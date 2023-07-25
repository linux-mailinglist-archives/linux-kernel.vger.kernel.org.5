Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4A4762066
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjGYRnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGYRno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:43:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2B81B8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:43:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so48487535e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690307022; x=1690911822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Egs0y5KaNWNkFIqpVQHSvHUdOFnfxsQHMYxQOgZ2Qlk=;
        b=Mx7tVQGgw6ZrmrtxVZ/ZP4o8eZlqGAepCEpLu5bM+w58YAICTxSMq3o05Rg6hf3OoT
         /fycCK/RoDcrpZweo5iwGlKmbh4ojwekKiW1wVblPfGcVy/w81tfh0+M8/yxvy33B2y9
         0wdCEa5Q9vWe6/Qt0GgZF2LhfdUIo0HdbLxeo1ZgJjuL8y3X8o4PqjUpMXFr8PPu+sSD
         41A7z7vI5W5X6q9Zvyh+PswfSllcve6lEyPD9mIj8FWDvTrrriDid/I6otF5igDWioh9
         /DID+SgT8nSXJEVSZiQMKPtUzB14Oqn+RXkzofq9yjQ+JkEACHJuKv1p/T6fAss3i0aW
         Dwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690307022; x=1690911822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Egs0y5KaNWNkFIqpVQHSvHUdOFnfxsQHMYxQOgZ2Qlk=;
        b=iFJ6gsn8TueBN0Vck82hbLP3zqByjOfsIuMfd/nX2tiCt4VlwyjsgqHNHS6VT1Fw/S
         IRvi/ntWunACQGM+AP2sLDggaoAyY4xKg1ssgsKWjCqZSW3a1HpixDFsXnqli0bQhRcf
         7+xNTA+UTf9rNgRIkKHAj3hyZmEgi11tnp/DDtpV13q+nlowvO9OhkR5N3IcO+Qc9pt4
         OMYkNbdQN68W8fvyGiq9VAdLSsAY/7qwYjEJfArZT6AV89yQ5s/PwWUwQzZXOTLrnV8z
         iSdp0ypr+AkXVomkR1V+fsAq+2y88vV4NlS1IWxoPM6D6DE1V/kLAJgxqWrb/fqST1VE
         QLqQ==
X-Gm-Message-State: ABy/qLb2Hww5e6AJEYnJVRLtm1Mw5nxeo4duIHLeqNuOELJoTcX851ta
        ofOaR5bD28MDd+dysCqI0FVT+cgpct4=
X-Google-Smtp-Source: APBJJlEWHN+oLDtuzZorE0A6Ik+TJlUW5oSXODpupoq5FNTwWrrWoT/duD7y1Es6yOhF/94cNK+9Pg==
X-Received: by 2002:a7b:c5d6:0:b0:3fb:a2b6:8dfd with SMTP id n22-20020a7bc5d6000000b003fba2b68dfdmr9881899wmk.32.1690307021552;
        Tue, 25 Jul 2023 10:43:41 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c1d0500b003fbb1ce274fsm6232690wms.0.2023.07.25.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 10:43:41 -0700 (PDT)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Brian Norris <briannorris@chromium.org>, coreboot@coreboot.org,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH] firmware: coreboot: framebuffer: Allow building with simpledrm
Date:   Tue, 25 Jul 2023 20:43:33 +0300
Message-Id: <20230725174334.887485-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coreboot framebuffer driver registers a "simple-framebuffer" device
based on the information from the firmware, after checking that it's
compatible with the formats listed in simplefb.h. It was added before
simpledrm, and its Kconfig marked as dependent on the simplefb driver.

The simpledrm driver can also handle "simple-framebuffer" devices and
the coreboot framebuffer works fine with it on a 'Lick' Chromebook.
Allow building the coreboot framebuffer driver with simpledrm as well.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 drivers/firmware/google/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index 1bc7cbf2f65d..41b78f5cb735 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -59,7 +59,7 @@ config GOOGLE_MEMCONSOLE_X86_LEGACY
 
 config GOOGLE_FRAMEBUFFER_COREBOOT
 	tristate "Coreboot Framebuffer"
-	depends on FB_SIMPLE
+	depends on FB_SIMPLE || DRM_SIMPLEDRM
 	depends on GOOGLE_COREBOOT_TABLE
 	help
 	  This option enables the kernel to search for a framebuffer in
-- 
2.40.1

