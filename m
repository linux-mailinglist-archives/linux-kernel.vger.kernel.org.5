Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7342177D4F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbjHOVLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240085AbjHOVLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:11:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A329AB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:11:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589ebdea23fso49927927b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692133875; x=1692738675;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3y6Izf6PWqeRPwTjJUSGtpHjQ5Xbrf4Hr6LZlxEahOk=;
        b=DEykWB4VPD0KGwkR1rgTEkxuGrmyMbRmPDZOUHEnPXwFaHI3rUqsojcqqySGFoopGa
         qtooGMRnC2iBatnU5WIMN05g0vZUnhEdJZVjk4lw6MaKHZj3uELr1pxCP5/hsgTqIrBu
         1inqQgqIJZJ0VlbPAJIpm9/aWo9WsTqBaNDDVihJxzTBMBNgex/TOLHB2mYmoJOp1Kva
         bWeQr8NZbtkqjwq7mvqMAtaqjcOqkVBp/oDMzrZX7hqKYwQW4a6d2vnhTsoUk3GQCY2x
         1lnjzzGiQr7G4wgDP1gxwsyDXBuhUnF7eiCe83f1an5ltuLTmcDWNx/do1f/T7qdFpLb
         btCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692133875; x=1692738675;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3y6Izf6PWqeRPwTjJUSGtpHjQ5Xbrf4Hr6LZlxEahOk=;
        b=Q5tvpNfSixutkgK1QPta6lGlna4XfuWROqNbLTjMpLMJ501HZp0eF9W2kEWqpq5jXk
         Eo8jEczdj+1Pml+FnTc970bNHXriJ/YEt2OB7ez6Zxe4NzYGvDjeyCXkI8RsfB6F+kq8
         d5qylIuaRCNVe2MzvEeVF4VBbmeo9Hg0TDhbLqRo4ujbB+ubt85IeT+tO6gIVz6XJwDL
         qldKvE0I4FSttWKBagT4SNV7WidnyOu5TwdlembAzcGQ+RK1Seeq6rtTqnp/I5iK+etV
         lR/NIZKN+IBfQdimnJhv8IMlQIPomrzo7m2KlOZnGOr3dyZuw54735ZQP7YvPLkJQWko
         BXIw==
X-Gm-Message-State: AOJu0YzhUFJ4I9EBK+TNyqRgzDNwFJoZtt3zGx+rrSN/c9xg7U0kuGqz
        mVV236vSZQU1xOcr5xhm2B0Zd0gTbqZULBhT1w==
X-Google-Smtp-Source: AGHT+IESHOcNCiS8o17qcx7V9DnY9/u5Ejmnxug8PTEedCECk+Qy3ouUC8CMmwLN9yzo20in9nO1So2V6LKsvaBvXA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1818:b0:d08:95:76d with SMTP
 id cf24-20020a056902181800b00d080095076dmr2170ybb.6.1692133875480; Tue, 15
 Aug 2023 14:11:15 -0700 (PDT)
Date:   Tue, 15 Aug 2023 21:11:12 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAO/p22QC/x2NQQrDMAwEvxJ0rsB2aVP6ldKDqeRG0CRGCibB5
 O9xepuZw24FYxU2eHYVlIuYzFMTf+ngM8TpyyjUHIILV/fwNyyzEJJKYTUcF8IxZsM8bNYAzxo X+TGG0LvEfaLk79DWsnKS9f/0eu/7AWJszKR5AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692133874; l=1857;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=HWSTPugX/6hl45mOi43ekrd154LFJ7mP03sqOaFNygg=; b=mUKhNFxwaMYAvGE8r2mEXisjetzD1WuRCSRRz8uhoZeTBBafOwti17CqjOH6uuGZ7lX7yJ56h
 SfAxWxpgjWqCv3/V5qSm4hMKInmpums0ZWkx3xU6Pf+KbCoMPqB90qI
X-Mailer: b4 0.12.3
Message-ID: <20230815-void-drivers-mtd-maps-physmap-versatile-v1-1-ba6fc86d5e4e@google.com>
Subject: [PATCH] mtd: maps: fix -Wvoid-pointer-to-enum-cast warning
From:   Justin Stitt <justinstitt@google.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
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

This is due to the fact that `devid->data` is a void* while `enum
versatile_flashprot` has the size of an int. This leads to truncation
and possible data loss.

Link: https://github.com/ClangBuiltLinux/linux/issues/1910
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: There is likely no data loss occurring here due to the fact that
`enum versatile_flashprot` has only a few enumerated fields, none of
which are large enough to cause data loss. Nonetheless, this patch helps
towards the goal of eventually enabling this warning for more builds.

Signed-off-by: Justin Stitt <justinstitt@google.com>
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

