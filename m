Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C187E014B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjKCGkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjKCGku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:40:50 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990A9CA;
        Thu,  2 Nov 2023 23:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698993644; x=1730529644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0H8uF6uRphhgAW1p0wYu2vVQFz4P/6cLqDRwxZeXSFg=;
  b=rsnRsJjkZGqOkPWzUuNF4Um60pROJyxl/oy+CTCBkGYG90YVNtE8SkOP
   SMeYYIu/C6egBDe6qQQNwzkS+QO5F4C2s5VvQteYw+1ocfqd9mlOBsbTE
   YJ2We99u6esSgMwfTRcxdxpKUca7oaGksr0SyvfjzD+Vcd9LxZwvrX1j1
   fRG/3MZzkgqC/xy+DC5HfsGuiD2/zcm5r6thH+bhRxuv/Js0vFjzTUPsa
   mAmzQ8SPGetb5B7SSrhaCs8oP3aNapgDWQB0K5Lx49b/MNRJbmi3xPUqu
   QzTSG+K4oP+e2TC2JBEnHh+HkYiDHq6aC+nVzhszPp6uUga1QqbrBhsnR
   Q==;
X-CSE-ConnectionGUID: oXSkYV8YTcGmSNO/AeMgPA==
X-CSE-MsgGUID: fy1ME5LkS1uTBlyKzn0P3g==
X-IronPort-AV: E=Sophos;i="6.03,273,1694707200"; 
   d="scan'208";a="1450049"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2023 14:40:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHsLhJqtNQo+Gy/SQ0pk4PDIrb+OXXg3Ce6TlxyaBjelit/m9GaN8gpC8R1x/BKJgWREWNIwz+UDAfvAbPjohwtul1U/+NQLgKx3Zx7rsLCqJSqSAsUNg+tvtxi8Dgdqmsilf+tg5cIjOkR82rUDtxvmrkL4IpdfMYDQnMk0SP1DnYniHx/K1LgCa3g30uJWAoZoto/yeNtjID5WCvucEiSoOaeqSiVHBvJxmTZG8zAu4+8VtkhAhlAUoVdHNpUwRp20ZDBPd+Dc8ME1Vs8PB1JixjonXQdpDb3MhczRU9s/Wghy8fl6E6VZFZa2HoFoQaR/FQdiPKBegvbdSch+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JplVVXdViekdH5PgGZ7q3SPGySzB0BSBe9ChXVg3XI=;
 b=Nu3FLEk2TAj6WbYVeh0+FyDVdJ+xPo6DlCl1llVLTR754LAjXsUv2FGEnfuncxsvG7pyBCt9rIGRDLZg/u/fidA+Xoh0xaMMyjMRVDVKeIyMTnh7F+viE7gihdNDe1HAvUm82mzf5fSJfrWZQqjxA1heHjcfHp4y1i6UINIcqcJzdMcW0fWEw18PTZE4IcbzrBly4Kx4Mx0J2rOeuK383TsSSt9xo3V/0cCGjvJPaB9gOdqyHhd/YIjZN9mJPZyKVCvMXhn1QF+ZXQfjBeIZ867MmnDdDN9k6i6WmgMhskYFvAlzkaDb5DAVDjZIV79UmkNx7MkdUBj48os10AwZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JplVVXdViekdH5PgGZ7q3SPGySzB0BSBe9ChXVg3XI=;
 b=KSiuGLMENpN9rHhNLvF4VluylbTiGYwGygRpcnFB/kvGTjBTBG+6FEE581xnl1Ifcuf207TupOblEp6psPQqu0j1QAO2WCkRStyFO5764HSmQMmaZN0znPSNYokYqa6G0mzFe6hVTrTMQz4V/Kuj7E2HFoMznIcLV/0F+i2KNAo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH0PR04MB8034.namprd04.prod.outlook.com (2603:10b6:610:f8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 06:40:41 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%5]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 06:40:41 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dominique Martinet <dominique.martinet@atmark-techno.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alex Fetters <Alex.Fetters@garmin.com>
Subject: RE: [PATCH] Revert "mmc: core: Capture correct oemid-bits for eMMC
 cards"
