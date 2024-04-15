Return-Path: <linux-kernel+bounces-145371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2378A5494
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 916AAB232BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A2B85299;
	Mon, 15 Apr 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2/G+bLZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D3985272;
	Mon, 15 Apr 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191715; cv=none; b=CnsWGTMXD8xYib7zPkzT94r1lPRzv0QLaynJheCsxGT9q6HKzgFNYj+cUZIr5NjuBNqOwjPSyOgDj4sfABz2W+pvnzEolfU8uZnKIheYorbima1TArwKSusZVRDiVER/lsUhX2xUkYB004N2ly80WEEhob02X+nHmO0fosSnQA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191715; c=relaxed/simple;
	bh=/jO3xeS3d6mz8Phfjr7AEsNU828+kA/Fh6Ug4w2fpxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl7vg09ZRS8tpXDLyj0PQ53PgtuRHYVXq5+iA6zAB5zrjP3NSCf9JyPfwHdVqm2obddPvvWT0N7hNzzAuAHdvCaEVBAkmjLUwmk8laUzeA4uI3Ot/7YDU17t1HOxhf32PHvpy3AlycSR//jepOkIBC/5L5Z51plDv4Odn5odizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2/G+bLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45EDC113CC;
	Mon, 15 Apr 2024 14:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713191715;
	bh=/jO3xeS3d6mz8Phfjr7AEsNU828+kA/Fh6Ug4w2fpxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2/G+bLZdidkc3uheiGUFyNmZniI2kIAEB44yETKMd+2vIVSzS6SMcY4M0ILk3gGA
	 nElcmLaObWV7tP9U/4br/vWmIDJicMYh52cq1/FbJup0bS9G4sFdeWXmVWZOARGz7B
	 oJHGfQHpL0XydsCvDJTmuTMQVjdwqIWgTu5o2iKdH/lzzeVOq7hlQn4xK1ioKn5uMD
	 MUPoBcrOZGrPAleemN84lBHUr1ipqCE9k+0HXneVD1rIEKN2u+oK5geKYA5wyNVomZ
	 6BLmBPu1ClGWmw0Qaq5bUJ0det0yzx/1D1huNeaOasPzSw+mDqx0rq0chtstbU/2N1
	 3Ja1WStfI452w==
Date: Mon, 15 Apr 2024 15:35:10 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew@lunn.ch>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 5/7] netdev_features: convert
 NETIF_F_HIGHDMA to priv_flag IFF_HIGHDMA
Message-ID: <20240415143510.GA3545293@kernel.org>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
 <20240405133731.1010128-6-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405133731.1010128-6-aleksander.lobakin@intel.com>

On Fri, Apr 05, 2024 at 03:37:29PM +0200, Alexander Lobakin wrote:
> The ability to send bufferst from the high memory is rather an
> attribute, not a feature. It can't be toggled via Ethtool and
> is constant for the whole interface lifetime.
> Convert it to a private flag, carrying necessary inheritance for
> lower interfaces.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

..

> index f57c29de3a91..78e749f6b91f 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -3007,6 +3007,7 @@ struct ieee80211_hw {
>  		s16 accuracy;
>  	} radiotap_timestamp;
>  	netdev_features_t netdev_features;
> +	u64 netdev_priv_flags;
>  	u8 uapsd_queues;
>  	u8 uapsd_max_sp_len;
>  	u8 max_nan_de_entries;

nit: please add netdev_features to the kernel-doc for struct ieee80211_hw.

Flagged by ./scripts/kernel-doc -none

..

