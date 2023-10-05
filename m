Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFB97BA0F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbjJEOnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjJEOiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296544F068
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696514436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5aLdlzVl6iLHoL52j1448MA1fKXii3phroReUGkrwg=;
        b=E+B5pKUEbemTCVFfw//+4UU45jWoOHayZNFDGgHVPnJj8PvN3Y8iA+S7nbq0EoUCdSPyM0
        d9RArTMbwKR31YZU5p9dHO19WyriOW2M9Vr4D37TfLbTINwuumAP2Yhrjeh1nuA3SbsQDh
        dVKLG86+FWyMk3ltd2NyaSUFQgWl5eI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-jsHP0-ZkM5Ga_EDQHr0I6g-1; Thu, 05 Oct 2023 03:57:48 -0400
X-MC-Unique: jsHP0-ZkM5Ga_EDQHr0I6g-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-53479f2bfb7so80057a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 00:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696492667; x=1697097467;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5aLdlzVl6iLHoL52j1448MA1fKXii3phroReUGkrwg=;
        b=IPMtRGEodhRL4HatlCk0geMEQVMxTYBc4syBC3KQR0Q2qnXwiRbC1j8Wwxqq1riFxb
         mMOclFWZsfDIebiIR6ygDR1g5mx1w6805Qs1jjc8Vs6MC8V+Muu3CaPkMJQ3OSI3KIDA
         gS+T7JCLzl/k3tu3dekyg8Kvn4RB2PypfvNYDcPIixzBICql2MMSTAvTXm4b0+J/wfVU
         bYCBfknGjsh8Sm1gpXwv16bTwAYqRdoTJ6AmSloJWSE3ck3kSC59pxysrjrPjPCGSOQT
         DQTX/ZajhRDLnBOJVDxG+AuhNb2NFt8dMXjPcDN2/b14gOEMZnLqjqyfQRNxTvC7/4GL
         ZO8A==
X-Gm-Message-State: AOJu0YyG+o2d//7z6mhSUqvApPfII1p52ho37Ea6IcYd6t1d6uLrozXx
        ZQvZOSK9Snk4j/WQ0LUhvqxcWB25tLUKJZGdeJPnk6FSmODaI1fqYTws/2VqzQS1ERgX+tDP6qo
        WuFIe627qifLL2JtaekVXKIlL
X-Received: by 2002:a05:6402:4409:b0:52f:bedf:8ef1 with SMTP id y9-20020a056402440900b0052fbedf8ef1mr4382499eda.3.1696492666833;
        Thu, 05 Oct 2023 00:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvFo1Ly5JXwxj6lbDNm/R8YRDPhwf2BarjMZPezDrUV3wOkhWvoBaAbPCxNcfzGcfaHsLYbA==
X-Received: by 2002:a05:6402:4409:b0:52f:bedf:8ef1 with SMTP id y9-20020a056402440900b0052fbedf8ef1mr4382485eda.3.1696492666377;
        Thu, 05 Oct 2023 00:57:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-55.dyn.eolo.it. [146.241.237.55])
        by smtp.gmail.com with ESMTPSA id w10-20020a056402128a00b0053404772535sm643141edv.81.2023.10.05.00.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:57:45 -0700 (PDT)
Message-ID: <7e696ab339e423f987b3fe1d8c1fc9231dd4e92c.camel@redhat.com>
Subject: Re: [PATCH v5 net-next 3/4] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
From:   Paolo Abeni <pabeni@redhat.com>
To:     Roger Quadros <rogerq@kernel.org>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, vladimir.oltean@nxp.com
Cc:     horms@kernel.org, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
        p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 Oct 2023 09:57:44 +0200
In-Reply-To: <20230927072741.21221-4-rogerq@kernel.org>
References: <20230927072741.21221-1-rogerq@kernel.org>
         <20230927072741.21221-4-rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-27 at 10:27 +0300, Roger Quadros wrote:
