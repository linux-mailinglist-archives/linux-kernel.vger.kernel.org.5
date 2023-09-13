Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5169B79E94B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbjIMN3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjIMN3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:29:32 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295D219B1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:29:28 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38DCdvpp018783;
        Wed, 13 Sep 2023 08:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=jXUkuWQRgGnRREjnzrofeKJfs0TPp9/gwDU2O5wQCg8=; b=
        YpzQ2i2g4IlRzlkclLHl3bOgjyAntZx6RoqJedRanb9RS2hyGaSaRYs33JWsqjFL
        R2GrWb1jciGZ++6wADquCiftZTodBFNn/3e8vtI858UlYt0YO1YZJZJZuJsgfrzO
        jXy27hJbDduoB7dNiJn/MRsIKtYi+D2ODhdYM8XjiByiPEzcHqvgNI8G/sf8WVNt
        9Hx90O+LEZ80gifdi7S8136cBi2bcUNrxtF5KTgtE6lEAQNXgTeGWXSNwlFkENKe
        /fOy68y62dEmO/Hsu7p/W7N00ar2ySFUc0GgUggkhvag7WtSgxbQ2ecADrL/bn4b
        KdmYu7rXVoqRlA9ZL7t5dA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7sgs97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 08:29:15 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 13 Sep
 2023 14:29:13 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 13 Sep 2023 14:29:13 +0100
Received: from [198.90.251.125] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7AA743560;
        Wed, 13 Sep 2023 13:29:13 +0000 (UTC)
Message-ID: <07967d0b-043b-2541-b293-5a61056339eb@opensource.cirrus.com>
Date:   Wed, 13 Sep 2023 14:29:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] ASoC: soc-card: Add storage for PCI SSID
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
CC:     <pierre-louis.bossart@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kai.vehmanen@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>
References: <20230912163207.3498161-1-rf@opensource.cirrus.com>
 <20230912163207.3498161-2-rf@opensource.cirrus.com>
 <92b2b69e-3175-651f-45bb-d9ae11eaec82@linux.intel.com>
 <66a4381b-1a35-495f-a74a-1da0af1334c1@sirena.org.uk>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <66a4381b-1a35-495f-a74a-1da0af1334c1@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lxkA8S7jqudGOIYlsfZm9QtcFAekX3PY
X-Proofpoint-ORIG-GUID: lxkA8S7jqudGOIYlsfZm9QtcFAekX3PY
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 13:58, Mark Brown wrote:
> On Wed, Sep 13, 2023 at 12:56:03PM +0200, Amadeusz Sławiński wrote:
>> On 9/12/2023 6:32 PM, Richard Fitzgerald wrote:
> 
>>> +#ifdef CONFIG_PCI
>>> +	/*
>>> +	 * PCI does not define 0 as invalid, so pci_subsystem_set indicates
>>> +	 * whether a value has been written to these fields.
>>> +	 */
>>> +	unsigned short pci_subsystem_vendor;
>>> +	unsigned short pci_subsystem_device;
>>> +	bool pci_subsystem_set;
>>> +#endif /* CONFIG_PCI */
>>> +
>>>    	char topology_shortname[32];
>>>    	struct device *dev;
> 
>> This looks bit weird to me, snd_soc_card is _generic_ struct which is not
>> device specific in any way, and now you add fields for PCI, can't this
>> somehow be done using drvdata or something?
> 
> You're right that it's a bit messy but if we use driver data then it
> becomes specific to a particular driver and there's a goal here to share
> with subfunction drivers.  I was thinking we could refactor to a union
> or otherwise extend if we find other users with a similar need.

Yes, I was trying to avoid multiple custom ways of passing the same
data around. A significant advantage of explicitly passing the SSID
(if it's available) rather than a more abstract identifier (such as a
char *) is that's it's very well defined exactly what a PCI SSID is so
we know we can use it verbatim. A more abstract identifier creates an
implied trust (or mistrust) between the machine driver and the component
receiving it whether it's unique and in a useful format.

I could de-ugly it a bit by moving it out into a separate struct/union
and having just a member of that struct type in snd_soc_card.

An alternative was to add a function like the existing
snd_soc_component_set_whatever() family but that means adding a callback
pointer to struct snd_soc_component_driver, which is creating more
space overhead than one value in the snd_soc_card.
