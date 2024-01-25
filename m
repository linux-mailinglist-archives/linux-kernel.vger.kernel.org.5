Return-Path: <linux-kernel+bounces-39365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B4D83CF7D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7FD293C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EE911700;
	Thu, 25 Jan 2024 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpLU7XJo"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A871E125AE;
	Thu, 25 Jan 2024 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222139; cv=none; b=sfV1TOR0PNjy3ESEKkmVxMuUptW8fU72BHz3O5HKU+JeVUAb8YQNxupEZrvVBKBfUCqjSw9PEmVXBj49OPF3D+UZGgpz/UGg96wb5ZQLzuY0GX3UaYoKT6rqAhX8YBzHaNzjNLPcsehVHo6mNBDzPtR/Qepau0qqIu68EwLCf4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222139; c=relaxed/simple;
	bh=EpcQXL2y4W10EtBJFDqdMhE3g0qPf4/XBmyrTjfctOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyWDBc0fetpKyFshNOspzzdf0xEDr39xKnFmBJUggYWxaziKz8Og7IQsxs19yi8kOeyc6CLFqZiDM6a26y6kKDQD3sVLyg/hapetQyMeGBh+Bawx8wFvw8fy66Fu/8RawHNsxPRYn5xFx99f6TA6ztYaqXMxLNjqA0vMqDB1O3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpLU7XJo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e5980e1b8so172755e9.0;
        Thu, 25 Jan 2024 14:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706222133; x=1706826933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eE8uTyZT2lbnF5CcaUIyumC8KPuh+xQv+eXtsqwE/0E=;
        b=UpLU7XJoNh4ZjIDl1RYmJog5IaX1/tF0Rh4EZsXVkWniK3g8WjOr5cDmM4xuMSRqZh
         3ReyKJZPjCp2ZBDf6JzSD9c94b4yTgLFZgG1hKQkfFt07pA9YneMhlPW9ddW3DDK2ku4
         2TXUXsnn2OE4thoLH4IYv+rNi3X0qvw/O2mLRIcZP0awEsyV/rg4UEtUpGIeTYUvt50q
         QrdseDhRnWQU5aKF/x12DSeZPajZN0a2DKOWiUnfVH6e5vaXhA3J1wKvzrQBojA2iRk/
         PTm4blY2jrBCFz6c19vdDOWUMr9h0NerfFzoU/dOH/iqUIZT37Z1xmqW8qnEJa7X4jW/
         yF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706222133; x=1706826933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE8uTyZT2lbnF5CcaUIyumC8KPuh+xQv+eXtsqwE/0E=;
        b=B20RhnQX97dfVi2CwExXyNhjiO+lqNJFPg/auO6KpoSf3VWsD0Aj6wyI/iMlAS+BTn
         hJo4fglS1Ctukd730SYvYSil/YkOp0AbvXbBky2upug8//WTUlm2rcxnW9IOvFv8SJHn
         dgmOGG3kMw11t+zphaDunBhKGwsytOVQIA/Brd0Z8tDDr0OimIPyxeqfr0zI+COWnyFs
         JstJr32Vzg/L0rhpoDmy7eHZxXg9WXAXyPpNoPehmdcAOSCk9DZp42T9NeGdG5zEZjP4
         0Hlx5cs6IdbChJDlYmoZmXxOFvi8RcYoVBIe3cyIZTuSo2C5SwK9CitJZ6wQFtTgwmEM
         QnXw==
X-Gm-Message-State: AOJu0Yy3Ig0u3AiD5yqZ9WYQlIoX4Jt+u/0GzHWiYgbGRpgqrW4mPXSZ
	IUW/eLXqev/9rmXZfUfpQoPWotHPaoLBAUgYS5QxbPMRuNj5u2jH/A0HyrEg
X-Google-Smtp-Source: AGHT+IG9F4+iX8pfFf9o6PsX3DOSxDi8GXHI0tSXi5IhF+Z+MBeJlUCvzgdVC68xDCvtzWuWWDN0qQ==
X-Received: by 2002:a05:600c:5102:b0:40e:af30:4bd7 with SMTP id o2-20020a05600c510200b0040eaf304bd7mr547061wms.3.1706222132713;
        Thu, 25 Jan 2024 14:35:32 -0800 (PST)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:9829:5527:ea0f:1fac])
        by smtp.gmail.com with ESMTPSA id b19-20020a05600c4e1300b0040d8d11bf63sm40012wmq.41.2024.01.25.14.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:35:31 -0800 (PST)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ALSA: pcm: Fix snd_pcm_format_name function
Date: Thu, 25 Jan 2024 22:35:20 +0000
Message-Id: <20240125223522.1122765-2-ivan.orlov0322@gmail.com>
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

Fix snd_pcm_format_name so it won't return NULL-pointer in case if it
can't find the format in the 'snd_pcm_format_names' list. Return
"Unknown" instead, as it is done if the number passed to the function
is larger than a list size.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 sound/core/pcm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index d0788126cbab..d9b338088d10 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -225,9 +225,11 @@ static const char * const snd_pcm_format_names[] = {
  */
 const char *snd_pcm_format_name(snd_pcm_format_t format)
 {
-	if ((__force unsigned int)format >= ARRAY_SIZE(snd_pcm_format_names))
+	unsigned int format_num = (__force unsigned int)format;
+
+	if (format_num >= ARRAY_SIZE(snd_pcm_format_names) || !snd_pcm_format_names[format_num])
 		return "Unknown";
-	return snd_pcm_format_names[(__force unsigned int)format];
+	return snd_pcm_format_names[format_num];
 }
 EXPORT_SYMBOL_GPL(snd_pcm_format_name);
 
-- 
2.34.1


