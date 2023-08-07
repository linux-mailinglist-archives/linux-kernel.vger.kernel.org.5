Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A8C7722FA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjHGLpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjHGLpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:45:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC60D210B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:43:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so21506615e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691408636; x=1692013436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=diZtgH47DFaB28o0Ll3wrErtkFsWvVQ/oMefCRv/4ic=;
        b=ps3YWkdx1HcSAmLPS089rlIJpSuI64cHKtoWoVJLXaz9bmUO8CYYKxRsu48t0c2Vyw
         Zm4d4w3rPkyWmmluV+FKennlWxz/nOMBMMPV0II/7D2NjwerQuco6ukQ0GbStpLL8fLd
         axf1Eb5OLcPRrELjkOVY8kBvDoJka8LIGzB3i28hWgI7cfxRNX7KvttOUavQWb5AdZ9A
         MlwjakT81rG6Hm0ydUbQtPWB7f3l+zGvVJZe7LdpAVijCDQA1R8XbmQfguIXiORoYrt6
         qiijHlpav1JcjO0yWuDS4EoIG9Vev5hvt799YxqjSHDLFkPDmS6tXbbxQYi12Y5pcd0M
         KmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691408636; x=1692013436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=diZtgH47DFaB28o0Ll3wrErtkFsWvVQ/oMefCRv/4ic=;
        b=Cgqy5WZjBl/VT6iPzQY/ALgGrSA17okKxvsF2PVUeOzA2x10YQah5waFGTA7Wrqffo
         9at8sb2YiFfmPk1WXA+q8MytrEsZwh3A7GFr225mTR4E/vUsZ98ZyiPgvatZyCpw04is
         Evbf41Sex81pi2ftUgRExbc1d3wqZciwrY2LnMGekNtEiDPNFnagILzFzTRoPLNN3NEO
         v+cBIAefFXe83Y+5auKlGwtcOme8Nd/lD83RBwRnAqn59ykP0e5sl0J95/cTqxKdHuj/
         HFFG6GWzhUQwzPDn4SyU3upVNwoPXXoH4eGtGinp6B1PfeVYWv4lXRvxnEfkLOMd5+Ff
         HrYA==
X-Gm-Message-State: AOJu0YyNtQmVbX413Byx4ym1ZoD48YOJJXJ22OW/QSSbX/vbtGrYuTLx
        Jyf2WhQhK/cAqZUgHFRiuva0bu37GTl6Gg==
X-Google-Smtp-Source: AGHT+IEF+Zz2t3qfwolQNpLoMIq+pfbcJGy7AhHY7DQbZbK59/acuV278dYxW7FMArXTWssuNb8LMA==
X-Received: by 2002:adf:e8cd:0:b0:317:9537:d746 with SMTP id k13-20020adfe8cd000000b003179537d746mr5332011wrn.2.1691408635640;
        Mon, 07 Aug 2023 04:43:55 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id t12-20020adfe10c000000b0031758e7ba6dsm10273616wrz.40.2023.08.07.04.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:43:55 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     michal.simek@amd.com, p.zabel@pengutronix.de, alex@shruggie.ro,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] reset: zynqmp: removed unneeded call to platform_set_drvdata()
Date:   Mon,  7 Aug 2023 14:43:44 +0300
Message-Id: <20230807114344.15076-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/reset/reset-zynqmp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index 59dc0ff9af9e..510c168d635f 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -107,8 +107,6 @@ static int zynqmp_reset_probe(struct platform_device *pdev)
 	if (!priv->data)
 		return -EINVAL;
 
-	platform_set_drvdata(pdev, priv);
-
 	priv->rcdev.ops = &zynqmp_reset_ops;
 	priv->rcdev.owner = THIS_MODULE;
 	priv->rcdev.of_node = pdev->dev.of_node;
-- 
2.34.1

