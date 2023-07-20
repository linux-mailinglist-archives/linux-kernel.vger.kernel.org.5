Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528EE75B32B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjGTPlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjGTPlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:41:40 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B7810A;
        Thu, 20 Jul 2023 08:41:38 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id D73AA100002;
        Thu, 20 Jul 2023 18:41:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D73AA100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689867695;
        bh=mMr9bRmI+ChimdsaHpu2eMgXK7jKeBapFRumhYLwrYU=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=pP4OgGFCCTXljtaxwkZrLonjlOWRPg4ehqSkOK1J9Q3u4bZERTBYnqmj+lFr0hl46
         CPdNT8Vhb6JK9FEZDii/Gw3WK4pO5RPedSoDLomPo4tZPLNHJgqOQgXRsa5d7pYcW6
         BylJFhwGD1rNeoes46cfQ+xali6wQ1NJhcKxAxzR7ZcvcUXvY9ZjJIDfGB0RLPY1j1
         D1FXC/LRjiEtfQcCI2R3KvaX1X7ksNZ8IsyQ3W9PVs4gWXrsuWb7ynAZTGLqJa+qD6
         QphgZNfnf2ziPIz4AEo4T0rzOw2itlpQJQjSI5Iaw3gPh+pFvbYelf3i8eTHGmUrpg
         1YgmxaiQQC2Xg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 20 Jul 2023 18:41:35 +0300 (MSK)
Received: from [192.168.1.146] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 18:41:35 +0300
Message-ID: <5dc58681-d89f-8a8d-4da5-ccfa142fa15a@sberdevices.ru>
Date:   Thu, 20 Jul 2023 18:41:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] spi: amlogic-spifc-a1: add support for
 max_speed_hz
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>
References: <20230706110331.19794-1-mmkurbanov@sberdevices.ru>
 <20230706110331.19794-3-mmkurbanov@sberdevices.ru>
 <1jlefm6h8g.fsf@starbuckisacylon.baylibre.com>
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
In-Reply-To: <1jlefm6h8g.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178759 [Jul 20 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: MMKurbanov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 525 525 723604743bfbdb7e16728748c3fa45e9eba05f7d, {Tracking_arrow_text}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/20 13:53:00 #21647430
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



On 11.07.2023 10:25, Jerome Brunet wrote:
>>  
>> +static int amlogic_spifc_a1_set_freq(struct amlogic_spifc_a1 *spifc, u32 freq)
>> +{
>> +	int ret;
>> +
>> +	if (freq == spifc->curr_speed_hz)
>> +		return 0;
>> +
>> +	ret = clk_set_rate(spifc->clk, freq);
>> +	if (ret)
>> +		return ret;
>> +
>> +	spifc->curr_speed_hz = freq;
> 
> There is no guarantee that clk_set_rate() has set the rate you have
> requested, at least not precisely. You should call clk_get_rate() here.
> 

Hello Jerome, thank you for the feedback.
Are you referring to a situation where there is a change in the rate due
to a request from another client, such as a sibling driver with the same
parent clock?

-- 
Best Regards,
Martin Kurbanov
