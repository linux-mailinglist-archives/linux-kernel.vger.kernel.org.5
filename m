Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAD17E8A4F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 11:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjKKKm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 05:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjKKKmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 05:42:47 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35053C07
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:44 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-9be02fcf268so441630366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699363; x=1700304163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfR080tdra7BLhUIWSvcaEDMSQNVyZv5MjwAaJaquw0=;
        b=GrCfM2erwPgk4/3+nyPnjZ2JFTv3Wwvd+P8cfyzcebe4TdbGQuwMOCiL2NeTI/cPZn
         HntLgdH0GyHiyjjlgnFbRK1YPaxn8YeRBiiYwIOCJgXuYnCl12mTsX2sEWy1vCWl5g5B
         dSN2gymXCMVjLelNQ55s8bWQTTUCeLODdZvkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699363; x=1700304163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfR080tdra7BLhUIWSvcaEDMSQNVyZv5MjwAaJaquw0=;
        b=E/8fl+odcMcLbxjwWdRVkLiaVajUNF94DsB1qm4pyYtU+Zhun9UyV2vzQfG8qWSp3Y
         dqR3/NjGTku1FuH2pIDCK45EW4yCJwo6O7zDjTr4eoi1kba05hpxmXb0ghl71kDFbJRT
         3N37rbVGTmGblsens2lsCwQKyY/oV/22NmqplBYhDx50bUDZe1pcfMUlDuPSZwGg/jiH
         C7BzDaozDzadXTi43PFZ5fyQspGSp3/JimQfWSzIxRJAs/Q52e7nDGTHenbpvsekebI4
         PMeHfA+GgeBb3BG8x1JSG8FWZWTQVMobu15pnXgZoxIGUJNLTC4Fw2otFSjl0EJrXVDp
         o9Aw==
X-Gm-Message-State: AOJu0YxLoAcr/MGtNUNpFJWSP7yES5ZbfasZztIOAni3dMY1nC6tbAiv
        RJd+lbBxT9ZLIvV+NY1BjF1QgcupqU8N9SOETZVQabWh
X-Google-Smtp-Source: AGHT+IERVItiW0QNcc7Itc1tQ63vCmzWRiYW8aKUXkxzrDZclJWRXQE4ZuhMCcTgFOSgvNri9tEQNA==
X-Received: by 2002:a17:906:32d9:b0:9cc:97b:5a15 with SMTP id k25-20020a17090632d900b009cc097b5a15mr963727ejk.64.1699699362713;
        Sat, 11 Nov 2023 02:42:42 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:42 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Fabio Estevam <festevam@gmail.com>,
        Helge Deller <deller@gmx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 05/10] fbdev: imxfb: add missing SPDX tag
Date:   Sat, 11 Nov 2023 11:41:54 +0100
Message-ID: <20231111104225.136512-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
References: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
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

Resolve the following warning reported by checkpatch.pl:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

The patch also removes some license info made redundant by the addition
of the SPDX tag.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/imxfb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 485e57fa9389..de1434069530 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  *  Freescale i.MX Frame Buffer device driver
  *
  *  Copyright (C) 2004 Sascha Hauer, Pengutronix
  *   Based on acornfb.c Copyright (C) Russell King.
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive for
- * more details.
- *
  * Please direct your questions and comments on this driver to the following
  * email address:
  *
-- 
2.42.0

