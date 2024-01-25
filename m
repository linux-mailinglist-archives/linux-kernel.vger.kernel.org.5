Return-Path: <linux-kernel+bounces-39366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B6D83CF7E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA37B27654
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1F2175B9;
	Thu, 25 Jan 2024 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdqVTOAO"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509211CBE;
	Thu, 25 Jan 2024 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222140; cv=none; b=DhOmfK2zb0I2kbKePJ+6trXgkKmGyZberFvscra3uCONyLHLOPTAYdGjlrj2C/CXx6rPjEpheDruXsqHUjqvCxLTNW6+Sx+qbF9Fck/IUS4jiqzr4KeXLQLFlw+ozTiHv2+cu8N1rKk4wgGJzotVYW7fN1J79cn4Y+JSTcLdpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222140; c=relaxed/simple;
	bh=iaENUkdckDjvCHndexFHmGTDmatDhxYTmV6H30IpC0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DKBBc13F1R6GAO9lo4MHZVU5ui7lsJUc+LDopS85Cbh0UgjMAhmDi8EZ8Y5t3EdH+FIdNlpQ+67zKbxCtczcDZ8Ltd2iI/Leu8vuYKqqe5brtsecOIQ4ugzlwrx4NvmfX7Q64yvW7RoQu5mWNx0Wd8R5bBAolo+o1wB19V2d4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdqVTOAO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e60d74b81so10175695e9.1;
        Thu, 25 Jan 2024 14:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706222134; x=1706826934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVWS0jwQOTHPni8BkOdPMXu3CZySiGKR8/ARwF2iZME=;
        b=OdqVTOAOdS3rjs6vA6hEzxxtMQEn6aKBMy7X56QEqYwW7vp+S78YbGhZgMvX/AofVM
         gU+RBdCZkLiffzr54UYfyC1SrNxDDc9O+i3NZ+A4ttWt+u/11yNu8bl7b/Zhk+TPDdWH
         KtmLw9J2TQZ/n1933MyeIiWSinRaOcYOgKIUZuyf1bqt1JHZkVLD5OS8soevg71GclqR
         Eriyz+78QejA/AOKE8cjXlngnAsnCj9uUw4rcgh5VzWzL9T4lMUwxoV8A4hd2jwbyP20
         AvRrJ2zpdYbooCLV/3+UzViJ2/ofSeo5gVdbaGL7/EaOQhWpOkksp9gX1yIEMKZwxoSo
         al5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706222134; x=1706826934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVWS0jwQOTHPni8BkOdPMXu3CZySiGKR8/ARwF2iZME=;
        b=KbT7mD14F/qvn1px80DLJkM26DHQmnoIa5RTCFCbMIRqxMKhQPae7hXFJ6v27HE76t
         qDePjG3lmTfUSEgpyhbkBljMt+GFjRJjLQfoHBfGDU/etnIu+0/9RnMpTfuFNN8MXBRy
         adZng/0dr6h0sADXGoA0LjUOWq30Kvoy8FlTfby1hCW/V74JGQ0CYhNG/6AWBBuzgQJM
         g6yDPKvq77QRt/JESd5UQ/EszXMa6+qyeigeaLLfQMTv3ass4Gmz0q47LOrvQ9fKnYEc
         UjzEhTEPyMO9/MX6+aX/9rhAT/8f5wxq/DjHTFmbvBM9nrof7QiMSvzC2L606zKj2v47
         28Qw==
X-Gm-Message-State: AOJu0YxorwmiZjSrkPtY1IhisUSJdG6zaDefbBInOYXf2+pszYG+DGuI
	xSNr2bfI3H9m4O8uiPzYkAla36p4OJNAiHiiNqAFoKT3vZjRJDjV0GrVIH60
X-Google-Smtp-Source: AGHT+IGhYdADvTN9PdF55Ze0bpbKRz4o0qWNI98fdmcK5xLpLb3w+AXQrpYhnm8FaAwUw/s0t4r1ew==
X-Received: by 2002:a05:600c:1ca0:b0:40e:c217:7cb with SMTP id k32-20020a05600c1ca000b0040ec21707cbmr545064wms.4.1706222133616;
        Thu, 25 Jan 2024 14:35:33 -0800 (PST)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:9829:5527:ea0f:1fac])
        by smtp.gmail.com with ESMTPSA id b19-20020a05600c4e1300b0040d8d11bf63sm40012wmq.41.2024.01.25.14.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:35:33 -0800 (PST)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ALSA: core: Add sound core KUnit test
