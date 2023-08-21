Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A3F78316A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjHUTkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHUTkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:40:53 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03hn2240.outbound.protection.outlook.com [52.100.13.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D924DB;
        Mon, 21 Aug 2023 12:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AVyDmMLmoyLxMRC56GT2CQ6M9yKRqKal+pzeOpmPeU=;
 b=v4GlmWe9y9JDdXyziP4KqcBGBITkNkmG+jpGnTdLdE4Euy4IlgpTyklWfF4Cz4Xt6Uuwy2Jz4lLQKrYs+bn76NHvS9AmC3dUW9k/2KtKpCZRGUQNwHVWv0tiB/WRZkiZnV1z7N99LVq/Hw0wBznwRsNKeTxTyMMK/WMA3WUu0ezLADunkwd9z1tC29Rl6pSn2pJ/SYVAdH7oE5N1uptGAEnE3F+Ca5rR1g3sz6cK0hFjJtSTFwU/QlMbUdJMF8pU54v267rgp2Yw3PvIWOXZygkZw8NfFPpi8P52d8oYW8WNkPFHIQISrSeAAFvP312Wb13vaWGvxaBFtiuR9IGWxQ==
Received: from FR0P281CA0172.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:b4::14)
 by AS8PR03MB8119.eurprd03.prod.outlook.com (2603:10a6:20b:446::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 19:40:44 +0000
Received: from VI1EUR05FT041.eop-eur05.prod.protection.outlook.com
 (2603:10a6:d10:b4:cafe::41) by FR0P281CA0172.outlook.office365.com
 (2603:10a6:d10:b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.10 via Frontend
 Transport; Mon, 21 Aug 2023 19:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.81) by
 VI1EUR05FT041.mail.protection.outlook.com (10.233.243.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.15 via Frontend Transport; Mon, 21 Aug 2023 19:40:43 +0000
Received: from outmta (unknown [192.168.82.132])
        by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id B459A200813A8;
        Mon, 21 Aug 2023 19:40:43 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (unknown [104.47.14.54])
        by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 276AB2008006E;
        Mon, 21 Aug 2023 19:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHR+7IE6EftoatJHJu36YNNYinRI83P+W8q3IxV5ck0TH+XAisP3gLQjohnLnwmlqTCHG5ubyHvzRl6Z12RWXUFzMmjHIIM+XZWMhejokiIjjSY8yzQH82ApY2fPaaKsPbzJl7B4LB1QMKrP3wq+bgiEdCst2eJOIJ5l1RXIOcw2enjapitcsK38jlnixzs2KEWOwyBxAwB11ixbd+frvscssBxr+4UmcKG1GV6qZlD+67+LHp0l/b+4HsPGp2aO53tECKIpQgsSSe5upxEdXSnS6djLpsTMkDqZHqfYPROHgi71DSnUac+jEjwlk/kmZ7jJtnSzuU5WalcTkAf4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AVyDmMLmoyLxMRC56GT2CQ6M9yKRqKal+pzeOpmPeU=;
 b=FoXxcrBerhV5nnnqgqTDjDcqoeHRkTwvus0Q9mY4OsJ4hDArZTsVgRux+Huu9aHbNEmI+NyVYyGIxgXDDxbP48Xr1XEfCr3AoLOtDfgNOkWgrvG4EaCA7J8cXRMUnV4J9OgjxCAFSHG7/K+fTj/JDjuFA6nzolbovpOSg8yKlcakOsvpbGXtLxxHvms8eI/OXehmtI2uAHTJNlqknD4tMstuHBTS+uwQa/FhUv/WlNjTluphA0WkzWfsIdLd7jxivIWbw+qLnDa899vD4ElvuifJhqk7l7tkvX87HfblOyVPxYsGZjD3bJ+4/oqRaI+060Vy1B7X9xUIl7IFVwka9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AVyDmMLmoyLxMRC56GT2CQ6M9yKRqKal+pzeOpmPeU=;
 b=v4GlmWe9y9JDdXyziP4KqcBGBITkNkmG+jpGnTdLdE4Euy4IlgpTyklWfF4Cz4Xt6Uuwy2Jz4lLQKrYs+bn76NHvS9AmC3dUW9k/2KtKpCZRGUQNwHVWv0tiB/WRZkiZnV1z7N99LVq/Hw0wBznwRsNKeTxTyMMK/WMA3WUu0ezLADunkwd9z1tC29Rl6pSn2pJ/SYVAdH7oE5N1uptGAEnE3F+Ca5rR1g3sz6cK0hFjJtSTFwU/QlMbUdJMF8pU54v267rgp2Yw3PvIWOXZygkZw8NfFPpi8P52d8oYW8WNkPFHIQISrSeAAFvP312Wb13vaWGvxaBFtiuR9IGWxQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DU0PR03MB10114.eurprd03.prod.outlook.com (2603:10a6:10:415::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 19:40:36 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::21bd:6579:b3d1:e5f7]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::21bd:6579:b3d1:e5f7%5]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 19:40:36 +0000
Message-ID: <aa479c9d-232a-8e23-fd5e-092053c813c1@seco.com>
Date:   Mon, 21 Aug 2023 15:40:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [RFC PATCH net-next 2/8] phy: introduce the PHY_MODE_ETHERNET_PHY
 mode for phy_set_mode_ext()
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
References: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
 <20230817150644.3605105-3-vladimir.oltean@nxp.com>
 <2c8cb48c-5b0f-5712-8c50-ea285df829ec@seco.com>
 <20230821181350.akn5mir2woj2ioke@skbuf>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20230821181350.akn5mir2woj2ioke@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:208:329::14) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DU0PR03MB10114:EE_|VI1EUR05FT041:EE_|AS8PR03MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5ae1fd-673c-4e11-2d38-08dba27e826d
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: RkKf76NXYRVRtBB85h679OV3MsbSWON6tLzkwKJwe5w9NhF2RgWRDKySthcgiDeVHEx9tt+cfXJAeLVGnOZ/Rb6P4BZbyCUWYaBeyuC9p/Lru8SB3AaD5KMGJtfw5/MERSVntjuKc9NUkX3c8wCKVMmpRV7PRhmLp+ERyH73aEFb/BzRXmXqbQK9HuXd+pMTNafnuELinomTGHgqoyEMG7jxe+t9ZRxCZGYjyeimm6i3I4DD3HByfbvhOkbm2cMxCUvLFiUutfiLQIIp/eQQlgh1FVuYiACJfdw3byxPRGlT53qvyxpeY9+LrOv3TJo7t/+g2qQim+W9nqDRAZMUDTHbZKCmq9HyJFkLg0TF/lQi+rbDabe2GCLqKj7prvtT4ehGaD3aM6e5bISC3IYhfFpJWpMp2NJN6GKEup3JdZRoRfEzW4g+KTm4xg0QriYlN4i7KvrPP6AXAAxpEB06J3YJ7d7nE0RamSO+cAnpxiSMSzy1CcowFNTvz3gKvkDc1brkzgFRlBuroRmk6DyR7dkHwJNykc864EJSdhHh+ZZPuj3bUR1i22kttJplXxZI1DWDN6B+GLlVPGE8QfxUBtl8vJHUm4Xqt9Ku8wVJ8errcjytNUkJyyseswjWrAAYcJ/mhWzI0W5YuF5RgkZcCUuFoMgIsYQheoMT9mPZTlv9ptwDOnZd4kDO4buRlmET
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39850400004)(451199024)(186009)(1800799009)(31696002)(86362001)(38350700002)(38100700002)(36756003)(31686004)(19627235002)(6506007)(478600001)(44832011)(6916009)(316002)(8676002)(8936002)(4326008)(66946007)(5660300002)(6486002)(2906002)(6666004)(7416002)(53546011)(83380400001)(52116002)(26005)(2616005)(6512007)(66556008)(66476007)(41300700001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB10114
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR05FT041.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 848ec5df-0e11-471b-0ff1-08dba27e7d84
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNQ6xxkSjOmDqlK1wau5K4pUeCNUNNIxUOZ7SN6ckXv9v8JmM8GeCRphHpnZ0Ijte70uNjdc5eu62w5XY1mvLtLJaz6uvXKrtmwKUunhaPkaaHks1ntian/C7PGtxi5lqzafLZza44amRtfNhbgXm8IsUuAJdUpEfNJw1jffFP/E1EGd4m8jElOldg85SkTHM1xeWZEa3epDDW3Jnptp6bO/jWv5GkIdHZV4ubmeWfRmD4ARBU+6FzSxU3X1wGIShZ5O222OBnjOeS/OZ1NNXdUKhjGEszMuja+QwcFK7/m3AQflI76RLvPwoQ6RUefdLYsMp4WdXy1+4GqimePJpPHu/DSSJiTTMYxH0FDeDQ2uDh8sWT6nQd2lRmJcDxfJJj5WtljRBnLidkOi0Ejgo4heKyu+9OBwZBpbvM3kutvdbZYUl7T2BDyQOnDMlxAb0o1L4lvIqpB9nlYJyBYoRk7kyVFqiNYZwVIjV1KKXwZnuz/Mm5O0hZOh5EV19dnZu3Q58ZBZ182HaP1BnRU8fKSsnz5IUnAFR4d8H73qXIETN3VKlVbXewbSzSrBx4/DOs12pNxju6plCF3Knp6KI/z2PxGaX/+9o5r38MlDWe/fKQ++vObJJ9dI385xFJsTFjiI0yeD5REGu+Ux7KDfQbhmiQ22uCccf4JxOhx4/9F98gk4cuoZ65znnqGAi6Tft9kTeBgQUHWxzSZLs4Tlq1P+MU0noT7BOOqgC8i2tG5cbN8bImbGatLPKTD2Ozi/3WL3OGUL/W+mL0qK74MSb0QFVtWCIJDyjwwSmiPpHqTaFpuEjM7jz1ANUgR1XX5e15/TFPV6wAACzHKMkjETWg==
X-Forefront-Antispam-Report: CIP:20.160.56.81;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39850400004)(346002)(186009)(1800799009)(82310400011)(451199024)(5400799018)(46966006)(36840700001)(40470700004)(54906003)(6916009)(70586007)(70206006)(316002)(6512007)(8676002)(34070700002)(8936002)(2616005)(4326008)(7636003)(36756003)(41300700001)(40460700003)(7596003)(356005)(82740400003)(478600001)(19627235002)(6666004)(53546011)(6506007)(40480700001)(6486002)(83380400001)(2906002)(7416002)(86362001)(31686004)(47076005)(36860700001)(31696002)(336012)(44832011)(5660300002)(26005)(43740500002)(12100799039);DIR:OUT;SFP:1501;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 19:40:43.9891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5ae1fd-673c-4e11-2d38-08dba27e826d
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.81];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT041.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8119
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 14:13, Vladimir Oltean wrote:
> Hi Sean,
> 
> On Mon, Aug 21, 2023 at 01:30:46PM -0400, Sean Anderson wrote:
>> On 8/17/23 11:06, Vladimir Oltean wrote:
>> > As opposed to PHY_MODE_ETHERNET which takes a phy_interface_t as is
>> > expected to be used by an Ethernet MAC driver, PHY_MODE_ETHERNET takes
>> > an enum ethtool_link_mode_bit_indices and expects to be used by an
>> > Ethernet PHY driver.
>> > 
>> > It is true that the phy_interface_t type also contains definitions for
>> > PHY_INTERFACE_MODE_10GKR and PHY_INTERFACE_MODE_1000BASEKX, but those
>> > were deemed to be mistakes, and shouldn't be used going forward, when
>> > 10GBase-KR and 1GBase-KX are really link modes. Thus, I believe that the
>> > distinction is necessary, rather than hacking more improper PHY modes.
>> 
>> 10GBase-KR and 1000Base-KX are both electrically (e.g. link mode) and
>> functionally (e.g. phy mode) different from 10GBase-R and 1000Base-X due
>> to differing autonegotiation. So the phy modes are still relevant, and
>> should still be used to ensure the correct form of autonegotiation is
>> selected.
>> 
>> That said, I do agree that from the phy's (serdes's) point of view,
>> there are only electrical differences between these modes.
>> 
>> However, I'm not sure we need to have a separate mode here. I think this
>> would only be necessary if there were electrically-incompatible modes
>> which shared the same signalling. E.g. if 802.3 decided that they wanted
>> a "long range backplane ethernet" or somesuch with different
>> drive/equalization requirements from 1000BASE-KX et al. but with the
>> same signalling. Otherwise, we can infer the link mode from the phy
>> mode.
>> 
>> --Sean
> 
> Thanks for taking the time to look at this RFC.
> 
> I will ask a clarification question. When you say "I'm not sure we need
> to have a separate mode here", what do you mean?
> 
> The lynx-28g implementation (not shown here) will need to distinguish
> between 1000Base-X and 1000Base-KX, and between 10GBase-R and 10GBase-KR
> respectively, to configure the number of electrical equalization taps in
> the LNmTECR registers, and to allocate memory for the ("K"-specific)
> link training algorithm. Also, in the particular case of BaseX vs
> BaseKX, we need to modify the PCCR8 register depending on whether the
> C22 BaseX PCS or the C45 PCS + AN/LT blocks need to be available over
> MDIO.
> 
> So, passing PHY_INTERFACE_MODE_1000BASEX when we intend 1000Base-KX is
> simply not possible, because the dpaa2-mac consumer already uses
> PHY_INTERFACE_MODE_1000BASEX to mean a very different (and legit) thing.
> 
> Do you mean instead that we could use the PHY_INTERFACE_MODE_1000BASEKX
> that you've added to phy_interface_t? It's not clear that this is what
> you're suggesting, so feel free to stop reading here if it isn't.

