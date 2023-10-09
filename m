Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C87F7BD841
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346088AbjJIKMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346035AbjJIKMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:12:40 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B83899;
        Mon,  9 Oct 2023 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696846359; x=1728382359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vBHLeECN2FfpwevdyHHGmkek2eFUhShyesx2YbpFim8=;
  b=nqJ5DlPZrry3b9y3n71veSI8jRNmRuXWHE1v4OJwBSP7q8eK9Qymfeoy
   CyrYIpXOr575k6UbdoEyxsvdhQsL8A6YkHNjhCptRY9J+LxepG7Jqvg4f
   I3+IiG1rx7erQzwTptrOuk9ziNMVkkokoLN9wkgRgPiCYd1de9hoZG6bq
   4j5u7Sl9lgoEQYCOuooRBD8IsK9T8tfqX8nrGbU2DC9C14rmI9JSdoZ63
   tJvK7vAEWkWv5JvqTuYKQeWFvgk85JWMJqhmIBLkN/86oavTGpyTTkwPF
   84M2IHduRSGDJEnVWs7JRPAM3PcTupPcHOlAPy0zw1jSvY96e8aFv2o0y
   Q==;
X-CSE-ConnectionGUID: FVRF1gnFRf2f+qJP19Q+Yw==
X-CSE-MsgGUID: EUBWibQ/SqerpURpdMCHng==
X-IronPort-AV: E=Sophos;i="6.03,210,1694707200"; 
   d="scan'208";a="351432923"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2023 18:12:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abMD3B3zy1pHAeEtWc58cU1si6BCM5TKAYamX+K/Y9uiiUuJ9B2kxXVlU56OkUHdg8kwWb03xJ0oLboYffmpI2fmhF/4oqHvRp9eid4MO/vvsJrLxw06kENWQAvTfajMh0SZ3XuFuZYM90UT5Bg8HUJsTAtR+C6GR9D+ca7GDuB6Ei7xNV2eFRDvxBOcitmHiTe9sxfsYlkYH33ZdDv3ywqjmlEbz/5sEhYAdC3MHXjDn5U5+sD+ip6O7j0ZxOc8PPmLIFiBN+dkQ5yP8s1rxIbT/WRpjkLdYeuyetK4/zJjJjtElfnRadOceFDrYl3+17Hk5irsc8l3UGT7UPiMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrsWago6HvMGtly04Z6Sf/FREA5iQT1qQvWGYsijAok=;
 b=Mj8wlrDc0ciF1O0QqEgE37FnmAvywjxioRA5BrhrVQbJD36dJHntrl0AqdDqFnVcgpIg/MAYUiwHi49vav6mPwGVK1hvK2+zB8aEBrqUC6wbt3RnKMqXDg+SyHIPAG5IQ8fWrjHMpDj2QL8tUfeRzMFW7q/kErohMP1snI/KzzLY+OPSaChDQyyL9JStkwSJfygHl3truKPW7wdqL2Ke7DOV4RPbD4BMvCW6jAn+h8pWUYtX63MXChwnfHE+v6YarR+u1+aBqw/hdrShHeZhyo2XbY95P/6JRN6YTfeeNrzAARzn2obzzG6aYrpr1WIQDRTYj9PFHD4JgKaZ0hGwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrsWago6HvMGtly04Z6Sf/FREA5iQT1qQvWGYsijAok=;
 b=AWOGc/ZyKsl4GiI6ax5OzH5aRS7Vuly6/S5Pz7lgNBiN/KMOl45mWGxXiuIgiMBOW/C5Xh9zHmiP+YTfvkmWpXsrG/9DpjdcD3TUsoWlyA3hhgeL0Mn55nyClqCL/zSQTfqxUdREfVKTbYWm3GEyBRlmbV5KzyuIatG5ZwZ3iXg=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by PH0PR04MB8401.namprd04.prod.outlook.com (2603:10b6:510:f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 9 Oct
 2023 10:12:36 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 10:12:35 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Ma Ke <make_ruc2021@163.com>
CC:     "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: sata_mv: aspeed: fix value check in
 mv_platform_probe()
Thread-Topic: [PATCH] ata: sata_mv: aspeed: fix value check in
 mv_platform_probe()
Thread-Index: AQHZ+pkfVLu9iJm2J0SnnPjdm/WkQg==
Date:   Mon, 9 Oct 2023 10:12:35 +0000
Message-ID: <ZSPSDcPY5c1UzrM2@x1-carbon>
References: <20231007072657.4001311-1-make_ruc2021@163.com>
In-Reply-To: <20231007072657.4001311-1-make_ruc2021@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|PH0PR04MB8401:EE_
x-ms-office365-filtering-correlation-id: 0ead62f7-69da-48d4-74b2-08dbc8b04260
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YSnffouegADezRCkSL85wkAs0geNt/oPnbAZyAIyUF0xYlZhH2kvDt3UQm9oPUwI3Itb6R+CUTP7a37g1D6LPRZUnKZDyiMv08YJRDjPbCehXKRwxAtvRrlkH+e8/oDfp3IvofNItxGX3tbfjeD1wiN/ldOeX8VCaCL0KO2PiHlvvZ305AtPXyGTHnxRCzqjaILphImOGFMx9JXE/bUTwlN3+9gSpxYK6jx4lOX8TH93BzanL/RsuJ4SXVGzYHlwlHNDoqL800Voj3CFQPePClPc75TeapJE6AeLUZ1LIVO20iDYelz0cewk2JVdlKg+lvcNk1q3dXebBgz8pCDXAFm8+Tvef+ozUP1n1iA41jbC7f2oXyLGUoEg8ipsjqAY+tvriGmetRvfI3R5WE9C73IyBEPRiNnFTrIhmQgq3hSodC91tWbyG0tGKCw5LvvfUsmVblc/TlhdpR9xwouFqNiKBBkwP5gkn15DZjjdWju9kjVKAzk8uOANzdKS9/ArrdwIMQZ5KFdpx7b5JO+tPYwFZjiYXio/WwaXnaPeUM7UOyWuU9F/ZX/00nFGh6R/fJUSlasrpm4S5+tJCcwsSAmEvYIjkgvpox8/11ymRhg0TnsqKVazgX/2LsrfTu78
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66476007)(91956017)(2906002)(66946007)(66556008)(83380400001)(76116006)(64756008)(316002)(4744005)(41300700001)(478600001)(54906003)(6916009)(6512007)(66446008)(4326008)(71200400001)(5660300002)(6506007)(8676002)(26005)(9686003)(8936002)(6486002)(122000001)(82960400001)(33716001)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?emfR2YoKlx44SCC+EHj6KLLQEoeUR1VsrrrDJ9b29rDjpeb/7bm/KE/P+Wc0?=
 =?us-ascii?Q?AF1NcuK/x0D+eAlGTBea9RTbbgzTGuA6I5VavBsS4Art5pRAp9hjIE6laYqG?=
 =?us-ascii?Q?cokZVS3oeYplmj9gIrw3JhsjL1ATwBg1a47QkbJgjDFhOv6ydtPwWA6mHcNV?=
 =?us-ascii?Q?lzHmxqJtlhqBdsPEWmBIUUwoKXawptW0FWyT/6+0u7oClp7C+UNECgC5tqSp?=
 =?us-ascii?Q?Nr/Yaf4rcO0oogolDqwsWRLNFy8pK6/IripoO234x/eDwqgNFeYHRBVo0mlB?=
 =?us-ascii?Q?u9e6thhRhZy7Mj2Hfq9T61d4r1iGLBXTf+yG/eXpYsDJtwOqetrYd8JHYy2y?=
 =?us-ascii?Q?nlFapDgvdbPrcy7sA+Py5khmcauhpoG3z6ypA+BI3BTVU37PD/BWH44AgGQx?=
 =?us-ascii?Q?n24x4cNkwqr31y7LWVfEPdwopThXgmXWVAiXLh3xW8U2opR1yobB5FQTqlbI?=
 =?us-ascii?Q?WJBFF4w36sWQ89STqjHAKKlrUD48HdsWk7Cq+nlfIMFpGBSWqedXDpNERzKr?=
 =?us-ascii?Q?LFSV1P2/8JfXk3X/3rAkEpFmn7mp1tIyy54n9uhqtCf9yixL4pf+ZR+dQiJH?=
 =?us-ascii?Q?gde6yJtHzDfsx4PNIMQap2/d4JbgEuNcF+4KDvCETGsKJsV85HihlACPwJ22?=
 =?us-ascii?Q?vgh4wWJM9oGh0vZ4J2zup5LlOPkfXhnpvIrluaJObSrkYp15H/99vcmmGUjt?=
 =?us-ascii?Q?LTfxEymQb4FMLMiFuRTwtEmDW6uSj3XfHvbNOJJ5A3nN6VsXkh3fCD02+bJV?=
 =?us-ascii?Q?hh63dcv2SDLsG7LAisnr2IhLwJMFGn8gQWpwV/l5YNRDOwe1eAvLhi3GcGbD?=
 =?us-ascii?Q?fNe71J/MFdhUCzK0uSM/+T2G2ZzsG1VFFIBMrW8dXlIx9zSzzJWRFTJC2/nv?=
 =?us-ascii?Q?4qWXB1U18iJPDGCvZKPwXYX+6BRKj/+UphDPRWuBZgqR+9fQdGcfKJjzBqjs?=
 =?us-ascii?Q?vxP8NpE3jo1DLuNy/b6DRQ1DNV+qxTBlOHfJfOFHGUkp0lbCO9/gQXWZByTM?=
 =?us-ascii?Q?h4ZS3DU8RuLQeS5WtKm1gbjVRNeqYU/f1Gx2X/zZB859y0dikwZgw9NSk3sU?=
 =?us-ascii?Q?roPAYxG6NeDub3buRdAE96ev/p8BZJ5rgQz7SilidpEGPQU12j242osLoQ17?=
 =?us-ascii?Q?u/8NP5MVmGAI8SSUNDj1xNPge0Fz5alObmhNecQvtgm47NNmz+DZxrARr/Ab?=
 =?us-ascii?Q?1IfafYivyCwMARuO52qzMxK6t0ETlwv8hTgJGpNSmIn3cIWI2zQjLtbQ98e3?=
 =?us-ascii?Q?MQpwlKvU6Xh4Q9DoYV2KQ18LSKuVJogZP7XkruEpDZQK2LvXynbyQODcQIFx?=
 =?us-ascii?Q?LXsVvdyGbcM7yy9NlxQvH6y/dlo0T7T84L1rCBVhLMgHi1JnL0od9Bt5lhk0?=
 =?us-ascii?Q?n63lPVMc4n3iHutbAlbA+s0dlsDjyvMFErPSlKdaytmK8FG1ah9JgSjrVsQ4?=
 =?us-ascii?Q?ZqgOwXDzG4hDFFmdI825t5jpdg+6KTjN3H6EirA65SGvD561WUWJm9bsp07W?=
 =?us-ascii?Q?8O+ZVm5CPifW/357DpwcBWb5SKaNWZ2Mp6GZxGh2cu5dt8im9X2dhD6q1B2w?=
 =?us-ascii?Q?aHrI2RlWcP+jDrDWGhOGux6QqHEOenQmgMTPwCaVL8U1MxD7NyKBJoG47PtK?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E306AE102A72A4FA1AD8F2A6980DCF5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q0cNpu9ziuw7NxTLR/3q/VKVohoWbuFjZ56NhFJRAenlJUBXHQMxEXHh6OIgPO2JB4rSIyH3SH0vPzuW6pEZ2iNfgXhLz5ORDIoHri3g4xXoUO/XBKbYwtpdbK4XOtFZZBHhBE4PJVwq8rRiXpR6yc42bZYbR//AVEm+BSCjVWB2tIubCuQT3EOZEWjjxOtEd/evkpT1hBcBpmFvNz4pBfXTWDIpJ3/6vPPBLovWNqsUq1lEH2xKas7MRkTMM7GFXqgkliEKi/2hguRYZwjgEApOViBWHg+6xDUtYja95uDs+8hjBHydsqNzz7ezQjEhjTVouObQ7xtTJpgO3zkzBrdQ0RT6PHRa/pr0HOoSKXq1TPZtg2COxkOK63jrwsTFSrz2RenkQumk2+mJDnol1BnvqL0aitz86JG1aft/FqpvJEp3QQ47f1UEvi0YjcR9ZiLlGPXyhOlyAihlVHNvMtrGq1i70x5qOm1Il2FdYBV4Sb63QobiYaQ5R2kGjQ9z0XOiWlbUax+wh2xJ70fYfgTLDoXPu4+/rLU7aReUJPjxwQJ36FjAgOI9CQC7m08XdIrDVqT4nck2TLWHctzh7AxVDH/p2Zg7w80hOc1LHMJ9iFz0M5MwO5/z4LuwyNqFRNTW/c9zmPdYQJz49XmMc/HrTH0jCud0n8yY8B9bZyC1mIxhXKWp6OR4SFl27PhsBsdokQXVyAEhXgqHeYDja+iC7L/bnMuUEb/ZYNvO59di+qL2s2eGzcyJs0s4vJpXmPZb1GQEfT6tBA8AEEVp4pzG6fW8q3iBn794PerLNx5lzyx8J06l9x/bGHepmNaaj9X4IlnHawJWeGRKbxEn5w==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ead62f7-69da-48d4-74b2-08dbc8b04260
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 10:12:35.6340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Meh1OgxeefgqOUfvT6dKVcv3U+76gNjika/MC4EBWfiiDbaR20MfaWJ1XJSv1YS0PevGYL56Vl2gWNID9Pwh2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8401
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 03:26:57PM +0800, Ma Ke wrote:
> In mv_platform_probe(), check the return value of clk_prepare_enable()
> and return the error code if clk_prepare_enable() returns an
> unexpected value.
>=20
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/ata/sata_mv.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 45e48d653c60..96f9841aae6c 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4125,8 +4125,11 @@ static int mv_platform_probe(struct platform_devic=
e *pdev)
>  	hpriv->clk =3D clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(hpriv->clk))
>  		dev_notice(&pdev->dev, "cannot get optional clkdev\n");
> -	else
> -		clk_prepare_enable(hpriv->clk);
> +	else {
> +		rc =3D clk_prepare_enable(hpriv->clk);
> +		if (rc)
> +			return rc;

Don't you also need to call clk_put() to undo the clk_get()?

Can this error path perhaps simply do a goto err?


Kind regards,
Niklas=
