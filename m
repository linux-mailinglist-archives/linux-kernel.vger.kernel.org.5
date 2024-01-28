Return-Path: <linux-kernel+bounces-41939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFE183F9C9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2860E282406
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CE04EB53;
	Sun, 28 Jan 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="k4Hgpt9z"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA7446D2;
	Sun, 28 Jan 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472700; cv=none; b=fdnzFrJf61UY7BSpIl/LmJXZnEhkTr4Ctgxvv7voLXzYkDrnfAWugV/QiZ53iyRxOCRiLNGGQjBRn3KMa28ZqtTNkAXHbfkZiAlb5ozxYKWPKG8QTOFcrIVKfv2LCKe2KZ/tqVFPKGD9Qr/VUl+dWuj9MwcifPVLDFQI0r+ZDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472700; c=relaxed/simple;
	bh=ckHhRGX1uFe4zXOay/HZNXKKKQjSfzNMM+9KeqUPzlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mX00Q+vF/6qnbWGtdVLrBzGpEoklahs9LU0B4b9aU1KfwbnNIw+R0ix8fVvzAntGvfiU/EQF+v/EWC6V0QJEI6fk+cu+BSXX1nTKJkS5W9PWgAN+y2bpSpmDFPk9OUMJ4QoAcLNPm7qPrIYZ7Ww37nI8iqJJ0izIrrQ2ucy4pZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=k4Hgpt9z; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472683; x=1707077483; i=wahrenst@gmx.net;
	bh=ckHhRGX1uFe4zXOay/HZNXKKKQjSfzNMM+9KeqUPzlk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=k4Hgpt9zRKMhtZsO6/LMZQGfK083sOv5ylNGnl6sclCUToWpCKsdpF63FJKfYeeL
	 9FgjSY981h4eRnyiqWfJER/bccMmd5HMRBgLSrXfHav9yVnz2waJ6tmM/ubifzllW
	 qCvvtHM9bM5F43GMGxF5RP8IEwTxX3h39uI0Vacp0kBFEsbpIqcvzOh6coTxIWkE7
	 NSizIiJq5rpj83axkuvDg4PD0tb3EaY38Iu7LxBB1whp7N3POuFdYH/XnESOM7mGM
	 431IG6ZLCvZ72kV+DTF5GOnOSIv3JOZkp/DjRZPmHJ5YCOpbBqGqoBnxzXPV4bdCU
	 /ui+fGKcrVMhHMN0Fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpJq-1quIiP1lS6-00Zzai; Sun, 28
 Jan 2024 21:11:23 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH V4 10/15 net-next] qca_spi: Log expected signature in error case
Date: Sun, 28 Jan 2024 21:10:54 +0100
Message-Id: <20240128201059.6259-11-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128201059.6259-1-wahrenst@gmx.net>
References: <20240128201059.6259-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9dHEZTQTt3oQtnOq7nBtaz/TRLP2O8x1r4rxHiNaBMx8eoTD0A4
 rbFq4f+RzEGZSs1gH3+T2CRDwl5lhwdufkw/mBOS3fya7QarNTtTxKYdOz9BgCmiEOHrdHc
 pQULQ2eYPd3bgJnrDouTYMcNTRoYxrR4WdJsVLIO7N2AiORxCDXqnPFK+Ph5HtX24MnMRTt
 4/HnV414RDx4j1qtWdqiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R9CMuJyLgoQ=;34SKGDBlBplOqnPuEy9NEznJpAy
 PD2abgE73JEFTVPZj58zRHAgGKp9cY8X6zkRmYvoXx566PlgCH4Yi9w6moj46hxDyTxe4c/Nt
 qR9NisDCwllxtR76/dYQs12hVMIcc3FpKq1r/BS4NOZa13EfHortGf5RZpNk4pwnheZl6+W5r
 15Gxb8EPZB7TwTI3auh5+SjfEeYWLCqzo4KgMjjrfeTqVp3rdJeL4WeVTckdgnq+DdvFv1kSl
 qSWREEeRNQvXyn/57Mj4gsdw5Na/2OIbKydi9aDMSpCdBBjLxuIHGEVTiOkMVK1xBRCfItFLV
 B3a+dOa0YXUH3bq+o1cxuCE9kkufiEyF7JhLFPPo91RUnl+lNS4abwwOqPiGSXuOyfXvecMla
 5aAZjWc8eyFigywhRkqRNOa2q7HGibMHpRWPaLFoCWgu1vjT8dIuV8ckklCVjU2cUfHNNOT/+
 Fj3+BS0J06yQa0f6cxSpccH20bbzcxeAl4Uwdk9e5oBJlh/RzCLh1QsgvLBm47m1k1/he2aHH
 hnbKJ90175CecMwdIFjVJKRFoK8addabPRiThYdFxAmXawOm0PoneIFhfKXhWJra6jOPbxVEx
 YI/RKz9C42OgFMlPq6QYiCW7+9j14QXleMHJmQuIVvrVmQ8xQ79TsNmmznSsf1LDKThgETLgg
 Tl9BVbfa5MQtz9/s3/NLR6kR388llSM06+Uchc/QT4eKeRmNplEIoXT2E7mOCPva1ZfHPYyTo
 Ovm2Xlf9qucKrSl45FLFpcwOTgJQzV2fhzdVqn6MC0FQvzSB/EliuRpYS/OoxGqxW08pHyHiM
 3H6GgV4H9tv+xu/9x41JkQJUjS8TWW6CpoMOgsY5yI11Kb/xlOzzsvtdIOhQdKX1CURk+yOMA
 WE0Y1aBiHRo92pKxAakGqXzdaDCFeLmITWM82uCjT3pgunflGAZ7DYI4YvaUAFHZQOs14A4Un
 0KYcyOdP1CLxrBMKqjX9BdC+xfo=

Most of the users doesn't know the expected signature of the QCA700x.
So provide it within the error message. Btw use lowercase for hex as
in the rest of the driver.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index b35fabcd488b..d2d68c20b32c 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -1006,8 +1006,8 @@ qca_spi_probe(struct spi_device *spi)
 		qcaspi_read_register(qca, SPI_REG_SIGNATURE, &signature);

 		if (signature !=3D QCASPI_GOOD_SIGNATURE) {
-			dev_err(&spi->dev, "Invalid signature (0x%04X)\n",
-				signature);
+			dev_err(&spi->dev, "Invalid signature (expected 0x%04x, read 0x%04x)\n=
",
+				QCASPI_GOOD_SIGNATURE, signature);
 			free_netdev(qcaspi_devs);
 			return -EFAULT;
 		}
=2D-
2.34.1


