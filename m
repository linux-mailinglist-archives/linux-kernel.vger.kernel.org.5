Return-Path: <linux-kernel+bounces-34191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F9A837560
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C20C1C252CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668704CB3B;
	Mon, 22 Jan 2024 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4nesLab"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129F4C62D;
	Mon, 22 Jan 2024 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959003; cv=none; b=lLcZJvRjOoTYAwf1s6pLkbFkVznl02OzxeZTfwzHxg3s/lfIjDrUSFfhomgotWy79HEsmV7ppAhfOCsrOpdFH7MehXNn5sibzWt2sNYmhGMaoVDjkjuCKONxGG15DgRcUerkmPt0vbF78+dByl3mPpDm7O7ULzyi1jvqQqXIG28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959003; c=relaxed/simple;
	bh=gVWeiOOF83lgbg3d3Hgq6hBQJa8Yf982x7sxesEXGJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1NgCAh8SfzrRiKfIH7/tOc5qRS0IeNPAsChOwibojCLCbBXrk1qCVx9Hj2cSjE4baVdXPhUWSX5ZymEs07orop8Igk5iKBIT5hG/nQq7QXRJC925VI30eACNOo+E/eCvIoh0ubFeM7kJ/d/cPQMONp0/crGypKe7ZU7X40Hxjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4nesLab; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7c6f0487so3971398e87.3;
        Mon, 22 Jan 2024 13:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705959000; x=1706563800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF2lS88daqX+EmhgKmFGg146nVZ0sD1rKTUp+1acvGE=;
        b=h4nesLabSKzQGHFe+TjNWmOY0Jkj3yInkUltP7L05QgwZ4ItRSJ4L4SONQifYs9HOK
         ibiG+adGJ692/Sydl9mxsxw2ICql0r2r5C/RFpQWvz81PhTIhTawLjLzozvd9PbAssNh
         HpluN1EQLBd5qhjObQ9InGfHBWCNumrlSUSLVgHlmNKW5Jzn6+X+kHjiXDdiq9e7tjx8
         3ef5Exg9W+jFQUx4VGwN6W+hPXsPe9prDIpEshtAyhSe+b/UBawTdsJg8Beavi7LoOHl
         WjXtM816XmUG7b9MYwdYmvcYAli3H/hwY6kGF46FU+ZfGS9QYqpok7RJgBwXtvObFvS1
         zJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959000; x=1706563800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UF2lS88daqX+EmhgKmFGg146nVZ0sD1rKTUp+1acvGE=;
        b=r+gfX9NdZtA/81THHzEe84KC/jYPFPWm/S+SzZLeprR9M30hXlEXQEcRGoM+GDj01z
         W58KmI0NM7MRgFUDFfs6Q2cw/IxsN//6924AC9ZpEbXRLCxoTfiJ0zklWCIqladFAtlF
         PiwJGAKttz4P14/Z7/npEhVcAp6Jl6kN01KcoETRpvV1ocnXtPOTOosaQQQ98oChQPKG
         lIU8vCno2qOKnERJcrm321FrXewMlf5UYdhUOgJ7mQSxlTkIcoW2Eg3mLCIFhL5PocB5
         5JfPb+jStZB1QEbtElSYVdKIBYThy8J6lwb/qdknuk1VpcVLnPL3oDt3AHfba5DE6Pyt
         PEfA==
X-Gm-Message-State: AOJu0Yyv070YtFAS/ws9ZzjDXqC/0+jQ8JC1v3Trc3Nw7gW0P/gf9Xay
	M010Poq+fWvWjRprqONH0MNNd++asJ33Ns6vbe9daP+VmBecTRQQ
X-Google-Smtp-Source: AGHT+IFjZ64Xy9dhHa77HPDbnEGumg+fhoyqMJsZWoA4es0Nw/Wy0Na6TUO7tJ375n13xr0iB9dyRA==
X-Received: by 2002:a05:6512:1096:b0:50e:dc80:46fa with SMTP id j22-20020a056512109600b0050edc8046famr1529079lfg.101.1705959000100;
        Mon, 22 Jan 2024 13:30:00 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm13823336ejt.4.2024.01.22.13.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:29:59 -0800 (PST)
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
Subject: [PATCH v5 net-next 10/13] net: phy: marvell-88q2xxx: make mv88q2xxx_config_aneg generic
Date: Mon, 22 Jan 2024 22:28:43 +0100
Message-Id: <20240122212848.3645785-11-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122212848.3645785-1-dima.fedrau@gmail.com>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
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

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index f59822cf9526..8bd68b3c3ea1 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -362,7 +362,7 @@ static int mv88q2xxx_config_aneg(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	return mv88q2xxx_soft_reset(phydev);
+	return phydev->drv->soft_reset(phydev);
 }
 
 static int mv88q2xxx_config_init(struct phy_device *phydev)
-- 
2.39.2


