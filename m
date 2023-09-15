Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48037A27D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbjIOUOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbjIOUNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:13:46 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBABF2D4B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:12:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c364fb8a4cso23536185ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808765; x=1695413565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/9ednYaRcJqbNHBCr/S6Xdi9dFFsTXXFXM7WGc+jfHE=;
        b=oOA4U0z+DKedymQeLiefny2YObaElqYQGxh67bWSu9jBgBPOnJRbq9fIZ6sq1A6/Gj
         yTycAn7CI8BsSTWI7LBiPRYkMBc6NYlH0TL1uJKtsF0/F9PZBke5Q52BoIniNU3qpbJQ
         yQunBfllkbyynBcosU1KHqvfFi3s1IU73FTaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808765; x=1695413565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9ednYaRcJqbNHBCr/S6Xdi9dFFsTXXFXM7WGc+jfHE=;
        b=u8I4rYDvnveItNS0VE907rGqWth6lxTO2rsL20jq/EApYjE3CaLZGutLJhgvqpsgFd
         3wyX0Jdzr9KNfDiNgjlhr4tfCx88EvXCHvOsIzYE3EBa1x32YA32CaViwF9A4zoybwO7
         FjBgKFBK0P/WVT7YkuZHVL1e3KgEmu9SakP+5no/5dGPmV3HETKYyI7KljvVUaa6CkNl
         dA4uoBbLBFtcQhxVBJu1EFrCwIHOGAxn7/wK0S4iMOZKuvU+388LmuCPSfGICbAgSaXV
         uMZwEP0XkRYUTfKE+PIp7VVi6l7aGQFqHZcnKgO+YGg9N3ZVrKiC1hQZ3isIMOIjzmhq
         A7lw==
X-Gm-Message-State: AOJu0YxDctADuXpYs0IkAKx2ID7dnbjRJ7iSq8q2VQPS989OcvKBS/l+
        6u3LeRCrBm5JC7vLxAs6o/hhaA==
X-Google-Smtp-Source: AGHT+IF26agxIuVbx2bzTaD9bnr+Fu0VoE03C3/1yq+KoExa8nJ3wdcTmCK/3DSQQpd1lF7ovsqncw==
X-Received: by 2002:a17:902:b494:b0:1bc:6c8:cded with SMTP id y20-20020a170902b49400b001bc06c8cdedmr2417137plr.67.1694808765369;
        Fri, 15 Sep 2023 13:12:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902c3ca00b001c3cbedbc47sm3859508plj.6.2023.09.15.13.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:12:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] mtd: rawnand: marvell: Annotate struct marvell_nand_chip with __counted_by
Date:   Fri, 15 Sep 2023 13:12:43 -0700
Message-Id: <20230915201243.never.235-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=keescook@chromium.org;
 h=from:subject:message-id; bh=TQ33NzB9u1hD2EeLpj7Zf3S9y0fIk3egTEL+4CNIaZM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLq7Uo+K8oyZTYA57xeasyFe+Qr+U0ga005PU
 otIx9G3DgCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6uwAKCRCJcvTf3G3A
 JsKoD/4pERGmBwMG1bnu0pOlCoKD7XbCGlqkd/EhEKPpQocWXRVqfmHIwKg9nm+oRxEEY/fQgRJ
 HPDNMYrW4NCVpCfktLjVuNqULEYV1xQhPXiRPbtPoctSpCffUAcDGeSdxZ+ADTtOMCf9YMxZ86M
 XeE5QMBNAWO10BnFaiCeF+DVmCbhIPN3voMjzZNhZrbp+4ZZHnkStN1CWXoqUdEFxmjTfye2xEo
 6GSoFfDAUz4lsOp4p23NBSGDoXS+hoVMhk5NCWJ5o2m1Tg3GM58ZAevy+KZG+bCZy68wh4S7FQQ
 QX6fTuhdxeEsnWoOJeYfaHXkjDTJNn+kizzywtJNe5YfkZ6Sfc/NeMytmeOyQl/MskHmZDM30j8
 naA4EfZc8RPme4ulzyVc2SWSMilvBlKUGF/rWF40drwKmQVBJN3ppGzcxkvvYuLlswVxmMnufHb
 Veidh2Y/zUi/crLXAwAyph5HkKkLM3ugeU+mHQP/jsi1T4ckqzw0U9EHXgkUVm03oZ1pnzc86v9
 0ztGQr/8O+Sgok15/8FkWTTeS4qXajh/GTDLetIc4wxK21KZzQNRlQuTIXTCJUL3M9ZHuV3Wm0z
 EfwVgQMW9MD9gPWZdJUzuZuFMYiEzHmKD0j52m0w7qb8t4STrDA6+OKfBN50dsM0Pivr2OSq6hz
 afLGe7T gFR43eRA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct marvell_nand_chip.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mtd/nand/raw/marvell_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index b841a81cb128..a46698744850 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -348,7 +348,7 @@ struct marvell_nand_chip {
 	int addr_cyc;
 	int selected_die;
 	unsigned int nsels;
-	struct marvell_nand_chip_sel sels[];
+	struct marvell_nand_chip_sel sels[] __counted_by(nsels);
 };
 
 static inline struct marvell_nand_chip *to_marvell_nand(struct nand_chip *chip)
-- 
2.34.1

