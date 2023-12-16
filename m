Return-Path: <linux-kernel+bounces-2158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 479198158C5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD0C1C23A49
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C33615E94;
	Sat, 16 Dec 2023 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNUs2bRP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3026414005;
	Sat, 16 Dec 2023 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d383c7a751so11462345ad.1;
        Sat, 16 Dec 2023 03:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702725051; x=1703329851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=52bukz5OEwPqW3+PrJR3Zff5UyUgEPAKyq1wevAV7IQ=;
        b=QNUs2bRPLagZt0dnCu7Un9b425vMd2FQeg2BVOb0pp20RrhRVF3q5t0C62cQt3geJa
         G8iQEX1jQQlqL3hla0OkC40wNwxEfLEtL4RUpj0SB13Z759BgW0fpw2SSk5MEcobAj0W
         J4RYhKTfY/gWzd/YIT7gT5he1AGln26DWNdfXas5EHyeocB+bZfBmRCHxDWNZF2BOO4F
         3ABDdwujhn4CBZ1IyVI1nuqwwKuboXJMNsyYqswLHxqp5/Lc8y5P7g4hU5diqddF8+Gd
         X4I84ufNlPA3q0iRttUrUy0gYJ14MpED3vlvJ7eBAVijGZCxWp8I113KvgizgtMeWDAr
         xCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702725051; x=1703329851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52bukz5OEwPqW3+PrJR3Zff5UyUgEPAKyq1wevAV7IQ=;
        b=puLIgZmDyZvuRI6WEAt6QTdThq4HRC5e8YFTQLXq3oP7EdTc6ocgKivqffPTGk+7m8
         Cp2551Yf4Vn8J83cjNxjO4WMemL2Rbwv7Zaq0YXNMEdBRpoy7ZFx0jc6m4rf8YrlPirN
         zsBAqU6JsXpdsV9VnYoiwVdVgWb3PRWW9kyXdGYhF0GG8qtZ3JeKHGJ4FezefVMjKDE4
         td27KDlqL4QXkIwiZTNNZhzxMc6kAF8vq5qpTfPkNVaUwrKx1eto4zeyQ+S/FKzf8wgV
         DK2YhQ8mXvQYz1+jdEPxIGha8iifguSbgli10CAOBqvelH2LWibgSCrR2BWdLuFG5/AP
         yCfQ==
X-Gm-Message-State: AOJu0YxfSBV/zlrYKBCne5x8R6797oep3EKf6OyJM1EKCXVYKkLoJsCC
	7+7lpYIditdK4vf0siuVbMg=
X-Google-Smtp-Source: AGHT+IFcxUUJzWefJMD4f++MNnbTZ8X51NmtzAWytJLOpY467MG5rc1yFYx3c58rFOy2s+JkzbNaBw==
X-Received: by 2002:a17:903:2303:b0:1d0:6ffd:e2c5 with SMTP id d3-20020a170903230300b001d06ffde2c5mr16060236plh.95.1702725051389;
        Sat, 16 Dec 2023 03:10:51 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ix2-20020a170902f80200b001cffd42711csm813414plb.199.2023.12.16.03.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 03:10:50 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 566E3102F376D; Sat, 16 Dec 2023 18:10:45 +0700 (WIB)
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
Subject: [PATCH] MAINTAINERS: Remove Ohad Ben-Cohen from hwspinlock subsystem
Date: Sat, 16 Dec 2023 18:10:18 +0700
Message-ID: <20231216111017.17624-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2231; i=bagasdotme@gmail.com; h=from:subject; bh=6OfYArUW8Avykd+ylNtEXIf2NipDbU3dsr6Tpm5qsoo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKm1zV9cFVJOzJuwRP72y32m8+b/eHi44yWX9elFMt1es i2+/Bt1O0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjARAQuGfxZe0uUeZQYXuFSK dSen782uPp+96vQ2t5+r+TTe60gZKTP89xJWYIyw2TC3JuApo7VEQFeR5sNt8ts/lmtwqnb3vEr gAQA=
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
I was prompted to do the removal when I was reviewing kernel-doc fix
[2]. When I was digging MAINTAINERS history (`git log --no-merges --
MAINTAINERS`), I noticed that Ohad is inactive.

This patch is based on mm-nonmm-unstable as I intend to route it
through mm tree.

[2]: https://lore.kernel.org/r/ZX04Ymz_vDFEeUDX@archie.me/

 CREDITS     | 1 +
 MAINTAINERS | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/CREDITS b/CREDITS
index 81845c39e3cf37..cff24c62b0e8f9 100644
--- a/CREDITS
+++ b/CREDITS
@@ -323,6 +323,7 @@ N: Ohad Ben Cohen
 E: ohad@wizery.com
 D: Remote Processor (remoteproc) subsystem
 D: Remote Processor Messaging (rpmsg) subsystem
+D: Hardware spinlock (hwspinlock) subsystem
 
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


