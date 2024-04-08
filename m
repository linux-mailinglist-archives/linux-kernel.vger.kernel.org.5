Return-Path: <linux-kernel+bounces-135201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B126F89BCA8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B5728460C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC7C52F6F;
	Mon,  8 Apr 2024 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="TYKDh4ru"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F5524B7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570778; cv=none; b=Bmwya/zLO1JfxG3eiklZkcS5puQgN/iEAEcqsYXdXlYnGTenCpPH3truNatbWIBwnUKbbnN6jhmBeZnMWYzam6HTLNim+nZoTl+CE4xOpjR2n2e4CAcjMuzkDFzkfTiUTAjqmbLA7AvEIhKGwWeaC1J5FDdPGJmgindPkn6G7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570778; c=relaxed/simple;
	bh=zMxsF/XXAV3m7oZA9ZVnB88S/DsMpWU9zUZymugNDEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o0ZjD605sPtoTvZYK2znwg6VF/db1aOyS/Il6o7h3NcWmvbhYwksv7IGfP1l2PUUYdga7BJ0VF/2RO5p7pJIywViEjPEKh7WAGRfz5arKOHDFr8gMtJBH//ivx/gGSPV+Yr14wxhc1zfYqWr7Tpa7e/E7cV6mCy/YYp2UWfa0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=TYKDh4ru; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e3f6f03594so5319345ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712570776; x=1713175576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=blAupfSoqLWI2yFJEHwQhfFwkpv/bLxix9B/LO52s/E=;
        b=TYKDh4ru2sI+3+1Ec5FyFxZWRdhwf6DbO4KnJo398SHp4tDr8dKxYzNk6lifk3B9i7
         gmu5rH426ZPqOECq4lmGyy25B18WXwC2vZEJa8eak8n4hzDR534BhfPFTH7nSpUzdU7x
         6TMGuVh03xcu3KCxgtDZysO8/UqsUqSf7PPsbEjcB0Fp+Co2WTA1IHGIFlu6tsLpLISE
         oWEhP2GL0cTraXjlngpi3OSK9q2Qfn2gYg3lnK0vIm/18xWl1PxNpizN+ysrZ+cyKtJZ
         zj5oNQSG7KlLgPUmO69uXTNkxFoyEan4tl3MNFjGD2+TEOgr4zdg2r1mn/RlmVMg9a7w
         rxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712570776; x=1713175576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blAupfSoqLWI2yFJEHwQhfFwkpv/bLxix9B/LO52s/E=;
        b=Z7ZqY+jTFmMZn7Vt9RDHI/tvxa1cq3eDkmvy9hc1iLSQpct1lLc44tW/AIiNUOyY8P
         SoQ21BsqXPBJxZAzywfH0jqKTclj8cXAcp8zgIvytY5Ap/iZ7KO30T7xxo61M7MWfw7s
         pIStFM67Aep00qNfUjs66NnJleBJIZh0CBZHfv9H0gmyh3ySy4u3uikceUl1aJhnahh6
         qXzhrXAURefnrMEg4yStKFJX5vN8rBGx8yQBjHYfzvmRmHbxoOMVjMuSF9WGR0WYA/5y
         pLnkU4vpU1UcvYSXmrHk5uzKo4nThySodAnSweG44LmoGyeXagPfG4dJiuCcK0thqC84
         thJA==
X-Forwarded-Encrypted: i=1; AJvYcCX9Ta86ujDWfxRVb+lhnLPIo7y41KSThbulL5vS4eyzWx6qufol1oQ8aI/5cDoLiTbcAoc5/HklL8gGBMdFWj787iCrJqD1fsfJGlTd
X-Gm-Message-State: AOJu0Yx6egRsddkilRr2ROHI2uRHsYg5Sw7ZhnJoqKyLd/yCLJU13fEQ
	nlsmV06jJ61RoHLHLv5+PpT43K29jqLzQQ5bv3ZFb2uluCiaACAVmWRoYmKsdfQ=
X-Google-Smtp-Source: AGHT+IFxR/QyDiaK/oafQZ7Uv4X27fjdU3R6v89UJ3tpEMQkbtTwijp1NBy73BXJqtd++CJY2VhT0Q==
X-Received: by 2002:a17:902:cecc:b0:1e2:ac38:2657 with SMTP id d12-20020a170902cecc00b001e2ac382657mr8154395plg.24.1712570775312;
        Mon, 08 Apr 2024 03:06:15 -0700 (PDT)
Received: from localhost.localdomain ([103.172.41.198])
        by smtp.googlemail.com with ESMTPSA id o3-20020a170902d4c300b001e3f54f90ecsm3039894plg.300.2024.04.08.03.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 03:06:15 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Lei Chen <lei.chen@smartx.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] x86/tsc: print some log if calibrated tsc freq deviates from original too much
Date: Mon,  8 Apr 2024 06:06:06 -0400
Message-ID: <20240408100607.1732600-1-lei.chen@smartx.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In most cases, tsc_khz is refined by hpet on boot. But in a few
production-level nodes, the refinement fails because calibrated
freq diviates from origin tsc freq more than 1%. Printing some
logs will help get this info.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 arch/x86/kernel/tsc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 15f97c0abc9d..a68b16e72df1 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1435,8 +1435,15 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	}
 
 	/* Make sure we're within 1% */
-	if (abs(tsc_khz - freq) > tsc_khz/100)
+	if (abs(tsc_khz - freq) > tsc_khz/100) {
+		pr_warn("Warning: TSC freq calibrated by [%s]: %lu.%03lu MHz deviates too much from original freq: %lu.%03lu MHz\n",
+			hpet ? "HPET" : "PM_TIMER",
+			(unsigned long)freq / 1000,
+			(unsigned long)freq % 1000,
+			(unsigned long)tsc_khz / 1000,
+			(unsigned long)tsc_khz % 1000);
 		goto out;
+	}
 
 	tsc_khz = freq;
 	pr_info("Refined TSC clocksource calibration: %lu.%03lu MHz\n",
-- 
2.44.0


