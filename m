Return-Path: <linux-kernel+bounces-73617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA26F85C52B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F49028294D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A7514A4D0;
	Tue, 20 Feb 2024 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/73DrKu"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B6B1474A8;
	Tue, 20 Feb 2024 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458694; cv=none; b=JI8+w7XB334FJSpN8N0/f5pn2BpxiIHfB2SYhS5miE6UeT3QlrmBjVoyDasuxqy7F5Me7pJJaqw/CoBanfh8apeYE+LyMFYZlJb3Sk4G8F6/VC+FeF5p2SWtewcBsWuhk84zg9wGbTMW/QfVARhTiY2TNDBsA8ZGb/9Hq0o7NyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458694; c=relaxed/simple;
	bh=LX/Iy62jTtUBwefaPKs2N8vsxbkh+ynCHbcWGUHwJQc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZsMA4r95agQuaUh8AyuwdMEseFKb0xqJ0eQIQQb5iqrreRli5AdnXABubY0xKsgnMDH9UviEvD7JPUxEdH81Ka9euoe24g6tb/oVltzQLdFbDlH8hrak+TUmkpTfU/z+DjyGc1t/pppNlBpgJKPMLmIlp0k0sJfIqzVE5JLXZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/73DrKu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-410e820a4feso39202005e9.1;
        Tue, 20 Feb 2024 11:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708458691; x=1709063491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilrcf9FIzNhryRpiM1gMnDk2mj28uZPifSV6of9OdPY=;
        b=X/73DrKuwRIpzU2+2mgq/TK0op+H9qAOP3pK/TGHbic6yWo1JMT803ephmOLTT6+y2
         Lginz4Dt9a40GUn4Ih+V+EtRzkq333tqeF3H/J6kFJ5BI70Lw22N022aE1ghsULv7DU8
         4s/PPhSuuJOVJ70VrBFBjaulkZGQvIICgf89Ge3Po0NnLuWcTTpvb96m4yBOm9BKYOnH
         3iUJSz9zhLvjKtaCTCbVpF6yBtVVsa1U7lbXczZoyW+t+E7shipjZKscIUNJ2B/a6qQt
         xUvB6DdlQGrVtMnOwpTyDg77+AH+V8yGJawNASuwsmm07bT7JGzmsbL8FMFEhBnH0E4O
         +7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708458691; x=1709063491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilrcf9FIzNhryRpiM1gMnDk2mj28uZPifSV6of9OdPY=;
        b=r40+yMUaizWLjEkDH6esbBgOCqo45ZxcRroEq7ZWC8N8AQtPw1J8DjGsA0te/gI0eR
         eDw6rc4cHhCgD2WKI+aShSE3NRixTRQJ2xBY5oQ+3Ww1u4W2Z4jXkbAOvlIGew78NpnC
         fQ1DRyJwcYf8wh8j60q80lmrY+H6WvSq1HtpXOdocXJyOuoNxM7yYzTp/IQ3KLsop5F7
         5sKp/IFdTFF2WlbWx5BLnS4oRBbaQvz9saf6TZFrOAsEqdJzIfRUJPyORT/Vvz7LLquD
         3X/6/qc+1+AVKqmOyuU65BIJMryOmBUlFd2LTZG0w29MG/10bu5HPAW3R/3RhJxJYxOc
         S/zA==
X-Forwarded-Encrypted: i=1; AJvYcCWCH7tjD4OUbFa0eUVN++0Dy0XDpPz26mEcsZ8pr+fZNNePX3AADyry4jkUvNyZRiwFZ4vxxArq/FiOImtcnAPCtGe6cWyNmBMyOcwsy7OISLEBSi6hzZDBIuCd6JYOQNilU+Dm
X-Gm-Message-State: AOJu0YxxDAISMAqr2eD/egKklbst3u+To31jBBpqs0OdGMfHAcFoSpLP
	t+m3UwT9C21rYSq3kBkQK+uHR5WlYdX9Qqjtb6vf3R9oaCORNv7n
X-Google-Smtp-Source: AGHT+IHDFUk+dwyav1PP0LVsLhyXp1LnmbfhGA0Rm6MLUWBnLcbZLFrjnhkMS702tdxRLlsskSCh8A==
X-Received: by 2002:a05:600c:19c7:b0:412:5296:9737 with SMTP id u7-20020a05600c19c700b0041252969737mr11719504wmq.12.1708458690689;
        Tue, 20 Feb 2024 11:51:30 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id fs14-20020a05600c3f8e00b00411a595d56bsm15494853wmb.14.2024.02.20.11.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:51:30 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v2 0/3] net: phy: support multi PHY in phy_driver Was: net: phy: detach PHY driver OPs from phy_driver struct
Date: Tue, 20 Feb 2024 20:50:47 +0100
Message-ID: <20240220195103.15809-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an alternative implementation of "net: phy: detach PHY driver OPs
from phy_driver struct" with the same object in mind.
v2 is used to keep track of the similar attempts but this is the 3rd try
to accomplish the same object.

As was pointed out in the previous series, deatching OPs is a way too big
change (although IMHO needed, but I understand the problem with downstream
and ugly code). As suggested and was already an idea discussed privately,
a more easier approach is introduce an alternative way in phy_driver
struct to declare PHY with the use of an array of IDs.

The second attempt to this had a fundamental problem, as pointed out by
Florian, it did cause an ABI change in sysfs. This was caused by the fact
that sysfs entry are created dased on the first name the PHY driver is
registreted and changing the dev name after (although wrong) also doesn't
update the sysfs name.

The only solution to this problem is to register one driver for each PHY
ID like it's done currently.

This was the case for attempt 1 (detached OPs) and is implemented here in
the 3rd attempt.

To accomplish this, the mdiodrv has to be moved in a separate struct and
defined for each PHY the phy_driver supports (this is already the case
for each phy_driver struct). With this change, we can keep the current
phy_driver struct and support defining multi PHY.

Each PHY will be registered as a separate driver, (even if they are defined
in the same phy_driver struct) permitting to register it directly
with the right name.

For single PHY implementation, the phy_driver is internally converted to
ids implementation by dynamically allocating the table with only one
entry.

This is needed to handle the move of mdiodrv from the phy_driver struct
to a more specific one for each PHY ID.

Changes v2:
- Drop c45 patch
- Complete rework to handle specifi names for PHYs (no ABI
  regression)

Christian Marangi (3):
  net: phy: add support for defining multiple PHY IDs in PHY driver
  net: phy: aquantia: group common OPs for PHYs where possible
  net: phy: bcm7xxx: rework phy_driver table to new multiple PHY ID
    format

 drivers/net/phy/aquantia/aquantia_main.c | 170 +++++++++--------------
 drivers/net/phy/bcm7xxx.c                | 140 +++++++++++--------
 drivers/net/phy/phy_device.c             | 127 ++++++++++++-----
 include/linux/phy.h                      |  38 ++++-
 4 files changed, 275 insertions(+), 200 deletions(-)

-- 
2.43.0


