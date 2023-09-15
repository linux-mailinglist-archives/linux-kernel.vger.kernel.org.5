Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6281F7A27C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbjIOUND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbjIOUMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:12:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F51A2D45
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:12:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf7a6509deso20273795ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808722; x=1695413522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nHWelds/0UMwcBpnWos/aLtztFrXjkfJbKPQ2m0GJNU=;
        b=Ccr4eaICflYTAiXTu0fiX7maWWHomUy+vUaA5/t/PzrgUBuYggq15LtWP8MUHsJfkH
         pxgBLGAkdcwy/s/3jMX+g0JajNWoBZFCgX6WFif4R844Eg+IWo5l8dHqYNpI3JrRYOy3
         4UUasTgHAsHgBNzGSLwZauWwDUWjuPRSz9hZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808722; x=1695413522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHWelds/0UMwcBpnWos/aLtztFrXjkfJbKPQ2m0GJNU=;
        b=XKEMk6c8ti/iH0Z6sh0txPipg417MDySvWqUhlMRR1orlVHI+ljVYROJJmbdgIu/bA
         oSee6Y9Xe5GLYjxE9lUlg2Ha5/VzywKhTDtIIP0F/DjH4cLEyXuPbgVd6PExsfG+1KVD
         tZvuckjWKmxF03FfXZX5LKHwx7d8/jlkA6SZAtrRyqS5dEd/7IBUek+4q6VQMo2vZl9K
         h/FtaMlvsZ2KoI9PgnedjSQU6nc3nSTeZDqBv0aWSelF5aii8gP/BgZfcSokajx5cvrI
         FK8TELHcWbJ1zfkhr8pdiaJ8ynpl9vp8WLTm9tBBF5sDK8XqjPCtwylIb2oQWzZDfu3V
         X8dw==
X-Gm-Message-State: AOJu0Yzw++XBfdiT+Ec1YLnY74ML+ZOK48+aMGfOfYy5QLxCVLiaypHC
        qWm+HB98T+wImceTQ54aW36YLA==
X-Google-Smtp-Source: AGHT+IHiNyqrliN/74dUaaMOB5YH/EEzt/xoauvDLOTN5wb5Fju0foAYEpaV6viOplTZo5uTNSDJMw==
X-Received: by 2002:a17:902:6bca:b0:1c3:a396:25b5 with SMTP id m10-20020a1709026bca00b001c3a39625b5mr2401710plt.61.1694808721930;
        Fri, 15 Sep 2023 13:12:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001b9de4fb749sm3898447plb.20.2023.09.15.13.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:12:01 -0700 (PDT)
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
Subject: [PATCH] mtd: Annotate struct lpddr_private with __counted_by
Date:   Fri, 15 Sep 2023 13:12:00 -0700
Message-Id: <20230915201159.never.112-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=keescook@chromium.org;
 h=from:subject:message-id; bh=gCkXC8MpJaPT99ttxM470YlQxkUzCuh2ydBh0veT0Pw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLqQdMeeixNUCF5z4zedCX95mr3jXFz4Nb5Cs
 5V4tlXbBCCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6kAAKCRCJcvTf3G3A
 Jk8yD/9mHmYeZ4PilIA7bE0IVUOPX8xWImvE2StXacFdcKWj6g3dT1Z+QnG6UZ6K8E0IVbwxtWx
 0/u6hFgLlJcs7VYdQYDz6zlzN2DcqRSOQ2IfFjqwHVOA0VxKOMIZRLlsz2ZXr9Vgx4Lme5dVV+5
 WSjxLhY/Aa77SDYccaT9iTj5whirBeTZ/+vPA6YK7bUhNpaRPqACjOUXlOhpwyirFk+PtJe1rci
 unArKIBK5LaAqs+X0rqDR0pO3sL3YLFldvjdN8siCHGt6iEcP6G2Zp3AV9wjqnjH8UWylOIQX5t
 fBXq2LKhG2ubRtRStk+p6y5uCBHE1/mhxLP8nflD1p74ErUwtR0wgAmkwQ5LQhNX0doFZJIVnh5
 5bnGARcrRIi2/9J4R5T9e27gNXb32m9ldgD/vE+nWoAd78lQuJ/zp/ElqbJ0riOEXSw/Ug+Pjw6
 4zAmyAm0rIrnzbZIezZ9boeyfe7ZalC5ywHALmoK4I5ymlp0BHznG/ylHJKuRCKB9usocw4mMkH
 PkD55lpZ3U7R6j7pjvzZQ5C+9Mlf2siik3YLwqlhEl4kP6MI3UZnuZv0iGx2hMayqeo0ouuOI8V
 J+rkTGfqayqeMzppAHp9ib6o/ji2/JoJYvT2rhZd5I4OllXNs2Rg3m97Ee0Iq0UEYje/AB9V/Ro
 46ySS5G +6Rqb3pg==
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

As found with Coccinelle[1], add __counted_by for struct lpddr_private.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mtd/qinfo.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/qinfo.h b/include/linux/mtd/qinfo.h
index 2e3f43788d48..0421f12156b5 100644
--- a/include/linux/mtd/qinfo.h
+++ b/include/linux/mtd/qinfo.h
@@ -24,7 +24,7 @@ struct lpddr_private {
 	struct qinfo_chip *qinfo;
 	int numchips;
 	unsigned long chipshift;
-	struct flchip chips[];
+	struct flchip chips[] __counted_by(numchips);
 };
 
 /* qinfo_query_info structure contains request information for
-- 
2.34.1

