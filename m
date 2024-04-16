Return-Path: <linux-kernel+bounces-147317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC5A8A726D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC641F23081
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3141B133422;
	Tue, 16 Apr 2024 17:33:44 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186FF4E7;
	Tue, 16 Apr 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288823; cv=none; b=DAztOFBc7nKg2rKccNWDeUojtRM8Iz3ZRVfMxpdBsZ2ZpgexktzXwiB1nS2f3vaV5hgh9op7W6Ca6r7aByn3q+4qrmgYdNex8OQCksUdK8/MI09rLdVYBZZjq1K4ptBJVLJ2tH0K/1dgxjMSBP7Acd9TWvzJA/N8EweJacl50tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288823; c=relaxed/simple;
	bh=oyuMKSYGoMfRz+tvPVJ/jIgvFe45ZdlNrFcZrO/Oozo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cARZ+MBZ0F/ha0SSCEde9f29OgY9hg1MjDsmGJegmxMHcl2w14yCyE3QL7+PgHmiRLg4PEOqPW5b5kroc5VxqjFaAskpW87myvHgzEoKyojrrANRnz8yWQ/NqHQmNll9IBaEMU+10EhBGN1ptvMYVnorLYoZKdvNSp3QXoqtx1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e9e1a52b74so781276a34.0;
        Tue, 16 Apr 2024 10:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713288820; x=1713893620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8Fq3HZ/CaefZ5llRGtNvq0zZoQTpNhHnR6rkcG9Onc=;
        b=oTXCCSbaUNGxS0kZdKo1Db0xteqmsWV3znkAYDRdPeePHZyqqDH8ja/lmWEVG4J5WP
         VReN8U7bNa8PGY6jAFV2hjfM1VVnV4uNLbfHi82i5pAMbcW/hpZLOT7uO0q6STcRgp/d
         TZJTSooCGMvlabelEwxGXkh2ICjbX01dfeL8E7bexonxEAqGKP3NZZaVKEEM5HJKJZU/
         cOLNlGAqaj2hWBZF43e6SLppKKF7XG7iZ8KI5MxCKFpZeHrk4L5aPPwU1TW4eTtKHYsH
         nmcjvsSNibRaD6ZSO8q/dY8Ep+MXLeKlgYzquzoXZusGQFmBNauxXFbV8YS4kSArhfn8
         igLw==
X-Forwarded-Encrypted: i=1; AJvYcCWN5k4hxdy9GzMY325wEYooMI60dH6ppqbIRIvVmJheOSZ8ZL7KoLkVQ/X5Yj3ZdyldyMbemV9LQX4EKXiImqpT70364kPM
X-Gm-Message-State: AOJu0Yz5hWKH54xjTxSQCUiAaY/V94NlMirMmD1GwBbL0pOlf2T6c6X8
	2bzwdUmtRWGR1sqUQNVVMtRK4kTFEDgCM59VGKUA4J57/MYwVQnYTpIvOuBQ
X-Google-Smtp-Source: AGHT+IHlUJXf+egTIlLcd42IFhCtKBOGMyeucgOobbmxD7Sy4JCYOTx59oxRQCIT8vAf0H1CE0Fkhg==
X-Received: by 2002:a9d:4d89:0:b0:6eb:7cc9:93c3 with SMTP id u9-20020a9d4d89000000b006eb7cc993c3mr8004133otk.0.1713288820102;
        Tue, 16 Apr 2024 10:33:40 -0700 (PDT)
Received: from hemlock.fiveisland.rocks (hlfxns014qw-156-57-186-228.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.57.186.228])
        by smtp.gmail.com with ESMTPSA id d6-20020a05620a136600b0078ed1f9f101sm5667027qkl.88.2024.04.16.10.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:33:39 -0700 (PDT)
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
Subject: [PATCH] rxrpc: Clients must accept conn from any address
Date: Tue, 16 Apr 2024 14:31:38 -0300
Message-ID: <20240416173138.126853-1-marc.dionne@auristor.com>
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


