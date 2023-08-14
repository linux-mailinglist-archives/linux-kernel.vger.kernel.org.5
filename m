Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125F977B1B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjHNGgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjHNGgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:36:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D33E63;
        Sun, 13 Aug 2023 23:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co/hUziuLPK+NRB9qgm7lvBoafcSnWOZPNZ84zPs1sYgSSlRSrx1smzpEND4iZxKI/lSdnEFhiG4bqaeV+pUWE5AOHBoMbnuV1vhAEbQV8tf31MyJzIjjAeJhdWK75NH5wcV1tb+SLlQmqEXPNZLwy7LtjcQmG+ef9DvWXlZBMX+1l3OI/WJPwJviXggbk//7KQcwKTc3+nM/+Fs1IyVYrxRbpadvcaBmqoucvoo/PQRJKMceI2SsN+JMoRuzq2UW4WMUV7HlbjkE+sGKfDiCBrGPVRfaIIrOUg8cafez1AFRMGX6JPLI7+a3dbotZWAEqdVS/xoOf5Nnt91X6huIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6taCWcz9eBXBrsc3n/VCLb/fmpjA4FKbNiy+2+YEbNk=;
 b=J+XjNrxJA9TzAA1a36b+JJJ3O5z5aBiwB5MGo9H20Ux2IldjfhVTCNxBqloe+/LJsGQ8N6QpzffHM2nTU5EKma9k0UMaLmEI1VQcCDnuagRA0u5bH0Fis5avQGiyT2PN36UAehx3975B1u9nGOGxpo6hwOMccLhW2ElVo6p0Hccw/+C+li59sU4qywFcR6qIjbZxU6clChbnuNEoySkaupOrR+H7SBCF3/zX/XnucYPL/dFLTOX0DyDumjCYLN8lqiaMFd6KDtI+b/vMap3yTcG73t+zxbQpz/HF94IL7Ot90yZRWd6kxTkb62rFeruO0+IgUx2bVuFfa0thhIhJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6taCWcz9eBXBrsc3n/VCLb/fmpjA4FKbNiy+2+YEbNk=;
 b=gplbY9/UZn2YJMI7GwF5SOMN7GUW6YxRrsLJE+w+3ARAHoae8Yn2iOvOm+Qv97LHoWlPDzW3E4ZqUH+DAlq7Apfpv24rRifAfkYuNVumiMclvQXDNGHKe8PyjUQuzbid4HspXWE6EnNs3Mfn0kGn0cZoP/Tvy7+H6Hdsrk+DBM8=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by PAWPR04MB9912.eurprd04.prod.outlook.com (2603:10a6:102:387::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 06:36:03 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1392:7c78:1b43:769f]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1392:7c78:1b43:769f%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 06:36:03 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: RE: [PATCH] crypto: caam - increase the domain of write memory
 barrier to full system
Thread-Topic: [PATCH] crypto: caam - increase the domain of write memory
 barrier to full system
Thread-Index: AQHZyebjZhlBXUXcS0OCogj503Wqn6/pX1mQ
Date:   Mon, 14 Aug 2023 06:36:03 +0000
Message-ID: <AM0PR04MB6004C29F992ACA290E63E687E717A@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230808105527.1707039-1-meenakshi.aggarwal@nxp.com>
 <20230808105527.1707039-2-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230808105527.1707039-2-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|PAWPR04MB9912:EE_
