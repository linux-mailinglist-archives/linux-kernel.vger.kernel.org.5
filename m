Return-Path: <linux-kernel+bounces-15531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C30822D6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A921F24379
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D919456;
	Wed,  3 Jan 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkFGe3sb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5F319440;
	Wed,  3 Jan 2024 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d89446895so2491235e9.0;
        Wed, 03 Jan 2024 04:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704286009; x=1704890809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jsq3OCLIVB4Vhvlqsi6n871YvrY5KZyh3nXn/CFzR1c=;
        b=SkFGe3sbaQNGaYPP/INiccHUKTUTBoAlBMwWQSVixd9THIqcnz8fhwYK4EMrWT8Hdy
         yTVjvW0m+H8s7BixZBlh7lJKTnxMJ/v84gvXKAM9u+qJEJMA5STZiZ1vxKGKjA4teNdC
         pGK0X0AOXrsnBT0LGzxbQZYCX9HbGjMvuhKh0FlVaVZKr5MIVXVBuGE/vi0hntPYOp8I
         oDMgC6iIy8nBycxRsbV4hGnqNIkoFr1KVuAFboOfolx7Z2Ladrb9yA0+t3NJtH9XFOEm
         J4id7NbgOdgb8HdapZvMr6+BIpuZoGCOyKs/bTHzlJOeDIm8hzdQhyjI2JIl2nrkLe7M
         Va+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704286009; x=1704890809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jsq3OCLIVB4Vhvlqsi6n871YvrY5KZyh3nXn/CFzR1c=;
        b=WK8mxteK5zpdxwAnm1PLpP3rdQEfAgHuk/k/r8p+qyMf6dp0Sl1kZY3q3GF55mUMG0
         IKrK345y0uw9kVAy+ejjzQJnrASro/ZAZ7vBGOa9e0cmlCQFoSVxrnfyBqJHphq4pFCA
         mtufNBg6cM/KmO4iXa2zc/HidIgmAaqujqBjEpfulwXLiFbEZuBEDQG3HVZR6LgkrZ6V
         +YkuYuOuZTgmb8I2Sk/dxdak6OPh/1USxvrTYhteL22wyZ4kRCFkrjVR7K2lplfF1lfp
         MEXSNg4Zj6dnR11S+MaQmCyTnlr+kW13GK7IHJ3/c7uri7pXI/oWWCeX2s+Vq98UeYdU
         7htA==
X-Gm-Message-State: AOJu0YzGMipeD/M+LFYg2ZblKDtw8dBpretfzYP4WD8MTlgAtBH6WGDQ
	32xVlW+X7A1Ob29TelMNFEs=
X-Google-Smtp-Source: AGHT+IEjOUPsKWCDqXMR3N+V1LnLUGxnhVdA+EH+cINY06coME3ftiVYspKpjEtW5faJyzb0+noKWw==
X-Received: by 2002:a05:600c:4683:b0:40d:709b:2b95 with SMTP id p3-20020a05600c468300b0040d709b2b95mr517021wmo.152.1704286008867;
        Wed, 03 Jan 2024 04:46:48 -0800 (PST)
Received: from localhost.localdomain (host-87-10-250-100.retail.telecomitalia.it. [87.10.250.100])
        by smtp.googlemail.com with ESMTPSA id fc16-20020a05600c525000b0040d5c58c41dsm2219676wmb.24.2024.01.03.04.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 04:46:48 -0800 (PST)
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
Subject: [net-next PATCH v3 0/4] net: phy: at803x: even more generalization
Date: Wed,  3 Jan 2024 13:46:31 +0100
Message-ID: <20240103124637.3078-1-ansuelsmth@gmail.com>
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

Changes v3:
- Rebase on top of net-next
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


