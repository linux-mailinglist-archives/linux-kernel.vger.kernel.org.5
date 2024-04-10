Return-Path: <linux-kernel+bounces-139220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C9C8A0007
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2F18B27525
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB8D15B0E4;
	Wed, 10 Apr 2024 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-stonybrook-edu.20230601.gappssmtp.com header.i=@cs-stonybrook-edu.20230601.gappssmtp.com header.b="XXureqNO"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C915920B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774989; cv=none; b=hMpnOwsrC86J3OI4vRNzImKfy1LpYrbZDOCar0T5Ave53XWFg6CMmya4VjFokpdLI2JjoLMln2YgvaG1CeoAey3i4XRoj66tau3RYgtWAYfAtiXXs+0JYWD1LeMIMqBLOEZad9O9XNaUFbc8eaBIlb/Gl8OxM7pSDXv9pcncejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774989; c=relaxed/simple;
	bh=vrbdY5Nhw7D58IFx3rshYwA6Wyv6H4LAkz/SSXDj35o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eiUKd4vTs3jaRUr1aeG4JI0s9lOiMAn1xQf9/Blr2KUBm41pv0hC+KEqWCmUCRPAsOCDHznKGmrY7WP3EpqAOjIGZehsUzUgxylSKn46xyDh9Irfma/COPvQVoSxIw5v99IsB/RI0UckuqSyxLRbDueWaKKDNgo8/LKMUmc2evk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.stonybrook.edu; spf=pass smtp.mailfrom=cs.stonybrook.edu; dkim=pass (2048-bit key) header.d=cs-stonybrook-edu.20230601.gappssmtp.com header.i=@cs-stonybrook-edu.20230601.gappssmtp.com header.b=XXureqNO; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.stonybrook.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stonybrook.edu
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78d543db3a4so296157785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs-stonybrook-edu.20230601.gappssmtp.com; s=20230601; t=1712774985; x=1713379785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+qYp6FwjoLyn7nHecO4se2yRXmWHmNIdEDWpmOEjXt0=;
        b=XXureqNOpvnVoXvcvSGSH3tnvZIx2opn2A6zFxqJE2mRoYZ7RsZgldO/OU1UUUNxMo
         ESA/ZZYfPgExc9b/bi4P2O3q3WwY/o3nUUO0pdXDHefnOM0OYK0UD8GHnwdOuabZCNl4
         4k65tBO7WyP2JgEcKsKwoF2bV48npuohcf3Tyc0KYpJuwgrL2xB2DJuXsm7De7xBwQlb
         Av4cyWAEpHsz48OaaxE8qWtEnMbflvm21EPDlASZfFu37MoTbZwp5FF+vy/JxZq0zYQa
         EQcCEqpmSLelZOPn5K8R+JszbqgvPZAfzTJRDxJ6P7/mOpJ7AAiqdUsuQGMxWOtRj+yt
         mlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712774985; x=1713379785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qYp6FwjoLyn7nHecO4se2yRXmWHmNIdEDWpmOEjXt0=;
        b=M9PCXKihG582cMs6Ju33JqZ/UfUKOcbX8BDJsx4aOxso/P4ZRtYYZ3A3mw5reUji6Z
         3pNFh0Bc5Xiarxmdd9+VLODqKvIFAJaqvf+jKHc4wcYgH+UchtwdyTGVMLk6N/QMoyY1
         yquucAqD3Ek3gXeUs8HU2VqzbhcP9n/4oufzjApQQj5PVKU1igBlCWzd3unYLoknGRFx
         lPf1hHvFHOEr7OpK50xxGdeWxUB6XKZMdFzZyCTie7eYbS7Bmh09DP3ASHI46D6PjjNI
         2fEAXooaRJJA+y8i9xXwlFU5r04QfcgQOA34cVAYYGrWJh4r+kPFTFSWr/GeFZD7EUbp
         a3cw==
X-Forwarded-Encrypted: i=1; AJvYcCUe4/Bbp3wkwaRRdVxh0f9W1gH6tPRHfBPclbS5FRb6gJUPrSv0XjVKSp8Fh95RS3hvRsZ0NWeCuzbR0ZgAJAkwA7uyTRwu12G2ryW1
X-Gm-Message-State: AOJu0YzmjimPiIX6zGuLQcDCmDHknAmVHIBTQ73CgwlQqrTvv9j5Hy08
	rrr524VtWSXj3t0iacdaqEWpp00RokUXDmoSat2Y2OKaa6PQxNjK1MhJlZN3r1M=
