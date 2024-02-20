Return-Path: <linux-kernel+bounces-73261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4EF85C02B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E85B20FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B155676054;
	Tue, 20 Feb 2024 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frjXQmRH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E486A35B;
	Tue, 20 Feb 2024 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443573; cv=none; b=Tip+gniBozTovfRCH0p//Ij5SdykiIzmJvm+P9T1JsoD26+X1s8DfoCWIHq09OgCWnUhzn0p0NSEcPGuxmpghs2FfKhnuguVFv5vfItyo7c/WdG7p+rrFPYvmEn71M9TuhlhuLB8DZSp+GYIbyqbIJLdBUTOZQNPw8lzJSZm8dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443573; c=relaxed/simple;
	bh=SEgYYOX36WF+ylRme4jY6LEbb5z9zVVBxPDYpryyAvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eodeiOUD5HXTIOt9c5BRU/+2G68VNQx2+sLSdHHbDwHHpTluIhWaR9L7sR1Pm+vWIfxbdJdO9/n4yyt4I+tFYOKUD/ski/A62V//212K3gtlTr67EtGbpkDK9HtSOhyoRzXw7wi7SZc5zFRDouvYigQZ7E7ofkuyMdXQ80icTQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frjXQmRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D83BC433F1;
	Tue, 20 Feb 2024 15:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708443571;
	bh=SEgYYOX36WF+ylRme4jY6LEbb5z9zVVBxPDYpryyAvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frjXQmRH7B360sJhKlJEt+m2CFVNjnwrajGam3GN1tNfnIb77jeeFuis3S/F+5aJf
	 wlFMKnrIjhNpXQUCQjvYhd8YuUTWTmobpY7MMKa4N1TZJOPOLEytN5xoDRT2p9qB8N
	 O7taf96Df5MDKvTLXjg7u1URwrJhPjvKstd79EpCQBa50KPr6FmkhvxROF2aThdwoq
	 IwWROuSE1bzTtVymdUVyxrqVObMx6CTlVtlXLAoQcZPqs4DQjErhoyLtnbpE40ubhG
	 tH5KDz+l3zoPZirVszNJaejC6BLQGXs4E8hmrvCiJdeTyuOb1AmIT8q4Y3WhVnPhnF
	 QQjYNEacpTQ0A==
Date: Tue, 20 Feb 2024 08:39:29 -0700
From: Rob Herring <robh@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Rob Herring <robh+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Update interrupts
Message-ID: <170844356767.3565819.9603342879693949125.robh@kernel.org>
References: <20240213085912.56600-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213085912.56600-1-prabhakar.mahadev-lad.rj@bp.renesas.com>


On Tue, 13 Feb 2024 08:59:12 +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> All the RZ/G2L and alike SoC's (listed below) have ECCRAM0/1 interrupts
> supported by the IRQC block, reflect the same in DT binding doc.
> 
> - R9A07G043U              - RZ/G2UL
> - R9A07G044L/R9A07G044LC  - RZ/{G2L,G2LC}
> - R9A07G054               - RZ/V2L
> - R9A08G045               - RZ/G3S
> 
> For the RZ/G3S SoC ("R9A08G045") ECCRAM0/1 interrupts combined into single
> interrupt so we just use the below to represent them:
> - ec7tie1-0
> - ec7tie2-0
> - ec7tiovf-0
> 
> Previously, it was assumed that BUS-error and ECCRAM0/1 error interrupts
> were only supported by RZ/G2UL ("R9A07G043U") and RZ/G3S ("R9A08G045")
> SoCs. However, in reality, all RZ/G2L and similar SoCs (listed above)
> support these interrupts. Therefore, mark the 'interrupt-names' property
> as required for all the SoCs and update the example node in the binding
> document.
> 
> Fixes: 96fed779d3d4 ("dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt Controller")
> Fixes: 1cf0697a24ef ("dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3S")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2 -> v3:
> - Fixed IRQ description as pointed by Geert
> - Sending this individual patch as DTSI patches have been Reviewed by Geert
> 
> v1 -> v2:
> - Fixed review comments pointed by Conor
> 
> v1: https://patchwork.kernel.org/project/linux-renesas-soc/patch/20240202093907.9465-2-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  .../renesas,rzg2l-irqc.yaml                   | 44 +++++++++++++++----
>  1 file changed, 35 insertions(+), 9 deletions(-)
> 

Applied, thanks!


