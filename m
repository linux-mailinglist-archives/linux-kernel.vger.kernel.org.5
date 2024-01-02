Return-Path: <linux-kernel+bounces-14856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ED5822340
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5207B1F23105
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26102168BF;
	Tue,  2 Jan 2024 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QTq0Bdpo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141E8168A7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbd7389572dso12612444276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704230839; x=1704835639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9mb89vCm3BKTU0DU+/TGy4Hk6L4CQ4i3DlNwc7INoo=;
        b=QTq0Bdpo60Ekqq2oYrLPhrRJXYQNZ4E2Yt6/noM/M+HB+sNtRh7ignNo9Cy3hIlekX
         mIWrMX9TIu+lqVnTmg2Ar22FQs/81LYhG5wd3I12E1oGKPsAOg9B3RaNoyj6dZBV2xNR
         cQbm94zUt6LPqNquQWih+umpryX8HK1QvDZ84f/pvZAMSc9ieZAoIJV5g2vEwfQ1fMu1
         Rtcuw6Z0fdR2Vyp7B+yxYkSmNetKobhTvewX+uqHyAs8Y4Vaij4LMnQHi5GDrRidkOBX
         GYkERIWBo6qnB8Lzxqz3qU7Req5wRfw3hhhfTTYDc/n6emJWdCrFXAMm0PR/rDhVX9Lw
         /kUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704230839; x=1704835639;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9mb89vCm3BKTU0DU+/TGy4Hk6L4CQ4i3DlNwc7INoo=;
        b=MPqSG2QaNuvY0JqbtiKNQQzUqL0Shj0q6K1c14DpAunS+sj3sGeg0nxudbFTdARGi/
         doc04hwOHLuNtoR4iP7tNSk/y7xxRsV3hWj/8n4+BR0HMYmfbM81IgWHWYnqhiCxfixp
         U7ZpI2k5dCSh4Bp7dpj5gEiolYKk72qHTdsHERz4aonFtPuiXIwLrAWc+stcGH8W15cx
         H/Q5c7XtxcWwYT8ID3kw7EbjD2SUQZ2VdGfQBVPvKKTZRpTWJFaGcm3XIysBG2k7jhsE
         VaRGnvtiMdHgYYipzhX/U/IArYbu7D+xzu6vOCxbr3q77gJThoktbXoFh3JxGcCan+aM
         uhSg==
X-Gm-Message-State: AOJu0Yxx0DivGLD4fLampE5Y1+TYThwpOtj6ZW/mv8Uck5aEgqJTCJb5
	29bIxzPDVihZALX1IxsRR4+DP/FxJJnCEslvM7TVIy0QxMDZZsIrv7YZpTvAZRXTXV6VH3Zz2XC
	KpZpsuMsaNmOzL2r6sReQHvmf3fwfNt96bInWPjM05A96kBS7nHDO965i4t1oHEZxgBjN8vih8K
	PS7AXOwaEZ7Qk17A==
X-Google-Smtp-Source: AGHT+IHi1x1vNvCy7nh5qrPZXCz13gCpMzojuxdWNRARprBd5bnr1TBEGPjAqihkEYX2n51UbHfc4n0C/Tpy/M+g4g==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:9a04:c262:c978:d762])
 (user=almasrymina job=sendgmr) by 2002:a25:8181:0:b0:dbd:2c5a:6c53 with SMTP
 id p1-20020a258181000000b00dbd2c5a6c53mr21581ybk.6.1704230838915; Tue, 02 Jan
 2024 13:27:18 -0800 (PST)
Date: Tue,  2 Jan 2024 13:27:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240102212716.810731-1-almasrymina@google.com>
Subject: [RFC PATCH net-next v4 0/2] Abstract page from net stack
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Changes in v4:
- Forked off the trivial fixes to skb_frag_t field access to their own
  patches and changed this to RFC that depends on these fixes:

https://lore.kernel.org/netdev/20240102205905.793738-1-almasrymina@google.c=
om/T/#u
https://lore.kernel.org/netdev/20240102205959.794513-1-almasrymina@google.c=
om/T/#u

- Use an empty struct for netmem instead of void* __bitwise as that's
  not a correct use of __bitwise.

-----------

Changes in v3:

- Replaced the struct netmem union with an opaque netmem_ref type.
- Added func docs to the netmem helpers and type.
- Renamed the skb_frag_t fields since it's no longer a bio_vec

-----------

Changes in v2:
- Reverted changes to the page_pool. The page pool now retains the same
  API, so that we don't have to touch many existing drivers. The devmem
  TCP series will include the changes to the page pool.

- Addressed comments.

This series is a prerequisite to the devmem TCP series. For a full
snapshot of the code which includes these changes, feel free to check:

https://github.com/mina/linux/commits/tcpdevmem-rfcv5/

-----------

Currently these components in the net stack use the struct page
directly:

1. Drivers.
2. Page pool.
3. skb_frag_t.

To add support for new (non struct page) memory types to the net stack, we
must first abstract the current memory type.

Originally the plan was to reuse struct page* for the new memory types,
and to set the LSB on the page* to indicate it's not really a page.
However, for safe compiler type checking we need to introduce a new type.

struct netmem is introduced to abstract the underlying memory type.
Currently it's a no-op abstraction that is always a struct page underneath.
In parallel there is an undergoing effort to add support for devmem to the
net stack:

https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@google.=
com/

Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Mina Almasry (2):
  net: introduce abstraction for network memory
  net: add netmem to skb_frag_t

 include/linux/skbuff.h | 92 +++++++++++++++++++++++++++++-------------
 include/net/netmem.h   | 41 +++++++++++++++++++
 net/core/skbuff.c      | 22 +++++++---
 net/kcm/kcmsock.c      |  9 ++++-
 4 files changed, 129 insertions(+), 35 deletions(-)
 create mode 100644 include/net/netmem.h

--=20
2.43.0.472.g3155946c3a-goog


