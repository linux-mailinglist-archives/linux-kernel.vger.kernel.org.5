Return-Path: <linux-kernel+bounces-74292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5758985D252
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892F91C22EAA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3173BB3F;
	Wed, 21 Feb 2024 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxPD8nz1"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540563BB2D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708503274; cv=none; b=FSlNtrcY3tQKuR9JaI0YOzDbd8SvjiG1lEkeiaWWB1TVuxwOz/67xqCS4Lq+GuhBUMMp6jb6xK7MYbS3JpTMqpq5T5lrDlGAoCLCPU2MVUucQPzrI/iWJ3fcT/GYZzRdmj1YXsGFpr4nQkFh/sHSaUdZbZaETGDosr+DlwWOLWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708503274; c=relaxed/simple;
	bh=hAvZUArQubG6FOTvp2Z9ZxyhW0jKEIvDo1xz4DEtdnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C8tV4CN81gv77DrMxkqbkm88s+LRbv1E3GdK7Xm7tEd+dZqtccnvZ5EtisTKKYn/zhoo1pu0tBnXv2iHL+1roPiXkM9iUzAv5zB7twmYDOXsttGKC2HaRARqNXhVcI3EhPMcyEXpaTaoSw9CGW2jrXilZs67axzwRffRA1zZQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxPD8nz1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so27005145ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708503272; x=1709108072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RLLstCGYI81xQhpwq9Yxp4yDZIlsvXljT4KfVN7Dg6s=;
        b=TxPD8nz17QzRn8Xao8choHPD0KWPHaeqFXEEO9yeQ5I+byKNyOfFQgAce+YYIqD8sK
         nTDUzzrjDFtOgXz8YAi1aZ6s+QsKNxhs5URtjhYiLtIEmlXGNfxZcEVrOq2gAtstBeG3
         bTJPrPCIoEejYRz0uuQZry0gIk8g68I70VAknf00yStiCKWPfw72WepWi/XeYAqx2EKb
         hY2IbQ1DA1XzcFp+y5N/YTNKwkpIBflCjrs4QZfiNaf/x0OWNcuyiuHnWptBBQuqQS5p
         zJOCVH9OjyrmQvyBe6UXtkcWUJ6jJixjMRE5oolZNHV63eQ0R5B2N3TxogLpn7RzDHxg
         MCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708503272; x=1709108072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLLstCGYI81xQhpwq9Yxp4yDZIlsvXljT4KfVN7Dg6s=;
        b=p9yVKZcm5ELS8apjIATVjR+LD+QloyygYIb7gbFreWNgQ5VT85LNUVbyFx9TAaHTjI
         c493StH+eM1N1UbGkj5j0dRTqDPm3+zQak6VrcjD/I8QOeSiRRBQJKJfg+l0GtgAQ9rw
         7iutjlviVqN8/c5CkfYUeO011LOjjmNQ0MsuXJPTjsbxUEHpQzZLFtTPlNXx0hFoX6rE
         Qdhs60mqOW5jixQzgX7fu9dsMz4rqQfIoX4RfPOlDYaQrfgmuDlhxX8ILnjN6ZRX8i91
         JNl2mIjrPAyDs5E/CtNSwivoBOdKaVBAom173Khx5ykhD0Pf1/VRIOYi0ls6IhoM5jkE
         TLWA==
X-Forwarded-Encrypted: i=1; AJvYcCUfcKpLBx7oxX+4GZKxhVRyQxenykEDhnCh2Fhzvznyq1EGwfgnNUSbMf0Cp243T3vCV1qEF4rA6HnNRUMpJ8D80iCPG3JkAOE8YrKX
X-Gm-Message-State: AOJu0YyXlhGJ1BblAo+oTUpC9VWQW0sewQ6P6ETTbiqPWmfxMMEyae7d
	9EzVlj8Zq6b6Mfwa/tsELz7vgn2ax0R81jH4A60UJ7ErpOPqMEOp+BQXzbVw
X-Google-Smtp-Source: AGHT+IE84X1gwtq0IISwa/yDBtGDeQ/oOnbumLEt9s6m0b2yQuk5GOnSCx8Fwx3Hj//33cWNcZLtVg==
X-Received: by 2002:a17:902:c084:b0:1dc:20f2:77bb with SMTP id j4-20020a170902c08400b001dc20f277bbmr2597073pld.29.1708503272399;
        Wed, 21 Feb 2024 00:14:32 -0800 (PST)
Received: from mi.mioffice.cn ([43.224.245.229])
        by smtp.gmail.com with ESMTPSA id kr6-20020a170903080600b001da1fae8a73sm697162plb.12.2024.02.21.00.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 00:14:32 -0800 (PST)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	liujinbao1 <liujinbao1@xiaomi.com>
Subject: [PATCH] f2fs: control gc_thread_func to run periodically
Date: Wed, 21 Feb 2024 16:14:20 +0800
Message-Id: <20240221081420.1712430-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: liujinbao1 <liujinbao1@xiaomi.com>

By default, the gc_thread_func function fluctuates within
the range of min_sleep_time to max_sleep_time, and only
when gc_mode is GC_URGENT_HIGH, wait_ms can be specified
as urgent_sleep_time.For other algorithms, we may also want
to execute it periodically. After introducing this patch,
we can control the gc_thread_func function to run periodically
by setting the values of min_sleep_time and max_sleep_time to
be the same.

Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
---
 fs/f2fs/gc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f550cdeaa663..df94e64533de 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -120,6 +120,10 @@ static int gc_thread_func(void *data)
 			decrease_sleep_time(gc_th, &wait_ms);
 		else
 			increase_sleep_time(gc_th, &wait_ms);
+
+		if (gc_th->min_sleep_time == gc_th->max_sleep_time)
+			wait_ms = gc_th->min_sleep_time;
+
 do_gc:
 		stat_inc_gc_call_count(sbi, foreground ?
 					FOREGROUND : BACKGROUND);
-- 
2.25.1


