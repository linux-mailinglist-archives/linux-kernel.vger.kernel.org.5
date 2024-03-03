Return-Path: <linux-kernel+bounces-89683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0722286F41E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 09:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D03283056
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 08:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C25AD48;
	Sun,  3 Mar 2024 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URdqFMO/"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A69463;
	Sun,  3 Mar 2024 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709455807; cv=none; b=b/izIhpN0mRTpI84OFvXHWVk5ttpIfNyIWsCbP3lvYYEfJ5SbNsQQ/oAyEacl4koK3NB91sNcXsrD9MpQMzs8bD9iHMGGLfah1biMhi4Jg9Pz6/XoHpJ3EQCIIwsgkBDaH+2P36l4hHp0DKLbU8Fe/3DQEwAEchKBBVZL1KjgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709455807; c=relaxed/simple;
	bh=Yj6iX0LL5X90eG+2pDyO+Qzz9M+jP/NmAc3mleyIkZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OuR/6RFFgi2gi5e/ZPoZUt2AQz8+hk7ykU90YUqXwet8575v8tHE09t5suTAePcz2IjsQ5wyi5oe3033CFQIoj31QohomVoH6Iii9+IO0wrTG0IYNlbKs/6JFA9Ax04JH53RNYjjm+9YTU2leky1rkoiXCy2cRDnt3d/lh2VXug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URdqFMO/; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a127c1feb0so242787eaf.2;
        Sun, 03 Mar 2024 00:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709455805; x=1710060605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urYDUe+DtMbYmGQD/lY83L/cyDLHJDDpcAruR8ELVew=;
        b=URdqFMO/AbYQH/M/+VNWONSUfdcCT6L8m0Xp83S5ivtp3fDIZmYZdQ1U8+DfjdLoZC
         G4CMZjXZlDa+Qycgq+6UK8GBKfs6LZdEyvkq72f3cN1lt+EIK122dIAIuWE3x6XlyLZt
         +D56BkqSKE4bt3C8Leb2U0OMajVuzQUCDnB86esxSMfXn+7KwZiSU/rUZbAv50aMFdLy
         G48+9JeuDIpal3s4V6wVi5uOHUH8AXhXhWmnMPA9nZZVxwlNSMDaDsv56Qfd+AyedXPR
         xqOAnFRmSmpiVPCFiVGNuoyJNQ7xNCQSP2dfP7iNBfB3se84crmZizxV4gxVkFbZL+4s
         fdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709455805; x=1710060605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urYDUe+DtMbYmGQD/lY83L/cyDLHJDDpcAruR8ELVew=;
        b=rv79DucLbmjBKO2358n/rLdSWosAwTCm5VzL6bIkdUkEpshKmaSh1a4GXkpUmWcpfj
         DbI2Ood0eJzimKROY6iRmEIw4VnUyCT3UBmEZ7MMJil+lpSCBdAJKbkXgaxNx718c+BI
         fZOgUQzGDl50Pq9XbOPWzVNX/7J4/zklr6mXIfj73Psnf5+JbeiPupJzm2BL2v2diFLt
         fqT7IyKucrStkyAaBRV2dmZLi3xoNtAu41o4cHyPE6Rwd81RI/Imhr5Qm27U/O4R5pGi
         s7l3LTPCAliKtY6VHL/2LY4qP+HVACePdyhk/lbAZEHhlCtGaMDGRDrfTqftV5VbQcjK
         bdbg==
X-Forwarded-Encrypted: i=1; AJvYcCWPbv9ihlyEIs59mewSYQ1/b1tvkBoU/4F6QZSrhleDGdQZyn0xtXIZ9g9VKqPH+HVQ5fC9gtC9jQq/0GgBCyBClp/vIkZWATUeGqPc
X-Gm-Message-State: AOJu0YyDLHNTQX1hl0z9CbJr0gmrAp0wS7pkt0VN0cqfSZ5oFqTmeZxz
	cOQ7EcbKZHnmAE9o18aY1Sng6Vc+VuHs7zLJlQtBNN3ovXidvFuN
X-Google-Smtp-Source: AGHT+IHC1+8NHI84yDKUlYRB3brf7bA+Jl7CeCimrpD66l5vgEewW+qff+2s9REMJE9X/qcmw/NlWg==
X-Received: by 2002:a05:6808:13d1:b0:3c1:c36e:9ed2 with SMTP id d17-20020a05680813d100b003c1c36e9ed2mr8644542oiw.36.1709455805180;
        Sun, 03 Mar 2024 00:50:05 -0800 (PST)
Received: from VM-147-239-centos.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090a744800b00299d061656csm5738592pjk.41.2024.03.03.00.50.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2024 00:50:04 -0800 (PST)
From: hyper <hyperlyzcs@gmail.com>
To: shannon.nelson@amd.com,
	brett.creeley@amd.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jitxie@tencent.com,
	huntazhang@tencent.com,
	hyper <hyperlyzcs@gmail.com>
Subject: [PATCH net V2] net: pds_core: Fix possible double free in error handling path
Date: Sun,  3 Mar 2024 16:49:54 +0800
Message-Id: <20240303084954.14498-1-hyperlyzcs@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <333dca5e-fae7-4684-afa8-10b8fdd48bf6@amd.com>
References: <333dca5e-fae7-4684-afa8-10b8fdd48bf6@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When auxiliary_device_add() returns error and then calls
auxiliary_device_uninit(), Callback function pdsc_auxbus_dev_release
calls kfree(padev) to free memory. We shouldn't call kfree(padev)
again in the error handling path.

Fix this by cleaning up the redundant kfree() and putting
the error handling back to where the errors happened.

Fixes: 4569cce43bc6 ("pds_core: add auxiliary_bus devices")
Signed-off-by: hyper <hyperlyzcs@gmail.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 11c23a7f3172..fd1a5149c003 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -160,23 +160,19 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
 	if (err < 0) {
 		dev_warn(cf->dev, "auxiliary_device_init of %s failed: %pe\n",
 			 name, ERR_PTR(err));
-		goto err_out;
+		kfree(padev);
+		return ERR_PTR(err);
 	}
 
 	err = auxiliary_device_add(aux_dev);
 	if (err) {
 		dev_warn(cf->dev, "auxiliary_device_add of %s failed: %pe\n",
 			 name, ERR_PTR(err));
-		goto err_out_uninit;
+		auxiliary_device_uninit(aux_dev);
+		return ERR_PTR(err);
 	}
 
 	return padev;
-
-err_out_uninit:
-	auxiliary_device_uninit(aux_dev);
-err_out:
-	kfree(padev);
-	return ERR_PTR(err);
 }
 
 int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
-- 
2.36.1


