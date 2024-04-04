Return-Path: <linux-kernel+bounces-131474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C56D898853
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA05B1C213A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F39E1272A6;
	Thu,  4 Apr 2024 12:55:17 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D959157;
	Thu,  4 Apr 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235316; cv=none; b=Qm4IJu+gVC2ySmcE0D+9SytLC75QLIqIlql6zraEGPsYh8NFFXwP/obXL2WA0B+IbjCe7CXg5H6ePKgedLZ518pWu2jSr0UcGmDi/t8dkDbVZ1VH1oMqqvK7WgN7LXDZvaWwCth7+NkcEGMhxjRGmCugOMnJIWwf91VAPm6UpYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235316; c=relaxed/simple;
	bh=ostQ0XvbZ4Xswj3rkDxFH+u55Uw1YqBVGn08piL5Ih4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GagwH55Ha5JxWnq7So5Q2WMvQtTclCJazel1eTVAj9Bd3A7hB9AU+gd76n1eas++c7r2Ne/WQA+1m7G9eviOmPXsmPc/KRdJGiLHx2WFWdyfhQFo8GualHunbFdUVjFYQLd3n1MToIN3ptGX29p7UjPKTcQUOnfIemVLvlFUU4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4a387ff7acso120434066b.2;
        Thu, 04 Apr 2024 05:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712235313; x=1712840113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6O2JKeZvqaoJNzaclf36Ur4Gc3+emicV0GwUt8uQmao=;
        b=TTbSNeWQLH20YpGujWIEvKKex+Iy9AumzfM436MeuL1O/9Vg94oUmUMCG8OtFh8jMz
         5UESFEzrtWlhHih27HH4fqA/605fWqKTGWUGIOQV5fFH1bx9+gCny5f+9DCy6f4bZjJ7
         6gbdUlYbcR5UCzYLdrb+rC1JOLnw07T9JTvri1GTKr0pY5mp2dl7qD7L4UQg/LJ8HKve
         +Ko/VJ3fZ6t2RQTwPD+g4zoVSghG6lsYVCuI0s3AZ5sO0uWXZFSD09uLoDxthf2bXzUC
         kWxYUcr9HMJB3tNeJTyeGMLatxzXjcduUj18ia8UD6o0fPB0TCJfmDjI0q4Xxdy1YhAa
         Et2w==
X-Forwarded-Encrypted: i=1; AJvYcCXWtLT4Tl7u4YKIa+xGEhmthaKbGLV4i6nOUGVVwe7QQEg1PvR+gnH5dyckhQ0e8vd2kImrxUXdAqdUuDanZpCm9eukguPA
X-Gm-Message-State: AOJu0YzvZc19hxfVXo8tmGFX76lKMaJV1f0izfGsEd2YxkMAJsRKW1Ie
	VvlkNwYn0UC3AmhEyWjaTIm57U8uEwEdBXC8HsCQ0q5quV84r97d
X-Google-Smtp-Source: AGHT+IFik+fbQrbMFPzpT5sag14+qCt6HdMSkhsjjRwPbfYxPNdO3b+FTDja065PzdWdD8NT7TlBTQ==
X-Received: by 2002:a17:906:1687:b0:a4f:b391:886b with SMTP id s7-20020a170906168700b00a4fb391886bmr1491841ejd.69.1712235313187;
        Thu, 04 Apr 2024 05:55:13 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id gy18-20020a170906f25200b00a4e4f129d3bsm6478237ejb.26.2024.04.04.05.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:55:12 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/2] ip6_vti: Remove generic .ndo_get_stats64
Date: Thu,  4 Apr 2024 05:52:52 -0700
Message-ID: <20240404125254.2978650-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404125254.2978650-1-leitao@debian.org>
References: <20240404125254.2978650-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
configured") moved the callback to dev_get_tstats64() to net core, so,
unless the driver is doing some custom stats collection, it does not
need to set .ndo_get_stats64.

Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
function pointer.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/ip6_vti.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 71c749bb4b3e..4d68a0777b0c 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -887,7 +887,6 @@ static const struct net_device_ops vti6_netdev_ops = {
 	.ndo_uninit	= vti6_dev_uninit,
 	.ndo_start_xmit = vti6_tnl_xmit,
 	.ndo_siocdevprivate = vti6_siocdevprivate,
-	.ndo_get_stats64 = dev_get_tstats64,
 	.ndo_get_iflink = ip6_tnl_get_iflink,
 };
 
-- 
2.43.0


