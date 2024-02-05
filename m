Return-Path: <linux-kernel+bounces-52413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEBD8497C9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586FE1C22B3E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7D4175B7;
	Mon,  5 Feb 2024 10:29:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47C91758B;
	Mon,  5 Feb 2024 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128952; cv=none; b=YFnSrjeqY1lxnw0y7RHxravzOnERgnoj05cGc0SIgwRJLtBdVH5nB42Q+bBtsV3AJPC7LiXTGNwl/24DZcNH82u7LQgcnEerHTz7I97bBujw/FkvXeWD08DDpqerWFYiBNes0IOr5qLrhkhMtbRyWF1uxi6IKPyuNPmWaQZU51c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128952; c=relaxed/simple;
	bh=/wlzKzNGUjh5hzxTw/V3EZD8Wh/eked9GcqGmJlsNyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9miQ7J1JvDTwYm6DDhEW6eIhilhdSjC2n9VRNffc6XMmg7y+a8l1nKd6lA608febMhzANy40SpKkKb4XC/H2zE+8GKmWdLzo4lVJTJhakRao3G6349sfqKYhppgJ3hKMURCEDbwfQJm78zhWLRt3PHNHP31aN337DuT/Vf7Qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91ABC433C7;
	Mon,  5 Feb 2024 10:29:03 +0000 (UTC)
Message-ID: <201ae1d1-1e03-40e2-9cc4-49df70abb8da@xs4all.nl>
Date: Mon, 5 Feb 2024 11:29:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] linux: v4l2-vp9.h: Fix kerneldoc
Content-Language: en-US, nl
To: Ricardo Ribalda <ribalda@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Bin Liu <bin.liu@mediatek.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
 Tianshu Qiu <tian.shu.qiu@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-amlogic@lists.infradead.org, Sakari Ailus <sakari.ailus@iki.fi>
References: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org>
 <20240126-gix-mtk-warnings-v1-17-eed7865fce18@chromium.org>
 <ZbTTb-SdK-EubGdc@valkosipuli.retiisi.eu>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <ZbTTb-SdK-EubGdc@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/01/2024 10:57, Sakari Ailus wrote:
> Hi Ricardo,
> 
> On Fri, Jan 26, 2024 at 11:16:16PM +0000, Ricardo Ribalda wrote:
>> Kerneldoc cannot understand arrays defined like
>> v4l2_frame_symbol_counts.
>>
>> Adding an asterisk to the name does do the trick.
>>
>> Disable the kerneldoc notation for now, it is already ignored:
>> https://docs.kernel.org/search.html?q=v4l2_vp9_frame_symbol_counts
> 
> Wouldn't it be nicer to fix kerneldoc instead? It might not be difficult at
> all.
> 
> Feel free to, but I can also give it a try.
> 

It would be nice to have this fixed in kerneldoc itself. I'm holding this
patch back for two weeks to see if someone wants to work on kerneldoc.

If not, then I'll take this anyway to fix the noise in our build.

Note that while this header is indeed ignored in the documentation, that
is really more a bug and it would be nice to actually include this header
somewhere in our documentation. So fixing these kerneldoc warnings one way
or another is something that we should do.

Regards,

	Hans

