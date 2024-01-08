Return-Path: <linux-kernel+bounces-19244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EA7826A3C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD1B1C223B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33221170B;
	Mon,  8 Jan 2024 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmV1m/Wb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81611C86
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e461c1f5bso8615345e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704704883; x=1705309683; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4UdLGAH7mAUfR9yXCWKCpw7UbYKtkDbnESY38vkxFL4=;
        b=GmV1m/WbhAuWKZBuQUCrM38Vy2EfZ+ZwlfLs6grsa7lT3HmuXwtXJE8Ahl9rxEWdC5
         jaIEPTJRN56d74qbnpDwx4xoFJmut1Rz6Lo5P7q2q3iCMp+9309328VEG0YnRn+QLP1+
         02buYXqbbkrtboWa6tzh0/inTqmq4ek4Emr5+bIfQycpJ53XwX+V/g2FsEsao/4eGvqv
         5au+TdA6IrOXlbBhXgnZ/SxH0qUchIZWNq7nnbKYJBge/x3S3SlpnGJlPl0DjWY7mROP
         8DfV43S5Pplu/Dl+XPLynpT/qJMASIrk9qrMC4TUyIkvB1w/zC36yVrYCRoZqRH1NFAi
         bUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704704883; x=1705309683;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UdLGAH7mAUfR9yXCWKCpw7UbYKtkDbnESY38vkxFL4=;
        b=X1Q0Di/CRWRtiakBUT9m5YVNHtIkLTfz/eAAgY8j0gwJJQSP6BVfHHKoqIqutPbkJt
         zdOtHLUdgjucqPub8UurUb0ct+phhGdH3GYaYdgjTRPh453kIoimoHIg8VgPV4qow8nt
         FW54qvAPn2SWrbVWgkXoU3zVrWi3b1z6Wr8SbM6gwmvy2yGdFRaCgRNK3rTtzvrqapyx
         GCKWh0XesO5y7O0+VQOPE0pwWh3LGGpaZHCyElpfYd0jN4ukcT2GbWdgPikt1ZISLrgR
         3M3Z3n4rIvFbvCw3NmmvPLjMoACv2gyUPjX3cc3RiNHfZc+KPtxKwoTzMWUNLJdbPD5B
         GGjQ==
X-Gm-Message-State: AOJu0YzsPFT4RHVnuCqUr/roBQmf7TjoAivCp72jU/fgH9M3L30HtYS6
	VdF01DCgHuHa6Wd1IvRHpGqDThC3JRJM6Q==
X-Google-Smtp-Source: AGHT+IGR9C1sN5I4JwnlQfEbHvH3L7omqSa/7b+RgytNY22CW/mp0f3Tji6ueqGkBmSbtXxql7dBKg==
X-Received: by 2002:a7b:cb8f:0:b0:40e:47a3:5e1d with SMTP id m15-20020a7bcb8f000000b0040e47a35e1dmr470518wmi.156.1704704882913;
        Mon, 08 Jan 2024 01:08:02 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b004030e8ff964sm10295482wms.34.2024.01.08.01.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:08:02 -0800 (PST)
Date: Mon, 8 Jan 2024 12:07:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/3] cifs: delete unnecessary NULL checks in
 cifs_chan_update_iface()
Message-ID: <b628a706-d356-4629-a433-59dfda24bb94@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We return early if "iface" is NULL so there is no need to check here.
Delete those checks.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/smb/client/sess.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index a16e175731eb..775c6a4a2f4b 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -467,27 +467,23 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 		kref_put(&old_iface->refcount, release_iface);
 	} else if (!chan_index) {
 		/* special case: update interface for primary channel */
-		if (iface) {
-			cifs_dbg(FYI, "referencing primary channel iface: %pIS\n",
-				 &iface->sockaddr);
-			iface->num_channels++;
-			iface->weight_fulfilled++;
-		}
+		cifs_dbg(FYI, "referencing primary channel iface: %pIS\n",
+			 &iface->sockaddr);
+		iface->num_channels++;
+		iface->weight_fulfilled++;
 	}
 	spin_unlock(&ses->iface_lock);
 
-	if (iface) {
-		spin_lock(&ses->chan_lock);
-		chan_index = cifs_ses_get_chan_index(ses, server);
-		if (chan_index == CIFS_INVAL_CHAN_INDEX) {
-			spin_unlock(&ses->chan_lock);
-			return 0;
-		}
-
-		ses->chans[chan_index].iface = iface;
+	spin_lock(&ses->chan_lock);
+	chan_index = cifs_ses_get_chan_index(ses, server);
+	if (chan_index == CIFS_INVAL_CHAN_INDEX) {
 		spin_unlock(&ses->chan_lock);
+		return 0;
 	}
 
+	ses->chans[chan_index].iface = iface;
+	spin_unlock(&ses->chan_lock);
+
 	return rc;
 }
 
-- 
2.42.0


