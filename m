Return-Path: <linux-kernel+bounces-99041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF218782B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692FF1C217C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1044207B;
	Mon, 11 Mar 2024 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOD2jh5/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471384206A;
	Mon, 11 Mar 2024 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169460; cv=none; b=XLa1hZlWZ5gX+HukU5TRXo/jJg1XA7tUhzMD/epuxXBC1EseiBTM6iVxjvxTupsQRj8deKV7u6pDeV/55VGux0HmsBlmBC6ee8BNOl6VZrl/6m1/1ksZlr29SINYaEgwXdNYUwdm5rK2oo1D+3ePVOiG1n5m/lSvbRZfNNaOJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169460; c=relaxed/simple;
	bh=tTSFr2gNazt8LUj+QIBkDoISkFb8lDwUZAR355BTpj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWmKfqgtGUY6b4+xd71iWcWVgVhLp7khuCSBECc79DH4ZuKLXy1SxqXARBgrJoBya4ahqlay60yTyC+6+xcBfXhHiSdqG0zyKYJ5NU0vQ+kwpT7FK4dR4SnctOeUI1mNmEBajcvFbdUjuyOXCSaN8X3K7AAqD0FSuVOxpMRRdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOD2jh5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9715BC433F1;
	Mon, 11 Mar 2024 15:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169459;
	bh=tTSFr2gNazt8LUj+QIBkDoISkFb8lDwUZAR355BTpj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOD2jh5/xhC3Y6SADdJi9Zl6alV9z7Uiw8EvyFNrIYjSfkRTJ9dBx5pK1QxNUQVh9
	 C9+Q6Bf7mO/5gKEETqc5WWqaWDW2BRKGD/NNcJFM0UssEBKtvrASyyog5cOG4X7Oyn
	 jSxdkKsJ+zYYKJEPHmjI/u004pP6GtWLfVRs9dOGqZaImdYI0QFzlIth+n0pyeUbkZ
	 upmlA/we5FaA3K5pUVyuUC0XPKcXSixrG5/Ms5bDBmP2vNpK3SO4Uh85yP0GqBXyGq
	 6HTt2yvtc10UUqG+SaRFEF2ZEkITqfg0PbD/GL/8I/Ep2PA+mXS32PAWIvKl7soY6e
	 DfnCiBgjN3lgA==
Date: Mon, 11 Mar 2024 09:04:17 -0600
From: Rob Herring <robh@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org, mturquette@baylibre.com,
	geert+renesas@glider.be, devicetree@vger.kernel.org,
	conor+dt@kernel.org, sboyd@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 02/10] dt-bindings: clock: r9a07g044-cpg: Add power
 domain IDs
Message-ID: <171016945662.1184451.5636347126324844578.robh@kernel.org>
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
 <20240307140728.190184-3-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307140728.190184-3-claudiu.beznea.uj@bp.renesas.com>


On Thu, 07 Mar 2024 16:07:20 +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add power domain IDs for RZ/G2L (R9A07G044) SoC.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> 
> Changes in v2:
> - collected tag
> 
>  include/dt-bindings/clock/r9a07g044-cpg.h | 58 +++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


