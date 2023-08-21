Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078EF782F71
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbjHURbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjHURbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:31:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05hn2249.outbound.protection.outlook.com [52.100.175.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B3210F;
        Mon, 21 Aug 2023 10:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucgSqP7EpSzw+b77mygvC9Ki6b91GIwBUxZC3Y0l9no=;
 b=WXPDJkmFZqVdt+aFTvYK86gYKbaAJrZ9NtKKpE/ipI4levd5uof+XCA/CiDt8osNRH7EbrOY3wRdFe0ExBp8appbvZz9mBgMSL/qORi0177rkXdet6uiYX839WaiEP8bgVC+nXAB1NU3ufwZUbxPKQhIESm1IoexZqnclUkFLjp/U2z2/6Qhh1lFp13/9T6T76aRfwIZUQ74kDJYmhmVN5zDMwmFWsn0ZXa4vgRAq0+xUHQreYGwYrynytXTHSBvRI19k1v3bl49clNeMd+iSomLkeS51JYysBCwH4Z7g4YSshvsYG9+hcUWnvrE3aRfzC5nV/HM3ytafdVVT56m6Q==
Received: from DB7PR05CA0065.eurprd05.prod.outlook.com (2603:10a6:10:2e::42)
 by PAVPR03MB9162.eurprd03.prod.outlook.com (2603:10a6:102:326::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 17:30:55 +0000
Received: from DB8EUR05FT027.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:2e:cafe::7b) by DB7PR05CA0065.outlook.office365.com
 (2603:10a6:10:2e::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 17:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.85) by
 DB8EUR05FT027.mail.protection.outlook.com (10.233.239.192) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.15 via Frontend Transport; Mon, 21 Aug 2023 17:30:55 +0000
Received: from outmta (unknown [192.168.82.132])
        by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id E77E320080096;
        Mon, 21 Aug 2023 17:30:54 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (unknown [104.47.0.54])
        by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 1F0592008006E;
        Mon, 21 Aug 2023 17:30:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kjn4boEGH7PPWecrG3rssHwspcQYWWtVRCaiJPPRjDrGwZxEg4d7MtGzjuyym4VT+8q/Y7HqJnxWKIxR5w3nI9H4rPzMmQ1rdOMiHx0CaHQjmvpw3+CrLZtLi69EildrlWD24a4hp9vAW+zoHOK7p+CE8xVTx5OYejBTefh15OcYRjD4I7mC8xqL9SEbU0tCosAXsF2Yo0ysMvPYe3uhfDA6yQd1vLZcapY7jf4wUad+WEXsUkXsSqno7Vbh+dBQ/fYb2VXDmMrdD9aG3OROA+dntPUqGHnto3BdvtH07EmAtAXmb0f/EF1R7x1IbxU+UyOPOqoNN6g11TIR1v70ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucgSqP7EpSzw+b77mygvC9Ki6b91GIwBUxZC3Y0l9no=;
 b=D3Vp/scJg0gw3gDcy1QrYIij/oVVdJ8/dvDKwSq0epVMfSOxOJT2Utc2N/DUo+N98jn5PoXBYR+y02DEST6UNizNzpX3Vg5WUp2KE3Bs0vP0V2Gv2ZauDQ6n1vDM/jEOexX9aAO+jACCFshKRlvwFxxQdspWMjTDpss1l/YYkTKqE0MZifAyZBnDzn9hIJnHGd2iZaQhH90FqnEGTFTqTkVqV70mHAVB+2egj2NC/pIphDjdSntC7Ym6tZTymveEMa1pn/DIiXZx+2nLrdgR6MkszvT/SwdhkjY63mxJnuFw71y6kNycljVR79+PtjsBjJWedngFW46nrg2XurxCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucgSqP7EpSzw+b77mygvC9Ki6b91GIwBUxZC3Y0l9no=;
 b=WXPDJkmFZqVdt+aFTvYK86gYKbaAJrZ9NtKKpE/ipI4levd5uof+XCA/CiDt8osNRH7EbrOY3wRdFe0ExBp8appbvZz9mBgMSL/qORi0177rkXdet6uiYX839WaiEP8bgVC+nXAB1NU3ufwZUbxPKQhIESm1IoexZqnclUkFLjp/U2z2/6Qhh1lFp13/9T6T76aRfwIZUQ74kDJYmhmVN5zDMwmFWsn0ZXa4vgRAq0+xUHQreYGwYrynytXTHSBvRI19k1v3bl49clNeMd+iSomLkeS51JYysBCwH4Z7g4YSshvsYG9+hcUWnvrE3aRfzC5nV/HM3ytafdVVT56m6Q==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PAWPR03MB9834.eurprd03.prod.outlook.com (2603:10a6:102:2ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 17:30:51 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::21bd:6579:b3d1:e5f7]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::21bd:6579:b3d1:e5f7%5]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 17:30:51 +0000
