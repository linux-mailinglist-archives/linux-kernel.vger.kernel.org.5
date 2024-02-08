Return-Path: <linux-kernel+bounces-58361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0838584E52F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEEBD1F286D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B051E80052;
	Thu,  8 Feb 2024 16:42:57 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F27D41C;
	Thu,  8 Feb 2024 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410577; cv=none; b=QshetxUIJBSxY4HKqNzk/o5ZAse8mGkuaJK8EBzgLRNEwLGCMxG/6yXUuShdCAvi0KDiLn/Livk5gGB18zKFP30YwndKIcY4TkCtHdwX1uFM7kxUPnvhPye3/PWW2nmgBmBOZgcxN3on+zAyaXykGmlbRnPsdtVXtVkcymEu+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410577; c=relaxed/simple;
	bh=MRXHEQkf7wqs+M7qYmfTRp+de2JnYANEUAI2NYkiT30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/+PcmyMnxkIDpvnoiaeGWziddjVXKCBjzVNXi5FFU0vd3GC0f1MDAVDaWsSNRikr7ZtbNH9muajDrbQbTWLatrCXsd8CKyVJgocqanqSOohGHjZSVtjhCJixyV66FwESq0c5OoH/baJ8ioo+Ijts+nQT0D4NXQwdYAA7T6xzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a389a3b9601so215780266b.1;
        Thu, 08 Feb 2024 08:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707410574; x=1708015374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o586i0NCF+hpa/78D7n7u9Ed3lb4YXQk+TxOLpi8A+E=;
        b=pu/wxYVkdaDBgi674D90oYuWS5yQTH/aI/L4ykNojtgShqD0pvF9rCDTh6J57gLydI
         JIOsqIY43QV4kTVdzXCpiSgElfU6QrkVzVQlqtls2nHqLTJ3u6Db7e80i8ecJHAlXmcL
         6Sx4tyxOr49sRRTiACBkiVFQFf/XKNilczrYmsNkqvOGuhfxDDFNKgdwVWdH6gFj70t/
         J9tHcbNqy8gUT/pRNlyX769hjMa6sgFoLBpMN5zHnUTc3lrV+HfTdyHROqzptk8hdQla
         kO/a4xndPmtwvi8SXv1uASyFlYWyCUkQ3nPezpytESJiqBxyiZCTSl6IoKaNgh+1xlOE
         Dj6w==
X-Gm-Message-State: AOJu0YwqEsigFWUcRgHMkfcQWQemQkkz/Aq4gEslHtpVw4UizBa3yBsL
	RQFHuXY+OoSOu07dEzIuiPeK0ynEHphzRyA2l6u5maPLSqy8QDdo
X-Google-Smtp-Source: AGHT+IGcuatqdPy8GgpTDIh+gxRMsVBvNGo+53PkPcVaKsxwwKRN3t9k/R5D04UKPpfqEZkLzlHZ2A==
X-Received: by 2002:a17:906:298b:b0:a38:9446:106 with SMTP id x11-20020a170906298b00b00a3894460106mr3197877eje.51.1707410573704;
        Thu, 08 Feb 2024 08:42:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdBaiu6liz8/zwUl4sAlkVnvnnHfYDIuogkwiOPJzX+/w+/lT2SuvsIgrOR3RZBcx1fjEFXNp3/elwqRMfE22Oc2ZIPlzjzgN48uUDnAJFJ/+ciKitWzY6Vfmbb72SZqO204+Fr6lDxmTLP4LP0jTz0u0dETw7HjRw53QHno7Crw7+j8NksIXudmI5UVZ+ZDE6OtT8qY8awLCApZaXdLDkYCxCvLzVgIFKU0+UINGJP4qbVVpCddFCHswzUOWl1B24LhzvkhiE41ZuCkEyyrOBkVAYF63csN2b8QcYGwlRuD0KTWzAyXawSvU+b+QHBGaWmDNEKqOWJ/NSgWfXHskBN/vkvp/sqpqh6N+Xh2s=
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id lf4-20020a170907174400b00a3bbf725080sm224797ejc.55.2024.02.08.08.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:42:53 -0800 (PST)
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
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	jhs@mojatatu.com
Subject: [PATCH net v3 1/9] net: fill in MODULE_DESCRIPTION()s for xfrm
Date: Thu,  8 Feb 2024 08:42:36 -0800
Message-Id: <20240208164244.3818498-2-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240208164244.3818498-1-leitao@debian.org>
References: <20240208164244.3818498-1-leitao@debian.org>
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
Reviewed-by: Simon Horman <horms@kernel.org>
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


