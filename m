Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19937F05DE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjKSL3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjKSL3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:29:03 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA73D54;
        Sun, 19 Nov 2023 03:28:40 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54394328f65so4735711a12.3;
        Sun, 19 Nov 2023 03:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700393318; x=1700998118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj6lXffwhPaiA+tttg2gWfCsavHU7fIAFEm3bWLvYqY=;
        b=T6ESpNBD+BilFiIBbXODWPBXtiLXQMhZzVuKaBd4gsf7x9fV0hvxf+mG8X5+pv6C+l
         lECeXi/AY/DGrslulZtqbJN6S5AX5sOBdZzFNdFDwykwav8AMNkeyDhOCNmg2+tWdv7b
         0tOXpbT/HVBzFuRveR5+UjN6seaFsJ76Z4MSeiZD4ApDKUwrlNU9yzR0MxYt8hkEAeLP
         6hjqIi3/2mebqxFVxdXGdHORfMxW2ax16vX+jRi4a2IUtnO78tDt2mIXksZxCLmqBfYA
         iyZn1KKpiIykU786No+AVEn3tosgoXJMJlX/nmsXhHBTOOaCss+BHk3HCGb7/8Zps9WQ
         bDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700393318; x=1700998118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lj6lXffwhPaiA+tttg2gWfCsavHU7fIAFEm3bWLvYqY=;
        b=rodd8xXFJvy/fZgkLpyk/9DjUGc6XMwWGT33JrFm938KBCqX0wU2+lV/TVe64ueCRw
         MkhigGWTU247fKMr1Hzl3atpybmVMg9wmyZKYHpTo9zTM//sM5ScSW9Ui6KZ4eD0Qedb
         VGz+5msz4sMoYaN1Z88uhaD5KBLgtxsXOZgU/0WrV1dFSfpfo8BZOxreNweI3zYjf4mE
         +A94y3TEUkapFl0f+YCBQ6DEqbVEFBydPV8RY1+CJlhHd7m3hSkDIAt0Z/aqltNkJHLI
         P+jTDgzt0l/HuRbmwuV6ziTsvFYwEXbhKRAGD1/rP3Mn1QUqkeL/LC21FQ1vbIFeKTd7
         hW1Q==
X-Gm-Message-State: AOJu0YyLUB8rvm4EgaH6M2fIkCNz4TjmqH9+yzAOVn2uFjzveCXS/KKh
        X+4aMEXuz1nrauTxX1fFH/E=
X-Google-Smtp-Source: AGHT+IFZggot9AqS3X6Qt+Jt5dcuKalJ7+U5FRGLkcM87LKer+UjD3CjY5GltxnAdA4qRjb5SMpr7Q==
X-Received: by 2002:a17:906:10cc:b0:9fc:1236:beff with SMTP id v12-20020a17090610cc00b009fc1236beffmr1696210ejv.65.1700393318307;
        Sun, 19 Nov 2023 03:28:38 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c23-bde4-3e00-2223-08ff-fe18-0310.c23.pool.telefonica.de. [2a01:c23:bde4:3e00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id k22-20020a1709063fd600b009f8af454d0dsm2420378ejj.112.2023.11.19.03.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 03:28:37 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/20] drivers/video/fbdev/cyber2000fb.c: remove I2C_CLASS_DDC support
Date:   Sun, 19 Nov 2023 12:28:15 +0100
Message-ID: <20231119112826.5115-11-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231119112826.5115-1-hkallweit1@gmail.com>
References: <20231119112826.5115-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of the legacy EEPROM driver and I2C_CLASS_DDC support in
olpc_dcon there's no i2c client driver left supporting I2C_CLASS_DDC.
Class-based device auto-detection is a legacy mechanism and shouldn't
be used in new code. So we can remove this class completely now.

Preferably this series should be applied via the i2c tree.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/video/fbdev/cyber2000fb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 52105dc1a..79775deda 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -1234,7 +1234,6 @@ static int cyber2000fb_setup_ddc_bus(struct cfb_info *cfb)
 	strscpy(cfb->ddc_adapter.name, cfb->fb.fix.id,
 		sizeof(cfb->ddc_adapter.name));
 	cfb->ddc_adapter.owner		= THIS_MODULE;
-	cfb->ddc_adapter.class		= I2C_CLASS_DDC;
 	cfb->ddc_adapter.algo_data	= &cfb->ddc_algo;
 	cfb->ddc_adapter.dev.parent	= cfb->fb.device;
 	cfb->ddc_algo.setsda		= cyber2000fb_ddc_setsda;

