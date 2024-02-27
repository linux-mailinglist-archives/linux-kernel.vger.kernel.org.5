Return-Path: <linux-kernel+bounces-83297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B00869181
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B11290FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C811613B791;
	Tue, 27 Feb 2024 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bToqdiQ2"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0113AA2B;
	Tue, 27 Feb 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039697; cv=none; b=eWlZOUGz74q1oLIL9UMGQARWL59xsjwr560EpuQ2WeEyHh6qGIiVz4x7enfFnBjzSjhWPQ20T0vFWbs2rpGqTBj59r/ZN0jN5MhBf78YppuBcLjtNGX/VTyYq4aEZhWMoIzJ7u9DlUzDpB6aLK0u4ZPBXvoSlTqPQZb5atqyJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039697; c=relaxed/simple;
	bh=NJNXI+K3JHWpjNDnBECTCpd1UuaOUMZ/inEaVKjUMxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UP2KzJ1UR8U+rK5CyW76d4tSckqlzzcwAU9FEqpdugYmpto42wndyTabgSQTaWcQMKJUtXnCGFrNPJm2U0cMPN02c9Z2PgVeMVfiXRGuUjmqEv5+XXDqWhcJLs0Q1PJosICokv10xfQ1WL9x3Mv1zn7j89JkYgs4l0I7APYSV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bToqdiQ2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e550ef31cso480847666b.3;
        Tue, 27 Feb 2024 05:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709039693; x=1709644493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t2pGOKrAqj7OeT3MchT4Kc1lyx+483hvEbxm3Ejyu9c=;
        b=bToqdiQ25F+2xGzmpKqB1/GlkJ+/QMnVpEjj3eGROO2sMwuFODQkM296h5YUIZ5WL8
         V9FbKSYy9YvIe++oyv66hgqeUFnydk6vVADUIu5VklAlRMI+xOTWk55pmurjyRDe9X4I
         CDKMTgIrvhGo5pNvryXuemU0qw1ZE9oLJuVnFDp6HYgv7Gy5nkXPEPshtIzpIHSgm0gn
         mKBG25pmY2YcpsiSBuL3FBVIOlNJCNfku/gZOPmy6ouzpTSgS+KT3W/Na8lqYwfzpFIV
         PA14cvsJFFBHvlyD0CatOSOmR5BXscctRFm87plMGGjT+RITk2flr9dlrXX9Z9Jp5DIO
         RseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039693; x=1709644493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2pGOKrAqj7OeT3MchT4Kc1lyx+483hvEbxm3Ejyu9c=;
        b=abJmfi1TYC6RctlkBQWDKGgihFaDKKduLk+ZBaRly1OgY66zqx4fLRgqunKhUI4WVB
         7dvLvRqrYRagBJD/h/3K/oDrlM/pz/5Rsw45iRtSn52L0st5HTYZ5cUPKDvSSpPievi4
         J3QHm8QtJUcsskRLA5W8uV4L3Ktt0IbkvtvXTyjlUyWgxvrcnbajWEidwJtfH3PDKFci
         4I5BK9s/zD5ZhWe6nys1SM50zQdpICX2LLcYM0iVSI2Y7TczZcLwcTb96Dy2jaVtwQOX
         3ig6j3lsjuwWAyNUypW9idkvEs68sR95BpTUJ50U/XIZG/kMbWy9aiWLtSnl/yLC7/YB
         g2MA==
X-Forwarded-Encrypted: i=1; AJvYcCVwdflHjeHOtXhVLBLpDZ4i5fVRKV/XDchWnDa+QKl4hwmfPucacPBfnLqxSnop1qZ41nWwS3Eecfn/5V/O/bA7hINav2tCTl/I
X-Gm-Message-State: AOJu0YxNcZV7axpCNaOCeGWfUul9YootkZTEWDi7EXXmFNG3Ufz2tvNZ
	Z2FCCqPV5UW1D4xybrjfMewGF8uQAQpyciJ5dTIAq6XMJtS7vdOuQs0RAKDN7eU=
X-Google-Smtp-Source: AGHT+IFLwwFsptDyZtJy5UYi91r9lc64KxsgXBxKVSpRNTPSwAtLZ1fB931GcwyG4HnDgliqI3WdYg==
X-Received: by 2002:a17:906:ce36:b0:a3f:4fd7:3cf5 with SMTP id sd22-20020a170906ce3600b00a3f4fd73cf5mr6324320ejb.17.1709039693265;
        Tue, 27 Feb 2024 05:14:53 -0800 (PST)
Received: from lola.. ([2a02:810d:7e40:14b0:d371:e319:5dd0:9b35])
        by smtp.gmail.com with ESMTPSA id pj11-20020a170906d78b00b00a42ffa7d4cfsm760600ejb.88.2024.02.27.05.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:14:52 -0800 (PST)
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
Subject: [PATCH] docs: drop the version constraints for sphinx and dependencies
Date: Tue, 27 Feb 2024 14:14:10 +0100
Message-ID: <20240227131410.35269-1-lukas.bulwahn@gmail.com>
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

As first step, drop the version constraints and the related comments.
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

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/doc-guide/sphinx.rst    | 11 ++++++-----
 Documentation/sphinx/requirements.txt |  8 +++-----
 scripts/sphinx-pre-install            | 19 +++----------------
 3 files changed, 12 insertions(+), 26 deletions(-)

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
index 5d47ed443949..1f3b98eee2c9 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,6 +1,4 @@
-# jinja2>=3.1 is not compatible with Sphinx<4.0
-jinja2<3.1
-# alabaster>=0.7.14 is not compatible with Sphinx<=3.3
-alabaster<0.7.14
-Sphinx==2.4.4
+jinja2
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


