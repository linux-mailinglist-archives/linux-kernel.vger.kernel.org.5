Return-Path: <linux-kernel+bounces-104199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B52F87CA95
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD47228471A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EEF17BD5;
	Fri, 15 Mar 2024 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUs0E6zs"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5912C17C60;
	Fri, 15 Mar 2024 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494394; cv=none; b=DWj6uLQA7gCQYqtn4JKvQS4ShLH/3VTRcJeWZiZlnWS+ktcphyaYggdvxYI6ziqSMy4H9Gh+NdbwPaybZdz+TDp6/mRKzoyO0khGcQYlewVp97OzxA8A7VD9YQx9ZJnXCSktjTuIGGm0tWCrfDnrWGFM6rFSynXrcBJiersvFbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494394; c=relaxed/simple;
	bh=AHqSOaYNZFgQYet46uTTxEfuRsPs8jM7XyxJUop08WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=j8aGrzcqiCeo8m6/kBv800V1xniXQPQpKhIGDVLaOF1BzS8l8jEskkvW5M8eklUVc/Jw8Thki9Yvk1hR3R8AvKrzLVeOc9MW/h82BjNa2+faHvYvrEA8Vtb9Jj8P56sKOQvZn+ZbgKOpJGehPV36E2RkQoQRxIzuoxnQ01lIDcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUs0E6zs; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ecbe78c3fso701550f8f.3;
        Fri, 15 Mar 2024 02:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710494390; x=1711099190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQw5oNsYEXSP8sYyXUIy+9N1iJwFeZV5w5qJgAdE1PQ=;
        b=IUs0E6zsw1KXD2i4OQ1DhBHVpLVaPGFsNZZStWtfH25dfWkqb2ofRpBfkD4IXhAO85
         VBzZMWbeQfOK5bhCh1nDSmCwlcNwdb19CEtlAxQOpETxUm597OLfnhOU5kbxW0puK6a9
         CKk1IMhUawiLKbRPR7cP9+TmZYVjBWENeH8xqiSEjoUdIDGMSa/L+KVdxwe9tGnKW2rl
         /1AaMHKle7Ou9MgVKL7qc72kckIgTA/6hvkWqEg2um/p8vINjaJommL8Obg/STN1o7Uj
         6H/BxBgZHPw596RGwfjsJ5mQ46c4YOKhFByAMKkWv5wNN9/Kd+H1K1/srFrxl1X2HLNF
         5nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710494390; x=1711099190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQw5oNsYEXSP8sYyXUIy+9N1iJwFeZV5w5qJgAdE1PQ=;
        b=n364Sn5iUqHN47J7oPgn2IDFwHuDlH7rm1QT0pQC05JnMhTLomxkyDO09TStIElN64
         I/MOvydI8+L7F1/EOsmpPEnWEvFYBrJbzdGb4dW2zhuMMN9z85bQ3w0C7j7r9q27KgCv
         kRJnrlbMJw1hN3secbQSxuTbs1PrF2UUsqlISA1oXKEvcdn/bWA62RKmyUOShvJWG5Mx
         FMuGE17SjKfZffBITwKMN7OxrepsmfoDuxNCVnJlG/EgWN9Jp+GUzQ8XEWwax45DMhNz
         H51yhxp+p2SpGRJWrU4ZcI5HchzIiszvpzEt9N5mGjUWPE6TbtEOmRIw6ofiXBuCXtnP
         YzcA==
X-Forwarded-Encrypted: i=1; AJvYcCVNFqQ2D9KLxL10WjjwEiGnE/pzadmkMS3XmTGjX7YrB4hOgPnsdNPbnkP5Wy4nOPDCyqXT6HDLr0USnj+TRqZ64ym8lIKwlVnmgj8k
X-Gm-Message-State: AOJu0YzvSLGI0zsu2A3uJMOggG6xSemVA6Vbq0DZ/PKlgSqyScFKVTE7
	qC0JjB/tYnzZ2Jsbckk8WqwYlrHiaoKXHfwozqB1QQqvmrmIWcuS
X-Google-Smtp-Source: AGHT+IEPdVBZg1VY8jVGSbWV92yzvxfLlvNgJ8Fm6j0v75JcMGGC9XqCOWMIYR7F+cZQf+yjsTfhsg==
X-Received: by 2002:a5d:5750:0:b0:33e:34aa:d78a with SMTP id q16-20020a5d5750000000b0033e34aad78amr3009495wrw.8.1710494390487;
        Fri, 15 Mar 2024 02:19:50 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h13-20020a056000000d00b0033ec9ddc638sm2723586wrx.31.2024.03.15.02.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:19:50 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jan Kara <jack@suse.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] udf: Remove second semicolon
Date: Fri, 15 Mar 2024 09:19:49 +0000
Message-Id: <20240315091949.2430585-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a statement with two semicolons. Remove the second one, it
is redundant.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/udf/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 2217f7ed7a49..ba6b747a3830 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -630,7 +630,7 @@ static int udf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			if (!uopt->nls_map) {
 				errorf(fc, "iocharset %s not found",
 					param->string);
-				return -EINVAL;;
+				return -EINVAL;
 			}
 		}
 		break;
-- 
2.39.2


