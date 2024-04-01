Return-Path: <linux-kernel+bounces-127049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD8E894630
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043ED1F2229F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B72155783;
	Mon,  1 Apr 2024 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ9iBvPQ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD053E16;
	Mon,  1 Apr 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004340; cv=none; b=m98MiyCL5o5Ur3sZaJXSOBrInvdXqEPkJ9ed0SG6XPgPS+nKgGYtdn3fZmnXVwr/+6myLQdbnwD/m63hpn5x5zowuEh4KLCfUL0NdvNG04dZ+LUqQx2YJXPXHRhpvHh1EpZQ2oYd+fJJZLiAPS1//jWekXaLHfVE5x70IDQNcJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004340; c=relaxed/simple;
	bh=/fleXBNYAYU3E77ArQ+/9CqE2wRzAKHtMfKgZTlcNMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BYVVoOaN7E1GuN5TDV9ryw2FToZURjTJsgd58qPWudOn26bvR/S/aX3exxreE/vwpHeY7oLyKK83z2gPuI+2377pW41qH96PM6lua6r5kAcnNEUD/JsidQbXMv02WMYvUmhjO3nRqWqv72xMDuKJk/VOUjIr93F56E56PhpgiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZ9iBvPQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4e5ee91879so200627966b.3;
        Mon, 01 Apr 2024 13:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712004337; x=1712609137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wrp24nKKQiBtqi68g4W7Q5hiUOZC7GtVZoFpsiai5/w=;
        b=LZ9iBvPQy/Ms80jH/KajcEOV4NQTH8Y2yy938CYVJEHca+RECGxXy/nSvFFJFAwE2T
         LfrNNqAMHZVJ4ohEH0pbJeT4EfjVMCAG5QNvpLNURRthWgKo+Azp9D5gh5eDImLQlLg5
         Gdi2JXAv0OQVEjIemFpeVM9YBYtjdi3mkDrYXQpnoLq65hIGGAg7EXexg9Qo+rcP64Qu
         hCKWWzLardV2ndIPG8+z0VRhWl++At7oUthvvNTqiS/35rZv40q7orYeYUw/CwXr9yF9
         aXT1BFttUT/Y1U8OPuVKN+asO2rhdaR2kJIHvYw/5fjy9blmiGtybXF9ZdFYn3ZwStup
         qr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712004337; x=1712609137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wrp24nKKQiBtqi68g4W7Q5hiUOZC7GtVZoFpsiai5/w=;
        b=UAAOeM4F2mgSxEITRoagmefuw+GFjw6HfXJCoP1xc3kIitG9WwSDzs8N7JNXj3P7sc
         Yz2Pq97nh0Hkqam9cIfvxQI+rPBsd8wJJKy68THFdiVhVp9xegTlaORdtPSYhVdnxDgS
         HgD0OdawXQVWkeCbdho2ifjMfmNC6IBD7ViW9OB+L8a3KneFYPHBoMypR1tfZdS2faoo
         NV74/Bw+80nmyJHvYjaAKShXN7oUs/u2LBrXaxrSal90jkLsPoRVN1zrcfzjvj/LRJi3
         VX/YW/qBHkxFWjtgAsjkEBdaM36rHsaTSea7MB91Qv556RGYbYlDFfmAj0AFAGADzr+A
         GGng==
X-Forwarded-Encrypted: i=1; AJvYcCUhe6p9lzRE++dXvn/VAexcnNr8zN+9yFFjEo/Gb25YDHCGj7l+TZ48cFE7+JHGnHRNDzUfK0++u5g20wXu5gzIYkkADQ/pAN+yHyLa
X-Gm-Message-State: AOJu0YxKH+wPxPcmZw4U0e0xVJWPC73FJA7UUz5UqIiCMGanUdDMkBGO
	yNbpeFAL59IDB5jf+cr0bMCTQZESiNa3rLIPzcpXcpX3RXiWg1N6SbGwp5+gbbM=
X-Google-Smtp-Source: AGHT+IH2WZInKwDy7nlpjgO3Q8RIsWQfbAsSN8X8rvcgftsTthzXUU2OfG+ckdV4ImjMhjilLXCuBQ==
X-Received: by 2002:a17:906:fe0d:b0:a4e:7f22:cfc2 with SMTP id wy13-20020a170906fe0d00b00a4e7f22cfc2mr882350ejb.28.1712004336811;
        Mon, 01 Apr 2024 13:45:36 -0700 (PDT)
Received: from localhost.localdomain (2a02-8389-41cf-e200-5145-c12f-55fb-574a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:5145:c12f:55fb:574a])
        by smtp.gmail.com with ESMTPSA id l3-20020a1709067d4300b00a466af74ef2sm5646751ejp.2.2024.04.01.13.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:45:36 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
To: dan.carpenter@linaro.org,
	javier.carrasco.cruz@gmail.com
