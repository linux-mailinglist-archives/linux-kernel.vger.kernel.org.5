Return-Path: <linux-kernel+bounces-103748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6B487C3EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A8BB23171
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC23F7603A;
	Thu, 14 Mar 2024 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx6FUSzO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24DF2BB13;
	Thu, 14 Mar 2024 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446679; cv=none; b=gfXuJqSF4m1ic20F35TpUv82wwhoMlR66rZTMM4RdTX+Y8L+j/8lsxwUZOy+jA4/Iscb9fI4jCaGY2AyJD9q1POPNbtGO+VrpUuCdHUMVP3iov9DHUZ5wl9Wq8KLKR08eAnOk874dB/wodPn1UQM9GT02T8L1yI88DOcuqvPBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446679; c=relaxed/simple;
	bh=6+H3BNBg7goP41I6XpJRXHjoIZj+IWMhxTJDdpJKB2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNIYzf4aAJxgZ1wSQvw3/Q0/+alWxb2DXKhK1rFiNTv5DMPXJK/9GSSBOibgnf2Zm4IyukAf4ZL9StrlwPttLvFn2esOP2i/WKXZFfAercjPi//HR9qLLC4lfzPSmgo5l7L++G/KVmX+0h9EsFB04ZfaQYuPRg7nk5mrpCmXJ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx6FUSzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A574C433F1;
	Thu, 14 Mar 2024 20:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710446678;
	bh=6+H3BNBg7goP41I6XpJRXHjoIZj+IWMhxTJDdpJKB2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yx6FUSzOlAskw3Vkd5I52H7snaL2XmmkpIcuD9W9M8ivz2Qyuj3b9bYZ3MMaqEh5/
	 1FUDnqtEDJtdB4GHUzs1QB+zyAV5vPaDNNCbp0ZSnDZQ7xt1JnUOJ0u8tZvugwp5Re
	 bjW/8vl5qS+zsSLGDFw1zX6vE7667w8B63XLLeE32gkc9R6OyTeGInLswLaDjPCDHR
	 MDexE1+hFI1t6+1PYOx4Wm88nS/HhsgjG36t7V/tKNZ2CIVqe17hFpCuwSC6xbtQJG
	 bdmaSf7ok3u5n0mT3lp1k/X8r99ipiVkYNXSZIXUc/C3KoIcCHupke1YwVFnV0cdAO
	 ZDUVDNln0blhA==
Date: Thu, 14 Mar 2024 13:04:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 alexandre.torgue@foss.st.com, andrew@lunn.ch, corbet@lwn.net,
 davem@davemloft.net, dtatulea@nvidia.com, edumazet@google.com,
 gal@nvidia.com, hkallweit1@gmail.com, jacob.e.keller@intel.com,
 jiri@resnulli.us, joabreu@synopsys.com, justinstitt@google.com,
 kory.maincent@bootlin.com, leon@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuhangbin@gmail.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com,
 paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com
Subject: Re: [PATCH RFC v2 6/6] tools: ynl: ethtool.py: Output timestamping
 statistics from tsinfo-get operation
Message-ID: <20240314130436.1052c739@kernel.org>
In-Reply-To: <20240313174707.38a71c84@kernel.org>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-7-rrameshbabu@nvidia.com>
	<20240312165544.75ced7e1@kernel.org>
	<87plvxbqwy.fsf@nvidia.com>
	<20240313174707.38a71c84@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 17:47:07 -0700 Jakub Kicinski wrote:
> +  -
> +    name: header-flags
> +    type: flags
> +    entries: [ compact-bitset, omit-reply, stats ]

Ah. Throw in an empty:

	enum-name:

into this, or change the uAPI so that an enum called
ethtool_header_flags actually exists :)

Otherwise make -C tools/net/ynl will break

