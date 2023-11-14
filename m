Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4957EB476
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjKNQIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjKNQH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:07:59 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFFF13D;
        Tue, 14 Nov 2023 08:07:56 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8D0805C02A6;
        Tue, 14 Nov 2023 11:07:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 14 Nov 2023 11:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1699978075; x=
        1700064475; bh=20tfSKNtHL+rKOlEuM96Y15IraCN16Lw4pR+Bb7sBnM=; b=n
        uz9FySiZwgmabLbS+33isxpTquEj7qDTwpswH6tug+s/deFbwh465LwmfjzhGa0a
        b9k/HD8UWNSJFAQmIeYQ5AmBwv0GI4c0368yaMQoxCHRdUioHJw+MXRkZd1D40ir
        x2jCjPtzJgeMTOqpIDMrSMsBh+EULWRIPHgET6ucSvRjhRkT/IXrxB6Xj5tpWTnV
        PjLNBB+Gk30kTiaQIKOJJAx+xjRmw2xrO8Iw6hlONMnOUPPewF3rsgm8CriAlC/n
        zfWFt9vjod1peaTI3TGKt549NmoG1ZE8PGlUTYisqcFcDdF9zsl65Vh0hf3ld8ly
        3WT9ZemJNd2R59VE20l5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1699978075; x=
        1700064475; bh=20tfSKNtHL+rKOlEuM96Y15IraCN16Lw4pR+Bb7sBnM=; b=t
        uRA20ZQNoGPMXxR8yH1MzaBsgatm/pc2QgyCUE3NS69RLfS61OZark6Gxxcna7Hm
        WLm6UjJYqLkMMyew0cDA0svi9bDPunWBb+hpZLYQEvk+EVvpY644neuCM1tqFVD0
        +hAJEailPRdIMNKfzbOx/LDNYM+I35IP7Pz0UZcAqKDHigKtHPFhY5bmHSeo/8Cz
        5KjR/ULCmFdhpaL0gHWR6BNhE5IbKY8v3jeDTolwnClW+pCF+Xv2bDMijDnPvude
        skg2sfLybP0m+MxEPUywuA946/wvCjKaSLurZrm47IcwQicH668FFv3PNsPOpgzs
        jJHnUkx8UeF9YQb4H5r6g==
X-ME-Sender: <xms:W5tTZc1FSEtx_CwNLhEQ4QX9S2Aq1Dvyl25QtRxEPxDJmcisVmZgiA>
    <xme:W5tTZXECbmPRP0X01JdTr3qx9LPdmi9Dq9Di5mjBBUxQlb09FYXyF382jYg8xoZ8E
    4rCOB2Q9huYkMVaCyQ>
X-ME-Received: <xmr:W5tTZU7olGFBczUG3xNfC1Qfl7BO5Oo9XIEX9x0MJYdPY0-KDjeo-omL-k7KcSKKCgl6dAxqx3gZg2_4dBkx_85gXka85fBnHMs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefvddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertder
    tddtnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeejffekudffkeefiedtjeelgeej
    hfffgeffgedvgfffleevgfekkeetffdtheefhfenucffohhmrghinhepughmthhfrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgr
    thhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:W5tTZV1p6GWv88jJ9dVAJ4NPqXxpyV3LzNgl6g2G2FmwCUo5WbnOdg>
    <xmx:W5tTZfEunjZ6IQ3fJ-vbeuXV6FKxXhyd_1D96mPiIaAb-1NUy9SWgA>
    <xmx:W5tTZe8emSTO7Vr-OhilWG1VSvnRtCbCZa5QDV0ceNTVg_FawXs6HQ>
    <xmx:W5tTZe0KkYgPJa4G9rx1SJct61ICzChuImbGPH3XzgiMYLPSgaCI0g>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Nov 2023 11:07:54 -0500 (EST)
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Peter Delevoryas <peter@pjd.dev>,
        Patrick Williams <patrick@stwcx.xyz>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/3] net/ncsi: Add NC-SI 1.2 Get MC MAC Address command
Date:   Tue, 14 Nov 2023 10:07:35 -0600
Message-ID: <20231114160737.3209218-4-patrick@stwcx.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114160737.3209218-1-patrick@stwcx.xyz>
References: <20231114160737.3209218-1-patrick@stwcx.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Delevoryas <peter@pjd.dev>

