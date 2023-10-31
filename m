Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C07B7DC5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjJaFf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjJaFfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:35:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D41BD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:12 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc5b6d6228so10224615ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698730501; x=1699335301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl870JnZ4hTIQ++KxGAzU1faBppIdJahzCd4lGE08z0=;
        b=L0RsxGAvKCiHzLoaRWbcDFwLcUVm55SQVr0QaykM1BSCrrlGFEF2DHBPBQdclEtkBL
         Ukm7l6e6UUl2MjnfzD67GgLeGo3BIYgZLkpPUS4OSm2GHCs5Y5GVXgvS/1a9ioXfonq9
         kZNxyO/Er3Wbtm0yyikUaZYT9sIPu44JV4RiWZNh4z83KX9CHAbIkW9+x91OqZq222Ms
         yAk0/DEBk45CxVV/HYHtHjjbxnMtXF/Vdi86Tk1dIKP/iow6+/CTYNOCGUXFBsh19o7Y
         g+7zm3nvKhxb9trLZq3uCTZCeXLyVIiCzV9SU/bKzYNIgQMel1HLTioZKbI3p07KLAJk
         ckeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698730501; x=1699335301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rl870JnZ4hTIQ++KxGAzU1faBppIdJahzCd4lGE08z0=;
        b=WZd0ctXRjArcHZFpKx5Y2LCSWs4r/aQliiU4WcSYGUKHuE4YuuhSSXjSWyuS3qJ1p+
         Jzp7t9fm7kR6r5hAAxkFnpWlYzZ1WciYWdBae8M+gWt/Q8MSrsergFkpD2SSy6o85SXl
         avzCfceJQ+LZt5gGOXnVajQXLF7qknrKIngJAZP/4oa3UFhrPPlm75jQIm3JV2OnDoe3
         oQY4lzDPWu9YeyYsIU+Sm2QFoN5EZbAeFlGRRR4EWjpLZk4A9QQ7bHkIlvEKYkCwWBeS
         dEsiAVCfK9+A2Yb90bSqggg/NegXLDZgaSwVRMpnmOteEZGTHRnMjuWAJp72gZ8QnTo6
         JeiA==
X-Gm-Message-State: AOJu0YyWD0wIL6J6lUPaW/UQAWQj8mX40GZXihGQXtZ+7+dCsEz6AE2p
        QLqvJwmLRRXgBtQv7CKxnGo=
X-Google-Smtp-Source: AGHT+IFwj8WKebJrOXAshRQFxkCACrIGsFphLy02voEXYOEigu4AoA50dyzKuuS9gmqJ565lGbrxPA==
X-Received: by 2002:a17:902:d491:b0:1cc:50f6:7fcc with SMTP id c17-20020a170902d49100b001cc50f67fccmr4334968plg.55.1698730500952;
        Mon, 30 Oct 2023 22:35:00 -0700 (PDT)
Received: from ubuntu.. ([122.182.231.82])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001c0a414695bsm422211pld.43.2023.10.30.22.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:35:00 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 10/11] staging: vt6655: Type encoding info dropped from variable name "pCurrTD"
Date:   Tue, 31 Oct 2023 11:04:33 +0530
Message-Id: <06dc61ae807dcaa1dd8fdbf18686f0f4c20be634.1698730318.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698730318.git.opensource206@gmail.com>
References: <cover.1698730318.git.opensource206@gmail.com>
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

variable name "pCurrTD" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index b249f22246b0..d20afbc1072f 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -385,7 +385,7 @@ void card_radio_power_off(struct vnt_private *priv)
 void card_safe_reset_tx(struct vnt_private *priv)
 {
 	unsigned int uu;
-	struct vnt_tx_desc *pCurrTD;
+	struct vnt_tx_desc *curr_td;
 
 	/* initialize TD index */
 	priv->apTailTD[0] = &priv->apTD0Rings[0];
@@ -398,13 +398,13 @@ void card_safe_reset_tx(struct vnt_private *priv)
 		priv->iTDUsed[uu] = 0;
 
 	for (uu = 0; uu < priv->opts.tx_descs[0]; uu++) {
-		pCurrTD = &priv->apTD0Rings[uu];
-		pCurrTD->td0.owner = OWNED_BY_HOST;
+		curr_td = &priv->apTD0Rings[uu];
+		curr_td->td0.owner = OWNED_BY_HOST;
 		/* init all Tx Packet pointer to NULL */
 	}
 	for (uu = 0; uu < priv->opts.tx_descs[1]; uu++) {
-		pCurrTD = &priv->apTD1Rings[uu];
-		pCurrTD->td0.owner = OWNED_BY_HOST;
+		curr_td = &priv->apTD1Rings[uu];
+		curr_td->td0.owner = OWNED_BY_HOST;
 		/* init all Tx Packet pointer to NULL */
 	}
 
-- 
2.34.1

