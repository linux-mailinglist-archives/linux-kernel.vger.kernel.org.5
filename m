Return-Path: <linux-kernel+bounces-58365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F0C84E550
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED7428CA30
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5E686AE8;
	Thu,  8 Feb 2024 16:43:04 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E02385276;
	Thu,  8 Feb 2024 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410584; cv=none; b=m/YdOYvKLRC0XzGNoh/2oVolCady9olaX2JcDMshYlhmstLV3TeDlHXqmWq6XzpDky2Rs5XbjVXvYACr1Fh/aUrYQBvR8T991dd+esBdfD4Gc+h0nCRQNOabeZG3oN9vhkCKcmdjhHEJPPrqD2EzdS1SV9v8SXoieX3pTuddUFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410584; c=relaxed/simple;
	bh=0TJr9SPkwnlTG9uKVj59UILIzyUJlgu+VRGvyidgXCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wq8qvcV8UnHK1TIAELk0u63Rt8zx7+agq5cOVJ12gn30l43TzSQhPNbkLwpyx2b/O17hdIfcJpBzv2MahWb5skMXDkdGaVAob1nMThdcfrc767ERU3w/KHFRlbyXeTW2MS27Dg9mXrG7e1JdYUV0PFT9kfOxPuNBJKupbse3GXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3916c1f9b0so170888466b.1;
        Thu, 08 Feb 2024 08:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707410581; x=1708015381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6NrglvQNA8UcjFWlDsn4D/ol88i9iFcMKr2mLjvwfI=;
        b=bWPMmAv5PPpeZ6rf6Mcp/rDTI2AtRyoiqfI0nedN1n+8SlC0fZkhrvXqxA0yGxH2Fb
         VlMHoZ2YrlxvdUCn9uNbReXueajwM7rDe2GKuMAUhs/FqpDSY4AiFlDmIwy9kLcFbNmB
         VDAFNPO/dd3oRXUyX4pOVaXVc6j+A0QMC8K2umU14YlvrwR+vWI8EYoJgsbh4/1+pLUn
         GqXXnYXL3RdWtRrm4Fe1NzV8Ysa1Z7SkmlmTgWvJmugU6cHq6iS3Us0Ttf9AvkjbXsGy
         YaZWU3HE0LOa5qJYGGLh9Tgj9GZMxyNmrv5LsyZ0zmnOMt1nawqywPXsdmbdPWknHbmh
         4IOw==
X-Forwarded-Encrypted: i=1; AJvYcCWS+GvJycw6FeHL3/I8c8fDMuvXYavmq/XTRPX/SfC3pxsw8+AsRgwrXGKb7/9HMa04EUT+5jyEyhPFaBwuiyKA5xa8SRSZi/5euljDaxNt4NUdTINYwe72QaudbxDLq72EuCKlHGzhwYQOJv31m/r8NNHqhg1UM22teWxiM741vBpOWSaLOawrPw==
X-Gm-Message-State: AOJu0YzcSJVapR1fgF0hkMalfEBeehItCPnxJDqh5nq29ldlRlK97/yD
	+RQZpvGNaG3TWhQusTCaCFRhrMN3R2KM7EHppwYIdEeP7YJXgsR6
X-Google-Smtp-Source: AGHT+IEVdByW8vdmM232leKEL2grx8yFSsfrFp4uRJEt8bXULYqon2r5VuiscI/p1X3+2J9ZpGGShA==
X-Received: by 2002:a17:906:7cc:b0:a38:e745:fb88 with SMTP id m12-20020a17090607cc00b00a38e745fb88mr2410396ejc.57.1707410580613;
        Thu, 08 Feb 2024 08:43:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2V2LpfZ0wvPrNAyW+/jX8LM07o02stddr3VyFKzA/uf4lP94qe7uR3OZVYf+Cb3dmSMS+bRTuQ1Z0UsZ8ASHSOkZYDA7mhPlQaLK+dYmFgbH0kRcWajiF4jvarfERj2tzJAbvOxCBwtIp+7/xYxkmbT8WARVLjt6NHZXtu1TrTn8pIMw8sn867qFb5Qelcbg04Yk7NaIuKhpG5IH+z2VpdwsMh1Ofpink/9xYnewUiOGFuIqZYm1+9xNgxzxEP9jZjCmfcOzA81zU85I7udqsxpRKOQZUbF9U6pT7shyAgI8DwuvEmGoiCRCJFBDeLYLb9iQv/C8VLVj07ke3Q5T8FpMVTrs4nehtzhwGJ/zcvrRu4fNL/1VwIwMLoOgIBrcNNaIGSHAgRteVd1XS/uLhs//qZJL/DeCrE/c=
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906198f00b00a3809ce7e00sm215713ejd.196.2024.02.08.08.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:43:00 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Alexander Aring <alex.aring@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	jhs@mojatatu.com,
	Alexander Aring <aahringo@redhat.com>,
	linux-bluetooth@vger.kernel.org (open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4)),
	linux-wpan@vger.kernel.org (open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4))
Subject: [PATCH net v3 4/9] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
Date: Thu,  8 Feb 2024 08:42:39 -0800
Message-Id: <20240208164244.3818498-5-leitao@debian.org>
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
Add descriptions to IPv6 over Low power Wireless Personal Area Network.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Alexander Aring <aahringo@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/6lowpan/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index 7b3341cef926..850d4a185f55 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -179,4 +179,5 @@ static void __exit lowpan_module_exit(void)
 module_init(lowpan_module_init);
 module_exit(lowpan_module_exit);
 
+MODULE_DESCRIPTION("IPv6 over Low-Power Wireless Personal Area Network core module");
 MODULE_LICENSE("GPL");
-- 
2.39.3


