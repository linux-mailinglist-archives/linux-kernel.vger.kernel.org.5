Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE837DAC22
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 12:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjJ2LTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 07:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJ2LTQ (ORCPT
        <RFC822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 07:19:16 -0400
Received: from smtp1.ms.mff.cuni.cz (smtp1.ms.mff.cuni.cz [IPv6:2001:718:1e03:801::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB39AB0;
        Sun, 29 Oct 2023 04:19:11 -0700 (PDT)
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
        serial F5FD910E8FE2121B897F7E55B84E351D
        issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
        auth type TLS.CUNI
Received: from localhost (internet5.mraknet.com [185.200.108.250])
        (authenticated)
        by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 39TBIYbD065436
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Sun, 29 Oct 2023 12:18:36 +0100 (CET)
        (envelope-from balejk@matfyz.cz)
From:   Karel Balej <balejk@matfyz.cz>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>
Subject: [PATCH 1/2] dt-bindings: mwifiex: document use with the SD8777 chipset
Date:   Sun, 29 Oct 2023 12:08:16 +0100
Message-ID: <20231029111807.19261-2-balejk@matfyz.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029111807.19261-1-balejk@matfyz.cz>
References: <20231029111807.19261-1-balejk@matfyz.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the corresponding compatible string for the use of this driver
with the Marvell SD8777 wireless chipset.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 .../devicetree/bindings/net/wireless/marvell-8xxx.txt          | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt b/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
index cdc303caf5f4..4f374ea029ed 100644
--- a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
+++ b/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
@@ -1,4 +1,4 @@
-Marvell 8787/8897/8978/8997 (sd8787/sd8897/sd8978/sd8997/pcie8997) SDIO/PCIE devices
+Marvell 8777/8787/8897/8978/8997 (sd8777/sd8787/sd8897/sd8978/sd8997/pcie8997) SDIO/PCIE devices
 ------
 
 This node provides properties for controlling the Marvell SDIO/PCIE wireless device.
@@ -8,6 +8,7 @@ connects the device to the system.
 Required properties:
 
   - compatible : should be one of the following:
+	* "marvell,sd8777"
 	* "marvell,sd8787"
 	* "marvell,sd8897"
 	* "marvell,sd8978"
-- 
2.42.0

