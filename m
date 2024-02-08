Return-Path: <linux-kernel+bounces-58363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DC684E549
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D904F287C7C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1007F85943;
	Thu,  8 Feb 2024 16:43:03 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD102823DE;
	Thu,  8 Feb 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410582; cv=none; b=CNgRxSgG9kNnMTTO8Qsd2sbjB4mvoueyNmY2vfZsfmuCVbvtrrudP17c9QaLiHYE3ytUtbfAvu7CRxgcqp9DJXrImB+qEGEo7k6jjlf9Tx7bpm15sX6hKS8RRXzHM5nhZIHk8xcvCeR6Zh4/c3iAhfyywTz41TFavbA/kfHDWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410582; c=relaxed/simple;
	bh=qGprDF5yFbJMMfvwg7rlQsZq1GoMUYoBgio5pa7q6nY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWUA9zIIiob1xKtGUOgGLX5MWogUx+Znnk72IkyWheNgEoMt7vCEamnXEVwJapbH1H6OVhx/w2/4n98wwcx3DLc+YcG7HlukOzpV6nl+NMe5xxEwua7aJ0ypXXP7J455EfZwB6memV6Gcve3vL7anVSUwOHsqcCr1xGn4pWr7jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so277239666b.1;
        Thu, 08 Feb 2024 08:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707410579; x=1708015379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkvYXjV87q8WCwTxmNUx3QJd5xc/NdLDoxk8vLpDGEA=;
        b=Vf/kDJohlg29qvceV7jqLKfW2+aTMtDzywL0QQk3ynp8lFAhzGUJUobDwN8KGhWHu4
         CVt3EVG8J1vtb5DLR3K+OcVPUp6WVlJOKDJ+O4f2nZueof0H0s+rppb/qmkrDdyIsUpI
         98jQF/LUnX261xfBYRtOOS+oZcPN5+GxY3CrLFJJqMRJ6T4BmDo1T++iIrifmZqXi2LU
         w96TnjNXvQtOGr7sxrsRxQ74oHO7oSL4ZAAk0j6FYI35L2//jO5bW5RBqBClFAS9OPUu
         Wu/Xg+NB0M5xATWBK06Z994nvgePTfL3tSy8YszEBZ+tzNEHDgPOcMKO9k4IjMJHO8xV
         ovXA==
X-Gm-Message-State: AOJu0YwKj/QfM96PRCCY8wy3TL+BHeDPzNDFF3NUodaGf5oxoimqi+PL
	Yv+6VDDlcyVagnh0hbFOGTX6BNGYi6evspMEeSJJLVkGuAHaa4Su
X-Google-Smtp-Source: AGHT+IH7ul2dwGNdIAq2sUTLqGxn7/5daggKuKE43x4OoCRAWkWcVU9P7X773u77bNYzZvgdaLmiCw==
X-Received: by 2002:a17:907:60ce:b0:a30:db53:5bb5 with SMTP id hv14-20020a17090760ce00b00a30db535bb5mr7824145ejc.58.1707410578667;
        Thu, 08 Feb 2024 08:42:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQrK1ranyGnGRRYBkuusGjrMs1eFVK06hmGga+H28lThOLY1h43LOZcusK6oOQj8opMl5tr06R4oVZZai9/Njfz4ly3DZ6KRpeGo0mvPsB17wxAfgG78gNPS9vfgc2T4rzWnJTcbmdZkpXDewmMijLRqzIy10Eads3sJp7Ksw0ROLTupzuM9sFs5q7++igGDBgnw/uFFdGhfGcMz0DtovykDdEZUc1QFdu0u5SOpo5sNLClHYeJDrIAV7QVb7ZgLbmbKkq5YUVlxAs84LBPu2cRGDRA2dEmP3oj9V41KsBqix6d3MQvYoR+QXdEGegboUL0TOtoAsPJb8pZq3KBW+Nl6i+KHB3awHT/9JaRyQ=
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id u18-20020a170906069200b00a3522154450sm227959ejb.12.2024.02.08.08.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:42:58 -0800 (PST)
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
Subject: [PATCH net v3 3/9] net: fill in MODULE_DESCRIPTION()s for af_key
Date: Thu,  8 Feb 2024 08:42:38 -0800
Message-Id: <20240208164244.3818498-4-leitao@debian.org>
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
Add descriptions to the PF_KEY socket helpers.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
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


