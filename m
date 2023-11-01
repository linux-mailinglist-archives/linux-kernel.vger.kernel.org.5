Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EBD7DDE4A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjKAJSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbjKAJSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:18:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C066C2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:18:44 -0700 (PDT)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 76788D8B;
        Wed,  1 Nov 2023 10:18:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698830300;
        bh=cqr9qmnFL43Mi0X/si5rR0wyx9x15IoN3blFgEcAEhY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QtWevdGxZ8j6lFrOZSDySoZ8OFG//OIF6lsjV4Rfe1bhm4ZcUopLubuWCahTy4pRH
         Csc3evlzCSnuoaSdwACFMFKoLR/J6OqoXXNhnMOkbgQYkJ6pbmfQcMHrxXu3jfO5Kl
         eOuCzrLYjQ1Mx76jlI5T6wtE4bViQ670xn/0KjMU=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 01 Nov 2023 11:17:40 +0200
Subject: [PATCH 03/10] drm/tidss: Drop useless variable init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-tidss-probe-v1-3-45149e0f9415@ideasonboard.com>
References: <20231101-tidss-probe-v1-0-45149e0f9415@ideasonboard.com>
In-Reply-To: <20231101-tidss-probe-v1-0-45149e0f9415@ideasonboard.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=708;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=cqr9qmnFL43Mi0X/si5rR0wyx9x15IoN3blFgEcAEhY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlQhfmZvrXwVfeAXpKfH/t84dOn0jl1YydKNIAp
 4Tb85mAQMyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZUIX5gAKCRD6PaqMvJYe
 9dq1D/9dvYn6n3xz8Hjqt40LO0+SBnW3EclIBin6YRnFpRYTkAcGD5/If7zbmwBilpE30tQs50H
 X8BE0m2ZZrWnSyC0zzWG0hUmdmSoalIR2kfNXS9l+hdJ4sTY1HCkMX30EbAXbCWdvFqi9N7xoYN
 btOEe49slqZhQczeK6/ILzdUnxUhMlvmktqb2Zd0A4xeGlxHBKur7rpB48+GiS1dH8veEJT5mAr
 FXd1kZjxAHjUZqYvXx293BAKaMtyh3FXsQVhCGx0MrmfpL4QnoCummdCZfiCuFn68LGTodiP2YB
 +c/bw7IMyu37R1Evmd409EBXE+pBiNbk3EcR9Qs7i4nal+KZubWHmhA6DSumDLy5rhXHBXD+B09
 Ddr8qy02PgfLOXzS3QQxfS97ifltB6gZV26CNmbglV9DNPaK/qi4Neylwwy9ierje0zbaRriRuQ
 0b7kruM7DKsHqvl3e60MHop9sYYICBWoOEFZEByuFA7b3eXw6YNzNrO8DuipN+YEwkrnxJN6bjG
 PZ8xHAY+LLDMpjsy2Iil2PqFBPc4GV3EuxNzYG89oqZ+jUJXwL6Zt0D9rXu/VraWyG3uZcCoFFp
 d80YfWbmFYs533LFOvrEIkd5MgNIPchPnwBW8Fk5ZIQAckMGk3isUWKt0EbcruvG4EiOgv2+1gd
 BogoFbcu0cTNDig==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to initialize the ret to 0 in dispc_softreset().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 9d9dee7abaef..ad7999434299 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -2705,7 +2705,7 @@ static void dispc_init_errata(struct dispc_device *dispc)
 static void dispc_softreset(struct dispc_device *dispc)
 {
 	u32 val;
-	int ret = 0;
+	int ret;
 
 	/* Soft reset */
 	REG_FLD_MOD(dispc, DSS_SYSCONFIG, 1, 1, 1);

-- 
2.34.1

