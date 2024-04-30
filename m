Return-Path: <linux-kernel+bounces-164496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6758B7E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6771C230C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82DF17BB08;
	Tue, 30 Apr 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhSZy7db"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C83127E25;
	Tue, 30 Apr 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497032; cv=none; b=XRXy+vXboa3DhT5dW63MiTVoCiOnAAjcRb/uZnNex89u5TDnfADc5P+U2VEBpykSzavTNqTpRe6fRZHKrsK6qkQ0fpGxO6aGFGqfaYRUriyhgF3+Ht1J5b6bocOYpbx+6Cfv8bTsFNPzNLloT7VNX+dDRl0M5akwp2hpCAZbOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497032; c=relaxed/simple;
	bh=kiFeRvgm1GUqZrPzGzDk2qBEMMDhQdW6bA+PMgeiq1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IudIN9iW4sv06LvjjMFOyvA9BG6I/i0IifuYQKIr4BIHKEhu0xvhXtQPgts5qJMLLTcmDT2+msBDTC2eDUUr25lXqmKG3JRCignY4ZymVR21OUL+Eek3TaCb66GWR7SHVKo0bk7z8LIc+S+vhw1d8m4YHfWxCvKIJOR0BRrH024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhSZy7db; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f30f69a958so5166106b3a.1;
        Tue, 30 Apr 2024 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714497030; x=1715101830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCEBGy0iqEEScOu2GTcPLub3TdVLK2F9Tv6HBrxW28M=;
        b=LhSZy7dbTHpV4lwNvPwArlB6TUObqaRc1q2BIIegHNcZ6135P0wG16s6c5WwQfPFTE
         1de0u4R8Zq+TvF14i2RUJwovL7pxTgww/8J9pCyhGSOZIFR1Px79+8pe//18mGz06pqV
         wNXaWIjNrvYRP04iuSGJ8V9lKj7bbbLVwUACTkfzNJHrKsH0MJAMbnjgQuLnEAbnon07
         dgzhx1AIfVftw1rWW6lNfvyrGY7muMkux/s6nJ+rgQ8pYW4YL05D8kGNFS8nrpw4fE7g
         qehcclmVIAyRvaS7UX2Dgul80FMjtGlLF0+LrWauViTYW4xxKGua8xqjuzDv8RyV4dF2
         7TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714497030; x=1715101830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCEBGy0iqEEScOu2GTcPLub3TdVLK2F9Tv6HBrxW28M=;
        b=AlzPT5815NZejHDBhwMmMmhUzaYxNX13YhK7SBRORmlY+A7xZkBmtZQTgKmEhnBVbm
         QJPIm2fUjjhcdX9r4+F8RZrhoHRqWaZwm+YzfochN5k8Jn+7RswG9Z681ZxUhDwCXyL+
         cDbg4ifVcc6Qv8izNtEArgu0z6X2Xhs7OjCs2JJU7YjQmzbVNQKHfBrkAUULFpqUL5E9
         GVAKFF92RIZYGcn+UrNi6fagoANaZ7k8NjPEWybXpfv1ri4E6nUETmp0dceSrI8Shiu5
         enwu/jX3dHB9mUdrrTIRrR5u84eEb5pcaGfXM3EmXCpKEnlZYeyIGPgkFORqtFBaM56H
         yrwA==
X-Forwarded-Encrypted: i=1; AJvYcCUnbsRJNqKfAB4UMKBOYAPdMIQljttCKWVc+uPlfUiaP4imn88Fz2tvtliszl29v+o/UBImbo6Aedcv6+Ig/wOc5Ghrf7tAjFehSvCx3d9+sWiMvHxGLeMh5g2S7hi8RWY/v0I/IWpLbno=
X-Gm-Message-State: AOJu0YxTMWKfYxyqYhv+MJFSY2HEou/eym5Gx4JGh9sRavPIlVp7EfEp
	YcYWUxBgxDSqjJsDRTXLJGwuDd/n3VO5Pg9fUBg7/zJFGeFgRb5B
X-Google-Smtp-Source: AGHT+IHMAVG0EWpQPuldpw9z2FO7NqH5u2MC/9Up//burvX3f4HqsG2eIM4ldekstXAdQJLqalFRug==
X-Received: by 2002:a05:6a20:3254:b0:1ad:12fe:103a with SMTP id hm20-20020a056a20325400b001ad12fe103amr443722pzc.23.1714497029594;
        Tue, 30 Apr 2024 10:10:29 -0700 (PDT)
Received: from thought.. ([186.139.89.143])
        by smtp.gmail.com with ESMTPSA id a8-20020a62bd08000000b006ea81423c65sm22028956pff.148.2024.04.30.10.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 10:10:29 -0700 (PDT)