x-ms-office365-filtering-correlation-id: 0d30c39a-bc09-4a13-5e04-08db9c90bb6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RGF5T6HQNxPaon/jJUgOolYeeiorVRhES+umQgvWeaNvz0Rnrc5ENlwtaxfM5FpIxGkqWKtrkxPSOp/Ez2gZWOraFS931jqXdnVOj3xwgV6//X331+a7axIjzwGeGxpZ78H59WmW09PyHi5Q2A+RypBXNVJMoII7hztCOy3oywVuqyAwMyj43xUa2wxzQB1nTfFeyUHYG4Jun8o9EGLkxEzZQ3PkMUx6e2JbXP/Tby5vx81ivkIi9jzU04kXSeQZ9kHjuudniUWdWk0QM1vC7eOpzTVyWafaf/92MmIQ11ujnofFi9fwPBnZr2wDBX5ziqSkrxN2XUL3euVb8fvttdU3JNBHRF/moXwlEffxnlJkWl9v/jtTdYXLSIbmoUri7v7+EG4YfphrV17IOHB5AxOGFjVP/sBSGiDWNv92us34rBUQkhj/hMlvlrsmiwxiUm5nKxcVwlGFmjrVvbRYC5APkG7TzYA9+RCugL4tXr7obHdX532Rlbvn7Mbc12b1h3fRrOCMbENwM8o+I90DMtyY0JNoGypzojZXeZzqQf67ukUMghxVktICgSyWc0izrnzryGSddoNbBUdSMeXeIRjZUuyRH1gDU9jNy1EQjWnnfAvaYhGKTnlGQWroxofz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(1800799006)(186006)(451199021)(478600001)(71200400001)(110136005)(76116006)(6506007)(7696005)(26005)(55236004)(53546011)(9686003)(66946007)(2906002)(55016003)(8936002)(8676002)(66446008)(66476007)(66556008)(64756008)(316002)(4326008)(41300700001)(44832011)(52536014)(5660300002)(38100700002)(38070700005)(122000001)(86362001)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yeHj/o9tivkEIOliGK+sf6ScDyi+aiiwFt9C6qPnWOCY6lAenH4Yf4cCCNFk?=
 =?us-ascii?Q?B5c6f5PKGxKKOz8K7tOMq9jlmUBzuYJCt9UkfDSLu2Lt1bWLuDY5q9LaD1DR?=
 =?us-ascii?Q?8gGLva7EQdklcOMuZj8h8fJ5c+omFcbIqWgbRLIJaA8OCw+7vZUjR5hxtOeW?=
 =?us-ascii?Q?dGYdp3Uilc/XCqLrhiLkLoWY8u0fLP5Z4mdyGzm1jzThVfhXvAgR5WyP5umb?=
 =?us-ascii?Q?92IKD9Ov/HDdJNXsTW4YP99WV0GzmlsJCgpWTfUIFWiqYu1zm/oCHaYza+ef?=
 =?us-ascii?Q?R6LdsgrFQOHLc4Iq9vw2g9g9t2O3QTfw3H+bASHDJ5jPj1pKoYNNlGRRTQjT?=
 =?us-ascii?Q?Mett1bNBVuzTkCbNU9USzo6sLModNK+IVStzIjGDxpEuSgnZMm8rzH6RplmY?=
 =?us-ascii?Q?tp0jd4x45pZjZosG+/XX5F3R0BELR9PoQQIxoY3R+ShMIL2vgukLRUREbUVk?=
 =?us-ascii?Q?sPJ1EMDka5I7ao1fOG8TXHnOsh2H+oLtD2T2t7Lpp730d/nNpcYvb/tH5qRT?=
 =?us-ascii?Q?Voy2NoB+7tSsWgGY+pVnyrMC3ACrpNWM//18m+vlqaIlY+WLuRQdsiqM9Lpj?=
 =?us-ascii?Q?TzHIEEJuN4HCDw0bG+AoyARzp5HeR9SD6awi4JktJRWfp0EBZL+LVEv2o9JH?=
 =?us-ascii?Q?aM8oQAP/uI1t4iGTHAcSjJFqs4YAyQ23XONQ0DtQ+fEBqWa1QNOesBTAdPCs?=
 =?us-ascii?Q?yAoYpbOfOhOvSVYdz349gHnZY/FC/cR0yY6tAnazBc+gZKIxHkivjnnQAI/G?=
 =?us-ascii?Q?6iRHzsWOeP+3TqEK0EhZHACGJPjHPZPPvDBFrasN3If1LPk682+VVpTMIsj5?=
 =?us-ascii?Q?h6TrIkBXpsx/xSJmcQBlOXy3FF+KE6e5ZJZ7X9XMTK3rWY17hm12bfSVEEyU?=
 =?us-ascii?Q?UsQq/RDI881H0E+XdpW9G5s2hSwkw2qRCwJ4HzSgh/wK8M7+fBLt2HcPPrlw?=
 =?us-ascii?Q?NCooCRUZAGL8AIKkjVpVfGShPkQmVxIr8vVb95ceZKX3Wk3eo+J++3C1Cr9n?=
 =?us-ascii?Q?R+1DKYy7cDcntOHWYoTY73TlEtxFjFnqXeCvUx5zHgb5reGp7Ohq/qd4WpFO?=
 =?us-ascii?Q?I9KKU+IwTWW0/GIX1jSqOlBEY1dmEDuDe9bRshJmWpnVvP0RvoZm86zuD+xO?=
 =?us-ascii?Q?wEmMCAo+KbmIvEoWfoSIf9oCUqwAYJdcEh3BOZGcx8rENMu38FqvhYkS5ygQ?=
 =?us-ascii?Q?eN84NqJ+qYnk/J0gkWJbItijPnnfUsYs+GiIbEgdKnPzUs4a3pYHBEcrwsjt?=
 =?us-ascii?Q?nKQ2lb1m6Je+0g0eLq5mhJsSgXS9aYEWhofj0j8Kg5K4Lqt3nzAN3O6uFYZ0?=
 =?us-ascii?Q?ma09fFWDDV/QOgTHKHDrT+rmPQ8/p4ytK3cTwv8SebbZVwyMzg2EX5uwety9?=
 =?us-ascii?Q?Nc+ZQ6/CIc8l8VWj180UohypXuFjK3pjzw3lqL6dDYc2TRinGBE9rAdkPviZ?=
 =?us-ascii?Q?FZKZcPuNxDyWQnfbfpZIuyvHGsj/DUa8Wt16ouL/9A3NlFC/rgU2WuhQcs0Y?=
 =?us-ascii?Q?8k0VMw/f1OQLbIQTlVQoPz3sGxP070uXDBciguvA5C6upHHKnCxmTfIaAzga?=
 =?us-ascii?Q?8COiY3aGwDdixrbwR0gXkfCSJi9gqcVtiN4myAuW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d30c39a-bc09-4a13-5e04-08db9c90bb6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 06:36:03.6158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9NQQiVANCbRyFp2DV3xRlPoiGUTteXAu+ms51ru/ryMlh4f+n3oT+ubbBqRFg36wBgkBmntmBhdHAKpihXeYQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9912
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
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
> Cc: Iuliana Prodan <iuliana.prodan@nxp.com>; Meenakshi Aggarwal
> <meenakshi.aggarwal@nxp.com>
> Subject: [PATCH] crypto: caam - increase the domain of write memory barri=
er to
> full system
>=20
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>=20
> In caam_jr_enqueue, under heavy DDR load, smp_wmb() or dma_wmb() fail to
> make the input ring be updated before the CAAM starts reading it. So, CAA=
M will
> process, again, an old descriptor address and will put it in the output r=
ing. This
> will make caam_jr_dequeue() to fail, since this old descriptor is not in =
the
> software ring.
> To fix this, use wmb() which works on the full system instead of inner/ou=
ter
> shareable domains.
>=20
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> ---
>  drivers/crypto/caam/jr.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c index
> 767fbf052536..5507d5d34a4c 100644
> --- a/drivers/crypto/caam/jr.c
> +++ b/drivers/crypto/caam/jr.c
> @@ -464,8 +464,16 @@ int caam_jr_enqueue(struct device *dev, u32 *desc,
>  	 * Guarantee that the descriptor's DMA address has been written to
>  	 * the next slot in the ring before the write index is updated, since
>  	 * other cores may update this index independently.
> +	 *
> +	 * Under heavy DDR load, smp_wmb() or dma_wmb() fail to make the
> input
> +	 * ring be updated before the CAAM starts reading it. So, CAAM will
> +	 * process, again, an old descriptor address and will put it in the
> +	 * output ring. This will make caam_jr_dequeue() to fail, since this
> +	 * old descriptor is not in the software ring.
> +	 * To fix this, use wmb() which works on the full system instead of
> +	 * inner/outer shareable domains.
>  	 */
> -	smp_wmb();
> +	wmb();
>=20
>  	jrp->head =3D (head + 1) & (JOBR_DEPTH - 1);
>=20
> --
> 2.25.1

