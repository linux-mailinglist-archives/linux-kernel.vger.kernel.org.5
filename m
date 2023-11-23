Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FA37F5E25
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345110AbjKWLqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345070AbjKWLqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:46:05 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1875298
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:46:10 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AN7vT5Z000887;
        Thu, 23 Nov 2023 05:46:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=VLviY3398usHXqz
        E8bFY5Zo50GC0sDV62NYdyLnx1kg=; b=JWaDhDt0y8m3vdUQ1ggoPx5IkGjcyKW
        J/bPJQFPyidmNW/WoV35FXW68DOQ/eftLU55eZBKelqGrgGeXHPoTR7B0DSaZA4g
        uKmWCfLvkrnYucaLFfN7JmX2Y/niHW/nsr1BV4d8Z3xIYIczRLa66XbObeB3tgAD
        OlfmimM8iMteH8hVRTG98q7uHKbpVRzPbF2MPY8gj5LvayJjsRUe41yne7bzKh7X
        AvWBpqOEitmF77H/K1J+9Tk4ltpDeyotFvCvhCmOhtCADCe/IJsnPbhMWT1sg6qD
        UvUgjDOUAz1Tey+o0vUCJOxt+KT58ZA8AXxfJaiU/7wBMb/vXBPQReA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3uetjpdp2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 05:46:06 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 23 Nov
 2023 11:46:05 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Thu, 23 Nov 2023 11:46:05 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 35F883581;
        Thu, 23 Nov 2023 11:46:05 +0000 (UTC)
Date:   Thu, 23 Nov 2023 11:46:05 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: cs42l43: Correct SoundWire port list
Message-ID: <20231123114605.GQ32655@ediswmail.ad.cirrus.com>
References: <20231113150220.1472294-1-ckeepax@opensource.cirrus.com>
 <20231123113055.GE1243364@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231123113055.GE1243364@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: tT-YbKIC9JGITieGFF_r-lAgvY_GSL4D
X-Proofpoint-ORIG-GUID: tT-YbKIC9JGITieGFF_r-lAgvY_GSL4D
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 11:30:55AM +0000, Lee Jones wrote:
> On Mon, 13 Nov 2023, Charles Keepax wrote:
> >  enum cs42l43_sdw_ports {
> > -	CS42L43_DMIC_DEC_ASP_PORT = 1,
> > -	CS42L43_SPK_TX_PORT,
> > -	CS42L43_SPDIF_HP_PORT,
> > -	CS42L43_SPK_RX_PORT,
> > -	CS42L43_ASP_PORT,
> > +	CS42L43_DP1 = 1,
> > +	CS42L43_DP2,
> > +	CS42L43_DP3,
> > +	CS42L43_DP4,
> > +	CS42L43_DP5,
> > +	CS42L43_DP6,
> > +	CS42L43_DP7,
> >  };
> 
> This is starting to look a little redundant now.
> 
> I'm not sure if this is better, but it sure takes up less room:
> 
> #define CS42L43_SDW_PORT(port) port
> 

Sure, I think that is better. Will respin the patch. I mean I
guess I could also just drop the enum/define entirely and just
use the port numbers. But will assume you prefer the define
unless I hear otherwise.

Thanks,
Charles