Cc: smatch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Documentation/smatch: convert to RST
Date: Mon,  1 Apr 2024 22:45:11 +0200
Message-Id: <20240401204512.538453-3-javier.carrasco.cruz@gmail.com>
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

Convert existing smatch documentation to RST, and add it to the index
accordingly.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/index.rst                  |  1 +
 Documentation/{smatch.txt => smatch.rst} | 56 +++++++++++++-----------
 2 files changed, 31 insertions(+), 26 deletions(-)
 rename Documentation/{smatch.txt => smatch.rst} (72%)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index e29a5643..761acbae 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -86,6 +86,7 @@ Some interesting external documentation:
    test-suite
    doc-guide
    TODO
+   smatch

 .. toctree::
    :caption: Release Notes
diff --git a/Documentation/smatch.txt b/Documentation/smatch.rst
similarity index 72%
rename from Documentation/smatch.txt
rename to Documentation/smatch.rst
index b2c3ac4e..f209c8fb 100644
--- a/Documentation/smatch.txt
+++ b/Documentation/smatch.rst
@@ -1,43 +1,46 @@
+======
 Smatch
+======

-0.  Introduction
-1.  Building Smatch
-2.  Using Smatch
-3.  Smatch vs Sparse
+.. Table of Contents:

-Section 0: Introduction
+.. contents:: :local:
+
+
+0. Introduction
+===============

 The Smatch mailing list is <smatch@vger.kernel.org>.

-Section 1:  Building Smatch
----------------------------
+1. Building Smatch
+==================

 Smatch needs some dependencies to build:

-In Debian run:
-apt-get install gcc make sqlite3 libsqlite3-dev libdbd-sqlite3-perl libssl-dev libtry-tiny-perl
+In Debian run::

-Or in Fedora run:
-yum install gcc make sqlite3 sqlite-devel sqlite perl-DBD-SQLite openssl-devel perl-Try-Tiny
+	apt-get install gcc make sqlite3 libsqlite3-dev libdbd-sqlite3-perl libssl-dev libtry-tiny-perl

-Smatch is easy to build.  Just type `make`.  There isn't an install process
-right now so just run it from the build directory.
+Or in Fedora run::
+
+	yum install gcc make sqlite3 sqlite-devel sqlite perl-DBD-SQLite openssl-devel perl-Try-Tiny

+Smatch is easy to build.  Just type ``make``.  There isn't an install process
+right now so just run it from the build directory.

-Section 2:  Using Smatch
-------------------------
+2. Using Smatch
+===============

 Smatch can be used with a cross function database. It's not mandatory to
 build the database but it's a useful thing to do.  Building the database
 for the kernel takes 2-3 hours on my computer.  For the kernel you build
-the database with:
+the database with::

-	cd ~/path/to/kernel_dir
-	~/path/to/smatch_dir/smatch_scripts/build_kernel_data.sh
+	cd ~/path/to/kernel_dir ~/path/to/smatch_dir/smatch_scripts/build_kernel_data.sh

 For projects other than the kernel you run Smatch with the options
 "--call-tree --info --param-mapper --spammy" and finish building the
-database by running the script:
+database by running the script::

 	~/path/to/smatch_dir/smatch_data/db/create_db.sh

@@ -45,21 +48,23 @@ Each time you rebuild the cross function database it becomes more accurate. I
 normally rebuild the database every morning.

 If you are running Smatch over the whole kernel you can use the following
-command:
+command::

 	~/path/to/smatch_dir/smatch_scripts/test_kernel.sh

 The test_kernel.sh script will create a .c.smatch file for every file it tests
 and a combined smatch_warns.txt file with all the warnings.

-If you are running Smatch just over one kernel file:
+If you are running Smatch just over one kernel file::

 	~/path/to/smatch_dir/smatch_scripts/kchecker drivers/whatever/file.c

-You can also build a directory like this:
+You can also build a directory like this::
+

 	~/path/to/smatch_dir/smatch_scripts/kchecker drivers/whatever/

+
 The kchecker script prints its warnings to stdout.

 The above scripts will ensure that any ARCH or CROSS_COMPILE environment
@@ -67,7 +72,7 @@ variables are passed to kernel build system - thus allowing for the use of
 Smatch with kernels that are normally built with cross-compilers.

 If you are building something else (which is not the Linux kernel) then use
-something like:
+something like::

 	make CHECK="~/path/to/smatch_dir/smatch --full-path" \
 		CC=~/path/to/smatch_dir/smatch/cgcc | tee smatch_warns.txt
@@ -75,9 +80,8 @@ something like:
 The makefile has to let people set the CC with an environment variable for that
 to work, of course.

-
-Section 3:  Smatch vs Sparse
-----------------------------
+3. Smatch vs Sparse
+===================

 Smatch uses Sparse as a C parser.  I have made a few hacks to Sparse so I
 have to distribute the two together.  Sparse is released under the MIT license
--
2.40.1


