Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4425075ED28
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjGXINf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjGXINO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:13:14 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072E7E79
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e56749750so5769678a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690186385; x=1690791185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQWD6o2QmQMIWADk9Uuk1r2hOrPJzs9WMOrl4s2UcP4=;
        b=TOspIZRVdxW+KctBUpzedxlrRyCBWoiE4/Y43E0WszgR4uL2m5kri2Cm2crujjE6Xb
         WaSPPQtb1VI0KIWu/JaMHAkE7gb7FGnMCx67INEINzHhzclnBur3wAUsulYwFNKcn7Q3
         0/p18ZUYciCIvQ3FnOns88/A9p05Ge/RbDlv+q1Wro9a8e/CHIkmZTvH6RcZpV2+omoW
         r+3lDpi2DGk9Gb6p0MbFYDKcMFz9nTV1zG/cgDZxQeXTGSiryM2V3ZdW91UVWi4Yyoai
         ja1nPqz0gWTsQjKMapq8LYWVAskMTc8VtmZ5RdD2tHqyJjO6gGpmzUg32UFABSHXhkxO
         xmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186385; x=1690791185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQWD6o2QmQMIWADk9Uuk1r2hOrPJzs9WMOrl4s2UcP4=;
        b=Qlj/UUSSJs0Z4FHizCpCdOw6uci3u7CGh3jUAN9SQx8sJ24yfmALjbl7T0n3edWyde
         tde3IlS2Lu7CdvmbLXohuvgLV08MsH0YJBGfMdB+Q5pNFqd8k3KP9qDQTH5PU0/zFJ5F
         MKOxhLQM5Gc5RkUvvse/uG7EU7dJfQeWB1nFfY7GPH59G3qODlQ9Qy1wjIj+dC8at2Vj
         VPIwYHfyBLKYh0+SvfPpm2TmzZDNGui61w8s2mHC4rcol8C6j7X8N9PnFqcqKxUSKF+D
         i9hSQVV+ZitviVmbkU3DtWpsatcGFFxoPreUb7m/098EbhJ4Jq12vCbjfJ6ONy2zFe1u
         u7CA==
X-Gm-Message-State: ABy/qLZNkecBXEDQTFOy/M/t+fe9+ivbfpSXD91KgLTpoN+Ddh6MYWwX
        xFPBdhakyMBhoX6ruN9One1Xow==
X-Google-Smtp-Source: APBJJlEMJswmOKOAqJzwRQ5aFVr0jQaI5nq1DEVa4URq69sVkBeRtwC3r2KBUvBj511T9cXfd5lwiw==
X-Received: by 2002:a17:906:cc0e:b0:99b:4a29:fb6a with SMTP id ml14-20020a170906cc0e00b0099b4a29fb6amr9268494ejb.59.1690186385224;
        Mon, 24 Jul 2023 01:13:05 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709065f8600b0098ec690e6d7sm6355395eju.73.2023.07.24.01.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:13:03 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v3 05/11] mtd: spi-nor: spansion: switch h28hx's ready() to use vreg_offset
Date:   Mon, 24 Jul 2023 11:12:41 +0300
Message-Id: <20230724081247.4779-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724081247.4779-1-tudor.ambarus@linaro.org>
References: <20230724081247.4779-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=851; i=tudor.ambarus@linaro.org; h=from:subject; bh=WVFbE2wfxt/8hLhyWshKgP+KuZXcvV9Z2hzSYAD/Z5w=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkvjJ+ywSNb/VFIiWHMUEXC6o5GvL5YbM7I7q4J IEexIEmBVOJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZL4yfgAKCRBLVU9HpY0U 6eJNB/4+GW3Up54GTrKVZ3mORH/AXQ4goiqFedFcFMq5+rzCmlhsMNZMPtCayF3XYjkYioQePJ6 t77LMQ6vU0lhJhZc+cFFAajMT/KRpl2rL1CCBRmGsYBGupKFjEt2/kx1995y3vclQwGOo5QEHZi LzOeN3QfUMJvfQkJKkPPUuTyFtZO+on+ZxG1pTb/v8+vmNUMW8VfRIFtDTsBntBJEUOvH5bBfqs sKiuaOD6DyQgiaMfeCg06P86hkgmF6vvdz8JwsfcZf8cyJClhHeGzRrerrRsK+T8bqfBVwEdMqZ zpFUiN5MiLajo+IXlGncp/ROz/y4mMixiUOQ4iyvbDhb37il
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

