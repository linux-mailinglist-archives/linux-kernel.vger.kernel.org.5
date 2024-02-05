Return-Path: <linux-kernel+bounces-52392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F286884977B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E6E1F233A9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080A17541;
	Mon,  5 Feb 2024 10:14:15 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1716D14AB4;
	Mon,  5 Feb 2024 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128054; cv=none; b=iJHrB0lIbWGlzmvIJXmFNKfYwvVJ5pb3Xmnub9oHiZyrBqpOqXeoMuh/L/XoPHbzMyqFLVTdOjwjIS/U+3E9P526Sgf/S0xiCPl403bd5RyxExCZsSllSR8B6p1Brhfmp7pH/WyXdgX7oPPW7jprkw0WxCAa5kY8Pr0MJ6LUuZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128054; c=relaxed/simple;
	bh=xH69Xw3DVD0dhlpjBXThkJ1M9fXCl+ci+4v6DASKARs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yko4ie63bUicBozUXlYG7c91b4nR0MHjfxrOPvlJJ0L6savLPhvOW2HIxPjqaPaqxmD2iYzNYdvWr83OZnF0F2kzFD5NZg5nI4+5XsudjqrNu1T2O7C1p4Vlvbr0dJRmx1SBmLBxIuW3djh9S0flOxq4QV/pn7tTTDbT3MZDtDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a30e445602cso1087243666b.0;
        Mon, 05 Feb 2024 02:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128051; x=1707732851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjSPVVvnnRzkYLgJXv5Mc7t5j4u2y9HdB6tgbsPJKPM=;
        b=V99mTgIA+waT8SgSStjzLJXuoHaIWgAQ8N2IbqGMJz0TxbYe25eb18hjBH86fNghoj
         yje8PjeUVQ97CIaGTtxvQsa5KPaepA60QUj+YYGy+rLothfvaG3wqaNj8SyWo+/9D01+
         6QdEmJbrh/jpOyFsHkUnrbIelU0cjLGFBd2e2xEIxaUygJ/MiPMCil8MWr30R+/P8cNj
         vvULv0sKyNM6H/Hs+XkOwCH98bJxWAQhJCzWr8JL0F5XWCJ+rIJ1THNUmyGt1yh1brQs
         WKpSeXC3Ct7z0AZnxOYsYBJEMoxHtzIck9t9HsYAQxP7a/EJgBcqvh9wLtwvq5qXhKW3
         plvw==
X-Gm-Message-State: AOJu0Yxi3+ARZDwcrpl4DKwv86VbRczDaeED1ZUBqmFf7hJ9cL6jq5/f
	mC8zVN/H5YwceKo+1qS7ggQhCKxCFYGmZw2wo9NpDT76RP5oy/2l
X-Google-Smtp-Source: AGHT+IHputcji5AchtEY68DPBTUtxtqNtt8t1+AFsYVJqx3/3kR2+HeT1d3K9P4gMHgTNJdc7GOn3w==
X-Received: by 2002:a17:906:750:b0:a35:e5bf:b585 with SMTP id z16-20020a170906075000b00a35e5bfb585mr5698399ejb.35.1707128050801;
        Mon, 05 Feb 2024 02:14:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWuuNv0uDM0ud0zUdGuczz8WBzVV8LwWREB/0cduFeKggkKbL/Z+69WRg3syoYLtbrrKQRJGqQkTktYF79H0RmcQSsju9TmBFlkdS+mizLsEu90nSRoL10hHyLnu2/hl8I1ECBh8SwQl5GIirkD0sG0u8rTffNSbntjzsOGy807uweC/U7IBePxRdcGm+TVVSFyDfMWAxVjxZfzyqE7GJBeuRJjOL9Lh56Buhvxp2z1zGOVhW1B8p+dasHt8iAddOuOsRc6GaeFySkMR4ChPJkzt5QnQVjY6yKFIVzhPQgdsfBiW176GA==
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a36f7891799sm4107234ejc.193.2024.02.05.02.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:14:10 -0800 (PST)
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
Subject: [PATCH net 01/10] net: fill in MODULE_DESCRIPTION()s for xfrm
Date: Mon,  5 Feb 2024 02:13:50 -0800
Message-Id: <20240205101400.1480521-2-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240205101400.1480521-1-leitao@debian.org>
References: <20240205101400.1480521-1-leitao@debian.org>
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


