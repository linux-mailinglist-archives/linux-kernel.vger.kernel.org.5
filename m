Return-Path: <linux-kernel+bounces-51704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4310C848E64
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E2E2816D1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF2522606;
	Sun,  4 Feb 2024 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="C1ayLjDl"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEE122EEA;
	Sun,  4 Feb 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056722; cv=none; b=ZkXzHmj2OCj0/K9qh0ozsUX4d0cBwd11kIYZ41QOPyjZVT6AxcZFaQFe7vNNyDN9rE888G6aRoh6EUrTg9fCdmpulXCT5zKW/ElS2lMR4Z53I2gTL7xUu6K1PA3/vloox4zDV9E5JOmkIJTMvmAG1mMwPExxHgCsvItUmIJ/TH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056722; c=relaxed/simple;
	bh=rzp49cPLhRF5YRkkzXrkuWthBcYyCjpzP0assQJmZyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jhsFEWpY2Tf7iBeRAArdx/YQNG2Y4RbiqN1fWDzj907Duewg413iyweS5o9kc/zOe+GfrMB6CLthYQaXE5GMrZ8uQU/VLNcbOk4n8IC2BmYIMuInMbxR70s9yEb9AJC+kLS/CvSSUTl1xBMXLIS4rLPDHBZ4/V8xwx40ZjknNZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=C1ayLjDl reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2990301a12.3;
        Sun, 04 Feb 2024 06:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707056719; x=1707661519;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrzqA1/9kC/SVQh8KKaDIOO07Ch3FmKZfS4riAJsSMQ=;
        b=MbOMWi4KG4dWzrYNNJoEKeLXxpbZM2dCIPlq+GZHmLNgPOyDPE7xLFeGEfFwEoZxeV
         R9yj0AzFWUtfkc8SQlcDZIayvnNk4Y9hJpKtu4aSpBPXB8lJR95zFgr2XXC065Mzq/ps
         2oAuK3FBNlq8M43dKOVzrfJSB8QO2MsNqMr6zdXPKZRjLi0F3um9uNe65JW3H95Dl/Mc
         jv22C7RVDAEfslKjM6cMw7DqaZT3rtblzV65MohhO01MNea8S5226HJwf9wZ+UxbDVtD
         yQ8WE6n3VDX5K2xsXTeRb+yV9jEvbmhNILNxES56W9HjKrSW9ePVpgBP9NS2pIQWY8Sk
         1PdQ==
X-Gm-Message-State: AOJu0YzgHCnPWomKBl6QmrtPTiAKjJ5ToGomEDt7fNJ2kPqf/M7UvvcQ
	Zzk/tjz2TP18aE8iYazpaR78OfWkT6JKPfw1YxTZtISaslkyEcRz
X-Google-Smtp-Source: AGHT+IGs/Hz8WRPqs+c5/kaC26Y8v3sHU4Z7ZH0/3XLgVDfBc3fDSn/M0FenXf9vEDTONpcg7SwPAQ==
X-Received: by 2002:a05:6a20:12c5:b0:19c:9c1d:6090 with SMTP id v5-20020a056a2012c500b0019c9c1d6090mr13570810pzg.6.1707056719414;
        Sun, 04 Feb 2024 06:25:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWFwN+D70SIXrfM/LiSwvS/M/OAFDk2sKiuhuDcz64Suu+AhF4S9/f1+sHNIy7FwbCBBE5cfqZ7XLT5vC4/ruMAK98/amMJweBagjJEd9Kvjog9yv0hTesKuEhHmeCIjKFYHJnN/MQ8YnRRG0gTKFk6GhVVA5sd8ZFM/uLa59noS2wS7l0W2nkG75VFjtOp3h46/ZkQlyriZICtBTmwR1WeyNceOMz1iMqun92wVq4YKJqWdrYZ4231UEnqjPzeCcI4iZM=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ka39-20020a056a0093a700b006d9b2694b0csm4777290pfb.200.2024.02.04.06.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:25:18 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707056717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GrzqA1/9kC/SVQh8KKaDIOO07Ch3FmKZfS4riAJsSMQ=;
	b=C1ayLjDlc/qbehe1XNToJcchDkr9q/TeFb9e4is4Z3rODRPonT2VipgfzZwBRqpUZ5uT+k
	xx2IssortygVxu7L05nZuiI+w1eSGJ81pfuuPVHfjnKqWGvsbkQDk/6eQO6BBlYydfBjVJ
	vO+RtYzX4jyfFLNqDKfOaDvM1HyLDEa9NQWdaEUndp67BvWrkEdWvyf8d1JwA376E+zutq
	ORqlHLtPecGQjym6VT0ORYge3sk8yuEzUJq7GRVazIv18hdChRyUaW/VYY5LVJ7PabGM14
	L+CsdV8gyDq+lBxCIMM7KwQWf78BqTQ7QZ4r8jlSwOHke4ce6oMaWWF3Wc0OaQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 11:25:45 -0300
