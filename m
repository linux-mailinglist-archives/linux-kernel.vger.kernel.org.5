Return-Path: <linux-kernel+bounces-111557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3D3886DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E6B287C75
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749B8487BE;
	Fri, 22 Mar 2024 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="k0ncReND";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DlJ/kagk"
Received: from wflow3-smtp.messagingengine.com (wflow3-smtp.messagingengine.com [64.147.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C167346449;
	Fri, 22 Mar 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114779; cv=none; b=SRqolVK7RuhQp2fBrFid2pHNPqhDKRbDnqrs1IP3bYH7lZ8MIzTqUsCQOhSiGSIgpgMgqCYgk3VzYJrQr/2t1EyeOYYJYBPM70QIaiT44t4qUAKwezfY1NOIoT0lO/CcTjv/OD6AlXBBTpyCY2D5s5WoZ3n0++e5lAnjTqG+wjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114779; c=relaxed/simple;
	bh=WTmXfI0M08pmpvv63nQvhaH1TNGPWtey9xubpmGccnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhnOjW1ku34BVD/41E1OFDGAyIuq4aWyIxx5T/+XEn+nJkEiRXH+8bKoHp3diwxF/pWHZSeYOUktpw6Qfo876/GbAZ846C2B97yOoe7tG660VXLHWvqNUWRk8CE00a889QtQeWpwSEYaZ2YVsfTdxzIneX+FlxYSlfIwt1ZIpeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=k0ncReND; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DlJ/kagk; arc=none smtp.client-ip=64.147.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.west.internal (Postfix) with ESMTP id 8C2972CC00C8;
	Fri, 22 Mar 2024 09:39:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 22 Mar 2024 09:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711114773;
	 x=1711118373; bh=XsXGuptKt13EJ/gv1xo+2KCLb6yaD1Leqmnh5HvA8so=; b=
	k0ncReNDYOXBstPpIoz6beSva/3UwX13jbsVhdTSKIA1834wcDuyyKKFxF6AZzKJ
	pHwpZ+tChYC9eaQaN2BhIV9DmbMNMD7+Aiob0H/LiJt5g+g1n1NdMqa1Eqv4rP5q
	sfeqG/XsK1vAEJZ6gyuob297taaB7D1pDzh2tm6BC8dfeE8R+CcQWfiPn4O7TJb6
	Tgnw53/v+CfN6vOSWbW1iMZLPweIk2/0qETiOYgueQY6OTADOkTl8tnQsJbjqs/p
	0LWZC2ZSbc/Xte2kUcIir4GNMMM/MVk0D4jPRfK5XUtQ48R0GTdl4vBwnXQ1ln52
	KrZwmZKj8/qkzB9CJdEYkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=i80c9496c.fm2; t=
	1711114773; x=1711118373; bh=XsXGuptKt13EJ/gv1xo+2KCLb6yaD1Leqmn
	h5HvA8so=; b=DlJ/kagkU1GsShBar6DPexYUIkGyob8Ht5T6E9Byo9h4iYGJQ3k
	oFOEKSF8BEQn7j39eiX1K8XnbdcarP8SV4/Y6eIvMI0AICln3yQuUL2LMU9RQ8+I
	T106wcfZ2bRnmhL2EO4gFU1QhkAxenIZp4vQl+PVqi+AYfH/JRKna20xih921kHI
	JxTFNLFNn12AWPZvs07QAvX3W3aXw3peM8dzZHFXjB7OojPduGp4bUTpiEaYzAWu
	tcn+/m5ty0nkUIkrq7KujkLzkd+4y4oosKxGJpDd2PurJGwUOYJb4BC4QQ4fERRo
	zUxULPg6aVxcYIx2KcDmsglJBo3pxlb4uIw==
X-ME-Sender: <xms:FIr9ZQ-7792OuQbiHP19zmLlzNhuO3Rb-5OBm5LcZLxM_cGLm4U90A>
    <xme:FIr9ZYs77JwI57KUI3FoUwz6bBIW4vJvNYTveZOcSG4MM-mjstQ2g8x9HBiW5b09O
    LJrOYfHJAR3B-SECZs>
X-ME-Received: <xmr:FIr9ZWCUmHPvEA1o75nsLtxYr7ZYsK8i6K44f5jgaI5noQ8ujDTLsDWly4Q9WxCEfi9p3KIwqyInaU_qKSeZedQAJdzJWNo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddttddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugesrhgrgh
    hnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeevteegtddvvdfhtdekgefhfeef
    heetheekkeegfeejudeiudeuleegtdehkeekteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggvrhhluhhnugesrhgr
    ghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:FIr9ZQfZqJoZ5ZaenkF5_H_6Xor2JNsdHOIARLfqu3UGfxA6-LSIzQ>
    <xmx:FIr9ZVN2mO0I5b3FO1C99rwa_I0nXa6NlsPqGR8Ck5a26IPJ_tPH3A>
    <xmx:FIr9ZamPo7PStVoFTVbxnjS5qQgM7Bv3eIhEXowe52bo5OpejOmWgQ>
    <xmx:FIr9ZXuSH-A5s_f7mStL7bJ-CbEngTq2ZolTKNaWd0pv8aO_FGFxDw>
    <xmx:FIr9ZbvNzgkVq4FvqEPH9NGAkCI-N5JecqUJlCo-URnQo3SkmBEF35Iu53Lewatt>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 09:39:31 -0400 (EDT)
Date: Fri, 22 Mar 2024 14:39:27 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-media@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] media: rcar-vin: work around -Wenum-compare-conditional
 warning
Message-ID: <20240322133927.GG3438308@ragnatech.se>
References: <20240322133353.908957-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322133353.908957-1-arnd@kernel.org>

Hi Arnd,

Thanks for your work.

On 2024-03-22 14:33:46 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-19 warns about mixing two enum types here:
> 
> drivers/media/platform/renesas/rcar-vin/rcar-vin.h:296:12: error: conditional expression between different enumeration types ('enum rvin_csi_id' and 'enum rvin_isp_id') [-Werror,-Wenum-compare-conditional]
> drivers/media/platform/renesas/rcar-vin/rcar-core.c:216:18: error: conditional expression between different enumeration types ('enum rvin_csi_id' and 'enum rvin_isp_id') [-Werror,-Wenum-compare-conditional]
> drivers/media/platform/renesas/rcar-vin/rcar-vin.h:296:12: error: conditional expression between different enumeration types ('enum rvin_csi_id' and 'enum rvin_isp_id') [-Werror,-Wenum-compare-conditional]
> drivers/media/platform/renesas/rcar-vin/rcar-vin.h:296:12: error: conditional expression between different enumeration types ('enum rvin_csi_id' and 'enum rvin_isp_id') [-Werror,-Wenum-compare-conditional]
> 
> This one is intentional, and there is already a cast to work around another
> warning, so address this by adding another cast.
> 
> Fixes: 406bb586dec0 ("media: rcar-vin: Add r8a779a0 support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> There are only a couple of -Wenum-compare-conditional warnings in the tree,
> so it seems best to just address them all instead of turning off the warning
> globally.
> ---
>  drivers/media/platform/renesas/rcar-vin/rcar-vin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-vin.h b/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
> index 792336dada44..997a66318a29 100644
> --- a/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
> +++ b/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
> @@ -59,7 +59,7 @@ enum rvin_isp_id {
>  
>  #define RVIN_REMOTES_MAX \
>  	(((unsigned int)RVIN_CSI_MAX) > ((unsigned int)RVIN_ISP_MAX) ? \
> -	 RVIN_CSI_MAX : RVIN_ISP_MAX)
> +	 (unsigned int)RVIN_CSI_MAX : (unsigned int)RVIN_ISP_MAX)
>  
>  /**
>   * enum rvin_dma_state - DMA states
> -- 
> 2.39.2
> 

-- 
Kind Regards,
Niklas Söderlund

