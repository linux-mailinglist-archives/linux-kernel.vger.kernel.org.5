Return-Path: <linux-kernel+bounces-163622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFCD8B6DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04B91F22D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF92127E05;
	Tue, 30 Apr 2024 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8XKojoH"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38088801;
	Tue, 30 Apr 2024 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468318; cv=none; b=HaaMhybK0JepO9Hq0c/BXh94dKFE4DZNRsz7FsGAmr3XgALTkSqg7wCDJOEhTJeRj+zIfWrH734SLpDsGluhF+abHa4w2tcCjjRYZc98Xtwdi19/aP+JGP8vUotOjrkiyNe2VrEKVhQ1Hq1SgPgBBui2yUub45fius7oCJ4VtUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468318; c=relaxed/simple;
	bh=STiwPfQ3FgfC68RgCrPFSAvD0HXwevrsh2MHG2P+BxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=auCcAx+MUYWnRUxhf9/ijDtVPxKByLxgiOhC0AcbfyqJf2pNSlgdxi4es3scTYEvMrVNQWoeb3JFH8NDt2aI3Ac/bmQjGYP0ZHmb6GIysk7AEJvDeNKZ78q+vrOJim1YIkY7MkhNpWMCozHanpq3T0O7nKRx/ZA9rUkeXVxukdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8XKojoH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ec4dd8525cso2231925ad.3;
        Tue, 30 Apr 2024 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714468316; x=1715073116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQBoYvZPsCYcuSR3qK1bJQWQDiuW4fONQZ/4zoSfa0A=;
        b=E8XKojoH6+RoFi5Unum/E7wXNxLCFnxUGOUKtqwXL6hWHEghwshwNHzPnorzEP01ue
         q/Piv16eSTJpHoY5AmmHxHEGNhM3TPF5Av4ftwNRE+L5xo5Bbfif1bTjNnRdWCBBtJgO
         ykWR1JBWzjgzVI0dcYEhsn6zWHPEkOi9qwRyLY52hvMhpuj4cdyr8QKsP3KqbbZJPeVe
         ZlFvEO3SFSbk3kqlOxzVhnDqYN3nZAbKX0PE/MZ/tT7IYU3lxZ0wmN+3IaObX/OqKavL
         fHnzHvP4bTKhTYFtje/mMteSrvP4oCycnvFGWFMDJdLZkOkCL2nkJBjshhdkv9QGRHk0
         Jq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468316; x=1715073116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQBoYvZPsCYcuSR3qK1bJQWQDiuW4fONQZ/4zoSfa0A=;
        b=QQSQv3u/WfeA9EC5KrmQ6RioDpwHIfBAq2Nc/MzD7IPKXGvlYP9kWWHusDPG8BwEr4
         3UthGvzteAMOmIiAZ2ZXvpi4Oc6xPdJUo0fP1tydXzH2nkFvKIkqwmKzIlgioHFxXF2N
         lVl0Dl48Jj279Lbt/dOIp6CnMXkOcQ4dAUccreUMUKMW2igjdU/QbyDDqM9zDWdJEcZR
         cG16NA+9hUMFzTTowy65S9zj84ITi3SusCr02txZ3UQYwH+uK8VOLqfOR3k0AcUAaBWK
         y1ClUUjm6hFJS1IX5hI2vs06u9W28nN03LiFk4lCMG757e8eUid3h8RXl0jpliZ2Vayy
         jf7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpzfCmB9Uj5Eiibn5qkII5RpEgKHqGqQ4KgbNciwemD221cgRb4RvsvoifvTkcfdTIRzGSfB2XCOlKXYQ6U4G5tSSpZJSUX2X/jt++lKPhQtNAwiGUcxLjEI0fAjphfhdC0SP33qjn1Q==
X-Gm-Message-State: AOJu0Yw2eoFw9b6hekYHq0oa2gvLHlUuGUE/7/UgIpb5+dWb3FuygPfY
	5Lvpfu6mryTLA0RFHUYgPfvq2cu/v6F3AxkKbzfzSfcJlh0a+ARA
X-Google-Smtp-Source: AGHT+IGdQj3RvvilGjPqOJ+D1q8N7cU48eNqNv6tzSAfI1/lYpJcwu9FZdy2EjkD8mzyUnt6enes0A==
X-Received: by 2002:a17:902:d543:b0:1ea:c7a4:7e8 with SMTP id z3-20020a170902d54300b001eac7a407e8mr11288084plf.17.1714468315953;
        Tue, 30 Apr 2024 02:11:55 -0700 (PDT)
Received: from VM-147-239-centos.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001e47bf10536sm21845806plb.69.2024.04.30.02.11.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2024 02:11:55 -0700 (PDT)
From: Yongzhi Liu <hyperlyzcs@gmail.com>
To: skashyap@marvell.com,
	Markus.Elfring@web.de,
	njavali@marvell.com,
	martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com
Cc: himanshu.madhani@oracle.com,
	GR-QLogic-Storage-Upstream@marvell.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jitxie@tencent.com,
	huntazhang@tencent.com,
	Yongzhi Liu <hyperlyzcs@gmail.com>
Subject: [PATCH V3 1/2] scsi: qla2xxx: Fix double free of fcport in qla24xx_els_dcmd_iocb
Date: Tue, 30 Apr 2024 17:11:43 +0800
Message-Id: <20240430091144.10744-1-hyperlyzcs@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <9c711441-6e79-422f-9405-ee271929e77c@web.de>
References: <9c711441-6e79-422f-9405-ee271929e77c@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dma_alloc_coherent() or qla2x00_start_sp() return an error,
the callback function qla2x00_els_dcmd_sp_free in qla2x00_sp_release
will call qla2x00_free_fcport() to kfree fcport. We shouldn't call
qla2x00_free_fcport() again in the error handling path.

Fix this by cleaning the duplicate qla2x00_free_fcport() calls up.

Fixes: 82f522ae0d97 ("scsi: qla2xxx: Fix double free of fcport")
Signed-off-by: Yongzhi Liu <hyperlyzcs@gmail.com>
---
V2 -> V3: Improve patch summary and provide a patch serises with two separate update steps
V1 -> V2: Optimisation of exception handling

 drivers/scsi/qla2xxx/qla_iocb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 0b41e8a06602..faec66bd1951 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2751,7 +2751,6 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 	if (!elsio->u.els_logo.els_logo_pyld) {
 		/* ref: INIT */
 		kref_put(&sp->cmd_kref, qla2x00_sp_release);
-		qla2x00_free_fcport(fcport);
 		return QLA_FUNCTION_FAILED;
 	}
 
@@ -2776,7 +2775,6 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 	if (rval != QLA_SUCCESS) {
 		/* ref: INIT */
 		kref_put(&sp->cmd_kref, qla2x00_sp_release);
-		qla2x00_free_fcport(fcport);
 		return QLA_FUNCTION_FAILED;
 	}
 
-- 
2.36.1


