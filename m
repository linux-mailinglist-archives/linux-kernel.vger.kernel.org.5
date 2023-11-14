Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED097EB474
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjKNQIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjKNQH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:07:57 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD5F132;
        Tue, 14 Nov 2023 08:07:53 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id C92595C02AC;
        Tue, 14 Nov 2023 11:07:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 14 Nov 2023 11:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1699978072; x=
        1700064472; bh=kIut46fx2IEds+GnftD+Puxb3jCN/JHSvCNajszxUrc=; b=F
        d43aS4fP5efyh6m/Qrc09jOR9M3wJUOTP7+Tld62RdpM29wLjQYMmITHC+BvrHU8
        dXMDVOxWnFsDkvJ/ocUq5SLoQHmUNrIlKx2TqkPsMclS1Ddcd2IAgFLEEm3DHgH9
        rAdE5sakxcHSuCCr1SaDnXLqXRik6md8khuu1rTEdmUNIzy+rp6gQfCjlLtMViRT
        DEH8iyCeeE8Ogx4F1tnyYCMaV2fidb+LmzGEZtgtEAOyg4gno8kqQ7m/kH84RTWu
        Y6R2Z3gf3SaBX054m7ri5Ptn18J7F10h+ngVRA9suDWZFZWSGJo2SVcP6W45RxXN
        WlQYmcaRL/YFUk4WX8KPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1699978072; x=
        1700064472; bh=kIut46fx2IEds+GnftD+Puxb3jCN/JHSvCNajszxUrc=; b=C
        /4D1mzyEwHG3nSz92fZDDpb2nFEIVZVpT+bjVOBjYD5MA50zM37LQRS3n/9vvXfq
        JI9DoNe424qCYQ1OF4SZx+XXATHqwEAbj8tMU7xR6TYuOggZ1IPvVoDBfp6PGtl/
        rMewhBt/vo86hNUF1P9c2kcGEhSN7e9uRKKNB5fpnFEJNEamyjFIJaRkj2+scShl
        2uE3Ka7uF43WP69VUjKnlLDvB0sdT1CRo0LJB1UOEnafLOtFa0iWz8z0ehdsgehL
        MkDurzYK+kMxeTmKXOCE0fwsfLNFCoxotYk07UfnfdobcQk1Zjnbs6C7jrYLkHkH
        YIAs6Zh7wozwcI5NGZSFA==
X-ME-Sender: <xms:V5tTZRULtkETzTaeIopdup6Ob8UmS0N_7JZxFf9kBGq3tAxxdFGY3w>
    <xme:V5tTZRmyyT1JqgC3KjPXGyYa2KlHbf__ob62SS4uuViI9NCcKHC1xQOQWITde5EzL
    U1fWkvnoiGU56VVMYE>
X-ME-Received: <xmr:V5tTZdaiT1mJUwiurSPDpuyRXATD_0C8i-QVOxER8FY1eppAYfBLdtQddJCB_l1u9MPaXhjW7_JwhF2RVKmr8ImHzQk3-1WQ3rk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefvddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertder
    tddtnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeejtddvjeetffekleekfeeljeet
    jeelgeefjeejjefhfeetfedvtdejfeehffekveenucffohhmrghinhepughmthhfrdhorh
    hgpdifihhkihhpvgguihgrrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:V5tTZUUFYImaL0gBu3MKyWznWjBhhW58dsg7AHwYTuQbNBTvcEqwPQ>
    <xmx:V5tTZbkAfrBgQHUSXFEXXG9VcSFigbiREl47EGSIi-_60FaYNCd-2A>
    <xmx:V5tTZRchv_OZCUsbeJ_PT1mWZq-51ApDbShKpbRj1Ck-xpEJCtwpGA>
    <xmx:WJtTZd7sJI2vJytcuVkVV_dLKVF9h_uWcYMKjN_0N-ON2qC-gtmufA>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Nov 2023 11:07:51 -0500 (EST)
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        Joel Stanley <joel@jms.id.au>
Cc:     Peter Delevoryas <peter@pjd.dev>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] net/ncsi: Fix netlink major/minor version numbers
Date:   Tue, 14 Nov 2023 10:07:34 -0600
Message-ID: <20231114160737.3209218-3-patrick@stwcx.xyz>
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

