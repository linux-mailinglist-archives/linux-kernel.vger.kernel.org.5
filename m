Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9255B7AB835
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjIVRvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjIVRvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:51:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B321716
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:51:00 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c44c0f9138so20941425ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405059; x=1696009859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gFyJJYhu61gLnPgJC1ya/mEghfp9ocdZMiaUuBpRzCI=;
        b=VQAkobzXY82wBd3qU3adEkwwv4GuskkyqfniSPuYFTJ9M0BHx4+T2Ob7pX7AVfxQEA
         winKjJ+/n2jaku1+DcrvJH5E0rpeTlfIRfjixE+HJjsrn1sIbvsiA1p1/xgRB8+oXGsT
         L3ut/GVCey534e4FGMfy9L9gjCHBfIUOEhlIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405059; x=1696009859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFyJJYhu61gLnPgJC1ya/mEghfp9ocdZMiaUuBpRzCI=;
        b=H+ZOi8rFPv5LA5qEFcFyoIMZn5oiGdjI78Vd+i+jcbCFPLk1SHslrKAW8g3YiimeH7
         ScN1xljMKgKa/3JweRbXjxcYQS+sS9wKpFoM+Ah/Qotr6wJNhSQ38PP88SDCjmdf4gQr
         wmyxOGhn/tdU71HkhumPvg2AVJAobw/RcBY/n8q98nKKGJPJzZ+sQ6thePbPkFCP11zV
         Nr3EoF+mIS+rYBR1VccIy7Jw+6SKcLPUuoYWSUDK6jCqV3C9KNnmZ3VlfPGrqAjgfnt9
         CbmoZOLMDNgxOa6GRiQpvHss+2+0qE+inGnkax7DDWsitQ1m0J483qLRYbgI7MwZr1Tm
         AP6w==
X-Gm-Message-State: AOJu0YwXUgMXrIKSrIp4cHWpn3fPIHb+RyywV4t4AI93+QtL7KZXvm2U
        B0JmxiylZ8tz2jzjgnk8x/numA==
X-Google-Smtp-Source: AGHT+IG1adrBAZ2+GtFScfWMTn8dsWjCCh+RfOJyr3A6ecvwwm0uIC035vv1JafJavULfeMVJ0iE6g==
X-Received: by 2002:a17:902:e844:b0:1c3:f4fa:b1a2 with SMTP id t4-20020a170902e84400b001c3f4fab1a2mr222048plg.8.1695405059632;
        Fri, 22 Sep 2023 10:50:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y18-20020a1709027c9200b001c5de42c185sm2833729pll.253.2023.09.22.10.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:50:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] misc: bcm-vk: Annotate struct bcm_vk_wkent with __counted_by
Date:   Fri, 22 Sep 2023 10:50:58 -0700
Message-Id: <20230922175057.work.558-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2215; i=keescook@chromium.org;
 h=from:subject:message-id; bh=GdZsD7KH5MvR1EoC8TSF7iyP/6ZcwlPVOaPWgy/qG/U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdQC249SPfiphqcsPLrCDIDyXGQ5SRF673Br0
 hQuer+DlnaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UAgAKCRCJcvTf3G3A
 JrF+D/0Y6GwQ6UQX5zVVwMmJRnNwyqK4+dCUgc8y1tQGnK+kPTUOZBmyS+1SoMAx5k/0bYPJakH
 5qqklha3HDxhEORrhcj4OH7BsqtkbT/KKDbCg3rTiLmq3cBgVnA+270iTiPLJB2AvsFAxBN6CrR
 AEoNs+Ijz9ShuaXP33ZqMdypuIFYnQZ25ltNHfdmj4WSj9o3UfO6S9ldRt/f0XYni1+Sqywb5M7
 1oWcVWrFiW3heKM91hca6ad5zoU9+4RbrCxIBZ0qCbgvRNvk7Mc3NWWJ21sYsniyZ0grpKRQa/r
 /5eaiwomFzIUwebpM4QlMnHm1MT8ir+fLumHPOmcZl4180wQbLTXvjAmOlRdcnMlTPVHPFDU38g
 Ez6UoDvUI3Mhep1HRy3TAJwtKgpW0ZIi5Rb3XviAV+/3Y1zivKH+WJfS0+Nwom9WX23MKCN8UnY
 lFO3dSjJ59VvKdhfEQ5OLRiOvhjiwxbj+xlBeguiL63r7KE9WgxB/Pqsx/G97UIghEsgYBWgLbT
 uIVM4vqXFolYKK5jSDyG4HS4lgD0PxpSurGZkC+PE9RqYgOKsEDrvnOlmvJSGXbag85Wx58N+XA
 YWhZgVlWuubc88sBm8HoRH8JVs+iQ+gbRCGBtZCBmERMvujOh7zX5SCEAnOLj3TqagG9GgMZZ13
 +ayp/8S h4UOHkGw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct bcm_vk_wkent.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Scott Branden <scott.branden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/bcm-vk/bcm_vk_msg.c | 2 +-
 drivers/misc/bcm-vk/bcm_vk_msg.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index e17d81231ea6..1f42d1d5a630 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -703,12 +703,12 @@ int bcm_vk_send_shutdown_msg(struct bcm_vk *vk, u32 shut_type,
 	entry = kzalloc(struct_size(entry, to_v_msg, 1), GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
+	entry->to_v_blks = 1;	/* always 1 block */
 
 	/* fill up necessary data */
 	entry->to_v_msg[0].function_id = VK_FID_SHUTDOWN;
 	set_q_num(&entry->to_v_msg[0], q_num);
 	set_msg_id(&entry->to_v_msg[0], VK_SIMPLEX_MSG_ID);
-	entry->to_v_blks = 1; /* always 1 block */
 
 	entry->to_v_msg[0].cmd = shut_type;
 	entry->to_v_msg[0].arg = pid;
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.h b/drivers/misc/bcm-vk/bcm_vk_msg.h
index 56784c8896d8..157495e48f15 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.h
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.h
@@ -116,7 +116,7 @@ struct bcm_vk_wkent {
 	u32 usr_msg_id;
 	u32 to_v_blks;
 	u32 seq_num;
-	struct vk_msg_blk to_v_msg[];
+	struct vk_msg_blk to_v_msg[] __counted_by(to_v_blks);
 };
 
 /* queue stats counters */
-- 
2.34.1

