Return-Path: <linux-kernel+bounces-162943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA348B6293
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0579F1F22DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC23113C68A;
	Mon, 29 Apr 2024 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li5f2pab"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F23813BC3C;
	Mon, 29 Apr 2024 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419572; cv=none; b=rGOIhJ76Vb629c5bfa1Dhw+l7otZXOYRQ5rOGvz9djGsNZN4edtSKMDDda9bIQmUQve2E57cfo0jKeHLmQsrE0zK8lvW+u5XHHq9gi/ycRgUiy5VZ/OnM1nxBTg3ndqku4VsT7SI4S4dP2vtqr1ugsUkcn6yyxlIn4ZyachVZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419572; c=relaxed/simple;
	bh=C5DYJf0dGg1RSXsBs63GsWtBySO28gzBOeTcg35xaOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXq3D3meTjXJUqeZHomsny3TwkPGOy4r10HS+3T+rAx+BMDvbAWa7QKL8ZWCdB77PwOtOyVaObnKMFOjRePMDv31swkMNxWX7c8DO0GbPCUQUASgdLQyLLJ/XL5/HKxcNG/sJJxawffYr78nGCmW3TZ3aCH3rl+tMaSTN5OynAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li5f2pab; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7da09662332so160422339f.0;
        Mon, 29 Apr 2024 12:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419570; x=1715024370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsc/9WsGromIBMCX1IbPd4mLGTopgfHgqr35jw6ogHo=;
        b=Li5f2pabwBbfQQSYK3JM3yZBxJfBitJ0wWnnyE4yAX2QFpKoLVNmDbL9C87w7zRvJp
         Z6ERBh4dDgBBxBkARjBgqk+Bs5JSdCPpdIh7UZxIizvmYh/HA0rPcoBTuz/ldJDKzo58
         qCMmQixqEGpuXfcccDatc8GaMQmdGlZw5LGtU6AfYJ3MwkaQUbeCwmnW3O4fUIofyHbB
         ij5AjdKqziFpXOGpj3NwAYan7LPYD43pQSs1/O/5FuPDTwc7x1uHi4dvizGU33FzuLZS
         RgVUQA3qftB7w1/NYf0AEd68cfMvGPyg3cJpOsn4FkIh96dd0NCntN8a7XzqwipvrYxx
         P7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419570; x=1715024370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsc/9WsGromIBMCX1IbPd4mLGTopgfHgqr35jw6ogHo=;
        b=GAAPmu2VznxtJ25D1X5frerz1LJP3/lRSV+1NiyHBq+7PgnEy6GbxfFbVz2pKFgvFH
         VKuRY3KKHhjR+8C1ic6BZbeirws2VtDLeqW3aoXzUxBFHmYpNCJi6uV6hptriBEivL2B
         o0kMxiDiGN5D2Zb1zBuEzBXvx/Z8QjRlZe6b9FHfi5zmpIiqB8RTDHCz2/M0KAD/3gcN
         5hBhOSg/dKsY1mJ1iuk4cUNkv1Gqb6x8zsm/sCViNB+cxdtyyAUIvAVO9AvtJr3FIMAp
         PiyMTAL5WUq4j/Mtmj3Zca/5kaKveN2lMB+1Yx90zpBLbcbAL6HyozvmK57tR03cDdL4
         MXrw==
X-Forwarded-Encrypted: i=1; AJvYcCW9bvYOEUc5f0wbmvdOxff/XFuzKxn1Kh5vbUyx7zEdpuRjWEV/8oLvT+K47u2YbV9dQNbHG2k7nm0pTysAYjAy7ZBIva+lXZfyNDenjO21NZiZzC5DXnALwg+Hy4hdr8l15g9/czym
X-Gm-Message-State: AOJu0Yz45tLOC8Xct4KkKDB6zeS7bvPDYIpQuOPHQjolqLhIfrsGqcNe
	FxdihwzSNH+rGXYr0IxR13vQiRakNin7tU4vfRXt2yT59aaxp9Uu
X-Google-Smtp-Source: AGHT+IGSjAuBVUKjB/XBUA0dptA+ZKvZmIfrYhF8kqBK8ypwvGZwurqlZkqnE/Ouq9b/MO+XR7xJBQ==
X-Received: by 2002:a05:6602:2772:b0:7dd:c59c:83a5 with SMTP id l18-20020a056602277200b007ddc59c83a5mr574201ioe.9.1714419569961;
        Mon, 29 Apr 2024 12:39:29 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056602165000b007de9f92dc57sm2325105iow.16.2024.04.29.12.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:29 -0700 (PDT)
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
Subject: [PATCH v8 22/35] selftests-dyndbg: add comma_terminator_tests
Date: Mon, 29 Apr 2024 13:39:08 -0600
Message-ID: <20240429193921.66648-3-jim.cromie@gmail.com>
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

New fn validates parsing and effect of queries using combinations of
commas and spaces to delimit the tokens.

It manipulates pr-debugs in builtin module/params, so might have deps
I havent foreseen on odd configurations.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index cb77ae142520..7a7d437e948b 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -217,9 +217,23 @@ EOF
     ddcmd =_
 }
 
+function comma_terminator_tests {
+    echo -e "${GREEN}# COMMA_TERMINATOR_TESTS ${NC}"
+    # try combos of spaces & commas
+    check_match_ct '\[params\]' 4 -r
+    ddcmd module,params,=_		# commas as spaces
+    ddcmd module,params,+mpf		# turn on module's pr-debugs
+    check_match_ct =pmf 4
+    ddcmd ,module ,, ,  params, -p
+    check_match_ct =mf 4
+    ddcmd " , module ,,, ,  params, -m"	#
+    check_match_ct =f 4
+    ddcmd =_
+}
 
 tests_list=(
     basic_tests
+    comma_terminator_tests
 )
 
 # Run tests
-- 
2.44.0


