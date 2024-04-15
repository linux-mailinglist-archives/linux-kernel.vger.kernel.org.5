Return-Path: <linux-kernel+bounces-145394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF258A55AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705721C21F15
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B1276046;
	Mon, 15 Apr 2024 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EslYGgKj"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6292119
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192945; cv=none; b=Ypl3be971lkjIidIhBCDRg1X/jFh8B/JG5mVfuzdmnaPafepTwtHoy2zwJg5ve/XQtIvnQwuFey6Te+VgppDbHZcsj12gYGxnNQMSoSk4sw7UMPYJXmu8thKA71vwVn3MHqSCZWKPD20ulWjjzatjH4wbHh9JX2NyJUfVMgpCS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192945; c=relaxed/simple;
	bh=9OWRJdkAv7cHnWuVRgo+tbzxoUOMQDC00S++Chf+Sns=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GuGjJj8O4R1RByIjbDbk/ZF7G/WeLhRwZD6l5/OC6x2Mbbk2k1g7FkmHQjGmjGC4i8JDdhvDFCL7mcnLpCOHXzJ67ZbTutGGKJnyXZw2dQBNA9UiexLUPuIsZN6rxIvz6yKq13mWL3jRQR7Jgkfm3BsBXKhcWyzGG/ZBVyNuBuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EslYGgKj; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-518d98b9620so1516174e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713192942; x=1713797742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTVNNfo5/Y61rhM7u0Y0ocSrSY3U2WS9X7F9mo8CMy4=;
        b=EslYGgKjR8I3tRXIkC8cIzcbwSJvKoNI0wd3WzmRQhQ7ZBRf7/CppQ6Y+p15ixWrfp
         wuhVwARbslTXM/2iawl8t3m6edbzpEObpzsGhHDbYAD4GKI3hT+0IODCFKxMH/THG0UB
         loWKyqotyC8iKSgRUameQ1xJEFPiFnIaqjlHeO/8MpDta15Z9MunKvwmDiWgbCx0vRee
         yhYUCpilWc7iOvN9YuKBqgkwpXBEmvdy/+uRcLqfC1N1FeCemzSj4mYdEQ23Bl4K8LQs
         q9jf0qhesi3oViq1BEZjB70ohyLUqIdsbmEsMSaLZQl7oZ4fV9GvobYasiYVcwlnhbmC
         QlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192942; x=1713797742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTVNNfo5/Y61rhM7u0Y0ocSrSY3U2WS9X7F9mo8CMy4=;
        b=Gl/K8MLyumHT5DatQUImmiA7gnQmk9BSIGm0LLVmU1Cymr2ZHj48gCcoEW1f9UVy85
         Ly+UrvyAzbY+IhY50n9dP7SUKo4txt5miHSn91WtiQ7SvXEOAiWDRV+xo09oSqK5cWVm
         669z+NW5rM1+OE2qnt7eU2KGh+cYN/GQKgjGj1r+f2YFxqLgMNnLVIDQEvbYYwS4+EHa
         D5VnAFnU7eoHE2dcBYxs+94dQK42DRHHA0e5A8X3sielCGw4q2x2n2I+tBxrGl8XYWkG
         1lPPsu7Vy+TyN41/lfG1cOs8r6xf30Y0wa03enjW8S7dZyFocw7nmr0uo4npRXrD/5av
         pGzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO+26KIPPT7sZE565sW8lQL/CA2IwmFjjw4LgEwPnXVMJSfQfbiTRmdX94AQiIfx/chYXfB8w68aMTRgwbhc1Wf0UrJzUzJvxYfv13
X-Gm-Message-State: AOJu0YwmE6AA0xQV9R16fSefAXbTOtlK/b+U2hlOXbFzz4lzI/EWqS6o
	uU9VkyyvwGmlzI7KHK2BRMGaQvWPVBXZBSdOLONoSkiKAQDYUqvW877QQ1vj
