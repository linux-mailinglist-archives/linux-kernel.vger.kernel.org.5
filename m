Return-Path: <linux-kernel+bounces-53200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A02284A20B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9792285DD5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7E3481AC;
	Mon,  5 Feb 2024 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRilGf9C"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C30481A7;
	Mon,  5 Feb 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157482; cv=none; b=ix268aoCpuGMzbtawYed6vaDhKgigWL5VP8sBeeJejeg/fUdxXeksx/k9nbLlH3vjf+rmUN0mG6/voyQ+QuZuhp7KqXr6g/gu0u0WCvkCwuiVg5HGW7GKvW2prUNergu81Kt0hWezuDDctRNZyIRu/9gD7K74qmZP/60eTP9Tsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157482; c=relaxed/simple;
	bh=g48/g471LD8lkAOaEa25kLlPkxEomPtYRQ8CQIFaNNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sE1EkUwbuof4BXpVnTgvdnnvLj1EBAVi1HdyR+HKZZSHcRxVyn4GaNeZ0oDDJGYdFNsoK/5Sx9yFvjug2NgAdS3tZ83USlDtNVDgTUkfgOjsxUjx6sXHtFg9d72+cWshz4YSf69pj3pYo+RVuXvmSgFATOlsMJDTeIv/yIyR8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRilGf9C; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33b401fd72bso736215f8f.3;
        Mon, 05 Feb 2024 10:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707157478; x=1707762278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E/95Us55Ran9Sed3OiAJ4KGme+SBSpnuH92E4Nqcaos=;
        b=fRilGf9CWk4nHyjEiFm+Gmj0nLHWUlpW2irapg4ePitwHKbqaX0DDeT9tlI4xD5gIx
         oWfBZ7xPz1b1rAOJeyBs1s0QbLpcS3TPL/A2qLpszKOivS4DUb+j0pLlIilC5AYopm7J
         CIGVtVEThVa/rrczeSNO1tKBEIDTUxVDbzGfiRnP4jcytWTf+rUy3XW3e3DSenr4yjGC
         +GUZnW4b/4iqHFaH+hSJyAzXE9vNjIyx00AsmMT6UffLit6zNKGEXiyoeoIH1EhxzS2c
         HOYs1+F3KOmy4gRsupjWSE6s/9V+Whdi0D+MrpVPRpBUpLjAL8g3W726/PVLZX1hNuHz
         tmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157478; x=1707762278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/95Us55Ran9Sed3OiAJ4KGme+SBSpnuH92E4Nqcaos=;
        b=rw6IwJ4yhi9D/qvQ1Xd1d7VQoGfMq2KpiV3FSq58UlmQyVIOqUG3JuiJARndv8UcPn
         Ck38/nLdhZNlWRNMy9f8SJf+x1A+Mm1OpR464G7CJf/MuMv+n5NYW2K1hWtGbLnZ5ASf
         G55ANYOwKqXF66HjY2j1ckbWqjlXX1x16ZLs9ye2Riuhs6lxXCh08QhAer75g7rcs3hz
         qn1S/SgcQku2nbNoSEYl+b3lQRIIwK2rwhl38QQbyf03hVfuMSwN85Y5Y/quOjy2NAs2
         XHwHb3Hrx+i6K1e/Sze82mk09FuXIw9ZQ8k3L4d/JrZa1X9ulxLIHtIDC8o2haikDMUV
         C3Uw==
X-Gm-Message-State: AOJu0Yw/8d9Qg0epW2kSKb+N1r9dkV6nRtuijpF27XCt2f5QqE/3Cn4N
	aW7ycXB5SFR1kGIm+wuSF0jqljo4Ed6nsj1azvzMbq+PXgIggwj7
X-Google-Smtp-Source: AGHT+IF77OGreAX5w90BtR2pqO0yqGGkxuQ6y+jep1MAvXY2YZk0hKLE0n4RXjfQHdDHd4k/aXQwdA==
X-Received: by 2002:a5d:6050:0:b0:33b:731:808c with SMTP id j16-20020a5d6050000000b0033b0731808cmr221522wrt.13.1707157478289;
        Mon, 05 Feb 2024 10:24:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWnOAieYCoiWnEigKI0X38acX35XBE44hL8vHMp2X+y/irjbVBWGhtA9P7/GIO85eXKVTpcnrBWjIip5ONXANhrRAhKxs4O0pw4bzlCa8XxPQdRQlsj7aEAZW8EP41rCqAny1rf7s0OTDmkn5nB0wnBf0jsB233ZaSzQn3/VCL/FojfDa+FR/ALAdIoSu3IeZXQqmbcKjyvhcHhGE5c+Z9X5XCnUySw/oFLxEoRJHv/y++PpUckdM10OsPg/AAR4ZA2NAw+zBw9QcHNZ+q+b798lZTtfRxbMvSwFSO1hK+S3Mg=
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z9-20020a056000110900b0033b43aaac8fsm194797wrw.7.2024.02.05.10.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:24:37 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] soundwire: intel_auxdevice: remove redundant assignment to variable link_flags
Date: Mon,  5 Feb 2024 18:24:36 +0000
Message-Id: <20240205182436.1843447-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable link_flags is being initialized with a value that is never
read, it is being re-assigned later on. The initialization is
redundant and can be removed.

Cleans up clang scan build warning:
drivers/soundwire/intel_auxdevice.c:624:2: warning: Value stored
to 'link_flags' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/soundwire/intel_auxdevice.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 93698532deac..95125cc2fc59 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -621,8 +621,6 @@ static int __maybe_unused intel_resume(struct device *dev)
 		return 0;
 	}
 
-	link_flags = md_flags >> (bus->link_id * 8);
-
 	if (pm_runtime_suspended(dev)) {
 		dev_dbg(dev, "pm_runtime status was suspended, forcing active\n");
 
-- 
2.39.2


