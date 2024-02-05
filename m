Return-Path: <linux-kernel+bounces-52331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06D58496CE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5604A1F2544F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B50D134D9;
	Mon,  5 Feb 2024 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhItRGOy"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5112E5C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125976; cv=none; b=beMUZwL2mAm44BdbRSReNWfCCD550WwI9fFSX428nCsgEbdQ6FqVVJllc5jsBy9AITKuCMyVxTcJrndKzHZsj3Du74w/9H3R/TQN5xVf8tloLqB8tCchysONNwn4Yc8Zk5fHF51e8DcC/woOXiMQN64IPNYDDJqBtPumwFkMwGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125976; c=relaxed/simple;
	bh=xIDctwqwnFoouPbumxcKvA7QckHnFJYT+ZVd0nPEP9k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g+Si84pqajLsCbMR+q2heveH5z+94uAG2c6VlY0Pk/taktDcWSyAzcC/8NS9LKi8dbak2qTmlhFGLsjYlNeHkPlIQvbu4JWkc9DZ9UmZ8NVfuAu4my7VXkoUIe/Y4770JbeQMoiOHoK6ifgQ+gi3toYR4CUBBqFK1MAY9nh+0m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhItRGOy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b409fc4aeso280722f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707125973; x=1707730773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1lYBRZvANc8NTjqQCLcG5zRX1RODX3spfuiCcoB8eI=;
        b=GhItRGOyExqBKy3DN/IH9Uhy3oinVqnMMGSqi42X+dHLzTsF6OJSPgUMdk7JypnAJT
         dImS42NiUnmfncOeQTBjcuxg/gLsWqGG+GJNSpxifurU5UleI4HD0ZtisGjoev5HQaT2
         mF8IS3d5cQo2a1UAccHnEpoElRhzwuYbLJnOGpmpiuOzOAV96/lau+XHNiKDDXiS3tUW
         +rASl0ETly2P5V4TkgRLUPmm29M45HXjPg65ac3xFODTuuZSiJzG0V7yuIvM4OyvYcFB
         vu01CVWImoDJUDU2VU0+I3bNvliGBy/wUss5AJ5ovujKvo22nW79IHlwd1YE8Gr2gaZh
         jpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125973; x=1707730773;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1lYBRZvANc8NTjqQCLcG5zRX1RODX3spfuiCcoB8eI=;
        b=UcfnlNqIJVb9c7pvrubmodvnclNcdwKBnKZLqHCjjavCBRJ/olkeFw29dMluTIYci7
         SRwWJYHCMkO4OVSZFU4OPUw0A52wGi9uBxegE/37hodtUNIumN3BRn5/ETrqnNR5UOd3
         2cnXYFptU8LUdfGrwenwRFkLsciv9Xe52QuIrbMx6l1EaHsaSzPVdfW+w1zmWY6MYlbJ
         OGfgDKzIxti77BRRf5+bXBi+rOy+y8mk7OQwzsoFBWcn5GC1Uri4HcHTVDdmFO0zMkQA
         ZfcBz+mus/+hMJboFwdcPq6WBFW0m5hb7fe7L0eAhes6vnjK79rNT8PvPjZfncXU05kR
         C2/Q==
X-Gm-Message-State: AOJu0YwvZM2JVkUxQ+csUm79E3EXj6khK16DqER8TfHaLREWaJcuzpfe
	qJl4I3Z+5KF4Jakpuf1w7UT3N+G8hQIY3HkvWxKOnlxlnQt6Fw0=
X-Google-Smtp-Source: AGHT+IFTZ5p7rDUnnhxJS36icrFXI+WKlAizxd15mRSLC2/ZqQ4W1YJTgh27QM6XoVCeQTQwwYnljw==
X-Received: by 2002:a5d:4a0c:0:b0:33b:17e3:60d9 with SMTP id m12-20020a5d4a0c000000b0033b17e360d9mr5489751wrq.1.1707125973150;
        Mon, 05 Feb 2024 01:39:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUnegPd6GboLd7sc0JhbFf6NfPRhbY9zrp7y41biV0O1FhgMnLyc4k9Aba66QPXFxic2L1vQjqLLmxDIC+rJg9qvDuY4aF1znNs
Received: from p183 ([46.53.250.163])
        by smtp.gmail.com with ESMTPSA id q16-20020adfcd90000000b0033afc875fd5sm7600537wrj.49.2024.02.05.01.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:39:32 -0800 (PST)
Date: Mon, 5 Feb 2024 12:39:30 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: peterz@infradead.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] smp: make __smp_processor_id() 0-argument macro
Message-ID: <0037d1f2-8153-4b33-b43e-f4b6ecd710ac@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

smp_processor_id family of macros never accepted any arguments.

	#define __smp_processor_id(x)

works by accident (see C99 6.10.3 §4). __smp_processor_id() gets
1 (empty) argument and passes it down to raw_smp_processor_id()
which doesn't accept arguments.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/smp.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -261,7 +261,7 @@ static inline int get_boot_cpu_id(void)
  * regular asm read for the stable.
  */
 #ifndef __smp_processor_id
-#define __smp_processor_id(x) raw_smp_processor_id(x)
+#define __smp_processor_id() raw_smp_processor_id()
 #endif
 
 #ifdef CONFIG_DEBUG_PREEMPT

