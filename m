Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C607FD5D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjK2LgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjK2LgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:36:17 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA8B197;
        Wed, 29 Nov 2023 03:36:22 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3AT7gDos028524;
        Wed, 29 Nov 2023 05:35:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=tLUNRvgWk+ud0QmQYCqTsJBqX8EpNbh6RL1514LHx/Q=; b=
        iwWXiJUbHFGoDmeNuzHytyvQz5iNsIfbyRRMWDqHb9VQgBIZaWmYZxCmlJbF0nwy
        lFkorC5jcZkUJA4c8qEFMUrhMvU2v1YtP9gucYHapmhfmgxNjnb8JeWsT/GCHx/S
        qMe9TbrPIdtHdIE/sTVmZbwwxao1ii8ZJG5XmgtjJcEBjCFNEgqaKY50KIx//LPu
        r3qXx7h+vh6u8YgxaKEjOyhuDpHmUelzpfcO58YMnh1/eAhXY/vDiSssK+hvSIC8
        bpU0VxDbKvrbxTlHxFmTbkNo0dGk2yQxRA+AFusiZHYG97pyNYUSkg8n34oPM+7b
        SxpsFGavyStWUxKOYf8eDQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3unvprrcgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 05:35:40 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 29 Nov
 2023 11:35:39 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Wed, 29 Nov 2023 11:35:39 +0000
Received: from [198.90.251.82] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.82])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A316015A5;
        Wed, 29 Nov 2023 11:35:38 +0000 (UTC)
Message-ID: <20908914-2827-4402-bd93-12cd385d0c13@opensource.cirrus.com>
Date:   Wed, 29 Nov 2023 11:35:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/187] 5.10.202-rc3 review
Content-Language: en-US
To:     Pavel Machek <pavel@denx.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <jonathanh@nvidia.com>,
        <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
        <srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
        <allen.lkml@gmail.com>, <maz@kernel.org>,
        <andy.shevchenko@gmail.com>, <brgl@bgdev.pl>, <wangyouwan@126.com>,
        <jani.nikula@intel.com>, <ilpo.jarvinen@linux.intel.com>,
        <dan.carpenter@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
References: <20231126154335.643804657@linuxfoundation.org>
 <ZWUJWhOkbHlwC2YB@duo.ucw.cz>
 <eb4fb7bc-93db-4868-8807-f97f5da59b23@opensource.cirrus.com>
 <ZWZQUs+j7RufSr42@duo.ucw.cz>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <ZWZQUs+j7RufSr42@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DoZ7WtW1RprGFVM5pcdvrSpwOU1NnCED
X-Proofpoint-GUID: DoZ7WtW1RprGFVM5pcdvrSpwOU1NnCED
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 20:40, Pavel Machek wrote:
> On Tue 2023-11-28 10:42:51, Richard Fitzgerald wrote:
>> On 27/11/2023 21:25, Pavel Machek wrote:
>>>
>>>> Richard Fitzgerald <rf@opensource.cirrus.com>
>>>>       ASoC: soc-card: Add storage for PCI SSID
>>>
>>
>> The driver that depends on this only went into the kernel at v6.4.
> 
> Thanks. So it would be good to drop this from 5.10 and 6.1.
> 
> Best regards,
> 								Pavel
I don't have any need for this to go into 5.10 and 6.1.
But I've added Mark Brown (for ASoC) and Pierre-Louis Bossart (Intel,
there were some patches to Intel drivers in the set this patch was
cherry-picked from) so they can comment if they disagree.
