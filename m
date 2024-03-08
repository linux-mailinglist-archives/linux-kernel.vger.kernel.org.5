Return-Path: <linux-kernel+bounces-97012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A167876468
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012FB1F22A40
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F591BC39;
	Fri,  8 Mar 2024 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff1gm9Dp"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45453FD4;
	Fri,  8 Mar 2024 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901512; cv=none; b=X510cooT7nM+PCaIgXs7Ji6PD410P0AzjtW2Ti7ccjIgdeishEeypgZ5JDoG/Sth2Hv4Zv1Vg0LCU2kiB4nKYnE73FmnFRauTPYcuqZKRtO7TKrHtvHP+xfI1cxlszSZigfXlMOtHXdkuE5nH4oKaFsCzshCThaUoLmzhDdVmrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901512; c=relaxed/simple;
	bh=HSOdXPyL9FrKPvC80E57oiqcB9+Roc7ZUYMBUoCc6Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4TOtnh+e0hB/qIsyiRxZQK00duucM/h8Rjds6lkBXGIjq4mgbHv+HUJdz58FztnrIFsaiQCo0q+mrS/z1TOl7mKmj/7LZ6hn7s01IZJnuqeiheGEIfhKyK3/C9eCDhV1MXjrxnLRNHUTtTme1IPAzrTZgDQoQHpYD2R+E3Gah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ff1gm9Dp; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a45ecef71deso73723766b.2;
        Fri, 08 Mar 2024 04:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709901508; x=1710506308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ohVnEUh4D9mAq5jiJ48ejhs5oQ6S+LIDRY+0Ap4F1QU=;
        b=Ff1gm9Dp/da1hnpw1RKKXorPTFb0hzHp6UygcyOPQ4kji06A5tMj8j8eRtcpbDfCD2
         H+mkBzZkCwKq3nmvope3dmQUWxzEVRE2/HpqOLpkpXZa0Viy1g7NbEIKADnEz9D30ubv
         wOecdNQa+7YA+kvbYBvu9gaTdJHuDZd8VaYrGOaDC56czsSlwXaE4JpOhCFxpOYytchD
         ppjrbioicGB3Z7U803+8JCPNA+PgDFoK3NNIDvnwveLyWWUp0TbeYx/yCQObUOOT547j
         VRwMTJp/nqu532WbJXrj5B1uB1JWQQp3TGOq/eRl4ecMZznF/vxJ9gnDMOosvUdS20nL
         9MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709901508; x=1710506308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohVnEUh4D9mAq5jiJ48ejhs5oQ6S+LIDRY+0Ap4F1QU=;
        b=QVyLhaoLG0h6kJHKjie0iAky8e18p4tD21vaqSi1mDEeAnYOJNNHbyxqGcMBTNj5F1
         8kzPpOuXwWW1gUvEo0iwNiKVuKUvuzP48BPrN/RqgJs3clEjG8aZk+xn7nQVf/k8RIHc
         oDrk1M059j1xlL2IUQsGxM+QIYFfXwTOGL7G/Go3KD34OxyqN1AZQH2BLLTf9QP+xLap
         jETsi0gsMquNnCf2GgZRXLOMgJicFqagxo/iubXEUwn9EJbTmwp/eSFRVOSbrphBqbLE
         ZJL/lI+iUhl0EuuL4PbwAYOs/jdlDW6fkxo9u/irMtQNd531DnN6hEo2MZphgZT/DK+u
         8p1g==
X-Forwarded-Encrypted: i=1; AJvYcCVyfGg8GOG2VYLokjCo5LcDPpWTQWfLNOkaOGz5EtuURLhS370KCzMYvoy31UFLJish2WUuxaJIuGcQk2wO0FMhh1kFAcUG6Wt4Gz43
X-Gm-Message-State: AOJu0Ywpwn9Jv+QwJ+5oqTpxCtoP5XmUSoK1iHrZmAuWGRQhz/XRHpAO
	mU/CMDATjrGETK3iGCGftu1u9Dzv5HnQrwG27tcu5q6OL3rjq3a1
X-Google-Smtp-Source: AGHT+IE4Of/SS7YIi2QBM6vtahCIkmWISI2BbOPorADw73ZHw1oOl8DMBMRJCDc6hQl6/YViRFrNPQ==
X-Received: by 2002:a17:906:4c58:b0:a45:ad29:725c with SMTP id d24-20020a1709064c5800b00a45ad29725cmr6691407ejw.62.1709901507771;
        Fri, 08 Mar 2024 04:38:27 -0800 (PST)
