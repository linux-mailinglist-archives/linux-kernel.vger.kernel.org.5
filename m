Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9895C7A8896
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjITPkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjITPkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:40:35 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0744B9;
        Wed, 20 Sep 2023 08:40:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4047ef37f55so12980075e9.1;
        Wed, 20 Sep 2023 08:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695224426; x=1695829226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DmDW8C66MIXswoSM5nwW/iwY1HolEslG881LGV47I5g=;
        b=g0RpJzRLKCLV5x9vt50OCAoxhN79whHaqTsYeH0CXJjyAiIQksTPeD8/KnIZJ5dBG2
         0Jwn2lOSLxHo1qiKB2advo2K+nFMv0EecA4NItQitmz1MXmxVlTLi3RizS/MTmMTGr1A
         hepxd2g0OQMJFGh/beVe3b6pfKGVP5ukD0fnthaW/I+k1fVQtMbDzfwwAm4wCQmf+Jde
         VUvVllaUnIjiC6qqulVEzqCbqLzh7NMDZLgXo8NECrgbtIK8KyQ6VhQ95KVvI79NbGKI
         nMKmraA/NrDGEofYJCVKDB3R1FvFzoTgoEbBYAj743eliQ2uGukaa+HZmvcHsRm7YGKH
         Cq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224426; x=1695829226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmDW8C66MIXswoSM5nwW/iwY1HolEslG881LGV47I5g=;
        b=fexSCnMCH+vca6BX9xh9ajPdAmlNE5glQH0JEcMZ9kV/M6Mv24wWpQkgkZknykotd8
         QQX5MLbN7R2zAFQ+Ey9E5Waj4tivV2mNSY2dizwtzxcXOy0PtuZ9l3OVsqg7HZQXWR8U
         kgqAk8ojcqMk5eZU+beHVIBpqxuY4OJuQdKqb7dxbhTUyE39926w54Iutrmxbk3hBIvs
         aOXXj7gUap/UbufnSH0fy4+/Z1ivWQ3DbPklXFKwDmse627D4vXl39zHkZ6dp/Ct5H2f
         444F/Yn1FYYYnXF+zmSx0x9ktHpSroqQk9Q8DQ4g9gui4dpectTmMEqSaKMAc+n3Ve7G
         Xstg==
X-Gm-Message-State: AOJu0Yy5ZMu32sxqXLSSMZYtpYtEZ17wxabaBvLaVltyh7akegPxrm/3
        ZsUqNli01GCQPNw4KNHileM=
X-Google-Smtp-Source: AGHT+IGY6S/u4wuzGFZWQPzNYC/n7wkXF3frx60bMUjcaNO/YAYotJ4z2zy3bW0cajG5+rTtKldaGA==
X-Received: by 2002:a05:600c:358d:b0:3fe:d46a:ef4b with SMTP id p13-20020a05600c358d00b003fed46aef4bmr2783826wmq.1.1695224425927;
        Wed, 20 Sep 2023 08:40:25 -0700 (PDT)
Received: from ivan-B550MH.domain.name ([178.160.241.68])
        by smtp.gmail.com with ESMTPSA id c26-20020a05600c0ada00b00400268671c6sm2274810wmr.13.2023.09.20.08.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:40:25 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, corbet@lwn.net
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, skhan@linuxfoundation.org
Subject: [PATCH v3 1/2] ALSA: docs: Add MARIAN M2 driver documentation
Date:   Wed, 20 Sep 2023 19:16:09 +0400
Message-Id: <20230920151610.113880-1-ivan.orlov0322@gmail.com>
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

Add documentation for the new MARIAN Seraph M2 driver. MARIAN Seraph M2
is a fully digital PCI soundcard with 2 MADI inputs and outputs.

