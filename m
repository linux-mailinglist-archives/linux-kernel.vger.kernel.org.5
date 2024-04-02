Return-Path: <linux-kernel+bounces-128058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DA68955C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE9D6B2D7D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6FD84037;
	Tue,  2 Apr 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6ltzsmq"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526279DD4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065127; cv=none; b=gCxrJu/UcwlgA/rz9D1aLq5SNFjRGrcaW1irB5YpqMm3kdRM71YXcl3xdJVOVTXJNuHXwxUJ0z23hNVE1L5Eyqd7qA18m7xdRs40Mh/fpKn8YQja4het5bXdf0pM9CIO02vvq9xhBkm01EwmpfThFlXR+3KTrdRhRD8bHlKNqtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065127; c=relaxed/simple;
	bh=oy6TSCppR0FL8FKnxmd6Ok1rnWwYEeT4sUvfAhd/HpA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YH6ud3XWs0Sa4M2tyCfg/n15IAhao/ZNS2eSPm2J31l5kLgimplI7Ozlk3oyZJKyPTG09iRRUC79UFZqCabE4WiPXrf6d4oW8rDaaBP71la2TDvMljalydIiEi7rsAmlQ0ODI3rG899WYDkGqmMKp9Clo/81pfqqPREyC+EUT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6ltzsmq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e8f765146fso4339400b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712065125; x=1712669925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jIQOkXAPzRTIsXCLQrCNO/btC95b+DW8Kc5c+5fkvh0=;
        b=h6ltzsmqg1LWf59d46X/Dwr9jVh9Kj3Cl3N3vS+/NafT6UB5ShAJPeHTpBOKfeQO0E
         NABgbdHpG5ip2udWQkmrr27i2empFhkiSix66WLFczVluSiXntHB1Jo/tkXl3dWjnaHd
         2SaD0faA4mI9+NV8fzjE3tkD2m1SUTh+wX+JCiPTOuSBTAnSRAjcery7/LD2e+8gBHKH
         nXCBGqLrBxS3O+SIcE3w0jOYgRRsKrBwLO4G2Br6DCBOV1GcS3U5B51LOLbaMEKtmtJA
         sq1Lo4d5avMYjgxckeWu3vxzmCN31yEQk0q+zrsHZhLp4W6OQz/uTlLGIzhnitzCcubg
         awEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712065125; x=1712669925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIQOkXAPzRTIsXCLQrCNO/btC95b+DW8Kc5c+5fkvh0=;
        b=v8sbi349zhGHnSf3Qa7vbzlxy7AFgBUj4gOtS4HeO8QiPS9RJoueInq+M4Gyq9HFmR
         /plEI7aB+2WlaBj/PiTzIsAloj3cZ6Fw1dAvBArmcaLJ3V851yO+y2GFH5clpjvTazqW
         CqM18FYk5XDOODxbJxgTlhTGopXyzO+sD9q/uTlF7WCB6oXnGF1J3qhRF97oLRJXiZdT
         ejrrZzZiZoPWEcUZxRb6xCQ1e10JRh+ufUz788ZvJUPYgACQrCSIBUN7MoLdkyJ7H2AZ
         +rwVhnqP0ON7G374rCvacxrrrTmnUNYNX5nmJB1822aLuxTWiZnOWhELq3hC/C2IwIaR
         PAmQ==
X-Gm-Message-State: AOJu0Yw2jVpQxMLxpLEjjC0g3Birpo8X4n921nuEUupoQcnfDDbt23ce
	2S1La6pnw6fq40+4vbIKt/Tf4emAhqhSczYqFQOyoJ+fs9Ne5e0o
X-Google-Smtp-Source: AGHT+IF390TovvkC6+QyYCy4RwGWahE/gPHKWGE/HLIR1BlC+7C6X414ToBdcrxXfWP8JhVWGnNE+g==
X-Received: by 2002:a05:6a00:2403:b0:6e6:f9e1:fd07 with SMTP id z3-20020a056a00240300b006e6f9e1fd07mr11956503pfh.10.1712065125000;
        Tue, 02 Apr 2024 06:38:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fm26-20020a056a002f9a00b006e5360f1cffsm9820266pfb.180.2024.04.02.06.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:38:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Oliver Glitta <glittao@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Daniel Latypov <dlatypov@google.com>,
	Marco Elver <elver@google.com>
Subject: [PATCH] mm/slub, kunit: Use inverted data to corrupt kmem cache
Date: Tue,  2 Apr 2024 06:38:39 -0700
Message-Id: <20240402133839.283793-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two failure patterns are seen randomly when running slub_kunit tests with
CONFIG_SLAB_FREELIST_RANDOM and CONFIG_SLAB_FREELIST_HARDENED enabled.

Pattern 1:
     # test_clobber_zone: pass:1 fail:0 skip:0 total:1
     ok 1 test_clobber_zone
     # test_next_pointer: EXPECTATION FAILED at lib/slub_kunit.c:72
     Expected 3 == slab_errors, but
         slab_errors == 0 (0x0)
     # test_next_pointer: EXPECTATION FAILED at lib/slub_kunit.c:84
     Expected 2 == slab_errors, but
         slab_errors == 0 (0x0)
     # test_next_pointer: pass:0 fail:1 skip:0 total:1
     not ok 2 test_next_pointer

In this case, test_next_pointer() overwrites p[s->offset], but the data
at p[s->offset] is already 0x12.

Pattern 2:
     ok 1 test_clobber_zone
     # test_next_pointer: EXPECTATION FAILED at lib/slub_kunit.c:72
     Expected 3 == slab_errors, but
         slab_errors == 2 (0x2)
     # test_next_pointer: pass:0 fail:1 skip:0 total:1
     not ok 2 test_next_pointer

In this case, p[s->offset] has a value other than 0x12, but one of the
expected failures is nevertheless missing.

Invert data instead of writing a fixed value to corrupt the cache data
structures to fix the problem.

Fixes: 1f9f78b1b376 ("mm/slub, kunit: add a KUnit test for SLUB debugging functionality")
Cc: Oliver Glitta <glittao@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
CC: Daniel Latypov <dlatypov@google.com>
Cc: Marco Elver <elver@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 lib/slub_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index d4a3730b08fa..4ce960438806 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -55,7 +55,7 @@ static void test_next_pointer(struct kunit *test)
 
 	ptr_addr = (unsigned long *)(p + s->offset);
 	tmp = *ptr_addr;
-	p[s->offset] = 0x12;
+	p[s->offset] = ~p[s->offset];
 
 	/*
 	 * Expecting three errors.
-- 
2.39.2


