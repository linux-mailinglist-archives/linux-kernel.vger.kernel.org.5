Return-Path: <linux-kernel+bounces-158312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544588B1E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DE41C21227
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D754284E06;
	Thu, 25 Apr 2024 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu2Awh/K"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154D28F7;
	Thu, 25 Apr 2024 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037879; cv=none; b=EFdbdm8wVGETxwsk1XsBSuiG+ETAZNkDRxVdwhxct67k4/oiGIaNLhxRVp9N2TwJ27uMQf02T7UELeT87lNtHYOgKJfFo+pkmjIzr06yaZdYca1T+6fwuN5vc3DUH1/Gu7OPC71U+8UqItESXoO2O4oeTJ6MCc5AiTbNbKCymrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037879; c=relaxed/simple;
	bh=B2QnoUC7+LFWaRs4o1LMiByLwNslJDQSlWXTtB7gBKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Evlp9CN6TP0BHwf/gA6qRdokCxZIxeq6fZGGZi2Fdtu9sIwZRi+a4jpVawKxe1sZb+p4jEG4Uxi/e+Eb00cPreJ9M+TbBpoaCckqPN4G8JeHc88vLTTB2ZVFT7XUiQ8c6DmRks6EURhkfhyueSIVGbmMLRfMuQkX0hUanEaLK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iu2Awh/K; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so731153b3a.0;
        Thu, 25 Apr 2024 02:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714037877; x=1714642677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DGzKI3EXkY4x8FVQwjB0FHYCOu3rJrUkYNddsUIIYmA=;
        b=Iu2Awh/Ka6kuC281L6SjyUCRTkiqHdwpi7c6TJ2WZUgMv874GqbkO7YXTR2j3DzFDT
         c9Pq+slq33ZK9RuYFOr9pE5JIIobSRmh5kcGzMoFk8DyMgFWNCxBgzsEeY3xawepdQ6V
         p3NXlKuZRTp0FaPT9vWPi2XjdQ6suekoRiTc870WdKPots+6ZOBrvpZtf7UUJhHWja/S
         HIOsnyjalMOfUICpf5TH+HWB2ZI4Lf8M7SJzmA5J6roNc9j1tHL4w8ILgv86QUAtmpXV
         Y4gCqVbOiCIB5bpVvahdqWJg1WZmJiug1Oq3Yp86P6NHjbBTOUhRjt+lRwGQPoUps9JM
         OtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714037877; x=1714642677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGzKI3EXkY4x8FVQwjB0FHYCOu3rJrUkYNddsUIIYmA=;
        b=dn0ZuzOutgdGWL3Q6aO745+nq3p0pOpV0ue1/4bhPxCDD76Ew9mMdTj1iptaqcXb7K
         pOYIi2zCfycDplrF0VXTd6MI7d9O1j0ye3npBBBKC9Vy5GMld0aZotbBVguOimGluLq7
         vbCA+wOWxswfuQcPBE93WyOYAGS1MrNDhiiIlePr5Qlyak9DrP0UEQUyYTRr/UTRlGz8
         2STnCTDNqYSYbuI5bikQph7zUubGfsyf/Z07FXl1k13GqYyLsgT3Bdl8fPmmh05W6Xe0
         sl9k1d+E/sLjgzwdjI2+eEBmrcIDzKesMgQXWUYoh9d2NRz7c2qF5Ypg4aeZzO4GuUqH
         +qiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL+7aah29PiEMeOgjyW8KACfZg5gVFPYw2DRyCpUgLa2qVOvM+YecCEeOujfno9lWm1Nwf3jX65SROTDti1sbBCofs06//VPzJdRIHsMruCQoe6RmVTMH45lZePiTEVVreldQ8sv065w==
X-Gm-Message-State: AOJu0YyDBBEmKE1MbM0DUT+V17FS4UEta6FlPQZ1GSknJlHT3j6IMyat
	gs+o7xr9qdHQmi5ANVyr1Rv/MkDHBCH0SJVVyS3GcewB2v/6dE/M
X-Google-Smtp-Source: AGHT+IFKAcb89md+m4w+P6J7vPjdhv1NtjyZqxzk8PLc206EV3uuh6oa2kHLHIULqqT3GsbHEbilxQ==
X-Received: by 2002:a05:6a00:190c:b0:6ed:de6f:d762 with SMTP id y12-20020a056a00190c00b006edde6fd762mr6411562pfi.6.1714037877239;
        Thu, 25 Apr 2024 02:37:57 -0700 (PDT)
Received: from VM-147-239-centos.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id u11-20020a056a00124b00b006eab7ca005esm13209145pfi.18.2024.04.25.02.37.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2024 02:37:56 -0700 (PDT)
From: Yongzhi Liu <hyperlyzcs@gmail.com>
To: skashyap@marvell.com,
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
Subject: [PATCH] scsi: qla2xxx: Fix double free of fcport in error handling path
Date: Thu, 25 Apr 2024 17:37:44 +0800
Message-Id: <20240425093744.22207-1-hyperlyzcs@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Fix this by cleaning up the redundant qla2x00_free_fcport().

Fixes: 82f522ae0d97 ("scsi: qla2xxx: Fix double free of fcport")
Signed-off-by: Yongzhi Liu <hyperlyzcs@gmail.com>
---
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


