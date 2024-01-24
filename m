Return-Path: <linux-kernel+bounces-37743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344F583B4B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 940A1B244CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B3A135A68;
	Wed, 24 Jan 2024 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="hrYHPw7H"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFECA2C9A;
	Wed, 24 Jan 2024 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135573; cv=none; b=OMTZdcp38lKzv4SrLi9mdhiiix/H5l2tgg4mp6ghoj1L+lXqzny73KpmhTsFfxV1xZmFLN/xwK0ornLJbPPEsSCOgMaCEetF752hh7nwb/EDmVvo9KescBmSG5SKEEWVLV3et53I/KN/acXkQd93N30QkDz/LXyidL7CrVj4h+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135573; c=relaxed/simple;
	bh=htt4WYNlHFFscLRqL8HdJgCZGwjTOJEUdN3kt/lnatA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NqqJbhZONje1F3e1xm2ThcirqhdegP4iv8YB8u0Z9/o91AsO9BoZJ3Ns33MVcLY8tkd8Q3CX/DdPdlZMu2hoLZrCp4vUwK3q9wgax4DjljGJ0uLBH7TBkCwWd2HsoIf7acA9cWO2YlaLWxFSM9iE5d4UMyVJ5nXZDVJoIp/hX2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=hrYHPw7H; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706135556; x=1706740356; i=wahrenst@gmx.net;
	bh=htt4WYNlHFFscLRqL8HdJgCZGwjTOJEUdN3kt/lnatA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=hrYHPw7HCacNom8FrAhDFbtCnCsDaJxuRxlFsIVFYcOPN5fHSwNsjPnJcR1lP2t9
	 JrudfQc50OZ+agzM5i4GEBqlcYzIWvtAFlLrAff5c5g+KLrskA6JVRS9joAIENUlm
	 YT8KFQ/bPB96ygo4nqNSF1dtUtftt7rbd2oSsiqzZROJ4CWJHHR9kPubiLnqA6yuN
	 OWCFQRMflthO4CFw24+E068fZbu7Ug50vLJXrVRIKJNTiCzisroY/Ay4FkNpmplXu
	 5u9SEH8KFv8Bg8WfwsFuZ1SHTY8ctLTTIzFq6okGBDSmqGteLolL/gt1cqaatMW0X
	 oWW5DyV/P14UvSlVeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiaYJ-1qqOuZ1nzL-00fisF; Wed, 24
 Jan 2024 23:32:36 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 00/14 next] qca_spi: collection of improvements
