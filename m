Return-Path: <linux-kernel+bounces-2449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3925815D4E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 04:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887A91F22224
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 03:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DE65221;
	Sun, 17 Dec 2023 03:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flKZvGRI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC673D8F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5906e03a7a4so1429330eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 19:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702784201; x=1703389001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jscYpo84xIlTIrjQEZDT5YAVqLMOQqnP0eOYv7+MbRw=;
        b=flKZvGRI+Uua7WsjtvqA9nn0T569knckk+H60qEvF/zCwSdggTFneukCVOqgBW9L5R
         DGNgoSutc3hlJUgVBLAAVMlek5WX2Hv48gcJS3rDGthaxcNp/YwtoabPplOVsDWCASa+
         NyCuUOklj+ndrwEcTCahP0lYtU1Qoyqy7CzJG0bOxJLWS+MzDHvaKOX3fmKIWVzR4srK
         45NHzv5CdaghJ1wdDkDbFg6yqNldBlC9Wt5w171J/V86VBWzYfwpnYrgBWXYbd44d2Dd
         l89YOtyA585Y6CXSNpGIr+xJ9nGTxaMm3nKy0Yw4eCdt3aHqvWWeov53MjIxPFegev29
         BSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702784201; x=1703389001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jscYpo84xIlTIrjQEZDT5YAVqLMOQqnP0eOYv7+MbRw=;
        b=CFOGda09j7cRXMkYiC3GR+rfHFiLDFtr+H60EUIs7yEaOgFOyb/Gfve35gwywEIRXz
         VPXaRopAmD49Hol3T7V7jN4a5nWkKaEK3SBWi9MuLYYPJ6UeXWhtkAZzQ3Ri1qTI7eSg
         g1uXSlfTCB6W6U1oWaTG10SilNi46OAkcFZ5tvdXgSTT2xfpgeV3DVdc2JYMMZgFhZyt
         ca+yvJ3SehpfZQ90ns97Zx7j/AB9FKfelwCcQJ+ilBDT/m6a/QwMriA1t4u1X8HhmZST
         ZbFXwVx9533mKuF7tLQdFE3nP9Zt/+QxQzXZe+4v6Z3YCiHOQWj/2FzPcKAPO5Pzq20K
         6G4w==
X-Gm-Message-State: AOJu0YzVZSC3FhVHEtdiDSVN4ZAHKAF97hJJEPCWEvN4Ug504ev02bg7
	vtOlzgYv62i4gamx40kDkDYs+buc0xQ=
X-Google-Smtp-Source: AGHT+IHxfeJ2/5ZmVlwHFplWezFuqpKI/InwfEnH6Lv71yXTfqFxulFEco7zz2dzTje/5OiY9iM0Sg==
X-Received: by 2002:a05:6808:3197:b0:3ba:18f:62c6 with SMTP id cd23-20020a056808319700b003ba018f62c6mr17936532oib.7.1702784201449;
        Sat, 16 Dec 2023 19:36:41 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id x26-20020a62fb1a000000b006ce48a0b7c6sm15768820pfm.109.2023.12.16.19.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 19:36:41 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v5 3/3] x86/kexec: use pr_err() instead of pr_debug() when an error occurs
Date: Sun, 17 Dec 2023 11:35:28 +0800
Message-ID: <20231217033528.303333-4-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217033528.303333-1-ytcoode@gmail.com>
References: <20231217033528.303333-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an error is detected, use pr_err() instead of pr_debug() to output
log message.

In addition, remove the unnecessary return from set_page_address().

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 2 +-
 mm/highmem.c                      | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index a61c12c01270..472a45dbc79a 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -424,7 +424,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	 * command line. Make sure it does not overflow
 	 */
 	if (cmdline_len + MAX_ELFCOREHDR_STR_LEN > header->cmdline_size) {
-		pr_debug("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
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


