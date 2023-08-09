Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08763776247
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjHIOWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjHIOWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:22:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B8110F5;
        Wed,  9 Aug 2023 07:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqH0sH1jgah500T+ddDWBTBtBGjHWMMdpiXwst4T56mAg/6QLsoDpPFqbgqA9aXkm/PDmRdthGgxjqooC9bDanDD+Kw9a5gt9kfS2ZLa5bihoG7ajm8khaPnARMOtVby01THZKf7HrWAmFjuEIYATeoHOLWBLXYJzjp4Y9sbywXTubC0vg3NQSB4bGpCzoz62CfvY2K1oMHtQfGunJO2ym4XvKWGGD4KhGWbP8WqYVAIxfi/Q+yhwj6L0FfDi1jh8vA1x3IAXiFo2Vu3ivnQ18uXaWWqh8tGI3PTztrkaPx9JWHU3uN18b09npXUC1RJKde9b4CHiI8JchXGnWmYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNp+xBD4ewJa2WKIvH5ZrpgFkVpiIVDpE8iP7e21rZ8=;
 b=XLZnDGn6GCaofYqGakgU2C/VQbrZx+B56NHZDAO+IwA2YKUSNakgYT2UbsO3TuIvN4fezxRVf0i3tPHVKEHdC153Lnc2Dqz+6niVSwukjYvn3qsLgp0VYTqx9ImTgy6at9G1Rj3QboThAuCncPLGsB6bW3szdDZE45HlMtbnIIPQd6iTzxSAQyP3xtdxsz7MKZPheuIRqTRoMJAA9Gw/LbK8PlxZ/9+yeSdaUDocTe9VJbWnIiOXOmPTOIsDSxALhk1HuQv1JJ9WfVtHXab8xaDGJxy58Ixv+x4ZdFheh8KMVNacGVB+rOnXNj+hk2yE53SQmx5TIzzbyXE2OQpZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNp+xBD4ewJa2WKIvH5ZrpgFkVpiIVDpE8iP7e21rZ8=;
 b=rFRLQlan3RrSSPFb6U9Umb9N8eUMMFoB9Ni4c2g9Bc8r6+j1CDTG8xg1fTHssrXC/8dUdhoR2BzHW3Xu3D38F9sT/HydU/BZws0sQo2d8WgaVbFt5VB99KLESoyIGdcrF2FHfv9DqlmzK2+pKlkdtkMffwhtYp8wqgFNpIyT62g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by VI1PR04MB7022.eurprd04.prod.outlook.com (2603:10a6:800:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 14:22:00 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::fd28:f7a2:1bc1:53a0]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::fd28:f7a2:1bc1:53a0%6]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 14:22:00 +0000
Date:   Wed, 9 Aug 2023 17:21:55 +0300
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ioana Ciornei <ciorneiioana@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andre Edich <andre.edich@microchip.com>,
        Antoine Tenart <atenart@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Divya Koppera <Divya.Koppera@microchip.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Kresin <dev@kresin.me>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Michael Walle <michael@walle.cc>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nisar Sayed <Nisar.Sayed@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Willy Liu <willy.liu@realtek.com>,
        Yuiko Oshino <yuiko.oshino@microchip.com>
Subject: Re: [PATCH] net: phy: Don't disable irqs on shutdown if WoL is
 enabled
Message-ID: <20230809142155.4dtmnmmecaycbtum@LXL00007.wbi.nxp.com>
References: <20230804071757.383971-1-u.kleine-koenig@pengutronix.de>
 <20230808145325.343c5098@kernel.org>
 <1e438a02-6964-ce65-5584-e8ea57a694bb@gmail.com>
 <ZNLIOEBXNgPOnFSf@shell.armlinux.org.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNLIOEBXNgPOnFSf@shell.armlinux.org.uk>
