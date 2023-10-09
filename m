Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E677BE29B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376997AbjJIOWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjJIOWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:22:41 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1B2BA;
        Mon,  9 Oct 2023 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696861360; x=1728397360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+jPvNYbzjAH+Ljlj0GmsRfCilx1J8uv4H2Rzu3hdfqY=;
  b=Bcv724Ix4CYzIA/qTyC0GyKPROHC0s2k6qW14swwhvVVz+iaqbZUcv4o
   te8RbSQBy4YMWOCMLg7TMtZHaX2x/yfnwI89WCUZoXqHBWA9cLFnk+Bo3
   buIShDauWP2loiaRLs2TwdERWHDDOmLl22tNbBvYG7QwUo/wTJIcD1jbq
   rzATo8dzwWxZQT97FmlGOX6Hb6mg36deqsTESkbe4Gf0PefzrCmhGy6cp
   ISecQnq3qr9THrffuE/1OlZ8sSt480ZwsJLicrFXdorLa3eXhoJUxkecY
   yScUq3nMHbZ9OROtcRuo4K/gj8ahHYEcM0UOD+Wo4TC2GLQvnsRun4fEf
   Q==;
X-CSE-ConnectionGUID: tXOH1BbfTdKNputWaWcGNw==
X-CSE-MsgGUID: 5MCtBf79RA2sXSqhB4fmkA==
X-IronPort-AV: E=Sophos;i="6.03,210,1694707200"; 
   d="scan'208";a="250559222"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2023 22:22:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zxqoe9NBspUAWUYdALPNv8tHNFex/sid4ndMzYR4XVlz3/k1/0yl1tsCcxPBpOU7c7jhkogcn56ygSG1HfjwFv5BHhfWfr6nquaW0L56ztYG+m7pInWESscNwQh4nUKFY6ztKSDHaDUuNLdPkZJ9RRQnMzzrw/vmn/mA/O7mfK6W8/f9rEMZ2Eo/0hSGN4pipAtUaRI3+KDHgc4oawOeJXCWlgDVuSPXnm3VnIjOVf1j2N+IqJz6MuLSwKNd77IFl0MW8cHfw0jHsmCOpGjy+9xINw5axTKD3pRRD7VH+K9942CgveoNmLtYpmX7SEkVFz2JiuE1zwKwq0K4y9v2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1mqbzfFsTuN1inZMvr3qBXFbtBijwxeFAzOkN7pASI=;
 b=j0CRCqoe+BubnO2mFjHKZa9CREsR58NMO4Q60x1mTSvANV/1qbLfLGEtu4SJxsVW9Gxdy04PBPPHqJbV8laHlXubdE6QvhllV23ZssELjIkJwVmZJ7Nv36bKzy/WvFpXAi5r5kMdcM9Kb6+TL9+iVjgBIzZNDmrLXIT2XHP47/ebMyqJ7tv3XodhVM+k9yF54nVUzFm7RwIoy3n/KnOSY0Xv3fHdFayt3cuBWDvYvgdoXjIAAr9/lwp0czKy1LRfWAFONodcJ0zAggip1nIm8VRj7smV6UBEvFtHwVHYsu6pwhK5RnJ1qdx4RCCNNO1aXwtBld5oNI9EEedlRak0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1mqbzfFsTuN1inZMvr3qBXFbtBijwxeFAzOkN7pASI=;
 b=IXAmJ3aaDbdJ0IrojdVvHICvLTFtX5eqmnrLMVpdmza69iYA3qd+a1W6i8ICXq9EDvR768rwgkzdg+tsUIrzC0+n0W1rfwQdOMJPZWdppwYxdicT5L1cW/HWLAIFF+yd2OMa9PUiTtPrQYsDtco1Ve4ARr+y854b3Thr79SOT64=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH2PR04MB6807.namprd04.prod.outlook.com (2603:10b6:610:a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 14:22:37 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:22:37 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Ma Ke <make_ruc2021@163.com>
CC:     "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ata: sata_mv: aspeed: fix value check in
 mv_platform_probe()
Thread-Topic: [PATCH v2] ata: sata_mv: aspeed: fix value check in
 mv_platform_probe()
Thread-Index: AQHZ+rwN5B4BC+3D3EianOt6+pON8g==
Date:   Mon, 9 Oct 2023 14:22:37 +0000
Message-ID: <ZSQMqTos1/y0/eeC@x1-carbon>
References: <20231009124955.4046988-1-make_ruc2021@163.com>
In-Reply-To: <20231009124955.4046988-1-make_ruc2021@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH2PR04MB6807:EE_
x-ms-office365-filtering-correlation-id: 7f2edb1a-89c7-4b9a-105b-08dbc8d33049
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HGwCxIPjwD36cbe8vWgxJtjCoIpM0yltzsICoW3kD6W9kVY6i1Ir1lATWMWgznTAChZSWqYAy5be0V4dgOGXX2sTes4LH5k0B4S+E1cOO9SRNDKTBZRyCz4PHT2BBhq9fjKduSLyKtUEXptG9UpRJwnA35nvG9FkNrGswdU48UIDcDmC+yHlNn9oiZlwkK/HALxIHoMmhEnXFVKHoqq5KKdyBYIKa4D7v0kXsT7WISUn5+TIz0d+Ni3FeblZnYBKl5RrBBHSJ/upjvkD5YPBf0i7A1UhfIHpjFtGK9W1hZZeCvPyKU1+w7FvjBJHeM33ABhWcCo17vZepHCW4Xz6wpApiVCEpJnqz05QOVY+Y5Z8a1x1lyHH8Y1zdbAcT/YWMupRXlQThPgISKqCEXD+4d3A6ScFqb6uapKXCKDqhSCsdGWkjxZ3En8iNz5dhrKKG3Nognw6mv/hA36hRVLTF8XedaMxmmx6+VDZa85pzijZYKi+B0PGC+As7YMKNGvkdQTBLum+34j+sHlmXkISsKH9Eitph/DAbqRFKwBOX08LM9SX+RlwgBNVRo5v2+XgRiHLweqWKprnVXvIbS5kXMmus9Cn+pt5BHSQ+zTz8F397Atg124PTTFwOfA0p/AC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(91956017)(66446008)(66476007)(66556008)(76116006)(6916009)(316002)(64756008)(54906003)(66946007)(41300700001)(9686003)(26005)(71200400001)(2906002)(4744005)(8676002)(6506007)(6512007)(8936002)(4326008)(5660300002)(83380400001)(6486002)(478600001)(38070700005)(82960400001)(38100700002)(122000001)(86362001)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GXY/yDfGO7UFL8FBImGYYPJYLSBEgyfNumJtsaI0Mc6BONv9Gxl97hHfm4qV?=
 =?us-ascii?Q?WrMGGmKvegauqzVPXd8863wRAyN1DZbG0QrG7+YbPP+tpfK/vO3u7uc7nCfd?=
 =?us-ascii?Q?VnMnYYFv7TPOl2X11lLUVwhv7zH0ANj78p+DwThLSL71Y6QPFcZADgREIK5R?=
 =?us-ascii?Q?pN7i+I4BlwsrEmwel0frjy9I9gsnGMi+rOjFV7XJdb5izrd2NgHiRbldpXLd?=
 =?us-ascii?Q?3SKSDfrOUJ16Yk2OqZhsNQbkZzW1yTEnWC1sUsHD/Mngjll1F2NpolRk1D+E?=
 =?us-ascii?Q?W2wJH07OFAfdBGGKemq9kLMLeCi16Dcc8lrPA/XnsxPnOcbwtmj2fm4II+O5?=
 =?us-ascii?Q?iDGz1aC27t9wmZSqEGw/Ic/4yK5KcyFpM8ZTKJiEdKYjVqWmliAGdlD7aa7o?=
 =?us-ascii?Q?gNhf5ewo58ZD07cPwZM3++ZNAcDiPmM60VnrAamUdLw8u2NrRe/tSVdAGPoB?=
 =?us-ascii?Q?JhS83GpWI7/QlZ4tg1UELHGt/+CAD9i9cMMrQYgrPAz/08EK73+7azwz5qHv?=
 =?us-ascii?Q?6YxWjDAfPzCvSHOHdTmDGy4olTILB1CyFa+Oh7+KhBV934Krhkv7vkBQZUC8?=
 =?us-ascii?Q?Xyb/68cJeG74jo2Eetk61dR/zOiIvRH7hHg8aJGVWlveHx2JKdjDTOugmqzy?=
 =?us-ascii?Q?9g/YXOUDbUpB3/mqYl18XdS67pWUeHjCHn/4eoJ4sTgccbhVnQ1M5MAPv6Wy?=
 =?us-ascii?Q?qMfiQnnvFHys0+Y+jiEMZqzaffOQGzMXGgCaUGyxrNUgW7Pl02113KqVXvtc?=
 =?us-ascii?Q?iXSR2W+YdI597bIR/dO8aI0o9V0XFGM5/PJe/oWw9TEV3JUVMsjohZ45nOlY?=
 =?us-ascii?Q?nEySe75RHN00uHQ3dCytlMN5rckSex/I4FF7E47Zz9V+kaCBhAIHwBAm49I8?=
 =?us-ascii?Q?AD5FolAE5jhP1wG8wjZN2HNVUXgJgS9zLtrkCMJniJeVTUILMau7DtAr3re8?=
 =?us-ascii?Q?2ldeWlN9fQtgf8H/kcnwkrIWxZKt1SeHNZQ2uvstulpMd+bADZ0JHXZLQf6Q?=
 =?us-ascii?Q?eI8N/1hw8N8+e3YrbiXhSD+7T1tkvZBN5lHrL8rL/11NwPU5fc/JIgmb/9LS?=
 =?us-ascii?Q?bhLMt/3b6/3Y+HrSlivPBRumJnBRfvmT7RxPycy0sfZF9tQItCpabShm+kOX?=
 =?us-ascii?Q?fM4xDMqUzToHhhnzBkvG/wgnxjBjJBiVzXiFQfSTKM3Gu4zuWH/Bm5iUW+d5?=
 =?us-ascii?Q?Q32cwGZAF+oefZl4OsRiNn7YaeXCj5VlWdlxdtxiOo7u+Y+t5Qva7ri+vL+y?=
 =?us-ascii?Q?yPlbWsTqhpJtQMByhx8PWTr/W93ORLAOn/kBG1SbkQ8/PEoMxFLB1dnQzQIb?=
 =?us-ascii?Q?wNYmjTNBMZtXd1xHvPffrdGZG+t5fAWMowGwr2mxxb1nPDfwXZOX4Lfhovk6?=
 =?us-ascii?Q?8VpqR8qHBMIdXCCz//65aXNPWvff9dglC+RIyBqRf7quZum4RcIiMBhwosZ4?=
 =?us-ascii?Q?ZXZ39GvSv2y3PRliXXMAeNSHgdJH6Mwn2K7c37iAbPcN1x9yAGHxHalKsLal?=
 =?us-ascii?Q?o/VYvGnHGR1McQsB7y2lLQB41F8HgCvwytmj4C5CaJNVJIApIf/Q9/Ry3A+y?=
 =?us-ascii?Q?+04MaHfHyc/kffgPI0Ci2nzmd4TNh6wDGIGOC4r8+Zlgy0Tw0t4SrIw5TRyt?=
 =?us-ascii?Q?lQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D76A580830580B4B905046FD7A8498D9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a48H8+yfpS4VXFbfFHaAAkS6GYYtyNwCLH3Rj0llLOATw3GOKRCQ+rFC5MXVdOSV+Igf5i/k+vyNWwpmuQ+DGtqMm6RxRo26Agl2KYw9vQJpOq+995CzaRXGOFmz1ljjGF7Dpu70A1qaSRtc6Drp9NyN3YjJKSLO7YDeO9eReqPeJiXYeQoQrKijR3HqXEthmVpYBIbHf+z8nyJWsFH+688D+PxOLqI/rRsDoP/pRmpsK/bnbkNTD4HKURgoi0fkFv5ckw5UFcS89N3pzjD9WyVu+DMNzhwtI/mGh37cxRlJU8a4wWf/BvClcQ4i1s0vVS1oWdOuM34MPWsqfroqL+x7KvYgV+0lmV1x+3GZp5+vWmSkxAk5CGjnyTRpc6adNLG6mz7LUs2bfsiPL3sfLv6RZfoFLPlMZDFcMaImlshLRhaWQbeEdZNZBk44T/7l85tMkrJgWngQIRaQwmE1cmN7KgukzTFCFlQC05lTuJFwpv74e2Bn/RRuMVXOcVoobtHwF1Im6p7pdOADHslS9YC/DcXw1putR8YWcy/a40b+MLeVeX2vBTYxwxAM/rOOpx2FE/Ww9nITFd0IrAzXAtnV5miDsjAjyR3fdvTb9M1kX9FYuM945rJK6BrF6yBykU26WXVWmK71uYEs0u4I0/ghUXy4LyvF/z9/2RUxfDPfjrJNxjnKn23r7zQ36CYeH2LuWAn0tG2EANZiswvMZM2XVBqMqrLWZfNrt8AxAowEF4Dxa6hAplqzXSw6oh+sUIpBKNGCMVB2+aBTFW8rCpA8rsWh3Ixm1xKQ2QuN8x5zxwzw2FoOjZsmSePyokxsj3LXbEXsD5L+W1mSDnqiHA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2edb1a-89c7-4b9a-105b-08dbc8d33049
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 14:22:37.6217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NgD4U5JS5fJk2UAp7nPqMZVoJzcd0QSNM7DFe9tolk8f9R4UAVPRA7Oq5TdnnogqfSfAS9RtsbiPFbqpd5zLdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6807
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 08:49:55PM +0800, Ma Ke wrote:
> In mv_platform_probe(), check the return value of clk_prepare_enable()
> and return the error code if clk_prepare_enable() returns an
> unexpected value.
>=20
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/ata/sata_mv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 45e48d653c60..df3a02e7a50b 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4125,8 +4125,10 @@ static int mv_platform_probe(struct platform_devic=
e *pdev)
>  	hpriv->clk =3D clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(hpriv->clk))
>  		dev_notice(&pdev->dev, "cannot get optional clkdev\n");
> -	else
> -		clk_prepare_enable(hpriv->clk);
> +	else {
> +		rc =3D clk_prepare_enable(hpriv->clk);
> +		goto err;
> +	}
> =20
>  	for (port =3D 0; port < n_ports; port++) {
>  		char port_number[16];
> --=20
> 2.37.2
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
