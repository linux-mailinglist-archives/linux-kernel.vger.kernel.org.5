Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAE47E9749
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjKMIFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjKMIFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:05:49 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7EB10F1;
        Mon, 13 Nov 2023 00:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699862746; x=1731398746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z5SUTEHNfmKnEd78RCEn4oIWDvZDusKaCvwgmEiW+EA=;
  b=UGFNAfAkGE5Loip95ZcxuS/ENA85KB6QaxUwn0Q4i4uTMAtv7bI50ota
   DKMH/Ap7QOKLKDyWUHsn09UU5zbyChZsS4ym/e8/hkHPTdDGABcCzMGrR
   2i4e55ZbJdgDH54ohfRFr3xfExtpN/ZG0WCEhAigMVGDm8NnTfkzc2Chb
   EDbsM4hutMRE/gwcjxmDW8DlNn9ok+3Y0sJRh9DEzDWPwpLDo1HN8mEZJ
   uBsVNmrmO5FYNq1F132Ooy5bZN39tSy8yGgd4ELR5ShQhtZoeIBlQdO82
   YDSYZ5WfSUSujUQdlkzcG27ltNrHepbqJsrLDBdY4R/6UFzzPiqPZQldJ
   g==;
X-CSE-ConnectionGUID: gr+w4fJHQdOoxN/rkdEK6A==
X-CSE-MsgGUID: kyNJRFckTZO5366JsyXOJQ==
X-IronPort-AV: E=Sophos;i="6.03,298,1694707200"; 
   d="scan'208";a="2104205"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 13 Nov 2023 16:05:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM4svnXqDeZUkZpnQCc1LklfGcgEUrHl9/bMhDRz3vbb1izFhBc3U/PyCkZbBc/ZXw66WDgc2f95tB/7WvGLlUrUTtms796liK65xb2WGLjw9NUCVAbwbXkTCg7VZTFspMjEOFRBqOid6hYcCrnM9zfINaMEbx/LsqJ+hYDdI1hSe3eHQlVaz+jxYDIpqozreV+w2Z2J3h9IvXXr/Z2blGbCfmRQLb7ugydGHcNNum6/EEIld2MgnMFybJC1cUMykobWFl7iRMV3GLmaCo/DDeI5CgvKOB/dc9ADPjCjLNWKnYDJATgv7MU/e9vQeekviidraiHZRdp/Cf6MSYgFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAfQPNZ1pETMONhSi5fq2fY/Hya8c9NoeOGY3tS+pzA=;
 b=UOHhb9TXoyis8Fp9K7lbUcntLKRImyBULqRZrKS5woych4YvYdMHuXUKxCvsL16m8rjaWFYOWXA+4WHw+sE4OH1mjaJW3gtB58Up9PS3alInMTDc6zF+bingHbdI1We5OBWq6yg0CU9m20UYozD6nGhCKAspGCzJ265q4xIqfOQnIqomw5+k9BlyAPanaV3aIeeGfIcLVii8ZdkTf3tYhEPe0UnMB/lrFQVmuiadZh75IfZZTRwWllT4gUUZ4NZctattTcUHnGgB+iClv6Wt5+CDCkXwqLMz5sEE0YPnyAWjNaRwfLTn2KK18Ug/pYyae2mCLpm0ESGAfNuVCTM6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAfQPNZ1pETMONhSi5fq2fY/Hya8c9NoeOGY3tS+pzA=;
 b=EW7J5wIJSABruJTmGyjrmEFciGMexXQuY1c0cM/gzAtYw6TZ7k3Du/Kzm69qRq9YM2aWysdumbkYExBqR8RkTYiSYG1cY+0SVw/GgnMeQuZ7K17lGhP96WM0PZo3QlZ9Gdrbe9xijhknuoIjV/GeaVXDoD1FgZyR25YkFd5IWpQ=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MN2PR04MB7039.namprd04.prod.outlook.com (2603:10b6:208:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 08:05:43 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 08:05:43 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] ata: pata_pxa: convert not to use
 dma_request_slave_channel()
Thread-Topic: [PATCH] ata: pata_pxa: convert not to use
 dma_request_slave_channel()
