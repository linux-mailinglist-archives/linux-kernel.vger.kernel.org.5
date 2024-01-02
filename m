Return-Path: <linux-kernel+bounces-14816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E878222C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282901C22668
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C94B16435;
	Tue,  2 Jan 2024 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3l33vppm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8456168B1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e898eb4432so131710947b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 12:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704229149; x=1704833949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6OrdrWvBDxOQfJ4vcbx726UKsh13Gg6rlqSW8b/m6AQ=;
        b=3l33vppma/IgX8GqZ/OsBLNrTC+DQFRaN8jbjBtjZFbVKVfGtg+mZUxwgVjiSHhedx
         JEwM1UbU8arnhvayONYV+yWeB5FSVbH0mN28LW7y7tH5blJ7WnhqRSfgqyZeqe3VI9WO
         QngELDGoSrrvJGNJFYKmMam1ONjONDCWi6qe4Oh8ZZWjZVEEiy084wqA0zyyCeZxlccP
         LqjxccfJY6/xw1mr0evvSYTmNiV/qoBJxbST7bWPtUholNL5UrLoIAfY+U0Zvomht6Vm
         g+LsMJp0jeJy/c2K5G/nfAu4cDDJjaOL2PXpxx9C5IxvuCOlb3JPssl8GdrHo16RIz3/
         xH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229149; x=1704833949;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6OrdrWvBDxOQfJ4vcbx726UKsh13Gg6rlqSW8b/m6AQ=;
        b=Um7VO8irPC5v097I0k969hc4k8d0c5h7rxUpGMREg7NnvwHLk8oqUe7MKGB3YeegFq
         rX+9eRWNNzed8fGKynzwfuGgebGXhCWkN/EDETLQp2pb9HALnZ357CmLYmfKPZr4dWJf
         FzNbmFA4emW8dwDVl0GTt6WVFPNj37oLjhpBGB3iGzgQHE5COCZ4xL/nZWVubL7pHMIt
         feXnXbPz4UkdUImytj0ZGhz9AwnVnMOYu8f6CWa2cJY18ob2dWbOOP8KIeHQdxR+SBsC
         K7oBpI9rCWZ80/YO2MjJgqJboxVSGpRNqDTLUiGZdQ0Cft+lCf4eLrqrtmQFps94tqUY
         NyGg==
X-Gm-Message-State: AOJu0YwSHFMnGbUCPAD2finqz6KKkGU03WZWfcrgLlpRLeeBC1DkjuFg
	hiNtGqp6Zuwoib075VPOPCLtbcJ+M9bxtoYUZ1rQ6drE
X-Google-Smtp-Source: AGHT+IEYBVWVkGFDvnDDwSh8ZR1uFwBIdUhOiKNQJdQm7yNcrBncdU6lu+BqxXTaSudF2V5VYA6E0+s7Hmgg6J64Ng==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:9a04:c262:c978:d762])
 (user=almasrymina job=sendgmr) by 2002:a25:b9c1:0:b0:dbd:b7cb:8a6b with SMTP
 id y1-20020a25b9c1000000b00dbdb7cb8a6bmr513742ybj.1.1704229148829; Tue, 02
 Jan 2024 12:59:08 -0800 (PST)
Date: Tue,  2 Jan 2024 12:59:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240102205905.793738-1-almasrymina@google.com>
Subject: [PATCH net-next v3] vsock/virtio: use skb_frag_*() helpers
From: Mina Almasry <almasrymina@google.com>
To: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Minor fix for virtio: code wanting to access the fields inside an skb
frag should use the skb_frag_*() helpers, instead of accessing the
fields directly. This allows for extensions where the underlying
memory is not a page.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v3:
- Applied Stefano's Acked-by.
- Forked this patch from 'Abstract page from net stack'.

v2:

- Also fix skb_frag_off() + skb_frag_size() (David)
- Did not apply the reviewed-by from Stefano since the patch changed
relatively much.

---
 net/vmw_vsock/virtio_transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f495b9e5186b..1748268e0694 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -153,10 +153,10 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 				 * 'virt_to_phys()' later to fill the buffer descriptor.
 				 * We don't touch memory at "virtual" address of this page.
 				 */
-				va = page_to_virt(skb_frag->bv_page);
+				va = page_to_virt(skb_frag_page(skb_frag));
 				sg_init_one(sgs[out_sg],
-					    va + skb_frag->bv_offset,
-					    skb_frag->bv_len);
+					    va + skb_frag_off(skb_frag),
+					    skb_frag_size(skb_frag));
 				out_sg++;
 			}
 		}
-- 
2.43.0.472.g3155946c3a-goog


