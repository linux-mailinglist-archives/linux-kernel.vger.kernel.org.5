Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC747A517B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjIRSBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjIRSBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:01:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6435DB;
        Mon, 18 Sep 2023 11:01:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31f7c87353eso945653f8f.0;
        Mon, 18 Sep 2023 11:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695060070; x=1695664870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cmvXpKMQno5A00syG83s4F0RNpgRyQmZAnIOeoswnyc=;
        b=P2s6YCODTLTHVvSTbu/QCxmR1clba5aEdlPGNsIqK078wteOv2JwRxH3Jy2gZ/I0Vz
         harpFx6p/ZgxUvRYbp38ocMrtDLiFLrCwPmvKjDeRCXnA/T6rJ4EUWlMNWSRAodVAJhj
         EsrZckLIGk6uABS91FA/v1eeqsRgA8Oqnco+nw/JUDiv5A9+VvZ4o9xw/c1QGFLAOChZ
         22HIt0C3LRbgeR/hepLSnjMFZ1Iog4oSoV58XZBOqfew04c9rbwMdTg6GGa6DsjTMWRh
         7qwefagOpiM5ayKJTlDB8WC3xyqgcPmZu8d9ibUWHrkWZMmc1jUlhUStJsY/1W7DiC/t
         Z0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060070; x=1695664870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmvXpKMQno5A00syG83s4F0RNpgRyQmZAnIOeoswnyc=;
        b=Nf4T8pvATCet3zp/gdn5ohVslBDR4fEtcKfwo/drufYz/+se48n8xpWt/Rj64qqk99
         bjRNuvQG5h1KZOBWo4qYJdE6I+8o9mJ1Rv8m1Z0K+NgUABiKZREQBxgUI+bSolFL9PNR
         0RPDg2zF+NLFMR32OYtYxIfN/6VCL4WalaLyPtMZ+pqYBEzCi9533+OydEKzgaPOYgwU
         2Qv/HdjPi5y5CUp+dNqP/9dHU/7jXGJfLhvbISirvhsXswkjgiN2dkdCzZKBklBji2gP
         YvwjtNoyUd5h3C6In/EjVsmNPya9k91I5PNh2PXCwQ5DT4CSfgPzpW/ncRpqP6pWHb9K
         SoaQ==
X-Gm-Message-State: AOJu0YxCMcXt1EOpBqV9BjISajsqi11xXXOhanDNafKFvX1wz5sJUeM3
        JAIBY35oxVVWWYVdsVU45GI=
X-Google-Smtp-Source: AGHT+IFMam+SIBnrILBvXkxg6UIOQQFVn9y5rVGYJ0W5QBzWp1JYIJWw8cm9B41ENMDf1GLXaWzZvA==
X-Received: by 2002:adf:ec4f:0:b0:31f:a717:f1cc with SMTP id w15-20020adfec4f000000b0031fa717f1ccmr7638106wrn.5.1695060069900;
        Mon, 18 Sep 2023 11:01:09 -0700 (PDT)
Received: from ivan-B550MH.domain.name ([178.160.241.68])
        by smtp.gmail.com with ESMTPSA id o6-20020adfeac6000000b0031c6dc684f8sm13232942wrn.20.2023.09.18.11.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:01:09 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, corbet@lwn.net
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH 1/2] ALSA: docs: Add Marian M2 driver documentation
Date:   Mon, 18 Sep 2023 22:00:49 +0400
Message-Id: <20230918180050.6166-1-ivan.orlov0322@gmail.com>
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
index 000000000000..a968feea79c0
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
+This driver is based on initial driver written by Florian Faber in 2012, which seemed to work fine.
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