Received: from skbuf ([2a02:2f04:d207:f600::b2c])
        by smtp.gmail.com with ESMTPSA id fi7-20020a170906da0700b00a44a859fd9dsm7972713ejb.174.2024.03.08.04.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 04:38:26 -0800 (PST)
Date: Fri, 8 Mar 2024 14:38:24 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 07/16] net: dsa: vsc73xx: Add vlan filtering
Message-ID: <20240308123824.kyenmgm4pouambus@skbuf>
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-8-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301221641.159542-8-paweldembicki@gmail.com>

On Fri, Mar 01, 2024 at 11:16:29PM +0100, Pawel Dembicki wrote:
> +static int
> +vsc73xx_write_vlan_table_entry(struct vsc73xx *vsc, u16 vid, u8 portmap)
> +{
> +	int ret;
> +
> +	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, vid);
> +
> +	ret = vsc73xx_wait_for_vlan_table_cmd(vsc);
> +	if (ret)
> +		return ret;
> +
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS,
> +			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK |
> +			    VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
> +			    VSC73XX_VLANACCESS_VLAN_PORT_MASK,
> +			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY |
> +			    VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
> +			    (portmap << VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT)
> +			    );

Close the parenthesis on the previous line.

> +
> +	return vsc73xx_wait_for_vlan_table_cmd(vsc);
> +}
> +
> +static int
> +vsc73xx_update_vlan_table(struct vsc73xx *vsc, int port, u16 vid, bool set)
> +{
> +	u8 portmap;
> +	int ret;
> +
> +	ret = vsc73xx_read_vlan_table_entry(vsc, vid, &portmap);
> +	if (ret)
> +		return ret;
> +
> +	if (set)
> +		portmap |= BIT(port);
> +	else
> +		portmap &= ~BIT(port);
> +
> +	return vsc73xx_write_vlan_table_entry(vsc, vid, portmap);
> +}
> +
>  static int vsc73xx_setup(struct dsa_switch *ds)
>  {
>  	struct vsc73xx *vsc = ds->priv;
> @@ -598,7 +714,7 @@ static int vsc73xx_setup(struct dsa_switch *ds)
>  		      VSC73XX_MACACCESS,
>  		      VSC73XX_MACACCESS_CMD_CLEAR_TABLE);
>  
> -	/* Clear VLAN table */
> +	/* Set VLAN table to default values */
>  	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
>  		      VSC73XX_VLANACCESS,
>  		      VSC73XX_VLANACCESS_VLAN_TBL_CMD_CLEAR_TABLE);
> @@ -627,6 +743,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
>  	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
>  		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
>  		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
> +	/* Ingess VLAN reception mask (table 145) */
> +	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANMASK,
> +		      0x5f);

It would have been nice for this to be expressed more symbolically than
the magic number 0x5f. Also, is it correct for vsc7398 (8 ports)?