Message-ID: <2c8cb48c-5b0f-5712-8c50-ea285df829ec@seco.com>
Date:   Mon, 21 Aug 2023 13:30:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [RFC PATCH net-next 2/8] phy: introduce the PHY_MODE_ETHERNET_PHY
 mode for phy_set_mode_ext()
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
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
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20230817150644.3605105-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:208:2be::27) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PAWPR03MB9834:EE_|DB8EUR05FT027:EE_|PAVPR03MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f862e21-cf8a-48b4-29e5-08dba26c5fea
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5tH459ACNF1boyE62JID2K50DAaP9/xMflDQFYBn1vI3llW/VqMohHlEwA79RW5dIV3Li6VsJvAC24GBk+XwjYMd8Ry7scBg5NoyKYDEvFv49qUaCR9Cwpg+89n9a9t7CHyqif+uEv5K9dtniG2se2i+UCRQ7rN1xPJBQeB6UwIQ8eL8GCK3OlZk1Xs/GzpwsNBpd3Z24CXTf/FXoLQ1uxROUaKklzhreSkZFchsE9i0NzQdUBYFY1WxKOPbPntMgq1/4rj6hVqvaY+z00bCnMBRH+NXvj0u4cy9ah3zT9htDvnYzwDoB6QiK4046f6gF8nF4dQPZA94Br869c/fIcOPzlXcZmDsh1ZUaOMxM0Pz3FcTGlSyOwoOqdoJ8b8XUb04nicWaeKK6xU8oZx19zKuEUgJs6oHQvxRGf5iMe/AcWjouj/0z2OWKuEbDBlvBoUWeHgNYXMCKCYXpgkduvWkiEGTo1yWNyBkgqxhMbnmCgQJIkUPwbeJAYWeWCs0k4plqb6iXpRVBCAokIQW/YtQUEk/rAXkdmIyo6CsOqD/neM+/AZXEqvaRBGwqZ29bcbb+TTrEOJY+nwOc89Euq/NP5YU/2PnxlE3nSU7TolXZuebuV/3SZNXvDePUW0KnwRYaFHFufM48QuXnhxOFkG8LW+k/+wtHGYGZVlmel7zbopijLWk2aGqM+AOdXc9
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(376002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(2616005)(26005)(6512007)(38350700002)(86362001)(38100700002)(31696002)(36756003)(83380400001)(41300700001)(316002)(8936002)(8676002)(31686004)(66946007)(66476007)(54906003)(66556008)(2906002)(44832011)(5660300002)(4326008)(7416002)(6666004)(6486002)(6506007)(52116002)(53546011)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9834
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT027.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: cc1cf05c-b59f-4231-135f-08dba26c5d9a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5afmQQTpC233ygYmJl6wxd6EkiDH72XBbSWQceDHHv3yzaumfJCpsgqJXTauOH74ofZsnyiDC4DozISt8LDclNpfx7D6gpuZlIsut3kHtxEHo2v3lL6P2mSh9MfAAGh/1+bRYtNX8D1Y/2PG9BclTxECGI/D0aeTgOPTydrFCPgaBkK+0vDjXQj8br+o6b7cvAflge+ITUEK3OCw5vJxZl0DB3qLWLxxmLQ8WbmJ7Vy2A6P58gtTjHDa4Tx9AUK8Ep5uCOYA6hoVOacBCbtJIbAHKl8LEkAtWSCffO6HeGM6m5CC9pwnOvZq0Z2Ekt3u+4PS3zABCwhs9uHLESyWZkbvmIrgKBHFkCAEfDiwYcJHBy7yz5BPB7OZPkL44SelA/OCm5jhPmE7y28qGwbqtXuxSIymRfSXT/eGB1NgrTcufaDRGXuvORLE7f8SXD7oLkv7CC8juHUNEzpXIJj9SOf2h58DOEsnZD7HCnOgn247ADitcnyOXbBXl+1ypWoGoU+U5LPr60OkLxjjxcTnWE/W4DR7jKUskjJYipnxC2sJb5iJI73j6TYkXJlhUxqPG098wHDzsSWAzpEZo6q3HoC49gnw5scCl2BlPj08CSdJqI1WoLLK2s4dsc0XKFJVsLs7ly3b/U/Z9Iu7xr9L9flq1tSzOoT7Ex1uA4mYwd5UmWCdL2HrbrkZappn4KQYWXZTGmmrz91TsqspiNJcADt2Vj5s+I4xHTz/oy6LqVUd82ySmwTXT25mAtyRfj/f8ILJFg50PqbWsyGb+unpjgEwLNI7d2rfzXZJIt0ZaYsY1cYrj38KVUsYNnnZaoo5/xRUNicBAuzND5Wmry9kQ==
X-Forefront-Antispam-Report: CIP:20.160.56.85;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(396003)(39850400004)(346002)(376002)(136003)(1800799009)(451199024)(82310400011)(5400799018)(186009)(40470700004)(36840700001)(46966006)(54906003)(70206006)(2906002)(4326008)(44832011)(8676002)(41300700001)(8936002)(316002)(70586007)(478600001)(53546011)(5660300002)(7416002)(6666004)(6486002)(6506007)(31686004)(6512007)(2616005)(336012)(26005)(83380400001)(40460700003)(47076005)(31696002)(36860700001)(34070700002)(356005)(86362001)(7596003)(7636003)(82740400003)(36756003)(40480700001)(43740500002)(12100799039);DIR:OUT;SFP:1501;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 17:30:55.1625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f862e21-cf8a-48b4-29e5-08dba26c5fea
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.85];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT027.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9162
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/23 11:06, Vladimir Oltean wrote:
> As opposed to PHY_MODE_ETHERNET which takes a phy_interface_t as is
> expected to be used by an Ethernet MAC driver, PHY_MODE_ETHERNET takes
> an enum ethtool_link_mode_bit_indices and expects to be used by an
> Ethernet PHY driver.
> 
> It is true that the phy_interface_t type also contains definitions for
> PHY_INTERFACE_MODE_10GKR and PHY_INTERFACE_MODE_1000BASEKX, but those
> were deemed to be mistakes, and shouldn't be used going forward, when
> 10GBase-KR and 1GBase-KX are really link modes. Thus, I believe that the
> distinction is necessary, rather than hacking more improper PHY modes.

