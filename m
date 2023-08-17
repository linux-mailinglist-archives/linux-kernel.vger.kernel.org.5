Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A1F77FC4D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348116AbjHQQoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353738AbjHQQoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:44:17 -0400
Received: from smtpcmd0768.aruba.it (smtpcmd0768.aruba.it [62.149.156.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B4B2D70
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:44:13 -0700 (PDT)
Received: from [192.168.1.205] ([95.47.160.93])
        by Aruba Outgoing Smtp  with ESMTPSA
        id Wg6QqdaxgGtUfWg6RqhyyE; Thu, 17 Aug 2023 18:44:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1692290651; bh=/WW9v1WAslhcQooa6UbgzvadufTPdDcAWA3DP1TW/3s=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=CneS2txm13hAE0dkPgE8aeTnWdpIeebWF56VPMQu0vErAMqhlmZIhX8V3yR/g4oDq
         gFGFd+rKp1RL9/WvN5B/OhYjDpmk8CZZ85XtJpvvtLeQhSf0SRB2DNKg0nTEktQ/kK
         dZVFr+e99CSjcd2hxQ55Fd2wOVEl1sOPgSgRt0/Va4h8sAdlae6y+eb8A14jOtI6/8
         d7v3K/lCyi2D3CuOhT6ywAqqW07jFkpy/d9shC0lVQ2U/jRoFBRCvB3Ln0jOdV/LEu
         Gk2G7ob+rG6tHwsET2zD+DIYz+uaWx51vRqeUhWMrAyFGjc0//2nW1NShxuft2Zmgc
         x6BgGIMtML2HA==
Message-ID: <116308f2-2133-5953-802d-6da562c81af1@benettiengineering.com>
Date:   Thu, 17 Aug 2023 18:44:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Haibo Chen <haibo.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
References: <20230811214853.8623-1-giulio.benetti@benettiengineering.com>
 <CAPDyKForXMxANUrvOUfEtiRsXYPJ8MbfPBdJB6zu49QfeJfS8A@mail.gmail.com>
 <630d9eff-c6b5-a019-ba27-5c18824f7b89@benettiengineering.com>
 <CAPDyKFq9VpSDuD1itDPZ0cYdRJuHvYcK=+Si-u1YkDqQhBAcQQ@mail.gmail.com>
Content-Language: en-US
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <CAPDyKFq9VpSDuD1itDPZ0cYdRJuHvYcK=+Si-u1YkDqQhBAcQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfG+ezq16URayEgseWQxvNNWsGVZ+UiwtXvo7H30h/cfvI0MZoFQ17L1T7rNPRxs2fh1JypAGYvDiyAt4acF447OP6D+X4Yns79X/9W0vd6rCGA+U3dY3
 oNVg2SGxFtx34TLBG9FYxgc84e3ITrnPxW7YtoJmJPkb4QdfncHETCyK6Rxi66TuNT2Bzo+XrP2DEnqyDoiKJqF3TO102KcFJCICFGJ9sikejG+lNL4S2sfw
 OPPr4N+rh7yXYO0osnYTXmzfWCRPDy8KbK7f1YourTlg+8fm6G1zXVQ+toL7uyz6rfTw/wwdCtiV1NEUZVEnMFCScwmmBuoabw2JMSCfS7RrrPaqqE46k/kY
 bd1KzsqQ/HB2N22h7fdEOU16cMp91TjFKANvCAqonSFxxIYL9YEoX09L+jAgu7yOBqgG3EtdseiQm69Ni4W1yTtRWEMTv9b1tcoL2FqXiFz2lBiG2+qYXLrf
 ORy9K/dfk6XJoNpbGbJCZE0kwsRey8KNM3Vnr3zBYWOThGksDz9kTD3QS4HkfM4hC63Rg70/jnQTIg+zqUR4CxKgCylKiuzXRwLhROZ3obAMe8+jXmeS1yp2
 e4FSaskuXGZylrZLVz0XaOB3+tfTvpEY3GiKm7q5SXfTgwy8s6278I5YsJGhWSpphxKA+oqpnzETnsX/PyFPmndQ
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ulf,

On 16/08/23 23:36, Ulf Hansson wrote:
> On Wed, 16 Aug 2023 at 19:14, Giulio Benetti
> <giulio.benetti@benettiengineering.com> wrote:
>>
>> Hello Ulf, and All,
>>
>> +Cc Andrew Lunn,
>>
>> On 16/08/23 11:52, Ulf Hansson wrote:
>>> On Fri, 11 Aug 2023 at 23:49, Giulio Benetti
>>> <giulio.benetti@benettiengineering.com> wrote:
>>>>
>>>> Errata ERR010450 only shows up if voltage is 1.8V, but if the device is
>>>> supplied by 3v3 the errata can be ignored. So let's check for if quirk
>>>> SDHCI_QUIRK2_NO_1_8_V is defined or not before limiting the frequency.
>>>>
>>>> Sponsored by: Tekvox Inc.
>>>
>>> Didn't know we have this kind of tag. Can you point me to the
>>> documentation of it?
>>
>> I've been pointed by Andew Lunn almost the same question here:
>> https://lore.kernel.org/lkml/859ff6a9-3ba9-ea2e-7b85-01813c5df0dd@broadcom.com/t/
>>
>> and also asked to update:
>> Documentation/process/submitting-patches.rst
>>
>> I've taken inspiration by this commit:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=73c289bac05919286f8c7e1660fcaf6ec0468363
>>
>> where there is "Sponsored by:" and not "Sponsored-by:" otherwise
>> checkpatch.pl script complains about it.
>>
>> Other commits already have that sort of tag.
> 
> Yes, but that seems silly to me.
> 
> We should not be using tags in this way. First there needs to be an
> agreement of what kind of tags we should allow in the commit messages,
> before we start using them.
> 
>>
>> I could add Sponsored-by tag documentation and in checkpatch.pl script
>> as well as other possible scripts where required as pointed by Andrew.
>>
>> I think this is a good way to give credits to companies that sponsor
>> patches and it could be more interesting for companies in general to
>> pay someone to upstream patches because they have their name on it.
>> Otherwise it's not an everyday task to add a driver from scratch
>> and write in the top comment that is sponsored by some company.
>> Also now there is SPDX so that part would be dropped too.
>>
>> What do you All think about this? Do I go for a RFC patchset to add
>> the Sponsored-by: tag?
> 
> My opinion is just one voice here, so at this point it doesn't really
> matter what I think.
> 
> If *you* think this is a good idea, I encourage you to submit an RFC
> to the kernel docs for this. In this way we can collect the comments
> and see if people think this is a good idea.

Ok, I will go with a RFC soon,

> That said, do you want me to apply $subject patch without the tag or
> would you rather proceed with submitting an RFC first?

It would be great if you can apply the patch without the tag please.

Thank you
Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas
