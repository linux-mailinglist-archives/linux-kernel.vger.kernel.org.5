Return-Path: <linux-kernel+bounces-161942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A888B53A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6DF2812BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6134F1C294;
	Mon, 29 Apr 2024 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="ibvMJ9rh"
Received: from smtpcmd13147.aruba.it (smtpcmd13147.aruba.it [62.149.156.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FC01805A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381320; cv=none; b=lRKwCBnIGimpZtk5LQ9Nbopotv/pPXedP6SLRL7P4ghAoh50bGhaRjHKtssJ+oDooNvqVBdTVLD6sQBzw4Fl4RSMoWMiqQSJl4jvykl5XUNeOmf/GZ86ctbek2XfItP5LD2afmfv6+bhX1kZmB8mh9/AYvZc4S1hX49CQMeDpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381320; c=relaxed/simple;
	bh=i8FmGMtJzlikw6wB6ZqFhjg0Ookvgh8byAh8XQNT4xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRvNp6Nrnv1K4LngOCKMsV0gf0Q2zssH25dKa22OsSehLB1zJDP38AYsNXX09HUDvmTVOvtQe+foGzIqIznHlx891vvz9zJG8U0yBhd/OpBujBNWapRG8bwcgR6VgNv4jy6Ba6XXtZTXRwTPDMa+mxgJK19pAC/RCVToCUDIchQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=ibvMJ9rh; arc=none smtp.client-ip=62.149.156.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([146.241.8.107])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 1MtVsUi4M8U421MtXsNpBr; Mon, 29 Apr 2024 11:01:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714381315; bh=i8FmGMtJzlikw6wB6ZqFhjg0Ookvgh8byAh8XQNT4xM=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=ibvMJ9rh0OCgLdxohI3Ogn7GPFrgHH7Zh4NtOvH3em67+cf/WumXdiyu47PwgrSeb
	 X+oZf5yYe1k+/xNGTD6buuJwCaOPh428ZvArNUOJ1HxWkKtgchr15QaADpn1OUHleL
	 6ax4sRhw92dcrjZbmob9KqEQKK+ozrUqbf1NghauGymfqjBMV3zwHjH+VGaegBe//p
	 dagsiTstE4MOXkFc0Cndm2LOqIiSBDWn0hXbo3MMMMMktth3o90WD6UNkBKybw2Bfq
	 BDINZiDZrhaU69K4Ysa1r3AqgwQbmwz8a3jQgG5jb0YrpGuBhhTyGhNHSQ0yG8S7mx
	 RdsHJSf7j/PCA==
Date: Mon, 29 Apr 2024 11:01:53 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: arm: fsl: add Engicam i.Core MX93
 EDIMM 2.0 Starter Kit
Message-ID: <Zi9iAZjrq13X4K/C@engicam>
References: <20240429084422.8369-1-fabio.aiuto@engicam.com>
 <20240429084422.8369-2-fabio.aiuto@engicam.com>
 <07fa8910-da6e-49f3-a3d3-b7a55c48224a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07fa8910-da6e-49f3-a3d3-b7a55c48224a@kernel.org>
X-CMAE-Envelope: MS4xfM10U/MOtBvDDGkxGerqcBNsZW7E4daaxkkWp8r5fj1+fdoePgGL2cwE3Dw4du4mDHmao1Fng1rbN42v/Yzk1ka8X4kq/K92BBG9GjC19EozEZ7TSwVY
 4uLJdcjAxdzvPDwLcqXECYxk/qWQJ6p5r+dk0+EwDAcxBWbjlttF8EfyZOUppLeKzYjzku8mUadXD9AAA7vs9GLBv1FLbJczUsDQQLZKWvGp34oZSMqfalrJ
 FwmklNtXrCZbmaZAdYIa9EpHZSrbIZFiiWHz67u/UbbRaeKjNqtQl4eHeqICHSpqUqCJdw+nxC7yPmFPfMMiV3sFzd8iZqj7rHqPE1MZ1ODB5YAMBEgQxqJg
 NXpugTNtwDkL3KmUZ8cAncVdxkwvdn9fJziGuMLNgWFI//6fEQUjEFBcpol0PQgs6GFiHFXYwpC/0fLJj9PTh4fUIvhvPaM9Trs7nXwy8Mi7rK+LrjxK6z66
 9Vu57r75tHkyKjYxE+KORu6MImhYLW5BW/yX5rsETJkFy0fSz/nicjUw7mwuB2yyk7ElLUfPtXmFaYzdLsYTCnQg5OKvLmjB0AvZlfG/iOhm7fpbtHlR6WxY
 ISOYSlBMUP4MvUP0Guto/mcWVcbH415LKwY75QrWwC6mqQ==

Dear Krzysztof,

Il Mon, Apr 29, 2024 at 10:53:08AM +0200, Krzysztof Kozlowski ha scritto:
> On 29/04/2024 10:44, Fabio Aiuto wrote:
> > i.Core MX93 is a NXP i.MX93 based EDIMM SoM by Engicam.
> > 
> > EDIMM 2.0 Starter Kit is an EDIMM 2.0 Form Factor Capacitive
> > Evaluation Board by Engicam.
> > 
> > i.Core MX93 needs to be mounted on top of EDIMM 2.0 Starter Kit
> > to get the full i.Core MX93 EDIMM 2.0 Starter Kit board.
> > 
> > Add bindings for this board.
> > 
> > Cc: Matteo Lisi <matteo.lisi@engicam.com>
> > Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
> > Reviewed-by: Krzysztof Kozlowsky <krzk@kernel.org>
> 
> What the hell? Why are you changing tags?

I fear I don't understand your comment. Did you gave me
your Reviewed-by: tag, didn't you?

When Conor gave me his Acked-by in v2 told me to pick up
yours too...

that's all

kr,

fabio

> 
> This is corrupted since v3!
> 
> NAK.
> 
> Best regards,
> Krzysztof
> 

