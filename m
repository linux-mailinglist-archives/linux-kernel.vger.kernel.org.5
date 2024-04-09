Return-Path: <linux-kernel+bounces-137084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90B589DC2E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260D21C21120
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE7612FF6D;
	Tue,  9 Apr 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icS/oM+I"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E68812F598;
	Tue,  9 Apr 2024 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672781; cv=none; b=oqiQIjCElpWRmFnaQtyaixC2nIdeDO2LVH9KrOGtKV7zyIqp/ahaKMQoo6YSPZw4rN0Cp/HdeHdnQcKM+iTO+IQJA1b9jtCctZ5lUv+/tUN6BghRbwdBf/4B/scNyWZ++Pi3PXf6nmn5bhnGZ2jtOVyKZqvYdj+iAprH2q45kMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672781; c=relaxed/simple;
	bh=0FCx0ExAOuO47pPXq+LvIi7sP+m6A6+hblbEodnSxDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQF8nvPTgdQn5bPEcm+99Bh7l5/ix/J7GGfrU/j962er0/jXNGmiXglfouI8W7irOaZS91o048MMFmv6/msIg6g6/kp45QvkncfMEsx+KKP2lL2u6IJ5tNG2t4Ndvr5I+2TeOOuFikNAAj4To2FGd3qaUwPSQ15jHldJ/HE2ryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icS/oM+I; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516ef30b16eso3282638e87.3;
        Tue, 09 Apr 2024 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712672778; x=1713277578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5siHBidFUu/f/+SSwIYn7JsHrl83u4UHX8WsLfWFlHk=;
        b=icS/oM+I76ESzKryfrKgYOof1JiUqjVl5zNQzYbMPdO3U2NtIRAtH/iL6NOUXVSGf4
         h+uv7OmQZbpDGqFPd+ic0nbIvyXZ7bFCnUF6JwqmMf90yOKSwER43B9CG4jfwSJkS3Q0
         G7vCigFk/WSbFM4pFoU1ijVsep/Dyrc2/E35XTN/HLVPNo+JhYWbnp8CImd1WHbXCQt2
         l4d9/AUNzfHnhocz1KYwJlMPLB9m8sT4dKxPngOgH9J8y7wFFbeNQIzAwMyET44Q9nqT
         NWk5L4hTSIvRp5a5FAhJDsSWozQgNEh4qZ2IDb32lObBbeyLL2G5CApjg6eC3L3oO+3h
         dp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712672778; x=1713277578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5siHBidFUu/f/+SSwIYn7JsHrl83u4UHX8WsLfWFlHk=;
        b=K91FrIF712UCUlmXZv3Td0zOHtI8MSbniDDylYkBKf/K5JbNZXrjStMKlgrHY5m7Pc
         SmklOS5qlUFQwWnpRlijpTTSQ691O/4U4McVIdxhfCGmgrM46XKzFoV3O+wkTNMW0n+e
         4lOBeQqi8F+S5VRAyqMrja4gvc66IqRA51yoztyogEsAHISkKHijt74eIx54tFz0mD2P
         i6pTnaGDkvk9y39VMNZcbmF1Ge3lhrHyJVqWo/xKfHZxzfhiujDUN438SOxSWj28+F6C
         C4r7v95efWddDqfBjcyFeMeEdjpqcVIjC348w1UbISgLp/UvNz/Y/nh24UKi6haIzS2j
         hLuw==
X-Forwarded-Encrypted: i=1; AJvYcCWOpzcu77cHQkotNfBBz+w1ZYM5fdvxy/Mo4gf5fCMEHbT2nLnFQ0CesKJOIn8YQeug9KERGJCdiaZR5qsascMm5IHGfQhrSMQROS8NhoZcfm3ZnJeA2PZVIq+KUAqN9ToqO3aJ
X-Gm-Message-State: AOJu0YywA9tTBVF4CvxPgRD6iDUgG3H1sFN0qcxMg2OlgxzONJhp/O5J
	fav0yT8S2bxMlSDz4MJEV1q4B8wxIOuo8snN7Y8SfmJjarRrtB/zh5lw/G9j
X-Google-Smtp-Source: AGHT+IHj+m5LwCmCOAmqAI1oRxRP3QiTiWCZAHVTOsuuo4TMQQOeU4/As9nnE1nRGMtnNgpgroibvA==
X-Received: by 2002:ac2:5337:0:b0:513:dac5:ee22 with SMTP id f23-20020ac25337000000b00513dac5ee22mr6953932lfh.28.1712672777495;
        Tue, 09 Apr 2024 07:26:17 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id s17-20020a195e11000000b00515d55b66acsm1558748lfb.64.2024.04.09.07.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:26:17 -0700 (PDT)
Date: Tue, 9 Apr 2024 17:26:13 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add missing mmc statistics in DW GMAC
Message-ID: <qfsmz4mtjknbul2e43mvqghinqvpqq3hsnp5p5prtpbmoa47at@g3zuvdq7kirx>
References: <20240408012943.66508-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408012943.66508-1-minda.chen@starfivetech.com>

On Mon, Apr 08, 2024 at 09:29:41AM +0800, Minda Chen wrote:
> Add miss MMC statistic in DW GMAC
> 
> base on 6.9-rc1
> 
> changed
> v2:
>    patch2 : remove mmc_rx_control_g due to it is gotten in
> ethtool_ops::get_eth_ctrl_stats.

The series has already been merged in. Just a small note about the
patches. Both the changes seems reasonable:
LPI-statistics for DW GMAC and DW QoS Eth,
and
Rx-Recv and Tx-oversize errors stat for DW GMAC and DW QoS Eth.
The former stats has originally been added for DW XGMAC and the later
stats aren't supported by DW XGMAC. So the provided change is
complete. Thanks.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Minda Chen (2):
>   net: stmmac: mmc_core: Add GMAC LPI statistics
>   net: stmmac: mmc_core: Add GMAC mmc tx/rx missing statistics
> 
>  drivers/net/ethernet/stmicro/stmmac/mmc.h         |  2 ++
>  drivers/net/ethernet/stmicro/stmmac/mmc_core.c    | 15 +++++++++++++++
>  .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c  |  2 ++
>  3 files changed, 19 insertions(+)
> 
> 
> base-commit: 4cece764965020c22cff7665b18a012006359095
> -- 
> 2.17.1
> 
> 

