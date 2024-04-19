Return-Path: <linux-kernel+bounces-151547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B647E8AB059
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6E3B26154
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89ED12FF74;
	Fri, 19 Apr 2024 14:06:56 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43512FB2A;
	Fri, 19 Apr 2024 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535616; cv=none; b=d6XaJWuHOr9RTBGDTKm/t9NTRjEyhbOPybtaKeISyDFs2rp/ONBNPp49iJy05RS07czHQWfZwIu2BhK8KOH8KG2I/syMR76NM3da4oQjLHYsoH7gU/t0+AyRilzH5Z3eAvlx+Ied7eZ4YF6y534evsPnlvEMweBVDvly+vq0gLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535616; c=relaxed/simple;
	bh=oyuMKSYGoMfRz+tvPVJ/jIgvFe45ZdlNrFcZrO/Oozo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UHxNZGDmru0Q5tHuWdW5lZ5bCKemUo2p/5ALokEUSDbp8SrhXMZx35Bsh8xNWOnMHiY1BRncWEKGw5Eb/j3u6AQfzJiX2aKSO2j+Z49wadAmAllhq2Lbysro+ZFt5fMvxYZzmFxWvhTPAjJbqEtVPN951ERC/QsEj+A0vtgcB98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69b10ead8f5so10509566d6.0;
        Fri, 19 Apr 2024 07:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535613; x=1714140413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8Fq3HZ/CaefZ5llRGtNvq0zZoQTpNhHnR6rkcG9Onc=;
        b=QWRCbm0mAYrJ61AwC95b82Yn2lNQ61bnbw51PvqDLRGvtDWOC5U89LDhVOheTjx5cV
         UCgkkbpG+ex/EGITQ2oGTf1Ts8uJZN/VLdyFuiLS7x/TSWHlbDHBnvJaJxSYz0TOKtXG
         Ns25wbUH19sPG1XyncEwuoNHSR5djOGialmJ0vB2qcjG8DNcqh4lWhArYrNtLTwfq5ux
         BMK4jxDWRYVEssBGL/TQqWQJCM0nL0ORYZgepu1hUZApF8c6oeO2dd6BJi8L+oc7w5hq
         rKV4VZ1YjpjTH2b6YQdZ7fnfMwrK73X7hHzSt05FpTqnr2nHBU5a/N/4bJAeZthVINv5
         DkQg==
X-Forwarded-Encrypted: i=1; AJvYcCX+uEK8NrGMRuTaeyAjiMB17S/7UwJjbDaoeQHm+/JSuwmi65bBeORIJUBENNQ2BW+Qc5VKPTAWJwT2l+Q+Kutx8wOPI/rB
X-Gm-Message-State: AOJu0YyBnigHeXnQEliNhJKFudKyvrqKKkFMkDia2+scoPdhojZcTR4c
	AKBslfauhMaQvfqTbewRNH3UgXpBKt2PC/WUFzMRsYJdUV4GGFGH5/+AOtuD
X-Google-Smtp-Source: AGHT+IEExWZrMFhZkzaFUZt5oFz3RthU8jjCWST9IjqMH5SnWFRL8n0X6a0aq8SFT13NmFp8XFaSHQ==
X-Received: by 2002:a05:6214:2cd5:b0:69b:6746:7ff8 with SMTP id lf21-20020a0562142cd500b0069b67467ff8mr2309114qvb.31.1713535613102;
        Fri, 19 Apr 2024 07:06:53 -0700 (PDT)
Received: from hemlock.fiveisland.rocks (hlfxns014qw-156-57-186-228.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.57.186.228])
        by smtp.gmail.com with ESMTPSA id g6-20020a0cdf06000000b0069f1c071f1csm1554335qvl.29.2024.04.19.07.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:06:52 -0700 (PDT)
From: Marc Dionne <marc.dionne@auristor.com>
To: David Howells <dhowells@redhat.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jeffrey Altman <jaltman@auristor.com>
Cc: linux-kernel@vger.kernel.org,
	linux-afs@lists.infradead.org
Subject: [PATCH net] rxrpc: Clients must accept conn from any address
Date: Fri, 19 Apr 2024 11:04:51 -0300
Message-ID: <20240419140451.4139663-1-marc.dionne@auristor.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeffrey Altman <jaltman@auristor.com>

The find connection logic of Transarc's Rx was modified in the mid-1990s
to support multi-homed servers which might send a response packet from
an address other than the destination address in the received packet.
The rules for accepting a packet by an Rx initiator (RX_CLIENT_CONNECTION)
were altered to permit acceptance of a packet from any address provided
that the port number was unchanged and all of the connection identifiers
matched (Epoch, CID, SecurityClass, ...).

This change applies the same rules to the Linux implementation which makes
it consistent with IBM AFS 3.6, Arla, OpenAFS and AuriStorFS.

Signed-off-by: Jeffrey E Altman <jaltman@auristor.com>
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
---
 net/rxrpc/conn_object.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 0af4642aeec4..1539d315afe7 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -119,18 +119,13 @@ struct rxrpc_connection *rxrpc_find_client_connection_rcu(struct rxrpc_local *lo
 	switch (srx->transport.family) {
 	case AF_INET:
 		if (peer->srx.transport.sin.sin_port !=
-		    srx->transport.sin.sin_port ||
-		    peer->srx.transport.sin.sin_addr.s_addr !=
-		    srx->transport.sin.sin_addr.s_addr)
+		    srx->transport.sin.sin_port)
 			goto not_found;
 		break;
 #ifdef CONFIG_AF_RXRPC_IPV6
 	case AF_INET6:
 		if (peer->srx.transport.sin6.sin6_port !=
-		    srx->transport.sin6.sin6_port ||
-		    memcmp(&peer->srx.transport.sin6.sin6_addr,
-			   &srx->transport.sin6.sin6_addr,
-			   sizeof(struct in6_addr)) != 0)
+		    srx->transport.sin6.sin6_port)
 			goto not_found;
 		break;
 #endif
-- 
2.44.0