Thread-Index: AQHaFggyc6S1ssLuWUKPAFKZXnXfNQ==
Date:   Mon, 13 Nov 2023 08:05:42 +0000
Message-ID: <ZVHYK1rI9Z8DcKJP@x1-carbon>
References: <f177835b7f0db810a132916c8a281bbdaf47f9d3.1699801657.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <f177835b7f0db810a132916c8a281bbdaf47f9d3.1699801657.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MN2PR04MB7039:EE_
x-ms-office365-filtering-correlation-id: 378afc21-409e-49ea-b4eb-08dbe41f54fc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ybcmVYsRw1i88OlbcjEqVIFrxB/+CEB3mscVwYbhQfwVaJ2/JVIHRkj9sy5fdgN9R6KH5dOfzYJuQf1skDb5+Xegwa5825aOVGk/f7EJojdT9+lHwCPSXTdLSgNw+wcW3Kvx7DZfCaBTWOpLLMHRzUYW880ATIZLDZyN4Xq/aRyvmrtSkFZl2/MNoGh8zPb6DE63vYbbmwaJ9dJllgMN+XUVtfwRex+/F4yVUrLrL3wea1hYlbUgiOlE0DfFCm4xbFp7krwzik4j+Gaa96PaAalo+ZU8OEnb+bAfhLZeSSg+2kmnPWMe0rCLicbjZ+hnsd04mTPY1anBm9d3HxhQB3Hk1hISPIyhziyRniAdcckn5cL8PScmvjfl8Bt3S74TV/bnJBAUrWeQbuS9wW+ji7808ly4r0weZq2CAw+EMY6WLhi6xRh+M7S/uXjXfZAxZxts6ySpC/wXD3a/omkdldZdtGb04oVdAHllqWOdNlJBhCtkQXtKmq2Dlod3Tb7Yhg8Lbq8YEEh8nQSCGNILV5Ltq+wD+hg55SeCHplnaAF95GIGYkVonFcdLOAvBRQ8aNGvfHI5jsBS9nxl6UC7W6Ss63RI/AycDIplVgbVDaCk3elieK/wMjrABLY5IMoI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(64756008)(54906003)(66446008)(66476007)(66556008)(76116006)(66946007)(91956017)(6916009)(38100700002)(38070700009)(122000001)(82960400001)(86362001)(316002)(6512007)(9686003)(83380400001)(26005)(71200400001)(6506007)(33716001)(2906002)(478600001)(6486002)(5660300002)(41300700001)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rQOB3w/AdUqk7ybwsJH9GISSR3c0iDxuB3U3oKhA7XefNewVndHmpNUw7L3B?=
 =?us-ascii?Q?3vMfRufPA7HiR6BJw5zX+ZSJ0oJEusO9hgXHSyltz54va+LOfAP0APRhyBEr?=
 =?us-ascii?Q?g3NZrFnVhhp4/y3NNBGBYqBMr3B2+oJCOiEOHaUxNTJVcdXiUxSzNSgj/xGU?=
 =?us-ascii?Q?Jx/6Txdd219fHgV00I159lA67bvq8zgWxETsDONq1FKQXzYA7r2SkRRCe6Sd?=
 =?us-ascii?Q?E/JRqxO7x24vWEttM4Hs7Mq2ITFX1/uowBEhvWCr6wscaUm3YFDm5cxuxID9?=
 =?us-ascii?Q?jlk2EtfSxSpOYj7FfwzbPepuEkKSO8p0POio6hG+fXhR5wX2e+l3t65qnThi?=
 =?us-ascii?Q?QARLpoeQX0uxO99usVN5iH34E/AS9roQqjTpj3ebWQth6e3rrxQZHljabbtV?=
 =?us-ascii?Q?nWmml4njlUcKA98jb9XhgPqwtqJxsXVGyrYP8AcUnvC2kmkKBChTaOhVg5Mi?=
 =?us-ascii?Q?W+nldXo2F7vCUl+rcor7p02aHCqeJ6NIqCiytgHah1JczyGRT6AG9AJJRbTG?=
 =?us-ascii?Q?Rt/2eQjsh703kNTEH4MPavWnQpMggL66qtXoHknuA/kkSvFzQ9tu203RVDBI?=
 =?us-ascii?Q?SRTFT82mkrGnny+hEq9NS5lyf221d5dHTbktLSsFnb5zD2aIb9A/r/osUlVX?=
 =?us-ascii?Q?RoTSJojIHAZRuHXWwXkxOjnLMk8kqUpQIfB9NULmhcKS9+yc4U1uK0nQC8eG?=
 =?us-ascii?Q?BDh6id38sMW/rFpuNMRlNsJmURuslvcBeiel3dtiAjLorEPjUNpH7qxAedYq?=
 =?us-ascii?Q?/YbqnzwJ601IlNTByVk8lPvR5s+S7ueZIASgG6S8xVByxX+CCsVhguNbagVF?=
 =?us-ascii?Q?BEHLWZ5buh7e9NI0EyjAzkEsnDR4lkJ6tQJMeTawRV2FHZVWRqOM7YmzZSWG?=
 =?us-ascii?Q?taPJxXl1hinBMS1yLAGan3HQTEQxggRbwZxq8AYMaffRF5ajK4H6S2Gnktes?=
 =?us-ascii?Q?rws3iJp7elPzhx56T7CEBIySF7j193HW7v820CK5L+ZOrfqIhP2UXM9d0rz2?=
 =?us-ascii?Q?LEF+3MZQkNRqtgYp3LNv01LragxcjeC1SEXUwvsNKg8A4uukasxjuAfMhcv2?=
 =?us-ascii?Q?QIxOaQYYU2qJIKx+9OSvf0rpXQhS9WZ2eXw5yfYAD93X757O0+B8KYlgNBHS?=
 =?us-ascii?Q?4TmAirzBNqsv6bUkbIQQ2MKf71Y4SN+dLURr7iKXPs0yqaxUovfClBNM+Jmq?=
 =?us-ascii?Q?m8b0TMCO/GJhOAe8VCNWzbHjMGSrMA/1p/FimFA0wfmIa4dGEIUAI7ESkTyv?=
 =?us-ascii?Q?z9zAuAFkHLBrH3tpvF0vuRGAVZEsVpmGexxUwhLUz06bvYcKpGxRX8rm+NmU?=
 =?us-ascii?Q?TYZBMf9qbc0J6Gj6dD/qTTD0iFth6tmNo+BwM3ZrSsEEEs3FsRozpo8dmd0H?=
 =?us-ascii?Q?76/mZ2VD8WxyeTb1x2NHTZ4SWD8CmhT9CI7DAyUQRwPg1RsPD+KOc+wfbmIa?=
 =?us-ascii?Q?lUvwulPfMH/CB3f7tcp6mevuTAaNqGXbupgHx8oh1EoCMiSE1GAqbW8pxxZe?=
 =?us-ascii?Q?IiqZJRH866xjs0z+kriFMfua8oH+2XDUt7fUpJQby4aOUcc8nTzootyh56rw?=
 =?us-ascii?Q?luP/zty4Gg/AZCM2sIST7UEVkgHtlwIUUNyZiuTHpSv6S+hpvz9vnj+fC8fP?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38A623706A1B4D4582BBA6E18BCAC546@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yFPwC1LaQOxvawtBMQnAH02xgQ6w9rkoV6rgFxbhtZ7pGGSCZOcoaESreYLdBocZ7OvPY/8HEGIn76+m2uYGMI4cd9Cbd3vVeClSEPSeZ1b6ZyB73SjRt1piCvzuy3Vj9x9Tn7ClYqMV53RFodhYj9jNCSixrLLCF//k9xc3drc6q1s1McbXT3jSbeAO2wfeOpGI6qOIGylk1lslC5bfUVL5JpO+teb0MvbbKlv36BZwXiuUUXC7wgB8QmWQJXs44zD3l2V73QIPzc/xahAGZYyou/xVrF96JR+qDPg1jK2CikA/XGCvfTJqzxxeLsX6u2nLbTXcqcvXWWSThAPHNxKIBCtltv5qQoujNsJZ2oEEEOCMgXWIzcZGwltFr4ISRVvgZI1ujlSpweckUTcd9ks7UoqtYr3ggrrrhJaD1VRGAFC84+f7CwwAu8aYuIrVHvQ8H+uvbHbRPiNtEwiRq+w9Ucq8qmA8IzeoNrYnw33WdMAhHqdRR8xfu3i2lYG15F+asS7W4AYB41i+j7EHYF8F/agFH/Grbt+fpFDJ+LukLr3ZJYwu7iNkz1L24hUCMubpzlXcLPN4uYtpmNX7AE8C7iy3Tnj3wUe+rDn0B4YIPkSpqaG2yzkRTJ3Jr8auiLpUrGZEkqTWTMw9AOzqeqJrdQnfk3l8cue6mjpDdCibqEszAgql6z42fRr0x6PQA6hldaxddCeohZpUG+vN6fYvg/VTtkW5rCfz4CBWFHV7vkAvS7FlFe5vZrFEsx0xSjoiwAs7vteLmH/7OzsRRZzGmUd+AtWn5vuBQxpreltUBqRyOUE7ly6QzQ9C+lOeXwoOER4v2Zs6Bl9yLBNJKRsH8jJ2iVkFc4QDRiW0lf4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378afc21-409e-49ea-b4eb-08dbe41f54fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 08:05:42.3699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5nIljccJLy1sXq2AVB3xSU5dnD87J1JubAQzFwlDZdHH+92LfrHBx7u73UaZDz5Zebl2Skk+HkG1uWMH2g9X9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christophe,

