Return-Path: <linux-kernel+bounces-1014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD3881493D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ACFDB237CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35762DF91;
	Fri, 15 Dec 2023 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh8AHGwe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4AA2DB74;
	Fri, 15 Dec 2023 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c6736d10fso8167145e9.1;
        Fri, 15 Dec 2023 05:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702646978; x=1703251778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jiK3vZ0YhAGGRMudlZG2mTaCFhn6zk+5XFJeIalCQN8=;
        b=mh8AHGweS+r8h0FkrRM6QsJbNPEVL7uv/qteEO8c8GMOO+TPCALD1CKxImLS83qmc4
         bEaFceuKHWQaHOGLNdDK+yDc9nOAJ0i68mDFvxCqz3/w2Yy3860gAouyS7eq7T/MhlZ0
         nmJq5nzzDGRQmvDV+VC7alFuMztnHZOfdeDaLaHtQjK4/xCgIAWWY5R+7fdDu7llfsf2
         98I236paPseDfHC1ekbu5teEmWiTjaIKtUonXU6ubpcwhKaH5Ji0cbq5+gXaZzT3kGMw
         A86kajGCykZnHBdIRjIk9DCRcOf3GoX5QgBiLnOXknWFVjYTNfVh823Uv32PhJnl/P25
         SZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702646978; x=1703251778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiK3vZ0YhAGGRMudlZG2mTaCFhn6zk+5XFJeIalCQN8=;
        b=GG443K62hQZRoN5epu7jNVW97VACn74ZGVznO6SHS/zHHzMmfM+jg0sn+3U3GGsc++
         mhUXAVNZMVsJhWgyRN4gwSzMgIPd9reUFST1Gj50MPooDbFz253EcT+O79G7+fAzW7HR
         UVBvAORHQ+VKu40DOn7w4BNrcxjaUkFlZbnkyf+yMKmhIWmAxdBMXW19P/oD0749Q0Yb
         IBNHEVrWUHVwZD/SJ4WQzUKQemOanEWPhkB3fCkwKsfaTWeSS7yw9VU9+7Vvx5BvAAtT
         EF1AI7FJZd5jvxvfEauAgXYXgYgQrWCCxZ+2PZW2mm7wYyQN9pr5kH1+9GkH0Gd+ve0g
         pvJg==
X-Gm-Message-State: AOJu0YyM7x/yp5YUwTKGYlP37b6uWSgyF6tVxH7eHozWVWvJHCLW+Qve
	yXzG+TWzlEig6dmSFVHhP8w=
X-Google-Smtp-Source: AGHT+IG2JVNUd5pCNHgIDKUAWkxnbR2Lpm2gHtsaTKIy2hfIkryYCozyWPkQIA4KoC/M5P7bxODF9w==
X-Received: by 2002:a05:600c:3148:b0:40c:6b55:29f1 with SMTP id h8-20020a05600c314800b0040c6b5529f1mr500533wmo.135.1702646977578;
        Fri, 15 Dec 2023 05:29:37 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id o3-20020a05600c4fc300b004042dbb8925sm31434543wmq.38.2023.12.15.05.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:29:37 -0800 (PST)
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
Subject: [net-next PATCH v3 0/3] net: add define to describe link speed modes
Date: Fri, 15 Dec 2023 14:29:18 +0100
Message-Id: <20231215132921.16808-1-ansuelsmth@gmail.com>
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
Documentation on the additional helper is not added to the phy.h as
suggested from another patch where in double documentation define .c is
preferred.

This is also needed in the upcoming changes in the netdev trigger for LEDs
where phy_speeds functions is used to declare a more compact array instead
of using a "big enough" approach.

Changes v3:
- Fix various compilation error (wrong revision pushed)
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
 include/linux/phy.h                |  2 ++
 4 files changed, 72 insertions(+), 8 deletions(-)

-- 
2.40.1