This change adds support for the NC-SI 1.2 Get MC MAC Address command,
specified here:

https://www.dmtf.org/sites/default/files/standards/documents/DSP0222_1.2.0.pdf

It serves the exact same function as the existing OEM Get MAC Address
commands, so if a channel reports that it supports NC-SI 1.2, we prefer
to use the standard command rather than the OEM command.

Verified with an invalid MAC address and 2 valid ones:

[   55.137072] ftgmac100 1e690000.ftgmac eth0: NCSI: Received 3 provisioned MAC addresses
[   55.137614] ftgmac100 1e690000.ftgmac eth0: NCSI: MAC address 0: 00:00:00:00:00:00
[   55.138026] ftgmac100 1e690000.ftgmac eth0: NCSI: MAC address 1: fa:ce:b0:0c:20:22
[   55.138528] ftgmac100 1e690000.ftgmac eth0: NCSI: MAC address 2: fa:ce:b0:0c:20:23
[   55.139241] ftgmac100 1e690000.ftgmac eth0: NCSI: Unable to assign 00:00:00:00:00:00 to device
[   55.140098] ftgmac100 1e690000.ftgmac eth0: NCSI: Set MAC address to fa:ce:b0:0c:20:22

Signed-off-by: Peter Delevoryas <peter@pjd.dev>
Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 net/ncsi/ncsi-cmd.c    |  3 ++-
 net/ncsi/ncsi-manage.c |  9 +++++++--
 net/ncsi/ncsi-pkt.h    | 10 ++++++++++
 net/ncsi/ncsi-rsp.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/net/ncsi/ncsi-cmd.c b/net/ncsi/ncsi-cmd.c
index fd2236ee9a79..b3ff37a181d7 100644
--- a/net/ncsi/ncsi-cmd.c
+++ b/net/ncsi/ncsi-cmd.c
@@ -270,7 +270,8 @@ static struct ncsi_cmd_handler {
 	{ NCSI_PKT_CMD_GPS,    0, ncsi_cmd_handler_default },
 	{ NCSI_PKT_CMD_OEM,   -1, ncsi_cmd_handler_oem     },
 	{ NCSI_PKT_CMD_PLDM,   0, NULL                     },
-	{ NCSI_PKT_CMD_GPUUID, 0, ncsi_cmd_handler_default }
+	{ NCSI_PKT_CMD_GPUUID, 0, ncsi_cmd_handler_default },
+	{ NCSI_PKT_CMD_GMCMA,  0, ncsi_cmd_handler_default }
 };
 
 static struct ncsi_request *ncsi_alloc_command(struct ncsi_cmd_arg *nca)
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index f3d7fe86fea1..745c788f1d1d 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1038,11 +1038,16 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 	case ncsi_dev_state_config_oem_gma:
 		nd->state = ncsi_dev_state_config_clear_vids;
 
-		nca.type = NCSI_PKT_CMD_OEM;
 		nca.package = np->id;
 		nca.channel = nc->id;
 		ndp->pending_req_num = 1;
-		ret = ncsi_gma_handler(&nca, nc->version.mf_id);
+		if (nc->version.major >= 1 && nc->version.minor >= 2) {
+			nca.type = NCSI_PKT_CMD_GMCMA;
+			ret = ncsi_xmit_cmd(&nca);
+		} else {
+			nca.type = NCSI_PKT_CMD_OEM;
+			ret = ncsi_gma_handler(&nca, nc->version.mf_id);
+		}
 		if (ret < 0)
 			schedule_work(&ndp->work);
 
diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
index c9d1da34dc4d..f2f3b5c1b941 100644
--- a/net/ncsi/ncsi-pkt.h
+++ b/net/ncsi/ncsi-pkt.h
@@ -338,6 +338,14 @@ struct ncsi_rsp_gpuuid_pkt {
 	__be32                  checksum;
 };
 
