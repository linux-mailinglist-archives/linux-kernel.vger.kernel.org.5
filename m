Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FA57B5E74
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 03:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbjJCBGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 21:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjJCBGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 21:06:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5830FB4;
        Mon,  2 Oct 2023 18:06:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EB4C433C8;
        Tue,  3 Oct 2023 01:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696295161;
        bh=F4f0krFznweIk4taQ98VjdjNBbxdo6qbxD3mNrr0nSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qjo96mCWqTKW7xGjcbugvTHPxzMEDCajwcw1va4Y2FbcHxO3ZcGKJhTfC83106ARL
         tU6n9aOW7ZWhDLjnQiboRRQ82EVD3td822hvni2XK2g9yNk3HSm2Ur7Z555ck5rG+o
         12dhoHDmpsg6GbUi7vFsQpePSjmL7y7isIq5rL6cYanqyxddTPGOhvh9UX6i8cVIA7
         ZNczfsHMS606tgeAt9grrKxT2FqCR0UULw6bIjRTIClFh9JhkLAVjJWQ9lZKETlzhR
         YTYWmLkKqRpNbxBQIivk0G2e/6Y+0MGkQudKU03TMbdV9ij8lvPLibuVE8O1+k6oVB
         UoMFwMLszD8rA==
From:   Bjorn Andersson <andersson@kernel.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
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
Subject: Re: (subset) [PATCH 00/40] soc: Convert to platform remove callback returning void
Date:   Mon,  2 Oct 2023 18:10:02 -0700
Message-ID: <169629539848.1944895.16954663145011378401.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Sep 2023 11:54:51 +0200, Uwe Kleine-König wrote:
> this series converts all platform drivers below drivers/soc to use
> .remove_new(). The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side.
> 
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
> 
> [...]

Applied, thanks!

[18/40] soc/qcom: icc-bwmon: Convert to platform remove callback returning void
        commit: dd714c568ed4e6f79017be45077de71e9908af03
[19/40] soc/qcom: llcc-qcom: Convert to platform remove callback returning void
        commit: d85a9d18a58156fc8b5ab185e00e078adaaeefde
[20/40] soc/qcom: ocmem: Convert to platform remove callback returning void
        commit: 0b742c498bcd7d215501b10fe9df72a16237735a
[21/40] soc/qcom: pmic_glink: Convert to platform remove callback returning void
        commit: 4b3373e42dc2caa34394ac090c8c70bed49badd6
[22/40] soc/qcom: qcom_aoss: Convert to platform remove callback returning void
        commit: ffbe84a514f863a46a85c1e47b2b6d930b1b463e
[23/40] soc/qcom: qcom_gsbi: Convert to platform remove callback returning void
        commit: 57b31729bd2c72b00d400106e18db91e9d95d3c3
[24/40] soc/qcom: qcom_stats: Convert to platform remove callback returning void
        commit: a47ff90bf2f93ce4ca99858948a74a0c10a2bc45
[25/40] soc/qcom: rmtfs_mem: Convert to platform remove callback returning void
        commit: 7c93da5b8b69d4e4e7270c33ba3206af43930e1d
[26/40] soc/qcom: smem: Convert to platform remove callback returning void
        commit: 4b8dee9a34d51a61f60add996fae6a7140a20ae5
[27/40] soc/qcom: smp2p: Convert to platform remove callback returning void
        commit: 1cd966c2dc19654ed08c843e5c933db8c1349636
[28/40] soc/qcom: smsm: Convert to platform remove callback returning void
        commit: bdd7cc62cf69fe989557445d65d6c8cb2f956518
[29/40] soc/qcom: socinfo: Convert to platform remove callback returning void
        commit: c0989f7d1264b2b1885345a28a32fd5e1e61f9c7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
