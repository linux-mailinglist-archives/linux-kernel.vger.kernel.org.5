Return-Path: <linux-kernel+bounces-83576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B07869BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E18A1F26A67
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7F11482F5;
	Tue, 27 Feb 2024 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="00Xx+0Oi"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E615B1474A5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050398; cv=none; b=hFPc3ALiMMYH8zbc8q2Li1ZsfBC4+3raN4sMxbnBAOUdbunZv5seC4+wBCU35gbA1Iafq2c/K73HJHXN+HBwZpOmU95BQZwqqla7thOrskxvtb0WWLwxYIOz1uiwA8iamXuigkhu+ZHTUS6YsZ6ZVYKEAjvZAvhsF6nCZTJLRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050398; c=relaxed/simple;
	bh=GgMIs7CnGsj0Oiwid0N1vSiT6igOmfDfHV3du4XW2XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYUhuKz/LBp4VGmFRfPr4sCjQGva3JioZzGdsisRrX4KSpD5pIvE1VsOcAZnNmukIO+gIoamr7wpbvwRSJE2/m8+G7+A7lcxaYIw6g0wWLAS0NbNV6OVzJ/RoMud6PEJSGjdu2esWsFvLbTMiNX5K9FfniGxlA8DDVUyFeREH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=00Xx+0Oi; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512b700c8ebso5567898e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709050394; x=1709655194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0zlUbDRUti/0fQkXKr609F+U7sVS+VPdTOuFz0F/Bk=;
        b=00Xx+0Oi1EXJ3i4nM0YKBbQitPdIU0owy6WyMLxh2HPwX67VUy5/50bLkDmQoJtVY7
         ZttcMohwTP0XbjfHr8JC8L7pIqGrTD++5WZcYlMbgqVFTXeOslg/NMLY8BG2IiS9XBxR
         KAHKNrbSuhXa4wuU2OJy8E8g78iVISLH2/7z39U/07BKuWjM/pwHaK/Creb9NPxjfl9R
         ppWrbSs1hRHQjc+ZHJOfsKv4PAJ7Xy6R7YB5FPf0tweM8VcUJIXvQpXBEMVGAPCa4RyV
         bTvo3IEqnprR/3trdhGSjw9cL7hzGzxA/6P6GNEX2Fl0tLHqa3jhbdAiFZTG19sTHpl+
         P55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709050394; x=1709655194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0zlUbDRUti/0fQkXKr609F+U7sVS+VPdTOuFz0F/Bk=;
        b=Ow6hRvwQ9M+4lzZPYX3tL5duKSd6g9ab5v51HcZAyvXHbVMA8BZCV1IPNLgr92wAf8
         +MFZaDQdsabF8J1Od6Ib40L/JaDxFVmfuI4wS0PmNbd5d6VYk04tPJOSzg1Ml+xeTgRh
         cLLbI1Cj3hKRhE6Trn41hE4RHG5oeSMnjnjSX7KGNJMb6Clmi8ogAEE3ur2qFRo6chNo
         T7Rbh4Qgk7+B/zFc4KisudtdK1fhAsYAUlX9jJFivl+7sXOtEu1LHb8VGLsAs5AyJ2kq
         MWdUKUuhDK4vrPyksOpxD3clI6IVnF+3dmx8kfg4EPXqR+WriUF8pZyqJuNNK8kfxGbx
         oB/g==
X-Forwarded-Encrypted: i=1; AJvYcCXGE8DmE8rZX4I0Yx/kCDoJtKfJTTS7qmJjkET+W+RFtolZzOX8HE83l3IcYWDybEIrQIsgR2zrRzXWpQfLTUFhqmVU883jhWhC6a7b
X-Gm-Message-State: AOJu0YwoDkakucmNqDBTpcM3J2UVdQO6CUmM7htyC9i6hYviLM8WArw5
	Cz4l/cnGFJrXcpL4GqFxSMPbrrjf49oaHRjeGqfZxm6XPWbQYH8yY5/wzegIq0ypwfhV7+Dg6YF
	l
X-Google-Smtp-Source: AGHT+IGdncA4Y+RRQwxvVBuwQR7ctR1zSWoNVd6L0U1b5mZoDC5tYdlxznJIjlJBo0jpK+3MajGWdg==
X-Received: by 2002:ac2:5e3c:0:b0:512:a959:af3d with SMTP id o28-20020ac25e3c000000b00512a959af3dmr5733841lfg.52.1709050394044;
        Tue, 27 Feb 2024 08:13:14 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6d42000000b0033b79d385f6sm11694326wri.47.2024.02.27.08.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:13:12 -0800 (PST)
Date: Tue, 27 Feb 2024 17:13:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Karthik Sundaravel <ksundara@redhat.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de, michal.swiatkowski@linux.intel.com,
	rjarry@redhat.com, aharivel@redhat.com, vchundur@redhat.com,
	cfontain@redhat.com
Subject: Re: [PATCH v4] ice: Add get/set hw address for VFs using devlink
 commands
Message-ID: <Zd4KFZINps0CloD-@nanopsycho>
References: <20240224124406.11369-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224124406.11369-1-ksundara@redhat.com>