>  	/* IP multicast flood mask (table 144) */
>  	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
>  		      0xff);
> @@ -639,6 +758,12 @@ static int vsc73xx_setup(struct dsa_switch *ds)
>  
>  	udelay(4);
>  
> +	/* Clear VLAN table */
> +	for (i = 0; i < VLAN_N_VID; i++)
> +		vsc73xx_write_vlan_table_entry(vsc, i, 0);
> +
> +	INIT_LIST_HEAD(&vsc->vlans);
> +
>  	return 0;
>  }
>  
> @@ -1029,6 +1154,443 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
>  	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
>  }
>  
> +static void
> +vsc73xx_set_vlan_conf(struct vsc73xx *vsc, int port,
> +		      enum vsc73xx_port_vlan_conf port_vlan_conf)
> +{
> +	u32 val = 0;
> +
> +	if (port_vlan_conf == VSC73XX_VLAN_IGNORE)
> +		val = VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA |
> +		      VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA;
> +
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_VLAN_MISC,
> +			    VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA |
> +			    VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA, val);
> +
> +	val = (port_vlan_conf == VSC73XX_VLAN_FILTER) ?
> +	      VSC73XX_TXUPDCFG_TX_INSERT_TAG : 0;
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
> +			    VSC73XX_TXUPDCFG_TX_INSERT_TAG, val);
> +}
> +
> +static int
> +vsc73xx_vlan_change_untagged(struct vsc73xx *vsc, int port, u16 vid, bool set,
> +			     bool operate_on_storage)
> +{
> +	u32 val = 0;
> +
> +	if (operate_on_storage) {
> +		vsc->untagged_storage[port] = set ? vid : VLAN_N_VID;
> +		return 0;
> +	}
> +
> +	if (set)
> +		val = VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA |
> +		      ((vid << VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT) &
> +		       VSC73XX_TXUPDCFG_TX_UNTAGGED_VID);
> +
> +	return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> +				   VSC73XX_TXUPDCFG,
> +				   VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA |
> +				   VSC73XX_TXUPDCFG_TX_UNTAGGED_VID, val);
> +}
> +
> +static int vsc73xx_vlan_change_pvid(struct vsc73xx *vsc, int port, u16 vid,
> +				    bool set, bool operate_on_storage)
> +{
> +	int ret;
> +	u32 val;
> +
> +	if (operate_on_storage) {
> +		vsc->pvid_storage[port] = set ? vid : VLAN_N_VID;
> +		return 0;
> +	}
> +
> +	val = set ? 0 : VSC73XX_CAT_DROP_UNTAGGED_ENA;
> +	vid = set ? vid : 0;

Why overwrite "vid" to 0 if deleting the PVID? Does it even matter, since
you're setting VSC73XX_CAT_DROP_UNTAGGED_ENA? Or is it just due to the
weird calling convention, where "vid" does not even matter when set==false,
but some callers pass weird values like VLAN_N_VID, and you want to
avoid programming the HW with that? If so, see the more detailed
suggestion below.

> +
> +	ret = vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> +				  VSC73XX_CAT_DROP,
> +				  VSC73XX_CAT_DROP_UNTAGGED_ENA, val);
> +	if (ret)
> +		return ret;
> +
> +	return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> +				   VSC73XX_CAT_PORT_VLAN,
> +				   VSC73XX_CAT_PORT_VLAN_VLAN_VID,
> +				   vid & VSC73XX_CAT_PORT_VLAN_VLAN_VID);
> +}
> +
> +static bool vsc73xx_port_get_pvid(struct vsc73xx *vsc, int port, u16 *vid,
> +				  bool operate_on_storage)
> +{
> +	u32 val;
> +
> +	if (operate_on_storage) {
> +		if (vsc->pvid_storage[port] < VLAN_N_VID) {
> +			*vid = vsc->pvid_storage[port];
> +			return true;
> +		}
> +		return false;
> +	}
> +
> +	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DROP, &val);
> +	if (val & VSC73XX_CAT_DROP_UNTAGGED_ENA)
> +		return false;
> +
> +	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN, &val);
> +	*vid = val & VSC73XX_CAT_PORT_VLAN_VLAN_VID;
> +
> +	return true;
> +}
> +
> +static bool vsc73xx_tag_8021q_active(struct dsa_port *dp)
> +{
> +	return !dsa_port_is_vlan_filtering(dp);
> +}

This and vsc73xx_port_get_untagged() are a bit misplaced in terms of
ordering. I guess you'd want the functions which handle the untagged
VLAN to be grouped together, then the functions which handle the PVID,
then the rest.

