Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5CB78C1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjH2KFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjH2KEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:04:52 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50F2B4;
        Tue, 29 Aug 2023 03:04:49 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37TA4RFb031776;
        Tue, 29 Aug 2023 05:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=u9hqaXuOFL5v6nc
        N7D6ugpoWF0WNT2DLXEHoDCgk5S0=; b=awtHp5/DLU5WTv5mFtNucOz205WDqTA
        Suc1W8ReXRmuHF44NK/ZZNSC0byVQAPgQHUgkUYiS5kYG4CAyyQfNzCYwMhIvllp
        kLOHJc8KL+rdlgoDUZ7LQDaZmrlIghgejMhSL95eRsIiAoPPsiz/58SgjjFLWNYs
        MXdQHN4nUqIn7BckWSqUJ2lf6IUHsK4GI99niKGyU6/59bXR+Bck1VEmkDB7dMXy
        xSEMrwTDihK6o+Be+RKudRKkEAdtOP3T/vO40TiEFNoRQzK0FvBk1pkzwdN2v3Gi
        6fsTevv2qs7uxzX6A7pK//wUiY2IpdLhySYww2HQ8B/K6iixdEj+bUw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sqdtj2s9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 05:04:27 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 29 Aug
 2023 11:04:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 29 Aug 2023 11:04:25 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 71AD415B6;
        Tue, 29 Aug 2023 10:04:25 +0000 (UTC)
Date:   Tue, 29 Aug 2023 10:04:25 +0000
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
Subject: Re: [PATCH 1/7] ASoC: cs35l45: Add support for Chip ID 0x35A460
Message-ID: <20230829100425.GP103419@ediswmail.ad.cirrus.com>
References: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: x7d0QwZ9GEWB7LVPnwW5UviVJFxlrWhQ
X-Proofpoint-GUID: x7d0QwZ9GEWB7LVPnwW5UviVJFxlrWhQ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:05:19PM -0500, Vlad Karpovich wrote:
> The 0x35A460 chip is a different variant of the cs35l45.
> 
> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
