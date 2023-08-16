Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD2B77E8AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242561AbjHPS1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345610AbjHPS1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:27:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8E92D69
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:27:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589f986ab8aso2523977b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692210410; x=1692815210;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S6as3BxJpUCbqcYsYLfwqrd6wpI3WguOJqonU+8LSLc=;
        b=z0c2F/G/8ZqCH25VdVy3+VNDQI8CZeomkJY3XdzlkKQh/JwPUa5Z1o9g74b4z1pxiH
         wRYVTVuqobGllrdShttdO/QSk1CkCvnHciCc+U6yeBKeMn+G8bMhR+kKrlyHuLI78mgH
         /xhC9LfsawjIy7OW5AbgBlur6CBQyM9oq+7T98ppgngF3OFCO5C4JO0Ati2/MimQ3z9U
         GEv8Fn8BOAvyhA3xgcd9vgY4844c7XHjvtPwYSJ8J0FHRfSxmOZ7IyzbNBghkWgIAK5u
         svFaihEPiZ2b4puUHNUBBfwTU3sl64Ck6rlz10eKKLgLmoxIB/j85T+jNUpMtdvqTLcr
         FPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692210410; x=1692815210;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6as3BxJpUCbqcYsYLfwqrd6wpI3WguOJqonU+8LSLc=;
        b=HwISsZ9isD+azjcS6UvTGOStYNasozA+SEzlJJ51p4/Mbmdmmm1mgNyhNy3anMrmSv
         +AC7A3qmPfmUPBg7radnK04qmdN51lRy9go5+xq0UH/GG/TfTrKt8Gfgy2GqTVL3jRkU
         MerubPvYQ4f6/x/M83v7ZtJtYAskf3hxNfkZTsFiBtgLeoYuY8wRfrN5CFAsOpGO939v
         5RsXW2Xt5PtKwijEFEMls/u1K7MVnjqfktLBsW2pNNw4fCJdr/XjqdLTsgqwrkXmGMK5
         gpT3RtoT7pz79uYes6phPjrNtOebKjR2Y+LOTgJafiWNNqBzQy7E7X7nJ6w/82itW7Tt
         X6Jg==
X-Gm-Message-State: AOJu0YwhfmQEW2x1N54X2m/t5NFsEwQ8udIqhVV1+93YLGNpjnV6bmKn
        1Lp3pb5XoAVTubcyChOEA2o4HgS+lfVFA5VJ8g==
X-Google-Smtp-Source: AGHT+IGHa/5g87NdPEOq2wAtPaDB0w/dWc4EOap0B976E0FRPaTqbUwY726ZhRQ4H+6EEHfTB93fXA2tnit2luAlDA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:4316:0:b0:58c:e8da:4d1a with SMTP
 id q22-20020a814316000000b0058ce8da4d1amr8918ywa.2.1692210410645; Wed, 16 Aug
 2023 11:26:50 -0700 (PDT)
Date:   Wed, 16 Aug 2023 18:26:44 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOMU3WQC/5WNSw6DMAwFr4K8riuSlo+64h4Vi5Q4YAkIilFUh
 Lh7Azfo7s0s3uwgFJgEXtkOgSIL+zmBvmXQDWbuCdkmBp3rR16rAqNnizZwpCA4rRYnswguwyZ
 p4GnNyiOh1lXuqHLWqRLS2xLI8fcqvdvEA8vqw3aFozrt/42oUOHHlK6rS1vQk5re+36ke+cna I/j+AGL1kKx3wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692210409; l=1749;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=8lAIhnmpRVK+py4l8xzNXorgfe03DykVYWVS/7qh4fw=; b=ktG2rQbNbxM+rTl/KVl5MI/PcP0u3a40de2Mqg6Bm+oJeBznguW1yO4lm/q5TFtmA7hRZT6nf
 DixvkgTw1w3BeuZDW/cwGzcjia8AwOtJnFMUleRe1Ten7DKqdvdMwwp
X-Mailer: b4 0.12.3
Message-ID: <20230816-void-drivers-mtd-maps-physmap-versatile-v2-1-433a25272bfa@google.com>
Subject: [PATCH v2] mtd: maps: fix -Wvoid-pointer-to-enum-cast warning
From:   Justin Stitt <justinstitt@google.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang 18 I see the following warning:
|       drivers/mtd/maps/physmap-versatile.c:209:25: warning: cast to smaller
|               integer type 'enum versatile_flashprot' from 'const void *' [-Wvoid-pointer-to-enum-cast]
|         209 |                 versatile_flashprot = (enum versatile_flashprot)devid->data;

This is due to the fact that `devid->data` is a void* while `enum versatile_flashprot`
has the size of an int.

Cast `devid->data` to a uintptr_t to silence the above warning for clang
builds using W=1.

Link: https://github.com/ClangBuiltLinux/linux/issues/1910
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- Use more accurate commit message (thanks Krzysztof)
- Link to v1: https://lore.kernel.org/r/20230815-void-drivers-mtd-maps-physmap-versatile-v1-1-ba6fc86d5e4e@google.com
---
 drivers/mtd/maps/physmap-versatile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/physmap-versatile.c b/drivers/mtd/maps/physmap-versatile.c
index a1b8b7b25f88..d65cf8833771 100644
--- a/drivers/mtd/maps/physmap-versatile.c
+++ b/drivers/mtd/maps/physmap-versatile.c
@@ -206,7 +206,7 @@ int of_flash_probe_versatile(struct platform_device *pdev,
 		if (!sysnp)
 			return -ENODEV;
 
-		versatile_flashprot = (enum versatile_flashprot)devid->data;
+		versatile_flashprot = (uintptr_t)devid->data;
 		rmap = syscon_node_to_regmap(sysnp);
 		of_node_put(sysnp);
 		if (IS_ERR(rmap))

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230815-void-drivers-mtd-maps-physmap-versatile-2270fe7fdf16

Best regards,
--
Justin Stitt <justinstitt@google.com>

