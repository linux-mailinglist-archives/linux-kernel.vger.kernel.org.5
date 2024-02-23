Return-Path: <linux-kernel+bounces-79159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19990861E58
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381391C21550
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316F91474C0;
	Fri, 23 Feb 2024 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a//ACeaS"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DFC12A16D;
	Fri, 23 Feb 2024 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722087; cv=none; b=iXRz8zvX0twy8JzoKc6o8mGMInEP3/58ew8E9ScgDgl9+ByEWHjymaq4Q+tD+lycghhPVm1kwYdwmkGe90A6mhjCb5W0nc81cZYRTyDF/Pme9FrIfjhcxxY5hq0Pr3awZ936nUI75GQnKEmdcYsIF47VguE9r5g9Q7bsLeRTRi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722087; c=relaxed/simple;
	bh=Fl3u9pMwDPGse1MXw1pM3vY/EEMKXmRvq4wt3Gr6Yns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pQj8s4JuKRJeCtRsMG2+irWywjQWgPVwO4YSK4Se40vz55wB2d0MtNwVrc6MEdEFeRrbCi490IUoqTYLkgnXYlMmDvSit9+qLp2t/tbxa5mQQOK9FeKeSJ6hKULSlQlnFr6ypmzcZ0UcVxPEUyrp5oD/JIUqjYC6RDE7GsSZQwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a//ACeaS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3e75e30d36so239098266b.1;
        Fri, 23 Feb 2024 13:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722083; x=1709326883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAZ0i/HIdghwBWRomJ6/7WQJ3u9qRWTJceL2wCtQwpI=;
        b=a//ACeaS9bHtPgQoSW7cPLAJ8T697Pd8LT1rFaIzhjG0lX9juOLoXVCH/Li/2nUZz8
         0CT+mSza0DTb6GjvYokWjkjmjWz1g3QcjsoMD+Hz5eeWguHz7il96stY+xCd04Qdcl9P
         ycAymOWgtEcs/oKzqSoI6mjouI2g1xsGYxhzd7kqTp6SA6i5z+4pei3jlyhjh8oFLkJ3
         q6uwIuPOYSfgncXxIox93I5ZjFZTiJb0p2PsxUzqKYcuwmqiOlemhyiFEIPZI9johGmP
         ni4j38gjaAhu6PU8GNAqw4jkBpLv+h3e5whXWxRwx3Ly+rr9IphmXQZaoKo/CDZMKDmJ
         cLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722083; x=1709326883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAZ0i/HIdghwBWRomJ6/7WQJ3u9qRWTJceL2wCtQwpI=;
        b=DX1mTmKz1x9D8fR6wHwYRkru1gjiuaw8JK39w1mk4t9Fdmi/apuIEXxlWR8uOfXd9i
         JuI88QrycbEfA3Ev60nXYQf3ued9bM/IhEYD9c06jlHSO4QsSOKBBfcGPoNS97uukdqM
         2Z7SrzM0tFdEjHY5xqHq9K4XbVTu67sz1GbMCGB5S4cR5M7JcczX5AanUh2p6/qN5ryc
         L6wn0ReUT+1jIb4/Svf0wa5cfon0HhQJN1CkwEO7Z33JfpcfWaxkvGWJnf79sCf5bkIR
         ZI2gOvyKvMomWIw+JtrW+BB+G0KTR9Mo8OEF66J/DQr9b/kYdm6eznI+XSX9UkZmEDBX
         RMww==
X-Forwarded-Encrypted: i=1; AJvYcCUmVmhwzqpHOqKsJgnMC7Er2bdj+32Sls9HZkcYvb+ndnHqR2ZVyIbT52ax8l2vrbq+0ojKrCvqGTnZ2zQeNUzmeqooWKCdYMag7g3r
X-Gm-Message-State: AOJu0YzVVz8Oc6GPzuYSu2PNCku0SwF5GPCbt5nY8esNlU87Ma3i7ufR
	eDyJr0T2SSS0KopHrVJGwx0IuNpUks7uwhCE7brwJ2yw7Z0jJGrAGc9fca3+V8A=
X-Google-Smtp-Source: AGHT+IEyErYw8sG+JAz/okCoQbuWaYIXUryBZf9GKQecb05eFfK1XeGjCVC6XkcJ3ciO38YlRtAUAQ==
X-Received: by 2002:a17:906:4c41:b0:a3f:2b3b:baa9 with SMTP id d1-20020a1709064c4100b00a3f2b3bbaa9mr873084ejw.14.1708722083256;
        Fri, 23 Feb 2024 13:01:23 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:01:22 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
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
Subject: [PATCH net-next v5 00/16] net: dsa: vsc73xx: Make vsc73xx usable
Date: Fri, 23 Feb 2024 22:00:30 +0100
Message-Id: <20240223210049.3197486-1-paweldembicki@gmail.com>
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

Patches 7, 12-15 provide a basic implementation of tag8021q
functionality with QinQ support, without VLAN filtering in
the bridge and simple VLAN awareness in VLAN filtering mode.

Patches 8-11 came from Vladimir Oltean. They prepare for making
tag8021q more common. VSC73XX uses very similar tag recognition,
and some code from tag_sja1105 could be moved to tag8021q for
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
 drivers/net/dsa/vitesse-vsc73xx-core.c | 990 +++++++++++++++++++++----
 drivers/net/dsa/vitesse-vsc73xx.h      |  56 +-
 include/linux/dsa/8021q.h              |   5 +
 include/net/dsa.h                      |   2 +
 net/dsa/Kconfig                        |   6 +
 net/dsa/Makefile                       |   1 +
 net/dsa/tag_8021q.c                    |  81 +-
 net/dsa/tag_8021q.h                    |   7 +-
 net/dsa/tag_ocelot_8021q.c             |   2 +-
 net/dsa/tag_sja1105.c                  |  72 +-
 net/dsa/tag_vsc73xx_8021q.c            |  66 ++
 13 files changed, 1071 insertions(+), 222 deletions(-)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

-- 
2.34.1


