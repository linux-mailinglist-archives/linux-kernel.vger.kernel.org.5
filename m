Return-Path: <linux-kernel+bounces-83774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295E7869E52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3103283908
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E89145FF9;
	Tue, 27 Feb 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="aSsY+UL1"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0334EB49;
	Tue, 27 Feb 2024 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056393; cv=none; b=jlREbiHoBGpIz/ffcZ1CCQ5Cb9/XJBbyhTqrdJw+MAg5pOSGdv1SL833Ia0qZjfJh75b1AadlPfOS102Yz0cVWRcUVSxmLcfzi8SWaf0li3nlAeOGoAVN1jgcL9Z2iSKPdBPQlIxUAnaXy8YRlznic9XJqnSNtHXsMe4wJe5mjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056393; c=relaxed/simple;
	bh=Rb707RyBtZ8AOjJcjZBAQyjM2wuexkM3XlkBOzJ0sPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqAKNXomMMuIUtx55WmsHVGMd1d9or5eToitBo7wMSZUXaVLXRR569Ps/lROT8QOCEqDLufSD3CMp8QwkZ45b2uybhAHR7Yl3IqKYVUOs7IwLWWvgbIacEeInVoPpLzGeyKbClHIY+3xcevVgauDw0YT4BUG8Xiy0H6SRycd5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=aSsY+UL1; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6C5D7214FC;
	Tue, 27 Feb 2024 18:53:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1709056388;
	bh=5XIWQjnpneGx3/sXkWCcI4KvJNW+2ALCYYk3iqBTCZE=; h=From:To:Subject;
	b=aSsY+UL1sY+G/kReBzTo41N0hOl1pTg6txi/BaJ5VoITYsIBvDNpHJqWupirYIJ0A
	 c9zFipKMC7pQk3fHLC3TBDTcyBaY+1lJ8M13a6MV/fYEE70j+av8p+flimlqgpBu+D
	 Fnqz93q2jsQtf/jT0GERLBUkXtYo3jio23PcYvghWpZZzxzGylKHUAHtlyfDgvzOUK
	 RoyeywQgIPAG1vJqUe4C6+nCqn+8le/LEwwjcp/DO11I15lATsDqpbwoKou6IVWgb9
	 ECiJkwtHoVi3+bGFoHtXD+/CXvbexnZoxvZX7JpLEmXvcH9m3qrvq00ihN7yy3eAXi
	 bI4jIvPOVV8Bg==
Date: Tue, 27 Feb 2024 18:53:06 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v8 1/2] wifi: mwifiex: add host mlme for client mode
Message-ID: <20240227175306.GB11034@francesco-nb>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
 <20231222032123.1036277-2-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222032123.1036277-2-yu-hao.lin@nxp.com>

On Fri, Dec 22, 2023 at 11:21:22AM +0800, David Lin wrote:
> Add host based MLME to enable WPA3 functionalities in client mode.
> This feature required a firmware with the corresponding V2 Key API
> support. The feature (WPA3) is currently enabled and verified only
> on IW416. Also, verified no regression with change when host MLME
> is disabled.
>
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>

Currently this do not apply cleanly on wireless-next/main git tree, it
should be rebased to that branch as v9 (the reason is your addition
of fw_ready_extra_delay from a previous, now merged, patch).

In general the patch looks good to me, however I am no expert on
wireless driver or the related linux subsystem. I just have a couple of
small comments that I would suggest address in v9 (given that you need
to do it as a minimum to rebase your code).


> ---
>  .../net/wireless/marvell/mwifiex/cfg80211.c   | 315 ++++++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/cmdevt.c |  25 ++
>  drivers/net/wireless/marvell/mwifiex/decl.h   |  22 ++
>  drivers/net/wireless/marvell/mwifiex/fw.h     |  33 ++
>  drivers/net/wireless/marvell/mwifiex/init.c   |   6 +
>  drivers/net/wireless/marvell/mwifiex/join.c   |  66 +++-
>  drivers/net/wireless/marvell/mwifiex/main.c   |  54 +++
>  drivers/net/wireless/marvell/mwifiex/main.h   |  17 +
>  drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
>  drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
>  drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
>  .../net/wireless/marvell/mwifiex/sta_event.c  |  36 +-
>  .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   3 +-
>  drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
>  drivers/net/wireless/marvell/mwifiex/util.c   |  80 +++++
>  15 files changed, 673 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index 7a15ea8072e6..3cee1b58465e 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -4202,6 +4208,302 @@ mwifiex_cfg80211_change_station(struct wiphy *wiphy, struct net_device *dev,

..

> +static int
> +mwifiex_cfg80211_probe_client(struct wiphy *wiphy,
> +			      struct net_device *dev, const u8 *peer,
> +			      u64 *cookie)
> +{
> +	return -1;

See my following comment on this

> +}
> +
>  /* station cfg80211 operations */
>  static struct cfg80211_ops mwifiex_cfg80211_ops = {
>  	.add_virtual_intf = mwifiex_add_virtual_intf,
> @@ -4347,6 +4649,16 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
>  			    "%s: creating new wiphy\n", __func__);
>  		return -ENOMEM;
>  	}
> +	if (adapter->host_mlme_enabled) {
> +		mwifiex_cfg80211_ops.auth = mwifiex_cfg80211_authenticate;
> +		mwifiex_cfg80211_ops.assoc = mwifiex_cfg80211_associate;
> +		mwifiex_cfg80211_ops.deauth = mwifiex_cfg80211_deauthenticate;
> +		mwifiex_cfg80211_ops.disassoc = mwifiex_cfg80211_disassociate;
> +		mwifiex_cfg80211_ops.disconnect = NULL;
> +		mwifiex_cfg80211_ops.connect = NULL;
> +		mwifiex_cfg80211_ops.probe_client =
> +			mwifiex_cfg80211_probe_client;

Can you omit this one? You should get `-EOPNOTSUPP` for free with probe_client
set to NULL. Am I wrong?

> +	}
>  	wiphy->max_scan_ssids = MWIFIEX_MAX_SSID_LIST_LENGTH;
>  	wiphy->max_scan_ie_len = MWIFIEX_MAX_VSIE_LEN;
>  	wiphy->mgmt_stypes = mwifiex_mgmt_stypes;

..

> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> index a2ad2b53f016..23639aacf092 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> @@ -136,6 +136,7 @@ int mwifiex_fill_new_bss_desc(struct mwifiex_private *priv,
>  	const struct cfg80211_bss_ies *ies;
>  
>  	rcu_read_lock();
> +	bss_desc->bss = bss;
what is this change for? I was not able to understand it, nor to find
any user of this bss parameter. This looks like an unrelated fix, but no
code seems to be affected.


With these 2 comments addressed, please feel free to add to v9

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


And thanks for this work!
Francesco

