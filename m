Return-Path: <linux-kernel+bounces-7713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB45C81ABE9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6802C28769A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9288B17E9;
	Thu, 21 Dec 2023 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjizUnwR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A20258C;
	Thu, 21 Dec 2023 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b9d8bfe845so185842b6e.0;
        Wed, 20 Dec 2023 16:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703120246; x=1703725046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsKyRwIIJMh6ypd8eGcHKjusmAjA6ghKRoJtNW0AIPo=;
        b=IjizUnwRsc3FAcM6NfIMzTqOvRJZIOJ2PKDVyI70ok25QrB3ubpgcZnKbIHvMZBniO
         YD4dw8FE2jICYKiVEuioXUhJIcYonGtmN8R03Cb1T7uzDoSS4tV2KVqBItS/65kvqI2r
         wNkzbCj6Ed+UgOSN1uHsubwzX59aq5Wg6ya48X3n8OMT2qXmIu0W/y0ErbV02j9V53SD
         WJKNezwAEL95zZWIjJZZuaPL1pDak9/wKzya4Vkf0LQspmtvKNLB5o1vj7JNs4X6V05x
         6gN7qZ7ma/73iq1LbLWLgIGkduqGuPYNy5D6qwDzVYp7NzpBQiqDbiesuHaMYASyBKIV
         OjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703120246; x=1703725046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsKyRwIIJMh6ypd8eGcHKjusmAjA6ghKRoJtNW0AIPo=;
        b=wKrJ9vB7ZBOAw1OOayTDVFbWLnnZoXohXfr15t31zfDwvAQayhDAXVUYzCmhVvI3L1
         YAayH20VmTBGNK2KD9vW6GS5yki04Bs0uhUx+MGbJS2TxJQ5GK9LA6sydSl05U5+nzby
         9qPuRsUA2wwKlReTK0Q2cxkAH/NGxl1QZznuhGacix3QA80HIKYPL2rKIE/6E2JnYFGj
         Gd4QoK88DwIedKIivZcJiunZPLIOj3IYoyd2ATBDL6Vlx90PiopHzTYqO6Mht0Uc2Vun
         DvTsPELGzi8Al6TipJK+LY24jQjA0qJBqO0K+NwWyPrKjoko6tZ6yHtNwB4gv+N/+8qC
         Sgyw==
X-Gm-Message-State: AOJu0Yw8oNGwX7XTEuSAacFd3PzQ1oia3SRS+QLl2nMsdFLshUOVT+/2
	FR1/dvJSYSzRHVPohDZNej0=
X-Google-Smtp-Source: AGHT+IE2svPs9OIqJz6GQFQGm3iwTc8Gs7lh91C7UHNps90ESUqToUj97RVKlK0QX9L3bsZ5gNHDng==
X-Received: by 2002:a05:6808:1489:b0:3b9:dddb:2921 with SMTP id e9-20020a056808148900b003b9dddb2921mr26162193oiw.78.1703120246576;
        Wed, 20 Dec 2023 16:57:26 -0800 (PST)
Received: from localhost (fwdproxy-prn-020.fbsv.net. [2a03:2880:ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id j20-20020a056a00235400b006d6b6c0b569sm358349pfj.219.2023.12.20.16.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 16:57:26 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	cerasuolodomenico@gmail.com,
	yosryahmed@google.com,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	hughd@google.com,
	corbet@lwn.net,
	konrad.wilk@oracle.com,
	senozhatsky@chromium.org,
	rppt@kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	david@ixit.cz
Subject: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling (fix)
Date: Wed, 20 Dec 2023 16:57:25 -0800
Message-Id: <20231221005725.3446672-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207192406.3809579-1-nphamcs@gmail.com>
References: <20231207192406.3809579-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a caveat about recurring zswap store failures leading to reclaim
inefficiency.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 5 ++++-
 Documentation/admin-guide/mm/zswap.rst  | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 2b4ac43efdc8..5ec7dd753cd1 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1686,7 +1686,10 @@ PAGE_SIZE multiple when read back.
 
 	When this is set to 0, all swapping attempts to swapping devices
 	are disabled. This included both zswap writebacks, and swapping due
-	to zswap store failure.
+	to zswap store failures. If the zswap store failures are recurring
+	(for e.g if the pages are incompressible), users can observe
+	reclaim inefficiency after disabling writeback (because the same
+	pages might be rejected again and again).
 
 	Note that this is subtly different from setting memory.swap.max to
 	0, as it still allows for pages to be written to the zswap pool.
diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index cfa653130346..b42132969e31 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -159,6 +159,10 @@ zswap itself) on a cgroup-basis as follows:
 
 	echo 0 > /sys/fs/cgroup/<cgroup-name>/memory.zswap.writeback
 
+Note that if the store failures are recurring (for e.g if the pages are
+incompressible), users can observe reclaim inefficiency after disabling
+writeback (because the same pages might be rejected again and again).
+
 When there is a sizable amount of cold memory residing in the zswap pool, it
 can be advantageous to proactively write these cold pages to swap and reclaim
 the memory for other use cases. By default, the zswap shrinker is disabled.
-- 
2.34.1

