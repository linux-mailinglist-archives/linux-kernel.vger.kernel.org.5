Return-Path: <linux-kernel+bounces-85190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E5386B1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBAB2895E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCD215A4AE;
	Wed, 28 Feb 2024 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+du1MYx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567312E1DD;
	Wed, 28 Feb 2024 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130860; cv=none; b=ptB9jsW1gfOkUyTFTJEFPO79doofijR4ckUO5+t4AswpqgufKtn+ZkkaQFbDsJ+qGVlRoTlWSQvTI8zDGpWAUcbPWpVFEaAaxunLxuQ//EWWS5lBcZ5R9vzQ2bHrz80VuBf8G3zA8YlAlt6dMYHMjl6ZyptF6/Y99gimzyQ3l+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130860; c=relaxed/simple;
	bh=SohApJ8J7//9aXWrTz6SAXiRplz8+1lqaQMKmo/qSTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgYWYjLCEonbDeSkqtPAiH3jI4Z6EG5+gOABm3c12kSvMnJ7rGbYWTu898ZA0mdiiTFbHvZStYk0WrdC5nlathDj5xaCEB3ywRXAe40LL7d4XbZ2RxLC24hpNMIJ1UvcPUOoAY9OXpKonpCY2fKFj8hivhweo+n6ZUUOwg8hX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+du1MYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1766AC433F1;
	Wed, 28 Feb 2024 14:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709130859;
	bh=SohApJ8J7//9aXWrTz6SAXiRplz8+1lqaQMKmo/qSTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+du1MYxHQMnDNJs/xhw9UfuaPmjKnuSo+wJy0m5sp1aLu9KdfLge/BMZwJtECfdZ
	 fwaZD3vuCLwOW2WGCQFfvJzqFPfG/vZDaJVmS+xQPggxiLiOy4cZWWYx1MpBPb3LfW
	 9kFNWrMEOOdfGOPiX8I6w1uVuA2P0g/+XF/USGiRp4dR3ERIs9FzlFsWgjnIbQwwMc
	 YcIpcCfI+ZZGxAF20ch4JjhAff8u+RjCmB1Td6BtckzuvENtQYt1q3Y+/N9te2QjcU
	 IBf4ju4OWsW9mUDhA2r9oifgdcKpKw23J5bYc1K7NxaqilCaVk37g+/Utfm9ELupR9
	 miagPLEMIIfWA==
Date: Wed, 28 Feb 2024 14:34:16 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: sit: Do not set .ndo_get_stats64
Message-ID: <20240228143416.GH292522@kernel.org>
References: <20240228113125.3473685-1-leitao@debian.org>
 <20240228113125.3473685-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228113125.3473685-3-leitao@debian.org>

On Wed, Feb 28, 2024 at 03:31:22AM -0800, Breno Leitao wrote:
> If the driver is using the network core allocation mechanism, by setting
> NETDEV_PCPU_STAT_TSTATS, as this driver is, then, it doesn't need to set
> the dev_get_tstats64() generic .ndo_get_stats64 function pointer. Since
> the network core calls it automatically, and .ndo_get_stats64 should
> only be set if the driver needs special treatment.
> 
> This simplifies the driver, since all the generic statistics is now
> handled by core.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


