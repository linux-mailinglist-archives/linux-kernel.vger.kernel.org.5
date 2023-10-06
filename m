Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1F47BC026
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjJFURc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbjJFUR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:17:28 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12A9FA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:17:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690ba63891dso2152524b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623443; x=1697228243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kW97lFtdi7tQSx5WV0UdX/3taJs5J9htbLPAyylMrXE=;
        b=kJfSleHIr4K5rV9AG0993UM4ty3EhIbt+f1zqjQPQATref/U78mlNCHrRB2PdId8Ap
         rhMUfyWUb428Sj2BvkML1y1A/7QkCp2Op73EBLONKDC5PJfN6WU/1uP2e6ODanPf2sO6
         PfJVx9hocwMqsuqGyF0UB6KAQYv9A7WlZEcn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623443; x=1697228243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kW97lFtdi7tQSx5WV0UdX/3taJs5J9htbLPAyylMrXE=;
        b=u9Mga0g5ktsyH0lr3Go7JO6Wy5QLBaU9N6KnNKIhWqU6VrpkyTJwlRT3CL3eX6N+i3
         MJN/c7v2PGaMHCt1UQzBt4uvVGpBvz68JNfZAFfli7nFxbyBKCvqaTKklxurujvScU/V
         wcDFiNIjBMe9i+EBywO5nOT3a1SFPkbIaXLdhxdyIEfEaWEBkqRngjdqwPelVwkh/KH7
         OFPd15AdanbWP/RIkPHbJOaPULMd8pRlXDV4pXPeHjhQ5i7MRK1C93YD6Ag7U3ESHGyu
         vAlTDYmEwMCG7hbcPIKjltZ4T51udBCGcAqBFvHKE11cTLIgZHhStgkvAqMsdBDjeYH4
         3o7Q==
X-Gm-Message-State: AOJu0Yy2WC4qD+xxYGlPSTwMb++flpESQ77Y/PDLBIENoHXM+USj/I5W
        wqsBhzwssjmM9+ByDtlyNLpMvw==
X-Google-Smtp-Source: AGHT+IG6MS6aq0hR7NEmqMW13hny+F7i2UoqfOJWvAQ5rl6J3/G66uwQc2vUM5xOUeHLWKCJ3JR0OQ==
X-Received: by 2002:a05:6a21:3296:b0:140:d536:d428 with SMTP id yt22-20020a056a21329600b00140d536d428mr10800853pzb.51.1696623443148;
        Fri, 06 Oct 2023 13:17:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q16-20020a62ae10000000b0069343e474bcsm1886916pff.104.2023.10.06.13.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:17:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Christian Lamparter <chunkeey@googlemail.com>
Cc:     Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] wifi: p54: Annotate struct p54_cal_database with __counted_by
Date:   Fri,  6 Oct 2023 13:17:20 -0700
Message-Id: <20231006201719.work.356-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=keescook@chromium.org;
 h=from:subject:message-id; bh=NFwzX0Eq7KCDbbQM5umu2p/6j6lMwTY9c2gIIvIyXH8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlIGtQu26M1sSthhYbE6kdTUaJiSm4LeUxUUykm
 4fh5mQO3aaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSBrUAAKCRCJcvTf3G3A
 Jhn3D/9y8+XILyj+byVNV0fCgmz3v95DGYn0tJmv1MXslgAFu8Pww0V8y65fznB07xphjUv3cxA
 WEudhs5dA2oWKVPIwgQkBr3dHpfR7MfTVAMX10JUODoUvZVbazlu7hg0b1/7JFv1xtmuwolgPFU
 ZDLr+eXAHNGcBC7mQDHWoQhR/anMut6KlTh0STekS1k9UApNKth4ayj4Q27n6URT7tgcLyhTpXG
 IDqWi7pmZhV0HTzbN3qJ9OzS8Ea6Mrr3flfaApdtgc8l4Q8/KxLtO+gbQgWTd5bSAhG8ee3BrW7
 CbghSKSSzyymAfdDTmw0xrvj6qfi+fTNEnOC/ahuDL/gsc+OPa/JbiLIWhLqhF5tOPKrwtvEPWQ
 zaUV5mYkSplYev71JajAiT3XxdTIy4NvIAHvwhdz6qakMmuIPeWdxXVsF30xALAoGqwA4LUljcE
 rOKtVVsTzIf3yZNJhOzFzBwOZlf6gpiSCfX/WLCn9+84Xf44KcnkWmIOrAJp8v85wuBKsOa3FGh
 7TVCgeR/pe2oepKBwd24/KIQfu00XLzyQ7gliBRqobRTqowyK+UH4HCz6dW8TJ9+xF/1MBlohwB
 xWPTCxRzak2H8nyD8d/6psRG4kwCNICHXBCHdZ2sggZ3np+yS6sngN07u5+GoFUfkOBP2trZMya
 Y8XV3hQ JBRA4ZRg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct p54_cal_database.

Cc: Christian Lamparter <chunkeey@googlemail.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/intersil/p54/p54.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/p54/p54.h b/drivers/net/wireless/intersil/p54/p54.h
index 3356ea708d81..770e348d1f6c 100644
--- a/drivers/net/wireless/intersil/p54/p54.h
+++ b/drivers/net/wireless/intersil/p54/p54.h
@@ -126,7 +126,7 @@ struct p54_cal_database {
 	size_t entry_size;
 	size_t offset;
 	size_t len;
-	u8 data[];
+	u8 data[] __counted_by(entries);
 };
 
 #define EEPROM_READBACK_LEN 0x3fc
-- 
2.34.1

