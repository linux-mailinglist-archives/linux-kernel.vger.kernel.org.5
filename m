Return-Path: <linux-kernel+bounces-111161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E28886884
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF3B1F21390
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2266C20DD2;
	Fri, 22 Mar 2024 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvVuvld4"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96291B277;
	Fri, 22 Mar 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097408; cv=none; b=p94Zt7Dfb4ZLcxxir6JbqdVZzeY/Viv8DiQi1BgS61ZzTKtCanPN229GldS1nnHvSDr96Wc1m209/IcJr1UH7CMPJpJLJV+QhDZvc6C5VfoIDc+SPTkAAD1dLRaC6vGiBxTL/lNI9UVH8zDKsCPeJRIKCQfm0imDD3RTyrr3yJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097408; c=relaxed/simple;
	bh=U9JfB1zvQO1sWnqC+teAftUQyKNdZFSLzpoIHEeAvGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3ey5xsQfVDdvnBjZg/nIO55VKvC4S5x1H6VcuzTnwqDhvEfykUL5wbZkYgcq//n1cGQltVGYLSdoNw30Hu2+5KY+V2Vt0eC+Mcu0VmN27phulSo+NKXQI8achb0h2hugTjPun/pll1lp7oHUnLhe0SoF/4cA8fCkUReXrXdnr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvVuvld4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e04ac4209eso16134575ad.1;
        Fri, 22 Mar 2024 01:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711097406; x=1711702206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQPV7jUa05dU9iEMp/1ytAeEWTIcwBktdRO6vcJ++jM=;
        b=bvVuvld4k82mKpuepUJOYBglPOV4ZtQNoUiZnOwGDJBhOIiF/jr8Wkabk0MO3+CURx
         REnqFBl/d4mwUfLiAWGM4YhVXdJSKrv8rWKe4rIvsvcsxar3xwx+9TCJzBpuDJnYfv1n
         1W99R5WviEnsH/QPjcx5zfbHxiytH1gosxTg3tfSvm85H4AxGmtsugaioZOlicK5o7BO
         yybb4Z0NsVa79lUn/7Awzud0xtYTc8iQOyDglIbLBKWUm0lBftX5iqH5oUVMz7qRbmhi
         AdkCovW+cd6JfF4coinaWtrr9J72lTqpGR2z8Ur4g3XQoVKakwMOHoUVQQWHvb82E7OB
         FEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711097406; x=1711702206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQPV7jUa05dU9iEMp/1ytAeEWTIcwBktdRO6vcJ++jM=;
        b=wmUNBdYAFX0Y+v5/RwCi6xOKAcQmmWjbWzCo1LSl5uHDf9lYT9N35qqH1qYYk0Ka83
         JhmB9Ykn8ppCYKKTkQBCTH4sQnDg3+r5cVTBUUrOEdXBxHC3kmxWjgSx9MPhzhaNunzX
         mqYHuBi490SNXTx5VSYP2rqoPpxVZvcRwaTDV47jfoWx3ojcxowIQ3nF1ZHxPHQmOuNk
         6ZF0q13hEPyjVW8SFsyvXuGQXPAFZxRdDyUDuRLu6b4zUo+E1C+dPgnkb88m3y12+jqw
         0S3Pk5PlyuyCPd+mX7j8z3iPHkXzWGx6MITk7DNLjgHlGDumJXJ/vv/IsYgNzLqoH24P
         NbYA==
X-Forwarded-Encrypted: i=1; AJvYcCWlfdF018QLShzu3vs7Ded2w3okQcktujr5uVKr1ipwSX5T6e3HcCAiAYu9JjvsIodVGCj3RX+f6wi4hhREXSfQtEh3u+buNpilLEsOgwC7TxopfC1ozSVJSHJBnmx4EJm4hm0J
X-Gm-Message-State: AOJu0YwAdfHJ9Hp+xHWakDt3/rIX92qj4J2a0uWxwhj/3072Z3JBMT5/
	4ujA9zp+Ub/l0EKkCioL1Bo6lr+fpyQ6p5hzmuctRQkfqG1mqu1n
X-Google-Smtp-Source: AGHT+IHaLY2PUDsp7RYl90sQQ2ebshPFnPejDPXg9sP1nM/Tb50mAgFOwo+CJmWObpJ6Ots5cmGUTA==
X-Received: by 2002:a17:902:ce8d:b0:1df:ff0c:cccb with SMTP id f13-20020a170902ce8d00b001dfff0ccccbmr2177547plg.53.1711097406131;
        Fri, 22 Mar 2024 01:50:06 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd5a0a20d6sm1328165plf.287.2024.03.22.01.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:50:05 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: corbet@lwn.net,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Xining Xu <ma.xxn@outlook.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Zankel <chris@zankel.net>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Mark Brown <broonie@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v3 2/2] scripts: checkpatch: Check unused parameters for function-like macro
Date: Fri, 22 Mar 2024 21:49:37 +1300
Message-Id: <20240322084937.66018-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322084937.66018-1-21cnbao@gmail.com>
References: <20240322084937.66018-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xining Xu <ma.xxn@outlook.com>

If function-like macros do not utilize a parameter, it might result in a
build warning. In our coding style guidelines, we advocate for utilizing
static inline functions to replace such macros. This patch verifies
compliance with the new rule.

For a macro such as the one below,

 #define test(a) do { } while (0)

The test result is as follows.

 ERROR: Parameter 'a' is not used in function-like macro, please use static
 inline instead
 #21: FILE: mm/init-mm.c:20:
 +#define test(a) do { } while (0)

 total: 1 errors, 0 warnings, 8 lines checked

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Xining Xu <ma.xxn@outlook.com>
Tested-by: Barry Song <v-songbaohua@oppo.com>
---
 scripts/checkpatch.pl | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..6f778f3403b5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6109,6 +6109,30 @@ sub process {
 				WARN("TRAILING_SEMICOLON",
 				     "macros should not use a trailing semicolon\n" . "$herectx");
 			}
+
+			if ($dstat =~ /^\+\s*#\s*define\s+$Ident\s*(\((?:[^\(\)]++|(?-1))*\))\s+(\S+.*)(\/\/.*)?/) {
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
+						if ($body !~ /\b$param\b/) {
+							ERROR("UNUSED_PARAM_IN_MACRO",
+							     "Parameter '$param' is not used in function-like macro, please use static inline instead\n" . "$herectx");
+						}
+					}
+				}
+			}
 		}
 
 # check for redundant bracing round if etc
-- 
2.34.1


