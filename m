Return-Path: <linux-kernel+bounces-128971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3B489626E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB77B260C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEF01946B;
	Wed,  3 Apr 2024 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldzThvtW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E19B259C;
	Wed,  3 Apr 2024 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110725; cv=none; b=QhmFOPoTaoEMs+ArM4DC+P1HsemRkxSh4TuH6JPOiGvzIOJ9jZ3ELPGfXUleEO2zumaPfJnxPTJk9KdtOPldyw6+4L4FdldKorqpgr4McsWJewevaK0pcnTFYyN7vn+SynvxKiGMRrYAN2VPZGoQhG5Rqk7e4hWBNP0qPl7dYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110725; c=relaxed/simple;
	bh=R9fYilqkrq8iygPPfkADp53ieAs4A1QmT22VdM+Kzx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NdI8dlEBE0c3Drazw3K7CQqyw9X+BEK7fS175bgNll5L/lv5baDOuYi6ASltyf8dE6IQkyiGnavtJ8PgH7NR9sH/ZQFLIjNifOhM05MwBSXbrUiu2q5GeUDmgzBk9NYUVa44795TEZp50pL8cS+cOXP3zs8zHdLJrC0I0inONuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldzThvtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46777C433F1;
	Wed,  3 Apr 2024 02:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712110724;
	bh=R9fYilqkrq8iygPPfkADp53ieAs4A1QmT22VdM+Kzx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ldzThvtWNA0erTrSs7uhEuDgTYSgBfZOqKybUyWm1XIYfMZAfKiWR42lAFxRNy/Bv
	 BvQn/gzakiVqrug9ujsyKqUbp6QZxK1ovb6Nq7+ZLf+Bj0rxRln51+iRYcNV6iY8fz
	 o7mZHaszxC5zhBo+mYDxHB40nE5Qz6bGV+4n/aR3E9AMTmrc5WLqAknrShG8wyJ+t0
	 nAW//8QRJECBqoAVa1dpfVuq7GKCPckzMgTVSxK5xbM6Kk+q+9ZH6kZ0GmOBN7xAPN
	 zDOHPyA+IRksao/mg0dD/CuKqo7LmuEHSu40ukRA+FBmNVfh4xp1E1SNgoMd98l5Cq
	 mTlHPTSY51drA==
Date: Tue, 2 Apr 2024 19:18:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, alexandre.torgue@foss.st.com, andrew@lunn.ch,
 cjubran@nvidia.com, corbet@lwn.net, davem@davemloft.net,
 dtatulea@nvidia.com, edumazet@google.com, gal@nvidia.com,
 hkallweit1@gmail.com, jacob.e.keller@intel.com, jiri@resnulli.us,
 joabreu@synopsys.com, justinstitt@google.com, kory.maincent@bootlin.com,
 leon@kernel.org, liuhangbin@gmail.com, maxime.chevallier@bootlin.com,
 pabeni@redhat.com, paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com
Subject: Re: [PATCH net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
Message-ID: <20240402191842.66decfd3@kernel.org>
In-Reply-To: <20240402205223.137565-2-rrameshbabu@nvidia.com>
References: <20240402205223.137565-1-rrameshbabu@nvidia.com>
	<20240402205223.137565-2-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Apr 2024 13:52:01 -0700 Rahul Rameshbabu wrote:
> +/**
> + * struct ethtool_ts_stats - HW timestamping statistics
> + * @tx_stats: struct group for TX HW timestamping
> + *	@pkts: Number of packets successfully timestamped by the hardware.
> + *	@lost: Number of hardware timestamping requests where the timestamping
> + *		information from the hardware never arrived for submission with
> + *		the skb.
> + *	@err: Number of arbitrary timestamp generation error events that the
> + *		hardware encountered, exclusive of @lost statistics. Cases such
> + *		as resource exhaustion, unavailability, firmware errors, and
> + *		detected illogical timestamp values not submitted with the skb
> + *		are inclusive to this counter.
> + */
> +struct ethtool_ts_stats {
> +	struct_group(tx_stats,

Doesn't seem like the group should be documented:

include/linux/ethtool.h:503: warning: Excess struct member 'tx_stats' description in 'ethtool_ts_stats'
-- 
pw-bot: cr

