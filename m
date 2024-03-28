Return-Path: <linux-kernel+bounces-122325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B583488F539
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B771C24968
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88E928E22;
	Thu, 28 Mar 2024 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8iGeo+M"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB1D374D2;
	Thu, 28 Mar 2024 02:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592526; cv=none; b=By9fjua5tHn+1PDqd6uLMldYNHYkdCDM2WWoURi5dNJ9Wn9tEkZYF2wmtwpYMSigly5aampqQwaHifVEohil1qOC3yCZ6k1xwuymzXAgEugd7ScyObR8lhyi6wP5/gK/IivOYel3EGuhZbT/02L4EG2bp1i+TNDA+Tps4MINBCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592526; c=relaxed/simple;
	bh=/eLhb9Rg4nh9yNL4iwlTn1l8Pyav0reD3p6fibEz1d8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AribWiBZA3eBz0MVeVF+QkfbNU/fb7lRMJ3Jrfec6JsVf1fxn7/66mdGxKLirIag999XqvJeZ9EJllvHHqWao6OFDiek0gMMlyQkaUeawnT0YsEKWsFYOSZti8BiTgLsZEc9UMmpLeO+CsVr+q00SqliabKZ9rh+XDo5DGsI3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8iGeo+M; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-222ba2a19bdso267647fac.1;
        Wed, 27 Mar 2024 19:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711592523; x=1712197323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJKFKvTWiQ1ylayITMd1pxJyaQfArgqbTI5DSxcGrbE=;
        b=f8iGeo+MnS8W2a21vGPo96OCc+bZwI+ZmmXjd6BvjSw/Z9g8pfF8GQku4UBTywxzCR
         eBq9j+6Y1CIIATJWDFIibRG9dfl+12eTwCNYIVnscBMFS+YVrMoSjAoGDBHIOXUXGsbh
         OXiu5b4UQG4PBwMMXdZVC1DqWJFplhOFhEfzaRvgn/qlsXUf6oNkMAUhtNvTGLn2w6B/
         cbcAV9e97rCmgefxkDRHJOv8C8DW+S7yaggflHK1w5kmxcdFgjode/kBnn9Xen/P91Q/
         kUfYK2uwmkUFKujZveNZQF7Uz0RtwotWLU/SmASRMCaU01r5RDIj6NRVEf99VgF0tx3f
         s3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711592523; x=1712197323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJKFKvTWiQ1ylayITMd1pxJyaQfArgqbTI5DSxcGrbE=;
        b=ILIqTKCn14mtPzNpktJwXulJkIgyBGMhr5uFhffsykqTYPCCjwXQcgfuWmk7iapcqV
         ujfPClZE1chv5Atumz6G8gSkX7f4oHAVfViYP4oyDkfGSV9GnQy3XFB6V4sRTK3ZPq/k
         4kKvI7Ykuavp0Pv41KlmykUOZrNwXjvUTWPynwrhXe5PG3tqlnOnZ54AdcofE4Cj+b+r
         xr4rMH5v88Vj7Z/6iPcN6XHjnUU0RGL1yJPxCYlOPoaeJ+329f+iQQrSW6GIoK5rJDDA
         UchM/v8LiHua5kSTxz180m8KotP+NSMqShucg7PvEiF2A9gAC9C7cfAGvclSLeVUtX9/
         r6+g==
X-Forwarded-Encrypted: i=1; AJvYcCWZUv26bg4nDgGgl2IPBPICKyj9HnizghLSqUDerXTI+oZhpPlwv/MX/cljwQesOJMKe0VzMin7uyfaVibJmnH7MK2mEWATxcETWn9IhpL828koWWbHxfS5QikB7XFTINeHuzHsNk8AXVUrCBwldeMzPlhzWk0TOE+yGqP70ePNeHl1
X-Gm-Message-State: AOJu0Yy4ALOmK/Uoy79uV6rXNv93PA2eoNqj0n4mUbHUyZECIjv5nSNL
	fJVM1R39tT4VEPSemXeHYKKMXNeYgQYUaotMobTqsYVDr/9xbHjv
X-Google-Smtp-Source: AGHT+IG6vBI7mFQMTCRkMR1DgL0LU5ekXVqi3z1NUbDX1byFjVV13DxPVWJQAAHxY3Ul2lejpzlYyg==
X-Received: by 2002:a05:6870:c0c8:b0:229:c1b3:db51 with SMTP id e8-20020a056870c0c800b00229c1b3db51mr1459496oad.47.1711592523713;
        Wed, 27 Mar 2024 19:22:03 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7869a000000b006eac233f5c2sm228113pfo.127.2024.03.27.19.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 19:22:03 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-doc@vger.kernel.org
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
	workflows@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 2/2] scripts: checkpatch: check unused parameters for function-like macro
Date: Thu, 28 Mar 2024 15:21:36 +1300
Message-Id: <20240328022136.5789-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328022136.5789-1-21cnbao@gmail.com>
References: <20240328022136.5789-1-21cnbao@gmail.com>
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
---
 scripts/checkpatch.pl | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..bcb886014d60 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6109,6 +6109,36 @@ sub process {
 				WARN("TRAILING_SEMICOLON",
 				     "macros should not use a trailing semicolon\n" . "$herectx");
 			}
+
+			# match "\s*" rather than "\s+" after the balanced parens, as macro definition with arguments
+			# is not required to have whitespace after arguments
+			if ($dstat =~ /^\+\s*#\s*define\s+$Ident$balanced_parens\s*(\S+.*)(\/[\/*].*)?/) {
+				my $params = $1 || "";
+				my $body = $2 || "";
+
+			    # get the individual params
+				$params =~ tr/()//d;
+				# remove leading and trailing whitespace
+				$params =~ s/^\s+|\s+$//g;
+
+				$ctx =~ s/\n*$//;
+				my $cnt = statement_rawlines($ctx);
+				my $herectx = get_stat_here($linenr, $cnt, $here);
+
+				if ($params ne "") {
+					my @paramList = split /,\s*/, $params;
+					foreach my $param(@paramList) {
+						if ($param =~ /\.\.\.$/) {
+							# if the param name ends with "...", skip the check
+							next;
+						}
+						if ($body !~ /\b$param\b/) {
+							WARN("UNUSED_PARAM_IN_MACRO",
+								"Parameter '$param' is not used in function-like macro\n" . "$herectx");
+						}
+					}
+				}
+			}
 		}
 
 # check for redundant bracing round if etc
-- 
2.34.1


