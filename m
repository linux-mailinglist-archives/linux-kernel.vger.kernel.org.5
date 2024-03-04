Return-Path: <linux-kernel+bounces-90772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AD88704BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89FA1F21BCA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E0F45BF6;
	Mon,  4 Mar 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4I7lUmX"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFAA45945;
	Mon,  4 Mar 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564583; cv=none; b=kW0ySVdwiAW/Dd+AqSOUNOrDyicl0bj9sKyQxo8J41a+V21cKU13hS14gJbQDvGeoelvGOHAAsuWVqiX/ej/fCIxSkTP7wnpIaoc5Hdc/not7jhYJmWkXf+i5dVi40VBefKQxb4CPok7xesReK1IkA3NzhTcOUlQO67EfjYpoKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564583; c=relaxed/simple;
	bh=E7m7xNV1pXS9SED3gi2iwd2vJh0Ek189A/1Yh1JvJYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTlOgsN5oi22NeJZaLmhLT4jYWOwtkgB12+tKY4WSmNi3XZ5/Lk93ZO7RXQBoaPFunOqDN3GSZ/ZZ+HK8Ab9nfOCjX7ixvy8J5vh5ZsGHzrZxZI04MgXFj6Fwac+63fWIyRzQejGjRsQ5T7G4HgahpzT38sDoZYFGHn6eCQZLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4I7lUmX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d944e8f367so30548845ad.0;
        Mon, 04 Mar 2024 07:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709564581; x=1710169381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnXcc/0pU6MGyLtNvp9rjgwSJZoETOROqPJlOVOWeAQ=;
        b=f4I7lUmXaF2BxDpr4TxBgWY2gKw/zAlaiA+dz1iFtI4mMKWEvKiFVSA+5ZU60AyxpX
         +eKqyI1dchTMjqFK+m0NT9yi3pVHV0YZ+GQBdjgI+N2Kn1wPPJtVE4Gs3aaoRDS0DemU
         OktQCCiS2BUvTtjEfNkpmEXiNh9hSqsPIO+RMQ66m6V82HGqyYadWtrMlt3xZsuEOacd
         Ih5ZnXfszDILs8pAmjL/O6ShAGChiM324AbizdoRgGg+98LeHZbrh8R3/lRbhUvt6kP5
         ydnbPKZw/8PeoVKd8EcMxtH5KuuNykAyACl6v2tMMn1xea8fUuDHPXt6sFHHzCe2o9M3
         qAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564581; x=1710169381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnXcc/0pU6MGyLtNvp9rjgwSJZoETOROqPJlOVOWeAQ=;
        b=rcH79JsGIf+R3nUU9jMfLIw2ETBrDHPfMPEIpDeqLg24Cq7OyXndujfgdKvkED2ACk
         D8zxcyzeuXn/VIDRIJjs/+FO/zDv4S2SraTlLORy4NDo5bFWeJFQ522nW9ITAqqgOqbE
         dN0X0p67Oa92jbdkS1r/FtK5qeh1F9FPRr4GIDQB5i88dEvtQLrr1zuvApbM7BzbMbGz
         vo0TAxv1C1vKUs4iwGtCibPU/920UgHqQR3oXgZHNqc4MYr4+qBr8hDRMriEyAwxr61R
         T4o/hjh/DwJYWYMXTFI0hExKYGdQ94Dwq8vcWDiaxhEErOiF7E7+gx0fgGlzXuT7m9yA
         6/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWkdalI/PGPXRh6x1fjQg/f6tN2spzZiBLwVlTWtgsfw50qeQ2YNNGsepfzSrBhAoutZ+o6BE61bslM1mh70spbm0LuT1yiv62CGYcz
X-Gm-Message-State: AOJu0YzXFIYojIgRlgm+kDrs79gUV0C2w0gA6XyGa2T3KcrT/Gn8NBWj
	k0Ig/FHw/g/0yPjovsGJOh9IVIaLNKDXeRRv0l/cRHhAt8Ul4jv1VBd7fU10
X-Google-Smtp-Source: AGHT+IHo7uSAOY7xHevAVNoD1yPBJfJR6TsI+tzQsEB+aQtTPbfOY8hhCOXO32d8l+xm5jAzUffExA==
X-Received: by 2002:a17:902:ecd2:b0:1dc:c9f4:2dab with SMTP id a18-20020a170902ecd200b001dcc9f42dabmr10973649plh.1.1709564581287;
        Mon, 04 Mar 2024 07:03:01 -0800 (PST)
Received: from localhost.localdomain ([49.142.40.215])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902fe0100b001dc941f145dsm8639675plj.253.2024.03.04.07.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:03:00 -0800 (PST)
From: skseofh@gmail.com
To: robh+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	frowand.list@gmail.com,
	linux-kernel@vger.kernel.org,
	skseofh@gmail.com
Subject: [PATCH] of: fdt: modify small size memory check
Date: Tue,  5 Mar 2024 00:02:26 +0900
Message-Id: <20240304150227.166053-1-skseofh@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAL_JsqKNGjKq3vcUPFiPa9JNq-8=oP=uBSD=tyKaPMH3cvAkww@mail.gmail.com>
References: <CAL_JsqKNGjKq3vcUPFiPa9JNq-8=oP=uBSD=tyKaPMH3cvAkww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


>>
>> From: Daero Lee <skseofh@gmail.com>
>>
>> After page aligning, the size may become zero. So I added exception
>> handling code for size 0.
>
>That may be true, but when would anyone only have memory regions of
>less than 2 pages. In any case memblock_add will just do nothing. What
>is the actual problem you are having?
>
>Rob

Ignore the previous mail.
I modified the patch to clear this size check routine. Please check

-------------------------------------------------------------------------
From 2135d37c37f8c369033f79102b17ddf5bb3ff838 Mon Sep 17 00:00:00 2001
From: Daero Lee <skseofh@gmail.com>
Date: Mon, 4 Mar 2024 23:21:14 +0900
Subject: [PATCH] of: fdt: modify small size memory check

Small size memory which is less than 1 PAGE_SIZE after page align
should not be added to memblock.

In this patch, the size check was modified to make it clear.

Signed-off-by: Daero Lee <skseofh@gmail.com>
---
 drivers/of/fdt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..9cf844e664b0 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1220,18 +1220,16 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 {
        const u64 phys_offset = MIN_MEMBLOCK_ADDR;
+       u64 abase = PAGE_ALIGN(base), aend = PAGE_ALIGN_DOWN(base + size);

-       if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
+       if((aend - abase) < PAGE_SIZE) {
                pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
                        base, base + size);
                return;
        }

-       if (!PAGE_ALIGNED(base)) {
-               size -= PAGE_SIZE - (base & ~PAGE_MASK);
-               base = PAGE_ALIGN(base);
-       }
-       size &= PAGE_MASK;
+       base = abase;
+       size = (aend - abase) & PAGE_MASK;

        if (base > MAX_MEMBLOCK_ADDR) {
                pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
--
2.25.1


