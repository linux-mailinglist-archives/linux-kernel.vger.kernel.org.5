Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A6F7B7A08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbjJDI3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjJDI3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:29:03 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A1983
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:28:59 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39461f0t031953;
        Wed, 4 Oct 2023 03:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=cx4j1u2cB/RSNNO
        JLWI4IUS4jJGgAFRWe5mxjA6ot+c=; b=Zf52U4la5q2cEqwx8LAAg9AOofwWtxa
        O4pL/S3x8TsZ8CtRsOzvuVoPev/mbHhok8mD019Jl2+qdO2ZE47LaKkErdFF4sYY
        FDZ5nQKIpIKk3yXoZz+UrsSjy1aeWFoklvMOEMC/zO45nmDjV2s2lms82pubMSff
        gDE/wHZ12uJz4cAeIvXZWKzKrKa/PD850ya3x2+WunxJ/8svDeTFvvF4uIhH1Go1
        sMiNiFZakFQr7/uEazajymhaT5pzW6YUuHrWf6z2t33RyQMrIKOUdSK3JhX2qcSp
        UnvIdF3zjlk4YDyd+qcMryEKAVaho9NoZgY9HclQ3fgeax2jR5x8oZg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3th2dt85hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 03:28:38 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 4 Oct
 2023 09:28:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 4 Oct 2023 09:28:36 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6973611AA;
        Wed,  4 Oct 2023 08:28:36 +0000 (UTC)
Date:   Wed, 4 Oct 2023 08:28:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Rob Herring <robh@kernel.org>
CC:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Peter Rosin <peda@axentia.se>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kiseok Jo <kiseok.jo@irondevice.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ban Tao <fengzheng923@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <r.anjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/5] ASoC: Explicitly include correct DT includes
Message-ID: <20231004082836.GP103419@ediswmail.ad.cirrus.com>
References: <20231003-dt-asoc-header-cleanups-v1-0-308666806378@kernel.org>
 <20231003-dt-asoc-header-cleanups-v1-1-308666806378@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231003-dt-asoc-header-cleanups-v1-1-308666806378@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: jEULMgwzMkTC_DEUuufa0o2tsqWlPrbB
X-Proofpoint-GUID: jEULMgwzMkTC_DEUuufa0o2tsqWlPrbB
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 11:43:07AM -0500, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

For the Wolfson/Cirrus bits:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
