Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC87A27BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbjIOUKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbjIOUKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:10:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C6BF9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:10:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26fc9e49859so2066373a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808612; x=1695413412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xnN3gHkGLtoNA2QTGtMAmFrJjm3lWByeM/YOF1ick6M=;
        b=mxE74pomv1v1sYJxR9mmyug+RE7jUOCOGYAsO5l2r/1fkUWBuZ+/lfmuInnOh8rMNZ
         Szxye0kVNj0Q6Pz4iUz9OCcVPJdJMhlAHhrZ2X0kseXgf3/3LQlKjhOLotPS19mSF1i6
         Bc47b7UxnHVx73w939+X9nWsWBlmKlCj09oSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808612; x=1695413412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xnN3gHkGLtoNA2QTGtMAmFrJjm3lWByeM/YOF1ick6M=;
        b=vUr8qzc9mWkYWkTXNgRllcoLLw6fkc/Yld4y0j6Lmwj+bIX0xidwu1T+5hSTMeRaQi
         nDYlak2P0eoy2mOL185qhnub0QGjFsJb3uPhWr6XUPnqHNc44AUrmlAbN39R8IjNMDCt
         7+qMjk50PWs6Gmaa9d3DGmzi2wtpIz6WikGCH31UaMZKtNM+y0DdKq9k4LGVwiuNRXEC
         dunCcQyyBTXq/xtl0cy0loXqP3Wl2VmtDalGmbSYsO1afGkunKB9KLOdaucrtqmwpO8X
         F8ukcw1/KoLC6cMIap8UxIOTpJuDoW709oy1Z7pDDVEsGE8uHENGuAbHCYsNWTxDPRAk
         bKDQ==
X-Gm-Message-State: AOJu0YylPa3X3LJXh18adPi4jdm9KqUX+Pw/JTtW+r8ybI+7+al9kzn7
        iMV/GHB0esSSKVhY7cLuT/P82Q==
X-Google-Smtp-Source: AGHT+IFTakrAd/P9IgFg/t1kORbe5OsEnV1TC7veShETUWveOXxBj4Is85OM+v2tEfU42/NGU94RCw==
X-Received: by 2002:a17:90b:4a11:b0:26b:49de:13bd with SMTP id kk17-20020a17090b4a1100b0026b49de13bdmr2581678pjb.36.1694808612530;
        Fri, 15 Sep 2023 13:10:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a195c00b0026f90d7947csm3649999pjh.34.2023.09.15.13.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:10:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Kees Cook <keescook@chromium.org>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] leds: lm3697: Annotate struct lm3697 with __counted_by
Date:   Fri, 15 Sep 2023 13:10:10 -0700
Message-Id: <20230915201010.never.399-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=keescook@chromium.org;
 h=from:subject:message-id; bh=UTGtDE2akLSsdTySqF59uiPuDzz1OaDB2cv0YvrcVBc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLoiuSQ3SORqIHxgEzXMXxgMfoY6915BNtJRe
 8pDUP6OpliJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6IgAKCRCJcvTf3G3A
 JpbaD/0clVqVUxTw1+EOL/tG6W6RoCiaXFDUaXAPcnNTfob2vfYL2KQkMIjFYbgvOOwd9Z3glI2
 b95tMT0bCRoHujNvqOOpI/cdAfKFKxz6SD522+Hhrx1ufi0cCHh2iO0HT7UgOLrW0+Rr/AgXFUm
 CBjn0TNqarPBQOJNSrk0AoIdpKp4HYfydvM1AhzU8YlakmhAqVlNM3gy2pwnDars5U5ed3p9pBO
 vj8XrD3iumDh/0eVACxk2cIdIRztZ7sjPNJ/HrzdxEfb60YXjHFqRJAc3BlmNTJhiqCW1mpPDzD
 R2+WA7VEcEoj0oTFmLEJGeOCjLizRTkRt4AVyMXG//RfLOiwD/FGV8i/9BU0CjArO5KZDbiN6pg
 XkXTlGgx2udPvdFKjs0oIBd7/sAOPWAk4I+5qLhSkAZkB+PzoRZbGM00+/JYYrAgPD+n8sBi0eD
 8VIeXQJvQ1t6NCjw3GwU/5AkySxbWyCL5fMpTHI+P65znv3n2QAYJ2idcC5/x7F9E07cxhsP29l
 6eHYhQYkfFHL+F+PQ/t1v2XeXg/v4GqAM1+9N41ktDpoP47HeFBhs9wwVj96wbU0sGgrkBpZJs4
 wydpIoJeJ2wJ68fdxIXE0QKuxqbCL4kqgVri1VsGVVia6NO+TM5kM4KVQw67PaY7QgMX8Yj1w72
 mgcWtvz G82BZOPA==
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

As found with Coccinelle[1], add __counted_by for struct lm3697.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/leds/leds-lm3697.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lm3697.c b/drivers/leds/leds-lm3697.c
index cfb8ac220db6..380d17a58fe9 100644
--- a/drivers/leds/leds-lm3697.c
+++ b/drivers/leds/leds-lm3697.c
@@ -89,7 +89,7 @@ struct lm3697 {
 	int bank_cfg;
 	int num_banks;
 
-	struct lm3697_led leds[];
+	struct lm3697_led leds[] __counted_by(num_banks);
 };
 
 static const struct reg_default lm3697_reg_defs[] = {
-- 
2.34.1

