Return-Path: <linux-kernel+bounces-13585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2F1820866
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 21:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A8E283E4C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 20:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CA0C8F8;
	Sat, 30 Dec 2023 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="CwSvrHrV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2BC13D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1703967150;
 bh=48uwgyUepoTSwyC5niR44R50rvv/N7Od8yW5FGvT5tM=;
 b=CwSvrHrVc21lQQfqDKPX8TCsCabekBKSYC+SHd0X6ZS3dIaFBFvV4slhuGiHpCybwX02zt1VN
 mDD2UQDU1B1e+K/hCXkMNJOX3BbVsh5zLDUJTTF1CV553y6fe23e8HN7CtT88ilOpQmVwD4U5jA
 M/vu83g0v0WPu6PN5V+LqchpMRaXNTmZAKZ+mPuMqaCAk2FZVfkzkAMrGFXeJ3Wq/qPvLRXp8qS
 fJpI9/+hPIrP9iD4ca3xK5qLVng4xWUTGZtVH1az5wyrT/4Yd6wiVMN0Nv8qAuzlx4bQd6OjFjg
 aSKtUr5zXKcTjwOAqH7xqGktW6WMln/olg6T3FxBrm7w==
Message-ID: <b9e6702d-4781-413b-8e4c-0b74272e9f22@kwiboo.se>
Date: Sat, 30 Dec 2023 21:12:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add hantro g1 video decoder support for RK3588
Content-Language: en-US
To: amazingfate <liujianfeng1994@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar, heiko@sntech.de,
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, mchehab@kernel.org,
 p.zabel@pengutronix.de, robh+dt@kernel.org, sfr@canb.auug.org.au,
 sigmaris@gmail.com
References: <97faf49b-0109-439a-accf-251b502ad40b@kwiboo.se>
 <20231230153159.3748580-1-liujianfeng1994@gmail.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20231230153159.3748580-1-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 659079ad220dc6bab27e429e

Hi Jianfeng,

On 2023-12-30 16:31, amazingfate wrote:
> Hi Jonas,
> 
> On Sat, 30 Dec 2023 12:49:38 +0100, Jonas Karlman <jonas@kwiboo.se> wrote:
>> I have only tested this fork of fluster with ffmpeg 6.x, what version of
>> ffmpeg did you test with? I was expecting it to also work on ffmpeg 5.x.
> 
> I am using ffmpeg 6.0 with v4l2-request patches from libreelec[1].

Great, that patch should match my v4l2-request-n6.0.1 branch [2],
and does not have any NV15/NV20 ffmpeg pix fmt patches that could
interfere.

[2] https://github.com/Kwiboo/FFmpeg/commits/v4l2-request-n6.0.1/

> Ffmpeg v4l2 decoder in fluster fork is using ffmpeg args:
> "-hwaccel_device /dev/dri/renderD128"
> which make the test fall with hantro g1 on rk3588. After removing it I
> can run tests by ffmpeg v4l2-request decoder. 

Thanks for confirming and testing again, and I fully understand why
"-hwaccel_device /dev/dri/renderD128" caused issues on rk3588 :-)

The commit "HACK: hwcontext_drm: do not require drm device" was required
to run ffmpeg without a hwaccel_device, and I tested fluster without it.

Regards,
Jonas

> 
> Rk3566 and rk3588 are sharing the same results:
> JVT-AVC_V1 test suite with decoder FFmpeg-H.264-V4L2-request:
>  Ran 127/135 tests successfully.
> JVT-FR_EXT test suite with decoder FFmpeg-H.264-V4L2-request:
>  Ran 44/69 tests successfully.
> VP8-TEST-VECTORS test suite with decoder FFmpeg-VP8-V4L2-request:
>  Ran 59/61 tests successfully.
> 
> [1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/multimedia/ffmpeg/patches/v4l2-request/ffmpeg-001-v4l2-request.patch
> 
> Regards,
> Jianfeng


