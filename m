Return-Path: <linux-kernel+bounces-127924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42968952C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFEFAB26C70
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80BE77F0B;
	Tue,  2 Apr 2024 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AO/yqQd+"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C023D547
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060376; cv=none; b=PuKfgxdGONcduP5u7TD5Fperd47KTtSHVWngmwBlWMAbRVUguNIh0GmS2IwBF2q0j2igOg2CsVYeTJazE8W10eIw3u85xILmsPGMmRWTLPoZm0lgMIiJfsIeVqZ1xLzlx4i3HW/jWPXBTIRprf+/88+2UfY2WtAp/YjHNKZaj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060376; c=relaxed/simple;
	bh=SxN2kRRSNg7FIiCTwGfGMFWSHQEYaGhOTNRnqmFeVb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLo57jlaIL76yIz0g5D4Ssy6QVKGdNtnE6nbiH1Nm/JrzlGW9uhsz4qoCDDuiRq94hIlU/Y3Qr23CWmaCq3JCDjIG4IPuvL1uib9QZk2w/lLHeiNMp8gDngHQEgZsdRUMANfcC9ZvlFopj0OGSLbb2tRaxp+SLQkqSQxxsrVXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AO/yqQd+; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-515b3077d09so5514834e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712060372; x=1712665172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBMeIJyQXJd0P9fli/s8lXYuCNIymgMK4qXq2E5aD8E=;
        b=AO/yqQd+UjcB7CFFZxo2bUs9dC8mB3RzIdYSb7wh18WVmZjNcE8KqFE8ngKpoV3XRI
         6dIA/r6SKfi9TMxZ3dDaK0M4ffpSsz0E36EboMUqJtm1pFFfvfs2R/T5Wp55OgaRI3vF
         ZqP64NZJGpfsI/CyQGrCDxXS594bhzlamj+Jh5JPkg1feh8sQGMJYdnG4ygQnMO7de5a
         kvn9LCif1QxUqMoSiw65PeNIyHvAn1j3YXTQo0IxRpCNSYpEGTGWdH7cVbj1O1K9U6J8
         HRHjuIqJb/by2BmmcBg5Na/XxvYVaXvlnXk0HQ0XcxyEdu/DXrn3HOl7ppIYm7cJhUJU
         p2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060372; x=1712665172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBMeIJyQXJd0P9fli/s8lXYuCNIymgMK4qXq2E5aD8E=;
        b=pxUgkenhGcJmMHNIDCv1uhCBOa+PHqZxYW0FL7mJR94inmC+j++LLTXWOg1tPEl6Bc
         VnCMPzSirsHfWv59s8JrHv8iMNgX1xL4cCjInB/hHroC5Y8IQ6OWLAhGVyjVEAPrekda
         l/d+gO/QPJN/HKHP5ZD8vrQg8INvQfmUysWY4L4550vzvUFj6hh9QG1SMCneYZqXWOxS
         bWgYEET0YYZoiLPIlGUicqbqdq4ciL7ItXrQO0q0wa5U7uwGfzbEehsaPQI/rbOL24cy
         IM5lG4YSUWOE2TPDZw7c+/brhsSn1pL9cSCPlY12Eps4Dm4WqCuuHDlFQPyF8aqXB/ai
         v0YA==
X-Forwarded-Encrypted: i=1; AJvYcCXWCXko8GSvrNKWNO3mv5GjeVEeB4v/pItAWjF58Ut4xymAoqSj/rmWgPFxesx+ZyL82NRR9xHIh3nTqlZbkzehuXqQ3SOCgB7I8cpe
X-Gm-Message-State: AOJu0YzBwVJA0PHDu2CtajmnIspPKyIkT6iUABTf/9bZe671V/IgNfDv
	hWda7XJxqyNhbnHstEhJl5fKXbqWCwXYID5Rd1tF8Ar7/o1N3Fh+5O3zh8vI+rTL0Q==
X-Google-Smtp-Source: AGHT+IHf2vMQeI/9lsWXQS5t669nAjoRathqHCj/MPd7TVTZIVlKYOVGJsBGwqwY7uRFajZLIxOEAQ==
X-Received: by 2002:a05:6512:713:b0:515:a8e0:bf3c with SMTP id b19-20020a056512071300b00515a8e0bf3cmr7981286lfs.32.1712060372252;
        Tue, 02 Apr 2024 05:19:32 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id fj22-20020a0564022b9600b0056a2cc5c868sm6659535edb.72.2024.04.02.05.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:19:31 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jakub Jelinek <jakub@redhat.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH tip] x86/percpu: Re-enable named address spaces with sanitizers for GCC 13.3+
Date: Tue,  2 Apr 2024 14:19:08 +0200
Message-ID: <20240402121926.78477-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit:

  b6540de9b5c8 ("x86/percpu: Disable named address spaces for KASAN")

.. disabled support for named address spaces with KCSAN due to
the incompatibility issue between named AS and KCSAN.

GCC 13.3 has fixed this issue (GCC PR sanitizer/111736) so the
support for named address spaces can be re-enabled with sanitizers
for GCC compiler version >= 13.3.

Note that the patch considers GCC 14 to be fixed - if somebody is
using snapshots of the GCC 14 before the fix, they should upgrade.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jakub Jelinek <jakub@redhat.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/Kconfig | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5fbe8ad39cc1..c62db6b853d7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2431,19 +2431,18 @@ endmenu
 config CC_HAS_NAMED_AS
 	def_bool CC_IS_GCC && GCC_VERSION >= 90100
 
-config CC_HAS_NAMED_AS_FIXED_ASAN
+config CC_HAS_NAMED_AS_FIXED_SANITIZERS
 	def_bool CC_IS_GCC && GCC_VERSION >= 130300
 
 config USE_X86_SEG_SUPPORT
 	def_bool y
 	depends on CC_HAS_NAMED_AS
 	#
-	# -fsanitize=kernel-address (KASAN) is incompatible with named
-	# address spaces with GCC < 13.3 - see GCC PR sanitizer/111736.
+	# -fsanitize=kernel-address (KASAN) and -fsanitize=thread
+	# (KCSAN) are incompatible with named address spaces with
+	# GCC < 13.3 - see GCC PR sanitizer/111736.
 	#
-	depends on !KASAN || CC_HAS_NAMED_AS_FIXED_ASAN
-	# -fsanitize=thread (KCSAN) is also incompatible.
-	depends on !KCSAN
+	depends on !(KASAN || KCSAN) || CC_HAS_NAMED_AS_FIXED_SANITIZERS
 
 config CC_HAS_SLS
 	def_bool $(cc-option,-mharden-sls=all)
-- 
2.44.0


