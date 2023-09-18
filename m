Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4F37A51C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjIRSLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIRSLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:11:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D04103;
        Mon, 18 Sep 2023 11:11:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40472fef044so9671815e9.0;
        Mon, 18 Sep 2023 11:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695060695; x=1695665495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=izrjrMGBpPCkr9U7qebqVQKKiL2jpXVFSYUNkSOXrnU=;
        b=NFDsFzUOnqskEv+7REqO8Q72+Jqu1SdUyCaN6dI4NK5ZxZID47bmgEtwdgVRuI1CiA
         JOJVYaqfCwhZGKLAVITkhe11sL5zBmgRU0ukSdhMIWofUkklQ7cywfCGzAGJYn0AfV6T
         mW5Oglj2IKbFvmWs7kbmU3t7daa+v0CC4rgiH7rUSbhs/npGoNKD39kFdfKCNZ6Go3Wo
         2uQB4+MJQWKtjmJZQPTaxDPilfPyhrO/qrl1bUQO10mOw6qUmRXYWJG5wUUrGQeTvFnL
         2SZb27QFR+jtAVEDXQHem7fgV7WoMJ7FbI3macEBQzHn/B4WMDheOCuhUOCCJV+xNx8J
         Ailg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060695; x=1695665495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izrjrMGBpPCkr9U7qebqVQKKiL2jpXVFSYUNkSOXrnU=;
        b=ETid3GSePTHx0tNj0eCSbk56h7xQOjYhkOQMZdC3sXfOcmHi/Vfb7hCrvDXEmh4Kmb
         ZPOL8R6FqPLpWIImkcgcivethlYeZrR8rDowiSpNFmwXD6UURnfPHPdhyVxZ3nEwj1cu
         m4ge8j4Eiz/Rds/3grprK4oWYxa4mT3ztd9uQIJOcArWi9VTiQyMuOO4ZqLjHeemF5Ie
         s7yIzSh9HQTPGwdUTl6TFLk2GOTAOAwBgjfa4hV4f9vgosnpfTl2YX4bUf+7R1y5qaQ9
         12yIfRm8z205aqgDEXdIfr9zk9ZXwlneCutzPUab6szdA87j5k5bddHNbxenHulaFb16
         kLKA==
X-Gm-Message-State: AOJu0YwBMXwWsFdNYdO66u96YfcSBXoTXVdUaG1Tii/45eS79f8CaSDq
        wliVlfK3weGcpI+APPGF0b4=
X-Google-Smtp-Source: AGHT+IGxry8HqUFfp+mriNzQZYSAuA7iVv+R4bRVLZRESku9GPhySmAjsW/GgUOjpmfdqn9K9ePakw==
X-Received: by 2002:a7b:cd91:0:b0:3fe:d46a:ef4b with SMTP id y17-20020a7bcd91000000b003fed46aef4bmr8516093wmj.1.1695060695056;
        Mon, 18 Sep 2023 11:11:35 -0700 (PDT)
Received: from ivan-B550MH.domain.name ([178.160.241.68])
        by smtp.gmail.com with ESMTPSA id x20-20020a05600c2a5400b003fe601a7d46sm15865769wme.45.2023.09.18.11.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:11:34 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, corbet@lwn.net
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 1/2] ALSA: docs: Add Marian M2 driver documentation
Date:   Mon, 18 Sep 2023 22:10:43 +0400
Message-Id: <20230918181044.7257-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the new MARIAN Seraph M2 sound card. It covers
current development status, available controls of the card and
information about the integrated loopback.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Remove redundant documentation fix from the next patch in the series

 Documentation/sound/cards/index.rst     |   1 +
 Documentation/sound/cards/marian-m2.rst | 104 ++++++++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 Documentation/sound/cards/marian-m2.rst

diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
index e68bbb13c384..e873592d8d00 100644
--- a/Documentation/sound/cards/index.rst
+++ b/Documentation/sound/cards/index.rst
@@ -19,3 +19,4 @@ Card-Specific Information
    serial-u16550
    img-spdif-in
    pcmtest
