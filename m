Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB1578F177
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244158AbjHaQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346591AbjHaPYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:24:09 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38338F;
        Thu, 31 Aug 2023 08:23:37 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37VF9ufQ010374;
        Thu, 31 Aug 2023 10:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=QoTHImQpsUztV6bLsl45NRd1IskeAu8gfDTm3hK83sI=; b=
        h5XOtMhdIQ0asEr+VqgFjVwcJKOh79dFS3hJJ78egH0SiTGImzyJz42p4GTH+yUm
        JtZBTHwTaRUme3LH8gvSogiPbRbmhLtUAOwiM+Gd0ypPJ3Fi8rtW6qtLC3O/Kytl
        JrQKcNfIW8nARdN7lIF8LssSmEESGmBW9SE+wMNAsFhfd6ecvxXDc58FaV0gyYND
        rvvfP1Y0//SOeHxe6UsBseY7a6rDkuFB2edCS38s8pzaZhkz4dJvof8M0h7wih90
        I8aUK9+pV32hvl/7BjgdAW46+IpX8A+iJ6onVo3cWmJWXAowIsuFv03TNgQMvpnC
        PzNfwfyPoLSmA+lJ9catAQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesyejaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 10:22:55 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 31 Aug
 2023 16:22:52 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Thu, 31 Aug 2023 16:22:52 +0100
Received: from [198.61.65.91] (EDIN4L06LR3.ad.cirrus.com [198.61.65.91])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4BA2911D4;
        Thu, 31 Aug 2023 15:22:52 +0000 (UTC)
Message-ID: <d97094c6-1534-05ad-0452-c627d7c45802@opensource.cirrus.com>
Date:   Thu, 31 Aug 2023 16:22:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/4] ASoC: cs35l45: Checks index of cs35l45_irqs[]
To:     "Rivera-Matos, Ricardo" <rriveram@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
CC:     Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
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
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <5B0EB2A2-2048-4A71-A4A9-D5167C7AB5EC@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: On9qX7pPhbKz3vjHwmY6N5R3bWS16DnF
X-Proofpoint-GUID: On9qX7pPhbKz3vjHwmY6N5R3bWS16DnF
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/8/23 15:56, Rivera-Matos, Ricardo wrote:
> Hello Mark,
> 
>> On Aug 30, 2023, at 3:59 PM, Mark Brown <broonie@kernel.org> wrote:
>>
>> On Wed, Aug 30, 2023 at 02:55:33PM -0500, Vlad Karpovich wrote:
>>> Checks the index computed by the virq offset before printing the
>>> error condition in cs35l45_spk_safe_err() handler.
>>>
>>> Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
>>> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
>>
>> Who actually wrote this patch?
> 
> I am the original author, allow me to clarify how and why this is supposed to work.
> 

I think Mark's comment is that the Signed-off-by chain doesn't match
the patch author. The s-o-b order implies that Ricardo wrote it and
Vlad is upstreaming it - but in that case this email should start with
a From: line to say that the author is Ricardo.

