Return-Path: <linux-kernel+bounces-24005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEB982B52A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D9D1C23BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11B555C08;
	Thu, 11 Jan 2024 19:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEk89ieX"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BEA55C00
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd7e429429so24613591fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705001012; x=1705605812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1qV0MgfaGtL42XxXe4bDGM2XS9rJFS6WTwSh6qlgBHA=;
        b=dEk89ieXC4+pePgyMi72Cp2Ed7Z6ZEUcAzYmUW3XPqIHf1CTjqgNrmoXO8a+iSCsm3
         uWMQTO2BL3Fn/zPJ4rWG0/9Ldny1uaLERPavPU4k4frCx2bkqC3OUPkMqIIUGr5gviyk
         tPWfzci4p45MSiqdDP/WAllfDv41FB5MDsWHNF3WJIDGitF6Oja4BLiNYIKMAV40+9Li
         yWXccEeF/TAcfLFEfcG2+BReUDCn0MWOZDzqCXznlERRbLeR5kEgPTLajs0gH0FueI0F
         REMVgH1f+UZY22ZB+2efGiuMOj5ovzAxmQIsaJBNUxrw8s+wIWDg+jwqe0zo3Rdo6sL3
         5lHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705001012; x=1705605812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qV0MgfaGtL42XxXe4bDGM2XS9rJFS6WTwSh6qlgBHA=;
        b=EesrLYsOuE999yGffR/QsI+9bRmGwbsWwYUbmm0jZOpmmfP/BLoFyzTsHlb+o/2JCF
         BlWDbS+ZYCcDLDch1wcpDrvFAV7kiD19wTaqepCKON822FG+hbEXqYYTlBpajRing1Wp
         pAFMghOh+fi91/oQRT3vbeufetysOoBlaUA96viQgweU+Ke0C55AjPQGLE2gftQeenrx
         u2sfkj+K9LlU8zP8N5VYa+7XUaXwcT8g+UoTwZS4rqARlhxM/PBiDUYxbzhU5SK2yzw2
         bxHywokseYKRozWcOGmk/V1o5Lyh7R+leSra+qp1XrX9MdpBr+4yuFEY8rYkEy6/iDie
         ByPg==
X-Gm-Message-State: AOJu0Yw4jDlhWxZ1fGLcacg7scIzyeL6JnMUwrQcHzeRPLyNEGhNaquR
	mtyWazTZqIW8g7xG9Q3xszk=
X-Google-Smtp-Source: AGHT+IGtv6vw9qliqzpC9az9v/1sloPf3eY0NVM2Ni/4Km/KxnGkVAK7ACN44R8vw7D27OQqfsvukQ==
X-Received: by 2002:a05:6512:74:b0:50e:69df:b067 with SMTP id i20-20020a056512007400b0050e69dfb067mr103977lfo.11.1705001011991;
        Thu, 11 Jan 2024 11:23:31 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id j18-20020a056512109200b0050eaa8c1431sm272591lfg.151.2024.01.11.11.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:23:31 -0800 (PST)
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
Subject: [PATCH 1/1] mm: vmalloc: Fix a warning in the crash_save_vmcoreinfo_init()
Date: Thu, 11 Jan 2024 20:23:29 +0100
Message-Id: <20240111192329.449189-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vmcoreinfo_append_str() function expects "long unsigned int"
type as a second argument(0x%lx) to print a beginning of vmalloc
start address which is defined as a VMALLOC_START macro.

For some architectures it can be considered as "int" type, for
example m68 generates a compile warning message. To fix it cast
a second argument to "unsigned long".

Fixes: 9bdb180b2d ("mm/vmalloc: remove vmap_area_list")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401120218.y469Puyf-lkp@intel.com/
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/crash_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b60de490c1fc..49b31e59d3cc 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -748,7 +748,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
 #endif
 	VMCOREINFO_SYMBOL(_stext);
-	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
+	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", (unsigned long) VMALLOC_START);
 
 #ifndef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(mem_map);
-- 
2.39.2


