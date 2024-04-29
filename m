Return-Path: <linux-kernel+bounces-162935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AADC8B6262
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FFD2852F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8B2154BFA;
	Mon, 29 Apr 2024 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+mV9SRh"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7B14885F;
	Mon, 29 Apr 2024 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419163; cv=none; b=Zgx5ohSowIBfGSTom+/1bBIoCvBp1utn/2NYku+jC7Nv5LMyhNpxm12KqFxomWCoeX8wtc41golm/WIbDpR3M1P7+9wvXnzfizyaLv5LLOgoJ9wWJIOyjglfF7t7ARy/TXYBa9RyplAKneotrsiTNDb9A23Di+WMOCrmFlGegVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419163; c=relaxed/simple;
	bh=C5DYJf0dGg1RSXsBs63GsWtBySO28gzBOeTcg35xaOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvrIv9J82ECYP7TFmg6LKHZG107/yoI+rKJA8sC2hSQcQ3eRhVKe/8QIuAgk/rm9EcYWx0Z3NxvAQbR7qnyxgLwWDEhSxLr+lowlWQAaBCV67TRyz36SWH+4hTHaiIU8ZZY95Om2KcwWZFgkixeozshZums9Er/rEljFK23G7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+mV9SRh; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7da41c6aa37so244368039f.2;
        Mon, 29 Apr 2024 12:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419160; x=1715023960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsc/9WsGromIBMCX1IbPd4mLGTopgfHgqr35jw6ogHo=;
        b=N+mV9SRhQLXrW7J7baoHVjRp7HVnWAs0IBjkD9PoEZDY7JrEEEMRG3AJsuT7QnnmF+
         A79JqIXeXUeqIjV1RGDZmZ62BBT2BCQ8MeeE+BZ1UCMW1/ux0BheLx+F3hHBAEpuBLvu
         ILr4YmoDTYzblNrCMpPupz5NAAWTQ4cqLTbSL1JSpAWe8ROIKl6ixa9vfZrHv8Mh3VrM
         Z3pVxlF0HRBCa1oO50NAZG1X4n2OMXSTF4kp9G9uvDq+5I3/49ac3QhwfpCJNAJXJXVq
         J87zF3lW2X3GK4ShlDG9+bTkCyB5zz189GntWVanz7afiJMCRpoVrqfWB7kp+vgWEU/X
         3ziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419160; x=1715023960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsc/9WsGromIBMCX1IbPd4mLGTopgfHgqr35jw6ogHo=;
        b=fH6qmAjRz3DwmrUw52bYjQL2ogdS2ZJLGxMzlS/fIsTa0WbP9L8FRhwRuJICIcjUaT
         teVcnvq5ejEOs++Jma5qFACxMwT3bgHQosdeM0r7XsjNXAqIi/6CwimRg8NkzQb4VazY
         ynQ0Q13KFhLcFCbub5XQM1Tytxl9wSRyiKb/FF6g0L3hEquBLvg1lb+c/z2uWcLAE+bK
         9Zp4j/yvP8WnvkKT7807ZkPjdEaDDT9Juq3ZE6EP4msEesu9kudtideNsw+mqMEpSW8X
         bQzc490F3/u5/ipe0V6gfQyvHHZvx9eD9uAf+cBLV/5BpgKEJMnECKeR3c1uSov0/byV
         sTZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3ehNhchPVcobkxMOaYRTjxr2VoasPSKeYWFtyd3/Kdbavbv75atpfAg4Z33uHxBM9QrBHUzoeA3ndFvtPgPYmjQYvXg5pbm/Z750nIBaqAdRIgrCxbLTVHoQ5Cc40H2zA8wFExn5c
X-Gm-Message-State: AOJu0YwDon1bYtn7sMkOxCNAP4oagt2td6Km/7i7loANP67Lq/pA4nL+
	chiGVjAbj5pcsj7+FQHVkeVV+naIOVkdJGNkvIzDY4e1JU+JhMab
X-Google-Smtp-Source: AGHT+IEvl7Ozyqju1Vb002jjbAwsGz0wALuKAmyIrroEmxIQoLfnQkqifO6d2t/QJPOQBzw+TvGRFw==
X-Received: by 2002:a05:6602:3424:b0:7de:cdc8:10e4 with SMTP id n36-20020a056602342400b007decdc810e4mr6877777ioz.14.1714419160438;
        Mon, 29 Apr 2024 12:32:40 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:40 -0700 (PDT)
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
Date: Mon, 29 Apr 2024 13:31:32 -0600
Message-ID: <20240429193145.66543-23-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193145.66543-1-jim.cromie@gmail.com>
References: <20240429193145.66543-1-jim.cromie@gmail.com>
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


