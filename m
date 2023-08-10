Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BDD777CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbjHJPwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbjHJPwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:52:00 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E353C1AA;
        Thu, 10 Aug 2023 08:51:59 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AClMPY009213;
        Thu, 10 Aug 2023 17:51:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=g+8JhM5SSBXnEGBoDoQhWJziQ4ZCSrXrnm9iiuLxIDk=; b=Fp
        GQg3BnYhfEf9QARcqXnmN7GIWJ9LN4rj2fv9mXskpBbHFjF0lhIge+MUd2SrDB/g
        5h8ZB/RhFE58kIj0jFzFQKAX0Kqd/ONBO4+ks+L/faH+9sGjYjy1sAkhMFr9i5wX
        oP6CmZU4XH+stxhokKvrdSyUgS6je6OGBv7F52oNh9m/saZjvsOja8Ojopu1WT2z
        vdbnv/EgSrBagecSYRvq3pImjqDw9bhkl015knbPjnPqBZCpmtGSytTs4d9Fn0BT
        2ODeFbqlssEuMqdej8GjZPqUiOG2KtNUUIYKOPOoJiM3wO6XCVzy+dqXurtE5wSD
        jwk8XUVejmMwBjjgQQHQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sd0730yba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 17:51:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AF8F6100053;
        Thu, 10 Aug 2023 17:51:48 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A8313227EF6;
        Thu, 10 Aug 2023 17:51:48 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 10 Aug
 2023 17:51:48 +0200
Message-ID: <6098f24e-c2fa-b74f-76e3-5a3718e887da@foss.st.com>
Date:   Thu, 10 Aug 2023 17:51:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] Add gpio_ranges property for stm32f7
Content-Language: en-US
To:     <patrice.chotard@foss.st.com>, <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230808093119.714224-1-patrice.chotard@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230808093119.714224-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_13,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 11:31, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Add missing gpio-ranges property for stm32f7 based boards.
> 
> Patrice Chotard (2):
>    ARM: dts: stm32: Add gpio-ranges for stm32f746-pinctrl
>    ARM: dts: stm32: Add gpio-ranges for stm32f769-pinctrl
> 
>   arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi | 44 +++++++++++++++++++++
>   arch/arm/boot/dts/st/stm32f769-pinctrl.dtsi | 44 +++++++++++++++++++++
>   2 files changed, 88 insertions(+)
> 

Series applied on stm32-next.

Cheers
Alex
