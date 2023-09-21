Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88E17A9FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjIUU0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjIUUZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:25:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39957BC2E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:36:12 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50336768615so2247878e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695317770; x=1695922570; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/fADfeKoZIjZhq0aIRCr68VMxyyHfjxw3zHT+/cyZ8=;
        b=NZc9NJ5fO3lO314/uin9F6itxDEPfsA0MN+o5SMLWYASiEVfMHIUU9xX8ANtCjgURa
         i0scrdAWU/q3Yzq7EaUNgq3PZR7YGEB9PI/0ldzf0sp13Afs5g9CwEeP99Z+hCJJWnBJ
         bRJJ9h5uWypniF3M94RDKB7umLl0n+UoKobFgMjGA3q6gwd2+TMPY1rJQkzrbZ2GyS0i
         bhgo1cocw34aYkHB5X54pEEQGdC/8jy7Dk70N5wFuL+2r1/wu8AmehWymXSRhF9wJ+8c
         Np+o4ygXJw1/UPrgmGBTq0YeTAeTKawZ99vhLRk0e/IKuhDPIDz6GwpmUNWKnTj/AMz3
         fgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317770; x=1695922570;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n/fADfeKoZIjZhq0aIRCr68VMxyyHfjxw3zHT+/cyZ8=;
        b=u68dmSCZpJkzjk+bHGzQHY3w0VqgUrsdN8jK/MNAzXDzBLDUIRXdlOP5V51uKyPDoP
         eAnpCE5j8AUNpOu68YMIEBQlDNyw9bZxqIh5lVw68Rrqfsi+wdumLW5gaLiCrKmDOt+P
         hSMF9I9/Er6RYP6nnsZmE3VJjxthIYxJe1HtwDbmoXnqr1IcA3BcCb5GSK4rge0dhVIq
         5si5Njz+HyCvmYfLCi9LycrtZJs7p8oN1o/9T+1vqH6HHBhjRTYXv4mTiHPnNefCUGIz
         uzr84irh0JMcs/fh41mrTfUvcVJZo5rpIea6zTvBlUeZVGHhh1a+9btrMilz8L1TszEA
         EImA==
X-Gm-Message-State: AOJu0YwsCutQpMa3CErULizGBpEwpqia3C/pj+kCOPYti3Vr0af1XWH7
        Gwly4X4h84ROHwJQcyuZ2g/htARiommaBl8n
X-Google-Smtp-Source: AGHT+IHI5dM0C9xgNsHyQUlP9jSIJIyxu5ITX4hMYw6AAv/xSIdGQZzyKD3dZWpgRE4MfEYw2I5Fow==
X-Received: by 2002:a2e:9b8a:0:b0:2be:54b4:ff87 with SMTP id z10-20020a2e9b8a000000b002be54b4ff87mr3963948lji.40.1695280980822;
        Thu, 21 Sep 2023 00:23:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:7c80:b060::49? ([2600:1700:7c80:b060::49])
        by smtp.gmail.com with ESMTPSA id f13-20020a2ea0cd000000b002c029a4b681sm203240ljm.15.2023.09.21.00.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 00:23:00 -0700 (PDT)
Message-ID: <2436e7f2-b986-4dda-9d4d-0f73845c1ffc@gmail.com>
Date:   Thu, 21 Sep 2023 03:22:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
From:   Abelardo Ricart <aricart@gmail.com>
Subject: [PATCHv3] ALSA: hda/realtek: Add quirk for ASUS ROG G533Q
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same quirk applied to the ASUS G533Z is also applicable to the ASUS
G533Q (of which I am an owner and have thus tested).

Signed-off-by: Abelardo Ricart <aricart@gmail.com>
---
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dc7b7a407638..fdc3560ad951 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9649,6 +9649,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
     SND_PCI_QUIRK(0x1043, 0x1493, "ASUS GV601V", ALC285_FIXUP_ASUS_HEADSET_MIC),
     SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
     SND_PCI_QUIRK(0x1043, 0x1573, "ASUS GZ301V", ALC285_FIXUP_ASUS_HEADSET_MIC),
+    SND_PCI_QUIRK(0x1043, 0x1602, "ASUS ROG Strix G15 (G533Q)", ALC285_FIXUP_ASUS_G533Z_PINS),
     SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
     SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2C_2),
     SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),

