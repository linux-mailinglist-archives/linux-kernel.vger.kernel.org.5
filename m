Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F50A78DF41
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244430AbjH3TVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245273AbjH3PBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:01:16 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92FE1A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:01:13 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37U7gEVE026115;
        Wed, 30 Aug 2023 10:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=nY6mVvv6rW6BhL4
        MqzQFYP/NvGfCvBh5V3UfYUMt3Qc=; b=STvijXg8VhtiCnXcKhtViWah2cFCb2w
        hipYvB/Xhno62yxDTxCb6e3aVIsWXxLZUZNFWT/GD+/zdGkhZ788C2Xvwo/4NxEL
        JsNf1URvi2HaZGcLV6rdAdmltF274DDr7/rqu4ij5nO9oQsC5DTcPlO/jIa49Brn
        FLx23DwLcoKNY3ruu0L+X4ZdR1wwGVKWO3J7u3B3nWUyzvUIb+IK2IjCje5yTbC5
        kklzbWUq+RqjJ6WQVrGMBxwg/RRo3hGmC2lVkhwA6F0xsNCjYogRtZp5H732XwXp
        aD63dgYXQAXq2MbOa6p0zdraSuSbmf6zOxPE6/bepdaruNFaVWbR1XA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesyd38v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 10:00:40 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 30 Aug
 2023 16:00:38 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 30 Aug 2023 16:00:38 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E6F183561;
        Wed, 30 Aug 2023 15:00:37 +0000 (UTC)
Date:   Wed, 30 Aug 2023 15:00:37 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <regressions@lists.linux.dev>
Subject: Re: mainline build failure due to ace6d1448138 ("mfd: cs42l43: Add
 support for cs42l43 core driver")
Message-ID: <20230830150037.GW103419@ediswmail.ad.cirrus.com>
References: <ZO8oNb2hpegB6BbE@debian>
 <87cyz4he2u.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87cyz4he2u.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: NK8Mq90hyYK6qZ7mtTDHX5VrG2uIuS3d
X-Proofpoint-GUID: NK8Mq90hyYK6qZ7mtTDHX5VrG2uIuS3d
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 03:09:13PM +0200, Takashi Iwai wrote:
> On Wed, 30 Aug 2023 13:29:57 +0200,
> Sudip Mukherjee (Codethink) wrote:
> > 
> > Hi All,
> > 
> > The latest mainline kernel branch fails to build alpha, csky and s390
> > allmodconfig with the error:
> > 
> > drivers/mfd/cs42l43.c:1138:12: error: 'cs42l43_runtime_resume' defined but not used [-Werror=unused-function]
> >  1138 | static int cs42l43_runtime_resume(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~~~
> > drivers/mfd/cs42l43.c:1124:12: error: 'cs42l43_runtime_suspend' defined but not used [-Werror=unused-function]
> >  1124 | static int cs42l43_runtime_suspend(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~~~~
> > drivers/mfd/cs42l43.c:1106:12: error: 'cs42l43_resume' defined but not used [-Werror=unused-function]
> >  1106 | static int cs42l43_resume(struct device *dev)
> >       |            ^~~~~~~~~~~~~~
> > drivers/mfd/cs42l43.c:1076:12: error: 'cs42l43_suspend' defined but not used [-Werror=unused-function]
> >  1076 | static int cs42l43_suspend(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~
> > 
> > git bisect pointed to ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> > 
> > I will be happy to test any patch or provide any extra log if needed.
> 
> Adding __maybe_unused for those PM functions should work around it,
> something like below.  Could you check it?
> If it's confirmed to work, I'll submit properly.
> 
> 

This is probably the correct fix:

https://lore.kernel.org/lkml/20230822114914.340359-1-ckeepax@opensource.cirrus.com/

Just waiting on it to be reviewed.

Thanks,
Charles
