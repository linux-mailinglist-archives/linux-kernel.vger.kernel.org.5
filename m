Return-Path: <linux-kernel+bounces-100068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2692879160
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8251C2206C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048E979B90;
	Tue, 12 Mar 2024 09:49:10 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583778662;
	Tue, 12 Mar 2024 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236949; cv=none; b=Rtm8MPDJmfW07gq3mux8+iZuretpjyvuGlwsEat4Q7pcDnuuMW8P1FXT//4Kwf3e9OBNhgUpFCUR54UStfG79BDiUGfytytubc4LRWzy5MosWRKE3ZrkGS3AGmyrvcvAd4V+W271m9qu9jAPkOTSuUSKe5NBjSnQkvcP88wtmsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236949; c=relaxed/simple;
	bh=WP4DY2eQ60OFoSajZjswjdTowx4ulBVDMnVbWSofK3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIdfmXqC9go76fZKvsUibOFSMpaSR0RZZsAYvlvVDYOJhW4AChxS89SH9UwOQgMkbFksnK2hdi8I8wn8HfPjxu35IEsY5G3lBAIRmG+pk3VC0IBQGMIbdr0qA7XUJ/rFhUJWAjXPnaw+9TAI38iPK93fMeaHBvxCnSdZZYt8ZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CAA1261E5FE36;
	Tue, 12 Mar 2024 10:48:20 +0100 (CET)
Message-ID: <fd37860e-306f-42bf-9a1d-e4d98ddf338c@molgen.mpg.de>
Date: Tue, 12 Mar 2024 10:48:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v3] i40e: Prevent setting MTU if greater
 than MFS
Content-Language: en-US
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: Erwan Velu <e.velu@criteo.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20240312094259.770554-1-e.velu@criteo.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240312094259.770554-1-e.velu@criteo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Erwan,


Thank you very umch for your patch.

Am 12.03.24 um 10:42 schrieb Erwan Velu:
> Commit 6871a7de705b6f6a4046f0d19da9bcd689c3bc8e from iPXE project is
> setting the MFS to 0x600 = 1536.

Please add a link, as most people do not have the iPXE archive checked 
out. Maybe also add the commit message summary.

> At boot time the i40e driver complains about it with
> the following message but continues.
> 
> 	MFS for port 1 has been set below the default: 600

Hmm, but 1536 > 600. So the log message is incorrect?

> If the MTU size is increased, the driver accept it but large packets will not

accept*s*

> be processed by the firmware generating tx_errors. The issue is pretty
> silent for users. i.e doing TCP in such context will generates lots of
> retransmissions until the proper window size (below 1500) will be used.
> 
> To fix this case, it would have been ideal to increase the MFS,
> via i40e_aqc_opc_set_mac_config, incoming patch will take care of it.
> 
> At least, this commit prevents setting up an MTU greater than the current MFS.
> It will avoid being in the position of having an MTU set to 9000 on the
> netdev with a firmware refusing packets larger than 1536.

Maybe add the new log message.

One last formal nit: Please use a line length limit of 75 characters per 
line.

> Signed-off-by: Erwan Velu <e.velu@criteo.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 89a3401d20ab..225b2fd0449e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -2950,7 +2950,7 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
>   	struct i40e_netdev_priv *np = netdev_priv(netdev);
>   	struct i40e_vsi *vsi = np->vsi;
>   	struct i40e_pf *pf = vsi->back;
> -	int frame_size;
> +	int frame_size, mfs, max_mtu;
>   
>   	frame_size = i40e_max_vsi_frame_size(vsi, vsi->xdp_prog);
>   	if (new_mtu > frame_size - I40E_PACKET_HDR_PAD) {
> @@ -2959,6 +2959,14 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
>   		return -EINVAL;
>   	}
>   
> +	mfs = pf->hw.phy.link_info.max_frame_size;
> +	max_mtu = mfs - I40E_PACKET_HDR_PAD;
> +	if (new_mtu > max_mtu) {
> +		netdev_err(netdev, "Error changing mtu to %d, Max is %d. MFS is too small.\n",
> +			   new_mtu, max_mtu);

The other log messages capitalize MTU.

> +		return -EINVAL;
> +	}
> +
>   	netdev_dbg(netdev, "changing MTU from %d to %d\n",
>   		   netdev->mtu, new_mtu);
>   	netdev->mtu = new_mtu;


The rest looks reasonable.


Kind regards,

Paul