Subject: [PATCH] s390: time: make stp_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-s390_time-v1-1-d2120156982a@marliere.net>
X-B4-Tracking: v=1; b=H4sIAGiev2UC/x3M0QpAQBBA0V/RPNvaXRR+RZIdgymWdpCSf7d5P
 A/3PiAUmATq5IFAFwtvPsKkCeDc+4kUD9Fgtc211blyp3S4UO/PXUlW6e7glRSOZVkY59AMCLH
 dA418/9+mfd8PoPhTXWcAAAA=
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=rzp49cPLhRF5YRkkzXrkuWthBcYyCjpzP0assQJmZyA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv55stPUTtSSu1buSOLh4PaT14iz73KGj8/ETy
 UyKxF5TpCGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+ebAAKCRDJC4p8Y4ZY
 plXdD/9SEgJGPyIAwp7YyD9biM6Jo3KpZGt5feF71deR96N30ZPvPcL10RBfjGnEKmE3r0cv4PT
 m8HM90adHu+ec+3DRo53X1ba1gqALLjAMSZS9dieMlQfYa5+RAb3w12wnOwF5srpuP+cVaaoSqY
 H8N6Q93+BckA8SvTIgtBUfRdmQx22kmqJi2F2MZXdSUPKk+8kEWs39/L1xmcVe2QRpAis60Nsd5
 zXOR0JyDt9pyNRaWyfeD0XwGQuDLnD/M06V95N9X80vGFGFnAJhzKvdutYKQ86TD7HEu8uG4S9Z
 On4uOZqcqSPfKreg5QaKYhohBickGbevJmUWGGEsStH99sj2KADWsSnqRrwL5iI690by1vxPP6l
 q/zo5q8a3kNZh8cAvBIrSzreafm1NmXajKn28hIeAFZtOQCwTxn84tdeVmHqPkYeOHA0RlNnTeQ
 aqO7e9aR2MYrIn1lgovFUakqebBPB8aC6KztQh4hUEQeZdoouvzM5/DwDQE1TJ3+juknBoKfK+L
 f5rwyVimmOlMKpJqiy8kr6NhOGmfs692cb8mozokg4e5h3khX9xg9I/ZFFyxeT72NsYtaA2ldDz
 MPXekzsqef/KjHZo7Kby4c0aPKfhvpNs3FSwQ6mc4A4SkTDO/VerpTfm048mDrUahym/ZnqtPUv
 /qYbeoK+RYFidZA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the stp_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/s390/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 14abad953c02..39a42369389c 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -716,7 +716,7 @@ static void stp_work_fn(struct work_struct *work)
 /*
  * STP subsys sysfs interface functions
  */
-static struct bus_type stp_subsys = {
+static const struct bus_type stp_subsys = {
 	.name		= "stp",
 	.dev_name	= "stp",
 };

---
base-commit: 8eb3db95a8c8ecd6f8bb082a99ded3bbc79b023f
change-id: 20240204-bus_cleanup-s390_time-cf8851bbc1dc

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


