Return-Path: <linux-kernel+bounces-137062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F2989DBD5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED021F23F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BBA12FB14;
	Tue,  9 Apr 2024 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuzBib3P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3FD75809;
	Tue,  9 Apr 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671893; cv=none; b=Bron64fjMzCgMxY0sjVGKpXe4Yt6SydVyNJnyaosRkSmevZLE87dsrKOnVQUaAGDdqWFG4OAu649Otsm6ea82vwTVFtPOsHZusF3Bhg/CDD9fWRsG2gw3tbusVjT+rBC5GYTumy/7tVkYdTuXv/1ovk6Vd5+VjS+V3gtULOZWDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671893; c=relaxed/simple;
	bh=YaXWoVymImPtlRnaXvB+mRohV2Ldkp3X0gl23abX7y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5kr551MvHkRCvJSzzzZLDr0sdlsg2MQDq7cFxuev+qnx/44Hib2zJgNcZZX0o7doIgRrh56Rf5VjYjTtnOq3tgkJGUWPIhXA0PSMXfG3zbgF6CyNdh1+7OS1nxHckXZmsjZspUe7vqZIUZuegp452NnrpC1AmoQDUB3F/jx++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuzBib3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18092C433C7;
	Tue,  9 Apr 2024 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712671893;
	bh=YaXWoVymImPtlRnaXvB+mRohV2Ldkp3X0gl23abX7y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JuzBib3P9kTwrHPfG27Cnd5t6YLM7UNrhEPA8gSixs2TtZ8PQfyigu35dgS867ssG
	 eI8AAJH1+SKaz56fhufBUSFe0PtoCf927I9DQRoS7ThX0I0Kb1KDcYWKy1rFm+9ihD
	 JJQraBZynIO2SBCn5ORSnZlPsng5i2GryY2lmJW9JoDXAwOW89J4GNYKMyc2nkD15J
	 EBfm97nfvmUgGJvwyKD+fJCd/6wfBwTE1RcFqdor4KU5bjeRyF+ZjNronLxkR9rgox
	 OtSe/JyLZSf5O26DxxRcSQ7CJWMsCG1aYhbwRT9MFGYyI8p89lA+yEr/2soVtwn5y2
	 mBhMUDOSV2dLw==
Date: Tue, 9 Apr 2024 09:11:31 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: renesas,cmt: Add R-Car V4M support
Message-ID: <20240409141131.GA1102070-robh@kernel.org>
References: <3e8a7a93261d8ad264dec2fa2784fe1bbfc4a23c.1712068536.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e8a7a93261d8ad264dec2fa2784fe1bbfc4a23c.1712068536.git.geert+renesas@glider.be>

On Tue, Apr 02, 2024 at 04:36:05PM +0200, Geert Uytterhoeven wrote:
> Document support for the Compare Match Timer Type0 (CMT0) and Type1
> (CMT1) in the Renesas R-Car V4M (R8A779H0) SoC.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/timer/renesas,cmt.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Daniel, please apply this. The timer bindings seem to keep getting 
missed.

> 
> diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
> index a0be1755ea28b996..5e09c04da30e47d5 100644
> --- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
> +++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
> @@ -103,6 +103,7 @@ properties:
>                - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
>                - renesas,r8a779f0-cmt0     # 32-bit CMT0 on R-Car S4-8
>                - renesas,r8a779g0-cmt0     # 32-bit CMT0 on R-Car V4H
> +              - renesas,r8a779h0-cmt0     # 32-bit CMT0 on R-Car V4M
>            - const: renesas,rcar-gen4-cmt0 # 32-bit CMT0 on R-Car Gen4
>  
>        - items:
> @@ -110,6 +111,7 @@ properties:
>                - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
>                - renesas,r8a779f0-cmt1     # 48-bit CMT on R-Car S4-8
>                - renesas,r8a779g0-cmt1     # 48-bit CMT on R-Car V4H
> +              - renesas,r8a779h0-cmt1     # 48-bit CMT on R-Car V4M
>            - const: renesas,rcar-gen4-cmt1 # 48-bit CMT on R-Car Gen4
>  
>    reg:
> -- 
> 2.34.1
> 

