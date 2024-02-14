Return-Path: <linux-kernel+bounces-64666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31414854141
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43481F214DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F3E11701;
	Wed, 14 Feb 2024 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJX4wR1B"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8711197;
	Wed, 14 Feb 2024 01:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873933; cv=none; b=dRKoWr/UcaMqkvvKGuabW+HbHhT9qlflSZ7N9YBSbtPRHSAzjADlxMEWc0KInjC3j3fQCUNW6FloWi4Pnu3AfkUdTPze6u2pktZ1FEM6iBOiX1EVaAyZFZ5fbw4+TLzDyOUyUzgfL6Flj3ZxGVaiGgy9KdWXizVciE7krxCHhlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873933; c=relaxed/simple;
	bh=yOEMQLS0HBWD1xpp/GEUAOHOe6zYSrs6EjP/pYr8yKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFs01rmXl4/KldDFj63HcIe/C5A/SGTsFuPLDUPWGixReogELNWn6N9u35ToWaI1zon+WhaWjRgjW0rUQvOFrjw4hEhe4bRpXUOo6DMHxBdQMcM2oxaYxIb8ldHaMfJmnLMI/yFy1uTRySN9FOmE58J9kJtzGUcXcUdux0thqAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJX4wR1B; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2185739b64cso3175408fac.0;
        Tue, 13 Feb 2024 17:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707873931; x=1708478731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zqcKGjJIq8z28bcz9jGNmiRh2zlXlrXCYNsKpGAsbk=;
        b=RJX4wR1B6KPkvvvpTmwmtkAhG7jv8V7Ys/5f76WCqrGv7ZYIFaaGvlm2jppkEyyvEJ
         83qKm6IeKGx5E1qiwZwLhqrBxpoQZnuG9QDhtl8Fw/xoXTVqY8BK0X0MSVBknKt7fPk1
         E7CzczaN3pLwJvVLNqTFbBWj3nrjXauB5YaYA4M829wv/gFcXtwgcUgMyHeo26opb8M3
         tfG1LfPwXB+NQVN2KZFmkeUi8xqZL5G9uar5NQzxFOtLVHh+hmQyUq2zbKrsEmOWjpZm
         QF6tX3U5tggVRkcZ7f0L4nKgSFIVflbeJo88M7MTCX4f7LIHGhwCHW3GPhdIV5JRIEW1
         nvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873931; x=1708478731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zqcKGjJIq8z28bcz9jGNmiRh2zlXlrXCYNsKpGAsbk=;
        b=LrH0PT3Bl/HPJNECWQt59WPo/2RGDebFpcD1t54P9cgS9WI28roPyWShMAC2vrTjKn
         VofFSMlds7exk0sdQ6ukKz+sHZ2t+P8lsYKSbOZcQUPCZcNM02qOjZOpUI01SaN98jii
         bgGF6SihcJBii2vk9XgEBIHkbdwpeo8/y7Wf0nQw7w9Hnw1gHt8H8OvPiUwyejlrtzUZ
         tEP6I/DbdeV8PKh4JdczUcbLj1SJERC5RxdNjXamp1TJRpdWzYwHDN3uixILaYQwsCcV
         NtcriVEPsvS5fqqvxy+R5j9qwX4nfgSC37qO2PKdtXTdGvNow0Fuk8gXStPvbr5UWUSq
         a/JA==
X-Forwarded-Encrypted: i=1; AJvYcCVRP9kbSlyQ7XJbxl97olVI0L8P6iC6RENSeWiRfZVRVfNSskyha01Krb71y6P1b8cnUwa3xYztC1cMmP8j5OS7x9xljI/l1opideN1egzrOOopT7ANG1bsLycsYonlCnokJacVmmsG0kAm
X-Gm-Message-State: AOJu0YylKgH6/KROsuQniwgZK6thEf9eWOgKSYSnnjmd+MnkABZvkgVk
	hb0Unfg5neBnGL+DoDGcRWXOFoB8dwQ8FVpTIDALOXDSp74/VLtz
X-Google-Smtp-Source: AGHT+IGkPWH3yWst8zIhaEqoltQddmcw8FOkSPKhRemNOFMvUlGw/MFK4UEg1BMeMV6v3qIWULcviA==
X-Received: by 2002:a05:6870:84c2:b0:21a:216d:3a6a with SMTP id l2-20020a05687084c200b0021a216d3a6amr1195402oak.52.1707873930990;
        Tue, 13 Feb 2024 17:25:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVv1/HqwbbPQn8gnhT+3LrX1gtJKlF9y4+dDoI8DuptB9zKlMmYPlEA9NbSXc7Wg1qo5pU1tT2nPwL9R7K/x0hS8W2NQ6FKvh7TFU7du9IwKDTWJTsYCzl/xgDX+pM/hBynoFTzCmtPyjqMTRnatvME3uCT2Yqmi5r+5/X0m9XOEvFf71xLF6HJ+Ch6gyxc3oAatPw9jPfzVxMrjPDUyVy52T5Bw1MDX5whs0UBXXDKWBKTXiat5eSwOir99hrhzR55jp4MkLwW9bUTSdGhqpz3tDxveYLBih+jg96V47GtOSIU7CQgGSijeXr8yIqDqpHgHVxhT6CRRwcHPXkVM1VAnhcr4WDy1//qmSNJLrIip2eevvh4bpwaApC0+d3Thzy0pToic/MDQa9oeFNNLrBhhR8=
Received: from my-computer.uh.edu ([129.7.0.170])
        by smtp.googlemail.com with ESMTPSA id pc7-20020a0568701ec700b0021a89fff00esm572928oab.19.2024.02.13.17.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 17:25:30 -0800 (PST)
From: Andrew Ballance <andrewjballance@gmail.com>
To: justinstitt@google.com
Cc: andrewjballance@gmail.com,
	linux-kbuild@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	masahiroy@kernel.org,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	nicolas@fjasle.eu,
	skhan@linuxfoundation.org
Subject: [PATCH v3 1/1] gen_compile_commands: fix invalid escape sequence warning
Date: Tue, 13 Feb 2024 19:23:05 -0600
Message-ID: <20240214012439.879134-2-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214012439.879134-1-andrewjballance@gmail.com>
References: <CAFhGd8pvhzehMGh1XEHBct7CGEQuF0CZeneMH3D6cKSRj5UdHQ@mail.gmail.com>
 <20240214012439.879134-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

with python 3.12.1 '\#' results in this warning
    SyntaxWarning: invalid escape sequence '\#'

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 scripts/clang-tools/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index 5dea4479240b..e4fb686dfaa9 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -170,7 +170,7 @@ def process_line(root_directory, command_prefix, file_path):
     # escape the pound sign '#', either as '\#' or '$(pound)' (depending on the
     # kernel version). The compile_commands.json file is not interepreted
     # by Make, so this code replaces the escaped version with '#'.
-    prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
+    prefix = command_prefix.replace(r'\#', '#').replace('$(pound)', '#')
 
     # Return the canonical path, eliminating any symbolic links encountered in the path.
     abs_path = os.path.realpath(os.path.join(root_directory, file_path))
-- 
2.43.0


