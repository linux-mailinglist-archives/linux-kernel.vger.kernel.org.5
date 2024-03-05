Return-Path: <linux-kernel+bounces-92261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D6871DA2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED3A1C2338E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B8158224;
	Tue,  5 Mar 2024 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="BmPU6Sx7"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1C522068;
	Tue,  5 Mar 2024 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637934; cv=none; b=liN0r6m5AFo59MvHFz6RpCI3K35g+SY9Jb1MlN3lairId9HtgZGC42/JZ1Fn8RuAXKm3VTq+nX+/0IDcA+d4/kdxOIonN70KdVCwhx8u2POy8B+OnaqVvcEiDEIhPYZqzSYVHBFvWGNdSAC7NiyoAMgOyb8J7+kB8sAQxjNNhVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637934; c=relaxed/simple;
	bh=jnklyTAj9n7JSkFIdzS+epw/LCdYIxHvvE3dqFQWSI4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YU6SuhgQU9JaHZltDNiKZ0XaOcW4Qd42T2ze1CMKH/MBqnX3MZs9JIix2fDvhsgF7Mxjn+lcPnwSORc7nj8Gk62EoBWS9ose/HPmfU4+bd9HiM9vftpTvOSZ/EDcbryqxFz5Q9tW04RNON+B067gwBJYKMZ4SXT/UUH3mmynngQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=BmPU6Sx7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dcad814986so49611865ad.0;
        Tue, 05 Mar 2024 03:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709637930; x=1710242730;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rnDdUmjYtBfgIhjZlrfRTYpbq7Ct5qpyZ49+VLZHb/o=;
        b=GebvP4k+XZe/odYrCjXZBdsrYNtbdftYuoVMM+Ji0PuLCVOlqiFAnYKgpwV7WKvXbw
         32eHnl24CTCWGvGxAdUHIGIrnIFgEzCLDA1TlL/E+UNme41Tg0R1MVhLCM6kOguAjqjq
         fdAJlLRp+bZ2NmChgrUOvKG6yIj6Mxz3yvhWLd3/RiJPLVV7EjY099XKmifU5NQyaTAX
         kkOKwy1n17uSef4OKCQV0qk0Rqs8uFA8UJfPzbbI9KaIryMh1B/1XQLms/TVW8gwKPG+
         hnQL5dal79nmxWqdFsH4TN+KmCcG10AK7JG8/1kqbsLJ0xhin26M8SL8RPUx+eftxnHv
         jqqw==
X-Forwarded-Encrypted: i=1; AJvYcCWu+X4wukY/u5fxPcXdAWEhXQo7MXA2MwRPVkrnXexD9zVOEeEPGM9HFP4gJxOvfsH8OmaCyI9FTUSiPziRLEf/jqzwNIk9z7Ypz9Mw
X-Gm-Message-State: AOJu0YxDWQH00lcxGxIvlc7HYVaeiVNRKUAaj63rqwMS76QfFPZIfyFf
	MK44Jmk8hHwdHL3SjHEbC5cFyS4ryFFH7U5MgJbpsfBPL+B3d69m
X-Google-Smtp-Source: AGHT+IHn0uUwpehKYAzzBla8rndd6v9xKeeKGNJLgtLMUMYQ4p5MXXoDbdCzgd0QmKDTCItvrR4sew==
X-Received: by 2002:a17:902:c085:b0:1db:b36c:715f with SMTP id j5-20020a170902c08500b001dbb36c715fmr1326365pld.24.1709637930250;
        Tue, 05 Mar 2024 03:25:30 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b001dbad2172cbsm10515638plb.8.2024.03.05.03.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:25:29 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709637927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rnDdUmjYtBfgIhjZlrfRTYpbq7Ct5qpyZ49+VLZHb/o=;
	b=BmPU6Sx798oEqBcnvbPwiG3HOPvwz+X/yF1fxyyNMADAmk6M4pWiVBX/VjcE3f8gCmNx3L
	rxn3x0goZg9g2ADaj7aTIyoBnZr69P3oDMcaBiYSCuvXpvHCHp7t9nMnb20qMhT9fA+v8/
	oLFfSXANl9tIdUKsu2OLz9Gd5TQ5CJYS2KsrqFRj4/Cmxh86ae7dLV3wo8KuOMmrA0BlFB
	k8Pu4n1qFeYJVQ9nPF7b40vv8qPCqdthFdXLUzA/k7jlo1+Gei1ukcaPAyRyj7I9Yvq+tu
	c572rhImk7P7wVhXSNdxOfNUSOjUBocbZkG738kn/RPwS1SYJdr/ONcCP4odBg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/6] s390: constify struct class usage
Date: Tue, 05 Mar 2024 08:25:18 -0300
Message-Id: <20240305-class_cleanup-s390-v1-0-c4ff1ec49ffd@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB4B52UC/x3MTQqAIBBA4avErBPsR8KuEhEyjjUgFg5FEN09a
 fkt3ntAKDMJjNUDmS4W3lNBU1eAm0srKfbF0Oq21502CqMTWTCSS+ehpLNaeTOEAREbgxZKeGQ
 KfP/TaX7fD81KyzxkAAAA
To: Harald Freudenberger <freude@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=jnklyTAj9n7JSkFIdzS+epw/LCdYIxHvvE3dqFQWSI4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5wEgRfkiCCz9gKh2fAxyjfgOAvGhChXiiJb8M
 WXZTc6bDxGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecBIAAKCRDJC4p8Y4ZY
 phh1D/wP9rEfdH6o5Q7W4x2p1il9VVS/4KzOPg05OTeig41Stht65IM36qzHOVv5C+9cq1FkCWu
 77rq/SNN2wuX6B3XwWymPWOG4iV2GQvDRcXJvMJNqusoGBIm0NiqrGKNEaARDJJ6AyeSYdM0il6
 KQ9umCMgziKtXNoN11kuvZkqn3CEVgcbgsZksSHETjs/YVKCF9pLOnW+3FBtMUd28FxmTCKmqDt
 +buXtFsIs+yq9WfoMY/pVWzFnWkg8jg216beKtbEd6xnVOKiTnFz29D5BtrvBlizmyhxuwgV3ln
 T1TEJH2pmc7OuoYnhVvDFoWi9m9W6jkH5qpivCUyYg0d1vmMnVMO21ccGgnBW30UoRRWajsUmZO
 ynSkdZFsKxhejG/P+doDriKnZEqv9bbD0JX4PS28mcRqrrg6daMu9i6i5MaBpZznZWhIf1+3OaA
 e3s5TjMmz+0h1t4naS9wrn9eqhZZgR+w4yn5K7HxA6CJIfZvGm+UZrOLj20ih91M6sUzHhlSTm+
 GzOYeoawZte5F/plye9MdN7ExqpzIpt+Nz+YUQFYMSJ8wtOWYN33pzb+QelqlZ/0HU8NMplNJGx
 uyR5bgbJ7xpgX9neWFCUIk9QDqIjv2kTQKPz/E6yG5nU/+LTm1QJcf0y8zI3TIi9nNN9WN5VDq3
 k688SmVWfOix4tQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This is a simple and straight forward cleanup series that aims to make the
class structures in s390 constant. This has been possible since 2023 [1].

[1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Ricardo B. Marliere (6):
      s390: zcrypt: make zcrypt_class constant
      s390: vmur: make vmur_class constant
      s390: vmlogrdr: make vmlogrdr_class constant
      s390: tape: make tape_class constant
      s390: raw3270: improve raw3270_init() readability
      s390: raw3270: make class3270 constant

 drivers/s390/char/fs3270.c       |  8 ++++----
 drivers/s390/char/raw3270.c      | 32 ++++++++++++++++++++------------
 drivers/s390/char/raw3270.h      |  2 +-
 drivers/s390/char/tape_class.c   | 17 ++++++++---------
 drivers/s390/char/vmlogrdr.c     | 19 +++++++++----------
 drivers/s390/char/vmur.c         | 18 +++++++++---------
 drivers/s390/crypto/zcrypt_api.c | 33 +++++++++++++++++----------------
 7 files changed, 68 insertions(+), 61 deletions(-)
---
base-commit: 6a42aaf8e867f4876370c3d482ee0c21769dff58
change-id: 20240305-class_cleanup-s390-d57f7ccc15c9

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


