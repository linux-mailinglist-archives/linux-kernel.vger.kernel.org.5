Return-Path: <linux-kernel+bounces-89519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9FA86F173
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8A428328B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229E5374F6;
	Sat,  2 Mar 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="pm6WQ1M6"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D5381DF;
	Sat,  2 Mar 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398066; cv=none; b=Z7dvevCgohGdHvRdrlVMf4doOMIgGr7Rs+jF7fg2JjWPZh2xk1ie7xKtvuLvwrcPP4Q00wvtDthrBDPM7T8GodadER+IjL9J3/+f4odHEKicKlL12HXlb+SzMolL6fe+4eiPS1VjnpwDF3P4hmZutRY43r7nUpKKIQnVtR/B6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398066; c=relaxed/simple;
	bh=wgMOE+sj1rZMMKNVOYVSq6l1jWjszymXD7/64j1vfoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F5oT/hLO2oPJArc9acXtnv/8tCM5G0pQyRMZERjGbucPkBxB9h8Qoyoz795czp1xcYra6EHqLZ/9VJIQrBEN+prGGQoftoYt00DhZxQlF/sOgufu81ZjUzDJWKYDwXsZu7kk6dwk2M+6NqXpXNuQbqMP8izk0FIfKJJeXIMvJZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=pm6WQ1M6; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c788332976so113600939f.3;
        Sat, 02 Mar 2024 08:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709398064; x=1710002864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j7hW65oxQqWdEt3THXuCSWMMi03uiOaUApU8DRpHvpU=;
        b=AFi0X61nkay5AMsve4CWvLSE0pFjXCtT+gdZwXLhGJaBFlVtLMdSi6OUk18zyiHUkr
         r1PfYB6hPc1yl5GdDV61p6F4azsf27BvUJYEvLJxc2svaQ4xW4AWdXarTwe3rh8KxJ6A
         uVEKMrNmgG9SWqdOk/EHwU/ITWaFUFexOHNk1HWQQUQEISLtgoqjkQmjYefUDAS4kE+D
         MHkmS62+S6gHwcHlwWM3kDZ5RS9tX2/asKhL3wnZZAvZRKUhBOZ92iMAQ0qdUOkiRG6g
         Dhx1KieiqRmfsNvQ5Gpt/b+HJmRysWV2QfHqFwybIoI585pxzNO08dtdw5ITQd70k1/t
         YT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkC5+ZCUGekHTyR4cNB9asLboGBR3UDdX8VXLEkcwXUaFZQY2Hti3tMWydeizVtTU1//+Q4BHGWZvxXcRYG6VhVRw/SVO7EnbwfBqq
X-Gm-Message-State: AOJu0YyCEG6fpkDYtOJrYlNQsvOCa/2PYvYpONxhJ6sTMl6HyZtblFyB
	V+ren6bVua5z6RJ/6wPucLyNV66gLwMYoVkMg+AGvaTVc1K+PzKE
X-Google-Smtp-Source: AGHT+IGf6K75ayQ2r8t2fX7p1HE9LDce/6YMZWF1q0NkpobfGP7wyqQ7FM2j+fwYP3f3TbK81fDdig==
X-Received: by 2002:a5e:a714:0:b0:7c8:34b1:e446 with SMTP id b20-20020a5ea714000000b007c834b1e446mr1702514iod.12.1709398063964;
        Sat, 02 Mar 2024 08:47:43 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id c26-20020a02331a000000b004747a1063a8sm1408697jae.131.2024.03.02.08.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 08:47:43 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709398062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7hW65oxQqWdEt3THXuCSWMMi03uiOaUApU8DRpHvpU=;
	b=pm6WQ1M6R/3bjn1NS37kgHPToUBEwsSBuZlIyfJQNXqR+JNkqHxAXpR9ukRB9VTQHM6Y42
	UFTTOq41bZfgFbz69gp886lHNFLbJgYCX9qVng5oAG2IQGSGLxLw2MsRB9nuUlLAq1WK22
	8tfVabluKpCxc+ABXsB/pW2VC3H39qcGh/aqpU2QRwwtD9dXiiDAxLrsheu4kYkmwjbGgb
	/VfIXQuv62r4jjs7gLy8LRsVByScv1YPmjTCXpB3nnMxo4ykaM6PQDsAD5uVqTQN5pnFT4
	aF5Rc4YiE6TyyHQr3kv26e9aLCRN3VNJaBS7gQkRTobd8zsZR3CgUh1MhdDW3Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 02 Mar 2024 13:47:26 -0300