X-Google-Smtp-Source: AGHT+IF2Q7Q19g/35jZpQF06W4+QlXiQW/wgqsuDGztGBAXaCggmXtwmqU16QJ8IlGGr5uz8KXgfQw==
X-Received: by 2002:a05:620a:171e:b0:78e:bd77:b8f with SMTP id az30-20020a05620a171e00b0078ebd770b8fmr1512800qkb.14.1712774985570;
        Wed, 10 Apr 2024 11:49:45 -0700 (PDT)
Received: from dhcp206.fsl.cs.sunysb.edu (dhcp206.fsl.cs.sunysb.edu. [130.245.126.206])
        by smtp.gmail.com with ESMTPSA id w2-20020ae9e502000000b00789f3c50914sm5571956qkf.33.2024.04.10.11.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 11:49:45 -0700 (PDT)
From: Divyaank Tiwari <dtiwari@cs.stonybrook.edu>
To: shaggy@kernel.org,
	dave.kleikamp@oracle.com,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	axboe@kernel.dk,
	jinpu.wang@ionos.com,
	dchinner@redhat.com,
	lizhi.xu@windriver.com,
	johannes.thumshirn@wdc.com
Cc: Divyaank Tiwari <dtiwari@cs.stonybrook.edu>,
	Yifei Liu <yifeliu@cs.stonybrook.edu>,
	Erez Zadok <ezk@cs.stonybrook.edu>,
	Scott Smolka <sas@cs.stonybrook.edu>,
	Geoff Kuenning <geoff@cs.hmc.edu>
Subject: [PATCH] fs/jfs: fix order of kfree() and mutex_unlock() within lmLogOpen() in jfs_logmgr.c
Date: Wed, 10 Apr 2024 14:48:55 -0400
Message-Id: <20240410184857.42754-1-dtiwari@cs.stonybrook.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the jfs_logmgr.c file, within lmLogOpen() under the “free” label,
mutex_unlock(&jfs_log_mutex) is called before kfree(log). Through our
model-checking tool Metis, we found that this is one of the potential
causes for nondeterministic kernel-hang bugs in JFS. Specifically, this
indirectly results in the “log” variable being NULL dereferenced in the
function txEnd() in jfs_txnmgr.c.

Fix: Swap the order of mutex_unlock(&jfs_log_mutex) and kfree(log).

We checked the entire JFS codebase, especially the file jfs_logmgr.c where
log is allocated and kfree’d multiple times, and found that every time,
except this buggy case, a call to kfree() was followed by a mutex_unlock().
This ensures that any shared log resources are protected by the
jfs_log_mutex lock.

The small patch given below fixes this bug and we are reasonably certain
that it is the correct fix.  Before this fix, we were able to trigger the
kernel hang bug fairly quickly through Metis. Through multiple experiments,
we found that we were able to cause the kernel to hang mostly within a few
minutes of execution. While we are fairly certain that the patch below
fixes *a* bug, we believe there’s another race/bug somewhere else that we
have yet to identify.  With this small fix, when we run Metis, we can still
trigger a NULL ptr deref of “log” in function txEnd() in jfs_txnmgr.c,
but now it takes anywhere from 6 to 137 hours (almost 6 days). We are
hoping that this fix will also help some of the JFS maintainers identify
other potential races.

Note: All of our experiments were performed on Linux kernel v6.6.1.

Signed-off-by: Divyaank Tiwari <dtiwari@cs.stonybrook.edu>
Signed-off-by: Yifei Liu <yifeliu@cs.stonybrook.edu>
Signed-off-by: Erez Zadok <ezk@cs.stonybrook.edu>
Signed-off-by: Scott Smolka <sas@cs.stonybrook.edu>
Signed-off-by: Geoff Kuenning <geoff@cs.hmc.edu>
---
 fs/jfs/jfs_logmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 9609349e92e5..ce9af4ef1e41 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1144,8 +1144,8 @@ int lmLogOpen(struct super_block *sb)
 	bdev_fput(bdev_file);
 
       free:		/* free log descriptor */
-	mutex_unlock(&jfs_log_mutex);
 	kfree(log);
+	mutex_unlock(&jfs_log_mutex);
 
 	jfs_warn("lmLogOpen: exit(%d)", rc);
 	return rc;

base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
-- 
2.34.1


