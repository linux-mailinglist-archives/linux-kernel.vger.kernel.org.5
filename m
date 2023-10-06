Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D077BBC2B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjJFPx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjJFPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:53:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDE79E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:53:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so2197013f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696607635; x=1697212435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+eWlw5uIz8Eo4vzwKnmP5yHTM5CmRYMnf/JNk3fMdpg=;
        b=HMjzW8+0srnB40ykd0WOZGcTBmjSC3SxKyTmBCZp78tnqTt0j7RS3N6N5JpQPOEXV7
         LT0gzeZK+Tdrm8UpZ0hqzAiVkw9/4DUtG4CxJvNWrMLU6jR3QJ+OUsbxqk+oO/B1fGfs
         0zhj45mK/mR2I7BpXP62pKMcUFH5JtTfbrtYbmFPW4jS8YKOFsm4k1jc+Us7YZmwnjiE
         AaXIfDL21JSz4OrSIZ24sY5hypakY3TssoGDkxJYfSa/CZ6u6sl6ynIqL3lnLSZ3J7jm
         CRPWlVxeJohH4nlnkvOzy40DnXnMtKzeU5+KS5Lupj0hjImZHzLXyrrbT3RgBG2pN6FF
         mehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696607635; x=1697212435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+eWlw5uIz8Eo4vzwKnmP5yHTM5CmRYMnf/JNk3fMdpg=;
        b=Mk8BFjsrwhwqFQe9RtIeZVxDrXaiAEfHAlniEM8gjJ2y9Ptx9kbEiJwzzulx6saJoT
         qnSQ0GeuRFfDwAU9ilFQPTdMxvi17NSJKEZK49Pyt8rxIT2YhwqxPc5kdkxtwGsPKw4W
         Zld4vJRvdBTuRWIEj1hNcLVofriNAnnisc3hYUd9HOIWAGGxwYl+QIzpkqJKlgPZa286
         plDhgfpUlm+NDN9oiRGcAbRmojQV58vTrD677dwGsZOGq1y0wpkmPa9OItjowsQ4kB5O
         OuVSzKp43PZA5PdlCMmLdvHNdE6x8qTKO6yanrTjpDxHbMuVhMAds79RMrO+8T3QTZMK
         ABpw==
X-Gm-Message-State: AOJu0Ywua3rV7rdaU4Qw+9FNWi2NMeqpRmSfY7uUGGDBswlv24fFDMxD
        CHEcatbzamf4Jv4ODCQGJKR4kmyiSen6JIZl
X-Google-Smtp-Source: AGHT+IEzqmpVLm6DX3cmD/5369KlBDll3ZM+r9f7CxMQCfCkEhBtCzxZPmg2EoJU9c0th/7TJY5Kyw==
X-Received: by 2002:a5d:4dcc:0:b0:319:785a:fce5 with SMTP id f12-20020a5d4dcc000000b00319785afce5mr7451144wru.38.1696607634800;
        Fri, 06 Oct 2023 08:53:54 -0700 (PDT)
Received: from ubuntu-desk.. ([91.205.106.168])
        by smtp.gmail.com with ESMTPSA id e8-20020adffc48000000b0031f3ad17b2csm1920229wrs.52.2023.10.06.08.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 08:53:54 -0700 (PDT)
From:   Christos Skevis <xristos.thes@gmail.com>
To:     tiwai@suse.com
Cc:     peter.ujfalusi@linux.intel.com, linux-kernel@vger.kernel.org,
        Christos Skevis <xristos.thes@gmail.com>
Subject: [PATCH] ALSA: usb-audio: Fix microphone sound on Nexigo webcam.
Date:   Fri,  6 Oct 2023 17:53:30 +0200
Message-ID: <20231006155330.399393-1-xristos.thes@gmail.com>
X-Mailer: git-send-email 2.42.0
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

I own an external usb Webcam, model NexiGo N930AF, which had low mic volume and
inconsistent sound quality. Video works as expected.

(snip)
[  +0.047857] usb 5-1: new high-speed USB device number 2 using xhci_hcd
[  +0.003406] usb 5-1: New USB device found, idVendor=1bcf, idProduct=2283, bcdDevice=12.17
[  +0.000007] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  +0.000004] usb 5-1: Product: NexiGo N930AF FHD Webcam
[  +0.000003] usb 5-1: Manufacturer: SHENZHEN AONI ELECTRONIC CO., LTD
[  +0.000004] usb 5-1: SerialNumber: 20201217011
[  +0.003900] usb 5-1: Found UVC 1.00 device NexiGo N930AF FHD Webcam (1bcf:2283)
[  +0.025726] usb 5-1: 3:1: cannot get usb sound sample rate freq at ep 0x86
[  +0.071482] usb 5-1: 3:2: cannot get usb sound sample rate freq at ep 0x86
[  +0.004679] usb 5-1: 3:3: cannot get usb sound sample rate freq at ep 0x86
[  +0.051607] usb 5-1: Warning! Unlikely big volume range (=4096), cval->res is probably wrong.
[  +0.000005] usb 5-1: [7] FU [Mic Capture Volume] ch = 1, val = 0/4096/1

Set up quirk cval->res to 16 for 256 levels,
Set GET_SAMPLE_RATE quirk flag to stop trying to get the sample rate.
Confirmed that happened anyway later due to the backoff mechanism, after 3 failures

All audio stream on device interfaces share the same values,
apart from wMaxPacketSize and tSamFreq :

(snip)
Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       3
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              0
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           8
        bDelay                  1 frames
        wFormatTag         0x0001 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        44100
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x005c  1x 92 bytes
        bInterval               4
        bRefresh                0
        bSynchAddress           0
        AudioStreaming Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay         0x0000
(snip)

Based on the usb data about manufacturer, SPCA2281B3 is the most likely controller IC
Manufacturer does not provide link for datasheet nor detailed specs.
No way to confirm if the firmware supports any other way of getting the sample rate.

Testing patch provides consistent good sound recording quality and volume range.

(snip)
[  +0.045764] usb 5-1: new high-speed USB device number 2 using xhci_hcd
[  +0.106290] usb 5-1: New USB device found, idVendor=1bcf, idProduct=2283, bcdDevice=12.17
[  +0.000006] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  +0.000004] usb 5-1: Product: NexiGo N930AF FHD Webcam
[  +0.000003] usb 5-1: Manufacturer: SHENZHEN AONI ELECTRONIC CO., LTD
[  +0.000004] usb 5-1: SerialNumber: 20201217011
[  +0.043700] usb 5-1: set resolution quirk: cval->res = 16
[  +0.002585] usb 5-1: Found UVC 1.00 device NexiGo N930AF FHD Webcam (1bcf:2283)

Signed-off-by: Christos Skevis <xristos.thes@gmail.com>
---
 sound/usb/mixer.c  | 7 +++++++
 sound/usb/quirks.c | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 985b1aea9cdc..409fc1164694 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1204,6 +1204,13 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 			cval->res = 16;
 		}
 		break;
+	case USB_ID(0x1bcf, 0x2283): /* NexiGo N930AF FHD Webcam */
+		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
+			usb_audio_info(chip,
+				"set resolution quirk: cval->res = 16\n");
+			cval->res = 16;
+		}
+		break;
 	}
 }
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index d4bbef70d2f7..4e64842245e1 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2177,6 +2177,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
+	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 
 	/* Vendor matches */
 	VENDOR_FLG(0x045e, /* MS Lifecam */
-- 
2.37.1

