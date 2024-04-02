Return-Path: <linux-kernel+bounces-128166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2978957CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578ABB2B148
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C23117F3;
	Tue,  2 Apr 2024 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="D1b4kXsf"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F8212BE80
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068721; cv=none; b=vFaYavoqnWRPIj46KT+04+e/MPG0Q/sV7BA0y1pOMCKHDcDdzaPs+GES4HFnqKsusgQf6ZeOhP7iPNJSozj2Po+AUrGFMQ0D45SyqJSuK9cEBcOqDgOvPzPMui3CStUTJvWtilOFdiNPRwxYdzQHv6wI1tevB14FhsRMjTAt0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068721; c=relaxed/simple;
	bh=jZGiqbzIbi6mZpdXnOzxBOpMOfMMWsp7k2Lz2cz9N5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDqy1nS67bcgEBtouSPcWTtakZpJBgOS1NO3rWlFmlK3HPYhTZ4sk40kCa9EmYfkrqDFCQ9e9r36LPX8N3LmF1d1IT4nt6TzDPeeTYfc488ITMcAz0D+rN3k+zUMySEBRHkKwTARBknxJJlXQD6/xr2gvn51YrnwEvDCJcUMKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=D1b4kXsf; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34175878e3cso3946768f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712068716; x=1712673516; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jb91MyD/GfnMjJ42GMj31sctff97Hftn6+nj+lz8QO0=;
        b=D1b4kXsfl9YrDD8e4XhcZkcXdEQ7M1l7CptN8VBN5Ula+ijuD92Yq7EeWiUZqM5bWf
         HyUEh8nkwGfPFyz+2vo4ThS2nTx1MXNyX36N7G7+LibZnG3Bhpg9Hpq8fbqNts6Um9kq
         hXGdZAgQwzAmvWh3Qjh+wxSo7f4rWacU/sPE0vgPv7Jn9cWmcg3dX4ClmLmYtw90vfsi
         55YnSrc6O6uBFEX3ykl4zXeGAGplV9cQ0D+gGlQJIeOYDaY6XIZngTwxYtsg3i4IC60d
         wwzISZGbtJIDGv6GlMK9iBFvLuOxxcorY0xOSiukni8VhZe3mQrSSWdoMoI0Mep+pRB+
         v9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712068716; x=1712673516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jb91MyD/GfnMjJ42GMj31sctff97Hftn6+nj+lz8QO0=;
        b=nViuhjW2Aupmc5jhQOI42JlNAgNrKbtt35fZqvQw7yONLV4GE3OCA7EkR7Ez9mCs/N
         no7oJ7QU6ToXmBe+p4nwCtkV+6imuf5VKu2ed8BGphwWyXcilHEQsXGWKTPbC3TSWfrY
         e0Dpenp9rWv3B5o54sk+3m3RnoIssS/SmBvR4MeVuxEgbQ8r/NcLLZBNQonbsKXrXxR1
         HwxPFwad58Pz4QbT2cE5/jsewcUB4QiEwQ2tAKZFZO+ZcyWo0tZxuf2MGvL7Hbr6fJN/
         uEyTdFUBBWig5Ey4Rgfcj3UsFtrQJ+xF3nscKo0LImaDT41lykRaCSp4CYy5Wjb0TOnD
         ozvA==
X-Forwarded-Encrypted: i=1; AJvYcCWjGgtMMGKOuwBfj3bPC0GcBQoaNTjo5duWGmiw4zy+5HB4spSsR4H4r9Nz5mGt2N5l37rGs6qO8LiIMeBN1iPQDHuuXVOjAQKxnSEV
X-Gm-Message-State: AOJu0Yw7dmUJPkQpzxYM8cHny0fRujkbR01Cl2XpiMQ52PJU/2gCgQWP
	uqmiyjvfbysye+dehiXcEon8uRD5QoSqkkuTgHldW6RW2rwNvOSp1tYcksuwKlk=
X-Google-Smtp-Source: AGHT+IFIqNO1IAuDmEGvalsUNnPRkm7aTf10+J9YuPNVfuj68WVf+nyhGTiSSpbChANmgbaQc+YBdg==
X-Received: by 2002:a5d:648b:0:b0:343:53ca:cee1 with SMTP id o11-20020a5d648b000000b0034353cacee1mr4278272wri.13.1712068715849;
        Tue, 02 Apr 2024 07:38:35 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id i13-20020adfe48d000000b00341bdbf0b07sm14249642wrm.50.2024.04.02.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 07:38:35 -0700 (PDT)
