Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653A07811C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379031AbjHRRVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379021AbjHRRV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:21:27 -0400
Received: from pegase1.c-s.fr (unknown [90.115.179.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8F13C2F;
        Fri, 18 Aug 2023 10:21:26 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RS6zs1by5z9vhM;
        Fri, 18 Aug 2023 18:40:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lXP2OwoFw5RG; Fri, 18 Aug 2023 18:40:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RS6zl1qYrz9vhN;
        Fri, 18 Aug 2023 18:40:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3397E8B763;
        Fri, 18 Aug 2023 18:40:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TDM3vjXENiKH; Fri, 18 Aug 2023 18:40:03 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (PO17626.IDSI0.si.c-s.fr [172.19.54.29])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 79E568B779;
        Fri, 18 Aug 2023 18:40:01 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37IGdvd5141991
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 18:39:58 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37IGdvDx141990;
        Fri, 18 Aug 2023 18:39:57 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 12/28] soc: fsl: cpm1: qmc: Remove no more needed checks from qmc_check_chans()
Date:   Fri, 18 Aug 2023 18:39:06 +0200
Message-ID: <cfe9f648f849526b1aac01ca13ee7e5f3f51a3e5.1692376361.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692376360.git.christophe.leroy@csgroup.eu>
References: <cover.1692376360.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692376734; l=2150; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=/2BhkcYFCfVdUJW9iyItt6BfQ3h3Y35LDTdW3A3srlw=; b=CFqlIBlU5AMPuF2hcu/jmjdlTWFhn4WJXBe5RU5oDbnFR1fmzzJ7MkFjSNMKy/bhhMfQs26rg mJOq+SUcC8tA1BBdocSnonDqluqi7jfx8NcGyh8jOB9gb71QuJAoRbk
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_FAIL,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herve Codina <herve.codina@bootlin.com>

The newly introduced qmc_chan_setup_tsa* functions check that the
channel entries are not already used.
These checks are also performed by qmc_check_chans() and are no more
needed.

Remove them from qmc_check_chans().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index bddff0b74252..2416408bb7e7 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -884,10 +884,7 @@ EXPORT_SYMBOL(qmc_chan_reset);
 static int qmc_check_chans(struct qmc *qmc)
 {
 	struct tsa_serial_info info;
-	bool is_one_table = false;
 	struct qmc_chan *chan;
-	u64 tx_ts_mask = 0;
-	u64 rx_ts_mask = 0;
 	u64 tx_ts_assigned_mask;
 	u64 rx_ts_assigned_mask;
 	int ret;
@@ -911,7 +908,6 @@ static int qmc_check_chans(struct qmc *qmc)
 			dev_err(qmc->dev, "Number of TSA Tx/Rx TS assigned are not equal\n");
 			return -EINVAL;
 		}
-		is_one_table = true;
 	}
 
 	tx_ts_assigned_mask = info.nb_tx_ts == 64 ? U64_MAX : (((u64)1) << info.nb_tx_ts) - 1;
@@ -922,27 +918,11 @@ static int qmc_check_chans(struct qmc *qmc)
 			dev_err(qmc->dev, "chan %u uses TSA unassigned Tx TS\n", chan->id);
 			return -EINVAL;
 		}
-		if (tx_ts_mask & chan->tx_ts_mask) {
-			dev_err(qmc->dev, "chan %u uses an already used Tx TS\n", chan->id);
-			return -EINVAL;
-		}
 
 		if (chan->rx_ts_mask > rx_ts_assigned_mask) {
 			dev_err(qmc->dev, "chan %u uses TSA unassigned Rx TS\n", chan->id);
 			return -EINVAL;
 		}
-		if (rx_ts_mask & chan->rx_ts_mask) {
-			dev_err(qmc->dev, "chan %u uses an already used Rx TS\n", chan->id);
-			return -EINVAL;
-		}
-
-		if (is_one_table && (chan->tx_ts_mask != chan->rx_ts_mask)) {
-			dev_err(qmc->dev, "chan %u uses different Rx and Tx TS\n", chan->id);
-			return -EINVAL;
-		}
-
-		tx_ts_mask |= chan->tx_ts_mask;
-		rx_ts_mask |= chan->rx_ts_mask;
 	}
 
 	return 0;
-- 
2.41.0

