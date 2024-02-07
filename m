Return-Path: <linux-kernel+bounces-56301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66A084C877
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FE81C21CAC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2DE2C6B0;
	Wed,  7 Feb 2024 10:19:48 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330D28DA6;
	Wed,  7 Feb 2024 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301188; cv=none; b=m9fo9htKjYGUgelmZ0FEy1Lj5UlPFSCtBnxNR1db+fUO8PqbnAPq0jviBLsdJK88h1ho6oZJ/TSiXClyyp3WiVIbONqMFQMkEpDSbJps3nGGCFo7aGc9e4zdWvWp1VDC/DmzOpUYVENrr1X794+NPfGIXq2c66Ik4ykxM27emjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301188; c=relaxed/simple;
	bh=atwRRAFztXzGD3KWPYr4aeQs1Rpm8oWvJPjmX4wVT0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xlo69WYQtDdEtyHWBcqIA7oaTFgarMhJtr0ti8wbJJLmUSQ1oDKDnZZ9D1+tun4fc+X5rqxp8PA8le7jhToKzKgCPNRnPj3ZeKxGlfCyLfFGMeEhSOBy/fkYDdV4DccqszYYGHtRPDQpZz5/iqXhz3OtFuwzZQXxB+aCIi3P9+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a370e7e1e02so51273766b.0;
        Wed, 07 Feb 2024 02:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707301185; x=1707905985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmCKZcfoOVWDMX06KS3eziDG+p1IeDEhKIKh82+FwlA=;
        b=WW65tdE+xSbKLTLJJvbNZjyiLNOKomOiJCGh0SuwgaDd/YFxdHPQqZBb41N+coV5xf
         QSkoHH3HtlJb5Ms1kdRNx42aQiLJ5a9DsLRINIUabtj1coxhpc2OGyrYsRCDrvQvnWOM
         KEPmVfQioWJ82ekuk55BHhT+4xNsUj6Q0CAwao/5UuMsHazQUaTMYcMUH5KBeKC9VMEV
         ZOCsGfCXGkqFg+TJyk0r5LMPah++G6v0VAQE4iZRqRVpGRYyuz6WtZiOEvD6fZe+xJhv
         RHAPbj+VtNgq67NB6ZLmQF25ajADRzLdUkil+ChgNBuEOks5W9zFemAjPbT0S8zaqByW
         lM0Q==
X-Gm-Message-State: AOJu0YwUbQJ0e7h/U3nNbA0+ctlhK4oBLSAGxY+EJzr9AgpmxZ8bV7IA
	qwFJ81JjB4H1U7kECp3MaAyOxHA8PiuKv04Q/KTHCnqqnnEnQDQ5
X-Google-Smtp-Source: AGHT+IEXA2SoybpYpM1SwquQMfAekliTDV74zchTbW27qEP+LObFwH+NGdnUya22t4bMGN55y/suEg==
X-Received: by 2002:a17:906:1e8e:b0:a38:9ff:571d with SMTP id e14-20020a1709061e8e00b00a3809ff571dmr4771132ejj.34.1707301184623;
        Wed, 07 Feb 2024 02:19:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWM82yEFHXlcavFtSisFyZIsDEq8NfXHx6LrQRXFY45M2Yudl/k1Ss/7tNkxCHwfaP2JR9QF34ythba76fU+kDdSFWNJxCp+U+yZvL8AewZRTm32IUJV3H/XGGs0upS0yJFJP/TQtIbQJwlgBfyQ9qO1XwY72YWElXctzGJqC1ECXsuoblWdH5TW4c3qAr0p6/StlwZqvGH5kQAKGLOHoYra2ENysudwGV5Aas+eNchrfST01G4K6zHvodAzTyCUNahCixQGbpqx6ySalXZaHDkvP8xxVLCbJ4gf/KeyLWKV68TF8jEZw==
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id st7-20020a170907c08700b00a35cd148c7esm578627ejc.212.2024.02.07.02.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:19:44 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net v2 3/9] net: fill in MODULE_DESCRIPTION()s for af_key
Date: Wed,  7 Feb 2024 02:19:22 -0800
Message-Id: <20240207101929.484681-4-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240207101929.484681-1-leitao@debian.org>
References: <20240207101929.484681-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the PF_KEY socket helpers.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/key/af_key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index d68d01804dc7..f79fb99271ed 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3924,5 +3924,6 @@ static int __init ipsec_pfkey_init(void)
 
 module_init(ipsec_pfkey_init);
 module_exit(ipsec_pfkey_exit);
+MODULE_DESCRIPTION("PF_KEY socket helpers");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NETPROTO(PF_KEY);
-- 
2.39.3


