Return-Path: <linux-kernel+bounces-72423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617E285B312
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1953D283E82
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6D35A0F7;
	Tue, 20 Feb 2024 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJejcPYB"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E975A0EF;
	Tue, 20 Feb 2024 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411474; cv=none; b=PjXGORHtBy4yD3czMSY+BIIG1UaLAupYsGf6FtRhncod+uic6zWydoUMsrQbq6+ESP8fVkl4VcgEWu7kNsvMgihO0ZomV4Pfnp7yvvSlJHotG9FWOeujI4tcmMaklofUXynR4Kn6iagekgfW1BISTPGPX0B7WEIF0KHgohGG68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411474; c=relaxed/simple;
	bh=plNZ7tcdc54Xd4MJZqot88ecKS3wEhJAIerrdmq/8Ac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U9QtOWuPKF/knpzAWHv7bZ4NVU0W6UDFjyTPYTX9WX15lCHaDhDVWxNgxrHu+iTP014Oq6+WeKXQaW6KJ7PGHS2Ni5xxEdMVsDd50ESSv6F2g1APqhgxOyUlEa6OYSDxWJWvJ0CCEdmZamDwn6dxq6iBoWPik83fF/hEN5YHDjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJejcPYB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so8080135ad.2;
        Mon, 19 Feb 2024 22:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708411473; x=1709016273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i2aL+tHLY0VW/P/ruhh4nglplL/Lhxc/gUkBRs4GoYc=;
        b=KJejcPYBnEapD/bJUB8S383Cmz/ggX3C4r/8uQc7zmwd+qeA0PKLajrPCKgxGWd48h
         SO9fqgYwgGBPldOjik+a42pO/NtJ1shDyLIppAbXK4ofjNNs0A+r4JVGLmmRssQ8HsSR
         G7A20Y94TYLF5yrZ0bqzZ89QjFMKfbUeY+3VRf2owz3S6SfLrRUUGDnIHydlQSkFstxA
         fBN1Txqks+P39av7B0gglVyIowa1xx5twNWk7xxUlB26PUII+pfaymJGGwG59306XFse
         onIDULXrFRWz3OGy/fpsqKCicY/xo3IcPj5jAYlwnMBiS5bF6Vku7xVA9cCOLCUbA5w9
         uZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708411473; x=1709016273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2aL+tHLY0VW/P/ruhh4nglplL/Lhxc/gUkBRs4GoYc=;
        b=pZYo1bYxGvoBNtU8jy84i318FyC5yCRgo08NqnBx61CPwDp1i/Hxn6mw2FjcjILYLX
         ClDDxjxT9GCGqDsHesnixaimZbMr02PGvfUZrHJbP+c7f6USiFW9o7BzOFbLnc3Y4W8b
         9FCSIuGbf5CIdILFeJD8XtqOTUYoxiaenDoBK5GuQG2l/AVz82pCTI9Qdwi7NxwCzKTA
         gSVifZW/s2pFa3M9/9UZCjcCwP98mTwPmzIECwgRA+GAzh0k34gNBySoRr6iCYSqzGiN
         PwwYjhkETSq8fk2G+z8iPcdmpm11iHGoqhTq+CmLRkawxVqjNff+ljl8AMUfMx+WDLhZ
         89Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWR0vfxjsMP35emRk3zPuloRrO2Bquji1quwClxTHJl/y+JZK+sj6sqM8+SqkEi/IQj2MR8jHjxi94Sf3msBN/NLNV3OKSNXQwydTzfzr6TlVujlAIguGmFXsNyRj3nFRefCY6/NRSPW3sD
X-Gm-Message-State: AOJu0Yz7lhthwSiBuUzffqgVm6QlkZDxSwTr76YuYteMPlmDrJ4aVR0l
	fjWNq9RjvJYJog3MVP3t5VwZiub250luzZ7WRrho9HtJAFHj9qpJ
X-Google-Smtp-Source: AGHT+IEitGa7GaedpJW3RDJe4mFVNHXIAb5Z1qrfL/aDfUYmWhkNQLmwyuspBkLd6MZ1/Npg0zW5sw==
X-Received: by 2002:a17:902:c402:b0:1db:3a22:1fd6 with SMTP id k2-20020a170902c40200b001db3a221fd6mr15979321plk.66.1708411472707;
        Mon, 19 Feb 2024 22:44:32 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a5bd:9c11:af2b:aecf])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709029a9000b001db60446abdsm5419090plp.262.2024.02.19.22.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 22:44:32 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	davem@davemloft.net,
	hannes@cmpxchg.org,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	yosryahmed@google.com,
	zhouchengming@bytedance.com
Cc: chriscli@google.com,
	chrisl@kernel.org,
	ddstreet@ieee.org,
	linux-kernel@vger.kernel.org,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v5 0/3] mm/zswap & crypto/compress: remove a couple of memcpy
Date: Tue, 20 Feb 2024 19:44:11 +1300
Message-Id: <20240220064414.262582-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The patchset removes a couple of memcpy in zswap and crypto
to improve zswap's performance.

Thanks for Chengming Zhou's test and perf data.
Quote from Chengming,
 I just tested these three patches on my server, found improvement in the
 kernel build testcase on a tmpfs with zswap (lz4 + zsmalloc) enabled.
 
         mm-stable 501a06fe8e4c  patched
 real    1m38.028s               1m32.317s
 user    19m11.482s              18m39.439s
 sys     19m26.445s              17m5.646s


This patchset applies to mm-unstable as recently zswap has
lots of change.

-v5:
  * remove the helper of exposing algorithm flags, alternative directly
    expose acomp_is_async() by test ASYNC flag according to Herbert;
  * remove the fixes of cra_flags for intel and hisilicon async drivers,
    they are separated patches[1] according to Herbert

[1] https://lore.kernel.org/linux-crypto/20240220044222.197614-1-v-songbaohua@oppo.com/

Barry Song (3):
  crypto: introduce: acomp_is_async to expose if comp drivers might
    sleep
  mm/zswap: remove the memcpy if acomp is not sleepable
  crypto: scompress: remove memcpy if sg_nents is 1

 crypto/scompress.c         | 36 +++++++++++++++++++++++++++++-------
 include/crypto/acompress.h |  6 ++++++
 mm/zswap.c                 |  6 ++++--
 3 files changed, 39 insertions(+), 9 deletions(-)

-- 
2.34.1


