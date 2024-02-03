Return-Path: <linux-kernel+bounces-51244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7038D84883A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DC5285699
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0778460877;
	Sat,  3 Feb 2024 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="bDAxb7TV"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE860244;
	Sat,  3 Feb 2024 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706985528; cv=none; b=I0BSzgjRusDtXM8F7ISjaZLHJu7EFRohmNH3a6ksmZC6/R9WVXXrooWf4ZjYRWp1AxFm0moQ4/rdTjMDGm6l4kqw/8OT72u95n/cxLWs4GnA6CBuojFE82ACW/HvI3B6goqoXYTTKxBxrygVzgxpm9YEi7n0Pd9VaTFiEhLIxC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706985528; c=relaxed/simple;
	bh=bjdita3VtualiLH2Bvvv6BEMeZiNVZfO+Ctf4DIyT8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fsLPSlpHEwArwN4H/fNb8StojY5A4ibIllsGkSQtcraAPhUnd8G1zz2mTltMWIvHwccEprIfXPYF+dKO1hSzcRyZRKkHaME81uwRPVqrRq/8PXfwwubx0j/AsvlnlPaaYmwXEmpS//++DwHDyslSQedFt05HN3S6hnL+qLP7sxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=bDAxb7TV reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7881b1843so27582675ad.3;
        Sat, 03 Feb 2024 10:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706985526; x=1707590326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5eYTNML8rXP6bbP0gutaZdb5ydCkJPq19idDEW8PyI=;
        b=SySDwPoyUASBU/i4Vy9qBUwzPlxJXkj+F46e6+KoDJLUMUt+YJWjVfIOYDkauYsNWQ
         DacmSd9l6FZtgyruAsYUeZ52issRsqzWByHvD+GVsev7Li2J+iaUFsFj1ln7P6DZ0lF4
         DerT7XCv97xk2Nsp2Ce4qrradLd2TldAy3hFkfG2++OHO29mOWCYEIWl+cwkdmrCloG9
         L5rMNmmMy66GFWmnpgR6EwgNo2+vHX6i6iLWPopDW+SBMcTrgqeQKR7T2aVA8S5V8/hL
         nT/1hjfXLjsaSdE35dwEsSv/L/iSiAsrd9/RqkwphTI2KpUC4oFYZ13NgOtRex84VJig
         DvzA==
X-Gm-Message-State: AOJu0YxBo1r7GUtBIED3C8lIaB6YTk0Thwuho4o46pdRUUj0xj5zILP2
	0ESA9xZ9p8+a3kRqNtqNjb1Nd1TPfzWn8wC7GHzLIcT3TqGmkipq
X-Google-Smtp-Source: AGHT+IEkonobOQtpu9NaJwFj4Ja2ILhPqa7izFzDiKECOkmWU7cjHDASg3pJaSUtorAjur0d3xoqKw==
X-Received: by 2002:a17:902:6b46:b0:1d9:3bb5:2819 with SMTP id g6-20020a1709026b4600b001d93bb52819mr6278789plt.34.1706985526052;
        Sat, 03 Feb 2024 10:38:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVX/bOMqCMMuf6JvX38GJni5+jzBUqwDC6o+/8jQOpIATlEfhWmWv108M1iCie5lCcl19gwRGkY0+WjHxxsKgv42X/Ve865lKNqCP2I7zE8cWqraUnB4XMmBtvH11sG9a0Yky2r5OyYLyPuoHg7UbK9QUe+RAjlK5AoajW19Jr3teWSf13ZRtXbiXY+LgZ0RpPC6Wha5oZkGKxwsoR9lsjOMNJ/EODVye3Cn6B9K9GRvPk+ugmKfsLmVp2hIMy0+d42WY1BvFakR95ctGYjdyuZpD9gRn/oBSti/10I4BUMpYVCCAOFQ82LX0nNVzOXrj/3Txiw4yFq
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902f24a00b001d9834f2946sm2051315plc.46.2024.02.03.10.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 10:38:45 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706985524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W5eYTNML8rXP6bbP0gutaZdb5ydCkJPq19idDEW8PyI=;
	b=bDAxb7TV7pMM/jjBqY7pETjaPeT20lh/5Ga7l6L/2CGR7KlfOwZ0F/2malGv60FMhxeDJX
	MJLOJykkR87C+kd7f0xiuNV4Bf9utd6D9WW8CEGOX7j2r5Oq9tjw0SFdra5OnCOYarLAnG
	0+03QSr4ZAI3CrzyaDN/tG8KZpebMmcAaxMRpAuHyO1QE5uLPbYYUg1C5Df61dvM4Sfrx6
	UkrEhfth/R6pnAQduW54IY+2AigBpZ3KBNmXyXkSFTxvmWLOkcUeuVl9708gmRzAHNQzHf
	sdOydxSWFp1vbQf1sYvtlUwSGoG7aeHOwwgM7fjZtfY0yH4mrDSgi5VAL4/O2Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 15:39:02 -0300
