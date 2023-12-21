Return-Path: <linux-kernel+bounces-7832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E007881ADEB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8763B23B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE688F63;
	Thu, 21 Dec 2023 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi88D/iD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166C8F48
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28bf1410e37so137410a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 20:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703132609; x=1703737409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jQk7EpxEiCnw88xrJN/Bi8qLqCREQMGkFRovIaAVWdw=;
        b=Xi88D/iDWY1roNw0X7Z1b2ZcpLqyW0ZE3q1apbJKshisnbQuqoEaLnh4LQ76phWhOx
         bhwaK/UI/qX0DBszFzyQInbbcxpnNRVj9AOYVSSsd9mNKc3ze6jjpvQz1h/zsOdKemzJ
         Qb30WKROAVWQX1rr0DnczJaNRkR0ix/HCGxoNWAkyz7MtR8cyDkA/4knGaPJVcMnIIWE
         0zHwFMcF2C7TL3i8/u1SsiK8UBxK/1fZiF+kzvFmXdZ4g4thZeFLueS367jKakxvkiuB
         zDndlsgIJQYm75yKb7FCNdT4m4ps4OLySBRLmoxxJ58/gSIQK46KINqwwQ5+a0Vqpf0J
         +cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703132609; x=1703737409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQk7EpxEiCnw88xrJN/Bi8qLqCREQMGkFRovIaAVWdw=;
        b=u+oOBH5mH7Ffm4cK72pwXQ3PRujr0y7fUrzJo0WkMcaIf1kEyvYFaKacnZQ55UBlqu
         uX1WPHA73A4d6wDrhgUy6b1rC8OU9KO+s9Odl1Aq5rt92xbUe3Ev7piphzSqnUwpg000
         ibp7KU13ruC3TpPkK72wVyB4FGWTV1gjLpwxNuMiSA/Xx9Q34RqKPAJ4lIbcKmP5vH6y
         HZVRNbukeRnrbUJ2tdP1Rj72lwQL99v2KojBMzL51WNpp/UKVNSlEK6JO/lh/rSXEvJN
         u4QRbicAHodjlsWLOzdO+0pj2gYimEmKK+f73Xb2hlVEBcqHj3UyYcD/aDa61oiz2sLM
         yHYw==
X-Gm-Message-State: AOJu0Yw9fQtY94GjoHFk+SQYRKEsPW1PYMUgWH0jgFUkIUZ9NqGIyNqn
	I97LuZCoAc0yt2l6Nu795kf2cadFQXM=
X-Google-Smtp-Source: AGHT+IFD5tSw6Gu2ysxsWhnmuA7VMZQSZfGTc1y94lnLOCK5XyqmjJGeYsGpaZEl6wgcWKagK9pmCA==
X-Received: by 2002:a17:902:e551:b0:1d3:dda1:f16b with SMTP id n17-20020a170902e55100b001d3dda1f16bmr4512638plf.9.1703132609307;
        Wed, 20 Dec 2023 20:23:29 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902d3c400b001d359f150f9sm531972plb.265.2023.12.20.20.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 20:23:28 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] kexec_core: fix the assignment to kimage->control_page
Date: Thu, 21 Dec 2023 12:23:08 +0800
Message-ID: <20231221042308.11076-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

image->control_page represents the starting address for allocating the next
control page, while hole_end represents the address of the last valid byte
of the currently allocated control page.

Therefore, after successfully allocating a control page, image->control_page
should be updated to `hole_end + 1`, rather than hole_end.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 2f039a7d9af9..a08031b57a61 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -457,7 +457,7 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 		/* If I don't overlap any segments I have found my hole! */
 		if (i == image->nr_segments) {
 			pages = pfn_to_page(hole_start >> PAGE_SHIFT);
-			image->control_page = hole_end;
+			image->control_page = hole_end + 1;
 			break;
 		}
 	}
-- 
2.43.0