This patch introduces the documentation for the card driver. It covers
current development status, overview of the card, available controls and
information about the integrated loopback.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Remove redundant documentation fix
V2 -> V3:
- Make the documentation to follow 80-column rule
- Use literal blocks for markup
- Update the documentation correspondingly with the latest driver
changes: remove mHz and detune controls descriptions, remove
'speedmode' control.
- Extend the documentation to cover the card overview.

 Documentation/sound/cards/index.rst     |   1 +
 Documentation/sound/cards/marian-m2.rst | 140 ++++++++++++++++++++++++
 2 files changed, 141 insertions(+)
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
index 000000000000..3c12fe024e37
--- /dev/null
+++ b/Documentation/sound/cards/marian-m2.rst
@@ -0,0 +1,140 @@
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
+This driver is based on the driver written by Florian Faber in 2012, which
+seemed to work fine. However, the initial code contained multiple issues, which
+had to be solved before sending the driver upstream.
+
+The vendor lost the full documentation, so what we have here was recovered from
+drafts and found after experiments with the card.
+
+What seems to be working fine:
+
+ * Playback and capture for all supported rates
+ * MADI output frame mode changing
+ * Input frequency/frame mode measurement
+ * Integrated loopback (with some exceptions, see below)
+
+CARD INFORMATION
+================
+
+The card is fully digital and contains two MADI Inputs and two MADI outputs.
+It has internal clocks, but could be synchronized with clocks on any of its
+inputs. Also it could be synchronized with other MARIAN M2 sound card via
+SyncBus cable.
+
+Outputs support two modes: 56 channel mode and 64 channel mode. The number of
+audio channels will be halved automatically to 28 or 32 depending on the
+sample rate.
+
+The driver currently supports 48 and 96 kHz MADI frame formats for output.
+
+MEMORY MODEL
+============
+
+The hardware requires one huge contiguous DMA space to be allocated. After
+allocation, the bus address of this buffer should be written to the hardware
+register.
+
+We can split this space into two parts: the first one contains samples for
+capture, another one contains play samples::
+
+   CAP_CH_0, CAP_CH_1, ..., CAP_CH_127 | PLAY_CH_0, PLAY_CH_1, ..., PLAY_CH_127
+
+The card supports the non-interleaved access mode only, so samples for each
+channel lay together::
+
+   C0, ..., C0, C1, ..., C1, ..., C127 | C0, ..., C0, C1, ..., C1, ..., C127
+
+The count of samples per each channel buffer needs to be set explicitly, so the
+address of the first byte of the playback data depends on this value.
+The playback buffer starts where the capture buffer ends. It makes the arbitrary
+period count/buffer size feature impossible to implement, and the driver
+supports only 2 periods per buffer.
+
+Controls
+========
+
+ * Input 1 Sync
+
+   - 0 - No signal, 1 - valid MADI signal found, 2 - Synced with MADI signal
+
+ * Input 2 Sync
+
+   - 0 - No signal, 1 - valid MADI signal found, 2 - Synced with MADI signal
+
+ * Input 1 Channel Mode
+
+   - 0 - 56 channels, 1 - 64 channels
+
+ * Input 2 Channel Mode
+
+   - 0 - 56 channels, 1 - 64 channels
+
+ * Input 1 Frame Mode
+
+   - 0 - 48 kHz, 1 - 96 kHz
+
+ * Input 2 Frame Mode
+
+   - 0 - 48 kHz, 1 - 96 kHz
+
+ * Input 1 Frequency
+
+   - Measured frequency on Input 1
+
+ * Input 2 Frequency
+
+   - Measured frequency on Input 2
+
+ * Output 1 Channel Mode
+
+   - 0 - 56 channels, 1 - 64 channels
+
+ * Output 2 Channel Mode
+
+   - 0 - 56 channels, 1 - 64 channels
+
+ * Output 1 Frame Mode
+
+   - 0 - 48 kHz, 1 - 96 kHz
+
+ * Output 2 Frame Mode
+
+   - 0 - 48 kHz, 1 - 96 kHz
+
+ * Clock Source
+
+   - Internal/Sync Bus, Input Port 1, Input Port 2
+
+ * DCO Frequency (Hz)
+
+ * Loopback
+
+   - Enable/Disable integrated loopback
+
+
+Loopback
+========
+
+The card contains integrated loopback. When it is enabled, it sets
+the hardware’s DAW-in memory pointer to the hardware’s DAW-out memory. So, what
+you play is what you record.
+
+You will not observe the effect of channel halving when using the integrated
+loopback, as the data bypasses all DSP functionality in such case.
+
+You can enable the integrated loopback using the corresponding control.
+
+The loopback seems to work well on lower rates (like 28000). However, when the
+rate goes higher, the count of mistakes in recorded byte ordering increases.
-- 
2.34.1

