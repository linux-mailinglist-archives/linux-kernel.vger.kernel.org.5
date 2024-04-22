Return-Path: <linux-kernel+bounces-153554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935908ACF8C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A72B26429
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8C615218F;
	Mon, 22 Apr 2024 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dT1qTkyw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3715531A60;
	Mon, 22 Apr 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796489; cv=none; b=Hsge9dbJrm7ND+NtPFNZRX8piPjAQKEqcLyg0FuMi97Cf7zlxQU2Dl1PYwXsxtlgXF3tiD7kx/RCLexe4U2HQDpC8zheziV/TEgnlrBssd5oASBmGTvqbsELcaMl/wQpYNYWlHZ2lmedBltjX6Xzg48X0gIRWJI2if0tdDJeCEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796489; c=relaxed/simple;
	bh=nXW/dGp76KSMhEsdyPgcY4LRy3/wNfDXNDI/mbg/66g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+is9i1CFSNmPY5ASTgorcEQmZYlRuxaeRhR4P/ECH8S7C0jGEfxVXtsDrYP5Kbc91m6lz0vhZ8QqKKorIvPf7/FldD1nU85e6MRvhoBAfIFI/+SCGLji0uz20ZiI4CJpf+e1VOmhlGQNuhBt4oicZyXIn4GNr+p6Wpty7uFXhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dT1qTkyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72648C113CC;
	Mon, 22 Apr 2024 14:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713796488;
	bh=nXW/dGp76KSMhEsdyPgcY4LRy3/wNfDXNDI/mbg/66g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dT1qTkywsybV/NomyonjwXaYy4MOx0PozQcd7dGysPmLVUq790DAbcNKrJWqK7GyK
	 ELjSzvEuELkuFdrOsnYjYOlK7pFpdxsnG2rTT5rCGucVQ/8ElTCCtCL97KbgtKuNw6
	 jc3lh26lYgzDjpbE1RysS5D2Zh4QGlZwMRs2qJ9vnDs0LePC++9AKw0p7SmoHdqZuU
	 rPkFQVzQIoNO3FKWlu6LDNslZNjW8GS1olJYMmZorENrtiG+ic9AFy3VYYLt+o4hHM
	 HN/pgmxebJVh+wRGqhtI5+ym8yfWzG8JSZri5HL8Gm+pfhK67U213owbZ1D1Pi/Bap
	 1Xhj8DSKhjXEg==
Date: Mon, 22 Apr 2024 09:34:46 -0500
From: Rob Herring <robh@kernel.org>
To: gabriel.fernandez@foss.st.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-stm32@st-md-mailman.stormreply.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 1/4] dt-bindings: clocks: stm32mp25: add
 access-controllers description
Message-ID: <171379647410.1220216.12174956651152279801.robh@kernel.org>
References: <20240419152723.570159-1-gabriel.fernandez@foss.st.com>
 <20240419152723.570159-2-gabriel.fernandez@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419152723.570159-2-gabriel.fernandez@foss.st.com>


On Fri, 19 Apr 2024 17:27:20 +0200, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> access-controllers is an optional property that allows to refer to
> domain access controller.
> The RCC driver will be able to check if we are allowed to register
> clocks for a peripheral.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---
>  Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


