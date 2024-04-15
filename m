Return-Path: <linux-kernel+bounces-145879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A278A5C47
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C746EB22284
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A05B156997;
	Mon, 15 Apr 2024 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="A2bCFYPL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xOCDnAHP"
Received: from wflow6-smtp.messagingengine.com (wflow6-smtp.messagingengine.com [64.147.123.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059315696C;
	Mon, 15 Apr 2024 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713213198; cv=none; b=ioyVaWhXLPXPfTj3dGbR/lVpEC3ND+5YdfBQ1ZCyddcP79j7W580E0dpYffu6Ubah5MtOW/IXh1uoWjwJ/8qDjs6V+bK+77JKmM/m+jjX5dmsuAltBla/cRjKRwLiSO9T5K7t0X6RZrlRwglnSWIwkf/ScXzlhjv53abWfBgJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713213198; c=relaxed/simple;
	bh=MbARjvrpCHy36HlftTskv0oUA16RtaXGCQ9Sa4PohHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGtN8udgLvv+DeZhxsYEyc7QshEBOSHNTfSp+pFeB7rX6g5LBmslStRWtH96TGNYaBnMX1pMjqsun77X6GeVpcrqosqIh9CigYnW/e+YD8sQps5TmEVfjr8NdJwN5bOCSAcPVyrBcwb2XO1TerTi8XOXl0vby1v3E4mzNRh4IYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=A2bCFYPL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xOCDnAHP; arc=none smtp.client-ip=64.147.123.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.west.internal (Postfix) with ESMTP id 14D142CC03C4;
	Mon, 15 Apr 2024 16:33:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Apr 2024 16:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1713213189;
	 x=1713216789; bh=fIcGKyu3RVbTPH8gf2IgRkAbQpE7HkRtMrZ9SC1NGEA=; b=
	A2bCFYPL663eOepLVbEnC0VXlQe5Jq0k+hwWR5TJw9zrtT/wIF5ZSvoH9xom2KgQ
	d3/edVSsZW8bMc+dfWpv+kKms1yZrQN9NfzVaFQJbyxX/p4HyHsoHjTEjMtN9/dS
	2R6WdYQ0gmRXUAusWOtnPYl7FLJsh0pRcYcnQAHqyvl3n/DfOnH5z6YiBOgcGxLs
	OHnAylRQKS/hLHsfFTQ7kuHGyTMIsJ16DHeiSUuGvqj4UsT1u+qpAVDgCrS4eCjT
	gmm30+JCk54OnK//J6b8NbldfsAKiCw2DEK2SLMpMMkdVPboSMJozXKeTr2cz00O
	UTPhqtfABRr0S9Rtx1qsSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713213189; x=
	1713216789; bh=fIcGKyu3RVbTPH8gf2IgRkAbQpE7HkRtMrZ9SC1NGEA=; b=x
	OCDnAHPigtxYg57VGgTClsFyFHHYw6ro/OrmE3IKhNHkVlH12P3cBR42RF/S0VRt
	Ho1bEUD5+iRHi2I6AiqzRvQS4m5rY1h+0eWNEh7E/nVi+jUR6ZNoUlSgwOawqKEu
	GQWORIQpX194mslGn39P+KA8sOiTOWh/ML11a2UyzlYdv5bsqD897put9yliqfdl
	aVFXciAT0aF/Xak/2xdWE9GEqvvGgiT2AKTdwbBihhvEkIxcXAMnRzRuDojJwei4
	Ob0EUdLOTpMJk6G5k6lV/RZuYMlrxsPNvZDA3w8gbPkCEFfN8V4tV7Cj9oQuHWmD
	Fk6wqqiuesU4n/IWr+8rg==
X-ME-Sender: <xms:A48dZinBXjQljppjuYshoqMb956esQaWJY6oA4zR0mjyvytphnvx2g>
    <xme:A48dZp0wpVXjd3geX5J2e3DY31sBSly8Ra3l6Wt4kCqYkqoef8WIbka7EycoznUdt
    w-IQQayQv4_u0wkJJo>
X-ME-Received: <xmr:A48dZgoZH8_-Rgs08YtX4tA9s7O7A8QhuESSnQRW_0s35vXBkisJltlggluoUTxL78wSC7DIC_TxvCuY0pvaw7ClFg7VNhs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheppfhi
    khhlrghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlhhunhguodhrvg
    hnvghsrghssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthhtvghrnhepfeetleeu
    jefhueekteeftdeffedvudefjeeffeehlefgvddthfevleduvedvteegnecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghdpfhhrvggvuggvshhkthhophdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhoug
    gvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:A48dZmkR2Cb8Nu49QcE5CJq-Ja7hjXExE8ddiaWaPoReY3FBXadTGA>
    <xmx:A48dZg2EswAJi0VioKY02SnxIwLcN5788cL-4KQ35vZ35ftvuK7qkQ>
    <xmx:A48dZtuD9RfeJ8kj95gjbnM-4CpungoSLQJkTJQAWes6N8u-rNSWkQ>
    <xmx:A48dZsV3gbKbvYqK3iI8UGR7nZPPl05nS0QVbOXUnxfyez35GTa-AQ>
    <xmx:BY8dZh2LQxfcu9mwVB157qbXRe8nmcbODjjN7y9Tc65DItle1JDrPIjg>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 16:33:06 -0400 (EDT)
Date: Mon, 15 Apr 2024 22:33:04 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Hugues Fruchet <hugues.fruchet@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen-Yu Tsai <wens@csie.org>,	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>,
	Abylay Ospan <aospan@netup.ru>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Dmitry Osipenko <digetx@gmail.com>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Pavel Machek <pavel@ucw.cz>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 00/35] media: Fix coccinelle warning/errors
Message-ID: <20240415203304.GA3460978@ragnatech.se>
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
 <20240415195348.GD22954@pendragon.ideasonboard.com>
 <CANiDSCteGngbSS6CCuUxM-PQiBz0W0WfoFr2E2oH2d8qt746_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiDSCteGngbSS6CCuUxM-PQiBz0W0WfoFr2E2oH2d8qt746_A@mail.gmail.com>

Hi Ricardo,

Thanks for cleaning up.

On 2024-04-15 21:58:58 +0200, Ricardo Ribalda wrote:
> Hi Laurent
> 
> On Mon, 15 Apr 2024 at 21:54, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Ricardo,
> >
> > I'm afraid I won't have time to review any of this for the time being.
> > Unless you would like me to put uvcvideo reviews on hold ;-)
> >
> > Jokes aside, my first reaction was that this feels like a bit of a waste
> > of maintainer's time :-S
> 
> This is part of the media-ci effort.
> 
> It is definitely not the most fun patches to do or review, but someone
> has to do it :)
> 
> The whole idea is that we want to get as little warnings as possible
> from the static analysers, after this patchset we almost achieve that.