Date: Wed, 24 Jan 2024 23:31:57 +0100
Message-Id: <20240124223211.4687-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7+qEVx8iZHWGykoVWNu7NTrHM2jUqSJIRUjXMbPGKOhrNbL1LP+
 7SDYlN/8uwqAQjZcFOw5+PUtcAmBuahP4WjQZAqaefOi0KlHDQLUIjlGPKMeANayhZlVYci
 js2kUetaObH1o8xgadHSBSOFNVw4imSwxNspd+X1FxvXH7ly+9E6udKipEnb/WR3J1BcvsD
 +FgTeNIAVMAXMb7dwmzng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HmqKFcYRM/g=;VeqC84B1C5viCmEyAYrdl43Iec/
 3GXpW3fW3EEIor4PGij8t3VcrakXhof2+j0lPqI6UbfKIqRRUeYQgOI/tmFkefoujCwMnyr8p
 fWVUOotnPEiwdU1RFpoLyP1Spc+I2XTmQD03TuUIa0E/iRw0D8058qkxJNrjZgJa0OI0UGCkM
 OY1Q0+92XffLTca7Y0yFh1od2wyxJHRx1BeY1X8dXjqL6J6ebLTDUlIKw7l90UicdJD0W6tz4
 PYWVQ02qD77Kz0lW5ePKxzEmvJQeTmk8L5uxuP+6aNMcqQ8sd4G8mC6tPCQNlwvd4qYd5HIo7
 KA91yklOSl9TJBAT/HFaye1TLMsmOWf1agj5MCWe3k6uft0hfUKr7c80Jtez7Nl9MghFeiY+h
 Erzm+iAmUPrF4epa8f3lUHPMtb+HB9jeQ4NOGIRBld+Nj4UPX35ocyj/Qvr6z6FKJM8/Ngo5B
 /95LoUPqw0Zczrjk9f6prSiRFufenkzQmJrVO8QiOAYqIZSSszMZIOPFgkrnYTkjAK4kpRrib
 FfeFGn/VU0Hv1mHWInBp3r76PyvG/IqX7Wz+aUGTMX9Sb/i7gnDKENKzGu2Khc1x5HwTmWRSN
 Z2fpi3wPsGQPXndkjMQaaQbO41eRa8o1x3WTLKUcf8sa8f2H+Do9lO8Wyh0vTcl0u3rmQ9DL6
 /UBKhMiXHLZVz+g7UDvt+YU749LJrtHtauPoSh2pEoVuh55bpcTCnuXiGDggU0se5e2QXeIBv
 qwMIIY6VbuUTo/Dj1FXImjyiKDfgD6Cwa2JW1v6vsO61GhZ1On2T8akMOSg/J80v5fDK5D0cc
 k+gyzDybSu48HMjbJA4E+FWnrhuFNUiT6clvE61wDObdeEsFm7TUBAotMbxOQ0wTX4sONqbuR
 L4EaPC9o13HKLPfx5rSvTE3q6qmg19mMDCkEHb6HSSxKjnur5P8UjfTc/3jlLertg9MEN6CJc
 xFmpK63l0BOoxCSeG2IYctrV1y0=

This series contains a wild collection of improvements for the
qca_spi driver. This is a follow-up series to the recent bugfixes [1].

Patch 1 & 2 in this series is the initially intended rework of
netdev_open/close. Patch 3 & 9 are minor functional improvements and
the rest is clean-up.

Changes in V3:
- rebase on net-next-20240124
- improve commit message in Patch 8
- add Reviewed-by's from Jacob Keller
- add Patch 13 for mailmap as suggested by Jacob
- add Patch 14 for MAINTAINERS entry

Changes in V2:
- rebase on net-next-20231218
- improve cover letter

Stefan Wahren (14):
  qca_spi: Improve SPI thread creation
  qca_spi: Improve SPI IRQ handling
  qca_spi: Avoid skb_copy_expand in TX path
  qca_7k_common: Drop unnecessary function description
  qca_7k_common: Drop unused len from qcafrm_handle
  qca_spi: Add QCASPI prefix to ring defines
  qca_spi: Introduce QCASPI_RX_MAX_FRAMES
  qca_spi: Improve calculation of RX buffer size
  qca_spi: Log expected signature in error case
  qca_spi: Adjust log of SPI_REG_RDBUF_BYTE_AVA
  qca_7k: Replace BSD boilerplate with SPDX
  qca_7k: Replace old mail address
  mailmap: add entry for Stefan Wahren
  MAINTAINERS: add entry for qca7k driver(s)

 .mailmap                                      |  1 +
 MAINTAINERS                                   |  7 ++
 drivers/net/ethernet/qualcomm/qca_7k.c        | 17 +---
 drivers/net/ethernet/qualcomm/qca_7k.h        | 16 +---
 drivers/net/ethernet/qualcomm/qca_7k_common.c | 17 +---
 drivers/net/ethernet/qualcomm/qca_7k_common.h | 29 +------
 drivers/net/ethernet/qualcomm/qca_debug.c     | 21 +----
 drivers/net/ethernet/qualcomm/qca_debug.h     | 15 +---
 drivers/net/ethernet/qualcomm/qca_spi.c       | 86 +++++++++----------
 drivers/net/ethernet/qualcomm/qca_spi.h       | 22 ++---
 drivers/net/ethernet/qualcomm/qca_uart.c      | 17 +---
 11 files changed, 65 insertions(+), 183 deletions(-)

=2D-
2.34.1


