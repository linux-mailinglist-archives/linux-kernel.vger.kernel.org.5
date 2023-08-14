Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40C077B1B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjHNGgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjHNGgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:36:35 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA52E5D;
        Sun, 13 Aug 2023 23:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuFyG/ur1Km5RF6zzawl7od2hc8eLvxxEHcu5J9y6jA0talcoECzM3cehuNWK6n5lh9FKsUyXrF+Z/rW5S7HAbMU0uUxS+mgXnx/xzdH0h4F/IZpNCsuiAXb2pTGIhQZRbAhzb4xdQTQnmEVMIYzRtlfeCwdmWDxUs3IJzoQi/yQGD5btDNmwytQfXcwdQbhr9OsnRI6JEgFWPAqO1LsqMFEvS74G0S7BVJvIWeT56/uRsM0xdS9SjRQLNpUBATMRnN3p+vP18bFTh5+ZrGAN2vnF3MEV8DSw/RN5j+KeXm9d47R1j0ix1iEcALlX2k5VLmAUCyTc9uqKueWVmG9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlQ2L6ojf2F5WBCVU9WinSpkvSXQbjwKC5qGvBqpFhg=;
 b=XkTrSfUWXhiIj9ZpV6k+roi2S5DPI7fWvm4qm/x6UZHY+9+HzKxDkLu4IIaOQm/MTJnMcYh+NFC1SMwXgC3Ysbi3uMZti06p05vomaSG1t+n6XN7X2x4z3PT9dLuZCcZ4OYerbmt1DxZx9xfkWHkUtzFPgb8SykPsdD8a6x9REj1EplPcU4xd+WEodSZ2NfZsjTObeKvk55iDELvzswOxwR0sFNbOCsZmqoSXs39FVxbAn0a4VJcSWzbcwV03wJxemGeMWAuEICXMVO6hH7WpNzqAyGcg151VVy27a4+aRzd5SH/Ga/GGE9dYs3ha7wakBvhY/7yMjTFiFGt3q31xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlQ2L6ojf2F5WBCVU9WinSpkvSXQbjwKC5qGvBqpFhg=;
 b=Bj0+V5Ll/HnBgGCZ/+5QDb6XhyLus1bst/z5XJ7Tk9LbY8R1Iiv6M2D1Yjj3u88Wprr+PmowXO5YbWKCJf263UBPqsLFoeOSrAaEvT1Bb1f6ap71l/8i6D5MBDRi+GJdS33w1q1QtiEKIykgDb67Lq345BK0q6JRFKFwHOUIs6I=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 06:36:31 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1392:7c78:1b43:769f]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1392:7c78:1b43:769f%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 06:36:31 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] crypto: caam: fix unchecked return value error
