Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8047D7EED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344789AbjJZIxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344728AbjJZIxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:53:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7162128;
        Thu, 26 Oct 2023 01:53:08 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39Q8qX1i024935;
        Thu, 26 Oct 2023 03:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=meY/NcqksPwsYaV
        rdoWv0mO5Ml8Ah9L0WADpYCb7aYg=; b=mKc0MnVaC4xqxuCKjP7yD5+WRB24sfb
        ldlb8bcXWYYk9iAeh/Y1UeiRHILgKuT2buo5XuFWVQnFU6bLrUBjX058bVSmh+rf
        GbXpBQZvKRUlbT9lOu27OaB/Czxmb7CcOLJ5UYyBz33NQaKrIhoImfrbCIZvHCk6
        iXczyPkbOHKcduduiYLO+iUG/32Fj00+xaTatI5PjD59EYUvCmqXRRFp7F4PDKNy
        aQhyWbydkHqFd1KOm2Js0GeeWc7gzyLMyb+TNjlxpi3bRUj/Vu9H+WO5ESl/eGuf
        VR5eSuN3tVJIbzp7CjXtVwMyWr8Bc0XiM6lTUEJr8RmfNv09UWl4siw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3tvb2j6dra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 03:52:33 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 26 Oct
 2023 09:52:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Thu, 26 Oct 2023 09:52:32 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1372BB38;
        Thu, 26 Oct 2023 08:52:32 +0000 (UTC)
Date:   Thu, 26 Oct 2023 08:52:32 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [RFT PATCH 11/17] ASoC: codecs: wm8995: Handle component name
 prefix
Message-ID: <20231026085232.GA103419@ediswmail.ad.cirrus.com>
References: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
 <20231023095428.166563-12-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231023095428.166563-12-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: R6fqKvCV_h-KsNmgGlanxb0Z_43awYVT
X-Proofpoint-ORIG-GUID: R6fqKvCV_h-KsNmgGlanxb0Z_43awYVT
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 11:54:22AM +0200, Krzysztof Kozlowski wrote:
> Use snd_soc_dapm_widget_name_cmp() helper when comparing widget names,
> to include also the component's name prefix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
