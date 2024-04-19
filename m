Return-Path: <linux-kernel+bounces-151751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14DA8AB369
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7357C1F234BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656F913174E;
	Fri, 19 Apr 2024 16:33:02 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486CE1DFF0;
	Fri, 19 Apr 2024 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544382; cv=none; b=VSl1DV+9cvouIpZ81GdlSI+LCHnXasFNNYUc3R554WcIGRUIn1+9564W7MgVHt0z4PdCOw35YTqULaVfmmDZDQH4xkqDxOIwT4XjfjuXcaUu1ToyYUygyFBvFNLZv0I1zfV3Yv7KvDWcLuUZ9yZ1Nf8xiDK07whBeHIpn9XUwzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544382; c=relaxed/simple;
	bh=lrsLAInGmmwlG8t8h9BjUv8G4ES4s20nILYak8Fi+Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQjzsuHl5U8Y/Q5WyKRA1cF2iJT89ZS7GVVCCEYYGiFkk9evfWMUESSKsXGtacTgLyb48ePZ8hc5w0WamLBehQYeX9E0YdEJSeJxdjmpdtvMlQcXxstqv9+gwLN4i26ulLQ+HQ5osb0R5EaFUb+zjpucP8UvpEpfVZkufm1Aj7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4347cbdb952so9099521cf.3;
        Fri, 19 Apr 2024 09:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713544379; x=1714149179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZt0+bvbyo27WYKm1jClLea1EE0Wu1vF3OW+kTQvhOQ=;
        b=pOQ6ruR3bMhxnpzj+lLDL012moR1Cl8raQZxxE54SwBS5wUxf/dhDgeMF1iQ9cO6wd
         W8CfQDutAvgLnWxPE5NIGGwuvf42HFtwZ7O6pSUAGprT+nmtPEiEZEH+ecTzzPCu3ejL
         ItYqsoS/l1jFWgVm75JLZWCj8IG44U6uE28mTwS2Iu85joSmXnUqn6+0sVFXAfw2z68r
         wALBfBG751leNMqdSb8thhe/YQsMYF0tumtcyaBzLN7mV3dcoIn3NxxGBfoxlL2Z7avH
         Ckkjtwfh9ogLTJSNnzM7Z+8R8gKi/JtgByD0RabcfJylRKE1ku4YxO8r87ZH2/F/8219
         WqFw==
X-Forwarded-Encrypted: i=1; AJvYcCUT68sleQdlXjSz9C8pvXmjCfVZLx//BXAPoQYzXvqw1ky7u2IbXXLN+vdsjz/247fPyN+nnIMxr7+BsTIYbPCvaqsSl/1B
X-Gm-Message-State: AOJu0YwhJI5ipG4gm1hPwNo2QAcAonjWYH/u6j43iAahr1VpO+Iuc5L1
	NKYaUD+eJqSIVD1sPv8XrnoE6M2dV0j/7pYlHdSG27idAO08xJhD
X-Google-Smtp-Source: AGHT+IHaukWucAcTRkaFJw/QkRj27FoPZb1ec89AIlkmvXdYGorNs9q6y9L3bto15pZ+DtfIPa4ChQ==
X-Received: by 2002:a05:622a:1207:b0:437:bc0f:323a with SMTP id y7-20020a05622a120700b00437bc0f323amr2583923qtx.48.1713544379177;
        Fri, 19 Apr 2024 09:32:59 -0700 (PDT)
Received: from hemlock.fiveisland.rocks (hlfxns014qw-156-57-186-228.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.57.186.228])
        by smtp.gmail.com with ESMTPSA id g23-20020ac84dd7000000b00436e0eb2346sm1718444qtw.55.2024.04.19.09.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:32:58 -0700 (PDT)
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
Subject: [PATCH net v2] rxrpc: Clients must accept conn from any address
Date: Fri, 19 Apr 2024 13:30:57 -0300
Message-ID: <20240419163057.4141728-1-marc.dionne@auristor.com>
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

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Signed-off-by: Jeffrey Altman <jaltman@auristor.com>
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
---
v2: Added Fixes: tag

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


