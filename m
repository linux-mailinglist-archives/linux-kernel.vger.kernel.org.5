Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B81B78F9D8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbjIAIUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243208AbjIAIUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:20:02 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DB610DE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 01:19:57 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3817SpqE012068;
        Fri, 1 Sep 2023 03:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=HmbQF+n1buq5au+
        CxCfNxxyc+bpk4OqqY2opc+lz1jg=; b=XhyUziRrVvp871EY4H+x9n8Ogl7o0Hw
        n/iea21iEyQontcNJaPscRg6bVR7G3XI8vK6bEN7DhIUiainzaMk+7OEOPo35xVR
        P8ftfxEZ0T/M03wP4tfycHhBvspWctj9p3WHmLmjzljXKfwN6MhmxN49pQYmpOUL
        Q69F9KuCAjwHY2U3r7CBXvb9ZHP28n3elHk79TwJzs3egkDRYkxdmmElTo3AHlzP
        8g0EYYMOqiUpyy6tuR/ULZFHZnZx7wDQo8G9GL2HcxJvvtjSN8zJvbzz0a0vnY9j
        QOLbWuNWFVn+lHEkxypr2r82EKHstDw5gijYeg+XhPUZaU906Jswf0A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sqdtj6r9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 03:18:32 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 1 Sep
 2023 09:18:31 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Fri, 1 Sep 2023 09:18:31 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EED473563;
        Fri,  1 Sep 2023 08:18:30 +0000 (UTC)
Date:   Fri, 1 Sep 2023 08:18:30 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v4 3/3] ASoC: wm8580: Move OF table
Message-ID: <20230901081830.GY103419@ediswmail.ad.cirrus.com>
References: <20230901065952.18760-1-biju.das.jz@bp.renesas.com>
 <20230901065952.18760-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230901065952.18760-4-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: G9HaHnAHO6lgBOxV9ToKfuQHxAYLBjDj
X-Proofpoint-GUID: G9HaHnAHO6lgBOxV9ToKfuQHxAYLBjDj
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 07:59:52AM +0100, Biju Das wrote:
> Move OF table near to the user.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
