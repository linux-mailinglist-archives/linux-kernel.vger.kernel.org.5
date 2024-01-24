Return-Path: <linux-kernel+bounces-36746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F3F83A5F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB431F2DB26
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9EE18059;
	Wed, 24 Jan 2024 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doHe+Wvu"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E6118032;
	Wed, 24 Jan 2024 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089951; cv=none; b=V2TMRLrp3AH63KDlFvN2SvKv0KVqBc5EYYSL5ESoNXQkcPJ48x0DE2wVt2nXkoZnH0VAtisEpOILOqSgTj+VztA24U5OKpxfS8QAPwjgkx/hmybdtQ85bDi65WKZfORLPwfiqY78OgqzLb0j4/tljqYptUCu3mQj1JrW0bBNuUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089951; c=relaxed/simple;
	bh=s2XlWICd1+C+67plz6lWJk0zQ60c+fKd79/Gm6FZI4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=c7lg7T5f9WZk5N7jfq9UTaIBUWaCAhxfOY9yPI0kb97IjL1brxujwlFnbMP2uLhGMKbxn4L6TYNFtpIyDDZ96PWXf7E0DfVWhtS1hHJ84jIRCQ4t932fYSQPFVtIYFeRHXgwj22hBk3CdMxUb1Ddhcssmb29m7rK+OjBiOIUxC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doHe+Wvu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e7065b692so57128695e9.3;
        Wed, 24 Jan 2024 01:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706089948; x=1706694748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HkC2PRqd6pgF7Zz/Q26hfAQmP6D0KFqOdRxvm5B8X2g=;
        b=doHe+WvuC7uODz+f6kPgdtQcTqo9nQSLS5cCeGNWCxAsI0BPPF1aGQloG7DIFcdkpC
         MM3HWN6gClNYVHum9wvgRS8VrKabh9LmeodJm8zBQRxaGmaOC1tVTG/zq7oEYZsvmCDo
         RvxS6muVRdSE61lFVX74yAQUSnlK9qs6Pe1iC3VHeCGMo1Yc9v9rpx09IgySQIIfGcmT
         DCst1CrCdenzXoU0ld/zf+b6RPi9S+v6IV+wFjlx7ebTad9Qt6SQtCvA3k3XyUq0uzd4
         7xpseLvb1bgRPJz5q8C+duUUmXeXVds7c96B9Z5h3D9uDpqZbQXxusd7jgHElrGgKA68
         oqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706089948; x=1706694748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkC2PRqd6pgF7Zz/Q26hfAQmP6D0KFqOdRxvm5B8X2g=;
        b=VzsbanmA7GuA2bafxXPZt763uudyWTsUHTeEdXjUW6d2xGGLvRvSJxTZJ7N9O1wBy5
         6TSe74UpYuQ3bX0DERpNq/kfgwxlEuqDkgKYSDb3357qb/oM2agpFUoB+BduCJczzgHj
         7TXEG/LS+8efU8VnsDeIrOtrvDN2dMzwr/w2DTDObID1GOAqVlRZ3/oyZuORvcB67cz9
         o9YglHGY7Dqpl21682VJdGerKGpbawYlhqwUQQItAVhXicR5NQV7O3xN57FTkXLXIB28
         5E/E0IzyS+aYBxx1jW98o8xaeB91G+piSapZlJU1iOvcbb4HzJAv+9O6xD1QK6T1JBw3
         nLLQ==
X-Gm-Message-State: AOJu0YxREP9FNYI3B4FziNqKgM7vi+SdWv59NmOhmqkFpBddaF9FuVC3
	LI4UMSMmUV4KRcxs2+Aw69e/fekYY831ksIXFVT41u+nNL4Eua0F
X-Google-Smtp-Source: AGHT+IFyqGGODHossZnnZrv7N55tfyX0G66TbydE69PFWGQJxgAM7c7YKvMVu30vnnQqBj6wkjZrmA==
X-Received: by 2002:a05:600c:1c06:b0:40e:6ba0:de3b with SMTP id j6-20020a05600c1c0600b0040e6ba0de3bmr969508wms.0.1706089947501;
        Wed, 24 Jan 2024 01:52:27 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm44769392wmq.12.2024.01.24.01.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:52:26 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-ntfs-dev@lists.sourceforge.net
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ntfs: Fix spelling mistake "initiailized" -> "initialized"
Date: Wed, 24 Jan 2024 09:52:26 +0000
Message-Id: <20240124095226.3395965-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a ntfs_debug message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ntfs/mft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 6fd1dc4b08c8..69978329877f 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1580,7 +1580,7 @@ static int ntfs_mft_bitmap_extend_initialized_nolock(ntfs_volume *vol)
 	ATTR_RECORD *a;
 	int ret;
 
-	ntfs_debug("Extending mft bitmap initiailized (and data) size.");
+	ntfs_debug("Extending mft bitmap initialized (and data) size.");
 	mft_ni = NTFS_I(vol->mft_ino);
 	mftbmp_vi = vol->mftbmp_ino;
 	mftbmp_ni = NTFS_I(mftbmp_vi);
-- 
2.39.2


