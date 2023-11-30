Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213117FEF78
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjK3Mo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjK3Mo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:44:56 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA85D54;
        Thu, 30 Nov 2023 04:45:01 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cfc34b6890so7849025ad.1;
        Thu, 30 Nov 2023 04:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701348301; x=1701953101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcWBigwAEQLxd/2D/xlr472XrZ5RLKDBlKnV9K8Ge0E=;
        b=KP6r0mO8Rbdw/ArnlAwRqSFkoRWDAPn2r4Md1fldtcA7hZK6iA0u+zC09ccrMJ3ePe
         UQmGf8Ah8tPQt93fdGO70HkH/Wi4jzDh0W7Vibj8fHuYIE/NSEOCk0hDdr+L222hnKHs
         r3K/XOCp88TDAzjWV1Tdlj1Ohi6iLLB1ST1lroZW8xNAGIceRTaFJNfNIp1zyZ15fi3d
         8Dn/zdmXHcDX69WrqqxUJbg2rgdRBWOPFxv90vX1fFiTkTkhz/GycmkP4fva9hyom2Vv
         sNNRwsBY/nYSWEnXk+g+AXf6AJVfVv+l3hMTfVvRzQfyOn506F8+llQgnAHZkJ3PZkjz
         BCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701348301; x=1701953101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcWBigwAEQLxd/2D/xlr472XrZ5RLKDBlKnV9K8Ge0E=;
        b=Q35Ta8n3ZOegGybLUdS5hOMisBN+DwshPgvRkqq0Hg+NROJti6EqLLD6ZhEBDJEQYh
         nAlNT+N98cQKGPOGadRCGaMBp3rlGNBd81qnzVZqb8QycMVvR6qkmvXslNs4fOSF2tJU
         mFYCDQB5uP54fGr9NBTVVBiwSDWjV/C7Od/5bKVaybgaE13+IB7ID03CSv0HHIwcC058
         3DbjbBsH/Nvd3D4JM16y72+ZUfkmylrqPMqXm1tgCqG+jXwt9jVbj/WY8kpfWnHlMNl4
         Ietqo3KcNbXmG66EsfA5/tXAr+LOA1Ba/UWLy1SdPEFsrrMi+N/eQ0x75QqpZWlPh/SC
         ZS2w==
X-Gm-Message-State: AOJu0Yy86PdMPgIABO2tWvQIGGlpT3cpcU7pSc43l+ZFwIzsXqKArB3j
        lnLvIwd++TA5gnRtabvmGVe9lGOGXRuCzg==
X-Google-Smtp-Source: AGHT+IFhQ2WGTyc6UagJwSmCP8MJECePq0BT6Xx3EiE1x8lneakyNthndXYW3FytXYLExoQ7yOHDHw==
X-Received: by 2002:a17:902:c60b:b0:1cf:5746:7ad0 with SMTP id r11-20020a170902c60b00b001cf57467ad0mr28483189plr.14.1701348300722;
        Thu, 30 Nov 2023 04:45:00 -0800 (PST)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001c407fac227sm1274742plw.41.2023.11.30.04.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 04:45:00 -0800 (PST)
From:   SungHwan Jung <onenowy@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     SungHwan Jung <onenowy@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: acer-wmi: select ACPI_PLATFORM_PROFILE
Date:   Thu, 30 Nov 2023 21:44:52 +0900
Message-ID: <20231130124452.3460-1-onenowy@gmail.com>
X-Mailer: git-send-email 2.43.0
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

select ACPI_PLATFORM_PROFILE to fix the dependency problem for acer-wmi
to support platform profile.

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311301842.ppdT4zWK-lkp@intel.com/

Signed-off-by: SungHwan Jung <onenowy@gmail.com>

---
I apologize that I missed dependency in kconfig.
I have submitted a single patch because the series of patches were alreay
merged to linux-next.
Is this enough or should I re-submit the patch-series including this patch?
(or modify this to apply before "platform/x86: acer-wmi: Add platform
profile and modekey support for Predator PHN16-71" commit?)
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 8e99a2f10147..81e6cd62a533 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -182,6 +182,7 @@ config ACER_WMI
 	select INPUT_SPARSEKMAP
 	select LEDS_CLASS
 	select NEW_LEDS
+	select ACPI_PLATFORM_PROFILE
 	help
 	  This is a driver for newer Acer (and Wistron) laptops. It adds
 	  wireless radio and bluetooth control, and on some laptops,
-- 
2.43.0

