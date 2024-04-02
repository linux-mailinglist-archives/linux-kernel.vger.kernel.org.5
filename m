Return-Path: <linux-kernel+bounces-128047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D8489555E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303901C20B91
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B3686658;
	Tue,  2 Apr 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2u4KHOe"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A5583CDF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064444; cv=none; b=jJDojviGcpp4D8NpAkUItGgo3jmkAhd8TBUvwgAztcuA8fz8eyGwHRqIAfaDyvNIYxd4fYJoISAztF8Dg/c+5zOoWrFUkzFBspx2vFfvERFC0LzsMkz/a8prClAulhKBepHmyui6bjT48CGt5f8g/58WMKlx0qOmhsbehM3/VSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064444; c=relaxed/simple;
	bh=Gpl6+RFGBVOtKmVuE3aToXQdg4cMocS4faBp8f2P3lE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=q6RE5QuSEvUI8bsF2s3YoC3CGCuHv4S14NCSe7ogXPA8D+FI2R/nFM3HyhweHjP/36tG4LXFuPwf3KKpKQNpQ4ANFNd0HKwqeywTCtUFHqkNDcEBtet3epac6MTWXCrSVp0/mgG30zWGdPH3iX5vRXDpqmhQlzOljSNQUtd4y9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2u4KHOe; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so939079966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712064442; x=1712669242; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B6ALcUhn3bkfonAFTQyhGpgkfckA9UhL/OB/3gO2UMI=;
        b=C2u4KHOew0lGMerx6DCG4RZVdXYleYjz6F7Ayspa7IH1oRhx4ht3DCB1Pha0xARfR5
         21Ao3mbo04NXOWQ8l6TV+AI5Oc5JFPotkFQmihMnoIWV/0htaWOCIx4PRe5N+3banCDQ
         zqiBf6BKoencmdAXD2g+mF1KB/xgbhwP8eNA2GDcaAqnmPAR2D3DtDMbEaANNvAS+9HC
         vibph959qf4MK1U8Uw52/7XEEelIefWXftoflwZ+/KExWH21yUK/nuEi5RSLpLhpDLzV
         IXl1vrU57JJglxypjcjTdJHZJU1v90aO83k5jh28py+GgSrs96TDoqFwrq01MeE7CU61
         htpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712064442; x=1712669242;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6ALcUhn3bkfonAFTQyhGpgkfckA9UhL/OB/3gO2UMI=;
        b=fxPqF7YfT1l68sH1jRXOyewxn/6hBwf3AD94QMS7mVqQDw5rpAaT2cQdNSqrCzPEgB
         BECl4WZvwCi1Sq+IBX7EbyJ7Bjd5Ab4RPRr+2TQ7/CCMO7Qzg0/37yLaDIwEDVRjuHWT
         lajqQODozuuPXIvAB/1zWRD+4RZmM6TXEzsGA46qjRmm61tKVFcVv9woVdsCAEph6lE1
         HPFndz9S92eCI7DE/TvRM0byOrw3inra7/vN6hyXCT1Rs5vOOoIXJ6Igz5qBYL5UO11a
         RiN7m1BFmUVcol06JPifWcW/yXVjA3RYQ7Y8Sbez9NWAm61Pth88RvWrqMCzT2xYA0ON
         RFkw==
X-Gm-Message-State: AOJu0Yy6yby6aoLqrMfA/h5W+QWWsBl4gfyK4xVaS/PGn3gVCAbupm90
	o4H/67FbJCY3U5myVy0EGqxjJOKq8aXoBWG2b1pWm2TsBnAiRkxc
X-Google-Smtp-Source: AGHT+IFTabiMBzV2DetNy6rdQODxSmUfHTAHQgfA3KyyBQOMZScRczY67MoRnE4oSPyLwrU+ldb6Rw==
X-Received: by 2002:a17:906:2892:b0:a4e:7d0e:f62d with SMTP id o18-20020a170906289200b00a4e7d0ef62dmr3372904ejd.13.1712064441572;
        Tue, 02 Apr 2024 06:27:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id lw7-20020a170906bcc700b00a4df01f4232sm6534084ejb.189.2024.04.02.06.27.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2024 06:27:21 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	rppt@kernel.org,
	rongtao@cestc.cn
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 3/3] memblock tests: fix undefined reference to `BIT'
Date: Tue,  2 Apr 2024 13:27:01 +0000
Message-Id: <20240402132701.29744-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240402132701.29744-1-richard.weiyang@gmail.com>
References: <20240402132701.29744-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

commit 772dd0342727 ("mm: enumerate all gfp flags") define gfp flags
with the help of BIT, while gfp_types.h doesn't include header file for
the definition. This through an error on building memblock tests.

Let's include linux/bits.h to fix it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Suren Baghdasaryan <surenb@google.com>
CC: Michal Hocko <mhocko@suse.com>
---
 include/linux/gfp_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 868c8fb1bbc1..13becafe41df 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_GFP_TYPES_H
 #define __LINUX_GFP_TYPES_H
 
+#include <linux/bits.h>
+
 /* The typedef is in types.h but we want the documentation here */
 #if 0
 /**
-- 
2.34.1


