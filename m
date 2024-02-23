Return-Path: <linux-kernel+bounces-78681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEA7861726
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FAE28B66F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96CE1272AE;
	Fri, 23 Feb 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoulZOWf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20AA126F2C;
	Fri, 23 Feb 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704575; cv=none; b=S68RjvupOw8FC/0y9d5eIUDwP63o9vxgqpsAc+d5Ifb4xiW7f2z0msB8VuzRXXXvsfnunc8YyKd7tB0AVJj1PJ+uyqdiqKekI1Tmu6+YRkYxrVEBJJ56WoCxF8AzOBo88WIL3VmvAZq5WyyrioRZaAXshMEPZsmgkkC42oBsPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704575; c=relaxed/simple;
	bh=rE/EX9atsCk+04g+knmXNpj9M8baBRwq5gAnO5u9V90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FR39307ISL3MEoHDgwxTxnOHU+g8T8RZG4RQ2nr+sy4dkD0xr+21tfF5l9GnBKKKsX/FdPF+j8ux3wLq+LkCyhgMGK5UaA7RELLo2Q0k2yeTSCWRVtiXhiSC4ppjepVj8qGZKGL3SHb0i86otrgx5mLtbh4Qdv5INpgz49PpnEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoulZOWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44333C433F1;
	Fri, 23 Feb 2024 16:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704574;
	bh=rE/EX9atsCk+04g+knmXNpj9M8baBRwq5gAnO5u9V90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WoulZOWfAJ0D2gX4dRmpeXrgjhaThroqpRFKpSTGBzB+PpPVvj+pGwEgKKe8sVEbW
	 ZNRXwJsXjt7k20W03fqpk6UhO7JWB4bM4WUxq/wjWslAegjtl9k8TG1aT3ryqF86bQ
	 6Wi+HBXeZA9/+8EHMEYKxWbMFBqM8v9KulSm0y82pIbuRuMpNTYzYIvp7YcJUH4Mml
	 +ChJd65lSliboc7NcBMqIWE2Yp/ExJDmhff1xKoWGteJs3UliuSvgi6gW8uaw1wz/i
	 GqP+BIsc9BRAMh5Ju8n/96dOyeAQFClLiXdZb7c4awjPxMJBoVQ5vaajQk8sdCd+6O
	 8OnAJJHZsTi1w==
Date: Fri, 23 Feb 2024 09:09:32 -0700
From: Rob Herring <robh@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, David Yang <mmyangfl@gmail.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/7] dt-bindings: clock:
 hisilicon,clock-reset-controller: add Hi3798MV200 SoC
Message-ID: <20240223160932.GA2637361-robh@kernel.org>
References: <20240223-clk-mv200-v4-0-3e37e501d407@outlook.com>
 <20240223-clk-mv200-v4-5-3e37e501d407@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-clk-mv200-v4-5-3e37e501d407@outlook.com>

On Fri, Feb 23, 2024 at 03:40:15AM +0800, Yang Xiwen wrote:
> This SoC is similar to Hi3798CV200.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml b/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml
> index 251156905a7b..a4af12aa3f08 100644
> --- a/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml
> +++ b/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml
> @@ -23,6 +23,8 @@ properties:
>                - hisilicon,hi3798cv200-sysctrl
>                - hisilicon,hi3516cv300-crg
>                - hisilicon,hi3516cv300-sysctrl
> +              - hisilicon,hi3798mv200-crg
> +              - hisilicon,hi3798mv200-sysctrl

Alpha-numeric order please. Really, looks like the first patch is what 
needs fixing. With that,

Acked-by: Rob Herring <robh@kernel.org>

>            - const: syscon
>            - const: simple-mfd
>  
> 
> -- 
> 2.43.0
> 

