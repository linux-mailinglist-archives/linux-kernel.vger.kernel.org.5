Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FCB762F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjGZICL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjGZIBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:01:15 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AFC3AAD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9bb097c1bso860241fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690357990; x=1690962790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0Gap5z5HQj+20KA+5rR6ZWXU3MXLJY5RV2SAA/NzIc=;
        b=JTaUGxTaEzP8WuluF6JI7pcb3FNbQyMdYooHInNRIoD/+m/jyNLdY8PLNgTir7NFNt
         xxX32PLRCjTkGLkDI+GeSrjtoswcKBjXudphHTpsrrF/+2ZKmjtFkE6mHok1zBbYtL09
         YPZGaTsB1yAPTTe0DIVZm2QSRbdLiCrHoANSLFlb2K1sxp2v9psoYQ1Wu9s8mJwGElb6
         Md2CKj/rd/oKqURKUF5av1CiVf5kc5Mz34cOXLkPuCvjNQTWSo+hw2lSzrFKNaoYe62M
         SzfuFAfYA2PmOgKjKKgcV3YcB273IIx7cyqi3HHlU0KuyWOFdh6zsCKGtE5fMPtbRUwa
         gvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690357990; x=1690962790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0Gap5z5HQj+20KA+5rR6ZWXU3MXLJY5RV2SAA/NzIc=;
        b=KdUdqfRFK9m12FIkLCRT/XRq+HtrNISD7yjTGcpOZRiFj80U1Fj4xlLQAuuxZxO+5E
         HQ3dNmzxny4q4t0Bf3tNhuzY5C9xLobuRFHvqWrVB59011i+E8xMfXmDqQb7lY7j/eky
         VBPDKKd8D8+3ITbzDRgzu/xrbQ62IO3AyFu6MCVSMCOO/d4e3XLYgtw7Az07EmjXAMVT
         5vJ7Au+o84xWDH3r9cIQWpLKrTHAdbNKEUXalXCjzPeWiW1C64vp5x9MnIbPh/oAM6d/
         NCYDRyWu6U7wTGc6V+9n08lrwYPO2UEG7ho0HmWT9PmgAW6CSw/uyDQcQSglAeKCaXXc
         Ybtw==
X-Gm-Message-State: ABy/qLaxFDL7tVzuTI48e8flLMQXynCzWpGizYhhG1vqH/N/7eKcwbG4
        LDW9jqG8HS8ZuXKcqbjcXrzlGw==
X-Google-Smtp-Source: APBJJlGvbeA1bwNEatZegegZYcyw8ZenkB8PdMHec6wLbL3TAmih1qzN2A3UEFv6Rlc8mfMVplU2EA==
X-Received: by 2002:a2e:80d3:0:b0:2b6:f009:921a with SMTP id r19-20020a2e80d3000000b002b6f009921amr921837ljg.13.1690357990399;
        Wed, 26 Jul 2023 00:53:10 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fbca942499sm1264346wma.14.2023.07.26.00.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:53:10 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v4 05/11] mtd: spi-nor: spansion: switch h28hx's ready() to use vreg_offset
Date:   Wed, 26 Jul 2023 10:52:51 +0300
Message-Id: <20230726075257.12985-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726075257.12985-1-tudor.ambarus@linaro.org>
References: <20230726075257.12985-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=851; i=tudor.ambarus@linaro.org; h=from:subject; bh=q/Qc3k9qz6CGFcYot604zmE6bU9NIV/TJy23m7QhG7U=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkwNDYlft4XVdhUmR6ygrhXLxkoNCICvSgBiqvh UqcRB9M36uJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZMDQ2AAKCRBLVU9HpY0U 6ecVCAChy9qN/FV0Ep/NahRCUBvsEecWHg3rWVBFRK2+nZiAefeyDXaelwOVrvbB5Lo9Uwj8s/a iLX5lIkS18KbB/29CjxJ7cJXEwKAQFlu+yHMENoGdDrfccdeCv5FlHNSnUomR2oPRaBqoPR7V0k 4ndWXvTUsF1y7+DcPSPtdd0H/MV2TUjc/qA8urT2xYkYlN8uqhDd+Vb3AK2M1Rc5MTIPxJYgV7t f1mi4jVSbQjSgHhoAs+i3ApJRLNwg4BM3e4djHJQwUK+nIZ1pGtUf/kayMgcaXWUjVuPgtsiKWp PQkB3VfmX7citfYlFFZm2tL1KKfBTVYO+3/3oBoil9apeons
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

s28hx is the sole user of cypress_nor_set_octal_dtr, which already
uses vreg_offset to set octal DTR. Switch the ready method to use
vreg_offset as well. This is a preparation patch. The goal is to use
the same s28hx methods for the multi die version of the flash.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/spansion.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 94d98b5b0ff1..6d8dd800ba65 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -728,6 +728,7 @@ static int s28hx_t_late_init(struct spi_nor *nor)
 	}
 
 	params->set_octal_dtr = cypress_nor_set_octal_dtr;
+	params->ready = cypress_nor_sr_ready_and_clear;
 	cypress_nor_ecc_init(nor);
 
 	return 0;
-- 
2.34.1

