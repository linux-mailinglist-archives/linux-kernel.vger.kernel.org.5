Return-Path: <linux-kernel+bounces-126392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD158936B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A240281E51
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 01:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB7323BE;
	Mon,  1 Apr 2024 01:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqK1ygLQ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF14E6107;
	Mon,  1 Apr 2024 01:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711934521; cv=none; b=I9Rg1KrpTMhdEfhF4rcMepKNUG1s/3nl9mPVVUVdr+9reRfprHBrR+ZV3nheL5TfRXBHprCjaWN4g4g3cml9Biw2xWssBEBCYhHEWjCK9jEEr/bsF7kndAglsTf414Lx8a+vYTyZ+QMzdAvBKnjR1zGIGXp4racL7lckud5c9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711934521; c=relaxed/simple;
	bh=pF8/O7G3JnB+p12JMdMYXn0IIFS7qvrYLMw3/h2CkeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O73D67s43kBaVOOis2kJhKXoC3RxOezJxxvIMBnVdQMXso4+3e/MljvVHkotYnWgT4347GfEWASwEiR1/e3vCPU6QaPqwhCF7iIIgBZCCX9VOoiycEyC1Wu9eGRKqu0rZS+jWfBA8ML58p8NSBD+0tinBV8YvYqkvnEGVFs2hX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqK1ygLQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eac64f2205so2942481b3a.2;
        Sun, 31 Mar 2024 18:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711934519; x=1712539319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ClrGnV7r7AvVPqLy+4xZZ8jmOxanrfAMR3Vk8uaHbU=;
        b=EqK1ygLQlA9FLAZXZvdBd/dWSQ3g+YoKrUpi+xwOq2vYKZpes9aAaB2WxlpKhl5aZR
         Bvfe5VkebpG+rx4Npp52LwivWE+d4YguWCIjDWBY5SSjOujHjP5G2okY5w446OACc/gu
         k77endW1eTS42yQD5UiJehdZF+nH9XcxCWOZXflIFSSYTA/TK6QDVFQgicFHGKSjI6vm
         XcSvi9uep4NyAfffhBM4m8YzKQEWcE+JU67DAaLO/2PxaQMnbJgr1dt9CTdrKp+cbID0
         uz39U9404xUpt0rM9a1h9qyS6uGov50hSx36rCyxqHA6o/3sYbwKjoYIqADPU2EOunx7
         XgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711934519; x=1712539319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ClrGnV7r7AvVPqLy+4xZZ8jmOxanrfAMR3Vk8uaHbU=;
        b=wvTWYpcBpMd2Sb/Nu3Yi9Rmd2MCliDD/H1oK4HczTDKjSOXx3Pl/ao+8zHfQ/kG1Vr
         lWLTI5HRgBbv0jRWR9TrWdgAXnk9sd7NY52KL0vYCMwBjd0zDeRBBGj7gkDQzqP2oEot
         F9+qdANoBXB6JLb5BTkbG505gm8ym8IhbfEJdtdlboOPhohDznC7pQMwK7h8zH757nxU
         Gj9LRnsJGhJ0b/l4HqLaTW/28pQ3rE2jFfvjVBIxPIAKzzvOAVouc0XCGsLDXihE8bGv
         9Q4oNxkIPyCIhs5Dnou1QVEqmvG4DVZGgkBtHe3zE88sug695Uy7Ef8hKm3Jj6Vujrak
         kvPg==
X-Forwarded-Encrypted: i=1; AJvYcCWIlAPg1RFqgLeWX6XRwSsZOn0jjcGbcRrAhCBtGrD09JofMKx63MRPhuZ/qRNJR1EKpMNjAtkkHEfI2nU2IFi2OMHFhi84YA6NJpCODDhoGeWIJUmkQOOLewQpL3OogyfdWEFQMsvFTdLpP+8/9iaG9kuEEeGRCIzOHqhphqadOpKZ
X-Gm-Message-State: AOJu0YxXtqF5I2zBVcttVEyhedUZfBPZp8hEtapqhMjXalu4J252kXHd
	Z6Nz+jSQcL3nCZfUAg1tj6TDA7XGyKSYfUqugo1beWyBozaw/qEM
X-Google-Smtp-Source: AGHT+IEnYGd3AWdwugZeaF+bVGLgmbGVHTTkemvlVARu8loJIMTNqPiBeBnEGYC+XN3O7VO82gK6NQ==
X-Received: by 2002:a05:6a20:9589:b0:1a3:ae50:16d2 with SMTP id iu9-20020a056a20958900b001a3ae5016d2mr8839288pzb.60.1711934519225;
        Sun, 31 Mar 2024 18:21:59 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902784f00b001dde004b31bsm7694357pln.166.2024.03.31.18.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 18:21:58 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-doc@vger.kernel.org,
	workflows@vger.kernel.org
Cc: apw@canonical.com,
	broonie@kernel.org,
	chenhuacai@loongson.cn,
	chris@zankel.net,
	corbet@lwn.net,
	dwaipayanray1@gmail.com,
	herbert@gondor.apana.org.au,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lukas.bulwahn@gmail.com,
	mac.xxn@outlook.com,
	sfr@canb.auug.org.au,
	v-songbaohua@oppo.com,
	Max Filippov <jcmvbkbc@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Charlemagne Lasse <charlemagnelasse@gmail.com>
Subject: [PATCH v5 2/2] scripts: checkpatch: check unused parameters for function-like macro
Date: Mon,  1 Apr 2024 14:21:20 +1300
Message-Id: <20240401012120.6052-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401012120.6052-1-21cnbao@gmail.com>
References: <20240401012120.6052-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xining Xu <mac.xxn@outlook.com>

If function-like macros do not utilize a parameter, it might result in a
build warning.  In our coding style guidelines, we advocate for utilizing
static inline functions to replace such macros.  This patch verifies
compliance with the new rule.

For a macro such as the one below,

 #define test(a) do { } while (0)

The test result is as follows.

 ERROR: Parameter 'a' is not used in function-like macro, please use static
 inline instead
 #21: FILE: mm/init-mm.c:20:
 +#define test(a) do { } while (0)

 total: 1 errors, 0 warnings, 8 lines checked

Signed-off-by: Xining Xu <mac.xxn@outlook.com>
Tested-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Charlemagne Lasse <charlemagnelasse@gmail.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..9895d7e38a9f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6040,6 +6040,12 @@ sub process {
 					CHK("MACRO_ARG_PRECEDENCE",
 					    "Macro argument '$arg' may be better as '($arg)' to avoid precedence issues\n" . "$herectx");
 				}
+
+# check if this is an unused argument
+				if ($define_stmt !~ /\b$arg\b/) {
+					WARN("MACRO_ARG_UNUSED",
+						"Argument '$arg' is not used in function-like macro\n" . "$herectx");
+				}
 			}
 
 # check for macros with flow control, but without ## concatenation
-- 
2.34.1


