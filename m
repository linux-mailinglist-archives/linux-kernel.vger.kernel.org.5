Return-Path: <linux-kernel+bounces-32618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C548F835E07
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678B7B268FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152BB39AF1;
	Mon, 22 Jan 2024 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4tPybXZ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D139AE2;
	Mon, 22 Jan 2024 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915428; cv=none; b=VJ13e7JqS/KhyEucJ0Q76tJNeq/kgBYBEvUB6y39VABg/jFkMmw7Q4W/gpA2THc50EhDyPInyW08l2ZJrI/rztZDKqFiH046fGwluQX9gY+hApcMuzg7eMWQaVYGP6f+7QXlDQzG+3YUr2mpV+H8aDKs+AmiGEmklxT3asGuJEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915428; c=relaxed/simple;
	bh=vay+VqmlopxI655UNhNHoiATDbT3W+WrtjG1/9dKVXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=liQeLuAec/M4jtQGQ1Hk8M8B8DStwUBHL+BpCpmyZbG/qDaSXL5wp8mGjNNwrGQylOKiSaUyX7v77pjwrL9iiIug/GfYlSt0Tq3hzBKGwO+eDEA1WWxHH5HkFjT7bnD+EltL4Jy+QeK8DFRtS0XPlb+E37ykPMKVGT7EaLApo34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4tPybXZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e86a9fbd9so32834815e9.1;
        Mon, 22 Jan 2024 01:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705915425; x=1706520225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yHBHjM/RO1xCzBLcmgTsv25UAmmwT4Tay/bBv7LW0I=;
        b=h4tPybXZ4ZGeZVowo2aVStvHHG6CxXKcDWfpVAp/WnAtSLP4yXoPTPhXtH3ImK4JTu
         eWb7OwCh0KWaxJa2005wZZbPkTFyCSx+hj9RASMRE0FhAo232RcA8j7f1rWuVNAM+c32
         nVybJG3haFZzQDpy1zvmgltyhf8gHnjPxiP547dLTy2EJfam1X4CF0jb20y675SiPTtc
         4l7X9D6X52NJWDPERT1ZwSxrNlFgpSofkHnpCYPTCbPcRggF5PkJ9QeCYiDOSlwfZc0P
         qG2rifNhIkDnaqJoPSYvy1BcjbqhApP4DTugD5eL2rwpXOzhw+H0+4MOS3aCRnWwmgI8
         0dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705915425; x=1706520225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yHBHjM/RO1xCzBLcmgTsv25UAmmwT4Tay/bBv7LW0I=;
        b=JKUIPUwEzhNB7pAzFiQfarlh2QuJ6zwr+yHPx3j4Pyb1FQHv/jm/Atz4JRp7nOKxlB
         63qiB467nhQAnsiXjwDpxLAmr7RtXl9lV23ITpTbd/pYgeRZZfdBFQlYO46Ish1xJdCG
         y9dYG4bu/MQBM3p8u7eLmT9yuMnFCFU6oc5E1nd2/Q+PffVle3+2HKS/Kn7h0vEgnF3W
         LHwpVa6aMerFxKEof6Kw3I1g1UPEC8PFXtxmyztCJeU6+oalWRd/RJqYc6jUQyZCXFM2
         PxTvfy0IMxlH/z+7rqtwb7UuaRTeTVZJp+TsoIT71PWh+SeaYFbidmVqvkIKaDBUajFX
         ddJw==
X-Gm-Message-State: AOJu0YwYcyehjMbCY/5u+f4GGlO/2IDohR29jVGt4VjQWXGnnHepXgo9
	k5C2NDANPc4bsCz4d/7DDhMkBm6zRhL4N3xHKk1H0E1APb1Beko=
X-Google-Smtp-Source: AGHT+IEPKx1fb16j3UmGVvYLSZCw0H35x1y5xl8aO1KIIu27CgUoPmTtLeysTKSwlcfXYYVYN1V7QQ==
X-Received: by 2002:a05:600c:4387:b0:40e:5333:2024 with SMTP id e7-20020a05600c438700b0040e53332024mr2366505wmn.53.1705915424823;
        Mon, 22 Jan 2024 01:23:44 -0800 (PST)
Received: from phoenix.rocket.std.lan (a95-93-126-153.cpe.netcabo.pt. [95.93.126.153])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b0040d62f97e3csm42248158wmq.10.2024.01.22.01.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 01:23:44 -0800 (PST)
From: Rui Salvaterra <rsalvaterra@gmail.com>
To: tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH] ALSA: hda: Increase default bdl_pos_adj for Apollo Lake
Date: Mon, 22 Jan 2024 09:23:39 +0000
Message-ID: <20240122092338.25047-2-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apollo Lake seems to also suffer from IRQ timing issues. After being up for ~4
minutes, a Pentium N4200 system ends up falling back to workqueue-based IRQ
handling:

[  208.019906] snd_hda_intel 0000:00:0e.0: IRQ timing workaround is activated
for card #0. Suggest a bigger bdl_pos_adj.

Unfortunately, the Baytrail and Braswell workaround value of 32 samples isn't
enough to fix the issue here. Default to 64 samples.

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 2276adc84478..9fb54813693c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1732,6 +1732,8 @@ static int default_bdl_pos_adj(struct azx *chip)
 		case 0x0f04: /* Baytrail */
 		case 0x2284: /* Braswell */
 			return 32;
+		case 0x5a98: /* Apollo Lake */
+			return 64;
 		}
 	}
 
-- 
2.43.0


