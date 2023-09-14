Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2627A0CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241303AbjINScD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239446AbjINScC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:32:02 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713EC1FEB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:31:58 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id gr87qJd7OVPLSgr87qVaza; Thu, 14 Sep 2023 20:31:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694716316;
        bh=v/TDaIRxJKGlPY3fpIXLuEW+O/pJ/KGfg3MooNqWmPg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DDU0oPPSHjTHHZulF/fW8fttRhxzZMW45GPSWMZEF8ewpK5IIDxMHhJmvdzC76/JX
         +EskoztytTE1jMet+dGErWhFeMv5qguonENn2WH14VXr80uVgD6wmo5BcUn/Bo8Q4K
         IF+gJD+Ich4nTiC0W9cuD49BAf0kZwQAJENdSWp4s8Pu+9OBCB7XJIUBN4Hbwxe4VL
         FV/2VN0zY3yKtI5MawaU/KOoACGUmZO0OVuJ49UJTC8b859b6ZpD3ss8S5kgeVNHtS
         M+5ucGSyopZqnJINrUUvkLtwinG3nwsmtbm8OobXPbVWHhWbiH7//C7bTSSRxKvL4Y
         PlYEIj1yTCBSg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Sep 2023 20:31:56 +0200
X-ME-IP: 86.243.2.178
Message-ID: <b3b54c2a-e567-a4fe-d022-eae04aa07354@wanadoo.fr>
Date:   Thu, 14 Sep 2023 20:31:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: RE: [PATCH 0/5] clk: imx: imx8: Fix some error handling paths
To:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
References: <cover.1693126687.git.christophe.jaillet@wanadoo.fr>
 <AS1PR04MB92641B7B3944C2CF9F3DA3B3E3F7A@AS1PR04MB9264.eurprd04.prod.outlook.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <AS1PR04MB92641B7B3944C2CF9F3DA3B3E3F7A@AS1PR04MB9264.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/09/2023 à 12:22, S.J. Wang a écrit :
>>
>> This serie fix some error handling paths. It is split in different patches to ease
>> review because the issues are unrelated and the proposed fixes are maybe
>> wrong (I don't have the hardware to test anything)
>>
>> Patch 2 and 3 are more speculative than the 3 oher ones. Review with care.
>>
>>
>> Finally, I got some problem when generating the serie, and some patches
>> have been hand-modified afterwards.
>> They look good to me, but I hope have not screwed up things...
> 
> 
>  From the 3rd patch,  it can't be applied, maybe there is generating issue.

I will resend.

CJ

> 
> Best regards
> Wang Shengjiu
> 
>>
>> Christophe JAILLET (5):
>>    clk: imx: imx8: Fix an error handling path in
>>      clk_imx_acm_attach_pm_domains()
>>    clk: imx: imx8: Fix an error handling path if
>>      devm_clk_hw_register_mux_parent_data_table() fails
>>    clk: imx: imx8: Fix an error handling path in imx8_acm_clk_probe()
>>    clk: imx: imx8: Add a message in case of
>>      devm_clk_hw_register_mux_parent_data_table() error
>>    clk: imx: imx8: Simplify clk_imx_acm_detach_pm_domains()
>>
>>   drivers/clk/imx/clk-imx8-acm.c | 27 +++++++++++++++------------
>>   1 file changed, 15 insertions(+), 12 deletions(-)
>>
>> --
>> 2.34.1
> 
> 