> +
> +static bool vsc73xx_port_get_untagged(struct vsc73xx *vsc, int port, u16 *vid,
> +				      bool operate_on_storage)
> +{
> +	u32 val;
> +
> +	if (operate_on_storage) {
> +		if (vsc->untagged_storage[port] < VLAN_N_VID) {
> +			*vid = vsc->untagged_storage[port];
> +			return true;
> +		}
> +		return false;
> +	}
> +
> +	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG, &val);
> +	if (!(val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA))
> +		return false;
> +
> +	*vid = (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID) >>
> +		VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT;
> +
> +	return true;
> +}
> +
> +static struct vsc73xx_bridge_vlan *
> +vsc73xx_bridge_vlan_find(struct vsc73xx *vsc, u16 vid)
> +{
> +	struct vsc73xx_bridge_vlan *vlan;
> +
> +	list_for_each_entry(vlan, &vsc->vlans, list)
> +		if (vlan->vid == vid)
> +			return vlan;
> +
> +	return NULL;
> +}
> +
> +static size_t
> +vsc73xx_bridge_vlan_num_tagged(struct vsc73xx *vsc, int port, u16 ignored_vid)
> +{
> +	struct vsc73xx_bridge_vlan *vlan;
> +	size_t num_tagged = 0;
> +
> +	list_for_each_entry(vlan, &vsc->vlans, list)
> +		if ((vlan->portmask & BIT(port)) &&
> +		    !(vlan->untagged & BIT(port)) &&
> +		    vlan->vid != ignored_vid)
> +			num_tagged++;
> +
> +	return num_tagged;
> +}
> +
> +static size_t
> +vsc73xx_bridge_vlan_num_untagged(struct vsc73xx *vsc, int port, u16 ignored_vid)
> +{
> +	struct vsc73xx_bridge_vlan *vlan;
> +	size_t num_untagged = 0;
> +
> +	list_for_each_entry(vlan, &vsc->vlans, list)
> +		if ((vlan->portmask & BIT(port)) &&
> +		    (vlan->untagged & BIT(port)) &&
> +		    vlan->vid != ignored_vid)
> +			num_untagged++;
> +
> +	return num_untagged;
> +}
> +
> +static u16 vsc73xx_find_first_vlan_untagged(struct vsc73xx *vsc, int port)
> +{
> +	struct vsc73xx_bridge_vlan *vlan;
> +
> +	list_for_each_entry(vlan, &vsc->vlans, list)
> +		if ((vlan->portmask & BIT(port)) &&
> +		    (vlan->untagged & BIT(port)))
> +			return vlan->vid;
> +
> +	return VLAN_N_VID;
> +}
> +
> +static int
> +vsc73xx_port_vlan_filtering(struct dsa_switch *ds, int port,
> +			    bool vlan_filtering, struct netlink_ext_ack *extack)
> +{
> +	enum vsc73xx_port_vlan_conf port_vlan_conf = VSC73XX_VLAN_IGNORE;
> +	struct vsc73xx *vsc = ds->priv;
> +	bool store_untagged = false;
> +	bool store_pvid = false;
> +	u16 vid, vlan_untagged;
> +
> +	/* The swap processed below is required because vsc73xx is using
> +	 * tag_8021q. When vlan_filtering is disabled, tag_8021q uses
> +	 * pvid/untagged vlans for port recognition. The values configured for
> +	 * vlans < 3072 are stored in storage table. When vlan_filtering is
> +	 * enabled, we need to restore pvid/untagged from storage and keep
> +	 * values used for tag_8021q.
> +	 */
> +	if (vlan_filtering) {
> +		/* Use VLAN_N_VID to count all vlans */
> +		size_t num_untagged =
> +			vsc73xx_bridge_vlan_num_untagged(vsc, port, VLAN_N_VID);
> +
> +		port_vlan_conf = (num_untagged > 1) ?
> +				 VSC73XX_VLAN_FILTER_UNTAG_ALL :
> +				 VSC73XX_VLAN_FILTER;
> +
> +		vlan_untagged = vsc73xx_find_first_vlan_untagged(vsc, port);
> +		if (vlan_untagged < VLAN_N_VID) {
> +			store_untagged  = vsc73xx_port_get_untagged(vsc, port,

A single space before =.

> +								    &vid,
> +								    false);
> +			vsc73xx_vlan_change_untagged(vsc, port, vlan_untagged,
> +						     true, false);
> +			vsc->untagged_storage[port] = store_untagged ?
> +						      vid : VLAN_N_VID;
> +		}
> +	} else {
> +		vsc73xx_vlan_change_untagged(vsc, port,
> +					     vsc->untagged_storage[port],
> +					     vsc->untagged_storage[port] <
> +					     VLAN_N_VID, false);
> +	}
> +
> +	vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
> +
> +	store_pvid = vsc73xx_port_get_pvid(vsc, port, &vid, false);
> +	vsc73xx_vlan_change_pvid(vsc, port, vsc->pvid_storage[port],
> +				 vsc->pvid_storage[port] < VLAN_N_VID, false);
> +	vsc->pvid_storage[port] = store_pvid ? vid : VLAN_N_VID;
> +
> +	return 0;
> +}
> +
> +static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_vlan *vlan,
> +				 struct netlink_ext_ack *extack)
> +{
> +	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> +	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct vsc73xx_bridge_vlan *vsc73xx_vlan;
> +	size_t num_tagged, num_untagged;
> +	struct vsc73xx *vsc = ds->priv;
> +	int ret;
> +	u16 vid;
> +
> +	/* Be sure to deny alterations to the configuration done by tag_8021q.
> +	 */
> +	if (vid_is_dsa_8021q(vlan->vid)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Range 3072-4095 reserved for dsa_8021q operation");
> +		return -EBUSY;
> +	}
> +
> +	/* The processed vlan->vid is excluded from the search because the VLAN
> +	 * can be re-added with a different set of flags, so it's easiest to
> +	 * ignore its old flags from the VLAN database software copy.
> +	 */
> +	num_tagged = vsc73xx_bridge_vlan_num_tagged(vsc, port, vlan->vid);
> +	num_untagged = vsc73xx_bridge_vlan_num_untagged(vsc, port, vlan->vid);
> +
> +	/* VSC73XX allow only three untagged states: none, one or all */
> +	if ((untagged && num_tagged > 0 && num_untagged > 0) ||
> +	    (!untagged && num_untagged > 1)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Port can have only none, one or all untagged vlan");
> +		return -EBUSY;
> +	}
> +
> +	vsc73xx_vlan = vsc73xx_bridge_vlan_find(vsc, vlan->vid);
> +
> +	if (!vsc73xx_vlan) {
> +		vsc73xx_vlan = kzalloc(sizeof(*vsc73xx_vlan), GFP_KERNEL);
> +		if (!vsc73xx_vlan)
> +			return -ENOMEM;
> +
> +		vsc73xx_vlan->vid = vlan->vid;
> +		vsc73xx_vlan->portmask = BIT(port);
> +		vsc73xx_vlan->untagged = untagged ? BIT(port) : 0;
> +
> +		INIT_LIST_HEAD(&vsc73xx_vlan->list);
> +		list_add_tail(&vsc73xx_vlan->list, &vsc->vlans);
> +	} else {
> +		vsc73xx_vlan->portmask |= BIT(port);
> +
> +		if (untagged)
> +			vsc73xx_vlan->untagged |= BIT(port);
> +		else
> +			vsc73xx_vlan->untagged &= ~BIT(port);
> +	}
> +
> +	/* CPU port must be always tagged because port separation is based on
> +	 * tag_8021q.
> +	 */
> +	if (port != CPU_PORT) {
> +		bool operate_on_storage = vsc73xx_tag_8021q_active(dp);
> +
> +		if (!operate_on_storage) {
> +			enum vsc73xx_port_vlan_conf port_vlan_conf =
> +							VSC73XX_VLAN_FILTER;
> +
> +			if (num_tagged == 0 && untagged)
> +				port_vlan_conf = VSC73XX_VLAN_FILTER_UNTAG_ALL;
> +			vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
> +
> +			if (port_vlan_conf == VSC73XX_VLAN_FILTER) {
> +				if (untagged) {
> +					ret = vsc73xx_vlan_change_untagged(vsc,
> +									   port,
> +									   vlan->vid,
> +									   true,
> +									   false);
> +					if (ret)
> +						goto err;
> +				} else if (num_untagged == 1) {
> +					vid = vsc73xx_find_first_vlan_untagged(vsc,
> +									       port);
> +					ret = vsc73xx_vlan_change_untagged(vsc,
> +									   port,
> +									   vid,
> +									   true,
> +									   false);
> +					if (ret)
> +						goto err;
> +				}
> +			}
> +		}
> +
> +		if (pvid) {
> +			ret = vsc73xx_vlan_change_pvid(vsc, port, vlan->vid,
> +						       true,
> +						       operate_on_storage);
> +			if (ret)
> +				goto err;
> +		} else if (vsc73xx_port_get_pvid(vsc, port, &vid, false) &&
> +			   vid == vlan->vid) {
> +			vsc73xx_vlan_change_pvid(vsc, port, 0, false, false);
> +		} else if (vsc->pvid_storage[port] == vlan->vid) {
> +			vsc73xx_vlan_change_pvid(vsc, port, 0, false, true);
> +		}
> +	}
> +
> +	ret = vsc73xx_update_vlan_table(vsc, port, vlan->vid, true);
> +	if (!ret)
> +		return 0;
> +err:
> +	list_del(&vsc73xx_vlan->list);
> +	kfree(vsc73xx_vlan);
> +	return ret;
> +}
> +
> +static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_vlan *vlan)
> +{
> +	struct vsc73xx_bridge_vlan *vsc73xx_vlan;
> +	size_t num_tagged, num_untagged;
> +	struct vsc73xx *vsc = ds->priv;
> +	bool operate_on_storage;
> +	int ret;
> +	u16 vid;
> +
> +	num_tagged = vsc73xx_bridge_vlan_num_tagged(vsc, port, vlan->vid);
> +	num_untagged = vsc73xx_bridge_vlan_num_untagged(vsc, port, vlan->vid);
> +
> +	ret = vsc73xx_update_vlan_table(vsc, port, vlan->vid, false);
> +	if (ret)
> +		return ret;
> +
> +	operate_on_storage = vsc73xx_tag_8021q_active(dsa_to_port(ds, port));
> +
> +	if (!operate_on_storage) {
> +		enum vsc73xx_port_vlan_conf port_vlan_conf =
> +							VSC73XX_VLAN_FILTER;
> +
> +		if (num_tagged == 0)
> +			port_vlan_conf = VSC73XX_VLAN_FILTER_UNTAG_ALL;
> +		vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
> +
> +		if (num_untagged <= 1) {
> +			vid = vsc73xx_find_first_vlan_untagged(vsc, port);
> +			vsc73xx_vlan_change_untagged(vsc, port, vid,
> +						     num_untagged, false);
> +		}
> +	} else if (vsc->untagged_storage[port] == vlan->vid) {
> +		vsc73xx_vlan_change_untagged(vsc, port, 0, false, true);

The fact that the "vid" argument (here 0) is ignored when "set" is false
makes the calling convention confusing, and thus the caller itself.

I would have probably written 2 wrappers on top of
vsc73xx_vlan_change_untagged() as follows:
	- vsc73xx_vlan_set_untagged(), which eliminates the "set"
	  argument from callers (implicitly true)
	- vsc73xx_vlan_del_untagged(), which eliminates the "set"
	  argument (implicitly false) and the "vid" argument (unused)

Same for vsc73xx_vlan_change_pvid().

This will force you to eliminate the complex expressions given to the
"set" argument, like "vsc->untagged_storage[port] < VLAN_N_VID", and
transform them into "if (vsc->untagged_storage[port] < VLAN_N_VID) set() else del()",
which is probably a good thing in terms of readability.

Something like this:

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 05dbeec8eb63..464d74c891d7 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1205,6 +1205,20 @@ vsc73xx_vlan_change_untagged(struct vsc73xx *vsc, int port, u16 vid, bool set,
 				   VSC73XX_TXUPDCFG_TX_UNTAGGED_VID, val);
 }
 
+static int vsc73xx_vlan_set_untagged(struct vsc73xx *vsc, int port, u16 vid,
+				     bool operate_on_storage)
+{
+	return vsc73xx_vlan_change_untagged(vsc, port, vid, true,
+					    operate_on_storage);
+}
+
+static int vsc73xx_vlan_del_untagged(struct vsc73xx *vsc, int port,
+				     bool operate_on_storage)
+{
+	return vsc73xx_vlan_change_untagged(vsc, port, 0, false,
+					    operate_on_storage);
+}
+
 static int vsc73xx_vlan_change_pvid(struct vsc73xx *vsc, int port, u16 vid,
 				    bool set, bool operate_on_storage)
 {
@@ -1231,6 +1245,20 @@ static int vsc73xx_vlan_change_pvid(struct vsc73xx *vsc, int port, u16 vid,
 				   vid & VSC73XX_CAT_PORT_VLAN_VLAN_VID);
 }
 
+static int vsc73xx_vlan_set_pvid(struct vsc73xx *vsc, int port, u16 vid,
+				 bool operate_on_storage)
+{
+	return vsc73xx_vlan_change_pvid(vsc, port, vid, true,
+					operate_on_storage);
+}
+
+static int vsc73xx_vlan_del_pvid(struct vsc73xx *vsc, int port,
+				 bool operate_on_storage)
+{
+	return vsc73xx_vlan_change_pvid(vsc, port, 0, false,
+					operate_on_storage);
+}
+
 static bool vsc73xx_port_get_pvid(struct vsc73xx *vsc, int port, u16 *vid,
 				  bool operate_on_storage)
 {
@@ -1367,23 +1395,25 @@ vsc73xx_port_vlan_filtering(struct dsa_switch *ds, int port,
 			store_untagged  = vsc73xx_port_get_untagged(vsc, port,
 								    &vid,
 								    false);
-			vsc73xx_vlan_change_untagged(vsc, port, vlan_untagged,
-						     true, false);
+			vsc73xx_vlan_set_untagged(vsc, port, vlan_untagged,
+						  false);
 			vsc->untagged_storage[port] = store_untagged ?
 						      vid : VLAN_N_VID;
 		}
+	} else if (vsc->untagged_storage[port] < VLAN_N_VID) {
+		vsc73xx_vlan_set_untagged(vsc, port, vsc->untagged_storage[port],
+					  false);
 	} else {
-		vsc73xx_vlan_change_untagged(vsc, port,
-					     vsc->untagged_storage[port],
-					     vsc->untagged_storage[port] <
-					     VLAN_N_VID, false);
+		vsc73xx_vlan_del_untagged(vsc, port, false);
 	}
 
 	vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
 
 	store_pvid = vsc73xx_port_get_pvid(vsc, port, &vid, false);
-	vsc73xx_vlan_change_pvid(vsc, port, vsc->pvid_storage[port],
-				 vsc->pvid_storage[port] < VLAN_N_VID, false);
+	if (vsc->pvid_storage[port] < VLAN_N_VID)
+		vsc73xx_vlan_set_pvid(vsc, port, vsc->pvid_storage[port], false);
+	else
+		vsc73xx_vlan_del_pvid(vsc, port, false);
 	vsc->pvid_storage[port] = store_pvid ? vid : VLAN_N_VID;
 
 	return 0;
@@ -1463,21 +1493,16 @@ static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
 
 			if (port_vlan_conf == VSC73XX_VLAN_FILTER) {
 				if (untagged) {
-					ret = vsc73xx_vlan_change_untagged(vsc,
-									   port,
-									   vlan->vid,
-									   true,
-									   false);
+					ret = vsc73xx_vlan_set_untagged(vsc, port,
+									vlan->vid,
+									false);
 					if (ret)
 						goto err;
 				} else if (num_untagged == 1) {
 					vid = vsc73xx_find_first_vlan_untagged(vsc,
 									       port);
-					ret = vsc73xx_vlan_change_untagged(vsc,
-									   port,
-									   vid,
-									   true,
-									   false);
+					ret = vsc73xx_vlan_set_untagged(vsc, port,
+									vid, false);
 					if (ret)
 						goto err;
 				}
@@ -1485,16 +1510,15 @@ static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
 		}
 
 		if (pvid) {
-			ret = vsc73xx_vlan_change_pvid(vsc, port, vlan->vid,
-						       true,
-						       operate_on_storage);
+			ret = vsc73xx_vlan_set_pvid(vsc, port, vlan->vid,
+						    operate_on_storage);
 			if (ret)
 				goto err;
 		} else if (vsc73xx_port_get_pvid(vsc, port, &vid, false) &&
 			   vid == vlan->vid) {
-			vsc73xx_vlan_change_pvid(vsc, port, 0, false, false);
+			vsc73xx_vlan_del_pvid(vsc, port, false);
 		} else if (vsc->pvid_storage[port] == vlan->vid) {
-			vsc73xx_vlan_change_pvid(vsc, port, 0, false, true);
+			vsc73xx_vlan_del_pvid(vsc, port, true);
 		}
 	}
 
