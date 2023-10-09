Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC3E7BE2E1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjJIOdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjJIOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:32:58 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AFA9E;
        Mon,  9 Oct 2023 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696861977; x=1728397977;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rkVt3ztR2twS1HBsfcA3gWwcWNs+5ICdIqBhASlpNHI=;
  b=WbpSwbx/8EXW3gmf8mGUgUqvD691Mxc79+FkUdpReGLxV+/0Zbrb2Q4u
   yXc1NtgfZ5OEZWN07IFDpgjfJW9nXsURzx1pxg2u0U38A/sO3OeUY6KYx
   hGHCyyaN9NRX2jddu6pt83l+LvzoedaTLVx3iMiWyoEiTcuq/yxINKymf
   c9KwCtOaEOQwmtXc24VSZO2/Af99EcVS2SpL0zzap6s1lQgUbb5IVDe3g
   KAdqaEiG9Lv8rQCd/jXQtJjV5tDC8um+ck1YJatKXb5BPoYbWYjSer+9n
   zwPl5DysoOjwZsCRZpmdJMgvmQmMZGZe+qY2J3NubF3QjrMe8UHitqFF5
   g==;
X-CSE-ConnectionGUID: 57xtZDrGSey0+TBy834U1g==
X-CSE-MsgGUID: 3ZT/6rJ6Rs+gKDuvovEnHA==
X-IronPort-AV: E=Sophos;i="6.03,210,1694707200"; 
   d="scan'208";a="244209660"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2023 22:32:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3QGn4JJRS0i0hxkLCyYmVyNtbFpnvqyjk7b0ge9a0vutXvENpzpr24fiL73iXfvxeBlr8BJcFoGhJh4ccBXbNO4fAcUc3jKVqhNAzLDZ3lHajILlAC5ud3i1An3r193TojVXHAbF3AZuSy546uRVgMddmXyOtcUUO1fI7qxsBm8K7YCd4aHtYlpFbKN8AbIxkrFFqR4GGRq4h9iyftICxXut74ifk/eQYRXQ7aZ1BhSQYbS7Ky0ZBYYjJdEwxjVoPy90WN4FpteajNxygseeM+CjBj/hCHYRvCNDhf1nRlxNQ1h1a0GOUsEWExDh23qIffMND/VzzlRyGziAcdHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oo5sydePOBgyE+jspN5YhQB7+N+GhA2SqT02slDBiUY=;
 b=QI0FqsF+/v0D85Py2V8NM4GE6H3Ut16MQys9QQLy2akrXC5ETbQKI6u6ixufgWZ97Rj0W1E19+HQ5HbEggIB4kswD6r6jJ/BFYWmD12OUUO6NZqNW118+/e8he3v1EOJep0a6fbw7bsAezzI2mfTXrOcNMgJ74YzpNgzXHba3cpWqy+VsSN3E/T+xE40TOqmj/pDHBviaft+e3s5AwrLrk4YE5747kXTWixBc+wyAXLmTyrN5UqumCXfQMHGvqldsZoXIS0+KVvI8pQwsNkz79n7AqX+m62j5SwZDmOQsfQ+imlDUn8dmH+w6iNSQ0tSHnVr2paCqb1ZS+tFBBKkGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo5sydePOBgyE+jspN5YhQB7+N+GhA2SqT02slDBiUY=;
 b=RwMxEoxRde4Y5skuGUbRa9icFh5quZ77T8Uo8z42Xmn8gLMM/si0a8DtzGDSlM8fXcesUCxHDlsCFcpej5p2Kuv3iPYpNYnDL5dnJ4uQcl3dnZPWnKcNN1/vvvg136VaUhPOHiqoLbO4rUOgsAvSpxWowDO3CUSCpIIRhwnXgI8=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BN0PR04MB8078.namprd04.prod.outlook.com (2603:10b6:408:15d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 14:32:53 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:32:53 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Rob Herring <robh@kernel.org>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: imx: Use device_get_match_data()
Thread-Topic: [PATCH] ata: imx: Use device_get_match_data()
Thread-Index: AQHZ+r18FCvS8aA15UaFAdH3fkfrTA==
Date:   Mon, 9 Oct 2023 14:32:52 +0000
Message-ID: <ZSQPD0xeQ3I6I/v7@x1-carbon>
References: <20231006214442.339890-1-robh@kernel.org>
In-Reply-To: <20231006214442.339890-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BN0PR04MB8078:EE_
x-ms-office365-filtering-correlation-id: 78ed62bd-4110-42fb-a9ab-08dbc8d49f0f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PGmTepDq/4FWAakk6gx3TFYZELAIg+752r4vAEfzGAR+7rcIUZZU4J0TqMczOW5Vc2ECVN2meO25m1htBj3iaJnLuyjpQzkOxLVmxqph6RbK9CukOnEtsQivrh4z/NpbYYVztkjeECoASRv4vhpHokSz4JEMYrEpGcRAlsZ4qblNULdZIuHQAePaDD72ONCO1IrzZMBAUgEbHKsELCee1UliU4rfcgihlVbtqF61PAlLb6/F/nTynsVgmFi6wpEd3YqwU+yigPs7bs5f9ejmxuARvva1bMaMamSRp6BYIzhOUmAFeX8dYcJXaTQUh5YioRkN+2/w7sxAF08K+hL8B6bz0CHb4kmxXHk7U8HFsYgWuOyRvcMYDwVBAeRVfybGbFIdaOti8YRrlA9dC4I9lJ6nSapps0rg7h3KL/yGc7Tn6NlGHRPUdNcB8K/w3CS4yNBfST1suscMzMT+qdtI1W7lD3NJv3nKSMZWPa+vwk4Vn7FkwY4E7nJlh7ieBNkkINjPF9mZRHoWZEs0tF5kEE5hI4y9+WU1ORqym2bcYkQ3AvPDUKVGFh6VUypNZiZNHSsceUUTnKymr/zIi4gP49rM6B15rO6c6lpx+SShxfstbDmtjXjij/wBBJSnW9SD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(83380400001)(6512007)(38070700005)(9686003)(71200400001)(122000001)(82960400001)(26005)(6506007)(38100700002)(6486002)(33716001)(41300700001)(91956017)(76116006)(66476007)(478600001)(66556008)(316002)(64756008)(66446008)(66946007)(6916009)(54906003)(5660300002)(8936002)(86362001)(4326008)(8676002)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ht95MvpXF/M7mLJzdVuU1Fn82k+tkILMQ8nloQfrxg849NzkcKi2SjFWLbKH?=
 =?us-ascii?Q?PBQb9zSNyalVKURJ+hlvRkt5bxhCa6YkeeI0Fj8HGttz81r/y64hJZT/owYg?=
 =?us-ascii?Q?bbf27yHjZ/ZA6s8dkB4BpYe1NpVtxSz2vgPnCGGw5/D/hAxUuyQtVEMf1Oso?=
 =?us-ascii?Q?yQGuh2a7ZerBBoS/JcpXiktCbvRy+3wvaEHg+fwQo6Gi/wzO/8JsnSYkK9Aq?=
 =?us-ascii?Q?8UjS922FLX6MBcEUVTmwoo8aeZ3cFTRMwIi7FEMJB08YEyxeaAGDJr4nbYqL?=
 =?us-ascii?Q?4Ei2PXOaxL0vEtfJXAW6bune1PZ6qPQci6J93HodEHgf3n6lrCjTQdWF6Ax9?=
 =?us-ascii?Q?NC97ZZ27cg+ebsqVIqbJ6i3w7rRHUf0Yh/359eSCp4xOQ6aBql3Z0ZASz6v/?=
 =?us-ascii?Q?ZAqvaitB5dBY7f0OckqT30SttASrlLsW9zDmSVR2JXScvSqngMC0yXAoytyY?=
 =?us-ascii?Q?tD+I4QNMI04xTdd/9577hxRBsCPUcoIt0ZzYlSx4ow9OHCDt7BKMzQ2bAlCT?=
 =?us-ascii?Q?35W6tp0LiXfzEwfJCcEJeOg/j9EJvn3slnvpv+KsH2jQZEzC/JkVhC6wsVOp?=
 =?us-ascii?Q?1l93Tyw0uVViiXYRbzeXmd/S4wiHFZjp4RqEyJIOV/HZhC6RqOCR5Kp/8XWe?=
 =?us-ascii?Q?ptrug3tPzi7phLnPvLQZeNp+FzjzsL1gm1XoZD8IndmitmomT4D4P0+SXcQy?=
 =?us-ascii?Q?8YlFbLNZ+0gXC6lJit+iEkpzJ8P6bPTitj/E3i5M7+gAnMe08p2z71HcojTC?=
 =?us-ascii?Q?F5y609wY2oMAofYNcI3ZEsh4N2jXweTy3QeUqdv2HWljvEO7PAH19xJf1M7J?=
 =?us-ascii?Q?8qy8Wpt1F9Bfjys/tR9iphcNfjW6vwvC/Lu3S5ZIiX0ufmQimYC3qGAQ36Fj?=
 =?us-ascii?Q?h8j4BBg10Trylu8ZTQqMZivxLbUz2osog+EgSeYWlQ0dSdP0Stil86xpO9S1?=
 =?us-ascii?Q?09MuCc4naCmg/Ju3fsdFOahHsJoENbWSkfJ8171OoHD+Gka1kFBf66nKJ2EV?=
 =?us-ascii?Q?l4e4nU8kJFrwYBcJeWPDXL1nN6S/oK+pYchUJT990luYZVpUXlff/QkjYDWg?=
 =?us-ascii?Q?UVxHGeIWn/lO+SUxjH0soH/JWNV3A7J61xcQR+zhTBHLwPdwJw9ELAlDFM97?=
 =?us-ascii?Q?wU5tET1anlaBw1JSyqLLUU8otxJrQHhWfMor23DLVpp1lXBmQrjbk7X5Spup?=
 =?us-ascii?Q?ZHuH8+EVWhnRxx5u6EF8k+lWnaA6GOXbcZptpqAirmY2UIFiUJ/UgfDh2Rkw?=
 =?us-ascii?Q?B8xq7cuXZRQe8AI2JIfYLGIBPwj307TWeVc2hNEec8gLvbgMeinW4LQnSAh/?=
 =?us-ascii?Q?IdrMyFXT8fmBUcaO6gxVvpOQHgmMTZVOPHrUAtJ7D/0NA2EY+5PlEEfsuO4B?=
 =?us-ascii?Q?Q0ptKDLlN2xHMAR+LbgNYAGbZQXbO7c/chXbu0GoSZvDmcSEXSj2eLC5HoFO?=
 =?us-ascii?Q?qU8pqmfxMP9nSdPtZOtLEzHlT6gRGWi7rEAxsadPPVfu9NirnUNICdc0eYBg?=
 =?us-ascii?Q?i02pP3XFgNifqQpCL2B311RvNXJtquMcpZmcNHVXbEwbgbJKpLOvx1VyMnCg?=
 =?us-ascii?Q?+8rqnjuPS73zwexurl5Y0gs1CB//wGaCkZtN2CJZucanEZ6LbdX8OUnv+29B?=
 =?us-ascii?Q?PA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <177E43F2B167D045B3B99EAE33C56E21@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?neSeCggN25s33cD6dy0D2w/SiLIXqZVSpYUq1y2nYuq4mgSWbyD0MZUeYvCt?=
 =?us-ascii?Q?OpXsZhKEzqECrg1qpFM+pMSSWjMkfZM5uXXuQ/94WqsKnR1JazDTmF5/SIIt?=
 =?us-ascii?Q?Lvvg5uWnd1ilBy7V46h/HZj88nyjZx837kXAK/m5bwVTlLkD71GGPG6OYExs?=
 =?us-ascii?Q?+5NfYOdljuK9fvttzdaXZNDjUTzaVESwlXKRg/nxmpz6Jb7OGL++8uuPDbwp?=
 =?us-ascii?Q?uRjuIC9sn5hceLxEtfoyfDnP68MWSdRJb7Nv09o4srbTWhcfoPBrvzayXcQV?=
 =?us-ascii?Q?C25lZvvIzRFHcLw6NLi81NAQSJ25BNuXrn9vZTBLZMAiKQfW29Ol/1V/NewX?=
 =?us-ascii?Q?iX/+TB6VoyvTSYxVdoTc2rbPL1EV2fPuA4S547QgQ9K5NpzJHm292Z3tJAG1?=
 =?us-ascii?Q?WHM9rnK1WkE2rKJLewiQPcJGFATGe9BCX+B6K1lGKPmj/Rp6miCk5qu1XARS?=
 =?us-ascii?Q?n39gZI4L+0gj/v+peWCdxaVlu+pKD/clJyNimZAsM6wzvZgAIABEBvKQrtF8?=
 =?us-ascii?Q?HTrrHhqvzIzRFPUQYhQmb+NpvnYfvyzJzCZsBBWseee2IOm7qoY/pLRYCnSV?=
 =?us-ascii?Q?1t8srGZBpVFoQ7DznFAJlL3nPE1vyT8EqEqC6cX/hkvPh4DzqwHXpfMjZrpp?=
 =?us-ascii?Q?56QU3qeed3LQDapXkltnuVT97YOCWRSb5niwfiPIDmWjQQRLmGY71wt/RhCj?=
 =?us-ascii?Q?APo8AxOCUwzQZbKKlhJnUJlqGlkjmL/8uJqL4YseP8sWCHgS3J0SCtjz+olb?=
 =?us-ascii?Q?8wrHwLmq8kBSXHDus6q165Z47zDjybQ2QJhT4H/fd+jynhfkQHpCGOsoQ5uY?=
 =?us-ascii?Q?2OfSg9yZePnyuofP8f5g2aUn015uTe8SxPDxDXjsLfkLN8rp23j/iooDujZH?=
 =?us-ascii?Q?OZNGe8ZoC1kTAvmU0g+gQOMDzYOpsxfen+E2bNUp6PvwVCBluj7rwoIEQM31?=
 =?us-ascii?Q?VK8hjyf3IycD/GOrCw29lQ=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ed62bd-4110-42fb-a9ab-08dbc8d49f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 14:32:53.0204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXmAyZ12YkJ9JBOoQ3Q8Il2sNvvBZnfYeWzbrCYI3Hr5FDnyMfXGkPqS2ZJMKJv2cFIELO4ahjTR6CRk6LYxkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 04:44:42PM -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/ata/ahci_imx.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 9fa005965f3b..cb768f66f0a7 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -9,10 +9,11 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/ahci_platform.h>
>  #include <linux/gpio/consumer.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>  #include <linux/libata.h>
> @@ -1050,16 +1051,11 @@ static int imx8_sata_probe(struct device *dev, st=
ruct imx_ahci_priv *imxpriv)
>  static int imx_ahci_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> -	const struct of_device_id *of_id;
>  	struct ahci_host_priv *hpriv;
>  	struct imx_ahci_priv *imxpriv;
>  	unsigned int reg_val;
>  	int ret;
> =20
> -	of_id =3D of_match_device(imx_ahci_of_match, dev);
> -	if (!of_id)
> -		return -EINVAL;
> -
>  	imxpriv =3D devm_kzalloc(dev, sizeof(*imxpriv), GFP_KERNEL);
>  	if (!imxpriv)
>  		return -ENOMEM;
> @@ -1067,7 +1063,7 @@ static int imx_ahci_probe(struct platform_device *p=
dev)
>  	imxpriv->ahci_pdev =3D pdev;
>  	imxpriv->no_device =3D false;
>  	imxpriv->first_time =3D true;
> -	imxpriv->type =3D (unsigned long)of_id->data;
> +	imxpriv->type =3D (enum ahci_imx_type)device_get_match_data(dev);
> =20
>  	imxpriv->sata_clk =3D devm_clk_get(dev, "sata");
>  	if (IS_ERR(imxpriv->sata_clk)) {
> --=20
> 2.40.1
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
