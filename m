Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC87BE32A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjJIOlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjJIOl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:41:29 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93552AC;
        Mon,  9 Oct 2023 07:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696862487; x=1728398487;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MC6wIS+BVoS+Tt7CUguk2RUYOs/91UogDAs2MFmU5Jo=;
  b=rziS+Yfkf6vUtI0DupMUMmSW0EHFZX7KwEcqKySqxogpL9Rqq79hnEn1
   PWdsL/MkkYHSGJjOZNCCoRWxEJh5Tj7j2AvQ5I9Ws0oKP80a+35njLAXN
   9V7Yu1aU9dlLIlJkhU/qVmXLNjR0IM7das76Zu7nOYhwhLX0p43DFRaKl
   Jh9Ik/BYfp3FwxpP4Z78CmHmaU0iDvaUImuQR0JzNXBd62BcRulgBMisH
   oMkZ7mCsXKJ5skqsq7W4p5kncRRTm3+NCEpb7eOgEZ1jCtDat5dNqgVZ1
   7tJGJjKGow2IaQ/Wa6aOTIdFapyP24e0UgQg/OX0hSfp4C7TCQG2nDOSi
   w==;
X-CSE-ConnectionGUID: ynSLTM+VRqqjXD5D5nr11g==
X-CSE-MsgGUID: sDH195XjTpOdHmjwoHd9Fw==
X-IronPort-AV: E=Sophos;i="6.03,210,1694707200"; 
   d="scan'208";a="250560377"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2023 22:41:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMkRhH50hrkUk56yPyYzDk1lzTI2pP165pbUtBhPZqeh5raFmE+eZz8+F1OszvOmsp1SpARz4bITxcxfrnnWcZ8JXPIHaGrtCR5eOkPE/pa2NdYeuhp+9ozWD9vdsxUHtnv36++5lbXZSjZr+Znfbmf7cO6GcgXAHAAIJBxDOYveNjQ6Lo7cdTZGaab/rpvUUcrnF13/YqBJkpdnNGLsWry+XzPKKkri3OAd+4MXUJsbAD0VZVTA+Jj1VW7rz3LXCf3BolyF/2tudlJgSjjIczlnehiBOO/VpCTPncDjP9uArGDxF74UWi2/ZmyaOf53/HyRaXXM/xIgYq+99bFx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lE5n+qE5z0xmdziiMb/N2hqNffIoCQ6/AgQkNVfgDg=;
 b=ShVpGECVdQAPWWZ1yutozFERAiFtf2IzyVCDABfFtMyfAaPKdNJOnwb+6lg7JlhsktMW+IHvdpM2KaX/YCVSq8YeIyWjaYXzNcV9IkL3F9t1qdQ4EXU+PUrpv5jWnuGrLOciRTVdYMNtufTX9YCNNd5dyTJrW6AdYpNfj8SfE1yWNP8Fnn10T8ip1OKuRK4fLJbHOoc7dBbNm2QVYwa/uwcbm1z6YzN8oZp3jtEtqyPQPyo46I5dkPrg5l1zDwqUdhZ7chSmkAX8XuHMxz9nQahzXDB1Zm4cdAG1wiZd95sa/S0pMBOEaTmWPZKWzABpbn7pRwy0YE8eRohHtAnigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lE5n+qE5z0xmdziiMb/N2hqNffIoCQ6/AgQkNVfgDg=;
 b=Wxokj3O6coWlHfoSZ3H7ni/OixYOVzatDSYGAcw042lu5HBETPKyOBqvRxA/HTDjyaHqCviCLX+BPOJqVVo9jk4gF6aaLgT7/gnybN6ww8hoXvAvBk/gQMSFnBXV7E3VZsZEOo2rA7mZ9M1djKcqRMVuYO66pS5FFXE6/sAbza8=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SN7PR04MB8717.namprd04.prod.outlook.com (2603:10b6:806:2e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 14:41:25 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:41:25 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Rob Herring <robh@kernel.org>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: xgene: Use of_device_get_match_data()
Thread-Topic: [PATCH] ata: xgene: Use of_device_get_match_data()
Thread-Index: AQHZ+r6tyqEqExIopkKdwhLCRrgP3g==
Date:   Mon, 9 Oct 2023 14:41:25 +0000
Message-ID: <ZSQREEr0WBk15fFJ@x1-carbon>
References: <20231006214433.339688-1-robh@kernel.org>
In-Reply-To: <20231006214433.339688-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SN7PR04MB8717:EE_
x-ms-office365-filtering-correlation-id: 5b598c93-0c0c-4373-9368-08dbc8d5d07d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4am3TjCIwjnrrWJXl2zOlh49Bh9mPL5l/Ah9zNfXr9RdqbK3S3mOlMfdq0TXSRmscVBdAdl/WOdnc9felPSUO5IPsQc8UvY9xwW/9IXEb1TZtclgfLwWbY9HdENLLUZ7CM0NN5fTvBpXG3gs3U6r4I1H8iYv4WRV6JDZepJhfHgxKYHUO6hxWlCVbb9WQD44/XD6j9ltc/OeN94p+AqnmMmFC7i064oATxmMxOYK2TleOnyNMgA4dc1p/V+c/P+R4nun7O9ybV1NkuSi8NY/C7+9SHkP+M50La754c61ibTwD8yli8/q2bcf2ipwwYNV/Zkpj/zmygfXQqy2JqT0CngRxHsZvnD+ckQBYH3qzKJvhMonxuwR3I8QB5+EGG1q+CZLdY5ohQdvHzYHi6pWWaOeXqu2E2h9LsyX0TpECySACMQ9h5FhUhdYHpJtUMqejFb3zXLcO8Vxju1PYyBSaZYuSQSjVhQgd4X2BPnyc0DCuJwz7rPA4N8tjIMjkvJDpp+CGGVQI01w+9e17ZhZ0Eg+ag0Ig6aH0pKhmZwmRFy9/dKQnMGLdxck4cibzvxXQmnuuSHFSx7ZW5GQhe2WTrGpJB6/nInteHRaZgHuHGQ92N5ElFP0WHP/7jP6Ns6M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(122000001)(82960400001)(38100700002)(38070700005)(86362001)(33716001)(2906002)(6512007)(9686003)(478600001)(6486002)(41300700001)(8936002)(8676002)(5660300002)(4326008)(71200400001)(6506007)(83380400001)(66476007)(66556008)(64756008)(66946007)(6916009)(54906003)(66446008)(91956017)(76116006)(26005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zW3PzYWEB21KB43Yy9JUHT4zUXyHaE/PsRe0L5YdO35xASqbTdGaBSLiPU2+?=
 =?us-ascii?Q?DKXWF76D+okxDuhPjFf09rKWvK5OAwB4vfh+Q50ammbgdN0YDSnktIKjPYlQ?=
 =?us-ascii?Q?3qkBlolAF4TUJWEM50TZWn4UsANp0Ge0AA/sRZ6COJ1cdpSz5yeRCXYV/RQU?=
 =?us-ascii?Q?CSLbVraMnrz92cGiatSEN2CZlMmYO2b24QpEiuaC31vX7SgEryJ7W1Ru+BLd?=
 =?us-ascii?Q?dwtJC+TfXwKi5dDQd6qCTpafnqWUYxI74r5F8aBpGVNGrtDUfIpgWB0q0fPo?=
 =?us-ascii?Q?K+pkrvtRC1E4agzxQZtmYBl2n+W7aWPFjOYGQpiqdN710qdynWYG2z5vJ0V1?=
 =?us-ascii?Q?UJSRABaI+IQzc5ZdVKMh52Dj95+P2a84Jr3+boYfEAvaKLDQ+PGK9XY9jYo5?=
 =?us-ascii?Q?OnCtri43J/uYtqzt2JKQ1xrSyBsOzMnHMX5rvPA5tTcO9PtPLxMEBZfg83ou?=
 =?us-ascii?Q?Eo7giyl1ue0B72nwbaXhIwVEaueRejgRbJ9z/dLuStI6FaP9zYGM68JPTuPd?=
 =?us-ascii?Q?J9bKMCS0awLL5cTkcaftCFasxNNdmHQrEY2/1i+sFgpyx0a2+aUXgHzG8Kmc?=
 =?us-ascii?Q?IY2OjNh9ovKnCQfJOX5rQHnDcGtPQudOEElafh04rM3apTSQ0lTE2BTNvUX9?=
 =?us-ascii?Q?vPYVANY33Fyjh3xGJJBdcpGHGJRWuuIFAKTrhrkbimnRBM4AzkcGIGv6iwh3?=
 =?us-ascii?Q?MgnYa4CHlbe88pv1FGIQdiTBpCxVkckRZn7aDkDx+6x5KFz5jrwenKHmmmcr?=
 =?us-ascii?Q?Ewwf11ehtKM5Knrm4/BIYOUvc3Ou5M6im21v1RLH1RJw2mlVY1dR1s7uGT8n?=
 =?us-ascii?Q?tSrKf+Ks6sa2yP2J4YHPtKhkc1UhL30RzD8RZKGDKVfFAv++0NCT7ck48kTX?=
 =?us-ascii?Q?dSRsh5vqoBkvvZG51gulDYrruAa081q2H71odQoVHqANTn2786P3KbZIJL+u?=
 =?us-ascii?Q?YV5XopvLf0oT58xAJQGeQ+Wunf9iLFQaBEzS1F79pFBYFneGJvt7GLaG6PUs?=
 =?us-ascii?Q?f8s6MlV3U9SiJWKmq0H20V/ZPcshQnR7flBBt/4dBY1nKKV4Zcyi1w2oDtMI?=
 =?us-ascii?Q?oJZn+Zw9PV7QFZEWeSNJeZkMNxTO2bDGZE1KmjO54Nd/LmVGsxzccUMs+cmO?=
 =?us-ascii?Q?qDQqXBGuF7IKGjPy3sGthrFfksN3VCB7dBfgjcRA3lVDZQak+T+K9M6n/Egq?=
 =?us-ascii?Q?nBZFm47olzBAdFJZuYLo7WVkCZixbBqcve6C58nzafLn80QDUlQA6tYH7OP/?=
 =?us-ascii?Q?1pOgaMW7JyvHpbE0f/3MCZrX2p/TcJgBJlJJEVh0jeqyX3P/sgvP7hz/VrPo?=
 =?us-ascii?Q?SCej9FGGcKOHIcQI/uK3/kKdWZbJgf5HetfsJTjEwj3P8Kytjwzuv0/R/eBA?=
 =?us-ascii?Q?Lf0sfABK6fp+gGz79opCO3e2GMp95DRlvdnD+FqPjd91U5LZrH46Ad3fIPnA?=
 =?us-ascii?Q?edzHJkUgGHl/EjDwPZ1l2gUpMe+X0lPTUlXN3eWTfSG9Jy+QgxVpbex+hWPO?=
 =?us-ascii?Q?4ldS2u0LBKWKuf3dMXu4DHXDVArcGrXZobQN6Oujc5WjXEn3lm4XoQgVMhv2?=
 =?us-ascii?Q?r6IyXQKKqFtZKp0uO3rIj7I5G1tBgBMTFXFM1RCCNkkbKwEFRN2hFsK5te9c?=
 =?us-ascii?Q?vQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F3B4915C93ACB4E97A74058DB16D5C3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xz1pyvL+bqlHWC2MebmTdhRTcc9Lr4raG/lOrAZZaDtgLrR4+FfFJFmOr7BGEBnSBAOs383E1XD+lVL1h5mRpe1mNl4fMtztldPTT9OcyecNg1hMJ/vd8QhTSNW0SLptqx1uTIc1Msi2jAz89NmMssoZQcd8E+Eb5VhfwLcLzvIau6j8tv7pJ6MjKWX2hgKdFp4RhbxB2Ao6o/yDUvZqutFByHNdBZ5TFAd5tBW9MZgMBzhq4HsOJ1xo+iPzqX7k8szsS01dZvFXOJ8pwc05bqq6Rh6A/4ewj8lDOsGtfe49oQq2oPLXpZr2BIg3VL3if+ucbbMCn9fMjadK/GY/QJbIiD1JZ8nXDJlcIs7HlpGcxD+Re55neOMD+//WDQCSjwwzPbLc6QIuKYrU2a24HwEZLhEwUdpKVKN/ywrIDc08szj5FuzvR70JQLSr154crMqDh3jOS7VQqreSJ+zxlQyaJ666TnetIz+N1zad/lVcha90dA11wafNABgOJ28Ef8F5ogop4Iykh2c+YZaE3uXlArhNf6PGR2H5EwDZGv0g1NK1KhIi4FxYBQeG1JUcsnB6uC2ZnRjRdUqw/BwRJUI/KKyvKtDhDnzGp1zWFXvJY10+Da19+0AQrXtKyu0oUYkysUGzdp4E+gSQH7heP86dUmI1k/k2Yfi+Hbq5sOCQ7XtBZZvaromLSAX17dHK0OhfLQf5S6VNI10jgJ83VYRb9h9xestlBsoSaYqLNGQy6Ix489jrnfYTGabJ/OCpBlm4Du00+K0oLdKSc9J5U8tmcl4kMk5jcXc2bKyri8nbdxiZk6k2ThdDOO2XVvIx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b598c93-0c0c-4373-9368-08dbc8d5d07d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 14:41:25.3944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMsOhZjHOdezeIMnSCBxq5bC1Xc1EbikucPo5qDgpc0hOLf6QIg1kDrKtrjBTL5KvdMLFdLbiOGDdRsD5m0h+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8717
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 04:44:33PM -0500, Rob Herring wrote:
> Use preferred of_device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Perhaps device_get_match_data() could be used here and all the ACPI
> specific code dropped, but not sure if all the ACPI code is really
> necessary.
> ---
>  drivers/ata/ahci_xgene.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index ccef5e63bdf9..81a1d838c0fc 100644
> --- a/drivers/ata/ahci_xgene.c
> +++ b/drivers/ata/ahci_xgene.c
> @@ -13,9 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/ahci_platform.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> -#include <linux/of_irq.h>
> +#include <linux/of.h>
>  #include <linux/phy/phy.h>
>  #include "ahci.h"
> =20
> @@ -735,7 +733,6 @@ static int xgene_ahci_probe(struct platform_device *p=
dev)
>  	struct ahci_host_priv *hpriv;
>  	struct xgene_ahci_context *ctx;
>  	struct resource *res;
> -	const struct of_device_id *of_devid;
>  	enum xgene_ahci_version version =3D XGENE_AHCI_V1;
>  	const struct ata_port_info *ppi[] =3D { &xgene_ahci_v1_port_info,
>  					      &xgene_ahci_v2_port_info };
> @@ -778,10 +775,8 @@ static int xgene_ahci_probe(struct platform_device *=
pdev)
>  		ctx->csr_mux =3D csr;
>  	}
> =20
> -	of_devid =3D of_match_device(xgene_ahci_of_match, dev);
> -	if (of_devid) {
> -		if (of_devid->data)
> -			version =3D (unsigned long) of_devid->data;
> +	if (dev->of_node) {
> +		version =3D (enum xgene_ahci_version)of_device_get_match_data(dev);
>  	}

Nit: braces can be removed.

>  #ifdef CONFIG_ACPI
>  	else {
> --=20
> 2.40.1
>=20

With or without nit fixed:
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
