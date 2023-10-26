Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C43A7D85F4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345454AbjJZPYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjJZPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:24:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D21D57;
        Thu, 26 Oct 2023 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1698333819; x=1698938619; i=estl@gmx.net;
        bh=J/MP/ggMBeFOk1GH4VqYwPDUgDoYGPXDLvvW2d6zvWY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=EtiCsGtTj19bk/cnvYowLI0Bvyr4mSCFUVgyeom4i/Xw4VywLd910M4r6CuGginW
         4fN4pF4v7M3FqYSxaOHmaEJ7VxTy2qFzbPoOOOnHadm+olq1fy8+bmOQOntKVPilg
         K4QdzcyV+2R2egjU1JFvVuZXdgDEpVOocWJ/5P9GnwTUPR/JQGbV/RK7GgpeVnNUY
         5sGVj4B2MeYOd7BUdztK/y/9qMVkocsDYTwIohkQQ55Hh036oGsFmr3rlxxlt7TLl
         nRoMsl/gQiV/fF4PuyHQn8qP4e2NTgFZQJg1eoFAkdXHMPEK36Fu/UPtlxbl57owy
         KQSdnEQ6qarqhd5/aw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([77.246.119.226]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MSKyI-1r2kHT08sq-00SexA; Thu, 26 Oct 2023 17:23:39 +0200
From:   Eberhard Stoll <estl@gmx.net>
To:     Han Xu <han.xu@nxp.com>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Eberhard Stoll <eberhard.stoll@kontron.de>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chuanhong Guo <gch981213@gmail.com>,
        Dhruva Gole <d-gole@ti.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Mario Kicherer <dev@kicherer.org>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Olivier Maignial <olivier.maignial@hotmail.fr>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        William Zhang <william.zhang@broadcom.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 0/4] Add tCLQV parameter to tweak SPI timings
Date:   Thu, 26 Oct 2023 17:23:01 +0200
Message-Id: <20231026152316.2729575-1-estl@gmx.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O7+W+0kTktx9+dspKsYqJeT5/Cn+VqewNKP9rukwDbjeCopCyXI
 gcCAOXQe3ddnyLBHvqWbVm4dV+vLK0b7iO/wWLnX5bSs9o+lokV0OQkwBg+pgHV0NumcTh3
 x2lBsvjdKV7dxHyQnKyy9Tgy/3J9a/Pxrnpvbs/QJZaRfbDGShIqiU59i3GerZok15/JONv
 7aL7C5q+4dYax28d5qbyw==
UI-OutboundReport: notjunk:1;M01:P0:Cv2ssFvhnOM=;/r5PLEm2khhBqpGeCl9qm+cb4Kb
 7O5abRSiXpAdhXZf4l4qsfRMO1bXWFXHjul/9D773HImmIv1sSf9dybqZh0m7HEQop4AvSfhX
 q3JFKr1kzKLSCOdeLuuwWUHCiIYpiVDscX7qwv4lF0/N5iFt6Aj5oC7aIMOfBUyx/S6vI2RFA
 GvKG5J6KC3swhveY1RjTXf77Gvdn6GSa7E+6r5lVwBE7yaSjoicO0lbLnijOcILexSyOsSlzB
 Ht/5QZkuji6dhoo21cdNPSOnqm02E5r9PNIgybBdpFXzgn/ok4hjdQH3uc6dFQpGqCoUPlPaF
 ZQtiYPmKzWjcOxp+qbrNPX2KpAamMmsRxJs/0s0q+soBC7t+SsMnoHCvc2ntdw0mbT446eUBJ
 PSaG5PjEHJcNe+OeA4UBZW7PmYrNbrJzUpQTLru7eWeyny+bmpdbLqrPKKhEl4mYPLWvWCGXV
 pCTBsCQdMOwOgizhWTwQ3j1WSMN0Vz5RAaktlZcWv91mw8aNFUnniKNOlqz+PX6ZCFMSxzZA8
 4auLNuq+bwlwCCb9htUINzQ6vt17dJ8Lf5G4mWcNWsceSxWL0V+fbX8rngp8zfuug9t5xlyoF
 TCywDrxkzSbTFihzkoAWxqfVF6bAxH83ybgejN5OT304OaUy/DHC1bKgXkPeyOxD+OQ8Pj0GN
 xghiH6m3E/2SL41JZ1UMoxuhxxhX1sEMlFWF1Wyumbljdtl+nimrDYtxRE1FQNyTA8K8oeuXs
 +wFBN8mOps3KUj1OH15DfbVrvmUmzLNjuG7QWswigL/81obHPsiyWrvvnEIxsqKg1l0RsN0op
 o+isqk+HrTC8RlsSwcGAp1MhCUUBlRLFNs4LMA1pPDVjYNjkf9lxX4dpsfUXInmWrOpFc9ez7
 rsYsAsUJKUii7ODkOurjSur+CAYQaRbPpC4/2TNUkrCz+qy1dzv1ZdvZ6SiFm/N02uA/HyVV9
 ZJ3/i4MB4G02lRMCzXV1UdmpPmU=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eberhard Stoll <eberhard.stoll@kontron.de>

Hi All,

this patch series adds parameters to tweak SPI timings for some
(Q)SPI devices. For example it optimizes the support for the operation
of a Winbond W25N02KV SPI NAND chip on NXP i.mx6 ul(l) devices.

The Winbond W25N02KV SPI NAND has the characteristic to introduce a
delay between spi clock and the masters spi receive data (called tCLQV
value in data sheet).

This chip can operate with a maximum SPI clock of 104MHz. Disregarding
the requred tCLQV value of 7ns for this chip reduces the possible spi
clock to approx. 70MHz. To support the full bandwith of this chip, the
tCLQV parameter has to be supported in SPI framework and SPI controller
and the SPI NAND chip needs this parameter in the device configuration
data.

Also other devices can improve their operating SPI clock performance
with this setting if they also has significant tCLQV values and the SPI
controller will support it.

This patch series adds support the tCLQV parameter in:

- SPI framework
- SPI NAND framework
- NXP i.mx6 QSPI controller
- Winbond W25N02KV SPI NAND device


Eberhard Stoll (4):
  spi: Add parameter for clock to rx delay
  mtd: spinand: Add support for clock to rx delay setting
  mtd: spinand: winbond: Add rx sample delay for W25N02KV
  spi: spi-fsl-qspi: Add support for rx data sample point adjustment

 drivers/mtd/nand/spi/core.c    |  2 +
 drivers/mtd/nand/spi/winbond.c |  3 +-
 drivers/spi/spi-fsl-qspi.c     | 80 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h    |  5 +++
 include/linux/spi/spi.h        |  3 ++
 5 files changed, 92 insertions(+), 1 deletion(-)


base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
=2D-
2.25.1

