Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0010D76FF83
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjHDLcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHDLco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:32:44 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E4211B;
        Fri,  4 Aug 2023 04:32:43 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686ea67195dso1421709b3a.2;
        Fri, 04 Aug 2023 04:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691148763; x=1691753563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VfvBijsO2sMlDrlMC7AyPHbFWwb0ahNV79UVj+FEisM=;
        b=U70dWupWM2FxVvKo+UYn/YBIE4+3RwWguzMzX9YZgY3H5HcliIY1JdK6NyTrSCMCtl
         7uR5IN+PMCPAtQVuYB11ypayUnXrLZ2/RUJj4Ml1i34TkQWrcahCY5axBckLdhuyuDtJ
         sy/KqPOssCahHDs7pdlwmffWMDxq2ivladpzNutqTNuUzcuVzc+r8BhX0KsdUKYmC73i
         K2vedwwlHSCOCWT3CKXRAnSUqu1RJkkUYaDhs6kP08BxWCXXFhZexd3srflWOoEiuZfb
         1UEc4KS9p32fF6SEyJNM8Xtdv37f0t99VQ0GgJWaZ1Q9Tnf1JoYaqAUxCRHt+W6OvuDM
         15jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691148763; x=1691753563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VfvBijsO2sMlDrlMC7AyPHbFWwb0ahNV79UVj+FEisM=;
        b=e+szlpff74M7im4HT39119k/4fk4ISioYA8lXkvqpRXPR1uCASaKZsNZwptcTcn9VW
         EyRZkw8T4civN2p8v4gImu5/Utoa7uccwDlRhg0uMZcfJbe2rGrI057RfeE2meoYI/5G
         nndfq2Fvvj9OFteOoXZ1IZZZ70ezk1hyYWCzDyFRmqPbJdKANtg9ed1TKzWwvUwSwpWa
         Ojj7exTLNJFgxYRupUpCOH58Snk3rVSbFdV2vAHWGTqwWrEtLf3M+r05pTTp7M2qEOm4
         AEbKkP/SA9+77lnnLZb0CTRGfZIAThXmI+I0CF1WMzP57W9x/wocaccJKwR1E8bJNwF8
         XHVw==
X-Gm-Message-State: AOJu0YwpFNi3gWq+4B9f2+BlQxjqf0ZRV3JzaXSCyNAkPKRIoRBnuGEs
        eaUweVxVJzGfYkX5DuQm4Ma/V+zK2x0=
X-Google-Smtp-Source: AGHT+IG9dvCYmEptOFC9VjllrZMWd5c+brV4DTFKrmiuaeUagZRje6Mdh2k+6LaXQABWjnvTuQ3P7g==
X-Received: by 2002:a17:902:f94e:b0:1b3:f5c3:7682 with SMTP id kx14-20020a170902f94e00b001b3f5c37682mr1049005plb.68.1691148762695;
        Fri, 04 Aug 2023 04:32:42 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-73-13.dynamic-ip.hinet.net. [36.228.73.13])
        by smtp.gmail.com with ESMTPSA id iw3-20020a170903044300b001b857352285sm1536501plb.247.2023.08.04.04.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 04:32:42 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fbcon: mark fbcon_registered_fb static
Date:   Fri,  4 Aug 2023 19:32:35 +0800
Message-Id: <20230804113237.51653-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark fbcon_registered_fb, and fbcon_num_registered_fb static
to fix the following sparse warnings:

drivers/video/fbdev/core/fbcon.c:105:16: sparse: warning: symbol 'fbcon_registered_fb' was not declared. Should it be static?
drivers/video/fbdev/core/fbcon.c:106:5: sparse: warning: symbol 'fbcon_num_registered_fb' was not declared. Should it be static?

No functional change intended.

Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>

---

change since v1:
1. registered_fb and num_registered_fb are still used in drivers/staging/olpc_dcon,
so do keep them as-is.
2. change the subject to fbcon: mark fbcon_registered_fb static
---
 drivers/video/fbdev/core/fbcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 887fad44e7ec..976900d6893c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -102,8 +102,8 @@ enum {
 
 static struct fbcon_display fb_display[MAX_NR_CONSOLES];
 
-struct fb_info *fbcon_registered_fb[FB_MAX];
-int fbcon_num_registered_fb;
+static struct fb_info *fbcon_registered_fb[FB_MAX];
+static int fbcon_num_registered_fb;
 
 #define fbcon_for_each_registered_fb(i)		\
 	for (i = 0; WARN_CONSOLE_UNLOCKED(), i < FB_MAX; i++)		\
-- 
2.34.1

