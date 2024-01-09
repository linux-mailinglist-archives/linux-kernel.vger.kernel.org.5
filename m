Return-Path: <linux-kernel+bounces-20249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE783827C6B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7017B1F24269
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69792186C;
	Tue,  9 Jan 2024 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPYRu+Ps"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452E7A53
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe02d0c945so1449519276.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 17:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704762898; x=1705367698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wdQGlntYSzgRkKM7jC11IrH2xPiRiy9sKIOQ0dx3oxU=;
        b=DPYRu+PsJCAFpiYsTIVJri6h/w/fy1uLSciFjMiyn0DgMv67ZaMPgLC+tBryUPjgZi
         iHDPMWuaa5dNqBXYeBo1bjCvNUpksrU0M75Zp+Nx9AY34hTx8qEvFftkrgEUMQ/L3wzN
         ORI7byvmSPVgOXMz4vgLaI1GBG3HzEKwGsJs9rqKqsj+V092lkRfvxjWdbDy/Gel+HoC
         RtKkzR6/lK/LZqn3wF9jaBsVQITIqVyGA1V5S9GqkBBEilcU8KF/77CjO2noSKlg0lnL
         FASfb6AUcecNkGmG6OZuiW3n3H2qhP9Hj0dAssVbjpSC/rDI867RhikSeRwE77qrbnfW
         B2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704762898; x=1705367698;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdQGlntYSzgRkKM7jC11IrH2xPiRiy9sKIOQ0dx3oxU=;
        b=IZfaCZ8b+ex9CiuZnI2fwI8ctDM8040C5bUiDRb3QKNjFZIw7inIvTGAp0EMa8SnG1
         ephAItIMMBlKoiT2nkEIAeXFCN+zATmSlEPxLzgDc9JFyJWE8dsCwK34GeVThRtPcOIT
         2nocfOo3hMrkecs9nhuDE4GXh30CDTFWDXVsSczd1S+SAzLYzRCONqNWiq1BXym3bX5f
         DnMNhPPs5J0lWP4Y9bRjWyZI57Jj5iewreP/MwwAid8pI+27R0eFT3FKHP1Zn7bLXUFU
         ADH3Cyue2O5qxnLuP732DvUJY5VlZtk1iq3vmCCs4D+U1JMh52/hSLZ+7ejf3PlJBMys
         kSRA==
X-Gm-Message-State: AOJu0YwmMjvI1QC9XMbmkjQlx5BRqdEd1+5G9z8195+wodUgN3QB0afP
	wJqDq1k9P8O7eQhodBm2QmwjHrM6Ny7Ct9S5scX7iBhGOU5yo9nvpT9mf/FkANC3NH9UgcHTI+f
	8qho1kJb5Y0AzORhpDzYvRjKst/Bk82eLZYD6cTEv5+k5Hs1jTPv8t8scW50x+Yu1yToLVoroJb
	C7QwLVyU9m/MMtZg==
X-Google-Smtp-Source: AGHT+IFMTcfam3s9iBf+3ewuAdxMqQhaLRjfMlYY5+2Q4BQfnBf+FFxy45PTQYIZJUCx1Q+SONv8RGq8ht5mNwSSUw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:23bb:bfcc:9879:32e2])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:1369:b0:dbe:ab5b:c667 with
 SMTP id bt9-20020a056902136900b00dbeab5bc667mr126227ybb.2.1704762897875; Mon,
 08 Jan 2024 17:14:57 -0800 (PST)
Date: Mon,  8 Jan 2024 17:14:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240109011455.1061529-1-almasrymina@google.com>
Subject: [RFC PATCH net-next v5 0/2] Abstract page from net stack
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

 include/linux/skbuff.h | 90 +++++++++++++++++++++++++++++-------------
 include/net/netmem.h   | 41 +++++++++++++++++++
 net/core/skbuff.c      | 22 ++++++++---
 net/kcm/kcmsock.c      |  9 ++++-
 4 files changed, 127 insertions(+), 35 deletions(-)
 create mode 100644 include/net/netmem.h

--=20
2.43.0.472.g3155946c3a-goog


