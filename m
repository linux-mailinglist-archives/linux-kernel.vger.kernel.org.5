Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECB37A209E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbjIOOQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbjIOOQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:16:05 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D1C1FCE;
        Fri, 15 Sep 2023 07:16:00 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38FDxFew031114;
        Fri, 15 Sep 2023 09:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=aCEXI68lTXdsry6
        dELoiV+B/0zhuy6taAq6GDfbTB20=; b=ASH6m340IgCWovKTPuYQUPzjQnBntrT
        aO4NYRrFnw4cXIbn7qzJ+rAwuWBS2VKLo0aTa1sv+kxUbRhkXCxF29XYhdAH5/iA
        sO/9vIqquWy2r2CaLENlJSzyl8uAncskkTizrYBwt3cUMUY0imGQfWUoWaJa/tEr
        saq1bkKBXdYChecl2fYRXKXaPhf7s5x2tRbMQl0VRSzlnfNH5Eigw4OZTZwT1VdK
        MaQh2Lj9BvB94STU8KLmi4N9OazXKpqv4nNEdjsnOL0M18A/Jmg2hC1bRl0BSsPv
        ER4dv3u4clDXCXJznmhvaCtEokFdVsYOjlwbcexipaadbZLuRTquTUA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7u4486-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 09:15:30 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 15 Sep
 2023 15:15:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Fri, 15 Sep 2023 15:15:27 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D6870357D;
        Fri, 15 Sep 2023 14:15:27 +0000 (UTC)
Date:   Fri, 15 Sep 2023 14:15:27 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Colin Ian King <colin.i.king@gmail.com>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] ASoC: cs42l43: make const array controls static
Message-ID: <20230915141527.GU103419@ediswmail.ad.cirrus.com>
References: <20230915092639.31074-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230915092639.31074-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: kXd1VQHzb0v6gaw4aAc6S3Wd7MZ_nUJk
X-Proofpoint-ORIG-GUID: kXd1VQHzb0v6gaw4aAc6S3Wd7MZ_nUJk
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:26:39AM +0100, Colin Ian King wrote:
> Don't populate the const array controls on the stack, instead make it
> static.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