From: Manuel Barrio Linares <mbarriolinares@gmail.com>
To: alsa-devel@alsa-project.org
Cc: Manuel Barrio Linares <mbarriolinares@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] ALSA: usb-audio: Add sampling rates support for Mbox3
Date: Tue, 30 Apr 2024 14:10:18 -0300
Message-ID: <20240430171020.192285-1-mbarriolinares@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <87cyq7nw19.wl-tiwai@suse.de>
References: <87cyq7nw19.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for all sample rates supported by the
hardware,Digidesign Mbox 3 supports: {44100, 48000, 88200, 96000}

Fixes syncing clock issues that presented as pops. To test this, without
this patch playing 440hz tone produces pops.

Clock is now synced between playback and capture interfaces so no more
latency drift issue when using pipewire pro-profile.
(https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3900)

Signed-off-by: Manuel Barrio Linares <mbarriolinares@gmail.com>
---
v2: Cleaned up code. Explicit __le32 usage.
v3: Get rid of sparse warnings

 sound/usb/quirks-table.h | 38 +++++++++++++--------
 sound/usb/quirks.c       | 74 +++++++++++++++++++++++++++++++---------
 2 files changed, 81 insertions(+), 31 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 5d72dc8..73abc38 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3013,21 +3013,28 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.fmt_bits = 24,
 					.channels = 4,
 					.iface = 2,
 					.altsetting = 1,
 					.altset_idx = 1,
 					.attributes = 0x00,
-					.endpoint = 0x01,
+					.endpoint = USB_RECIP_INTERFACE | USB_DIR_OUT,
 					.ep_attr = USB_ENDPOINT_XFER_ISOC |
 						USB_ENDPOINT_SYNC_ASYNC,
-					.rates = SNDRV_PCM_RATE_48000,
-					.rate_min = 48000,
-					.rate_max = 48000,
-					.nr_rates = 1,
+					.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+							SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 4,
 					.rate_table = (unsigned int[]) {
-						48000
-					}
+						44100, 48000, 88200, 96000
+					},
+					.sync_ep = USB_RECIP_INTERFACE | USB_DIR_IN,
+					.sync_iface = 3,
+					.sync_altsetting = 1,
+					.sync_ep_idx = 1,
+					.implicit_fb = 1,
 				}
 			},
 			{
@@ -3035,22 +3042,25 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.fmt_bits = 24,
 					.channels = 4,
 					.iface = 3,
 					.altsetting = 1,
 					.altset_idx = 1,
-					.endpoint = 0x81,
 					.attributes = 0x00,
+					.endpoint = USB_RECIP_INTERFACE | USB_DIR_IN,
 					.ep_attr = USB_ENDPOINT_XFER_ISOC |
 						USB_ENDPOINT_SYNC_ASYNC,
 					.maxpacksize = 0x009c,
-					.rates = SNDRV_PCM_RATE_48000,
-					.rate_min = 48000,
-					.rate_max = 48000,
-					.nr_rates = 1,
+					.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+							SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 4,
 					.rate_table = (unsigned int[]) {
-						48000
-					}
+						44100, 48000, 88200, 96000
+					},
+					.implicit_fb = 0,
 				}
 			},
 			{
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 09712e6..2f961f0 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -984,21 +984,13 @@ static int snd_usb_axefx3_boot_quirk(struct usb_device *dev)
 	return 0;
 }
 
-static void mbox3_setup_48_24_magic(struct usb_device *dev)
+static void mbox3_setup_defaults(struct usb_device *dev)
 {
 	/* The Mbox 3 is "little endian" */
 	/* max volume is: 0x0000. */
 	/* min volume is: 0x0080 (shown in little endian form) */
 
-
-	/* Load 48000Hz rate into buffer */
-	u8 com_buff[4] = {0x80, 0xbb, 0x00, 0x00};
-
-	/* Set 48000Hz sample rate */
-	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
-			0x01, 0x21, 0x0100, 0x0001, &com_buff, 4);  //Is this really needed?
-	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
-			0x01, 0x21, 0x0100, 0x8101, &com_buff, 4);
+	u8 com_buff[2];
 
 	/* Deactivate Tuner */
 	/* on  = 0x01*/
@@ -1008,6 +1000,8 @@ static void mbox3_setup_48_24_magic(struct usb_device *dev)
 		0x01, 0x21, 0x0003, 0x2001, &com_buff, 1);
 
 	/* Set clock source to Internal (as opposed to S/PDIF) */
+	/* Internal  = 0x01*/
+	/* S/PDIF    = 0x02*/
 	com_buff[0] = 0x01;
 	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
 			1, 0x21, 0x0100, 0x8001, &com_buff, 1);
@@ -1113,9 +1107,11 @@ static void mbox3_setup_48_24_magic(struct usb_device *dev)
 			1, 0x21, 0x0107, 0x4201, &com_buff, 2);
 
 	/* Toggle allowing host control */
