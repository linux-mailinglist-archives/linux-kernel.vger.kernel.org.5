Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8F3776442
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjHIPoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjHIPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:44:29 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2074.outbound.protection.outlook.com [40.107.14.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4C6211C;
        Wed,  9 Aug 2023 08:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOBV0bHKVhjdasun1uvMT+Jmw47RRdkIu2HQwDretcLidLFQ6xbtQgFiUfj/LvrCbHLOgGGr8h+lIhNaGZxfhf37KEV3TkkVcRfgjnuIdd3eGbmXbhylZGVTlkZ9/VECtYk6sY8tVfksKMU2D92PCCeAQDxyaRPeDE3cz+r90p46JcCAJW3oZ3lOYOe3aphvNh360bIl6xH6p8w33InqRXYGadbr+W+P8b4m36rtq7LZCfcnouvEIUTHl500WovzcOmlSKB9L0L2Q5x0lzWiwe4OP1dRfWjOKZUTjWplNRnv3YCuJap+GDq8zfoz7lwsp/vjqKrFaQOg76ogFAl/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCQV4qNb/CREVEDO4JZtXM6t8f8mPCc6M5B5n+0yaTU=;
 b=SniaC91dymkDJCp0IScGGcBGurbiwBg6JAlkIlAbF/tGZY4biGrACFxZZ6T/OdJ5OLS4EZ5xh5QFZtrV5tERdDU5vm4hIziJeNLf0hZKPr8ONytoFONi90b5TTFY2oSvRtzKNfKbcBXEpwsW+jnqKaJK7zrZ2rPihLbhtgI0+0UjcLfU/3oZ08MWCoybArlHuE6nNAe+N+HM2dqAlVorjsVl2XWwfMWdvhibqiM8M9G5x8l+HUYipimAEqJBiGNjZFHBkAJd0rewGa+2VHMB+yvJZzgHZTULZyhKeKGjbyqCHxXlMxWj3PznAehhi5ygUjBoFUfWsFds7gV+gnrNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCQV4qNb/CREVEDO4JZtXM6t8f8mPCc6M5B5n+0yaTU=;
 b=YATQmLwaqO9UdURrRDfUmxfHWlwdzf4gRVO5xBvl4jhLPGxg900vWbsjWZxmduSnTCD/C5ypOHb2Uj8ZdhSDkHbJRTJkfX3+Yifu28GvcneHj72aQHrgC9uR0Iw4fqFqao+nK3FFQzBpfjFyMXy3j/03gFBg3yiDyED7qVMUvXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by DU0PR04MB9634.eurprd04.prod.outlook.com (2603:10a6:10:31c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 15:44:24 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::fd28:f7a2:1bc1:53a0]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::fd28:f7a2:1bc1:53a0%6]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 15:44:24 +0000
Date:   Wed, 9 Aug 2023 18:44:18 +0300
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Uwe =?utf-8?B?S2xlaW5lLUvilJzDgm5pZw==?= 
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
Message-ID: <20230809154418.hjkf43ndwfzretiy@LXL00007.wbi.nxp.com>
References: <20230804071757.383971-1-u.kleine-koenig@pengutronix.de>
 <20230808145325.343c5098@kernel.org>
 <1e438a02-6964-ce65-5584-e8ea57a694bb@gmail.com>
 <ZNLIOEBXNgPOnFSf@shell.armlinux.org.uk>
 <20230809142155.4dtmnmmecaycbtum@LXL00007.wbi.nxp.com>
 <ZNOivVJ+G/sRiwai@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNOivVJ+G/sRiwai@shell.armlinux.org.uk>
