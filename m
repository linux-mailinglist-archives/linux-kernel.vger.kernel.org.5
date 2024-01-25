Return-Path: <linux-kernel+bounces-37969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995C883B8F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBEAD1C23AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BFA8832;
	Thu, 25 Jan 2024 05:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEgYy0Fe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CCC10971;
	Thu, 25 Jan 2024 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706159681; cv=none; b=RWlAnkGFFdxzfjjAplaMkGEjNUFl00MPAzAM+b4LUTuaRbkczPXx4GrHJgDWRMFF43F9NB9h2AfQbhOz7JIM2+Nn3Sz6eBF7ooJy9s6WbWuJ6zsIK7XnoDRgyqxaNAXeJqZq36AbjS/jz+6AgpuSDvi2R7eFc9QXwV46WodQoXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706159681; c=relaxed/simple;
	bh=Yn70t2s1fUq9MYJq0J8Q39cfckyZ4xFAxacYTMcniwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6msOmbp1qfj38fNXWm2+sfGe82VEuT2UR7I5JiBDQoW6Fz3lWRvHVE3NgXJMBXj2oE/jgD9j/5ycZDyBHMDYISO3LBzLrYMDO376HkeQttdUxRIxbNDfJbfV5FqaoEW7TI3ERaSTSlyZfO3O1tRfKFtF/YpDxzk+sj9uJk8ENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEgYy0Fe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAF8C433F1;
	Thu, 25 Jan 2024 05:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706159680;
	bh=Yn70t2s1fUq9MYJq0J8Q39cfckyZ4xFAxacYTMcniwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GEgYy0Fehn+BGRy8yMjXTDWbG3IdSKwBi9k0vp90tA1984LZGhKm6zPLr/ONO13rj
	 Jx2S9EYpDQp6gwQXDiQ8CJzovqHExsJRFaNX4jnE94bwMs0T6lHWY2bl6Gtbjbc/MB
	 Jt0A8zFNruT0E1T/CvodWcnnSAw5Ml8jTthT8+9fojq2y8otF1vf8HYlwqBFq2ogYE
	 SKwGwWpBK0HOwJ/pV2pOjTyEBP8VDrQU3AMkZHB/zD+dKuv8lkEGZhFD/FDpVLI1rk
	 g0g+ZljOAVQhU9T7Na4r/DqWsPn7kwwVY3m0zxKCAC9cTRGDq/EJlHsJMSeDUn9vzK
	 AxldPiu2xcF5Q==
Date: Wed, 24 Jan 2024 21:14:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, leitao@debian.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/8] net: netconsole: move netconsole_target
 config_item to config_group
Message-ID: <20240124211439.16db3c7b@kernel.org>
In-Reply-To: <20240124174711.1906102-3-thepacketgeek@gmail.com>
References: <20240124174711.1906102-1-thepacketgeek@gmail.com>
	<20240124174711.1906102-3-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 09:47:00 -0800 Matthew Wood wrote:
>  #ifdef	CONFIG_NETCONSOLE_DYNAMIC
> -	struct config_item	item;
> +	struct config_group	group;

drivers/net/netconsole.c:111: warning: Function parameter or struct member 'group' not described in 'netconsole_target'
drivers/net/netconsole.c:111: warning: Excess struct member 'item' description in 'netconsole_target'

kdoc needs fixing?
-- 
pw-bot: cr

