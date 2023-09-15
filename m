Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6F27A27BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbjIOUKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbjIOUKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:10:09 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBD610C3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:10:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fbd31d9ddso2138857b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808600; x=1695413400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk/nOdWGEwQoqrorI1M5M4fwyDhM0MyESikBhRPJynY=;
        b=GoXo+IQumbCh93lMrBeK1O7HBstJmd6H2DeRANwWPg2DLSCVbkK0gy5yFtTg95KYAg
         pMZXG8lSp4/RaWR7OQH/CW5NMO7ogkaRm7zZfoFIYXO/UlVv76MWHShxPn2846QbNmQw
         zzyYtesLZ7KqU7cov2metdcauBd9/3pM8Sr5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808600; x=1695413400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nk/nOdWGEwQoqrorI1M5M4fwyDhM0MyESikBhRPJynY=;
        b=rnthfYDZavQCHEZcLssMJrZ4Z01egyydHdkH/MHVakwVcuiTLRUCTbrlcnFiCDQ3BD
         nE8dfgCZw1nsMXqTRPWTE74OKVDRTIErAqAVBV1wVFnhxgfliE45ZbgaZl2xkXZZNwJ4
         jMZO2nAj9feP3eNj5p+gQvB0nMpXXBVqoKI7DYnhlxtc846wQZMvuCb70LdtiySuWMfb
         JisAoTRHuUu7OGBdrVMeVjNSrjZdxEGmQgSzP/3+mjq/rsfDd1ZpQJn2hf9wH9sSa5Am
         M2k31uzA0jSuJojf0+/NmVRYYgIC5J08DmTCGKRsiY1c8pvAT7RZz+XzJjR3cw2lSvbl
         Reyw==
X-Gm-Message-State: AOJu0Yx6Gjoy8etovuRKv5Pn0NyNAsGWPnmR9BKpDXmx8KehUxwJJc8c
        cZi5tmBYJYYl8l0T6KxfP5vmkMiKZyBw/Qxj+8M=
X-Google-Smtp-Source: AGHT+IFkfodOw8key9MPLTpF8gDPsl4mUuf9r5i/8RdhOSnfEKeLKI70UXE9EitqTTeBx6I3fzUqdQ==
X-Received: by 2002:a05:6a20:9193:b0:130:7803:57bd with SMTP id v19-20020a056a20919300b00130780357bdmr3001465pzd.3.1694808600453;
        Fri, 15 Sep 2023 13:10:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j26-20020aa783da000000b006883561b421sm3321766pfn.162.2023.09.15.13.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:09:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Kees Cook <keescook@chromium.org>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] leds: el15203000: Annotate struct el15203000 with __counted_by
Date:   Fri, 15 Sep 2023 13:09:56 -0700
Message-Id: <20230915200955.never.871-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; i=keescook@chromium.org;
 h=from:subject:message-id; bh=AuQmhyKilUvoXwglsma/MaTlIjm+821tEBgc3NFI2G0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLoTgbluNuEb1ppIxCDVPhVSRR03x+HRH+wGk
 TRaulMR7I2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6EwAKCRCJcvTf3G3A
 JmYoEACdL3vVF2NKECABdmlrHoQg7GoQpORVNGSD7el8DAMl2SBhoB09PyPXllokTqK9Wdil8zV
 zZPIhIGvvUg5oG9N/OMZs9AwUK+CMQNWBG1YsP6za4n0V2TaobBHGIJmhYbBfcYx8ZgAp/bSWN+
 TvG9AQpwF5p5NuHck+/CfHURygXTJpYCHco/6y8qBEuIttCFIsytyfX2AQPbQuSvDyoVXAcfxjb
 iaKhvLFCMqVMnBmihmv6mFyiLZfARMGlfrvAAO642M46+/rMmAx0Fg0TCkLZDrmOwoOXUqiV4kj
 BJSWoBKjM0hUxo0fXw/Ha5n6uDjLsZ9uXNh6cszZO9Dx1z1bCrAWDkyIKpryVLX4ZF0Xn2MZSD9
 y2tF1ooPUPeZHIFOy+ZdXVrUI5Hrcgq6J/85H2zltLR30GOyvTV0cl4wD6vz7T1xZz6JT0jN//L
 tBY+QCaBMaB2e7UPPX6ivy4npGZRvC93WHEHwYZ7pRXA6aDkDEL91tLzVdMdPeGvNvybrASe8sN
 vwcfhZhL+89ozR+go0DF8VBaeAuHatpbKYiUM39R3IB+Lvn5c3v8fUxPUHvkZDJEvD0R7u8gsqi
 tFykTaw5+cMlZFoLrXywMsHcXVrOccqZEt+dOi9SCZnr7CvdKlmoHc+hTlyIOli3HNATBr5UqqP
 pJ1mVkd qJDn93uQ==
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

As found with Coccinelle[1], add __counted_by for struct el15203000.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/leds/leds-el15203000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-el15203000.c b/drivers/leds/leds-el15203000.c
index 7e7b617bcd56..d40194a3029f 100644
--- a/drivers/leds/leds-el15203000.c
+++ b/drivers/leds/leds-el15203000.c
@@ -80,7 +80,7 @@ struct el15203000 {
 	struct spi_device	*spi;
 	unsigned long		delay;
 	size_t			count;
-	struct el15203000_led	leds[];
+	struct el15203000_led	leds[] __counted_by(count);
 };
 
 #define to_el15203000_led(d)	container_of(d, struct el15203000_led, ldev)
-- 
2.34.1

