Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8987AB821
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjIVRun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjIVRua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:50:30 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AABECCB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:50:18 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-578b4981526so1812472a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405017; x=1696009817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9keGpI24f73ClY+CDWArkkyfvsmbI4ZAwNSISbMEuk=;
        b=HCScKNGQ9djV4FJJFL+r/OeIwkUmaW1MHBaCQYB1F6FJlRz0zHwxJJMx71X7QgIYDN
         Aaa0RM1R2lxKqzNqQ0sAHgbyj29/QLqVkiArMhaLIRusL4PfOXkuSWnYsTOgPIyNPCxo
         I81eurxFBlveuYEzV2Z/s5uaKQPeNiDkuFOjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405017; x=1696009817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9keGpI24f73ClY+CDWArkkyfvsmbI4ZAwNSISbMEuk=;
        b=MKECC4D/BMASaM5yhVfL2MiF+fRdym8ji3gRmdpS6q/LLXFJ1N1qsEhAHIOStIsITd
         SFitJl5PuRx6PiXFHgJqEWVf2sC8K0KBohsbulAr/bWy059NihTS89ljEsAy9ymhViCN
         V7O4Gi2a6i4ROTWKYNutcBNS03asl4IdnOzkEb8RXVedv01tu0QA8OkadvetEJxRK0su
         cFyukZyITGAS8RJBoWhAtYq8w8z5NPlZcVv3UK7FM0EBA815/SEqHpClzNdoNKo0DDcn
         ZWjr8l0eoTzOMR9XGarKyTAA2cvCe+4vJMC3dUEk97UJZtYPOq6nQKAwls6j4i9haXgb
         eTIg==
X-Gm-Message-State: AOJu0YycFZRN42nhSVG9u5A455QE2f8aq8ud6liHOTn2P9ROL3hSz3/z
        b+uA7OxcrEpSbl7aRBGi/39ljA==
X-Google-Smtp-Source: AGHT+IGfcvrozhcUEUzeu1USWPMbEzqOOs271XXupxZ4a0g5Mv91RocyYCRFpFcCdsq7ZZYXC5wBrg==
X-Received: by 2002:a05:6a21:1a5:b0:130:7803:57bd with SMTP id le37-20020a056a2101a500b00130780357bdmr225662pzb.3.1695405016897;
        Fri, 22 Sep 2023 10:50:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q26-20020a62ae1a000000b0068ffd4eb66dsm3465165pff.35.2023.09.22.10.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:50:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     =?UTF-8?q?Przemys=C5=82aw=20Gaj?= <pgaj@cadence.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] i3c: master: cdns: Annotate struct cdns_i3c_xfer with __counted_by
Date:   Fri, 22 Sep 2023 10:50:15 -0700
Message-Id: <20230922175014.work.637-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216; i=keescook@chromium.org;
 h=from:subject:message-id; bh=nFAdeiJyBBAN2nKXtTbKJp+l0ifJ3TjsMbq5N6rgU9w=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdPXeEDRSo/vrvPQpWyJYQlr8t8eeYkEi3JUW
 aibP2KoNw+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3T1wAKCRCJcvTf3G3A
 JhqAEACFSx47UGcJAEXS4JS+FsFG8ENlzAj09y+6MUbVP+WFjPpnkap95ejxcB4GSfsDCqDxk6l
 LI+ahUhhLo96bzoYSLBN9IV/bTNp+UCcPA60RZwi1hEFT516danvY6/UgAYBXnWHjRT2mwY3odX
 yy3kqrqLDUnE3ETLmj7fMNLBhq3ZuSq/m/XUToa9/h+24FUfhzbUTBikmHvfAcveyS+RuxjO9qY
 ed0C41STALin8Mqjuy9khWvT8vR42ScDvLuGiyXsymCn/mx4I2J4ddu5LH/2IS8VU2YmaMNctjg
 ptvies9UobnLJBW8R/IZHZ04Beol8N6tigZtVT5CCdCkn8LX2w7ZwYR6ajB/A3/IaNSW5exMyyw
 /fok8hnoJA/gcVCwUm16AX3pOIbVUEDyHaFauMP6vJZ0zHV5pJOJCTylmIizWc9HTOYV0NHkpwb
 8JEjbN6xmyxxkPy2SpwEdxWpngNkl4BRwZeyOV2LFic3mtPOPfrJkhQU/qUmsdaqacHAXERuTHh
 2KPB99gvcM+fdO5CeCkrYIa+gNwDc0xfAcKIM3tL0FOVaulCGqw1bIFmIV8j6FJCbGoY+GObpnT
 xUWz5txRoRBsr0UsApv4Bsd5OFnimSTXLoSBWdriF4p1gKcvsPpxrqYI49ejrS4hjpmZDrCM3CX
 mLCiun2 ZcNO3KyQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct cdns_i3c_xfer.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: "Przemysław Gaj" <pgaj@cadence.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/i3c/master/i3c-master-cdns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 49551db71bc9..97c1010956a0 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -387,7 +387,7 @@ struct cdns_i3c_xfer {
 	struct completion comp;
 	int ret;
 	unsigned int ncmds;
-	struct cdns_i3c_cmd cmds[];
+	struct cdns_i3c_cmd cmds[] __counted_by(ncmds);
 };
 
 struct cdns_i3c_data {
-- 
2.34.1

