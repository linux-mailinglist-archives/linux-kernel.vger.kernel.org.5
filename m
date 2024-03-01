Return-Path: <linux-kernel+bounces-88542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6DB86E32B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0D61F21DA9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C856F074;
	Fri,  1 Mar 2024 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gk5b3wei"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C365E6EB7D;
	Fri,  1 Mar 2024 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302686; cv=none; b=HxYEXogrDsLn4gO/dEyF9Ctykq7Ztcm4Jt5M6IgHlDMBDT+zuoEHjf33ct7InrJGxnHoXDJL/3lFcFPZXTE6sMjm3MMvf1wrRvxmFT/reahYX+7pXg6+RygRiQqywuwtUM7kHjq9HDsmkPdDiXGdXaJv2M4pUbVBhtEv+C4RAXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302686; c=relaxed/simple;
	bh=D+vLVgNSB6OJCkwkdiQ/Iewxjkio5RJ2m9abpN1+EHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+6vtFrcpghs/hONxStmzeqGiGmA4TjKebBG+utcXXTxd4p3GQrkDeb8EzqfgEKe+wH0hsqCnpiGwtOWWIh6/zpHPtIuCOkqmtIurYlH0eSw3cSeEXT8a7yOqkXldD4+fT9Ujv/5jCOI8E6xd/DTo6ZvM8t4d2452KvGgMuO5sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gk5b3wei; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d18931a94so1219218f8f.1;
        Fri, 01 Mar 2024 06:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709302683; x=1709907483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iZ5qWcryj1xGwlryYdwJv9e3FPpE5SnnsgIwWyR+VCI=;
        b=gk5b3weiC+NAv21ctRURRrS6et69aHeYQXSr73e322QlK11dggZNUkxIvRN9hqjg9t
         vGstpaFDgJQEdzaQCgFXJhMUjsTh0609If6u/wFOsjXMP6XqesOvzPwQ5a5rt0qFLsez
         lCOhhPtGHpAg+Y1xrVhBD+ArqTVIsgILfyhjP5Z5lRTHDbz7+LPrTM4yqO+ipJSMCyDj
         2l6oRxLO0uxeRxgrfNdoSqb989h4gRhrH7nDG8z6Ji2EnbG/agkWNqKyqIbTckoqOqaj
         Ehag6KgrTkB0pik4SiqcH9EMg4GEja4vIve4Yb5YbBsQPRESMiwTinicLe3wyoZjN1s8
         Wd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709302683; x=1709907483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZ5qWcryj1xGwlryYdwJv9e3FPpE5SnnsgIwWyR+VCI=;
        b=sgUJm19mWM3iHAYfiSJBX4sDFKSPboCKFRn2wFRk4MfwLDaW/2pEFUAS7DOYKQ8COp
         QpUZhmlTZZRWvEHUZV3Z0HqwyvvECkwTsXo2tW9MPolZpg8pOqAM5LhMryHEiP8IL0yY
         PxBAkLG3rynTXrFbu+F7txV5MH/O6RoU7m8q83/sBc+PSmq9h5P25gGb+Yxd5OHv7u5K
         eL0Gshnk7WYX0HKhwVhxlRXm3vp0aUZAuPGdzUY2JgZJL5kQL9OOXFlSpcGn7LO+jOaI
         Qmd8uPqBHdhIiYVD5p/PnyK2exdX7yNAlKWWrjyEy95AkKXBRSnJH0mohGWtge0O65Fh
         chhw==
X-Forwarded-Encrypted: i=1; AJvYcCUi9t81njMyl8AWMx3kQytzEB0RIqXn9Fq5pIQ4IRc8WHvlLDAjID8fLeC5CHfIxIFxJdE4lrVnniSWWu2geAqrpbtIhLGOEYcr
X-Gm-Message-State: AOJu0YwR6bnCydjX912Z5lzTJx0E/qWFwB6hvldRGDSWgkuA67S1y3Ee
	T3gFWdcZgBSLynd4561E45nQoUlkhSGwP92DFDWG7T8+Z1/Xdr5N
X-Google-Smtp-Source: AGHT+IF9n1Rh1FgSNSP10DMZLzJAe5zxlQFzu8xYDxrAPxsWnV1C1vlZJbg+9zEPk/y3YGhxoXC+bw==
X-Received: by 2002:a05:6000:c8:b0:33e:142f:7ca9 with SMTP id q8-20020a05600000c800b0033e142f7ca9mr1340932wrx.54.1709302682965;
        Fri, 01 Mar 2024 06:18:02 -0800 (PST)
Received: from lola.. ([2a02:810d:7e40:14b0:d371:e319:5dd0:9b35])
        by smtp.gmail.com with ESMTPSA id j13-20020adff00d000000b0033d06dfcf84sm4643368wro.100.2024.03.01.06.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:18:02 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] docs: drop the version constraints for sphinx and dependencies
