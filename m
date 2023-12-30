Return-Path: <linux-kernel+bounces-13409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68878204AF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C1D1F21843
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DB7881F;
	Sat, 30 Dec 2023 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="rKacEDg6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654879DC
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1703936984;
 bh=mxaMu8U3QMAFU/y35CQF9vSyxsVfW4Q2ekWUVTmfutI=;
 b=rKacEDg6gxzfbiW3OXa2U6qYs+s8uJAUyDyNJsMRBpJOc6OVocug9j4mzTWadABLEh+JCEQow
 gEWJ5yG+sYQ+aXjBBCPcfYtQHAYQX9ka0n/jAIb7KcmO5VtBj9O6Eggju9ONyGe2+KFIFoGWPKD
 KAK0IqRBrqssiHo22FqgOQpAKaWN9LrKXvG5taIryO8w0TAA7OpK5x8WhZ65KAIImF3aeOhnAiZ
 dnBMaFtoQ9udtJDHuHbPye4tSU2fwZFJxwFvAgCLV6IQSVKDVGIIJFgVs9ml3ZD0JblJ3mhQ5Ts
 95jKBhbp9RZXRzFjQCi+MvQdixFe2sdmAX7SQ0IpREhg==
Message-ID: <97faf49b-0109-439a-accf-251b502ad40b@kwiboo.se>
Date: Sat, 30 Dec 2023 12:49:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add hantro g1 video decoder support for RK3588
To: amazingfate <liujianfeng1994@gmail.com>, sigmaris@gmail.com
Cc: ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
 mchehab@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, heiko@sntech.de, sfr@canb.auug.org.au,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <CAAXNxMT3f68-ptM7Crhrfmn7iwTyJc9pwz4Beob+5beVODaSHQ@mail.gmail.com>
 <20231230095228.3739806-1-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20231230095228.3739806-1-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 659003d74d40790198022670

Hi,

On 2023-12-30 10:52, amazingfate wrote:
> Thanks for your test with fluster. I also tested on my rock-5b(rk3588)
> and orangepi-3b(rk3566) which are sharing the same hantro g1 ip. I am
> running on ubuntu jammy so I'm using gstreamer 1.20.1
> 
> rk3566 and rk3588 are sharing the same results:
> JVT-AVC_V1 test suite with decoder GStreamer-H.264-V4L2SL-Gst1.0:
>   Ran 112/135 tests successfully.
> JVT-FR_EXT test suite with decoder GStreamer-H.264-V4L2SL-Gst1.0:
>   Ran 27/69 tests successfully.
> VP8-TEST-VECTORS test suite with decoder GStreamer-VP8-V4L2SL-Gst1.0:
>   Ran 59/61 tests successfully.
> 
> H264 decoder test has less test case passing. I think that's because
> of my low gstreamer version. If you have a rk356x board I guess you
> will get the same result as rk3588. That should be the mainline support
> status of hantro g1 decoder.
> 
> For ffmpeg at the moment fluster doesn't support v4l2-request decoder.
> I tried Kwiboo's fork[1] but failed to pass tests with decoder
> FFmpeg-H.264-V4L2-request. I can decode video with ffmpeg command like:
> "ffmpeg -benchmark -hwaccel drm -hwaccel_output_format drm_prime -i Big_Buck_Bunny_1080_10s_30MB.mp4 -f null -"

I have only tested this fork of fluster with ffmpeg 6.x, what version of
ffmpeg did you test with? I was expecting it to also work on ffmpeg 5.x.

Please also note that ffmpeg v4l2-request patches at [2] contain some
NV15/NV20 ffmpeg pix_fmt patches that fail ffmpeg tests. They are not
needed for decoding of 10-bit frames using rkvdec but they are required
to be able to run fluster test suite JVT-FR_EXT on rkvdec. (hantro g1 do
not support 10-bit frames on rk)

[2] https://github.com/Kwiboo/FFmpeg/commits/v4l2-request-n6.1

Regards,
Jonas

> 
> [1] https://github.com/Kwiboo/fluster/tree/v4l2-request
> 


