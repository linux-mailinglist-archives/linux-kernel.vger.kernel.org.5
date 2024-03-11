Return-Path: <linux-kernel+bounces-99526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F47878998
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AF11F21F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3A458226;
	Mon, 11 Mar 2024 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV/Nh38t"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D257315
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189653; cv=none; b=tjv1oKa8BataKBjOEaXMfirjaYj2lYmUA4WLgUGXVSlNGUBJrs1ui6j2stI4vkSkB4EHvqgbRh0DiN45TbAr4YtqRJxyAJtR1QPyPpRRBXQoFwLtos7fxjPUI8VWyWbihgCyDgL0NqDmDENwUXgUrmjzn9gRSIGG9Eowx7cAw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189653; c=relaxed/simple;
	bh=z1eiWF00ulFGIhwzo8vX7fAaQ7Gt/3wwViaVAn8v6Xs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g9QoJtgAITYEq9+sZaybD2TuQqdBXFGRryf9+1p2KHkiQZDcQS1jvoudi4j2LrXh8YzhPDCMOTWhXHF5z9bZwoCNtdpAgoqeu7HjxcqOXU1Lt8bvhstXHuakI+csiKMdSg1fw+2LWwOfr/MHrB3TCfSF1tWfTkWLn81Zb2irgHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV/Nh38t; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4132cc37e21so6994845e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710189650; x=1710794450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4gf5zJ8CKFjRYmrei7za8lmpK5Lzx3+chgGCjt8WGo=;
        b=WV/Nh38tBykT/JicFi0KacWSCtk6fkOOQttIMrbJwVNy+oa8ehBrNfRe9ZdsKAnGem
         ngM+WVZtvXsJglUPPOOeSfHBnpGMQzOnApiodrmPv88jsIAfa7H6IIMRbf+wCPcK9L6d
         IAEd45MeW4z+YPTyvd7X0cdDO7DHLaYXg3OgiVgn1hTRvqpsyDXOqFqaCdkWyQoxjdaC
         gVdR3JOjGHhx3L4fVzdAKHPFieJfEGRuDsTkOHafHMWQ1WnGOt2kieNHXSXMXwIwBDde
         WyofNlxeAV61Z4mDUqq6sLdVvlPXAV/xAqn6Qu127Nhz0RRSA3DaI4ZUKgjH2ktZLwLz
         4rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710189650; x=1710794450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4gf5zJ8CKFjRYmrei7za8lmpK5Lzx3+chgGCjt8WGo=;
        b=kv4zO4GgPBX9dODYENqOT4KoeSV6UFBGQQceRtw0ciqLvCjSvmKDT4Q1CAANe0kDbx
         iipdJlrl8FP0GINZULiXCIH5Ej9Sjj+tA47m3jLk2jJssFKcisWHoBBjQ32jYFFTGeNk
         lH9XEmTTtdCcQlogRCr0ra+Lcw1vLUAuBCqUcTmpqDJmEdiuR0yrSxqpDz2odvDCzHRm
         M9mgrNoEJgjkXpds77/CbrxgI8ZMwBRyakDWa07LUqT6hLs8y2NeKtKEn/5X3z8bd/ZI
         K1Lf7Hz5oLEe/b9JqE8xvHCA7Stlj09fDXIBP1LzVrpi56+gNiL7J3QfwZUMyBQU+l9b
         VT2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWW04Ifx0it5aSmRrOfwn5wpeoti45FB3PRQHNIbvXernSk0oqc6vx0SIgh1mIY8ua79BTxRyG6YmulXIrXjcbDHMCCImLIvVW8Mi19
X-Gm-Message-State: AOJu0Ywzy/9q2zvN9x8b5G11AIrDtFj22mnZvGDxJyfnWiHVpVAO4yOk
	fFRwBT1KM+QXWP0baNCrixxLaRta0ewfIijnJH68RCVOb92vn0xnshsimVZn75c=
X-Google-Smtp-Source: AGHT+IFmXXxuNdfoeWL7LRFZsvGA+WyC047fJGUlZv8+wxSs1WHgZrjKSl+0gbgaXFowrjsiD0v/ow==
X-Received: by 2002:a05:600c:548c:b0:413:3110:2d06 with SMTP id iv12-20020a05600c548c00b0041331102d06mr555348wmb.16.1710189650396;
        Mon, 11 Mar 2024 13:40:50 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b0041312c4865asm14929355wmq.2.2024.03.11.13.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 13:40:49 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH 6/7] scripts/faddr2line: Remove call to addr2line from find_dir_prefix()
Date: Mon, 11 Mar 2024 21:40:18 +0100
Message-Id: <20240311204019.1183634-7-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311204019.1183634-1-bjohannesmeyer@gmail.com>
References: <20240311204019.1183634-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the single long-running faddr2line process from find_dir_prefix().

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 scripts/faddr2line | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 48fc8cfc80df..1fa6beef9f97 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -85,15 +85,17 @@ command -v ${ADDR2LINE} >/dev/null 2>&1 || die "${ADDR2LINE} isn't installed"
 # init/main.c!  This only works for vmlinux.  Otherwise it falls back to
 # printing the absolute path.
 find_dir_prefix() {
-	local objfile=$1
-
 	local start_kernel_addr=$(echo "${ELF_SYMS}" | sed 's/\[.*\]//' |
 		${AWK} '$8 == "start_kernel" {printf "0x%s", $2}')
 	[[ -z $start_kernel_addr ]] && return
 
-	local file_line=$(${ADDR2LINE} -e $objfile $start_kernel_addr)
-	[[ -z $file_line ]] && return
+	run_addr2line ${start_kernel_addr} ""
+	[[ -z $ADDR2LINE_OUT ]] && return
 
+	local file_line=${ADDR2LINE_OUT#* at }
+	if [[ -z $file_line ]] || [[ $file_line = $ADDR2LINE_OUT ]]; then
+		return
+	fi
 	local prefix=${file_line%init/main.c:*}
 	if [[ -z $prefix ]] || [[ $prefix = $file_line ]]; then
 		return
@@ -350,7 +352,7 @@ echo "${ELF_SECHEADERS}" | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO n
 init_addr2line $objfile
 
 DIR_PREFIX=supercalifragilisticexpialidocious
-find_dir_prefix $objfile
+find_dir_prefix
 
 FIRST=1
 while [[ $# -gt 0 ]]; do
-- 
2.34.1