10GBase-KR and 1000Base-KX are both electrically (e.g. link mode) and
functionally (e.g. phy mode) different from 10GBase-R and 1000Base-X due
to differing autonegotiation. So the phy modes are still relevant, and
should still be used to ensure the correct form of autonegotiation is
selected.

That said, I do agree that from the phy's (serdes's) point of view,
there are only electrical differences between these modes.

However, I'm not sure we need to have a separate mode here. I think this
would only be necessary if there were electrically-incompatible modes
which shared the same signalling. E.g. if 802.3 decided that they wanted
a "long range backplane ethernet" or somesuch with different
drive/equalization requirements from 1000BASE-KX et al. but with the
same signalling. Otherwise, we can infer the link mode from the phy
mode.

--Sean

> In particular to the Lynx SerDes, it can be used (as the PMA/PMD layer)
> in conjunction with a separate backplane AN/LT block to form a
> full-fledged copper backplane Ethernet PHY. The configuration of the
> lanes is relatively similar to what is done for a typical MAC-to-PHY
> link, except that we allow tuning the electrical equalization parameters
> of the link (support for which will come as a separate change).
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  include/linux/phy/phy.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 456d21c67e4f..7e10761303fc 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -39,6 +39,7 @@ enum phy_mode {
>  	PHY_MODE_UFS_HS_B,
>  	PHY_MODE_PCIE,
>  	PHY_MODE_ETHERNET,
> +	PHY_MODE_ETHERNET_PHY,
>  	PHY_MODE_MIPI_DPHY,
>  	PHY_MODE_SATA,
>  	PHY_MODE_LVDS,
