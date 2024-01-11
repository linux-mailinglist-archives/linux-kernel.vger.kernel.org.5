Return-Path: <linux-kernel+bounces-23565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1045F82AE79
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFA6282E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED85156FA;
	Thu, 11 Jan 2024 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAuIv1Hn"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8C156CB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e7b51b0ceso4920064e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 04:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704975067; x=1705579867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WC0zU9bk+mOGuDDseHGwErXQyyS357utHMq886vihEw=;
        b=SAuIv1HnuBI6KtWi6FRe/r0CXezqTODAPTLdmJDHwL6yK7LLctud+3NBMZcZnliSTt
         3/3XCYx7yGux7/TsJ6qsLujrHanpYC/WSDT8h21nHrxJZkASI5NcpBnB0vVksSTLXGL6
         A4hHdKj0A/LtEgh7R2RWlvxG1q4J640PcSh+Y/IY4m0pOTd0IJYkYBUZ5uT6fULGBrt1
         VRM0+EUMs0dkvknx8log8Bh3rRJpAsyjeJoAPOMoxr2vETOMsga1L/hO0IKtdk01l8Ih
         h3+J6Pg3NzTWYJsjEZMNXqgcYcA0go9W1xeLiDnhnXVRoDDemv/MnK5IzGzGwLl9bLdx
         hP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704975067; x=1705579867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WC0zU9bk+mOGuDDseHGwErXQyyS357utHMq886vihEw=;
        b=eVTqSkY6fdRP8/Yz/g2ghhOzg5m6sXIkmrJE5IfE/DKGw7QXVW5DWv3/48tqIA/Ol4
         BT5apkTpmEg0y3E8n/qOWFQP/cdR6RPQvgZrX+Fp0DsVpsdtv1HrK5M4u2mdt2nitMzu
         8LJiHoV26CjcHC4IRszzrd5N5U7l0Z3hHMXW/Kj4TEqeGPqxV05l9hDIBREVknKMa9lV
         786XNxryL331hrzHyakuoG2VWf1N68BsHiW20s23lWlTpAp5C/KH6TRqG3o6FU79KsXP
         ETqifhhHsEu9wdLBmRCddo12kJxnz4OMOTgwPzDeGOMzDJOyd7wRn3F0JEOaqctepCYO
         uoHQ==
X-Gm-Message-State: AOJu0YxZMG9wWzVJ6tBmsX/OSHy9182NT6lOLFTEDRYbGHW16CVF9o5M
	SCZhEYSMGzbAjLzZwvfXDUg=
X-Google-Smtp-Source: AGHT+IGD7tMllt2J4AfLMkdE+aYeu00/Ci0X9HYfVAb+VjUhkfypq9v/gSEPE5Z/UMINE/m/8DxUQA==
X-Received: by 2002:a05:6512:238b:b0:50e:4b1f:5ddb with SMTP id c11-20020a056512238b00b0050e4b1f5ddbmr494462lfv.16.1704975066532;
        Thu, 11 Jan 2024 04:11:06 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id w5-20020a19c505000000b0050ed63b0e4csm173854lfe.32.2024.01.11.04.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 04:11:06 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/1] Fix a wrong value passed to __find_vmap_area()
Date: Thu, 11 Jan 2024 13:11:04 +0100
Message-Id: <20240111121104.180993-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a type in the vmalloc_dump_obj() function. Instead
of passing a real address which is "objp" an "addr" was used
what is wrong and not initialized.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: e88b85b81d5 ("mm: vmalloc: offload free_vmap_area_lock lock")
Closes: https://lore.kernel.org/oe-kbuild-all/202401111810.TKPIXLCs-lkp@intel.com/
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e30dabf68263..43a6608e1397 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4688,7 +4688,7 @@ bool vmalloc_dump_obj(void *object)
 	vn = addr_to_node((unsigned long)objp);
 
 	if (spin_trylock(&vn->busy.lock)) {
-		va = __find_vmap_area(addr, &vn->busy.root);
+		va = __find_vmap_area((unsigned long)objp, &vn->busy.root);
 
 		if (va && va->vm) {
 			addr = (unsigned long)va->vm->addr;
-- 
2.39.2


