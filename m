Return-Path: <linux-kernel+bounces-128929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A463A8961F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425BA1F25DCC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB75134CC;
	Wed,  3 Apr 2024 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVxnuDC0"
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B524168A8;
	Wed,  3 Apr 2024 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107647; cv=none; b=cO9q+zrZRr0W36WtEoLXactc8XljbLmazy9WNMwZF6avBT8mvCM0MlzaAKSbePtlIXmj55chrk6aRSYvGZ5JD6E3oln6nfljVG3iop1RwmkwmXsJajcGrsjJKQpjZbaacmaRWmfG+TZVNU3Y8tH8kg6TFoGwze66EV4GXyq/U0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107647; c=relaxed/simple;
	bh=gpiz8ytPP4xNPIcRFhDKhFYNxujxRb4J0v0+KGwLOhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gMPcKzwpeJFwNpjU4GZQzOEgkUJYiRlAf4Jn+W9FiGZx9BK+ERLk1T0DYSVRDSHKlWgbNoNJ0exe192oOE7JArvDu3MQg6W1hTPcEOZepHk/U0XpizkChUyq2i5P/jleTVUMdY+oxOZWOY0N8I1qip2jrCt5BAitgzlp0Eo6VoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVxnuDC0; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-5a5272035d3so3489772eaf.1;
        Tue, 02 Apr 2024 18:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712107645; x=1712712445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QgF+noOD10kOlj0U+9VFK/2VpTAYYndo6kiRXQ7BdA4=;
        b=fVxnuDC08rvIXdDsInSahAPw/zX8d721ZLyOBtj+DbyD2de5IJWrn/GmXd54NH+XSC
         nGWAV7l0sfU51qLfqHxRKf2F+BYCTV2c7tSpEySEiH0zVDbGYzxMOnC1J+D3Z1uCMRG7
         u24gWVoOVKOyGiPtKnAIsvP6lu41YMab5sXuX5OWWd8CUN5LfZVzFAgx45b1P6B8khUY
         2DEsL06qWRZ/f/G0eF7s+yJavj5kE8r2Shu3QlqyPZZQp4JY8HTWYeESQWW09iwSIf0f
         dkpwABVuM5IkoB007trBvkCb1PlnU34yep14YRPickAyWpWuA0FUNVYPVEK/W6XMUUjH
         mRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712107645; x=1712712445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgF+noOD10kOlj0U+9VFK/2VpTAYYndo6kiRXQ7BdA4=;
        b=LZ33+59CfcIsBw9RkhK01sXRq380Q8EPyT7KHMdxB5zxqRct8uJm5HpkxvPfVWev0m
         /0JyIVYLfXBAUGgLzVCt/oEyXpiHbxxCGvwSnssSCP+AmIvI2t11t+6FVEY2zLe6K/vf
         KEdg1NelGXEla8StXytW06DATKYeVQ/80x2UfZPmCiGeyDIj9xDTsp60UwvKd10+6Lx6
         SIgu3tqHWAljX/jQv6F6NF0GaMEMM1fflKjKVOScqiXQhnzmsHrzKOplrKlT3qcOanQ7
         GU8B8bOQpJ2it9jfpZxkKJMOKD4gdZSVY+PMo5G06w3ssSh7/vwCUn+Kf1vGWoSRV+7c
         jbaw==
X-Forwarded-Encrypted: i=1; AJvYcCX/nQ9jKALimfg0ghZm2f4d477Pm52Kka/4BOGT1uWV3hi7aIVI7SXTpWHViiFYfp/4sC5PJ3dOFZhC/QysOybibYzicvauWt3ePY43
X-Gm-Message-State: AOJu0YyAj3mVoWygTjJ4m/BB1rOtcM0BxYwJpKKGexEFAuAtFrBwcW//
	MbfRoPabMcTrFQzJj1/94HG83KfE92EzfGode2EtD5OZvYZNZ/z8
X-Google-Smtp-Source: AGHT+IHtWX0h3Qqb90nofrtFDZgM6ojzuJUIsoy8nqk1QL9MdJ7XYyEolKWEcEUTbBV+0DQUVexZBQ==
X-Received: by 2002:a05:6358:5411:b0:17b:f672:4abe with SMTP id u17-20020a056358541100b0017bf6724abemr1260296rwe.16.1712107645033;
        Tue, 02 Apr 2024 18:27:25 -0700 (PDT)
Received: from test-virtual-machine.localdomain ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id l4-20020a639844000000b005dc9439c56bsm10278665pgo.13.2024.04.02.18.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 18:27:24 -0700 (PDT)
From: Huai-Yuan Liu <qq810974084@gmail.com>
To: james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Huai-Yuan Liu <qq810974084@gmail.com>
Subject: 
Date: Wed,  3 Apr 2024 09:27:15 +0800
Message-Id: <20240403012715.3058-1-qq810974084@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: [PATCH] scsi: lpfc: Fix a possible null pointer dereference

In function lpfc_xcvr_data_show, the memory allocation with kmalloc might
fail, thereby making rdp_context a null pointer. In the following context 
and functions that use this pointer, there are dereferencing operations,
leading to null pointer dereference.

To fix this issue, a null pointer check should be added. If it is null, 
write error message and jump to 'out_free_rdp'.

Fixes: 479b0917e447 ("scsi: lpfc: Create a sysfs entry called lpfc_xcvr_data for transceiver info")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index b1c9107d3408..b11e5114b7f2 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -1904,6 +1904,11 @@ lpfc_xcvr_data_show(struct device *dev, struct device_attribute *attr,
 
 	/* Get transceiver information */
 	rdp_context = kmalloc(sizeof(*rdp_context), GFP_KERNEL);
+	if (!rdp_context) {
+		len = scnprintf(buf, PAGE_SIZE - len,
+				"ERROR: Not enough memory\n");
+		goto out_free_rdp;
+	}
 
 	rc = lpfc_get_sfp_info_wait(phba, rdp_context);
 	if (rc) {
-- 
2.34.1