Subject: [PATCH 3/3] scsi: scsi_debug: make pseudo_lld_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-scsi-v1-3-6f552fb24f71@marliere.net>
References: <20240203-bus_cleanup-scsi-v1-0-6f552fb24f71@marliere.net>
In-Reply-To: <20240203-bus_cleanup-scsi-v1-0-6f552fb24f71@marliere.net>
To: Hannes Reinecke <hare@suse.de>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>, 
 Mike Christie <michael.christie@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 open-iscsi@googlegroups.com, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=bjdita3VtualiLH2Bvvv6BEMeZiNVZfO+Ctf4DIyT8M=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvohHKD2KVdzbFHmqJSdjw5yECAKL6C8DdNRDx
 HjXE6vafgGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6IRwAKCRDJC4p8Y4ZY
 pn9vEACzDxkMsI/V0KNPQerNhX7GPPfeoliQdQtelH40OYV3j7WCVLhD3uPZLhkwwSiQeLFt8qA
 +qUPdMC7iwhld5oUs+bXXymMf5J4OSWsCCjGSDpZWe7osbu8vWyBfPJdxqsMX0NaKQMnKVyIfR7
 1ja8pfPhqNhe9w2CnWRkFts4X94dgfu007syV1dgUKMfesq6l/dSpgPdWZaWt2bEZioDc8plAIj
 IhQUAO2jrksFJHHu3Vga0MnYN1CSdG1t3voZBSS7qpQ6DJxxIOk/FSpsu8sxAJzFQLzIXBjjFdK
 9EF6Xa64AsT7D7MxEXm8u8Ar3+w2rXLAps5mNts7HDLj5/vmHA6jHGxFS/H64B3PCP3uD63QsbN
 liSIGixW+ucTqjAsq5/V0xEEIQCO4z7rbAY7mE/aMdG2q0BxBvPhQ4cHcSZxENFwS1GPQ5XjxfP
 lA2yvYejrZ6eKdsKl5fyuxsQnv3iSA6uRkuLINVBQp3+Y4PLG6WSV4AL0oB+Iu3BKPkc9VnmATD
 uEFGjRw9Baz+PyJYysslhgpWevszWbJDZibiZkoY0JzGVzPzwgDqpb6mqfeyCsQsLblwKZQompX
 /Nk2UyGeHOwNRPV8ruVWk2mnSkwzL1v/6/3nxakRxTP5XzoYDqgOSFk/8W86zh7bRYhnMERLO8a
 VibumcJrdgDqdAw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the pseudo_lld_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/scsi/scsi_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index d03d66f11493..914d9c12e741 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -899,7 +899,7 @@ static int poll_queues; /* iouring iopoll interface.*/
 static char sdebug_proc_name[] = MY_NAME;
 static const char *my_name = MY_NAME;
 
-static struct bus_type pseudo_lld_bus;
+static const struct bus_type pseudo_lld_bus;
 
 static struct device_driver sdebug_driverfs_driver = {
 	.name 		= sdebug_proc_name,
@@ -8405,7 +8405,7 @@ static void sdebug_driver_remove(struct device *dev)
 	scsi_host_put(sdbg_host->shost);
 }
 
-static struct bus_type pseudo_lld_bus = {
+static const struct bus_type pseudo_lld_bus = {
 	.name = "pseudo",
 	.probe = sdebug_driver_probe,
 	.remove = sdebug_driver_remove,

-- 
2.43.0


