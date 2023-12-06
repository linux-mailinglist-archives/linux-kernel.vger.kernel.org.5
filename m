Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2443807676
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378131AbjLFRXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLFRXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:23:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA86CC3;
        Wed,  6 Dec 2023 09:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701883394; x=1733419394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hoPk5DjHDNN7ngBJZ65wXNCMvoqThxzFslm47zVNbg4=;
  b=zLUQAmdS+nvRDMOiycUxD6KS0+e8e3g3AIOsI/cIHml8b4aHRwC1ZGhZ
   IY+8BMkN7/DtB+xTRpAbS4tknNhKSMwxfTFqVcDXWmnF9ASy3Y1tVwl5Q
   ZdoXAE/eh0JbKfWbNBZU2yvW2DgJHKb56xi19ev8w9RcN40AQEtWsBwqm
   u87ehJPyqnZzKJStKmWCm+SkAxtsjgwDamHadtYilZkJT8qC3Y64SRLo0
   WtQjfpuV4gq8jkMqabQH0MyVLz9VNbuLPP7Tbpq01homxzesN5XWxtHVe
   MM1QsIPZ/DdamnTAtWCjw2pSj58mJW47uMaYLmRKtiy8b2J+ZTmiV6CbZ
   g==;
X-CSE-ConnectionGUID: XhDziRSWQKS37Ky+Ah4YpA==
X-CSE-MsgGUID: AupFpxXQQeupeeqB5V1Lcg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="12808188"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2023 10:23:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 10:23:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 10:23:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnyRmUw66ZGtdPyV3OhSjC7t7xGeOFOPQSOpVhsRO/MT645BexZNAwi4BtIhB8sMHx/tZykdC1fFt+QNE0No07w2EqAjBMSgCD6Q8+BUOPLIjYyWTtxkU8lf2ZAM/a2WdX4mSZgMYiShbte8w2jffagaRQiz/PRFQs1X5WcK0pEM27yvZ6W1A9ElRJjc+vD3/0DNnToxBaERNGsd8DkQrYnJ72uIFgzSVYYLnRdAqKQHmyMdkcxsjViZCwzbBRYUejnYsMsK7MgfARKsaoDwjHkUx7xkKVzH21xBQ4eTbYt3wzyjeo4VbRHp9xcTErHjQKxjujStGB0UecdUvasLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOnLfMCIH1LtpiSEGdWlQRehXPmkCyNuAOyavyUbD1g=;
 b=RfiCO3RoUQ06QjLO2q2ONQ6UisndTvksk9cdRyYZdCrKqsN+QbSWAoqEsU9s3GLFOIX2qWqPzen6RS+QGQN4s98eX7kojipic9XwT6Tkx/Rs07qXINmTQnPlhnpXx3epxV4Oiumx7nSc9FpMR7FFFU2FHm+WEWKOrS3PjCwUF26CkZgsCU53UBYVEcBFI6/7wjIGCsp5uaSt0Pzr5HcDk+GXkeCgawiVSjCrvWhU11eH6d60F5bA4UwbDBEiudhJrKq75ZDUJYwbU9M89db2tBEHvk2SviHbf2yA2led1ETLagFEfEmUtlafUOuuEHyKNhw8t18Rb3AjvQfEL4o/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOnLfMCIH1LtpiSEGdWlQRehXPmkCyNuAOyavyUbD1g=;
 b=XO/BC8xEWrTRiWkOrEtSdYrFwpvT5tYqLbaL5AoVwe+AN9jVJ9TXy60ciLbjtsTtPhbR6SCplkWBMWHzAWaSU/ZUt0xIgIBi34oEjrBJVBnL8k9FVTTPDwAY5/L+6mGtjEYAKgPltD90gi2CeIiNGRMRBzrctnDTxT1er+VdArLV7Gh2vZvbOsRffmhWvbnhHJGnJ9gLaEfgEFS7KBJZpLd/i+VVljtUGpwW68bGzwbdpLo57Vdgakt4bFUUCjOJnWCbjXDsgsEQ046oTVGHpx1ZHLrGB3k12QEHZdu8pKX0LH+ZQtDhMaKbRQUjps0uZTz7FPDRD9Qjz3p0pFJ6GQ==
