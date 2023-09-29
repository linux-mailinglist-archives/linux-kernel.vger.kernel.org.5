Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2101C7B39C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjI2SMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbjI2SL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:11:56 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0651B3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:11:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c6219307b2so72504315ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696011113; x=1696615913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrmkuelEd3rJ28up92cyB2Np2I/dyvESECk2QEaqxqI=;
        b=flTXVNpO4qOVZlBAJzuGgI/EHIohwpzeMy/6PZ4cuSEtEmEfrjO4f4/PxeSuhSCiHa
         3KvLw0spqKmkQN4/Y08W1bR0V5YOWy4tm9t5IExSAqoN4qe0H89Clk55yFSaNHAORypn
         hyXYnXAQbzSRbHtcuXGjARxMPEEEfuiVlkA74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011113; x=1696615913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrmkuelEd3rJ28up92cyB2Np2I/dyvESECk2QEaqxqI=;
        b=Um761PhGKe18oNlrT2bCCuPagKSupqB/IrXBKvdik1+oHEobe6srkqgScomv5WpDHd
         JIZVCMfUej27DahVDviHVulMUK4IYvXhuc5Spegdwk6VwG57PsbVhDv+F6mmul9D2GYJ
         SF83wp+ZJX543xfvBjOvPWLCTJ0/869umroxeJIXFebcGQR+2qzoRPkbFXLUeCKF81YW
         bxK+RBs2UcNdyeX2KR00xZF5aw7ZkQkH9B0bQHPkxoG6oe1T956xGW+RDtHtueREaaNB
         U3aprLiI3lBqHmUcrrsshTNpT5Pexzi7f6tbn7GqihdINbqWJqaVuZm9o6Rv5v1YyewB
         tDaw==
X-Gm-Message-State: AOJu0YwbHCobrwLef0U0X3odagCVktG/6Qc9qAC3mvoBIlvQCZw+eW2o
        kzYIQZ4Er0R6tQsw5R1AVsJ6kg==
X-Google-Smtp-Source: AGHT+IF0+llAWLKGd5tXXfz3AaZJWSIgRckzd/8+Cbfq0HsBzZOPCAEvp67CPVp2BmJIO5snh7SQug==
X-Received: by 2002:a17:903:248:b0:1b8:8b72:fa28 with SMTP id j8-20020a170903024800b001b88b72fa28mr5257379plh.58.1696011113144;
        Fri, 29 Sep 2023 11:11:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e81000b001b898595be7sm17123630plg.291.2023.09.29.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:11:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Raju Rangoju <rajur@chelsio.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 3/5] cxgb4: Annotate struct cxgb4_tc_u32_table with __counted_by
Date:   Fri, 29 Sep 2023 11:11:47 -0700
Message-Id: <20230929181149.3006432-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929181042.work.990-kees@kernel.org>
References: <20230929181042.work.990-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483; i=keescook@chromium.org;
 h=from:subject; bh=WNbLnqzZE+z+esp5efLnkGvq7OtgHHNunnfXU8ZF7oU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxNk0t1kkwpfJqHrZx/YdrjBahRhU6dQg7Okx
 u6FscRO6QeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcTZAAKCRCJcvTf3G3A
 JidkD/9HX3Au2/63QgH0EK6PoLXEVxhxTyzFmm55RQkNUQ12mIdkyPQhXOdXdPaHOzINQkl3IxD
 XtInCBrvYRQV2fX6pGVD1FzuCQ8SVPLSnzKPJ9MzkyBA8G85jQJa27qbc8nOjADf84SnqUCU3E7
 abcFVVjUIDSZ0Ra/x92q32EPlOOmtGen8/5bd8oxADgtB1544tA/KdDiSkdx3YCXjN8VB3z7xqX
 Wd/RfUFBxFKzvD04iU34CID25Fp2EVQpI9y40lIzMtT3PizWOSLDYoFQ3NMr9dd9j71i3jHRkhU
 GaapzNg4UDQBfvv+ux2J5b6i+IAKJu0b+8a7tIfhhaKBNp2ISI4vIk9HqloOnQd+BWuluLKBpWj
 hrNtFoV3awi1v4YzPnCKrK0MvAhSaBekPoVttFqzxYutyFR66bgQx8yWh+h1V8+PfuZXkEhqpbO
 716CDFdVDm5pX8SWdmfs34fHxXg7aaD0cbUiOzEgXBZdyIZfRo+jtvT7z3lSEKFowA6ob5zSrCQ
 WRJT6MRTbvYTC5OtncSF65Ban2SQYBF3y7H8RvBQP4DCLG/hISKlxmIE/gCdL5musZW/gOJEyXx
 pxcm/D9H08sb0IH4WQreDSfrwlrjgngkjeCI+ouNbR/ybBapAwLHlhNU8QpNMPwM/LW4Tu3f2aX RMyKWiztAyV60qQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct cxgb4_tc_u32_table.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Raju Rangoju <rajur@chelsio.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
index f59dd4b2ae6f..9050568a034c 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
@@ -331,6 +331,6 @@ struct cxgb4_link {
 
 struct cxgb4_tc_u32_table {
 	unsigned int size;          /* number of entries in table */
-	struct cxgb4_link table[]; /* Jump table */
+	struct cxgb4_link table[] __counted_by(size); /* Jump table */
 };
 #endif /* __CXGB4_TC_U32_PARSE_H */
-- 
2.34.1

