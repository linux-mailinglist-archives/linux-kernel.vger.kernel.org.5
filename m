Return-Path: <linux-kernel+bounces-57312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854CC84D6E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B776C1C2274E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6932C12E55;
	Thu,  8 Feb 2024 00:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AWYPE2gP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8F4C70;
	Thu,  8 Feb 2024 00:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707350684; cv=none; b=VQE4SbOBZvz6BlwvUmp3muWcQKikyBv3v1k6fGbd4sI7sCd4BWLkr5wx3iwsfTAI8JrBhn609IbcmzhGFdBw+9QmLEGo0qptKqGiYY9J97by7D83s9ViffRN61VmoP96k8NsMFqAaqQE+s7z5LwjDqxrYG8BzkO6TeS+Ycz80vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707350684; c=relaxed/simple;
	bh=rUuhQxO5hijHzVr31s2tQ1oM73M+cCIiWMvwpUFCVWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZbo63Pn+Tl9gAJRcXqydFU0K3qSvVxCigmdv2qQi25Z3Wxs1jrqwDZA2nCGZbjZYMB6fu63jw210sDaS5ikDpz/yBk4A0rG/DRiXrDtlMV/uB2pM4Rr2qdjxbY2Bmx2LG6n8Jydjkja6fg1CJe315AvRNphS5uFsKJEza8ijU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AWYPE2gP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tZeUAfa9RbjQgBECn/qu6rSKPyPLTMOJXAfT7Ol4Lo4=; b=AWYPE2gPECpdOo0HyywKFwofzn
	7PoFX+CsN0BmAngxv/WIWboVxZAQenabvsk0nx+9g+wHSUx1VUkvkhaCvA4U/skO4rNSqwGl47Rrr
	KVvDDkChL4QzheXD33QbNXIznetLqWf7ofbM80MxFA3s6m6N6nqTCOwFrBnzLe3Glz6E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXru6-007GKM-J4; Thu, 08 Feb 2024 01:04:34 +0100
Date: Thu, 8 Feb 2024 01:04:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jon Maxwell <jmaxwell37@gmail.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next] intel: make module parameters readable in sys
 filesystem
Message-ID: <36a95b38-99c5-4fda-b9bf-8b9fb3b67e1c@lunn.ch>
References: <20240207230430.82801-1-jmaxwell37@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207230430.82801-1-jmaxwell37@gmail.com>

On Thu, Feb 08, 2024 at 10:04:30AM +1100, Jon Maxwell wrote:
> Linux users sometimes need an easy way to check current values of module
> parameters. For example the module may be manually reloaded with different
> parameters. Make these visible and readable in the /sys filesystem to allow
> that.
> 
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
> ---
>  drivers/net/ethernet/intel/e100.c                 | 6 +++---
>  drivers/net/ethernet/intel/e1000/e1000_main.c     | 2 +-
>  drivers/net/ethernet/intel/e1000e/netdev.c        | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c       | 2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c         | 4 ++--
>  drivers/net/ethernet/intel/igbvf/netdev.c         | 2 +-
>  drivers/net/ethernet/intel/igc/igc_main.c         | 2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 6 +++---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
>  9 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
> index 01f0f12035caeb7ca1657387538fcebf5c608322..2d879579fc888abda880e7105304941db5d4e263 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -170,9 +170,9 @@ MODULE_FIRMWARE(FIRMWARE_D102E);
>  static int debug = 3;
>  static int eeprom_bad_csum_allow = 0;
>  static int use_io = 0;
> -module_param(debug, int, 0);
> -module_param(eeprom_bad_csum_allow, int, 0);
> -module_param(use_io, int, 0);
> +module_param(debug, int, 0444);

ethtool should show you debug. And it is pretty much standardized, it
should work for most ethernet interfaces which support msglvl. So i
would say it is better to teach your Linux users how to use ethtool
for this.

There might be some value in this change for module parameters which
are not standardised, but i suggest you drop debug from the patchset.

    Andrew