@@ -1534,19 +1558,20 @@ static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
 			port_vlan_conf = VSC73XX_VLAN_FILTER_UNTAG_ALL;
 		vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
 
-		if (num_untagged <= 1) {
+		if (num_untagged == 1) {
 			vid = vsc73xx_find_first_vlan_untagged(vsc, port);
-			vsc73xx_vlan_change_untagged(vsc, port, vid,
-						     num_untagged, false);
+			vsc73xx_vlan_set_untagged(vsc, port, vid, false);
+		} else if (num_untagged == 0) {
+			vsc73xx_vlan_del_untagged(vsc, port, false);
 		}
 	} else if (vsc->untagged_storage[port] == vlan->vid) {
-		vsc73xx_vlan_change_untagged(vsc, port, 0, false, true);
+		vsc73xx_vlan_del_untagged(vsc, port, true);
 	}
 
 	if (vsc73xx_port_get_pvid(vsc, port, &vid, false) && vid == vlan->vid)
-		vsc73xx_vlan_change_pvid(vsc, port, 0, false, false);
+		vsc73xx_vlan_del_pvid(vsc, port, false);
 	else if (vsc->pvid_storage[port] == vlan->vid)
-		vsc73xx_vlan_change_pvid(vsc, port, 0, false, true);
+		vsc73xx_vlan_del_pvid(vsc, port, true);
 
 	vsc73xx_vlan = vsc73xx_bridge_vlan_find(vsc, vlan->vid);
 
