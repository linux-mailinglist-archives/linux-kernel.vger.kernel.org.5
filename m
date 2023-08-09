Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC9D775D8F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjHILiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjHILiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:38:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24D9173A;
        Wed,  9 Aug 2023 04:38:50 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so103237821fa.1;
        Wed, 09 Aug 2023 04:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581129; x=1692185929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7DrOKAHS+IzGe6Euc/6VVFYgmpVEV80Jtoz/MTSBFQ=;
        b=Gm/8NAZjsKmy9PT4/K+kSbGr/vK2pMKUNFHetyKqvHXPm+05PM/Ds2AOjy+qiyurV5
         ocIkbfi+xjvVYgxA36cLGVC8qt/A2O+Bjr8R24qRz7D2MfaVScUMxaM2VNm0n9n75ueI
         /g6i2AKR96BiqQnGwcfxXDjFONzfVlzbRG73JlKFly0YFs6naculhKZjXwvOBPUAYZFx
         noyMApGhGRjqMAUr4S2d3sN1TpqhasHkQHJPR8KuY3+LuQilvSMhnd8d2nOyw09FdKVR
         h+c0a4T0NpFSSas1acIIcCoWz8pDniBSiaeMtGet9jlRbadvOlFutEOJ5Lr2jupd0QnV
         oGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581129; x=1692185929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7DrOKAHS+IzGe6Euc/6VVFYgmpVEV80Jtoz/MTSBFQ=;
        b=igdq+5eqzoJYLHgWlTeOs094pyv7G7iJBINUpj/k6s/aNBeTXhr3jr0Jjm08N2eO22
         JJzssEqjcgBhVSE6ceU0Ka9b/75/7a0gwH8s9baCp549XRzznh0D2xoKNXKUJpeqDbrO
         IxkNMdqpgh80brm4RF3FThqUc1dfmzKXoC5KNxiagQ4FVueiGuUfiw5JZqB4qVFNfxkQ
         S5qfnr9rVtHUURPECctMk7D1o/dBSN6d91cwbPJ8UMVXkQsEp20OTl4WUcZpcnI8ru1S
         eUDg/K3+Z+TOJkeUbMc4UhSQVbYqRoWCtoQW3FFtS6J8YMhAnJf/Vb/vlsOtkO2qn2Nw
         Fdwg==
X-Gm-Message-State: AOJu0YwcL3RtRxI8PftJIMqzJz2e63m5fdLlg8Cn/y05uVz/hG+yhCPn
        5A1/E3BRQHaaBBOC6GHevxg=
X-Google-Smtp-Source: AGHT+IGLShGmCh8oBgIY9+OvWpu9UGXPzRkS67bVBWAe094J6ah+N/S9BXEuhbDN+uK5dpT0+v02+A==
X-Received: by 2002:a2e:8609:0:b0:2b7:15d:24 with SMTP id a9-20020a2e8609000000b002b7015d0024mr1685409lji.41.1691581128850;
        Wed, 09 Aug 2023 04:38:48 -0700 (PDT)
Received: from localhost ([185.241.208.206])
        by smtp.gmail.com with ESMTPSA id a15-20020a05651c010f00b002b9f642fbe6sm2652489ljb.111.2023.08.09.04.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:38:48 -0700 (PDT)
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
To:     =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [PATCH] HID: logitech-hidpp: Add support for Logitech MX Anywhere 3 mouse
Date:   Wed,  9 Aug 2023 14:38:32 +0300
Message-ID: <20230809113832.123667-1-maxtram95@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Logitech MX Anywhere 3 connected over Bluetooth to the device table
to get hidpi scroll supported. USB connection over the Unifying receiver
is already supported by the wildcard entry LDJ_DEVICE(HID_ANY_ID).

Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 129b01be488d..61d68c96581a 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4647,6 +4647,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb02a) },
 	{ /* MX Master 3 mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
+	{ /* MX Anywhere 3 mouse over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb025) },
 	{ /* MX Master 3S mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb034) },
 	{}
-- 
2.41.0

