Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EB07C829B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjJMJ5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjJMJ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:57:06 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2123.outbound.protection.outlook.com [40.107.114.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D85BE;
        Fri, 13 Oct 2023 02:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSZmXGBQ1QbSAdxPzRqfOHWt3+rr38XEkByazZaHmwNhpxLufwpZHG+m73pwi0UkxhmF8qNfVvbig8I83vHndsQnosH1o0GlL52x0fq9Hx3ftRVFF0Pe3V/Pm93pPgaJYCfvyRquq7dXB5ZXt3zMMNfHoGm7oAm4uBfynLLHCEHvzCHZ95+cRjTYrXlqsVzYgEaI5M4j5Im/QZbt8GkCnlo+IGtHFqN1+P14t52l5BtdgYkvLYMwBTimTom5RH88eqYmB7irTWZ7qmI2Lx/TsWKwbin1Tr8M8C7IFJ5eZGTjS2exMfY40h0bFlywiKwh9V+lQ0hkJ2Wy/nHAUe3FaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of/FLdaoDBHEa8E79swtn2r5NFHl/EG7u4j6AmdUFao=;
 b=CC6gQEO3YBAUP1aHRHPFctYB91Z0+Mtw3/K7VG/UFlEE1+4nDQBt6Z6aD8TQnA0cXNR1CyEhW5V6l7fTfjaC6VVWA9e+vy207IG0CDGwXd+Rqr4X4zxEizhT/PalPxx3XXwUH7HJ3c1FPZJ7Hm2qPFOdrD2fW03RbEBUNHlEA2eW5vGdfc9rQ8MNu2iDyf/gIe57+TR23rV8OKg7aoIU1F2Dy/ByRq3pUqLQ3B+p6F3Cn/xtAypaqbINXw+4db1dCJ76v+d8sFhzex27avD6zx6ckst+9jSLJm07R1rSwdkOUFhOwk2MPOWz0jquQI4zdn4czxTdaAYVLupX2EVAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Of/FLdaoDBHEa8E79swtn2r5NFHl/EG7u4j6AmdUFao=;
 b=iexLm/uSopYcUnZ4i5HZVSy622b2IbjZvJM8cR85M4UVLufCSD4ucES47Dg6MNklC6Pm0YJkTNgzq5QHSf4mA+lfWMZPUF59AACyPjCRlGFQiye7h8n+5jwUrfQkCP9jbrMCVgmyMwh86mUbYw3qoOu1XrI7B2buQrZZuD5bbA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:de::5) by
 OSZP286MB1943.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.30; Fri, 13 Oct 2023 09:57:01 +0000
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc]) by TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc%7]) with mapi id 15.20.6886.030; Fri, 13 Oct 2023
 09:57:01 +0000
