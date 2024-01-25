Return-Path: <linux-kernel+bounces-39208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4172983CC9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2C629E120
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83E313F011;
	Thu, 25 Jan 2024 19:35:24 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A313A25E;
	Thu, 25 Jan 2024 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211324; cv=none; b=lZLqJlUBAgeFHhbWTQD3dBPxTPCqCHx3MbpbG690Pxix8/i7GRuMTeOsttfJ4Ftp300VNN+vBMhSF0p5zyoG33IP4HrvtFGXZVsg0jQDREMu1ks8S5Okb6xnmitul/q4dxCRt39pklZOQt2qK3ALqQVL0+zLtF44JkcNwLOnTAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211324; c=relaxed/simple;
	bh=07M5kkoFvMKyzmFdLkvZ25JBt0OMrNKZCL/PQasAkZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GYiYddodHQOMA9SPXTlzgC2co0+0Yw+Z1sY29umcAgVzNcez69DjYwWS8uEZbwFwelVx9+h4ZDqvzygSPGyIJQziFBAKd8Nh3fNLWowBadAEz9r1qP6cUd0oxSPGFx8Xm29T4UTuyekUE7CduCidOSP5OseD8uiyYHoh20E2lEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2e0be86878so218602166b.1;
        Thu, 25 Jan 2024 11:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706211321; x=1706816121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imrDBi56DV0ZAB8kTOIfIaHsVZP4wFBIt0ytEIXfVe8=;
        b=IVbPAJDHWW57KAB2VjIueYL9PqJ7DOWN+5nUHF90LBx8zcxTulxj6k5tfeAJVWFRer
         DYZT1RSTHexjDvyGtrllCoPfaMZgfAtR34+x4MJ/JGuRjJB+0Fsd5hsFLgFs4iHyPUxJ
         nvWLhaUtc5LnKmjW2NrlLZNTUOy3/CC6RcQGS0+3EpFO0z8p+Vi71Lq35wdsyFb2QbpB
         Mv0Tj9yIxC8MA+fybhwgpeEiyFM/zGT7m6VXdcFiullTYHXLe75Cr2/dCuuL3jx+fQzb
         1rBKB7Z06QeZF/rH4w6EcACAysorjTcEU4Ux+EWV/eKuQ9nNeFLv8w1qmd5as0Qii4t7
         ZwQA==
X-Gm-Message-State: AOJu0Yyk3FSSFauJAZHSvX/ipjHXkpj7U5SfeAvKpQxCsJPzj1sJAM3g
	hKq3DZoe93QlBssAjFdBrmF8P69/jP2tPAWTR7NIk/aIrm5awNin37TlWz1eeGq+zw==
X-Google-Smtp-Source: AGHT+IGMflxq9aqXaxzhQaXuSOAnywi6JNbBRMFfEGii57LcYmd76ay6KhtJKISHwCqb18LUc19p0g==
X-Received: by 2002:a17:906:4fcc:b0:a30:cbae:3efc with SMTP id i12-20020a1709064fcc00b00a30cbae3efcmr46407ejw.34.1706211320869;
        Thu, 25 Jan 2024 11:35:20 -0800 (PST)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id vv2-20020a170907a68200b00a33dba470e0sm360325ejc.42.2024.01.25.11.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:35:20 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 10/10] net: fill in MODULE_DESCRIPTION()s for arcnet
Date: Thu, 25 Jan 2024 11:34:20 -0800
Message-Id: <20240125193420.533604-11-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240125193420.533604-1-leitao@debian.org>
References: <20240125193420.533604-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to arcnet module.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/arcnet/arcnet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
index d9e052c49ba1..166bfc3c8e6c 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -108,6 +108,7 @@ static int go_tx(struct net_device *dev);
 
 static int debug = ARCNET_DEBUG;
 module_param(debug, int, 0);
+MODULE_DESCRIPTION("ARCnet core driver");
 MODULE_LICENSE("GPL");
 
 static int __init arcnet_init(void)
-- 
2.39.3


