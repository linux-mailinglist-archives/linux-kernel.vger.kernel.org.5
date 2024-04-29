Return-Path: <linux-kernel+bounces-162945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACB28B629C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E2A1F22DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FBB13B5BB;
	Mon, 29 Apr 2024 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEvDduwB"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B613C662;
	Mon, 29 Apr 2024 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419574; cv=none; b=XunrB+a+sbvSEnrsMHtmzSu6A3vWhDHRAt2SuPTiLW2TgdSwoBnca/j5+HpaLthh6M2fgybnOf8N3QGEjTGF/16/LnURXF/fJ9CG+TkObJ4rRMEtPaFI0PbW5tG2PJLY0+VrBul42kpP1SYI2Mp37sJzc7zeRLmp880tlJTil5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419574; c=relaxed/simple;
	bh=HA0meXi/hb7p0axpxiXqsBTheF/w90VGeM/mc8da7p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulnrqL4DQokbgX/N2RQM/rZddRplZa01Txtx7giEDDO2mdOldl+NwkXBuC3eYjgByVUMtMlKx5Zn2sTvlsJtFFstg7oysvViTa0bwLNf4ZZRbZML2mB9e7evYWhyCh1M4GDj46RApQg8/HclMJJJ+Ji4OGHXlZRrZKqeUbwhREA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEvDduwB; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7decb58626aso55756939f.1;
        Mon, 29 Apr 2024 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419572; x=1715024372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vg38OZx3YLIwABtnQGkinhhYjsiQa4opg6MoojqE7Ag=;
        b=UEvDduwBhe2sOzunixCF+yuMEv2HSfWodUxE/V8ggRfuy4VzGZFNRx3IZogBBcj1GP
         V2/iIsFqqH8W4gDMSMbXIL3mbqpU5e0fhU/b9DA1CRQiWG6R8A22If4i2AtgxaAfJi/J
         OBhIlqC83LlEMepsWm+1R9EgGm+X5/41/8SWlTyCeNgo57kXASG0gxSGLFdmIEW2M3Jf
         EVNOaPhlMU+IrO8wSt8srw4njY8CWq/wVOJbjsPnMd7kEIeZm9IJ9pf2IeHmvY9Pqxxf
         SIqoqq5q9da2Cegw89kQcZL+psEYXlMeh6vb44MvTSHl7rma49CBTPS+hmqo+i5wOXzB
         GcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419572; x=1715024372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vg38OZx3YLIwABtnQGkinhhYjsiQa4opg6MoojqE7Ag=;
        b=d7WktnjgqjrvoR1gdOtpotwdTODPPvaWDGi+GfkSAqZp4vLLCmJK/S5hcjHhUlvd4Q
         bNLYtKyIf+YuEokwIliqgX7/Iu6gM48zMh4/2o0R2OLQuyzXDW29Wzga1lx+vSTrEVjA
         qX9kdnMRvKZuL9IoJb3eCB7HR8fflLZEqhFPb5p5oNjHc6yXpvHKAGPfwsmxbA7ShUVl
         nwddUguAs55UxCY5+5J3RxHOdl3+4wLbI3ps5PaDSVWd/l6Z3ZKj7GxBLxbBZba7wW/K
         9rCQcYmNNaDGCAoOLbjDo9hCgbJRbyt7YnCbNoNxqRDvN9ORfVpUy3LheluYMkkOXgeO
         j1TA==
X-Forwarded-Encrypted: i=1; AJvYcCW/aaOsLTCZKmhqFuYVZZ8ri6K3Xf0wW2ALocWlWylqjZ+h4GQU1mBhyS/PTsH63nNOedzaW1rIgOl+vF/XorpvkaxUrQJG3pQ499ynC516pAVO5t3OEXnvkH0l18yRY2kseHJ9BfYV
X-Gm-Message-State: AOJu0Yy+dKkeRl30xWXFE9NPsnEE8U0xntu0RWXq0l7EBpVbON7Vm4CD
	1VdT111pJQpJH+rcGzock0Usfpn4tI22ZzFbxSN2HVomDgxmiRCo
X-Google-Smtp-Source: AGHT+IFXbmxQz+e05jyizma4wMrqd8m0n5WRNSC7YJxpdev35A3a5dS216xqpdnTF1y2LwkPes/sYQ==
X-Received: by 2002:a6b:cf14:0:b0:7de:cb34:98ad with SMTP id o20-20020a6bcf14000000b007decb3498admr583501ioa.1.1714419572068;
        Mon, 29 Apr 2024 12:39:32 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056602165000b007de9f92dc57sm2325105iow.16.2024.04.29.12.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:31 -0700 (PDT)
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
Subject: [PATCH v8 24/35] selftests-dyndbg: test_percent_splitting multi-cmds on module classes
Date: Mon, 29 Apr 2024 13:39:10 -0600
Message-ID: <20240429193921.66648-5-jim.cromie@gmail.com>
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

New fn tests multi-queries composed with % splitters.  It uses both
test_dynamic_debug and test_dynamic_debug_submod, and manipulates
several classes at once.  So despite the syntactic-oriented name, it
also tests classmaps.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 7a7d437e948b..ddb04c0a7fd2 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -231,9 +231,29 @@ function comma_terminator_tests {
     ddcmd =_
 }
 
+function test_percent_splitting {
+    echo -e "${GREEN}# TEST_PERCENT_SPLITTING - multi-command splitting on % ${NC}"
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    ddcmd =_
+    modprobe test_dynamic_debug dyndbg=class,D2_CORE,+pf%class,D2_KMS,+pt%class,D2_ATOMIC,+pm
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+    check_match_ct test_dynamic_debug 23 -r
+    # add flags to those callsites
+    ddcmd class,D2_CORE,+mf%class,D2_KMS,+lt%class,D2_ATOMIC,+ml
+    check_match_ct =pmf 1
+    check_match_ct =plt 1
+    check_match_ct =pml 1
+    check_match_ct test_dynamic_debug 23 -r
+    ifrmmod test_dynamic_debug
+}
+
 tests_list=(
     basic_tests
     comma_terminator_tests
+    test_percent_splitting
 )
 
 # Run tests
-- 
2.44.0