Subject: [PATCH 5/5] scsi: st: make st_sysfs_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-class_cleanup-scsi-v1-5-b9096b990e27@marliere.net>
References: <20240302-class_cleanup-scsi-v1-0-b9096b990e27@marliere.net>
In-Reply-To: <20240302-class_cleanup-scsi-v1-0-b9096b990e27@marliere.net>
To: Doug Gilbert <dgilbert@interlog.com>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 "Manoj N. Kumar" <manoj@linux.ibm.com>, 
 "Matthew R. Ochs" <mrochs@linux.ibm.com>, 
 Uma Krishnan <ukrishn@linux.ibm.com>, 
 =?utf-8?q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=wgMOE+sj1rZMMKNVOYVSq6l1jWjszymXD7/64j1vfoU=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl41gdrdY8AIXuL43RwAEgLGNcwfXsIpXkoNK07
 11TPBPcZsmJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeNYHQAKCRDJC4p8Y4ZY
 prxZEACAWAb5qsXTFpr+gGnR8tbrrhJDYQ3w6UCspd7HwVEPiUM8tAgUaYUeV466ossJzPlrA59
 TarCIT/T3o7iuik70h7X1SLVXN7gaDmNxVXMnCtQ8V8PXxB1dEuEe4Tfx2ljAIrJFAfndTos4P6
 cpsbVAeJ3yLGSKa7k6HjDps+l4R5vBEgY5h11yG6phHG5XawC5wjr0U26VQ+mL3yuhRQsTNrsW7
 Jn83hQIuq9ETka1rDL2wR6FQkIRRQK5x84LuB/VEmxybvDZzTZ8FWsFdhVDOwqY31AlKF142eAq
 Pv6/2sMSo6wo+sOXIt/+pTuBFwd6F6ZxRvs3N8VfnG2u6rLPJbPHWBKgPgYVKk6+8UBH76ifQHe
 KxoMYCv64KkPkoskCypHNpMj4jBpzvS9anCTenKngcHjS1fo7CE6iQatExR6WOBgeoNfwXFte06
 jqqEQrX7DZ0N3pbEX9fQ7h2iQ3iBqbt/O08VlaYY3Hk5G0agx7JoFdfEbnQwfRocxxf0sI0+f5W
 BHyN2fgj7M/WJOwT8oxm4+LUE87KKKlmPJFRaz840uwpzh1imurWIRKiJdkcqQj5Uy3s2Vyhu7u
 LCUxNC+POMPh9JkvF/opee9vsZd0WfZWN2omwPOIkANEA0mC5Zunjr+BMOR4N2buUtw3O5IaGz1
 6rb/KhFy9NunR5g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the st_sysfs_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/scsi/st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 338aa8c42968..5a9bcf8e0792 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -87,7 +87,7 @@ static int try_rdio = 1;
 static int try_wdio = 1;
 static int debug_flag;
 
-static struct class st_sysfs_class;
+static const struct class st_sysfs_class;
 static const struct attribute_group *st_dev_groups[];
 static const struct attribute_group *st_drv_groups[];
 
@@ -4438,7 +4438,7 @@ static void scsi_tape_release(struct kref *kref)
 	return;
 }
 
-static struct class st_sysfs_class = {
+static const struct class st_sysfs_class = {
 	.name = "scsi_tape",
 	.dev_groups = st_dev_groups,
 };

-- 
2.43.0


