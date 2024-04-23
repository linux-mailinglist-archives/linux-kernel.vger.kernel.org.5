Return-Path: <linux-kernel+bounces-155428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D278AEA37
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DA62832E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F0313BAE8;
	Tue, 23 Apr 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMv0KDBI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D013B78A;
	Tue, 23 Apr 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884944; cv=none; b=qaYSDruOlzXeMctKSA7HhkStrGkVzqB4SXA52X62/moTCkaZQxyGan1w0DGZ/3b5CERxm67VUJ7ZG+zKKKq/L6rsLBG//dFRTPuXDjG6wYDF0+6WKkU0I8qZuQvk7wStHjTGf/ngPHquV9xX3pzutKfhyfGsYlSrUw2cTMjJq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884944; c=relaxed/simple;
	bh=rRRRqOIkU579WOQd5v8DqfCmc5CmMHDhSIUm1G6qzfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE8gcv3hDCHQldMuhaRw3L0ilQuLl9n51XqGWMfZl1W1crYcbJYm5Htp1JEBRhDxh4TexOyaDu7F9KTkOU3lPwmSyI9ZG4UXQiikEWCjCdVaTNOAj4J4u25uZ1ZJ3ITXIGcPSmGZq+LJkwsHKHFvzN1ELtp1v1zH+0+KzsxvxHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMv0KDBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1875C116B1;
	Tue, 23 Apr 2024 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713884944;
	bh=rRRRqOIkU579WOQd5v8DqfCmc5CmMHDhSIUm1G6qzfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMv0KDBIUq9wBLISzmCqyOY3mK+yUsGj2VsjrYHsRH1CZeTsHxYtdpHp/WEsKcH57
	 pBknsDNkE+TTjVqOWpBMQytDtRLNcJf4vvVZmdwLy8dIy9QdxPfS7/rPc0AtDZIhW9
	 isuWSHkq8Tk7exmX+B6nO2Cun2gO/pBWx7mZ3V4XEr1ZRsuVC0Asowb469lEb9PAfS
	 R7hUHSQM3HHkJkBhYxqwDf7onKUJZ3EX02IOyMd/WST6+C6xnJNsl4nimXFeuc7SaH
	 8oPI1mk78/eHRSyHWQIfR+7jLK9XIc46GcsnftGfVM7soDy+jx6aMP5bLQGYBSw4oQ
	 nzwb/f9lm5zsw==
Date: Tue, 23 Apr 2024 10:09:01 -0500
From: Rob Herring <robh@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Marek Kraus <gamiee@pine64.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, didi.debian@cknow.org,
	robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
	krzk+dt@kernel.org, heiko@sntech.de
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions
 for Pine64 boards
Message-ID: <171388492373.250779.3280449198658307048.robh@kernel.org>
References: <ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org>


On Tue, 23 Apr 2024 02:43:43 +0200, Dragan Simic wrote:
> Correct the descriptions of a few Pine64 boards and devices, according
> to their official names used on the Pine64 wiki.  This ensures consistency
> between the officially used names and the names in the source code.
> 
> Cc: Marek Kraus <gamiee@pine64.org>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
> 
> Notes:
>     This continues the description cleanup started with Radxa boards. [1]
> 
>     [1] https://lore.kernel.org/linux-rockchip/1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org/
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


