Return-Path: <linux-kernel+bounces-42732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D458405B3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEA31C22E14
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCF162817;
	Mon, 29 Jan 2024 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="NId3Dbh/"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E8F6168E;
	Mon, 29 Jan 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532698; cv=none; b=PYJUvgC1nSVc2M4VetYxzO4K9XpPX8Ce1G1pE+2YcQAvPRrhcjCPIQuiNkoFTQ0H1MWDHG+vmDMmmpCehXNI6sbn3jfRuxStYPPuh3A8rSK74qaQqnggTSGl1WlH+Dx7IBg9uB07LQXzg+6ys5zIPFL7WpvKcueVO8KaKUtKgyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532698; c=relaxed/simple;
	bh=QnBqzmhKuV4DkLRqe3+Uw6hRSHSCsEpTmcXzgBwWtE4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nMTk2TgoFFUtU8DmhKztRmmUtbhJywA1e/fZyTdVA+MSZhV0TKJ69R/SOAacyFapmZ4RCo2FZFttRkRdBOa1oaFq7wp3I2K1OwHm38/hLri7dkOQQQ7bqrmTgdDHw5I8t7ObvRIHuVxNq9omG9jxnKFeRKCi4cCkFHipr9xZxrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=NId3Dbh/; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id DF8E0941A5CF;
	Mon, 29 Jan 2024 13:51:24 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id jeapObYxi3VM; Mon, 29 Jan 2024 13:51:24 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id B3EDC941A5D4;
	Mon, 29 Jan 2024 13:51:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com B3EDC941A5D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1706532684; bh=P7HFrtGN4X3oSqy0NlKdSgb4AicwOFSWBTQe23Uieuc=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=NId3Dbh/rj1YZ1Ff9YY4cE058j4pexV6MAlri/kvILCyucXOi6MEtPILzbe6Y8VLp
	 /VhfWLK4HKcYc5iiBff1CNvGMKxXBdclF9lW24scuCYd2TWwhl0uDGQPBA26sh5zPY
	 mLoPCZTU72j4k1OOEqVjZf2Sfx8l1KmKeOjVME1XoTNWuQgpQMxco4YqCV6+dQRkBJ
	 UjfQNmeixvz0Jd5fPDMz38egPVFM/UiY0esaV96DUvWvvddi6wWzhbtTb7E/QhZK6V
	 R8YSxv+/M+Q1bx9r8llNUJgLhuwmEje2cv/7Autpo1/rS1HvE1v2fKBvv01ufpGzXw
	 Z9Nr63S04uBag==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id cWs2srkwjCFC; Mon, 29 Jan 2024 13:51:24 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 58D2C941A5CF;
	Mon, 29 Jan 2024 13:51:24 +0100 (CET)
Date: Mon, 29 Jan 2024 13:51:11 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
cc: Andre Werner <andre.werner@systec-electronic.com>, andrew@lunn.ch, 
    hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com, 
    kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v4 2/2] net: phy: adin1100: Add interrupt support
 for link change
In-Reply-To: <20240122074258.zmbzngrl7dzhkvwo@DEN-DL-M31836.microchip.com>
Message-ID: <e8a14edd-0879-a6f8-0e7a-edf09998f6e9@systec-electronic.com>
References: <20240121201511.8997-1-andre.werner@systec-electronic.com> <20240121201511.8997-3-andre.werner@systec-electronic.com> <20240122074258.zmbzngrl7dzhkvwo@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Dear Maintainers,

I'm a bit confused about the patch submitting process for net-next.
Do I need to send the patchset again, if the merge window is opened again and
the patchset was previously submitted as RFC?

Best regards.
Andre


On Mon, 22 Jan 2024, Horatiu Vultur wrote:

> The 01/21/2024 20:54, Andre Werner wrote:
>
> Hi Andre,
>
>
>> An interrupt handler was added to the driver as well as functions
>> to enable interrupts at the phy.
>>
>> There are several interrupts maskable at the phy, but only link change
>> interrupts are handled by the driver yet.
>>
>> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
>> ---
>> v4:
>> - Change read-modify-write behavior as suggested to phy_modify_mmd.
>
> Usually it is good to keep the change log also from the previous
> versions, so it is easier to see what has been changed.
>
>> ---
>>  drivers/net/phy/adin1100.c | 56 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>
>> diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
>> index 7619d6185801..7c82384e5d30 100644
>> --- a/drivers/net/phy/adin1100.c
>> +++ b/drivers/net/phy/adin1100.c
>> @@ -18,6 +18,12 @@
>>  #define PHY_ID_ADIN1110                                0x0283bc91
>>  #define PHY_ID_ADIN2111                                0x0283bca1
>>
>> +#define ADIN_PHY_SUBSYS_IRQ_MASK               0x0021
>> +#define   ADIN_LINK_STAT_CHNG_IRQ_EN           BIT(1)
>> +
>> +#define ADIN_PHY_SUBSYS_IRQ_STATUS             0x0011
>> +#define   ADIN_LINK_STAT_CHNG                  BIT(1)
>> +
>>  #define ADIN_FORCED_MODE                       0x8000
>>  #define   ADIN_FORCED_MODE_EN                  BIT(0)
>>
>> @@ -136,6 +142,54 @@ static int adin_config_aneg(struct phy_device *phydev)
>>         return genphy_c45_config_aneg(phydev);
>>  }
>>
>> +static int adin_phy_ack_intr(struct phy_device *phydev)
>> +{
>> +       /* Clear pending interrupts */
>> +       int rc = phy_read_mmd(phydev, MDIO_MMD_VEND2,
>> +                             ADIN_PHY_SUBSYS_IRQ_STATUS);
>> +
>> +       return rc < 0 ? rc : 0;
>> +}
>> +
>> +static int adin_config_intr(struct phy_device *phydev)
>> +{
>> +       int ret;
>> +       u16 irq_mask;
>
> Please use reverse x-mas notation here.
>
>> +
>> +       ret = adin_phy_ack_intr(phydev);
>> +
>
> No new line here, between ret and if.
>
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
>> +               irq_mask = ADIN_LINK_STAT_CHNG_IRQ_EN;
>> +       else
>> +               irq_mask = 0;
>> +
>> +       return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
>> +                             ADIN_PHY_SUBSYS_IRQ_MASK,
>> +                             ADIN_LINK_STAT_CHNG_IRQ_EN, irq_mask);
>> +}
>> +
>> +static irqreturn_t adin_phy_handle_interrupt(struct phy_device *phydev)
>> +{
>> +       int irq_status;
>> +
>> +       irq_status = phy_read_mmd(phydev, MDIO_MMD_VEND2,
>> +                                 ADIN_PHY_SUBSYS_IRQ_STATUS);
>> +       if (irq_status < 0) {
>> +               phy_error(phydev);
>> +               return IRQ_NONE;
>> +       }
>> +
>> +       if (!(irq_status & ADIN_LINK_STAT_CHNG))
>> +               return IRQ_NONE;
>> +
>> +       phy_trigger_machine(phydev);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>>  static int adin_set_powerdown_mode(struct phy_device *phydev, bool en)
>>  {
>>         int ret;
>> @@ -275,6 +329,8 @@ static struct phy_driver adin_driver[] = {
>>                 .probe                  = adin_probe,
>>                 .config_aneg            = adin_config_aneg,
>>                 .read_status            = adin_read_status,
>> +               .config_intr            = adin_config_intr,
>> +               .handle_interrupt       = adin_phy_handle_interrupt,
>>                 .set_loopback           = adin_set_loopback,
>>                 .suspend                = adin_suspend,
>>                 .resume                 = adin_resume,
>> --
>> 2.43.0
>>
>>
>
> -- 
> /Horatiu
>


