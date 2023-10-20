Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043627D0A29
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376462AbjJTIBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376430AbjJTIBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:01:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC11E8;
        Fri, 20 Oct 2023 01:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697788906; x=1729324906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oqd07yIrxIuQ0QvB1T4gyq27DcPzJDkXSecaddr9D6Q=;
  b=j8l0qoGFKFy6SFvMO2/H2HRWIits6xHlUIpfkECH2BGsrZIs2o4HQ1Gw
   wCWb1iHIrwVhHyn/MoLvkQMi2HSM96gSaVsdTvq29RJkI8J01BBhM67sF
   YTudFnU8bmGqBiW6/pyFa3TLclv8A75kBpg+Z+vqyXH4TdH2wtLFzvAfX
   uvrWw2PUFPyPg8p9f+BJELsCpEj+k0J+sPZOia0aTUxH0Sr+MqB53d9rs
   EJNL3G3sHXTkDzQW6S6e9oS03Wczou8UQsvBRS10pkBpAx/uy6KaFeTZ6
   UkqByrSM6U6P3mIxTWk8Nx3KaXDv69o5kx8xqQhz/ljsOetEaHyIMHSHs
   w==;
X-CSE-ConnectionGUID: EKBj6w/PQ8iQ74+Rp3MVpQ==
X-CSE-MsgGUID: WPMCAcSKT7aVqvUlvf9rzw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="177475221"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2023 01:01:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 20 Oct 2023 01:01:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 20 Oct 2023 01:01:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsFhvjUBUj/O6/IkHd96lRTjML+2BuOvcxIYrSR22bf1ChO+/j28RwTUe6cJrPIU0oKE4Qty3aalETc+GZXekLN3uK3Kxf82DuaGu6HhcNazkUc8RhQZorKdrU2bK2+EekFQJalg4fvANV1/iKlGd3mVRugpzTttlPDhU7G2rxp6HszWYl27X9s0FZL4tFOB3QZBt4zsfup95dX7EJoode804pM/XpkdFqQrP+5QjZ/3CFq8E8ljfHbGqFMShY9JctnxiiSacybB9blee9Lx0JfwdrPHSgbSNXBP7oae9mWs1Rfty3Ng+RdY8359SNcNc5FVtXigLVredYY6yb2CAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68RRKUDkVodIdYEgrC78/+DlmLNIoAkfhh7ahPAW8RY=;
 b=gxdPCWHRLQG4QoM3Crb1LNCn9TipSpsgiMv1APEsqMh0b4pXJ772x1AfUcTuNmpsPV14chiniOWoPC0TrwqiuH9CGYFY8uOkE8LFU4pAXJSxDuN0ENDoQUr1ka7ZoHGQvYk63Z+8aYJnRnbipXIME7X2PhtdTkP0t00Ay3MOqtjQv4M/UFLA29PnSNrdrzKk8aAY+soL2uvXRYebdyDfF8OO7GfeUDM2+cCjuxh31ACvOdGB5eSZuUiwGFlgdrmVuI7nfqI7BTx2z2PVdBP8VSUHD2TRmoDHIWbUzLBrF1Kr5J7O6wQR3hdrZv1qfLF/1VHndUbWXl9X0xyxqRlFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68RRKUDkVodIdYEgrC78/+DlmLNIoAkfhh7ahPAW8RY=;
 b=AOOtyaoyMfca0Chz1WfheZguTKzvDCKHg3oPQaWSaXylqkFh1/PMIVZoh27e41u5bkmgxbbedkly5/1eVNBqZC8iC6K6H6yhRMnWQ/4nhNFnKUiXxxvAEdzrXb7Z+zCipaTqOwCovSD0z3QyinT0o+bZd21aogOHPkmyxiHMjd0=
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 20 Oct
 2023 08:01:22 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::ce5b:804c:a362:9b4]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::ce5b:804c:a362:9b4%5]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 08:01:22 +0000
From:   <Divya.Koppera@microchip.com>
To:     <o.rempel@pengutronix.de>, <Woojung.Huh@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <hkallweit1@gmail.com>
CC:     <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
        <alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH net-next v3 2/2] net: phy: micrel: Fix forced link mode
 for KSZ886X switches
Thread-Topic: [PATCH net-next v3 2/2] net: phy: micrel: Fix forced link mode
 for KSZ886X switches
Thread-Index: AQHaAn2QgWXv9I3krEavaf/+aefoYbBSUeXA
Date:   Fri, 20 Oct 2023 08:01:21 +0000
Message-ID: <CO1PR11MB47717FCDC67AF14C5EA27C37E2DBA@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20231019111459.1000218-1-o.rempel@pengutronix.de>
 <20231019111459.1000218-3-o.rempel@pengutronix.de>
