Return-Path: <linux-kernel+bounces-157762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DC78B15C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507781C21AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955FC15B564;
	Wed, 24 Apr 2024 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOTbOX7n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D786B157492;
	Wed, 24 Apr 2024 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996276; cv=none; b=pFlZiFe2qGxru1GJCovNdsvo5lD6VyvT0PYy+MSl4HSYhnL5gG2PswjQfwYK7NdJotlqQHRJiguwXeYvp1Up97QoR34/AB35ORmToVVXwjTKRNWw8LNMMK6I9OAgfd+LF7dcW1Ar77UJEZQYNdLJeVS9Tbz8fWe5Wd5OLdXnrEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996276; c=relaxed/simple;
	bh=ExMY2DGUIWSWHmlNIofPsgB8GGtX0pH1hq3K1IaRN+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIuzDC1q3SENufP3erGN9UqNRLMCdpghAFX9//VerNzP3pvLLppZg/IsSkw8bw8/3+eRuzT+DY2ylu5R+Kd7HCD4MFkSbQS0KCUjEuSfth1zHgEHvtC+07ldAFFfvKrIHV+MEoY8FjLKKbtEd92HKDCDmk98eCJVAnt+aQg1WTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOTbOX7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BB2C113CD;
	Wed, 24 Apr 2024 22:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713996276;
	bh=ExMY2DGUIWSWHmlNIofPsgB8GGtX0pH1hq3K1IaRN+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOTbOX7n9SyqWouZPINt8hRWgfHp50GI3RR0vlwFWRwu8VxSx7W8UGc3uBEcGpOtY
	 +1aHPLIFTuleD51AdBad9RJ07NjR9Ul8dYPgNb/G3a52bDUKon7ImnhO1CN3VIPjNc
	 HmPX+vQaXfwZPM8xwW5FqiYz0LJCU8IdemVt1RD67amUSi4gPUsNfOVNgB57cWGErt
	 aUOEL0tjKykv7ORbbu+YRRZ1E1GCT5ktoBfjHQ06Obuz6jzoyBGw+j4LLdBsBFsfUv
	 1cNo/tHc04WorrdbI+hM9RJpej8XJwlZxDvXivhZ7McCHJIv0HaSWuG0+MPc+RRfEF
	 PFILxUhX3oI5g==
Date: Wed, 24 Apr 2024 17:04:33 -0500
From: Rob Herring <robh@kernel.org>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
	conor+dt@kernel.org, krzk+dt@kernel.org,
	jeeheng.sia@starfivetech.com, linux-riscv@lists.infradead.org,
	leyfoon.tan@starfivetech.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, devicetree@vger.kernel.org, conor@kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: cache: Add docs for StarFive
 Starlink cache controller
Message-ID: <171399595085.782407.16477944917789511195.robh@kernel.org>
References: <20240424075856.145850-1-joshua.yeong@starfivetech.com>
 <20240424075856.145850-3-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424075856.145850-3-joshua.yeong@starfivetech.com>


On Wed, 24 Apr 2024 15:58:56 +0800, Joshua Yeong wrote:
> Add DT binding documentation used by StarFive's
> JH8100 SoC Starlink cache controller.
> 
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> ---
>  .../cache/starfive,jh8100-starlink-cache.yaml | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


