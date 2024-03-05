Return-Path: <linux-kernel+bounces-92615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9BC8722ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA7A1C22130
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4925127B53;
	Tue,  5 Mar 2024 15:36:50 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806731272B7;
	Tue,  5 Mar 2024 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653010; cv=none; b=EIXfI5eiMjysOjr2eLxnwEi2OW6SejEhKE+pyOft8L14J/+v+y/4+7iAS1sGaxCKh6hmzhrPDexre+02d4fn0u4QIw8MI2VnGrb0/dti/DVuadH6rFQMfjR9SIiPQjZ4kG7SMamXQWjZTR4gvXE4kBxH1btrbgkqul1fitGMn1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653010; c=relaxed/simple;
	bh=aPbFheI9M3TElH4HfEMIXBUx9AN8rebgLs/CmEGBGNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNWCp7zwbMtR6y5RQbr4yTlcP5162ELDrniHcBa33yuTOBdvhvcdZgmsXc8qGku6qXfC5C/G4jIzuqsiSRdPx3umWiBb7PiEuYvaaRv+21R3gRmebt1HYvgqJ1GyVANQcYnBnQJxXUQtcrYzs+wewFa/ojf4fZl1eqfhnX2RnwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D6E2A61E5FE38;
	Tue,  5 Mar 2024 16:35:48 +0100 (CET)
Message-ID: <14cf3adb-7915-424e-b5ad-2c100cec183e@molgen.mpg.de>
Date: Tue, 5 Mar 2024 16:35:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ice: Add get/set hw address for VFs using devlink
 commands
Content-Language: en-US
To: Karthik Sundaravel <ksundara@redhat.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jiri@resnulli.us,
 michal.swiatkowski@linux.intel.com, rjarry@redhat.com, aharivel@redhat.com,
 vchundur@redhat.com, cfontain@redhat.com
References: <20240305152641.53489-1-ksundara@redhat.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240305152641.53489-1-ksundara@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Karthik,


Thank you for your patch.

Am 05.03.24 um 16:26 schrieb Karthik Sundaravel:
> Changing the MAC address of the VFs are not available

Maybe:

… is currently unsupported …

or

… is currently impossible …

> via devlink. Add the function handlers to set and get
> the HW address for the VFs.

This fits into two lines (with a line length of 75 characters)

> Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
> ---

Could you please add a change-log for each patch iteration?

>   drivers/net/ethernet/intel/ice/ice_devlink.c | 78 +++++++++++++++++++-
>   drivers/net/ethernet/intel/ice/ice_sriov.c   | 62 ++++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_sriov.h   |  8 ++
>   3 files changed, 147 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
> index 80dc5445b50d..39d4d79ac731 100644
> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> @@ -1576,6 +1576,81 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
>   	devlink_port_unregister(&pf->devlink_port);
>   }
>   
> +/**
> + * ice_devlink_port_get_vf_fn_mac - .port_fn_hw_addr_get devlink handler
> + * @port: devlink port structure
> + * @hw_addr: MAC address of the port
> + * @hw_addr_len: length of MAC address
> + * @extack: extended netdev ack structure
> + *
> + * Callback for the devlink .port_fn_hw_addr_get operation
> + * Return: zero on success or an error code on failure.
> + */
> +
> +static int ice_devlink_port_get_vf_fn_mac(struct devlink_port *port,
> +					  u8 *hw_addr, int *hw_addr_len,
> +					  struct netlink_ext_ack *extack)
> +{
> +	struct devlink_port_attrs *attrs = &port->attrs;
> +	struct devlink_port_pci_vf_attrs *pci_vf;
> +	struct devlink *devlink = port->devlink;
> +	struct ice_pf *pf;
> +	struct ice_vf *vf;
> +	int vf_id;

The signature of `ice_get_vf_by_id()` uses u16 as type.

> +
> +	pf = devlink_priv(devlink);
> +	pci_vf = &attrs->pci_vf;
> +	vf_id = pci_vf->vf;
> +
> +	vf = ice_get_vf_by_id(pf, vf_id);
> +	if (!vf) {
> +		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf");

Maybe also add the vf_id to theh error message?

> +		return -EINVAL;
> +	}
> +	ether_addr_copy(hw_addr, vf->dev_lan_addr);
> +	*hw_addr_len = ETH_ALEN;
> +
> +	ice_put_vf(vf);
> +	return 0;
> +}
> +
> +/**
> + * ice_devlink_port_set_vf_fn_mac - .port_fn_hw_addr_set devlink handler
> + * @port: devlink port structure
> + * @hw_addr: MAC address of the port
> + * @hw_addr_len: length of MAC address
> + * @extack: extended netdev ack structure
> + *
> + * Callback for the devlink .port_fn_hw_addr_set operation
> + * Return: zero on success or an error code on failure.
> + */
> +static int ice_devlink_port_set_vf_fn_mac(struct devlink_port *port,
> +					  const u8 *hw_addr,
> +					  int hw_addr_len,
> +					  struct netlink_ext_ack *extack)
> +
> +{
> +	struct devlink_port_attrs *attrs = &port->attrs;
> +	struct devlink_port_pci_vf_attrs *pci_vf;
> +	struct devlink *devlink = port->devlink;
> +	struct ice_pf *pf;
> +	u8 mac[ETH_ALEN];
> +	int vf_id;
> +
> +	pf = devlink_priv(devlink);
> +	pci_vf = &attrs->pci_vf;
> +	vf_id = pci_vf->vf;
> +
> +	ether_addr_copy(mac, hw_addr);
> +
> +	return ice_set_vf_fn_mac(pf, vf_id, mac);
> +}
> +
> +static const struct devlink_port_ops ice_devlink_vf_port_ops = {
> +	.port_fn_hw_addr_get = ice_devlink_port_get_vf_fn_mac,
> +	.port_fn_hw_addr_set = ice_devlink_port_set_vf_fn_mac,
> +};
> +
>   /**
>    * ice_devlink_create_vf_port - Create a devlink port for this VF
>    * @vf: the VF to create a port for
> @@ -1611,7 +1686,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
>   	devlink_port_attrs_set(devlink_port, &attrs);
>   	devlink = priv_to_devlink(pf);
>   
> -	err = devlink_port_register(devlink, devlink_port, vsi->idx);
> +	err = devlink_port_register_with_ops(devlink, devlink_port,
> +					     vsi->idx, &ice_devlink_vf_port_ops);
>   	if (err) {
>   		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
>   			vf->vf_id, err);
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 31314e7540f8..73cf1d9e9daa 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1216,6 +1216,68 @@ ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi)
>   	return ret;
>   }
>   
> +/**
> + * ice_set_vf_fn_mac
> + * @pf: PF to be configure
> + * @vf_id: VF identifier
> + * @mac: MAC address
> + *
> + * program VF MAC address
> + */
> +int ice_set_vf_fn_mac(struct ice_pf *pf, int vf_id, u8 *mac)

