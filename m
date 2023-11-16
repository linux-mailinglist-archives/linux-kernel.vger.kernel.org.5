Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36EC7ED9D5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344560AbjKPDBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPDBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:01:33 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAD6197;
        Wed, 15 Nov 2023 19:01:30 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc5b7057d5so3232665ad.2;
        Wed, 15 Nov 2023 19:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700103690; x=1700708490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=svtH6nB/hE04ntCGkIVPHKITT9cDPQUxSxeC2R+EmoI=;
        b=PWjyGpVWInj0h2Zr18H4vCUYg3rY5+SySGLV2LCjlN4nIfZJwPzngbb5R1qEySrAws
         i1DPT8ujEgNlsEahE3/OtjQYWWDnmUQHuNZc9jCvJGNVv2adoM6ebnwFM77E2bkvxvhi
         6GAa/QdHQ6j9sptD5nby/Fl4qe3WFOsumG2jfvs02Wuod0xGV0iT9mbgVud4H8JPKayM
         O/OWDEl9D7id3yqAq0qGYWuurWN9Z0EA8OwfsQge3BcjLhJkL0E4FgbPdxQA7ut/D7Fd
         8AWvPpLySzBd01ULL3sYhacurDsh0MMI2dempsIBXgkAI2nvojYDxQAsJwTYUtucN4rF
         38yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700103690; x=1700708490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svtH6nB/hE04ntCGkIVPHKITT9cDPQUxSxeC2R+EmoI=;
        b=K1jhVlxVf6UkdoZu9vDnF6WLl1ZtXK+TvM+9RmTgPbqDQllAjPpx8rsqBVgj2mj9Di
         eHYRxDQJ7ECT4Z/CwBcr60am+xKTrBDIrYuIkILYarpjPvQzfssi64c+71/nZlBBL9NU
         PXbDNrXlZEHA/yPJ8RdUsgvdobGja/nK0hPIYl09GbltDfDSp92NhM1r1LxCpr34dTzl
         q5kA6xrJTj5AmMgSku8S5xHBUU0VN8PBcUAahOu61M6vAq5uXxRnRA0BLkw2NHs96bfs
         EgM4sIuEjVSdfh5Hp383JiAM7j9ipH5s85cTVXCIaJP2r0yc7N4oWpSiOJQMqW2T5o55
         EISw==
X-Gm-Message-State: AOJu0YyHMwpE6C26iyArMhqLauTSRO+ExqvKhSp1xLqsexxukL430gs8
        CgMGeXyfBImiADT9Q8ODCnIbVGPNXbnn
X-Google-Smtp-Source: AGHT+IGA8rCm7EkqiGzRZiCcdTHu7i5Qme8uVH6OChuTUt3GWx2CHaOCiu13+3T6Uw/uUTdtNHCCXg==
X-Received: by 2002:a17:903:1cd:b0:1ca:abd:1c1a with SMTP id e13-20020a17090301cd00b001ca0abd1c1amr9110647plh.61.1700103689606;
        Wed, 15 Nov 2023 19:01:29 -0800 (PST)
Received: from localhost.localdomain (111-243-26-65.dynamic-ip.hinet.net. [111.243.26.65])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902dac900b001cc50f67fbasm8058322plx.281.2023.11.15.19.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 19:01:29 -0800 (PST)
From:   Stanley Jhu <chu.stanley@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        peter.wang@mediatek.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        chu.stanley@gmail.com
Subject: [PATCH v2] scsi: ufs: mediatek: Change the maintainer for MediaTek UFS hooks
Date:   Thu, 16 Nov 2023 11:01:23 +0800
Message-Id: <20231116030123.10820-1-chu.stanley@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the maintainer of MediaTek UFS hooks to Peter Wang.
In the meantime, Stanley has been assigned as the reviewer.

The original maintainer, Stanley Chu, who can be reached at
stanley.chu@mediatek.com, has left MediaTek,
so please update the email address accordingly.

Signed-off-by: Stanley Jhu <chu.stanley@gmail.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index be1cbc6c2059..4f6fb3357947 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22102,7 +22102,8 @@ S:	Maintained
 F:	drivers/ufs/host/ufs-exynos*
 
 UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER MEDIATEK HOOKS
-M:	Stanley Chu <stanley.chu@mediatek.com>
+M:	Peter Wang <peter.wang@mediatek.com>
+R:	Stanley Jhu <chu.stanley@gmail.com>
 L:	linux-scsi@vger.kernel.org
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.34.1