Yes. The intent for this interface mode is for the PCS to select the
appropriate autonegotiation. So if you use the 1000Base-KX link mode,
you should also use the 1000BASEKX phy mode (unless you have a separate
phy doing the conversion).

> But mtip_backplane uses linkmode_c73_priority_resolution() (a function
> added by me, sure, but nonetheless, it operates in the linkmode namespace,
> as a PHY driver helper should) to figure out the proper argument to pass
> to phy_set_mode_ext(). That argument has the enum ethtool_link_mode_bit_indices.
> 
> So, a translation between enum ethtool_link_mode_bit_indices and
> phy_interface_t would be needed. That would be more or less doable for
> 1000Base-KX and 10GBase-KR, but it needs more phy_interface_t additions
> for:
> 
> static const enum ethtool_link_mode_bit_indices c73_linkmodes[] = {
> 	ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
> 	ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
> 	/* ETHTOOL_LINK_MODE_100000baseKP4_Full_BIT not supported */
> 	/* ETHTOOL_LINK_MODE_100000baseCR10_Full_BIT not supported */
> 	ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
> 	ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
> 	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
> 	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
> 	/* ETHTOOL_LINK_MODE_25000baseKRS_Full_BIT not supported */
> 	/* ETHTOOL_LINK_MODE_25000baseCRS_Full_BIT not supported */
> 	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
> 	ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
> 	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
> };

Well, I suppose you really do have "electrically-incompatible modes
which shared the same signalling". So I think it's reasonable to go this
route.

I considered something like this for lynx10g, but that serdes only
supports 10GBase-KR, so there was no need to differentiate that from
10GBase-KX4 (or 10GBase-CR).

> I guess that network PHY maintainers will need to chime in and say
> whether that's the path forward or not.

I think the commit message could better motivate this patch by drawing a
distinction between a serdes which is talking to a phy or sfp which will
convert the signals to the final link mode, and a serdes which is acting
as the final connection to the far end, with nothing intervening.

--Sean