+   marian-m2
diff --git a/Documentation/sound/cards/marian-m2.rst b/Documentation/sound/cards/marian-m2.rst
new file mode 100644
index 000000000000..bf12445e20d7
--- /dev/null
+++ b/Documentation/sound/cards/marian-m2.rst
@@ -0,0 +1,104 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+MARIAN Seraph M2 Driver
+=======================
+
+Sep 18, 2023
+
+Ivan Orlov <ivan.orlov0322@gmail.com>
+
+STATE OF DEVELOPMENT
+====================
+
+This driver is based on the driver written by Florian Faber in 2012, which seemed to work fine.
+However, the initial code contained multiple issues, which had to be solved before sending the
+driver upstream.
+
+The vendor lost the full documentation, so what we have here was recovered from drafts and found
+after experiments with the card.
+
+What seems to be working fine:
+- Playback and capture for all supported rates
+- Integrated loopback (with some exceptions, see below)
+
+MEMORY MODEL
+============
+
+The hardware requires one huge contiguous DMA space to be allocated. After allocation, the bus address of
+this buffer should be written to the hardware register.
+
+We can split this space into two parts: the first one contains samples for capture, another one contains
+play samples:
+
+CAPTURE_CH_0, CAPTURE_CH_1, ..., CAPTURE_CH_127 | PLAY_CH_0, PLAY_CH_1, ..., PLAY_CH_127
+
+The card supports the non-interleaved access mode only, so samples for each channel lay together:
+
+C0, C0, ..., C0, C1, C1, ..., C1, ..., C127 | C0, C0, ..., C0, C1, C1, ..., C1, ..., C127
+
+The count of samples per each channel buffer needs to be set explicitly, so the address of the first
+byte of the playback data depends on this value. The playback buffer starts where the capture buffer ends.
+It makes the arbitrary period count/buffer size feature impossible to implement, and the driver supports only
+2 periods per buffer.
+
+Controls
+========
+
+Input 1 Sync
+    0 - No signal, 1 - valid MADI signal found, 2 - Synced with MADI signal
+Input 2 Sync
+    0 - No signal, 1 - valid MADI signal found, 2 - Synced with MADI signal
+
+Input 1 Channel Mode
+    0 - 56 channels, 1 - 64 channels
+Input 2 Channel Mode
+    0 - 56 channels, 1 - 64 channels
+
+Input 1 Frame Mode
+    0 - 48 kHz, 1 - 96 kHz
+Input 2 Frame Mode
+    0 - 48 kHz, 1 - 96 kHz
+
+Input 1 Frequency
+    Measured frequency on Input 1
+Input 2 Frequency
+    Measured frequency on Input 2
+
+Output 1 Channel Mode
+    0 - 56 channels, 1 - 64 channels
+Output 2 Channel Mode
+    0 - 56 channels, 1 - 64 channels
+
+Output 1 Frame Mode
+    0 - 48 kHz, 1 - 96 kHz
+Output 2 Frame Mode
+    0 - 48 kHz, 1 - 96 kHz
+
+Clock Source
+    Internal/Sync Bus, Input Port 1, Input Port 2
+
+Speed mode
+    VCO clock range (slow/fast)
+
+DCO Frequency (Hz)
+
+DCO Frequency (ms)
+
+DCO Detune
+    Range: -200...200
+
+Loopback
+    Enable/Disable integrated loopback
+
+
+Loopback
+========
+
+The card contains integrated loopback. When it is enabled, it sets the hardware’s DAW-in memory pointer
+to the hardware’s DAW-out memory. So, what you play is what you record.
+
+You can enable the integrated loopback using the corresponding control.
+
+The loopback seems to work well on lower rates (like 28000). However, when the rate goes higher, I observe
+multiple mistakes in recorded byte ordering.
-- 
2.34.1

