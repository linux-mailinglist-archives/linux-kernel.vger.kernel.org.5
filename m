Return-Path: <linux-kernel+bounces-127048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B9489462F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872591F22083
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B4454BD4;
	Mon,  1 Apr 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIiCsOtm"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561917552;
	Mon,  1 Apr 2024 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004339; cv=none; b=MTHJUogmpeT+YVq1ECuBezUoTdfcRrN2SvzF4Nivf3u4SHMW0gAsTfhKW6/CpEAEL3nJckFfxvBJnbjfQSLGECZZTyHVRR+fXgnKUSQ7eEEoCm2G8Z3up8/p+LQ4mvJtdns6Y9CYnOghMb7Y2RJgV98AjfVnjMD5ZzrgoS3pMIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004339; c=relaxed/simple;
	bh=DGZycoG/+6zZqZZVmTB3nd3K6WZ3LQItRHg9esmxBD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VuIb+Enni+vr+kBXlw/n+osdxr18ooOtiRoqNyRAdbdZWjlci+ztSCmq/MHE/WJ8LOajQ91BQcjuZ17nW81AiED0hFbKsXh0u1n8k9ZjbqJCktPn0GYmpgo4UVX4lKmlDfM70OrOeqRL0ji7uANTHAh8QnhqMsZgFqja2su27HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIiCsOtm; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44665605f3so497269366b.2;
        Mon, 01 Apr 2024 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712004336; x=1712609136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze5m9pU4VAoww/ZXiCsoFMWeDLEC0zqWwwSMDVFKCNY=;
        b=XIiCsOtmZfnrXpxQkYw0MZ61POcyigK6+XmWWlOZpDpNhbCVaSY0yJsSA2nLmpnXqj
         nvrihaowFyYJ+xf8NeAEDc/VccJ/GixY2Wx3sXc4eg8zh9ZJ+n2Ui5aap0qF9Ow00hPl
         /6YcMbR66aUyIrz0A7bJZ6ItL2WGhwzcGb3QNiQbsRcU85Sa4Ti3bQcuhkn06T3uvv0u
         IuAquus7Nnl/uO+Hs8fUA1Beaox+Etm5UNyrO5NmCnvPvMPo8Kvx2d9tsv4NTghGoB8Q
         SH4LOk70/D/jeXKJ0U85f8N/0YbduFhEbBLxeCFAJKK8D/nksl17i0rImoCVPJJd/N8m
         IVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712004336; x=1712609136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ze5m9pU4VAoww/ZXiCsoFMWeDLEC0zqWwwSMDVFKCNY=;
        b=cIyOaFm6d6SJyTnoUZ0HSxPKEWuaYmapIyF/vDSHL6qGZ5OJaSz6KhT2OW7VZW3KiF
         BGkrLyfDszvwLPFS2I5ddn5IHNf3In7dbVx2LnAmvZhhQj5j+8cLWVAfbF+xk74YG8zE
         BEpHnxzENN6uLFRbFYN/ALcIX6ftUmF8nP76DrsU7G52dQZLH5iqkc4CwWjTbnBU5diC
         Qz3K/ngm6240MqN1SnMMxFdy9+KJck29hp7tnf83xi5jCu1yC0+juTgBE9NJsiDA8ZlX
         onEgEexTA1yLULFsfO4WwkxczXAwDZKu141IAJ0qcKWAWBiAQfcVCtZfD5zXpDtcluTZ
         WpXw==
X-Forwarded-Encrypted: i=1; AJvYcCU7TK6RXqs7KWkSihN/fbGjFa3XrP4oK/hgcz1DzDCy7stz0nLxyR0MoWvD/j5hOnrVoe6inTFVdvoImrhRlNoSIIk0XvN+mbCtS3Ed
X-Gm-Message-State: AOJu0Yzy/r/j2gFLvoRCi3kybq966/H2fLDD6kZG9zZxVcqts45jOnv4
	raldKGZlOReK+CeBHTIjCnV0Ygv2HJ4QBTl0P+HqWWB2OjIxYdJO
X-Google-Smtp-Source: AGHT+IFB3CglDKr5Nz/bubGO8prjCDJN5uWY6h3ggeORYvQ5McMEeKVn6J2OTscWkf9WzgmIDgfuRg==
X-Received: by 2002:a17:907:980d:b0:a4e:37e1:62f4 with SMTP id ji13-20020a170907980d00b00a4e37e162f4mr7825118ejc.18.1712004335424;
        Mon, 01 Apr 2024 13:45:35 -0700 (PDT)
Received: from localhost.localdomain (2a02-8389-41cf-e200-5145-c12f-55fb-574a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:5145:c12f:55fb:574a])
        by smtp.gmail.com with ESMTPSA id l3-20020a1709067d4300b00a466af74ef2sm5646751ejp.2.2024.04.01.13.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:45:34 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
To: dan.carpenter@linaro.org,
	javier.carrasco.cruz@gmail.com
Cc: smatch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Documentation/smatch: fix paths in the examples
Date: Mon,  1 Apr 2024 22:45:10 +0200
Message-Id: <20240401204512.538453-2-javier.carrasco.cruz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240401204512.538453-1-javier.carrasco.cruz@gmail.com>
References: <20240401204512.538453-1-javier.carrasco.cruz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few examples use the '~/progs/smatch/devel/smatch_scripts/' path,
which seems to be a local reference that does not reflect the real
paths in the project (one would not expect 'devel' inside 'smatch').

Use the generic '~/path/to/smatch_dir/' path, which is already used
in some examples.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/smatch.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/smatch.txt b/Documentation/smatch.txt
index 59106d49..b2c3ac4e 100644
--- a/Documentation/smatch.txt
+++ b/Documentation/smatch.txt
@@ -39,7 +39,7 @@ For projects other than the kernel you run Smatch with the options
 "--call-tree --info --param-mapper --spammy" and finish building the
 database by running the script:

-	~/progs/smatch/devel/smatch_data/db/create_db.sh
+	~/path/to/smatch_dir/smatch_data/db/create_db.sh

 Each time you rebuild the cross function database it becomes more accurate. I
 normally rebuild the database every morning.
@@ -47,18 +47,18 @@ normally rebuild the database every morning.
 If you are running Smatch over the whole kernel you can use the following
 command:

-	~/progs/smatch/devel/smatch_scripts/test_kernel.sh
+	~/path/to/smatch_dir/smatch_scripts/test_kernel.sh

 The test_kernel.sh script will create a .c.smatch file for every file it tests
 and a combined smatch_warns.txt file with all the warnings.

 If you are running Smatch just over one kernel file:

-	~/progs/smatch/devel/smatch_scripts/kchecker drivers/whatever/file.c
+	~/path/to/smatch_dir/smatch_scripts/kchecker drivers/whatever/file.c

 You can also build a directory like this:

-	~/progs/smatch/devel/smatch_scripts/kchecker drivers/whatever/
+	~/path/to/smatch_dir/smatch_scripts/kchecker drivers/whatever/

 The kchecker script prints its warnings to stdout.

@@ -69,8 +69,8 @@ Smatch with kernels that are normally built with cross-compilers.
 If you are building something else (which is not the Linux kernel) then use
 something like:

-	make CHECK="~/progs/smatch/devel/smatch --full-path" \
-		CC=~/progs/smatch/devel/smatch/cgcc | tee smatch_warns.txt
+	make CHECK="~/path/to/smatch_dir/smatch --full-path" \
+		CC=~/path/to/smatch_dir/smatch/cgcc | tee smatch_warns.txt

 The makefile has to let people set the CC with an environment variable for that
 to work, of course.
--
2.40.1


