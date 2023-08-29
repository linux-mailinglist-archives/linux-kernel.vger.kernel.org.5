Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E6E78CBE8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjH2SSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjH2SSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:18:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28836BE;
        Tue, 29 Aug 2023 11:18:04 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37T4t9v0016954;
        Tue, 29 Aug 2023 13:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=hjJtFK3sukLgeT/0rAr92cHseae6nq/j1ezpqygbTVM=; b=
        n0D4h4ksgc3nAuB+PCHyDw9ER30T5ZoITOWKWS8RfEFQGM3mWQdTeRV0Wx4UVTaG
        raLaZWT0v/Ed6C5sma7ARces5Gn3N0B/I6rfBDrlXH0u7KysLu6L1PMKTjyOTCVm
        7Y8ttmpkcP94MFyGAZfhJwHtKGIBBXLrwAV+IupXtNS20J3z2UwSpfQrSPxtFOly
        y5gp/vTk44inT3mgPt+1p9ItuTEF9Vu/6MTYHwxDtBE38Se4mGrUpUnXnrMm9hN4
        z85S0T/UJF125EkkMlXtWxzkx1T4ZRvqBBEMgkw7MptqhHwl2YRCpGlqOxb8UtRx
        TO6blrfw2wHAX4cN9ej9iw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesyby57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:17:34 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 29 Aug
 2023 19:17:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Tue, 29 Aug 2023 19:17:32 +0100
Received: from vkarpovich-home (unknown [141.131.78.71])
        by ediswmail.ad.cirrus.com (Postfix) with SMTP id BA7DA357C;
        Tue, 29 Aug 2023 18:17:29 +0000 (UTC)
Date:   Tue, 29 Aug 2023 13:17:23 -0500
From:   Vlad Karpovich <vkarpovi@opensource.cirrus.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Rob Herring" <robh+dt@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: Re: [PATCH 3/7] ASoC: cs35l45: Checks index of cs35l45_irqs[]
Message-ID: <20230829131723.f0df743f3ce9293878422cc3@opensource.cirrus.com>
In-Reply-To: <20230829100751.GR103419@ediswmail.ad.cirrus.com>
References: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
        <20230828170525.335671-3-vkarpovi@opensource.cirrus.com>
        <20230829100751.GR103419@ediswmail.ad.cirrus.com>
Organization: Cirrus Logic
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: K4ZE7d_kF-hVehEcIWC6k5UYWOc4ysoC
X-Proofpoint-GUID: K4ZE7d_kF-hVehEcIWC6k5UYWOc4ysoC
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 10:07:51 +0000
Charles Keepax <ckeepax@opensource.cirrus.com> wrote:

> On Mon, Aug 28, 2023 at 12:05:21PM -0500, Vlad Karpovich wrote:
> > Checks the index computed by the virq offset before printing the
> > error condition in cs35l45_spk_safe_err() handler.
> > 
> > Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
> > Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
> > ---
> >  sound/soc/codecs/cs35l45.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
> > index 40fb64904260..2c9b41171a05 100644
> > --- a/sound/soc/codecs/cs35l45.c
> > +++ b/sound/soc/codecs/cs35l45.c
> > @@ -1023,7 +1023,10 @@ static irqreturn_t cs35l45_spk_safe_err(int irq, void *data)
> >  
> >  	i = irq - regmap_irq_get_virq(cs35l45->irq_data, 0);
> >  
> > -	dev_err(cs35l45->dev, "%s condition detected!\n", cs35l45_irqs[i].name);
> > +	if (i < 0 || i > 6)
> 
> This looks a little odd, there appear to be 8 IRQs attached to
> this function whereas this says 6. Also this check seems like
> it will be hard to keep in sync as things change.
> 
> Assuming this error check is actually necessary, would it be
> perhaps better to check i is smaller than ARRAY_SIZE(cs35l45_irqs)
> and check that the attached function is cs35l45_spk_safe_err.
> That should be more robust against future changes to the IRQs.
> 
> Thanks,
> Charles
Thank you. It was picked up from a different branch,I will change to ARRAY_SIZE.

-- 
Vlad Karpovich <vkarpovi@opensource.cirrus.com>
