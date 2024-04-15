Return-Path: <linux-kernel+bounces-145399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029BB8A55B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2274F1C222E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2A48002A;
	Mon, 15 Apr 2024 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggeHzr5f"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B117D3FE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192952; cv=none; b=R5deHBl7NJySVwEbxIoGqS+AB/b4gY31aNDEZ/9+4Bk6C219Hv1/gx1YwdEgxllJixYQhDTz52YhkI99uO6aTEphQQiJ5+G+DnWE7X4NjHFQh7YuaKMCqaP1d6M+II9ss9yWQ/NkPTB0yJItcCqwuztkU/jnUr3ZbER4VUU21Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192952; c=relaxed/simple;
	bh=z1eiWF00ulFGIhwzo8vX7fAaQ7Gt/3wwViaVAn8v6Xs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RQ1/snPU1rHPCuvk74TPxvIBIxrvprNxRmaGZjIeDOBl1qEodBHux2FSl8lYmBj8lAkJ4yA1qfbSnW7hcDxcKi7wLJgnWR8zwZ0schuRxZH1a6A/KfFnyJvbQYd4rtJ3xcBXHZxW9oXdmfARN5kmpkt07OgjPEJ23+lEcBuTuUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggeHzr5f; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so535959666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713192949; x=1713797749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4gf5zJ8CKFjRYmrei7za8lmpK5Lzx3+chgGCjt8WGo=;
        b=ggeHzr5f+XGoim1nJsX4BjM+Vm1vGSVGXJ5ZkwfrFCfpUW9RH6lB4rNrZ5WFskzfeN
         dboQaej13sbwht+RrGVEoBazUHhDKeyLo5cgZyujfE2g66zw5Ui7GTxb3pt+zu7EbDbH
         dUK9vxHF5LjtYPwUzS2xaktoj0FTu/icytQGR/pvRvNoO26qtc32bgWlSY17BhBwgjp/
         LmmD4iGugmB89xbItHryrx014VWzo8K98EiTdsK+vTmcZ7PK1hAjwE2iNbw2WhlMNwWw
         e6Fg/Ymtkf5eUYWiWnnxN+PMaYzx6HbRIVrpX4HKg5y86ML4imS89EhnmDj0b3oX6GZc
         c+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192949; x=1713797749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4gf5zJ8CKFjRYmrei7za8lmpK5Lzx3+chgGCjt8WGo=;
        b=BUDRa3XgHNGKWm4P9CdkZICQS2PrEN8BKv0JEezvd/MNyB6imI45oQpFo7cd4cvVg9
         dPJogAoy4REIYF/GrrBX9kjA4xSjN+hW/yMTqQmtfqh8+EC2SjyeYKead99oZXpXZfPW
         vI2OFRZKYuGDoIIIgbB2A4DAJHH5zWqmzbLQdW8sfokI/7aLDD0jKIRsjsi47FND+F92
         wEQhuRg0c1TO3yUkZCusxCEUckaabewNgU+CkxVz01R6lE6A/ZDMUG//fmRikPv68JFY
         BLfiCnGDCJ/ljYZP1lU6tDVsznDqH34N892gOqLJBKa175SiUOzJ3VyBEKJDRpN03BFK
         gUgA==
X-Forwarded-Encrypted: i=1; AJvYcCUMz1tgBXeD38TB+c1BNFvHX5XdJjtuJLpUVvF7gJCseqixmlVrb/7XLvj7ORii/Hg/2ynNXPj1ujkUGHZMwMSBdLN58e0DhF1NIWyM
X-Gm-Message-State: AOJu0Yx3cAJ4U+2cWNIKT7FOiKVzNleKpNz9dUrTxLsZZux3iutMUIRH
	4XE7+rEFLNHiAat2LnDAUayboBuBRnwp97AR9gyM6FN2P9XmLTxd
X-Google-Smtp-Source: AGHT+IF9mWA2ROf3u+UOuQ39sEr/zFwualwnQKHhVrvZrS8M9WVzNp0b4f4UkDJlMQNzv9Q8yAnATw==
X-Received: by 2002:a17:907:3d9e:b0:a4e:a23d:4b73 with SMTP id he30-20020a1709073d9e00b00a4ea23d4b73mr12869836ejc.1.1713192949412;
        Mon, 15 Apr 2024 07:55:49 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id s13-20020a056402520d00b0056bf6287f32sm4893415edd.26.2024.04.15.07.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:55:49 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH v2 6/7] scripts/faddr2line: Remove call to addr2line from find_dir_prefix()
Date: Mon, 15 Apr 2024 16:55:37 +0200
Message-Id: <20240415145538.1938745-7-bjohannesmeyer@gmail.com>
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


