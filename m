Return-Path: <linux-kernel+bounces-73371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112BD85C193
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E1FB23AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B476A76419;
	Tue, 20 Feb 2024 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBTT/r9V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013FB2599;
	Tue, 20 Feb 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447128; cv=none; b=L4jYjWrPN/Bhq08Z0Mmm7byKmFurL52CS/3BtAkEjsuLxl7wxa1Bym+nHJKdQHuXhW/oZesmCI29So8UAhC0Ei1fYWkzRpLB9WTlAWGCfLZXleFC1pA3h2sRiLHxh2Ax9TirpDkMgJKQb791ZnKwVhOGzGf8LiJWSnaeYglw0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447128; c=relaxed/simple;
	bh=5aPE0BvOdwD4Bb/bhUey8hHCmmCt1SJb76EzNNWyfDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeeVdQeyXAzwvCbVxtdSng+2O5X8kLh4O/4ReFLyrzT8N2X2BY1hW66Ocm4gzmqb5SbL4CjtDPkK0dGpIsOSsLqZIAIpug34v10vjJfJj7fRHKNfrj1iGC4MNEMGcmiPdS8f48Ce0RGHmRy1jojTLLHCezsMI9V/m8bGWK1IiZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBTT/r9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFF7C433F1;
	Tue, 20 Feb 2024 16:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708447127;
	bh=5aPE0BvOdwD4Bb/bhUey8hHCmmCt1SJb76EzNNWyfDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBTT/r9VDE54ymXpwINC0y8csNWpFi6oM/rwfDa+0RCltKbHt4MXlLZo1sAVflom5
	 VO7+SAssV+w/VY5nDFrQIeqo+zUlpgzDprkyxYOC3JV18wSn5hzaX+GJqdwYf4Yy/e
	 Rb5ZKxQN6w81j95Dq+PTMY6nmybWFRsjY8KVAu3L5UMhTetJYbyMyNyu4EAR1rRZTj
	 TASS5oLQZvv7T5ze6LYSF0jwIptUpCSNl6PnWvOwMKAFnrZOEfGlqwW+fWg5bzSR+o
	 zyE7kDXFoNZ5g1yaz3LzVFWjxozoCHYAWv2Ci7R5XRvUihmXinLcR9uokSP0EhPhXT
	 8viUj4yhTaECA==
Date: Tue, 20 Feb 2024 09:38:45 -0700
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: Add missing prefixes used
 in compatibles
Message-ID: <20240220163845.GA3606739-robh@kernel.org>
References: <20240216025839.902288-1-robh@kernel.org>
 <20240216-percolate-wooing-b5e4f6814d15@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-percolate-wooing-b5e4f6814d15@wendy>

On Fri, Feb 16, 2024 at 08:59:56AM +0000, Conor Dooley wrote:
> On Thu, Feb 15, 2024 at 08:58:29PM -0600, Rob Herring wrote:
> > +  "^calao,.*":
> > +    description: CALAO Systems SAS
> >    "^calaosystems,.*":
> >      description: CALAO Systems SAS
> 
> > +  "^IBM,.*":
> > +    description: International Business Machines (IBM)
> >    "^ibm,.*":
> >      description: International Business Machines (IBM)
> 
> These ones add duplicates with no indication of which one is to be used
> going forward. Why not mark one as deprecated?

Because I couldn't decide which... It's a mixture with no clear pattern 
of on what or when each one is used. Power is kind of special.

Rob

