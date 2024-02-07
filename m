Return-Path: <linux-kernel+bounces-56232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AF284C7A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF33B1F2A207
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3BB2D05E;
	Wed,  7 Feb 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox5XuzKz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59C25561;
	Wed,  7 Feb 2024 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298629; cv=none; b=TWt9aqjCxX/kP0dxH0CPpK5frcie3ok+V2C5L5Z1PbU1GKgcsCOM08xMrabFKTVDWypF0y5qEu/wBrt8jT9c2MZiT28BHnitFfeSJQnpGPvhPQGrSqkqtCDPTANOBVMC4hRhuCcAV1Nbzl8c6IOKuAbJ8nLifgBwWPvWqhtHt+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298629; c=relaxed/simple;
	bh=KM9VVhUu3n6Y8+Wp9Oq/XK60AfRXvTcVf3WAzkzI5bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix+b0tHAY7lvXYlXxK4JYAUjn81AjPgJamQ7Bd0YEoVRa9G9h/4S8jSaM63XnEhScLxpvGjquDT7XgkT18RCgGBs22dp4qEupGK0mbiJxXuTm0UGAkj1hUA7VEx11PU2Xdh3rIRQNlH67dXZPz+vjCOIgG/N/km3IyurGy4ecpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox5XuzKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C2AC433F1;
	Wed,  7 Feb 2024 09:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707298629;
	bh=KM9VVhUu3n6Y8+Wp9Oq/XK60AfRXvTcVf3WAzkzI5bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ox5XuzKzEyFpGHcbEXI202egudLTg0NckkYYcL7Ux1WFWvd+M01p4afH5qkbDO70m
	 8ytGe2X29f6kgUG0B0YrGKgV1XfrtfZF9qX/8KPgqqkd3obEz3Sgxd8uJh18nZgt9b
	 WtxvoTglCoXgCA0QxAAVDG18ztv2vsMwtAtOwQjR1/figVOZNbHywqR0fJhaTgcDHC
	 Jm6AaozES0bHB/GxIC1OnmvtR5NZg4rb4W3ib5muMdYAb/0i5dtlZV7NJNo4J3SVl5
	 pKrVedXKsJ1UB4Ys3GaF3jV6hEH3UE0aRxvi6iwaQ0AYYr9hvH5zk2FyxPY+VUkenL
	 UT64uAxJkIlgg==
Date: Wed, 7 Feb 2024 09:37:05 +0000
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] xirc2ps_cs: remove redundant assignment to
 variable okay, clean up freespace
Message-ID: <20240207093705.GL1104779@kernel.org>
References: <20240205213643.1850420-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205213643.1850420-1-colin.i.king@gmail.com>

On Mon, Feb 05, 2024 at 09:36:43PM +0000, Colin Ian King wrote:
> The variable okay is being initialized with a value that is never
> read, it is being re-assigned later on. The initialization is
> redundant and can be removed.  Also clean up assignment to
> variable freespace using an assignment and mask operation.
> 
> Cleans up clang scan build warning:
> drivers/net/ethernet/xircom/xirc2ps_cs.c:1244:5: warning: Value stored
> to 'okay' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

