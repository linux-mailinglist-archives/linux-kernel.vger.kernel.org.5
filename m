Return-Path: <linux-kernel+bounces-94705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E1A8743CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B3A28244A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D501C686;
	Wed,  6 Mar 2024 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wISlfJNN"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935571C6A6
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767257; cv=none; b=Y6avheN9tqAxRj2K3PvqxjGY5lAvZMIucuoJxlIHYbGdx39BGmocLvgabcWGBo7NfBm3CwnpdPntq9FiSoy9iDZxBt4alqvt88drIcIp4b8fsypPkQXOesH98nQcMl+9GiLKBK6KrTS6xV9CRHET3xKCG3umK317khNmcTVB1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767257; c=relaxed/simple;
	bh=x4c0QF1xK5HYmpfGSV2LTgalbNkmazcBNLlVATgNHmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ud13yCimc1e1kE98LyoYb6zj6+BrcD/WPvpZUv1Z8zcfah15dFRmvLBPrvrr6vDkCbzXJXUJ4DPbVcUMYnKyuhjx+VHfJtp+y7y1z4Q86NSzDfUXOIeRPJdIrgYZJBs8/vbDTsVCj5p+ZbbClPtsxLqNAbRXv+DhbTFfL/NVFps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wISlfJNN; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e4e9cdb604so146868a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709767253; x=1710372053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/HAOxTIhOb04yxROipfGfU9148m7i3FqBqWxGcLdbwI=;
        b=wISlfJNN5GQZiPOC8Mm1gGzltEcapnADKYkduvs1MC2nSSxbTXWYrF/YSRBFPhA0dz
         Y8M77Nd1lpS5X/vI3EopIhri6M7Tqxf6rmKfVXYFBQh4ZCTJIIeXZUp26geQV/2pYCdx
         /No96YpAxN6cT2lTvD6mU2PRihEN1fj/DaNQhHzHIMASb9I6Y5XviL6Ssus859osYxR0
         FLTMlcszUCIJ/X+J4WrsrbJ9BtGn4voOH2LdUMixuElefW484Eyjmd3WOgixKGVWlHc9
         mZ8UgEvjgYUDw/iRwKYLTA156gaOgpQRb0Q1PKA6WjsJePdCPMUPxe5BizCqEDyoKpm4
         Tgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709767253; x=1710372053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HAOxTIhOb04yxROipfGfU9148m7i3FqBqWxGcLdbwI=;
        b=rcfbF/o0UmuFsgWQocNOzIpLTdL0lhY3hsg6o61TVVt5NRgvRLh3Bxzfp8dFipAbyB
         WuYUBjOCsY1YBgH9Z+37uppxR34jOv+U9+jIGSqyOy0fAVmtRGge0n/Id2+VRfkjYDHD
         cO/TDYWY57WMLroU6vHKlXpMnXy0PLrGLLKz3zhfKKlkJ5FCS6kxQI1eDGd1GeLij32X
         4ki4v+BashOm0ORIYnnXt4Rtzb9awQtOBHd2CinMdrf+m8goY+N3mFYmWHUTD9lsvHpm
         11AgYxt2nb3gT49XKY0thjuVvqhVp00xX/d5QXFzVsgbeSOMg9MMbeFrcmsFYFlL+Ljm
         +IsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlkYei7yB6t0oBQijpuR1gtL7x6/VC+Ag8KECWIaPYZllwAyhEu0cUQMmUkRzXqxfVSqZCZK631JTJ+8R9DTeAUlEv96oqlAfCTkZH
X-Gm-Message-State: AOJu0YwXqNRmY7PDB7d75E6useQRcepTkbncwlu8e9FZmg95759tehOv
	fMOGWTAXVaFcAnUOTEulygZeQ6jjV9eQhhlrWk+IZ3/HdNDSixxC1vQxLmaZ6Iisphufxa17VRg
	9
