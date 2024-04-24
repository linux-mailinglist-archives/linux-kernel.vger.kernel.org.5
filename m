Return-Path: <linux-kernel+bounces-156542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D758B044E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003F11C22934
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1959815887D;
	Wed, 24 Apr 2024 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htFAcOYx"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA8157468
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947266; cv=none; b=jd0CaRqPha2hye8k2z14SrBAmzPzVYJXxrlZpV4vSSOF9i+dioizxRLKNQMa7pxygh7Wjgsj6ZCPAFllZMaf7v5fObWGkJZHUNUR9IZG8KOMNYm0g+9b8FgqvBUNSU3EMx7D5KBORjaeLCAjWh4XWtP3wkRQodOBy9Ypf5+LbJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947266; c=relaxed/simple;
	bh=OQ+hmKTwXPrA+yD3pv+rHIFJPSnVVGjA4gEpLSOo7fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Et4HzzHhjWZ3+SULiFFhOc/BrWSn2/cZ8c8p3C6G/IdyM6qAHLHsxWxZcT7FUMKMiINt4hFnjxtf0V62lc7NIOCCluig9VcR+/s9NNS1Y6h8EYSV9dVjYGhIurddLOcFv6bGytFUKMXWW1MzdWK6I+mf0RWotV8Zjdo4a1FlfuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htFAcOYx; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a53e810f10so4380914a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 01:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713947264; x=1714552064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyVLkZK5IAK4Hkz5uf7S362I3IR+MhEiIFxo4lPf7kQ=;
        b=htFAcOYxT4pYqYp8FiC5JwXMgWswiRUBG11VmSTEYOgZdG4PMh5Iau4+IlXcZdMASt
         W8abzE5h1z6/85fIvYHHxxvKFjtlDJKrlw4DKBHCqVCxEcLjtbrITScACsAeS4ZnjenH
         2+btHWdRgF7YqWcLUQR1Vuuus4shRpJoaydafpsCgF3mjd++0OCIo4P60q2CUxuZFya7
         AUO9YqAu4ses6XpOsPAt20cx+ug16BRCMEN3YShbJTDMU/hNfyiaP9PjScBvW4xWKp+U
         afHgyva0F2oAl5xAM8dH6jjV2irJUTTxL8q8WXZOF2gNoQ97dh0aLzAbLf0aFO7NMKze
         v82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713947264; x=1714552064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyVLkZK5IAK4Hkz5uf7S362I3IR+MhEiIFxo4lPf7kQ=;
        b=wfwm3xq+lUzWz6unYFX21rIU+pNi3Js2WqjRh9QHKw7ooRSxSyswez/44uqbLk8kcQ
         THZKsCPG/7XYbU6QaLEXdTcnWbYtZOlHo79Y0Y6wpxigbMR7HfQX0cvSb3+NBKr05ndo
         9K4sSBFJajn0KuxfqCfrm6CA1vnnc7mWJVqLOpvt4ibpZd8FVrG1lisOksXKpnVEXu05
         Aye6160OmWowQwr6hg0+xXPUcloZV/Bv5nTxMsrBeZ2wWcV6qteJOOnRIMiU11EI6AZ2
         47+YcqH4KpUvcHXyZNDpW1V9azw8MQfLZ0XkV2yvDpmuP9C756Xj3OfIfKHp0APKyRdC
         ZQVg==
X-Forwarded-Encrypted: i=1; AJvYcCXiynYZqElLdGJIAgaI5j1Lx6Jc2agOwLhxlxZ69pU8xiCrOpFGPazUkK10x3CKCIqqZudDWphKil+XycssMeAZgRoIKVcLrRFS9Il8
X-Gm-Message-State: AOJu0YxIFmr6YtgpWUdMu/cX2jyl7IqJgwlZ8X4UIo5MibPBbYYOzm5U
	qy/3ICpFeqgEv6ugEpTeZtsaalG2By3GzEDX59gDBFHdcX0VbZ8y
