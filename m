Return-Path: <linux-kernel+bounces-60475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AE985056B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12310B25375
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0085C903;
	Sat, 10 Feb 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7a0/Rn8"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD125C8F6;
	Sat, 10 Feb 2024 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583640; cv=none; b=WJ8vQjuZ+Y8gvjHG1iF6/PUu3cUbimDXZcafKHTUTQAyn5XJvUq2LzjCqqx+i2fYTHXeVPSE/26VMEHAfvoUJ0U6/uq1mLC/jasR374Z5FKIxBN2NRRIr2kxTHROonZpocC+3id3pXj1rdzmMMABoVr8fjC0UEk+hYsm4LnN9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583640; c=relaxed/simple;
	bh=UAqQD3oelYDMRM+Gfif5+1OVPXLKKMD6QFg8/vJG2+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eceh/3LEnQjlI2nRHkAe2f3ff7g4XrWOpSs6rgnkFb88Vyw8UVE/x4eu72kGPFaIqFAQoL/xi+lk7YHNPFb73ijNgwcHKctZAx/dFfZTstJh1DQes+6GgwoEnUIKz+Kd6xKwJQe7O5ygEP4c0BkWcvKg6zP/wCMhknJdW4cIOAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7a0/Rn8; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51187830d6dso87732e87.3;
        Sat, 10 Feb 2024 08:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707583636; x=1708188436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hk/SbajI1jl+xk0jp4p0+2kr+POyWtdnYXXg+LfRCFo=;
        b=A7a0/Rn8HNYavaFIK/h7Ot19czVPvX+siwj8QJvs0FqFkBptfgaZ5Bo54AZSeNNQWs
         xnUXb8tPGxyXzR68qIHM9SNA+tqLP5kvh418A659oP3aJP37COcFgyVsPvoY4bU0hsXL
         RGqb5I2oCNLiYEOLz6m1iu7HkqO4nu8bEYW4+AJa/5e9FLGS+BWXiEcsLaDVoK16jWwY
         2MNyKci8q/7ztPR2ohNkBtM2t1lefMVMaWcUnTacQvgbB9azlcztpNDnVm5zBMxnFPaT
         dBIslfGrVmpkS38mzy2+rUlNBF2JSbiJgJHn9mMWqtfE/XXOuCWAbUPhjHkSQJnD8dwd
         LOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707583636; x=1708188436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hk/SbajI1jl+xk0jp4p0+2kr+POyWtdnYXXg+LfRCFo=;
        b=RXUql4sYTudboTtjPNmdg4RuT/EbPPLkwCOmBJtiwvwvZdxEt1mm587vIcEVjBEeSa
         KZZI5uV1bnQAjQ762GvisWSOJ2KPUIgRwIqtm38iq2r5GeW2RAS13x3d3mSmTaXkFRjV
         S22dGP+3X9KO8mhxbLndRmQufWsja23tAK25RtrcRBTKt0D2xKdoDEfTvcRGcG4zfNEt
         voeyCzsTnIJd55jd0ir1+iu9fMw5GW5aK0gg9tatmwQo/NzxqWr6hJO2TCvPfDQSOLhp
         HvVZX+MnBobPQ7K23PUyM8rRc8PBwpGLWjZSRgHT1rZGSHn3DEZmN41vhR/FVkSwtsqM
         6W1w==
X-Gm-Message-State: AOJu0YxymGK3TO4UVnffJciO/9u2ohbvKiHdbrnKsImCBN7SVXnlKntF
	hC0NhV3fNxbTCHEYrxz+Wdc0VpjVUiYKXQ5XMQmb9kN57qmpI44u
X-Google-Smtp-Source: AGHT+IGVY56txG6C8RZcWR/I0QF4yI6Jei8H/VFea7K6RLSF4cd76cG16pi4Kf0qUF67FHg5mtyvwg==
X-Received: by 2002:ac2:548a:0:b0:511:4f21:4517 with SMTP id t10-20020ac2548a000000b005114f214517mr1310341lfk.33.1707583636294;
        Sat, 10 Feb 2024 08:47:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzAkW4XcByi5FH0mI93yicy17IKOxLWelYfbMecJ/SZVjWuzTX+EeI3oN66NFThGh6N3eGGqc5vUh3Vm7fKXOPK9p1hDnqfEZdocAfkhVF21kD+QceHX4sUqQdHLI09lgW6E/0iXA6vrsgfLufvzMBVvVE92RKmbegfUaxb8cWzqag2/iidkzavwKgrZOdPWAqnrWb8IC15PhGZ4fh
Received: from Attila-PC.. ([188.24.48.22])
        by smtp.gmail.com with ESMTPSA id jn14-20020a05600c6b0e00b004104bc8d841sm3804718wmb.13.2024.02.10.08.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 08:47:16 -0800 (PST)
From: =?UTF-8?q?Attila=20T=C5=91k=C3=A9s?= <attitokes@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Attila=20T=C5=91k=C3=A9s?= <attitokes@gmail.com>
Subject: [PATCH] ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU
Date: Sat, 10 Feb 2024 18:47:03 +0200
Message-Id: <20240210164703.141745-1-attitokes@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like many other models, the Lenovo 82UU (Yoga Slim 7 Pro 14ARH7)
needs a quirk entry for the internal microphone to function.
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 23d44a50d815..864976a81393 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -234,6 +234,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82UG"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82UU"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.34.1


