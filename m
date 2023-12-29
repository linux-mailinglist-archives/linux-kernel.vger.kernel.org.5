Return-Path: <linux-kernel+bounces-12922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA8C81FCAA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 04:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE3D1C213A3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2953D79DE;
	Fri, 29 Dec 2023 03:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8wztx/e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135D9749C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 03:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-555144cd330so3470098a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 19:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703819239; x=1704424039; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8NnLHCVjx9aqyP1ufwGEuN07V6WNPoP3NonBnRbDE3A=;
        b=V8wztx/e2lBePMKg6XqRVSIbqLsMW9F8rcopqR0cvBebFrVlunl7pu0cwNL2vL235b
         AS2TZjpkQVGdfuxMD86E7RuNqomXbDlrVohhjNuPOSGBvtM8/THIa5i1ggvXAEeu8a4d
         H+TEHkxsTgchE31ssfOPygGj/vuNiXcLQAvCRdZv08uXWWRO5GFC2Am6f8Cdy+c46Zpp
         s7AlzUr9KLm3woHJoaALoE6cFBatF54wCEGogIJcga7uW6NnH/GmtH0VaJbvAIj/Wh7/
         OkrjlsDiGTHqGyy4ftHLQwGOhYyPXPr9MGFZ2gJJGwYcI4P7xIguiTwNWXdeBslsGcAE
         RWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703819239; x=1704424039;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NnLHCVjx9aqyP1ufwGEuN07V6WNPoP3NonBnRbDE3A=;
        b=XtnRvoA+ZWFMW0FZC4qyP7z/xwKi0wtDxZooDp1m5KmIhVPJK2gORWI7ZV99Xbc8No
         e1MkC0cRpQrTSXnrkqt/q31+Drue5FtwBwSRV6OtRwZLp6hfJODnjhi+TluK+XhWbDLI
         cz3A/8NlrqA52OWUfuoB0pmjdaynSYdQUomRtoe4Yzy1joK6+xBosMjuqu0UFs+j8D3n
         ZWXCNwkxLw9OMFQZ/I+JBEVUAw6k2TcYoqhTN/K8iXLQduoKQm2jQ3dA+UXoM066GujQ
         PhvpX6ntXrw9iwE9Zx5ADaXBxvnEKzlSrqqUjgSPXSE07U0ZKY8zXziWy6CtIo0c9+je
         qIBg==
X-Gm-Message-State: AOJu0YwPTKRXcReaxjxy0faNjxZOH4RKG861mqaWdkgRD/o12IZZTH9n
	6GlN/5QpgGHLzhqHbb7dRuA=
X-Google-Smtp-Source: AGHT+IElBK6U4XRwsZNBqnPMOP2+jxJmVGZAimwdzPZWUKZf0RDXeVXklA55ousF8ikpWajbspMeQA==
X-Received: by 2002:a17:906:2cb:b0:a26:e363:2c9f with SMTP id 11-20020a17090602cb00b00a26e3632c9fmr3530202ejk.146.1703819239225;
        Thu, 28 Dec 2023 19:07:19 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id y21-20020a170906559500b00a26e490e3f2sm4738337ejp.181.2023.12.28.19.07.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2023 19:07:18 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: gregkh@linuxfoundation.org,
	masahiroy@kernel.org,
	nicolas@fjasle.eu
Cc: linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Jike Song <albcamus@gmail.com>
Subject: [PATCH 4/4] scripts/tags.sh: remove find_sources
Date: Fri, 29 Dec 2023 03:06:54 +0000
Message-Id: <20231229030654.17474-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231229030654.17474-1-richard.weiyang@gmail.com>
References: <20231229030654.17474-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

After commit '4f628248a578 kbuild: reintroduce ALLSOURCE_ARCHS support for
tags/cscope', find_sources only invoke find_arch_sources.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Jike Song <albcamus@gmail.com>
---
 scripts/tags.sh | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 5061ec255291..45568fee0cbb 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -81,11 +81,6 @@ find_other_sources()
 	       -name "$1" -not -type l -print;
 }
 
-find_sources()
-{
-	find_arch_sources $1 "$2"
-}
-
 all_sources()
 {
 	find_arch_include_sources ${SRCARCH} '*.[chS]'
@@ -95,7 +90,7 @@ all_sources()
 	find_include_sources '*.[chS]'
 	for arch in $ALLSOURCE_ARCHS
 	do
-		find_sources $arch '*.[chS]'
+		find_arch_sources $arch '*.[chS]'
 	done
 	find_other_sources '*.[chS]'
 }
@@ -125,7 +120,7 @@ all_kconfigs()
 	find ${tree}arch/ -maxdepth 1 $ignore \
 	       -name "Kconfig*" -not -type l -print;
 	for arch in $ALLSOURCE_ARCHS; do
-		find_sources $arch 'Kconfig*'
+		find_arch_sources $arch 'Kconfig*'
 	done
 	find_other_sources 'Kconfig*'
 }
-- 
2.34.1


