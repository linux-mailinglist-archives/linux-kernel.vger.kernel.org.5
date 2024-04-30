Return-Path: <linux-kernel+bounces-163623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18FF8B6DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30455281448
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453112882D;
	Tue, 30 Apr 2024 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADwR8ruy"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B96912837E;
	Tue, 30 Apr 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468321; cv=none; b=IAlSu1z9IivQWlvi0nwFlCIGNaLvdIi7hs2I5jxUAd0GvVf7BY3cc8stpUIEku93KhHfUX92zyYYKjjvDDzQHBRSgNpevWCzxXHxbx/Ax2lq0/O88T+abVjp9lDm9yRzeKfJvgoX9KY3OkCehVeSj1a10k5mAj5OLiNMOwAXm0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468321; c=relaxed/simple;
	bh=v4A0+zB+bgfLv7B2Shkzwh+aLCop35/3aLd00MNBlW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GFRiBGoFqF3/dyQlS6t36PG8G2Dn3aN7rewQsxxCYGXhQdwRtwskXNVPwX/ni+3mV0NlZCCYTsq7Zw5apgFaTUGhQ/yfe0Uyxj20s1k7cZ344uGeTg/q0Y6j5MQU6ozAs0DEZ22C9rJbI5SPnbhbCaJ8G2vCuVll9ebunP7nuKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADwR8ruy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ec5387aed9so1787685ad.3;
        Tue, 30 Apr 2024 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714468320; x=1715073120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0z6Ou6PFGBqj/BLnd55H4THR7b5BFV54qKTEzG/ZWXM=;
        b=ADwR8ruysKRAct921l4zl8TSu8WVS9RQPpMbfMCPiU7NDPMpx4Bbj7OhRgeJI8qyy5
         RFji0JTmH7eLfoIwy1zgyY4XsQD0TYIzQIwDh+T4HMfISlBBuxZCQpFMqXuOwpJGPbuv
         2Wqfm1uxJQEN0b0vG0ToAtGXCrlTpfqhO1htIJvXGUVAtkS7LnSGw5Iyh4mj18m3HJhC
         185mvJqfwLUijrIapiR66jozS+EnClHJG3OXXpMCmvsR+38rRZ2lntKXl6dZcYeEwm/w
         HNuk0ztxS165KURiVXpnhAjrlOnf3LfAYeSscLTFpl4d068Pq0MP1+igDf7czUiWAEcK
         BdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468320; x=1715073120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0z6Ou6PFGBqj/BLnd55H4THR7b5BFV54qKTEzG/ZWXM=;
        b=wGBk7nc0FX981xF95QcW66LCNkFwMsDYAvXU/IN8sZ0+kBCvixoDqlV4rSp3G2oFQ7
         ygo6SAvCoCJ6KObAq3OVu0d1163GBmlbAO0M4wbyxItATNb7B0MSIW7vunbLwPzTz7wC
         MI8VkFawj1tkj/B2pD3fyHL1joj3i4dw404W+BRAqd0VEHafmFKPOjDDJ1qAp+Q3x1ly
         cyrWlSKoOKmSAzsLLVEjhtFey4WdJSA1YlhSiNP+X6XZ1gPOeJO6cTRj9VwFMr7xqEVt
         JIflSCVNMtiRswg+NRKKlfNNAuw+iA2KhQFnyx7XIp8qOQ73mHY3W3O5XFvow9E4+jll
         JcJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJEFt88INOvsKEapsd1+Uug0HcNoRmdZ1h9ZITmijUMpTAPAkczZobm9ASSPYssOpqyLOrN++S9iJmVQ58G5i84soHZGlJXF7FWu7vK4Rp7YrlTWcJ0t+gB75vxc0WFVNa3z2Al6P25A==
X-Gm-Message-State: AOJu0YxCBct3ePM2Ore2IUrq5o6iSBrpYtRDx0c9Dv4ENEJrNPNKwf+B
	+2UR6q/2/PGkbu+JnKndT+FQJcG5tKvuYsR9GFrNSp9WYRtU37kg
X-Google-Smtp-Source: AGHT+IGWffpy9LYMK7EyQUIMaIoclMALmLM4JYJSZshdxPdlw9eSpSoOHwyr7kDPFOZSWNn975Q5pg==
X-Received: by 2002:a17:902:d2c8:b0:1eb:1462:1abe with SMTP id n8-20020a170902d2c800b001eb14621abemr14410845plc.69.1714468319983;
        Tue, 30 Apr 2024 02:11:59 -0700 (PDT)
Received: from VM-147-239-centos.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001e47bf10536sm21845806plb.69.2024.04.30.02.11.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2024 02:11:59 -0700 (PDT)
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
Subject: [PATCH V3 2/2] scsi: qla2xxx: Optimisation of exception handling in qla24xx_els_dcmd_iocb
Date: Tue, 30 Apr 2024 17:11:44 +0800
Message-Id: <20240430091144.10744-2-hyperlyzcs@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20240430091144.10744-1-hyperlyzcs@gmail.com>
References: <9c711441-6e79-422f-9405-ee271929e77c@web.de>
 <20240430091144.10744-1-hyperlyzcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid duplicate error handling code a bit more, use more common goto
chain in qla24xx_els_dcmd_iocb.

Signed-off-by: Yongzhi Liu <hyperlyzcs@gmail.com>
---
V2 -> V3: Improve patch summary and provide a patch serises with two separate update steps
V1 -> V2: Optimisation of exception handling

 drivers/scsi/qla2xxx/qla_iocb.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index faec66bd1951..a3a3904cbb47 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2749,9 +2749,8 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 			    GFP_KERNEL);
 
 	if (!elsio->u.els_logo.els_logo_pyld) {
-		/* ref: INIT */
-		kref_put(&sp->cmd_kref, qla2x00_sp_release);
-		return QLA_FUNCTION_FAILED;
+		rval = QLA_FUNCTION_FAILED;
+		goto put_ref;
 	}
 
 	memset(&logo_pyld, 0, sizeof(struct els_logo_payload));
@@ -2773,9 +2772,8 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
-		/* ref: INIT */
-		kref_put(&sp->cmd_kref, qla2x00_sp_release);
-		return QLA_FUNCTION_FAILED;
+		rval = QLA_FUNCTION_FAILED;
+		goto put_ref;
 	}
 
 	ql_dbg(ql_dbg_io, vha, 0x3074,
@@ -2784,7 +2782,7 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 	    fcport->d_id.b.area, fcport->d_id.b.al_pa);
 
 	wait_for_completion(&elsio->u.els_logo.comp);
-
+put_ref:
 	/* ref: INIT */
 	kref_put(&sp->cmd_kref, qla2x00_sp_release);
 	return rval;
-- 
2.36.1


