Return-Path: <linux-kernel+bounces-57958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B92A84DF9A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DDA3B21E85
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E8C6F063;
	Thu,  8 Feb 2024 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DvawBBJb"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1F16D1C0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391617; cv=none; b=d+beA4SCPeTkObs2URE5lIY2q4V6GJzmYslRjt+LzCQc8KcftBQYx1FL3VRxvGjwUPDxxaXd1hzm6Syga/TzpY3Eq3/BJZPAXRjAKVXgMjccAXVPj6lnv+4fWJTG6X/vlyEca23v3VGkmUbn8ekeXop8rmd/0yo6rqnowYGLxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391617; c=relaxed/simple;
	bh=PV3Cqb0WoNn1J9rsLHGrcOE6c3VTz+5cxRIhc352BgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSEIm0EiN/RU5Q2wAiW5WLfEgpGR9ZjMd282VzP9aFtA6zREVFbgL2T8Fh4jXRNEs0rsTEhdZkblCe/e0yNTJluXAz4lE0XMF4sdCJDnMwU3AxxKAmPTi/gCWCnXNi974l2If+pkZ/Bjab++cAHDhlMGRzU1mHVfiw2mYz/bt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DvawBBJb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41001c6e19aso4512445e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 03:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707391613; x=1707996413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ENe6a0MGhFAYwxbIJ6WLGpev+wUMn3WNP3NeinQqkpk=;
        b=DvawBBJbCISpjxBI1dj4jmEYLEff9Igk3MG1q8XOjGaa7AAVmw6JVBoLL666nEy9hc
         hz8cgO8ADi5swCesACf7VIRRtI1hsEEw52NmaBqyqotqY5Hd3dc/PZzGFo8bMAYPpL0M
         qHLWPLeccsEshl500Fo6t8GmNRvoOJZ209KmgYT28gbyErK4TyABy9wg36zdHHr/1eyV
         c8sJQyaks7TwaaKsbzMTyFO187fK1kmGH/4qXPZFLbfVqkQGbpdAeMPaBFe7wytwhac5
         8aSi01c9T7hhrcJN9PRh7MRGkuO7ul1phMUi02WZT44G8ThBOQ169DNehhOj/AgGbzS1
         knZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707391613; x=1707996413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENe6a0MGhFAYwxbIJ6WLGpev+wUMn3WNP3NeinQqkpk=;
        b=JZvHyBPX85AECWIcx9P7FUpqQMQIf0xuC0lr6cPMGlHXW0oMXP/Q3UozZfUNOkHHcX
         FZix/PxV16EwpaQLEKmUyEgPjaZ52KKqFBXfGTOODTVF5PuOxyLYq2MCjf5PDZihtg1n
         GR9e0sPrJv7tDak9WVuamZTLkPUMz6HohXIADN4TaK7L6vcLoVvvgvgoZ0XfQ//pFKzX
         xu9ZfcvOALcfk1IENCI6gcVYP00V1zxTiD2H/V7XjZwjotC4oHhPi9J+yiIpPcCAmFRw
         nEWmU/PJNeBUmMi2CdcVrbLxLePnFo7jRw4eBfwAjojGbPYbsu3/HZwfvBosP0h8NI7o
         cgDA==
X-Forwarded-Encrypted: i=1; AJvYcCUk+odET+x+P33wWfSD3oJpiGvQ1D1YqIDs5GMK9OHcDPGABXdc4mZBzilL0jWLu8XpDuplqgycTzaT5DDe2ONa4Im9cnGjxADattJD
X-Gm-Message-State: AOJu0YxP4c+hC2v4TgbtBQZtof6s4WL+i2h0yI4QDQPo8E7bkKlhsMVs
	3BeDParzARDtQrAlUPBKUQ0LIefxIuUWvF6Arn5uPDZKaJowJxXU4FG537aRmhk=