Date:   Fri, 13 Oct 2023 17:56:54 +0800
From:   Hongren Zheng <i@zenithal.me>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sfr@canb.auug.org.au
Subject: Re: [PATCH v2 1/1] usbip: Use platform_device_register_full()
Message-ID: <ZSkUZpMhiwweSPX5@Sun>
References: <20231006164312.3528524-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006164312.3528524-1-andriy.shevchenko@linux.intel.com>
X-Operating-System: Linux Sun 5.15.67
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: BY3PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:a03:255::11) To TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:de::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYP286MB1406:EE_|OSZP286MB1943:EE_
X-MS-Office365-Filtering-Correlation-Id: 4666718b-e5cf-4384-918e-08dbcbd2bf32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfkmf1YPnT6BVkLVBm1waZ8RDIfA2Ffl6V0Ez7RmNiYTkuNDzC/QNL57fyuiHITPECpa2l2VeXosRZMCvjQfkWvU9eQ+RtTYCBPPijCMJbNLitnH0dqRIy6LxUP+X+RbG2aZ5WgtDEbjsKhxoRBeOb8UhFSlhvC4EMcrYMmBV+xOEC/qHjPuv3wOwLncbcrwlc6CZcizQ0//1+8Urr7eQNw/8Yab6Rv/ZIaxRqTgWXpxrKx2a+bo3IdUqmB+ipseR9p6Kyc4Vm+hYlA33IZev+zqIRzaUJ4RRGaxNdVCe1asRk+Ut4SjZFiFdBAXunOqKs8OssGwYCV4uYTA57bdTUwqC3GPKcX+HpIoJP03othVPuSQbkOfbVxhkYSXgkYr1vKazkUD4c9zOsO7Cp7QfkjMT5DigvWBEzAqQ7YuO+1Wh+cyBcU1+GH/LYcCM1yLys467zD9xDJSfljUnJQNjTyqBkkvmEkoz41S6lV6D+tyrJBZxh3UZuKdD5/DOUVU5HSCdBJn/O+pFG3Z9W62cTknlsbgjg65Eiae74ibLj8jq0kf5WM9cPxti51xZ8dh0rmKmi6xO5Tpg9NH1bIEn2svO+Kku2q3e4NTRL2RXvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39830400003)(366004)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6666004)(6506007)(6512007)(9686003)(83380400001)(478600001)(5660300002)(4326008)(8676002)(2906002)(41300700001)(8936002)(966005)(6486002)(33716001)(66476007)(786003)(54906003)(316002)(66556008)(6916009)(66946007)(38100700002)(41320700001)(86362001)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L84h99eHXQpW63HAhy0VjuswnVF1YlpDUx+BP1jpoA3kSSqihiogpzvXlGUc?=
 =?us-ascii?Q?psvq2Y+295tWsuj6hcMFrcyEdDfOoUqQNpPvsDvJQapggwbfDmZH4VOfi/Q+?=
 =?us-ascii?Q?T9nA4wC81LyU74EBAChsHz0gQU9OYEMyHacJbhQg61NB3+i8EsCp0dvLPirc?=
 =?us-ascii?Q?ynZYS65HWvweHfCgjS4m/5mEIsr/9X7MjhO9/8HK79/c0NlsttxkdFpr6Re+?=
 =?us-ascii?Q?LCUEbHvcAvLRQJurUzM6f3hWlmIxlsSJEvxQiGOGC0XpPVGo4DxHiB7kiGio?=
 =?us-ascii?Q?gyMX9bH9uIUIdWI9l7qwLQD810OQDbbeBykhDWeG+k7avesKOYdAvH2Er9hB?=
 =?us-ascii?Q?KG6DHKefLqhkNan3+tjcq/MFzNKnRE5Q1bVGVWRZWjQM3HU/VhZqM+PR2Brl?=
 =?us-ascii?Q?SyiJMGKt53fnMIoE9Oqckn2YftqdPW7jl8NvXUa8r2W96V3nVePwJbIyiF+O?=
 =?us-ascii?Q?4eECQ8c47DbG0FAvM9gnubR0kIuWfAgE/wso1MQPVxleDllOSYZUiph/ukOw?=
 =?us-ascii?Q?7CPczibjRAyurd7p5PQ3/nQD3uxBIs3qg7e1Y830cmYIFqTQdtWLn3mG+ES7?=
 =?us-ascii?Q?ywRk8uJFq8Ui7CK5rRCAoI7Msc/iFo7LamPbRt6CRyVpqbCy5MEIwVME/q+7?=
 =?us-ascii?Q?QKS7p/l0l20dHsRgh8NavO4Zpmqr11tpLY1Ru/2CMKOIQ/v59OzfxvGD1wbh?=
 =?us-ascii?Q?Mhyfr3+X/z4t52Dy4oINy/BRwU/x4QgE1Z72fGj9zP4v3/zVhqBqbAB5seNX?=
 =?us-ascii?Q?tLIkOp2pBjaU7DQYbdpj2NLzR1kI2XahuCfkSsBt/xrZbE/KXiM+Sp1Zy2ct?=
 =?us-ascii?Q?QwekpDy63U7NUNPdK0/hnbg0O/gPGtr0AaF8dlr6qc7i15egSgsWgyOm95N5?=
 =?us-ascii?Q?qW3s1VoIMdTDCviGD1Hp9N9/vmcoibSXwRB5UCHDflpjwuhlLcCr/RrGjX66?=
 =?us-ascii?Q?tYoO/OayJ7os/13mSn6XytPpnlo4y90xezuOBbfH6OCgn+wIXbdD7zcVBvwM?=
 =?us-ascii?Q?G14/XO/B6sluYc8v9YOoDStZr/c+mAYb2htC+JoI9CMzODwVdjjRiZp9OoSY?=
 =?us-ascii?Q?yg9r7LCQXlYN04YLW+5rxWLKx/NoQ9RDsVoBzBSzN23/iy3+xi3N1OBVAQH9?=
 =?us-ascii?Q?9DzGIdxfPmRt5fKRyGKCjY+uAnHWCoEjHrRPZwG6K8A/Er9mLbZga80SFrj7?=
 =?us-ascii?Q?CwRe/2rxEQML+tRnojVSjQM/u64Bg35VT5NFjEOREhsoeBIUlFfp4s1ORexC?=
 =?us-ascii?Q?Ps/q5/ABnNutfmNLOXP8h6eysbn+UIn+dzCtlPpviq91gGTtNFQ8T20vwBbx?=
 =?us-ascii?Q?vQdAAOtPGnO8mJI3jUksO0hQ0cxUVqEO5LFX8UPnkM+1FEM42XC8PgtVZbx2?=
 =?us-ascii?Q?AujyK7i8jHoqNI7IK0uF2KrXkPOH5pVNBAyiH4oNPUF8Es/gXxK/bYAEJQ6+?=
 =?us-ascii?Q?KVuqNNdhwPRH8LGTBIEZLzhGxpOVK+fo77CuSVN8Ed1AkCAnQLvG69GfBWSI?=
 =?us-ascii?Q?5Dn6sSnorvoIg6EcNZHaxBKDTUUjCUU0D38ZvNi/7tIYetK0vjtPlhP4wXuC?=
 =?us-ascii?Q?x3OsVYmCaOk8eThRJ5GFxhftOaUE1rr2DsQERHu7?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 4666718b-e5cf-4384-918e-08dbcbd2bf32
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 09:57:01.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/0040w9nAjiP8D9NeUNx7T224s0mKz91qrR9EUwtxm1f2UgB+XzAgOZtSGR/9Sv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1943
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 07:43:12PM +0300, Andy Shevchenko wrote:
> The code to create the child platform device is essentially the same as
> what platform_device_register_full() does, so change over to use
> that same function to reduce duplication.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: (hopefully) fixed run-time NULL-dereference (LKP)
>  drivers/usb/usbip/vhci_hcd.c | 55 +++++++++++++-----------------------
>  1 file changed, 20 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 37d1fc34e8a5..f845b91848b9 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
  
