Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EA6769438
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGaLGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjGaLGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:06:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA80098;
        Mon, 31 Jul 2023 04:06:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98df3dea907so636468066b.3;
        Mon, 31 Jul 2023 04:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690801596; x=1691406396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9MdJiXGwyAkiC9mDh3NLqdU991BSWOeaVMH8LHr/VMM=;
        b=gIBxG5FZsM49TCiOEwGy/nkwgZSwyZyL00R5QXTBVFthMK/oAShm4WhD/TXuiwXwAI
         QB3kFzfjjjuwFi2fcm3s5vDCHAHuDd3jTJwm7TrtmCgyiYZt4k7N//qivLlHeICX5pIZ
         cTZcmbMu1BF6jNF32D4oubDsjfLg/W9yzQdWHRQKetUsSeoMw5Hv7LlCK8B6CQuT0Ad+
         rdrYY2KWMcfBDyHawpRcue8tCxUPRMPMmCpfN/J822SlEThnD31mYWEQGTpaVvVK4uwL
         FjR7WpEjzhRhV4O8IKbUmqEvhr4ZvNWg55NFSN+TUgszNG2BEnrCxZHfrgZBITOYELWa
         9Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690801596; x=1691406396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MdJiXGwyAkiC9mDh3NLqdU991BSWOeaVMH8LHr/VMM=;
        b=luvvtGZclaiNYlvi3k8TQCDD7M+9kT9sW3o2Iott9KFv+tBorfa55SUhA9F7YR/ci5
         6/ZjiEk4tubtYc6dlxJAp7OpkoPPE4tBSrnoPwid6Jvav2nMEW8DemsOuhNPIZ7tSYlW
         Gc6dzTi3mz50XypHocgKIkuL6Bwuh3mbqFeVYkz6ahCv6psF1Sf7P+zO+wL0U4ajctHV
         2bv2nCvQerqWJRACFUbvLgGeW19+gbwYC++QF4gtRAxT+AfcSw0fosJD+IAn/Q1asnCE
         enTaoBnxnfMv4GtZ3UwEXSnU3tCZQC7TrAZlZmXIW66XuEswwRNSh7hkUxSgYx4on8Dq
         jy/A==
X-Gm-Message-State: ABy/qLbIOKocM0EQb1Th1Nnq088jjmAQQnpANERrD5+HpGBjE+8L7Xx+
        RnY5pbPAFYyMAfHcDxAVU9LHt97czPirrg==
X-Google-Smtp-Source: APBJJlFysB5VO6gTBbAO78UVacGn24mY4IJgu1Ob2slRxFWBlhQfKkabRQJlBk5/mrLe8jps38MZYw==
X-Received: by 2002:a17:906:9b:b0:993:fba5:cdef with SMTP id 27-20020a170906009b00b00993fba5cdefmr6812802ejc.8.1690801595849;
        Mon, 31 Jul 2023 04:06:35 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id n26-20020a170906089a00b00992ddf46e65sm5961001eje.46.2023.07.31.04.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:06:35 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcaov@gmail.com>,
        syzbot+b08315e8cf5a78eed03c@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: [PATCH] staging: rtl8712: fix race condition
Date:   Mon, 31 Jul 2023 13:06:20 +0200
Message-Id: <20230731110620.116562-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In probe function, request_firmware_nowait() is called to load firmware
asynchronously. At completion of firmware loading, register_netdev() is
called. However, a mutex needed by netdev is initialized after the call
to request_firmware_nowait(). Consequently, it can happen that
register_netdev() is called before the driver is ready.

Move the mutex initialization into r8712_init_drv_sw(), which is called
before request_firmware_nowait().

Reported-by: syzbot+b08315e8cf5a78eed03c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-staging/000000000000d9d4560601b8e0d7@google.com/T/#u
Fixes: 8c213fa59199 ("staging: r8712u: Use asynchronous firmware loading")
Cc: stable@vger.kernel.org

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8712/os_intfs.c | 1 +
 drivers/staging/rtl8712/usb_intf.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index a2f3645be0cc..b18e6d9c832b 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -327,6 +327,7 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 	mp871xinit(padapter);
 	init_default_value(padapter);
 	r8712_InitSwLeds(padapter);
+	mutex_init(&padapter->mutex_start);
 
 	return 0;
 
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 37364d3101e2..df05213f922f 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -567,7 +567,6 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 	if (rtl871x_load_fw(padapter))
 		goto deinit_drv_sw;
 	init_completion(&padapter->rx_filter_ready);
-	mutex_init(&padapter->mutex_start);
 	return 0;
 
 deinit_drv_sw:
-- 
2.34.1

