Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8C6769A32
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjGaO61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGaO6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:58:25 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A24A120;
        Mon, 31 Jul 2023 07:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2yY2eN5uaup1EJl7E5Xlv9ZALZSN00CS4B8QdyYxbw2y2pAFczE1ldesp7iPs/os+OT3CEeRud404lHmkBYslMXVhwz2gd8QKGXVl7wFzkKYB1rcN4DgjmHzetQdIyJupGDUtwx+P///u9NpeBM9o1cEhKkA46UnbaNKydtv/1gonL9eCHNoapbTt1vgjuIJQvRtsrdg50297/UClExZil5qT9vN5keV6ITapvmPvzsH8H/BHl2aJ9povjigXU/eSoeNBs6Un9MS+4wTrB3VNWdLGxgzEvYV9BePz5a4xDg98dZiKff0PaoIw34qRvH4MUQ7wu0XoXbosTJ/yFn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dyan4Z/Pxj5N3ADMEm+8FP5qKTkuZfJuZ2DYbASgjrk=;
 b=i5ocDeQ3OKTUqUHmbm9NuqsxrpxePJaNRHDz5Pkh5H+9cxAxxJ3orEFQd5W12MSms5XDVHbggPh1vdbtPPJvfoZ6I3LGT2m4H1dp4npazKwzGU9lY12iwbSzRufjS5a49vr6NlzgKhcKLLdRUZPOPaw8XjdAITCQix+lcHnr+tL8E5bAE1c/v1mV7gcuEasLonx48j7SOvurQRe4WmhUi0ITxOHZvlxBkckfCPZHyf8AaevJDj8Tj1Oo6m0uD9JvS6pNEIUmeC2n7VdKDcdZ4A2qYT8oYgBAJoKl1xZjERmSgP/cDdvrD6/tLO/KKwhMRcpvL8mye+BRqlHSHBd8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dyan4Z/Pxj5N3ADMEm+8FP5qKTkuZfJuZ2DYbASgjrk=;
 b=com7aHH/DiU1GOHxjMTZY1NINBlMQT5ocPMvr/GnwQSl18pM5S9o7XLFViybkwgsBTntAkcYwOEKX5IbUKZxFqfCwuANZMncoNveF4ge88VOyO3vIMNlPiZahJzO/lK13Sa3bCEF6n7S3v1aqyw2CoRLGAoyjLlPgM8STCGVTb0=
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com (2603:10a6:208:145::23)
 by AM9PR04MB8729.eurprd04.prod.outlook.com (2603:10a6:20b:43c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 14:58:21 +0000
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::75f9:a3c:a9ef:7bac]) by AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::75f9:a3c:a9ef:7bac%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 14:58:21 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        David Bauer <mail@david-bauer.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Wei Fang <wei.fang@nxp.com>
Subject: RE: [PATCH v3 1/2] net: phy: at803x: fix the wol setting functions
Thread-Topic: [PATCH v3 1/2] net: phy: at803x: fix the wol setting functions
Thread-Index: AQHZwZ33oD8fGtEVxE+PIFQQ7nRsG6/QZg0AgAOSwaA=
Date:   Mon, 31 Jul 2023 14:58:21 +0000
Message-ID: <AM0PR04MB6289323F6F93E197103A225D8F05A@AM0PR04MB6289.eurprd04.prod.outlook.com>
References: <20230728215320.31801-1-leoyang.li@nxp.com>
 <20230728215320.31801-2-leoyang.li@nxp.com>
 <8071d8c5-1da3-47a0-9da2-a64ee80db6e5@lunn.ch>