In-Reply-To: <20231019111459.1000218-3-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|LV8PR11MB8509:EE_
x-ms-office365-filtering-correlation-id: a94bbc01-a191-4faa-72d5-08dbd142bfdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nd4YbMxI3QSPxhaWthcD996joeRHan5jfVnu6SwzxUniVp78V+60uEbeUS6jbd1Pl0Zym5McewbVUw+gvMXxG7tiy4x/Cram2jqJoz18Kd5zhLBosuBReYB2sHTRH3ZviFz69f7LLr1R9n3tP771mmL+NzdOJa+48NUIhCi6ckSJYqopSDd1bpa5PNLsrxZtVbq11BMlGKXhuxFQsCGhlH6WLinIrz0VGIvTedU1KJill8qKeEBpMlf1jBzzijQZyLwb3ZvlmOrYw4u/2LdidCZD4Uz67ncaQ3z9SsamXFeqzijviZzq/f18FTsByXBhsFWMjBqNRPL3RVInrw8jJgkdfU+k6XMNnr3NxGF8/HhWbkBk02hZYeQuQSCaT1GKGRvirEZ6d9JZuu04dC3xaPPBFnAJmpCHgUEQ48qMKDSEqzNZmcsPs/hSO1ulFQMORwFL35J/wCS/zqNAbQIpZUgunomSWskBw1Ok8Ht8+nFqY6VHdUMDJywQBoFn1Aq8x1BrKC1oHU+pxism0f+S80IFZNazxUNidsLbgIm4XRIzlCCAGwJFt6idwuIAzXs69PvFCy5iGUhssaBBp2/oUHaaTKgyWGZdQwL1EnrKJEHarUgpCFEC/iAqS1fT9PjRGM0dZ4tvkMHeOKv7xaIN8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(38070700009)(921008)(2906002)(55016003)(64756008)(7416002)(8676002)(8936002)(5660300002)(9686003)(52536014)(4326008)(41300700001)(66556008)(54906003)(66446008)(110136005)(76116006)(66476007)(33656002)(478600001)(86362001)(38100700002)(53546011)(71200400001)(122000001)(316002)(7696005)(6506007)(66946007)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pPBB1lpHpAIrbi4Ny9G8AbNTpChvUTGouWpPPeWsaE/H+MBucmy9mpzWpwGE?=
 =?us-ascii?Q?X+SeqEw7VhhaJYnpOtDtxmebNgpdtEUSc3TIEtWMJeH5pSKo+hKmKzq7OtDJ?=
 =?us-ascii?Q?7GoBY5aflfEtDA5dCaujoMBoY1VezeDrosot2Sm4/KWRF7OTaTd8AVZnMt/k?=
 =?us-ascii?Q?I39tT1ba2uqXe2LOOHXQZ2zEEA/z3oztWm97lD3LEEKWLq7vdyLvgHE+xOVy?=
 =?us-ascii?Q?8K9y6fiZ95MQea089NCdslN35vlZMpJFGV9V2j7hoyShWXS3T6QpdlL31V4j?=
 =?us-ascii?Q?zXj8hlOlExys/hXyIULsmFEXjYugvhdVRtDpzW5jdarMlwxusNbsyujPpEs9?=
 =?us-ascii?Q?aWxEvx1MjWYG/t2oywKUJXyJtCth4CxA4hN//7uSgPRjEQdvi7bGTFC7J2nK?=
 =?us-ascii?Q?g8RjgxxZFrm9feHTolFa7pHP6FnRlzEXx+oUfdaUCQJzTOPZblQnStBuTnD3?=
 =?us-ascii?Q?M/4mjH+HNUpvRrfTGzT5OysK3ZVgXqMH7In6DlPFPvNoJJVtvvQ74ZxrbZVY?=
 =?us-ascii?Q?JuG4j3nR9Z1k++xnnyeetJrmEo2WvV6jz8sf9k2vrUIeQe6+vkE+pJbfwYN4?=
 =?us-ascii?Q?U/wDyJFU4Td+eT5wH17M0SmdIrBifmwhjEkszOZirE0ICeKn5BBmKyBDpUo2?=
 =?us-ascii?Q?49R8HUR2u2hiaITXFzoqFrRDRlFzWqQsVDVNTmF++z7z7mewLCxhl6j2X79u?=
 =?us-ascii?Q?vZYnGaFWbBeUB3R2Zu5w51pJf71VzTC9EFhNVTx3XRWO3+X6XZunrz2wSAbT?=
 =?us-ascii?Q?2pn9aCuWFZloGqhxLMydRJxHD0i4OeBNQPmLnTs3cyN/QUh9+FLqnzNvVGxd?=
 =?us-ascii?Q?JqDWQLU72V4/vxvbqwT3k8WuCSarErJidCnpUf1NMXYqZ4cs7Gtn3cUXFolp?=
 =?us-ascii?Q?i5AToqARYv5wEhXM/XOUXQOBIBgm73CgsTlDoMXbCMSV7cKplFTPFCjK/aQ0?=
 =?us-ascii?Q?qUjjZACRr8EMCS87elOupxIOSk9B7kr5o0eErT5B0GncylzuyuPBNODOQbIH?=
 =?us-ascii?Q?BgW3D4acKm3nJkKaZxeX7fqGUQHfiOhsqUsSnufZkPyKVsD2qLWMOwiiP/TG?=
 =?us-ascii?Q?rmfwlzRNlSEmPTWlO/xJ7AQDJVbBuKkDJ8BZ0ptujeLT2up5eOcB8LwGvAoR?=
 =?us-ascii?Q?IObfvkzzzL4du9BjyegkDu6903tbc9nPmidu00YvToJuROf+HWvDFKOzruYg?=
 =?us-ascii?Q?BcFjnRTXQranbf016qWvDUEG0nX4CXUbf8diXG+5I6k47f6Kf3WaafleWCMp?=
 =?us-ascii?Q?2bFlzAiO6rWpzaG9lc4347i0ZxJtwlzw8vLVP3QOI/SWz/KVMy+3UPZZ9odX?=
 =?us-ascii?Q?1K+lgF99AE6lodrW10QP32/ck9nlBWEd+AzxJM2d1sUUxG9IoNrGufOUb/yn?=
 =?us-ascii?Q?z+U455fPc2t7KnT+p1K6puUSHp3oXnHkyNYutKXxgiNag6PiGA2n6XiInhQo?=
 =?us-ascii?Q?lhvcUI+Ty9S/khXiuUE7fh2DwMedm8GqQ2TugXU2AZ8a5q84KDA/yPla7CKk?=
 =?us-ascii?Q?/pVQyhdrYD0DIERAMrYJN96zLulY1en+HIuparpOoVsBPE/3y8chj5x9vxdS?=
 =?us-ascii?Q?paBVhfUhZFbr/IBRqsbVL+y2VdaDY7D+CBK3l8q7suHInjlEYYJZATcbtXvJ?=
 =?us-ascii?Q?zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94bbc01-a191-4faa-72d5-08dbd142bfdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 08:01:22.0009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQfd9iSl5MP5fSLSEwlHFkteYbZM1hIHPrcqZC3PxH8IXQDlz9byT5gPDqeGF4Tj4EzsQqgzD0LNPcV4qwg/GlhhZ3R63yV4uDiD+CoBzIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8509
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Oleksij Rempel <o.rempel@pengutronix.de>
> Sent: Thursday, October 19, 2023 4:45 PM
> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; Andrew Lunn
> <andrew@lunn.ch>; Florian Fainelli <f.fainelli@gmail.com>; Vladimir Oltea=
n
> <olteanv@gmail.com>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel@pengutronix.de;
> linux-kernel@vger.kernel.org; Russell King <linux@armlinux.org.uk>;
> netdev@vger.kernel.org; Alexander Stein <alexander.stein@ew.tq-group.com>
> Subject: [PATCH net-next v3 2/2] net: phy: micrel: Fix forced link mode f=
or
> KSZ886X switches
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Address a link speed detection issue in KSZ886X PHY driver when in forced=
 link
