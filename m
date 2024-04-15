Return-Path: <linux-kernel+bounces-145396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DAD8A55B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCF01F221A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899AE74BE1;
	Mon, 15 Apr 2024 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQAfIprP"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078E763EC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192948; cv=none; b=GhnQvV/4Kx88ET/KF4PI+Oy9RjsGjLiDbO8XjwzcG8Qn3JTPY6cKHfC6LVqT643hk8jpqkZMmoP7GaWW9FeE1m5MSEB0r1+g98Pah5LbcBKj9t4E7jvKCd/Mim0cZrCAgP+hpIdGE4cAN7s3DsDktpcZTok6ICpnaLbUhr4RJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192948; c=relaxed/simple;
	bh=pXQbxd5ujUmK1VVLnK8kdd1NphI/TywkGB3WoCJTJQ8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDCCg7M2jPd3gQGJZ5/FU2Cq/uRUGxtkS54yCSYt5nTxEmzRaQSGI6Xm/gqIRinHGbQK4o+mAB/Fwe8LbAh/2CFDxuqgcJqB4OE1We5FAg7Tw7AsQ/dIWUiN8hCy/FcQU3JJh1h+zZGNvQPE5DV4LEBxEgDORWJjBz0kozvqIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQAfIprP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso3206895a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713192945; x=1713797745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4lmLduepyzOAbsVFho4Xvkct1BwmBvnsIf9kusvzWM=;
        b=bQAfIprPXmZ5mtmBb9vtJQz/D16RCl8wsgbm7t8mATwAE+1+fy8UTaHARYC4cMKzGy
         SnSEYfmqTY2TsCCrTUN3TDzugArsQxEujri53tZmcclV2rg562HbhNTcGdFm3qHMlcR+
         WEGAle5ha24LjSuJESXqTie2jZUWiJNy6p6t8i9bde4Q9Djs4Bl5+Os0/r/ulfHVjMaH
         FR6Zv1Ecz2wej0cqAp3CHUdTisIzhgAAeDl9u0MxFp5PykysUdoMZ2pjNLEYsogc9JFs
         4z0ewNYt7Zf4LVZN/9nbQbYW3ZCLDH8wjanfh5gbaRPsDdi6s9x/qPLjea0r1Gz0CVju
         /BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192945; x=1713797745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4lmLduepyzOAbsVFho4Xvkct1BwmBvnsIf9kusvzWM=;
        b=Tf/RAp+nATMAOzkw6CHvc2DoJgZx6r9zVZEhPPAnNmT5xBzZ0UUZHHgFFULyUXqocM
         uaRTYxVSbUYsKdmv94xDveRQRutMKTGE0qpM80cv86ChXpCWCSgmPh00xy1niYz9Hp0x
         aNTj8UeLswTgTv8XksgjBBTuNNrmY7beQDSGc1lGttz921o9z8IPL468MZnkkuP925Ms
         mcJIhQ4rHZsyq9+mKiqhQQfu5xn1zPMamWTZ6627BCuUMe0HuJLpJLfC+JaXhhB24G4a
         wHsAU3J0oo+gtgOVf7EEFNuFEurFygrHQlJVqhlG+iZFVIbbU+nMBDeLzkSNMCAq+0rx
         aJAw==
X-Forwarded-Encrypted: i=1; AJvYcCWvIN1i6o+vK3wFaY6Ntmmj/84NVZnl6kXYisnLY3K/k3dTqM3WBE5Ox0B9H89TK0JbFIxaRbINsfVH2Yxo0s5Cz5XaQ232H6TLS40R
X-Gm-Message-State: AOJu0Yz5ztX4lAaIUMi1aqmGNPnopxmFpui8hbrNZIw1LpENeZn48n/h
	TbvxqJlvJvwDAZcRPTWB7ZQ0y6Wd2DmTyV+NpmPn68cp/d5u52C9
X-Google-Smtp-Source: AGHT+IEe38g2tO5GPGSsyEIDzccfRxNiWf0GVHpH/dwBBiJSrbJWJIQ0xMK7BHVkWszNYWXTGw55JQ==
X-Received: by 2002:a50:a695:0:b0:570:35e:9a09 with SMTP id e21-20020a50a695000000b00570035e9a09mr6978695edc.7.1713192945301;
        Mon, 15 Apr 2024 07:55:45 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id s13-20020a056402520d00b0056bf6287f32sm4893415edd.26.2024.04.15.07.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:55:44 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH v2 3/7] scripts/faddr2line: Check vmlinux only once
Date: Mon, 15 Apr 2024 16:55:34 +0200
Message-Id: <20240415145538.1938745-4-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415145538.1938745-1-bjohannesmeyer@gmail.com>
References: <20240415145538.1938745-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than checking whether the object file is vmlinux for each invocation
of __faddr2line, check it only once beforehand.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 scripts/faddr2line | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index f011bda4ed25..bb3b5f03f4ea 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -115,6 +115,17 @@ run_readelf() {
 	ELF_SYMS=$(echo "${out}" | sed -n '/Symbol table .* contains [0-9]* entries:/,$p')
 }
 
+check_vmlinux() {
+	# vmlinux uses absolute addresses in the section table rather than
+	# section offsets.
+	IS_VMLINUX=0
+	local file_type=$(echo "${ELF_FILEHEADER}" |
+		${AWK} '$1 == "Type:" { print $2; exit }')
+	if [[ $file_type = "EXEC" ]] || [[ $file_type == "DYN" ]]; then
+		IS_VMLINUX=1
+	fi
+}
+
 __faddr2line() {
 	local objfile=$1
 	local func_addr=$2
@@ -125,8 +136,6 @@ __faddr2line() {
 	local func_offset=${func_addr#*+}
 	func_offset=${func_offset%/*}
 	local user_size=
-	local file_type
-	local is_vmlinux=0
 	[[ $func_addr =~ "/" ]] && user_size=${func_addr#*/}
 
 	if [[ -z $sym_name ]] || [[ -z $func_offset ]] || [[ $sym_name = $func_addr ]]; then
@@ -135,14 +144,6 @@ __faddr2line() {
 		return
 	fi
 
-	# vmlinux uses absolute addresses in the section table rather than
-	# section offsets.
-	local file_type=$(echo "${ELF_FILEHEADER}" |
-		${AWK} '$1 == "Type:" { print $2; exit }')
-	if [[ $file_type = "EXEC" ]] || [[ $file_type == "DYN" ]]; then
-		is_vmlinux=1
-	fi
-
 	# Go through each of the object's symbols which match the func name.
 	# In rare cases there might be duplicates, in which case we print all
 	# matches.
@@ -260,7 +261,7 @@ __faddr2line() {
 		# Pass section address to addr2line and strip absolute paths
 		# from the output:
 		local args="--functions --pretty-print --inlines --exe=$objfile"
-		[[ $is_vmlinux = 0 ]] && args="$args --section=$sec_name"
+		[[ $IS_VMLINUX = 0 ]] && args="$args --section=$sec_name"
 		local output=$(${ADDR2LINE} $args $addr | sed "s; $dir_prefix\(\./\)*; ;")
 		[[ -z $output ]] && continue
 
@@ -305,6 +306,8 @@ run_readelf $objfile
 
 echo "${ELF_SECHEADERS}" | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO not enabled"
 
+check_vmlinux
+
 DIR_PREFIX=supercalifragilisticexpialidocious
 find_dir_prefix $objfile
 
-- 
2.34.1


