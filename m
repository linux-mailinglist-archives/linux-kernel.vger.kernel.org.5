Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A876D78B660
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjH1RZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjH1RZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:25:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A0FFF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:24:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5956735bdc3so1118627b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693243498; x=1693848298;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/oLxkqcj6idE2RAd7eB+LLnuv7c2HnjVXYsMqqnGgg8=;
        b=Q3kdIiExrixB0kXpfSIkMi+WUhVxAjzZp1Gb0Pv92AW7RoauqfxFtrlVmmUAgDr92G
         YT3v72v+p4ZdtUIfnVnnt4izhXVNFK2RaLOtbuijsYwyUD4zlE5ZbDmmOGaAteX6o2I0
         rjeRnbkLNa7xN4WC/7Tk4ej57vemznhk7e5+sQX87NqNVIdfOnOonenrEBGV5LTpv70m
         EOK8gmCgoWq+WNRgfDYABZPBFV68uSsbt77FNJ7F9JS4Xut8mVJOPGih8H/fPSEU0DjS
         zU3AeR8ISUVZQ07y8530/l9a8o/ybm02tigJ6dk72/7WTDAqn5kOIPfrsnSyTGte3I4b
         8nDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693243498; x=1693848298;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/oLxkqcj6idE2RAd7eB+LLnuv7c2HnjVXYsMqqnGgg8=;
        b=JjebLo0yaXWNieLXks8a+WN/jTrMAwyuHxyzI23/VACT2sNH6GW3wARK2wpwVRero2
         TPul9o4mDjl/0eccLjwlYuR2T8WPSOVECe1l14MKCrwlnjxpy3ubF15uIZDNAVjgrobd
         I/4f4ZiAF0SS/R7dMm27InuHknZl/zD0HKNuLhJCzos4ml5np/QZ2DRgC5QMafYZs27/
         rJBgaKaWRWPUKbfVxlInekC5Qm6YhjLBRpLrvsHiu5I3DLOHXWQBNDY3CYlOjFfec73b
         c4vItlUteThAzqVtfahCg16a9w439FHj7N3ozG7ylc4QehmHv0NwkERyI/Q9KqgQh2VD
         D9Bw==
X-Gm-Message-State: AOJu0YxiYMjuOzGOCwkOzkFiksqB2tM8oNKtQwP8Qicw91YTB3d8rs5E
        7Lb/H8Ust++Ub9xmqWSJztG6BP/67HBDgeUsHkw=
X-Google-Smtp-Source: AGHT+IGK2UAO+x9AivLfeQCbe/oWqNS//H5fFRBkRtH1NHfK+e8tED1exgd39eYPQHfAxiWZ7GpFXPzi/ILoF0aXDNM=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:b64:7817:9989:9eba])
 (user=ndesaulniers job=sendgmr) by 2002:a25:d809:0:b0:d01:60ec:d0e with SMTP
 id p9-20020a25d809000000b00d0160ec0d0emr864417ybg.9.1693243497711; Mon, 28
 Aug 2023 10:24:57 -0700 (PDT)
Date:   Mon, 28 Aug 2023 10:24:56 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGfY7GQC/x2MQQqAIBAAvyJ7TjBFkL4SEaJr7UVFKQLp7y0dh
 2FmQMdG2GERAxre1KlkhnkSEE6fD5QUmUErbZTTTsYS+p7ouaqMxhtrfUwuKeCgNmTxz9btfT+ CiCgEXAAAAA==
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693243496; l=1285;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=zCJ5iDIwWerWby5h6qezWElTcBWFCjLXZm+/Emze4k4=; b=Be7HD5ZZzeKJKDc7FCdvIqAeEUnkF5wWw4dcsSwn+XM/KS7qdTk8/xSGsBu46LPiDpE8tF4YV
 kYUBq67QmrBC/DHsEyUTt2eT9Z3C+LmJgo+FpAyYBzTdDk7AxcVeK1l
X-Mailer: b4 0.12.3
Message-ID: <20230828-docs_fixup-v1-1-cc78af124667@google.com>
Subject: [PATCH] Documentation/llvm: fix typo in link
From:   ndesaulniers@google.com
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following observed build failure from `make htmldocs`:
  Documentation/kbuild/llvm.rst:127: ERROR: Unknown target name:
  "reprocible_builds".

Fixes: bda09c0e14a4 ("Documentation/llvm: refresh docs")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20230828145737.6ff53bc9@canb.auug.org.au/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Documentation/kbuild/llvm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
index 384622dd36b7..b1d97fafddcf 100644
--- a/Documentation/kbuild/llvm.rst
+++ b/Documentation/kbuild/llvm.rst
@@ -126,7 +126,7 @@ Ccache
 
 ``ccache`` can be used with ``clang`` to improve subsequent builds, (though
 KBUILD_BUILD_TIMESTAMP_ should be set to a deterministic value between builds
-in order to avoid 100% cache misses, see Reprocible_builds_ for more info):
+in order to avoid 100% cache misses, see Reproducible_builds_ for more info):
 
 	KBUILD_BUILD_TIMESTAMP='' make LLVM=1 CC="ccache clang"
 

---
base-commit: 2ee82481c392eec06a7ef28df61b7f0d8e45be2e
change-id: 20230828-docs_fixup-d3a355adf8f0

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

