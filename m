Return-Path: <linux-kernel+bounces-6310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957E981970A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CC6282563
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3684AF9F1;
	Wed, 20 Dec 2023 03:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKFa8s5/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501AED312
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3d0faf262so18179215ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 19:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703041296; x=1703646096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDcGZt780N7cf+8KzhOequQQWw83UVMubMF6UVq890A=;
        b=ZKFa8s5/xZFN+KZtL10Pg29ffY6IuJKkiFIr2vYiReTkG21rWuif2e7jt/p0d+qxs/
         adkG+sV/UXQ9RzHHYO9KpwKrvi23hJVRWP3eyQRDInXpc1fyk+A9mhWCuXO/kmVXxPvI
         zkjCGJGq4tSUDI0azdGEXvHGAEe6W/0nFKINtGVuOihPqbqzneg7B5Jt7JCIg1Ta9XQ7
         LQx0jNUk3e/3FQV3+ucczfnWiu6UPBxn5SqrRZl/ADj4+MnVCb9CyL+8zbb9W1vKvi/4
         sGutPQ+7C+/ciExomhx190URRmvzxMU+CFaRuuOUwMmMbV+45gEffJ4bICtVVrsrDanF
         o23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703041296; x=1703646096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDcGZt780N7cf+8KzhOequQQWw83UVMubMF6UVq890A=;
        b=IC2mnOgIBB31KCJ7d7DOVXijsya2dkaSFvRJyydkd0za441+uVrI0BekvA85ZSgeXU
         gFIOjuCHrQRIRj/2vQ6yaNxkGwdZqIjvhmtbWDnA5cNGhNHNe1zWmTX8GKJDmeE98Mdw
         7IGqajGt5Bj4/Md0RNd4uq5E4LglS+6GSKO+En9yLsJGn+1mhZAWe8ddHfEK2r6QuOFc
         8cN97T6fkBC3nPmvRXVlD9JaoKly91knHUYZmdefiSMKoOL8lTJhOB2iQXooa7p7IN+l
         o/qr0jfDSCF41CRwsgKf/ETxHe5RIanCd5gtQWGHiQINbxuysTPJi5DcsI8Xfhrus+4K
         FNOw==
X-Gm-Message-State: AOJu0YxxCxXkQ+mpTwWrxElMRXSX5n0s//Kfjp12bTP3ZgQG/RykJ5BP
	RlfzkTo6wU2kfZMwYAbjGGJ4HhFMWIE=
X-Google-Smtp-Source: AGHT+IEDTnad5cVvWJ4zCxN1KdcFYYIzAX5inlXZMrowaBwcuL22z2qHYQWCeJlX6qAI0qKDn09DlQ==
X-Received: by 2002:a17:903:234c:b0:1d0:c418:1758 with SMTP id c12-20020a170903234c00b001d0c4181758mr23877565plh.66.1703041296453;
        Tue, 19 Dec 2023 19:01:36 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b001d38410aa13sm8752200plg.192.2023.12.19.19.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 19:01:36 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: akpm@linux-foundation.org
Cc: bhe@redhat.com,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: [PATCH v2] x86/kexec: use pr_err() instead of kexec_dprintk() when an error occurs
Date: Wed, 20 Dec 2023 11:01:24 +0800
Message-ID: <20231220030124.149160-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219122151.aa4ae562537abf74067588fe@linux-foundation.org>
References: <20231219122151.aa4ae562537abf74067588fe@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When detecting an error, the current code uses kexec_dprintk() to output
log message. This is not quite appropriate as kexec_dprintk() is mainly
used for outputting debugging messages, rather than error messages.

Replace kexec_dprintk() with pr_err(). This also makes the output method
for this error log align with the output method for other error logs in
this function.

Additionally, the last return statement in set_page_address() is
unnecessary, remove it.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
v1 -> v2: Rewrite changelogs

 arch/x86/kernel/kexec-bzimage64.c | 2 +-
 mm/highmem.c                      | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index e9ae0eac6bf9..4a77d5dd4bce 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -429,7 +429,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	 * command line. Make sure it does not overflow
 	 */
 	if (cmdline_len + MAX_ELFCOREHDR_STR_LEN > header->cmdline_size) {
-		kexec_dprintk("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
+		pr_err("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
 		return ERR_PTR(-EINVAL);
 	}
 
diff --git a/mm/highmem.c b/mm/highmem.c
index e19269093a93..bd48ba445dd4 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -799,8 +799,6 @@ void set_page_address(struct page *page, void *virtual)
 		}
 		spin_unlock_irqrestore(&pas->lock, flags);
 	}
-
-	return;
 }
 
 void __init page_address_init(void)
-- 
2.43.0


