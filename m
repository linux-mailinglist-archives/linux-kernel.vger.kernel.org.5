Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B25378F7A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 06:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348162AbjIAEOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 00:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjIAEOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 00:14:47 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ADFE50
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 21:14:44 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58caaedb20bso17518547b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 21:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693541684; x=1694146484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MvPRoYGjNk3TX7+/+aO8UReMrhh5LYGpxACDliYOSyE=;
        b=Wx0Gb+1VX8ThXQHmmCx9Ymu9g5KkNXvOTfhFVDxZ26cRRVxZXfKh5D+qBfHVu6gpGP
         KTElimeUcH3s2lIK5HzDkD3GROt/LwYcBodaevEHDA94EfnmlQsH8TD7sJJSDjqYn/IJ
         0x8lYRgq/+HxWu0b8aZCmxktseF60jU+LIJUOjCzPUHVVD+mNXGX7n/q+mMFs9kuPNBf
         vpfMwLL2ofkqXzKVp+U8zzGqp/r+R0qbIpysoSN6wvixVo3H2LcvNRZS1n/8qPJe90n6
         J3rK47pyMReiTcWejHpbnU3WctLiangH0eDXam1W9Xnmg52fk7kB8bm1ZGmsw2Jl9Plc
         8F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693541684; x=1694146484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvPRoYGjNk3TX7+/+aO8UReMrhh5LYGpxACDliYOSyE=;
        b=FK07/RB94ku5oISJYBzT8qsRC9YF8sg+WgdEU9BPXzn9RNrzHlCq7c/wdcRIzTF7RV
         uzNcYDgnYqpIViKv4ZOCAJblD21Jn4gMdM3txi2V+7/2zQBGCwBmJxmEczgOXBou7ulk
         7xLcXJQpAeVGW1L8tllEKE5bURya+6rpIM7lzPXC3bOjgD7HwvuWFFa2eyvCirTKniDR
         S4lEi6vcVfMubYnR3x2IJQV9o4YjGl1uPu1Dwl+hnq8HKSa2jyQBzB3igb2YBuaPhgGl
         aHJo2xFb/5EuR06C09NUvHdM4vlCsD+bvLaz7IH8BKZPTuYxrrwzYLnWfz9vt95Hm4SD
         xkYg==
X-Gm-Message-State: AOJu0YyY1E0fafpeo8cCF8w2yOq4U+bHuYMONiuhlvGUunrBSusGnXDh
        Hu1r1h9jrb2TDhPWYTy18XQSQcb5kybPfQ==
X-Google-Smtp-Source: AGHT+IHTUufXAWRnpFUA17Fh4H0LFucPVVrX5mOAEbvJcIiytXZK+mIisEgb6jALmD24EM69kChilw==
X-Received: by 2002:a0d:f243:0:b0:586:a012:c703 with SMTP id b64-20020a0df243000000b00586a012c703mr1574017ywf.30.1693541683807;
        Thu, 31 Aug 2023 21:14:43 -0700 (PDT)
Received: from walt-ROG-Strix.. (99-176-3-182.lightspeed.brhmal.sbcglobal.net. [99.176.3.182])
        by smtp.gmail.com with ESMTPSA id e188-20020a81a7c5000000b0059812d9719fsm201680ywh.8.2023.08.31.21.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 21:14:43 -0700 (PDT)
From:   Walt Holman <waltholman09@gmail.com>
To:     tiwai@suse.de, linux-kernel@vger.kernel.org
Cc:     Walt Holman <waltholman09@gmail.com>
Subject: [PATCH] [RESEND] acp6x-mach.c: Add quirk for MSI Bravo 15 B7ED digital microphone
Date:   Thu, 31 Aug 2023 23:12:21 -0500
Message-Id: <20230901041220.17629-1-waltholman09@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-of-by: Walt Holman <waltholman09@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index b304b3562c82..e05b3f4070c6 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -255,6 +255,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 B7ED"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.2

