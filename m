Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845027AD52C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjIYKAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjIYJ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:59:36 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF205AB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:56:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJa-0007m3-Nw; Mon, 25 Sep 2023 11:55:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJT-008pyb-Sh; Mon, 25 Sep 2023 11:55:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJT-004dkN-HQ; Mon, 25 Sep 2023 11:55:35 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Joel Stanley <joel@jms.id.au>, Li Yang <leoyang.li@nxp.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Huisong Li <lihuisong@huawei.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Michal Simek <michal.simek@amd.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Zev Weiss <zev@bewilderbeest.net>,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Nick Alcock <nick.alcock@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Ruan Jinjie <ruanjinjie@huawei.com>, kernel@pengutronix.de
Subject: [PATCH 00/40] soc: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:54:51 +0200
Message-Id: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6687; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=rvB7bVgDAAktE8ghXihTFoFKKAYdQUIGJrvcbwXNFWY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVg/wR4H5DL2toQ7evPAUcXpi7TAsGaDNcnrq TRp5k8KakmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYPwAKCRCPgPtYfRL+ TifcB/0aVr05FQYrvmmOz1wL8CNQPEXMLJDWDJwAPDWD03L+gmmVu9DcaPQGH8bvpuCcydz+p1o V/BaCnfCvkvvHiLuLEDeBVXlwTU5zvYgAOQXvgDv/aN8uQi0AoraoBDwW9AivvN5EH7FD5WRs8P 1cFuO04fWjfAlUSZtqcR2N8j/LjZ2of4+tkEI/ioZloR5NxUsOZeIfIjKxpLIbokBrOh50O7qm4 Yf31fGMug9dQZpggaTF93CLXkvp40lqu3JS5qh6g44+WSCDHAGpyIOPo+9XbyFVvZ82JzZXQmcp BQx5Tmjduzc+iKsziqmcFWP7m6WRqdCmjFtU9ZKeNC35WVUT
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series converts all platform drivers below drivers/soc to use
.remove_new(). The motivation is to get rid of an integer return code
that is (mostly) ignored by the platform driver core and error prone on
the driver side.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.

As there is no single maintainer team for drivers/soc, I suggest the
individual maintainers to pick up "their" patches. There are no
interdependencies between the patches, so that should work fine. As
there are still quite a few drivers to convert in other areas than
drivers/soc, I'm happy about every patch that makes it in and there is
no need for further coordination.  So even if there is a merge conflict
with one patch until you apply or a subject prefix is suboptimal, please
don't let you stop by negative feedback for other patches (unless it
applies to "your" patches, too, of course).

Best regards and thanks for considering,
Uwe

