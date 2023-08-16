Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E40E77DBC8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbjHPIK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242809AbjHPIKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:10:19 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525F594
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:10:18 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G4px6f021725;
        Wed, 16 Aug 2023 03:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=RtuS4+RPM5H1eJM
        X+4Vl/LFgMJ7LIG0XPxVu8i+mQYU=; b=p6gCqmF5a32jO0Yqo4wAaacnUR4GSqG
        Y95zPgG7IA7/Y/guuFNkunnjFa/Lmij4iQf7nQAZ4xvR+jdk4/8Hy/yhTTs1QepI
        8LxL0nL8jXuARklIL/d3WausNTHxRf0VnyKIu/Jx8o+I6uwrOlZoYqotNoQjEUBG
        6Z8F/cuy86suepUnRX3EZc2Fo0EC4UdUWa0NC+RdaF3KIT07tKsrAvVb/iPTy8Vm
        W5B9b8g07ao/TltFpj+l2ALVQBxXz6W4jshFuBZETiLcuz+t5eOirbi3BeWYN6dE
        TYO4kdptj7qAT15pxIbFYzbYD7QMocO8XrojXEpOP6UWRcTH7BqqSEA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3se8kqvnbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 03:09:36 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 16 Aug
 2023 09:09:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Wed, 16 Aug 2023 09:09:33 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CBBE33575;
        Wed, 16 Aug 2023 08:09:33 +0000 (UTC)
Date:   Wed, 16 Aug 2023 08:09:33 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH RESEND 2/3] ASoC: codecs: wm8904: Fix
 Wvoid-pointer-to-enum-cast warning
Message-ID: <20230816080933.GA103419@ediswmail.ad.cirrus.com>
References: <20230815143204.379708-1-krzysztof.kozlowski@linaro.org>
 <20230815143204.379708-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230815143204.379708-2-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: eNCEnLsDOM7DPowp6ucywe6coIrIFr1T
X-Proofpoint-GUID: eNCEnLsDOM7DPowp6ucywe6coIrIFr1T
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 04:32:03PM +0200, Krzysztof Kozlowski wrote:
> 'devtype' is an enum, thus cast of pointer on 64-bit compile test with
> W=1 causes:
> 
>   wm8904.c:2205:21: error: cast to smaller integer type 'enum wm8904_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
