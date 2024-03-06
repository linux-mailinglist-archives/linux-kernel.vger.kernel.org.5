Return-Path: <linux-kernel+bounces-93866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1586873605
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC081C22CC6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDDE7FBDC;
	Wed,  6 Mar 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAeF81mT"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D5A78B43;
	Wed,  6 Mar 2024 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726722; cv=none; b=bUL1pGdY12Z9MMwOyvPveDfV4ULQl6u31ESN4OdFG1vurdZk6hyCti9WeSoq3kp9ZiLym7ZXMoCAAUOI48VWlNTgirR3vScqut3uLwEQJlrQr9O9Axc0VtzBUGJFr7ZJwQZNQGsbZ/FlWiAaKKhYSgEyuLAKK1O6FEFBM3nrQCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726722; c=relaxed/simple;
	bh=eQFHMv8UUo9nQQ3yy4xIIoO43toDxUa8TDUZCAlrLJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iTcIgWl3UFu2O2H6hFVSuJhInoc7SSU/KR5vzi3BXnNqcV9XKgYZXgYtv5RB2fEVTDJONlFU04VYcIQfjpln5Mub6BvyqAjNXFSX3x68rqugFEuhp9WunReMjcOF05ffcpLk8f3OPpBfQiNuNjIFvhFBlwcRx4DR+y7OU3igV48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAeF81mT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4429c556efso900510366b.0;
        Wed, 06 Mar 2024 04:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709726719; x=1710331519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8RIolar8ojewqWNyIt1GZK9S7XixCtLVhwrhP98c+A=;
        b=kAeF81mTngChlwUGS6c/arwbYyHgw9RSHfe4PcxFdkG8PqdM9JLTths4qcYWjk1ye6
         WcLY9P3DzGalBpzDLezwEdFfQyupNL9e1ZZZ2bZuY8Z8W09v87l1fW3WqJXEe2YYPcPi
         szrc09an83E6X0TkkdXxirCc0w2d0budSQY2HtNlBnbfIz2PwTX5vQyrUN2EBnBKEXLY
         2prHY735pV9b/JHkzRmJpkADTFtIIDT6GYBgcaBqSh2wgsu/qqvDOlEN46nzxGtzoqkA
         cXUH8o/F779r3awrxxbbDzTnLGrLzZ6o3bnVXUUClz3U/QYcwvkJk7f7s6E3hGkeACtf
         OuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709726719; x=1710331519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8RIolar8ojewqWNyIt1GZK9S7XixCtLVhwrhP98c+A=;
        b=tXY5AIE/chPLYjzMw8HLfAjAcOjgnzOudzrKtBdN+e1b6NSCiTjeFAo+GHBV7RmnBq
         +KAdB3OZxQw3aCeh8eIvFqX55cPsfXZSdFs/jzs5DR0VCJTpUsd4F66N3WShz1f7sMJF
         zyHeXFxvP2GDqu5y2JjTqouXu49DbK6VLDISAzVrv01IrdNIz2F8wWeSeORk0wrf+IZy
         xO+HXk5CnZn9fyaRa9ImIq6qCK9G4L4BZhmMMeaYkgQoDfzdMSmIp1Zm2464x/TDAjIm
         jAGmB4G09gFjMGC5f+ol9HK4yzWyS2gInwfskInir2nm5S7XBbuzQi9G1ioLLWqBtBFQ
         mv1g==
X-Forwarded-Encrypted: i=1; AJvYcCV2kSlvaau6x/uCvKu8xjr9daPADvE6gJkxqGBQshlg3Nv5M1OucKW6QtJczg8oYi2eeHs0jBiiB2aZfycCeqqYAqHfQtysvECdlh6H
X-Gm-Message-State: AOJu0Yw+LEyi3i+Q4ikuMnmCs1lnh8BuWL+2LfqzzNZGunOe+5ABinIM
	VxsbAQAyGHywezHWqvfcCnPqFJc0NT3gQeiklpAKL+9LVrCOG5HHUWAYqO6kTOw=
X-Google-Smtp-Source: AGHT+IGCoXG6Rl4slT5HV6uXkUjMR2UjZ+4AnyHwlfCUp0/BkCYBOE0k6LPL7CYJvUf1+uaWpPSQTA==
X-Received: by 2002:a17:906:13d5:b0:a45:95f5:f314 with SMTP id g21-20020a17090613d500b00a4595f5f314mr3820262ejc.42.1709726719025;
        Wed, 06 Mar 2024 04:05:19 -0800 (PST)
Received: from lola.. ([2a02:810d:7e40:14b0:d371:e319:5dd0:9b35])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906381b00b00a449f43a7afsm5637290ejc.113.2024.03.06.04.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:05:18 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Rodolfo Giometti <giometti@enneenne.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] pps: use cflags-y instead of EXTRA_CFLAGS
Date: Wed,  6 Mar 2024 13:05:15 +0100
Message-ID: <20240306120515.15711-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f77bf01425b1 ("kbuild: introduce ccflags-y, asflags-y and
ldflags-y") deprecates use of EXTRA_CFLAGS in the kernel build.

This has been cleaned up in the whole kernel tree long ago, but this one
single place must have been missed.

Replace the EXTRA_CFLAGS use by the common pattern for such debug flags.
No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Rodolfo, please ack.

Greg, please pick this minor cleanup patch.

 drivers/pps/generators/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pps/generators/Makefile b/drivers/pps/generators/Makefile
index 2d56dd0495d5..2589fd0f2481 100644
--- a/drivers/pps/generators/Makefile
+++ b/drivers/pps/generators/Makefile
@@ -5,6 +5,4 @@
 
 obj-$(CONFIG_PPS_GENERATOR_PARPORT) += pps_gen_parport.o
 
-ifeq ($(CONFIG_PPS_DEBUG),y)
-EXTRA_CFLAGS += -DDEBUG
-endif
+ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
-- 
2.43.2


