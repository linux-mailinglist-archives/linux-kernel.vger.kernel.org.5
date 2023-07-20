Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2452575AA9C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjGTJ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjGTJ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:26:49 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4877646BF;
        Thu, 20 Jul 2023 02:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVBlB6UsPoAtPxvPeWaN0eFnn02CgJQ2sZycidgOnPn9rdF4tpLu6zQpj3T9oBsi3ZjqPUjtIDP066zSmV4rmOXIS1woDEH2OdvivW47bIcXhfSmtpXD/wPH7F+2s+Tk1Y2ulimt7NeU4LoJg8javJ0ANUX4Y+1JMkRMkz1isPlO2U25M/NIVHJvxfVIBVwamXTFZwie1WfncKk8xJb+GrhDKSqg0g/ILzd4/piko33HdYqyW/jxK1E0Gb7CtBBHMqM2OMni7Ym9XCqHavCOKYi0RRG68m7umy7I6XOwvwCBqnZbKTfpCeEjQoePX6Fg6xPy5Y8TWxiH0wyK7EGkug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=traBGbZrxZ7/jry7JutA+UtX1kD9CipyYn8ugT0N2zI=;
 b=WjhyZdpq2jT33N4vUgoDoxYHYyKk2cRaLsyNcNsOc1dEWo7o9bShyfeUEISxph5Ok+nbxWY3ywZRBwLmROLx9L5LZZtT7qn6NJEaf3/1fNaBRRlBVFY4SloPNa65+xgXyolI8kgNpqYlmFkqwFtufaIjEPPrSDRlxhGrHOQ36XqJoipdwPAQA1zj6HjOXEht8CLEw8eyjFq6SIk24ROMfEg3GJT3XBvqQiPfzARYIOgAUKp66YPsSbALRmW3HYerihBWFNgZs6WoSwPVUgjM27rV+u6xn5PIU2zBawZ+kXbAMLUIKMq9L8yI67wfYoYPZKPSDndlYvogi/o5JcSGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=traBGbZrxZ7/jry7JutA+UtX1kD9CipyYn8ugT0N2zI=;
 b=HlKKdJQrvmmum6eyhxzrYKH4KkN4wHFTl2i30n8lOpSrH1WHtO0LWY5m6W6z7XAvMOEfKWiukAOAssQeOUVmo2YvnloEkMIkVxwH6zN4stLmaAMJ27fp6K4dy74Whxo9yJ7pHumK4KNX5kxmy9yJMeJDezo3LxpYgS2L8mdAWVg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7810.eurprd04.prod.outlook.com (2603:10a6:20b:237::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 09:05:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:05:31 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] genpd: Makefile: build imx
