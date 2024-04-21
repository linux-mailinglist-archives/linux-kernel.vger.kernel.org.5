Return-Path: <linux-kernel+bounces-152647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906248AC1F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BF91C2098A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A80E26AF6;
	Sun, 21 Apr 2024 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="nCGLFlRm"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F8F8825
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738999; cv=none; b=JhW9LLWS/1JxJVeMxyYn4G3nGe1y4dqaXi/zLUF3QWUXHhUuIQtAT1NfcpYxMEiZawhId3/1+B+fWffgF8AZ2QNNPaCePUWy+BfWcaZffjlVNx734KYBQt95NTWarlHAkeztx5bMhNb85YUF7xPLqIl/FURYaaT5xYRIQVaVc6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738999; c=relaxed/simple;
	bh=frxj7VoKufQjlZ6utnq8MUHWksTvQ4BGtt3iQhc+LJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gfn+wK13/oJ6y0FlasnQPm96Bv8FSn2kOXOs0lVAnF6JmPFX7KFK+brIAAwB8qaPkSCLFgLrEOh4JjtAW/ML0bcHKpha1MQEUcnuxKIQ1aVvV+B3wwdyOlUi8A9IK/qZ2BnHoXRBKYhJJptopCBFrfgk9P+sSKv34H2yA71ZqXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=nCGLFlRm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-344047ac7e4so2801994f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 15:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1713738995; x=1714343795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EnYedXI07hAt3dhd+HbGbXf1Rjt+QGaitKZA/KSOMMg=;
        b=nCGLFlRmj5xcxWgRcUByCxVCip37uBts3zRcVenKDD6aZDoi7YTx4GCkWoMIMvzk8Q
         O/9d04smlPW/1HwVN7rsIs2PITB28036EFh6IlpWgaS8NeYTXrgisT6EnhJh1IVSqW2y
         JL+t0UA/ZNqeTcfzaLOntVdi8JfUHDuKz7rqWeqVFH7wPXTX5g7Mg4MjYXlsyB9BCXBr
         dffBmEq2bLOf/o1ryz9h54vgOklAhapnOQLIBYYTaKsxcJwRUjwca5fnrJH6CTS7wwW/
         u/E6RoCNQD0zfNboAVRProin5u/ei0ttfJMT2HRW104d+Ass5VYX7qbsAvtlHACPu/d1
         U6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713738995; x=1714343795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnYedXI07hAt3dhd+HbGbXf1Rjt+QGaitKZA/KSOMMg=;
        b=kxfRcYN9SOXG+nxcNDLm3dpYSwqPi6TMJmYGNhpw0ijYgluH+mcr2puRlPHxz0dyTw
         W3kbJjpjfRtR9j4hwDwg6Y4y5ul9WaHtE/Gn93t6U+V5Pj3UKs5PlNBdxWIoQgM52sgb
         E7PgrlvxJn0eBEl3grT0u+S7GpYaDaxqNYrYbGGjCSJ/uEJzojJ0ZSUgorj83uDNgCGZ
         njRZJIrJNjrnUcxthV1XfoSnRJufZ8748acWWztpElKhFsiC4zHnIVr0mJXcUbzZMZoF
         YfgsA2VCGKrSC8iXhy2MsKxAzPDqfpIF90Fgdngkr7UbXRC9gJl3mZA2GtqtsS+uESqV
         x98Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDCWiVl4FvUEi4Wwx9arnNbZhHjs2sJPILMcKt5tMb60OZOXAK20JSIo96neElgnMByLoH4t3/WLTwj564AfviGaErR/spDRt4kBae
X-Gm-Message-State: AOJu0YyDM3Q4vovk0fvVJZpbJ9e3QUF8nPr4Ia9fege4i2GnVJX9efva
	2neA+Lt6B71KcRKJc3lJPfqetNC8Yb3rN/wJwDMkYTjngUAlCPrIBaQ0zYKPlmhu3n07+GVyaSi
	B
X-Google-Smtp-Source: AGHT+IH3nS05/Y573CAnV+aIotx/7hBYrQJZjbQWPOFwWawFDdMCAUrtYZrRMhnxPkxNiNA4ue17jw==
X-Received: by 2002:a5d:53c4:0:b0:34a:70d:1117 with SMTP id a4-20020a5d53c4000000b0034a070d1117mr8754940wrw.18.1713738995089;
        Sun, 21 Apr 2024 15:36:35 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b0041902ebc87esm11158683wmq.35.2024.04.21.15.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 15:36:34 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] bcachefs: Use format specifier %u instead of %lu
Date: Mon, 22 Apr 2024 00:35:50 +0200
Message-ID: <20240421223549.952824-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use %u instead of %lu and cast the value to unsigned int to resolve the
following warning on m68k:

	format ‘%lu’ expects argument of type ‘long unsigned int’, but
	argument 12 has type ‘unsigned int’

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/bcachefs/btree_io.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
index 9678b2375bed..45dff1a77366 100644
--- a/fs/bcachefs/btree_io.c
+++ b/fs/bcachefs/btree_io.c
@@ -888,9 +888,10 @@ static int validate_bset_keys(struct bch_fs *c, struct btree *b,
 				 -BCH_ERR_btree_node_read_err_fixable,
 				 c, NULL, b, i,
 				 btree_node_bkey_bad_u64s,
-				 "bad k->u64s %u (min %u max %lu)", k->u64s,
+				 "bad k->u64s %u (min %u max %u)", k->u64s,
 				 bkeyp_key_u64s(&b->format, k),
-				 U8_MAX - BKEY_U64s + bkeyp_key_u64s(&b->format, k)))
+				 (unsigned int)(U8_MAX - BKEY_U64s +
+					bkeyp_key_u64s(&b->format, k))))
 			goto drop_this_key;
 
 		if (!write)
-- 
2.44.0