On Sun, Nov 12, 2023 at 04:07:59PM +0100, Christophe JAILLET wrote:
> dma_request_slave_channel() is deprecated. dma_request_chan() should
> be used directly instead.
>=20
> Switch to the preferred function and update the error handling accordingl=
y.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/ata/pata_pxa.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> index 5275c6464f57..0c9c9cf63d36 100644
> --- a/drivers/ata/pata_pxa.c
> +++ b/drivers/ata/pata_pxa.c
> @@ -274,9 +274,8 @@ static int pxa_ata_probe(struct platform_device *pdev=
)
>  	/*
>  	 * Request the DMA channel
>  	 */
> -	data->dma_chan =3D
> -		dma_request_slave_channel(&pdev->dev, "data");
> -	if (!data->dma_chan)
> +	data->dma_chan =3D dma_request_chan(&pdev->dev, "data");

While the previous API could only return NULL on failure, the new API can
return an actual error.

I think we should return the actual error instead of -EBUSY.

i.e.:

if (IS_ERR(data->dma_chan))
	return PTR_ERR(data->dma_chan);


> +	if (IS_ERR(data->dma_chan))
>  		return -EBUSY;
>  	ret =3D dmaengine_slave_config(data->dma_chan, &config);
>  	if (ret < 0) {
> --=20
> 2.34.1
>=20


Kind regards,
Niklas=
