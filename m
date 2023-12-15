Return-Path: <linux-kernel+bounces-1071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B1E8149EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E771F21777
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1A33DBB2;
	Fri, 15 Dec 2023 14:00:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5173DBAF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iy-0002lK-KK; Fri, 15 Dec 2023 14:59:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8it-00G2ZD-Fu; Fri, 15 Dec 2023 14:59:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8it-003cBz-4n; Fri, 15 Dec 2023 14:59:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Frank Li <Frank.li@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	Khuong Dinh <khuong@os.amperecomputing.com>
Subject: [PATCH 00/18] perf: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:00 +0100
Message-ID: <cover.1702648124.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3618; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=QIF36TPLiswSJ7BGiTaGhS7zuJ523QsVTA+4ETPdeHY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFukmiA7JF09OlxcCekWHX8K7N+brb2dL8yu1 L79tE8736eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbpAAKCRCPgPtYfRL+ Thd3B/9bi37yHbyCmxtoBnTyzghErF03a3MQ2kLvT2WmB6Vq6D8LnRwzOn4qBxY8ZfeDwdwKqld VmyWYR4z12b2U0+t6+ECIYcIjWxvDKcBiUJSS79pIL6fT0UeHQ4H2od/hSZnok7vIJ6fJa6XtqM Zl+rLWPBfpQmhBkomYlmL8hSpsWm+NSe3gKOlCV6mjshMhP9BUbBTKxrfHgYWlBrvaBZMZ2pLPL ZqQvKMYTRYvzctEkxL+nfaZrX+/Hd3Z2fsxNMGprvpEDQQcQJjPId5k36TG+jic7RZVP3M93Oh2 /DnXMSYbdraUhMvDc20qEUTd8vLV2/RzXtBaIw/o0ZZplz3k
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series converts all drivers below drivers/perf to use
.remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
callback that returns no value") for an extended explanation and the
eventual goal. The TL;DR; is to make it harder for driver authors to
leak resources without noticing.

I based the patches on today's next, I had to revert commits 
3115ee021bfb ("arm64: perf: Include threshold control fields in
PMEVTYPER mask") and 816c26754447 ("arm64: perf: Add support for event
counting threshold") to compile test on ARCH=arm (this is a problem in
next, not in my patch series).

This is merge window material. All patches are pairwise independent of
each other so they can be applied individually. Still it would be great
to let them go in all together.

Best regards
Uwe

Uwe Kleine-König (18):
  perf: alibaba_uncore_drw: Convert to platform remove callback
    returning void
  perf: amlogic: Convert to platform remove callback returning void
  perf: arm-cci: Convert to platform remove callback returning void
  perf: arm-ccn: Convert to platform remove callback returning void
  perf: arm-cmn: Convert to platform remove callback returning void
  perf: arm_cspmu: Convert to platform remove callback returning void
  perf: arm_dmc620: Convert to platform remove callback returning void
  perf: arm_dsu: Convert to platform remove callback returning void
  perf: arm_smmuv3: Convert to platform remove callback returning void
  perf: arm_spe: Convert to platform remove callback returning void
  perf: fsl_imx8_ddr: Convert to platform remove callback returning void
  perf: fsl_imx9_ddr: Convert to platform remove callback returning void
  perf: hisilicon: Convert to platform remove callback returning void
  perf: marvell_cn10k_ddr: Convert to platform remove callback returning void
  perf: marvell_cn10k_tad: Convert to platform remove callback returning void
  perf: qcom_l2: Convert to platform remove callback returning void
  perf: thunderx2: Convert to platform remove callback returning void
  perf: xgene: Convert to platform remove callback returning void

 drivers/perf/alibaba_uncore_drw_pmu.c         | 6 ++----
 drivers/perf/amlogic/meson_g12_ddr_pmu.c      | 6 ++----
 drivers/perf/arm-cci.c                        | 8 +++-----
 drivers/perf/arm-ccn.c                        | 6 ++----
 drivers/perf/arm-cmn.c                        | 5 ++---
 drivers/perf/arm_cspmu/arm_cspmu.c            | 6 ++----
 drivers/perf/arm_dmc620_pmu.c                 | 6 ++----
 drivers/perf/arm_dsu_pmu.c                    | 6 ++----
 drivers/perf/arm_smmuv3_pmu.c                 | 6 ++----
 drivers/perf/arm_spe_pmu.c                    | 5 ++---
 drivers/perf/fsl_imx8_ddr_perf.c              | 5 ++---
 drivers/perf/fsl_imx9_ddr_perf.c              | 6 ++----
 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c  | 5 ++---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 5 ++---
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 5 ++---
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 5 ++---
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   | 5 ++---
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 5 ++---
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 5 ++---
 drivers/perf/marvell_cn10k_tad_pmu.c          | 6 ++----
 drivers/perf/qcom_l2_pmu.c                    | 5 ++---
 drivers/perf/thunderx2_pmu.c                  | 5 ++---
 drivers/perf/xgene_pmu.c                      | 6 ++----
 23 files changed, 47 insertions(+), 81 deletions(-)

base-commit: 17cb8a20bde66a520a2ca7aad1063e1ce7382240
-- 
2.42.0