I understand and I think it's a good goal to aim for zero warnings. But 
some of the fixes here are IMHO not helpful, for example I find this 
type of change counter productive.

-       return ret < 0 ? ret : 0;
+
+       if (ret < 0)
+               return ret;
+       return 0;

Maybe it's better to disable this type of checks in the linter?

> 
> It is only 2 trivial uvc patches, I can ask someone from my team to
> review it if you want and trust them ;)
> 
> Regards!
> 
> >
> > On Mon, Apr 15, 2024 at 07:34:17PM +0000, Ricardo Ribalda wrote:
> > > After this set is applied, these are the only warnings left:
> > > drivers/media/pci/ivtv/ivtv-fileops.c:223:4-10: preceding lock on line 267
> > > drivers/media/pci/ivtv/ivtv-fileops.c:230:3-9: preceding lock on line 267
> > > drivers/media/pci/ivtv/ivtv-fileops.c:236:4-10: preceding lock on line 267
> > > drivers/media/pci/ivtv/ivtv-fileops.c:245:3-9: preceding lock on line 267
> > > drivers/media/pci/ivtv/ivtv-fileops.c:251:3-9: preceding lock on line 267
> > > drivers/media/pci/ivtv/ivtv-fileops.c:257:3-9: preceding lock on line 267
> > > drivers/media/pci/ivtv/ivtv-fileops.c:272:3-9: preceding lock on line 267
> > > drivers/media/pci/ivtv/ivtv-fileops.c:598:4-10: preceding lock on line 627
> > > drivers/media/pci/ivtv/ivtv-fileops.c:598:4-10: preceding lock on line 689
> > > drivers/media/pci/ivtv/ivtv-fileops.c:606:3-9: preceding lock on line 627
> > > drivers/media/pci/ivtv/ivtv-fileops.c:606:3-9: preceding lock on line 689
> > > drivers/media/pci/ivtv/ivtv-fileops.c:648:3-9: preceding lock on line 627
> > > drivers/media/pci/ivtv/ivtv-fileops.c:648:3-9: preceding lock on line 689
> > > drivers/media/pci/ivtv/ivtv-fileops.c:692:4-10: preceding lock on line 689
> > > drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2776
> > > drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2786
> > > drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2809
> > > drivers/media/dvb-frontends/stv090x.c:799:1-7: preceding lock on line 768
> > > drivers/media/usb/go7007/go7007-i2c.c:125:1-7: preceding lock on line 61
> > > drivers/media/rc/imon.c:1167:1-7: preceding lock on line 1153
> > > drivers/media/pci/cx18/cx18-scb.h:261:22-29: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_cmds.h:77:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_cmds.h:85:5-16: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_cmds.h:154:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_cmds.h:171:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_cmds.h:180:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_cmds.h:189:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_cmds.h:201:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_cmds.h:220:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_cmds.h:230:5-16: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_helper.h:764:5-15: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_helper.h:1008:43-60: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_helper.h:1014:36-46: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_helper.h:1041:5-15: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_helper.h:1088:39-51: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_helper.h:1093:5-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_helper.h:1144:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_helper.h:1239:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_helper.h:1267:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/qcom/venus/hfi_helper.h:1272:4-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/common/siano/smscoreapi.h:619:5-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/common/siano/smscoreapi.h:669:6-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/common/siano/smscoreapi.h:1049:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/common/siano/smscoreapi.h:1055:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/dvb-frontends/mxl5xx_defs.h:171:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/dvb-frontends/mxl5xx_defs.h:182:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/allegro-dvt/nal-hevc.h:102:14-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/media/platform/xilinx/xilinx-dma.h:100:19-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > > drivers/staging/media/atomisp/pci/atomisp_tpg.h:30:18-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > >
> > > CI tested:
> > > https://gitlab.freedesktop.org/linux-media/media-staging/-/commit/055b5211c68e721c3a7090be5373cf44859da1a7/pipelines?ref=ribalda%2Ftest-cocci
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > > Ricardo Ribalda (35):
> > >       media: pci: mgb4: Refactor struct resources
> > >       media: stb0899: Remove unreacheable code
> > >       media: uvcvideo: Refactor iterators
> > >       media: uvcvideo: Use max() macro
> > >       media: go7007: Use min and max macros
> > >       media: stm32-dcmipp: Remove redundant printk
> > >       media: staging: sun6i-isp: Remove redundant printk
> > >       media: dvb-frontends: tda18271c2dd: Remove casting during div
> > >       media: v4l: async: refactor v4l2_async_create_ancillary_links
> > >       staging: media: tegra-video: Use swap macro
> > >       media: s2255: Use refcount_t instead of atomic_t for num_channels
> > >       media: platform: mtk-mdp3: Use refcount_t for job_count
> > >       media: common: saa7146: Use min macro
> > >       media: dvb-frontends: drx39xyj: Use min macro
> > >       media: netup_unidvb: Use min macro
> > >       media: au0828: Use min macro
> > >       media: flexcop-usb: Use min macro
> > >       media: gspca: cpia1: Use min macro
> > >       media: stk1160: Use min macro
> > >       media: tegra-vde: Refactor timeout handling
> > >       media: venus: Use div64_u64
> > >       media: i2c: st-mipid02: Use the correct div function
> > >       media: dvb-frontends: tda10048: Use the right div
> > >       media: tc358746: Use the correct div_ function
> > >       media: venus: Use the correct div_ function
> > >       media: venus: Refator return path
> > >       media: dib0700: Refator return path
> > >       media: usb: cx231xx: Refator return path
> > >       media: i2c: rdacm20: Refator return path
> > >       media: i2c: et8ek8: Refator return path
> > >       media: cx231xx: Refator return path
> > >       media: si4713: Refator return path
> > >       media: ttpci: Refator return path
> > >       media: hdpvr: Refator return path
> > >       media: venus: Refator return path
> > >
> > >  drivers/media/common/saa7146/saa7146_hlp.c         |  8 +++----
> > >  drivers/media/dvb-frontends/drx39xyj/drxj.c        |  9 +++-----
> > >  drivers/media/dvb-frontends/stb0899_drv.c          |  5 -----
> > >  drivers/media/dvb-frontends/tda10048.c             |  3 +--
> > >  drivers/media/dvb-frontends/tda18271c2dd.c         |  4 ++--
> > >  drivers/media/i2c/et8ek8/et8ek8_driver.c           |  4 +++-
> > >  drivers/media/i2c/rdacm20.c                        |  5 ++++-
> > >  drivers/media/i2c/st-mipid02.c                     |  2 +-
> > >  drivers/media/i2c/tc358746.c                       |  3 +--
> > >  drivers/media/pci/mgb4/mgb4_core.c                 |  4 ++--
> > >  drivers/media/pci/mgb4/mgb4_regs.c                 |  2 +-
> > >  drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c  |  2 +-
> > >  drivers/media/pci/ttpci/budget-core.c              |  5 ++++-
> > >  .../media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c   | 10 ++++-----
> > >  .../media/platform/mediatek/mdp3/mtk-mdp3-core.c   |  6 ++---
> > >  .../media/platform/mediatek/mdp3/mtk-mdp3-core.h   |  2 +-
> > >  .../media/platform/mediatek/mdp3/mtk-mdp3-m2m.c    |  6 ++---
> > >  drivers/media/platform/nvidia/tegra-vde/h264.c     |  6 ++---
> > >  drivers/media/platform/qcom/venus/vdec.c           | 15 +++++++------
> > >  drivers/media/platform/qcom/venus/venc.c           | 19 +++++++++-------
> > >  .../platform/st/stm32/stm32-dcmipp/dcmipp-core.c   |  5 +----
> > >  drivers/media/radio/si4713/radio-usb-si4713.c      |  8 +++++--
> > >  drivers/media/usb/au0828/au0828-video.c            |  5 +----
> > >  drivers/media/usb/b2c2/flexcop-usb.c               |  5 +----
> > >  drivers/media/usb/cx231xx/cx231xx-i2c.c            | 16 +++++++++----
> > >  drivers/media/usb/cx231xx/cx231xx-video.c          | 10 +++++++--
> > >  drivers/media/usb/dvb-usb/dib0700_core.c           |  4 +++-
> > >  drivers/media/usb/go7007/go7007-fw.c               |  4 ++--
> > >  drivers/media/usb/gspca/cpia1.c                    |  6 ++---
> > >  drivers/media/usb/hdpvr/hdpvr-control.c            |  4 +++-
> > >  drivers/media/usb/s2255/s2255drv.c                 | 20 ++++++++---------
> > >  drivers/media/usb/stk1160/stk1160-video.c          | 10 ++-------
> > >  drivers/media/usb/uvc/uvc_ctrl.c                   | 26 ++++++++++++----------
> > >  drivers/media/v4l2-core/v4l2-async.c               |  8 +++----
> > >  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c  |  1 -
> > >  drivers/staging/media/tegra-video/tegra20.c        |  9 ++------
> > >  36 files changed, 132 insertions(+), 129 deletions(-)
> > > ---
> > > base-commit: 71b3ed53b08d87212fbbe51bdc3bf44eb8c462f8
> > > change-id: 20240415-fix-cocci-2df3ef22a6f7
> > >
> > > Best regards,
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
> 
> 
> 
> -- 
> Ricardo Ribalda

-- 
Kind Regards,
Niklas Söderlund

