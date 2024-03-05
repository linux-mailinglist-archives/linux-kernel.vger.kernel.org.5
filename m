Return-Path: <linux-kernel+bounces-92542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD618721E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C741F220F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F13686AFA;
	Tue,  5 Mar 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAzSaouw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929125466D;
	Tue,  5 Mar 2024 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650100; cv=none; b=ZwZv4ARtxEWArqcmYWfUgH0o7AZqBgrJg6jB5FhnQxrsVh+DF52Y/rNEsogHOLmU+3iuQV8rB5bMXH5H4VgUytTqgvdHkNeAHKiLMF/j/pcukKaLBigGBnGeYlDjRsXMm5WJ6yD7Kzq0FNC+R9fbBt/la1Q27d9UT5NFQrFTpOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650100; c=relaxed/simple;
	bh=ivZ3608XOjlyfI/jTVtD2Rd9tfXwgE5HJrQajJgh2MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTe61qONli5y6htPGQ4SitedKE3DC/M1HmCl49xj3TbyO8JaVlHUcVJ4hHTC0xLD3CN6gjssHUySNdlRKcbx3k4taOAfmbwb2T20E2zbvuX2ZJeIKYf5R+7E0bAsNUYXYGqMwsEPfTNGqWI3+/sT3by81NuimHn9ZnABIswyNPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAzSaouw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E49C433F1;
	Tue,  5 Mar 2024 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709650100;
	bh=ivZ3608XOjlyfI/jTVtD2Rd9tfXwgE5HJrQajJgh2MA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAzSaouwcSUTBZt+s6Yv7/P83NDFtlBo4AaFMjL12bVlmPptxiYgrFpko575FcjGW
	 CGk9IQbqNSsmthc+9Z8gicgvmg8+7pM61RA38a2SGI4ho0deAtn4kRnuASxqYH1Qzu
	 ro8ovihIOSoHE6Bba4ih7rlC4Kt5rV7qiygejo7aQHEqnFJZEl2c7iExlDz5WihFPl
	 yoCTO4/McjGTmEh8ShNk2U9uSOE7rlNDXY2H028XvqounaMoD/g2D/KzoBO+Lonc9l
	 Ird4fCpLofrAV6h8EoFKtbDSCEDArLTDle8WEqd7vgmZYCFqiPu5o+VPmi/H+uBw/V
	 0es7Y/klS/UXw==
Date: Tue, 5 Mar 2024 08:48:17 -0600
From: Rob Herring <robh@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] dt-bindings: interrupt-controller: Add Canaan
 K230 PLIC
Message-ID: <170965009708.3330690.1601978626699583351.robh@kernel.org>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
 <tencent_1B1643401B7BF8EC04C3B5551D9D703B6209@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_1B1643401B7BF8EC04C3B5551D9D703B6209@qq.com>


On Tue, 05 Mar 2024 05:05:58 +0800, Yangyu Chen wrote:
> Add compatible string for Canaan K230 PLIC.
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


