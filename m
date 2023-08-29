Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A2378C1F1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjH2KFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjH2KFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:05:09 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D158E129;
        Tue, 29 Aug 2023 03:05:06 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37T6exKV018289;
        Tue, 29 Aug 2023 05:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=/8KaQMAgqsXHbnZ
        VKpnstEf5sWpQ+uUAV9RcOHPg7Qg=; b=JavZNAvojy4Z2DyXqYcAZLzsjO6M5Ni
        s2bjqlUnA+YoR/k/alRs2yLwNBH41gRChp7GYAKXYbM+xhc4JPkpRNoIEuim6/ES
        4CSLY3AlKRF19X6Qhpt+y+ibMaOe9FDPUiMkoY0YafcP+iboFkc+nwVtTefGlqny
        ehkaaK1g4O0m3Wwo02H0iqUydD/1qbbe9X3TBKMxI9gH7Fyi31tuJu52UEZUxnGU
        Zfuvrsz9m/mVsHTGq4CaNhKjNqpI+erAnDeJZVXnvKCSK56l2N6NgzlTY+wtgb6S
        GTWKUgAxjS1wAf22QkLKAFDjq7MyO+KppI4vAlBe0YuosJwQlr8C8gQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesybbj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 05:04:41 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 29 Aug
 2023 11:04:38 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Tue, 29 Aug 2023 11:04:38 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DA7A211AA;
        Tue, 29 Aug 2023 10:04:38 +0000 (UTC)
Date:   Tue, 29 Aug 2023 10:04:38 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vlad Karpovich <vkarpovi@opensource.cirrus.com>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <RicardoRivera-Matosricardo.rivera-matos@cirrus.com>
Subject: Re: [PATCH 2/7] ASoC: cs35l45: Fix "Dead assigment" warning
Message-ID: <20230829100438.GQ103419@ediswmail.ad.cirrus.com>
References: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
 <20230828170525.335671-2-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230828170525.335671-2-vkarpovi@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: UDJBV15sSFOlm9g95F4y57geD7o5qRiC
X-Proofpoint-GUID: UDJBV15sSFOlm9g95F4y57geD7o5qRiC
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:05:20PM -0500, Vlad Karpovich wrote:
> Value stored to 'ret' is never read. Remove it.
> 
> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
