Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F34752DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjGMXP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjGMXPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:15:54 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B62B1999;
        Thu, 13 Jul 2023 16:15:51 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 71A95100018;
        Fri, 14 Jul 2023 02:15:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 71A95100018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689290148;
        bh=DsGRfrpuDz+eoGX0DFT571i6HCLrEzqgMyuDpPgA6pI=;
        h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:From;
        b=VOQA/Ip3huHRjrWTxnjNaPozqRlraHFAN9b2yZGGAXr0GdGhVJTHK8gPpHqJM3cJi
         G6IB1fQAWSO5N8X+8HmPsHTvvVK57Nrwz4vrcBw3nfOdkRzsGRcIqft+sfk/KYA/M8
         vGY9gsseOK/gFqBxN0ZyRPFceUoE8w4sLxpI3X+WRvPpnDtkKRzzQastes/0ksHzZy
         rtnfwaVzhCAH/ZCB7X3rdJDMZdeTeMfDwyrM108D5MkRHyrMuc1dVQcNXSZV00k8HS
         x+0tFothzR+2kxX797Vge8/1/1ddceqEgQW5n7NzG6TSp7/ZWsA2MaFfcQGJJVBM4Q
         L/nZYl0IqPyqQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 14 Jul 2023 02:15:48 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 14 Jul 2023 02:15:20 +0300
Message-ID: <df30fcca-8f7e-bfb2-be92-0eb76726d3e7@sberdevices.ru>
Date:   Fri, 14 Jul 2023 02:11:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   George Stark <gnstark@sberdevices.ru>
Subject: Re: [PATCH v5 0/6] iio: adc: meson: add iio channels to read channel
 7 mux inputs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
References: <20230711200141.239025-1-gnstark@sberdevices.ru>
 <ZK7GCAgA1gljrxyl@smile.fi.intel.com>
 <fe1b4eb7-e137-fe43-44cb-8de597fe00e4@sberdevices.ru>
 <ZK/pNQcT6CrZWIzM@smile.fi.intel.com>
Content-Language: en-US
In-Reply-To: <ZK/pNQcT6CrZWIzM@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178613 [Jul 13 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 523 523 523027ce26ed1d9067f7a52a4756a876e54db27c, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;lore.kernel.org:7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/13 05:55:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/12 20:30:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/13 18:27:00 #21610128
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/23 15:08, Andy Shevchenko wrote:
> On Thu, Jul 13, 2023 at 02:04:05AM +0300, George Stark wrote:
>> Hello Andy
>>
>> On 7/12/23 18:26, Andy Shevchenko wrote:
>>> On Tue, Jul 11, 2023 at 11:00:16PM +0300, George Stark wrote:
>>>
>>> I gave you a tag, any reason why you haven't applied it to your patches?
>>
>> if you're talking about patch 6 commit message - yes, I missed the last line
>> in your letter, I'll fix it.
> 
> I believe I answered to the cover letter [1], which means that it applies to
> the entire series. If you don't include tag of the reviewer(s) who spent time
> on your code, you have to well justify WHY you did so.
> 
> [1]: https://lore.kernel.org/lkml/ZKvQaoFxO5gpAFdM@smile.fi.intel.com/
> 

Hello Andy

I think I've understood at last what you meant by "not applied tag". I'm 
not experienced kernel contributor yet and believed that RvBs and Acks 
are added by one who merges patches or by some kind of magic :)
Of course I'll add the tag, I missed it not on purpose.
Thank you very much for help and your work for the common good.

-- 
Best regards
George
