Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC13F77A145
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 19:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjHLRN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 13:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHLRN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 13:13:28 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Aug 2023 10:13:29 PDT
Received: from smtpweb158.aruba.it (smtpweb158.aruba.it [62.149.158.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5977B1B5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 10:13:29 -0700 (PDT)
Received: from [192.168.1.205] ([95.47.160.93])
        by Aruba Outgoing Smtp  with ESMTPSA
        id UsA1qvv3cAtggUsA1qUdwL; Sat, 12 Aug 2023 19:12:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1691860346; bh=ijDa6SZ3jPUmbQztD0IHb8aEkeW7e7yoL3mOaclh98Q=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=XtGhKSkkmVE+xhiwh/lgvJ1qqzEVTbaqZGknMoM5Kj5TQ0cBWW6RNlHPLE3NyILLY
         /ubMO2B/ruO8NWOgRVnn3E3FKBNk9Bmmk033V0xDaW7lr7V8Xbfe1OqNn2UNGldKTy
         arNMEt9sjKmEvkvOCGq+3Mhiv9I+WsFoqqFtkecE4rEDuCAky/jjMuz4JC8Kyhauky
         h0ltlqKr+CDm5YgZJIicV39sV0J9z6dQl8Kj8Bg2klJYVtvH3qguR+ka99lOG9Rg2F
         cBK6gtLvyNWz3Ij0bWMwHoTPnYAOUSnv7MIgn7pYU9QzgVLHIlnwuY0KfEAuJKIkE4
         TOE68fLny5vAg==
Message-ID: <05fbb2b3-17cb-3d4d-5787-50825c090451@benettiengineering.com>
Date:   Sat, 12 Aug 2023 19:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] net: phy: broadcom: add support for BCM5221 phy
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
References: <20230811215322.8679-1-giulio.benetti@benettiengineering.com>
 <0188dd19-7fcb-4bfe-945d-6cb5b57ae80a@lunn.ch>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <0188dd19-7fcb-4bfe-945d-6cb5b57ae80a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAAa85nVzIqNB8icWtEw3o/qk62wAhhrtH3XSMiwYP//ZL7ZA68agIAtlIsm6TngrXA8gDPkZSX9v68eCP8It4TtnxQvBeuGAbRJ9vPi5w+eOALT3HSq
 ZI4dqxS+dPCmvhvT0FWou4ms3wKd3Bv/6rKyqDVzLpmR9vaR9C+G42B2CZGGlSwYtBg7RHXVeu9VcUrXZzK10c/Bi9/yef2u0wPAelcD3X27X3DT5rCiJQot
 Pja7nCZl97xxNrY1IDmv/GUNd0IvZ3w32a/baoko2EjAs335JrkI5LLXgWOWz3QsTpfLBtOutNjFMq2C+g56YmYax17G5sAD+PDdexNedYlBJCyw/uwo27b0
 63NapQUH0cgoRdiJXKbtPYEy6W/fEf9a64fqrsC9fEJCGQJWVLyKP1vGG5TLj1xOsRE78YM4/YIvgQkX6DY4IEbL0z41bVJDYSL+gacAlPzf2LLm0juIOyXu
 Rv1WkSBdkF+pWzl/+Qu1PEDnz7LSGjp4vN0PM9qvggzsxBFiJ7j/smbOH7A7idpMjQ9XaUO9NTLFje/yPY+hAxv5HP5ADOuRamPuWqAcX6zEug4cj8c6lMCE
 oMCBA0eRImrsNltIEBmDfo5TDnoXZ3N83Cffl0ctmheEf2PNYiDj9cND4yoLfnnS0DI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

thank you for reviewing,

On 12/08/23 00:16, Andrew Lunn wrote:
> On Fri, Aug 11, 2023 at 11:53:22PM +0200, Giulio Benetti wrote:
>> This patch adds the BCM5221 PHY support by reusing
>> brcm_fet_config_intr() and brcm_fet_handle_interrupt() and
>> implementing config_init()/suspend()/resume().
>>
>> Sponsored by: Tekvox Inc.
> 
> That is a new tag. Maybe you should update
> Documentation/process/submitting-patches.rst ?

I've picked this tag from commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=73c289bac05919286f8c7e1660fcaf6ec0468363

it's not "Sponsored-by:", do you think it's better using this last form?

I can send a patch along with V2 of this one for that.

>> +static int bcm5221_config_init(struct phy_device *phydev)
>> +{
>> +	int reg, err, err2, brcmtest;
>> +
>> +	/* Reset the PHY to bring it to a known state. */
>> +	err = phy_write(phydev, MII_BMCR, BMCR_RESET);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	/* The datasheet indicates the PHY needs up to 1us to complete a reset,
>> +	 * build some slack here.
>> +	 */
>> +	usleep_range(1000, 2000);
>> +
>> +	/* The PHY requires 65 MDC clock cycles to complete a write operation
>> +	 * and turnaround the line properly.
>> +	 *
>> +	 * We ignore -EIO here as the MDIO controller (e.g.: mdio-bcm-unimac)
>> +	 * may flag the lack of turn-around as a read failure. This is
>> +	 * particularly true with this combination since the MDIO controller
>> +	 * only used 64 MDC cycles. This is not a critical failure in this
>> +	 * specific case and it has no functional impact otherwise, so we let
>> +	 * that one go through. If there is a genuine bus error, the next read
>> +	 * of MII_BRCM_FET_INTREG will error out.
>> +	 */
>> +	err = phy_read(phydev, MII_BMCR);
>> +	if (err < 0 && err != -EIO)
>> +		return err;
> 
> It is pretty normal to check the value of MII_BMCR and ensure that
> BMCR_RESET has cleared. See phy_poll_reset(). It might not be needed,
> if you trust the datasheet, but 802.3 C22 says it should clear.

oh ok, I'll do that on V2

> 
>> +	/* Enable auto MDIX */
>> +	err = phy_clear_bits(phydev, BCM5221_AEGSR, BCM5221_AEGSR_MDIX_DIS);
>> +	if (err < 0)
>> +		return err;
> 
> It is better to set it based on phydev->mdix_ctrl.

ok,

> 
>> @@ -1288,6 +1431,7 @@ static struct mdio_device_id __maybe_unused broadcom_tbl[] = {
>>   	{ PHY_ID_BCM53125, 0xfffffff0 },
>>   	{ PHY_ID_BCM53128, 0xfffffff0 },
>>   	{ PHY_ID_BCM89610, 0xfffffff0 },
>> +	{ PHY_ID_BCM5221, 0xfffffff0 },
> 
> This table has some sort of sorting. I would put this new entry before
> PHY_ID_BCM5241.

right, this and even the struct phy_driver driver entry too then,

> 
>>   #define PHY_ID_BCM50610			0x0143bd60
>>   #define PHY_ID_BCM50610M		0x0143bd70
>>   #define PHY_ID_BCM5241			0x0143bc30
>> +#define PHY_ID_BCM5221			0x004061e0
> 
> The value looks odd. Is the OUI correct? Is that a broadcom OUI?

Yes, you can check it in the pdf page 37:
https://docs.broadcom.com/doc/5221-DS07-405-RDS.pdf
and yes, it's odd.

Thanks again for the review, I'll do the changes here and the others
suggested by the other and send V2 patch.

Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas
