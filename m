Return-Path: <linux-kernel+bounces-151410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6A18AAE7D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342A31F21D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DA582D62;
	Fri, 19 Apr 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGoNclF2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76AE1DFC7;
	Fri, 19 Apr 2024 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713529916; cv=none; b=nPbhdOz3pf/Uh3wJs6zvpo5/JD0GgVdMiya87U1D0Fn0bXA/2FRoKkUocwLoDktpgkKQCCIFog50b3LOzi6GptbU3Dr5KT0tr4SfxzsdUROepACKBN4q+a59wg02IfCTRvnrhU0EkCdsHuefHjx0/ZEVJJYBYReLeHlmuXTTpII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713529916; c=relaxed/simple;
	bh=8ZdgU4dOJyRZx+fR46Q8AITxE+MOsZ+UI4bN5O0P0hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaw3U/reRBE9+ZjlqcGM2g9QyBd8s6h3ctguh9YpmhUYCyoqEVTxHydPkg8BFn3JVWCuRQc3iE/hOqTi6axIyxLzfnBmNwb79yxXFD/Q+6NCWZLiZ4dEiifIiFVfKHoe2ffHYPD8zDVvMPGcxR4LvfH90l7BS138yXJR0iWS5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGoNclF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92B9C2BD10;
	Fri, 19 Apr 2024 12:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713529916;
	bh=8ZdgU4dOJyRZx+fR46Q8AITxE+MOsZ+UI4bN5O0P0hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGoNclF29KkqNv7koxQfzGm+tHYtZYLAtHbL9PMCh78z/5QxGFYpLDGCXjKAf9SKH
	 RqyYdPYbktMAhs/j/ZAO3wX0EdvmKVGW66btMVE9yIngsCNaxOtVRp/HKu5QZL+vOX
	 avLS08CfIsmOEs8iUJTyLHphvao4ldZ8spHRA6DqqSqBv1uq7Orv14Mn/N7bB0CKh0
	 EIkNpdIgGloD7hdk5DYyaIw4DM5U6cx+cpuOkHJ8x7k7RZzYzZV6Ak7Afy9vpdybEL
	 USUu7IHl+EN/ZWANrmD3As3Dc1dqFH9kQGzxz9+LYzFErxnios288XTdMY9/T89J93
	 bM3doESDJ0Opw==
Date: Fri, 19 Apr 2024 13:31:51 +0100
From: Simon Horman <horms@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, hkelam@marvell.com, sbhatta@marvell.com
Subject: Re: [net-next PATCH v2] octeontx2-pf: Add ucast filter count
 configurability via devlink.
Message-ID: <20240419123151.GB3975545@kernel.org>
References: <20240418190031.1115865-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418190031.1115865-1-saikrishnag@marvell.com>

On Fri, Apr 19, 2024 at 12:30:31AM +0530, Sai Krishna wrote:
> Added a devlink param to set/modify unicast filter count. Currently
> it's hardcoded with a macro.
> 
> commands:
> 
> To get the current unicast filter count
>  # devlink dev param show pci/0002:02:00.0 name unicast_filter_count
> 
> To change/set the unicast filter count
>  # devlink dev param  set  pci/0002:02:00.0  name unicast_filter_count
>  value 5 cmode runtime
> 
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> ---
> v2:
>     - Addressed review comments given by Simon Horman
> 	1. Updated the commit message with example commads
>       2. Modified/optimized conditions

Reviewed-by: Simon Horman <horms@kernel.org>


