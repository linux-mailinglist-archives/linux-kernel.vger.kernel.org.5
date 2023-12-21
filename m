Return-Path: <linux-kernel+bounces-7935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3F81AF6E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F7AB2524A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973BC168D3;
	Thu, 21 Dec 2023 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg2zd1Ol"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793FA1642A;
	Thu, 21 Dec 2023 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5532b348d30so492390a12.1;
        Wed, 20 Dec 2023 23:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703143760; x=1703748560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejo7wkMYCp9JjGzkF+F3cQyIjCmI1lLvd98NTJgc+sk=;
        b=Tg2zd1Ol2h0Z/FC7cQDpL7o8GdJncVVsuG7JIoThkj3DdTSblxph5wkDYNg9pl0Xmg
         tDnaZnuMBZ59Ts21vFvizoTcj5NfGmcCalPfVjH7U6z/bgDcCU7PdEnUX4xamjFDep5h
         h0/UucoslLgqVSfFWG4mWQoYWLQi+a0EXzMnZTq7I15ci+Je8zrkK9m6AjYGrG6lOOVQ
         vK8X+aIsonrz5URrhZGZx67R4FsM4TBdKqP9Ai4jeATCrEGZ2EX4QxDB14wcnjEqTci5
         8/utjsf2XcME1hsyD5XSJcNES4b09QAIFmjYwpjYpPH+0I75L8NkGkk4ZEhWBZu6Ft2Q
         bzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703143760; x=1703748560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejo7wkMYCp9JjGzkF+F3cQyIjCmI1lLvd98NTJgc+sk=;
        b=gFqmRA5Q01dbHoPeoX6bYbck3/43EIoNJJFquuRfE2iBjOmo/XuOAjbBoQhQoaC5w5
         JDnB2Bc56lmfJzJVbAOvcBVpSiNOiMnN6DABqbOKUCdo6Ijuml1xHuwSdu9TrNkDaB2z
         S9mHczyyNYvfxOZM6WfKoKYKrxqUbecbpvExTK1diU5BUkGeZEfEm2ZFCD+a+lDY2yQK
         aOdEkJOSS6sgefiUBA8rgNKoL1a6okr0u9tkS7BDlPcFpc4r4GFnZWrSXX7DDyTTJKl4
         d7YFKDEPZIprxuTafYJPRlCRqyszElddscrEgUQhk8IRH6FiiGYVuQhUi57eXmnFyM9R
         +cYg==
X-Gm-Message-State: AOJu0Yx8HVdf0+nhDVBUhRQXTBsnnQenIAzBplBbo/d/DcSVz634k//i
	qwGHNiHEmQQ+nRaH/rK+TA1L5P/dWUdXdA==
X-Google-Smtp-Source: AGHT+IH7yGg/Ns5KOnK4mfcQDFx0W0vpoxuqVHVxZ8KxmZHCsbNzUNupXvfKONBQN/wk4wTuslrzOw==
X-Received: by 2002:a50:a455:0:b0:552:3044:1df9 with SMTP id v21-20020a50a455000000b0055230441df9mr6605753edb.67.1703143759673;
        Wed, 20 Dec 2023 23:29:19 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id en22-20020a056402529600b00553830eb2fcsm787819edb.64.2023.12.20.23.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 23:29:19 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] net: phy: Support 100/1000BT1 linkmode advertisements
Date: Thu, 21 Dec 2023 08:28:49 +0100
Message-Id: <20231221072853.107678-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221072853.107678-1-dima.fedrau@gmail.com>
References: <20231219093554.GA6393@debian>
 <20231221072853.107678-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend helper functions mii_t1_adv_m_mod_linkmode_t and
linkmode_adv_to_mii_t1_adv_m_t to support 100BT1 and 1000BT1 linkmode
advertisements.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 include/linux/mdio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 007fd9c3e4b6..3d177f265cd3 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -372,6 +372,10 @@ static inline void mii_t1_adv_m_mod_linkmode_t(unsigned long *advertising, u32 l
 {
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
 			 advertising, lpa & MDIO_AN_T1_ADV_M_B10L);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+			 advertising, lpa & MDIO_AN_T1_ADV_M_100BT1);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT,
+			 advertising, lpa & MDIO_AN_T1_ADV_M_1000BT1);
 }
 
 /**
@@ -408,6 +412,10 @@ static inline u32 linkmode_adv_to_mii_t1_adv_m_t(unsigned long *advertising)
 
 	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT, advertising))
 		result |= MDIO_AN_T1_ADV_M_B10L;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT, advertising))
+		result |= MDIO_AN_T1_ADV_M_100BT1;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT, advertising))
+		result |= MDIO_AN_T1_ADV_M_1000BT1;
 
 	return result;
 }
-- 
2.39.2


