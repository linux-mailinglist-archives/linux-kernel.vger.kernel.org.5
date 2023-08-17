Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9198477FF40
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355017AbjHQUp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354996AbjHQUp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:45:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A6730F7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:45:26 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bee82fad0fso1821115ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692305126; x=1692909926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pMm0/808CNGa3aT1/hWj5cxfbWGv7KS7xsYpPdCv0WE=;
        b=Hba9RUgUZEtj0CVdjLz7pSKYV71ZGnjTWbN7fT7j8VmDbWCNH7/Kb8mwvIODbEdUjh
         G4Dez3nqrO2b5mJVfoUjbCWCIbo3JLVEO8py6g+qeU3Q2hpyjq30jFe3SjLvKgYPKQhs
         kRO8DdhFpW1DHPFaa64Byi9R/aHUlYKD1cxb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692305126; x=1692909926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMm0/808CNGa3aT1/hWj5cxfbWGv7KS7xsYpPdCv0WE=;
        b=GlZGDM0ShiFqiLp2uv2ecItGIrMn2c0GSrejPCYYuOHOjTk4GzgGpuS57bmsTCWAK7
         a0DVZlFAtETkEv5bA0iFaHcsR97LBUjy9TqqTI+l0+en8zqKpW5BYN+7SNHWgGN/7Iq7
         kN7ktH+jIyIzngqlynlH9zpAYHUk1An6jQzJH4MxreDXjqwkq8LAVUJW+AK8eiPlyvBn
         jCh7jsL76lXRK73BRSoNKe4QlkcPE/ELNnwsPK8yZb3wDORYFf9DgWk9SMjPUZ61Msyw
         MQnpAb/13VbR7Mmu6J8xGfGb0l+NfEsHd9abj13dc9c7xNNHgsKcJm8L2Is8gsV1VXqv
         BEPg==
X-Gm-Message-State: AOJu0YxRR2SN4IFjby4+IOlTgrHPv34ZdSvWhkw0+1gZ0yXMBdtnhsgQ
        qHaJ7mDO1CCuEUaPJ5y+m7nT2Q==
X-Google-Smtp-Source: AGHT+IHk55UnrVjKhLbeoH0FOsI/LvZ/lE2QJL1gJ+D+E8C0Gwzt+7qwXOdkBQv9AkY7J3V6Bv/K9A==
X-Received: by 2002:a17:902:f7d6:b0:1be:f53b:4335 with SMTP id h22-20020a170902f7d600b001bef53b4335mr494226plw.20.1692305126211;
        Thu, 17 Aug 2023 13:45:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id je9-20020a170903264900b001bee782a1desm189883plb.181.2023.08.17.13.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 13:45:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Yogesh Hegde <yogi.kernel@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Annotate struct rtllib_txb with __counted_by
Date:   Thu, 17 Aug 2023 13:45:24 -0700
Message-Id: <20230817204523.never.034-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=keescook@chromium.org;
 h=from:subject:message-id; bh=UUiTzVogaZirmWMGpsPMj7phpen0D5w/qKNcKFWYCRw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3obkTXsIF42rVOApuK1+6hZwZMndX3d7u3bA8
 wUVSJ8CkOKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6G5AAKCRCJcvTf3G3A
 JjL1D/48cDpSX2Ac20S71nPjuKbgJSg1g+7exjTTXnTvVNl4NVcTcYOOX6XG+Q8Lnb2J6ZF49IB
 zYwnG+ICNOHrimTy9xnEzL8t/7AlZD9fhSo6JEZZfuqzW2qI1F3dKW13uWuvTMRsHPXUV0i6OWo
 aJDlbIWjkrLP4tfCBxa9yL10Y0+NXb2kmRpmxqFBbvFaY2RaEepM/ST6csF1yuviXLe6OH7o0zL
 Phe1f9UmMqa1oHNdo3IUlmmDjPTfNH6ZX0FmjGPiWEV0IrAYgqWEkcHQKzt8P2h4hl36WSq9cpM
 cgSkbtOdwBQtKKi74PisY5UFmgWtDx7zlWZMa2/legptjd7gbbI69cOYyHn3pw5v0aTNwkXe3yd
 2iyApZjS8bGmYne4s8QCkiAl6JKnzvoRsH2uq+B8TTUDuncVwVADZIr9nmhlUnAho5eigZpy2/n
 7UM3vKjQjBVJmZdwFij8jHhCMOFNIMkw6t/RNcu+roCj8+Jg8i+LQOiPxMkdoQaCqEg8YiRZctG
 bLEix0Ky3IWQOFgETdkh6K76+opM5AT7FkbZ7NEzqJcRgGq4e4dOTht2Rh72Et3YvN8S22JilbP
 fDs2++6vYppmECcd6ksWFXfHYilH1HC+fUTYwW0VyBcMBSYMcIYS3x7r4WobnHxJGpqaTt/aqCK
 uascUme ok0NojuA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct rtllib_txb.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/rtl8192e/rtllib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index c5a692dfcd17..543d8671281d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -818,7 +818,7 @@ struct rtllib_txb {
 	u16 reserved;
 	__le16 frag_size;
 	__le16 payload_size;
-	struct sk_buff *fragments[];
+	struct sk_buff *fragments[] __counted_by(nr_frags);
 };
 
 #define MAX_SUBFRAME_COUNT		  64
-- 
2.34.1

