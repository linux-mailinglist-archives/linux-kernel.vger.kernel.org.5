Return-Path: <linux-kernel+bounces-58281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB1684E403
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB841F27C25
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BDC7B3FC;
	Thu,  8 Feb 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="meGLZBXG"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953A776C75
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707405896; cv=none; b=YTluRDXN/u4A2Bv6MkJPKSmQNjNxP4Bm8pEm1zymC3MxFcCFVMGC0/dVUwY9Yp0z6c5+o8wXeKl/2tYHiJoEkAjoUziqKHIkhYNkoO+/xolyfDDpdmGoL/I0oDG5PvGWSXJfUV8jK0vmdpen17pkqx0nMy5NkYCAlq2yTbXqEp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707405896; c=relaxed/simple;
	bh=kAOIuWlwovzhjk3AgDdaNyJxXE1rLS9fIf9ZEx9VMjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kJ+ELZR9VchwmFipm8p6uVQXOtg+YGbe5tGKWZWC3bQ4Z4NO/nKkIZB3olwJqmoeTxqKCm3y1imGKhNncgDfycwFd27+ZT5K0izIjTUcaokti0tjfihIR+dS6D70RfMwnHDgDOT2XW7hx7uo5wRnbC/Z+wfwsoaZ9s+ruQGc8sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=meGLZBXG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3122b70439so262426966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1707405893; x=1708010693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlC2lhzngOyeafJ48Z4cKb3VJi3sH6uOejDd3gD5xnI=;
        b=meGLZBXG/DbQqOnS2e89RiIuf/EE8lDBwa2ZdGBoOQOqBQrD5LI2kB747PCY/RaWKI
         /rAJqd7hSTdabi+2LovHVyPfF3GDYc5hGgMhdfscFdq3Miz7j/VbQHxYeEeyNWKxf2Em
         3WrqWdMrZvPqCDl9XcCO/kawwP108Ft53AYSfGfD18jVSY28sAGrtdPsjVGgZErxcUmc
         czuauihsw4PRm3Fc7zuLRokJXpFeDbvsp1FJT9THMDKIDz6mkdLAAktHL6xnsJqItNcF
         XI10jhVQdKSq4xrHGg7lN7aP1/1FsmhXNxqBbcC/4rnRdkj7U9PIx7eeT0l1WvOdLTnV
         yZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707405893; x=1708010693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlC2lhzngOyeafJ48Z4cKb3VJi3sH6uOejDd3gD5xnI=;
        b=lwOxDqNji7Cjbb2GnNdeLZdWn1Vrd69z1MLS3XQdc/R4jl984CL+k6uf5/NF4oryl1
         k6lTl1FuY+gihtn9LFlU69W7SA/swajT+JEA9JlplYwhkToMASJq/V1wEygab1IqYp7M
         GcrW45tI8XP5oFg6fy+7ng3qTU3NIJXUSflz+S6C5ZYWzbG3XVyrBaLXyg56YA8UrRQW
         Ta/pphuabQ6TKlwXmxkTkfbP+7oVvyE26wDVWICLMF4Ycemv4E3R839Sr3u3eIHiz73u
         G5sbPJktliHBM3rWQntXAobVbiPxVmPYvofUCGDWA3i1dpUgvBjnNbBPyeGycKPZaYZj
         FNcg==
X-Gm-Message-State: AOJu0Yx3L2F0JbAiGFqc50GhPWS6yXtWH2BnqxQ0zKJUmFQbW2azH/J8
	2DeIn9xUa2ejRiP3Qs5GqBHTLqBW4wgooRDMjuNlVRIt4PXjSBm+6WP1VpTLzFsnVCL1DF7OmPr
	kLz3WuQ==
X-Google-Smtp-Source: AGHT+IG9IjcQZfVwTrZS0u/E1ebQvET8jEiFldZ8xlY1mor7GtxKiiyGjhmZKyn7ZlW9NL8ZuY4JSQ==
X-Received: by 2002:a17:907:7856:b0:a38:3ec3:9379 with SMTP id lb22-20020a170907785600b00a383ec39379mr5294511ejc.44.1707405892723;
        Thu, 08 Feb 2024 07:24:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQ8IEO6JZFgmRiIonq1XkvroWEyaaxaFIO/nHSPzEN/V53OUkgjD9/IgkmuZOSa1S3NZCky5sIX2VEll/4k4vWQHeZuAM6/JweicEBanitnNSbsqO+ChWSVFcM9uo0LgSjdRjXss50TKrG4/9QVlidITHf3mapmm2yQvbDZ2HW2LLSf5dC3rdPSh/aS5uYPd81vTCPnPDkGNDi1QjwcjU8
Received: from debian.fritz.box (aftr-82-135-80-180.dynamic.mnet-online.de. [82.135.80.180])
        by smtp.gmail.com with ESMTPSA id a24-20020a1709066d5800b00a3bb2156f7asm147155ejt.185.2024.02.08.07.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 07:24:52 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] docs: dev-tools: checkpatch.rst: Fix grammar
Date: Thu,  8 Feb 2024 16:20:40 +0100
Message-Id: <20240208152039.65293-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- s/exists/exist/
- s/maybe/may be/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 Documentation/dev-tools/checkpatch.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index c3389c6f3838..127968995847 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -168,7 +168,7 @@ Available options:
 
  - --fix
 
-   This is an EXPERIMENTAL feature.  If correctable errors exists, a file
+   This is an EXPERIMENTAL feature.  If correctable errors exist, a file
    <inputfile>.EXPERIMENTAL-checkpatch-fixes is created which has the
    automatically fixable errors corrected.
 
@@ -181,7 +181,7 @@ Available options:
 
  - --ignore-perl-version
 
-   Override checking of perl version.  Runtime errors maybe encountered after
+   Override checking of perl version.  Runtime errors may be encountered after
    enabling this flag if the perl version does not meet the minimum specified.
 
  - --codespell
-- 
2.39.2


