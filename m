Return-Path: <linux-kernel+bounces-109020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C6A881372
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2F728183B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5438247F7F;
	Wed, 20 Mar 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvs4/3Zp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865854596C;
	Wed, 20 Mar 2024 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945432; cv=none; b=ShMc6pdwaA1ZkNlFYGtatR1FcNZF7HVjEXEdjGND9umNw0kvgvh1/atONsidZnPKYreFWfKKtj5B2ObeAkQmZoOLuUpj1jERcmGjpEU5aSx3ckQu7H4WdRDH1YI1kCRnX/g7CWKwBrypc1W3NoDrjtT/36LIFmHW311QS93NGVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945432; c=relaxed/simple;
	bh=sHHbuYFWLzbXRpPFre1G9oi4c/Un6QERBOEq6EyyZOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jD+DKcGCApnACp7h3GAjtHk6uaHFzGvSt8DbLbe4DTcX0A33PXFyy0P9RmBjU4aYg3VSkiqU5yt4/uz+bLD7E/+ilPG1rZV7+mgd+MufvCNAKC0MOaVV9KYVyMzC270wiQmd5YFvXUBxzGC3Ldo8D7R8kpwbzCFwkg08XrNOKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvs4/3Zp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2674C433C7;
	Wed, 20 Mar 2024 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710945432;
	bh=sHHbuYFWLzbXRpPFre1G9oi4c/Un6QERBOEq6EyyZOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvs4/3Zpg/p5C1nPFtJd3JaiL6u9ZdC64Ztv7iG3TDt0UjISG+WWAnaY7/LSE65CY
	 1fft6ZlyELQuhflT33iq6T0fiIgH9QXMsbjjtWBBEjj1KLEcUpx43oikwge4caOxcI
	 X3TgX+xeVHt5oa+j1XhC2RQPmsRbC688OE9ejsuHnLx4/2oy9/6701cxnEOYSUZUKM
	 NLXeOnIED1bm4g1/RKDgK525yIAAn2FvzsZ+J6vX9zzICNYbXmtcQNEFV47HCVmjiu
	 KIh1wC1v+2hxlelEaASDNZabL59/9tydiyO9K+y+xSJQfaIspm9R6J+sAO3a7XgYv9
	 n3a4eO9+HdZWQ==
Date: Wed, 20 Mar 2024 09:37:09 -0500
From: Rob Herring <robh@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: serial: renesas,scif: Document
 R9A09G057 support
Message-ID: <20240320143709.GA1676859-robh@kernel.org>
References: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240318172102.45549-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318172102.45549-4-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Mon, Mar 18, 2024 at 05:21:01PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Document support for the Serial Communication Interface with FIFO (SCIF)
> available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interface in
> the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
> (R9A07G044) SoC, with the only difference being that the RZ/V2H(P) SoC has
> three additional interrupts: one for Tx end/Rx ready and the other two for
> Rx and Tx buffer full, which are edge-triggered.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3
> - Added SoC specific compat string
> ---
>  .../bindings/serial/renesas,scif.yaml         | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> index 53f18e9810fd..e4ce13e20cd7 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -79,6 +79,8 @@ properties:
>                - renesas,scif-r9a08g045      # RZ/G3S
>            - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
>  
> +      - const: renesas,scif-r9a09g057       # RZ/V2H(P)

I don't understand why there's not a fallback. Looks like the existing 
driver would work if you had one. It should be fine to ignore the new 
interrupts. Though with Geert's comments, it seems there are more 
differences than you say. 

Rob

