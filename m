Return-Path: <linux-kernel+bounces-129569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30328896CB1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45B42814D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E7A1386A7;
	Wed,  3 Apr 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYJDv0sh"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D5F134CEF;
	Wed,  3 Apr 2024 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140670; cv=none; b=lX+LLgdlDx3CQ79xHxsHc3oazRgd62Hyyyqm+CKgh+Gw6sKttU8crTihFaa+q1t+X09yIhfRLNbtUQUHW6ESYKJNwF7SHh3YHmBBgSWx6VAkVv6RGOXwK7AfIkz+9L7CKAqohvrdpFur2sZpiiH7sBI0UdrdVjvH4izpT7oqQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140670; c=relaxed/simple;
	bh=OX4QNN00v+JoVO8uVyUrJwbnHKbTugh5+aFb4M0Jias=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bzuQy2DR0mIeWBCIKqyZQxfJc2kmfn/WPM9v4jPy6gXUHAUXfdAolQHldBfARzdSILxtLgGRiWq8B1ICRDUlT9VmIG+UNKBDPCQ1saYKg19PbBUcG2rCOUli87IfXJCDZPqqThBKqUH8WgrNzQUCwebwPe/v/nqrE+x6sKAgX1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYJDv0sh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4734ae95b3so797177466b.0;
        Wed, 03 Apr 2024 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140667; x=1712745467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qdw121Z3GJCdoOwRHnkQQv6LO24vnl4F6y7MzTOy+VY=;
        b=RYJDv0shmA1E9HeRJL7YTt05Dq6M5fIxmh1xOUw79Y3fLjmWRBq13UOyvUyWShWCf7
         yMPJmtPFxt28djfwos/ZGX3gZtpxWBKYjm0BJVk7x2BAFj8F5w2ymXJs9qAhtqMIabBT
         yuLFCD7Rf+6giatWuTBGu1VW7Gij6fn3qV/G0rOdGbtGb6oiyQSjHXEYsa9/tRGA90Bo
         BiHyW90whUAH2vE0RCgG5AulQqFcNIlWvm2iCXgEZqz0hP0RFl5I0EeAe4V2mYsQ34/D
         XVKW5n+mIXG/bn9rfoBADHQqqrqfCNQ3K/7sannamsJLTe9WG4YKJ9B6Nmx8+qe1uUz1
         Jh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140667; x=1712745467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qdw121Z3GJCdoOwRHnkQQv6LO24vnl4F6y7MzTOy+VY=;
        b=ddxvaj1iEfkkTGN8EfjCflv89bFP362r2BpMBqO7iwHcWyx+9ZoIH5A06G0/OTi0yv
         +FVHMAwQeCnMn451PY2YG6JR6vrWY/BWHbn6Bajr1qBBTI5WoIKZjhv/AvXb9/SNyRS8
         dUA7dj46XbeDKbD3woBPkoj3gmGg74vyd5Hgt3PTNyh6WeM7EAZD5PRtXH9nyu/om0Wo
         y0LQtKOnfzF88JbLPDfTgy4/FGjQD7g7cWt8o+NXJvGfxmHguRgXiD+pFh9TXNo3ZT3s
         VOosSukXwiJXtVowjWYUEMuFi93ieWZsgtoqspG3xhz7vFSpf7p10MOOGHSrgfzPmCCX
         qXTw==
X-Forwarded-Encrypted: i=1; AJvYcCVhIK7rdPNOeim0FbbE8V1eLh31LDtxMtqkj9d6z9Sf7l4APMKwu4Qf1QDMNtaJPi78SdwH7Co11lw/ikLicPKEFYKJJSc4D7Wrh4yp
X-Gm-Message-State: AOJu0Yz7KMUDJzy+jAfP0V30lsMTWEOW0WmtfBdsVvd5wNwmjEDKH/4c
	7F/cfi1q7dL7K5vCy1c7gFdqIldjKifvbgf4OdnYCwOjdSiqdPoqAbyG1X/ypsI=
