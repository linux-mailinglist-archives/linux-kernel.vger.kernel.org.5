Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A2B7AB8D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjIVSFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjIVSFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:05:25 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA702D5D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68bed2c786eso2275875b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405220; x=1696010020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=35gtyXNkaxV1CbWW0mQ4JhX2sryrgmwmW4Qyfs+/hZM=;
        b=O1LITAYt09swLRrJp8fve4IBMIdWFNCx9cj/PVDl+xTVKojkfdkar4gw2RNcJeg0AQ
         SLGJ7GkgN98SKzK/bT7hWDqC3ziLqT3SnA1Nn/T4aVxNYaPc6hcY7pRVwhmOYgakMvcS
         mhovKq7rDOgoZwOzpngygNSPNxWdb/o6CMgW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405220; x=1696010020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35gtyXNkaxV1CbWW0mQ4JhX2sryrgmwmW4Qyfs+/hZM=;
        b=MJ00vwjUTnCPkjl2j4Srx8v9ou7DE9miopNKEozyLuozewTGXvVETFz1XBZ1cr47/H
         KPTHwpOmIXcB8ZCVJIVU78mBsyzMBRyG/D8QDzVSMQpdvWYWaPoElmxdSJOcbx1w6cwA
         kw++VnlmyN+Gfog9E2YE+AOSnx+D9FZIdOmJBHyiR0/IPualPQ/si16cBQFwM0ngyDZn
         l31RLjPHuEX0gAO/c+rxT3rEzaddpOtVBYl8FNUW6pCvPF25l1GExXJQffMNwGMwkbMj
         A4vkSj4pjwtICm9ZwyixyxgJ55taU4xO9myvakh59BeLVdmXQZwRhtKhH0hcA7VtMt8E
         0FWg==
X-Gm-Message-State: AOJu0YwM9Vx+zoDR8Dn4Gb8danam++EZq/W8R5aLkVYPBwE9T1kNDt9g
        qKz2nITZgzGF6Sd6GkpPG/AaPA==
X-Google-Smtp-Source: AGHT+IE4t0+eU5/4e6IKIf0243xPBzsg5WQKxy89ruYQeAv2++FejJkkI+uW5TH7Mk0QCKLUsty1kA==
X-Received: by 2002:a05:6a00:987:b0:690:41a1:9b64 with SMTP id u7-20020a056a00098700b0069041a19b64mr90043pfg.1.1695405219712;
        Fri, 22 Sep 2023 10:53:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k130-20020a636f88000000b00563c1aa277asm3380555pgc.6.2023.09.22.10.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:53:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] mfd: iqs62x: Annotate struct iqs62x_fw_blk with __counted_by
Date:   Fri, 22 Sep 2023 10:53:38 -0700
Message-Id: <20230922175337.work.150-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=keescook@chromium.org;
 h=from:subject:message-id; bh=40smk5nu73u0vfTxfrOWAC2AnRabVPFAKtr9H6m06to=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdSierso3cLUCkrGkR7SzFR8Eef9SkFGVBB++
 YGtQ3yHy4yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UogAKCRCJcvTf3G3A
 JjquEACNQ40A/dsuVWJtubBKqSUsV0RJy532o2a7KjsWRrhyAnUAyi95GcYxhpG1L2yeF3MdMBy
 thxxRTReJNGXfQwmqfsJQ1QMrDTWiVR7zXFq5mo7Uo/enLd1chriGNT+rMx1UvBuwOLj05zOchw
 MSpEKITLwGLx+YA0K02TZ9/3rt1ErYIX0xbTAPHcD+EP+T9uzKev2zNvbMj+kEmK0/Lkh1PVktA
 zHTyOqFn3coTptKLxDpkMJyWSlBeXb/lrvFYjaa3H45C3osBppBcKPGod9MMJAM/x73a6J5RzZc
 JfO5z5UsvwydKhrtUS+uoO+uEnIm7d7kYexmfe4FXQvJTMudNyH2MI8q2mXBo378A5PDkKLYeYF
 Ri2c4Ja+5VeIqpcCaxVGKngmTnT0Omlv6wHBT3zl1sCiRvqdEHf5lxIh+US/TTK+9F1l9ZdKnYv
 wQcUkUsep2ZxvWKHD/M1kQaxEzuEsA0oyGgO7iXmIW8HySZDT+Ii74EgmLDg+UxG+2xH2uZ09rp
 07Qqy8qtTiZdDo7eAptBkGmie70Sn4C2VdJl3XVF31DeU3ZKLNEQwbF1J73d4L61K3oeEtz0x7R
 IYmgjByteN3WXc4sxL30VJTXfnaZOz56zFsyPX5CmOPfIGOPu1q1pZrn9wEco3Clbbj8y4I0omy
 GNCQZNPa TRkH0iQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
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

As found with Coccinelle[1], add __counted_by for struct iqs62x_fw_blk.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Lee Jones <lee@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mfd/iqs62x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
index e03b4d38fbb0..1b465590567c 100644
--- a/drivers/mfd/iqs62x.c
+++ b/drivers/mfd/iqs62x.c
@@ -96,7 +96,7 @@ struct iqs62x_fw_blk {
 	u8 addr;
 	u8 mask;
 	u8 len;
-	u8 data[];
+	u8 data[] __counted_by(len);
 };
 
 struct iqs62x_info {
-- 
2.34.1

