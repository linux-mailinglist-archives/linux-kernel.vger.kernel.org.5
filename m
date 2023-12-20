Return-Path: <linux-kernel+bounces-6499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 621EA8199AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20401285092
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441871BDE3;
	Wed, 20 Dec 2023 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBFcRaF9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FFB168B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-553a45208ffso1791320a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057891; x=1703662691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxdaR881KYWxnVjE5RFuD+xNEp0CWp7EUb3EZJFwG58=;
        b=CBFcRaF9um8CTe/6RBFNzYJ3JxOkiLFvFntXhMzq3vF+ERECkg96EraCj02i07m3+3
         UmSjzGYEEWmEy53Qfm2mmAcBg2fe+YJpNFrf7bq7WUfFSoYhhokXOFePamggOz1xz+3K
         NAYqun3zcUNtKHoDUSpn0mA34JQM7hsX/mTv0qhWT7mcTRA+NW88ZgQtpI6E97NdS9L0
         PjAYCWcMMWKMzo3MbH6nSW3mc8sIMlLvAb1gg6muTunroGvwGDmj4VT9zvoA13Tyw3aM
         9cqcXfskRALHK07Xp+91il646Sp4Ay4G5dHx3csjDk+zuDi/rlwvB1M3yRq6hD11ubiU
         UegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057891; x=1703662691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxdaR881KYWxnVjE5RFuD+xNEp0CWp7EUb3EZJFwG58=;
        b=OQFRS3PG+SYvMWgLN1aRYzuyrYjf62cxzQ5sbyujz/QZm5mblgGIcmCIdM9ISQhb+E
         gVdQq8AaRKl96iNnCVqxlcS3kKWfpfa/Nq/uOC1gofXNLTyCt4onzAftDTBq/4q0Fv7O
         tpKJxiqbCeCFiub5EVzwUcOn0/aqYskCf5rYJgF1YDW4W5HRFN+Ttg4Chk5for/AqENk
         4dXOSnLpHNbb9j0fBY6UCEqa9HTYu+etlEsHbffxfugFpbkvynoB6ouOckvVqApTW0ne
         sr5vkjVkvM8/VFtIjKtb0yfw9J3o4iW8+Blaz7DJ17Wn0ylysDbypcWjT4uKychITRK8
         G8+Q==
X-Gm-Message-State: AOJu0YwfIu6KWOC2A0bswlv3pgmvgXEs1sFUdIo2ZrLu4uPjsZEnPGRZ
	1+WWmF5cUqfCHhqMg5gwXw==
X-Google-Smtp-Source: AGHT+IF1+fG3lPptD5qJNeH9L9Yw2E+IRSt3K4z5bx6nfNUz4NixxmGTMGu3Eq9TuPiyNB8OraLeiw==
X-Received: by 2002:a50:d71a:0:b0:553:99fb:ae47 with SMTP id t26-20020a50d71a000000b0055399fbae47mr526017edi.27.1703057891414;
        Tue, 19 Dec 2023 23:38:11 -0800 (PST)
Received: from alex-pc-ubuntu.lan (31-10-153-16.cgn.dynamic.upc.ch. [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id p7-20020a056402500700b0055283720ec3sm5979043eda.76.2023.12.19.23.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:38:11 -0800 (PST)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: tiwai@suse.de
Cc: alex.vinarskis@gmail.com,
	alsa-devel@alsa-project.org,
	david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	josbeir@gmail.com,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	sbinding@opensource.cirrus.com,
	stuarth@opensource.cirrus.com,
	tiwai@suse.com
Subject: [PATCH v2 1/2] ALSA: hda: cs35l41: Safety-guard against capped SPI speed
Date: Wed, 20 Dec 2023 08:38:08 +0100
Message-Id: <20231220073809.22027-2-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220073809.22027-1-alex.vinarskis@gmail.com>
References: <87ttokpyws.wl-tiwai@suse.de>
 <20231220073809.22027-1-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices with intel-lpss based SPI controllers may have misconfigured
clock divider due to firmware bug. This would result in capped SPI speeds,
which leads to longer DSP firmware loading times.
This safety guards against possible hangs during wake-up by not
initializing the device if lpss was not patched/fixed UEFI was not
installed

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index c9eb70290973..cb305b093311 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -210,6 +210,19 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 
 	if (cfg->bus == SPI) {
 		cs35l41->index = id;
+		/*
+		 * Some devices with intel-lpss based SPI controllers may have misconfigured
+		 * clock divider due to firmware bug. This would result in capped SPI speeds,
+		 * which leads to longer DSP firmware loading times.
+		 * Avoid initializing device if lpss was not patched/fixed UEFI was not installed
+		 */
+		spi = to_spi_device(cs35l41->dev);
+		if (spi->max_speed_hz < CS35L41_SPI_MAX_FREQ/2) {
+			dev_err(cs35l41->dev,
+				"SPI's max_speed_hz is capped at %u Hz, will not continue to avoid hanging\n",
+				spi->max_speed_hz);
+			return -EINVAL;
+		}
 		/*
 		 * Manually set the Chip Select for the second amp <cs_gpio_index> in the node.
 		 * This is only supported for systems with 2 amps, since we cannot expand the
@@ -219,8 +232,6 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 		 * first.
 		 */
 		if (cfg->cs_gpio_index >= 0) {
-			spi = to_spi_device(cs35l41->dev);
-
 			if (cfg->num_amps != 2) {
 				dev_warn(cs35l41->dev,
 					 "Cannot update SPI CS, Number of Amps (%d) != 2\n",
-- 
2.40.1


