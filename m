Return-Path: <linux-kernel+bounces-162948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F858B62A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FA01F22DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF7C13D28D;
	Mon, 29 Apr 2024 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjZlpbib"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25D13CF88;
	Mon, 29 Apr 2024 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419579; cv=none; b=KI6QNgq8JtNaVT8t7EeaYPS3Ql3Iuh7NN0nNUWr0fi/Zaay0LRekdZie3O3fGXAN7tLJHkhDqWRm3StsbReq8YORVyA4Q8Lfw5DIKT+L7ika2vKFhRB9QnZZM4kFZ45aP3Wbdi/MUKPgn5hrIww5P5oPvwNKwgArbH9ywlk5Ha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419579; c=relaxed/simple;
	bh=6oHaX5tczKiiZM5vyksZ3rUPAVmC5VfvW8KCqG5sAWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObB3k5sphNtXmj5Ep2bBKnAPkfqRTezB5GgAVYCxYIKNNO43f4LsGBaSJRVTmmyCWaHBpRmO4EYiRThumLskUQugaxZaiP3I4LhZwToVr3/0DB0WsRTqWX5isAaMSoZ1rFOUq8zIj2w+qlYsSM+Zhp9os62Gx9oKPlPKbOF2uek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjZlpbib; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7dec786b0a7so49976039f.1;
        Mon, 29 Apr 2024 12:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419576; x=1715024376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsk6wFmyYbt14YO4ncMIjEQV7uyunoDHYxXESUpDG9U=;
        b=FjZlpbibacfo5PKAcb7IPlZggwPnY2wSs/TxhBUKQlS74pEO+k18SYWwPstN5teird
         nTcs207w/KClCFPVAhavYu1yANEV9QUD5Od2BPhD+qjb2eyORn7y78yzKjruUd+WPPhW
         nKh20OuqyEjaavh3i0aKuKFUiprGUnRHNrMXMwDKSgzqVZu43xKhgPPGhCscpBwTTyBd
         HInw7F5cNzYO4KwuKG82I0H2f9qsUQsiNpx/AIOnS/P3ST1raCqR0AdSc5Aa6SyckFBU
         zVTDsemsqKnxdPtQjcHBHpDY+wKe/1w7GmO8FX80KESilIQf1RkycUZz9gOzfrdxwpzN
         mpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419576; x=1715024376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsk6wFmyYbt14YO4ncMIjEQV7uyunoDHYxXESUpDG9U=;
        b=Ie4++Re7b73vItfEfpQJm0PWbL39wc/RHysqeIx+aRo4o6SgoblH2Hl/EGD6DUj3Tl
         5IY0rG8KrT8xffa/wwAwcf0NEDb52LMUvcdReKrY2lrzG3ExS1xAMGA6FMfCaG+K1UMz
         T7yku58dCtRkGnI2LgDtBaDpAtv9Lky3jjhsLoxVeufQvBq6fz3IBb7nigHayaW/nX57
         8qwznh4w/PamPIs3miP3wemYKB7a/SUTRdAR0jdLRTMcZg6yF1VmdXqTZkXHFeuwBXo0
         PVtiba+6BFIg2fmySY1nf//Rxu27BfbUwTVCwkMpLru4utYP66AoLGTidUjIiSAUI+us
         AQXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Pch03bKcPA/1JqPQ63mOpVdqbJT05m71sk3fyDUV0MPbI+AqSTsGwnY1ujf7x3pgzGX3dqChrT8Sx9Sdv7OzLdKRH8eum7tLdNwkdSW/LqndOXjvMqr05NxIgsaKg4OoAYpH7os4
X-Gm-Message-State: AOJu0YwQawVZe0SHShPyyTn0kQbGJGAkdJW+UXC+e2uFelKX8ZLbBFKV
	FkVgty5S+cW9Zo7RLSAn7sV2LchXDLBbSAWk6RozOT5q/YMh4jzQ
X-Google-Smtp-Source: AGHT+IFLCml7VJa3thVzim744t9VtphWf2fPKNQQnr7CEhnJRINbvibP9AjA+PIPiDOlMLU7xx3G4w==
X-Received: by 2002:a6b:d20c:0:b0:7de:cf4d:b7c6 with SMTP id q12-20020a6bd20c000000b007decf4db7c6mr585980iob.4.1714419576271;
        Mon, 29 Apr 2024 12:39:36 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056602165000b007de9f92dc57sm2325105iow.16.2024.04.29.12.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:35 -0700 (PDT)
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
Subject: [PATCH v8 27/35] selftests-dyndbg: test dyndbg-to-tracefs
Date: Mon, 29 Apr 2024 13:39:13 -0600
Message-ID: <20240429193921.66648-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193921.66648-1-jim.cromie@gmail.com>
References: <20240429193921.66648-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a series of trace-tests: test_actual_trace() etc, to validate that
the dyndbg-to-tracefs feature (using +T flag) works as intended.  The
1st test uses the global tracebuf, the rest use/excercise private
tracebufs.

