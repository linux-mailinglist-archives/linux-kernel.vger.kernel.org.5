Return-Path: <linux-kernel+bounces-158867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10978B25FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3377282936
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CC414C5BF;
	Thu, 25 Apr 2024 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuESLOa/"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32E12C466;
	Thu, 25 Apr 2024 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061278; cv=none; b=uLUgL934LwGmfzdWkUWf0iJsu48QTUG+rvPmlrxyBek4F2DOx9GNxYmWxKqZ7mzihcU+7u4lqv58CPzLfyqD9JtxhQ/151fZMj3FBNTGTndY/TjNMbCeL+RFa6b9n5qIvNAksNN3Mqon6bPaZA2Tv881jbhHNo1N8w/Bsc5zHTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061278; c=relaxed/simple;
	bh=kZSoVnPwHh86m3NoOdlMADSlVu0ywdgka1QLhDZJ0Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gDw6HX9mxALQ71JjbwOhGOgRHoSeauYhslgUm/CDuOPiSdprQUduvBPaIr8hb9/t8EVOosW7JD2JC1SL25LyuALqB+AS1+ewocfPQ0GjNx4mArurUVDlXs+GYtM4mxW8wWduqHu0GjPFVoP35nMZzvAECWJkq1QkYpdVDtkxGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuESLOa/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a1d88723bso8336075e9.0;
        Thu, 25 Apr 2024 09:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714061276; x=1714666076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gN8Y1W7KR/HV28QZoX9RNXIwZmbdrRKuGKHOSEwdMx8=;
        b=JuESLOa/kdXz/mhcAg+eFEEbCqabNIuEDmwqLQdH4UdzDNJ1dt3jvZVSuqBuewzxcE
         m+g7x5oKe6Z+n9TFPgz4SvHpVC4Ww6aM/4P5XRQRvAPi8qDyaEAjbJT3xHWh/Hf3bkXw
         TYnKDPDbN0YqlI/EMKUqAxzT3/8A8J5y90AChJdbWhjYi7fQ5R/plNPRTA8mdilBivWY
         mh6Q6DMc8Q5HkkjwjsJ/AXMnuBq8kXEVS443vdtAddIjB5KHDIY12Hs3pUcJTAJO9ypo
         EyRg0FxpTuMqBDHSnXmAJMMYQHorYORVf6gae7V0splzVI694WxzEj1sX8TUw04ly/5J
         Z8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714061276; x=1714666076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gN8Y1W7KR/HV28QZoX9RNXIwZmbdrRKuGKHOSEwdMx8=;
        b=H4Ref1xZ+UCyKvq1319KqfrDC3Fd6Z0PhsndViWibqz95cQAjaAu7Bt/NNsxeyXSIO
         o+Maqzt8uDbm8zchgM4kvFaJWAj7sGd/Z/ZPulhLEPTeUp69SMemGIS53LOi0B408eMB
         0BDbdhsXuCiOy5F3qnigyTQJsIq45o6YP3QGXNdR53f9Kb1FWoTMBYDTh4caLAEY0foH
         F4M612XzWppJ88iVyNtbd4KIpmLqqOYmO9JIxqKTjPhgxaHXKXPeWhew2lBGrg/W8DI9
         +YX9UdH8MC4wM56Li4clklqg84L7Gh00u+kMz5JmteLEUOJa6qwtvnYHKXnNScEVDKi3
         pztA==
X-Forwarded-Encrypted: i=1; AJvYcCWBU6fPsd3QNRk6Zonuv108KaF9XE85jmOxbptIrmn1IC+rZQvQs7kDAf9l+5/K+Vq6G/uHCdnMn2CM+J2ICrfiRbiScraKOzX365En6n9O6Irt/QRfZQnztCLq+DWK9M/GymwI4dnf/Y4=
X-Gm-Message-State: AOJu0Yy0ntNBtpX6LfLD6qkZB61VjbCdp/tGeXLtnEZKm2JYSE/Z3uXm
	gSVpRY0aqNXISxB/hL2ct3BQmSMy9ygy0Lzd1ahGBVKKUFHek8jnzDcYDY4m
X-Google-Smtp-Source: AGHT+IFlDxeIzTLQZ6oCjoR8SMYSRVnEsMxbx1edkXUA0vtbs8bw/ldbshuE6Rzl5C3HS2QqZZNG5A==
X-Received: by 2002:a05:600c:1554:b0:418:a620:15a1 with SMTP id f20-20020a05600c155400b00418a62015a1mr4465333wmg.30.1714061275261;
        Thu, 25 Apr 2024 09:07:55 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id j2-20020a05600c1c0200b0041ac3e13f1esm9643536wms.37.2024.04.25.09.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 09:07:54 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ivan Orlov <ivan.orlov0322@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: kunit: make read-only array buf_samples static const
Date: Thu, 25 Apr 2024 17:07:54 +0100
Message-Id: <20240425160754.114716-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only array buf_samples on the stack at
run time, instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/core/sound_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/sound_kunit.c b/sound/core/sound_kunit.c
index eb90f62228c0..e34c4317f5eb 100644
--- a/sound/core/sound_kunit.c
+++ b/sound/core/sound_kunit.c
@@ -167,7 +167,7 @@ static void _test_fill_silence(struct kunit *test, struct snd_format_test_data *
 
 static void test_format_fill_silence(struct kunit *test)
 {
-	u32 buf_samples[] = { 10, 20, 32, 64, 129, SILENCE_BUFFER_MAX_FRAMES };
+	static const u32 buf_samples[] = { 10, 20, 32, 64, 129, SILENCE_BUFFER_MAX_FRAMES };
 	u8 *buffer;
 	u32 i, j;
 
-- 
2.39.2