The netlink interface for major and minor version numbers doesn't actually
return the major and minor version numbers.

It reports a u32 that contains the (major, minor, update, alpha1)
components as the major version number, and then alpha2 as the minor
version number.

For whatever reason, the u32 byte order was reversed (ntohl): maybe it was
assumed that the encoded value was a single big-endian u32, and alpha2 was
the minor version.

The correct way to get the supported NC-SI version from the network
controller is to parse the Get Version ID response as described in 8.4.44
of the NC-SI spec[1].

    Get Version ID Response Packet Format

              Bits
            +--------+--------+--------+--------+
     Bytes  | 31..24 | 23..16 | 15..8  | 7..0   |
    +-------+--------+--------+--------+--------+
    | 0..15 | NC-SI Header                      |
    +-------+--------+--------+--------+--------+
    | 16..19| Response code   | Reason code     |
    +-------+--------+--------+--------+--------+
    |20..23 | Major  | Minor  | Update | Alpha1 |
    +-------+--------+--------+--------+--------+
    |24..27 |         reserved         | Alpha2 |
    +-------+--------+--------+--------+--------+
    |            .... other stuff ....          |

The major, minor, and update fields are all binary-coded decimal (BCD)
encoded [2]. The spec provides examples below the Get Version ID response
format in section 8.4.44.1, but for practical purposes, this is an example
from a live network card:

    root@bmc:~# ncsi-util 0x15
    NC-SI Command Response:
    cmd: GET_VERSION_ID(0x15)
    Response: COMMAND_COMPLETED(0x0000)  Reason: NO_ERROR(0x0000)
    Payload length = 40

    20: 0xf1 0xf1 0xf0 0x00 <<<<<<<<< (major, minor, update, alpha1)
    24: 0x00 0x00 0x00 0x00 <<<<<<<<< (_, _, _, alpha2)

    28: 0x6d 0x6c 0x78 0x30
    32: 0x2e 0x31 0x00 0x00
    36: 0x00 0x00 0x00 0x00
    40: 0x16 0x1d 0x07 0xd2
    44: 0x10 0x1d 0x15 0xb3
    48: 0x00 0x17 0x15 0xb3
    52: 0x00 0x00 0x81 0x19

This should be parsed as "1.1.0".

"f" in the upper-nibble means to ignore it, contributing zero.

If both nibbles are "f", I think the whole field is supposed to be ignored.
Major and minor are "required", meaning they're not supposed to be "ff",
but the update field is "optional" so I think it can be ff. I think the
simplest thing to do is just set the major and minor to zero instead of
juggling some conditional logic or something.

bcd2bin() from "include/linux/bcd.h" seems to assume both nibbles are 0-9,
so I've provided a custom BCD decoding function.

Alpha1 and alpha2 are ISO/IEC 8859-1 encoded, which just means ASCII
characters as far as I can tell, although the full encoding table for
non-alphabetic characters is slightly different (I think).

I imagine the alpha fields are just supposed to be alphabetic characters,
but I haven't seen any network cards actually report a non-zero value for
either.

If people wrote software against this netlink behavior, and were parsing
the major and minor versions themselves from the u32, then this would
definitely break their code.

[1] https://www.dmtf.org/sites/default/files/standards/documents/DSP0222_1.0.0.pdf
[2] https://en.wikipedia.org/wiki/Binary-coded_decimal
[2] https://en.wikipedia.org/wiki/ISO/IEC_8859-1