X-Google-Smtp-Source: AGHT+IGMztPX6NkzSQGNz6AeZgFZvWJftzJt3bWxjbexdXXCGEPM19WSVysyk+X1Tln5QrfzTag+3A==
X-Received: by 2002:a17:906:2719:b0:a4e:2e25:75b5 with SMTP id z25-20020a170906271900b00a4e2e2575b5mr9825469ejc.55.1712140666978;
        Wed, 03 Apr 2024 03:37:46 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm6858169ejb.11.2024.04.03.03.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:37:46 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 00/16] net: dsa: vsc73xx: Make vsc73xx usable
Date: Wed,  3 Apr 2024 12:37:16 +0200
Message-Id: <20240403103734.3033398-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series focuses on making vsc73xx usable.

The first patch was added in v2; it switches from a poll loop to
read_poll_timeout.

The second patch is a simple conversion to phylink because adjust_link
won't work anymore.

The third patch is preparation for future use. Using the
"phy_interface_mode_is_rgmii" macro allows for the proper recognition
of all RGMII modes.

Patches 4-5 involve some cleanup: The fourth patch introduces
a definition with the maximum number of ports to avoid using
magic numbers. The next one fills in documentation.

The sixth patch implements port state configuration, which is required
for bridge functionality. STP frames are not forwarded at this moment.
BPDU frames are only forwarded from/to the PI/SI interface.
For more information, see chapter 2.7.1 (CPU Forwarding) in the
datasheet.

Patches 7, 12-15 provide a basic implementation of tag_8021q
functionality with QinQ support, without VLAN filtering in
the bridge and simple VLAN awareness in VLAN filtering mode.

Patches 8-11 came from Vladimir Oltean. They prepare for making
tag8021q more common. VSC73XX uses very similar tag recognition,
and some code from tag_sja1105 could be moved to tag_8021q for
common use.

Patch 16 is required to avoid problem with learning on standalone ports.

Pawel Dembicki (12):
  net: dsa: vsc73xx: use read_poll_timeout instead delay loop
  net: dsa: vsc73xx: convert to PHYLINK
  net: dsa: vsc73xx: use macros for rgmii recognition
  net: dsa: vsc73xx: Add define for max num of ports
  net: dsa: vsc73xx: add structure descriptions
  net: dsa: vsc73xx: add port_stp_state_set function
  net: dsa: vsc73xx: Add vlan filtering
  net: dsa: vsc73xx: introduce tag 8021q for vsc73xx
  net: dsa: vsc73xx: Implement the tag_8021q VLAN operations
  net: dsa: Define max num of bridges in tag8021q implementation
  net: dsa: vsc73xx: Add bridge support
  net: dsa: vsc73xx: start treating the BR_LEARNING flag

Vladimir Oltean (4):
  net: dsa: tag_sja1105: absorb logic for not overwriting precise info
    into dsa_8021q_rcv()
  net: dsa: tag_sja1105: absorb entire sja1105_vlan_rcv() into
    dsa_8021q_rcv()
  net: dsa: tag_sja1105: prefer precise source port info on SJA1110 too
  net: dsa: tag_sja1105: refactor skb->dev assignment to
    dsa_tag_8021q_find_user()

 drivers/net/dsa/Kconfig                |   2 +-
 drivers/net/dsa/sja1105/sja1105_main.c |   3 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c | 979 +++++++++++++++++++++----
 drivers/net/dsa/vitesse-vsc73xx.h      |  69 +-
 include/linux/dsa/8021q.h              |   5 +
 include/net/dsa.h                      |   2 +
 net/dsa/Kconfig                        |   6 +
 net/dsa/Makefile                       |   1 +
 net/dsa/tag_8021q.c                    |  81 +-
 net/dsa/tag_8021q.h                    |   7 +-
 net/dsa/tag_ocelot_8021q.c             |   2 +-
 net/dsa/tag_sja1105.c                  |  72 +-
 net/dsa/tag_vsc73xx_8021q.c            |  68 ++
 13 files changed, 1074 insertions(+), 223 deletions(-)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

-- 
2.34.1