Sat, Feb 24, 2024 at 01:44:06PM CET, ksundara@redhat.com wrote:
>Changing the MAC address of the VFs are not available
>via devlink. Add the function handlers to set and get
>the HW address for the VFs.
>
>Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_devlink.c | 88 +++++++++++++++++++-
> 1 file changed, 87 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>index 80dc5445b50d..c3813edd6a76 100644
>--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>@@ -1576,6 +1576,91 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
> 	devlink_port_unregister(&pf->devlink_port);
> }
> 
>+/**
>+ * ice_devlink_port_get_vf_mac_address - .port_fn_hw_addr_get devlink handler
>+ * @port: devlink port structure
>+ * @hw_addr: MAC address of the port
>+ * @hw_addr_len: length of MAC address
>+ * @extack: extended netdev ack structure
>+ *
>+ * Callback for the devlink .port_fn_hw_addr_get operation
>+ * Return: zero on success or an error code on failure.
>+ */
>+
>+static int ice_devlink_port_get_vf_mac_address(struct devlink_port *port,
>+					       u8 *hw_addr, int *hw_addr_len,
>+					       struct netlink_ext_ack *extack)
>+{
>+	struct devlink_port_attrs *attrs = &port->attrs;
>+	struct devlink_port_pci_vf_attrs *pci_vf;
>+	struct devlink *devlink = port->devlink;
>+	struct ice_pf *pf;
>+	struct ice_vf *vf;
>+	int vf_id;
>+
>+	pf = devlink_priv(devlink);
>+	if (attrs->flavour == DEVLINK_PORT_FLAVOUR_PCI_VF) {
>+		pci_vf = &attrs->pci_vf;
>+		vf_id = pci_vf->vf;
>+	} else {
>+		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf id");
>+		return -EADDRNOTAVAIL;
>+	}
>+	vf = ice_get_vf_by_id(pf, vf_id);
>+	if (!vf) {
>+		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf");
>+		return -EINVAL;
>+	}
>+	ether_addr_copy(hw_addr, vf->dev_lan_addr);
>+	*hw_addr_len = ETH_ALEN;
>+
>+	ice_put_vf(vf);
>+	return 0;
>+}
>+
>+/**
>+ * ice_devlink_port_set_vf_mac_address - .port_fn_hw_addr_set devlink handler
>+ * @port: devlink port structure
>+ * @hw_addr: MAC address of the port
>+ * @hw_addr_len: length of MAC address
>+ * @extack: extended netdev ack structure
>+ *
>+ * Callback for the devlink .port_fn_hw_addr_set operation
>+ * Return: zero on success or an error code on failure.
>+ */
>+static int ice_devlink_port_set_vf_mac_address(struct devlink_port *port,

Better to have "fn" in the name of the function, so it is clear this
sets the mac of function itself.


>+					       const u8 *hw_addr,
>+					       int hw_addr_len,
>+					       struct netlink_ext_ack *extack)
>+{
>+	struct net_device *netdev = port->type_eth.netdev;
>+	struct devlink_port_attrs *attrs = &port->attrs;
>+	struct devlink_port_pci_vf_attrs *pci_vf;
>+	u8 mac[ETH_ALEN];
>+	int vf_id;
>+
>+	if (attrs->flavour == DEVLINK_PORT_FLAVOUR_PCI_VF) {
>+		pci_vf = &attrs->pci_vf;
>+		vf_id = pci_vf->vf;
>+	} else {
>+		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf id");

How exactly this can happen? I'm pretty sure it can't.


>+		return -EADDRNOTAVAIL;
>+	}
>+
>+	if (!netdev) {

How exactly this can happen? I'm pretty sure it can't.


>+		NL_SET_ERR_MSG_MOD(extack, "Unable to get the netdev");
>+		return -EADDRNOTAVAIL;
>+	}
>+	ether_addr_copy(mac, hw_addr);
>+
>+	return ice_set_vf_mac(netdev, vf_id, mac);

It's misleading to call ice_set_vf_mac like this. It is originally used
by legacy ip vf api, where the netdev is the PF netdev. Here you pass
devlink port representor netdev. Internally ice_set_vf_mac() gets
pointer to struct ice_pf.

Could you please use:
struct ice_pf *pf = devlink_priv(devlink);
and pass it to some variant of ice_set_vf_mac() function?


pw-bot: cr


>+}
>+
>+static const struct devlink_port_ops ice_devlink_vf_port_ops = {
>+	.port_fn_hw_addr_get = ice_devlink_port_get_vf_mac_address,
>+	.port_fn_hw_addr_set = ice_devlink_port_set_vf_mac_address,
>+};
>+
> /**
>  * ice_devlink_create_vf_port - Create a devlink port for this VF
>  * @vf: the VF to create a port for
>@@ -1611,7 +1696,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
> 	devlink_port_attrs_set(devlink_port, &attrs);
> 	devlink = priv_to_devlink(pf);
> 
>-	err = devlink_port_register(devlink, devlink_port, vsi->idx);
>+	err = devlink_port_register_with_ops(devlink, devlink_port,
>+					     vsi->idx, &ice_devlink_vf_port_ops);
> 	if (err) {
> 		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
> 			vf->vf_id, err);
>-- 
>2.39.3 (Apple Git-145)
>

