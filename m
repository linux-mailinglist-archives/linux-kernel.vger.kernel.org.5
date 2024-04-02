Return-Path: <linux-kernel+bounces-128074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA078955B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267C8284221
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973EB85C5E;
	Tue,  2 Apr 2024 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xauo+CfB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D0783CD5;
	Tue,  2 Apr 2024 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065435; cv=none; b=V5NnXyUXhv2R56b9t/RMPodyO+W5WauFMJGKBHx4CMFeZ6Flog8PI++Gy8oJgTfIVdxW91GJ28Om/VWWVuITUMhpfGSYJgJXBv6EIP2EiHF3xt4haGFawk1n/oM7JbpiQsToe9NJENvk/Mx2hI2c8EZFKE3PEPnmTQmF7aoDhxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065435; c=relaxed/simple;
	bh=ILknQX3J4PZxUszkFt7epugC1M4nZbhuqbLyTS3A8iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEfqLkfDuGYMb5BbZf4/fJ/XO+DXtM2sFIJRBJFpItPX+RDlC0K+TeOgI6FT66rgr4gMZELGae4FPj1L0kBKWVp6uFvE65vSr1kVIOkLEeXH+MResu+TWzOaQ89QxeOkgG7qNlZxCZWq6gVKs85a71wD5we6RsRte7LR8hDZVmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xauo+CfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6DCC43390;
	Tue,  2 Apr 2024 13:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712065435;
	bh=ILknQX3J4PZxUszkFt7epugC1M4nZbhuqbLyTS3A8iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xauo+CfBBB47w5kBNrl6dtBQuuAAndmgLyo7PKwtYCZ1gP2onEgiJm9SmIPWEy4Rj
	 DhVJYkwhSNBFyYnfTBO7+y+hpL7kosgM0w/mzyEuFyWRxBZHhtS4nAzRfwqUU0WM9W
	 R0ClOMfBrLdqzihPQagAF4KzuchmW4RqPRPvyPydeLv0lvCQ5r0pSbsdtn2fEb3I51
	 bVlQmuENfzLLiZuUn+AjMszgkM+qKaRzu/aMQ4QxaH/2dFtqK36zoBP2FDC29vc8Iz
	 aTXTb7cFRfsrIIca2BgtEGXDZkbo/W9pKi6uXdfnDmOhdIbI0V3TuHBSHUp6Epo9sU
	 MmUFwcy+g4r0w==
Date: Tue, 2 Apr 2024 08:43:53 -0500
From: Rob Herring <robh@kernel.org>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Jason Kridner <jkridner@beagleboard.org>,
	linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>,
	linux-kernel@vger.kernel.org, Jared McArthur <j-mcarthur@ti.com>,
	devicetree@vger.kernel.org,
	Deepak Khatri <lorforlinux@beagleboard.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: ti: Add BeagleY-AI
Message-ID: <171206542850.4100155.11719958875815891934.robh@kernel.org>
References: <20240328191205.82295-1-robertcnelson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328191205.82295-1-robertcnelson@gmail.com>


On Thu, 28 Mar 2024 14:12:04 -0500, Robert Nelson wrote:
> This board is based on ti,j722s
> 
> https://beagley-ai.org/
> https://openbeagle.org/beagley-ai/beagley-ai
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Nishanth Menon <nm@ti.com>
> CC: Jared McArthur <j-mcarthur@ti.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Deepak Khatri <lorforlinux@beagleboard.org>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


