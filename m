Return-Path: <linux-kernel+bounces-162082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6FF8B55A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369FC2849F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAA73A28E;
	Mon, 29 Apr 2024 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="HF/UUzj9"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A22C197
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387509; cv=none; b=fnX7GKOgscg/1QzJS00LbC+bGns5VjDAMu3svF0cvyVwH+j2ildBDgQ4YU6UZ0SUX2aZQ1fgthmuCOPSNsq3jvojQAfvCA92P0Oe4pD0lZapn6cF78IrLqEEyn7Sr2xM4Jh11MZMQJx01qpKQaTz6JVJpUsnYbkR+iVoISi3cN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387509; c=relaxed/simple;
	bh=21RMRAHr62HOzIUOgv3ewkW9+VGicSXGvye8BW7fsFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYcQ8bpfuFyvi+rp0TwwaDU5YwIEovbQqQoyB53Hnwj0wx6/tVuefgTRrXcaIDsItSckF8K/TA/xdHSjQ7EvPNSPf0dL1tqPojlEpVgG51ODdk7J/seyQXIlCxOspdeOcHF/i3wadZdTQ172upKSbCv8ePMQD4FJ5k/BDNNwXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=HF/UUzj9; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-518f8a69f82so4802741e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714387506; x=1714992306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIf87VobpQBzjXayRCky+XzMmywWO3o9vJ/C9lYT1FU=;
        b=HF/UUzj9jQKszUJcR0Duu5ROyJKt8w6ns5XLn0oNpmiWN9MVNOv1ltC5hh8YT9NBtP
         rmn0TpGL1tmdj35hYby7+pD3YHZseO8RRsZBmGrYXVgb4AD3Qm4JgX3eyEcMrImsmgHC
         HgM8dBuEtu/MCGBBfTi/6TCf/XOb3pFxBLFP+t8p/NEeGYFURJDHXowrmO3/3M+dELRq
         qqRddpLk2QvrRjur/oWEWqZvLI+CHvC80kJtE7nLVdU9zyUP9OQB/yHlkPbEDStjShbl
         Cdi8hiunbd87DE1ul2wfN35uP4XuYs88ZwGCn38WyOG7+a/6HihlN4tJ0FSV9TS7BcGa
         PhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714387506; x=1714992306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIf87VobpQBzjXayRCky+XzMmywWO3o9vJ/C9lYT1FU=;
        b=s9Y6Ylh6/OzfHGUmi2FhYs33y2xS6gj2VCBuoZLJBumYf061oTiEZUo2hxU+OPpWKU
         rPpQm+7tHN83gEY8IdGuVsw2f9y1h9QpH/dfP6JrUd3p/735Rmhf0p5mY38EcnUk7SFl
         LR/rgVY1JVVdZgZRNNXqFkmbUeh1ubTCUSAERA9x8UxTah+/7+PiqoNiLBWYGSWT5cQ/
         i1ROxCIuYtyUULI6HCuboklnDGM//r9oUGBwYagO226y/hdIjlOuhP8SSAX37g8BE4n9
         Ij7iDXn9I/wHKSf7dnAxf56UM7A3/cwwECItamG87szkCzjrfYaChtblBfjMM4TXNbim
         B/HA==
X-Forwarded-Encrypted: i=1; AJvYcCVf24/wavQRgPs6RtmYz8DCJhhpmF6tfuDtddWswxjZFebtjXkAvA6uL+ka+sHbGxz4jNjLzZ3zOeHpaUG2tHNmSFgmQgvyLxyAV/GO
X-Gm-Message-State: AOJu0YwbtZe/N7/jc6yUtNbP2KEJmXBXzDaEW6D6cFIrXddSJoBTWR1U
	E+b4w2aKqz9BVdMB6v1Rr1HLmGPvYbjsvsOCZMyJoQkZcq1k2iAGx1eTw3R1kBs=
X-Google-Smtp-Source: AGHT+IHE9ANqur2+1+XKhc4MrtY/BD5yLizVMOaJPlYSALAtWsYgzCwhL67JKEMz5AyB9A979d3WUA==
X-Received: by 2002:ac2:5dce:0:b0:516:d3ba:5602 with SMTP id x14-20020ac25dce000000b00516d3ba5602mr4811351lfq.16.1714387505986;
        Mon, 29 Apr 2024 03:45:05 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id k8-20020a05651239c800b00517746176ebsm4055614lfu.49.2024.04.29.03.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:45:05 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:45:03 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Message-ID: <Zi96L3WDCwLz-2_O@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-10-Parthiban.Veerasooran@microchip.com>
 <Zi1Z5ggCqEArWNoh@builder>
 <b82a3006-05cb-43a3-bbe1-4f2f81113bab@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b82a3006-05cb-43a3-bbe1-4f2f81113bab@microchip.com>

> > To avoid an additional copy here?
> I think, this can be done later as part of optimization/improvements. 
> Let's keep it simple and optimize it later.

Sound good to me

R

