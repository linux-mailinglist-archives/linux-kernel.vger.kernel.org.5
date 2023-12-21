Return-Path: <linux-kernel+bounces-7799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764B581AD28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E031C226D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC724C64;
	Thu, 21 Dec 2023 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CNMWDCG/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C369B4416
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7811548d0b7so16413685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 19:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703128758; x=1703733558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ghdfdvj5dTvmX90o5EKDMFpbNy/cwlZMLwYqTLMlBw=;
        b=CNMWDCG/RVrfsVZIPCm6YfJJd8W+dCZ9Sx4TF5NzBsufl3wbh+a64Wkm9tphnA5I7G
         CELiS80qWUlCRIcAifwKgW1J48HRq4GNS4UvBEU3reqtur9N8Y4EzYLgIGhnJR+oVf89
         XI4tMSKE1yT5eZPs/LU56OVzjwoA5j5z4wjBw5XHQ0281xJaldnKZScw2MgFZ2aRdwwr
         G6lbG+WW/CCXo1HcgNrYnZpAsWxWN4bAK/0J7MKcIEIbB0ZJnnahWtd5Hyi0OJjpdWmw
         sAvVG8ebqfDAmqZv6P17ej+Hg0iGpuLu5OI8xpl6FeaHIo84ICh67joiN+cajStLbbmw
         trRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703128758; x=1703733558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ghdfdvj5dTvmX90o5EKDMFpbNy/cwlZMLwYqTLMlBw=;
        b=SpNm8O91ZqH5X4+mcLpYgzazcCVvHrIAAAJEJdlTQ+MKPTRJVO2mDjKgjExest3foz
         /bQpfPnYgzykPAKn7nTNoOMa+IBGrPAD5W4jHHRm+4RuvKcGHwEtOdiU1qjYDAimSCsE
         +z2K0B52/poll9rXQoa4DXVU3EOHIk9giIludUs+m9UmfGl0QZ40ZZOy48pBeaigB08v
         LAcIBP/gfvFzUXShCH0xAKeBjFT/i6QQzcw6h2Dzm3cOMQpKOHWTwLla0RDOgSQaA8sd
         Mk+GI8sR9HbLqKRIkTBHwe1/AMJgvGMA9yKSXvaJyu3OoKVKy9Ijwd4VpfCWR6t/aGWL
         cW7w==
X-Gm-Message-State: AOJu0YxPBPLFzL2GtV64pa87V2cYtQI8fqRTjZSYn7eNInIuyb70/QQD
	wKQZ74MdAs4ARhmvT6R/ftxVqg==
X-Google-Smtp-Source: AGHT+IH265HWEA86myqkwiq6DXT5J8wsiFwkQyNOE8yBUQ22blsKxbZ6TRgp5oa7b51nOFNbspw3wg==
X-Received: by 2002:a05:620a:20c3:b0:781:129e:101 with SMTP id f3-20020a05620a20c300b00781129e0101mr1960327qka.37.1703128758561;
        Wed, 20 Dec 2023 19:19:18 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id m18-20020a05620a221200b0077d85695db4sm371893qkh.99.2023.12.20.19.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:19:18 -0800 (PST)
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
Subject: [RFC 0/3] iommu/intel: Free empty page tables on unmaps
Date: Thu, 21 Dec 2023 03:19:12 +0000
Message-ID: <20231221031915.619337-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series frees empty page tables on unmaps. It intends to be a
low overhead feature.

The read-writer lock is used to synchronize page table, but most of
time the lock is held is reader. It is held as a writer for short
period of time when unmapping a page that is bigger than the current
iova request. For all other cases this lock is read-only.

page->refcount is used in order to track number of entries at each page
table.

Microbenchmark data using iova_stress[1]:

Base:
yqbtg12:/home# ./iova_stress -s 16
dma_size:       4K iova space: 16T iommu: ~  32783M time:   22.297s

/iova_stress -s 16
dma_size:       4K iova space: 16T iommu: ~      0M time:   23.388s

The test maps/unmaps 4K pages and cycles through the IOVA space.
Base uses 32G of memory, and test completes in 22.3S.
Fix uses 0G of memory, and test completes in 23.4s.

I believe the proposed fix is a good compromize in terms of complexity/
scalability. A more scalable solution would be to spread read/writer
lock per-page table, and user page->private field to store the lock
itself.

However, since iommu already has some protection: i.e. no-one touches
the iova space of the request map/unmap we can avoid the extra complexity
and rely on a single per page table RW lock, and be in a reader mode
most of the time.

[1] https://github.com/soleen/iova_stress

Pasha Tatashin (3):
  iommu/intel: Use page->refcount to count number of entries in IOMMU
  iommu/intel: synchronize page table map and unmap operations
  iommu/intel: free empty page tables on unmaps

 drivers/iommu/intel/iommu.c | 153 ++++++++++++++++++++++++++++--------
 drivers/iommu/intel/iommu.h |  44 +++++++++--
 2 files changed, 158 insertions(+), 39 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog


