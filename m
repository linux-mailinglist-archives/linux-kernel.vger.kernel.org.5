Return-Path: <linux-kernel+bounces-117960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE69688B1D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C4E1F63075
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEAD5B5B3;
	Mon, 25 Mar 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj5rNkYi"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7D12B79;
	Mon, 25 Mar 2024 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399475; cv=none; b=Oum+dmedUTn653uKEjTjwIDopaNKM5K3NTQn/tKjRhVZWXdQccZyBMBBbSoAH42SHsADGvYc3msEeQFjgwlOVYfgif6gIEpRwsiln5yu3ulWXG7oPXw1ps7EK+PvMEZJ0n9NHPOC90M7ykKb3Cv3S8FTT+l2Eg+jTKJ65emgJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399475; c=relaxed/simple;
	bh=MoV7yhMatg8/eoYWwtw5NdcTKS7f2GZYby6KdhglCDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t3XCV3pxqKtG13+SuMDhjhC2PIQQpod4MI/1ry4/9m7AccslZLI/hQ67VO/E/JuIBzyTKgoVgyTY6Bfa8R4nx8MX6xuqkdqadJ8ADeUcinoB4j5wFoLNukHtF9lQJ6zlWZSf8XeO0hPwEJMiMerZjPwgNn0VwMpygZFGZQAlhlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qj5rNkYi; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso4716416a12.2;
        Mon, 25 Mar 2024 13:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399471; x=1712004271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXUk1zNC7cPK5fVOurLks4dzlHCRdkWyTT8V0Jfd+04=;
        b=Qj5rNkYiNnhdq+POX/dB/QLdiTuOgkN8JQBXrodPvmgzezsAL8oD0MAwiuj2wmEGK2
         FPKM+uHOGRSgXyYwILwa24JZ3zgrYjiHH94bmiCTKGdD5hOJbqu8edmODbDn1V/UknS8
         AF9QHPYpV8JLknJBOurLD3S1kwpJLQ2vQvnfgRgXBWhvu7GBP5HZv+EGyRZBVl0le2zQ
         0fUSPriOrBoZRYjKw9uM9UBmS7hO/gbuYT/kuajgnPleAmMJ/At9lh+V0DESXSXfsaBj
         hdPDYimwUzki4kbzX89XX5DcrhqwEnTQC/DEUGkkrNky/qG1gZIYylfnPyfaWiOxaUZL
         0HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399471; x=1712004271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXUk1zNC7cPK5fVOurLks4dzlHCRdkWyTT8V0Jfd+04=;
        b=Mkd65BHazDb285hYXOnfMhG3vRze3Wu8QJ07jXaOQAm4Krmcc0k+CKaasN71uabdrp
         0ASGgH1H8elXd2vONtI4icxx6eQeN7uLJK+Ufs09mAzhaD1jB/123PDnmoBHaf/9mcZ+
         Lv1/NHAEvTqf9P7Lvp8HMDwG8s9pjdSJXmrs+H1hjdyNbEJliSyfpO1ncw8uuVjVkYE9
         mwXhq/oSuZrray4RzQnf2ybS2oGgut6a8I1Ha+DwWui/pVmPx5yxyBC2L+is5n/lT8x1
         FiD3OU5ReRfZeOV0+4PAKYKgaxX4x5vgMTZhLdtlWrXWIxT1tikus89Y7h8rqNsNetw4
         YAvg==
X-Forwarded-Encrypted: i=1; AJvYcCW32QkE9eyyIvL/A3FpZGyA1diY/bPWIxtZkW6yaO+pwGtQuh+b59nrhE6jqYXkozQWhS16OqPefRPBZJtY7gkdC2QNrAIOA31jefJE
X-Gm-Message-State: AOJu0YxOU1ncA45CDTaaVjxb4RPBXXqw+SrztuIF6tYBHDsTCpHIx1bw
	pcCr2I0++S/4mBMYjHdFCKM/T55ztGMHuNh/1d/CgzsoC1wbZLiTNMsrj/JaARA=
X-Google-Smtp-Source: AGHT+IElP7YNWWXnX3JkfInzh/yUf1EjTeJOLIvUrgvNU4FDQbc05MN6pZVbbUBoiA/f1pDZGGYIvA==
X-Received: by 2002:a50:d54b:0:b0:568:93f:36c6 with SMTP id f11-20020a50d54b000000b00568093f36c6mr5299441edj.22.1711399471083;
        Mon, 25 Mar 2024 13:44:31 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0056c1cba8480sm591751edv.25.2024.03.25.13.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:44:30 -0700 (PDT)
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
Subject: [PATCH net-next v7 00/16] net: dsa: vsc73xx: Make vsc73xx usable
Date: Mon, 25 Mar 2024 21:43:25 +0100
Message-Id: <20240325204344.2298241-1-paweldembicki@gmail.com>
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
 drivers/net/dsa/vitesse-vsc73xx-core.c | 977 +++++++++++++++++++++----
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
 13 files changed, 1072 insertions(+), 223 deletions(-)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

-- 
2.34.1


