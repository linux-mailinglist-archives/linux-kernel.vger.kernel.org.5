Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83827A346C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 10:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjIQIf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 04:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjIQIe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 04:34:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5721135;
        Sun, 17 Sep 2023 01:34:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fb85afef4so3246657b3a.1;
        Sun, 17 Sep 2023 01:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694939694; x=1695544494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BK/UofqNnCW1HejZh6vEf0f3JWk0OhQLopWWHxVZZBE=;
        b=Y+HtxI3RVhVTWJ2NQ/p9LQEPW8bq+HiTCT5WoXVtonp8x/slHfnMLP24W9hF70hoAv
         sml5dKOowTWz0yZsIvtxjtJhmWQ8T71EFJ3LMgogKURDFZwIPpHWQ8LDyATFV/ECZBQp
         FVfLHUI8sQSUdc+hPNfbsDyastQkHvUyGqUfsxvJLl+X81jI8jl1bmQccZawd9A65Bh7
         KnXoR483vX5JqVJkr0VJmLtJGEQNgfC52ywDuuTDLC+FWovnc4E4fgWl064GenUDiVl/
         8lxJQp67Q22YUA5d1PCs3mn14ACcE8q1jJ7mH99o79S9Ww09e3Sw4mfunSOMeFfm+6ND
         Ht5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694939694; x=1695544494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BK/UofqNnCW1HejZh6vEf0f3JWk0OhQLopWWHxVZZBE=;
        b=kWkW6qlJqdl6G5Xdbaasi3F7sZs1LfTEzPKdznTbCvL4OSGv//4CB1xmfYeBFs2F+h
         v9wCSaopfhMgI16UkqYQ6dinzDN+nrL30GxH6UyHFS65BkPZk2NeJxnrZCQ2KmycNlH7
         Zr8tSfmI8HdgyJixBMqSnwxeAqHNcZNFqKGd8PbhKzZlIYpqLDc2pjmUyM2fy3LZy9NZ
         Fi8kY9+7UM3JJoxpezoLGnMGE6UAH8RLln9+LGDo6e03pKxe23SX2kFRMyzz437EtKKE
         sWzNG01I3LFeDyr4ncwByk4u88h14Na1FI6SEous1xZAfnmtzTm0cmKY5p5y81dTs86B
         OtzA==
X-Gm-Message-State: AOJu0YwGM8RFAKhNXC1dt6Wg5HobKXKRmYLegllQuW9Qma2E38pPipww
        21eUC9TQvJqtUDyS0y2ERgFbBlL0kzIuqw==
X-Google-Smtp-Source: AGHT+IGvyr4SKwRt74tS2k5QmPoMTWHY78PGiQYkelnw/2nyygJ8tvP4DBVfLtpA6sQpsoLtdRBkhQ==
X-Received: by 2002:a17:902:a3cc:b0:1c3:9aa7:66d2 with SMTP id q12-20020a170902a3cc00b001c39aa766d2mr4565209plb.55.1694939694002;
        Sun, 17 Sep 2023 01:34:54 -0700 (PDT)
Received: from brag-vm.localdomain ([117.243.104.136])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902ea9400b001bb28b9a40dsm6307038plb.11.2023.09.17.01.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 01:34:53 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        amitk@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: imx8mm_thermal: Fix function pointer declaration by adding  identifier name
Date:   Sun, 17 Sep 2023 14:04:43 +0530
Message-Id: <20230917083443.3220-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added identifier names to respective definitions for fix
warnings reported by checkpatch.pl

WARNING: function definition argument 'void *' should also have an identifier name
WARNING: function definition argument 'int *' should also have an identifier name
Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 drivers/thermal/imx8mm_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index 14111ccf6e4c..5dc6c18f12df 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -78,7 +78,7 @@
 struct thermal_soc_data {
 	u32 num_sensors;
 	u32 version;
-	int (*get_temp)(void *, int *);
+	int (*get_temp)(void *data, int *temp);
 };
 
 struct tmu_sensor {
-- 
2.34.1