Also use u16 for `vf_id`?

> +{
> +	struct device *dev;
> +	struct ice_vf *vf;
> +	int ret;
> +
> +	dev = ice_pf_to_dev(pf);
> +	if (is_multicast_ether_addr(mac)) {
> +		dev_err(dev, "%pM not a valid unicast address\n", mac);
> +		return -EINVAL;
> +	}
> +
> +	vf = ice_get_vf_by_id(pf, vf_id);
> +	if (!vf)
> +		return -EINVAL;
> +
> +	/* nothing left to do, unicast MAC already set */
> +	if (ether_addr_equal(vf->dev_lan_addr, mac) &&
> +	    ether_addr_equal(vf->hw_lan_addr, mac)) {
> +		ret = 0;
> +		goto out_put_vf;
> +	}
> +
> +	ret = ice_check_vf_ready_for_cfg(vf);
> +	if (ret)
> +		goto out_put_vf;
> +
> +	mutex_lock(&vf->cfg_lock);
> +
> +	/* VF is notified of its new MAC via the PF's response to the
> +	 * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been reset
> +	 */
> +	ether_addr_copy(vf->dev_lan_addr, mac);
> +	ether_addr_copy(vf->hw_lan_addr, mac);
> +	if (is_zero_ether_addr(mac)) {
> +		/* VF will send VIRTCHNL_OP_ADD_ETH_ADDR message with its MAC */
> +		vf->pf_set_mac = false;
> +		dev_info(dev, "Removing MAC on VF %d. VF driver will be reinitialized\n",
> +			 vf->vf_id);
> +	} else {
> +		/* PF will add MAC rule for the VF */
> +		vf->pf_set_mac = true;
> +		dev_info(dev, "Setting MAC %pM on VF %d. VF driver will be reinitialized\n",
> +			 mac, vf_id);
> +	}
> +
> +	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +	mutex_unlock(&vf->cfg_lock);
> +
> +out_put_vf:
> +	ice_put_vf(vf);
> +	return ret;
> +}
> +
>   /**
>    * ice_set_vf_mac
>    * @netdev: network interface device structure
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
> index 346cb2666f3a..a03be184a806 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.h
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
> @@ -28,6 +28,7 @@
>   #ifdef CONFIG_PCI_IOV
>   void ice_process_vflr_event(struct ice_pf *pf);
>   int ice_sriov_configure(struct pci_dev *pdev, int num_vfs);
> +int ice_set_vf_fn_mac(struct ice_pf *pf, int vf_id, u8 *mac);
>   int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac);
>   int
>   ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi);
> @@ -76,6 +77,13 @@ ice_sriov_configure(struct pci_dev __always_unused *pdev,
>   	return -EOPNOTSUPP;
>   }
>   
> +static inline int
> +ice_set_vf_fn_mac(struct ice_pf __always_unused *pf,
> +		  int __always_unused vf_id, u8 __always_unused *mac)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static inline int
>   ice_set_vf_mac(struct net_device __always_unused *netdev,
>   	       int __always_unused vf_id, u8 __always_unused *mac)


Kind regards,

Paul

