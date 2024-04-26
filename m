Return-Path: <linux-kernel+bounces-159480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BD68B2F32
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0543EB20EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CB578C78;
	Fri, 26 Apr 2024 03:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="BYf61GvY"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE57604D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714103009; cv=none; b=sTbpwHqkfzerK92Jj+6LXpLABoN3ij0CjcFZ+shLSA75hjVXmcAu6zRQtx1LRegXocYI5rnfhduMk+WM0d/vXROsARszzi/Q3GxI8wvXKoaR3LduY5n+hmimWmYftDjOtr9TPlbfhCR4KfAlaOpIyAe4/4sP+7do8fs/iVaot5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714103009; c=relaxed/simple;
	bh=tDWeS9EyfVzdb9+b53fsi52JTEQiv3F8/xYZ8HRdDKQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KqaG7p343Mh8OCOn/NYmut3m9vXEB7FlIe0dHzvGqktCvoT9yWBhZgleIq+GW7XPZAFFnpK4cq4bL5f55mhB/xakeiK9qYRPK+SyEB+/lQHkCz9K5E7zUF9nmue+gSMq/nf0wtqvAlqt6o9GQ1nDk7/YD9Ai+TkgW6LqKPHYly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=BYf61GvY; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4376157292fso11262191cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1714103006; x=1714707806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjep24xOYUjfKLkGIt5Xg15kGd3msBByaQ3pAIEh0mM=;
        b=BYf61GvYUnF2TTRC814RtCj7Jgt4au0+4X2s48k/PAgcayVMRSoDIYyb7/T2r8+gZk
         9g+jXcAfqG0aaf+bQvVm+HtgLisCoEVoczDwIt46ENd/qiobLYVmUBVzeC4jHYB6TxHA
         ahEmsBWWheDlETvzHZ0KHhv0DQamjmogdwdBO1h77jSecm+MDMMC6r6xqG+XckV3I5cs
         j+BDdQUuBI0HeAPJI9/2r2hP/UxlSYqXn+zSS/UGE/z5x4YIORfseB8cfpjZyyRQokzM
         QaFy10fSn8vuXAudMO5k7eXs2NKXH3dzKHSe/5WSV0ZG+rK3+zDzSdALX22uZRdmbeRA
         YLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714103006; x=1714707806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjep24xOYUjfKLkGIt5Xg15kGd3msBByaQ3pAIEh0mM=;
        b=SqBZrVPC7f1cidsARClFSVcKOVHtvs1EWZluydzX7sFnCNi2GAqmt6v/bPC919cYjV
         7cloaxUIoZ4dyRuEqC7oBaoX8OMu7RvdsDOeSwwoe/BJLmzlb095BNdHyEi8smc8EpVX
         QvdIyOqJ53mnY31C5441PKympuo6Zui0wS7kF2qeG65WHmDZPgQ8fDz6dugAOUcsgm76
         cTS1P7337viIQHgTOXlkQzD1IzrjzTqgxLKrUudBBdmcl2FoSPWsWHOHWjCDz2XNbp4D
         kDkDM7kzCaWua9ToKEHOidQKO7tMO6xOA/WYA17s6PawlnSiGB2WGQkR81Hj1huvBdLs
         RNQA==
X-Forwarded-Encrypted: i=1; AJvYcCX0Xh7Y26NqPouPNgHzpFtDCpl3vC9O2sWc3yaa62STJkwWo6QC6xeG3yNQYTumNbYoFAk2eHgIzgdnny8oz1MfMuJr5N1KRqDhJfN9
X-Gm-Message-State: AOJu0Yzum7YpLgs1M5xAZ2Q6WwOlEXyay6RRd2FiTpxoKIhLuiCYfc14
	z1Vc29B77Tx35fiwPejXhzacHUGb2Esb2JXvecxDy/YlPjlw6T+duRoyg2qhk4w=
X-Google-Smtp-Source: AGHT+IFuoNJDhVkOL87F6xMutiaC8xqNWrWB8I1N4j8YVN/IGWVNHKOf3F9BvXbF9SFqhbkbEzFqrA==
X-Received: by 2002:ac8:7dc1:0:b0:437:9877:333 with SMTP id c1-20020ac87dc1000000b0043798770333mr1787129qte.35.1714103006289;
        Thu, 25 Apr 2024 20:43:26 -0700 (PDT)
Received: from soleen.c.googlers.com.com (129.177.85.34.bc.googleusercontent.com. [34.85.177.129])
        by smtp.gmail.com with ESMTPSA id c6-20020ac80546000000b00436bb57faddsm7540815qth.25.2024.04.25.20.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 20:43:26 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	linux-kernel@vger.kernel.org,
	rientjes@google.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev
Subject: [RFC v2 0/3] iommu/intel: Free empty page tables on unmaps
Date: Fri, 26 Apr 2024 03:43:20 +0000
Message-ID: <20240426034323.417219-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog
================================================================
v2: Use mapcount instead of refcount
    Synchronized with IOMMU Observability changes.
================================================================

This series frees empty page tables on unmaps. It intends to be a
low overhead feature.

The read-writer lock is used to synchronize page table, but most of
time the lock is held is reader. It is held as a writer for short
period of time when unmapping a page that is bigger than the current
iova request. For all other cases this lock is read-only.

page->mapcount is used in order to track number of entries at each page
table.

Microbenchmark data using iova_stress[1]:

Base:
$ ./iova_stress -s 16
dma_size:       4K iova space: 16T iommu: ~  32847M time:   36.074s

Fix:
$ ./iova_stress -s 16
dma_size:       4K iova space: 16T iommu: ~     27M time:   38.870s

The test maps/unmaps 4K pages and cycles through the IOVA space in a tight loop.
Base uses 32G of memory, and test completes in 36.074s
Fix uses 0G of memory, and test completes in 38.870s.

I believe the proposed fix is a good compromise in terms of complexity/
scalability. A more scalable solution would be to spread read/writer
lock per-page table, and user page->private field to store the lock
itself.

However, since iommu already has some protection: i.e. no-one touches
the iova space of the request map/unmap we can avoid the extra complexity
and rely on a single per page table RW lock, and be in a reader mode
most of the time.

[1] https://github.com/soleen/iova_stress

Pasha Tatashin (3):
  iommu/intel: Use page->_mapcount to count number of entries in IOMMU
  iommu/intel: synchronize page table map and unmap operations
  iommu/intel: free empty page tables on unmaps

 drivers/iommu/intel/iommu.c | 154 ++++++++++++++++++++++++++++--------
 drivers/iommu/intel/iommu.h |  42 ++++++++--
 drivers/iommu/iommu-pages.h |  30 +++++--
 3 files changed, 180 insertions(+), 46 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


