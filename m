Return-Path: <linux-kernel+bounces-67887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E94485725E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30291F25A74
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BD23201;
	Fri, 16 Feb 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="FJ0tJps7"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDE738F;
	Fri, 16 Feb 2024 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042669; cv=none; b=exIhDTGxGr4Xx/W18Y8pi8TDcXWz9oHayGGR/LfQyRn9uWQlzyR2/kVfHeVWoDNnERvnUrnNc0n7KoleZg4AH9Rufy3zVazqPGwVrx78oDni7oG9XPlub7mKBS27FdURrjhTqQ0c05TFY6VOgBulgNv7Z1IxcV11W1PeLgOvE+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042669; c=relaxed/simple;
	bh=3j2RKb1cfZg8huWyT0jq17tIjyXftXmjC2TfUGqyH84=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PP0/ZIdCNI8I0QvMFtLS9DCIKD+1F2hLQcMSIeDqBqCE6nwdawt3DqSCWF4jX8WCuxKPWAg4rKJ36SbitdJXPGN6qdPiledQqQpBpKNSvaAvmNg/cukufMMmQAzn/XuoYpZILvub+Sf5owXry06WfR8RCYqTLM48J1oh4ZjNnzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=FJ0tJps7; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-94-146.adl-apt-pir-bras31.tpg.internode.on.net [14.2.94.146])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6723A2009E;
	Fri, 16 Feb 2024 08:17:40 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708042663;
	bh=M/FMdOoy6aMi24ewH9zofBlYD2XprYoCM/TIf5gAcDs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FJ0tJps7wyvVhd0rHdmK6uxliQ0CUy4f9kT74A8di+dS9mdD0ArR8eYYFpEQmCdth
	 fafxPWzJFeAX/6bnRGiN7g8WhLvPSruR56WBGzKAA1mJhCK3Qr70xQIXtPlWx08qs8
	 UfLu0Ey5I80K8CIiXnlWyHht6/FN9vRA0sVNHQqmoNGS/1o/VE2LAI3Njne8HfMAVP
	 3M2tRNYOkcLJDIC+ILqoZMvIRemcqlIR3T383SSpcE9MiekObZzIt9h5LhyF9vTArh
	 VqQkIMggtgHSesl1AbNYK4sF3n6UCSAxyAhjuV9yi8NpYuIoM5mkRwqmnUfLZNIkVj
	 TYXYTlStNVtzw==
Message-ID: <ae876e697ba16ba2925ec217c6b4e3d8ffea4ab3.camel@codeconstruct.com.au>
Subject: Re: [PATCH] mmc: host: replace 1st argument to struct device * for
 mmc_of_parse_clk_phase()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: forbidden405@outlook.com, Ulf Hansson <ulf.hansson@linaro.org>, Adrian
	Hunter <adrian.hunter@intel.com>, Joel Stanley <joel@jms.id.au>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Date: Fri, 16 Feb 2024 10:47:36 +1030
In-Reply-To: <20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com>
References: <20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-15 at 19:03 +0800, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
>=20
> Parsing dt usaully happens very early, sometimes even bofore struct
> mmc_host is allocated (e.g. dw_mci_probe() and dw_mci_parse_dt() in
> dw_mmc.c). Looking at the source of mmc_of_parse_clk_phase(), it's
> actually not mandatory to have a initialized mmc_host first, instead we
> can pass struct device * to it directly.
>=20
> Also fix the only current user (sdhci-of-aspeed.c).
>=20
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/mmc/core/host.c            | 4 +---
>  drivers/mmc/host/sdhci-of-aspeed.c | 2 +-

So I think I wrote the mmc_of_parse_clk_phase() prototype with `struct
mmc_host *` simply because mmc_of_parse() took `struct mmc_host *`.

I'll defer to Ulf for whether what you're proposing is desirable, but
in terms of the impact on the Aspeed driver it seems okay.

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