> Add driver support for viewing / changing the MAC Merge sublayer
> parameters and seeing the verification state machine's current state
> via ethtool.
>=20
> As hardware does not support interrupt notification for verification
> events we resort to polling on link up. On link up we try a couple of
> times for verification success and if unsuccessful then give up.
>=20
> The Frame Preemption feature is described in the Technical Reference
> Manual [1] in section:
> 	12.3.1.4.6.7 Intersperced Express Traffic (IET =E2=80=93 P802.3br/D2.0)
>=20
> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124=
.
>=20
> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pd=
f
>=20
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 150 ++++++++++++
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
>  drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
>  drivers/net/ethernet/ti/am65-cpsw-qos.c     | 240 ++++++++++++++++----
>  drivers/net/ethernet/ti/am65-cpsw-qos.h     | 104 +++++++++
>  5 files changed, 454 insertions(+), 47 deletions(-)
>=20
> Changelog:
> v5:
> - No change
>=20
> v4:
> - Rebase and include in the same series as mqprio support.
>=20
> v3:
> - Rebase on top of v6.6-rc1 and mqprio support [1]
> - Support ethtool_ops :: get_mm_stats()
> - drop unused variables cmn_ctrl and verify_cnt
> - make am65_cpsw_iet_link_state_update() and
>   am65_cpsw_iet_change_preemptible_tcs() static
>=20
> [1] https://lore.kernel.org/all/20230918075358.5878-1-rogerq@kernel.org/
>=20
> v2:
> - Use proper control bits for PMAC enable (AM65_CPSW_PN_CTL_IET_PORT_EN)
>   and TX enable (AM65_CPSW_PN_IET_MAC_PENABLE)
> - Common IET Enable (AM65_CPSW_CTL_IET_EN) is set if any port has
>   AM65_CPSW_PN_CTL_IET_PORT_EN set.
> - Fix workaround for erratum i2208. i.e. Limit rx_min_frag_size to 124
> - Fix am65_cpsw_iet_get_verify_timeout_ms() to default to timeout for
>   1G link if link is inactive.
> - resize the RX FIFO based on pmac_enabled, not tx_enabled.
>=20
> Test Procedure:
>=20
> - 2 EVMs with AM65-CPSW network port connected to each other
> - Run iet-setup-mqprio.sh on both
>=20
> #!/bin/sh
> #iet-setup-mqprio.sh
>=20
> ifconfig eth0 down
> ifconfig eth1 down
> ethtool -L eth0 tx 4
> ethtool --set-mm eth0 pmac-enabled on tx-enabled on verify-enabled on ver=
ify-time 10 tx-min-frag-size 124
> ifconfig eth0 up
> sleep 10
>=20
> tc qdisc add dev eth0 handle 100: root mqprio \
> num_tc 4 \
> map 0 1 2 3 \
> queues 1@0 1@1 1@2 1@3 \
> hw 1 \
> mode dcb \
> fp P P P E
>=20
> tc -g class show dev eth0
> tc qdisc add dev eth0 clsact
> tc filter add dev eth0 egress protocol ip prio 1 u32 match ip dport 5002 =
0xffff action skbedit priority 2
> tc filter add dev eth0 egress protocol ip prio 1 u32 match ip dport 5003 =
0xffff action skbedit priority 3
> ip addr add 192.168.3.102/24 dev eth0=20
>=20
> - check that MAC merge verification has succeeded
>=20
> ethtool --show-mm eth0
>=20
>         MAC Merge layer state for eth0:
>         pMAC enabled: on
>         TX enabled: on
>         TX active: on
>         TX minimum fragment size: 124
>         RX minimum fragment size: 124
>         Verify enabled: on
>         Verify time: 10
>         Max verify time: 134
>         Verification status: SUCCEEDED
>=20
> - On receiver EVM run 2 iperf instances
>=20
> iperf3 -s -i30 -p5002&
> iperf3 -s -i30 -p5003&
>=20
> - On sender EVM run 2 iperf instances
>=20
> iperf3 -c 192.168.3.102 -u -b200M -l1472 -u -t5 -i30 -p5002&
> iperf3 -c 192.168.3.102 -u -b50M -l1472 -u -t5 -i30 -p5003&
>=20
> - Check IET stats on sender. Look for MACMergeFragCountTx: increments
>=20
> ethtool -I --show-mm eth0
> MAC Merge layer state for eth0:
> pMAC enabled: on
> TX enabled: on
> TX active: on
> TX minimum fragment size: 124
> RX minimum fragment size: 124
> Verify enabled: on
> Verify time: 10
> Max verify time: 134
> Verification status: SUCCEEDED
> Statistics:
>   MACMergeFrameAssErrorCount: 0
>   MACMergeFrameSmdErrorCount: 0
>   MACMergeFrameAssOkCount: 0
>   MACMergeFragCountRx: 0
>   MACMergeFragCountTx: 57824
>   MACMergeHoldCount: 0
>=20
> - Check IET stats on receiver. Look for MACMergeFragCountRx: and
>   MACMergeFrameAssOkCount:
>=20
> ethtool -I --show-mm eth0
> MAC Merge layer state for eth0:
> pMAC enabled: on
> TX enabled: on
> TX active: on
> TX minimum fragment size: 124
> RX minimum fragment size: 124
> Verify enabled: on
> Verify time: 10
> Max verify time: 134
> Verification status: SUCCEEDED
> Statistics:
>   MACMergeFrameAssErrorCount: 0
>   MACMergeFrameSmdErrorCount: 0
>   MACMergeFrameAssOkCount: 57018
>   MACMergeFragCountRx: 57824
>   MACMergeFragCountTx: 0
>   MACMergeHoldCount: 0
>=20
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/et=
hernet/ti/am65-cpsw-ethtool.c
> index c51e2af91f69..f6b081b7e754 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> @@ -11,6 +11,7 @@
>  #include <linux/pm_runtime.h>
> =20
>  #include "am65-cpsw-nuss.h"
> +#include "am65-cpsw-qos.h"
>  #include "cpsw_ale.h"
>  #include "am65-cpts.h"
> =20
> @@ -715,6 +716,152 @@ static int am65_cpsw_set_ethtool_priv_flags(struct =
net_device *ndev, u32 flags)
>  	return 0;
>  }
> =20
> +static void am65_cpsw_port_iet_rx_enable(struct am65_cpsw_port *port, bo=
ol enable)
> +{
> +	u32 val;
> +
> +	val =3D readl(port->port_base + AM65_CPSW_PN_REG_CTL);
> +	if (enable)
> +		val |=3D AM65_CPSW_PN_CTL_IET_PORT_EN;
> +	else
> +		val &=3D ~AM65_CPSW_PN_CTL_IET_PORT_EN;
> +
> +	writel(val, port->port_base + AM65_CPSW_PN_REG_CTL);
> +	am65_cpsw_iet_common_enable(port->common);
> +}
> +
> +static void am65_cpsw_port_iet_tx_enable(struct am65_cpsw_port *port, bo=
ol enable)
> +{
> +	u32 val;
> +
> +	val =3D readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +	if (enable)
> +		val |=3D AM65_CPSW_PN_IET_MAC_PENABLE;
> +	else
> +		val &=3D ~AM65_CPSW_PN_IET_MAC_PENABLE;
> +
> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +}
> +
> +static int am65_cpsw_get_mm(struct net_device *ndev, struct ethtool_mm_s=
tate *state)
> +{
> +	struct am65_cpsw_port *port =3D am65_ndev_to_port(ndev);
> +	struct am65_cpsw_ndev_priv *priv =3D netdev_priv(ndev);
> +	u32 port_ctrl, iet_ctrl, iet_status;
> +	u32 add_frag_size;
> +
> +	mutex_lock(&priv->mm_lock);
> +
> +	iet_ctrl =3D readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +	port_ctrl =3D readl(port->port_base + AM65_CPSW_PN_REG_CTL);
> +
> +	state->tx_enabled =3D !!(iet_ctrl & AM65_CPSW_PN_IET_MAC_PENABLE);
> +	state->pmac_enabled =3D !!(port_ctrl & AM65_CPSW_PN_CTL_IET_PORT_EN);
> +
> +	iet_status =3D readl(port->port_base + AM65_CPSW_PN_REG_IET_STATUS);
> +
> +	if (iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY)
> +		state->verify_status =3D ETHTOOL_MM_VERIFY_STATUS_DISABLED;
> +	else if (iet_status & AM65_CPSW_PN_MAC_VERIFIED)
> +		state->verify_status =3D ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
> +	else if (iet_status & AM65_CPSW_PN_MAC_VERIFY_FAIL)
> +		state->verify_status =3D ETHTOOL_MM_VERIFY_STATUS_FAILED;
> +	else
> +		state->verify_status =3D ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
> +
> +	add_frag_size =3D AM65_CPSW_PN_IET_MAC_GET_ADDFRAGSIZE(iet_ctrl);
> +	state->tx_min_frag_size =3D ethtool_mm_frag_size_add_to_min(add_frag_si=
ze);
> +
> +	/* Errata i2208: RX min fragment size cannot be less than 124 */
> +	state->rx_min_frag_size =3D 124;
> +
> +	/* FPE active if common tx_enabled and verification success or disabled=
 (forced) */
> +	state->tx_active =3D state->tx_enabled &&
> +			   (state->verify_status =3D=3D ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
> +			    state->verify_status =3D=3D ETHTOOL_MM_VERIFY_STATUS_DISABLED);
> +	state->verify_enabled =3D !(iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERI=
FY);
> +
> +	state->verify_time =3D port->qos.iet.verify_time_ms;
> +	state->max_verify_time =3D am65_cpsw_iet_get_verify_timeout_ms(AM65_CPS=
W_PN_MAC_VERIFY_CNT_MASK,
> +								     port);
> +	mutex_unlock(&priv->mm_lock);
> +
> +	return 0;
> +}
> +
> +static int am65_cpsw_set_mm(struct net_device *ndev, struct ethtool_mm_c=
fg *cfg,
> +			    struct netlink_ext_ack *extack)
> +{
> +	struct am65_cpsw_port *port =3D am65_ndev_to_port(ndev);
> +	struct am65_cpsw_ndev_priv *priv =3D netdev_priv(ndev);
> +	struct am65_cpsw_iet *iet =3D &port->qos.iet;
> +	u32 val, add_frag_size;
> +	int err;
> +
> +	err =3D ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size, &add_fra=
g_size, extack);
> +	if (err)
> +		return err;
> +
> +	mutex_lock(&priv->mm_lock);
> +
> +	if (cfg->pmac_enabled) {
> +		/* change TX & RX FIFO MAX_BLKS as per TRM recommendation */
> +		if (!iet->original_max_blks)
> +			iet->original_max_blks =3D readl(port->port_base + AM65_CPSW_PN_REG_M=
AX_BLKS);
> +
> +		writel(AM65_CPSW_PN_TX_RX_MAX_BLKS_IET,
> +		       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
> +	} else {
> +		/* restore RX & TX FIFO MAX_BLKS */
> +		if (iet->original_max_blks) {
> +			writel(iet->original_max_blks,
> +			       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
> +		}
> +	}
> +
> +	am65_cpsw_port_iet_rx_enable(port, cfg->pmac_enabled);
> +	am65_cpsw_port_iet_tx_enable(port, cfg->tx_enabled);
> +
> +	val =3D readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +	if (cfg->verify_enabled) {
> +		val &=3D ~AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
> +		/* Reset Verify state machine. Verification won't start here.
> +		 * Verification will be done once link-up.
> +		 */
> +		val |=3D AM65_CPSW_PN_IET_MAC_LINKFAIL;
> +	} else {
> +		val |=3D AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
> +	}
> +
> +	val &=3D ~AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK;
> +	val |=3D AM65_CPSW_PN_IET_MAC_SET_ADDFRAGSIZE(add_frag_size);
> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +
> +	/* verify_timeout_count can only be set at valid link */
> +	port->qos.iet.verify_time_ms =3D cfg->verify_time;
> +
> +	/* enable/disable pre-emption based on link status */
> +	am65_cpsw_iet_commit_preemptible_tcs(port);
> +
> +	mutex_unlock(&priv->mm_lock);
> +
> +	return 0;
> +}
> +
> +static void am65_cpsw_get_mm_stats(struct net_device *ndev,
> +				   struct ethtool_mm_stats *s)
> +{
> +	struct am65_cpsw_port *port =3D am65_ndev_to_port(ndev);
> +	void __iomem *base =3D port->stat_base;
> +
> +	s->MACMergeFrameAssOkCount =3D readl(base + AM65_CPSW_STATN_IET_RX_ASSE=
MBLY_OK);
> +	s->MACMergeFrameAssErrorCount =3D readl(base + AM65_CPSW_STATN_IET_RX_A=
SSEMBLY_ERROR);
> +	s->MACMergeFrameSmdErrorCount =3D readl(base + AM65_CPSW_STATN_IET_RX_S=
MD_ERROR);
> +	s->MACMergeFragCountRx =3D readl(base + AM65_CPSW_STATN_IET_RX_FRAG);
> +	s->MACMergeFragCountTx =3D readl(base + AM65_CPSW_STATN_IET_TX_FRAG);
> +	s->MACMergeHoldCount =3D readl(base + AM65_CPSW_STATN_IET_TX_HOLD);
> +}
> +
>  const struct ethtool_ops am65_cpsw_ethtool_ops_slave =3D {
>  	.begin			=3D am65_cpsw_ethtool_op_begin,
>  	.complete		=3D am65_cpsw_ethtool_op_complete,
> @@ -743,4 +890,7 @@ const struct ethtool_ops am65_cpsw_ethtool_ops_slave =
=3D {
>  	.get_eee		=3D am65_cpsw_get_eee,
>  	.set_eee		=3D am65_cpsw_set_eee,
>  	.nway_reset		=3D am65_cpsw_nway_reset,
> +	.get_mm			=3D am65_cpsw_get_mm,
> +	.set_mm			=3D am65_cpsw_set_mm,
> +	.get_mm_stats		=3D am65_cpsw_get_mm_stats,
>  };
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ether=
net/ti/am65-cpsw-nuss.c
> index bea6fc0f324c..2004f6a020d3 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -2161,6 +2161,8 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_comm=
on *common, u32 port_idx)
>  	ndev_priv =3D netdev_priv(port->ndev);
>  	ndev_priv->port =3D port;
>  	ndev_priv->msg_enable =3D AM65_CPSW_DEBUG;
> +	mutex_init(&ndev_priv->mm_lock);
> +	port->qos.link_speed =3D SPEED_UNKNOWN;
>  	SET_NETDEV_DEV(port->ndev, dev);
> =20
>  	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ether=
net/ti/am65-cpsw-nuss.h
> index f3dad2ab9828..1e4a045057fc 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
> @@ -145,6 +145,7 @@ struct am65_cpsw_common {
>  	bool			pf_p0_rx_ptype_rrobin;
>  	struct am65_cpts	*cpts;
>  	int			est_enabled;
> +	bool			iet_enabled;
> =20
>  	bool		is_emac_mode;
>  	u16			br_members;
> @@ -170,6 +171,10 @@ struct am65_cpsw_ndev_priv {
>  	struct am65_cpsw_port	*port;
>  	struct am65_cpsw_ndev_stats __percpu *stats;
>  	bool offload_fwd_mark;
> +	/* Serialize access to MAC Merge state between ethtool requests
> +	 * and link state updates
> +	 */
> +	struct mutex		mm_lock;
>  };
> =20
>  #define am65_ndev_to_priv(ndev) \
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethern=
et/ti/am65-cpsw-qos.c
> index 991221d8f148..ec2986e79edd 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
> @@ -4,9 +4,11 @@
>   *
>   * quality of service module includes:
>   * Enhanced Scheduler Traffic (EST - P802.1Qbv/D2.2)
> + * Interspersed Express Traffic (IET - P802.3br/D2.0)
>   */
> =20
>  #include <linux/pm_runtime.h>
> +#include <linux/units.h>
>  #include <linux/time.h>
>  #include <net/pkt_cls.h>
> =20
> @@ -15,50 +17,6 @@
>  #include "am65-cpts.h"
>  #include "cpsw_ale.h"
> =20
> -#define AM65_CPSW_REG_CTL			0x004
> -#define AM65_CPSW_P0_REG_TX_PRI_MAP		0x018
> -#define AM65_CPSW_P0_REG_RX_PRI_MAP		0x020
> -#define AM65_CPSW_P0_REG_FIFO_STATUS		0x050
> -#define AM65_CPSW_P0_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
> -#define AM65_CPSW_P0_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
> -
> -#define AM65_CPSW_PN_REG_CTL			0x004
> -#define AM65_CPSW_PN_REG_TX_PRI_MAP		0x018
> -#define AM65_CPSW_PN_REG_RX_PRI_MAP		0x020
> -#define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
> -#define AM65_CPSW_PN_REG_EST_CTL		0x060
> -#define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
> -#define AM65_CPSW_PN_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
> -
> -/* AM65_CPSW_REG_CTL register fields */
> -#define AM65_CPSW_CTL_EST_EN			BIT(18)
> -
> -/* AM65_CPSW_PN_REG_CTL register fields */
> -#define AM65_CPSW_PN_CTL_EST_PORT_EN		BIT(17)
> -
> -/* AM65_CPSW_PN_REG_EST_CTL register fields */
> -#define AM65_CPSW_PN_EST_ONEBUF			BIT(0)
> -#define AM65_CPSW_PN_EST_BUFSEL			BIT(1)
> -#define AM65_CPSW_PN_EST_TS_EN			BIT(2)
> -#define AM65_CPSW_PN_EST_TS_FIRST		BIT(3)
> -#define AM65_CPSW_PN_EST_ONEPRI			BIT(4)
> -#define AM65_CPSW_PN_EST_TS_PRI_MSK		GENMASK(7, 5)
> -
> -/* AM65_CPSW_PN_REG_FIFO_STATUS register fields */
> -#define AM65_CPSW_PN_FST_TX_PRI_ACTIVE_MSK	GENMASK(7, 0)
> -#define AM65_CPSW_PN_FST_TX_E_MAC_ALLOW_MSK	GENMASK(15, 8)
> -#define AM65_CPSW_PN_FST_EST_CNT_ERR		BIT(16)
> -#define AM65_CPSW_PN_FST_EST_ADD_ERR		BIT(17)
> -#define AM65_CPSW_PN_FST_EST_BUFACT		BIT(18)
> -
> -/* EST FETCH COMMAND RAM */
> -#define AM65_CPSW_FETCH_RAM_CMD_NUM		0x80
> -#define AM65_CPSW_FETCH_CNT_MSK			GENMASK(21, 8)
> -#define AM65_CPSW_FETCH_CNT_MAX			(AM65_CPSW_FETCH_CNT_MSK >> 8)
> -#define AM65_CPSW_FETCH_CNT_OFFSET		8
> -#define AM65_CPSW_FETCH_ALLOW_MSK		GENMASK(7, 0)
> -#define AM65_CPSW_FETCH_ALLOW_MAX		AM65_CPSW_FETCH_ALLOW_MSK
> -
>  #define TO_MBPS(x)	((x) * 8 / 1000000)
> =20
>  enum timer_act {
> @@ -67,10 +25,193 @@ enum timer_act {
>  	TACT_SKIP_PROG,		/* just buffer can be updated */
>  };
> =20
> -/* number of priority queues per port FIFO */
> -#define AM65_CPSW_PN_FIFO_PRIO_NUM		8
> -#define AM65_CPSW_PN_TX_PRI_MAP_DEFAULT		0x76543210
> +/* IET */
> +static int am65_cpsw_iet_set_verify_timeout_count(struct am65_cpsw_port =
*port)
> +{
> +	int verify_time_ms =3D port->qos.iet.verify_time_ms;
> +	int link_speed =3D port->qos.link_speed;
> +	u32 val;
> +
> +	if (WARN_ON(link_speed =3D=3D SPEED_UNKNOWN))
> +		return -ENODEV;
> +
> +	/* The number of wireside clocks contained in the verify
> +	 * timeout counter. The default is 0x1312d0
> +	 * (10ms at 125Mhz in 1G mode).
> +	 */
> +	val =3D 125 * HZ_PER_MHZ;	/* assuming 125MHz wireside clock */
> +
> +	val /=3D MILLIHZ_PER_HZ;		/* count per ms timeout */
> +	val *=3D verify_time_ms;		/* count for timeout ms */
> +	if (link_speed < SPEED_1000)
> +		val <<=3D 1;	/* FIXME: Is this correct? */
> +
> +	if (val > AM65_CPSW_PN_MAC_VERIFY_CNT_MASK)
> +		return -EINVAL;
> +
> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_VERIFY);
> +
> +	return 0;
> +}
> +
> +unsigned int am65_cpsw_iet_get_verify_timeout_ms(u32 count, struct am65_=
cpsw_port *port)
> +{
> +	int link_speed =3D port->qos.link_speed;
> +	u32 val =3D 125 * HZ_PER_MHZ;	/* assuming 125MHz wireside clock */
> +	unsigned int timeout_ms;
> +
> +	if (link_speed =3D=3D SPEED_UNKNOWN)
> +		link_speed =3D SPEED_1000;
> +
> +	val /=3D MILLIHZ_PER_HZ;		/* count per ms timeout */
> +
> +	timeout_ms =3D count / val;
> +
> +	if (link_speed < SPEED_1000)
> +		timeout_ms >>=3D 1;	/* FIXME: Is this correct? */
> +
> +	return timeout_ms;
> +}
> +
> +static int am65_cpsw_iet_verify_wait(struct am65_cpsw_port *port)
> +{
> +	u32 ctrl, status;
> +	int try;
> +
> +	try =3D 20;
> +	do {
> +		/* Clear MAC_LINKFAIL bit to start Verify. */
> +		ctrl =3D readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +		ctrl &=3D ~AM65_CPSW_PN_IET_MAC_LINKFAIL;
> +		writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +
> +		msleep(port->qos.iet.verify_time_ms);
> +
> +		status =3D readl(port->port_base + AM65_CPSW_PN_REG_IET_STATUS);
> +		if (status & AM65_CPSW_PN_MAC_VERIFIED)
> +			return 0;
> +
> +		if (status & AM65_CPSW_PN_MAC_VERIFY_FAIL) {
> +			netdev_dbg(port->ndev,
> +				   "MAC Merge verify failed, trying again");
> +			/* Reset the verify state machine by writing 1
> +			 * to LINKFAIL
> +			 */
> +			ctrl =3D readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +			ctrl |=3D AM65_CPSW_PN_IET_MAC_LINKFAIL;
> +			writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +			continue;
> +		}
> +
> +		if (status & AM65_CPSW_PN_MAC_RESPOND_ERR) {
> +			netdev_dbg(port->ndev, "MAC Merge respond error");
> +			return -ENODEV;
> +		}
> +
> +		if (status & AM65_CPSW_PN_MAC_VERIFY_ERR) {
> +			netdev_dbg(port->ndev, "MAC Merge verify error");
> +			return -ENODEV;
> +		}
> +	} while (try-- > 0);
> +
> +	netdev_dbg(port->ndev, "MAC Merge verify timeout");
> +	return -ETIMEDOUT;
> +}
> +
> +static void am65_cpsw_iet_set_preempt_mask(struct am65_cpsw_port *port, =
u8 preemptible_tcs)
> +{
> +	u32 val;
> +
> +	val =3D readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +	val &=3D ~AM65_CPSW_PN_IET_MAC_PREMPT_MASK;
> +	val |=3D AM65_CPSW_PN_IET_MAC_SET_PREEMPT(preemptible_tcs);
> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +}
> +
> +/* enable common IET_ENABLE only if at least 1 port has rx IET enabled.
> + * UAPI doesn't allow tx enable without rx enable.
> + */
> +void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common)
> +{
> +	struct am65_cpsw_port *port;
> +	bool rx_enable =3D false;
> +	u32 val;
> +	int i;
> +
> +	for (i =3D 0; i < common->port_num; i++) {
> +		port =3D &common->ports[i];
> +		val =3D readl(port->port_base + AM65_CPSW_PN_REG_CTL);
> +		rx_enable =3D !!(val & AM65_CPSW_PN_CTL_IET_PORT_EN);
> +		if (rx_enable)
> +			break;
> +	}
> +
> +	val =3D readl(common->cpsw_base + AM65_CPSW_REG_CTL);
> +
> +	if (rx_enable)
> +		val |=3D AM65_CPSW_CTL_IET_EN;
> +	else
> +		val &=3D ~AM65_CPSW_CTL_IET_EN;
> +
> +	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);
> +	common->iet_enabled =3D rx_enable;
> +}
> +
> +/* CPSW does not have an IRQ to notify changes to the MAC Merge TX statu=
s
> + * (active/inactive), but the preemptible traffic classes should only be
> + * committed to hardware once TX is active. Resort to polling.
> + */
> +void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port)
> +{
> +	u8 preemptible_tcs =3D 0;
> +	int err;
> +	u32 val;
> +
> +	if (port->qos.link_speed =3D=3D SPEED_UNKNOWN)
> +		return;
> +
> +	val =3D readl(port->port_base + AM65_CPSW_PN_REG_CTL);
> +	if (!(val & AM65_CPSW_PN_CTL_IET_PORT_EN))
> +		return;
> +
> +	/* update common IET enable */
> +	am65_cpsw_iet_common_enable(port->common);
> =20
> +	/* update verify count */
> +	err =3D am65_cpsw_iet_set_verify_timeout_count(port);
> +	if (err) {
> +		netdev_err(port->ndev, "couldn't set verify count: %d\n", err);
> +		return;
> +	}
> +
> +	val =3D readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +	if (!(val & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY)) {
> +		err =3D am65_cpsw_iet_verify_wait(port);
> +		if (err)
> +			return;
> +	}
> +
> +	preemptible_tcs =3D port->qos.iet.preemptible_tcs;
> +	am65_cpsw_iet_set_preempt_mask(port, preemptible_tcs);
> +}
> +
> +static void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *=
port, u8 preemptible_tcs)
> +{
> +	port->qos.iet.preemptible_tcs =3D preemptible_tcs;
> +	am65_cpsw_iet_commit_preemptible_tcs(port);

I'm sorry for the late feedback, but I was unable to notice the
following before.

It looks like am65_cpsw_iet_commit_preemptible_tcs() is always invoked
with the priv->mm_lock lock held, except in the above call that can be
reached without such lock held, via the am65_cpsw_qos_ndo_setup_tc().

Is that safe? If so I think it deserves at least a comment in the code.

Cheers,

Paolo