In-Reply-To: <8071d8c5-1da3-47a0-9da2-a64ee80db6e5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6289:EE_|AM9PR04MB8729:EE_
x-ms-office365-filtering-correlation-id: a82c720c-748f-476d-cfe6-08db91d6955d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UsCRv2R1eKVSI50p10mkVo+28844n0U2hgp/26My4BEr/1RiXgSnqp0lrygmgxiDjNlNMb0meXi1sfIXgwVHcahtlLkg1ZKaD8C0JQbH6z6netvmGvcNc8FkehvrjPs4lBgO7W/gSKrMVAi+RParsRnRIEFP0+ovYgYNdFJpoIY+YBKn/K8KBvA4TKmGyXazdB7kvJvd+NT4AAMD0iOvfDXh6z6Sr7YdGlpnSEQTnGlBOkL5CSIkAaxW61YDpTksKF4Ixa/ILI2HKxYFlp26eBFMoThhip+lxLqUebt5LKRDWLYRHppKyOSiKPimizOLP7dJ6O/EQZSqV8ck0Z396LjH7xNIlcw05O1L9B0ft0LO+ou2DnhlMsUOhdJTf6dc9ptZ7uims403CCCbV8M4WjXCdMfYzvAHUineRn9tctcqcPguuFXIsZD8h4PqHNnsChu8b7ZSN/1+VcPVGzDB6zGqssJfjCECpdNbV7L+OwQ27+WM+VP6BE4M5oEqt3VjZr2c8eP5NAqaKN9nTCdKM0FD7EyMPzq2/xbgs0dpAPyXU+Sz+3P2/gDZUsDO9ieLmGJ5TRaoOo9ZAfPo1qbejsBDkj7DYuWCfSyFjLRp9kwpOYYA3YoBeZj1fYiOD556
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6289.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(8936002)(8676002)(26005)(54906003)(41300700001)(316002)(6916009)(9686003)(4326008)(5660300002)(186003)(55236004)(52536014)(6506007)(7696005)(71200400001)(66476007)(66556008)(478600001)(66946007)(76116006)(66446008)(64756008)(53546011)(33656002)(86362001)(38070700005)(83380400001)(2906002)(38100700002)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3Yr80xewpWOmMjcbIpH1mx/HVDQRfC5lnYiUYvSgpIZmKKHNwH0hRillTWRY?=
 =?us-ascii?Q?Fz+9/ztM5E2bH7DTT2R+dbCyVtP6VaXcCLfjG92k2c/qcHc86QUDdHoETD+U?=
 =?us-ascii?Q?Pck7MoIdgt52Fq+3P04fN7ljThbqn297z5mTnOG7xiaCjqZfbfBFxQHfxKJK?=
 =?us-ascii?Q?xtN/FIiWmQlyldCaH5sO+J3qHv/hY4tl0Q2W+GcbL7wKwWY2/mBYk7LWdUf0?=
 =?us-ascii?Q?Q0WGq1+uai26ijYlM1VgLDAgU1KLpSeWDJbtqV28mpIU6+R9Fv4inkMD0y2X?=
 =?us-ascii?Q?bUVp5neWIz6U+Lhjym5hT245ByFdd+Ty/iDj7KMkhDQnhnL1LEJkoFkUuRXz?=
 =?us-ascii?Q?QCGWz+qvcOtER3vEtHInUfxXJvbNGiSFMmBPc6vTsg7c5LtBJsYVRTCNft8U?=
 =?us-ascii?Q?CYT1ft09zHsqDDNAtPXNYMENSPMA+2zFp81CI2WxDtOpj4ZovYcrbmy5Il1F?=
 =?us-ascii?Q?J6EKA8zfYz/lmrRU2UZ1pFDvDjl5Zxy8awryK+Kz4VQjPwBC7GrV7LA25SDR?=
 =?us-ascii?Q?vj0fTld8JaOVsgXcy7UP27FtZErBuHHSY3tP9/KU0iovJU5kpqD8eaTwsC2f?=
 =?us-ascii?Q?sIt/ch4fssDfPXXXjXnWQ2IAKFshK9pEJanOUaga55QbMwSzdO2z/wd6s26H?=
 =?us-ascii?Q?TGyG9fMzt2JzbCrDnnOlH3UeRsdqGBNI6WMkf3m6uzPhhLVJa/+Tk20dT6Lh?=
 =?us-ascii?Q?lX0NRw9roC3XRVgVsOQ9nM5n5PHjB9YOh4MqqstC0YvSzEGuOdXXKZ47g0IK?=
 =?us-ascii?Q?tHwfj9x9RgVOdL+z111Tjd0t8dkT5EHtXLJf5RTwqF12HAp1jP7eBKWn2eOn?=
 =?us-ascii?Q?rZzyzmLtUQkY0G73bm7Zlm8+ct4M2dCevLfEIuIdhFHX+s4o6syc2Phk4+tq?=
 =?us-ascii?Q?dzn0oAT11WpD/5GnFLixgn7pYHPLkliJwroKTgS5Z+mOap6RNs39bj/v7P82?=
 =?us-ascii?Q?BwtqAyGVLcbdOn6yw7iClNMoe2mOBiteQwo58+4wH7EP4SBZGMGHdpvn/cUG?=
 =?us-ascii?Q?yCASDDr7Tk8mejEodfSpHtLwjNgT8IU5OoXpyW1uoUAVRbqAtTLEH9/138b6?=
 =?us-ascii?Q?AUzAoCdDhMxZpSe9kiVZdOZ8+yr9eMCW4SQ9ofGf69HwYUv0t9QbsMLR704Y?=
 =?us-ascii?Q?jS0Hiq0l1F+7w6+DCCGhYorDUf+Rm+2YSBjCACA17vSKCY3K8mAzM1CzQLBn?=
 =?us-ascii?Q?S8qYLv1yez7Hns47eUsQ7BYMJK+5IPPbd0CyzaTNI0Ellp7/w7cE0u7WNDEA?=
 =?us-ascii?Q?Ga/fKlUVzGK0kVFlQKWp+JOjPVeMqEZ2q0rIcDmTTR+y/f/3NdG6DrraYOdD?=
 =?us-ascii?Q?hTybfNbQZwVWi+O2iOpc6ShrGTneGOv0bxEYkocK0eTErx3hVOv1NiAhQQ9Y?=
 =?us-ascii?Q?HDgqCmmiB2EdhieALfwPzycahayJSgAnDG1tmXXvazq3zu8C16EPp0D9zuWU?=
 =?us-ascii?Q?caUSc+ERiA3jI8QOV97YooMW8ldk++n1NNR5/M2lFABSZpJlZmy8ti4OKO2X?=
 =?us-ascii?Q?xyfiRO2jXREDmyUflMoBdiwwazikcgTTggvu5hF5Duh0DXGUUW7Ayo9uEymx?=
 =?us-ascii?Q?d158JPphPKBbdo8avAo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6289.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82c720c-748f-476d-cfe6-08db91d6955d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 14:58:21.7820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PUhKDXAQIkUvfPTMdI8kuDi/geKtzvNP6f5h42qVvduVAOmlBe+PIMaRQ9l7WDxdD8nHWMzZUwCXFOBkmCHKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8729
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Saturday, July 29, 2023 3:14 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>; Russell King
> <linux@armlinux.org.uk>; David S . Miller <davem@davemloft.net>; Jakub
> Kicinski <kuba@kernel.org>; David Bauer <mail@david-bauer.net>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Viorel Suman
> <viorel.suman@nxp.com>; Wei Fang <wei.fang@nxp.com>
> Subject: Re: [PATCH v3 1/2] net: phy: at803x: fix the wol setting functio=
ns
>=20
> On Fri, Jul 28, 2023 at 04:53:19PM -0500, Li Yang wrote:
> > In commit 7beecaf7d507 ("net: phy: at803x: improve the WOL feature"),
> > it seems not correct to use a wol_en bit in a 1588 Control Register
> > which is only available on AR8031/AR8033(share the same phy_id) to
> > determine if WoL is enabled.  Change it back to use
> > AT803X_INTR_ENABLE_WOL for determining the WoL status which is
> > applicable on all chips supporting wol. Also update the
> > at803x_set_wol() function to only update the 1588 register on chips hav=
ing
> it.
>=20
> Do chips which do not have the 1588 register not have WoL? Or WoL
> hardware is always enabled, but you still need to enable the interrupt.

Some of them do and some don't, which is removed in the other patch from th=
e series.  Since I don't find the register to enable it, I guess it always =
enabled.

>=20
> Have you tested on a range of PHY? It might be better to split this patch=
 up a
> bit. If it causes regressions, having smaller patches can make it easier =
to find
> which change broken it.

No, I only have AR8035 to test with.  Changes for other chips are according=
 to the datasheet.  It would be good if others having the hardware can test=
 it too.

The problem right now on our board with AR8035 is that it gets the wrong Wo=
L setting and fails to enter sleep:
[  354.196156] Qualcomm Atheros AR8035 0x0000000008b96000:02: PM: dpm_run_c=
allback(): mdio_bus_phy_suspend+0x0/0x110 returns -16
[  354.196172] Qualcomm Atheros AR8035 0x0000000008b96000:02: PM: failed to=
 suspend: error -16

Regards,
Leo