X-Google-Smtp-Source: AGHT+IFrCcjG+0Z2KONunby15M30FWrBrcyNsAwI2Y3HwbEhG/u5N3zdB5+jDiNURklH58PA618BlQ==
X-Received: by 2002:a9d:6a82:0:b0:6e4:e282:394c with SMTP id l2-20020a9d6a82000000b006e4e282394cmr7335776otq.5.1709767253676;
        Wed, 06 Mar 2024 15:20:53 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id dq25-20020a0568300ed900b006e486902ce8sm2441379otb.31.2024.03.06.15.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:20:53 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christoph Hellwig <hch@lst.de>
Cc: Chris Ball <cjb@laptop.org>,
	Will Newton <will.newton@gmail.com>,
	Matt Fleming <matt@console-pimps.org>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-block <linux-block@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
Date: Wed,  6 Mar 2024 17:20:52 -0600
Message-Id: <20240306232052.21317-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 616f87661792 ("mmc: pass queue_limits to blk_mq_alloc_disk") [1]
revealed the long living issue in dw_mmc.c driver, existing since the
time when it was first introduced in commit f95f3850f7a9 ("mmc: dw_mmc:
Add Synopsys DesignWare mmc host driver."), also making kernel boot
broken on platforms using dw_mmc driver with 16K or 64K pages enabled,
with this message in dmesg:

    mmcblk: probe of mmc0:0001 failed with error -22

That's happening because mmc_blk_probe() fails when it calls
blk_validate_limits() consequently, which returns the error due to
failed max_segment_size check in this code:

    /*
     * The maximum segment size has an odd historic 64k default that
     * drivers probably should override.  Just like the I/O size we
     * require drivers to at least handle a full page per segment.
     */
    ...
    if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
        return -EINVAL;

In case when IDMAC (Internal DMA Controller) is used, dw_mmc.c always
sets .max_seg_size to 4 KiB:

    mmc->max_seg_size = 0x1000;

The comment in the code above explains why it's incorrect. Arnd
suggested setting .max_seg_size to .max_req_size to fix it, which is
also what some other drivers are doing:

   $ grep -rl 'max_seg_size.*=.*max_req_size' drivers/mmc/host/ | \
     wc -l
   18

This change is not only fixing the boot with 16K/64K pages, but also
leads to a better MMC performance. The linear write performance was
tested on E850-96 board (eMMC only), before commit [1] (where it's
possible to boot with 16K/64K pages without this fix, to be able to do
a comparison). It was tested with this command:

    # dd if=/dev/zero of=somefile bs=1M count=500 oflag=sync

Test results are as follows:

  - 4K pages,  .max_seg_size = 4 KiB:                   94.2 MB/s
  - 4K pages,  .max_seg_size = .max_req_size = 512 KiB: 96.9 MB/s
  - 16K pages, .max_seg_size = 4 KiB:                   126 MB/s
  - 16K pages, .max_seg_size = .max_req_size = 2 MiB:   128 MB/s
  - 64K pages, .max_seg_size = 4 KiB:                   138 MB/s
  - 64K pages, .max_seg_size = .max_req_size = 8 MiB:   138 MB/s

Unfortunately, SD card controller is not enabled in E850-96 yet, so it
wasn't possible for me to run the test on some cheap SD cards to check
this patch's impact on those. But it's possible that this change might
also reduce the writes count, thus improving SD/eMMC longevity.

All credit for the analysis and the suggested solution goes to Arnd.

[1] https://lore.kernel.org/all/20240215070300.2200308-18-hch@lst.de/

Fixes: f95f3850f7a9 ("mmc: dw_mmc: Add Synopsys DesignWare mmc host driver.")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYtddf2Fd3be+YShHP6CmSDNcn0ptW8qg+stUKW+Cn0rjQ@mail.gmail.com/
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/host/dw_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 8e2d676b9239..cccd5633ff40 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2951,8 +2951,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	if (host->use_dma == TRANS_MODE_IDMAC) {
 		mmc->max_segs = host->ring_size;
 		mmc->max_blk_size = 65535;
-		mmc->max_seg_size = 0x1000;
-		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
+		mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
+		mmc->max_seg_size = mmc->max_req_size;
 		mmc->max_blk_count = mmc->max_req_size / 512;
 	} else if (host->use_dma == TRANS_MODE_EDMAC) {
 		mmc->max_segs = 64;
-- 
2.39.2


