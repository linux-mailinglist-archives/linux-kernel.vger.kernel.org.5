Return-Path: <linux-kernel+bounces-105455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3003D87DE16
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1561C20F7A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F01CAA6;
	Sun, 17 Mar 2024 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="STbt3N21"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D67B1CA84
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710690488; cv=none; b=tC1Kk0g2L3mm/VpIZ13cVBDLqCC3l49q6xPALEdV52KS0MZ9A49fAjCD9y/N6TDvocpaYJtswrnA+J7XDaHR90Nak7DOHNz2nk7xLO9hOLD5rgDvfcaOvF2tmDrhbOCEifNdZkI8WEt1JY4PrvSaVr4ZEdsIvt5TypjwUGsXHiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710690488; c=relaxed/simple;
	bh=qXxDEQtn/XB5MDmUD/l0idw+x9pNLWoaaLD6V9lFy4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARrHYIo5ilv2CE1pYdB5BwnT3qG91cmZVH8Dtdt2XtlePHBSLoM7OUYd9G1bqnfQ3q804YuAigH5Ht4yK2w8QuFr9QpzikrDxsKAfS0NhapIPKnYx5PBRFW2HjAItdo7kOC4GiNyxCwgpahnNHBnAq8z+ZMAT6aXRO6tk6W4N0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=STbt3N21; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e162b1b71so3274929f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 08:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1710690484; x=1711295284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I1/ILuYKRTR9hc7wiDsKsn9WptuOvIHMyzKs0l5GSkc=;
        b=STbt3N21GXRmOTglnRDapcV/wxbkNSvBToaLlBrxtAoMKnxEa1yg97KyA7L0kIL7uo
         34xxt1DA532/lJNbDaSEWj5RxM69zfSGNzGFzoyxAEaa3gdgN4yCrmnK1BztHhy4jddR
         l+oCs0uJFbMTFpAGjLpoUvJ74mFxe4sngU+F3i6uTnOJMwC33vwEhbhyouwI1/dbq5Gp
         gMzkIYj52WOGnZvKMUmAo3t4oJ5usbO1rLpxt4QFd0nWUZowrw3f1gZEs7IeZzoZylpz
         FlQx+4IBfFzR7hgrtzmGC96WP0zLOrcFNoc1hV+jIx9IPNf0Phzlo+FvaOJIff01hKeK
         E00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710690484; x=1711295284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1/ILuYKRTR9hc7wiDsKsn9WptuOvIHMyzKs0l5GSkc=;
        b=uo7SEyWM12CKCDgPdJW8X+mML6mPndMiEwDo47O/SIp22danXKY07dR6EciRzddpio
         W6iMbf9zzL/mWvNLa8GnWu8pt/BBDldj7EApoCzb49bK+D27XNcTNM3IGKVu2qJsSWuA
         JnX/gMfl825W+EabgOAaoYxMt/aqOtiZ1F1d7ZcJD1Vdm3eS/a2KyPrYGbgyWrcxgXXN
         NAIq0LdOkVoejv090LFDPmY594kuUqA33xj4bUP0p8mlU9ILzJ4lY8m9gFpKAufqGJcD
         D0L3J22a11uP3Hx2lvmlVL7BcTT09kdqFXzeThOMb8HNQYZvk22o3XfZ3cRw6jLIudFB
         EWYw==
X-Forwarded-Encrypted: i=1; AJvYcCW859PlhTunhd1rwz4nzDyAghpgEmUJ1AplYbT2miwLRZaAzp5mLfWbBfWDxQrGS5awZAN2knES3WTPs52614cXropPxdHOfKhciL9q
X-Gm-Message-State: AOJu0YzzIz/x+B0LVSKhtha8x5fGN4SlK2RUu2wlEX5zxWLhF4EnFli3
	gxIY+VpX7iDJvF/xciEk4XzgEK8hQjPqCIGC2/Tf066ian3PqWPWImqENemmUzU=
X-Google-Smtp-Source: AGHT+IGAVGv55SM4obM+qSDvbMP4XmlQQ6CPIEt7Tum/LfPyMtRYmGIXVXbJFrvc1kpyB7U6CSeEsg==
X-Received: by 2002:a5d:61c2:0:b0:33e:7750:781d with SMTP id q2-20020a5d61c2000000b0033e7750781dmr6929837wrv.56.1710690483754;
        Sun, 17 Mar 2024 08:48:03 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id bv17-20020a0560001f1100b0033dd9b050f9sm7731246wrb.14.2024.03.17.08.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 08:48:03 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Chandan Babu R <chandan.babu@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] xfs: Fix typo in comment
Date: Sun, 17 Mar 2024 16:47:32 +0100
Message-ID: <20240317154731.2801-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/somethign/something/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/xfs/xfs_log_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index e30c06ec20e3..25b6d6cdd545 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -683,7 +683,7 @@ xlog_valid_lsn(
  * flags to control the kmalloc() behaviour within kvmalloc(). Hence kmalloc()
  * will do direct reclaim and compaction in the slow path, both of which are
  * horrendously expensive. We just want kmalloc to fail fast and fall back to
- * vmalloc if it can't get somethign straight away from the free lists or
+ * vmalloc if it can't get something straight away from the free lists or
  * buddy allocator. Hence we have to open code kvmalloc outselves here.
  *
  * This assumes that the caller uses memalloc_nofs_save task context here, so
-- 
2.44.0


