Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F477CF4DE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345225AbjJSKPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345188AbjJSKPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:15:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49854119;
        Thu, 19 Oct 2023 03:15:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083f61312eso12264535e9.3;
        Thu, 19 Oct 2023 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697710501; x=1698315301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzwyhcJNZa6arJQKPZmLNcj0YJDSwAR/dJyY9R0VHn8=;
        b=BjU2L6Ol+dwOKgU2rm84OysTJXZdovTbB+t5vegzP9KYiAM9eJ9N7a+FJrJlepHIBD
         xbqGvfl+yC9Uq1Wke/Eg8M0zc/3ij98h1REuohxjiBKaRjY31PMQLNtPJhRG0e9WaJ5R
         66Jh2T7hBnc2+zmCyJdVAjPcZnkkdmK8ow8uLsJwX4QExdy7aF2h228bQ3W0/eU7qKwY
         ovtsLtSa8eZMm9xcjI+gf9CGA6sSs1v0Q7bqMJ+wcCRBeskVjfj28s8vaTHMTvwhmMBR
         Mrb+x+MBd2FrSqFgRwxwZFb2q7RVRY5WHceghLROoHBRQm2/zPUf+4DaxMTw58ygWM7C
         yy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697710501; x=1698315301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzwyhcJNZa6arJQKPZmLNcj0YJDSwAR/dJyY9R0VHn8=;
        b=OBxFZrrVvm5IhBAdO+ASscTYES4zDZ7tHCqDz2ANnAPy+PEbP3/RkqEIimrR7QBHo2
         a8AMCALZLHMOKMlfROoiMb/94sj0k+YwoK2Zx1PFvkb6vO38/ticWbHYxcQzCsyXA5LW
         hUwzLeF3UtybeFprN2a+b5/6tiY0gDOGvjIWlZOacTPNlH1xKD1rpOJKmP/h8BHdGn0x
         bmkuv3/uN2QL1Mo0wWW/A+b4kv3/J2SxVwPuM8GgJhFEtoMOoRvhc9ZGItFQW/B6h60+
         UfBKoOUp1Lxra/cfTe4u6mcYQi+/XLyiOapsQnaO9XBhP35CA8nax22PS6w7qW+igwPn
         ogKQ==
X-Gm-Message-State: AOJu0YwayjUfl3I/gxXqprW9EL7KiVTtcAiNtgHqI18qutocKjkqsmJO
        +gfIEAxeRv2emDShHDomyQ==
X-Google-Smtp-Source: AGHT+IGY5Xbs39tKxYBmkdFpZ2jA/z2asMgDIq62w/t6lDhh17EFeuuxE3jZ86dk2BbT0yS3/BtY0g==
X-Received: by 2002:a05:600c:1c25:b0:404:4b6f:d70d with SMTP id j37-20020a05600c1c2500b004044b6fd70dmr1509198wms.17.1697710500407;
        Thu, 19 Oct 2023 03:15:00 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.1.8])
        by smtp.gmail.com with ESMTPSA id l32-20020a05600c1d2000b00402f713c56esm4109300wms.2.2023.10.19.03.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:15:00 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr, dan.carpenter@linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] staging: sm750fb: Remove unused return value in display_control_adjust_sm750le()
Date:   Thu, 19 Oct 2023 13:13:36 +0300
Message-ID: <20231019101348.22076-2-anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
In-Reply-To: <20231019101348.22076-1-anonolitunya@gmail.com>
References: <20231019101348.22076-1-anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modifies the return type of display_control_adjust_sm750le()
to void from unsigned long as the return value is being ignored in
all subsequent function calls.

This improves code readability and maintainability.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index bcdd291d25c9..83ace6cc9583 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -13,7 +13,7 @@
  * HW only supports 7 predefined pixel clocks, and clock select is
  * in bit 29:27 of Display Control register.
  */
-static unsigned long
+static void
 display_control_adjust_sm750le(struct mode_parameter *mode_param,
 			       unsigned long disp_control)
 {
@@ -70,8 +70,6 @@ display_control_adjust_sm750le(struct mode_parameter *mode_param,
 	disp_control |= DISPLAY_CTRL_CLOCK_PHASE;
 
 	poke32(CRT_DISPLAY_CTRL, disp_control);
-
-	return disp_control;
 }
 
 /* only timing related registers will be  programed */
-- 
2.42.0.345.gaab89be2eb

