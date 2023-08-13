Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8367D77A970
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjHMQMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjHMQMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:12:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C680E4210;
        Sun, 13 Aug 2023 09:11:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 537F560E88;
        Sun, 13 Aug 2023 16:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC7CC433C8;
        Sun, 13 Aug 2023 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691943058;
        bh=wNCqRJLuzySMBYP/Bwsi15obUizRPa4DGtQz1OO9QKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RrDWXI7H/0bztxYiOA/nNSzKx8O9XZ9uFO5IoudUiGP/kcllY+V/S84dlZR/gPabG
         mGNi2C5lfXAgk3YCCfPPThZVEBtrtet3+5bFum+iZWw7/DWGwdxWdbNDmGLF+sW+wb
         Pd3ClSyF7pk70GjGUUNMCVuSKeGK0Bl46oSvr+3KBG9I79GC7Q9+VS+7OVPMWu1SS0
         LtRkrbvXNnBmc7x2qv6q/op5ZV4WjjAtr+coJxtWhcONJKSDeI9plsiLsbbeJ6FGuS
         JzX/qxu4QvUiR1kyDbzKoipMV8fnOmC+RBMD0AnRprk8HODCOUF8YMigT68J6uBTpz
         qSib0ysoXYFDg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 18/25] spi: spi-qcom-qspi: Add DMA_CHAIN_DONE to ALL_IRQS
Date:   Sun, 13 Aug 2023 12:09:29 -0400
Message-Id: <20230813160936.1082758-18-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160936.1082758-1-sashal@kernel.org>
References: <20230813160936.1082758-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.190
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>

[ Upstream commit 916a4edf3daed845b1e5d6cf0578a7e43c6f520e ]

Add latest added DMA_CHAIN_DONE irq to QSPI_ALL_IRQS that encompasses all
of the qspi IRQs.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/1690285689-30233-5-git-send-email-quic_vnivarth@quicinc.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-qcom-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 8863be3708845..96ba63758d34c 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -65,7 +65,7 @@
 				 WR_FIFO_OVERRUN)
 #define QSPI_ALL_IRQS		(QSPI_ERR_IRQS | RESP_FIFO_RDY | \
 				 WR_FIFO_EMPTY | WR_FIFO_FULL | \
-				 TRANSACTION_DONE)
+				 TRANSACTION_DONE | DMA_CHAIN_DONE)
 
 #define PIO_XFER_CTRL		0x0014
 #define REQUEST_COUNT_MSK	0xffff
-- 
2.40.1