Date: Tue, 2 Apr 2024 16:38:31 +0200
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
Message-ID: <ZgwYZ-_aiSknTGZj@nanopsycho>
References: <20240402092254.3891-1-ksundara@redhat.com>
 <20240402092254.3891-2-ksundara@redhat.com>
 <ZgvqPHYj3jS7vGHO@nanopsycho>
 <CAPh+B4LJokN=-ii7fMkpSsucsBK7uROHwDSwXypX+moDRkiKXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPh+B4LJokN=-ii7fMkpSsucsBK7uROHwDSwXypX+moDRkiKXw@mail.gmail.com>

Tue, Apr 02, 2024 at 03:57:35PM CEST, ksundara@redhat.com wrote:
>On Tue, Apr 2, 2024 at 4:51 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Tue, Apr 02, 2024 at 11:22:54AM CEST, ksundara@redhat.com wrote:
>> >Changing the MAC address of the VFs is currently unsupported via devlink.
>> >Add the function handlers to set and get the HW address for the VFs.
>> >
>> >Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
>> >---
>> > drivers/net/ethernet/intel/ice/ice_devlink.c | 63 +++++++++++++++++++-
>> > drivers/net/ethernet/intel/ice/ice_sriov.c   | 62 +++++++++++++++++++
>> > drivers/net/ethernet/intel/ice/ice_sriov.h   |  8 +++
>> > 3 files changed, 132 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>> >index 80dc5445b50d..10735715403a 100644
>> >--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>> >+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>> >@@ -1576,6 +1576,66 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
>> >       devlink_port_unregister(&pf->devlink_port);
>> > }
>> >
>> >+/**
>> >+ * ice_devlink_port_get_vf_fn_mac - .port_fn_hw_addr_get devlink handler
>> >+ * @port: devlink port structure
>> >+ * @hw_addr: MAC address of the port
>> >+ * @hw_addr_len: length of MAC address
>> >+ * @extack: extended netdev ack structure
>> >+ *
>> >+ * Callback for the devlink .port_fn_hw_addr_get operation
>> >+ * Return: zero on success or an error code on failure.
>> >+ */
>> >+
>> >+static int ice_devlink_port_get_vf_fn_mac(struct devlink_port *port,
>> >+                                        u8 *hw_addr, int *hw_addr_len,
>> >+                                        struct netlink_ext_ack *extack)
>> >+{
>> >+      struct ice_vf *vf = container_of(port, struct ice_vf, devlink_port);
>> >+
>> >+      ether_addr_copy(hw_addr, vf->dev_lan_addr);
>> >+      *hw_addr_len = ETH_ALEN;
>> >+
>> >+      return 0;
>> >+}
>> >+
>> >+/**
>> >+ * ice_devlink_port_set_vf_fn_mac - .port_fn_hw_addr_set devlink handler
>> >+ * @port: devlink port structure
>> >+ * @hw_addr: MAC address of the port
>> >+ * @hw_addr_len: length of MAC address
>> >+ * @extack: extended netdev ack structure
>> >+ *
>> >+ * Callback for the devlink .port_fn_hw_addr_set operation
>> >+ * Return: zero on success or an error code on failure.
>> >+ */
>> >+static int ice_devlink_port_set_vf_fn_mac(struct devlink_port *port,
>> >+                                        const u8 *hw_addr,
>> >+                                        int hw_addr_len,
>> >+                                        struct netlink_ext_ack *extack)
>> >+
>> >+{
>> >+      struct devlink_port_attrs *attrs = &port->attrs;
>> >+      struct devlink_port_pci_vf_attrs *pci_vf;
>> >+      struct devlink *devlink = port->devlink;
>> >+      struct ice_pf *pf;
>> >+      u8 mac[ETH_ALEN];
>>
>> Why you need this extra variable?
>The function signature of ice_set_vf_fn_mac() is kept to match

Why? Why can't you just make the arg const?


>ice_set_vf_mac(), and hence the ``u8 *mac`` is used instead of ``const
>u8 *mac``.
>A copy of the mac is made to facilitate the same.
>Considering the usage of mac in ice_set_vf_fn_mac(), the function
>signature could be modified to take a ``const u8 *mac`` as well.

Yep.


>>
>>
>> >+      u16 vf_id;
>> >+
>> >+      pf = devlink_priv(devlink);
>> >+      pci_vf = &attrs->pci_vf;
>> >+      vf_id = pci_vf->vf;
>> >+
>> >+      ether_addr_copy(mac, hw_addr);
>> >+
>> >+      return ice_set_vf_fn_mac(pf, vf_id, mac);
>> >+}
>> >+
>> >+static const struct devlink_port_ops ice_devlink_vf_port_ops = {
>> >+      .port_fn_hw_addr_get = ice_devlink_port_get_vf_fn_mac,
>> >+      .port_fn_hw_addr_set = ice_devlink_port_set_vf_fn_mac,
>> >+};
>> >+
>> > /**
>> >  * ice_devlink_create_vf_port - Create a devlink port for this VF
>> >  * @vf: the VF to create a port for
>> >@@ -1611,7 +1671,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
>> >       devlink_port_attrs_set(devlink_port, &attrs);
>> >       devlink = priv_to_devlink(pf);
>> >
>> >-      err = devlink_port_register(devlink, devlink_port, vsi->idx);
>> >+      err = devlink_port_register_with_ops(devlink, devlink_port,
>> >+                                           vsi->idx, &ice_devlink_vf_port_ops);
>> >       if (err) {
>> >               dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
>> >                       vf->vf_id, err);
>> >diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
>> >index 31314e7540f8..b1e5cd188fd7 100644
>> >--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
>> >+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
>> >@@ -1216,6 +1216,68 @@ ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi)
>> >       return ret;
>> > }
>> >
>> >+/**
>> >+ * ice_set_vf_fn_mac
>> >+ * @pf: PF to be configure
>> >+ * @vf_id: VF identifier
>> >+ * @mac: MAC address
>> >+ *
>> >+ * program VF MAC address
>> >+ */
>> >+int ice_set_vf_fn_mac(struct ice_pf *pf, u16 vf_id, u8 *mac)
>> >+{
>> >+      struct device *dev;
>> >+      struct ice_vf *vf;
>> >+      int ret;
>> >+
>> >+      dev = ice_pf_to_dev(pf);
>> >+      if (is_multicast_ether_addr(mac)) {
>> >+              dev_err(dev, "%pM not a valid unicast address\n", mac);
>> >+              return -EINVAL;
>> >+      }
>> >+
>> >+      vf = ice_get_vf_by_id(pf, vf_id);
>> >+      if (!vf)
>> >+              return -EINVAL;
>> >+
>> >+      /* nothing left to do, unicast MAC already set */
>> >+      if (ether_addr_equal(vf->dev_lan_addr, mac) &&
>> >+          ether_addr_equal(vf->hw_lan_addr, mac)) {
>> >+              ret = 0;
>> >+              goto out_put_vf;
>> >+      }
>> >+
>> >+      ret = ice_check_vf_ready_for_cfg(vf);
>> >+      if (ret)
>> >+              goto out_put_vf;
>> >+
>> >+      mutex_lock(&vf->cfg_lock);
>> >+
>> >+      /* VF is notified of its new MAC via the PF's response to the
>> >+       * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been reset
>> >+       */
>> >+      ether_addr_copy(vf->dev_lan_addr, mac);
>> >+      ether_addr_copy(vf->hw_lan_addr, mac);
>> >+      if (is_zero_ether_addr(mac)) {
>> >+              /* VF will send VIRTCHNL_OP_ADD_ETH_ADDR message with its MAC */
>> >+              vf->pf_set_mac = false;
>> >+              dev_info(dev, "Removing MAC on VF %d. VF driver will be reinitialized\n",
>> >+                       vf->vf_id);
>> >+      } else {
>> >+              /* PF will add MAC rule for the VF */
>> >+              vf->pf_set_mac = true;
>> >+              dev_info(dev, "Setting MAC %pM on VF %d. VF driver will be reinitialized\n",
>> >+                       mac, vf_id);
>> >+      }
>> >+
>> >+      ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
>> >+      mutex_unlock(&vf->cfg_lock);
>> >+
>> >+out_put_vf:
>> >+      ice_put_vf(vf);
>> >+      return ret;
>> >+}
>> >+
>> > /**
>> >  * ice_set_vf_mac
>> >  * @netdev: network interface device structure
>> >diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
>> >index 346cb2666f3a..11cc522b1d9f 100644
>> >--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
>> >+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
>> >@@ -28,6 +28,7 @@
>> > #ifdef CONFIG_PCI_IOV
>> > void ice_process_vflr_event(struct ice_pf *pf);
>> > int ice_sriov_configure(struct pci_dev *pdev, int num_vfs);
>> >+int ice_set_vf_fn_mac(struct ice_pf *pf, u16 vf_id, u8 *mac);
>> > int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac);
>> > int
>> > ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi);
>> >@@ -76,6 +77,13 @@ ice_sriov_configure(struct pci_dev __always_unused *pdev,
>> >       return -EOPNOTSUPP;
>> > }
>> >
>> >+static inline int
>> >+ice_set_vf_fn_mac(struct ice_pf __always_unused *pf,
>> >+                u16 __always_unused vf_id, u8 __always_unused *mac)
>> >+{
>> >+      return -EOPNOTSUPP;
>> >+}
>> >+
>> > static inline int
>> > ice_set_vf_mac(struct net_device __always_unused *netdev,
>> >              int __always_unused vf_id, u8 __always_unused *mac)
>> >--
>> >2.39.3 (Apple Git-146)
>> >
>>
>

