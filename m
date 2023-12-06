Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FB1806835
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376923AbjLFHZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjLFHZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:25:08 -0500
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C270618F;
        Tue,  5 Dec 2023 23:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=IwlufYxpuWwftX9Aj3oJtglRsNwFLoWx30Owe9Vqr1c=; b=HrSGrNfvdvvv4ZXYybaZqc/vQU
        +yUw7mYMeTKEn1piQdpgm5HxPRd/pOog7FpRq17J1bMQMxX7gCqfRBfwRlAsqiDPOxxiNG/ekd499
        ClTTwYLLUH/aWYtOlG/bLv2wwJSLcsXS5wtVI6pjhH0eY65C9vnFSw6HsiJtr1BBCkRTU+Ibwnkor
        HdqP2Kb3sxvPAaYpk7jMcdKTnO5d36pd/8BDLXe5KFoNjgYMim2co+N30hQeIDutd8Chic2MGQUyF
        eOXSMbYpDhzEJ8bX30E+je7HiWoWDnNZMfX+VYONrGj+Sa1fIq3c9oPeY2OGRT6d1UQiFlF88rklw
        QK/1cAlA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1rAmHR-000Bhh-39; Wed, 06 Dec 2023 08:25:13 +0100
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1rAmHQ-0005AJ-B2; Wed, 06 Dec 2023 08:25:12 +0100
From:   Sean Nyekjaer <sean@geanix.com>
To:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: microchip: use DSA_TAG_PROTO without _VALUE define
Date:   Wed,  6 Dec 2023 08:24:41 +0100
Message-ID: <20231206072442.1628505-1-sean@geanix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27114/Tue Dec  5 09:39:00 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the use of define DSA_TAG_PROTO_LAN937X_VALUE to
DSA_TAG_PROTO_LAN937X to improve readability.

Fixes: 99b16df0cd52 ("net: dsa: microchip: lan937x: add dsa_tag_protocol")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 286e20f340e5..5c2214784ed0 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2614,7 +2614,7 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 		proto = DSA_TAG_PROTO_KSZ9477;
 
 	if (is_lan937x(dev))
-		proto = DSA_TAG_PROTO_LAN937X_VALUE;
+		proto = DSA_TAG_PROTO_LAN937X;
 
 	return proto;
 }
-- 
2.42.0

