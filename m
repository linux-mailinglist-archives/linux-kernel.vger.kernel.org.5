Return-Path: <linux-kernel+bounces-12920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8007781FCA8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 04:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0039B2393B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC932593;
	Fri, 29 Dec 2023 03:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDFDJgJ3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF74823B8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 03:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-555526a060aso2476664a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 19:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703819229; x=1704424029; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IIzt4t8eJHHk4X4J6CbXERVLfadafJ99wsxF/MUFPhk=;
        b=JDFDJgJ3Qdjji7fHsjWoutGYd7D7YhtYutQPs32lfBoD5ey1VkjYh35hZzW1dSl9v9
         zWi5Izz/wKL4Td+gC8phN+g/OTKNzniwElGQbQwY8ReamC/0JcnGoYtIw1Sd2hMfwL77
         uZ4C0PylZt3gK2HHcn20KrBS2IMfSJJagtIFzKqCJRDOkv6Ea6xI9fuq6xY/TVu0UguQ
         q4/GRQoXAdmW12ek7U4zDsHkT7AWJXUBUB60dEHQ0EPkIB8MGtYqn/UnPmQWqKXEhZIB
         R2YdnpfvhC83WW9CZ/ot2Pkyj1+wDUz0A03oyZbbaSs7ucw5xzbx2h1cwIfF3SoYY8tB
         OmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703819229; x=1704424029;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIzt4t8eJHHk4X4J6CbXERVLfadafJ99wsxF/MUFPhk=;
        b=jNzn8J+BUmI348vYCcH4XFV+Vgc/LGUJH09FN3detpGYsuWXMtfldg8bMzi7jFwXAC
         qKVFpbCDSE8RO0mr/PbpW74RX98e4MtIGa6cdIIREVfnZssXr/mvmBR4CSNEzIVytPeZ
         kjdIeVYmfrH+Gqq3AVQiYmFfHSrtBqyYmrWjWkZvnT+udE965bE2stuf63HHhEsOI3Yc
         IyRA90yEet5Mdh2MwtQway5fr0Yk8gcdQLz96f6ss1MmLPe5Nbg8oa1xS6FUg0V/pGf3
         CNoGhjUSRWyOOQQBbu0FbyEydlcAdwVofxMpH2VFPIXaUF58UqT1cTPEYoqHVWoDOSa9
         Q+1g==
X-Gm-Message-State: AOJu0Yzm9vmqKmKDIxv0nGQ16+E86DSLAlarO79ZehOimCgfviCqvHHQ
	hqSCihQir15yECMkvZ+SABw=
X-Google-Smtp-Source: AGHT+IFCDT5Tw65RlTUQMXJq3gXej1hhczFRTpnUJ4C/6EJoMltc7l1iTdwrqBUC2x7VGFy+/QeKOQ==
X-Received: by 2002:a17:906:d4:b0:a26:d9a9:fff0 with SMTP id 20-20020a17090600d400b00a26d9a9fff0mr3083033eji.81.1703819228899;
        Thu, 28 Dec 2023 19:07:08 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id gh13-20020a1709073c0d00b00a2797a545a3sm106704ejc.193.2023.12.28.19.07.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2023 19:07:08 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: gregkh@linuxfoundation.org,
	masahiroy@kernel.org,
	nicolas@fjasle.eu
Cc: linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/4] scripts/tags.sh: add local annotation
Date: Fri, 29 Dec 2023 03:06:52 +0000
Message-Id: <20231229030654.17474-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231229030654.17474-1-richard.weiyang@gmail.com>
References: <20231229030654.17474-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 'f81b1be40c44 tags: include headers before source files'
introduce two local variables.

Let's add local annotation to make it obvious.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 scripts/tags.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index fbae1a087ee1..83e3731b5bdf 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -50,7 +50,7 @@ fi
 find_arch_sources()
 {
 	for i in $archincludedir; do
-		prune="$prune ( -path $i ) -prune -o"
+		local prune="$prune ( -path $i ) -prune -o"
 	done
 	find ${tree}arch/$1 $ignore $prune -name "$2" -not -type l -print;
 }
@@ -58,7 +58,7 @@ find_arch_sources()
 # find sources in arch/$1/include
 find_arch_include_sources()
 {
-	include=$(find ${tree}arch/$1/ -name include -type d -print);
+	local include=$(find ${tree}arch/$1/ -name include -type d -print);
 	if [ -n "$include" ]; then
 		archincludedir="$archincludedir $include"
 		find $include $ignore -name "$2" -not -type l -print;
-- 
2.34.1


