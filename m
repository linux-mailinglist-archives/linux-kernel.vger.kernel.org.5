Return-Path: <linux-kernel+bounces-33121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D18008364F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C81B26196
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411713D564;
	Mon, 22 Jan 2024 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzS/xlOL"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615723D3AE;
	Mon, 22 Jan 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932137; cv=none; b=LfZbLk9bytilJ9tEtIaJkwuyS5DAPXUGpNTtbiZLFmH/aUjgvfqLyOoLXzEt0y3jPEO2M5mfXYn8Al4buSiQIfKWAeFe8KaEtsNxeigpbb78aNoZRxhKXZdCXt3rpnTJ5v2eYWP6TRHE+qXD7If/VnoPtplsAURD1zuJ2Hduo80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932137; c=relaxed/simple;
	bh=2H4lFZS69C/XBONPgR70jIXsN2kH5j6TPru8M4UOQUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dPRK6as0uGXFiF49gL2CTad3qx/fEgtCQkfMCDrZY4txlTRv6i2EHvBRVpxjP3a3o3JHEcD7B3MqjCVJzroL18XVaq2QHBQZyPR2scJcIPr/DkHslD3Ij4Wx2RDWF5O3LNuZPqE8WKuRmpPe5uz8BOP3KJy/I/c4m9YJQj2efq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzS/xlOL; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dbda9a4facso536894b3a.3;
        Mon, 22 Jan 2024 06:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932135; x=1706536935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3saB5AnYd5a6SwBp3LUujaI+Q8bdmZIuksz8EpNWVpk=;
        b=hzS/xlOLYq1jZYZ6ihK1V70UF1jIY+qMYlHYtw+sjway6PlG4xhdOh6Fe01KJG4lK3
         rru/ikZ26uOhMDFvacs3Qb9qtJ2rGYH79KX29dCVpLKvx2w7u3tfhdRAYgLBug8hSL5+
         tzYcW0RKVbPb1yCIWFUisQArca2Fhn9uNdQ9twEDx7R97oiucj0Q7lucJcsWjGLHsuSR
         C75E8a+yeE3Fh01mYKK94FFnuD8lD7L9N6TKbK0+tRXHKx45O6YrVTK1whxekf4gKhy+
         s3rj7wNOaE/DFtS4QAKtknRT4YRNkCUXvKZ4Jn3vNUK5a5G54TYGbEq0pLlKwfJVlIfL
         ADLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932135; x=1706536935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3saB5AnYd5a6SwBp3LUujaI+Q8bdmZIuksz8EpNWVpk=;
        b=vYkJXlzkqB8rhWARzTWursBpT8cTnMHAdtTo3DZcxPyi3mljte1cY+vsbsEOUoyA12
         vL7fefU5QRXEMdbEBkIGVvaKnz9sHCaC4CbAQSukNJOVGINyBu9EQgaFg9gKoQr2799E
         61vv1Nb6yrotgVEuCa4gEC3rpgNVoLh5RUzeUsHzQqq8uzIHway/h5n68ApN0hw8NbF8
         nZGvtlBzGfTbOyanD24MVPRYcybbSG4hMgkG3FBj0nDtirKS/Zh8HKmKXu9REp7Jlnbq
         ZfJBZBAZN6Xoi8bdAIcTACbWOoRRn8k/i9w3HBehcRWBVeqXIEq9rUtaGPzWLETmr60i
         4E9g==
X-Gm-Message-State: AOJu0YzUziCVrBPQoEx1hdIQLKuw/rHIKvClHGSukfMIi3RqK4GcK1Pb
	cuAcZhAXoinUUjgxKxDwQ4Rf5WJPIVH+5nqmrbyUdcVv1pJ2VdBd
X-Google-Smtp-Source: AGHT+IEgsc3djFTFny58gr9cIUPawPb9DoRNWpB2eJWgMYGXwAetzri5V58ysQB0T35kHliBbno1xg==
X-Received: by 2002:a05:6a00:1c9f:b0:6db:cf40:3ab8 with SMTP id y31-20020a056a001c9f00b006dbcf403ab8mr1448379pfw.21.1705932135266;
        Mon, 22 Jan 2024 06:02:15 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:13 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] nilfs2: convert segment buffer to use kmap_local
Date: Mon, 22 Jan 2024 23:01:49 +0900
Message-Id: <20240122140202.6950-3-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122140202.6950-1-konishi.ryusuke@gmail.com>
References: <20240122140202.6950-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the segment buffer code used for log writing, a CRC calculation
routine uses the deprecated kmap_atomic(), so convert it to use
kmap_local.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segbuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 6e59dc19a732..dc431b4c34c9 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -220,9 +220,9 @@ static void nilfs_segbuf_fill_in_data_crc(struct nilfs_segment_buffer *segbuf,
 		crc = crc32_le(crc, bh->b_data, bh->b_size);
 	}
 	list_for_each_entry(bh, &segbuf->sb_payload_buffers, b_assoc_buffers) {
-		kaddr = kmap_atomic(bh->b_page);
+		kaddr = kmap_local_page(bh->b_page);
 		crc = crc32_le(crc, kaddr + bh_offset(bh), bh->b_size);
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 	}
 	raw_sum->ss_datasum = cpu_to_le32(crc);
 }
-- 
2.34.1


