Return-Path: <linux-kernel+bounces-157010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0976B8B0B88
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD81286FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F5615D5A1;
	Wed, 24 Apr 2024 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1rdUHy0"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE2114A0B3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966776; cv=none; b=qNJyP+WnChFI49ltGg3VjH36OuJNr6IR6qeZ9m+GWzACndjg3iODNwBdDo0Z108K4LgJOtBpeFSbZt8Hujs+eMjLNIO2DXaxEi2qXeWPMs7IKCsFHp1uz/4ZpxwfagnxWPTS1LhKA/bZjl+BItZ/a8l5JUJVeONzOtVupf/RYzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966776; c=relaxed/simple;
	bh=USPWKhRStMy5yEsbhnsn+DZky68KVsIh8pE6KFyCWbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HvLiqXH+QQ5absidO5KHrbXeUWAmt83ww6trvSEZR2zG2zcqtCqM4bc3kjaDKrk3IV3NHTEGjXkxNgi5vDu8dgKPf5LY1Mx35EUolBk3VG56VW/pLEuNLsfv2Lyv7q5Cw97f4cBdaqCTUNDYB1wh77KjKFIIz7rkmKzBv5kei/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1rdUHy0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e9451d8b71so34087065ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713966775; x=1714571575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQTNzvf5GW9mOOhD2D/EI1Af/BZi/6EZJINWfEn3RP8=;
        b=K1rdUHy0wgYzAjQtp+klKDSagTeU7gp/WqBXk495Ci3ahm0Rlm+8e3Ar1RGM9OG1Pg
         jGsY0NfqjVHlLfettfOK4p9G+FvJ34o9yPoS6X4a2QCHTfvE777krmndHuja8YswpNXN
         d0wxWJke69HkaC0tLZv8r2YaisxC6ELKIjxJVVLnX+C74tNMXcBhntYcj8JQSxAKoAqh
         xfsSr6t62Gf7fu6qxUsEUAfg/grNAGJ1YhQxZRjKjSqAx/F+DuBKdOmfTCFEjBScLWbB
         Kk6mNs7P3vzHGT32aY4RKS162OmF90/6nCkl9A1bfXNUS1O+uH8c6IPx7kZjyZMLSCHf
         15SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966775; x=1714571575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQTNzvf5GW9mOOhD2D/EI1Af/BZi/6EZJINWfEn3RP8=;
        b=Ow095uZhkh4PVor8lmD7EUNj7oAkm745B2kSVVWtQpccrbua1dx4OCm1rchR7ZmOHN
         e/6Yp9ep1+7BqkoEX9d+/5Q4tJYkwYqGAmw8X6O5QnJfjFUmqKSkj93JK4bxUQUjEbLb
         3acJ7Y7rx7xOReuXlPeun4LjzA1sX7xzQN64o9qqJ143SI9NdHJOI8l6MNxFCz4NmXr6
         GZWDamA+Q4rUYAv1MBQHU64JSCCYeN4PcBJtBDMSFkRnStjIIlVFb2eJ81ygndZvzB57
         FDLWeHOufKT1aCSdwDpY5YGXBacZye6IMqt9irL0rpV5E/nf5GSVFMNAyQZepDtdTQMY
         NX9g==
X-Forwarded-Encrypted: i=1; AJvYcCWWbljLpmlpAZxbucnwCOt1zWggEobCkR3Juy0zcbkU8DBl1GhnosEh9wKeBTJAT9ZehmL4rc+NTvVl34qocXoZzCjoOfvKDxaSs/B+
X-Gm-Message-State: AOJu0YyK13UrYcaqLE2mpfz3dVo41zYoKbv4GovUzDhz2io1BX/4gW4g
	I+KB0GWHKf6HB1VRYiARRKSLq/ysx60Mx4NSli/k3PtnIeyXX3Mj
X-Google-Smtp-Source: AGHT+IH4PwCvrV2DDgiYRyPxda7sjbopLsIypSUYMZATJ4IXqnD+I8NdGBfVhJxpFt+DN9+GAsxeYQ==
X-Received: by 2002:a17:902:d50e:b0:1e4:3ed8:e264 with SMTP id b14-20020a170902d50e00b001e43ed8e264mr3357855plg.43.1713966774830;
        Wed, 24 Apr 2024 06:52:54 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.240.252])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902d48600b001e89c729843sm11140235plg.228.2024.04.24.06.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:52:54 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: 21cnbao@gmail.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH 0/2] mm: introduce per-order mTHP split counters
Date: Wed, 24 Apr 2024 21:51:46 +0800
Message-Id: <20240424135148.30422-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

At present, the split counters in THP statistics no longer include
PTE-mapped mTHP. Therefore, we want to introduce per-order mTHP split
counters to monitor the frequency of mTHP splits. This will assist
developers in better analyzing and optimizing system performance.

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
        split_page
        split_page_failed
        deferred_split_page

Thanks,
Lance
---

Lance Yang (2):
 mm: add per-order mTHP split counters
 mm: add docs for per-order mTHP split counters

 Documentation/admin-guide/mm/transhuge.rst | 16 ----------------
 include/linux/huge_mm.h                    |  3 ---
 mm/huge_memory.c                           | 14 ++------------
 3 files changed, 2 insertions(+), 31 deletions(-)

-- 
2.33.1