@@ -1574,11 +1599,9 @@ static int vsc73xx_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
 	operate_on_storage = !vsc73xx_tag_8021q_active(dsa_to_port(ds, port));
 
 	if (untagged)
-		vsc73xx_vlan_change_untagged(vsc, port, vid, true,
-					     operate_on_storage);
+		vsc73xx_vlan_set_untagged(vsc, port, vid, operate_on_storage);
 	if (pvid)
-		vsc73xx_vlan_change_pvid(vsc, port, vid, true,
-					 operate_on_storage);
+		vsc73xx_vlan_set_pvid(vsc, port, vid, operate_on_storage);
 
 	return vsc73xx_update_vlan_table(vsc, port, vid, true);
 }

> +	}
> +
> +	if (vsc73xx_port_get_pvid(vsc, port, &vid, false) && vid == vlan->vid)
> +		vsc73xx_vlan_change_pvid(vsc, port, 0, false, false);
> +	else if (vsc->pvid_storage[port] == vlan->vid)
> +		vsc73xx_vlan_change_pvid(vsc, port, 0, false, true);
> +
> +	vsc73xx_vlan = vsc73xx_bridge_vlan_find(vsc, vlan->vid);
> +
> +	if (vsc73xx_vlan) {
> +		vsc73xx_vlan->portmask &= ~BIT(port);
> +
> +		if (vsc73xx_vlan->portmask)
> +			return 0;
> +
> +		list_del(&vsc73xx_vlan->list);
> +		kfree(vsc73xx_vlan);
> +	}
> +
> +	return 0;
> +}
> +
> +static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +
> +	/* Those bits are responsible for MTU only. Kernel take care about MTU,

takes care

> +	 * let's enable +8 bytes frame length unconditionally.
> +	 */
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
> +			    VSC73XX_MAC_CFG_VLAN_AWR |
> +			    VSC73XX_MAC_CFG_VLAN_DBLAWR,
> +			    VSC73XX_MAC_CFG_VLAN_AWR |
> +			    VSC73XX_MAC_CFG_VLAN_DBLAWR);
> +
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DROP,
> +			    VSC73XX_CAT_DROP_TAGGED_ENA |
> +			    VSC73XX_CAT_DROP_UNTAGGED_ENA,
> +			    VSC73XX_CAT_DROP_UNTAGGED_ENA);
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
> +			    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA |
> +			    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID, 0);
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN,
> +			    VSC73XX_CAT_PORT_VLAN_VLAN_VID, 0);
> +
> +	if (port == CPU_PORT)
> +		vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_FILTER);
> +	else
> +		vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_IGNORE);
> +
> +	/* Initially, there is no backup VLAN configuration to keep track of, so
> +	 * configure the storage values out of range
> +	 */
> +	vsc->pvid_storage[port] = VLAN_N_VID;
> +	vsc->untagged_storage[port] = VLAN_N_VID;
> +
> +	return 0;
> +}
> +
>  static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
>  {
>  	struct dsa_port *other_dp, *dp = dsa_to_port(ds, port);
> @@ -1123,11 +1685,15 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
>  	.get_strings = vsc73xx_get_strings,
>  	.get_ethtool_stats = vsc73xx_get_ethtool_stats,
>  	.get_sset_count = vsc73xx_get_sset_count,
> +	.port_setup = vsc73xx_port_setup,
>  	.port_enable = vsc73xx_port_enable,
>  	.port_disable = vsc73xx_port_disable,
>  	.port_change_mtu = vsc73xx_change_mtu,
>  	.port_max_mtu = vsc73xx_get_max_mtu,
>  	.port_stp_state_set = vsc73xx_port_stp_state_set,
> +	.port_vlan_filtering = vsc73xx_port_vlan_filtering,
> +	.port_vlan_add = vsc73xx_port_vlan_add,
> +	.port_vlan_del = vsc73xx_port_vlan_del,
>  	.phylink_get_caps = vsc73xx_phylink_get_caps,
>  };
>  
> diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
> index e7b08599a625..facc50f1e320 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx.h
> +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> @@ -25,6 +25,17 @@
>   * @addr: MAC address used in flow control frames
>   * @ops: Structure with hardware-dependent operations
>   * @priv: Pointer to the configuration interface structure
> + * @pvid_storage: Storage table with PVID configured for other state of
> + *	vlan_filtering. It has two alternating roles: it stores the PVID when
> + *	configured by the bridge but VLAN filtering is off, and it stores the
> + *	PVID necessary for tag_8021q operation when bridge VLAN filtering is
> + *	enabled.
> + * @untagged_storage: Storage table with eggres untagged VLAN configured for

