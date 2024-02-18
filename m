Return-Path: <linux-kernel+bounces-70268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1CA85956C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E07283CD0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE88420B17;
	Sun, 18 Feb 2024 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqB0L/Ya"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B8208D0;
	Sun, 18 Feb 2024 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243111; cv=none; b=MGqxDeiAzxJ1UzaiYHnTQB0fp6I11zXWFAiCxaqPAZ2napyNACBk94znXNb53CJv3v5bv350Zug3sDSlu6ZHo1lyXWdw2tysL04dU/Ba5IadjOXDd+ZlX5p4Aiq39ZHz1QtJLmjXM/2LtwcGo+saarVKw4qUy95kJmf7qxnm6ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243111; c=relaxed/simple;
	bh=Ea8NaLNPADv8VDfh1Pb1Oe5BoRkPPa8AC3idJobKRtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cc9GMp+qlFCZtdudeUGCRatWv5XW9pdIueBCeFsD9jmEEYRmea8+ZgNQTQf+YC0dYOJdL9sFcH1/FOArpiqb2neVJohqFJpUUn+RklZbun4G562RfkzLuTM/TOiYGZDhSPRCj1CSqmFzffWWIf/6PFPyGfWA0sJ92kAF1ftHS/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqB0L/Ya; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso568172966b.0;
        Sat, 17 Feb 2024 23:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708243108; x=1708847908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/4bsnOcKwys+eKmRevLvzH/QB06cYALB/4EeQcmFfM=;
        b=eqB0L/YaBGa/DlrpZ8n9iPZ555H8l+nxpDfO+IoRAaNPSfhk3Gh3LSC0fw3FjnTOCP
         p+yJ/MokUY/ttdaqPNOIAwYG24jDxfMNnf0F/6o59d+KVr5yxB7ScGk8iQVjom+pHwJb
         ZQ2Qb6XBkXnuRRuExyyEqH7yEwdO8a5DBil2C8QhNAhxg5dKZ3vNK2ublMGyxPCpSua/
         y6gdCSdqYMVmGo7vh6eiDvTGYGpc6XtQWRgN9Jr1M5E+evbomk/5ntjAeeFCuMjJkqao
         9ilVF0XJZb03gerYHe80WvY3HtjNsLRX02wiKLbkYVYfWf0EuLS0so57UlLuqgrHS9QA
         aiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243108; x=1708847908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/4bsnOcKwys+eKmRevLvzH/QB06cYALB/4EeQcmFfM=;
        b=byNloUebBRp7rnRELAYav6xUmtuG6wqwrKxZsbL2ALMgsX0qeoMU/2+VkBep3/xb/8
         UsvqyAC5cuzafWKOYBZH/u8mXFXvFgUSBzfYjtSzgR7SbmDDz8FSqg4n7woH0Rtui3ib
         /twF2vCVG8Ie1dlSXYM8x7TK//SDxd23NCsbDI4+Xstnqx1K+MvSa1JfyNOyt5nrDDh1
         DW/9JjI/YFzEKuUVZS8P5nV0xU+rVlB3yT79hlKF5miSwDqTPWPV9Ftss2bWgYrFYYkS
         kTjEPHRJt05cQJjtYLjTbQPX57vnkjXgxKdEEp8Sx41rs90/lMY2/O/HQqVhPjzY7rCj
         GMdA==
X-Forwarded-Encrypted: i=1; AJvYcCU/hJ9MxyZbGayVtwXOaHwVKQQaWLDFjXTvyeFzHU4hIhly9j7aXp6I4ssYgirmfX/Onfn6lQW1yVvsw71ZtL6ShmrGkLmaVpfdXW6evSJh2B+ai9N1scG/mEulEjCtu0nzG04S
X-Gm-Message-State: AOJu0YxF7dyklBK5AqqHriu5Xk6pQqjkhkzyh1klFPDASW7qNPO/D3f2
	28c/H43f3cLkpqQl8/0JKhnOFMUFXEyMgmVh1zclD0iz1oH/Euue
X-Google-Smtp-Source: AGHT+IEhic+8p36UjietPwnv//K85VOuBnyx24EoelwCnpUfQ9hLeDwPNeoo1jqH64Cc/ZKRJtkPyw==
X-Received: by 2002:a17:906:fe03:b0:a3e:7a8e:ad5c with SMTP id wy3-20020a170906fe0300b00a3e7a8ead5cmr435041ejb.36.1708243107815;
        Sat, 17 Feb 2024 23:58:27 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm458732ejc.142.2024.02.17.23.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:58:27 -0800 (PST)
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
Subject: [PATCH v7 net-next 10/14] net: phy: marvell-88q2xxx: make mv88q2xxx_config_aneg generic
Date: Sun, 18 Feb 2024 08:57:47 +0100
Message-Id: <20240218075753.18067-11-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240218075753.18067-1-dima.fedrau@gmail.com>
References: <20240218075753.18067-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Marvell 88Q2xxx devices follow the same scheme, after configuration they
need a soft reset. Soft resets differ between devices, so we use the
soft_reset callback instead of creating .config_aneg callbacks for each
device.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 11963d8176b2..5bc36cc68a20 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -365,7 +365,7 @@ static int mv88q2xxx_config_aneg(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	return mv88q2xxx_soft_reset(phydev);
+	return phydev->drv->soft_reset(phydev);
 }
 
 static int mv88q2xxx_config_init(struct phy_device *phydev)
-- 
2.39.2


