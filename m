Return-Path: <linux-kernel+bounces-41929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CFB83F9B5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5F51C21580
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0873C3C461;
	Sun, 28 Jan 2024 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="AxbU6ucn"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47074219E8;
	Sun, 28 Jan 2024 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472694; cv=none; b=iYsqqF4MoIVCPoigaNKZcKvMUmVoq9+AZNkiO5W6eTWslfdh2nj5M/tP0iCCicLATH2vn9yDIyaHgYiPnIH02H7QPP1b2tMapCG7utJFdhp6hhm59CWppDIv6JlJM8CMwuPm4im16E8M+C82wTkglXZbR1ToG3VN89RFaIyiwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472694; c=relaxed/simple;
	bh=jfj+XNJlBhTwrzHSwO+yX5uONg/7PgczGQ04VpBLMjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hKo9bYKTNpCq93gbUpjSSWtNMXm6qvzw3Uqik+cVmcEbZPmlcDGOFOJZrnX8yCcwViS3pgwJ2RPQ/j3dUcvCGl+Kr2HL6V/dSyE0Z4unk/OG2Y+cDIMNW/ge6UzsiccoHPHbcZ/OKaCjUwE0WaEbCItWx70U9GrtyuYgpS/UORA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=AxbU6ucn; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472678; x=1707077478; i=wahrenst@gmx.net;
	bh=jfj+XNJlBhTwrzHSwO+yX5uONg/7PgczGQ04VpBLMjg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=AxbU6ucnK7QSDiILErQVpqeKYre5TgI4KBNcAtahR0RUJCD+RaPUdhMTquC8YRQy
	 5CbQm/LriSpgjxfj/XzCPy3iG6qa5eiFQRv+a110liGpkRkJGMdIjCzu1rwnNC7Pb
	 +VWYr1QCTIWifBvVHGm9Uby3ybslwUFl3OU0MQqUIyytat1XREcXMVuedXOYHU8M1
	 hzPazXAN6sL4K/+I6maV9GROr9WJjxR6YvYr8ZC84NIREq6BlhTBiEvGsZcXH9xZv
	 WgWoeEuxKO7T+gBc7kVTzTzAjditxh9PAROOQazansF5qGtAS5yFuZ6G2Ma1mFM00
	 sQ+HFPq73enXMUbEzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybKf-1r9Tn11Pxt-00yyIp; Sun, 28
 Jan 2024 21:11:18 +0100
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
Subject: [PATCH V4 00/15 net-next] qca_spi: collection of improvements
Date: Sun, 28 Jan 2024 21:10:44 +0100
Message-Id: <20240128201059.6259-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HRhVxe3o20NfwN9MaBZnO8COEcblFoy3zsfG5spZ3BAK+tAO29j
 5dvs5J0LMPN5IpoWJ5Tx8u/txKJB34CvzQ5h2HydJTkaYIz9AvUt+kl9jWsyBQE2Lcr/e3v
 ozJAUbM0Hstn1W+epT1EUEYVrqFn08mEmgB0ZQBpoMHyuDtt0RWOzn91KuV0FKWyZbnYYL8
 U3h8SiR7gR1I+l6nXvbVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zjinaDPiniU=;1ukX56HaqZ3M60BQ+i4gpPTw3t1
 DbUiW/YpkFXjy6nQz9HMF4SWmhGr1FYWodg3neYlOn7mpPPiuaNdBxRgIUd8QPYfXAnptUPKr
 5I+m5jsW7CEdOEoNbovV2jaEZBz9MHu7UFTlnjy1jhIcC0tlFAB5Lfere0kYD3z6CMuRz0ZTS
 b59eMuA+Vbl58wkyWLsoLJ6Om7AtRrgdjN9ygIMvFV9J+jc0w+kC5kc5x6CqbhZ3AeUk3qW3Z
 2FvUDG96ZkKX+qsVGU1gmo/aYor+Fb4QBOTEZ1yLWrFjFMX1Mere45tN0F5PgAOaZf1ieWw9x
 EyFhNEYFCOv1rQMP5uxUDZwyU2mYN00z0TBPgvgi+acskY8VNdxvrMUfL0xLug9dwEj/HWvk0
 OXqKt51zfEY3YeAp+uAh/FRXez539s2gc0xQtbNZ1G07mvwMzHflAposQjb4QGcF2VDJhRdsy
 0IJogrIaJm8ChDvTjArD1I0VidH65xs1WZTrT+5wRyy9uUzzkZFQXELIplPdWmUJ/q+7LhBoN
 C7q375b9wVAQU561mPu2UFwhFbyQIIPX7YyC56xk5oiTdNgUmPqg4JsiAob07YpibS7Wexn+w
 o3PsOvHnveOARrdREaVDZb0hCJae1EumgpYCkipLE7zMLh1icLwi+eClqIahfUSacoMs9Rtl5
 3apfo+OmgJuZ4T6xMT4WLnar3R+FOBcmkwZxiksiK5usfQ+nTjnCXle8YLIQQTyo9QbqLwKsC
 hWW7qnSuyhjjHvLP9Sic50WhsEqkEXPrdp+TQ6VhjLgBixbLjbPlauKqfK5jRheGyu40MTeJM
 +w56A3Kzp8o1zFaUvwLbu7IUEAWikEa93jM3qGpTKwHJnxsDsYeu8+eE2/WYJ4m6xWcVHODlB
 QHCN6UdoMmDoSjq1ybEcwWUPo7C2X3gMQ+u/kRpZUnWOx1d5b0VS7UGfV8UaTFtXOfpfrjZc2
 61iVoyDdWJTN/XtJU9nBsLP5jMg=

This series contains a wild collection of improvements for the
qca_spi driver. This is a follow-up series to the recent bugfixes [1].

Patch 1, 2 & 3 in this series is the initially intended rework of
netdev_open/close. Patch 4 & 10 are minor functional improvements and
the rest is clean-up.

Changes in V4:
- keep thread handling in netdev_open, but improve this by two
  separate patches ( 1 & 2 )
- add missing link to bugfix series

Changes in V3:
- rebase on net-next-20240124
- improve commit message in Patch 8
- add Reviewed-by's from Jacob Keller
- add Patch 13 for mailmap as suggested by Jacob
- add Patch 14 for MAINTAINERS entry

Changes in V2:
- rebase on net-next-20231218
- improve cover letter

[1] - https://lore.kernel.org/netdev/20231206141222.52029-1-wahrenst@gmx.n=
et/

Stefan Wahren (15):
  qca_spi: Add check for kthread_stop
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
 drivers/net/ethernet/qualcomm/qca_7k.c        | 17 +----
 drivers/net/ethernet/qualcomm/qca_7k.h        | 16 +----
 drivers/net/ethernet/qualcomm/qca_7k_common.c | 17 +----
 drivers/net/ethernet/qualcomm/qca_7k_common.h | 29 +-------
 drivers/net/ethernet/qualcomm/qca_debug.c     | 21 ++----
 drivers/net/ethernet/qualcomm/qca_debug.h     | 15 +---
 drivers/net/ethernet/qualcomm/qca_spi.c       | 71 +++++++++----------
 drivers/net/ethernet/qualcomm/qca_spi.h       | 22 ++----
 drivers/net/ethernet/qualcomm/qca_uart.c      | 17 +----
 11 files changed, 58 insertions(+), 175 deletions(-)

=2D-
2.34.1


