Return-Path: <linux-kernel+bounces-162947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF408B62A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415D71C21C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CBD13D249;
	Mon, 29 Apr 2024 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikArP1aG"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B839713C905;
	Mon, 29 Apr 2024 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419577; cv=none; b=uVEexxTvrT1spvZxy9Vb2ES4RrBbUi7uJwv2xQ8DYoZokDfcvX2RU/mS38SwnrXsWZQc80AmQVieMVBuahBcYrJg9a7SwGbEAGKNPJ9XFX7tfBVrnqhX53gwaR62JFpOZg16k0WuFuCxlSRRoUjRn3ciMMyfXtbAUoOH9GKIFME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419577; c=relaxed/simple;
	bh=cbGNy8oRP5j6w2LmDVqbEZBzv/tKmE/tTg++QyjnhhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgMbJOIMSjNy4HN1ZgTNior2fXyVTLZQRmfIfr1acQ12Mcdom27WQzpL9yU5r2r5tG1ow9GGb/Lx15Zz69IyRejhSCxY/0tBOiEkc0Vds5wY32sAJTyiJb5UIXyUnqQPONyq/hINzDUEOcTepwwR59pMar1MJl3+PedhbOS+/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikArP1aG; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7de95c7851dso238409539f.3;
        Mon, 29 Apr 2024 12:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419575; x=1715024375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7XDhXTeJoMWhkzTMSqQ0RhDu3HmDRaZUb49U4GCNsc=;
        b=ikArP1aGs/QNps2aKA+ZWWCyPNOjaTe0GEkYvUEWEXhR4a4l7CppPCPZFpDajrk5tf
         X6FARrkL6Ahj22CEaTgLFTSna0OQpHh4xZRiPLtHnFJI+MV0aoaUzn8QI2T+UKFwkU5X
         wO5cKV2ednluuzpDvnbfcQfO5IfZM5aF+8Jk0FC8Chu5+QcOusz28FP8jWwleONSirV9
         dKeTHn09jlHBGrHZXBCoowWQEdt3NtjuGOvODl2W4Ul12veBmOMHK1t0CsHU5KVLVLQA
         NmkXpMCbdLrtLMoU/BmpFTbC9PF/G/LVOalvzYcigo5GSPYr3UUWJ1XIKvjIMTEM7XH0
         aexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419575; x=1715024375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7XDhXTeJoMWhkzTMSqQ0RhDu3HmDRaZUb49U4GCNsc=;
        b=vqGhf+9QonXFXMJSPijyN0a10tm/kIrpM8QPNxCMuN6LSN7rMkA37sgoMHY1QN9w14
         WCGOW51F/ngHFU0V7Uj4Wfv0TWdVw6AgfPdHl/DlC147ZYOeDQJIpX8Fu6ABuoM5V9hR
         qRtZefXWdjnWfjJt7l0jGWm/sDTyaGqIoL7S80r6TwZgYTEMklKsBhDxfaosWaHLYu2v
         19g6ghXMgRq9nqDBYtpByuZDbjf7yz5pFaEEude2attC7SIocSdFHAk8YcRPKqZHN4G6
         tRiX0Qkb7/Sgc8m5N5MgsOxJjjjVqR8wAHzulWuFXwhS2u9fADrL8cdI8HJYtVPxsNBJ
         Injw==
X-Forwarded-Encrypted: i=1; AJvYcCVnxsY4NBpDrlThg1h5Ythx0hotczwEXKEnVUW2VTon5icgG7X/GJy5l5DqmJGrOccTDtR6KtD1pEeKc2bo1n830zFgLdlzn09QHAALisPaFnYRKd9nknIoBqF5A1AWapi95fIHPnF6
X-Gm-Message-State: AOJu0YxMkz1iWc861KkvbDpmrq0nOMUnVr1Hn1r0vWpPcZ6i7t0hWCwy
	LrbV2HBpmEOo+/EiJZpe4gM+KRVxdMtSRqzYvYazuKBY4WLpDLXi
