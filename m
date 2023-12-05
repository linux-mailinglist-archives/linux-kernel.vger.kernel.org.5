Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F708056D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345627AbjLEOI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345587AbjLEOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:08:56 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA0790;
        Tue,  5 Dec 2023 06:09:03 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B56gxTg026627;
        Tue, 5 Dec 2023 08:08:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=Y84RVH3VhN8tDOj
        vYdyt02UT9ZJhyn7aTdxCf/Az8cs=; b=YxWsdDBhl7aBk9adBDLA8QMKQ0q1QDO
        Qk0If8WrYTB6+wF84QLExCUrmzWOJPnv0qVMZs2KdbjiPJgPL/dzsOy27Jz0aW5o
        u2s7IYOCLxoAgsqDmQlkN1X+4rNr4mvLe7OiOd4KVtwcDsXiL2gbuXLDufiTxpkP
        uLgIoTG9hb3cJ9aEzQkX+abBe03wZ1j0DpcEdJjHlBz91Y7ASiN1BZQ7uHq3AF4g
        VAJNhkItD8sdLYRzeEJb6gBVhoJ+MW1jEPG16gn+80ESXIsGYjOZfuFKsErRgD/u
        GitxT5Urn/OZz5FTFB684Lw/l69Yo9i1rZDtE/rAHkiZv6Lp9gXJ5Vg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ur1vnkat2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 08:08:43 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Dec
 2023 14:08:41 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Tue, 5 Dec 2023 14:08:41 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C97E2474;
        Tue,  5 Dec 2023 14:08:41 +0000 (UTC)
Date:   Tue, 5 Dec 2023 14:08:41 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
CC:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kai.vehmanen@linux.intel.com>,
        <cezary.rojewski@intel.com>, <ranjani.sridharan@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: Intel: sof_sdw_cs_amp: Connect outputs to a
 speaker widget
Message-ID: <20231205140841.GG14858@ediswmail.ad.cirrus.com>
References: <20231205135001.2506070-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231205135001.2506070-1-rf@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: AsMvK67Ferp6_peSXzZpkcOf209E6xTk
X-Proofpoint-ORIG-GUID: AsMvK67Ferp6_peSXzZpkcOf209E6xTk
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 01:50:01PM +0000, Richard Fitzgerald wrote:
> Hookup the CS35L56 DAPM_OUTPUT widgets to a DAPM_SPK widget so
> that there is a complete logical path to a speaker.
> 
> There is no particular reason to use multiple speaker widgets.
> The CS35L56 are designed to work together as a set so they have
> all been connected to a single speaker widget.
> 
> Instead of a hardcoded list of codec widget names, the code walks
> through all the codecs on the dailink and for every cs35l56 it uses
> its name prefix to construct the source end of the route. This adds
> a small amount of overhead during probe but has the benefit that it
> isn't dependent on every system using the same prefixes.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