Date: Thu, 25 Jan 2024 22:35:21 +0000
Message-Id: <20240125223522.1122765-3-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125223522.1122765-1-ivan.orlov0322@gmail.com>
References: <20240125223522.1122765-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the moment, we have a decent amount of integration tests (selftests)
covering different aspects of the sound subsystem. However, a lot of
of sound-related in-kernel functions remains uncovered. This patch
introduces the KUnit test for the core part of the sound subsystem.
It includes 10 test cases:

- Coverage of the format-related inline functions from 'pcm.h' header
file: snd_pcm_format_physical_width, snd_pcm_format_width,
snd_pcm_format_signed, test_format_endianness

- Coverage of the available bytes counting functions from 'pcm.h'
header: snd_pcm_capture_avail, snd_pcm_playback_avail

- Coverage of functions from pcm_misc: snd_pcm_format_set_silence,
snd_pcm_format_name

- Coverage of card-related functions from init.c: snd_card_set_id,
snd_component_add

This patch depends on the previous patches in this patch series as they
contain fix for the bug, which was found during the test development.
Without them, the test doesn't pass.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 MAINTAINERS              |   6 +
 sound/core/Kconfig       |  16 ++
 sound/core/Makefile      |   2 +
 sound/core/sound_kunit.c | 310 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 334 insertions(+)
 create mode 100644 sound/core/sound_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 39219b144c23..40b79daad32b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20485,6 +20485,12 @@ F:	include/uapi/sound/compress_*
 F:	sound/core/compress_offload.c
 F:	sound/soc/soc-compress.c
 
+SOUND - CORE KUNIT TEST
+M:	Ivan Orlov <ivan.orlov0322@gmail.com>
+L:	linux-sound@vger.kernel.org
+S:	Supported
+F:	sound/core/sound_kunit.c
+
 SOUND - DMAENGINE HELPERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 S:	Supported
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index e41818e59a15..664c6ee2b5a1 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -39,6 +39,22 @@ config SND_UMP_LEGACY_RAWMIDI
 	  legacy MIDI 1.0 byte streams is created for each UMP Endpoint.
 	  The device contains 16 substreams corresponding to UMP groups.
 
