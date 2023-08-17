Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2158077FD49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354118AbjHQRw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353791AbjHQRwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:52:24 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D5426BC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:52:23 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-1c4d13ab88cso6017117fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692294743; x=1692899543;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n2UG2OG5KrxWJ0s3qtnx/i+Fr3CRP1zZ4JSm6GFIF8c=;
        b=camaHaV/Gbd+c1ik48sZSGrt5XHK8lSjJ9F8mxQ8gLFTx8n435uppOnVSxPbS/8nUS
         4uVnoANdukrwQN7xcDWOUWsUPjc725/cuRivpAvQBhIgg6CzB/aSMHIlyh0G0EgNj1Qp
         xlseRYQh4Fym8TvlpTtsxzYaJutZpSvYLdRVHFCnjq0P7HspwTp8XdfkwSXhM0QaFv5j
         84snFfINaQiAptUy7r4lVlsr3D2JGzcYWqpD9iw+iBq5pTW5Ju/bRMC6yDqTTcvUscc7
         Q2SGV9kcFEyWXJmEeBKXjHlCwSjI4T58yrXhGZS5J05eSAXz4ogD5Au17r54xzjfHatF
         BXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692294743; x=1692899543;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n2UG2OG5KrxWJ0s3qtnx/i+Fr3CRP1zZ4JSm6GFIF8c=;
        b=WPKNFkgAvuRaq1+NzpAY+m2EVoqwaDEbCr/nquMZAzSFalEMl3T1talWfMZcav0Gof
         sFwLM3Swsmt/5slYmcibZUrdO05oGXKZe2LB4PALsq0rXbZqr8AN2dGrtwBG3R6GpR5m
         jkAQ8V45XDswxUQ3l/UpPl/EsmNBn5mBPMoyEsAiocM1Eka/MZpElMbu5NtwpbEBIE0V
         N+gkc3sMQP4Sx7KWlR+eB5qkVYFszBkXXf6/L+gGGwt7/kTi1fAzXEzyz5mz3MHy00tB
         2xpdPArflBnf0QIv/zoc8Qmfjs5Nr6bQpLfTqXzNT9bJpzh80lMspx/jMwo+Nq/HIWZa
         6WlA==
X-Gm-Message-State: AOJu0YySvFCPe8reYR66O4gd1ZxrnBtUupHhqgWWRXuBxCE3obnauj66
        4UuBTu4qvl5JN0amOYcVL9eN1c5r5SZPXdzifQ==
X-Google-Smtp-Source: AGHT+IH06wac0SBG25lJJhXNOWcsSI2IvrGrskfXKVnJv8hj8F+qNwDIvYHlFs8yFjiUbo4MsE/swog16j/Elyccow==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:a8a5:b0:1bf:d3b8:5cae with
 SMTP id eb37-20020a056870a8a500b001bfd3b85caemr2392oab.10.1692294742832; Thu,
 17 Aug 2023 10:52:22 -0700 (PDT)
Date:   Thu, 17 Aug 2023 17:52:21 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFRe3mQC/5WNQQ7CIBAAv9Jwdk2hBRtP/sM0BhdoN7FgoEFNw
 9/F/sDjzGFmY8lGsomdm41FmylR8BXEoWE4az9ZIFOZiVZ07cAl5EAGTKRsY4JlNeC1NxD1C7J
 TvL15h6Cwk4PrRX8fNKulZ7SO3vvlOlaeKa0hfvZp5j/7Xz9z4HBCVLLjPUqFlymE6WGPGBY2l lK+MSeyT9cAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692294742; l=1720;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=MouGUYg3kqvRKE/s9FPfueuRCAtPM0lCpE5G1aOdCPA=; b=0qynUlCcs0UVl9/8Ugxh9CjQAoBaOahFyRH41Qo/Dkbl4zK00nH7C2j1ViGwNZ0iDLJGBWUBo
 sgWqOz6c9VeCZ3x2xIFjaBqNJmlKt5jXgy0SlqoZ0OqWSxdtsgE9+uq
X-Mailer: b4 0.12.3
Message-ID: <20230817-void-drivers-mtd-nand-raw-vf610_nfc-v2-1-870a7c948c44@google.com>
Subject: [PATCH v2] mtd: rawnand: fix -Wvoid-pointer-to-enum-cast warning
From:   Justin Stitt <justinstitt@google.com>
To:     Stefan Agner <stefan@agner.ch>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang 18 I see the following warning:
|       drivers/mtd/nand/raw/vf610_nfc.c:853:17: warning: cast to smaller integer
|               type 'enum vf610_nfc_variant' from 'const void *' [-Wvoid-pointer-to-enum-cast]
|         853 |         nfc->variant = (enum vf610_nfc_variant)of_id->data;

This is due to the fact that `of_id->data` is a void* while `enum vf610_nfc_variant`
has the size of an int.

Cast `of_id->data` to a uintptr_t to silence the above warning for clang
builds using W=1.

Link: https://github.com/ClangBuiltLinux/linux/issues/1910
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use better commit message (thanks Krzysztof and Miquel)
- Link to v1: https://lore.kernel.org/r/20230815-void-drivers-mtd-nand-raw-vf610_nfc-v1-1-7cc65314c56c@google.com
---
 drivers/mtd/nand/raw/vf610_nfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index 86522048e271..11d996dc655d 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -850,7 +850,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	nfc->variant = (enum vf610_nfc_variant)of_id->data;
+	nfc->variant = (uintptr_t)of_id->data;
 
 	for_each_available_child_of_node(nfc->dev->of_node, child) {
 		if (of_device_is_compatible(child, "fsl,vf610-nfc-nandcs")) {

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230815-void-drivers-mtd-nand-raw-vf610_nfc-6c358f424b8a

Best regards,
--
Justin Stitt <justinstitt@google.com>

