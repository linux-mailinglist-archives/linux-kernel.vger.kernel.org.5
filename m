Return-Path: <linux-kernel+bounces-13703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FFE820B64
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 13:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C703E1F21792
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2D24699;
	Sun, 31 Dec 2023 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlVpLuWU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0478F4415
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3dee5f534so58277755ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 04:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704025247; x=1704630047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwhX+cAV5A0hcUGz8xI0OEKJHWE3jawNxtgj/Y32ErQ=;
        b=QlVpLuWUo3vf84T8DPP20qaOJkHym9Gmv6dN7v5NuxLH5h5lsBM0CKjAdFhruEwZVr
         F8mqXUI/7QW3xdn1CxKTCMfGhyBJ8UbjH8n8Eadm0RPchAxXjhXetiuKONx649HqEVD9
         +6VlrlhhSAVDdwefzLgYo2/WbbybBP0uMc7Z4V/zA22YPuqLsbZCw0Fn5msHocUESaqa
         znShDDSV0hB9KJIaEjQwLPW65c1EV01V7bdbkGXGWzMmn9lwyF5cjE3EEHQvCxOwmk3T
         Y2lKfPKMb9f8mTHOtNGBxqYGN+l3EHQ/HX5NRyHQ0fh98GE2+EIuBbvtqBBa5HJO+z4n
         mJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704025247; x=1704630047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwhX+cAV5A0hcUGz8xI0OEKJHWE3jawNxtgj/Y32ErQ=;
        b=gWyQ7zfGsaZYeJ9ArHYKfNcK7664WXNLBcvwgNtlDENya7nU7n8LjkBVQBk3SrSVo8
         en6R4CCZkThVBO5r/6NhaGM048Y6zlPJc2LQgRl4EqNLCJ70SWzfZ8wKIg+ZyAXp3FyB
         wOia/fjgaVwcOo1RCM4IgCAQKrmwsxFlL20lZUTOG77wBhqeQL1WydTfbbNVH0kJteVk
         LkPG/TjD2xBZgt2vGe6lZCR6rnJjICXKhWhoZurpAugt2dizw3871LJBXO0JtnUuG1jb
         7eLPbsAlCzLYVKiUJfGE36N07OjOxqSjXbhjIhoklvgZIDZUZTl89K2eZen3L52j/CpK
         BVhQ==
X-Gm-Message-State: AOJu0YzOa+gVPZCLF7tJeY+GdK65m2TTGFKO1N0Uk23K8tRUVlKTXiNq
	6IaMFBWc+9nhmJqUZ4wcWd2bsJeRxydCtA==
X-Google-Smtp-Source: AGHT+IGKZtZvJGkeJmV5NmzrUWh5fq0p+ugPtzR9v3Q1VFuyqYs/WoHIJP+Tscmtk/kVxjf8dABN+A==
X-Received: by 2002:a17:903:2285:b0:1d4:3aa8:fa37 with SMTP id b5-20020a170903228500b001d43aa8fa37mr14994904plh.29.1704025246965;
        Sun, 31 Dec 2023 04:20:46 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id k24-20020a170902ba9800b001acae9734c0sm18352223pls.266.2023.12.31.04.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 04:20:46 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Brian Gerst <brgerst@gmail.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] x86/head: Simplify #include "../../x86/xen/xen-head.S"
Date: Sun, 31 Dec 2023 20:19:04 +0800
Message-ID: <20231231121904.24622-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since `kernel/head_32.S`, `kernel/head_64.S`, and `xen/xen-head.S` are all
located in the same `arch/x86` directory, when `kernel/head_32.S` and
`kernel/head_64.S` want to include `xen/xen-head.S`, we can directly use
the `#include "../xen/xen-head.S"` directive rather than the more verbose
`#include "../../x86/xen/xen-head.S"` directive. They point to the same
file.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/head_32.S | 2 +-
 arch/x86/kernel/head_64.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 487ac57e2c81..7804fff8bf8e 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -500,7 +500,7 @@ __INITRODATA
 int_msg:
 	.asciz "Unknown interrupt or fault at: %p %p %p\n"
 
-#include "../../x86/xen/xen-head.S"
+#include "../xen/xen-head.S"
 
 /*
  * The IDT and GDT 'descriptors' are a strange 48-bit object
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 0f8103240fda..af31200a2ebe 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -748,7 +748,7 @@ SYM_DATA(smpboot_control,		.long 0)
 SYM_DATA(phys_base, .quad 0x0)
 EXPORT_SYMBOL(phys_base)
 
-#include "../../x86/xen/xen-head.S"
+#include "../xen/xen-head.S"
 
 	__PAGE_ALIGNED_BSS
 SYM_DATA_START_PAGE_ALIGNED(empty_zero_page)
-- 
2.43.0


