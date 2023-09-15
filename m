Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C417A27B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbjIOUKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbjIOUKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:10:07 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9F12701
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:09:51 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-577fb90bb76so1373033a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808591; x=1695413391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Muy93PhGxQI637LkltSivczIg7w0S2HDIxF5V69MsXg=;
        b=dzET6Mf7ItbFD+1q0E/MlzjwZ5/hOIYZnbPK3zSQZlyKUpk92E7FjXdNiMY5L0cvQf
         TtUCGQfRvjQlyVgkRTk7YnFHCXLwR59HQNKyX5lnrTO+Ath7zWcBB+aGhwEsJjkmXRgQ
         wHtD16Cy/LEYbAhS52ji2k1IVqaMPnYgfclVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808591; x=1695413391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Muy93PhGxQI637LkltSivczIg7w0S2HDIxF5V69MsXg=;
        b=fyFs1M32dUQau1myG4Xcz7n5VZ1AuCTvsqQyeeqOFWF9wEX2CEONFOoK8CfgzitMOI
         NQQVUNcK5yjYPXZmDDlmQV53eMuXOHtsE7fxhbvMkSmisKaanTyqDHPLm9ONA95MTXDQ
         zY47GYWLoBFM/BsvU3YBTCdkCYh7a3F69lbxQIfMD0iIZYA6S847jkB12Jxwt8H1f6Fl
         Y8In8cyL3iO9PIfyjigRVux0vcZn9dSxc874ClIvi4S1J5C3KAtnR7YOmJ6eN6CRT2sq
         xBRy8q1Bp7Jf1u7/23c+sfKEFRtuOQuNnep3+D+oQVWlhemx9lkNUyHV14+b0n+nh/Un
         7koQ==
X-Gm-Message-State: AOJu0YziL4+6NeUaqJ0NWz0h7+fNENz2PtwP9lcqqs8U5VYvej8MOtKB
        SqdRKXdDhxuJN2a9ZWLiKIYj7Q==
X-Google-Smtp-Source: AGHT+IFrv22jckxNyFPHk4wkul59BZWPHDh4KeyX5yWqIvjMYexwtkhmjNCln5KRyZogKvg66UkBMg==
X-Received: by 2002:a17:90a:130c:b0:269:621e:a673 with SMTP id h12-20020a17090a130c00b00269621ea673mr2603231pja.1.1694808590812;
        Fri, 15 Sep 2023 13:09:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f2-20020a17090ace0200b002749fee7984sm1439060pju.22.2023.09.15.13.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:09:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Kees Cook <keescook@chromium.org>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] leds: cr0014114: Annotate struct cr0014114 with __counted_by
Date:   Fri, 15 Sep 2023 13:09:48 -0700
Message-Id: <20230915200948.never.728-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=keescook@chromium.org;
 h=from:subject:message-id; bh=Ay/S96r+TTbAZJCf/FmudMqBXZB0z8bluDuDqSyybAY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLoMRK4HKwbRdA/dQbibTN2neXE8kbK2imD47
 OJ+4vPf9VKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6DAAKCRCJcvTf3G3A
 JgeFD/456XBWPDEoi/0lXVUiOYdHq9R99vQdrY+GKQhMNhO2/WY8oM+OfE51KIc6dW8iAM2/i7F
 SChkpSp3hLfJ7uYdd28ESePEquipBhWrrBb/q4/fS9f5jGNvW81W8QMRcVskWtj5Uic+kCnzf8V
 jK3aModQKGLsYkj2F6z0mYZV5w8mXznoG3ndXPezz6jsGsuTuBEMagzXvOaXr7KCDkJJ0UOG3gU
 GaSQN5EQydQ5CyAWpL+SjS/TYSniIgF9eqsEoZ4xiOPBmR91woy6FQn3Z4hrlir5Izm+Pmn2RvL
 QsUBHiY3uyWfNzyfg8H+yPhjUx0JNpQlUoLis7NUidDojd1bRSkXjiEKKkywOSEWS94XQRqoM9A
 EnyL7jM0sh+jJYgZNqNxYdXv2yONd77E/9+TVYG4ntdl5/CBbo9iUw5XAr6n2KO3bBsztkJ4KOO
 OP1DUkOvmelWQRajNYgxjsi3RWvUyMhOd3fipXAe5bex0BOiEIg+mjS5nuuHKEcj+mJ++dIzhLx
 t6Txfb40SANvVUZVgr+3KTXpkYgNAKWDKDqwI0bmWboS2HWzyAr2OzFbBvBh6Z5UpEdZWUhn4Q5
 Dj4geW1zSzfm1s0T9SL9D8tCJAz7WEM1mt5hRQgDb9mLZMYOc6K1EpgPA1SrKaiBtXgIIDOnekE
 Yw0266w 5tKVbWGg==
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
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct cr0014114.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/leds/leds-cr0014114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
index b33bca397ea6..c9914fc51f20 100644
--- a/drivers/leds/leds-cr0014114.c
+++ b/drivers/leds/leds-cr0014114.c
@@ -56,7 +56,7 @@ struct cr0014114 {
 	struct spi_device	*spi;
 	u8			*buf;
 	unsigned long		delay;
-	struct cr0014114_led	leds[];
+	struct cr0014114_led	leds[] __counted_by(count);
 };
 
 static void cr0014114_calc_crc(u8 *buf, const size_t len)
-- 
2.34.1