Thread-Topic: [PATCH] crypto: caam: fix unchecked return value error
Thread-Index: AQHZyebilpxXMyMRNkuEfBm3sxlVsa/pX3eQ
Date:   Mon, 14 Aug 2023 06:36:31 +0000
Message-ID: <AM0PR04MB6004181BD078ABD918D4D008E717A@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230808105527.1707039-1-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230808105527.1707039-1-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|PA4PR04MB9566:EE_
x-ms-office365-filtering-correlation-id: 7e85866f-be15-448a-7a91-08db9c90cbe9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UBhS3mTlCYOW9kxjmOI4njN4rkMb9NXJ/dfgkTUWWGmxpCVCwNwwsoqgPUemHvbTHzgGE47sCB+dwfVlLgSlEmtzkxE1FuoOt1F806GY+k1FM93GhcUct4TOebYDM3tamXnfJZs0JU7yeSuVJUnctdN1gGK6KOQEZHGXvT8vfVP2hHZNOGRhM1V+enYY3mPq8IoczitGk6YUCz271NUhu2uIyDmbQd5rNEoIYIII29HdAxErdkd0MBlZ9Uk4sEL3jtBzW3zqXL8wQaDVuxsZwrIr9hZKMydRPpuRXR8OQiFSVyaTozFZUF1T4wHP5lKyjnaIA+fhhRrCAoI+4+1WbDFPoSDFnz69QtVHiHvN09RI/bpbv3hQYvNABw8vOtOGHHjkITKkIjwnZuEHDUZDxL3EAeUNZ21VNiENAzvEqvWp4y8u5OjwO4N3/29vgX0ufxpTkuQjenMWw8+jeeGef+8sH9+xqHiq6MpcmQlYcYyWXDBvR7hBqIlIgeD87FNDBmmNzKY5MIJOvrP2+sGB0wHUBP9JeUjYjFDI3FEHnjj8eIE9K4Syt9s6HnFN68GPoB27XZFHC57PZ8Eh3suA56Ya1e9YTdPGK9atRzdY8lI87rspSjIaOaZHiN0OgNC9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(39860400002)(366004)(186006)(1800799006)(451199021)(7696005)(9686003)(33656002)(71200400001)(86362001)(38070700005)(38100700002)(83380400001)(122000001)(26005)(6506007)(2906002)(55016003)(110136005)(478600001)(53546011)(55236004)(64756008)(8676002)(66556008)(66476007)(8936002)(52536014)(5660300002)(41300700001)(66446008)(66946007)(316002)(44832011)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0iJTVFbrMPvgjKcWM3LUpp5GZRuwF8BXM2XDQzm/A5dPF8Dd89EYYVJb0o1Q?=
 =?us-ascii?Q?19pjBn//W8C7DotLzNurDVa+c27OucuXj2cjTRrID58QQ+NrbSxOckCiJ7YN?=
 =?us-ascii?Q?8+r+lBHrTj+c058ZKowkfEXnDNW8K66GyMtmGbwWWWlGDDHB5aCXPVLt0p+U?=
 =?us-ascii?Q?v3HbCp9qF1IvFHAfhToFOX4ffvoTP8yKwpNK2tqPElSSdcTdkBp1SES91mLF?=
 =?us-ascii?Q?q8SDw8WNtQAtAvFAtR4/QTdEpr4O/s7J/JrWeThbOkl7wXe6L28vS/XrVXyT?=
 =?us-ascii?Q?zQfaCsDlqzk+dxHleTaXnZVz9KbBvdNYa20312NKdIyzbAazYF/PMrFyqBaq?=
 =?us-ascii?Q?nsjXlNUk7HN7LMcQLYO13gm+n7t4WH+3j+5lfEKeg1FEi9Os+6tq/+KOFSyV?=
 =?us-ascii?Q?dWh2rgZYDDCz/+y/4BSJhhOgQm/iytx17Uykx5Kheo79LKNR1yJ6ClKX0TAx?=
 =?us-ascii?Q?/tkIqB3am+LJfLK+4wTN4rInFoYBF+REPvrrI8YEr5FwzsK3wsfZpRlejVWw?=
 =?us-ascii?Q?Q/T4SFUhOK2RvAHfFm0Af7lk3EK9W+O/SkynTExEXBVHgjx0vmxmC8n3Prjl?=
 =?us-ascii?Q?TMNythuIqJWQWEUmLBQbySHEeSbO/3/ITfJCtjlIXTnc292S824MSKrtwqIN?=
 =?us-ascii?Q?b+3f843p1iCEgGsMBS+3mqFSwtwFKrMSrLXSgW9diWOD0kHnwVWdWN8k2GUo?=
 =?us-ascii?Q?ntRvKJsM5U4ei1+HZyIIHMwoCmIRXqWKSidqibhwSW1FBw8AqD/zG/suUIs9?=
 =?us-ascii?Q?bRpvwC9Vz36z3DAZw1SU3MWl55Y5W7SRwxh33RZse8JSW6ussJp44dBfRAjY?=
 =?us-ascii?Q?Z/xUKflcGxsru/Ev2AzqCGrpfHy5iByNIngtfO3NMnJmeNzwBeTnGuvmZu3V?=
 =?us-ascii?Q?nBGQqy85oArsZRwMUv2m7LtfflIbUqAKs1Z91BO/usL+gfsmShM7bnqJiTSO?=
 =?us-ascii?Q?TsziPKAVrwS7X+Ue9ZPwn7Ew2d9EGr/5AhphR1os/K1GuEqsABnpHeTXTCC9?=
 =?us-ascii?Q?WZDNctzshqTLZoIT4VwMsFUPVLmspb/5IRGqLDdEOsdahSc9YeySqjFzJyDv?=
 =?us-ascii?Q?SQSThb2kdjv42HAFrJn6gfU7xcoLbOxJeudN3AXYWUg2Ck3BXGsSWUPUqbrD?=
 =?us-ascii?Q?rvMtfex22c3Qo9/OymeGEUicWDbMji4YJorTIzAKKA6uXMEthqfZS8md8mUg?=
 =?us-ascii?Q?//DMAW4WuYnkS0/z05R77lk23qhxpoz9gUKxqJZstkfvGBL0OWboPeNCCCFI?=
 =?us-ascii?Q?B5oxtmVwa0x7PQj5br/Wox1p5qIkciXFY9o6QdhS+Ah7VxwuMNEPNsQdIjSf?=
 =?us-ascii?Q?nMnSmTFpfYAv8KpC6BDH1ml3yiiyoIWVABmxFaG16I2MzR1tKV0KlaDQd76g?=
 =?us-ascii?Q?RnMtesGkigZjCPbhdR+qrshhP1FcsJkG7UZB79qXi+QazqJgoF3XgWNiC3Qk?=
 =?us-ascii?Q?h4jiG15EUhQKjOQYGJvMy9VaFZXmi8c3h8FvXlmvu/+86brUlYpqCLC1UgZX?=
 =?us-ascii?Q?X+jbVsnNZ3AVjf25TN0RFrPET2nkiaJkB4A5ugoPqQtkj4cfI/iX/MgUAZFA?=
 =?us-ascii?Q?X5KAiJ5yibM9VY1a1VAd4uy6DGTJACvgZa+XRNf2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e85866f-be15-448a-7a91-08db9c90cbe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 06:36:31.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2G6nNt9fIFkc5JGQIlAfn5aZ7wfCZINHZl2pIrn8slfcRnHZ4VszQjA5C1QltBrOXRY2S9PmdETh0ltR4DqahA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>

> -----Original Message-----
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Sent: Tuesday, August 8, 2023 4:25 PM
> To: Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>;
> Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Subject: [PATCH] crypto: caam: fix unchecked return value error
>=20
> From: Gaurav Jain <gaurav.jain@nxp.com>
>=20
> error:
> Unchecked return value (CHECKED_RETURN)
> check_return: Calling sg_miter_next without checking return value
>=20
> fix:
> added check if(!sg_miter_next)
>=20
> Fixes: 8a2a0dd35f2e ("crypto: caam - strip input zeros from RSA input buf=
fer")
> Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> ---
>  drivers/crypto/caam/caampkc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.=
c
> index 72afc249d42f..7e08af751e4e 100644
> --- a/drivers/crypto/caam/caampkc.c
> +++ b/drivers/crypto/caam/caampkc.c
> @@ -225,7 +225,9 @@ static int caam_rsa_count_leading_zeros(struct
> scatterlist *sgl,
>  		if (len && *buff)
>  			break;
>=20
> -		sg_miter_next(&miter);
> +		if (!sg_miter_next(&miter))
> +			break;
> +
>  		buff =3D miter.addr;
>  		len =3D miter.length;
>=20
> --
> 2.25.1

