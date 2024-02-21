Return-Path: <linux-kernel+bounces-74648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA0A85D73D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E32CB24BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666047F48;
	Wed, 21 Feb 2024 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrUP+WxG"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB18481A8;
	Wed, 21 Feb 2024 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515494; cv=none; b=DhnhxlxBqznWkxb0grjdN9ePW+zQTR4K+7o0JfV/fozEvzxqvzmBwhKuxfe0h+01BReQPRuu/sHWxhcRRf9k1Q0zYRQg/PSAEXGkTfOB6got5ZS7FrptTBBTJhhhR/YmZuxLPVeIhPOmf40s4i3ryPo+e1AOkbYhXREVgLkpi5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515494; c=relaxed/simple;
	bh=EhrWngD9RDOax6weTU9Ro/qRRNM2e3wDxLZFUYJCqFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=groxgjMrHrpRKyVnBW4pO+AYxqLqSUJdpSrVFoXa3sUk6D0nqaFP+1IpbEfmpWgkhZjOWkw1ULxVjJkWn33t1XSfe0XiuLMihc1K0iH+fqlz6YuA8rfMxaNMT5JdEYOASuQQRCNDjlJ2stk5iYdJ6HRjlJnDNbpyYBFTljanCSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrUP+WxG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4127188dd5cso10082685e9.0;
        Wed, 21 Feb 2024 03:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708515491; x=1709120291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C/HFIcoSw75hDTLYVUPwa8rzXmjiPlpAtt6qgGaK/RA=;
        b=ZrUP+WxGt8IhN8QaymqyVGVaNfa/2ay4BRlBwkzOryk3m7iloqecPpcrl4M2wyJsmn
         pbOymW+JVS7z1JX9HVcow1H6/UHeI47By8SkX5s/ncppbNAS1F8KIMgDRISCDG8cJYJ4
         WwdFKCC+/8FDoKjVCyoNW53NnWtvwagqyc4vK5Cy+BCnpYUpt/ar80eF6P0tvfUphws0
         f1eP/shbMV8MHFJ7L8y2R4SRB4Yv+M24sCxS21MtJdT283/Cw5/lrWSCbA0hEUXtz75n
         jWrF5fN158YRpvFkOzAlb1gwxElu7KK5+v2CK4Er/2AJhKcSvop6bn615Y6yAv29TJmY
         T55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515491; x=1709120291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/HFIcoSw75hDTLYVUPwa8rzXmjiPlpAtt6qgGaK/RA=;
        b=W0e81M+pA1LTQzDETxDEqUiw2wELQNeTLovUBHMnHy9+YlOkSakQYyUDIO53irrxfj
         0oOSBrk2Uo8tU3tjdVZ5LqXSzhKbj2P0NBFLWeam8aWh/UFiTLcgOoYaJhdXY9Cl0p4b
         fBFvVnJG4dd6Et1GcxiJDxkcebRpZ/vF4hR30P8a4nQtSsNejUCnwvaeSjt4Nkim3LTU
         Y48t74UgrNcG8J8at93EEi0vTNnwYVSLciQzOjIA7krAZDPlTd79sEfjgJkxw9xv8HKJ
         D5QtdKeSCiTbSqgBI9hl7N/uqlzvSpNcsc8DkNs9Wi0dz/gwrgvR03cu2GgHB8ur1hpO
         AzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy91V7Qrr8ob+fR4ZwL4epuc8Tu8PWLaxh9wXK1uU+Ge9fhWfWJM9kpudoEvxYSsQUL/VgQ6z9FmhVfPP6DAmIExcusGjRhkp+tQUKcntOO6NPu9Q99A5YiwzQkUiVbhedgS5hoHtZcWk=
X-Gm-Message-State: AOJu0Ywbv7Lg9TJqETS2Umrd4AURRR4z6gx6y2NA18H9cvq3WRoP3yhL
	1xuraN2/sLU4PbxuqPPkA9XcFcj3VcBfn2L2Cu8H8k+wC+jOAnh5loim9brC
X-Google-Smtp-Source: AGHT+IEdSBNCbVnHf3xsKaHEyqKW8117YV+/I23ry7Dd9181w3oMZZfnGyOO2Vg//jXHeha/rb+Otg==
X-Received: by 2002:a5d:64e9:0:b0:33d:2833:a163 with SMTP id g9-20020a5d64e9000000b0033d2833a163mr10021781wri.29.1708515491151;
        Wed, 21 Feb 2024 03:38:11 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d428e000000b0033ce5b3390esm16657238wrq.38.2024.02.21.03.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 03:38:10 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: echoaudio: remove redundant assignment to variable clock
Date: Wed, 21 Feb 2024 11:38:09 +0000
Message-Id: <20240221113809.3410109-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable clock is being assigned a value that is never read,
it is being re-assigned a new value in every case in the following
switch statement. The assignment is redundant and can be removed.

Cleans up clang scan build warning:
sound/pci/echoaudio/echoaudio_3g.c:277:2: warning: Value stored
to 'clock' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/pci/echoaudio/echoaudio_3g.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/echoaudio/echoaudio_3g.c b/sound/pci/echoaudio/echoaudio_3g.c
index cc3c79387194..18b4d4b4d38d 100644
--- a/sound/pci/echoaudio/echoaudio_3g.c
+++ b/sound/pci/echoaudio/echoaudio_3g.c
@@ -274,7 +274,6 @@ static int set_sample_rate(struct echoaudio *chip, u32 rate)
 		       chip->digital_mode == DIGITAL_MODE_ADAT))
 		return -EINVAL;
 
-	clock = 0;
 	control_reg = le32_to_cpu(chip->comm_page->control_register);
 	control_reg &= E3G_CLOCK_CLEAR_MASK;
 
-- 
2.39.2