X-ClientProxiedBy: AS4P195CA0009.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::17) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|DU0PR04MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: af3d3ddc-ddf0-40d7-56b5-08db98ef8172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQDpVxbhm6qnWUuAgX7PV6ZxN4o4TDg5FjaxeMU/EgWZL6WHyulQzRrtIEoZ3LQBNFlwRXnkkcljTlriD/bzLA0vpxYpB2iUewAHTRNTcqABwWjI3JYpfNAFgy1p6iYDY7YGBKgg230JKt1i1IccFr2jrnbtaUJmz3XXlzJsn+8NhD0+0xxG8gHrmcBPFfxyZ/Yba/ev175FrSgGk8zFLbIZR05VnP8IfRn0sDMHFOJ+xpoMhcpBC9JnF9jRR30D+ghnVJM0AuXA4fiHV/OGDy6ApADZdUj4ls1IcdFxk9Re6gm1/57puI1VfrbYr7zaXm1haFtCDmI/wQLpLlHe+8RnguKr2yEaNKg4kxasjvan5S+er8vayUwZD4uRso2cKbh13HkbxcHku7KLWtnN6dOxpMaQSiHWHtxU+FV1H9pQZzWURSCF2PPA06bnq3n1ef0Z2OPm41bFUR7JXc43UbSl3D+4c7gPOZ2S1AGjnWTlyhNZucCEgt9smH0Lqgcbb9h3mXKdQwJ8JasNFJnTBDhilffQFi4LdJe3WaRc60VS8ad5aGxy1++/pHaF2CYK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(186006)(1800799006)(451199021)(6486002)(26005)(1076003)(6506007)(6512007)(6666004)(478600001)(38100700002)(54906003)(66946007)(66476007)(66556008)(4326008)(41300700001)(316002)(8676002)(8936002)(5660300002)(44832011)(7416002)(7406005)(2906002)(6916009)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d3OBJcKkhZsM6+ujjIDV3H46kjsIpyhpvME+VoL8SewFNyJyUktjJqn16yh6?=
 =?us-ascii?Q?iPSkhYMC+GZzriG0xF1injGS1AmMuZz1ZOSi61c7K9FPP80wAVbl2rBt87UV?=
 =?us-ascii?Q?Jo7gATzhAuJUEWOjffgytdIHctpOOq4rSlFPYCh289ESb/OZBM8NjkLZ2/rP?=
 =?us-ascii?Q?4f9D/1CbTxY+6WOps5QkkhEd0a3ftYuC9kfIeI+3z7Glc8tmmP593/TjIxFX?=
 =?us-ascii?Q?bgLiUkMTdFnZfyt+ONRkr0UFZCGNNCtKI4ys0O++OX9M7DCtNpPzH7NEGKE0?=
 =?us-ascii?Q?nahIhLmgNRuH4CXGppMeClh/nK13L7nJx9FMDFmdO0kG40Fr9sgQPlCXwMKc?=
 =?us-ascii?Q?56W5WyvQa7f81S5pLIE5ewM/a5CPmHY0UHncViBF8BIurtK8QbD+blLH4hbB?=
 =?us-ascii?Q?azlptzdszJQzLQ+sv3sXRrpIJm5qk/8zD49/Dr6Bb3C0GPT/1bQrlfNZaW3F?=
 =?us-ascii?Q?kIGjyd3wpSVn3hV2znNsVYfQv8BD5toS4pWV9/BIJmax3fQSao/l5wnPt233?=
 =?us-ascii?Q?Loiv01w311z2kAFYlGcXPkiMUveLbWtUME58LWhD6f72IqbpyA0uiYZys35x?=
 =?us-ascii?Q?K2oS9Vff2H6On00Ee4Iezrx3mCSUH9a2dNRjgDfSFUkqNNGMFddDFpmu2+hW?=
 =?us-ascii?Q?zN3oCLjiYAbCaf55Dcu2H0z8c6Fs9usGmH5ssuHOHG+CeMTgMilSOvgT9iVS?=
 =?us-ascii?Q?Ca+O8iUIkopyGdvjUvJx0BMk1BX42V7Ob1TilQTkpcJ1TR1097GVhGTKLsFL?=
 =?us-ascii?Q?Aw9lzsNE6TSbnuTQQBA4fcP3c3UGnqWuEN503RSg0qoK8wlMOphBpDv2bhQj?=
 =?us-ascii?Q?EprCe5ib9l8vZJIhd7rNKhTmgH5KYe8xrfyddJuzgRAmDYNvUFz9Ee5lpVHw?=
 =?us-ascii?Q?namf3nVOrK2SaATSqL6TRITqzVCzoj9yPVU0wmv3c3EopW67fcDeRkvvM/wS?=
 =?us-ascii?Q?iXk0+EWbc2yl7ucafj81Xwl/jSE9WGzy/JbKikis3tH1nMiBistWMlQmE8MJ?=
 =?us-ascii?Q?pxtbJO1aRY2EGgRzBT44eYEIAcMMqFvPuL6pBdIxIHAi1B9/HrGPVgmEZqf7?=
 =?us-ascii?Q?mq471yyAuLR5D9PqDyhJDI3SyvkuuCCQ+DYUanBSBmR3w+gnKDKNH7TOr5xl?=
 =?us-ascii?Q?21Iz2+GUDwm5jt90/JrE7HmWxRl98Y03nmZqO/75ILq0H/+EsotNXXcyxEyf?=
 =?us-ascii?Q?uX+RWbt3kwErHAqwFDeRYE6DBrTaS8+SI3OA5WPfGJ8NOyAjmzZIxL+FBDdq?=
 =?us-ascii?Q?BBQ4O19+3FTM4LtKNrCOTz0PKivtuG/tAHcFMeKXp+5GD1s4W85vweJqKt4L?=
 =?us-ascii?Q?96BvF4lIcaMYb9U4pCyyyHcdgyMdBX5mBW9oQ9/mvIp6vbhCraf0mSSBt3el?=
 =?us-ascii?Q?bfG9wTCmXK26WqM7j9MGMlt6T7aPg4W4Eh11AiG8ObjgeTTdj2z/HMrs9uq0?=
 =?us-ascii?Q?AIQt9Zcmws+MVXZKcVYsLiG8nCcUT9fKs7CtlFzLbbfwHTHjm69Mdh6mHE+l?=
 =?us-ascii?Q?AylGeDk0JfYhRwdMn+HbV7ki9Sc9guxyDYz3E3KOmS0WX++lSw2FJrZGrcw6?=
 =?us-ascii?Q?VCMfZ07VboBOe/g56jlWHVEf7cmoJhjQ4H4dbID9UIs11Qz7Q6nPTrAoDUAc?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3d3ddc-ddf0-40d7-56b5-08db98ef8172
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:44:24.1583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9/hb2YcdKD5+J5vlOrYhXhmFCWUaVq4+Gmwx+wMwV9QuO5NVaOQ6UkhPXG++nagKDX60qPrkzfzu7Lh5y/lqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:29:17PM +0100, Russell King (Oracle) wrote:
> On Wed, Aug 09, 2023 at 05:21:55PM +0300, Ioana Ciornei wrote:
> > That's a perfect summary of the problem that I was trying to fix.
> > 
> > The board in question is a LS1021ATSN which has two AR8031 PHYs that
> > share an interrupt line. In case only one of the PHYs is probed and
> > there are pending interrupts on the PHY#2 an IRQ storm will happen
> > since there is no entity to clear the interrupt from PHY#2's registers.
> > PHY#1's driver will get stuck in .handle_interrupt() indefinitely.
> 
> So I have two further questions:
> 1. Is WoL able to be supported on this hardware?

I don't know if anyone cares about WoL on the AR8031 PHYs from this
board.

Both of the PHYs are used in conjuction with 2 eTSEC controllers - which
use the driver in drivers/net/ethernet/freescale/gianfar.c.

The Ethernet controller does have WoL support, which means that WoL could
still be supported on the board even though we would forbid WoL on the
AR8031 PHYs.

> 2. AR8031 has a seperate WOL_INT signal that can be used to wake up the
>    system. Is this used in the hardware design?

No, WOL_INT is not connected.
