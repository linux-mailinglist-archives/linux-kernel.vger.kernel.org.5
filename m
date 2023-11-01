Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98237DE72B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjKAUqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjKAUqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:46:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8BF10D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:46:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40859c466efso1557495e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698871600; x=1699476400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bgaHZ3UfFshXfCxlOPE+D/nv3eSos7Ya5UTPtKr2DAA=;
        b=dxspA9LVP3Oub110nX/RPDyZlIzV+BbXA0dZ9FXNhojroa2M4RuPSDcgn4RGRESDmK
         kHnQfnyGsGA+lQclkI4ywJflxe7zwXHIA377Eve9Qe/ndwob21Wy+F1cHGe1zrNkr62R
         lbkdcLR6tggyBCSW9pIFmuYxbVA8/zwotgiLxIYxiNle8UoyGQZ0GCMkdUpB4/z+MxR9
         y7jfaiHn7a3p4qdQQ/0d4vw5qhr5A1jlyp327NamB/YVCgwzaCjbrpog8NaYKH1IBRBw
         +pDmgYXnljgSS16bhoA6io49rD/PMMCU0W3sbDyVDpGZnE3yS/Z++IPNCnuP7UZrMmxz
         xykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698871600; x=1699476400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgaHZ3UfFshXfCxlOPE+D/nv3eSos7Ya5UTPtKr2DAA=;
        b=N5d/SRwCeSuKLeMWyokI6+tcUWxzZVPYqQ0hTKVIZqCuZLeRfXhpflpIM9l5akMO6Z
         pVQFhMC3wqjOZtwnf3uGaUwkVjM/inh0pbRQtEkhCVCK3n3TvY3A2Kld3XxNcI3TZfDq
         HxegDg80f2XlI/GOFdvHzLUK5lsBZOBRLvYDz7D2U7KXgZXMm/Yxa2NJl2z92Dqg85E4
         HJFaJ6lj452fLUNmmz7Ubquz9luAF17kahoR3msdg7nwmS18ZCxHl4GnHwUq9GFTMfxR
         VOO3jnkaVmYPQjqZhCiBzgGchN0bp5EMzw6OSk3KX1WcneJzuntRF/UPyjaQ1v/eM18T
         626w==
X-Gm-Message-State: AOJu0YzGWKItUolWkdiHh6dS2lWQFGME0pjrHYyvsjuPTUegL3hvwFLo
        QqFow2UosukuA+TFrT7383jA+3j5h89I+g==
X-Google-Smtp-Source: AGHT+IHnyedvgAo2aDzKFhV2EESs4UTX+qwrFpTftQD9+PYoxO3xNNDT5oe2Q5omtjhQL3eR4zFzRA==
X-Received: by 2002:a05:600c:4454:b0:407:7e5f:ffb9 with SMTP id v20-20020a05600c445400b004077e5fffb9mr14475051wmn.9.1698871599642;
        Wed, 01 Nov 2023 13:46:39 -0700 (PDT)
Received: from archlinux.. ([88.127.172.169])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c450900b0040651505684sm655441wmo.29.2023.11.01.13.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 13:46:39 -0700 (PDT)
From:   dimadrumspro@gmail.com
X-Google-Original-From: dimadrumspro@@gmail.com
To:     dimadrumspro@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: comedi: drivers: ssv_dnp.c: removed unnecessary, fixed a typo
Date:   Wed,  1 Nov 2023 21:46:38 +0100
Message-ID: <20231101204638.27270-1-dimadrumspro@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dimaaac <dimadrumspro@gmail.com>

Removed an unnecessary comment and fixed a typo

Signed-off-by: dimaaac <dimadrumspro@gmail.com>
---
 drivers/comedi/drivers/ssv_dnp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/comedi/drivers/ssv_dnp.c b/drivers/comedi/drivers/ssv_dnp.c
index 813bd0853b0b..768524b02a0b 100644
--- a/drivers/comedi/drivers/ssv_dnp.c
+++ b/drivers/comedi/drivers/ssv_dnp.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * ssv_dnp.c
- * generic comedi driver for SSV Embedded Systems' DIL/Net-PCs
+ * Generic comedi driver for SSV Embedded Systems' DIL/Net-PCs
  * Copyright (C) 2001 Robert Schwebel <robert@schwebel.de>
  *
  * COMEDI - Linux Control and Measurement Device Interface
-- 
2.42.0

