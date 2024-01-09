Return-Path: <linux-kernel+bounces-21546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C8E8290FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D377528848B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E673E47F;
	Tue,  9 Jan 2024 23:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnEp/OBW"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606ACC142
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbc755167fso3223712b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704843845; x=1705448645; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDzSgBLqbfjMZPUPpyZDUP7UU1l75Pn8NaJbhwNgX2k=;
        b=UnEp/OBW+B3TIESbmYvAUySW6cAdoWSH1gnhvwnANUfwL0NYy6FCV03Y+2Cdh33sWP
         031mWFIAVdv6B730zze2LU+SYl3RVMVEgBo4Sh+zR7MwcoJcnTUPXDXiEBE2gXHtFNtd
         y4809XDwI2mtCa/wDYtpj1AvBdtaRojaMeawMYKMVQ72PcNA2sgPNYuhaXLu/32EH8N5
         l08qoqVSdVJ7Pae1tQ2MAUEBHgKiTfs2t2r7kOaH63PXVIjdSeFO487tFCfUM79NJ0sJ
         oQjMShbNGOJ3eVRcxj/g9tNQgSa2RAuc8n7gM/dK8op5uLuuXnfmycQPXLVlMgOc0LK7
         ApIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704843845; x=1705448645;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDzSgBLqbfjMZPUPpyZDUP7UU1l75Pn8NaJbhwNgX2k=;
        b=F0OHsou3dHu0PmAMBDKd2U8015s44fTIM1tBwMPUwuUIi7+vkD+npdzqgWU4dVw2QM
         EfwYTFr7SbIXjBynSy6eUapbmrcJ/qLoaTnmj4pPabMIKFQ2X7cBr0dWzYzbi8smvZvN
         /kqiGgW2NWqdo6iH4VhjMEBQRDQ1Z/f/U9F4uvB6jP0j5NZg8cTNvZIVpTeNCd7pi8Ve
         A6rqo5+4LJfFJsIBddj5wBngQoXU56nrA+TfeINt4pEs6sKOzkxD81gxG9cZwM8aTR2s
         SkICgnQuLmfsHZrvNv0NFoidlQy3E6L6QB2aMTvOjYNbjlQerdtTvBcguZZVyy4+aFBy
         I4yQ==
X-Gm-Message-State: AOJu0YzAw9JbW3NGpFZIpT5esAWf2OfPy/xPrmXHjlElGKfuKE5FelkC
	Ph/yGDvUG7wJipxP5mSfhKg=
X-Google-Smtp-Source: AGHT+IEmYCqYOqp7Odv/O1n9QDOcKeNQJsi0xZpvXJVCsep+CyzBbzudX1SU/TIFl93kG06ZwLcYIA==
X-Received: by 2002:a05:6808:1209:b0:3bb:d83a:99a8 with SMTP id a9-20020a056808120900b003bbd83a99a8mr187720oil.58.1704843845345;
        Tue, 09 Jan 2024 15:44:05 -0800 (PST)
Received: from mizu (142-255-118-068.res.spectrum.com. [142.255.118.68])
        by smtp.gmail.com with ESMTPSA id kj1-20020a056214528100b0067f4e2ad746sm1287050qvb.44.2024.01.09.15.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 15:44:04 -0800 (PST)
Date: Tue, 9 Jan 2024 18:44:02 -0500
From: Brennan Xavier McManus <bxmcmanus@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Ammar Faizi <ammarfaizi2@gnuweeb.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tools/nolibc/stdlib: fix memory error in realloc()
Message-ID: <ZZ3aQv3bKk30kKZA@mizu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Pass user_p_len to memcpy() instead of heap->len to prevent realloc()
from copying an extra sizeof(heap) bytes from beyond the allocated
region.

Signed-off-by: Brennan Xavier McManus <bxmcmanus@gmail.com>
---

All tests from Ammar's original test program pass:
https://gist.github.com/ammarfaizi2/db0af6aa0b95a0c7478bce64e349f021
This fix was tested with the following added test for realloc():
https://github.com/brennan913/nolibc-test/blob/main/nolibc_test.c#L73-L120

 tools/include/nolibc/stdlib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index bacfd35c5156..5be9d3c7435a 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -185,7 +185,7 @@ void *realloc(void *old_ptr, size_t new_size)
 	if (__builtin_expect(!ret, 0))
 		return NULL;
 
-	memcpy(ret, heap->user_p, heap->len);
+	memcpy(ret, heap->user_p, user_p_len);
 	munmap(heap, heap->len);
 	return ret;
 }
-- 
2.39.2


