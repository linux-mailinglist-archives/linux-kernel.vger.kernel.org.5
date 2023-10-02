Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397F07B4AE3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 05:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjJBDWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 23:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjJBDWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 23:22:06 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2111.outbound.protection.outlook.com [40.107.117.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4B4C6;
        Sun,  1 Oct 2023 20:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XV0cNgvWOEEU9cMKcOzLHqOj/AV+nx9X1f+RAsxt//wpqzcVlVetdpSYXhaTGLxZZWTGGSdQOXH4upkBHIOcsZhSrwHNslCDVYtQ3TTFzglX2L6VpqFmkaSlOEaCxod176LF1dAaS5Hf7BZKUPCTAuehLVby7h/wGhUoKLQbmu6pjiJySz3bKBwhQMuBtOllCSQinWVFscFvt1usjCxg99vE/gM9yplS919e2IhRduNhhBYufc8OpSsptwtTe+lKEGFeg2Axv6MUeEX1wJCRfnmbb16U67EeFhVJpoQ0sEZrPXi9kBvz3m8mTm4XWT/d2O6JDJBmJZqSM/KJGPBM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VR12+22R6sOqaNgzDEOC0yBSWf9Y2Pmk0f1Fo7RvKY=;
 b=In5DZW4+x5A0wsxOJ7iicoV2c7nCfbMp5GUuYGd5Qr9j6zsKHJdLSy/WhmtxttQiixDBieSZXfrMaXdNOvqa7gvzxBQrKiBR8DuWEhIuEaZaw1tfa34YR8k58+jbeoMCcJomoaoPUOsCop687n+9GwXPessKDYG7XbDS21yBkaZ1P530k+agHHoOgpnVd76ERqUB7iMaBvFDaNijvcngG0OKCiiZOjEusEMaOiLE2SVTXThwsBosncRlMlWfzTtlu9vNRsGV4bxh+1EBuJ+AtPwFE92X/5t2+pXzVZYvbv0oV63DZdFeGFtSWXGJKOpy93aDHMGBbKH/rZNeu76nWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VR12+22R6sOqaNgzDEOC0yBSWf9Y2Pmk0f1Fo7RvKY=;
 b=LLolZ7sY2zmKlEas0VoEuJSuodhvBK5Gh3i16a2w1hdiI2e3wiI0Opj+Z9AP1YFuZ/hzUWuz9XjQLyn+lF4ewlvNu5Fe6qkwvcIzlpC7oFv755qqp+1yEO1u56cXpCI3TTdb8mjGJHSbc5G0mDkQ3rtUVZoerUS3mP7SnoLoX+vLYuCa722pcnkJaU4MgRiFzfB/WxhAPv7/AeB/0HuyDhZVtUHyLdQMbLSYA+6SEJXY/fOCK96hZ1nQmFo8Fdj/M0JjzCFHIn48YQJJVAnD/MnIowfTiW5doT+O8cz3jxRX8KP9+FzDAp5R/4o69gafcCYOLJpPEzhAS2HLAg2apg==
Received: from TYZPR06MB6770.apcprd06.prod.outlook.com (2603:1096:400:45e::12)
 by KL1PR06MB6297.apcprd06.prod.outlook.com (2603:1096:820:ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 03:21:56 +0000
Received: from TYZPR06MB6770.apcprd06.prod.outlook.com
 ([fe80::1ed6:569e:e826:62c2]) by TYZPR06MB6770.apcprd06.prod.outlook.com
 ([fe80::1ed6:569e:e826:62c2%4]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 03:21:56 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Corentin Labbe <clabbe@baylibre.com>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] crypto: Move akcipher_request_cast helper to crypto
 header
Thread-Topic: [PATCH] crypto: Move akcipher_request_cast helper to crypto
 header
Thread-Index: AQHZ9KPWRcGTiWTCyUK/D0jNMoSECrA11bZg
Date:   Mon, 2 Oct 2023 03:21:56 +0000
Message-ID: <TYZPR06MB6770E43899C7AB66FF55FAC280C5A@TYZPR06MB6770.apcprd06.prod.outlook.com>
References: <20231001201357.2052949-1-clabbe@baylibre.com>
In-Reply-To: <20231001201357.2052949-1-clabbe@baylibre.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6770:EE_|KL1PR06MB6297:EE_
x-ms-office365-filtering-correlation-id: a80daac7-d270-4c76-fe64-08dbc2f6bb4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uj7SHwJVo+Xy+AXzvNGy7vD3QwaNTZA7HCdFPq+KcHRpr8qPwGQH2Vs3UtSi/PhMOJaLi63fx1iIrI2NUx33Oo9Tb8aHiVfZSKP12+ITtfFsZz9At9NMUgeH+iA642keyb73/bTLrRK9eMS64dKHun6D9e+uo+4wXIgywjoL5xaR1yzaxvpU2NYVHiiN3wmZ9a+UMhMkvd6+znu3+sE8PhPPL5a5wmH2attQQ23cJgtgx6vrjTlbHkCFzMpnKNvF4+nRutE9262F7vNV+Xs0ZMqNnQvlqgukJFQBwJnREwWS7UVAYGxSOwm5uEZHAeamzoC7/ABPXmP8FwaBVivSHPEhPd7WJCVs0+9kJt1oGGEsJ+2rXR4DiGuPEtLox9JosAInwyS13xCLBuubJ4fNDeMoWuD9wyGqjVN/t/mLPmRi0+qS8+GIXRyLhOzll2MBwuqovIoBOEVRWW8mTKC2nA9A3cqNQxObIvPXOc8DocCTKRDqFPrbqY+yKDzmsK9r/b7grcElHTT/KP3q3fACL5IS4q1wROIt35ySd+2+0T8gwxRq4m8VfUJqbnzS+nZRGzIowW+hL5m3hNvT/3+NDziVnQ3OvLKYfohmGx1EwWm1QMidAH5pPxt3lKM/QfXt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6770.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39840400004)(346002)(396003)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(7696005)(6506007)(53546011)(71200400001)(2906002)(55016003)(26005)(9686003)(66446008)(110136005)(66476007)(8936002)(4326008)(64756008)(54906003)(76116006)(66946007)(316002)(52536014)(5660300002)(86362001)(8676002)(33656002)(122000001)(38070700005)(38100700002)(41300700001)(7416002)(478600001)(66556008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XrPOdXYJM0o6v+mhhSYPJI4lKEfG3t4wODB4Mc7oWg79kXQw4NzbrtDbFMk2?=
 =?us-ascii?Q?Fp/sJ88Rxuq6CA+PDzovUQMw9gJOnRWciRlIukeTjYbiw8umucia3G/2xiJD?=
 =?us-ascii?Q?3vo3RyfGFz6avL/E84YTZlfhERq0/AlSm1kF+VOoUCfPdxC8oy/wyL4DEIQW?=
 =?us-ascii?Q?cqkMqEbVIgcjKIfNvqDcX0PCxONcnWcKxSsyBHB2RAIqSZMvkH3LqDxgTx2q?=
 =?us-ascii?Q?m1NwBawNrIkLxPxSSkaYU0kKIb7OObkjfGfvPCrn8xXbbcfS+hM5pUd5S6TO?=
 =?us-ascii?Q?NfNVF5EXeM8YYEQvptar1S92rYV/RqAaS/5ePSSADxfeyiHkRzfUJJ4TAAGI?=
 =?us-ascii?Q?k385GtNPStowNWcGU8jyEqrkI3CAovG2zSJeBoUTLVLuSH1m5Ubiqlp9YgED?=
 =?us-ascii?Q?TZGbaga/y8OweQfW0Y6cdzqBFHwtjST2IQnaxIJPRAfZjy15sZ7+dhB1s06r?=
 =?us-ascii?Q?cpIKzevecNaMTiL0EpquQLuVFwxtb5g+CeDEXIuejJho8ZDZkF69YEHQGKFi?=
 =?us-ascii?Q?rMdtkdvEbGwzfFJJvUOGMT5bWnwpeUqjkLc63Qeodh+o9pyfF2qLFRS1UHx8?=
 =?us-ascii?Q?S2zr9afKRCTgbFScrOuxGXDxk/Dpw/az9CI2rCxqVSH0pxZLnwzLT49+jlRh?=
 =?us-ascii?Q?4rcco2428eG/L2JMxFTwNzpkukHPR5IgrA+pI3aB5e2V+JPJp78CEbyOxfDf?=
 =?us-ascii?Q?dkBIUbrLdLeX0QS8JyOBGbENvK02JNgZ0kFn2XA/0vDLMkbrbPPh1L5yQDl7?=
 =?us-ascii?Q?SKv2sZ2gEqZF9H25JY84bNFELHgPu+1EohfbUMb25ejjKok4fdVLq5OJmSv9?=
 =?us-ascii?Q?I0P+TAtyHGjNKJiH0fwQTevrGTycNY6rBoqj7E/yKI13r9FFE0IRy8nqFoYT?=
 =?us-ascii?Q?YZNJB2c4zDVn3a5xhDRP7wqhh+pYKQf6uabBhBWQj5RkCeI0wQF9Kuvp7uvY?=
 =?us-ascii?Q?PGpOVwX//Z8HuoOUA2gz/Fs6iGvIFKr04C7xo41PCEnk3pyfl5pNa9RIlbsq?=
 =?us-ascii?Q?4rW0UNWK2pRBGcBjQV3KpYlq9bVMUwtFmEih1ozFCCAUIme1ysK4/S6LmOhU?=
 =?us-ascii?Q?VixxF+CzR5pFPDRT+D9wejZGJKpZyg+E1k/wkG+juKop4bE44r1rmMD52rf1?=
 =?us-ascii?Q?nqwGvs85xrBZV22Lsuur/F46//dOt4bfPz0P8xsZ/GtUOPXOjWRyvcTPSfSS?=
 =?us-ascii?Q?r5skRQ6zLq5YAuSQL0kMZD/Xw3qNFKZY46nSveoRqf+o7F/3WSNyOWkk+Kbc?=
 =?us-ascii?Q?dBW1X7YSYGWyCW6z/0655NI0NsAlSKlAEaiI0cUow/I1L0yVrOZ13RUku6HH?=
 =?us-ascii?Q?a3By51A1dMZswNR+Onum4pN4RXiUzidNqyte9BwjytN9QvX8M58MgzlY26Lo?=
 =?us-ascii?Q?74/cft6JKDIIWT12iv3iFTo26W5sgMjRa1qrX+8HeXvNI2kkWup1IoblvyUq?=
 =?us-ascii?Q?Hqpzhtb5AvTKX/4Q6W9Gi5PvzV0mZ9WzcJwiEIlmtLzGKum3gdrt8SwN5uD9?=
 =?us-ascii?Q?dF62cwXmzVno/xjB2nff9HIk+EBcDk9v12Is7u9sX1iCUllOMAu2fcx4bUqN?=
 =?us-ascii?Q?EydByR3DpVE65ajvfdwgbj0jmCc+kLz1Vnd9vZFZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6770.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80daac7-d270-4c76-fe64-08dbc2f6bb4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 03:21:56.3246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56r+V8lwcYhFyabpTPPXwlivq9/d5qLQo+bxIiZaYxZsq6bkAn8WrF+AdDwO2wsFlS8bLT2tBjps3QSfcq4NBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6297
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Corentin Labbe <clabbe@baylibre.com>
> Sent: Monday, October 2, 2023 4:14 AM
> To: andrew@aj.id.au; davem@davemloft.net; herbert@gondor.apana.org.au;
> joel@jms.id.au; john.allen@amd.com; Neal Liu <neal_liu@aspeedtech.com>;
> thomas.lendacky@amd.com
> Cc: linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org;
> linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Corentin Labb=
e
> <clabbe@baylibre.com>
> Subject: [PATCH] crypto: Move akcipher_request_cast helper to crypto head=
er
>=20
> There is already 2 driver implementing their own akcipher_request_cast.
> In the future there will be also rockchip and allwinner driver that will =
need
> this.
> This is sufficient to move it in crypto headers.
>=20
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Reviewed-by: Neal Liu <neal_liu@aspeedtech.com>
Thanks.

> ---
>  drivers/crypto/aspeed/aspeed-acry.c | 6 ------
> drivers/crypto/ccp/ccp-crypto-rsa.c | 6 ------
>  include/crypto/akcipher.h           | 7 +++++++
>  3 files changed, 7 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/crypto/aspeed/aspeed-acry.c
> b/drivers/crypto/aspeed/aspeed-acry.c
> index 247c568aa8df..ecb6e984367b 100644
> --- a/drivers/crypto/aspeed/aspeed-acry.c
> +++ b/drivers/crypto/aspeed/aspeed-acry.c
> @@ -137,12 +137,6 @@ enum aspeed_rsa_key_mode {
>  	ASPEED_RSA_DATA_MODE,
>  };
>=20
> -static inline struct akcipher_request *
> -	akcipher_request_cast(struct crypto_async_request *req)
> -{
> -	return container_of(req, struct akcipher_request, base);
> -}
> -
>  static int aspeed_acry_do_fallback(struct akcipher_request *req)  {
>  	struct crypto_akcipher *cipher =3D crypto_akcipher_reqtfm(req); diff --=
git
> a/drivers/crypto/ccp/ccp-crypto-rsa.c b/drivers/crypto/ccp/ccp-crypto-rsa=
.c
> index a14f85512cf4..32c9f524f3d5 100644
> --- a/drivers/crypto/ccp/ccp-crypto-rsa.c
> +++ b/drivers/crypto/ccp/ccp-crypto-rsa.c
> @@ -19,12 +19,6 @@
>=20
>  #include "ccp-crypto.h"
>=20
> -static inline struct akcipher_request *akcipher_request_cast(
> -	struct crypto_async_request *req)
> -{
> -	return container_of(req, struct akcipher_request, base);
> -}
> -
>  static inline int ccp_copy_and_save_keypart(u8 **kpbuf, unsigned int *kp=
len,
>  					    const u8 *buf, size_t sz)
>  {
> diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h index
> 670508f1dca1..4b6e610db18d 100644
> --- a/include/crypto/akcipher.h
> +++ b/include/crypto/akcipher.h
> @@ -498,4 +498,11 @@ static inline int crypto_akcipher_set_priv_key(struc=
t
> crypto_akcipher *tfm,
>=20
>  	return alg->set_priv_key(tfm, key, keylen);  }
> +
> +static inline struct akcipher_request *
> +	akcipher_request_cast(struct crypto_async_request *req) {
> +	return container_of(req, struct akcipher_request, base); }
> +
>  #endif
> --
> 2.41.0

