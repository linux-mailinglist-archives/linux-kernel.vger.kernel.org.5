Return-Path: <linux-kernel+bounces-17242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FC1824A54
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED4A282E45
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159F42C845;
	Thu,  4 Jan 2024 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5zVyOu6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C52C6B0;
	Thu,  4 Jan 2024 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5f40ce04so9314015e9.2;
        Thu, 04 Jan 2024 13:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704403865; x=1705008665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=el7QTA9pZD0fhoRA6AG1w+s9PIDJKYiV8SNI4Yuu+Vw=;
        b=B5zVyOu67EZLD0sDvuhGEGtm6vJ2cAu3CnOk3M0snRGUD9Uvx8Q2Y1TglOML7bSLg+
         dU9vnLXmUEWQx/Hj8wPsW3SN1Uo/TdQX1zinw7/sYLs/aNOtu3HSLavWSsZo0SxecIUq
         6ub0XGGPmBxGdDUDO1l93DZNMbd55XaddfjPltH5aifnWUT5yG2Se38DKWUvIkjFfSE7
         6auQqaCqeXBHSIvbDL5NH4f+92LUREBsj64b1TDHufQcdfz7EnMk7at1MaFgkZE8Q1CD
         8roxW1hqDo9hFAm+QOJ86QKNuWpx0bs4LwdEkoTlv+IChqFpSBkvibi5tRUC3NkLqct1
         J8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704403865; x=1705008665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=el7QTA9pZD0fhoRA6AG1w+s9PIDJKYiV8SNI4Yuu+Vw=;
        b=qYs/SADA3WLXCRMVtwgE9c1GZwMTBu78Cr7osbmtNoXOoBcbQKndrVB0tFhmzFJnLq
         OJbpjy6PDg6LweG6cD7rErsxny4NUhlKn9/MrF5KexHGt3KnWLZB0qV4t0Q9ysmVuKcp
         9Au9ohTUhZbxTzG4manyW/Eae1sW9ffDJQ5q+fFSCpNXai9A6O5vPO9/IG1vbKVXBZUl
         A/pMjgYnbhMUN1tWzK4vzlKYFzuR26BMw0l3HtvDFMQm0U0pxTHSrMsZeg6FFWlJ6zzQ
         f9Vs2jBOdx+MqEqXQXtDFczQ6+2TMm9DF+GkUh7rqWKkfhJmD0Nja+2a+RxM+KWeMUEn
         drsw==
X-Gm-Message-State: AOJu0YxuVrEQSTzCroRa9f/4JEvu2RdER/ZWAuh0/kjn9bPthGgBN+4d
	ra6LlHCBpxxCTMkiJGMYu7o=
X-Google-Smtp-Source: AGHT+IGPgIVyL0fDlP/oZhbxiwUwceYPiuP4UPBAmGWmeSSpVZCs7VZYYCCBtOAwZZY+mhkm9w0Raw==
X-Received: by 2002:a05:600c:3b14:b0:40d:5b7a:e31f with SMTP id m20-20020a05600c3b1400b0040d5b7ae31fmr717017wms.39.1704403864698;
        Thu, 04 Jan 2024 13:31:04 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.pool80116.interbusiness.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id f14-20020a05600c4e8e00b0040d3dc78003sm407291wmq.17.2024.01.04.13.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 13:31:04 -0800 (PST)
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
Subject: [net-next PATCH v4 0/4] net: phy: at803x: even more generalization
Date: Thu,  4 Jan 2024 22:30:37 +0100
Message-ID: <20240104213044.4653-1-ansuelsmth@gmail.com>
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

Changes v4:
- Fix Smatch warning
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

 drivers/net/phy/at803x.c | 186 +++++++++++++++++++++++++++------------
 1 file changed, 131 insertions(+), 55 deletions(-)

-- 
2.43.0