X-ClientProxiedBy: AM8P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::30) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|VI1PR04MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 42151ffc-9a64-4b36-e379-08db98e3feba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HhZkh8LDTRhlvndOvHRdmsziQ92DBSWCCne3SwniS3pFekOIRWWUUePdM0Y4HZkb3ew5WVXKvKS/kKXnqvBHO/JX/wVA2rOOzGJMDQEBaxDeCnNw1io5f8kuEERoproKNa/7+yYpRKVKNcUwKW3sddxWfxMTgQb4AzVC1Ph9uhQDtpz6cv7dJDQuLV4MJYiHBlBAqgZSCVYQqcEpcUvRN5LoVUxnJpQMZBREdB7sT/oO4cFwXeplXMeWpl/SgsA00WqDnTnpqFro67PC/vGI2ME32yacgoVwlaoBUCdazJLrPeTqxpDMlX4LHCa7lNNhQCtP6RMIpQ2RUhQ4/QIW9r3MIWtL/BsbEsVvbosEVwqDi44GtZ00v1YewqMxZNvnZ8N4PNHgKjOFY5jF97x9a57OSnbLP8H2+X1iHJ7cxL8GP0f+cYgzcOpfBglEZDlm07tK7HnpPGO0iwBz8bTp5FzLpTZiFTQqgGGwVDC4LedXwwiIfYXXdphjjUuUlDvodWG4wu4pmWoiB+8z4y76GHl68WDJB1qgUCC5a4xoiymqzP+ZZlBku+pAQyOKOju
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(1800799006)(186006)(451199021)(66899021)(316002)(83380400001)(66574015)(2906002)(8676002)(1076003)(5660300002)(8936002)(6666004)(53546011)(6486002)(38100700002)(7416002)(66946007)(66476007)(6916009)(41300700001)(4326008)(44832011)(66556008)(6506007)(478600001)(26005)(7406005)(54906003)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8OkYDcNlB1QybTaHPPbe+29lykz0Rbw4Dw5X2krFSAsvRNDbH7uyzbs1aW?=
 =?iso-8859-1?Q?SF3E8Jp/LuBvfxbZMitN3D02m1p/cEWR7TOcyQgo6VfGrowPVyVe4NzFCr?=
 =?iso-8859-1?Q?o3s1HV2ezghQF4HsOyyU8HIzAPRsqIAanaB4B5hMuJ+CKeSf0e1dtetLwc?=
 =?iso-8859-1?Q?yU37vR7jpQdXLiaxvBwdROE2KJ4VojeBVufXE45G3dZHLfMCnb9TDCxt0k?=
 =?iso-8859-1?Q?sa/H+rvGDvfEnzWdjxKX+NDAffYFXby77eEbDMBuR7iNyv2YkEcd0ByVmq?=
 =?iso-8859-1?Q?puS/0RH5viLjvbL3hRxaHxxgYAGDZ2hOxVHFcU+ZUp7o8ZvrU9ZaIgy3no?=
 =?iso-8859-1?Q?jpt+dOaQioauLFtDDK9eg7RwOsXLiOzsepRSrk+sStPxi2ekVwZnXHbv1x?=
 =?iso-8859-1?Q?XQSsFZXIB5uMf+4YSaBsqVwMRNfWI4bzAcBjPaY5IwyVAJTcF6gsmcnGej?=
 =?iso-8859-1?Q?ZD3nTE3VJDcuLeyPCymtfDwkeMcBH6qBPWMZjjy/oIWHv98XZBH/OAbh42?=
 =?iso-8859-1?Q?kXE7xYDdDjWaKxFI5XUAhfmT4jjxL1EK1IMhzhbY8Px47GBAMakd6T+cMX?=
 =?iso-8859-1?Q?z0Umdneo6niWO3WkRU0rMKdanu8sezthhNeNJznpiJPNPd0yy8foCfM1Gi?=
 =?iso-8859-1?Q?4iHT3CzcMxlNAXpeTmoYbxCbxNQIe4jyJPu3yYpHtJjE1TxbsCSE8hL68g?=
 =?iso-8859-1?Q?znw/GMBEiCe7z5xzfFaaHBJl8xxaP8u9LvqAajCJD5IcR3h2o//E19p2sH?=
 =?iso-8859-1?Q?Qvdarpx2/wruplL/nnYAQu2e7ArOmURx379JFUyw88Wga0iUWPeSt95ZiK?=
 =?iso-8859-1?Q?doQQnhqFB93CbIpTjyM+lUPQUaLshk0fZkEF+Vn4RQYfODTUzRhXEa01dh?=
 =?iso-8859-1?Q?so+FCOm5MZSBBhqIp6nAuLNv/xWPQ04dOaNCCqUcOH/zYu4+8uMm6AbG2k?=
 =?iso-8859-1?Q?DYGWmBzSINYfqc4jzVdm5Dcp4qoNcOqv3txrL/p907XfADvRNHwiBCRyEw?=
 =?iso-8859-1?Q?8niPFzfoAaHUyWS2niUzvF3lQGA9tuZcJzN2RcuZ/48JPJhYm+BsA2ZMxg?=
 =?iso-8859-1?Q?dEXlZpt8wZ8gkLI56A3OsZe2N9C5zFwzXy+W6+z9rm+G3EyStA96t3S216?=
 =?iso-8859-1?Q?F8UoJvimAC+liZDL6Bc0RhTz9NATM8hx+u53WaGWOGOjT95n30l5+0rPm7?=
 =?iso-8859-1?Q?DnAYjb6AKSbbhdY3OTHYIzZP13fy/wDm1Tac1rf3U5VMWwxR4l5DfC9PkN?=
 =?iso-8859-1?Q?SZZvDOwgStBxbwHX182UyOFIZcNX1Qojk4S6IAV3pdGDMB8H92PADx62ln?=
 =?iso-8859-1?Q?45TbDT4iQnOSnW63ra5CxikFxu4LFipMaX0UpXY3jQxqbtDv1aTbmUhuih?=
 =?iso-8859-1?Q?MlKjzdblrMoAoVgHeMAnl5l9vCn4GdkwjnAN2Jr8HSyQq3FuowJXLRMK3n?=
 =?iso-8859-1?Q?edH7PJCyypjgTfpikM4Yx49YKkepHg2WJdec35ZmjCsGDR8kKE92w6EECX?=
 =?iso-8859-1?Q?HZ82XPE218C/x9rFL+ZALU8jNNttSExOJJBBTHttZebFpZZ7a/7B0v3mT2?=
 =?iso-8859-1?Q?sCDxH0BgqXIcpYThkdkBe+ctKVyr+v2O4fMmyJOmMWhxlxiwlFvX5aMQCZ?=
 =?iso-8859-1?Q?fLqI1Z0swTbrvpDR8NEgSHB/xLpdWQ/9Os?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42151ffc-9a64-4b36-e379-08db98e3feba
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 14:22:00.5276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFuxlYb8Kilw6RxqXxYURLY0kjqW6RNHgGynHhbqZ3YuLb+E8R4jcRJE2fDjb9LlldmvI/QtTttnrPe+X1ckwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7022
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 11:56:56PM +0100, Russell King (Oracle) wrote:
> On Tue, Aug 08, 2023 at 02:59:41PM -0700, Florian Fainelli wrote:
> > On 8/8/23 14:53, Jakub Kicinski wrote:
> > > On Fri,  4 Aug 2023 09:17:57 +0200 Uwe Kleine-König wrote:
> > > > Most PHYs signal WoL using an interrupt. So disabling interrupts breaks
> > > > WoL at least on PHYs covered by the marvell driver. So skip disabling
> > > > irqs on shutdown if WoL is enabled.
> > > > 
> > > > While at it also explain the motivation that irqs are disabled at all.
> > > > 
> > > > Fixes: e2f016cf7751 ("net: phy: add a shutdown procedure")
> > > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > 
> > > What do we do with this one? It sounded like Russell was leaning
> > > towards a revert?
> > 
> > Yes, though I believe this will create a different kind of regression for
> > what Iona was addressing initially. Then it becomes a choice of which
> > regression do we consider to be the worst to handle until something better
> > comes up.
> > 
> > Russell what are your thoughts?
> 
> In this situation where a fix for a problem is provided which then
> causes a regression by fixing that problem, I've seen Linus T state
> that it means the fix was incorrect. That seems entirely sensible.
> 
> We are, of course, in the situation where reverting the commit
> restores the old behaviour and thus fixes a regression, but causes
> a regression for another user.
> 
> If it is possible to quickly come up with a fix that avoids any
> regression to either use case, then that is obviously preferable.
> However, if that's not possible, then it seems going back to the
> original situation (i.o.w. reverting) is sensible.
> 
> Now, the fact is that many PHYs do use their interrupts to signal
> that a wake-up happened, and disabling the IRQ from the PHY will
> prevent WoL from working. Other PHYs have a separate pin for this.
> Two recent examples are AR8035, which only has a single interrupt
> pin which covers all interrupts from that PHY, and AR8031 or AR8033
> which have a separate WOL_INT pin which might be used - or the
> main interrupt pin.
> 
> If we hibernate the system, then people how have configured WoL
> are going to expect it to work - but disabling the ability for
> the PHY to raise an interrupt will prevent it.
> 
> So, clearly always disabling PHY interrupts can have a detrimental
> effect on the ability to wake a system up using WoL - where the PHY
> interrupt is used to signal WoL to the rest of the system.
> 
> Now, if waking the system up from hibernation using WoL involves
> the PHY asserting its interrupt pin, then the system must be
> capable of dealing with the PHY asserting its interrupt while the
> system is booting. Remember that the way Linux hibernation works,
> that boot is just the same as a regular boot right up through the
> normal kernel initialisation. It is only towards the end that the
> kernel detects the signature in swap space, and then does the
> funky stuff to resume from the saved data.
> 
> So, during that boot, the system has to cope with that interrupt
> having been asserted by the PHY hardware. Either system firmware
> has to recognise that was the wake-up event and deal with it (e.g.
> disabling the interrupt source) before passing control to the
> kernel, or the kernel has to be able to cope with that interrupt
> being stuck at active state until the PHY driver can deal with it.
> 
> Obviously, if WoL is not enabled or supported, then disabling the
> PHY interrupt should be harmless - but that will have the effect
> of masking any issues that a platform may have until PHY based
> WoL has been enabled.
> 
> Also, don't forget that we have this kexec thing - and the
> .shutdown methods will be called just before handing control to
> the new kernel.
> 
> Uwe's patch solves the problem that he's experiencing - because
> it makes the interrupt disabling dependent on the WoL configuration.
> 
> However, Ioana's problem would still remain - and enabling WoL on
> that platform will make it reappear - and thus it still needs to be
> properly fixed.
> 
> If that problem is properly fixed, then we don't need to disable
> PHY interrupts, which means a revert would be the right approach.

