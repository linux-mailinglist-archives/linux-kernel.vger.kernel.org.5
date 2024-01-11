Return-Path: <linux-kernel+bounces-23652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4419B82AFA1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE79B22A33
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B71E16407;
	Thu, 11 Jan 2024 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgfq956Y"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C5515E9F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ccb4adbffbso62696951fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 05:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704979591; x=1705584391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yah8to25H/+iq48KN48VpbwXbSuJHwaj4nokrBP4ogo=;
        b=Dgfq956Ys5qAQfqFXctCmoM6fS1WUeNa067mAapyWoTJ013ZtUfEQFDiwZq3yxtN+N
         2Fe4nvd72mYkYfiM2yWEo3B7ARs8S2xoil8XWkM5GLX/TgoknqqLJ3cshg2h6ldg2/Zn
         1NJowI8msYhHMNUeIVFTUjtCKnp7kCFeWICR1kqEYnNv9LJla/PoN6WiGFB1tpY/LDDB
         VF485dHi3wNSnXiGm6rQQkI1VfMTbaEDse2Kw73Ot8RdtdaxtjDLaM/yxDcbzlx1tGd0
         TdfE8RQCFUBdRqr31BQ3niZHwo726RTF55y5ft6/Qz9pxg5cxb+yD2KRl1+yYCld6EKo
         ubag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704979591; x=1705584391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yah8to25H/+iq48KN48VpbwXbSuJHwaj4nokrBP4ogo=;
        b=M6tXAVxl7JvQyjPgzRapAozVA3/dh2mwONDWPx4l4qha+6kkj8L79MWb6obApoSH+E
         NpC9V/IqiQyKJcgc+0yWoLekWUx+T5E7N/kI5EICxpp64OnJcxHWP9DXIFE7fr+oYRA0
         XLle9otQUh1yILvBRYqxhmzEan1T5wqRJjtQggN1MYgPM64JKGE/jDo0+TdRTPA4t6Iy
         ZYfaTqYchxF7R7SNr/zYjARDy4wNMMUlYuQ0RIsR1ins/9xuJ/V47GQQch+GwBSXLoPh
         pngzhbtBsc3zsssPiUKRf146SRDPLPp1sdKp8D0WFI7CoA3sEZVSl+LJfbCOAZrCcnls
         SIFA==
X-Gm-Message-State: AOJu0Yzt0ZMMvQ6F5jcOATD4c0Tvp1Z++PUCNQnzqgjwG4ryxnnqFqeA
	AD3rECC1DTH/Mhs+kCdZDvo=
X-Google-Smtp-Source: AGHT+IGb/nQRVOnlRNtaMU0tze/M3CstxOEgSzwwOgXJsgsAgASh8oNcIRvKN1eMOvZ5fKDCcPuIhg==
X-Received: by 2002:a2e:9157:0:b0:2cd:2463:8972 with SMTP id q23-20020a2e9157000000b002cd24638972mr419685ljg.48.1704979590643;
        Thu, 11 Jan 2024 05:26:30 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id k26-20020a2ea27a000000b002cd187bb10esm140974ljm.95.2024.01.11.05.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 05:26:30 -0800 (PST)
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
Subject: [PATCH 1/1] mm: vmalloc: Mark vmap_init_free_space() with __init tag
Date: Thu, 11 Jan 2024 14:26:28 +0100
Message-Id: <20240111132628.299644-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vmap_init_free_space() function is called only once
therefore tag it with __init. Apart of that it access the
"vmlist" variable that is located in ".init.data" section.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401112056.I41bELL4-lkp@intel.com/
Fixes: 86817057732 ("mm: vmalloc: remove global vmap_area_root rb-tree")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 43a6608e1397..257981e37936 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4834,7 +4834,7 @@ module_init(proc_vmalloc_init);
 
 #endif
 
-static void vmap_init_free_space(void)
+static void __init vmap_init_free_space(void)
 {
 	unsigned long vmap_start = 1;
 	const unsigned long vmap_end = ULONG_MAX;
-- 
2.39.2


