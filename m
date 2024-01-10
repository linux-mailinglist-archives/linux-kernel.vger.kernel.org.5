Return-Path: <linux-kernel+bounces-21774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE4E829418
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8342288EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004BF3A1B7;
	Wed, 10 Jan 2024 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dk3zwH4z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8135039ADD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704870932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pq0F4aFw6g681LkvfPcovxOw7gCCC2AmnjI1JKPUo/g=;
	b=Dk3zwH4z7P10c1QJMPmgTBIUhvly81Pi5wyhK3+9gOuGlr0l8mNbrJ7QPIkccWBLofuBzv
	kc3ZQcRVOA+lxtQeKET44OwpZxR3tvt9zWhP0jhaHJRNY5UOrF9Dv3NXWGJ2At6tE/mz/e
	Mbwlje0VRVaIPSMi3dU+jkYgDHvwRMQ=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-y6DAq6wXOvaiky6pOAc7JA-1; Wed, 10 Jan 2024 02:15:30 -0500
X-MC-Unique: y6DAq6wXOvaiky6pOAc7JA-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bbb6fd2cceso4744972b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 23:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704870929; x=1705475729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pq0F4aFw6g681LkvfPcovxOw7gCCC2AmnjI1JKPUo/g=;
        b=nxwiWChC895Br3dxqr6VNEsd9HBeFxjNUirswX/OaZI+ZA612teq8GxVTqWkAQEvEG
         1Uap3gJRMAAMagVuk/fBlMH8YM1IhXJ/KBFlIyQQS0b2WNUcTqgxsaZR8l8AQcvYGkKd
         bfQZ6EjiKrh/Kr1lBt5huQ7LuvopjxFvgELIg5g9D8a+CvZxvNVk3TqRjSRUqtOTfdJj
         K2yLDMDhgMnhvvoW+QRzksic+goVrMx1zgiIz1e5EXWZHHPv14AdOQ25tYioFd3wg7z7
         BJFxW8CgZaoPArw4Ag2p9Fcvo2hfCn8GgUxF8s7I/5lee9wmrz1kZ7Bjn7R0hfW7nBYY
         iW1g==
X-Gm-Message-State: AOJu0YxU/GiAZkauxcHUcdtDSGZEmUJyNFYW5heYiRA5XqGqscGoCFNV
	9aTqziGU9/bUOwq2H7IYSiKQcIyCsEM8jGH3h1CBkkvbb7wsC1XmOjA8Wcy5mTDWL8MauH/FR2x
	MlWOfQoqoJMwvSUiHxPQ5nmf/MhA+IsIYhpudec8ox4+VKK6s
X-Received: by 2002:a05:6808:1827:b0:3bc:4f4b:2876 with SMTP id bh39-20020a056808182700b003bc4f4b2876mr836091oib.85.1704870929452;
        Tue, 09 Jan 2024 23:15:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAh30PQjEcO5UsWPrWFGKjGa/q7fyVdh5HckMBNYLKlvjstQEK5unXc4t5sinSV02Bz4i0yQ==
X-Received: by 2002:a05:6808:1827:b0:3bc:4f4b:2876 with SMTP id bh39-20020a056808182700b003bc4f4b2876mr836080oib.85.1704870929172;
        Tue, 09 Jan 2024 23:15:29 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 5-20020a631245000000b005b92e60cf57sm2628739pgs.56.2024.01.09.23.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:15:28 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v2 1/5] kexec_file: allow to place kexec_buf randomly
Date: Wed, 10 Jan 2024 15:15:16 +0800
Message-ID: <20240110071522.1308935-2-coxu@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110071522.1308935-1-coxu@redhat.com>
References: <20240110071522.1308935-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, kexec_buf is placed in order which means for the same
machine, the info in the kexec_buf is always located at the same
position each time the machine is booted. This may cause a risk for
sensitive information like LUKS volume key. Now struct kexec_buf has a
new field random which indicates it's supposed to be placed in a random
position.

Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h |  2 ++
 kernel/kexec_file.c   | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8227455192b7..6f4626490ebf 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -169,6 +169,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
  * @buf_min:	The buffer can't be placed below this address.
  * @buf_max:	The buffer can't be placed above this address.
  * @top_down:	Allocate from top of memory.
+ * @random:	Place the buffer at a random position.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -180,6 +181,7 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+	bool random;
 };
 
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f9a419cd22d4..7abcfc3c8491 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -25,6 +25,7 @@
 #include <linux/elfcore.h>
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
+#include <linux/prandom.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
@@ -419,6 +420,16 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	return ret;
 }
 
+static unsigned long kexec_random_start(unsigned long start, unsigned long end)
+{
+	unsigned long temp_start;
+	unsigned short i;
+
+	get_random_bytes(&i, sizeof(unsigned short));
+	temp_start = start + (end - start) / USHRT_MAX * i;
+	return temp_start;
+}
+
 static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 				    struct kexec_buf *kbuf)
 {
@@ -427,6 +438,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz;
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, temp_end);
 
 	do {
 		/* align down start */
@@ -464,6 +477,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 	unsigned long temp_start, temp_end;
 
 	temp_start = max(start, kbuf->buf_min);
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, end);
 
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
-- 
2.43.0