+/* Get MC MAC Address */
+struct ncsi_rsp_gmcma_pkt {
+	struct ncsi_rsp_pkt_hdr rsp;
+	unsigned char           address_count;
+	unsigned char           reserved[3];
+	unsigned char           addresses[][ETH_ALEN];
+};
+
 /* AEN: Link State Change */
 struct ncsi_aen_lsc_pkt {
 	struct ncsi_aen_pkt_hdr aen;        /* AEN header      */
@@ -398,6 +406,7 @@ struct ncsi_aen_hncdsc_pkt {
 #define NCSI_PKT_CMD_GPUUID	0x52 /* Get package UUID                 */
 #define NCSI_PKT_CMD_QPNPR	0x56 /* Query Pending NC PLDM request */
 #define NCSI_PKT_CMD_SNPR	0x57 /* Send NC PLDM Reply  */
+#define NCSI_PKT_CMD_GMCMA	0x58 /* Get MC MAC Address */
 
 
 /* NCSI packet responses */
@@ -433,6 +442,7 @@ struct ncsi_aen_hncdsc_pkt {
 #define NCSI_PKT_RSP_GPUUID	(NCSI_PKT_CMD_GPUUID + 0x80)
 #define NCSI_PKT_RSP_QPNPR	(NCSI_PKT_CMD_QPNPR   + 0x80)
 #define NCSI_PKT_RSP_SNPR	(NCSI_PKT_CMD_SNPR   + 0x80)
+#define NCSI_PKT_RSP_GMCMA	(NCSI_PKT_CMD_GMCMA  + 0x80)
 
 /* NCSI response code/reason */
 #define NCSI_PKT_RSP_C_COMPLETED	0x0000 /* Command Completed        */
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 480e80e3c283..bee290d0f48b 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -1091,6 +1091,44 @@ static int ncsi_rsp_handler_netlink(struct ncsi_request *nr)
 	return ret;
 }
 
+static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
+{
+	struct ncsi_dev_priv *ndp = nr->ndp;
+	struct net_device *ndev = ndp->ndev.dev;
+	struct ncsi_rsp_gmcma_pkt *rsp;
+	struct sockaddr saddr;
+	int ret = -1;
+	int i;
+
+	rsp = (struct ncsi_rsp_gmcma_pkt *)skb_network_header(nr->rsp);
+	saddr.sa_family = ndev->type;
+	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+
+	netdev_info(ndev, "NCSI: Received %d provisioned MAC addresses\n",
+		    rsp->address_count);
+	for (i = 0; i < rsp->address_count; i++) {
+		netdev_info(ndev, "NCSI: MAC address %d: %02x:%02x:%02x:%02x:%02x:%02x\n",
+			    i, rsp->addresses[i][0], rsp->addresses[i][1],
+			    rsp->addresses[i][2], rsp->addresses[i][3],
+			    rsp->addresses[i][4], rsp->addresses[i][5]);
+	}
+
+	for (i = 0; i < rsp->address_count; i++) {
+		memcpy(saddr.sa_data, &rsp->addresses[i], ETH_ALEN);
+		ret = ndev->netdev_ops->ndo_set_mac_address(ndev, &saddr);
+		if (ret < 0) {
+			netdev_warn(ndev, "NCSI: Unable to assign %pM to device\n",
+				    saddr.sa_data);
+			continue;
+		}
+		netdev_warn(ndev, "NCSI: Set MAC address to %pM\n", saddr.sa_data);
+		break;
+	}
+
+	ndp->gma_flag = ret == 0;
+	return ret;
+}
+
 static struct ncsi_rsp_handler {
 	unsigned char	type;
 	int             payload;
@@ -1127,7 +1165,8 @@ static struct ncsi_rsp_handler {
 	{ NCSI_PKT_RSP_PLDM,   -1, ncsi_rsp_handler_pldm    },
 	{ NCSI_PKT_RSP_GPUUID, 20, ncsi_rsp_handler_gpuuid  },
 	{ NCSI_PKT_RSP_QPNPR,  -1, ncsi_rsp_handler_pldm    },
-	{ NCSI_PKT_RSP_SNPR,   -1, ncsi_rsp_handler_pldm    }
+	{ NCSI_PKT_RSP_SNPR,   -1, ncsi_rsp_handler_pldm    },
+	{ NCSI_PKT_RSP_GMCMA,  -1, ncsi_rsp_handler_gmcma   },
 };
 
 int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
-- 
2.41.0

