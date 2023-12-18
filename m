Return-Path: <linux-kernel+bounces-4484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A98817E17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4452EB23550
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0D97AE70;
	Mon, 18 Dec 2023 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="IIcUiQ7j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F2E760B3;
	Mon, 18 Dec 2023 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702942020; x=1703546820; i=wahrenst@gmx.net;
	bh=CjjtG6p/Dd5V8xoWnC6XwBQXgsiDM9L9WIAtb5Jft6E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=IIcUiQ7jSLFeFkjotMMEvM3t3tUex3IXuCHOU4SKxBe7FZstB0+/aPN+7dzomQvq
	 vfaH3/SJoz5ZuaZXbkAjzp0jlszviW2DbnKfxOOd53Cp00gtVordgvg15k07vZtG3
	 QANDglvztIPF0wDdyef4z014qMgRQNCf/6QF5/WjmxEZuqRIRZcDtpH6jOjkJy9Sc
	 18H5mfts6G2SnD61SM2YTaLComv5oMPZ8BSMINdiVq28LIKL+KdAhniuoHpcuTQ4Y
	 IquXuJ3gljuDr+TuXzxXpbnUCZYTCaMg3s4zHfjHw5XsPX4snUMeRemfRCt9jRGPd
	 Um8qFr9NjYPrgKbj4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1rCzSm2UZM-016Nqt; Tue, 19
 Dec 2023 00:27:00 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 10/12 net-next] qca_spi: Adjust log of SPI_REG_RDBUF_BYTE_AVA
Date: Tue, 19 Dec 2023 00:26:37 +0100
Message-Id: <20231218232639.33327-11-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218232639.33327-1-wahrenst@gmx.net>
References: <20231218232639.33327-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KJfQIIKf3KWSJUMeOZt+dbssoEkhfzmvoKw4d3woAkq3v5l5XMK
 i4Uyd5CnCeawEXPJ0glpReFPGg+nGrfk9KtjFpCvKOte5ry9I1Jik2xCwhr8RnDmbCi1c3z
 kTDVcnnpRIb/FCbbsvGURZdeccb8RzNEbstCzOlgxpNFMIaXZCXj7rL/7XO+90ZmFwVqGi6
 x2m1QMT9UMbOlaOsYPxgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u8hUn6t+TGk=;lF3kbH92nTTWjbKz3jQGH2NzD68
 WWeF4q5cKxywO0ITFeV1a7ReoPBkBG/dDFAkDNA1b3lbXN+WKcX9tbHzMMxAU9o5A7OncBoVy
 KewMjYYosoKR5PeWPd73al4WR8eUHswJi1ogGCSOciwCJFZDXl1iG2nXXzKX7dfDfNX97j3Nm
 YxfgnSUlq9ypQyg33hNeKLMV5icXwUibcubZ3/x2EInsp5FjLMLcF92Y5lxT72tGNhxZTpOfF
 okk+miIGCwYia32RTYs4aC0vPr5lTXtfYB0N2zUa7qKIoMOf5k/2Eyhw+wac1eL1awf+cVdGY
 q81moYtlFBY3fy/JYKKGBjZCoax4nEK0WPePzSQGN5gaHCnbyoTeLcSW4LAw4i3OWOTNaoDGb
 8lVMmKUhTt63jUUY8OsIJx+iNpJEWv9g/TJ/rmoIq9W8Tks/Rfb9jMM9kqZTfMgROfERT/4rG
 NOovj/W/0Cr9hRrWDTWGgCH0wCyUfzZl77PG9h8G4CbZzGqRoXB2eQFWOBGINA1oZ4ww9U8Bf
 59YDhLqCGHyB60uCm5AnuU3pK/hp/9XoAb+Vo7wxeOoW75kBTvYfx3MfKTm8KBc7wYgtv7aZ/
 IDfmMjKuRzd6PFkS3/8CkEXm8iohtjtDVNh+nKyKZC8h0e89mrFOe1bm67y/1sijWP+czTi2N
 Kc0Mu8n9/LmI+3J2bjUmImjn7JJqyVi3VQomN37mKroiTi+04hoQbumuGTHx+rVp0e9/oled1
 W3VkCj7YaX3hvQedmWGTidDrv/bFN6827L38SkRioD4/3ZT9X+j3cjQoFdzV9I2Wh7ApgzNO/
 9LYbZdDVo6+593PihniaR9fTFLnfNrp0cOXlUwMX4Zz/VfgVM24TM2R7fXSBQEPoW/JNAGZqV
 kXaKoWNzUavuFs+HihT0QQ30QF41r0baBDSfn2Jyh+f5pBIQQNEvTcQZuUard21cWWZ7Fa25n
 JAys4otVAH5Iws32Mqnv5dXvULA=

All known SPI registers of the QCA700x are 16 bit long. So adjust
the formater width accordingly.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index c5d240fe4146..d3109eb24b4d 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -359,7 +359,7 @@ qcaspi_receive(struct qcaspi *qca)
 	/* Read the packet size. */
 	qcaspi_read_register(qca, SPI_REG_RDBUF_BYTE_AVA, &available);

-	netdev_dbg(net_dev, "qcaspi_receive: SPI_REG_RDBUF_BYTE_AVA: Value: %08x=
\n",
+	netdev_dbg(net_dev, "qcaspi_receive: SPI_REG_RDBUF_BYTE_AVA: Value: %04x=
\n",
 		   available);

 	if (available > QCASPI_HW_BUF_LEN + QCASPI_HW_PKT_LEN) {
=2D-
2.34.1