Received: from DM6PR11MB4124.namprd11.prod.outlook.com (2603:10b6:5:4::13) by
 PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Wed, 6 Dec 2023 17:22:56 +0000
Received: from DM6PR11MB4124.namprd11.prod.outlook.com
 ([fe80::af51:1aed:6d1c:6d64]) by DM6PR11MB4124.namprd11.prod.outlook.com
 ([fe80::af51:1aed:6d1c:6d64%6]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 17:22:56 +0000
From:   <Madhuri.Sripada@microchip.com>
To:     <sean@geanix.com>, <Woojung.Huh@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <Arun.Ramadoss@microchip.com>, <ceggers@arri.de>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 net] net: dsa: microchip: provide a list of valid
 protocols for xmit handler
Thread-Topic: [PATCH v2 net] net: dsa: microchip: provide a list of valid
 protocols for xmit handler
Thread-Index: AQHaKBRhZLeoCpYepkqcVAzm+JG6R7CcgKEg
Date:   Wed, 6 Dec 2023 17:22:55 +0000
Message-ID: <DM6PR11MB4124D98726836442169C2C55E184A@DM6PR11MB4124.namprd11.prod.outlook.com>
References: <20231206071655.1626479-1-sean@geanix.com>
In-Reply-To: <20231206071655.1626479-1-sean@geanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4124:EE_|PH8PR11MB6804:EE_
x-ms-office365-filtering-correlation-id: 9f86a7a9-5eef-48cb-eb64-08dbf67ffc6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mxaiNqH3XdW5QNwmdtCnRvpxqdqOoSSCKTOrMX9JIWs0s0lQq3I/KDlsbsa8Od2a37LwAyJkjSR6nh9zTiQnpW6kcaJU6uKqC3pg8RawTvL2LZhtVR0Z4khWwlEDk00c0Pf2hnnh17isia1JkvDW+FEuCUyQzE1NvYFlglAM2DlM7al3pWJFQoUCoYnZP/8d68Z58uZ40nVczV5RoJneGM7e04OCCsVWdyP2wbAq7KYjGkRawRv7sopDyYiiwYPx7K81beBwRA3pRu+nI6jIPobSl6aNAyM9T48wGmx2CmRjC9LO43afMgjXOREHhUUtPjY0xcjBKpmIBqZ0Bu/7n986WBSDhdmRkArVjtIts2tWWG1QQpVHj707e6RlRu68C1KZWdipVlI0SixOHyp9Y2yNVbtLtwTAFiw/+AusHsU/eshSaTzm861EIdzo7JE+vPg74++xj7ubsAWuqeOEZDE5RFuMZB+cykNPg10XCpZavw56iHLIvqva/JMlWzjcRUDvMu9fxWAXZPpFuVBqCpznJTMKQtN76b+GtkicW59INvmmAc3nwCQPn1bugVvbVIoqYZMqcfzt/gnvXzqvLHDlNAr99Xgq+8BaCnluHJ4SBTVEDMxw+jwiXwsJep09Fy7W6uav1sTqbZfwO3DJDoTlG4zV4HUXKDY0FldCUZM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4124.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(122000001)(38100700002)(55016003)(7696005)(71200400001)(53546011)(9686003)(6506007)(966005)(478600001)(110136005)(54906003)(64756008)(66946007)(66446008)(66556008)(66476007)(316002)(26005)(83380400001)(4326008)(8676002)(8936002)(76116006)(5660300002)(7416002)(52536014)(921008)(2906002)(33656002)(38070700009)(41300700001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ky33LOPRgDMERNTKYggubkeib6En+i9mrn2Eko67Gv/LuYqYcz2j8okIHoQc?=
 =?us-ascii?Q?ep2+M42by9i4eDZnGp8NuDjfoz61tYyULydGt67oj7uAVDjidaBKhxd+Sd2k?=
 =?us-ascii?Q?+Pen9lCJSKcvAtlo49YANPJQycvT+nguNCBX0ZgBaMYKb1HuVtgr9s6NNDkD?=
 =?us-ascii?Q?LVMnUcK/IcUi2oGIS5dJ2xThqi/cl1IAyrLEpvKdOAbls+6I7BGYIC6GkvkS?=
 =?us-ascii?Q?aIJ14xZkmk32jd1VLPGSSDHv3d6ARjfAh4MK4WnYlK1cdivBxUMxet11fX/w?=
 =?us-ascii?Q?Z3Y2dxFz9Rmt7TCvoY8dhlbZOQck6RvsQUUcNe8JxgIDSNQH9oTePith6eYI?=
 =?us-ascii?Q?kp4DQsIigsNUmo//6+vFEVgc5+iLyRDpaN7okzWfSs7zhVki2twUVBnSIPle?=
 =?us-ascii?Q?QdlEQ/4vvbuA882MkZ0MXFzCb7gwsnRVRtgMAnVjE+fmTzF1FVfOqtXJEI/3?=
 =?us-ascii?Q?sQJ4VdUfxRM31CtgCl+wKzHSxW9YaOzN4ZZjTIc4RrZ7e5BRh6Zltc5LTRp4?=
 =?us-ascii?Q?Bd/Kopky69K/e0uvvTAIOGsxT3ARp3FtgQghP27/tqtkrc8kmCnbzRKhdT1p?=
 =?us-ascii?Q?3/ibTLhvGxQudNg3oxzJ0kCqQ6/e+a76dhPzUHhjHU33ch3Ni7ux2RZrB4wl?=
 =?us-ascii?Q?r/4FNIQJQBsJ4jltUDeKzV+xoV3F2JYbehrwi5Ds/5elEp4sxgJujeBtQSkT?=
 =?us-ascii?Q?laiuVBUxxf9c9sDjlZ9pWYb2vBKv/6rgr6zQFUn6eAT4jntUodJKk0FOjo9o?=
 =?us-ascii?Q?ePu1/8FoXPMWnkRBX8NFYK6Qs7AnarCa8K1MY0LzG1hj+34yOwRDhqYWi6lN?=
 =?us-ascii?Q?odMTE8Crhtpq7LO7WbyHnxPqr1atnlOCsW4+fT5Hs50ZBoS+65RpNo/D7rTu?=
 =?us-ascii?Q?BiWcj5Mo2APZFTsCjKZ5Rm4HNm2WdyOPyzuWcih5wO6HiRhCSfLZZ4aQrCz1?=
 =?us-ascii?Q?w81WVO6UgFAEFW1DsC7L9skORuT051cg+WmU5xFV8TKpEvocTVjbHafjltZB?=
 =?us-ascii?Q?C/zK0xo2rh3nRI4oX7sHeuYA8xB3g03pzOTSgWgmy40J3zbYm3haRtKqy4Eu?=
 =?us-ascii?Q?W4SLwPk7tpBHb/JKSSd+QOyOnMkE+KS4R0w+cTejdRmQsx6wy+X+dopFv/Q0?=
 =?us-ascii?Q?iV/TWkXaowgj2wbVth1MVwb7FxQONUZaYQBtXN7wxBPK4UXPvK8Cowd92H9E?=
 =?us-ascii?Q?SYUB41D0nbIG6u3ZumhaL+twnHRKj5QDJiBmiYwSCiAF4lNwC35fuER5CACM?=
 =?us-ascii?Q?5WgEh3/Fv4n8jMmXvRPoQYYDfwCe0mv4MrKKzchMLUtufH0lJHMvzNY6D9Ho?=
 =?us-ascii?Q?c0vsEgtSOMIWrpRjxm5oRGjA0a8jxPedK/F4CyvfYrxnMKsmT7jxYHJM33Z1?=
 =?us-ascii?Q?tYwQLE2U5z3/Ly6VlNVrmVXAvIQpDQyx08XpP5mXg//552mwxLwjLNPWAS54?=
 =?us-ascii?Q?Poa4Vwn9jACuda5m/VkNMDKDaDX54GJGkpeNduBKlSvpop/O3cBm2Kr1+EGV?=
 =?us-ascii?Q?wezSg9VYy/qy7dcyrYaKQgnuJ3ldBOoaBlgU32duo6EgJZ40lO/B5RuN/qiW?=
 =?us-ascii?Q?54yd/Z4dmqjkfiCTAtxvU15/GXVc7HDaKOboST6ZErO0zD6HTHh16mpJMbg6?=
 =?us-ascii?Q?LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4124.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f86a7a9-5eef-48cb-eb64-08dbf67ffc6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 17:22:55.9503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3H3dItfloQBJg+zFZWrcHreM84s6MVvhJmySXZnxXvXgm4AluJxqXMcnAmzA40PrCH+CuIdwRtWuYkPAzrq/pyF8Wnlk4RpVfauuPIJoEmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> -----Original Message-----
> From: Sean Nyekjaer <sean@geanix.com>
> Sent: Wednesday, December 6, 2023 12:47 PM
> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; Andrew Lunn
> <andrew@lunn.ch>; Florian Fainelli <f.fainelli@gmail.com>; Vladimir Oltea=
n
> <olteanv@gmail.com>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Arun Ramadoss - I17769
> <Arun.Ramadoss@microchip.com>; Christian Eggers <ceggers@arri.de>
> Cc: Sean Nyekjaer <sean@geanix.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v2 net] net: dsa: microchip: provide a list of valid prot=
ocols for
> xmit handler
>=20
> [Some people who received this message don't often get email from
> sean@geanix.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Provide a list of valid protocols for which the driver will provide it's =
deferred
> xmit handler.
>=20
> When using DSA_TAG_PROTO_KSZ8795 protocol, it does not provide a
> "connect" method, therefor ksz_connect() is not allocating ksz_tagger_dat=
a.
>=20
> This avoids the following null pointer dereference:
>  ksz_connect_tag_protocol from dsa_register_switch+0x9ac/0xee0
> dsa_register_switch from ksz_switch_register+0x65c/0x828
> ksz_switch_register from ksz_spi_probe+0x11c/0x168  ksz_spi_probe from
> spi_probe+0x84/0xa8  spi_probe from really_probe+0xc8/0x2d8
>=20
> Fixes: ab32f56a4100 ("net: dsa: microchip: ptp: add packet transmission
> timestamping")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> https://lore.kernel.org/netdev/20231205124636.1345761-1-
> sean@geanix.com/#R
> Changes since v1:
>  - Provided a list of valid protocols
>=20
>  drivers/net/dsa/microchip/ksz_common.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c
> index 42db7679c360..286e20f340e5 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2624,10 +2624,18 @@ static int ksz_connect_tag_protocol(struct
> dsa_switch *ds,  {
>         struct ksz_tagger_data *tagger_data;
>=20
> -       tagger_data =3D ksz_tagger_data(ds);
> -       tagger_data->xmit_work_fn =3D ksz_port_deferred_xmit;
> -
> -       return 0;
> +       switch (proto) {
> +       case DSA_TAG_PROTO_KSZ8795:
> +               return 0;
> +       case DSA_TAG_PROTO_KSZ9893:
> +       case DSA_TAG_PROTO_KSZ9477:
> +       case DSA_TAG_PROTO_LAN937X:
> +               tagger_data =3D ksz_tagger_data(ds);
> +               tagger_data->xmit_work_fn =3D ksz_port_deferred_xmit;


NULL check is missing here.

> +               return 0;
> +       default:
> +               return -EPROTONOSUPPORT;
> +       }
>  }
>=20
>  static int ksz_port_vlan_filtering(struct dsa_switch *ds, int port,
> --
> 2.42.0

