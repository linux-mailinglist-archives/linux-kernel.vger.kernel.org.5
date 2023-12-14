Return-Path: <linux-kernel+bounces-199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31B0813D61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AC61C21E41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932FB68B90;
	Thu, 14 Dec 2023 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c89FoXZc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D11697B7;
	Thu, 14 Dec 2023 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c69403b3eso498495e9.3;
        Thu, 14 Dec 2023 14:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702593513; x=1703198313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qO4xPzkioMy0PzT4rWB2kh7NbLXNeuluzCFbqlXn2HQ=;
        b=c89FoXZcyfqrWfKDOGF7TUCkQnLCe/FVUgos/W63Ss4G8eN9oPk2dbGai5CiERa6nz
         4CMqELW8zbkJ9Z0JUxqJTOOfcw9h6cFi9fQrePNOsXY2NwsxIMYCG+wkZzMyWtO2aPuP
         NGZVKJNTQ0/UQxsnmJFzPgNLxV9bd39YlmgT44qIDu7uEGlHU2o7ScT3fHDY3JiD5mUQ
         2XGc1ttKGx4KpnsLoEKtYifyCT6ra4G7WJbPG8JX0GWVVLNgGeR7gSiGmQY78oZapshd
         wrsXhNW0usNH4672bO7a0IJSRG4tiiHeOkrvhHH7yCZSQmjSt0+5HEG250iq+65Q5cZb
         MnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702593513; x=1703198313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qO4xPzkioMy0PzT4rWB2kh7NbLXNeuluzCFbqlXn2HQ=;
        b=YZc+pzpPhAQSCDmg9soF7qEB3HBbSttQplYskn0+diE1egz8OXRZpSlGpXZL1mfvid
         7f98lCBPH72nbi1u/J28VS/5jSCb+EbK8PzT/1q+TZPkBcsJFhadLO0Ck2J4taBCmKI2
         w+Jhl8s5FyHPcs1uUUZOnL9hKhfAF/7q3Wk4m5VokKzdDT/33x8N73k4MO88vm6OhliN
         EpFgxYFFbBxUNqmnOtQMTmYWWT2RXObqsc0AUvz2iyakHqMPepIAtRyJ67TUkcuIKLGl
         0xdysN/d5943FhmCyEu27uCxRfsznMZm7fLwR1zzMOb86Utv0BqCBzTP5JIKYgC+pAzI
         2SCg==
X-Gm-Message-State: AOJu0YyxhDGb3HuWC8Ao0k46FdnmVrXKt9XWRQ+iktVOH32pD45YN+5o
	qNHJwcIBxzmw1079mFSc2JU=
X-Google-Smtp-Source: AGHT+IFiBqXxM3+R4R4MdCuFdA9ekXm8MpK05BiJjz3ux0xXiPOWuVpfjSQ8at9eseLTPvOjBdNKoQ==
X-Received: by 2002:a05:600c:1f1a:b0:40c:31f1:145c with SMTP id bd26-20020a05600c1f1a00b0040c31f1145cmr5011841wmb.169.1702593512901;
        Thu, 14 Dec 2023 14:38:32 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id n41-20020a05600c3ba900b0040c61ee0816sm54746wms.0.2023.12.14.14.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:38:32 -0800 (PST)
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
Subject: [net-next PATCH v2 0/3] net: add define to describe link speed modes
Date: Thu, 14 Dec 2023 16:49:03 +0100
Message-Id: <20231214154906.29436-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a simple series to add a way to describe link speed modes number.

An additional helper is added and the phy_speeds is better documented
and expanded to return just the modes number.

This is also needed in the upcoming changes in the netdev trigger for LEDs
where phy_speeds functions is used to declare a more compact array instead
of using a "big enough" approach.

Changes v2:
- Drop stupid enum-define hack
- Introduce helper function
- Document phy_speeds function
- Extent phy_speeds function

Christian Marangi (3):
  net: phy: refactor and better document phy_speeds function
  net: phy: add simple helper to return count of supported speeds
  net: phy: led: dynamically allocate speed modes array

 drivers/net/phy/phy-core.c         | 50 +++++++++++++++++++++++++++---
 drivers/net/phy/phy.c              | 12 +++++++
 drivers/net/phy/phy_led_triggers.c | 16 ++++++++--
 3 files changed, 70 insertions(+), 8 deletions(-)

-- 
2.40.1


