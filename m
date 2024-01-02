Return-Path: <linux-kernel+bounces-14935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C048224AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A57B2150B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0C2171DF;
	Tue,  2 Jan 2024 22:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+um1whB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC8317985
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d410cccfc2so36006305ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704234141; x=1704838941; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VoYBcyeMcOUsOKM5LbFmoG1rNiNhP0xj5K+Ym6ZJNQw=;
        b=S+um1whBxsvYBaRtrLrkkjesCTD6femhXZ7TnwNeyZXKB1jfxu0Dqa2J+TcMNsBNix
         SWkzea6fbYrmKR50AkZ7OlLdxIi4RdAGPT51h6GNjjjrIOLZb6vANqeluB9IGhPvVcBU
         8Vwv3/5KI8m4Fai2r0SXe3L6xR3Gv4isG6R9WvJKUa6fgybiDyY+iePo6CIvcRy8IvbL
         Pap+VBdukbO69AGl6ERtgjn+US/80wc4M9AOUoOdyEB2wwIngPayf3+uCIf5USGtorNC
         AB39NRKV/gYrpGjprcxBmpSuaxEuQ73cX8J01eSNprwDHqdBZWX1JL+TGVFhG1AVmBSj
         0iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704234141; x=1704838941;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VoYBcyeMcOUsOKM5LbFmoG1rNiNhP0xj5K+Ym6ZJNQw=;
        b=erGY1FbT8XM2vYUSzrzwRpwGArOPUXEYXKJamofTqJqnhr/mt2pAlkBNfmRYNctgbJ
         Qz1SDP3w/LtTc/szL3DvHhj7VtV/kGjC7VKDGFod+8tU2aF1xt17oNqvJom0MxrtKaHB
         2l8t2pw+RkK/Zbmu19gGV4H7Cjw7x+QJP1G/5P2P4GYpC2TsIT03pVtF2wK6gG+xW8PT
         RZe0JkB39Z3YvjezQOP8cXayRRhglVwmTA/mo5H0irjcwLJ47LZRXZTUBWYbWkzVLlPq
         UANBQUp3ungfYoeeHYNOPAh7lQf1qWoFsiAh/jaiD1TZ1mdb95D6ceokb18Kh1HJvGRO
         9Nsw==
X-Gm-Message-State: AOJu0Yywd+A6O7vimJJDIYkXgaP041BHHTL/fSxxSpMhrFaM8d3rF33O
	XI4vP2K0xZZq61lHa9gELIYHsE9ExQ2kE5vbZ9M=
X-Google-Smtp-Source: AGHT+IGibMrtSNs0B7J5A+QWM85xhUBg0GKDxizl0OkdWX1k1ttpJocQ5P4XooSKRH4vL9aHfM71x73t1FOt
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a17:903:120f:b0:1d3:f056:bd5e with SMTP id
 l15-20020a170903120f00b001d3f056bd5emr622882plh.8.1704234141148; Tue, 02 Jan
 2024 14:22:21 -0800 (PST)
Date: Tue, 02 Jan 2024 22:22:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJqMlGUC/13MQQrCMBCF4auUWRvJTKCIK+8hXcRkkg5oI4kEp
 eTuTbt0+T8e3wqFs3CB67BC5ipF0tKDTgO42S6RlfjeQJoMEo2qcn4UZfRF69GgNwGhf9+Zg3w P5z71nqV8Uv4dbMV9/RcqKlTGkmMXEG3wt5hSfPLZpRdMrbUNIDPSdJsAAAA=
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704234139; l=1390;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=DUB/ZV2zVOe/Hx7a/jPXLV+v75gZ6+Z01V5aE00rj50=; b=qe5pL7e035Zo4B16XWqHVxTumHn9sOyTDK/Y5RdiNEozypVYZV9EWUD5PpPY5hk9hItu8K1yE
 Xte40bFcZT6CVwbEGb5iSw5YFR6ub90ZUa+g5JlAcdt91FJWgTgeqh8
X-Mailer: b4 0.12.4
Message-ID: <20240102-verbs-v2-1-710de1867c77@google.com>
Subject: [PATCH v2] xprtrdma: removed asm-generic headers from verbs.c
From: Tanzir Hasan <tanzirh@google.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

asm-generic/barrier.h and asm/bitops.h are already brought into the
file through the header linux/sunrpc/svc_rdma.h and the file can
still be built with their removal. They have been replaced with the
preferred linux/bitops.h and asm/barrier.h to remove the need for the
asm-generic header.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
Changes in v2:
- Added asm/barrier.h and linux/bitops.h to not conflict with rule 1 of
  submit-checklist
- Link to v1: https://lore.kernel.org/r/20231226-verbs-v1-1-3a2cecf11afd@google.com
---
 net/sunrpc/xprtrdma/verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 28c0771c4e8c..b4c1d874fc7e 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -49,14 +49,14 @@
  *  o buffer memory
  */
 
+#include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/svc_rdma.h>
 #include <linux/log2.h>
 
-#include <asm-generic/barrier.h>
-#include <asm/bitops.h>
+#include <asm/barrier.h>
 
 #include <rdma/ib_cm.h>
 

---
base-commit: fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
change-id: 20231226-verbs-30800631d3f1

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