X-Google-Smtp-Source: AGHT+IHJ/J5CefPQItxbTqpcVctn5XpjkZ7VwJHP2udddod5gEHQAu9X47g8K13Y1gCMh2a+kWL2bg==
X-Received: by 2002:a5e:d717:0:b0:7de:da98:4d10 with SMTP id v23-20020a5ed717000000b007deda984d10mr998566iom.17.1714419575074;
        Mon, 29 Apr 2024 12:39:35 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056602165000b007de9f92dc57sm2325105iow.16.2024.04.29.12.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:33 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: ukaszb@chromium.org,
	linux-doc@vger.kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 26/35] selftests-dyndbg: add test_mod_submod
Date: Mon, 29 Apr 2024 13:39:12 -0600
Message-ID: <20240429193921.66648-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193921.66648-1-jim.cromie@gmail.com>
References: <20240429193921.66648-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This new test-fn runs 3 module/submodule modprobe scenarios, variously
using both the generic dyndbg=<queries> modprobe arg, and the
test-module's classmap-params to manipulate the test-mod*'s pr_debugs.
In all cases, the current flag-settings are counted and tested vs
expectations.

The 3rd scenario recapitulates the DRM_USE_DYNAMIC_DEBUG=y failure.

1. 2 modprobes (super then sub), with separate dyndbg=class-settings
   check module specific flag settings

2. modprobe submod, supermod is auto-loaded
   set supermod class-params
   check expected enablements in super & submod

3. modprobe super, with param=setting (like drm.debug=0x1ef)
   modprobe submod
   validate submod's class'd pr_debugs get properly enabled

The test uses multi-queries, with both commas and percents (to avoid
spaces and quoting).  This is the main reason the test wasn't earlier
in the patchset, closer to the classmap patches its validating.

With some tedium, the tests could be refactored to split out early
tests which avoid multi-cmds, and test only the class-params.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index ddb04c0a7fd2..54acee58cb4e 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -250,10 +250,70 @@ function test_percent_splitting {
     ifrmmod test_dynamic_debug
 }
 
+function test_mod_submod {
+    echo -e "${GREEN}# TEST_MOD_SUBMOD ${NC}"
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    ddcmd =_
+
+    # modprobe with class enablements
+    modprobe test_dynamic_debug dyndbg=class,D2_CORE,+pf%class,D2_KMS,+pt%class,D2_ATOMIC,+pm
+    check_match_ct '\[test_dynamic_debug\]' 23 -r
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+
+    modprobe test_dynamic_debug_submod
+    check_match_ct test_dynamic_debug_submod 23 -r
+    check_match_ct '\[test_dynamic_debug\]' 23 -r
+    check_match_ct test_dynamic_debug 46 -r
+
+    # change classes again, this time submod too
+    ddcmd class,D2_CORE,+mf%class,D2_KMS,+lt%class,D2_ATOMIC,+ml "# add some prefixes"
+    check_match_ct =pmf 1 -v
+    check_match_ct =plt 1 -v
+    check_match_ct =pml 1 -v
+    #  submod changed too
+    check_match_ct =mf 1 -v
+    check_match_ct =lt 1 -v
+    check_match_ct =ml 1 -v
+
+    # now work the classmap-params
+    # fresh start, to clear all above flags (test-fn limits)
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    modprobe test_dynamic_debug_submod # get supermod too
+
+    echo 1 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 4 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( V1-3 + D2_CORE )
+    check_match_ct =p 8 -v
+    echo 3 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( D2_CORE, D2_DRIVER )
+    check_match_ct =p 4 -v
+    echo 0x16 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( D2_DRIVER, D2_KMS, D2_ATOMIC )
+    check_match_ct =p 6 -v
+
+    # recap DRM_USE_DYNAMIC_DEBUG regression
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    # set super-mod params
+    modprobe test_dynamic_debug p_disjoint_bits=0x16 p_level_num=5
+    check_match_ct =p 7 -v
+    modprobe test_dynamic_debug_submod
+    # see them picked up by submod
+    check_match_ct =p 14 -v
+}
+
 tests_list=(
     basic_tests
+    # these require test_dynamic_debug*.ko
     comma_terminator_tests
     test_percent_splitting
+    test_mod_submod
 )
 
 # Run tests
-- 
2.44.0