Date: Fri,  1 Mar 2024 15:18:00 +0100
Message-ID: <20240301141800.30218-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed (see Links), there is some inertia to move to the recent
Sphinx versions for the doc build environment.

As first step, drop the version constraints and the related comments. As
sphinx depends on jinja2, jinja2 is pulled in automatically. So drop that.
Then, the sphinx-pre-install script will fail though with:

  Can't get default sphinx version from ./Documentation/sphinx/requirements.txt at ./scripts/sphinx-pre-install line 305.

The script simply expects to parse a version constraint with Sphinx in the
requirements.txt. That version is used in the script for suggesting the
virtualenv directory name.

To suggest a virtualenv directory name, when there is no version given in
the requirements.txt, one could try to guess the version that would be
downloaded with 'pip install -r Documentation/sphinx/requirements.txt'.
However, there seems no simple way to get that version without actually
setting up the venv and running pip. So, instead, name the directory with
the fixed name 'sphinx_latest'.

Finally update the Sphinx build documentation to reflect this directory
name change.

Link: https://lore.kernel.org/linux-doc/874jf4m384.fsf@meer.lwn.net/
Link: https://lore.kernel.org/linux-doc/20240226093854.47830-1-lukas.bulwahn@gmail.com/
Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
Tested-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
v1 -> v2:
  drop jinja2 as suggested by Vegard.
  add tags from v1 review

 Documentation/doc-guide/sphinx.rst    | 11 ++++++-----
 Documentation/sphinx/requirements.txt |  7 ++-----
 scripts/sphinx-pre-install            | 19 +++----------------
 3 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 709e19821a16..8081ebfe48bc 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -48,13 +48,14 @@ or ``virtualenv``, depending on how your distribution packaged Python 3.
       on the Sphinx version, it should be installed separately,
       with ``pip install sphinx_rtd_theme``.
 
-In summary, if you want to install Sphinx version 2.4.4, you should do::
+In summary, if you want to install the latest version of Sphinx, you
+should do::
 
-       $ virtualenv sphinx_2.4.4
-       $ . sphinx_2.4.4/bin/activate
-       (sphinx_2.4.4) $ pip install -r Documentation/sphinx/requirements.txt
+       $ virtualenv sphinx_latest
+       $ . sphinx_latest/bin/activate
+       (sphinx_latest) $ pip install -r Documentation/sphinx/requirements.txt
 
-After running ``. sphinx_2.4.4/bin/activate``, the prompt will change,
+After running ``. sphinx_latest/bin/activate``, the prompt will change,
 in order to indicate that you're using the new environment. If you
 open a new shell, you need to rerun this command to enter again at
 the virtual environment before building the documentation.
diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 5d47ed443949..5017f307c8a4 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,6 +1,3 @@
-# jinja2>=3.1 is not compatible with Sphinx<4.0
-jinja2<3.1
-# alabaster>=0.7.14 is not compatible with Sphinx<=3.3
-alabaster<0.7.14
-Sphinx==2.4.4
+alabaster
+Sphinx
 pyyaml
diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index de0de5dd676e..4c781617ffe6 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -280,8 +280,6 @@ sub get_sphinx_version($)
 
 sub check_sphinx()
 {
-	my $default_version;
-
 	open IN, $conf or die "Can't open $conf";
 	while (<IN>) {
 		if (m/^\s*needs_sphinx\s*=\s*[\'\"]([\d\.]+)[\'\"]/) {
@@ -293,18 +291,7 @@ sub check_sphinx()
 
 	die "Can't get needs_sphinx version from $conf" if (!$min_version);
 
-	open IN, $requirement_file or die "Can't open $requirement_file";
-	while (<IN>) {
-		if (m/^\s*Sphinx\s*==\s*([\d\.]+)$/) {
-			$default_version=$1;
-			last;
-		}
-	}
-	close IN;
-
-	die "Can't get default sphinx version from $requirement_file" if (!$default_version);
-
-	$virtenv_dir = $virtenv_prefix . $default_version;
+	$virtenv_dir = $virtenv_prefix . "latest";
 
 	my $sphinx = get_sphinx_fname();
 	if ($sphinx eq "") {
@@ -318,8 +305,8 @@ sub check_sphinx()
 	die "$sphinx didn't return its version" if (!$cur_version);
 
 	if ($cur_version lt $min_version) {
-		printf "ERROR: Sphinx version is %s. It should be >= %s (recommended >= %s)\n",
-		       $cur_version, $min_version, $default_version;
+		printf "ERROR: Sphinx version is %s. It should be >= %s\n",
+		       $cur_version, $min_version;
 		$need_sphinx = 1;
 		return;
 	}
-- 
2.43.2


