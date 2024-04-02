Return-Path: <linux-kernel+bounces-127853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ADA8951B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E5F281FF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F6B69953;
	Tue,  2 Apr 2024 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EKlXe2li"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7710364CE9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056898; cv=none; b=djuFUo2Cf1DdLbThNPAEpYvr5rgC/3XT2Nnd2XneIAlT64T1f2BuI6DvEcxCxzzIqhD3yjUF1buD4SgGOPOq9ZaNXmIwW1HcMpgm7TAULJesPHPLQCBwzO2esCS526iGb3Em6j5QkT2dmr18puTb5sNLE3gRsMW8HhFzke3Pox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056898; c=relaxed/simple;
	bh=DPNntHHbbVBuZpxtrcAASRP6mPwIxQPQpS3DBx0mYro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIsWibeuRc9e1mn4eo8GuvqswST4DB37FyJ9p04w8fJ56lmiktD00WcX7zkQYweH4j8mFu1bCtKhItKBQLSiDmysCoS9GynFmgIWjoqXOCix4UNPLzbA5D00I1mbW6s2NpO3+Wad4uRAm8KMnKoHNDdCQ7FMQYg9KsWAEhw50XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EKlXe2li; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d80baf621eso31735741fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712056894; x=1712661694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hgU+nZuiX4o0PnBgeKWW+EtIi7N1M71d0zV+QPmKFhc=;
        b=EKlXe2li85dRXuFbn9pa7C0iU3FhF/L+H6Dgia1M8BKiZTHVMrWX5aVtVI7rQqEmWA
         4/BTS2WCnmqHd/LggzKoxHzGcqUQrTflo1oXHsxPgK1Y737G02oxXLeLocowXcvovagX
         HDR4TGnRtWUap9iI13WxJaHqBax124hhDBcYsmpcNWlZrqGDb7FTF57solr1j6pItKcB
         YVF1X1ccRXiS22LbOgWprFKHCJkRFgEyybuVYcobLKDg4f57zGnWG0N+Vn9IZs6XzHV3
         Fmpgc4eNzUG+icEuPMPW+HyFo9lGYjWRGef/tGK5iDiTD+E+NA/a0GxttMQ6rxSB8GOg
         6CSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712056894; x=1712661694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgU+nZuiX4o0PnBgeKWW+EtIi7N1M71d0zV+QPmKFhc=;
        b=OlKb4/yKMqRqy0pQtAJTeEUktuA8i/kR7yfZqKsv5a+b87NA09bG7v9bprrjSqRj5w
         edbCXjnCnJqZy3h3s6Ar74w27xfm2fZPW9Q8L3cqbS4D3mZL8IGnInvZQL2M+RfIwdt9
         v4JANrKalRhBMZC2W0nWcjxvBk6YQJSsx9rwnSXgioP5SCEnrXHrYH7qXp4/aj3jr0xi
         xmz8EsKXqSxOVq/bH+v/vHlCSue+2dL6wPZMvADGOYAIav6rn3vugSIURckuQIZqCctp
         6NEm3xbFMvgkzglNL49oOIJqNWo8T0eXvgih553inEWTysrXk7QPAe0xgf7o+S6NMfK3
         khsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5zAvMW/9xYdypZ+TL9RAYr/XINHNV85diBcsIbZQGuH+lrF5qs17sa0YecjQNp0gLkpEEFH4KJDfYojRmXdlBhV2blS69osY5mTKP
X-Gm-Message-State: AOJu0YzxF9+5JDVKcFy1BD3u8JYZ6Nt2jDCQONr7oJsTdNQUokqIG9eM
	Pn+nkuNr8NN2cUsS5D/nN2Y7SWK+T+WqxtX2Opc2NwEhHR6jcuALv5zZBJb3r0U=
X-Google-Smtp-Source: AGHT+IGUgv/nFejl9dY+nxeDofI2G44Drc4/N4dAbJlhZL1H0IE7lOaZ6fKO8N2RwLmw/tJcnDgCVw==
X-Received: by 2002:a2e:890b:0:b0:2d6:c4ec:782 with SMTP id d11-20020a2e890b000000b002d6c4ec0782mr8428163lji.49.1712056894282;
        Tue, 02 Apr 2024 04:21:34 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id o12-20020adfa10c000000b00341bb338407sm13969803wro.99.2024.04.02.04.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 04:21:33 -0700 (PDT)
