Return-Path: <linux-kernel+bounces-108841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0668810C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DF21C220BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCB73D3AC;
	Wed, 20 Mar 2024 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyN1zphy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD11171D;
	Wed, 20 Mar 2024 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933571; cv=none; b=RS+bXQaNLkcVhp35pVDR32YMoLt3xVSj0EKUDQowIvjXnZIgo5+vjsaBXTTAppI5qOCE5+XIfpOQahFTrVoCaeZv0WHV0B/x+DC/IIY8O/93r1FW0HqSoj4+0VnHZ9hKGYqz7KV7h9dN8/DgnAvEDeoTR4hI8pnPm5wFumu6LsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933571; c=relaxed/simple;
	bh=ZGjdmKze+W8MptFXyZLv1/NCN4+JrhWDnVc972JzEF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBIhr6YHwXHeSLGOjWzxZo5EgckS/Xbbzyb7SxIiaqajK/9ZHDtIIQC7l8B1vPbqSCcCD8PF3l01YfZ9Cupe/2FbUEsY9ufBaDdpeZftgURJixJZ4pNjRiWu92MLBPPgS0Emwldf2EkpGX0HFcmkbFKCDV3aQ+gcFvRsqGyaulY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyN1zphy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCF9C433C7;
	Wed, 20 Mar 2024 11:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710933570;
	bh=ZGjdmKze+W8MptFXyZLv1/NCN4+JrhWDnVc972JzEF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyN1zphyJpnuHnDx7UpdrrSMXLAs8FwjMy2i14ohff6IKAt3jk1kD8DQw1aWs60J+
	 X0lDM0yCzd7FRs21GUXslXmcDacFrUGk3IEXB9hYyuYdBgDd0lipaVEfv5jycSape/
	 iD/V9tMzSENbTM2tUTL+7VsAiwbN/QvYW3rhiIdPhR7vdy/DAQ6JAybzhJYXoOJ2TG
	 r3uDzb0cYcbrbVBzhmJlOYOuTylN9j0N2aYJpnnDNnUTnrz1NqunH3vBwm2cVFnL9a
	 W9tCJPpU7YaIE3LImFQ++UjFmgZTfl8bjcM4UxQb1cAaJ4XJJXwPfNpizq77QT+8xq
	 O4WTAkzZvulJA==
Date: Wed, 20 Mar 2024 11:19:26 +0000
From: Simon Horman <horms@kernel.org>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: Erwan Velu <e.velu@criteo.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] i40e: Report MFS in decimal base instead of hex
Message-ID: <20240320111926.GR185808@kernel.org>
References: <20240319141657.2783609-1-e.velu@criteo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319141657.2783609-1-e.velu@criteo.com>

On Tue, Mar 19, 2024 at 03:16:55PM +0100, Erwan Velu wrote:
> If the MFS is set below the default (0x2600), a warning message is
> reported like the following :
> 
> 	MFS for port 1 has been set below the default: 600
> 
> This message is a bit confusing as the number shown here (600) is in
> fact an hexa number: 0x600 = 1536
> 
> Without any explicit "0x" prefix, this message is read like the MFS is
> set to 600 bytes.
> 
> MFS, as per MTUs, are usually expressed in decimal base.
> 
> This commit reports both current and default MFS values in decimal
> so it's less confusing for end-users.
> 
> A typical warning message looks like the following :
> 
> 	MFS for port 1 (1536) has been set below the default (9728)
> 

Hi Erwan,

If this is for (iwl-)net, then it should probably have a Fixes tag.
I expect it is sufficient to respond to this email with an appropriate tag.

> Signed-off-by: Erwan Velu <e.velu@criteo.com>

That not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

..

