Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D3178F0E8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346723AbjHaQI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242070AbjHaQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:08:25 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06671A3;
        Thu, 31 Aug 2023 09:08:22 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37VF9loi009908;
        Thu, 31 Aug 2023 11:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=bz3V/EyLgfL23DZaVfKZ/qv6E7Au5iTDNPzKtvGcP/g=; b=
        K9n+ai4Ijb2tPM6j4UmzEAb//C0l49yHS23KoHHMspuWYaz07g0Fqm2Es8EIjBCP
        A5clXWWFgidz25jbG5ph4mBibKwSW1JPIUSMvs79tuUy7j7iDEeOG+K5OkRmE8PW
        WJtVhh9nl7s1DdqHh7wRQsXMDU9pF2DKlXHOKTAgZxsCsX+gqKfbCJGjcdEVFtj8
        Uk1hTtJzfWOtIHpGIZQ0pxdEHr1ySMLMzZuvJ1Tix/UaP4LxThjqjAIE4ceqKup8
        O0CFp6nDWBG7lWw5Z/oRrfp2Bm65EjwINyd5Ad05VM2EdCW7yjyLLZm9BRHadF72
        iiHzPmMvXh9Cj53bHmPrpQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesyen1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 11:08:04 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 31 Aug
 2023 17:08:02 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Thu, 31 Aug 2023 17:08:02 +0100
Received: from [141.131.145.49] (vkarpovich-ThinkStation-P620.ad.cirrus.com [141.131.145.49])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CE36511D4;
        Thu, 31 Aug 2023 16:08:00 +0000 (UTC)
Message-ID: <f3514c7b-ad99-b77b-fc61-87fdce7e414b@opensource.cirrus.com>
Date:   Thu, 31 Aug 2023 11:08:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/4] ASoC: cs35l45: Checks index of cs35l45_irqs[]
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
CC:     "Rivera-Matos, Ricardo" <rriveram@opensource.cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230830195536.448884-1-vkarpovi@opensource.cirrus.com>
 <737c4114-5b54-444c-8a6a-de4e98566513@sirena.org.uk>
 <5B0EB2A2-2048-4A71-A4A9-D5167C7AB5EC@opensource.cirrus.com>
 <d97094c6-1534-05ad-0452-c627d7c45802@opensource.cirrus.com>
 <def16e52-3ba9-475d-9d8f-63513c47a392@sirena.org.uk>
From:   Vlad Karpovich <vkarpovi@opensource.cirrus.com>
In-Reply-To: <def16e52-3ba9-475d-9d8f-63513c47a392@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qOpifSmRjr64Zloc_0OawHLTEoqigudO
X-Proofpoint-GUID: qOpifSmRjr64Zloc_0OawHLTEoqigudO
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/23 11:05, Mark Brown wrote:
> On Thu, Aug 31, 2023 at 04:22:52PM +0100, Richard Fitzgerald wrote:
>
>> I think Mark's comment is that the Signed-off-by chain doesn't match
>> the patch author. The s-o-b order implies that Ricardo wrote it and
>> Vlad is upstreaming it - but in that case this email should start with
>> a From: line to say that the author is Ricardo.
> Yes, that's what I'm querying.
Ok. I will update the author
