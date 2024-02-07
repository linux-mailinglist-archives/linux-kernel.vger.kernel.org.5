Return-Path: <linux-kernel+bounces-56306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138F984C882
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC3AB24A03
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F543CF53;
	Wed,  7 Feb 2024 10:20:01 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0203CF67;
	Wed,  7 Feb 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301201; cv=none; b=qjynGNsKJ0LvfY1BK8ZnKVXCtiIA1DOT8tkh6Fi9/slY0R6bCxabj1Y+85DPnAfryAa41ZYb6+A0j60ooPd8PxELcD9iHc7qmtxjW4nsyXvEonzSfAmYG9iB1kkt0xw4dsHoYaBi4iePHF96lkkuUxpsCKtBOZ/fOlEeUXIJXxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301201; c=relaxed/simple;
	bh=T66TSvjfPaGyd+ykHdJe5K3cX0P9xPAS2OeJTOq0uLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ej1q0FskXinW4tkSkkVIA0kD8s/w0nMMdwMNFUEJvhaHcVOz25sQhSeh8C5vWnT5epYh4ZlRWoH4Poupf+EqbLLgAVLZRkk9+c7Lv4VrveVxqJ/fYEBkMxhpK+cZGpmtwPAP4eXtjJQqGx8D1A8K8GfiRmE1BLFZ3iGfz16fjSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3884b1a441so34415866b.2;
        Wed, 07 Feb 2024 02:19:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707301197; x=1707905997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dgcbcy70G2wxvarVa/puvAxGY53YxWzlweb2szxRXUY=;
        b=uZMBEyiOCdOMT4JgftLtE6FNUPL4dAakIaYVP2XkUTXBql2FVHy4DtaWF5B+8O5AOC
         ntjCS1ydzBObVS6orGOcORvtnlKKtMwf3WkCN9F8hyTcCJIcBHMJ7UWMDfQLY+EkEg5a
         uS7VXzC1cOo4SLSZqLE1QXD9/rmIJqzE9h/IlVXWbz31WwYQoD22eLjONhn5ZMO4DUgc
         pSRj0BpNzsPYcGan+T8SIgfeo2Tao7Bk5o5dunQ+L/KmcdeDvG3Ph1pqqjINeH3CFrgf
         dT7g9S/R6pPljMiYHIoufKIsmcFr9QX7uYF0R5EO+3aw0+n0BWBddasKldFwZ5MUJ6xS
         GUgg==
X-Gm-Message-State: AOJu0YxZocTjQXJdVAcQh2dq0fA118ze9oILxiHbW+wY4AOg8Mp54KwM
	hCXRUG5g8Y7nVf/JL3SoSZWzgEiDlpSibbzUxKFatirtBA32DZjK
X-Google-Smtp-Source: AGHT+IGDx0+pilG/6e7Mw3uxagbjJhxKlfvR7k+1kB8OdBbPKzyzKUEYqx8rgvRdXciGpL7op/jYyA==
X-Received: by 2002:a17:906:2:b0:a35:fa06:aced with SMTP id 2-20020a170906000200b00a35fa06acedmr481706eja.65.1707301197525;
        Wed, 07 Feb 2024 02:19:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHmm+tpYCfx8GKAIVEF3P2oIDeeowfCKV61oJSebGnSkrF7PyDwZrxUwWX5Lic7OAS9NhjKuJma1VvkzC3olBRfUDe8sEENoR7pLFTqWJfKnytC7MkfljNjzPeiOxIGCBhq7GmhTI0F1Rl8th5OHQqZJjO4M+mBbAJ8dPK92J2B8Waj4lWDmk/wzI6EWbRMVsU2ZsSTkME3dCBzIqDEvgTjxa+MhPZeabHVFQ9PC+V4UaBVe6WIJj+RXmatE2OrvYkangTJDan
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id m24-20020a1709066d1800b00a37a38737d5sm591100ejr.89.2024.02.07.02.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:19:57 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH net v2 8/9] net: fill in MODULE_DESCRIPTION()s for ipvtap
Date: Wed,  7 Feb 2024 02:19:27 -0800
Message-Id: <20240207101929.484681-9-leitao@debian.org>
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
Add descriptions to the IP-VLAN based tap driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ipvlan/ipvtap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index 60944a4beada..1afc4c47be73 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -237,4 +237,5 @@ static void __exit ipvtap_exit(void)
 module_exit(ipvtap_exit);
 MODULE_ALIAS_RTNL_LINK("ipvtap");
 MODULE_AUTHOR("Sainath Grandhi <sainath.grandhi@intel.com>");
+MODULE_DESCRIPTION("IP-VLAN based tap driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3


