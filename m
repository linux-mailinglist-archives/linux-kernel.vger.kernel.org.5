Return-Path: <linux-kernel+bounces-133942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFBC89AB40
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 386B2B21804
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E41381A4;
	Sat,  6 Apr 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="nhpiI5Uh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C/PpYlJW"
Received: from flow7-smtp.messagingengine.com (flow7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B61026ACA;
	Sat,  6 Apr 2024 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712412227; cv=none; b=sZGyUKYaLtcy4qNnsPhpWBPHHYmsrSM/AyK9dTNPN0nfPy/0NxAEwmATJhRBzmU4RXGNPZjBu6WfVkd2CQu1Bd17iB4U+KhW3FxjqZzOYL3wnSATUUIiCP2LqAFEuNOKGeZDBVh/CWXLaWkFulTrQM0ROo09zLqymhORfuZM9p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712412227; c=relaxed/simple;
	bh=ENTO6UB09qGYIRM+6RLPcHTPSVS4p+i2x0+J7oR4SWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjbmZ4rdVg4O9C1Fjni9cbehYqIp3KiFgGEBtjIrhSvmOjmMXStxE7AQZ6FfbYYBGMeftlsUU6xlThBNh4GhNkrCCr2QHAT7t/9u3bZX2fsuFsRhCgGZuJ1tlgdZSrf3hqw7Y3ESeYTErfWmF5laI74LqIA3c6f1EnIuhm7smIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=nhpiI5Uh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C/PpYlJW; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id 4C7FE20043B;
	Sat,  6 Apr 2024 10:03:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 06 Apr 2024 10:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1712412222;
	 x=1712415822; bh=PUh1xzVqpnfSlXumwj/nAAafAm5GRaA7LoifatDtllA=; b=
	nhpiI5UhCBdd0X1csnzvORn9ocq8aTbSyhI/rXU4z2/HT6L3kxmYWtlwsm+2hniA
	w2sRTKfrwSUY47T285uwkJpDytum2WvUfV/l4VMIGkUpZCQM8oH5FFllc/HU2hVV
	mbfXyrfw9yU64JLTGTDJ14DXfOwxmrk0fMV0zXPuWH15uV6Ywd7FbpStfqJhreuF
	SPGSXDVD7Li+S45bfEz3GkHI1CSr3F7B4qWhjMPg166As22PMMxxJ/qAZFQZxvXw
	bAzuzMwguh9HlkbyJjsb5Gx5/O6hu65PJPiE/EppIu5L2KcTXkKFY2KnQf97seYF
	SpZgTErYJBa3x5JCIdr0pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712412222; x=
	1712415822; bh=PUh1xzVqpnfSlXumwj/nAAafAm5GRaA7LoifatDtllA=; b=C
	/PpYlJWKhUYgLV4Bk0gbBs5URC8eW6rrj66BLWxEfjxfpanN+NliYT3GoUNd5v0E
	ODtH3Ox5bt3ZX9SdhJjfPkp0LWXPQUy7eqYbnQPopJYmtrUUazgUrL+v41cVZwKl
	Rby9hbXS4EWsM8uE9W2pKia10vq9v59JZVmRCN8s2s+zmpAIN/56q8zYjIAr1Coh
	f09QUbZKxTgiaf/miaxfrs3tCH9euS1VjsFWmpgU94EpXT0Ufo33XTne76Z0DNcb
	IGdcE8BQkYMdRP8uzjocyBDJl/dN3Hpsjw//NpaROmpPSwQ9qiKMnvpon4b8fphp
	l2Hzvm6r7wqMZ6lfe89ow==
X-ME-Sender: <xms:PFYRZrPRMr3peoqhSVFqZgcXj91qT_GBl_8d19Zn-bnnGvCs4aVXHw>
    <xme:PFYRZl83BApdr1J7SRa38Qk_7HKSPXHvdZy6QWxWAHLNKpgGqbWWpXhDHdeMPz7lU
    TUDDSnzgiCNPb_b5V8>
X-ME-Received: <xmr:PFYRZqRFf3IkBGNjOrq7dr3_ZPLO_808yx27UcMcxr2in3AOzWL91mKwEQBHtci3Ws_2sgCE2euGrWZFuFme0lIht1MtGCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegvddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugesrhgrgh
    hnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeevteegtddvvdfhtdekgefhfeef
    heetheekkeegfeejudeiudeuleegtdehkeekteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggvrhhluhhnugesrhgr
    ghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:PFYRZvtq1cjcK9gy4UPY21vp4k1B8iOMt7v7xupkfC-HgMFtVCYMzA>
    <xmx:PFYRZjfTo8bDsKxXdf7_Qq9vVcQyCqo0dqwbEw5drkVVRK9C46GbFg>
    <xmx:PFYRZr30Hq1gNFW-9lZrDbsmNnX_peDut0uBbJcLZHfqSvryz7lnnA>
    <xmx:PFYRZv-T6XyP8nsg_i3E4hiB3FGe7nOGMJnAEJ5XtqjY_Pu7X62PXw>
    <xmx:PVYRZh2SruAQsatXPh7b_-iP4YYwzuZ7TFE1bOU0HRrVl1_y1VzWmgrM>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Apr 2024 10:03:39 -0400 (EDT)
Date: Sat, 6 Apr 2024 16:03:37 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: =?utf-8?B?UGF3ZcWC?= Anikiel <panikiel@google.com>
Cc: kieran.bingham@ideasonboard.com, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, tharvey@gateworks.com,
	prabhakar.csengg@gmail.com, charles-antoine.couret@nexvision.fr,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	skomatineni@nvidia.com, luca.ceresoli@bootlin.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	chromeos-krk-upstreaming@google.com
Subject: Re: [PATCH 13/16] media: rcar-vin: Use pad variant of dv timing
 subdev calls
Message-ID: <20240406140337.GB2024639@ragnatech.se>
References: <20240405141411.1807189-1-panikiel@google.com>
 <20240405141411.1807189-14-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240405141411.1807189-14-panikiel@google.com>

Hi Paweł,

Thanks for your work.

On 2024-04-05 14:14:08 +0000, Paweł Anikiel wrote:
> Use the pad variant for all (s|g|query)_dv_timings subdev calls, which
> includes a pad argument.
> 
> Signed-off-by: Paweł Anikiel <panikiel@google.com>

Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c b/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
> index 073f70c6ac68..bb4b07bed28d 100644
> --- a/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
> +++ b/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
> @@ -730,7 +730,8 @@ static int rvin_s_dv_timings(struct file *file, void *priv_fh,
>  	struct v4l2_subdev *sd = vin_to_source(vin);
>  	int ret;
>  
> -	ret = v4l2_subdev_call(sd, video, s_dv_timings, timings);
> +	ret = v4l2_subdev_call(sd, pad, s_dv_timings,
> +			       vin->parallel.sink_pad, timings);
>  	if (ret)
>  		return ret;
>  
> @@ -744,7 +745,8 @@ static int rvin_g_dv_timings(struct file *file, void *priv_fh,
>  	struct rvin_dev *vin = video_drvdata(file);
>  	struct v4l2_subdev *sd = vin_to_source(vin);
>  
> -	return v4l2_subdev_call(sd, video, g_dv_timings, timings);
> +	return v4l2_subdev_call(sd, pad, g_dv_timings,
> +				vin->parallel.sink_pad, timings);
>  }
>  
>  static int rvin_query_dv_timings(struct file *file, void *priv_fh,
> @@ -753,7 +755,8 @@ static int rvin_query_dv_timings(struct file *file, void *priv_fh,
>  	struct rvin_dev *vin = video_drvdata(file);
>  	struct v4l2_subdev *sd = vin_to_source(vin);
>  
> -	return v4l2_subdev_call(sd, video, query_dv_timings, timings);
> +	return v4l2_subdev_call(sd, pad, query_dv_timings,
> +				vin->parallel.sink_pad, timings);
>  }
>  
>  static int rvin_dv_timings_cap(struct file *file, void *priv_fh,
> -- 
> 2.44.0.478.gd926399ef9-goog
> 

-- 
Kind Regards,
Niklas Söderlund

