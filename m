Return-Path: <linux-kernel+bounces-594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BBD814358
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649521F22904
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881F918E3A;
	Fri, 15 Dec 2023 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhcL3mRM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7345118C11
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ce33234fd7so164062b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702627809; x=1703232609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jscYpo84xIlTIrjQEZDT5YAVqLMOQqnP0eOYv7+MbRw=;
        b=PhcL3mRM/fWe0x2fK9715Zgyr7btw0S9r3b13/smCMVLRWnzf1V8wc+iSrj288cW/I
         buRQNtosyirMKLGkhFScBCAE01T5FRJVXuVKQA/gbM7tD8NXASZYQIoiHoevchtAu4mI
         WfjEOHOFytfvAPENwDsZSbgydt090LeMCZvhqzEHdtIeIIe0hGT62mV6rjH59W+Xbg2e
         oiMA9Nib6O5E70wa6uJ6KB3jeSa9NCvjqwuQdnBLhW6AwFZaAHaDDqz2WZ1JJtXXSQed
         gaSFCouZ+flY58prx768qpUTHqwhVhrlxhN5a6lWSXbiWX1hZ+EbtvDM6DJ36n9zuSER
         uDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702627809; x=1703232609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jscYpo84xIlTIrjQEZDT5YAVqLMOQqnP0eOYv7+MbRw=;
        b=ZuG1Y6hTYrjd4AHaLK3U50sM7n9LX+zxDpsT4u3cSte8CcAMw1h00FT+2+FZAgnK2H
         vRXaaT06WJY8zTzexHQH9AU05n24iK1Pmw0ebY+/TpxqsINqgrlE7izrrjNyc+f/UCCu
         068aOuYht5oOxSd0tInswPTdM3/nuef0Q9RRyU9bY7/t5AXr/XIdOOwDVrx/ZqiD4NrT
         dQ0BOLZNwRCwgftPbIuvAc5YQGJP8kTG59jH0KJ7afcZIfUjddyFK+vcCMtQSyR/O8ls
         mTQ+n8eyudqt3BvSWBsgx6pbSktN5ZtLzUmf8a+6zJ8it/41jUrZF+IKrl7tey932cRK
         6bPA==
X-Gm-Message-State: AOJu0YzZYBhZIC3vcVW92VoXxPQyfVNj1WEuvQZfXAEVHcL6FcFV1uzK
	WZ7QQYLx42NCQ+3T7K3A2Sb+FVPAwWo=
X-Google-Smtp-Source: AGHT+IFvEn6WjjxL9AELNTiUvLF5ar5KlNxdVOf+PtdHoCcSbpAc03KyD4vE24Y4VgQbfpvos6DDnQ==
X-Received: by 2002:a05:6a00:4601:b0:6cb:6a27:ab57 with SMTP id ko1-20020a056a00460100b006cb6a27ab57mr5960984pfb.14.1702627809447;
        Fri, 15 Dec 2023 00:10:09 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b006cee656cb35sm11783792pfl.156.2023.12.15.00.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:10:09 -0800 (PST)
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
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 3/3] x86/kexec: use pr_err() instead of pr_debug() when an error occurs
Date: Fri, 15 Dec 2023 16:09:10 +0800
Message-ID: <20231215080910.173338-4-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215080910.173338-1-ytcoode@gmail.com>
References: <20231215080910.173338-1-ytcoode@gmail.com>
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


