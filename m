Return-Path: <linux-kernel+bounces-89185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1766B86EBB7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C387E286EB8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F235C61E;
	Fri,  1 Mar 2024 22:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOkF0okA"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70D5A0FA;
	Fri,  1 Mar 2024 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331489; cv=none; b=F6GiUweeFvOUehzmZXiGz9VWlDnA39LZnpxOETkF7WJSMfTd4syZvQvoEQXmBE0NvmQP17vacD0xGPaLxaa57+1lI6mxtpslB7sRhvZWVvVTAmNtAPeat9m5b9kpRyGdZAntZJkNR2bf8DLuNLfaMjFjeAGUi0P21mIu2yxLUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331489; c=relaxed/simple;
	bh=Mpw8JDktOqAHVSnGhPK7OvlSmt3P/Pn9/iGcawwaPNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rHUDMxMMkopDzb+hy3wHf+jTFVKLMPQ0+4f+1ycF7dXqng3GwEmBfgBnSWwMKRdyFLHEMP/nNgFatzelQS0NruDQO1oaIjM/1kp44SyAH3FjuG8r7lL18o0P+XHJ1m45h9GweWcgJIGyqMzy3LHjTIoGPNve9ikMpH/i25Uaiy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOkF0okA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a293f2280c7so497772966b.1;
        Fri, 01 Mar 2024 14:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709331486; x=1709936286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eAOK6LG+DqrzRy5jAnNYEM/hys4zUVsiXRG3NHFhSI=;
        b=fOkF0okAJ7wZf0VYkVkm7GHBVz65sXVcMutqgBxfhlTqHogY0mtNeg/KG+tFnjYr1m
         H4rGSWBzx6sXJ/TA01HAD+aBfB6UVP8yKNUc14YYaW/nZBOt1G5+P/ElqwvD40wF0MBr
         XL/mLu3OxJkIe8rzfTxsM1XkQVJPcdqqUL/9tNq3pUhBONr+jmq5HdZ7si4SJlaRM5Ef
         zEqG5ZloNpaqZJ4RV53WPrln/BmxcL/evvQdZS25Sl3x2wmFQFkLLudjTX41F2CUtp/K
         gqCYqAiB7ExTAo7ELo/kPuyFvx3SpkRW3S8eOJy7BiGQKyd1sj6w2aKEaDdnoigZoDYM
         3p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331486; x=1709936286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eAOK6LG+DqrzRy5jAnNYEM/hys4zUVsiXRG3NHFhSI=;
        b=K3EXAZzyditA7j+9gG1b3KEvVvxSEe9kyVukfTRl/1ujWge/usi292/VrEp/KbLEMt
         ChvbURZVMB422BrKtf8JkEUxUClTz6O+YqiwSH+0wvZG29lykfrg6EZHGR5Cfy373uZj
         Na5iIYA+huro+j8hJQoeKWdCJhg9egppPMJ2zYTNuPPxSC1Qe5r6SMWBpL966Ph3Mnub
         N7Ofv8uJ+azhP8u5i9LeSBH7FPUtIqgBkNSswuNr6qyZEcOJ6Z0W6DrG8tv4/S3Dmire
         yZYq231SxjnSwt97OFqPtxS2O/uwDdFfG9yP120iTL+cle5/kf6mdu8AMgv8HD5IIjCb
         Q52A==
X-Forwarded-Encrypted: i=1; AJvYcCW6S388+vbzvvxtNdUDeGpYp0FKYUBG6Key7sUyzBN3JzCzHeMWJqcgRe2cNTRSEZhsiumVKR/k6XbFwokOwYVMPJW7ZYEI9BAQbA3W
X-Gm-Message-State: AOJu0YxfJjzHTOoUI1UepQPKhuDv43lJ/WcmiXRCFoRTRSRUI+VqWqUU
	+JHUaGjPNetwKuhvnDSLQOOcQU1rliL3kYgjUs0UNCA0/BlzwzrCBtaFWG3mihg=
X-Google-Smtp-Source: AGHT+IEMzsY3XvCZdJA1XBnW6EUS6STe8+WgV7WYWskXDcSaEOWvEub/NaEdP/57/V4CG8cnQoPxew==
X-Received: by 2002:a17:906:4558:b0:a43:9857:8112 with SMTP id s24-20020a170906455800b00a4398578112mr2365844ejq.20.1709331486353;
        Fri, 01 Mar 2024 14:18:06 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g16-20020a17090613d000b00a3f480154a3sm2091122ejc.65.2024.03.01.14.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:18:06 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 10/16] net: dsa: tag_sja1105: prefer precise source port info on SJA1110 too
Date: Fri,  1 Mar 2024 23:16:32 +0100
Message-Id: <20240301221641.159542-11-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301221641.159542-1-paweldembicki@gmail.com>
References: <20240301221641.159542-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Now that dsa_8021q_rcv() handles better the case where we don't
overwrite the precise source information if it comes from an external
(non-tag_8021q) source, we can now unify the call sequence between
sja1105_rcv() and sja1110_rcv().

This is a preparatory change for creating a higher-level wrapper for the
entire sequence which will live in tag_8021q.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v6,v5:
  - resend only
v4:
  - introduce patch and replace 'slave' with 'conduit' after rebase

 net/dsa/tag_sja1105.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 7639ccb94d35..35a6346549f2 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -652,12 +652,12 @@ static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 	if (likely(sja1105_skb_has_tag_8021q(skb)))
 		dsa_8021q_rcv(skb, &source_port, &switch_id, &vbid, &vid);
 
-	if (vbid >= 1)
+	if (source_port != -1 && switch_id != -1)
+		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
+	else if (vbid >= 1)
 		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-	else if (source_port == -1 || switch_id == -1)
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	else
-		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
+		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
-- 
2.34.1


