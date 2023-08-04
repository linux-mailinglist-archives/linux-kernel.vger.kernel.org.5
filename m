Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CA176FC18
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjHDIip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHDIin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:38:43 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659A011B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:38:42 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3745tNEG020986;
        Fri, 4 Aug 2023 03:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=sKZQGok/iJi3bIU
        9jek8/lGxGG21C/JvHMYYHSaC/WE=; b=paOwNJc91l5jLmJJ/V4xkm+NCXfZJVN
        oZyqLi18aR9xsMEuBibAcl1hVeYigubU+DkoVGbywRYjor3Ch9AdOSsE9EyaPwym
        KwY3sRoBK9HMYAfGkN3m5lzB6WDCJU9wYCK0ctuZgFGiWeBTwgZHDYG7uVNt0shJ
        lQLYH27ob12BMhXJVXj1eZba4McHCcao8rjpxHZI2AOXSlPilYjjytfV80YHmSn8
        x8UlAlodxdjRhMuMXyMBdNLKuHm0fWuN00KImDqsovIrtepWD6uHFB+C2cyCgjcD
        gKUpMAOFWwAbNf0cOTW6h5vuLCYlpXfsIm3GBLn4tS2joNrczRQn/IA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s4y6jwhfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 03:38:25 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 4 Aug
 2023 09:38:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Fri, 4 Aug 2023 09:38:23 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EF1B63563;
        Fri,  4 Aug 2023 08:38:22 +0000 (UTC)
Date:   Fri, 4 Aug 2023 08:38:22 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <shengjiu.wang@gmail.com>,
        Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 2/2] ASoC: wm8960: Add support for the power supplies
Message-ID: <20230804083822.GP103419@ediswmail.ad.cirrus.com>
References: <20230803215506.142922-1-festevam@gmail.com>
 <20230803215506.142922-2-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803215506.142922-2-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: oVoXdZ_DTCtmcS452BHLBw_2RwsyYKy_
X-Proofpoint-ORIG-GUID: oVoXdZ_DTCtmcS452BHLBw_2RwsyYKy_
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 06:55:06PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> WM8960 has the following power supplies:
> 
> - AVDD
> - DBVDD
> - DCVDD
> - SPKVDD1
> - SPKVDD1
> 
> Add support for them.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
