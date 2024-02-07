Return-Path: <linux-kernel+bounces-56299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F2F84C872
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094642837A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9DE2562A;
	Wed,  7 Feb 2024 10:19:44 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1915125571;
	Wed,  7 Feb 2024 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301183; cv=none; b=XHGreJDeTA2gVWmeDKXWhDrmqv75JHNr7Lrlm9TJtMKHPeis8fhOSQ0eW00kpvcW/e0yiWG+kmXk3tEKbKQfMnXJOX00vVRm0XvNLRqbJwxjvPfZEjn0tqh5ApKyoIhduxmTwbWy19fR6lE9bitn4LxRZXvNvwPAE6tj5CUw0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301183; c=relaxed/simple;
	bh=xH69Xw3DVD0dhlpjBXThkJ1M9fXCl+ci+4v6DASKARs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L/99j55WwOWuJ7kydqAC0WlEnVgqj+yp3PSZtRcfWJcp49Ee1doUo9v32qDRY19aFy+fAQNttdID9yF0o4PM+9x0dHdE9w3l9kkkt+D/9a4T9uO9KqDyV5n3whg0jAXTS6wpZYP3xPzb4xZE4dZWO3sbWlXh0zOBefBqICnhBSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51165efb684so767552e87.3;
        Wed, 07 Feb 2024 02:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707301180; x=1707905980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjSPVVvnnRzkYLgJXv5Mc7t5j4u2y9HdB6tgbsPJKPM=;
        b=bfLyOBrlCSrzqAXHaBg0l7sxbiGC0y+ZOnR+EJH8D7c4wvzM5yZAKZm11LH8o2akkn
         a61ahttoIGBMui9RbxS003QGAInlliZikbRH51A9ppDOKH9V6c9UWa30yU4AZJnDV0+h
         Wi8UB1O2gMkhbf2O++xork/jU4x4/+vweaRR7eGE37JzsSbYgMMMBlYbDj7dP783f0p3
         lrP+uzw5Q0RaBG54R5q9HOzqW5Aj5oca3aQaRZ4YrZ6xkLdN6wFb2bHkOfrZEO4NyNM7
         n3fmzLGZapw47ID0K3KWhOD7Cda1+F0+8UQH1bsLJRUHZIt9r2lI8sa2yn+HPXCK2cVH
         Uw6g==
X-Gm-Message-State: AOJu0YxbxDmLQJTx8BgT7jkDvFhQaWjwkeUd+oMDr3thcmLUpkUwwAeV
	w7Sp1u/3XKlrc0TX5Ul7PdrS0neAy3vAEOYyKO2QWwAPDQ8fZIF5ff3HDh1dxU7wZg==
X-Google-Smtp-Source: AGHT+IHgFAvwfVV4NmDZ17v1iRxOL1dreU/Wbrnf2eBIpSJ82+7Xh7gWPhnR3rzbeMlhOITysEk3rQ==
X-Received: by 2002:a05:6512:39c7:b0:511:3a20:e116 with SMTP id k7-20020a05651239c700b005113a20e116mr4698458lfu.11.1707301179832;
        Wed, 07 Feb 2024 02:19:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsJ2RavYcUMXxJ4dhE9wwHOOAS9EYUmM9ZbHI6thppYYxFjljxN3RPUkT1wylwXdW9uMRzYZWX1LaHe+153umJgFbieMLwZdSF7jXmo4T0kaYKVuCxgViVo8hH9hCu7u5nTL1OqA0/tEVx3j3FYwtTqxAXLMjWP6OUb3pGoZuh8QFK8+CKRyha0w2gxD97Cz82wZ5pygBWSV7OFUPjql60ktc11EqBWZU3uiQr2JBaTJ7E4fo3OQ6PD928075kaSTJTFqFZJa154kPpJJbAdWBD5lDuWCz9x/gPETCMg5DhbzpS2hEzw==
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id vi11-20020a170907d40b00b00a37b0d09d9esm576760ejc.119.2024.02.07.02.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:19:39 -0800 (PST)
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
Subject: [PATCH net v2 1/9] net: fill in MODULE_DESCRIPTION()s for xfrm
Date: Wed,  7 Feb 2024 02:19:20 -0800
Message-Id: <20240207101929.484681-2-leitao@debian.org>
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
Add descriptions to the XFRM interface drivers.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/xfrm/xfrm_algo.c | 1 +
 net/xfrm/xfrm_user.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_algo.c b/net/xfrm/xfrm_algo.c
index 41533c631431..e6da7e8495c9 100644
--- a/net/xfrm/xfrm_algo.c
+++ b/net/xfrm/xfrm_algo.c
@@ -858,4 +858,5 @@ int xfrm_count_pfkey_enc_supported(void)
 }
 EXPORT_SYMBOL_GPL(xfrm_count_pfkey_enc_supported);
 
+MODULE_DESCRIPTION("XFRM Algorithm interface");
 MODULE_LICENSE("GPL");
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ad01997c3aa9..f037be190bae 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3888,5 +3888,6 @@ static void __exit xfrm_user_exit(void)
 
 module_init(xfrm_user_init);
 module_exit(xfrm_user_exit);
+MODULE_DESCRIPTION("XFRM User interface");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NET_PF_PROTO(PF_NETLINK, NETLINK_XFRM);
-- 
2.39.3


