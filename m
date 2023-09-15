Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDE57A27B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbjIOUKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbjIOUKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:10:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4595F268F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:09:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c3bd829b86so21719745ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808581; x=1695413381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZHgORBBG6ssjw++gZqBRejLJi1rVlKpyOxRrxxQwRA=;
        b=V4zH5uYJ96kqSRMThjodMF7n2sx5xlhQePBTTHhGPEiUThkzPe++8I/HQf1/nAFv3t
         6YAtzsLWpbMguGsgKZ2j2X62zB/KLFQWsVX59hAYqTtiFmpXTcNrIfgSdRHrPPeWSYuj
         UXEpfuz4sXh9f2aPJOvdeAdwtabIVg6wrUkk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808581; x=1695413381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZHgORBBG6ssjw++gZqBRejLJi1rVlKpyOxRrxxQwRA=;
        b=YwP+BQYh4tHZmDdLpgzD0a1GXA6+AJMzsKzjVAmPTqB3x2h3JrTUOHYFllrygQEE4B
         X0bqprjXOO7a6QzyvaDqpU5AaJS9L8Hef4towPgBjDSMqQP8sruA7vrwWK3qMnLzku1O
         yg8T72pKr+6xvSOdN+zu7GPoyJIPDVC3Mo5OTAHPjsxpscdg2RWmiSKPUTJVEC5cNsY3
         53RIdSCVHAzuDbSOVtHpXz6FhC2s3J95WSBCtKpYRX5zBVhS/cARlRCDUNGOb4QjfveO
         /LmBqMr2c29399Te5aZ7Ln3IlmslZ8lJ9VOnslphh4hcUjbkxXnjd+onlxUENFYTNKgr
         Nd/A==
X-Gm-Message-State: AOJu0Ywoj1yZ2m1f4KBGh2FIDmG7LOlou1SquT1/ycyTIMXDCGg+uQEl
        +jd3g4FEM+NzdRUuQ0lCytwceg==
X-Google-Smtp-Source: AGHT+IERqajdncd+WB2eABrqeGZmFlwyJxwl9lufmAtYk22AnJYdSJUMk5KsBJM3IWItSx/NZqDv7A==
X-Received: by 2002:a17:902:e551:b0:1c3:2c2f:1132 with SMTP id n17-20020a170902e55100b001c32c2f1132mr3059174plf.54.1694808580799;
        Fri, 15 Sep 2023 13:09:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001bba7aab822sm3860053plb.5.2023.09.15.13.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:09:40 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Kees Cook <keescook@chromium.org>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] leds: aw200xx: Annotate struct aw200xx with __counted_by
Date:   Fri, 15 Sep 2023 13:09:39 -0700
Message-Id: <20230915200938.never.767-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=keescook@chromium.org;
 h=from:subject:message-id; bh=oTHqicaprD+Vk+cbEHwEFzQOqlE3AUBeMdwhjiKKmQg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLoCDhkOw9PWaCCHnBnbp9dycdVACHvMghQmR
 riWUgKv+YSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6AgAKCRCJcvTf3G3A
 JnqhEACGDVxaxu8dnzElwrmWNW2wxsx2VYR6mDGkTxfDwLy87LhrnBCTw0r+OXID3WbnJlVuK3m
 URWF8Pexx9n6ZWJ28D+roMmuQSKIbnlzBUQgQapCyAejg26D6GHYrECLX/heZnh7C8ZO6a/5hLP
 T1XjoIpoWJep2Am0zWpUfj/9YJGdBTAQ4acT+pKsTJ0J3Eqvv2TIkxCw+vL4SdT9zuR0M7p7v3J
 DlgC0p3Gr82v+Rg9Gr9EZ4b/VvNYsRW+oilQ35/nECjgoRqNf1IsDegl25knsYnERkmh9rwgq7y
 5RpxOjujCD+CUbDecn+SOtzMjvtNU5p481WLZc630Y4ALfXfqS/QXaEDIHTtZsyB0qY1BpP4jmR
 RnxOKUDFgoRbdJVbGma7Vd24Nn/88w4f9wnHOGvKgjHP9jxYrfRNXTijklmDmfgGZNvGYLofPDR
 FMZ6ul2puwRMBMGHihDZ23vzxaCyC8i4mCnMDENsAezK31ZYewWGRL69iNeSP2yUP6qXouEP5Em
 28Nv9SB3ehqFuS5G406AVpx/VzO0uFzSdSIfWWlTo5YGRPxT7e/1ikQJTqnFltPV5F+s85hXIoW
 G1k68CTTTnouYvEyUyyoc3WN6Xqas51qFn+8fjRH1JKhfmn4G4Lf5deBvGZH3wp0lYG09fYF3lG
 Y7Sdq1O rZG2uD2Q==
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

As found with Coccinelle[1], add __counted_by for struct aw200xx.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/leds/leds-aw200xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index 691a743cc9b0..4d517cace3e7 100644
--- a/drivers/leds/leds-aw200xx.c
+++ b/drivers/leds/leds-aw200xx.c
@@ -112,7 +112,7 @@ struct aw200xx {
 	struct mutex mutex;
 	u32 num_leds;
 	u32 display_rows;
-	struct aw200xx_led leds[];
+	struct aw200xx_led leds[] __counted_by(num_leds);
 };
 
 static ssize_t dim_show(struct device *dev, struct device_attribute *devattr,
-- 
2.34.1

