Return-Path: <linux-kernel+bounces-69679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3253858D37
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114681C21228
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9371F1C2B2;
	Sat, 17 Feb 2024 04:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWnLD0yh"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2933CA;
	Sat, 17 Feb 2024 04:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708145483; cv=none; b=Ibn4WBu4v/8Mj7sUPd8fjc+9ZYtHFNeYr5uu220Ch2qoQH/KPQpCKPRmNGillP8JiDRiRnmD+QOx2kMZXV/RNNMegoAqBhjzOPNthkjGcUkZOSBSdKmTf4c5Gy8veKwkA0s6+EZEQjqk73AJL+kUfRXvFbPpCkXgU/V9fRU9CaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708145483; c=relaxed/simple;
	bh=Qw6R8pfDRKknVO5RFsZ9GZFCMdOkP05AOnLES1xLe3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xu8wuxzQFC0dBaEc0MmYuLssLEFlm/30rna3jW0tB+0A5o3sBBOr5+osLzKSRSGdzr6LnEWRd74ptk4DespuWYAltYXEO826cgEW+YRmmIMlfNFd8IjD0bd8jWtImGoYw8hTxWGspx/YAumTmStuPJiChzpyMZhyCS+RiZStHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWnLD0yh; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21e085b9e61so1473034fac.1;
        Fri, 16 Feb 2024 20:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708145481; x=1708750281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MNOBgtxjdzfRlEyGVe+9BRmZDkEvX9p4KtMFsgHAFh4=;
        b=EWnLD0yh+WYeJd0EVu4O8VUBNSgYyFJdpyICgKGtFwUJmEc24srpnRV1zNoVjDdMUe
         kiAvjKps3zqbuB9+W24ZcJbaie5F4vo/uwI1phvFAp2ih/d/CQqa9LwKASw4N+l9Zd/K
         dDpNA3Rf+dYasUydBulTO0ShQV3xu6f5Uiuur0bulJLqW3LsOBdKcq2jeRwzxVwyDhwH
         AgDHq6+QrtCQeQZT/33Vk3rkGRrAnkOcZ2tM1RtfJwqX1cSh91mYzBYYvfLA8h+J0KLU
         4eFHRRlYMsy9neFh+CW+Xh3ulFDWGv++1dkY3I7ptyphD8n74p895TiyESFnw2Zm8ttt
         sCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708145481; x=1708750281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNOBgtxjdzfRlEyGVe+9BRmZDkEvX9p4KtMFsgHAFh4=;
        b=bejGHx0Gd0Gno7E0UhUdGhCyO8PQsQu/Ln/UOWMCWU2aUh7Lgn3/fCiTv45jn4NGUw
         HHKIJfQjotwGM/yVuDlJnW9e+JkhHad1F+S2tru730H/A1MI+U2FIEppV1GW8WwxGgX+
         PA+pfaGiWglXvDVULNpmJaB8OIcksD9RX2y8j3b/9qZ33zzxeoqFf3bOlmC7OckpwWNr
         S1MV7yz7QkDIo18yqX4jfQZdDQ7ba8Zj8BOwHwJJqmPph+UHdommW6Tw0pNqKp4N99np
         pEHE03LHDlE2dHyRsAHkh8x8GA8+Cl1Em8hIvHRJdHwmkQUVp0WFgd1V0dmIxMVannat
         EJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+/EI1nX1PlTXocXAUQ+/eh7oCr5/ftb9yZ3SFpb7EnbKBfcJ1BaX4+1tx224Iz5n9y2PKBGJVDdlE6mSOpo/GPfWm/IS0qFcXfSDsiSdUjbDnF4FRWM9aCHaT6gh2mB2E3fTuIe0U3fSL
X-Gm-Message-State: AOJu0Yy7OvmuuoOCdrlIobZ30rXh8NYU2wx8a4tkPB3jl7zz0vO4GZB6
	0RkeGDTNGn3zDW00p9zxbMQT9rFwyAMF5Mn1MyyNfjfUXGKSXsFr
X-Google-Smtp-Source: AGHT+IFgDSQJ8AJcEw2iGomSXji4WMGKVF3I6ZMj2AHljsVZsd9dVexoTSkScldRN6Oa7jw2L7sdGw==
X-Received: by 2002:a05:6870:56a1:b0:218:51dd:d4a6 with SMTP id p33-20020a05687056a100b0021851ddd4a6mr6971333oao.43.1708145481312;
        Fri, 16 Feb 2024 20:51:21 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:e82e:22f2:1bdb:989f])
        by smtp.gmail.com with ESMTPSA id n14-20020a635c4e000000b005dc2ca5b667sm610703pgm.10.2024.02.16.20.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 20:51:20 -0800 (PST)
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
Subject: [PATCH v3 0/3] mm/zswap & crypto/compress: remove a couple of memcpy
Date: Sat, 17 Feb 2024 17:50:59 +1300
Message-Id: <20240217045102.55339-1-21cnbao@gmail.com>
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


-v3:
  * collect Acked-by of Yosry, Reviewed-by of Chengming
  * enhance commit message with respect to Yosry's comment

Hi Andrew, Herbert,

As zswap is the direct use of this patchset and zswap benefits from
this series, It is probably better for this patchset to go through
Andrew's mm tree than Herbert's crypto tree if there is no objection
from Herbert.

Barry Song (3):
  crypto: introduce acomp_is_sleepable to expose if comp drivers might
    sleep
  mm/zswap: remove the memcpy if acomp is not sleepable
  crypto: scompress: remove memcpy if sg_nents is 1

 crypto/acompress.c         |  8 ++++++++
 crypto/scompress.c         | 36 +++++++++++++++++++++++++++++-------
 include/crypto/acompress.h |  9 +++++++++
 mm/zswap.c                 |  6 ++++--
 4 files changed, 50 insertions(+), 9 deletions(-)

-- 
2.34.1