Thread-Topic: [PATCH] Revert "mmc: core: Capture correct oemid-bits for eMMC
 cards"
Thread-Index: AQHaDe6wuGa60xkLQE+wyC+Jey7ipbBoJUEA
Date:   Fri, 3 Nov 2023 06:40:41 +0000
Message-ID: <DM6PR04MB657502AC388792B93D17E79DFCA5A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231103004220.1666641-1-asmadeus@codewreck.org>
In-Reply-To: <20231103004220.1666641-1-asmadeus@codewreck.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH0PR04MB8034:EE_
x-ms-office365-filtering-correlation-id: 2dfda5ec-e896-4989-0c7b-08dbdc37ccb3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cVREeU0JYIlQPdPlf2iLnzcpn/Q3Q9qG0BFSoNdZnBixYFEfLVmkmIoqObWi0pRVDIKqZqCCh0e5pZetlHNyy/IQ2ILiSC6pIy/0qM021ux4v6SwLyDsdn2s+qEfhOBJUiU15YJ7FDu9eTlsOA8U94+jhtwPmcG9SnODkV8iqjj6qmCm75gdb7gLX+G/pa81yWK0AAAU1RZ2iJkKjNmd7ppt1CWannvgT+1x/dffoh/UI7qeOyXcFIiLozfgp1Ha+65zHnZ3YUqdj256HyBypheR23RPDtZIbQGvNgiYJsgnA6miEYIT+PwSTkp9S2RPZ2fXvpj6+xOlH0tayInFZDgcjhKXlT5Ip2qb67pboBBT4bMnwjj9ukWvzEdJ8dhnTCUM+KfDdxmj0LonAnTUuhXNx5z6xqWRU6EDghAerBRcdAc1C35BFbFFjiEn4k5j5W/JC74ECknyYgAn+0bCSdzEzibiyD7luaonsUYAfaAH7ZEkmk7HZiWI8KddcNl4MW9wXgpzXH0zTSgxAq/l8eSHiHBFj7Lc2z30VoCuJO7AALxCjnDL1gUmNqsNIKDlS9c0M3jVAPuVehRMkvzE+CBz8WuL7coYk3BlzWWlD8iKDXJANs6iCMKCfXQj0UfJ5APA5JLwW9pJS5j7OeeR+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(71200400001)(122000001)(8936002)(26005)(38070700009)(2906002)(33656002)(41300700001)(8676002)(966005)(110136005)(86362001)(5660300002)(82960400001)(478600001)(54906003)(4326008)(76116006)(66446008)(66946007)(316002)(64756008)(66476007)(66556008)(52536014)(9686003)(6506007)(7696005)(55016003)(83380400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uZKOCArLMu0jdd8+07Naoe/6jfwP1OjsR4FqLXu7oO2ms4XemESlprSNraP4?=
 =?us-ascii?Q?9SAkFLruKktdwJe5eAFs5BPhqRGOuv1Il89pE0IxXcplIJ1RXbwXk1ytqcip?=
 =?us-ascii?Q?TyyBIDsv/Z2op31RewOpbuRqkkMopVZek32HpXO/x2wcW1CC0PSOgf/TYhA3?=
 =?us-ascii?Q?qKT/T9DQGBXn6Fa0MDe4qt4CsG9zaSaYI638sp0iwNCIMEFpjijhHke++isr?=
 =?us-ascii?Q?ajbAx/lf27Z8jWfEvskmndr3ZAzC1/mdie00RSIPeiqUP6wCPmuBOXtHYenj?=
 =?us-ascii?Q?f+tPWfwLG38yx7LVhACvJLk7y15Scv/TbsUrNmXKtoSkJVe9LANsLxBfGtju?=
 =?us-ascii?Q?KFOOySDNcAGQUVTRqwJTgisNGRV5vI99IFTWq4DKwdl2urNiS0sCGruMN+v8?=
 =?us-ascii?Q?rgxiJECVUCA3uYNm1wPyavhn6A6AXPzh3vKZqGK/Fn7+fiufkjLLd8/50LgH?=
 =?us-ascii?Q?gtdjxxk5Rf2ffHhXAbTqk+E+nCT5iHiXf8A5ncJ6Uf7d7DpNtpKZnpV/wDLp?=
 =?us-ascii?Q?NtJKDBKLNitUIhVjyEyYPH458A/UE88Wg4nugtR647Ae18c7cZFjm54tq+QD?=
 =?us-ascii?Q?qNyjybXA7sq9yd0Ou+nK3elWNws+yDLJeFHLeJbTLuL3riufGSLCV2UuAbvW?=
 =?us-ascii?Q?Y1xut5RbFgc9/wI+A+9XUZAnbVyXm+GOP1QlR9fstRKOqG2ZIBwxN0Ram8nX?=
 =?us-ascii?Q?x6hD2FiqN65zVmVa9Nx1bB1HAo4irtFzwYaP/s03SjxvXw/td6u3UCmpFgGK?=
 =?us-ascii?Q?VXUYWj1DVix3aW840grf2bMrMPvfhCbimXNFtT9kkworIgoMTI/Dee2pINl/?=
 =?us-ascii?Q?qtf77vAyCKKEcm7Ssx7sru5OaCU9su5VH7Twbq1zzsGzgSyPFLTc9DkyKdMK?=
 =?us-ascii?Q?QSlFfnjxbOcz6KqSM42b2swGC10gummCI9/wLG0IbzGA/yNhto6RayEkUeBf?=
 =?us-ascii?Q?oN+NbeDeYor3DM4nE+kYAo8/QZAvs18p0Vkl6Qzu0vRWFP1RRgpHmW4yznhe?=
 =?us-ascii?Q?IE8I1GKbfDZZNEEO1TnOnlH7QN1FC0JaIQDaaMnQKuA5MyT3njlLOzq4XPqA?=
 =?us-ascii?Q?atrgjDwfDwWQ4Pw8QFo4gBxQ3Va78lFCssdUcoOg/TKiS3eAr3W2PntcUg0/?=
 =?us-ascii?Q?g76gToLjXEa7Pah6Gjiysr5ZVc1APDF6Y8u5y0XWH3pTeqyFRRTTvUJI43gQ?=
 =?us-ascii?Q?BCg0xsl0KFwKAfxUlLAhMko9MKSAbAeB0MEXCmstVvMMSydqc1UBpNZ2miHW?=
 =?us-ascii?Q?waQRK9ZZAPLRIwHn782McbyAxLszK7natc4as2s6QDa6a1XJ3FGZ3NurWTrR?=
 =?us-ascii?Q?oIVayhaJyRp1NU55OcTbY9mlyPKmM4W0mdKIUsgHUnyIg14TzTdn+QFqTwpg?=
 =?us-ascii?Q?yPAFjhzIKbgnTOhmdCiQvFm5aZfc57OfuCiEovE76P1G2MR5RoRTIFVYngaG?=
 =?us-ascii?Q?KM3G7xewQu7Ntf0D9rmiCLJovuu3M/CVsvT3UQHt++cSx61XP8u1BeqXHc/0?=
 =?us-ascii?Q?/pV+fb0YbRi36j1+h4EDKh0rCQhX0+NIu0ds1x1eqzwgGoJeFQlQsNitt3gU?=
 =?us-ascii?Q?jsY3p9Uj3SUL4uHJo7e0Najq2DYNWId7b87KsPMM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hiFTqCEX9n8Eo3R/ZO95E0rWJNzB+Ri9ZcdKhjlgkKs3d2Wo/NZlfSQ1DZ2XaDhwgifIk1pX9sLIO8H8ticrlELqdeZv5MJ0MxZn8XqLyQAT/W2KhH64THf30vGUwzlzBMbUvjOgeT1IuLR3YdJL16DbRaejbxTdM+3onPqiqRWRM9yVMl1ONegPSNkGBZ0qLTen1IzzyODCk6ReWxyETWqqKlHZ0cgEEd4OI8BruftXK+WUfKSosU8tX+VPLa2+ADPF8ij9JFWaA0bZyRDOoPCZ83hyzGa/+Do7VviAV6scWyaLalKwfKfrs7aV1iJaigw/ydSm8q67mCuVoF66exMXuDtz9+/MX01F6aR08JZVBPYqqLK1Vd8z3R3aRC4gOqeOwpi9eSQfCHFs8dw8P5e3uyDc0sMDVVQNrGUNumZFvA2S5Fes9WWzwnwkdbJZ/8I85BzquoTsHZSx8lpOorB8f5gheqKFfp9qSRNiR4v+ilWOT86KxokRJx3Lgg4sQrIpeyj4OjAPUzaGVyVIjLMU3xuz8J7se1pQNN/PeMBdx8DiR3+v1bccnQs6YOA94k9Rh8ZbhanE6G2cdiE58ZI+OVOPv4hmhLpGyoiMKxOkYQ81x4MClssiMacCMCclJI+bvO2EAyAP9ywWmmW4mgYe2spxnAQBHvoEDzPZtT3nPM8ndOavjugSk3rZQuooMznNakLqs4SuPlgZdv0MtD0Ld7t+uO9dKdbrytv48da3D44Um6KtozhztCuy39VQyjCI2T3VicQFKvEwAkR+GYFrPDTC9U9erRcwccnXBEWn6A86mzVN77fTGBl47N4YEkowrVMxNCbhoAx6ud9DKt8BlvV5Bp3/Cx2Irkgup7F9EeoxDJoh9WIE2Hn4EATUi7tQg/o8X/HFzG1RQrIiIRGLLYH55WUi59A51+7J1vU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfda5ec-e896-4989-0c7b-08dbdc37ccb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 06:40:41.8372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mRmE4t/z++4BqsL0kCKdC3PxI9d6L1EONtvgDYeUYVkQIlNvw7N0ZaWCAbPEMltrxQK5PTMrOSdPf/9/pqFxwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8034
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dominique Martinet <dominique.martinet@atmark-techno.com>
>=20
> This reverts commit 84ee19bffc9306128cd0f1c650e89767079efeff.
>=20
> The commit above made quirks with an OEMID fail to be applied, as they
> were checking card->cid.oemid for the full 16 bits defined in MMC_FIXUP
> macros but the field would only contain the bottom 8 bits.
>=20
> eMMC v5.1A might have bogus values in OEMID's higher bits so another fix
> will be made, but it has been decided to revert this until that is ready.
>=20
> Fixes: 84ee19bffc93 ("mmc: core: Capture correct oemid-bits for eMMC
> cards")
> Link: https://lkml.kernel.org/r/ZToJsSLHr8RnuTHz@codewreck.org
> Link:
> https://lkml.kernel.org/r/CAPDyKFqkKibcXnwjnhc3+W1iJBHLeqQ9BpcZrSwh
> W2u9K2oUtg@mail.gmail.com
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-
> techno.com>
> Cc: stable@vger.kernel.org
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Alex Fetters <Alex.Fetters@garmin.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
> Here's the revert as discussed in "mmc: truncate quirks' oemid to 8 bits"=
'
> patch thread.
> Feel free to ignore if you already have something, I just checked your -n=
ext
> branch quickly and might have missed it.
>=20
>  drivers/mmc/core/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> 4a4bab9aa726..89cd48fcec79 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -104,7 +104,7 @@ static int mmc_decode_cid(struct mmc_card *card)
>         case 3: /* MMC v3.1 - v3.3 */
>         case 4: /* MMC v4 */
>                 card->cid.manfid        =3D UNSTUFF_BITS(resp, 120, 8);
> -               card->cid.oemid         =3D UNSTUFF_BITS(resp, 104, 8);
> +               card->cid.oemid         =3D UNSTUFF_BITS(resp, 104, 16);
>                 card->cid.prod_name[0]  =3D UNSTUFF_BITS(resp, 96, 8);
>                 card->cid.prod_name[1]  =3D UNSTUFF_BITS(resp, 88, 8);
>                 card->cid.prod_name[2]  =3D UNSTUFF_BITS(resp, 80, 8);
> --
> 2.41.0

