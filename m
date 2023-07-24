Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4754D75FA83
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGXPP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:15:25 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B1212F;
        Mon, 24 Jul 2023 08:15:23 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 5AD04100004;
        Mon, 24 Jul 2023 18:15:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5AD04100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1690211720;
        bh=t+ihf9IMsbedjxs/BkN0GdWeQdzNWJp78yHtqmUhcHQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=RIJw/Fi80876mMUYG9e8wL8sn+yl4ecQ4lCluiBV3cVb8buZB08iRLFTfHNyGFj46
         cXSQlyZD7A+Np5nuEucob3U/Llogz5UMuaQUoMM6V84nE8jIYIyPb6gszys5xbk+U9
         Hund9lJ6HXQXfLGl3PnB1Q/OuxypHOy03nOjd1AHzIWP9ZvZkExZ4IAZ99XOdxbo2j
         75Jyp55DOANqzh+1Kr24hulgDNG66ayqkO2oF62ZwXLYRUrkpwSk48PjOJY4Djl5jw
         NnNSvLpJthRNHYDjBsve7gzCvZedwAuWQN83z0oamxRHEyfqn0o3YxHp2xKgCj0n9d
         iLFU/GgfYyJNg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon, 24 Jul 2023 18:15:20 +0300 (MSK)
Received: from [192.168.1.146] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 18:14:26 +0300
Message-ID: <45116f61-6ee7-919c-7c99-704a5b274df8@sberdevices.ru>
Date:   Mon, 24 Jul 2023 18:15:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] spi: amlogic-spifc-a1: add support for
 max_speed_hz
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>
References: <20230706110331.19794-1-mmkurbanov@sberdevices.ru>
 <20230706110331.19794-3-mmkurbanov@sberdevices.ru>
 <1jlefm6h8g.fsf@starbuckisacylon.baylibre.com>
 <5dc58681-d89f-8a8d-4da5-ccfa142fa15a@sberdevices.ru>
 <c118f69d-db32-4544-83d5-14de089d5b51@sirena.org.uk>
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
In-Reply-To: <c118f69d-db32-4544-83d5-14de089d5b51@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178796 [Jul 22 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: MMKurbanov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 525 525 723604743bfbdb7e16728748c3fa45e9eba05f7d, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/23 08:49:00 #21663637
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



On 20.07.2023 18:46, Mark Brown wrote:
> On Thu, Jul 20, 2023 at 06:41:11PM +0300, Martin Kurbanov wrote:
>> On 11.07.2023 10:25, Jerome Brunet wrote:
> 
>>>> +	ret = clk_set_rate(spifc->clk, freq);
>>>> +	if (ret)
>>>> +		return ret;
> 
>>>> +	spifc->curr_speed_hz = freq;
> 
>>> There is no guarantee that clk_set_rate() has set the rate you have
>>> requested, at least not precisely. You should call clk_get_rate() here.
> 
>> Are you referring to a situation where there is a change in the rate due
>> to a request from another client, such as a sibling driver with the same
>> parent clock?
> 
> The clock may simply not be able to generate exactly the rate you
> requested, the rate will be rounded to some value that the clock can
> actually generate.

Yes, I understand the situation. However, I am comparing it with the
requested frequency rather than the actual one that has been set.
Therefore, I asked Jerome for clarification regarding whether the
frequency can be changed by another client (driver). Maybe, it's better
to remove this condition at all? CCF has a cached rate value and doesn't
run 'set' operation if it's not needed.

-- 
Best Regards,
Martin Kurbanov
