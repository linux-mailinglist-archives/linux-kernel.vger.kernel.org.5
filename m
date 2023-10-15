Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F867C9B55
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjJOUPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJOUP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:15:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF8EDE;
        Sun, 15 Oct 2023 13:15:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso622201966b.1;
        Sun, 15 Oct 2023 13:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697400927; x=1698005727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOqkDNi2G1klSItw+VfFUFmDBPvfXQMPHAdmvnTWKuY=;
        b=dMLMAH/Z6JUUUKif67a1PIqErjC7VE0HEIAO/qhxt2Q1EQrsNeMccK0g4rmfn1piEI
         MOASk5ymic0s5gIM67mPPgPaaRvbLPQlZTaZrs9KaKW7stBnpspRBDEXDkN5VtTYdgqk
         OfRAnctFYtb8rzXnF+SFemkbi7qdAUf+F21DbuNynWXRgjaxIgEiVkVUPe9cNnm+KcBP
         ovqdw897+lbmwDWf0IbepSCkHxtWIue46B/zyHiMnfapkF92ZEACifwthxtmS7Rkv3XK
         KOKW/ohrwsIP3D//Ov0C8KwmibDVNmaEWFsVuU3TnmkWmGTPHYi/Yy8/WX2k9p24W6pT
         XS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697400927; x=1698005727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOqkDNi2G1klSItw+VfFUFmDBPvfXQMPHAdmvnTWKuY=;
        b=HCrxxLvXO7JwbhrT56p4dJZ+fsGmCQdmKTgdoCBbuTmwogdHTMdmRM6gIOk2kb7zxV
         UFPsyQRoSUum+xjtjiD7iOFTz1oJrcAUmjiqW4mrOUDL9mTQv4tj/5nk6yplQ5UOF6M/
         VbgKAvUHXZe4S+wKgY914Z85QtcAzXd5EQ+IZzb3mF7rez1+p1+s9jhYT++3CNwabYe4
         +Nk1Cb/IB7/8S2LgyY5EI+Ln/UjTa3jb9K2I1d7N3z4EGmUmOKeqnwXsxSlwZVbakLj0
         A9I5ZtMh/DAW+6qSzfSf3Y7YznFoYPwnTlrOxXuRtj3yYvq2JXCcbLasEzkVBC5/PjLO
         KpPQ==
X-Gm-Message-State: AOJu0Yw+hlY0P5/W7nxs1Q5lIR9vBCoywv+zJhAQhu7DHQaRqoVERhnC
        9awHzsT9fnozc7glWiNQdI3bvFlFawoUSlQ=
X-Google-Smtp-Source: AGHT+IGmDRzZZ15imc7zYxdckrpC7tosOr9IS4ylHP2yT0JnqKftSePWFbjYO1E8NFxywr2czVZL4A==
X-Received: by 2002:a17:907:7ea4:b0:9be:6395:6b12 with SMTP id qb36-20020a1709077ea400b009be63956b12mr5248720ejc.27.1697400926427;
        Sun, 15 Oct 2023 13:15:26 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.157.6])
        by smtp.gmail.com with ESMTPSA id m10-20020a170906234a00b009ae587ce133sm2721766eja.188.2023.10.15.13.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 13:15:26 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Staging: sm750fb: Rename programModeRegisters
Date:   Sun, 15 Oct 2023 23:12:37 +0300
Message-ID: <1f4999e1523371bfb7dadde8eea7073ef3a04c75.1697400022.git.anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
In-Reply-To: <cover.1697400022.git.anonolitunya@gmail.com>
References: <cover.1697400022.git.anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function programModeRegisters to program_mode_registers. This
follows snakecase naming convention and ensures consistent naming style
throughout the file.Issue by checkpatch.

Mutes the following checkpatch error:
CHECK: Avoid CamelCase: <programModeRegisters>

Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index fc3db09de9ae..e901855fa9b6 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -75,8 +75,8 @@ display_control_adjust_SM750LE(struct mode_parameter *mode_param,
 }
 
 /* only timing related registers will be  programed */
-static int programModeRegisters(struct mode_parameter *mode_param,
-				struct pll_value *pll)
+static int program_mode_registers(struct mode_parameter *mode_param,
+				  struct pll_value *pll)
 {
 	int ret = 0;
 	int cnt = 0;
@@ -220,6 +220,6 @@ int ddk750_setModeTiming(struct mode_parameter *parm, enum clock_type clock)
 		outb_p(0x88, 0x3d4);
 		outb_p(0x06, 0x3d5);
 	}
-	programModeRegisters(parm, &pll);
+	program_mode_registers(parm, &pll);
 	return 0;
 }
-- 
2.42.0.345.gaab89be2eb

