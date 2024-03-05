Return-Path: <linux-kernel+bounces-92565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40244872237
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFAD8B21772
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C62127B68;
	Tue,  5 Mar 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnl2KG4H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032F91272CC;
	Tue,  5 Mar 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650733; cv=none; b=FvvGfCMYWJQG1XWmGKLpdtJD8IaEcoy4ulQXCfCKvtRJTEBHHnpROt4NuAimP8UOUQ+zXTaLrCQSaf6WIZnYFBp5wm8DqT9Vn04L5i4HLVDdP5CswtBAHLKTc1pGHMZDFqFBRT1fqHBf6N7cojx7paJY4i3ghIIzfeA+lM97a5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650733; c=relaxed/simple;
	bh=J04pRpfBn/6vgApXzTjxcOt28fu5ycMkjiryDRSouFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7pE3UzTLbW/8sQ/9BQ2K1ryDsGffUFL61YpjeT4t1WsFyLBN7uTUdt9F1rJqJdKpawnZMJHpaSbRS4E7n4EaqLM2wQRkdD3DGTbFCrZL53Rij2YVUAocCLdyxyM+jrkAZSj7xYdQzYdBwYaRwiEjiBcpkWy6MDlXZ5wMBzBfgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnl2KG4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FBBC43394;
	Tue,  5 Mar 2024 14:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709650732;
	bh=J04pRpfBn/6vgApXzTjxcOt28fu5ycMkjiryDRSouFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qnl2KG4HWtYmUl6RC1v+6GncfSZCWD3x6+yA9haciL4fuO9OQqLIV5knq3SuWQ1e4
	 ughBIbako6VNi3nzSu/qgFc+Ei8VsJJcyauRNcTBDHmUU+rnvasNNyv0xww8vUYCrz
	 7GtjbZfr9rm1MRfbo3JiW0A9Vm+CJaHoKswvBlB2QuqN0E48aHJoUK2fQNj1Hd+N9h
	 N6eiZlnUo/4ZhFX1WCTt/q325jfWv2fTbq6V3EfpuPRQiysMMs2FkM65IIYAMjkCQh
	 FILW3VSWrLHIcfatr/NvaPVdllKKkjyT2xlDqfm0PjS1lO2LpaN/g/RgN6SkqBDu7I
	 JcEBwnklyQMAg==
Date: Tue, 5 Mar 2024 08:58:50 -0600
From: Rob Herring <robh@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	David Yang <mmyangfl@gmail.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: phy: hisi-inno-usb2: add compatible
 of hisilicon,hi3798mv200-usb2-phy
Message-ID: <170965072885.3344208.7195492638472513221.robh@kernel.org>
References: <20240305-inno-phy-v4-0-a03204c9cf1c@outlook.com>
 <20240305-inno-phy-v4-4-a03204c9cf1c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-inno-phy-v4-4-a03204c9cf1c@outlook.com>


On Tue, 05 Mar 2024 10:19:49 +0800, Yang Xiwen wrote:
> Hi3798MV200 INNO USB2 PHY is attached directly to system bus. Add
> compatible "hisilicon,hi3798mv200-usb2-phy" for it. The ports of
> Hi3798MV200 INNO PHY has its own address space, so
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 31 ++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


