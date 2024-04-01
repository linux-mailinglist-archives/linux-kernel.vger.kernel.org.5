Return-Path: <linux-kernel+bounces-127141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 960F4894763
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC6F1F221ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2073055C3B;
	Mon,  1 Apr 2024 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="PZ4GPwFB"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D1B8F6F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712011211; cv=none; b=DMt8IoLcu0XRtpewKwuwCXGdPkkRPXy8ReF6adQp8iFyj6nyghmCB11KKTpgcksTzzYR2IxO3ro7Xm9jYaFlx4IIW8BEBWhC7amqMytq9KOg+x6hgb8KpWV4Elaj5yLulf4mo9f79k6Yt3XRqhS5MJf9eyV58M6BiOwG3+OmQGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712011211; c=relaxed/simple;
	bh=bBTc0pqDywUVYcERxbByjYcCqsIlfZ+1R7r4pWnsn6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eOpOewhQ1vR9egidiiOwzl9+6kKscIxuS/lac9JTackCGVMAzvW4DCWuH/VW/r3tVU9NPEPxRrKtb2Uz13XgiOOl8I3cEPeMaPI47X607ZrNATHydFy+VpgFgO0MWODddCTwQUfAdg2Q0Xd+qJxDYfpqdGTyDGWj9lsSkDBNMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=PZ4GPwFB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-568c714a9c7so5233050a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 15:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712011207; x=1712616007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm0/pyPQLpsucp7jeAp4DAwcuzeghtYOnq9ys62dZUg=;
        b=PZ4GPwFBrUlnuQpp17WXQDOYEZ4f9XizY79k0YHyFkLyxvJcZTtzy/tFUe2piPvYR0
         NMqn+8RYXMkO+FrJvSM20qtniDdL7o4dn0DhOdz7T0PWNwNISeKSKSvNOZbQmAXVQkpO
         Xq8gN0PFGfolpzomfrbaiWUQtZ23t6/urWQGIXynGAdFH5S9Xe17S/IH43Ym2z87VJ3H
         QdOg7Uo06gWNkxU31/ngw0JTmD8+M34Tz/Lx0EaAtQrPi2TiG94Q3MYyhEOZSStoKcyH
         +V9fKBwrLf10tfxlKhsQt1pZRWR/4KozzeVLW6QT6Z2vaFINX6jYT8msQ14YzBsrPYeb
         sZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712011207; x=1712616007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lm0/pyPQLpsucp7jeAp4DAwcuzeghtYOnq9ys62dZUg=;
        b=HU1TU7CfRPuCzBiqMxYS4GP7bGyDYasIpjNXS0PyxqzBBF45/SjcutmdvmV8dX1zw4
         jzWRuJJ2ctGKbq94zA/H16NW9xQ0JTtKLbna1xuu2viA6finlywU1IrJ9SMwNrtBk61J
         Ds4OFGNLwEY0sPcEeQ9r8K8YPfuNm7pY/0Ka2MJmXsBA2xMhUJnWWvxweTlAe40w0BQV
         nfdbRuz6b16kaxGTXef2UZSKSClAzorXCtbe2PJ2QfzTaul0a0Ywk+4/VbCvKSpG+/2a
         //FdAAs4Fix/QfmG4o3PkQt9z9d6IiV5eI0Iuts8pADCXa+CdLk/0rm1ECrlxcM2XkBO
         Fb3g==
X-Forwarded-Encrypted: i=1; AJvYcCUBrzI60S5X2p5uPgXCcTfX45f1ojN3N94MwTLkTLQsuoGEReliuLJW7odu0eQRJaX2Yul4KEO/t8S7eSVSAfvgqdhLjMf1WjVwthmo
X-Gm-Message-State: AOJu0Yzw6TzmaX2cs/bPDGVLsDUNFLh5/Vh+UxadxYPGsjYg8RpS2RT/
	xvPrfOUJIEAdpCQjXsDtFctutaCQ8o8zrWvtCJGqbB6NsxPzfIzW2GOFs7m97YWXdQFu1klFn2Z
	zTf0=
X-Google-Smtp-Source: AGHT+IFoemV+XmEcu8XZvJ2xMiDzvl5gB/kFX12BcKB+LRgUfRDX4L91CSMW9sNNTnUkkHeM1Oqj/Q==
X-Received: by 2002:a50:d69a:0:b0:56b:b7f1:80a2 with SMTP id r26-20020a50d69a000000b0056bb7f180a2mr4785357edi.40.1712011207504;
        Mon, 01 Apr 2024 15:40:07 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id z3-20020a50eb43000000b0056dc82d630csm2794763edp.31.2024.04.01.15.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 15:40:07 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Oded Gabbay <ogabbay@kernel.org>,
	Ofir Bitton <obitton@habana.ai>,
	Tomer Tayar <ttayar@habana.ai>,
	Dani Liberman <dliberman@habana.ai>,
	Farah Kassabri <fkassabri@habana.ai>
Cc: Dafna Hirschfeld <dhirschfeld@habana.ai>,
	Moti Haimovski <mhaimovski@habana.ai>,
	Koby Elbaz <kelbaz@habana.ai>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] accel/habanalabs/gaudi2: Use kvfree() for memory allocated with kvcalloc()
Date: Tue,  2 Apr 2024 00:38:17 +0200
Message-ID: <20240401223816.109036-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
kfree_mismatch.cocci:

	WARNING kvmalloc is used to allocate this memory at line 10398

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index fa1c4feb9f89..8024047962ec 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -10489,7 +10489,7 @@ static int gaudi2_memset_device_memory(struct hl_device *hdev, u64 addr, u64 siz
 				(u64 *)(lin_dma_pkts_arr), DEBUGFS_WRITE64);
 	WREG32(sob_addr, 0);
 
-	kfree(lin_dma_pkts_arr);
+	kvfree(lin_dma_pkts_arr);
 
 	return rc;
 }
-- 
2.44.0


