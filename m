Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B95477A166
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 19:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjHLR17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 13:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHLR16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 13:27:58 -0400
Received: from smtpweb158.aruba.it (smtpweb158.aruba.it [62.149.158.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FB919A7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 10:28:01 -0700 (PDT)
Received: from [192.168.1.205] ([95.47.160.93])
        by Aruba Outgoing Smtp  with ESMTPSA
        id UsP7qw2gvAtggUsP7qUg5M; Sat, 12 Aug 2023 19:27:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1691861279; bh=WdK2I7Y+vABxEZzrHZY4tQquHYXwxPmq+x/0MGOhJT0=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=j4u3NcrHy3Wa4swbjgNU7jB9uBRlDNL1rmUtWobEhSLx396fZAzr52ob0odZVzRwI
         x0A4fb2O4SSUK/1xOLp2bbMPP89rHrfRkSgox8fRdyj46s5ZpayQw/1IbJEu6vL1FK
         u6+RKp5njjFEZSBPyrOYBcHAifj7wkx6d3vGa+eactnUpgl/ZTneodnVQoGPJ4R5nM
         pXhOfoobGtmd5YNlyCpkp4EmO/Zaficm1FQxV74nsqG9/L0NcD33VEC6iCasK7oJRP
         6voVCUBQF8zxRgyaO/qceAuQBC3AaJ+LPpCciUqhptzcwTj02o82SWpJxChpfiz/XX
         Mhz51cVekgboQ==
Message-ID: <4a67a6ae-f697-1353-1b0f-55b42e5dbdfa@benettiengineering.com>
Date:   Sat, 12 Aug 2023 19:27:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] net: phy: broadcom: add support for BCM5221 phy
Content-Language: en-US
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
References: <20230811215322.8679-1-giulio.benetti@benettiengineering.com>
 <859ff6a9-3ba9-ea2e-7b85-01813c5df0dd@broadcom.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <859ff6a9-3ba9-ea2e-7b85-01813c5df0dd@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfINVkbhKg9D/+OB2rMBSZDDCi8Evw9TCNC6vd1wnlQFjU+UJ8EKDNiTCgAyGEHF2SzWitjH7CNegvUCfKdc15sjytd0/0vYGTlS63Q2UXXRbJN40ZAOB
 F3LQygNPOecJBzQOavOcaT3p+MqrsnHenpE60jQGDO/zEjYUdxBj7GGe9lcXabJGvfADZn5oliTuD0h3JebYTEKNxwJrDAW9lwvIxnkkqXI2yBVHmKrj6/QH
 kAMlNShgk6x8kftnzVV8n8Agxr2+CzJL4KAVVd/DSVAcG5aoVO6W7jn70Y/2F3EHTsLXzPNNUSgYLlCgdHElNSs5tdkyPpYCSFhIc+loIxALBVAki5q8MDEl
 vKrIcmVSauTUvmULJ4s8QZrS8TrnmimI6sUR25G2/WoERyWz318+xzkoKgLUOhF21Px1M5tInXW9IUqCxmDtKwXzkuinLVD1hNmbPbArwakE+IeynVoujGQ9
 mXqIQCaI9FP9GyCird+1tgJlXE2qLw2cVAFeHn49YQ1GqxN0BS7OKR2OfKfF3K9JuHMB8cx6iz/Yhw5WnjGd4gvCp2ER6VglgHm3efdburyfSSoHugQRIDYM
 WYF49NEorosG0A3xLcOiQhmMPp3C3HnHHHJ2hG9Y7h6mEMKKbxSkE0yuw+GpcMJcxWw=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Florian,

thanks for reviewing,

On 12/08/23 01:52, Florian Fainelli wrote:
> 
> 
> On 8/11/2023 2:53 PM, Giulio Benetti wrote:
>> This patch adds the BCM5221 PHY support by reusing
>> brcm_fet_config_intr() and brcm_fet_handle_interrupt() and
>> implementing config_init()/suspend()/resume().
>>
>> Sponsored by: Tekvox Inc.
>> Cc: Jim Reinhart <jimr@tekvox.com>
>> Cc: James Autry <jautry@tekvox.com>
>> Cc: Matthew Maron <matthewm@tekvox.com>
>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> 
> Looks good, few comments below.
> 
>> ---
>>   drivers/net/phy/broadcom.c | 144 +++++++++++++++++++++++++++++++++++++
>>   include/linux/brcmphy.h    |   8 +++
>>   2 files changed, 152 insertions(+)
>>
>> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
>> index 59cae0d808aa..99f6c0485f01 100644
>> --- a/drivers/net/phy/broadcom.c
>> +++ b/drivers/net/phy/broadcom.c
>> @@ -754,6 +754,84 @@ static int brcm_fet_config_init(struct phy_device 
>> *phydev)
>>       return err;
>>   }
>> +static int bcm5221_config_init(struct phy_device *phydev)
>> +{
> 
> Very similar to brcm_fet_config_init() except that you configure fewer 
> interrupt sources, do not have the LED mode programming and your MDI-X 
> programming is done via a 10BaseT specific register rather than the shadow.
> 
> Can you consider adding parameters to brcm_fet_config_init() such that 
> you can specify the 5221 specific settings such as the interrupt mask 
> for instance?

So if I've understood correctly I should drop bcm5221_config_init() and
use brcm_fet_config_init() by checking the struct phy_driver .phy_id to
be PHY_ID_BCM5221.

> This should help address the locking that Russell suggested.

But I don't understand how this can help to prevent the locking Russell
suggested, can you please elaborate more or point me and example?
As far as I've understood I should take care to lock sections to prevent
from interrupts to occur during shadow mode switching, is it correct?
So maybe you mean that if I do this in brcm_fet_config_init() it will be
fixed for the other phys using brcm_fet_config_init(), correct?

> [snip]
>> +static int bcm5221_suspend(struct phy_device *phydev)
>> +{
>> +    int reg, err, err2, brcmtest;
>> +
>> +    /* Enable shadow register access */
>> +    brcmtest = phy_read(phydev, MII_BRCM_FET_BRCMTEST);
>> +    if (brcmtest < 0)
>> +        return brcmtest;
>> +
>> +    reg = brcmtest | MII_BRCM_FET_BT_SRE;
>> +
>> +    err = phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
>> +    if (err < 0)
>> +        return err;
>> +
>> +    /* Force Low Power Mode with clock enabled */
>> +    err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXMODE4,
>> +               BCM5221_SHDW_AM4_EN_CLK_LPM |
>> +               BCM5221_SHDW_AM4_FORCE_LPM);
>> +
>> +    /* Disable shadow register access */
>> +    err2 = phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
>> +    if (!err)
>> +        err = err2;
>> +
>> +    return err;
>> +}
> 
> bcm5221_suspend() is essentially brcm_fet_suspend() minus the setting of 
> the BMCR.PDOWN bit, can you consider factoring brcm_fet_suspend() into a 
> helper that can decide whether to set the power down bit or not? Does 
> not brcm_fet_suspend() work as-is?

Sure, I will,

>> +
>> +static int bcm5221_resume(struct phy_device *phydev)
>> +{
> 
> This should really be calling bcm5221_config_init() here, if the PHY was 
> on a power island that is powered off during system suspend, 
> bcm5221_resume() would not be restoring the auto-power down that is set 
> during config_init(), probably not desired because that means you will 
> burn power when the cable is disconnected...

oh yes! You're right, I will then drop bcm5221_resume() in favor of 
bcm5221_config_init(), so brcm_fet_config_init() with phy_id == 
PHY_ID_BCM5221 checks.

Thanks again
Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas
