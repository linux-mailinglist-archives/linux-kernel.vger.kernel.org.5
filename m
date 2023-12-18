Return-Path: <linux-kernel+bounces-3747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 677D281707F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE801C24B28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDDF129EC4;
	Mon, 18 Dec 2023 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlGNlsCc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90981D127;
	Mon, 18 Dec 2023 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28b7a0d1665so371327a91.1;
        Mon, 18 Dec 2023 05:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702906140; x=1703510940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MTa54+lQlw7SR8DT+g/1Fr3hHx6APCXhIN2lYddiDtk=;
        b=YlGNlsCcwKLPjrlRSJkQPJqKJV63zhOeoyt3eAct9Fbbzjz8plGLYBNBjWQBJzlOMV
         4BGM1ZQXF8FT8bMcD9JLUHSlzRj3kYvI2jg00P4Y34Z9W6tUFHKff3sn6uMMJprQSviV
         BrEFZw9abZM2OF8hiUAIZBxu6cDi6jmdBgQD2SIqIpj0kIxSOiokMhhIPO10tLBgAsWp
         dfAWE7yPvlpApSHNeAmECQRp3JsEXmZ3ZlFB+jXKjUxCnir2ta56JfLAehy2y08ETyVr
         5xTMVv3URi2kQZQZ82lW4x9t1zP8swUyOo7gqT0l8HmKycorSD2hYfIV5DyFcSM6oo5L
         J7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702906140; x=1703510940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTa54+lQlw7SR8DT+g/1Fr3hHx6APCXhIN2lYddiDtk=;
        b=Geddf41ey4ZC6pMBabPqZOGg9Qvns+gbpYjvoirk4wPlNYKaD0v2851o+gZeBAm6Jp
         ZZwsbi5LIFAFjckdrOgpDTa9uJA+na4e5S7B8gAUvF3JURe0EP/SrukYxv+ss5gd/zGx
         7djRyvhib0axjid4oSTqfrAKxQP5XYLwiqeYBOkYFNOsKj7FMAuE+Lc+LgqxHJkz44CD
         UeopkqvZxiQiQ3frjUyInYzrnGihANRQwY1CCy4/0WOLyEYXjWrr7P/r+bKYO4CeBUnW
         b1Q26J0patDfeJt3wLQ3FSy/Xrb9CXEqMkq99ukJ8TAPdt2TgeKYrOEKoV/q4VRG6WI+
         Lcng==
X-Gm-Message-State: AOJu0YxmHJ60q4jUgMWq+zyh9Ld+jYHoOkTV3a7orpq+dHHy9JvO5rXA
	5G0NzjWYRyeurv3S6tTcXL8=
X-Google-Smtp-Source: AGHT+IEZB2TgUmy45ncpAne6KqvvnvtmZ+gMBs+oCv3PsYgnCD1AOUambh3fKhCzFxZCE8jZycHozw==
X-Received: by 2002:a17:90a:f406:b0:28b:4f4b:e53e with SMTP id ch6-20020a17090af40600b0028b4f4be53emr650117pjb.29.1702906139998;
        Mon, 18 Dec 2023 05:28:59 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id lt8-20020a17090b354800b0028b493c8c2esm4582747pjb.22.2023.12.18.05.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 05:28:59 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id B66DC10212A1A; Mon, 18 Dec 2023 20:28:50 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux RPC <linux-remoteproc@vger.kernel.org>,
	Linux OMAP <linux-omap@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ohad Ben-Cohen <ohad@wizery.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] MAINTAINERS: Remove Ohad Ben-Cohen from hwspinlock subsystem
Date: Mon, 18 Dec 2023 20:28:31 +0700
Message-ID: <20231218132830.5104-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2551; i=bagasdotme@gmail.com; h=from:subject; bh=7GhFXdwAV5PhQz23rGs3xKB6DfUzp3AwgsRqoRUYw+M=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKkNHtVr5gse7Ooz7rY8brF6P9vj+UsE5ghL5bByRUncy DEKNrnWUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIkY7WP4X8mx0ClcuFo9drnA sYge208ezEvvRd/cUujsU5JZ5hZ9meF/osz9Eu259/YyCa357KxeEGt81ePW1G0PP1z4GRUbEHS FFQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Commit 62c46d55688894 ("MAINTAINERS: Removing Ohad from remoteproc/rpmsg
maintenance") removes his MAINTAINERS entry in regards to remoteproc
subsystem due to his inactivity (the last commit with his Signed-off-by
is 99c429cb4e628e ("remoteproc/wkup_m3: Use MODULE_DEVICE_TABLE to
export alias") which is authored in 2015 and his last LKML message prior
to 62c46d55688894 was [1]).

Remove also his MAINTAINERS entry for hwspinlock subsystem as there is
no point of Cc'ing maintainers who never respond in a long time.

[1]: https://lore.kernel.org/r/CAK=Wgbbcyi36ef1-PV8VS=M6nFoQnFGUDWy6V7OCnkt0dDrtfg@mail.gmail.com/

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v1 [2]:
  * Add also OMAP hwspinlock & driver entries in CREDITS (Ohad)

I was prompted to do the removal when I was reviewing kernel-doc fix
[3]. When I was digging MAINTAINERS history (`git log --no-merges --
MAINTAINERS`), I noticed that Ohad is inactive.

This patch is based on mm-nonmm-unstable as I intend to route it
through mm tree.

[2]: https://lore.kernel.org/r/ZX04Ymz_vDFEeUDX@archie.me/

[3]: https://lore.kernel.org/linux-mm/20231216111017.17624-2-bagasdotme@gmail.com/

 CREDITS     | 3 +++
 MAINTAINERS | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/CREDITS b/CREDITS
index 81845c39e3cf37..3c7c953c7cf69b 100644
--- a/CREDITS
+++ b/CREDITS
@@ -323,6 +323,9 @@ N: Ohad Ben Cohen
 E: ohad@wizery.com
 D: Remote Processor (remoteproc) subsystem
 D: Remote Processor Messaging (rpmsg) subsystem
+D: Hardware spinlock (hwspinlock) subsystem
+D: OMAP hwspinlock driver
+D: OMAP remoteproc driver
 
 N: Krzysztof Benedyczak
 E: golbi@mat.uni.torun.pl
diff --git a/MAINTAINERS b/MAINTAINERS
index 5c9d3d8546714a..4acc4a3d4fcd96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9257,7 +9257,6 @@ F:	drivers/char/hw_random/
 F:	include/linux/hw_random.h
 
 HARDWARE SPINLOCK CORE
-M:	Ohad Ben-Cohen <ohad@wizery.com>
 M:	Bjorn Andersson <andersson@kernel.org>
 R:	Baolin Wang <baolin.wang7@gmail.com>
 L:	linux-remoteproc@vger.kernel.org
@@ -15692,9 +15691,8 @@ F:	Documentation/devicetree/bindings/gpio/ti,omap-gpio.yaml
 F:	drivers/gpio/gpio-omap.c
 
 OMAP HARDWARE SPINLOCK SUPPORT
-M:	Ohad Ben-Cohen <ohad@wizery.com>
 L:	linux-omap@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/hwspinlock/omap_hwspinlock.c
 
 OMAP HS MMC SUPPORT

base-commit: cbeb59a84b8f29151b882d03a4d23d19d92f4337
-- 
An old man doll... just what I always wanted! - Clara


