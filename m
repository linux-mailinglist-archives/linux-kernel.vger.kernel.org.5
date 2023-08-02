Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7589876D708
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjHBSn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjHBSnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:43:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2E92D5A;
        Wed,  2 Aug 2023 11:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+qvrzd4rR1KlPWPGoS6QMBaj0o27KirEU7lz15otmfFRSqR5MUfbi3HW+CsZzV9kKWZhKqAp6GSL1LoHyja2X+y/TQ+IX7/Z7n+veBz41UIZtK0ybyJBetLzYF5C2Raprceom3gJs9UejDfx6iXSXTKIQmTZJoNtDGmxrx0tq1RmhbxwyCgrdA6FQCFxNOiEBXpxv8pNUshSABmQvdexSnDoH4qwuEMrioMeZr7Ty+ZhhwsI9pIUYjGhcJR6rVqyR0Qr/qa1a+g71VFeko0+OHDSdVVTGjnP3wrZuS/q5owua1MF7wmvP0xkjeaMbrAMOVPjF3mrpoaGMkAraXMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRQC6ULHY03cBGnRVMxCNc788lEosZ9bre07CC6ZTVc=;
 b=VRW/3OcFYj+joaqyaMdS0giXRIxMS9az8SMLK1KVNz/MXLvlxL3w+LsLmCiB9rqdpDr7hUL4B0F4BocOFy9YyvFk+ngMxn0bczEZ9L1lnb23/g0/L2suz4mHWERWd1CHNrrBACTh1t25lK3ukZIGXhy1DW0717bnLf4TlcuaFXFserk+EHLg0JornSYUbed/4s7oEZYUN1+QSwaEpj9BI1DK8Zf8M/xxa4ginmqgI62W9y/NpPOjWdZSTjwgm+e7zewqcDMGKzaEoiQHfmTwYGuLaGK2bAfgjUZUn2HqJUZz+FUJAguAwYcErrRn1WDp01Ro9HNAZjcQ7yp026aBDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRQC6ULHY03cBGnRVMxCNc788lEosZ9bre07CC6ZTVc=;
 b=e0ch/U934yIlw6YWnw/X8EHWfK7q9gR1CrWjKhZX5RQIvAE8MwfGBwpDWqBo+05dq0+ZTwhuLfMtlHmyxV7LCoFCfsBkCTd4jhDWj3r/oCec5r/Xe2BeFrDcSrWYslxP88jplo/XYsOQ45KcQWOxhMg6rU0WgAwNlANKwljvBjo=
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com (2603:10a6:208:145::23)
 by DBBPR04MB7561.eurprd04.prod.outlook.com (2603:10a6:10:209::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 18:43:45 +0000
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::75f9:a3c:a9ef:7bac]) by AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::75f9:a3c:a9ef:7bac%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 18:43:45 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Russell King <linux@armlinux.org.uk>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        David Bauer <mail@david-bauer.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Wei Fang <wei.fang@nxp.com>
Subject: RE: [PATCH v3 1/2] net: phy: at803x: fix the wol setting functions
Thread-Topic: [PATCH v3 1/2] net: phy: at803x: fix the wol setting functions
Thread-Index: AQHZwZ33oD8fGtEVxE+PIFQQ7nRsG6/W0x4AgACIw/A=
Date:   Wed, 2 Aug 2023 18:43:44 +0000
Message-ID: <AM0PR04MB628950F03E423244198EFEF98F0BA@AM0PR04MB6289.eurprd04.prod.outlook.com>
References: <20230728215320.31801-1-leoyang.li@nxp.com>
 <20230728215320.31801-2-leoyang.li@nxp.com>
 <ZMouSluMSC+bIi9x@shell.armlinux.org.uk>