Signed-off-by: Peter Delevoryas <peter@pjd.dev>
Fixes: 138635cc27c9 ("net/ncsi: NCSI response packet handler")
---
 net/ncsi/internal.h     |  7 +++++--
 net/ncsi/ncsi-netlink.c |  4 ++--
 net/ncsi/ncsi-pkt.h     |  7 +++++--
 net/ncsi/ncsi-rsp.c     | 26 ++++++++++++++++++++++++--
 4 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 03757e76bb6b..374412ed780b 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -105,8 +105,11 @@ enum {
 
 
 struct ncsi_channel_version {
-	u32 version;		/* Supported BCD encoded NCSI version */
-	u32 alpha2;		/* Supported BCD encoded NCSI version */
+	u8   major;		/* NCSI version major */
+	u8   minor;		/* NCSI version minor */
+	u8   update;		/* NCSI version update */
+	char alpha1;		/* NCSI version alpha1 */
+	char alpha2;		/* NCSI version alpha2 */
 	u8  fw_name[12];	/* Firmware name string                */
 	u32 fw_version;		/* Firmware version                   */
 	u16 pci_ids[4];		/* PCI identification                 */
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index a3a6753a1db7..2f872d064396 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -71,8 +71,8 @@ static int ncsi_write_channel_info(struct sk_buff *skb,
 	if (nc == nc->package->preferred_channel)
 		nla_put_flag(skb, NCSI_CHANNEL_ATTR_FORCED);
 
-	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MAJOR, nc->version.version);
-	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MINOR, nc->version.alpha2);
+	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MAJOR, nc->version.major);
+	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MINOR, nc->version.minor);
 	nla_put_string(skb, NCSI_CHANNEL_ATTR_VERSION_STR, nc->version.fw_name);
 
 	vid_nest = nla_nest_start_noflag(skb, NCSI_CHANNEL_ATTR_VLAN_LIST);
diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
index ba66c7dc3a21..c9d1da34dc4d 100644
--- a/net/ncsi/ncsi-pkt.h
+++ b/net/ncsi/ncsi-pkt.h
@@ -197,9 +197,12 @@ struct ncsi_rsp_gls_pkt {
 /* Get Version ID */
 struct ncsi_rsp_gvi_pkt {
 	struct ncsi_rsp_pkt_hdr rsp;          /* Response header */
-	__be32                  ncsi_version; /* NCSI version    */
+	unsigned char           major;        /* NCSI version major */
+	unsigned char           minor;        /* NCSI version minor */
+	unsigned char           update;       /* NCSI version update */
+	unsigned char           alpha1;       /* NCSI version alpha1 */
 	unsigned char           reserved[3];  /* Reserved        */
-	unsigned char           alpha2;       /* NCSI version    */
+	unsigned char           alpha2;       /* NCSI version alpha2 */
 	unsigned char           fw_name[12];  /* f/w name string */
 	__be32                  fw_version;   /* f/w version     */
 	__be16                  pci_ids[4];   /* PCI IDs         */
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 069c2659074b..480e80e3c283 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -19,6 +19,19 @@
 #include "ncsi-pkt.h"
 #include "ncsi-netlink.h"
 
+/* Nibbles within [0xA, 0xF] add zero "0" to the returned value.
+ * Optional fields (encoded as 0xFF) will default to zero.
+ */
+static u8 decode_bcd_u8(u8 x)
+{
+	int lo = x & 0xF;
+	int hi = x >> 4;
+
+	lo = lo < 0xA ? lo : 0;
+	hi = hi < 0xA ? hi : 0;
+	return lo + hi * 10;
+}
+
 static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
 				 unsigned short payload)
 {
@@ -755,9 +768,18 @@ static int ncsi_rsp_handler_gvi(struct ncsi_request *nr)
 	if (!nc)
 		return -ENODEV;
 
-	/* Update to channel's version info */
+	/* Update channel's version info
+	 *
+	 * Major, minor, and update fields are supposed to be
+	 * unsigned integers encoded as packed BCD.
+	 *
+	 * Alpha1 and alpha2 are ISO/IEC 8859-1 characters.
+	 */
 	ncv = &nc->version;
-	ncv->version = ntohl(rsp->ncsi_version);
+	ncv->major = decode_bcd_u8(rsp->major);
+	ncv->minor = decode_bcd_u8(rsp->minor);
+	ncv->update = decode_bcd_u8(rsp->update);
+	ncv->alpha1 = rsp->alpha1;
 	ncv->alpha2 = rsp->alpha2;
 	memcpy(ncv->fw_name, rsp->fw_name, 12);
 	ncv->fw_version = ntohl(rsp->fw_version);
-- 
2.41.0