> mode. Previously, link partners like "ASIX AX88772B"
> with KSZ8873 could fall back to 10Mbit instead of configured 100Mbit.
>=20
> The issue arises as KSZ886X PHY continues sending Fast Link Pulses (FLPs)
> even with autonegotiation off, misleading link partners in autoneg mode,
> leading to incorrect link speed detection.
>=20
> Now, when autonegotiation is disabled, the driver sets the link state for=
cefully
> using KSZ886X_CTRL_FORCE_LINK bit. This action, beyond just disabling
> autonegotiation, makes the PHY state more reliably detected by link partn=
ers
> using parallel detection, thus fixing the link speed misconfiguration.
>=20
> With autonegotiation enabled, link state is not forced, allowing proper
> autonegotiation process participation.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/micrel.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c index
> 927d3d54658e..08e3915001c3 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -1733,6 +1733,28 @@ static int ksz886x_config_aneg(struct phy_device
> *phydev)
>         if (ret)
>                 return ret;
>=20
> +       if (phydev->autoneg !=3D AUTONEG_ENABLE) {
> +               /* When autonegotation is disabled, we need to manually f=
orce
> +                * the link state. If we don't do this, the PHY will keep
> +                * sending Fast Link Pulses (FLPs) which are part of the
> +                * autonegotiation process. This is not desired when
> +                * autonegotiation is off.
> +                */
> +               ret =3D phy_set_bits(phydev, MII_KSZPHY_CTRL,
> +                                  KSZ886X_CTRL_FORCE_LINK);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               /* If we had previously forced the link state, we need to
> +                * clear KSZ886X_CTRL_FORCE_LINK bit now. Otherwise, the =
PHY
> +                * will not perform autonegotiation.
> +                */
> +               ret =3D phy_clear_bits(phydev, MII_KSZPHY_CTRL,
> +                                    KSZ886X_CTRL_FORCE_LINK);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         /* The MDI-X configuration is automatically changed by the PHY af=
ter
>          * switching from autoneg off to on. So, take MDI-X configuration=
 under
>          * own control and set it after autoneg configuration was done.
> --
> 2.39.2

Reviewed-by: Divya Koppera <divya.koppera@microchip.com>

