Return-Path: <linux-kernel+bounces-23381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A245182ABDF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CFDE1F239ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66EB12E7E;
	Thu, 11 Jan 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgGICmU9"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADDE12E6A;
	Thu, 11 Jan 2024 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6daf9d5f111so3734312b3a.0;
        Thu, 11 Jan 2024 02:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704968618; x=1705573418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/5USLJE6jP3W3udMwPApQUbedGt1RcPBYyRyqph8pY=;
        b=YgGICmU9HzoW2xYwgRmsbO0ICqpol9hJXncYqhEeen5JHqJXCLU4MDPvmo73of6uvR
         IlMSlmV1yh+coVs3dnjLDo7Z1hd5BWNBqerHO9XgMEon25k9HTU9Rv5viceT4i4Z93Oq
         zKZPm4EPC7UCV9UcOHxLcg7LwduSnslRSJ5oDOnhbFGLT+g+EncwYLIGhHAcphdeVpJ4
         vdmtQWdoLuMpbYNEZfyrT3V70pvY/X9Oo1t4W81Eh/mnUe4uk7hYqVnegNrvZ/Uu8g6c
         WxreOIulae6Nl/7aEmXuuGeoAOfG4oATV8K3Q7msEafQDbOup8Z2/hrn1B82oFK1r54e
         6oMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704968618; x=1705573418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/5USLJE6jP3W3udMwPApQUbedGt1RcPBYyRyqph8pY=;
        b=gwVzGAeitqevfQksHOinhTA41KRD3aCx1PAcuTwbBCSej6xZVDjhgnJVIwVkKqjTzk
         XfDUHTTenQWZ2p2ElROTUYeo1tJO96+IBsojBUvwC3l7SQGfokVDfsY9Ts+9BvCwYZ1v
         pAj1JRFJjNTjrRN231mqo3S3CphVvsDAnL6r+2iLEe+KkWv/iP63H/Tf8QUkY/eoIkvO
         8mEyOa7JdrQrOZPh8hTxwgfadah4LO4cmcsrr0yMkbdwl8FdQYGXYlCcmPuWnyHc3m4s
         p4PGI0nZM43uFAiGu5OqAwQRCFIjnpxr/V4Iw2wjUpGhYLhp7A+AIYGQbcTh3a7CCeg/
         qAIg==
X-Gm-Message-State: AOJu0Yxp7YDNDqeQXNjLo5lXl4FXur0r604Gs3mcvDu6aMF+NN1BNTgN
	Igc69s5/5ACHky2/xbIzzyZUeK7uomg9Xw==
X-Google-Smtp-Source: AGHT+IFtjvm/MOzOOYRpD5BG2eD85QMivamXoma7NTGscRK+bbRddPxERWZbeiamtFGwt2t+PR1ZaQ==
X-Received: by 2002:a05:6a20:6a1a:b0:19a:4b6c:fe31 with SMTP id p26-20020a056a206a1a00b0019a4b6cfe31mr1014096pzk.1.1704968618186;
        Thu, 11 Jan 2024 02:23:38 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001d4c98c7439sm822641plg.276.2024.01.11.02.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 02:23:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 184951848A930; Thu, 11 Jan 2024 17:23:32 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Attreyee M <tintinm2017@gmail.com>,
	Adam Turner <9087854+aa-turner@users.noreply.github.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: sphinx: Require alabaster <0.7.14
Date: Thu, 11 Jan 2024 17:21:31 +0700
Message-ID: <20240111102128.37192-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436; i=bagasdotme@gmail.com; h=from:subject; bh=9FMMpdqk6pZiLm+3iFwjQCi3zP+CvYNoWtNjkctEo00=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKnzD4hvlWKyNkie4Hf4quvDGey1HQxycd9OH9TZeaLpJ FN+0N41HaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZiIjAHDP/3Pm84lv9T8vyrs 36XTOyZvqs6X6StV6y++LH5jUY7xypcM/xSusGfydfvpNZxZKbp8Y8kBE8F6lizfj7POBRbX/3v DxwAA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Alabaster commit 640273fd3ca7 ("Drop support for Python 3.8 and
earlier") [1] bumps minimum Sphinx version to v3.4, which breaks
htmldocs build due to version incompatibility with Sphinx version used
in Linux kernel documentation (v2.4.4):

```
Sphinx version error:
The alabaster extension used by this project needs at least Sphinx v3.4; it therefore cannot be built with this version.
```

Fix the build error by requiring alabaster version less than 0.7.14 (in
other words, at most 0.7.13).

Link: https://github.com/sphinx-doc/alabaster/commit/640273fd3ca7cdc1528c591172fd9cce2ead911c [1]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 I'm noticing htmldocs error when trying to build current master (still in
 merge window). Is this patch OK for 6.8 material after v6.8-rc1 is released
 (as stabilizing fix)?

 Documentation/sphinx/requirements.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 335b53df35e22f..b2ca7432437518 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,3 +1,5 @@
 # jinja2>=3.1 is not compatible with Sphinx<4.0
 jinja2<3.1
 Sphinx==2.4.4
+# alabaster>=0.7.14 is not compatible with Sphinx<3.4
+alabaster<0.7.14

base-commit: de927f6c0b07d9e698416c5b287c521b07694cac
-- 
An old man doll... just what I always wanted! - Clara