Uwe Kleine-König (40):
  soc/aspeed: aspeed-lpc-ctrl: Convert to platform remove callback
    returning void
  soc/aspeed: aspeed-lpc-snoop: Convert to platform remove callback
    returning void
  soc/aspeed: aspeed-p2a-ctrl: Convert to platform remove callback
    returning void
  soc/aspeed: aspeed-uart-routing: Convert to platform remove callback
    returning void
  soc/fsl: dpaa2-console: Convert to platform remove callback returning
    void
  soc/fsl: cpm: qmc: Convert to platform remove callback returning void
  soc/fsl: cpm: tsa: Convert to platform remove callback returning void
  soc/fujitsu: a64fx-diag: Convert to platform remove callback returning
    void
  soc/hisilicon: kunpeng_hccs: Convert to platform remove callback
    returning void
  soc/ixp4xx: ixp4xx-npe: Convert to platform remove callback returning
    void
  soc/ixp4xx: ixp4xx-qmgr: Convert to platform remove callback returning
    void
  soc/litex: litex_soc_ctrl: Convert to platform remove callback
    returning void
  soc/loongson: loongson2_guts: Convert to platform remove callback
    returning void
  soc/mediatek: mtk-devapc: Convert to platform remove callback
    returning void
  soc/mediatek: mtk-mmsys: Convert to platform remove callback returning
    void
  soc/microchip: mpfs-sys-controller: Convert to platform remove
    callback returning void
  soc/pxa: ssp: Convert to platform remove callback returning void
  soc/qcom: icc-bwmon: Convert to platform remove callback returning
    void
  soc/qcom: llcc-qcom: Convert to platform remove callback returning
    void
  soc/qcom: ocmem: Convert to platform remove callback returning void
  soc/qcom: pmic_glink: Convert to platform remove callback returning
    void
  soc/qcom: qcom_aoss: Convert to platform remove callback returning
    void
  soc/qcom: qcom_gsbi: Convert to platform remove callback returning
    void
  soc/qcom: qcom_stats: Convert to platform remove callback returning
    void
  soc/qcom: rmtfs_mem: Convert to platform remove callback returning
    void
  soc/qcom: smem: Convert to platform remove callback returning void
  soc/qcom: smp2p: Convert to platform remove callback returning void
  soc/qcom: smsm: Convert to platform remove callback returning void
  soc/qcom: socinfo: Convert to platform remove callback returning void
  soc/rockchip: io-domain: Convert to platform remove callback returning
    void
  soc/samsung: exynos-chipid: Convert to platform remove callback
    returning void
  soc/tegra: cbb: tegra194-cbb: Convert to platform remove callback
    returning void
  soc/ti: k3-ringacc: Convert to platform remove callback returning void
  soc/ti: knav_dma: Convert to platform remove callback returning void
  soc/ti: knav_qmss_queue: Convert to platform remove callback returning
    void
  soc/ti: pm33xx: Convert to platform remove callback returning void
  soc/ti: pruss: Convert to platform remove callback returning void
  soc/ti: smartreflex: Convert to platform remove callback returning
    void
  soc/ti: wkup_m3_ipc: Convert to platform remove callback returning
    void
  soc/xilinx: zynqmp_power: Convert to platform remove callback
    returning void

 drivers/soc/aspeed/aspeed-lpc-ctrl.c        | 6 ++----
 drivers/soc/aspeed/aspeed-lpc-snoop.c       | 6 ++----
 drivers/soc/aspeed/aspeed-p2a-ctrl.c        | 6 ++----
 drivers/soc/aspeed/aspeed-uart-routing.c    | 6 ++----
 drivers/soc/fsl/dpaa2-console.c             | 6 ++----
 drivers/soc/fsl/qe/qmc.c                    | 6 ++----
 drivers/soc/fsl/qe/tsa.c                    | 5 ++---
 drivers/soc/fujitsu/a64fx-diag.c            | 6 ++----
 drivers/soc/hisilicon/kunpeng_hccs.c        | 6 ++----
 drivers/soc/ixp4xx/ixp4xx-npe.c             | 6 ++----
 drivers/soc/ixp4xx/ixp4xx-qmgr.c            | 5 ++---
 drivers/soc/litex/litex_soc_ctrl.c          | 5 ++---
 drivers/soc/loongson/loongson2_guts.c       | 6 ++----
 drivers/soc/mediatek/mtk-devapc.c           | 6 ++----
 drivers/soc/mediatek/mtk-mmsys.c            | 6 ++----
 drivers/soc/microchip/mpfs-sys-controller.c | 6 ++----
 drivers/soc/pxa/ssp.c                       | 6 ++----
 drivers/soc/qcom/icc-bwmon.c                | 6 ++----
 drivers/soc/qcom/llcc-qcom.c                | 5 ++---
 drivers/soc/qcom/ocmem.c                    | 6 ++----
 drivers/soc/qcom/pmic_glink.c               | 6 ++----
 drivers/soc/qcom/qcom_aoss.c                | 6 ++----
 drivers/soc/qcom/qcom_gsbi.c                | 6 ++----
 drivers/soc/qcom/qcom_stats.c               | 6 ++----
 drivers/soc/qcom/rmtfs_mem.c                | 6 ++----
 drivers/soc/qcom/smem.c                     | 6 ++----
 drivers/soc/qcom/smp2p.c                    | 6 ++----
 drivers/soc/qcom/smsm.c                     | 6 ++----
 drivers/soc/qcom/socinfo.c                  | 6 ++----
 drivers/soc/rockchip/io-domain.c            | 6 ++----
 drivers/soc/samsung/exynos-chipid.c         | 6 ++----
 drivers/soc/tegra/cbb/tegra194-cbb.c        | 6 ++----
 drivers/soc/ti/k3-ringacc.c                 | 5 ++---
 drivers/soc/ti/knav_dma.c                   | 6 ++----
 drivers/soc/ti/knav_qmss_queue.c            | 5 ++---
 drivers/soc/ti/pm33xx.c                     | 5 ++---
 drivers/soc/ti/pruss.c                      | 6 ++----
 drivers/soc/ti/smartreflex.c                | 5 ++---
 drivers/soc/ti/wkup_m3_ipc.c                | 6 ++----
 drivers/soc/xilinx/zynqmp_power.c           | 6 ++----
 40 files changed, 80 insertions(+), 152 deletions(-)

base-commit: 8fff9184d1b5810dca5dd1a02726d4f844af88fc
-- 
2.40.1

