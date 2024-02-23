Return-Path: <linux-kernel+bounces-78675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A87861712
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851FF289C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EBA127B74;
	Fri, 23 Feb 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTXcICwm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D1383A03;
	Fri, 23 Feb 2024 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704438; cv=none; b=EN5w9nEbigFIZTmkSF95P71UlD0mK/9ri1JCeCmjMCRVSsxeZugvxeA+YDBl0BVP+oQze/ncpJL033U4qX3Csty8MhK/4qg4ajfnzNhLoP2/zWFsHFfumeTJQkd2x9jm6uPGGmBfT3QL4j+nvw/eFwln8lJTcf3UGUO0/9f6LoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704438; c=relaxed/simple;
	bh=3R3/y7BCl7DofayCrQj6RSNk+/FHvDatGBIbaYTfH/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSa6l6cWp4/+wjquWhKRHoJzvgWt/sOgevnuIzJGaxHLcth1oO3JZutTwL10LmoWTRA3jQfiP1qGLLnJ4ux9jSDx3OiouPGom12aRlXVd7Z+8sWuF8cuNvYMbeY9+UvOaxMZ407+wArbjHMPy9+a7wsNialy7AYfY/akkkPKTBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTXcICwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16693C433F1;
	Fri, 23 Feb 2024 16:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704438;
	bh=3R3/y7BCl7DofayCrQj6RSNk+/FHvDatGBIbaYTfH/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTXcICwmheazhrSUfd4a36q70X5/FiwIQTvgHHXG/jhWIpt5cNVqcb1VSA+E6sKnz
	 o2u3B5YMN4ELStnunkpeodAsD2utMKC5krko/ozPm8mibBcUXeppTEsFhq4qu+lCY4
	 FcW9mnOE8DpoZl5dVnWHxi7RzcStaRiaT39Yqu/YL/lpPRzzAFQVYM1JeGNxSvhBGs
	 6BWeKD9AyMvy2HVB7J4Huk3Z//uCtdY/0AKK7Q9dCnEVycHIugD3xS2anjBJ3xdtE+
	 9pVt4pz2iuz0uXPUtR8KZzbYI7kwB2oHTgK+L8Q9M55GOYIoDateGQSmHvFzis+V7u
	 zQ9AxqFZyyfFA==
Date: Fri, 23 Feb 2024 09:07:16 -0700
From: Rob Herring <robh@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Rob Herring <robh+dt@kernel.org>, David Yang <mmyangfl@gmail.com>,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: convert hisi-crg.txt to YAML
Message-ID: <170870443536.2630878.14585914562364296318.robh@kernel.org>
References: <20240223-clk-mv200-v4-0-3e37e501d407@outlook.com>
 <20240223-clk-mv200-v4-1-3e37e501d407@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-clk-mv200-v4-1-3e37e501d407@outlook.com>


On Fri, 23 Feb 2024 03:40:11 +0800, Yang Xiwen wrote:
> Also rename to hisilicon,hisi-crg.yaml. While at it, add "syscon" and
> "simple-mfd" compatibles to match the existing hi3798cv200.dtsi.
> 
> Add reset-controller subnode for hisilicon,hi3798cv200-crg to match the
> existing hi3798cv200.dtsi.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../devicetree/bindings/clock/hisi-crg.txt         | 50 ---------------
>  .../bindings/clock/hisilicon,hisi-crg.yaml         | 74 ++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 50 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