+config SND_CORE_TEST
+	tristate "Sound core KUnit test"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This options enables the sound core functions KUnit test.
+
+	  KUnit tests run during boot and output the results to the debug
+	  log in TAP format (https://testanything.org/). Only useful for
+	  kernel devs running KUnit test harness and are not for inclusion
+	  into a production build.
+
+	  For more information on KUnit and unit tests in general, refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+
 config SND_COMPRESS_OFFLOAD
 	tristate
 
diff --git a/sound/core/Makefile b/sound/core/Makefile
index a6b444ee2832..1d34e6950317 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -49,6 +49,8 @@ obj-$(CONFIG_SND_SEQ_DEVICE)	+= snd-seq-device.o
 obj-$(CONFIG_SND_RAWMIDI)	+= snd-rawmidi.o
 obj-$(CONFIG_SND_UMP)		+= snd-ump.o
 
+obj-$(CONFIG_SND_CORE_TEST)	+= sound_kunit.o
+
 obj-$(CONFIG_SND_OSSEMUL)	+= oss/
 obj-$(CONFIG_SND_SEQUENCER)	+= seq/
 
diff --git a/sound/core/sound_kunit.c b/sound/core/sound_kunit.c
new file mode 100644
index 000000000000..5d5a7bf88de4
--- /dev/null
+++ b/sound/core/sound_kunit.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Sound core KUnit test
+ * Author: Ivan Orlov <ivan.orlov0322@gmail.com>
+ */
+
+#include <kunit/test.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+
+#define SILENCE_BUFFER_SIZE 2048
+#define SILENCE(...) { __VA_ARGS__ }
+#define DEFINE_FORMAT(fmt, pbits, wd, endianness, signd, silence_arr) {		\
+	.format = SNDRV_PCM_FORMAT_##fmt, .physical_bits = pbits,		\
+	.width = wd, .le = endianness, .sd = signd, .silence = silence_arr,	\
+	.name = #fmt,								\
+}
+
+#define WRONG_FORMAT (SNDRV_PCM_FORMAT_LAST + 1)
+
+#define VALID_NAME "ValidName"
+#define NAME_W_SPEC_CHARS "In%v@1id name"
+#define NAME_W_SPACE "Test name"
+#define NAME_W_SPACE_REMOVED "Testname"
+
+#define TEST_FIRST_COMPONENT "Component1"
+#define TEST_SECOND_COMPONENT "Component2"
+
+struct snd_format_test_data {
+	snd_pcm_format_t format;
+	int physical_bits;
+	int width;
+	int le;
+	int sd;
+	unsigned char silence[8];
+	unsigned char *name;
+};
+
+struct avail_test_data {
+	snd_pcm_uframes_t buffer_size;
+	snd_pcm_uframes_t hw_ptr;
+	snd_pcm_uframes_t appl_ptr;
+	snd_pcm_uframes_t expected_avail;
+};
+
+static struct snd_format_test_data valid_fmt[] = {
+	DEFINE_FORMAT(S8, 8, 8, -1, 1, SILENCE()),
+	DEFINE_FORMAT(U8, 8, 8, -1, 0, SILENCE(0x80)),
+	DEFINE_FORMAT(S16_LE, 16, 16, 1, 1, SILENCE()),
+	DEFINE_FORMAT(S16_BE, 16, 16, 0, 1, SILENCE()),
+	DEFINE_FORMAT(U16_LE, 16, 16, 1, 0, SILENCE(0x00, 0x80)),
+	DEFINE_FORMAT(U16_BE, 16, 16, 0, 0, SILENCE(0x80, 0x00)),
+	DEFINE_FORMAT(S24_LE, 32, 24, 1, 1, SILENCE()),
+	DEFINE_FORMAT(S24_BE, 32, 24, 0, 1, SILENCE()),
+	DEFINE_FORMAT(U24_LE, 32, 24, 1, 0, SILENCE(0x00, 0x00, 0x80)),
+	DEFINE_FORMAT(U24_BE, 32, 24, 0, 0, SILENCE(0x00, 0x80, 0x00, 0x00)),
+	DEFINE_FORMAT(S32_LE, 32, 32, 1, 1, SILENCE()),
+	DEFINE_FORMAT(S32_BE, 32, 32, 0, 1, SILENCE()),
+	DEFINE_FORMAT(U32_LE, 32, 32, 1, 0, SILENCE(0x00, 0x00, 0x00, 0x80)),
+	DEFINE_FORMAT(U32_BE, 32, 32, 0, 0, SILENCE(0x80, 0x00, 0x00, 0x00)),
+	DEFINE_FORMAT(FLOAT_LE, 32, 32, 1, -1, SILENCE()),
+	DEFINE_FORMAT(FLOAT_BE, 32, 32, 0, -1, SILENCE()),
+	DEFINE_FORMAT(FLOAT64_LE, 64, 64, 1, -1, SILENCE()),
+	DEFINE_FORMAT(FLOAT64_BE, 64, 64, 0, -1, SILENCE()),
+	DEFINE_FORMAT(IEC958_SUBFRAME_LE, 32, 32, 1, -1, SILENCE()),
+	DEFINE_FORMAT(IEC958_SUBFRAME_BE, 32, 32, 0, -1, SILENCE()),
+	DEFINE_FORMAT(MU_LAW, 8, 8, -1, -1, SILENCE(0x7f)),
+	DEFINE_FORMAT(A_LAW, 8, 8, -1, -1, SILENCE(0x55)),
+	DEFINE_FORMAT(IMA_ADPCM, 4, 4, -1, -1, SILENCE()),
+	DEFINE_FORMAT(G723_24, 3, 3, -1, -1, SILENCE()),
+	DEFINE_FORMAT(G723_40, 5, 5, -1, -1, SILENCE()),
+	DEFINE_FORMAT(DSD_U8, 8, 8, 1, 0, SILENCE(0x69)),
+	DEFINE_FORMAT(DSD_U16_LE, 16, 16, 1, 0, SILENCE(0x69, 0x69)),
+	DEFINE_FORMAT(DSD_U32_LE, 32, 32, 1, 0, SILENCE(0x69, 0x69, 0x69, 0x69)),
+	DEFINE_FORMAT(DSD_U16_BE, 16, 16, 0, 0, SILENCE(0x69, 0x69)),
+	DEFINE_FORMAT(DSD_U32_BE, 32, 32, 0, 0, SILENCE(0x69, 0x69, 0x69, 0x69)),
+	DEFINE_FORMAT(S20_LE, 32, 20, 1, 1, SILENCE()),
+	DEFINE_FORMAT(S20_BE, 32, 20, 0, 1, SILENCE()),
+	DEFINE_FORMAT(U20_LE, 32, 20, 1, 0, SILENCE(0x00, 0x00, 0x08, 0x00)),
+	DEFINE_FORMAT(U20_BE, 32, 20, 0, 0, SILENCE(0x00, 0x08, 0x00, 0x00)),
+	DEFINE_FORMAT(S24_3LE, 24, 24, 1, 1, SILENCE()),
+	DEFINE_FORMAT(S24_3BE, 24, 24, 0, 1, SILENCE()),
+	DEFINE_FORMAT(U24_3LE, 24, 24, 1, 0, SILENCE(0x00, 0x00, 0x80)),
+	DEFINE_FORMAT(U24_3BE, 24, 24, 0, 0, SILENCE(0x80, 0x00, 0x00)),
+	DEFINE_FORMAT(S20_3LE, 24, 20, 1, 1, SILENCE()),
+	DEFINE_FORMAT(S20_3BE, 24, 20, 0, 1, SILENCE()),
+	DEFINE_FORMAT(U20_3LE, 24, 20, 1, 0, SILENCE(0x00, 0x00, 0x08)),
+	DEFINE_FORMAT(U20_3BE, 24, 20, 0, 0, SILENCE(0x08, 0x00, 0x00)),
+	DEFINE_FORMAT(S18_3LE, 24, 18, 1, 1, SILENCE()),
+	DEFINE_FORMAT(S18_3BE, 24, 18, 0, 1, SILENCE()),
+	DEFINE_FORMAT(U18_3LE, 24, 18, 1, 0, SILENCE(0x00, 0x00, 0x02)),
+	DEFINE_FORMAT(U18_3BE, 24, 18, 0, 0, SILENCE(0x02, 0x00, 0x00)),
+	DEFINE_FORMAT(G723_24_1B, 8, 3, -1, -1, SILENCE()),
+	DEFINE_FORMAT(G723_40_1B, 8, 5, -1, -1, SILENCE()),
+};
+
+static void test_phys_format_size(struct kunit *test)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(valid_fmt); i++) {
+		KUNIT_EXPECT_EQ(test, snd_pcm_format_physical_width(valid_fmt[i].format),
+				valid_fmt[i].physical_bits);
+	}
+
+	KUNIT_EXPECT_EQ(test, snd_pcm_format_physical_width(WRONG_FORMAT), -EINVAL);
+	KUNIT_EXPECT_EQ(test, snd_pcm_format_physical_width(-1), -EINVAL);
+}
+
+static void test_format_width(struct kunit *test)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(valid_fmt); i++) {
+		KUNIT_EXPECT_EQ(test, snd_pcm_format_width(valid_fmt[i].format),
+				valid_fmt[i].width);
+	}
+
+	KUNIT_EXPECT_EQ(test, snd_pcm_format_width(WRONG_FORMAT), -EINVAL);
+	KUNIT_EXPECT_EQ(test, snd_pcm_format_width(-1), -EINVAL);
+}
+
+static void test_format_signed(struct kunit *test)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(valid_fmt); i++) {
+		KUNIT_EXPECT_EQ(test, snd_pcm_format_signed(valid_fmt[i].format),
+				valid_fmt[i].sd < 0 ? -EINVAL : valid_fmt[i].sd);
+		KUNIT_EXPECT_EQ(test, snd_pcm_format_unsigned(valid_fmt[i].format),
+				valid_fmt[i].sd < 0 ? -EINVAL : 1 - valid_fmt[i].sd);
+	}
+
+	KUNIT_EXPECT_EQ(test, snd_pcm_format_width(WRONG_FORMAT), -EINVAL);
+	KUNIT_EXPECT_EQ(test, snd_pcm_format_width(-1), -EINVAL);
+}
+
+static void test_format_endianness(struct kunit *test)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(valid_fmt); i++) {
+		KUNIT_EXPECT_EQ(test, snd_pcm_format_little_endian(valid_fmt[i].format),
+				valid_fmt[i].le < 0 ? -EINVAL : valid_fmt[i].le);
+		KUNIT_EXPECT_EQ(test, snd_pcm_format_big_endian(valid_fmt[i].format),
+				valid_fmt[i].le < 0 ? -EINVAL : 1 - valid_fmt[i].le);
+	}
+
+	KUNIT_EXPECT_EQ(test, snd_pcm_format_little_endian(WRONG_FORMAT), -EINVAL);
+	KUNIT_EXPECT_EQ(test, snd_pcm_format_little_endian(-1), -EINVAL);
+	KUNIT_EXPECT_EQ(test, snd_pcm_format_big_endian(WRONG_FORMAT), -EINVAL);
+	KUNIT_EXPECT_EQ(test, snd_pcm_format_big_endian(-1), -EINVAL);
+}
+
+static void _test_fill_silence(struct kunit *test, struct snd_format_test_data *data,
+			       u8 *buffer, size_t samples_count)
+{
+	size_t sample_bytes = data->physical_bits >> 3;
+	u32 i;
+
+	KUNIT_ASSERT_EQ(test, snd_pcm_format_set_silence(data->format, buffer, samples_count), 0);
+	for (i = 0; i < samples_count * sample_bytes; i++)
+		KUNIT_EXPECT_EQ(test, buffer[i], data->silence[i % sample_bytes]);
+}
+
+static void test_format_fill_silence(struct kunit *test)
+{
+	u32 buf_samples[] = { 10, 20, 32, 64, 129, 260 };
+	u8 *buffer;
+	u32 i, j;
+
+	buffer = kunit_kzalloc(test, SILENCE_BUFFER_SIZE, GFP_KERNEL);
+
+	for (i = 0; i < ARRAY_SIZE(buf_samples); i++) {
+		for (j = 0; j < ARRAY_SIZE(valid_fmt); j++)
+			_test_fill_silence(test, &valid_fmt[j], buffer, buf_samples[i]);
+	}
+
+	KUNIT_EXPECT_EQ(test, snd_pcm_format_set_silence(WRONG_FORMAT, buffer, 20), -EINVAL);
+	KUNIT_EXPECT_EQ(test, snd_pcm_format_set_silence(SNDRV_PCM_FORMAT_LAST, buffer, 0), 0);
+}
+
+static snd_pcm_uframes_t calculate_boundary(snd_pcm_uframes_t buffer_size)
+{
+	snd_pcm_uframes_t boundary = buffer_size;
+
+	while (boundary * 2 <= 0x7fffffffUL - buffer_size)
+		boundary *= 2;
+	return boundary;
+}
+
+static struct avail_test_data p_avail_data[] = {
+	/* buf_size + hw_ptr < appl_ptr => avail = buf_size + hw_ptr - appl_ptr + boundary */
+	{ 128, 1000, 1129, 1073741824UL - 1 },
+	/*
+	 * buf_size + hw_ptr - appl_ptr >= boundary =>
+	 * => avail = buf_size + hw_ptr - appl_ptr - boundary
+	 */
+	{ 128, 1073741824UL, 10, 118 },
+	/* standard case: avail = buf_size + hw_ptr - appl_ptr */
+	{ 128, 1000, 1001, 127 },
+};
+
+static void test_playback_avail(struct kunit *test)
+{
+	struct snd_pcm_runtime *r = kunit_kzalloc(test, sizeof(*r), GFP_KERNEL);
+	u32 i;
+
+	r->status = kunit_kzalloc(test, sizeof(*r->status), GFP_KERNEL);
+	r->control = kunit_kzalloc(test, sizeof(*r->control), GFP_KERNEL);
+
+	for (i = 0; i < ARRAY_SIZE(p_avail_data); i++) {
+		r->buffer_size = p_avail_data[i].buffer_size;
+		r->boundary = calculate_boundary(r->buffer_size);
+		r->status->hw_ptr = p_avail_data[i].hw_ptr;
+		r->control->appl_ptr = p_avail_data[i].appl_ptr;
+		KUNIT_EXPECT_EQ(test, snd_pcm_playback_avail(r), p_avail_data[i].expected_avail);
+	}
+}
+
+static struct avail_test_data c_avail_data[] = {
+	/* hw_ptr - appl_ptr < 0 => avail = hw_ptr - appl_ptr + boundary */
+	{ 128, 1000, 1001, 1073741824UL - 1 },
+	/* standard case: avail = hw_ptr - appl_ptr */
+	{ 128, 1001, 1000, 1 },
+};
+
+static void test_capture_avail(struct kunit *test)
+{
+	struct snd_pcm_runtime *r = kunit_kzalloc(test, sizeof(*r), GFP_KERNEL);
+	u32 i;
+
+	r->status = kunit_kzalloc(test, sizeof(*r->status), GFP_KERNEL);
+	r->control = kunit_kzalloc(test, sizeof(*r->control), GFP_KERNEL);
+
+	for (i = 0; i < ARRAY_SIZE(c_avail_data); i++) {
+		r->buffer_size = c_avail_data[i].buffer_size;
+		r->boundary = calculate_boundary(r->buffer_size);
+		r->status->hw_ptr = c_avail_data[i].hw_ptr;
+		r->control->appl_ptr = c_avail_data[i].appl_ptr;
+		KUNIT_EXPECT_EQ(test, snd_pcm_capture_avail(r), c_avail_data[i].expected_avail);
+	}
+}
+
+static void test_card_set_id(struct kunit *test)
+{
+	struct snd_card *card = kunit_kzalloc(test, sizeof(*card), GFP_KERNEL);
+
+	snd_card_set_id(card, VALID_NAME);
+	KUNIT_EXPECT_STREQ(test, card->id, VALID_NAME);
+
+	/* clear the first id character so we can set it again */
+	card->id[0] = '\0';
+	snd_card_set_id(card, NAME_W_SPEC_CHARS);
+	KUNIT_EXPECT_STRNEQ(test, card->id, NAME_W_SPEC_CHARS);
+
+	card->id[0] = '\0';
+	snd_card_set_id(card, NAME_W_SPACE);
+	kunit_info(test, "%s", card->id);
+	KUNIT_EXPECT_STREQ(test, card->id, NAME_W_SPACE_REMOVED);
+}
+
+static void test_pcm_format_name(struct kunit *test)
+{
+	u32 i;
+	const char *name;
+
+	for (i = 0; i < ARRAY_SIZE(valid_fmt); i++) {
+		name = snd_pcm_format_name(valid_fmt[i].format);
+		KUNIT_ASSERT_NOT_NULL_MSG(test, name, "Don't have name for %s", valid_fmt[i].name);
+		KUNIT_EXPECT_STREQ(test, name, valid_fmt[i].name);
+	}
+
+	KUNIT_ASSERT_STREQ(test, snd_pcm_format_name(WRONG_FORMAT), "Unknown");
+	KUNIT_ASSERT_STREQ(test, snd_pcm_format_name(-1), "Unknown");
+}
+
+static void test_card_add_component(struct kunit *test)
+{
+	struct snd_card *card = kunit_kzalloc(test, sizeof(*card), GFP_KERNEL);
+
+	snd_component_add(card, TEST_FIRST_COMPONENT);
+	KUNIT_ASSERT_STREQ(test, card->components, TEST_FIRST_COMPONENT);
+
+	snd_component_add(card, TEST_SECOND_COMPONENT);
+	KUNIT_ASSERT_STREQ(test, card->components, TEST_FIRST_COMPONENT " " TEST_SECOND_COMPONENT);
+}
+
+static struct kunit_case sound_utils_cases[] = {
+	KUNIT_CASE(test_phys_format_size),
+	KUNIT_CASE(test_format_width),
+	KUNIT_CASE(test_format_endianness),
+	KUNIT_CASE(test_format_signed),
+	KUNIT_CASE(test_format_fill_silence),
+	KUNIT_CASE(test_playback_avail),
+	KUNIT_CASE(test_capture_avail),
+	KUNIT_CASE(test_card_set_id),
+	KUNIT_CASE(test_pcm_format_name),
+	KUNIT_CASE(test_card_add_component),
+	{},
+};
+
+static struct kunit_suite sound_utils_suite = {
+	.name = "sound-core-test",
+	.test_cases = sound_utils_cases,
+};
+
+kunit_test_suite(sound_utils_suite);
+MODULE_AUTHOR("Ivan Orlov");
+MODULE_LICENSE("GPL");
-- 
2.34.1


