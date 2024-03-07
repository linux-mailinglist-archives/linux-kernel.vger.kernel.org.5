Return-Path: <linux-kernel+bounces-95372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D9A874CD6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D764284911
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3761272DD;
	Thu,  7 Mar 2024 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijV14Ast"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194DA83CB9;
	Thu,  7 Mar 2024 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809322; cv=none; b=T+5MQIob5XiaurgZZi5YAFpmo+udrgqQa8afUG0eCuu9jS3QeLpHMjqfK2Lg7fk9qXCafhCfwKg+BK5rbF0dzlZe2svSbI7lw+xFaeeDlBZ4juOsjvc0Dr1xrRp+LWY7E1NqPzJH/fimM2230EOnTXxTCDriYLRBfWPziIAmYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809322; c=relaxed/simple;
	bh=eVUxeKBul20q99W88g/mh79eyjn/aApiFy+KxNMo8PY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mb23Y2iEiGq+udJPuCEOB8KBtOGLASeKaYIuSr8ylhoLyPknzkhOJlcA5FCRTddMbF+8STkNJierMr1b760V5QoArpH+Mx5OHmrqOSMr9vIYgF/ITpTJIG4H1wV/qimUBht1pF2pPBvpX23ZIFUJJSpDlv2fvvtaKNtl7mCUp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijV14Ast; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412f1ccf8d8so7106135e9.1;
        Thu, 07 Mar 2024 03:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709809319; x=1710414119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OVxCAgmtfzVnrg1x3qpcTUSpcMueI2D1M8zr46ervg8=;
        b=ijV14AstDMncECeTmHwh0XE0OynwQ38t/0OGmpRdW3vNE3huf4dVX0QLOz7SXB3D+v
         a1j7STWf5xhf17m8MZZC7cEgS3RNiqyhiY0C4MLQDcwXQPm8DlSGuswiRneCh3YVuvSz
         wWp8D7/ygNb/cYoViErOTlR4DOOSrGlToqo+f2yotBjVcxMKSgaiCRdgbTlJR4Zh8YWK
         0iHsrRyX3afUndkc2eseQXpndvJxC/tY1Nd0teweLRQmArlXO3fH63yOTsXIgjaZXhvt
         0THwm061GMfhkllX4kh2++RNXvrHobGe5m9jCrfIrI229ndIzYk2pbSkd5AJenr/PTwy
         Z6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809319; x=1710414119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVxCAgmtfzVnrg1x3qpcTUSpcMueI2D1M8zr46ervg8=;
        b=HEQ8gCEltHmg646KxGcmQKjsnpbn+FaLQ8UgIIVM8KzcooGGdJmlVnJLJPzHn8rBJa
         NaEw12f6+43BvUYSCKaV6pVsxUyxNT1lyDSyC+74V1PX4f+u6EaKC1hNDZ7+0jAou6jb
         alLFSkxKtQwLTyy6AazY1h3tCXaMc/L0cPXKMTCahFgpE1ldIH/tQxMlkj0FrygO1QLr
         yyfHy97HmMiCIq/8S5z1jzFIdldUSauJSVUaGL8Sp05uN1FJQd03GPvqsC5WxzsPUkex
         LByqbRftUmUuCELkVlITIHIPDvPuFjCBNm3XA3yXvHkJTu/IMFKnehtOBsQ1jED3PiOI
         iUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDfXmweqgS3fugxlp63yzEvylm/3M6ROYksZqHFasQpqj+9F6gmcXn/8Edf/TOHl3XktSco5RBU8aQ2vTpprhBJ80uDdG4IPpWR9BH
X-Gm-Message-State: AOJu0Yxe/9GeA3pI981OL0AQgQr3jxdhP+CwtJi72qqrWV1wwvrmQF2E
	s1z8GQFbMBxlPBszT5XuLXfb5h/H/0YGIHJJvbs870frnrsoXBE/
X-Google-Smtp-Source: AGHT+IFLyuScgDC5qSvBnfaovh6jHiE08ApmLOiTh8dr5gaSz2ndkCaFTchxRoN4I24dQevFNBNhRw==
X-Received: by 2002:a05:600c:548e:b0:412:e4f6:75ae with SMTP id iv14-20020a05600c548e00b00412e4f675aemr7518549wmb.32.1709809319108;
        Thu, 07 Mar 2024 03:01:59 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id fa18-20020a05600c519200b004130c1dc29csm2285249wmb.22.2024.03.07.03.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:01:58 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] nvmet-fc: remove unused functions nvmet_fc_iodnum and nvmet_fc_fodnum
Date: Thu,  7 Mar 2024 11:01:58 +0000
Message-Id: <20240307110158.1981401-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The inlined helper functions nvmet_fc_iodnum and nvmet_fc_fodnum are
not used and are redundant. They have been in the code since 2016 and
never been referenced. Remove them.

Cleans up clang scan warnings such as:
drivers/nvme/target/fc.c:177:1: warning: unused function
'nvmet_fc_iodnum' [-Wunused-function]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/nvme/target/fc.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index fd229f310c93..a19fa50c840b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -172,20 +172,6 @@ struct nvmet_fc_tgt_assoc {
 	struct work_struct		del_work;
 };
 
-
-static inline int
-nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
-{
-	return (iodptr - iodptr->tgtport->iod);
-}
-
-static inline int
-nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
-{
-	return (fodptr - fodptr->queue->fod);
-}
-
-
 /*
  * Association and Connection IDs:
  *
-- 
2.39.2