These tests are currently optional, via "TRACE" arg1, because the
feature code is in-the-lab.  But its an objective test, and pretty
user-interface oriented.

IOW this passes:
  :#> ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
but this fails:
  :#> ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh TRACE

So its won't break selftests success.

This allows the patch to be committed now w/o inducing selftest
failures, and the tests enabled later, with the promised code.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 435 ++++++++++++++++++
 1 file changed, 435 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 54acee58cb4e..65f31418870f 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -308,6 +308,405 @@ function test_mod_submod {
     check_match_ct =p 14 -v
 }
 
+# tests below here are all actually using dyndbg->trace,
+# and verifying the writes
+
+function test_actual_trace {
+    echo -e "${GREEN}# TEST_ACTUAL_TRACE ${NC}"
+    ddcmd =_
+    echo > /sys/kernel/tracing/trace
+    echo 1 >/sys/kernel/tracing/tracing_on
+    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+    modprobe test_dynamic_debug dyndbg=class,D2_CORE,+T:0
+    search_trace "D2_CORE msg"
+    search_trace_name 0 1 "D2_CORE msg"
+    check_match_ct =T 1
+    tmark "trace-mark"
+    search_trace "trace-mark"
+    doprints
+    search_trace "D2_CORE msg"
+    ifrmmod test_dynamic_debug
+}
+
+function self_start {
+    echo \# open, modprobe +T:selftest
+    ddcmd open selftest
+    check_trace_instance_dir selftest 1
+    is_trace_instance_opened selftest
+    modprobe test_dynamic_debug dyndbg=+T:selftest.mf
+    check_match_ct =T:selftest.mf 5
+}
+
+function self_end_normal {
+    echo \# disable -T:selftest, rmmod, close
+    ddcmd module test_dynamic_debug -T:selftest # leave mf
+    check_match_ct =:selftest.mf 5 -v
+    ddcmd module test_dynamic_debug +:0
+    ddcmd close selftest
+    is_trace_instance_closed selftest
+    ifrmmod test_dynamic_debug
+}
+
+function self_end_disable_anon {
+    echo \# disable, close, rmmod
+    ddcmd module test_dynamic_debug -T
+    check_match_ct =:selftest.mf 5
+    ddcmd module test_dynamic_debug +:0
+    ddcmd close selftest
+    is_trace_instance_closed selftest
+    ifrmmod test_dynamic_debug
+}
+
+function self_end_disable_anon_mf {
+    echo \# disable, close, rmmod
+    ddcmd module test_dynamic_debug -Tf
+    check_match_ct =:selftest.m 5
+    ddcmd module test_dynamic_debug +:0
+    ddcmd close selftest
+    is_trace_instance_closed selftest
+    ifrmmod test_dynamic_debug
+}
+
+function self_end_nodisable {
+    echo \# SKIPPING: ddcmd module test_dynamic_debug -T:selftest
+    ddcmd close selftest fail # close fails because selftest is still being used
+    check_err_msg "Device or resource busy"
+    check_match_ct =T:selftest.mf 5
+    rmmod test_dynamic_debug
+    ddcmd close selftest # now selftest can be closed because rmmod removed
+                         # all callsites which were using it
+    is_trace_instance_closed selftest
+}
+
+function self_end_delete_directory {
+    del_trace_instance_dir selftest 0
+    check_err_msg "Device or resource busy"
+    ddcmd module test_dynamic_debug -mT:selftest
+    check_match_ct =:selftest.f 5
+    del_trace_instance_dir selftest 0
+    check_err_msg "Device or resource busy"
+    ddcmd module test_dynamic_debug +:0
+    ddcmd close selftest
+    check_trace_instance_dir selftest 1
+    is_trace_instance_closed selftest
+    del_trace_instance_dir selftest 1
+    check_trace_instance_dir selftest 0
+}
+
+function test_early_close () {
+    ddcmd open kparm_stream
+    ddcmd module usbcore +T:kparm_stream.mf
+    check_match_ct =T:usb_stream.mf 161
+    echo ":not-running # ddcmd module usbcore -T:kparm_stream.mf"
+    ddcmd close kparm_stream
+}
+
+function self_test_ {
+    echo "# SELFTEST $1"
+    self_start
+    self_end_$1
+}
+
+function cycle_tests_normal {
+    echo -e "${GREEN}# CYCLE_TESTS_NORMAL ${NC}"
+    self_test_ normal           # ok
+    self_test_ disable_anon     # ok
+    self_test_ normal           # ok
+    self_test_ disable_anon_mf  # ok
+}
+
+function cycle_not_best_practices {
+    echo -e "${GREEN}# CYCLE_TESTS_PROBLEMS ${NC}"
+    self_test_ nodisable
+    self_test_ normal
+    self_test_ delete_directory
+}
+
+# proper life cycle - open, enable:named, disable:named, close
+function test_private_trace_simple_proper {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_1 ${NC}"
+    # ddcmd close kparm_stream
+    ddcmd open kparm_stream
+    ddcmd module params +T:kparm_stream.mf
+    check_match_ct =T:kparm_stream.mf 4
+    ddcmd module params -T:kparm_stream.mf
+    check_match_ct =T:kparm_stream.mf 0
+    is_trace_instance_opened kparm_stream
+    ddcmd module params +:0
+    ddcmd close kparm_stream
+    is_trace_instance_closed kparm_stream
+    ddcmd =_
+    check_trace_instance_dir kparm_stream 1
+    is_trace_instance_closed kparm_stream
+    del_trace_instance_dir kparm_stream 1
+    check_trace_instance_dir kparm_stream 0
+}
+
+function test_private_trace_2 {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_2 ${NC}"
+    ddcmd =_
+    echo > /sys/kernel/tracing/trace
+    echo 1 >/sys/kernel/tracing/tracing_on
+    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+    ddcmd open foo
+    is_trace_instance_opened foo
+    check_trace_instance_dir foo 1
+
+    modprobe test_dynamic_debug
+    ddcmd class,D2_CORE,+T:foo.l,%class,D2_KMS,+fT:foo.ml
+    check_match_ct =T:foo.l 1
+    check_match_ct =T:foo.mfl 1
+
+    # purpose ?
+    echo 1 >/sys/kernel/tracing/tracing_on
+    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+
+    tmark test_private_trace about to do_prints
+    search_trace "test_private_trace about to do_prints"
+    search_trace_name "0" 1 "test_private_trace about to do_prints"
+
+    doprints
+    ddcmd class,D2_CORE,-T:foo
+    ddcmd close foo fail
+    check_err_msg "Device or resource busy"
+    ddcmd class,D2_KMS,-T:foo
+    ddcmd close foo
+    check_trace_instance_dir foo 1
+    is_trace_instance_closed foo
+    ddcmd close bar fail
+    check_err_msg "No such file or directory"
+    ifrmmod test_dynamic_debug
+    search_trace_name foo 2 "D2_CORE msg"
+    search_trace_name foo 1 "D2_KMS msg"
+    del_trace_instance_dir foo 1
+    check_trace_instance_dir foo 0
+}
+
+function test_private_trace_3 {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_3 ${NC}"
+    ddcmd =_
+    echo > /sys/kernel/tracing/trace
+    echo 1 >/sys/kernel/tracing/tracing_on
+    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+    ddcmd open foo \; open bar
+    is_trace_instance_opened foo
+    is_trace_instance_opened bar
+    modprobe test_dynamic_debug
+    ddcmd class,D2_CORE,+T:foo
+    ddcmd class,D2_KMS,+T:foo
+    ddcmd class D2_CORE +T:foo \; class D2_KMS +T:foo
+    ddcmd "class,D2_CORE,+T:foo;,class,D2_KMS,+T:foo"
+    ddcmd class,D2_CORE,+T:foo\;class,D2_KMS,+T:foo
+    check_match_ct =T 2 -v
+    check_match_ct =Tl 0
+    check_match_ct =Tmf 0
+    echo 1 >/sys/kernel/tracing/tracing_on
+    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+    tmark test_private_trace_2 about to do_prints
+    doprints
+    rmmod test_dynamic_debug
+    ddcmd "close bar;close foo"
+    is_trace_instance_closed bar
+    is_trace_instance_closed foo
+    search_trace_name foo 2 "D2_CORE msg"
+    search_trace_name foo 1 "D2_KMS msg"
+    del_trace_instance_dir foo 1
+    check_trace_instance_dir foo 0
+    search_trace "test_private_trace_2 about to do_prints"
+    del_trace_instance_dir bar 1
+    check_trace_instance_dir bar 0
+}
+
+function test_private_trace_4 {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_4 ${NC}"
+    ddcmd =_
+    echo > /sys/kernel/tracing/trace
+    echo 1 >/sys/kernel/tracing/tracing_on
+    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+
+    ddcmd open foo
+    modprobe test_dynamic_debug dyndbg=class,D2_CORE,+T:foo%class,D2_KMS,+T:foo
+    check_match_ct =Tl 0
+    check_match_ct =Tmf 0
+    check_match_ct =T 2
+
+    # are these 2 doing anything ?
+    echo 1 >/sys/kernel/tracing/tracing_on
+    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+
+    tmark should be ready
+    search_trace_name "0" 0 "should be ready"	# in global trace
+
+    doprints
+    search_trace_name foo 2 "D2_CORE msg"	# in private buf
+    search_trace_name foo 1 "D2_KMS msg"
+
+    # premature delete
+    del_trace_instance_dir foo 0
+    check_trace_instance_dir foo 1	# doesn't delete
+    ifrmmod test_dynamic_debug
+
+    ddcmd "close foo"
+    is_trace_instance_closed foo
+    del_trace_instance_dir foo 1	# delete works now
+
+    check_trace_instance_dir foo 0
+    search_trace "should be ready"
+}
+
+# $1 - trace-buf-name (or "0")
+# $2 - reference-buffer
+function search_in_trace_for {
+    bufname=$1; shift;
+    ref=$2;
+    ref2=$(echo $ref | cut -c20-)
+    echo $ref2
+}
+
+function test_private_trace_mixed_class {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_5 ${NC}"
+    ddcmd =_
+    ddcmd module,params,+T:unopened fail
+    check_err_msg "Invalid argument"
+    is_trace_instance_closed unopened
+    check_trace_instance_dir unopened 0
+
+    ddcmd open bupkus
+    is_trace_instance_opened bupkus
+    check_trace_instance_dir bupkus 1
+    modprobe test_dynamic_debug \
+	     dyndbg=class,D2_CORE,+T:bupkus.mf%class,D2_KMS,+T:bupkus.mf%class,V3,+T:bupkus.mf
+
+    # test various name misses
+    ddcmd "module params =T:bupkus1" fail	# miss on name
+    check_err_msg "Invalid argument"
+    ddcmd "module params =T:unopened" fail	# unopened
+    check_err_msg "Invalid argument"
+
+    ddcmd "module params =mlfT:bupkus."		# we allow dot at the end of flags
+    ddcmd "module params =T:bupkus."
+    ddcmd "module params =:bupkus."
+    ddcmd "module params =:0."
+
+    check_match_ct =T:bupkus.mf 3		# the 3 classes enabled above
+    # enable the 5 non-class'd pr_debug()s
+    ddcmd "module test_dynamic_debug =T:bupkus"
+    check_match_ct =T:bupkus 8 -r		# 8=5+3
+
+    doprints
+    ddcmd close,bupkus fail
+    check_err_msg "Device or resource busy"
+    ddcmd "module * -T:0"			# misses class'd ones
+    ddcmd close,bupkus fail
+
+    ddcmd class,D2_CORE,-T:0%class,D2_KMS,-T:0%class,V3,-T:0 # turn off class'd and set dest to 0
+    ddcmd close,bupkus
+    is_trace_instance_closed bupkus
+
+    # check results
+    eyeball_ref=<<EOD
+        modprobe-1173    [001] .....   7.781008: 0: test_dynamic_debug:do_cats: test_dd: D2_CORE msg
+        modprobe-1173    [001] .....   7.781010: 0: test_dynamic_debug:do_cats: test_dd: D2_KMS msg
+        modprobe-1173    [001] .....   7.781010: 0: test_dynamic_debug:do_levels: test_dd: V3 msg
+             cat-1214    [001] .....   7.905494: 0: test_dd: doing categories
+             cat-1214    [001] .....   7.905495: 0: test_dynamic_debug:do_cats: test_dd: D2_CORE msg
+             cat-1214    [001] .....   7.905496: 0: test_dynamic_debug:do_cats: test_dd: D2_KMS msg
+             cat-1214    [001] .....   7.905497: 0: test_dd: doing levels
+             cat-1214    [001] .....   7.905498: 0: test_dynamic_debug:do_levels: test_dd: V3 msg
+EOD
+
+    # validate the 3 enabled class'd sites, with mf prefix
+    search_trace_name bupkus 0 "test_dynamic_debug:do_cats: test_dd: D2_CORE msg"
+    search_trace_name bupkus 0 "test_dynamic_debug:do_cats: test_dd: D2_KMS msg"
+    search_trace_name bupkus 0 "test_dynamic_debug:do_levels: test_dd: V3 msg"
+
+    search_trace_name bupkus 0 "test_dd: doing levels"
+    search_trace_name bupkus 0 "test_dd: doing categories"
+
+    # reopen wo error
+    ddcmd open bupkus
+    is_trace_instance_opened bupkus
+    check_trace_instance_dir bupkus 1
+
+    ddcmd "module test_dynamic_debug =T:bupkus"	# rearm the 5 plain-old prdbgs
+    check_match_ct =T:bupkus 5
+
+    doprints # 2nd time
+    search_trace_name bupkus 0 "test_dd: doing categories"
+    search_trace_name bupkus 0 "test_dd: doing levels""
+    search_trace_name bupkus 2 "test_dd: doing categories"
+    search_trace_name bupkus 1 "test_dd: doing levels""
+
+    ddcmd close,bupkus fail
+    check_err_msg "Device or resource busy"
+    del_trace_instance_dir bupkus 0
+    check_err_msg "Device or resource busy"
+    check_trace_instance_dir bupkus 1
+    is_trace_instance_opened bupkus
+    check_trace_instance_dir bupkus 1
+
+    # drop last users, now delete works
+    ddcmd "module * -T:0"
+    ddcmd close,bupkus
+    is_trace_instance_closed bupkus
+    del_trace_instance_dir bupkus 1
+    check_trace_instance_dir bupkus 0
+    ifrmmod test_dynamic_debug
+}
+
+function test_private_trace_overlong_name {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_overlong_name ${NC}"
+    ddcmd =_
+    name="A_bit_lengthy_trace_instance_name"
+    ddcmd open $name
+    is_trace_instance_opened $name
+    check_trace_instance_dir $name 1
+
+    ddcmd "file kernel/module/main.c +T:$name.mf "
+    check_match_ct =T:A_bit_lengthy_trace_....mf 14
+
+    ddcmd "module * -T"
+    check_match_ct =:A_bit_lengthy_trace_....mf 14
+    check_match_ct kernel/module/main.c 14 -r		# to be certain
+
+    ddcmd "module * -T:0"
+    ddcmd close,$name
+    is_trace_instance_closed $name
+    del_trace_instance_dir $name 1
+    check_trace_instance_dir $name 0
+}
+
+function test_private_trace_fill_trace_index {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_fill_trace_index ${NC}"
+    ddcmd =_
+    name="trace_instance_"
+    for i in {1..63}
+    do
+        ddcmd open $name$i
+	is_trace_instance_opened $name$i
+        check_trace_instance_dir $name$i 1
+    done
+    # catch the 1-too-many err
+    ddcmd "open too_many" fail
+    check_err_msg "No space left on device"
+
+    ddcmd 'file kernel/module/main.c =T:trace_instance_63.m'
+    check_match_ct =T:trace_instance_63.m 14
+
+    for i in {1..62}
+    do
+        ddcmd close $name$i
+        is_trace_instance_closed $name$i
+        del_trace_instance_dir $name$i 1
+        check_trace_instance_dir $name$i 0
+    done
+    ddcmd "module * -T:0"
+    ddcmd close,trace_instance_63
+    is_trace_instance_closed trace_instance_63
+    del_trace_instance_dir trace_instance_63 1
+    check_trace_instance_dir trace_instance_63 0
+}
+
 tests_list=(
     basic_tests
     # these require test_dynamic_debug*.ko
@@ -315,9 +714,28 @@ tests_list=(
     test_percent_splitting
     test_mod_submod
 )
+trace_tests=(
+    # these tests write to tracebuf, and check its contents
+    test_actual_trace
+    cycle_tests_normal
+    cycle_not_best_practices
+    test_private_trace_1
+    test_private_trace_simple_proper
+    test_private_trace_2
+    test_private_trace_3
+    test_private_trace_4
+    test_private_trace_mixed_class
+    test_private_trace_mixed_class  # again, to test pre,post conditions
+
+    test_private_trace_overlong_name
+
+    # works, takes 30 sec
+    test_private_trace_fill_trace_index
+)
 
 # Run tests
 
+# rmmod modules to clear their possibly modified state
 ifrmmod test_dynamic_debug_submod
 ifrmmod test_dynamic_debug
 
@@ -326,5 +744,22 @@ do
     $test
     echo ""
 done
+
+if [[ "$1" = "TRACE" ]] ; then
+
+    # rmmod modules to clear their possibly modified state
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+
+    for test in "${trace_tests[@]}"
+    do
+	$test
+	echo ""
+    done
+fi
+
+# leave modules in place at end
+# so that evidence of mishap is present
+
 echo -en "${GREEN}# Done on: "
 date
-- 
2.44.0


