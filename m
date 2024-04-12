Return-Path: <linux-kernel+bounces-143424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B45138A38B4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4380BB21F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05264152501;
	Fri, 12 Apr 2024 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="OXhuK2Xd"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F0B4C6E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 22:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712962800; cv=none; b=mt3t0R3kNTZgvVHm0fZ+7+hLcrTFCd2ZPTokkGNoy+s5rWuMpZ6P3QWJSkpnijsjLcvQH0SV06K8tDI+5g+TT7KK8B0jfxMF9+2FqxskVS3qNPpvyaznOW9omgk4j5IL8N+C87bDCqfZLOe8ZhPmvoJpQ1pxLveoUUzW7nvkt/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712962800; c=relaxed/simple;
	bh=rIVLVW+bBC8yBZ+b5m+XxQOExL9qTEAzQR7f8WMxTbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MakUFGmkCZkbZi8OSNLhvX5VIfhcgdk4V6G2LBnVrsnZyBF028IXabLshkP90Ro2or9tuG7uInBfHAwfWmWBzqkDyaA5ayKzFdPjsEdyp5GNvcJ3ia+IKbmCMX99HDvn2L02zkV9H0oSaGhsgFCJ1W8htOnbArBZPWYqfK+8uis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=OXhuK2Xd; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso2002287a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712962796; x=1713567596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJcj1JKbQx+AdrQmxw/BRHT0bI3Fvgh3nQKiMBwJNls=;
        b=OXhuK2Xdw/3OExhs2adnC9oEdteocQnD/r70QrkfiMmHBZs9r+ghj0hDlE6fCjuGw+
         VHm9S9N+7srgjT4tRFMNKR+aIb6XRO1DCE/C8U3RGlgXrfgnu8rAIVnXm/JnapNAIIm5
         OtojbNJLRFoOeY1dZPnxL1qHHnY5H0oC5TLOmeMadCIDDFw6GvkPYo9Y+BJ4hGuoRDVo
         ZwaAtgMqyMS7/vhgOuXmNLniE+ZhbkiC7mYTvhIXsV0sTeiCIQ3rNtjoT9znwPHvbZzP
         UrqvVQAFIqnboqkCB1ls8eJEg7Xdx6Mu578M0zVVa/dccrO/KfpyPelndY3lIUN0Kw9l
         hNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712962796; x=1713567596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJcj1JKbQx+AdrQmxw/BRHT0bI3Fvgh3nQKiMBwJNls=;
        b=GBalnqMbqhcI+Y7yUD3iJ/q9iPDBH3gcBItzkJ4HMPbZI7ByISx9KhnitcraMViLr2
         E/Se+YwLgiYfNnGRqVZwHXxxujSWH4YFp1QuPqbUpyyfGYzZKSLcSuLKYy3X8oKjVNuk
         45Y1f0wXk8Z5c8oqJveHo3DWahRr+DD6qBoIIJGwEhjKZ79BYJyqhtHmxYmUNmpMBPo4
         zPOwCipzNXUlTgdeSYMi1I8NRbPvoV57UwZqyrqEgPO3izhxGs4RKbCu02ZzBTsNJLCc
         bi6AuD/5Q7uDSDu3Nsgm2nnoWIMXwCY9W7h9GCoTivlLnbRoJwc2lwZMeL5dNiF4iDv3
         zBrw==
X-Forwarded-Encrypted: i=1; AJvYcCWgvSUmwkqsTNVr+WbjNQWrnlco2jx0fBchSFDhpmBE8j70FWJIUhgGCdmPTC4L+ZMP6JTcMa08m3cCtYTovDyOC+wD4uJQ0oQH5okC
X-Gm-Message-State: AOJu0YxFdSeSK3jfq2tMLXi0+9+2TBPZEN3gyCU+eBtSxF298b8hcTog
	CCKfcvNKGYlkELeb1dOTFijwD5s6tKPPMrZZIavaKut/0Dn1ekFK4FZHBM0Lzd/ioYOy/Zt+GZP
	uVc4=
X-Google-Smtp-Source: AGHT+IFebvfFfbPWloyVBdwUmNBWmPXHhouUUYh8/lIBCpO38VbFe0rG7TUm9UaWeT51bMqWZYUWcg==
X-Received: by 2002:a17:907:3ea7:b0:a51:d522:13d4 with SMTP id hs39-20020a1709073ea700b00a51d52213d4mr3442381ejc.52.1712962796149;
        Fri, 12 Apr 2024 15:59:56 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id by20-20020a170906a2d400b00a5233cd49e9sm1295603ejb.188.2024.04.12.15.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 15:59:55 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: rdunlap@infradead.org
Cc: chandan.babu@oracle.com,
	djwong@kernel.org,
	hch@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	thorsten.blum@toblux.com,
	Christoph Hellwig <hch@lst.de>
Subject: [RESEND PATCH] xfs: Fix typo in comment
Date: Sat, 13 Apr 2024 00:59:27 +0200
Message-ID: <20240412225926.207336-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <33c49440-8706-49e7-8bff-5df1cc828034@infradead.org>
References: <33c49440-8706-49e7-8bff-5df1cc828034@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/somethign/something/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


