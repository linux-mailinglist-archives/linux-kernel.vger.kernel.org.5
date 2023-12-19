Return-Path: <linux-kernel+bounces-4809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 916C581824A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A20280F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4022B13ADE;
	Tue, 19 Dec 2023 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhwlhn7L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FCA13AC2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-20364459774so2477544fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702970955; x=1703575755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVJnoRpc0nLQgXbaa396BAC/JfAbiv/gDW/cLPNXvHA=;
        b=fhwlhn7LueHvmh33o02ITomifkZOBL9p9Z5jUqylDKT9eyuclP0jfbjxymWv8ZNGpC
         6sFRqxNrW+aLLsaGL2iR8bEPsLCfj65HuFH1zVRfit0/z/tNCYXCw0bSJc+zVUdVirSg
         L/BQFxnexYMXFJf3YSdDjRfjN2pHEWLPo7CCHuPcrRjMgMw85fvAVBi0KoJmy64KBo9d
         4Y4I0NqvOMz7cK0oEgxWLSubweNOZOTOY5oPbeMuXXWMV+B9gwi4GMyk3MEeGzLJKmDs
         52m5uQXbR+N6+122UVf59IWl2Byybfr2/1es22KBK/Ylyzrsc7mUFqarxRsS7LSG/wLX
         ps1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702970955; x=1703575755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVJnoRpc0nLQgXbaa396BAC/JfAbiv/gDW/cLPNXvHA=;
        b=TTXCIU1/VJfZssM6dOMnN7JouR4VMkkmcXVpmCWKzTC7+LlLYwZXrBO9uLp+FlcMyr
         3QbCK0VS2QM1TPf0K0NZz4iMK9paex3FmMaKw9A+9LFl1QQZQXOgCrKzV5Ji57CiRga6
         iXXS/qF9wdTtJz7XNLadYfA+k3YhIiN+4ippizqGj/4vGrzhy0wZlOA6KAs9zxyJjqF1
         R4++KAlmCbZvyyn4euZpIQnvPrtyv8LqRRVnyTfrFUGsF1sioCXHsM4osf6s3x04JwCQ
         dxEoFgS+pMrXGnjWO7YOtpCk2THlGiyRcYJznO4uFMUSEM+4TZ7aTGAI72Q+hNVzk3cg
         lmzw==
X-Gm-Message-State: AOJu0YyB61RP0/ZIMRFEMZLSYyq0ZUNqAHD24DK4mPvo3umVZfYZsO6/
	qiUx264BW9Z5DJlCpU+A6l8O7KwAJ6I=
X-Google-Smtp-Source: AGHT+IHHdMs06uEO4+q/2bAZlRhxq6UUVNPFy9zVB4+gT6OvgQtBr2ly3NWW2ZDs89vzBi69wIq06w==
X-Received: by 2002:a05:6870:ac1e:b0:203:b0e1:eb7b with SMTP id kw30-20020a056870ac1e00b00203b0e1eb7bmr4201311oab.29.1702970955215;
        Mon, 18 Dec 2023 23:29:15 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id a9-20020a654189000000b005c683937cc5sm16388600pgq.44.2023.12.18.23.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 23:29:15 -0800 (PST)
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
Subject: [PATCH] x86/kexec: use pr_err() instead of kexec_dprintk() when an error occurs
Date: Tue, 19 Dec 2023 15:29:01 +0800
Message-ID: <20231219072902.90104-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218102436.4378f51a36525ce770f6cd30@linux-foundation.org>
References: <20231218102436.4378f51a36525ce770f6cd30@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an error is detected, use pr_err() instead of kexec_dprintk() to
output log message.

In addition, remove the unnecessary return from set_page_address().

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
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


