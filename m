Return-Path: <linux-kernel+bounces-132825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F098D899AC4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA7A283ADA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9B11649D7;
	Fri,  5 Apr 2024 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQJneVy4"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4138115FD01
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312846; cv=none; b=jhKFJ9aBkUYJSZxWRG2ZNS1fNXpPKCW//llA/PrbbPCartfjPEEnq+mtjAVAsQrCusKWwg1HtbLfdZLAsVSA2SgkMkRXO/qe1tbKiIL+Kg2mNvqTeVO4cUyK98b1AKbS1kn6AwFu5qFguIB2Qi4BuopqYyywt9zcUysfL8W2l7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312846; c=relaxed/simple;
	bh=pyc7TjpkPpR0rH6i087VGjA0xTNZEkUeZ8hlo4WPxXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PlAjX4XiBTwCO7nHNhUeyTEJ3YbBrXiWUmLmZsH3TlZwkff+MCUukoSd53ugXi7LpihXksFpu7J8wcKLed8Rr+7j9LjA9YHJW3rMxCSj5hFKCGm7L+n9Q0DR8B+xKi9BKDiC4Be91gCIJ5XDfRVxHEdzsFMKA30zPvOz2Mf9NBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQJneVy4; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecf541e19aso1079993b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 03:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712312844; x=1712917644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+cCaEOLaErwuf5tcHLIqV1Amnmp7sGSN9nxshP7k9Y8=;
        b=gQJneVy4gheDX15YM6QI8zo1YYNFuTothtV8vam5rhgM7YWaEUBeI3pdAAzK4aR7m3
         Hc2qKGzxI4dSjFYubfYCrWDA+mQmG50mB5Mm52CKyTHETDXMAmlHv4gAF7RRdbA/+GvP
         yZI4smR/I5Fr9ul+2Wl5scv1mNh/2GSLmH6GzxDmW99txdnV7t/Pz2/oAxvjCxfOyXnV
         DwqRox5E7J2viqINjTunOs3GXiQzVCYUcq4+SvytLOpF1NUgQs8jEstyd2lPdrfs7e/8
         iM/ExhhL2RORLO+m0q/7KJxKRmfEhXhhk5Tfbt5n64HfjYs74Y7uEuxQqnDkdpnFsHuk
         cuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712312844; x=1712917644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cCaEOLaErwuf5tcHLIqV1Amnmp7sGSN9nxshP7k9Y8=;
        b=O9C/HA5vBEQKcs7Pxil8EC/6rJ5mfi7TFMUEW7gHuNOsstdXiWGuGYcqQbWmZO0pcf
         BARqhaSW7y7UweyyrRXYGgn18E0PTdXiNeW9iTOk35trjbBqbmkytzcp79GJW0LGK/pE
         79rH9dVDCzS+TTt2rLl4eNBYWVmiV6Fw5ejXhKdW0y/UMtT59jbBWR197UV4etyGZZ2a
         ZNVecX2/w7ariaQEQsR9UmPkQC920PAarXUftileC/hmXxciw0YZOM8xbCNxo1PRfe7i
         9LlQ5NQzXxyZUR6PJ0QrwmnUqNynUaKblwvyd0yzue0lQsISW8MTAn5m4HkcPigldZQz
         TQtw==
X-Forwarded-Encrypted: i=1; AJvYcCX210N4XZCXkEwgc0oMs5cc0cvj88c1CLd+Jy6A6IMAxDbm5GR1DbkXhr0JV7+6JpJpUfY8EYBod0SdkAS7XgiA1g0KmGGXSIqEugJ1
X-Gm-Message-State: AOJu0Yyr4ntHmQZLzM1iZMxHdTqljlc1dKKPu2SsTPeBVtEmqCna4ntq
	I2kl+zhyTLEBxqmfVRohkTD6W7aa0LQm6knmaOcAs2TXq7fW5v/e+cjZqpQo
X-Google-Smtp-Source: AGHT+IHiwX+ZxZpVgNVm7bilvHtrmYTZJt2H2V/Mj8vfw6Mzz4kjncyNkLhAc5tRMzZX7e9o5Zuv1w==
X-Received: by 2002:a05:6a20:dd87:b0:1a3:ae4a:92f with SMTP id kw7-20020a056a20dd8700b001a3ae4a092fmr1060084pzb.32.1712312844462;
        Fri, 05 Apr 2024 03:27:24 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id f20-20020a056a00229400b006ed06aa3604sm113334pfe.82.2024.04.05.03.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:27:24 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: david@redhat.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com
Cc: cerasuolodomenico@gmail.com,
	chrisl@kernel.org,
	kasong@tencent.com,
	peterx@redhat.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	yosryahmed@google.com,
	yuzhao@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] mm: add per-order mTHP alloc and swpout counters
Date: Fri,  5 Apr 2024 23:27:02 +1300
Message-Id: <20240405102704.77559-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The patchset introduces a framework to facilitate mTHP counters, starting
with the allocation and swap-out counters. Currently, only four new nodes
are appended to the stats directory for each mTHP size.

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
	anon_alloc
	anon_alloc_fallback
	anon_swpout
	anon_swpout_fallback

These four nodes are crucial for us to monitor the fragmentation levels of
both the buddy system and the swapfile. In the future, we may consider
adding additional nodes for further insights.

-v4:
  * Many thanks to David and Ryan for your patience and valuable insights
    throughout the numerous renaming efforts!
  * Guard the case order > PMD_ORDER in count func rather than in callers,
    Ryan;
  * Add swpout counters;
  * Add a helper DEFINE_MTHP_STAT_ATTR to avoid code duplication for various
    counters;

-v3:
  https://lore.kernel.org/linux-mm/20240403035502.71356-1-21cnbao@gmail.com/

Barry Song (2):
  mm: add per-order mTHP anon_alloc and anon_alloc_fallback counters
  mm: add per-order mTHP anon_swpout and anon_swpout_fallback counters

 include/linux/huge_mm.h | 21 +++++++++++++++++
 mm/huge_memory.c        | 52 +++++++++++++++++++++++++++++++++++++++++
 mm/memory.c             |  2 ++
 mm/page_io.c            |  6 ++++-
 mm/vmscan.c             |  3 +++
 5 files changed, 83 insertions(+), 1 deletion(-)

-- 
2.34.1


