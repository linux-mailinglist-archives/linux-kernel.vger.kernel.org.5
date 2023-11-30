Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA047FEE0E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345204AbjK3Lhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345139AbjK3Lhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:37:41 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7307B10CE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:37:47 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3AU5J5NC012300;
        Thu, 30 Nov 2023 05:37:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=E/m7VbFvWRIYlMh
        KOYBL64zGShf2KtXgRnVnSt4eekc=; b=NrMFPOpoFR2CAW5ldehdcV/V3G1fpEb
        MguSVe3UrnEFbHdQWsh8kxLVRB0gmglG1q6knpCyWvG+JsiURg2sUisuzX7DDmvY
        C3tS+11Hd/+YxCtU+LdR1we1H8zrp8jrY34RiOD3fwWli+csYB+4XfUYDPsw1JmJ
        lbXqqSDb9mdGXb3vaQLm6Nz9fXAhH3qqXHdDKqhv+8Jf8++Lh3rGbqIc/uH/zobo
        pQDEW4VhWK9WBl5gxGBkze5wPMD6GlJeqhkltGx1KYt6kQlJZ2tu5KkoDEoCXWjS
        hKat41Z134K1OG5IVja9pf0FK3VPM0vdVczdBk0uLLovcjkR9d6fRww==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3unvprt0u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 05:37:37 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 30 Nov
 2023 11:37:21 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Thu, 30 Nov 2023 11:37:21 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 48FC446B;
        Thu, 30 Nov 2023 11:37:21 +0000 (UTC)
Date:   Thu, 30 Nov 2023 11:37:21 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mfd: cs42l43: Correct SoundWire port list
Message-ID: <20231130113721.GT32655@ediswmail.ad.cirrus.com>
References: <20231129154230.470705-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231129154230.470705-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: dGFzJNm-3G7VzwLHO6Hr6xP8pByKVgpX
X-Proofpoint-GUID: dGFzJNm-3G7VzwLHO6Hr6xP8pByKVgpX
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:42:30PM +0000, Charles Keepax wrote:
> Two ports are missing from the port list, and the wrong port is set
> to 4 channels. Also the attempt to list them by function is rather
> misguided, there is nothing in the hardware that fixes a particular
> port to one function. Fix the missing ports, correct the port set to 4
> channels and add a define to get the port mask for each port.
> 
> Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---

Apologies but scratch this, I am going to flip things around and
just specifying the ports it ends up looking much nicer, new spin
incoming.

Thanks,
Charles
