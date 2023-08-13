Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8731C77A6B2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjHMOFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMOFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:05:04 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746EBEA;
        Sun, 13 Aug 2023 07:05:05 -0700 (PDT)
Received: from p200300cf17418700333267be2b9ea1d1.dip0.t-ipconnect.de ([2003:cf:1741:8700:3332:67be:2b9e:a1d1]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qVBiF-0004o8-Jy; Sun, 13 Aug 2023 16:04:59 +0200
Message-ID: <cd15c23c-e237-25e3-d2a6-79113945a2d7@leemhuis.info>
Date:   Sun, 13 Aug 2023 16:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH] crypto: caam - adjust RNG timing to support
 more devices
Content-Language: en-US, de-DE
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Bastian Krause <bst@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Douglass <dan.douglass@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>
References: <20230612082615.1255357-1-meenakshi.aggarwal@nxp.com>
 <e1f3f073-9d5e-1bae-f4f8-08dc48adad62@pengutronix.de>
 <f673a09e-e212-ee7b-15c3-78afe8c70916@pengutronix.de>
 <DU0PR04MB9563E31E69F93B63EE83DD378E39A@DU0PR04MB9563.eurprd04.prod.outlook.com>
 <DU0PR04MB95637D86F0134DC26EF955DB8E02A@DU0PR04MB9563.eurprd04.prod.outlook.com>
 <ZMzBWXpvdW5YB8bt@gondor.apana.org.au>
 <AM0PR04MB60046B045B5965A61BA1CA91E709A@AM0PR04MB6004.eurprd04.prod.outlook.com>
 <f9e34f8a-5a7b-8223-c672-4fcb2bb23c0a@leemhuis.info>
 <DU0PR04MB95639E903580457856250C008E10A@DU0PR04MB9563.eurprd04.prod.outlook.com>
 <DU0PR04MB95637DD95D05179F36AFAF958E10A@DU0PR04MB9563.eurprd04.prod.outlook.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <DU0PR04MB95637DD95D05179F36AFAF958E10A@DU0PR04MB9563.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691935505;1bec62a4;
X-HE-SMSGID: 1qVBiF-0004o8-Jy
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.23 14:58, Meenakshi Aggarwal wrote:
> 
> We discussed about it and lets revert the patch for now,

Okay. So who will submit the revert?

> as the tag is to be applied this weekend.

/me can't follow, but whatever, likely not that imporant

Ciao, Thorsten

>> -----Original Message-----
>> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
>> Sent: Friday, August 11, 2023 5:25 PM
>> To: Linux regressions mailing list <regressions@lists.linux.dev>; Gaurav Jain
>> <gaurav.jain@nxp.com>; Herbert Xu <herbert@gondor.apana.org.au>
>> Cc: Bastian Krause <bst@pengutronix.de>; davem@davemloft.net; linux-
>> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Dan Douglass
>> <dan.douglass@nxp.com>; kernel@pengutronix.de; Horia Geanta
>> <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta
>> <pankaj.gupta@nxp.com>
>> Subject: RE: RE: [EXT] Re: [PATCH] crypto: caam - adjust RNG timing to support
>> more devices
>>
>> Hi,
>>
>> we have tested this patch on multiple variants of imx board and it is working fine.
>>
>> We are actively debugging the issue, it is taking time as we are not able to
>> reproduce it at our end.
>>
>> Thanks,
>> Meenakshi
>>
>>> -----Original Message-----
>>> From: Linux regression tracking (Thorsten Leemhuis)
>>> <regressions@leemhuis.info>
>>> Sent: Friday, August 11, 2023 2:18 PM
>>> To: Gaurav Jain <gaurav.jain@nxp.com>; Herbert Xu
>>> <herbert@gondor.apana.org.au>; Meenakshi Aggarwal
>>> <meenakshi.aggarwal@nxp.com>
>>> Cc: Bastian Krause <bst@pengutronix.de>; davem@davemloft.net; linux-
>>> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Dan Douglass
>>> <dan.douglass@nxp.com>; kernel@pengutronix.de; Horia Geanta
>>> <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta
>>> <pankaj.gupta@nxp.com>; Linux kernel regressions list
>>> <regressions@lists.linux.dev>
>>> Subject: Re: RE: [EXT] Re: [PATCH] crypto: caam - adjust RNG timing to
>>> support more devices
>>>
>>> [CCing the regression list, as it should be in the loop for regressions:
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs
>>> .ker%2F&data=05%7C01%7Cmeenakshi.aggarwal%40nxp.com%7C84b2ed6da
>> ac44625
>>>
>> 779408db9a61d801%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
>> 827351
>>>
>> 7248142302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
>> V2luMzI
>>>
>> iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=OWH18Cwu
>> h8zyAFqn
>>> I6iiL3Kewpj5NiWaQorKcmiYrr0%3D&reserved=0
>>> nel.org%2Fadmin-guide%2Freporting-
>>>
>> regressions.html&data=05%7C01%7Cmeenakshi.aggarwal%40nxp.com%7Cfde9
>>>
>> ceeb9e0d40d4f77d08db9a47a5e1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
>>>
>> C0%7C0%7C638273404742560069%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
>>>
>> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
>>> %7C%7C&sdata=lt7nphOXYXc3GRfOquvM5jmqNszQkDd%2BuSRdAbJd8Ec%3D
>> &r
>>> eserved=0]
>>>
>>> On 04.08.23 14:02, Gaurav Jain wrote:
>>>> From: Herbert Xu <herbert@gondor.apana.org.au>
>>>>> On Mon, Jul 24, 2023 at 05:13:23AM +0000, Meenakshi Aggarwal wrote:
>>>>>> Please share the required information.
>>>>> Any progress on this?
>>>>>
>>>>> Should we revert the offending patch?
>>>>
>>>> Debugging is in progress. There should be some mismatch in TRNG
>>> configuration in customer board.
>>>> Will be sharing a patch to dump the same.
>>>
>>> Any progress on this? Afaics would be good to have either the fix or
>>> the revert in by -rc7 to ensure things get at least one week of proper
>>> testing before the final release.
>>>
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker'
>>> hat)
>>> --
>>> Everything you wanna know about Linux kernel regression tracking:
>>> https://linux-/
>>>
>> regtracking.leemhuis.info%2Fabout%2F%23tldr&data=05%7C01%7Cmeenakshi.
>>>
>> aggarwal%40nxp.com%7Cfde9ceeb9e0d40d4f77d08db9a47a5e1%7C686ea1d3b
>>>
>> c2b4c6fa92cd99c5c301635%7C0%7C0%7C638273404742560069%7CUnknown
>>> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
>> wi
>>>
>> LCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=Xg3ZCWObptmF6xLKO7dpaIYB
>>> A17eKK5wNhlPZ6FR2XA%3D&reserved=0
>>> If I did something stupid, please tell me, as explained on that page.
>>>
>>> #regzbot poke
> 
> 