Yes, my initial problem would still remain if WoL is enabled on any of
the PHYs that have a shared IRQ line.

The problem is that I find this combination - shared IRQ and WoL enabled
- impossible to make it work. Maybe we could look into denying WoL from
being enabled on PHYs which have a shared interrupt line.

> 
> Honestly, I don't know what would be best - and I don't believe we've
> heard from Ioana about the problem that was trying to be addressed
> (e.g. exactly when it happened and why.)
> 
> If I had to guess:
> - the PHY in question may be sharing an interrupt with another device
> - when that other device probes and claims its interrupt, an interrupt
>   storm ensues
> - the interrupt layer disables the interrupt input, rendering both the
>   PHY and other device unusable.
> 

That's a perfect summary of the problem that I was trying to fix.

The board in question is a LS1021ATSN which has two AR8031 PHYs that
share an interrupt line. In case only one of the PHYs is probed and
there are pending interrupts on the PHY#2 an IRQ storm will happen
since there is no entity to clear the interrupt from PHY#2's registers.
PHY#1's driver will get stuck in .handle_interrupt() indefinitely.

> I think I've covered all the possibilities, all the issues, outcomes,
> and the politics as far as Linus T would state. I'm also quite sure
> that there will be no way to satisfy everyone!
> 
> Bearing in mind that it is holiday season, and we're at -rc5, I
> think we should give Ioana a bit more time to respond before we
> make a decision. Maybe a little over a week? If we don't hear anything,
> then I think following our established policy and reverting would be
> the correct way forward.
> 
