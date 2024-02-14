Return-Path: <linux-kernel+bounces-66056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5DC855603
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47991F217C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1865A250F6;
	Wed, 14 Feb 2024 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PORiuqgN"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EC326291
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950051; cv=none; b=mJnecn0RVB4h2TjedeieaVU3lGwZAoEcOGXIMSHzfhx6W/sOLWJiev0Oa4b9NKOIUgvs9gXnPVoKQSXYY9mF+hXEKya61cujWTc1X4rGcPP1iOsCg2ytThTr0NUDBdu6gCG0D5OTuY3FQVkJ0NqAoRxuOURCnWOW3DV3P3jcWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950051; c=relaxed/simple;
	bh=92FzybQ0k/QQSRZIXOZq2u6SesnBUJmYVfIEOiul8QU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FZBPfw1Etzcrpq63+w6T6WlpdvkKGoKCIe6x5pTbW4HIMOnk5Hs9NhLl+5/uQuQ3Cx9O3BcFDk2tCBP0Lurx77DLRwbZZj46t4+vCdta2Lg8KYVT/wziktg+GJ4eb1ZTitfEkSR5EjpB5okznbMKC0sLZOUXYtVrbVM9pnHli5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PORiuqgN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607838c0800so15841147b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707950047; x=1708554847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0cbBOEAdMKtHU21rqPFfqL7h7M//5Xm4Ynv7hO4s8OY=;
        b=PORiuqgN3YpORj0iB3mss/O3GREJn/8JAup3hW5Ar1YheIU/lKh6mQ4OdrfdIcWtCW
         r+x4SicyAcNiJwRhONgr6/uw5A4DU+5AaublgXqc1j5WlNnLZk6/adCh4X7BuFKJuhh9
         Z5uaBJoRTXMycgh51i9+agg1/wZpW107E+qdHe/yStmrpQcaCJCtuiJpaIw/bKLYeE/q
         5RsPS1d7OvwL4n8tGbaEwOf6ruyLiU167CD1bShhTSPESbTiPC0KNH9Vjl8qQBKj/QPb
         F+vx7brNzdjiGYM1YS9fDYSaJbasHtxlOgZRz363XnORSmNRHA3ci80kMDSWEw7TPdAl
         UmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950047; x=1708554847;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cbBOEAdMKtHU21rqPFfqL7h7M//5Xm4Ynv7hO4s8OY=;
        b=U+QpLlPQ4SjUkEQrLQfQ/4MpUM9zJjnI38fBzBpY/z8e4gFYfoeDTVFHqUS6Xyba8t
         9ADoJk1sJrIxKxqdScI8s6e+7jR0qOlHBvdl4P9pEKZc8mzlSDv448spO1mYnzejs8n2
         MlCAVm7hJ026AgrvvDUZHy/n9FUrhJ+Jf/BWwKbNz8fhhw+x4MIswozA2OwE8E4rb/Sd
         wDfGrpdupEIIDO/yA4a5crmdyJUzHLEtMYXVS683tFy1XW7fOYoxUUsxVK9eqnyfX1br
         ZnXzZ0+q3Bdd2YUhc6lfbcC2LKJCMj6WmCi5mSWQ6l4t0SIjQbU0W9QV/PbThADIm16H
         +q7g==
X-Gm-Message-State: AOJu0YyUlkxPq3nXqE+oPAkRKaYXvqvd+XpOwbxxqgacwjjdVCqxMg5y
	EQBWUTlAUCKmilffPND088+Q3P5LQ0ob2gfx3iVZPpFgdcG8WiD3+LUs2qqL7dzmefuFfg2MKEI
	TyN95JK8EFpoNQP4e9QqzOPPJxRjc/i0I+PyPo2THQQrYYYxjuEbFiuHz5RyA17OrGxLyJ/yco1
	3ZTqjPBrc8raD9ehwhOzjP5hBLjqu5M51XTcYgGfyEKjaAS0OS8o2bBq243z4hn4oRLzs=
X-Google-Smtp-Source: AGHT+IEOSORb6qxpucbb7XFNLoqJ4v4xQQfWM1UzuHlSCt/LPMOKzRv0czrYkhgLen57vRBQVrdmEA6kMTh9iErNeQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:e4bb:b13c:bc16:afe5])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:f0d:b0:dc6:deca:8122 with
 SMTP id et13-20020a0569020f0d00b00dc6deca8122mr588946ybb.5.1707950047502;
 Wed, 14 Feb 2024 14:34:07 -0800 (PST)
Date: Wed, 14 Feb 2024 14:34:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214223405.1972973-1-almasrymina@google.com>
Subject: [PATCH net-next v8 0/2] Abstract page from net stack
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Changes in v8:
- Moved back skb_add_rx_frag_netmem to .c file (Paolo).
- Applied Paolo's Acked-by.

-----------

Changes in v7;
- Addressed comments from Paolo.
  - Moved skb_add_rx_frag* to header file.
  - Moved kcmsock.c check.

-----------

Changes in v6:
- Non-RFC as net-next opened.
- static_assert skb_frag_t compatibility with bio_vec.

-----------

Changes in RFC v5:
- RFC due to merge window
- Changed netmem to __bitwise unsigned long.

-----------

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

 include/linux/skbuff.h | 100 +++++++++++++++++++++++++++++------------
 include/net/netmem.h   |  41 +++++++++++++++++
 net/core/skbuff.c      |  34 +++++++++++---
 net/kcm/kcmsock.c      |   7 +--
 4 files changed, 143 insertions(+), 39 deletions(-)
 create mode 100644 include/net/netmem.h

--=20
2.43.0.687.g38aa6559b0-goog