Date: Tue, 2 Apr 2024 13:21:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Karthik Sundaravel <ksundara@redhat.com>
Cc: jesse.brandeburg@intel.com, wojciech.drewek@intel.com,
	sumang@marvell.com, jacob.e.keller@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de,
	michal.swiatkowski@linux.intel.com, rjarry@redhat.com,
	aharivel@redhat.com, vchundur@redhat.com, cfontain@redhat.com
Subject: Re: [PATCH v7] ice: Add get/set hw address for VFs using devlink
 commands
Message-ID: <ZgvqPHYj3jS7vGHO@nanopsycho>
References: <20240402092254.3891-1-ksundara@redhat.com>
 <20240402092254.3891-2-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402092254.3891-2-ksundara@redhat.com>

Tue, Apr 02, 2024 at 11:22:54AM CEST, ksundara@redhat.com wrote:
>Changing the MAC address of the VFs is currently unsupported via devlink.
>Add the function handlers to set and get the HW address for the VFs.
>
>Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_devlink.c | 63 +++++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_sriov.c   | 62 +++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_sriov.h   |  8 +++
> 3 files changed, 132 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>index 80dc5445b50d..10735715403a 100644
>--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>@@ -1576,6 +1576,66 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
> 	devlink_port_unregister(&pf->devlink_port);
> }
> 
>+/**
>+ * ice_devlink_port_get_vf_fn_mac - .port_fn_hw_addr_get devlink handler
>+ * @port: devlink port structure
>+ * @hw_addr: MAC address of the port
>+ * @hw_addr_len: length of MAC address
>+ * @extack: extended netdev ack structure
>+ *
>+ * Callback for the devlink .port_fn_hw_addr_get operation
>+ * Return: zero on success or an error code on failure.
>+ */
>+
>+static int ice_devlink_port_get_vf_fn_mac(struct devlink_port *port,
>+					  u8 *hw_addr, int *hw_addr_len,
>+					  struct netlink_ext_ack *extack)
>+{
>+	struct ice_vf *vf = container_of(port, struct ice_vf, devlink_port);
>+
>+	ether_addr_copy(hw_addr, vf->dev_lan_addr);
>+	*hw_addr_len = ETH_ALEN;
>+
>+	return 0;
>+}
>+
>+/**
>+ * ice_devlink_port_set_vf_fn_mac - .port_fn_hw_addr_set devlink handler
>+ * @port: devlink port structure
>+ * @hw_addr: MAC address of the port
>+ * @hw_addr_len: length of MAC address
>+ * @extack: extended netdev ack structure
>+ *
>+ * Callback for the devlink .port_fn_hw_addr_set operation
>+ * Return: zero on success or an error code on failure.
>+ */
>+static int ice_devlink_port_set_vf_fn_mac(struct devlink_port *port,
>+					  const u8 *hw_addr,
>+					  int hw_addr_len,
>+					  struct netlink_ext_ack *extack)
>+
>+{
>+	struct devlink_port_attrs *attrs = &port->attrs;
>+	struct devlink_port_pci_vf_attrs *pci_vf;
>+	struct devlink *devlink = port->devlink;
>+	struct ice_pf *pf;
>+	u8 mac[ETH_ALEN];

Why you need this extra variable?


>+	u16 vf_id;
>+
>+	pf = devlink_priv(devlink);
>+	pci_vf = &attrs->pci_vf;
>+	vf_id = pci_vf->vf;
>+
>+	ether_addr_copy(mac, hw_addr);
>+
>+	return ice_set_vf_fn_mac(pf, vf_id, mac);
>+}
>+
>+static const struct devlink_port_ops ice_devlink_vf_port_ops = {
>+	.port_fn_hw_addr_get = ice_devlink_port_get_vf_fn_mac,
>+	.port_fn_hw_addr_set = ice_devlink_port_set_vf_fn_mac,
>+};
>+
> /**
>  * ice_devlink_create_vf_port - Create a devlink port for this VF
>  * @vf: the VF to create a port for
>@@ -1611,7 +1671,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
> 	devlink_port_attrs_set(devlink_port, &attrs);
> 	devlink = priv_to_devlink(pf);
> 
>-	err = devlink_port_register(devlink, devlink_port, vsi->idx);
>+	err = devlink_port_register_with_ops(devlink, devlink_port,
>+					     vsi->idx, &ice_devlink_vf_port_ops);
> 	if (err) {
> 		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
> 			vf->vf_id, err);
>diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
>index 31314e7540f8..b1e5cd188fd7 100644
>--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
>+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
>@@ -1216,6 +1216,68 @@ ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi)
> 	return ret;
> }
> 
>+/**
>+ * ice_set_vf_fn_mac
>+ * @pf: PF to be configure
>+ * @vf_id: VF identifier
>+ * @mac: MAC address
>+ *
>+ * program VF MAC address
>+ */
>+int ice_set_vf_fn_mac(struct ice_pf *pf, u16 vf_id, u8 *mac)
>+{
>+	struct device *dev;
>+	struct ice_vf *vf;
>+	int ret;
>+
>+	dev = ice_pf_to_dev(pf);
>+	if (is_multicast_ether_addr(mac)) {
>+		dev_err(dev, "%pM not a valid unicast address\n", mac);
>+		return -EINVAL;
>+	}
>+
>+	vf = ice_get_vf_by_id(pf, vf_id);
>+	if (!vf)
>+		return -EINVAL;
>+
>+	/* nothing left to do, unicast MAC already set */
>+	if (ether_addr_equal(vf->dev_lan_addr, mac) &&
>+	    ether_addr_equal(vf->hw_lan_addr, mac)) {
>+		ret = 0;
>+		goto out_put_vf;
>+	}
>+
>+	ret = ice_check_vf_ready_for_cfg(vf);
>+	if (ret)
>+		goto out_put_vf;
>+
>+	mutex_lock(&vf->cfg_lock);
>+
>+	/* VF is notified of its new MAC via the PF's response to the
>+	 * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been reset
>+	 */
>+	ether_addr_copy(vf->dev_lan_addr, mac);
>+	ether_addr_copy(vf->hw_lan_addr, mac);
>+	if (is_zero_ether_addr(mac)) {
>+		/* VF will send VIRTCHNL_OP_ADD_ETH_ADDR message with its MAC */
>+		vf->pf_set_mac = false;
>+		dev_info(dev, "Removing MAC on VF %d. VF driver will be reinitialized\n",
>+			 vf->vf_id);
>+	} else {
>+		/* PF will add MAC rule for the VF */
>+		vf->pf_set_mac = true;
>+		dev_info(dev, "Setting MAC %pM on VF %d. VF driver will be reinitialized\n",
>+			 mac, vf_id);
>+	}
>+
>+	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
>+	mutex_unlock(&vf->cfg_lock);
>+
>+out_put_vf:
>+	ice_put_vf(vf);
>+	return ret;
>+}
>+
> /**
>  * ice_set_vf_mac
>  * @netdev: network interface device structure
>diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
>index 346cb2666f3a..11cc522b1d9f 100644
>--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
>+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
>@@ -28,6 +28,7 @@
> #ifdef CONFIG_PCI_IOV
> void ice_process_vflr_event(struct ice_pf *pf);
> int ice_sriov_configure(struct pci_dev *pdev, int num_vfs);
>+int ice_set_vf_fn_mac(struct ice_pf *pf, u16 vf_id, u8 *mac);
> int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac);
> int
> ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi);
>@@ -76,6 +77,13 @@ ice_sriov_configure(struct pci_dev __always_unused *pdev,
> 	return -EOPNOTSUPP;
> }
> 
>+static inline int
>+ice_set_vf_fn_mac(struct ice_pf __always_unused *pf,
>+		  u16 __always_unused vf_id, u8 __always_unused *mac)
>+{
>+	return -EOPNOTSUPP;
>+}
>+
> static inline int
> ice_set_vf_mac(struct net_device __always_unused *netdev,
> 	       int __always_unused vf_id, u8 __always_unused *mac)
>-- 
>2.39.3 (Apple Git-146)
>

