Return-Path: <linux-kernel+bounces-39176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6710D83CC11
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090D51F27A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6691350D7;
	Thu, 25 Jan 2024 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="HGUAA8eZ"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195BB1350CB;
	Thu, 25 Jan 2024 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706210402; cv=none; b=Nq/cGim//2UW7BndG/6L4J+dnWM9IxIoOVLpRLiSXhUbK7fZWUIseJVuynhVqznKLAjZBl3/SyfklIpX9yWGvfnM/OvK/GQx6PwnNdMw2GZ8k9wO7KZsKtZb45Aw97pN1NcjACkBKl6R23QWohPW0syPX0tR78Ev4G1ftYA3YaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706210402; c=relaxed/simple;
	bh=6SC+L2BA5mqzWUrQpqvo942ACjt3fe5tpYr4jLAl8oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gb4XCjIUOoIdULBR+Wk1OZUmalZ5dcwRitpKbwVi6vOHOWzjokjSi9pl7D22cagX0wFGK6d1wy3dGTVTKZTtHRctdStTAoQZf+zUoxBkS5U+bgHWK2WQ5I6oWJpMhSogGJJDHBnnvdINiEG1XJQXprOVuPly3PKLD6xGDFPb5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=HGUAA8eZ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 3837522DD0;
	Thu, 25 Jan 2024 20:19:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1706210395;
	bh=TvhSW9GthYG8R5OfcQvqscsrRuKNMD6rW4OJhgfyU7w=; h=From:To:Subject;
	b=HGUAA8eZZSr+v8rJjH/VfykLZ/zOsSDxR1kdi5pMmRNL4GX2YzaSzDEiPc3cX165F
	 6hTAkJON1lq4ZeYAUgsxrCNupegBy7MVzs3IXm3JGVYZVK5Cp7agbrY+0i+T7zTRD1
	 j98+0x1CZP/dxc0PuHVhx3HhsbcBjygruK1FUww11d+T3PFKWbxrEjtPN0aUlULwWD
	 eYmtWaIFqmIMqa5NjjH8WJokBL/wb8yJoWL+8POD4AozlsTOnfmI7gvqODFVUilWMA
	 SKPl2e11TTvpCFDN9XZ17TD/xKGhtpCQdOCulXeDjRnuQ2ygn0rouADsJWSZYD3ykM
	 07bkWKpxEX4fg==
Date: Thu, 25 Jan 2024 20:19:13 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Conor Dooley <conor@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: fsl: add imx8qm apalis eval
 v1.2 carrier board
Message-ID: <20240125191913.GA3117@francesco-nb>
References: <20240125101457.9873-1-francesco@dolcini.it>
 <20240125101457.9873-2-francesco@dolcini.it>
 <20240125-player-disposal-a9cd852e9061@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125-player-disposal-a9cd852e9061@spud>

On Thu, Jan 25, 2024 at 05:08:04PM +0000, Conor Dooley wrote:
> On Thu, Jan 25, 2024 at 11:14:56AM +0100, Francesco Dolcini wrote:
> > From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> > 
> > Add the toradex,apalis-imx8-eval-v1.2 and
> > toradex,apalis-imx8-v1.1-eval-v1.2 compatible strings for version 1.2
> > of the Apalis Evaluation Board.
> > 
> > Version v1.2 includes the following changes compared to v1.1:
> > 
> > - 8-bit MMC connector replaced with a 4-bit uSD connector.
> > - Audio codec NAU88C22 added.
> > - M24C02 EEPROM i2c added.
> > - MIPI-CSI-2 connector directly to the board added.
> > - PCIe switch PEX8605 removed and PCIe now is routed directly to Mini
> > PCIe connector.
> > - Power measurement IC INA219 added.
> > - Replaced DVI with HDMI connector.
> > - Single-channel USB to UART converter replaced with four-channel USB
> > to UART/JTAG.
> > - Temperature sensor TMP75 added.
> > 
> > Please note that board version v1.0 (which reached EOL) is compatible with
> > v1.1, therefore toradex,apalis-imx8-eval and toradex,apalis-v1.1-imx8-eval
> > compatible strings should be used for both v1.0 and v1.1.
> > 
> > Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> I was convinced that I acked this already a few days ago, but no:
> https://lore.kernel.org/all/20240124141849.26254-2-hiagofranco@gmail.com/

Same, but different ;-).

This is a modular system made of a SoM + carrier board. Those two
series introduce a new revision of the same carrier board [1], combined
with two different SoMs (apalis imx8 [2] and apalis imx6 [3]).

Francesco

[1] https://www.toradex.com/products/carrier-board/apalis-evaluation-board
[2] https://www.toradex.com/computer-on-modules/apalis-arm-family/nxp-imx-8
[3] https://www.toradex.com/computer-on-modules/apalis-arm-family/nxp-freescale-imx-6

