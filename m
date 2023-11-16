Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C0F7EE49B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345402AbjKPPsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345297AbjKPPsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:48:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8DED4E;
        Thu, 16 Nov 2023 07:48:30 -0800 (PST)
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 22B5E6607351;
        Thu, 16 Nov 2023 15:48:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700149709;
        bh=BY0sbxpm5Rf/FVPVvUAfc6hpVbEdkpX0L7b1vxWfMEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oPVwla9EfSUkl+veP0U8qGqhda2TGfetqap4Bmramto6x2j2n7SeKMnWUvuZsyg71
         vFN74GbG8QqbTHRo7s/Yww6Xewg3xlapQbFk9W6RhMFPRekZWPwE0enUCWQBPMMBnK
         h9Kl/V+QGhujIiJ+RoMZ3z9X1wuAkHyOf82S9SeiUHjIAtA/viI7yDY9BlLzqmtQ1j
         zg98jCindurfZRzNIzglm6FqFDLLWwAyL0c3L7t2gn0aRb5Zdw/FsY0fE1D1Brt0Wz
         u2d0NEfGBrXqEdnat7Ma4vhfILY+ACIVRvpD6ryHB82wUFxUNmtBgBlNj9HczHtfYE
         rNxqRgNkbaetA==
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@collabora.com
Subject: [RFC 2/6] media: verisilicon: Correct a typo in H1_REG_MAD_CTRL_MAD_THRESHOLD
Date:   Thu, 16 Nov 2023 16:48:12 +0100
Message-Id: <20231116154816.70959-3-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116154816.70959-1-andrzej.p@collabora.com>
References: <20231116154816.70959-1-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a THRESHOLD and not a THREDHOLD.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_h1_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/hantro_h1_regs.h b/drivers/media/platform/verisilicon/hantro_h1_regs.h
index 57e89bb975ae..7752d1291c0e 100644
--- a/drivers/media/platform/verisilicon/hantro_h1_regs.h
+++ b/drivers/media/platform/verisilicon/hantro_h1_regs.h
@@ -92,7 +92,7 @@
 #define H1_REG_STR_BUF_LIMIT				0x060
 #define H1_REG_MAD_CTRL					0x064
 #define    H1_REG_MAD_CTRL_QP_ADJUST(x)			((x) << 28)
-#define    H1_REG_MAD_CTRL_MAD_THREDHOLD(x)		((x) << 22)
+#define    H1_REG_MAD_CTRL_MAD_THRESHOLD(x)		((x) << 22)
 #define    H1_REG_MAD_CTRL_QP_SUM_DIV2(x)		((x))
 #define H1_REG_ADDR_VP8_PROB_CNT			0x068
 #define H1_REG_QP_VAL					0x06c
-- 
2.25.1

