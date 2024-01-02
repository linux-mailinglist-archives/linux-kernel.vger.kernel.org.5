Return-Path: <linux-kernel+bounces-14455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A164821D41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E92283732
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A682A10A0D;
	Tue,  2 Jan 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ccp6Nxdq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A3510949;
	Tue,  2 Jan 2024 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d8991f1acso14235845e9.1;
        Tue, 02 Jan 2024 06:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704204215; x=1704809015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=awobl8VjBDg7kap3xLk73wds/lfIaStSTrwk13gNoso=;
        b=Ccp6NxdqzqoU044Z4brWeaSeMCTEWOdtuHHv23hb46t50JH2t6gqZ/gLW+1qsdTWtz
         nQa7hNQXGlGZO8gkCCEKMIV0NmsIqAipsaaNHnVbvBz7RZa5JDF+bVT8sVqVH7sugoMI
         nClLU3+liVLMCCB5GZj2WVyQqM1EpQiT3iJ1x5sBVQFJ6/z//z0V9FyoZbw3Uti9BFV8
         /JMUKxpjv/Y6qK+ikkrSewXPsVVDWju05tYTa5BslPECDIFrYzTZbyPjvuJ/D/0hXxR+
         ZMkDr4gHdmCfCa2HWMCD4yTmxcRw9OtwmLDOBsFWZBsfMYV6FAgs05uCOv//gjYydf1L
         MvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204215; x=1704809015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awobl8VjBDg7kap3xLk73wds/lfIaStSTrwk13gNoso=;
        b=oBSzLztntB2RNhZEbzHfkAODDtcP3stw/ben0HcirsJiWr4elOYFbf1PCM/QeVN0Rs
         Glmr96h8CpjGUobluI/TTucLFpQ6DMNpN3UBXnAp4USwJ/wOqhmd13zDTAyl3Df4/b4g
         K9NFW+vviOvi1beE8dES4lMuGt4rDBTtqKwyiyzX4EpTTHf/6I1B7nJX32C+Ti5PvFd1
         0NdEwMB7UT4RMUApAr21NKN8jqFSF9/LwaYi7d9iOuO7mQYeh3CY36gRlO0qFm08J70S
         3v6LykeF1jKUHlVz6nxem7/6WncuGgWPee34NShC/51UjOVqXqAS+gFJBwpGtqmNVFFe
         gkFQ==
X-Gm-Message-State: AOJu0YwAUZDtJT2MRlCaiuEgPUIZBFA+iwI8IWPlvA/CU8Bby3EfjU5O
	O7FkrVZC055Sf8K2DyYYVS4=
X-Google-Smtp-Source: AGHT+IGjWPQMT5ktYvyAz36LOlc7pBfpxvgWtK7kq7Rbteikwx2+6+aTk/sjJOMxVp1y2vtgh0vFAQ==
X-Received: by 2002:a05:600c:2d84:b0:40b:5e59:ccb3 with SMTP id i4-20020a05600c2d8400b0040b5e59ccb3mr8822636wmg.148.1704204215352;
        Tue, 02 Jan 2024 06:03:35 -0800 (PST)
Received: from localhost.localdomain (host-87-10-250-100.retail.telecomitalia.it. [87.10.250.100])
        by smtp.googlemail.com with ESMTPSA id e17-20020a5d5311000000b0033672cfca96sm28427527wrv.89.2024.01.02.06.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:03:34 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 0/4] net: phy: at803x: even more generalization
Date: Tue,  2 Jan 2024 15:03:24 +0100
Message-ID: <20240102140330.7371-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is part 3 of at803x required patches to split the PHY driver
in more specific PHY Family driver.

While adding support for a new PHY Family qca807x it was notice lots
of similarities with the qca808x cdt function. Hence this series
is done to make things easier in the future when qca807x PHY will be
submitted.

Changes v2:
- Address request from Russell in a previous series on cdt get
  status improvement

Christian Marangi (4):
  net: phy: at803x: generalize cdt fault length function
  net: phy: at803x: refactor qca808x cable test get status function
  net: phy: at803x: add support for cdt cross short test for qca808x
  net: phy: at803x: make read_status more generic

 drivers/net/phy/at803x.c | 171 ++++++++++++++++++++++++++-------------
 1 file changed, 116 insertions(+), 55 deletions(-)

-- 
2.43.0