Thread-Topic: [PATCH] genpd: Makefile: build imx
Thread-Index: AQHZuuaYltZ0jLCWxU2z3wIJ8tyEvq/CXNkQ
Date:   Thu, 20 Jul 2023 09:05:31 +0000
Message-ID: <DU0PR04MB941756683F9CDB9200C880C2883EA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230720085041.501344-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230720085041.501344-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM8PR04MB7810:EE_
x-ms-office365-filtering-correlation-id: ccf6526d-e36a-44ed-a2b3-08db8900781f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fT7hzuFohci0hdZS3gxcJ5tkUK0bKzTGkIhZNS0ExLo4ix5LJ5avMCCK9jQqoALWn8TdQg7+278BMPtokInrPjOeK/31bImzYAxwiHVKaQRabW4/jT/Imq2G7z0CVRoGpmnooGRSA/gTvoNl+NmnTQOOkHEvJWvM1kJuRDTD6EmKrOQQoMQXiiV4xTTgRHaRFJOCduEeK3FlQybxPvZgm3Do6ANezb8UQhp8t1E3sZAl6hDSTewwKbsz2j2wtMSGemhJ4yoHZOC7qSQfzulxTQiMDtAuXlMKLj4vlMQ8FwfbOCLj/5qWlDm9ywYFM941brkZZOzl0B5W+rn8cPax+citgrYOOIyA45Mv7tKcAF3oOXGWTIWidPnJ0KGPUaO219YO7zstV2oaXhYTtmoETg2/tcadG6t6w7LFTctUJHCWzYmeZ4MzZ4VSf2L5cQ5qFqOVx8BdQtj/FTdD72a/axR5gQ+YLNjQvS9FMtcWkirMBuxUkgM3SlnW18hNXvggDVUawXvErOSl0hG2Foe1C2qoZlrL2PsoOycdzSb3kos83PBxInFeTAjW68X5v/ywwzIGoePE3CWI6NJjMd8vuGv256xQbAEhE3Viw2x3biT0y6AUj8diS6NB8S1cxuX9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(4744005)(2906002)(38070700005)(86362001)(33656002)(122000001)(38100700002)(55016003)(26005)(186003)(110136005)(6506007)(41300700001)(9686003)(7696005)(4326008)(316002)(54906003)(71200400001)(76116006)(66556008)(66476007)(66446008)(64756008)(8936002)(8676002)(66946007)(44832011)(52536014)(478600001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q4WmVpxAXnZdIWXk+INwaiWaMd+ah6xI97Y7suMjMKfSA+tRbRnqvKcBlFem?=
 =?us-ascii?Q?oVVUT05T/n6qf/ChqWlsesEnjIaCE/kmnYV+LeUYZ3WAkP8x3A7MBZCLhRLX?=
 =?us-ascii?Q?oCEjUi71pzs5SPwdlE/PIH2q8GaCkpsWCARSrePcbDNDEBFsctAQG3YsXXKl?=
 =?us-ascii?Q?kYwctepF7zyGODcGuRM6ZTope8ojdZCUwJX/gd+7WJPQ21SrSVffRTV+sW9i?=
 =?us-ascii?Q?immow+Qfdzvekm/lLtCj5MnGakVj78ZftPpOowUmTtyEKWgneK6q94MvI19T?=
 =?us-ascii?Q?1h/A+XTXopADQIlwhRuGSMlqV5Wi1Y1YoXgljLUOMC0Z8Jh5nwysYi5Ou8CZ?=
 =?us-ascii?Q?ul0Ge6V3y/vGSKMrx1qOTHjYxqCOeNWA4vM59XPOzYaYXHoewkhwhm5swBlC?=
 =?us-ascii?Q?tGjzna0nMjihVe3f/uv2eEhJCjuL7K//X5zkxoUWBjcVfJ3Zrd8BGDC+rEod?=
 =?us-ascii?Q?fDzroVOVqDExxxvnGqwqOXQjQJdlXb9dTLFxP8HvvVI7hCR34rUOOHo49E71?=
 =?us-ascii?Q?oJx69Epi3iD+7u8mwQw7/8H25WPBbeZ798fjJQek1/ZAsQqCD3OIHMgevxb/?=
 =?us-ascii?Q?dYwPUqxP9hFePJ/4lxeU9tMF/gspqmYU5e3Oa9DGGm6+RCvjjfk5CknWjCIa?=
 =?us-ascii?Q?fa7QInBFT92S6hxcSVWkNf5R8+mFb6Mi0lDyakZtUTiZCB3tIqvurhsK2lGO?=
 =?us-ascii?Q?emWsKFqdVsS7jRE98Y6fc6QKy/DW62h5J4roN9wUDTfQA7PGgMVFEIj/pq4R?=
 =?us-ascii?Q?br5chB97lfTNmryuXFdEWXUzL61Qiee3N92bdDTBfnDoeie0gDLZF+Fa7lzJ?=
 =?us-ascii?Q?BD5CIpyL16IQyq7CqHbrtgWRxaf1+jybmHshJOb9OK2kp6UMbcbh2K8Coxgz?=
 =?us-ascii?Q?IC9034ThefPA2rdwebCR5wrKreOvmkOBNZqT0VnaV5DR8FzgjUA6zrxdk67v?=
 =?us-ascii?Q?2LZWc9wFgjPbuBFvx3R4P8f77LQnFOj6nUovCDqUYSdcbyPio9EkEvkd4zTI?=
 =?us-ascii?Q?30FRgjEvuo+HlMiuhQfJowix9WCRZdn/u1e1NfeDd3paKn4gwnQUKKeebY97?=
 =?us-ascii?Q?E8ka2qZa+7N6XMOa0CYJHjFgDEoDzGYNFYECgBXtx/FtjuN6vzylEHXe5nv5?=
 =?us-ascii?Q?YyaylXKO7cTFGE5ZY5T6uRunjwV0iMumJWP0NXLVnEGphC0PEhsBRssOVW/H?=
 =?us-ascii?Q?UxIeirggEis7nmvXzZQPZ3uW5yMe/X5xDc6H4nKtp5U3DOJ7T1WWIVgctr0G?=
 =?us-ascii?Q?CRpnafVZsc0EjPrtAsRz/aB6cnAS6DXF0AKGnb3OMMZdxoBtJMg2gPipMFOT?=
 =?us-ascii?Q?type9T2cwpNJHzW/IsY+/i4Izl8cxA7NRpNIslv0M1bC958Azji1LYn1plfz?=
 =?us-ascii?Q?GLath188grtJY8M89IukOkd59cd8WfGp4uH6onJkPmBeiptkN7DrzSFRACA5?=
 =?us-ascii?Q?cHn24pRq6s97wzH4fBBh8yrI2nQOKSoQYfnjXry7ezdKmgeeglNHO0P0GYz6?=
 =?us-ascii?Q?p6uCaUNauMsvyUgGmDof/Frv5b5XztAmx/2KdOQFS1A7RpiT35m4uGzbGD3H?=
 =?us-ascii?Q?yYVoCSqWds1/0aGm7/c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf6526d-e36a-44ed-a2b3-08db8900781f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 09:05:31.1043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbBRpocE6hNaJ42Iwn60MYlp2PN83VRFmyBOlfu51AodZH2CpnuJ/qXVhJBw4aW+geLUtPb7LEHnxK1VWV1D6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7810
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] genpd: Makefile: build imx

Drop this patch. V2 was out just now.

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> The imx genpd was missed to be built out, add it in Makefile
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/genpd/Makefile                   | 1 +
>  drivers/{firmware =3D> genpd}/imx/scu-pd.c | 0
>  2 files changed, 1 insertion(+)
>  rename drivers/{firmware =3D> genpd}/imx/scu-pd.c (100%)
>=20
> diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile index
> c429485c13f6..666753676e5c 100644
> --- a/drivers/genpd/Makefile
> +++ b/drivers/genpd/Makefile
> @@ -3,6 +3,7 @@ obj-y					+=3D actions/
>  obj-y					+=3D amlogic/
>  obj-y					+=3D apple/
>  obj-y					+=3D bcm/
> +obj-y					+=3D imx/
>  obj-y					+=3D mediatek/
>  obj-y					+=3D qcom/
>  obj-y					+=3D renesas/
> diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
> similarity index 100% rename from drivers/firmware/imx/scu-pd.c rename
> to drivers/genpd/imx/scu-pd.c
> --
> 2.37.1

