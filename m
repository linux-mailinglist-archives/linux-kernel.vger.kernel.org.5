Return-Path: <linux-kernel+bounces-19676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A374C8270BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F1B1C21AAA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F8A46556;
	Mon,  8 Jan 2024 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PthVjibB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903E14653E;
	Mon,  8 Jan 2024 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2ac304e526so73298066b.0;
        Mon, 08 Jan 2024 06:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704722939; x=1705327739; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2EOn2knNw0bvrkSkgIL62dU49cbdZaKI+b3bXf9BYw=;
        b=PthVjibBjlBHhoB8FFEHlQcLstjrHxTPmCzdBP4w5O4Xv9f2kdRAQoPaFubY7hdql7
         YzW74dq7+v9Mj5BRpwH23vD7zV9Fp3WofmbeexsT+V25SbCuap8A97eRLX7R+tB6sOJj
         d5UDOmDUfoU+/PScUjDTBmhlsAdk7AyBptrJTeWPthmTEWd7edXsM2l9qOQbnNHzXqGg
         qbL7N4A+ri8AmU7GeRZNxl8455nzymDmqEph+Fm24UyKSSfT5bGtVN1ujdNTkAdfcoAS
         T9cygCxWhEZQaV9pljifW/E9PBofysfw49NKcCDS51LuJ1CPDShID5GpwtiKGRIc9JHe
         sVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704722939; x=1705327739;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2EOn2knNw0bvrkSkgIL62dU49cbdZaKI+b3bXf9BYw=;
        b=DSAZGSZBodxBJro4HJusTzk1hVudbN6WDGEeM8OtX0MOzLPfgZPtePONGlTat1Wtv/
         0nwAFeufroj201qq3kenp4oSPM0Inu+VsXFo+w6vO9L+EUIjZM1YgXGY+DHS29XkVaen
         iTtNdlobcXmMRISS0o9tLGeT6kNmH6naGCNn3hSHKgEOGNBORS21hRjuSCgLBawO1UJ0
         PCBbMWE1X7Rl9mKKl3efRK3gj8/HT7tJpzMVYjMLJ/DlxNMB+6sYjpHRFWz5iK1ZEYN5
         y6yRjFP/HbuupEdXqky286uLg6PXUfNMfzSv8gxmEGaqd42439srd2wevMW8p9YaNSLb
         ZAiw==
X-Gm-Message-State: AOJu0Yw7V98iTIR6Hn2nLF7d6sQGPlssvXZTZo0wXxC33iAM1Azm7azl
	ttodAJAbRfFB2Do7KuUD1M3/eh24JIc=
X-Google-Smtp-Source: AGHT+IEJ0xyBDc+Nf83Pegqe0DpclFanViMkyAJ9aQ6k42VsEMBxK0zYXWPWFbGYmXy1Z78vtqXv0A==
X-Received: by 2002:a17:906:b045:b0:a27:a99a:a5e3 with SMTP id bj5-20020a170906b04500b00a27a99aa5e3mr1398130ejb.138.1704722938417;
        Mon, 08 Jan 2024 06:08:58 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:a060:7056:782e:5e26])
        by smtp.gmail.com with ESMTPSA id ad21-20020a170907259500b00a29beb20353sm2858834ejc.192.2024.01.08.06.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:08:58 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Elena Reshetova <elena.reshetova@intel.com>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: use tabs in CONFIDENTIAL COMPUTING THREAT MODEL section
Date: Mon,  8 Jan 2024 15:08:52 +0100
Message-Id: <20240108140852.20533-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 1f597b1a6ec2 ("docs: security: Confidential computing intro and
threat model for x86 virtualization") adds new documentation and a
corresponding MAINTAINERS section. It however uses spaces instead of a
single tab for all the entries in that MAINTAINERS section.

Although, the get_maintainer.pl script handles spaces instead of tabs
silently, the MAINTAINERS will quickly get into a messy state with
different indentations throughout the file. So, the checkpatch.pl script
complains when spaces instead of a single tab are used.

Fix this recently added section using tabs instead of spaces.

Fixes: 1f597b1a6ec2 ("docs: security: Confidential computing intro and threat model for x86 virtualization")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa67e2624723..c76884e40434 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5296,10 +5296,10 @@ W:	http://accessrunner.sourceforge.net/
 F:	drivers/usb/atm/cxacru.c
 
 CONFIDENTIAL COMPUTING THREAT MODEL FOR X86 VIRTUALIZATION (SNP/TDX)
-M:    Elena Reshetova <elena.reshetova@intel.com>
-M:    Carlos Bilbao <carlos.bilbao@amd.com>
-S:    Maintained
-F:    Documentation/security/snp-tdx-threat-model.rst
+M:	Elena Reshetova <elena.reshetova@intel.com>
+M:	Carlos Bilbao <carlos.bilbao@amd.com>
+S:	Maintained
+F:	Documentation/security/snp-tdx-threat-model.rst
 
 CONFIGFS
 M:	Joel Becker <jlbec@evilplan.org>
-- 
2.17.1


