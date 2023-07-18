Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC98758333
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjGRREH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjGRRCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:02:43 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2771B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:01:52 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36IFT7Co026098;
        Tue, 18 Jul 2023 12:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=avk9x2TyXLa/GzB
        pQ9T1QsBhP7RZDyZTYnijr+uAJw0=; b=aaKfbvwSpxz1hZVS2T3+q4eK5royMS3
        uXc4vs2V3e+ohQ6lEeW7oL1q/5StMhF9oFT23HbHi8Fa7cSmkYoBxE8eVP44HVAP
        5L7GqpCKqdnO+WFcIeapg4LDPXEwPsqaJQzDTHzt75u4DZn90LA7qKT8jtjvoCZA
        aSH+AbOxbW9I7/MRLP4lu71g74I22OaWX3PZHWD8TyTOSySTMiMDDXcumaZikLFc
        vO1oVg8+ANwpA66U3E4VjDwgOdGmdrfHJ1XBK2yiYnhLt2uwXXM6nKux/tt+9WAb
        wHKwWg0whH1W/FUwiB8ra1bmvyLaNeWERz5OyCTIBmNJY7aYFq1it4g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3rus62uj61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 12:00:37 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 18:00:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 18 Jul 2023 18:00:35 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2172B3563;
        Tue, 18 Jul 2023 17:00:35 +0000 (UTC)
Date:   Tue, 18 Jul 2023 17:00:35 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/11] mfd: wm5110: Update to use maple tree register
 cache
Message-ID: <20230718170035.GH103419@ediswmail.ad.cirrus.com>
References: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
 <20230713-mfd-cirrus-maple-v1-8-16dacae402a8@kernel.org>
 <20230718154200.GG103419@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230718154200.GG103419@ediswmail.ad.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 2oNCQVsR5BNEka5hZfPsczLbs1DOAJi_
X-Proofpoint-ORIG-GUID: 2oNCQVsR5BNEka5hZfPsczLbs1DOAJi_
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 03:42:00PM +0000, Charles Keepax wrote:
> On Thu, Jul 13, 2023 at 01:49:26AM +0100, Mark Brown wrote:
> > The maple tree register cache is based on a much more modern data structure
> > than the rbtree cache and makes optimisation choices which are probably
> > more appropriate for modern systems than those made by the rbtree cache. In
> > v6.5 it has also acquired the ability to generate multi-register writes in
> > sync operations, bringing performance up to parity with the rbtree cache
> > there.
> > 
> > Update the wm5110 driver to use the more modern data structure.
> > 
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > ---
> >  drivers/mfd/wm5110-tables.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
> > index 65b9b1d6daec..eba324875afd 100644
> > --- a/drivers/mfd/wm5110-tables.c
> > +++ b/drivers/mfd/wm5110-tables.c
> > @@ -3218,7 +3218,7 @@ const struct regmap_config wm5110_i2c_regmap = {
> >  	.readable_reg = wm5110_readable_register,
> >  	.volatile_reg = wm5110_volatile_register,
> >  
> > -	.cache_type = REGCACHE_RBTREE,
> > +	.cache_type = REGCACHE_MAPLE,
> >  	.reg_defaults = wm5110_reg_default,
> >  	.num_reg_defaults = ARRAY_SIZE(wm5110_reg_default),
> >  };
> > 
> > -- 
> > 2.39.2
> > 
> 
> This one appears to cause me some issues, seems to get the IRQs
> into a weird state when doing compressed stream stuff. The
> issue seems to also require commit bfa0b38c1483 ("regmap:
> maple: Implement block sync for the maple tree cache") to be
> present. So it definitely seems to relate to the cache sync,
> but not sure if it is something todo with the device itself,
> or the maple tree stuff yet.
> 

Ah... I think I see the regcache_sync sets async=true, but then
the maple tree code immediately deletes the buffer after calling
_regmap_raw_write. So its a racy use after free.

How would we feel about having the maple tree code, clear async
again?

Thanks,
Charles
