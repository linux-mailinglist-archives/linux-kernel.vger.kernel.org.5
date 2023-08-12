Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04AE77A14A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 19:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjHLRPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 13:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHLRPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 13:15:41 -0400
Received: from smtpweb158.aruba.it (smtpweb158.aruba.it [62.149.158.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94C3E71
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 10:15:43 -0700 (PDT)
Received: from [192.168.1.205] ([95.47.160.93])
        by Aruba Outgoing Smtp  with ESMTPSA
        id UsDEqvwg1AtggUsDEqUeMh; Sat, 12 Aug 2023 19:15:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1691860542; bh=muxnEISc+XHJJJMXfB20gSQ/1p4GnXF0uTq805wjmfo=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=hCODdIqxV2l6zIRyR1+Jf3zHRTalYYhX/TDUNJJSH2tGJWG05k5VF88OQs4DDfuBG
         Y6RMY0vmdBXa6whTH+iSGVj4FirkJpLZ0Zi8kh+wjGFjz9uJ0Wl0cOrhwQ3VXGwaZP
         5C9HINS8weQzF4nrWT9ZJMfHfT0dS+Vr2JK79W4DTsmbNbk4pUFdS685LKGUT5RxcI
         ZQk8EpGVGgmeo6Odr171BQ3lYcWypIEGB402YLErxMmIF3V7k87P1o7zOqvHHQANY6
         86CY8iPP//G9Q0uY1V9vWFzs9Xa35W3fMOifIe3hxeZT0rDs8o4XyVuzIqjC5i2Bec
         ytNHwFQrbTIYQ==
Message-ID: <e627f60f-b13d-d82f-ff7c-f4b2bef21303@benettiengineering.com>
Date:   Sat, 12 Aug 2023 19:15:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] net: phy: broadcom: add support for BCM5221 phy
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
References: <20230811215322.8679-1-giulio.benetti@benettiengineering.com>
 <ZNa0qlICwsUq6H2C@shell.armlinux.org.uk>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <ZNa0qlICwsUq6H2C@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGacTA4vdX1nLnQwEW9m50w4HnDo81jIoskLigC9gxfGbLo6EzHmiXnt8JHI9Sy4bqpvbmcbNEX3F0rJ9MKxTi0+URWFEoiAFRUtKr+ip1tfGOext1ZI
 GJ+cD/zct+zRHVq1dklZ6kzlyUqk398nPLjbiz9a0GlO8UpQPIOHscEmwK03oxFActPNuQdodF5GVR1onMyX409EmZW2Xutjw7R8dNlwys8m1QXTIWG97i4I
 8s2l4wIoIYIc3MVXXKe7j0rx9HH1zZMNtnF+U5Bz2TiC05ZZw0K2BkS/W58A7ao68hM8WQX3eJMxqZQc+QGaewn+M+lm7GbyHCxTqTyJ4XLxsrkuoZpdpzcS
 fp/WIeL36YJHIZDnrl+tj1oy7ynKXS3NAM/psdfyrgadGAcW5mp2pY2QjDRXbFKk37yCIqF6vg949zrEvkULqZ/7taHn3Vb2PwRQ9y6+iopkID64eIhzBR+z
 6a8ZiH+Vr3c7sHpug1s+hqHEUm5Iccy24rzJWLW3JgywzKSAVrU4XL0vvXgJBkhI3boBrBJ/Idpat8p5jwQ7yIV9WNeIDZS10OGtfwSWvCSNwTfyXKSaR3M6
 ACW/abWtgdMUtf/+lLLpDKSa9Npcdp60MO2vvheVU6XlO9mjHPlfNqhSK+xz+mrcs28=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

thanks for reviewing,

On 12/08/23 00:22, Russell King (Oracle) wrote:
> On Fri, Aug 11, 2023 at 11:53:22PM +0200, Giulio Benetti wrote:
>> +	reg = phy_read(phydev, MII_BRCM_FET_INTREG);
>> +	if (reg < 0)
>> +		return reg;
>> +
>> +	/* Unmask events we are interested in and mask interrupts globally. */
>> +	reg = MII_BRCM_FET_IR_ENABLE |
>> +	      MII_BRCM_FET_IR_MASK;
>> +
>> +	err = phy_write(phydev, MII_BRCM_FET_INTREG, reg);
>> +	if (err < 0)
>> +		return err;
> 
> Please explain why you read MII_BRCM_FET_INTREG, then discard its value
> and write a replacement value.

ok, yes, as it is it doesn't look self-explanatory at all

>> +
>> +	/* Enable auto MDIX */
>> +	err = phy_clear_bits(phydev, BCM5221_AEGSR, BCM5221_AEGSR_MDIX_DIS);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	/* Enable shadow register access */
>> +	brcmtest = phy_read(phydev, MII_BRCM_FET_BRCMTEST);
>> +	if (brcmtest < 0)
>> +		return brcmtest;
>> +
>> +	reg = brcmtest | MII_BRCM_FET_BT_SRE;
>> +
>> +	err = phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
>> +	if (err < 0)
>> +		return err;
> 
> I think you should consider locking the MDIO bus while the device is
> switched to the shadow register set, so that other accesses don't happen
> that may interfere with this.

oh, I haven't considered this, you're totally right,

>> +static int bcm5221_suspend(struct phy_device *phydev)
>> +{
>> +	int reg, err, err2, brcmtest;
>> +
>> +	/* Enable shadow register access */
>> +	brcmtest = phy_read(phydev, MII_BRCM_FET_BRCMTEST);
>> +	if (brcmtest < 0)
>> +		return brcmtest;
>> +
>> +	reg = brcmtest | MII_BRCM_FET_BT_SRE;
>> +
>> +	err = phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	/* Force Low Power Mode with clock enabled */
>> +	err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXMODE4,
>> +			   BCM5221_SHDW_AM4_EN_CLK_LPM |
>> +			   BCM5221_SHDW_AM4_FORCE_LPM);
>> +
>> +	/* Disable shadow register access */
>> +	err2 = phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
>> +	if (!err)
>> +		err = err2;
> 
> Same here.

ok,

>> +
>> +	return err;
>> +}
>> +
>> +static int bcm5221_resume(struct phy_device *phydev)
>> +{
>> +	int reg, err, err2, brcmtest;
>> +
>> +	/* Enable shadow register access */
>> +	brcmtest = phy_read(phydev, MII_BRCM_FET_BRCMTEST);
>> +	if (brcmtest < 0)
>> +		return brcmtest;
>> +
>> +	reg = brcmtest | MII_BRCM_FET_BT_SRE;
>> +
>> +	err = phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	/* Exit Low Power Mode with clock enabled */
>> +	err = phy_clear_bits(phydev, MII_BRCM_FET_SHDW_AUXMODE4,
>> +			     BCM5221_SHDW_AM4_FORCE_LPM);
>> +
>> +	/* Disable shadow register access */
>> +	err2 = phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
>> +	if (!err)
>> +		err = err2;
> 
> And, of course, same here.

ok, will do on V2 along with the other point from Andrew and Florian.

Thanks again for the review,
Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas
