Return-Path: <linux-kernel+bounces-15353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAD5822A90
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3252B21D96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF28318C14;
	Wed,  3 Jan 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCwGbdWI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092E18B1E;
	Wed,  3 Jan 2024 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bb9b28acb4so6928926b6e.2;
        Wed, 03 Jan 2024 01:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704275427; x=1704880227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aEztFZJsrJ8YqCwVoGZX/9s/oSP+HNIXvJUA0ruhjFI=;
        b=nCwGbdWIoQyzcL7T2sAM2Qj+p/0u6MENSBjLeTdyGJKS+an8VAGBqD/fN5MGau6lsH
         neyAz8uuE4r+MZBF0UTmRIKnm0Wu6H8d0PGKpD3i/Lz2xYHfI88ChfXiMrLDd2dxGPw9
         IYtwifNZ+I0kyVzW8yI0+KoEveZa7PUhAXx+zdaF1tvbYQnpYanZplcO68JO9O1NXZkY
         ajq+BvmoTQJ9a7g+Ij0uBUAfend87Hp2ZF1hrFMhlcFIDU6pxQMI1bh93jhIZFmNSzHT
         YRSoMAMj56ETaj3yJObMoEcthMWTFmuEPczTlwfWgN8qe+xMIKVWn0M9e4PsYR5Tsnf6
         RriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275427; x=1704880227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEztFZJsrJ8YqCwVoGZX/9s/oSP+HNIXvJUA0ruhjFI=;
        b=H0Nnx2tzOQgNgSEX9BqpK909PWPtBYJH1yZ2BAv5nNCFbi2Aq4iEDQ8OHPs8m69PbO
         csGunKZ1i7F+2IxaBBx+WZpeY6ri4gHIunFD8Fnn8neyqDaVb6/nD4DrhTCOc4kXJFGR
         X23ZHxyl0wpnygfU/i0w8AwP/xkwud1MROjWAfLhk4/dNhUCB8thF1JhNzfcDpNuOonL
         y/2zWUa3I+2SkMYn29bBj2lrio7WRMq6tY7Bz2NHFaNrqH91Em4+DlHzR4UWeisH+Nqm
         hlrVaP91Lk1wFhDFln2kUnW5nwVH831Sqs04nQ8ILi1DWSX4CMVP+yRj1Q3mh0D0BfLA
         zzmw==
X-Gm-Message-State: AOJu0YxrllxB3bpHI025uHxqNOsIMQPpUql7pi8b+kquE7gRVg2gR7Ca
	MZEUNIM5NDNuKHItBU+nQIY=
X-Google-Smtp-Source: AGHT+IGJyT3iyh5T+AI2zkgdvra2Kul3OKNzrR2xwTy5aGqOVkM9d9B6vjs63GPMXB1xk6rIoOxtgQ==
X-Received: by 2002:a05:6359:669a:b0:172:e402:4243 with SMTP id so26-20020a056359669a00b00172e4024243mr13698729rwb.59.1704275426915;
        Wed, 03 Jan 2024 01:50:26 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a7d6:f37a:9130:cd96])
        by smtp.gmail.com with ESMTPSA id a34-20020a631a22000000b005c65e82a0cbsm21823483pga.17.2024.01.03.01.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 01:50:26 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	akpm@linux-foundation.org,
	ddstreet@ieee.org,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	linux-crypto@vger.kernel.org
Cc: chriscli@google.com,
	chrisl@kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	yosryahmed@google.com,
	zhouchengming@bytedance.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH 0/3] mm/zswap & crypto/acompress: remove a couple of memcpy
Date: Wed,  3 Jan 2024 22:50:03 +1300
Message-Id: <20240103095006.608744-1-21cnbao@gmail.com>
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

The patchset is based on mm-stable.

Barry Song (3):
  crypto: introduce acomp_is_async to expose if a acomp has a scomp
    backend
  mm/zswap: remove the memcpy if acomp is not asynchronous
  crypto: scompress: remove memcpy if sg_nents is 1

 crypto/acompress.c         |  8 ++++++++
 crypto/scompress.c         | 35 ++++++++++++++++++++++++++++-------
 include/crypto/acompress.h |  9 +++++++++
 mm/zswap.c                 |  6 ++++--
 4 files changed, 49 insertions(+), 9 deletions(-)

-- 
2.34.1


