Return-Path: <linux-kernel+bounces-50544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00682847A7F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331711C27673
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2395181733;
	Fri,  2 Feb 2024 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr8CZbD8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A9381725;
	Fri,  2 Feb 2024 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706905566; cv=none; b=disbdTAlx8Vxeu3aMQn0XP86K4uafIqWxI017UNbnBkW/qSuDBswG8ZzkuRXLGPGUXa6JdCCX+fnMLmmVy+10pTUn0qoXWWhhUo4ajQtI0a2PuOEOpDv8a2knxP5KeAXiHmt1GnHKeRNcD74A21SHI+HElV89gB2//vFzZ8A+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706905566; c=relaxed/simple;
	bh=/1JZId+2n0CkTPlZTieyUQy2OiqiKThajJaUY47t+F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iazSSNI83+Xqw4dLJVOhhCZCKcg8JUkafIkRxmnUxDOeNuRGBwiEoDjPsBYgeKYjy3hPo5vs8vD6OtlDZg7IkSKqeoo1V9KJlu57O0ywqeHAmTIG3b8OCUW/9VZtGsZrbxeCaVUIW5D3kh0a5DtxgFUKS9zqVBulD44iRbnxfn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr8CZbD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EF9C433F1;
	Fri,  2 Feb 2024 20:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706905565;
	bh=/1JZId+2n0CkTPlZTieyUQy2OiqiKThajJaUY47t+F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rr8CZbD8YfgfYohHuZgQzTYRcx2V6NgtG4hYAr1/7fzjJ/0rkbMNFO1/r5ZDLbYCn
	 Try/3FPL9vOl1KbHnWE3hbgdbz2QyNDpUo6WIu/+nSof5DrEOpEr4kg2KYz+Z1GcSY
	 2tw/5J++pQsRywK90ljEhBllW8rdxxJw3ohjilNAI/MCKGP14tlCq8mIx1DqfFXZog
	 O1fMHAj+EwV1YbC9ipqymjcQxjfSqq2AoYwRO8iOQlDLXODqKhXV74ZH2L6HksbStL
	 XscZFyyP4EnkQyrTue1K114yG8a0eSdaIv/izhmJwKXeT+51r7rmYf0ls5475xqEji
	 U20tRHxK6V5Mw==
Date: Fri, 2 Feb 2024 14:26:03 -0600
From: Rob Herring <robh@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, nm@ti.com,
	linux-kernel@vger.kernel.org, b-liu@ti.com, r-gunasekaran@ti.com,
	srk@ti.com, krzysztof.kozlowski+dt@linaro.org, vigneshr@ti.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
	afd@ti.com, kristo@kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: mfd: syscon: Add
 ti,am62-usb-phy-ctrl compatible
Message-ID: <170690556320.1075006.3197540858856784438.robh@kernel.org>
References: <20240201120332.4811-1-rogerq@kernel.org>
 <20240201120332.4811-2-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201120332.4811-2-rogerq@kernel.org>


On Thu, 01 Feb 2024 14:03:28 +0200, Roger Quadros wrote:
> Add the compatible for TI AM62 USB PHY Control register. This
> register is found in the TI AM62 WKUP_CTRL_MMR0 space [1]. It
> is used to indicate the USB PHY PLL reference clock rate and
> core voltage level to the USB controller.
> 
> [1] - https://www.ti.com/lit/pdf/spruiv7
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
> 
> Notes:
>     Changelog:
> 
>     v3 - add compatibles in alphabetical order
>     v2 - New patch
> 
>     Changelog:
> 
>     v2 - New patch
> 
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