X-Google-Smtp-Source: AGHT+IFynlbwaELVo7GaJVr7oESUnpHbKAXacrmgWYI4W/2zafauLyOMJtviUIiHO9Q94lIKXOCKWg==
X-Received: by 2002:a05:600c:4f85:b0:40f:cb0d:4de6 with SMTP id n5-20020a05600c4f8500b0040fcb0d4de6mr1845639wmq.5.1707391613110;
        Thu, 08 Feb 2024 03:26:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVW2Sm7rwhnabfFI7IcIwsENsKhtSUWvyRauqFuYAvoIjG/4y7F+DfxNyxTxHGb0FC7lUWC4P8zebZuakFqVkSGmy2Yf/jd/UpReDdaGbvflchYAAZqAUuYSnAIDb2VJU2exvpPCNWGfX2rGUvgE8rBkOfGX+SRTzea9Mg2OFLwmhDGjQuMhoQNRQLKfwM5JwuqEKHczoxOdTo0cYNaOJo07RAeuo4yVky/5el9GY65WyIYI4jHfigrA5/+qnQUEicm1joLlowjxL8S4j3o3hiLwa315369rc07YXFhdQFksLjg9ME1WwIXXleVHWjXFGIyWpCSxam41nkLM1WNFia6/bmOSvC6hy5GTymBQ9kxL2tcgGXyM/tF/lZZRyXWFnBNJCa1g8dxOg87xmjUo5suYF9sEHQGpBQqXhMOWXaptvauVU8xFzdYoNUqQ88m+UIewxzPCoN7PC/+QzPPI2VT89k3Yrnz/Jioj/mE9Ef8IHWVyf2w0BAlWd9auzfvdA16rHTJ/dAQFDm5SKTOtSo=
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id fb12-20020a05600c520c00b004103bd6f21dsm1181908wmb.35.2024.02.08.03.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 03:26:52 -0800 (PST)
Date: Thu, 8 Feb 2024 12:26:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Karthik Sundaravel <ksundara@redhat.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de, michal.swiatkowski@linux.intel.com,
	rjarry@redhat.com, aharivel@redhat.com, vchundur@redhat.com,
	cfontain@redhat.com
Subject: Re: [PATCH v2] ice: Add get/set hw address for VFs using devlink
 commands
Message-ID: <ZcS6e1Z4w76Z2F_K@nanopsycho>
References: <20240208082455.66726-1-ksundara@redhat.com>
 <20240208082455.66726-2-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208082455.66726-2-ksundara@redhat.com>

Thu, Feb 08, 2024 at 09:24:55AM CET, ksundara@redhat.com wrote:
>Changing the MAC address of the VF ports are not available
>via devlink. Add the function handlers to set and get
>the HW address for the VF ports.

"VFs". Avoid the word "port" here, as it may falsely indicate you are
talking about the eswitch representor port.


>
>Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_devlink.c | 89 +++++++++++++++++++-
> 1 file changed, 88 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>index 80dc5445b50d..8455fa94a687 100644
>--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>@@ -1576,6 +1576,92 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
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
>+	struct devlink *devlink = port->devlink;
>+	struct ice_pf *pf = devlink_priv(devlink);
>+	struct device *dev = ice_pf_to_dev(pf);
>+	struct devlink_port_attrs *attrs = &port->attrs;
>+	struct devlink_port_pci_vf_attrs *pci_vf;
>+	int vf_id;
>+	struct ice_vf *vf;

Reverse xmas tree:
https://www.kernel.org/doc/html/v6.7/process/maintainer-netdev.html#tl-dr


>+
>+	if (attrs->flavour == DEVLINK_PORT_FLAVOUR_PCI_VF) {
>+		pci_vf = &attrs->pci_vf;
>+		vf_id = pci_vf->vf;
>+	} else {
>+		dev_err(dev, "Unable to get the vf id for PF %d\n", pf->hw.pf_id);

Fill the extack message instead.


>+		return -EADDRNOTAVAIL;
>+	}
>+	vf = ice_get_vf_by_id(pf, vf_id);
>+	if (!vf) {
>+		dev_err(dev, "Unable to get the vf for PF %d\n", pf->hw.pf_id);

Fill the extack message instead.


>+		return -EINVAL;
>+	}
>+	ether_addr_copy(hw_addr, vf->dev_lan_addr);
>+	*hw_addr_len = ETH_ALEN;
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
>+					       const u8 *hw_addr,
>+					       int hw_addr_len,
>+					       struct netlink_ext_ack *extack)
>+{
>+	struct devlink *devlink = port->devlink;
>+	struct ice_pf *pf = devlink_priv(devlink);
>+	struct device *dev = ice_pf_to_dev(pf);
>+	struct net_device *netdev = port->type_eth.netdev;
>+	struct devlink_port_attrs *attrs = &port->attrs;
>+	struct devlink_port_pci_vf_attrs *pci_vf;
>+	int vf_id;
>+	u8 mac[ETH_ALEN];

Reverse xmas tree:
https://www.kernel.org/doc/html/v6.7/process/maintainer-netdev.html#tl-dr


>+
>+	if (attrs->flavour == DEVLINK_PORT_FLAVOUR_PCI_VF) {
>+		pci_vf = &attrs->pci_vf;
>+		vf_id = pci_vf->vf;
>+	} else {
>+		dev_err(dev, "Unable to get the vf id for PF %d\n", pf->hw.pf_id);

Fill the extack message instead.


>+		return -EADDRNOTAVAIL;
>+	}
>+
>+	if (!netdev) {
>+		dev_err(dev, "Unable to get the netdev for PF %d\n", pf->hw.pf_id);

Fill the extack message instead.


>+		return -EADDRNOTAVAIL;
>+	}
>+	ether_addr_copy(mac, hw_addr);
>+
>+	return ice_set_vf_mac(netdev, vf_id, mac);
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
>@@ -1611,7 +1697,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
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