+	/* Not needed
 	com_buff[0] = 0x02;
 	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
 			3, 0x21, 0x0000, 0x2001, &com_buff, 1);
+	 */
 
 	/* Do not dim fx returns */
 	com_buff[0] = 0x00;
@@ -1259,26 +1255,27 @@ static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
 	descriptor_size = le16_to_cpu(get_cfg_desc(config)->wTotalLength);
 
 	if (descriptor_size != MBOX3_DESCRIPTOR_SIZE) {
-		dev_err(&dev->dev, "Invalid descriptor size=%d.\n", descriptor_size);
+		dev_err(&dev->dev, "MBOX3: Invalid descriptor size=%d.\n", descriptor_size);
 		return -ENODEV;
 	}
 
-	dev_dbg(&dev->dev, "device initialised!\n");
+	dev_dbg(&dev->dev, "MBOX3: device initialised!\n");
 
 	err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
 		&dev->descriptor, sizeof(dev->descriptor));
 	config = dev->actconfig;
 	if (err < 0)
-		dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
+		dev_dbg(&dev->dev, "MBOX3: error usb_get_descriptor: %d\n", err);
 
 	err = usb_reset_configuration(dev);
 	if (err < 0)
-		dev_dbg(&dev->dev, "error usb_reset_configuration: %d\n", err);
-	dev_dbg(&dev->dev, "mbox3_boot: new boot length = %d\n",
+		dev_dbg(&dev->dev, "MBOX3: error usb_reset_configuration: %d\n", err);
+
+	dev_dbg(&dev->dev, "MBOX3: new boot length = %d\n",
 		le16_to_cpu(get_cfg_desc(config)->wTotalLength));
 
-	mbox3_setup_48_24_magic(dev);
-	dev_info(&dev->dev, "Digidesign Mbox 3: 24bit 48kHz");
+	mbox3_setup_defaults(dev);
+	dev_info(&dev->dev, "MBOX3: Initialized.");
 
 	return 0; /* Successful boot */
 }
@@ -1734,6 +1731,46 @@ static int pioneer_djm_set_format_quirk(struct snd_usb_substream *subs,
 	return 0;
 }
 
+static void mbox3_set_format_quirk(struct snd_usb_substream *subs,
+				const struct audioformat *fmt)
+{
+	__le32 buff4 = 0;
+	u8 buff1 = 0x01;
+	u32 new_rate = subs->data_endpoint->cur_rate;
+	u32 current_rate;
+
+	// Get current rate from card and check if changing it is needed
+	snd_usb_ctl_msg(subs->dev, usb_sndctrlpipe(subs->dev, 0),
+					0x01, 0x21 | USB_DIR_IN, 0x0100, 0x8101, &buff4, 4);
+	current_rate = le32_to_cpu(buff4);
+	dev_dbg(&subs->dev->dev,
+			 "MBOX3: Current configured sample rate: %d", current_rate);
+	if (current_rate == new_rate) {
+		dev_dbg(&subs->dev->dev,
+			"MBOX3: No change needed (current rate:%d == new rate:%d)",
+			current_rate, new_rate);
+		return;
+	}
+
+	// Set new rate
+	dev_info(&subs->dev->dev,
+			 "MBOX3: Changing sample rate to: %d", new_rate);
+	buff4 = cpu_to_le32(new_rate);
+	snd_usb_ctl_msg(subs->dev, usb_sndctrlpipe(subs->dev, 0),
+					0x01, 0x21, 0x0100, 0x8101, &buff4, 4);
+
+	// Set clock source to Internal
+	snd_usb_ctl_msg(subs->dev, usb_sndctrlpipe(subs->dev, 0),
+					0x01, 0x21, 0x0100, 0x8001, &buff1, 1);
+
+	// Check whether the change was successful
+	buff4 = 0;
+	snd_usb_ctl_msg(subs->dev, usb_sndctrlpipe(subs->dev, 0),
+					0x01, 0x21 | USB_DIR_IN, 0x0100, 0x8101, &buff4, 4);
+	if (new_rate != le32_to_cpu(buff4))
+		dev_warn(&subs->dev->dev, "MBOX3: Couldn't set the sample rate");
+}
+
 void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 			      const struct audioformat *fmt)
 {
@@ -1755,6 +1792,9 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 	case USB_ID(0x08e4, 0x0163): /* Pioneer DJM-850 */
 		pioneer_djm_set_format_quirk(subs, 0x0086);
 		break;
+	case USB_ID(0x0dba, 0x5000):
+		mbox3_set_format_quirk(subs, fmt); /* Digidesign Mbox 3 */
+		break;
 	}
 }
 
-- 
2.45.0


