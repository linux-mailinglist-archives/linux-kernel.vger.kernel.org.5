Return-Path: <linux-kernel+bounces-92540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23FA8721E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA67285B25
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF7486AE7;
	Tue,  5 Mar 2024 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOQKa80J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7AA86AD0;
	Tue,  5 Mar 2024 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650071; cv=none; b=o47tQKXrraWlpThb6nXXBEEx825dm5D/dAonVWCeT0v9Zc8/BIFjT3cUo0pKgSFER3WMsyUxkF8lyXI/72ZZIQSFvVP1A4Ise8dwCHhf5O00xtM2j7jsqHedy5eNCsHzjzUNhAwnh+nSjKssyBf9Jkqx63Q4ivVTUxHk0CXWGog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650071; c=relaxed/simple;
	bh=hY0SkX2+Ee1KMf7D9DXccosG2cFlLicJnwjKDfLkTTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ8nOPmA4oOw+dfb4nLv1nmf8AFCgX2thC+HXFYHPKEj/E9e7UnE+9pLIhixIQyNok5QIXjcrI8ETsNFW9mWpvHt92vbN3czoFW8jvKsJgwLeUNxaEYmCVXmA+Jd5sODdmyT9sxhkq3lGiYmXOh5gpjzltfsAWzO9WNGKBNobaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOQKa80J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11990C43394;
	Tue,  5 Mar 2024 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709650071;
	bh=hY0SkX2+Ee1KMf7D9DXccosG2cFlLicJnwjKDfLkTTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FOQKa80J9eJMmAq1Ga1F2gAW2IndGSrbNBTCRwILYXlo2yUf1TYtMfTtBHhq6Odvl
	 omXdmg4xlxSqA+sCzjU+Swn27Vv3TtP9+1rlLZuD8igI5glHRxQ2v+1lLllGWVEKhu
	 N0QoYpH/92fYrgM64pC6EJYaOU2Tj6GbzkOXZ3WHkHkaPa9TD4l3FkxnJbUtu6cB+a
	 7dnVP4io/rQRa8IUGPx4E6N9Mbbz+a3tke9B9m57goEfMVVsNQ3hCmhtp8pKjvK1gd
	 W7/z1+ZwbnrZsJSV0wkVtkJv78rYc4yA145f/aWIXlixlNTt8kq7OSHgLmr/ZI6vSE
	 lXje0CQ+70yfg==
Date: Tue, 5 Mar 2024 08:47:49 -0600
From: Rob Herring <robh@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Rob Herring <robh+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Guo Ren <guoren@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/7] dt-bindings: timer: Add Canaan K230 CLINT
Message-ID: <170965006812.3329951.14876458857891644182.robh@kernel.org>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
 <tencent_CC6884F036B6F3D50A6269733BEAE226C40A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_CC6884F036B6F3D50A6269733BEAE226C40A@qq.com>


On Tue, 05 Mar 2024 05:05:57 +0800, Yangyu Chen wrote:
> Add compatible string for Canaan K230 CLINT.
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