> -	for (i = 0; i < vhci_num_controllers; i++) {
> -		void *vhci = &vhcis[i];

The void *vhci here is intended

platform_device_add_data "Add a copy of platform specific data to the
platform device's platform_data pointer"

however, vhcis is static so it is not intended to be copied (the
pdev inside struct vhci might be the cause)

> -		ret = platform_device_add_data(vhcis[i].pdev, &vhci, sizeof(void *));
> -		if (ret)
> -			goto err_driver_register;
> -	}
> -
>  	ret = platform_driver_register(&vhci_driver);
>  	if (ret)
>  		goto err_driver_register;
>  
>  	for (i = 0; i < vhci_num_controllers; i++) {
> -		ret = platform_device_add(vhcis[i].pdev);
> +		struct platform_device_info pdevinfo = {
> +			.name = driver_name,
> +			.id = i,
> +			.data = &vhcis[i],

here should be a &vhci

> +			.size_data = sizeof(void *),
> +		};
> +
> +		vhcis[i].pdev = platform_device_register_full(&pdevinfo);
> +		ret = PTR_ERR_OR_ZERO(vhcis[i].pdev);
>  }
> -- 
> 2.40.0.1.gaa8946217a0b

I have reproduced the boot error reported by syzbot in
https://lore.kernel.org/linux-usb/00000000000029242706077f3145@google.com/
https://lore.kernel.org/linux-usb/0000000000007634c1060793197c@google.com/

and adding back void *vhci fixed it

I'll send a patch.
