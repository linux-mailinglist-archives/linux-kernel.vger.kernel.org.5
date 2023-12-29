Return-Path: <linux-kernel+bounces-12921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AED681FCA9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 04:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD082866DA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD0C5CBB;
	Fri, 29 Dec 2023 03:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObbJUePb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5485241
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 03:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d5bc68bb7so24591325e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 19:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703819233; x=1704424033; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JxXfZU6ERWOuyrGVdyKmHBSuejXo21h0N1ktZLk7XHk=;
        b=ObbJUePbok7Fd+hzNkPI0HfFuF9XvxUNMFY1D6Cankj7DkuyoRcOpvM7fvqRZ6DMuT
         K2UqaeN87agQ9EgbW4KrTkDmZF39h5sNLYXudcRZB+ji8fU+ZX/h+km/Ni4HV/Pjvyqk
         M8GfAyUfwMFcSf3hRGji1IFYBqm6sUX6ZeTtSAkdtQRs0SEkg2cjpdC94vXcEpzFX7+K
         OyHrw2vr5rceVSePwPb0bek1BX435w2h1wbX86zpD9tI+Bi/3pDMcpaLCMK/lh9CUFpx
         B70gLk56WICeNCCucR4KtgwMWVJxowdY+f0qsui2G21QSUPJFXdvwR2jpsWOyG1x4ucb
         X4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703819233; x=1704424033;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxXfZU6ERWOuyrGVdyKmHBSuejXo21h0N1ktZLk7XHk=;
        b=ubtSVPpviiCPUJNUmRHhbjmolF3CFK/ZfokIG5Sa9W9/YDAxToLR2T8wd6UCeXLy5T
         54xPYDdEtA0e5Wh5pgeZTMzMxXMOI8kbyrbdPvKNpzhzVhs4HeVV0GHyKyO37xRWj+CU
         CdbY9SXw1Nn76b8x8Fw5J3F/M/mLxf16c6CSOf6CJTtFIWglpdjabJr1C7NztIh9xaOS
         HMlNz3MYG4D0qW0Ui9a7QS/PyxFO+yWCXn4kGZsvfKus8GzkXh2ki87B+9FrLgH34JrJ
         k8f7AfDo9d/ZyA4PqonVicwpjrmejiyWhnz3e499hkwbJFox5e6suFLldHfKn+w968Iv
         9E2Q==
X-Gm-Message-State: AOJu0Yyv6fFPwqFocsX9/vH+/1eKKycTHI/3Wr+CRR7kE9QFFvsjdtJC
	cOSwM15CT2klq6zSFMz5+zc=
X-Google-Smtp-Source: AGHT+IERsgSsv0IWY1cfITA1ssA5BB4JiHQzwDuEeAZsd3eLImfGIV8Y6tMvQjLJ3kf3LwHsfSUFGA==
X-Received: by 2002:a05:600c:4f0f:b0:40d:56dd:af56 with SMTP id l15-20020a05600c4f0f00b0040d56ddaf56mr3375564wmq.162.1703819233260;
        Thu, 28 Dec 2023 19:07:13 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id mf6-20020a1709071a4600b00a26aa8f3372sm7354822ejc.27.2023.12.28.19.07.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2023 19:07:12 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: gregkh@linuxfoundation.org,
	masahiroy@kernel.org,
	nicolas@fjasle.eu
Cc: linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 3/4] scripts/tags.sh: use -n to test archinclude
Date: Fri, 29 Dec 2023 03:06:53 +0000
Message-Id: <20231229030654.17474-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231229030654.17474-1-richard.weiyang@gmail.com>
References: <20231229030654.17474-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In bash, "! -z" is equivalent to "-n", which seems to be more intuitive.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/tags.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 83e3731b5bdf..5061ec255291 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -89,7 +89,7 @@ find_sources()
 all_sources()
 {
 	find_arch_include_sources ${SRCARCH} '*.[chS]'
-	if [ ! -z "$archinclude" ]; then
+	if [ -n "$archinclude" ]; then
 		find_arch_include_sources $archinclude '*.[chS]'
 	fi
 	find_include_sources '*.[chS]'
-- 
2.34.1


