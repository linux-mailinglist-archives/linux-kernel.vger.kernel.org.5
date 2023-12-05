Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8A8805576
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376991AbjLENGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376771AbjLENGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:06:47 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA814135
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:06:52 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B58YeSN011559;
        Tue, 5 Dec 2023 07:06:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=
        PODMain02222019; bh=2i4YUU/ZJt98xqHv4kH5pDhDeRu77FQXVGduzv5GYEo=; b=
        OiyMIkqelbAj/ldBIpajli2JPEoK+SDErlP7VfqHU1q5ofmKSdrAn5+D8gjR2kOo
        4H8nmgo/52btxL0D6gVcZKeqnjzjfJS1rbxu/ldCeVrokYgOlCpXytYZIoF5DMJg
        NHawC5Ykq7M7RaYahxAc5s34Kg+Tiwk5UJvx2AKeqRAw8GF4jNbGSZTn3EVAg+DZ
        e6+s0C4PZAD6iaPPVsWNX96obJJyVGXRXCn468uaxcQNZmxezkcwJBixRVXZqI1H
        QuAUEdGYGHwjY+meU8o/+iFo+1JW3sOVCGfO60sqD2ErwgrEGwrqM2GQqTgR4pb6
        ZAIu3/OO74YXUn9jCxotLg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ur1vnk8gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 07:06:43 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Dec
 2023 13:06:41 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Tue, 5 Dec 2023 13:06:41 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D356F474;
        Tue,  5 Dec 2023 13:06:41 +0000 (UTC)
Date:   Tue, 5 Dec 2023 13:06:41 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <kernel@pengutronix.de>
Subject: Re: [PATCH 8/8] regulator: wm8350: Convert to platform remove
 callback returning void
Message-ID: <20231205130641.GF14858@ediswmail.ad.cirrus.com>
References: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
 <1f7bbc545829a1cc3df40be0424fe46d7449fb72.1701778038.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f7bbc545829a1cc3df40be0424fe46d7449fb72.1701778038.git.u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: ciRXB-mdxhaP7GAPO-EEbEoE7UvNsSMM
X-Proofpoint-ORIG-GUID: ciRXB-mdxhaP7GAPO-EEbEoE7UvNsSMM
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 01:26:23PM +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