In-Reply-To: <ZMouSluMSC+bIi9x@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6289:EE_|DBBPR04MB7561:EE_
x-ms-office365-filtering-correlation-id: df9def24-e4b4-4edc-3516-08db93886695
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lwW1nZlEpKzr22khKFg74yUM7CW9JHYAZzH9q3+DynP3LH1UQsdzG+VPuJTTrT4ZWheOYcAf/1N5xXwFLdg8o7hj9aFXiiM64fygJD1y+8h+nbvF+esEOEzNqfdB5HjgBCbKQR9ds9wWEZzib17k3Kyx7hyXJrMqMdwMeDnUw5Z5m+iGU1k48RtEwFUjSl8m4uOzkUC6R4c3zQ0ET08k5LiC8lpyBI3MAAu5Ttjq0IKXqz1OhoFvLK0SJDLvnnejUSHoWe8FlyN79SfrQqpo55jwCEHcWgZMJEkiPJOgQxNIspIcztZmcVOGvOYXR0oB/Qor+yPsyPGynNsbf0iE+KZWIlI7ds5k5TuqDs9JMhwzrUB97latJIjYurUfaDicT+04QRjFfHjf4b2gJoBo+1KsGIghlGY9RUbo6QpJaS1fnHBU6o2IGFgQP+7C6rleM7jlbDQL7CfbEaN1/xxx/4O8Qkj9t5sN8/a/1HOannH1dPK161UEqpQMRhN3+Wr/DG5LgGnRcGqOB6CRV3/VTBJ3kzH37JxV+Q3qkIu+wPrTpgkje2iGkN6WrGibjFs8opzOpWGcIsH8kQHNP3KQ6wnXhWOttdl5pKDH9Aekgiq0e1CefeWR7RNjp21mYIuB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6289.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(55016003)(186003)(9686003)(316002)(86362001)(478600001)(54906003)(122000001)(38100700002)(66476007)(66556008)(66446008)(33656002)(66946007)(7696005)(71200400001)(76116006)(4326008)(6916009)(64756008)(55236004)(53546011)(6506007)(41300700001)(26005)(8676002)(52536014)(5660300002)(8936002)(2906002)(38070700005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qrpfrJnG3nLYhjPMtNISGKq1j3lMiAr75Pktu4ElsVtbTbYZyKVBZA0pBVWz?=
 =?us-ascii?Q?XLSvii+dXeBaeG1lNk7hNLQONxnPqCJj4MCAhrFW9HJFELSzo5vt2tSuvyOm?=
 =?us-ascii?Q?lpvHyJKv45iKMaZD8LIZjo55dw3Ya3cBMxNWscNRULOqNFTZq7/tyjJ+okjb?=
 =?us-ascii?Q?MVbJ2xMZEjiASvInTCJFSUgILU3sQwb/ZUmpUsfOGFsPZ0SiY3rV0L3EZiZW?=
 =?us-ascii?Q?SIFBaFwPyngrcxgGeJFQehEpvYtzL00obgARMZ3a6mJkmrJMMRsiTC8FUtud?=
 =?us-ascii?Q?ndD3n65FnedTUkwl+F2fB5Yzyz8I63soFTw7vYXc+rfz8udDePidpLUdPiRw?=
 =?us-ascii?Q?bUTz6+54MZl/YCKXFLrHwCiM82O+OeQcL3bL7owOxpxHHRNSc4mB7ORuz59f?=
 =?us-ascii?Q?FnB1D8DObWk0//fa5xFy3eyO+r+9T2z9fco8+xuk0y63rNCozgfIijTryiHN?=
 =?us-ascii?Q?ZTxeBqRxBxnkFx+GKU/ckwXe8mmvv6YheJl3foa49nNnLg8e9k/90NsFy/BC?=
 =?us-ascii?Q?6NvU+J0x745ur4FoL5OOtowmezpFFxrWC7XqaZ4AnmLYxsKoy6oLtgVfcZ5I?=
 =?us-ascii?Q?8vRiXiQaJH/sfvU5ePDBOyKzjP6NQyv7Z/mNajlcavx+oOT9vfQTTlTNej6q?=
 =?us-ascii?Q?dAc3bCEmo+X/zDxAZbQgubp6+bujFDWRthPv1paKsT32Pp9KiDVMD3L6PWEu?=
 =?us-ascii?Q?VOSIk4r/+yzJLbHaU2/vQZ54f/FJnNM2TuG2mbpGskdCJrEB0EViMCKfp8nA?=
 =?us-ascii?Q?fqgwFx4Ldf0usjEQ3F0Mrs1tYm4ZbvhTzvnmq0VFQGs6XDo7NQgqkVdApqnY?=
 =?us-ascii?Q?19LVtf5Qgml78raVzu/tJyKV4DxZR2Bag0/0VfU/GFMMIkymCoOCaIG5wO2T?=
 =?us-ascii?Q?Jtz7jtSXczbGwapkhCJrDA8y5zkYVVTXbM7RFbRplBD0N0UrWYNjMyG2UJhv?=
 =?us-ascii?Q?qkOXIObVi3Dm38A2Adr8tvM+v5IV9Z2GX4Xw6N/xFzP0VCeJ2EdCRrHhNcPt?=
 =?us-ascii?Q?Z6xVxkabMVTLmitfuSSS4iBTHLt/i8yRyHRBlOzsfmD1iiUFOC7QDPHyPOw1?=
 =?us-ascii?Q?T7jngAzilc9vcJS1IJK/Qu53pXDucGoaY3HyITXQoQqmnZIsCIM3L69LJwUh?=
 =?us-ascii?Q?zZQRNRbd+HebJGrU+unqVS0VsCJz72c+WJXi5BwQzF1NIbuXelr99x3ZPbg8?=
 =?us-ascii?Q?AhUdKzBeGX7Ns01djd6yFb0Vszh5ZQd/76ESQenC4c+t3pS63puPSHzy7ejq?=
 =?us-ascii?Q?V7cukksuu05qYLtHF2ngDjAFNuGPhb/XBY9mrIs01BJpaLodI2SMU6DcWTHv?=
 =?us-ascii?Q?dlh03FUekfuvi7pcYJ8OdpTdUiylencDDEOm2u52ScmdYSClOkaFx3x0HyDV?=
 =?us-ascii?Q?J4Pd+GfE0qk1RYfXkJk1XEsJR37a2hRaF9SU7UXWI2Q1XbnkSmB2uGC5pY2q?=
 =?us-ascii?Q?VFV8RQw5wSnAd8aRNst3AqNRwQiFPjitRKa8HLxevbKjY8l1iZfJJODByShS?=
 =?us-ascii?Q?okaphbV7oZ+00cI7xD5BAs5ayxn3BOQwyEbqNWyPOjdnAmFfhAS/7e730Arr?=
 =?us-ascii?Q?uqCDfrDVCpl0X86f/dU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6289.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9def24-e4b4-4edc-3516-08db93886695
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 18:43:44.8816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njW8Oz6N1So+3tr3HCYQL3haPbz0yIe4n+RoW3HbM2BO1o5L5DBgq7JNVZa/Fp5V0k0bb0rXkEBeXMBPyFA/OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7561
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Wednesday, August 2, 2023 5:22 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Andrew Lunn <andrew@lunn.ch>; Heiner Kallweit
> <hkallweit1@gmail.com>; David S . Miller <davem@davemloft.net>; Jakub
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
> > at803x_set_wol() function to only update the 1588 register on chips
> > having it.  After this change, disabling wol at probe from commit
> > d7cd5e06c9dd ("net: phy: at803x: disable WOL at probe") is no longer
> needed.  So that part is removed.
>=20
> Okay, having been through the AR8031, AR8033, and AR8035 datasheets that
> I have, this is what I've gathered:
>=20
> AR8031 and AR8033 are identical as far as WoL is concerned:
> 	In terms of hardware, these have a WOL_INT pin that is separate
> 	from the normal interrupt.
>=20
> 	MMD3 0x8012 (1588 register) bit 5 controls whether the WoL
> 	function is enabled or disabled. Defaults to enabled.
>=20
> 	BMCR in copper/fiber can be used to save more power.
>=20
> 	AR8035 details below also apply.
>=20
> AR8035:
> 	No WOL_INT pin.
>=20
> 	No MMD3 0x8012 register.
>=20
> 	WoL interrupt enable in C22 register 0x12 bit 0
> 	WoL interrupt status in C22 register 0x13 bit 0
> 	WoL MAC address programmed in MMD3 registers 0x804a (bits 47:32)
> 	0x804b (bits 31:16) and 0x804c (bits 15:0)
>=20
> So, what this means is that AR8035, the only possibility for WoL is via t=
he INT
> pin and the C22 interrupt enable/status registers.
>=20
> For AR8031 and AR8033, it depends how the hardware is wired.
>=20
> If WOL_INT is used to wake the system, then MMD3 0x8012 has to be used
> to enable or disable that functionality. From my reading of the datasheet=
s,
> WOL_INT is unaffected by the C22 interrupt enable register settings.
>=20
> If INT is used to wake the system, then it behaves the same as AR8035.
> However, the datasheet doesn't make it clear whether MMD3 0x8012 bit 5
> also has an effect - although I would lean more towards it having an effe=
ct.
>=20
> So, given that:
>=20
> > diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c index
> > c1f307d90518..1d61f7190367 100644
> > --- a/drivers/net/phy/at803x.c
> > +++ b/drivers/net/phy/at803x.c
> > @@ -459,21 +459,27 @@ static int at803x_set_wol(struct phy_device
> *phydev,
> >  			phy_write_mmd(phydev, MDIO_MMD_PCS,
> offsets[i],
> >  				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
> >
> > -		/* Enable WOL function */
> > -		ret =3D phy_modify_mmd(phydev, MDIO_MMD_PCS,
> AT803X_PHY_MMD3_WOL_CTRL,
> > -				0, AT803X_WOL_EN);
> > -		if (ret)
> > -			return ret;
> > +		/* Enable WOL function for 1588 */
> > +		if (phydev->drv->phy_id =3D=3D ATH8031_PHY_ID) {
> > +			ret =3D phy_modify_mmd(phydev, MDIO_MMD_PCS,
> > +					     AT803X_PHY_MMD3_WOL_CTRL,
> > +					     0, AT803X_WOL_EN);
> > +			if (ret)
> > +				return ret;
> > +		}
> >  		/* Enable WOL interrupt */
> >  		ret =3D phy_modify(phydev, AT803X_INTR_ENABLE, 0,
> AT803X_INTR_ENABLE_WOL);
> >  		if (ret)
> >  			return ret;
> >  	} else {
> > -		/* Disable WoL function */
> > -		ret =3D phy_modify_mmd(phydev, MDIO_MMD_PCS,
> AT803X_PHY_MMD3_WOL_CTRL,
> > -				AT803X_WOL_EN, 0);
> > -		if (ret)
> > -			return ret;
> > +		/* Disable WoL function for 1588 */
> > +		if (phydev->drv->phy_id =3D=3D ATH8031_PHY_ID) {
> > +			ret =3D phy_modify_mmd(phydev, MDIO_MMD_PCS,
> > +					     AT803X_PHY_MMD3_WOL_CTRL,
> > +					     AT803X_WOL_EN, 0);
> > +			if (ret)
> > +				return ret;
> > +		}
> >  		/* Disable WOL interrupt */
> >  		ret =3D phy_modify(phydev, AT803X_INTR_ENABLE,
> AT803X_INTR_ENABLE_WOL, 0);
> >  		if (ret)
> > @@ -508,11 +514,11 @@ static void at803x_get_wol(struct phy_device
> *phydev,
> >  	wol->supported =3D WAKE_MAGIC;
> >  	wol->wolopts =3D 0;
> >
> > -	value =3D phy_read_mmd(phydev, MDIO_MMD_PCS,
> AT803X_PHY_MMD3_WOL_CTRL);
> > +	value =3D phy_read(phydev, AT803X_INTR_ENABLE);
> >  	if (value < 0)
> >  		return;
> >
> > -	if (value & AT803X_WOL_EN)
> > +	if (value & AT803X_INTR_ENABLE_WOL)
> >  		wol->wolopts |=3D WAKE_MAGIC;
> >  }
> >
>=20
> The above all looks correct to me.
>=20
> > @@ -858,9 +864,6 @@ static int at803x_probe(struct phy_device *phydev)
> >  	if (phydev->drv->phy_id =3D=3D ATH8031_PHY_ID) {
> >  		int ccr =3D phy_read(phydev, AT803X_REG_CHIP_CONFIG);
> >  		int mode_cfg;
> > -		struct ethtool_wolinfo wol =3D {
> > -			.wolopts =3D 0,
> > -		};
> >
> >  		if (ccr < 0)
> >  			return ccr;
> > @@ -876,13 +879,6 @@ static int at803x_probe(struct phy_device *phydev)
> >  			priv->is_fiber =3D true;
> >  			break;
> >  		}
> > -
> > -		/* Disable WOL by default */
> > -		ret =3D at803x_set_wol(phydev, &wol);
> > -		if (ret < 0) {
> > -			phydev_err(phydev, "failed to disable WOL on
> probe: %d\n", ret);
> > -			return ret;
> > -		}
> >  	}
> >
> >  	return 0;
>=20
> This doesn't look correct to me, because in the case of AR8031 or
> AR8033 using WOL_INT, because MMD3 0x8012 bit 5 defaults on reset to
> being set, if we don't want WoL enabled after the PHY has been probed, we
> need to clear it.

The intent was to remove the code added by d7cd5e06c9d ("net: phy: at803x: =
disable WOL at probe") which claims to be needed after 7beecaf7d507b ("net:=
 phy: at803x: improve the WOL feature").  Since I have changed the behavior=
 back to before 7beecaf7d507b, it is natural that this part of d7cd5e06c9d =
is no longer needed.

But if we want MMD3 0x8012 bit 5 to be aligned with the WOL_INT on probe, w=
e probably just need to clear the bit for AR8031/8033 instead of calling th=
e set_wol for all chips.

Regards,
Leo
