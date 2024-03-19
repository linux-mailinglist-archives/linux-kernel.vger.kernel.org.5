Return-Path: <linux-kernel+bounces-108195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 046FF880752
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D981F2369A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508703A1A8;
	Tue, 19 Mar 2024 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="X9Zc7U4W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iqj+FAs6"
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A758ED8;
	Tue, 19 Mar 2024 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710887789; cv=none; b=r9Z5OdHbn/pDebCIeX1f91nDGV5Rwjw/+JKWTtdIpJAHAN04CUD9gugBLpXyh0YtY60FmKwjRQMnOs4F6QoIX+h6SHxIlzbft0iORqIkTD1M7X8So3iXPf6dAvfMFUXEUC5t+gAFuJ9UoSfMMgcvSx9YEDj0aVGIwVCxcff2rFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710887789; c=relaxed/simple;
	bh=wJcM7mcOqxwIvAfOf3Qrh1f4JmqCIIjuKwe6Ozy0d1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R072tFBZIDkQzdkLFvfLDPM4Epyj4bf7ZdOOGJyFTbZ5D5HKLp/IfMm014uAMr+9xYK9eWJPDz5Pnr2wr+lhv3CtFFwlygi0Q1GMHm6akE3PZc7S3W9+tIQFyKmhXab3lpUUKl6OydcoxrJFI8Z0cO2SD/O8s4F6VLlIH7Xy1Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=X9Zc7U4W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iqj+FAs6; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailflow.nyi.internal (Postfix) with ESMTP id E82EA200380;
	Tue, 19 Mar 2024 18:36:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 19 Mar 2024 18:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710887782;
	 x=1710891382; bh=bFbDxvQwIQcOv1ec4LJKXFtxm4eFHE4KoGHZHelhA30=; b=
	X9Zc7U4W5scGteYdS3QtOcvQuiOE15+oyFD59O3Z7XlywrsMj0Cms2u/hHbLXshr
	CSGaCG5uAJ9jubCRnBNl1i1z+u2b1yTxPSEEHulms25kqrniEWYZjzYandKEIXpY
	HszTDneUUj53t6KWvf/ZTZU8YW0BtVILTYFx/Fe1YDOEqM7IzFAUW36K+ExGXhSQ
	X6O7ERSu+kbsOgS+Zon4y+JF1w8ymMLSqAFVTWIH+zy5o7ehViGuUyyDpQXnmByh
	3Mxbe8rfjXlKMVbZDkP2qBEHeySc+QgG/s0V/g5rvbGIaZ7UXwHffXVLe02VL44G
	m6e7/Iz6Rb2fs/Tw22+U0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=i80c9496c.fm2; t=
	1710887782; x=1710891382; bh=bFbDxvQwIQcOv1ec4LJKXFtxm4eFHE4KoGH
	ZHelhA30=; b=iqj+FAs63u+TaJEu11mxF9duTElpyzXXYCbZBhGvvo1hafuGC23
	3AWISz4K7PpoJAAtbGGuo2ALppIufmxqvDBB4vgr6qnTReQbK0t37gVwocE8TpEL
	ZrSEgwHSpa3YgZ3syazd9+ndBuVV+NAzL9F3r7tbECuKvMEBPwiwmot3kOeNFsXy
	czdWVTBweGzUZBN2/gS1K4WW0yOLvH2Ge7duuSPxlu//JJk8Jl+QDn8dtCkBByEE
	DOXjZe85DLAcBPlL5zCVASQygLSG/hJQTCmFOjFcEJsn2Av8t6h57OahVKy45eJj
	DLpYj3xGhKzDSoWGUyJxV8dw31FhjOMBa9g==
X-ME-Sender: <xms:ZRP6ZaHkCNFZsukIir-cpf4ZEHDKpqEg9-uunI37wD1Bk4FeU5YeIg>
    <xme:ZRP6ZbUalKicHNPriLWJIJsnbfXjiLt2GqyBC70q5PjTGHEDRKEppTcjrajf9tr1V
    r-dB02a_n5xSCk2-V0>
X-ME-Received: <xmr:ZRP6ZUJVSmONchuZoQGu4CvnbzdwylKOwM8zQZd9ziG4fqPp2xm1KRnRywFmrO7bpVptkoNvnnK1vxKZ2C-ZRXgZ-rfVal8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleduucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhklhgrshcu
    ufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnhgvshgrsh
    esrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeefhfellefhffejgfef
    udfggeejlefhveehieekhfeulefgtdefueehffdtvdelieenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggvrhhluhhn
    ugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:ZhP6ZUEF-yi8tL-sYwWt7OosLjwr5uLbaIRXwySGUrEdH3AjS17t2g>
    <xmx:ZhP6ZQVnyWusD7KN0R90KQ-ZAc0EDtT9JrO-oQCqX-Uob93goKNklw>
    <xmx:ZhP6ZXP30aZFuFMwJmWqRf7RMt4KXxJqqhixvbg2Qb1UCGMKZ2x9uQ>
    <xmx:ZhP6ZX0_WfbRU0V1jU4e13J6v1xTBpax4RIQYNMxtVVh8dxjDymmjA>
    <xmx:ZhP6ZZPEmw_xQB4WzjYfHf_T63B0tH2Ybrqmp0S3ypvq7_ZxkPRQuKMww18>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 18:36:21 -0400 (EDT)
Date: Tue, 19 Mar 2024 23:36:18 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dt-bindings: timer: renesas,tmu: Add more SoC
 families
Message-ID: <20240319223618.GB3438308@ragnatech.se>
References: <cover.1710862701.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710862701.git.geert+renesas@glider.be>

Hi Geert,

Thanks for your work.

On 2024-03-19 16:46:02 +0100, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series documents support for the Timer Unit (TMU) on the
> R-Mobile APE6 SoC, and on various SoCs from the RZ/G1 and R-Car Gen2
> family.
> 
> Feel free to squash together if deemed more appropriate.

I prefer them split. In either case, split or squashed for the whole 
set.

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (3):
>   dt-bindings: timer: renesas,tmu: Add R-Mobile APE6 support
>   dt-bindings: timer: renesas,tmu: Add RZ/G1 support
>   dt-bindings: timer: renesas,tmu: Add R-Car Gen2 support
> 
>  .../devicetree/bindings/timer/renesas,tmu.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> -- 
> 2.34.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds

-- 
Kind Regards,
Niklas Söderlund

