Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D6A75DB10
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGVIk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGVIk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:40:57 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9263C32
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-993d1f899d7so436930666b.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690015233; x=1690620033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQWD6o2QmQMIWADk9Uuk1r2hOrPJzs9WMOrl4s2UcP4=;
        b=ECEzY1DbcoinZdp68gOfSyvAPGUR4JTFJtsB1E1DYNlUF1ujhfs4VGv+O017IT68xV
         y81ZF2Ne8x0h2hfwSBfcjWRUIHC//WLHYFa9FpBwbvdVFfi18wv6gReaElWnBQO73obe
         0ZyseqLog3CzQnQ94Y4AK74sP9coD8W0lTC4IuMgKlpG8cjWs5dJI9rzNhmrzhdSF0Sn
         pMI1H2vP/NT7lD5cUu8uPQvZ8NXlfGBanc43miLBdSxzkghgm6/DwNkkhcByUpPAWn3g
         luNBWbZrg1C38bKZ5yCXHjlrGtMHgJ8tM+zZdZUAylGTacuACRCJPvbx+zUz3YumDE87
         oimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690015233; x=1690620033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQWD6o2QmQMIWADk9Uuk1r2hOrPJzs9WMOrl4s2UcP4=;
        b=kpYnlBsc8u9m+VkUWVS60uwxJxhlNVP3Ta80oOdO6PzjByhBkIlYiNWJzZiqk7xuTr
         mMUZDZxg0y/n6i8s/aswjHkiIrzhE1DoBqD3d/COHpiwWZ9TY6IomygdqFN0rxOway0W
         Uw7jseUkwwGMOtTZgqyfNDLAAtNCxv6NJGZNZrlERjl+iaj52lIaUCBDLqzboSvNfDrh
         nyLBgDJCbqZM1JT7fz3ME9Vzop29CnmgqH5dg77rNA6BiMS/PBF0G+l9iNy7oEjJ+8xy
         iuie8NSkXouvhmbYYKLxWZeCikzWKNzzNiolVRrD0GjNdcfuk/Ux2l0yWFrY2ojOesBp
         UqLg==
X-Gm-Message-State: ABy/qLYXuX0iFl0p0KA7cOTHuBZQP9sxfJB3sgA/fr5fIdAeRcpPZhMd
        xKYNdnCTD8EqsxHtMUuJhZ7taQ==
X-Google-Smtp-Source: APBJJlGFe4ypvf3AH1f53UgYid2VMLbtIopcCXcbiWs9H70culUgPZ4TmLfC+u+qL4g1jMGzzue4Xg==
X-Received: by 2002:a17:906:9bf6:b0:993:ec93:a5ef with SMTP id de54-20020a1709069bf600b00993ec93a5efmr3687328ejc.47.1690015233233;
        Sat, 22 Jul 2023 01:40:33 -0700 (PDT)
Received: from 1.. ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906130800b00992b510089asm3253861ejb.84.2023.07.22.01.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 01:40:31 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v3 05/11] mtd: spi-nor: spansion: switch h28hx's ready() to use vreg_offset
Date:   Sat, 22 Jul 2023 11:40:00 +0300
Message-Id: <20230722084004.21857-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722084004.21857-1-tudor.ambarus@linaro.org>
References: <20230722084004.21857-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=851; i=tudor.ambarus@linaro.org; h=from:subject; bh=WVFbE2wfxt/8hLhyWshKgP+KuZXcvV9Z2hzSYAD/Z5w=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBku5XjywSNb/VFIiWHMUEXC6o5GvL5YbM7I7q4J IEexIEmBVOJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLuV4wAKCRBLVU9HpY0U 6ffjB/9gOC+pMoSHgPuRrB0eWWS5xeHjt1RTf6/LdnurE5CM9RsMgPu/5ImuudNvdHGdZ+j8iTG ageZl+JEpzkPLri6PIXjrsiweNkLFGrcwOfzR3CJ2Wbqdaevtxgm7F2PoRDgdcxZlzFNibL8lFN ccUFNvaUZaE/h/GS7V2X5cO83Ry0wO8AIsCtOa0e5yV76cWfN1ytCVdnlS7E2TIf5YebAMpwiH5 PKAXsm+Kaxa11S0KV5fzew3BaGYNjqa0wiQQ3YZFLNj57LM0SyYOs7IrUQfyv2Q6bqUpOCLfIPa UCFAZjiobYbhsFX0z/PPWm1j5AQfZakx3BOxfU6NrP6M1JXQ
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
index dc4841891b74..5b6f36b56e9f 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -730,6 +730,7 @@ static int s28hx_t_late_init(struct spi_nor *nor)
 	}
 
 	params->set_octal_dtr = cypress_nor_set_octal_dtr;
+	params->ready = cypress_nor_sr_ready_and_clear;
 	cypress_nor_ecc_init(nor);
 
 	return 0;
-- 
2.34.1