X-Google-Smtp-Source: AGHT+IEz8efraFklN0cHdU13zp8UbF4xXSaT8V02FypB+9ruwA2hWS9T97FhnXCMburIFEZFh119Gg==
X-Received: by 2002:ac2:4d17:0:b0:518:d829:4bae with SMTP id r23-20020ac24d17000000b00518d8294baemr2757922lfi.32.1713192942140;
        Mon, 15 Apr 2024 07:55:42 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id s13-20020a056402520d00b0056bf6287f32sm4893415edd.26.2024.04.15.07.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:55:41 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH v2 1/7] scripts/faddr2line: Reduce number of readelf calls to three
Date: Mon, 15 Apr 2024 16:55:32 +0200
Message-Id: <20240415145538.1938745-2-bjohannesmeyer@gmail.com>
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

Rather than calling readelf several times for each invocation of
__faddr2line, call readelf only three times at the beginning, and save its
result for future use.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 scripts/faddr2line | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 587415a52b6f..bf394bfd526a 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -87,7 +87,7 @@ command -v ${ADDR2LINE} >/dev/null 2>&1 || die "${ADDR2LINE} isn't installed"
 find_dir_prefix() {
 	local objfile=$1
 
-	local start_kernel_addr=$(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' |
+	local start_kernel_addr=$(echo "${ELF_SYMS}" | sed 's/\[.*\]//' |
 		${AWK} '$8 == "start_kernel" {printf "0x%s", $2}')
 	[[ -z $start_kernel_addr ]] && return
 
@@ -103,6 +103,14 @@ find_dir_prefix() {
 	return 0
 }
 
+run_readelf() {
+	local objfile=$1
+
+	ELF_FILEHEADER=$(${READELF} --file-header $objfile)
+	ELF_SECHEADERS=$(${READELF} --section-headers --wide $objfile)
+	ELF_SYMS=$(${READELF} --symbols --wide $objfile)
+}
+
 __faddr2line() {
 	local objfile=$1
 	local func_addr=$2
@@ -125,7 +133,7 @@ __faddr2line() {
 
 	# vmlinux uses absolute addresses in the section table rather than
 	# section offsets.
-	local file_type=$(${READELF} --file-header $objfile |
+	local file_type=$(echo "${ELF_FILEHEADER}" |
 		${AWK} '$1 == "Type:" { print $2; exit }')
 	if [[ $file_type = "EXEC" ]] || [[ $file_type == "DYN" ]]; then
 		is_vmlinux=1
@@ -143,8 +151,7 @@ __faddr2line() {
 		local sec_name
 
 		# Get the section size:
-		sec_size=$(${READELF} --section-headers --wide $objfile |
-			sed 's/\[ /\[/' |
+		sec_size=$(echo "${ELF_SECHEADERS}" | sed 's/\[ /\[/' |
 			${AWK} -v sec=$sym_sec '$1 == "[" sec "]" { print "0x" $6; exit }')
 
 		if [[ -z $sec_size ]]; then
@@ -154,8 +161,7 @@ __faddr2line() {
 		fi
 
 		# Get the section name:
-		sec_name=$(${READELF} --section-headers --wide $objfile |
-			sed 's/\[ /\[/' |
+		sec_name=$(echo "${ELF_SECHEADERS}" | sed 's/\[ /\[/' |
 			${AWK} -v sec=$sym_sec '$1 == "[" sec "]" { print $2; exit }')
 
 		if [[ -z $sec_name ]]; then
@@ -197,7 +203,7 @@ __faddr2line() {
 				found=2
 				break
 			fi
-		done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
+		done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
 
 		if [[ $found = 0 ]]; then
 			warn "can't find symbol: sym_name: $sym_name sym_sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"
@@ -278,7 +284,7 @@ __faddr2line() {
 
 		DONE=1
 
-	done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$8 == fn')
+	done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$8 == fn')
 }
 
 [[ $# -lt 2 ]] && usage
@@ -291,7 +297,9 @@ LIST=0
 [[ ! -f $objfile ]] && die "can't find objfile $objfile"
 shift
 
-${READELF} --section-headers --wide $objfile | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO not enabled"
+run_readelf $objfile
+
+echo "${ELF_SECHEADERS}" | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO not enabled"
 
 DIR_PREFIX=supercalifragilisticexpialidocious
 find_dir_prefix $objfile
-- 
2.34.1


