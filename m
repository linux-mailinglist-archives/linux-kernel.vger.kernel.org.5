Return-Path: <linux-kernel+bounces-68044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3B3857543
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A28ABB22B42
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9CC13ADC;
	Fri, 16 Feb 2024 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blgXYit6"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82716134A4;
	Fri, 16 Feb 2024 04:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708056531; cv=none; b=KkOvA5LFevt6q4BnvztUUS0Dxk7pJBvfTCycymUyvVnlL/zCT+Nnd/Bvlrs87LuYvj8R4/dpeBiJTO/2VB7tMsjKNsWj1OhhafZHAVzwXV1r7JuLo7BK68x3dtJ7eFSniuguYFmZavzpGHpJ7u5UwP9t4jeDi4Ucp8rQFaDcECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708056531; c=relaxed/simple;
	bh=vqVfXZrYe/yyq7Yk1lGwJ/c9MmJ5pqN2j4VN9jcJ7MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZsVMW0TILDaL/a24yuHv054maRE/u8q62nojO9ov4KXEzbc7W8fmdFcYY5uGWzHk4/NUBGiEbQthikwdXTwvFCCrZXluhypsXaG1+uYb179oCPsD9FnxvugT4cGTD/Fc01jOXVRfZTsWFEWf2bUAaDGpFXPsG0EufcaUOcgrkFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blgXYit6; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-295c67ab2ccso1350944a91.1;
        Thu, 15 Feb 2024 20:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708056530; x=1708661330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gIkxtNMiM4jWMz/QymqiYWPEEBA3/zmYvJ0m52F/Sw=;
        b=blgXYit6mmBEwvzVh/044cAmoIspxnStGDcwogdlUL9Nhb8O1Tdr1uoO+tWLbUZdrc
         EnQssfXOX0rtJlS0BdvGHPemmtkWWWiJPBDWdlay5S/boKcl9HmtCkASoIDPt8Wes2TC
         5+3ZrkHs34xpwEq3EqnzIUhTsmNYMkO+QUOJwZU8cT8ePnuTLJBNJtDi4Enc9y1zxlDw
         /rEeTNc4vJcHYSYaKq2TXzNCpLNUQQB0+ogEuji8NRaqdCb9Wgmyx7mOaPnpKX/Y16MO
         BjSYl16KUMTLPgogxH2g7w2PfX0FqF+isxo6mxb4swUOJK5OsdGmDNiJEb8XcR18gNUl
         rNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708056530; x=1708661330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gIkxtNMiM4jWMz/QymqiYWPEEBA3/zmYvJ0m52F/Sw=;
        b=MYzPtfV2UkanZDcAGlV6IaM3zRXT0yLukycqOyWM0LiPBDfsqPVxucXiqfzps6DbXp
         FCSxRn7K0n6cg80mnGkYdPKvqCG0dp/EVRrqbtWRVAGY5gprqAx+DpN2ZtLreV2/gPLh
         omlcDDp5bPCLBnBhg9icgL84E+wfOXqdhzH6dMrBwXS0QUtV5zUBn+ikyoS9yWF7yQ8I
         HDJ982asV5cMvA5u5DY5B5TACtUDlMkFS3yDPhOp8yfxE+TTRFwA0PEBToiDc2XYEIZS
         YZRoWN/Y0e/7Ws3zLHgbMAsza/KS2bkiMge3b31zNsOr2nK+fQ3rd7RTUXhv4JohqAjT
         uVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWVz/q9gHWFNvXZGMqzWolAY8UlvhGV0JzH78Smpt1vTmUG64NieZHUSgdVQa7WhBTgNvnjuwKqzq9nb60xW+zzDIsfIGjj5uBOa/WuhLJpG0Vkmggpor72T5ivqf0hwnsMUtORXqZCYHd
X-Gm-Message-State: AOJu0YzgB94k+6PRVUDhyj8pMF5KKu/uQXTs+7OBh9MBA8sy+tDzXIBt
	EFq8q+tx9xi4zv8LFwg0zMymLhHN3Kjam/XxbPdq8BuOifZSKdov
X-Google-Smtp-Source: AGHT+IGAeMakd3Fn/lSdvXKtNpwx3rj2aLJGuDgaufePUPLOyq3lT5SfwNYhexb0cGxh8XNtSZqHmg==
X-Received: by 2002:a17:90a:fe15:b0:290:9e9e:a87e with SMTP id ck21-20020a17090afe1500b002909e9ea87emr3514685pjb.42.1708056529701;
        Thu, 15 Feb 2024 20:08:49 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:f28b:3925:777f:45d4])
        by smtp.gmail.com with ESMTPSA id pt12-20020a17090b3d0c00b00298ff26e4c8sm2321393pjb.26.2024.02.15.20.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 20:08:49 -0800 (PST)
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
Subject: [PATCH v2 0/3] mm/zswap & crypto/acompress: remove a couple of memcpy
Date: Fri, 16 Feb 2024 17:08:12 +1300
Message-Id: <20240216040815.114202-1-21cnbao@gmail.com>
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

As zswap is the direct use of this patchset and zswap benefits from
this series, It is probably better for this patchset to go through
Andrew's mm tree than Herbert's crypto tree if there is no objection
from Herbert.

-v2:
  * add flush_dcache_page() in scomp_acomp_comp_decomp() according to
    Herbert's suggestion, thanks!
  * collect Reviewed-by of Nhat, thanks!
  * rename is_async to is_sleepable according to Yosry's suggestion,
    thanks!

Barry Song (3):
  crypto: introduce acomp_is_sleepable to expose if a acomp has a scomp
    backend
  mm/zswap: remove the memcpy if acomp is not sleepable
  crypto: scompress: remove memcpy if sg_nents is 1

 crypto/acompress.c         |  8 ++++++++
 crypto/scompress.c         | 36 +++++++++++++++++++++++++++++-------
 include/crypto/acompress.h |  9 +++++++++
 mm/zswap.c                 |  6 ++++--
 4 files changed, 50 insertions(+), 9 deletions(-)

-- 
2.34.1


