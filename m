Return-Path: <linux-kernel+bounces-56371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0510784C958
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE351C254EC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809301D526;
	Wed,  7 Feb 2024 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="FGUIhpNz"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA3717BDD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304515; cv=none; b=N0zpygWX/mhAIa50H+GjtE8/W03xgubV3wiVfXmhsb8XC50bL1Pr61BI21LE5lH4ScOhP1BH4leUI3K5qC5ChG3wU8jf3yB5bjapVKF7e/tIUB0aqV21sZX99atPAdmenvW//Oz1ao9+MBcKvGHKtMw+J1laH7Fs+rweiZNiIzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304515; c=relaxed/simple;
	bh=L4fKG0W9QCT0X2dT1SwcGIU6xeGtXimyzjeiuRERXP8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A62zBL5piVYFhCK73A8zZ/3uhSXNw1FhfstjqinGCAYzmkm7cNchFp0dcyfSeHOIXa/c07C1GraDEuK40ue0hm4fP6QutY/BQqEhvRvV83sZkwrZ9KgJLT1kG0GzzKPni3IljdXYfbBk6B4w75IfQwH3/0YEH/O8Fdc/p/YtKpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=FGUIhpNz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so96648666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1707304512; x=1707909312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kKATkoha7MJRDxzx6S7MfwCz1BHDb7Q1gZGPDiWFQI=;
        b=FGUIhpNzNVu/nIwNrzfb4lP0WrLr7jKVajDTO4IVsrxKxdsco4lR1PyvsMXFwBCCuQ
         fOj++F5m6qIcOVbJFE0rY1PZwSIlf1d7bUQtXYuQ78uyBQFu4SrMj1ofTsUcJmlY6Tzs
         uA8Ohm/1XOkFxLKdA/+TrDs0iqfbummucUlQKv6A34nV7yLZCAeOk72ihO7w8P2sIGDv
         Rj5Kay84gjWmpX6EEO91nefdKhHWwLENRpyUS1dybZUNhBNJTqzzOORBrZHeZ54mpAL3
         GBE0IH2ueNBHiRve7lvC7ZYtkJXiGkkXrJG3cTANZ0ZpLWWqqReFXvf64eFXxxwZgi9J
         0Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304512; x=1707909312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kKATkoha7MJRDxzx6S7MfwCz1BHDb7Q1gZGPDiWFQI=;
        b=Z4qVE1hUGjYKuh7b/vX6eW/hLNaCdI5DsmG8FTsP6BUhxYzJ0IzxrJDCqFjDMZ98t/
         f3LwprK95qxiCnLvEgRVokYDOjOIYmAP0cZk2spwf02ObfoaB6kVNSyeEEu4sKzdqbSk
         dz96d6Vt/FVmqSrmNwTAGIAJ6S8ZQF059AnUfDFTv2auGnu0yckudZcP68Q02k8Lhn4v
         rTWoC95dP4JiGvRiWgOXGH78OFo+M2JH35ILwHe+OIryoPqnfsF7riSqdK0g2jBwDXVb
         jOQwudBjFI15x7HM3OaIQzCMK5lhILzY3EVyOAVLb4LjNsBpBkzc3k82gihs3lTV26qs
         CEfg==
X-Gm-Message-State: AOJu0YyfLkBYu8VVQgtaay0zpF8xnlvYJWCaN4Ss/igENwoXH7mLDsqY
	G6eZWBSmVUnHwmZKf2llhkiVdLGpmiPMtfOPVoRNr0+l35MASVoQzbd5GfwYxgR+jSerLWbubuo
	baqY=
X-Google-Smtp-Source: AGHT+IELucIYpvpq6yvldLKzzMl7hr7qQWu1CVhHomilrr8FmzMLpe3QGhBXG96a/dz5LtvRPv5QDQ==
X-Received: by 2002:a17:906:168e:b0:a38:1a75:787d with SMTP id s14-20020a170906168e00b00a381a75787dmr5440517ejd.24.1707304512048;
        Wed, 07 Feb 2024 03:15:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfcOTVEdJD27+JGCOb6HJiNpAh4UIv/nTV2Whv2SEOhsaFVOroeAlbiT9JJWY5qvRb95M97X/OENJI+G2eAIN2E4eX4SHZUgotJpzkIpgRFW1y6Jwh9Are7yqozY+7dWUvVAqvANkHOOM13q6SFqrbgtyZWv50uGzpNw==
Received: from debian.fritz.box (aftr-82-135-80-180.dynamic.mnet-online.de. [82.135.80.180])
        by smtp.gmail.com with ESMTPSA id ty13-20020a170907c70d00b00a338fedb9ebsm650975ejc.54.2024.02.07.03.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:15:11 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] docs: scripts: sphinx-pre-install: Fix building docs with pyyaml package
Date: Wed,  7 Feb 2024 12:12:37 +0100
Message-Id: <20240207111236.7242-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Python module pyyaml is required to build the docs, but it is only
listed in Documentation/sphinx/requirements.txt and is therefore missing
when Sphinx is installed as a package and not via pip/pypi.

Add pyyaml as an optional package for Debian- and Red Hat-based distros to
fix building the docs if you prefer to install Sphinx as a package.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 scripts/sphinx-pre-install | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 25aefbb35377..7905beab3359 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -361,6 +361,7 @@ sub give_debian_hints()
 {
 	my %map = (
 		"python-sphinx"		=> "python3-sphinx",
+		"pyyaml"		=> "python3-yaml",
 		"ensurepip"		=> "python3-venv",
 		"virtualenv"		=> "virtualenv",
 		"dot"			=> "graphviz",
@@ -395,6 +396,7 @@ sub give_redhat_hints()
 {
 	my %map = (
 		"python-sphinx"		=> "python3-sphinx",
+		"pyyaml"		=> "python3-pyyaml",
 		"virtualenv"		=> "python3-virtualenv",
 		"dot"			=> "graphviz",
 		"convert"		=> "ImageMagick",
@@ -955,6 +957,7 @@ sub check_needs()
 	check_program("gcc", 0);
 	check_program("dot", 1);
 	check_program("convert", 1);
+	check_python_module("pyyaml", 1);
 
 	# Extra PDF files - should use 2 for is_optional
 	check_program("xelatex", 2) if ($pdf);
-- 
2.39.2


