Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0337C77E766
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344656AbjHPRPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345219AbjHPRPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:15:33 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Aug 2023 10:15:31 PDT
Received: from smtpcmd11128.aruba.it (smtpcmd11128.aruba.it [62.149.156.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507DE98
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:15:31 -0700 (PDT)
Received: from [192.168.1.205] ([95.47.160.93])
        by Aruba Outgoing Smtp  with ESMTPSA
        id WK65qJTsS2K8PWK66qEcKV; Wed, 16 Aug 2023 19:14:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1692206066; bh=N+9PWTDLjBF4OiIXaY51P2Wt4HfPbX2uXnPkXyQK3Z0=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=GBSbwHlGsOvFqATeUCoYQGI659t+QdoKZw48sj1vUvGNLSZvsfcR20ByKShlQUXew
         W31aHuYuKtZMqQCq3eGADkzkRfAUfosrwIsshALQu13L9W+2R+ik0OiP1TT1AaC18P
         uaCulrTkB7nCT6Iq18P8snPavPWTtSUsx1L4SO5l6GtpUlizaBhjlDcqOJjUNotEX7
         1GVb/faXouowQQEBCO2M6ABnjbZQ5k87jvMvWG84DYgCI0CWTuNBFoukJ6npTHfQFY
         bGM3INp5TSpCIcLPL2NngXE1PJS6UicT7aEsREcyp+LoUuyyehr18r7yfHF/EGdZtr
         izDuo3YCSnTXw==
Message-ID: <630d9eff-c6b5-a019-ba27-5c18824f7b89@benettiengineering.com>
Date:   Wed, 16 Aug 2023 19:14:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450
Content-Language: en-US
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
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <CAPDyKForXMxANUrvOUfEtiRsXYPJ8MbfPBdJB6zu49QfeJfS8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFTdRc0i6GjWwAjIHvenEG9PVVoL+pCOjSa6B7toVJkViRj1TSy07AkxTNPgz5ViQv4g1bNfeR/n6BtzY4/o7OQuZRl0VXKD0pJR0h3/+zvERbq7qrJ/
 +zH20XRlE3I6NG3jaNg/hWOkW/fApBnm5V8WC9uuuBwwPKENxRXN6JUVSU5d8lr8h/KLOtjh/3xQHrp2Z5zco36uOh+u+w2UaJkQQvJwdVIyL7kuxcZgonCN
 IhhAo8ZnNHuz9RytyYXgtBE6F5uLLXDA+tzkZ50axFv8hUZFhbYlwfZ9jOQd1kTL7g97C2ZCyum9TPuXAeIoDS9PiampLlX7tS6QFnMFofLYa8CDqy5Tg2Mn
 BL2hQu3V1VHCWClQxnCrvfKlR0AjpKLzXXeSBKoHipXTO0Km7tyy4zbZX+f2cZRNSGMB7U1DZwnO6lCoAIR/apgzE9IoPaaLpM/W4jbIimo/1xE1jMobtJiB
 3Vd2fWgHOBvREd10GJ9AQgYFNMc5flAgzMKJ8bfGKqVwIE8acVkokKXTEbTFUINGF7eHESL56UtbJ/NXSwtqqzPbQlpZ99ig1obn7ns96s/QqyIpnA5D9m+E
 PaHdaC91Qt6ZKT8YEUBYRjUIEPdvXhToFvr6CHkWB6IuqysVZzx/UauZIagiDQXAkzSmOvfXHPid1+I+ECkj1n0s
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ulf, and All,

+Cc Andrew Lunn,

On 16/08/23 11:52, Ulf Hansson wrote:
> On Fri, 11 Aug 2023 at 23:49, Giulio Benetti
> <giulio.benetti@benettiengineering.com> wrote:
>>
>> Errata ERR010450 only shows up if voltage is 1.8V, but if the device is
>> supplied by 3v3 the errata can be ignored. So let's check for if quirk
>> SDHCI_QUIRK2_NO_1_8_V is defined or not before limiting the frequency.
>>
>> Sponsored by: Tekvox Inc.
> 
> Didn't know we have this kind of tag. Can you point me to the
> documentation of it?

I've been pointed by Andew Lunn almost the same question here:
https://lore.kernel.org/lkml/859ff6a9-3ba9-ea2e-7b85-01813c5df0dd@broadcom.com/t/

and also asked to update:
Documentation/process/submitting-patches.rst

I've taken inspiration by this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=73c289bac05919286f8c7e1660fcaf6ec0468363

where there is "Sponsored by:" and not "Sponsored-by:" otherwise
checkpatch.pl script complains about it.

Other commits already have that sort of tag.

I could add Sponsored-by tag documentation and in checkpatch.pl script
as well as other possible scripts where required as pointed by Andrew.

I think this is a good way to give credits to companies that sponsor
patches and it could be more interesting for companies in general to
pay someone to upstream patches because they have their name on it.
Otherwise it's not an everyday task to add a driver from scratch
and write in the top comment that is sponsored by some company.
Also now there is SPDX so that part would be dropped too.

What do you All think about this? Do I go for a RFC patchset to add
the Sponsored-by: tag?

Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas

>> Cc: Jim Reinhart <jimr@tekvox.com>
>> Cc: James Autry <jautry@tekvox.com>
>> Cc: Matthew Maron <matthewm@tekvox.com>
>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> 
> Kind regards
> Uffe
> 
>> ---
>>   drivers/mmc/host/sdhci-esdhc-imx.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index eebf94604a7f..cddecc1e1ac2 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -171,8 +171,8 @@
>>   #define ESDHC_FLAG_HS400               BIT(9)
>>   /*
>>    * The IP has errata ERR010450
>> - * uSDHC: Due to the I/O timing limit, for SDR mode, SD card clock can't
>> - * exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
>> + * uSDHC: At 1.8V due to the I/O timing limit, for SDR mode, SD card
>> + * clock can't exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
>>    */
>>   #define ESDHC_FLAG_ERR010450           BIT(10)
>>   /* The IP supports HS400ES mode */
>> @@ -961,7 +961,8 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>>                  | ESDHC_CLOCK_MASK);
>>          sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
>>
>> -       if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
>> +       if ((imx_data->socdata->flags & ESDHC_FLAG_ERR010450) &&
>> +           (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V))) {
>>                  unsigned int max_clock;
>>
>>                  max_clock = imx_data->is_ddr ? 45000000 : 150000000;
>> --
>> 2.34.1
>>

