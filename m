Return-Path: <linux-kernel+bounces-104614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 038CE87D0F8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189D41C22E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0CE4502F;
	Fri, 15 Mar 2024 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsRETq9/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D1F40BEE;
	Fri, 15 Mar 2024 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519088; cv=none; b=rVnC7dmSkzWqQz8E0UJs+v+WzSuTGRkVs/bHHlhGVamUDvLY0vUBFbs4Sd+xt+0kEt6zOfIEgsrBRpzKTum1+kyIYeirJ6Civod8lj2ZfOATAw73PdNvArV8VszYWoq09sifx4p2W0C/A+yixeDOmZHwxocoyvYktTbo6o37HsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519088; c=relaxed/simple;
	bh=VW7YCKCSmxhXKxL8WmbPKYavlvTFAAsxWtG6CIWo7cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDqL9dfZg7KZ0UEkr19kgWnBobM21IvXhxTE7PUeWRp7gFXeYZeUQ1XuqShk9rgt1kx4awrI7KvsTFjMX+303LDD9fRYXV6/gK6E9W4C+THJCGNQAgP1POeI6UAs+QOP2kyeBfb2UlGHZ8EQGRodQvoywWqTDScolydCPD9YAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsRETq9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21FBC433F1;
	Fri, 15 Mar 2024 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710519088;
	bh=VW7YCKCSmxhXKxL8WmbPKYavlvTFAAsxWtG6CIWo7cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsRETq9/NDZ4TwbQkuZD1/7Il5fbOoNCcgrtNsssBgM/6DbCpcKH0fGDXuI5+SOok
	 4hNOmxvAJmfakUjvD9lv27msJsIhSUL9J287K2EWBY5R7cvo0pl4wQ0+GkCnsbNTPs
	 O7FLk11XVtAaByQK9DEbg+M2nmGw0Q1aF1eWdpONZ3Hvt4pEWlUCckzH7HzvJIGRZU
	 0fgu8cXvNDfNXXf7tdCkvCkv1cYlozqx4AXc3M6DqRL196QwXafiNTbxQuVFIvR8jG
	 w1plQSnUg36U3nDxYkvZ0bCGUKWwxU4NGqOjA1sKi7ochoVC/2yuL05YPxuwkr65vj
	 AD/DfGHttRwqQ==
Date: Fri, 15 Mar 2024 10:11:25 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH] dt-bindings: memory-controllers: add Samsung S5Pv210 SoC
 DMC
Message-ID: <171051908549.1426867.12932046451039923575.robh@kernel.org>
References: <20240312190348.724361-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312190348.724361-1-krzysztof.kozlowski@linaro.org>


On Tue, 12 Mar 2024 20:03:48 +0100, Krzysztof Kozlowski wrote:
> Document bindings for the S5Pv210 SoC DMC memory controller, already
> used in DTS and Linux CPU frequency scaling driver.  The binding looks
> quite empty and is most likely incomplete, but the platform is so old
> that no one expects any effort on this, except documenting what is in
> DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../samsung,s5pv210-dmc.yaml                  | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/samsung,s5pv210-dmc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