X-Google-Smtp-Source: AGHT+IGTK7wGhjw3HCy3pFp/GPitVMREtq2Jpo9FuF9PO8CrTRQirInQGMN99/thrEL2mGoJVfYMcw==
X-Received: by 2002:a17:90a:c909:b0:2a6:4293:f88c with SMTP id v9-20020a17090ac90900b002a64293f88cmr1555035pjt.16.1713947264144;
        Wed, 24 Apr 2024 01:27:44 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id p18-20020a17090adf9200b002aecaa2aebdsm2328200pjv.20.2024.04.24.01.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 01:27:43 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: dennis@kernel.org
Cc: akpm@linux-foundation.org,
	cl@linux.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tj@kernel.org,
	ytcoode@gmail.com
Subject: [PATCH v2] percpu: simplify the logic of pcpu_alloc_first_chunk()
Date: Wed, 24 Apr 2024 16:27:30 +0800
Message-ID: <20240424082730.99945-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <ZiiUoC5NokdpvDgN@snowbird>
References: <ZiiUoC5NokdpvDgN@snowbird>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the logic for hiding the end region of the chunk, there are several
places where the same value 'region_bits - offset_bits' is calculated
over and over again using different methods. Eliminating these redundant
calculations can improve code readability.

Additionally, there is a lot of repetitive code when hiding the start and
end regions of the chunk. We can consolidate this logic into a function,
making the final code cleaner and more concise.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
v1 -> v2: Optimize the code based on Dennis's suggestion

 mm/percpu.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 4e11fc1e6def..d22b317f3d41 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1329,6 +1329,15 @@ static void pcpu_init_md_blocks(struct pcpu_chunk *chunk)
 		pcpu_init_md_block(md_block, PCPU_BITMAP_BLOCK_BITS);
 }
 
+static void pcpu_chunk_hide_region(struct pcpu_chunk *chunk, int bit_off,
+				   int bits)
+{
+	bitmap_set(chunk->alloc_map, bit_off, bits);
+	set_bit(bit_off, chunk->bound_map);
+	set_bit(bit_off + bits, chunk->bound_map);
+	pcpu_block_update_hint_alloc(chunk, bit_off, bits);
+}
+
 /**
  * pcpu_alloc_first_chunk - creates chunks that serve the first chunk
  * @tmp_addr: the start of the region served
@@ -1409,27 +1418,15 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
 	if (chunk->start_offset) {
 		/* hide the beginning of the bitmap */
 		offset_bits = chunk->start_offset / PCPU_MIN_ALLOC_SIZE;
-		bitmap_set(chunk->alloc_map, 0, offset_bits);
-		set_bit(0, chunk->bound_map);
-		set_bit(offset_bits, chunk->bound_map);
-
 		chunk->chunk_md.first_free = offset_bits;
-
-		pcpu_block_update_hint_alloc(chunk, 0, offset_bits);
+		pcpu_chunk_hide_region(chunk, 0, offset_bits);
 	}
 
 	if (chunk->end_offset) {
 		/* hide the end of the bitmap */
 		offset_bits = chunk->end_offset / PCPU_MIN_ALLOC_SIZE;
-		bitmap_set(chunk->alloc_map,
-			   pcpu_chunk_map_bits(chunk) - offset_bits,
-			   offset_bits);
-		set_bit((start_offset + map_size) / PCPU_MIN_ALLOC_SIZE,
-			chunk->bound_map);
-		set_bit(region_bits, chunk->bound_map);
-
-		pcpu_block_update_hint_alloc(chunk, pcpu_chunk_map_bits(chunk)
-					     - offset_bits, offset_bits);
+		pcpu_chunk_hide_region(chunk, region_bits - offset_bits,
+				       offset_bits);
 	}
 
 	return chunk;
-- 
2.44.0