egress

> + *	other state of vlan_filtering.Keep VID necessary for tag8021q operations

Space between "vlan_filtering." and "Keep".
tag_8021q

> + *	when vlan filtering is enabled.
> + * @vlans: List of configured vlans. Contains port mask and untagged status of
> + *	every vlan configured in port vlan operation. It doesn't cover tag_8021q
> + *	vlans.
>   */
>  struct vsc73xx {
>  	struct device			*dev;
> @@ -35,6 +46,9 @@ struct vsc73xx {
>  	u8				addr[ETH_ALEN];
>  	const struct vsc73xx_ops	*ops;
>  	void				*priv;
> +	u16				pvid_storage[VSC73XX_MAX_NUM_PORTS];
> +	u16				untagged_storage[VSC73XX_MAX_NUM_PORTS];
> +	struct list_head		vlans;
>  };
>  
>  /**
> @@ -49,6 +63,21 @@ struct vsc73xx_ops {
>  		     u32 val);
>  };
>  
> +/**
> + * struct vsc73xx_bridge_vlan - VSC73xx driver structure which keeps vlan
> + *	database copy
> + * @vid: VLAN number
> + * @portmask: each bit represends one port

represents

> + * @untagged: each bit represends one port configured with @vid untagged

represents

> + * @list: list structure
> + */
> +struct vsc73xx_bridge_vlan {
> +	u16 vid;
> +	u8 portmask;
> +	u8 untagged;
> +	struct list_head list;
> +};
> +
>  int vsc73xx_is_addr_valid(u8 block, u8 subblock);
>  int vsc73xx_probe(struct vsc73xx *vsc);
>  void vsc73xx_remove(struct vsc73xx *vsc);
> -- 
> 2.34.1
> 

