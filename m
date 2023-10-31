Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD677DD832
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346557AbjJaWXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344925AbjJaWXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:23:32 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58D9ED;
        Tue, 31 Oct 2023 15:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtL1LTeDfnXCZahCU3nvEVELUJjKOL222abcMgH/6aAC3MaOuNeRk+6Ds8//MLFGyIM+LI3l+jdIBGBbb7yCnl1pcy6VmUO+DQk5FW/5KYEtjxWkiUOmQ7jzHT+pVQCoTsr1Q/uflCkvMnw9ujKp0YDYYO7YGkrs27WhyOP3jX0sVb4z1OWkWEefljOtDqUx+MkpxpKGm2VMOWmmlL6kdgAqik8R4HsAc/9SKO/opboXQ8k/wrkOr1qNFGsLL0zh/ZV82fXeiHmVQ3mKD6pWEgyzYmPEQLoIDwp8XWdO8fSL4Z3CHNqrsMBaKbHk96+mze/Gv/OkNYEpPBu8Sn5JUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwmDfUftkCp3KZ4DRMaBhEWZc4SY/fhI84BHL0BoZEU=;
 b=c750mGibptGK/CXRE7apLLgDU7fJXSIJzH9KCyq3w7P4KFwRGC3hyGbliWVmyBTEbVsgojdUufbuU6MJm0L6B1yOn+ndzgDJGFrhIayasfKLmUAC1s9hr+S6GTJjNF6Xnq0NAqGIgDMuoYPN4AfO7hp8hZ4d9QDWjH8OV5DZnuY/hQBBaDwq2uEKoBSb3F7B+m5stxJ01PRfyumXIz9zAgqNDYyoPsw0cr+HMM7u/Dgz6n1AYoSbnQQYClk7OkEK0krTLGtSXUmDlSTWOvuSzRtunHx1gqP+JvEkdiZ85LjCimKhcJbYNMCmvTTvb4UgUfoE3GcpYdRsjKSA14e43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwmDfUftkCp3KZ4DRMaBhEWZc4SY/fhI84BHL0BoZEU=;
 b=pR5woHYWmR1bZHg7XpJV1JsOltwPRNCvl+bfb/wFHaoyeR60UK22RleN49/q618JoknB6wXUQJ3smE7Si7MYJL4fcHf8HIDMnvHnf+wfBJs6cDl2pSojvKNFCHCUMktViPQeqD3BQSEe+P0GStFAGSYvTTLxqjvGQGsN9sYWLgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by GV1PR08MB7898.eurprd08.prod.outlook.com (2603:10a6:150:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 31 Oct
 2023 22:23:20 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::87b4:3635:b89d:c07c]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::87b4:3635:b89d:c07c%6]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 22:23:20 +0000
Message-ID: <6f98b471-b139-4043-a8ab-e7a9f9608d60@wolfvision.net>
Date:   Tue, 31 Oct 2023 23:23:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Content-Language: en-US
To:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com
References: <cover.1698666612.git.mehdi.djait@bootlin.com>
 <f7367726eb077d43446c83591ecbf9acbc77ef5f.1698666612.git.mehdi.djait@bootlin.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <f7367726eb077d43446c83591ecbf9acbc77ef5f.1698666612.git.mehdi.djait@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0026.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::13) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|GV1PR08MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8a3eeb-3e3c-457a-04f7-08dbda5ffcc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smiPvEs9gZnyu5caw+rsL5u4c3MQlK7qqis09S1lKlikDf/S5T3aaW2V1I2kpJ96gL+buxoSLK/DjpF+a5es4clcCmt/wgviEtikXD1cuC9XCNJoD0zV62JuXUruksHSgVZZ7fSTvfEDJkfr40uJTYjz3q3HOwSNKa50uxm1/bSJ1F2uqi43YI53J21FIcHsKowv7f4DlirisUq3UZCpKmurpeyF77/BH7sZTmdOO5TQV2uTbY5e4LSh/pQLmCIT3ULDk+fxgc2uLIIr1Jd8/rLrIkGcrCUns6nXqERLVlnKOeTbY3sMuwoclaX3kSyKxR2wEvx6tnpbaSrukDIQZiB8BZSq+B4i7EqYYVN+kUitPTK8S/cKHznpJv6JlJ9lQ8V0Igz2WUUi+dsB3AiIVDpjAmJ/JXsxJFGAqiDbhH4OHc8kgraI5bsCOyVkjbCz+a0C4gBphZsHEGlojvIRjdIHSP/qgnJTokAl/lNb7AJGaLRGsYfS3aLg2Tw+0GPzmB1cykIYfmS4Yqrug2jvu4YXj/JIXdCeXAeT/laDA/xCPL8OfrBQ7rReaYW8Xd8jc2E6mD3MMz0h+Di1TaRCOB1wSlpxdhgVQtF3j4t1KtbbD9Kt/k6Taija+XEAUBLKboTUtFhVit8vxWLcRWmGMu4364C+dOBW6Llcl4G/NUM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39850400004)(396003)(366004)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(31696002)(38100700002)(36756003)(30864003)(7416002)(41300700001)(86362001)(2906002)(6506007)(6512007)(6666004)(478600001)(6486002)(2616005)(31686004)(83380400001)(53546011)(316002)(66946007)(66556008)(66476007)(4326008)(8936002)(8676002)(44832011)(5660300002)(461764006)(45980500001)(43740500002)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RC82dTkyNzl5dVVOcTZsWWdZa3ZjbXB4MHlyblE1TnA4TXIvakxzVVlodkJv?=
 =?utf-8?B?OERwSGoxTkhRZHhWRUtBYkEyN3BmN21pbGQzUTVOM3NadjlJUVd3VWd2dW9N?=
 =?utf-8?B?Q0hTQlpwWGp1Y1NlY29BazVkMGpoMXBXWlBCTys1RFFUQTE1K3NMSHVqQnlH?=
 =?utf-8?B?Vm0zVkdmdEZ6M3FzT2lnaEgzOVhyTVR0S3hwbmhzSXhFRFNzQmRwQWZQMWly?=
 =?utf-8?B?cWRvUVJhYTBBQjhub0F0YURnaE45amtoZ1pJRTRmMlhxRUNIaUtTTC9LMklO?=
 =?utf-8?B?OUZyeTZXeFZ5RDZSemorL2gvVGtIS2FEYzZGSWpWVjNvL05iUU9aRXA0aWQ0?=
 =?utf-8?B?Y0t2NDJhSlB5eGVqc1RJTjVoYzNEd0VsYUh3NHNzTGE4aUphOURSOU9ncEQy?=
 =?utf-8?B?TXJ2Rlh6eWp0OTRhVFh1Mkl6RDV5WDBUVHhMMGVMd1BwUWZxNEEwaWxMREtn?=
 =?utf-8?B?Ti9zWmN6OElzeVZIblF6YVp4bFRuUEtqQ25CalBmVU8wWnp2TWFoZFJLS09Z?=
 =?utf-8?B?R0JvUFlSbWZMVWRFcUVTUkp0TVpVYmZOMi9DdzE1UG5Ba0VVVW5BN2FTL0hS?=
 =?utf-8?B?T01ubEhtWmFMQmdBZGhzNkNxMjI5SUNSWUVZR2tyRGJGd3g2UEx2NnFRdmJh?=
 =?utf-8?B?WUVkczVNbWlJVjRIV0FZRkFnRFNkWTYyai9NM1NUVVVkZXRSMWZCck05TEdW?=
 =?utf-8?B?amducmtWMHl4Y2x6b2NpcTkwYzhYMG51ekloSlMrcnAxV0htaTFGWStORWE3?=
 =?utf-8?B?eEVCNGM3NmdwNjkrRmN3QU5EQ0w2L3lOK2lmdnlIRkUvQllGWGNqajI0VFpB?=
 =?utf-8?B?TXU5d0Zwc1hIK3QzeW9KdXBtdVJCeFJNU0FHSkJjcXpwRGZqUmJFclJqVGRa?=
 =?utf-8?B?N3VXQVR3SXl6S1IzRE81VWRRT2o4OFlGNERENlFheEhidy9kRmZtempvQlgv?=
 =?utf-8?B?NzZtZFVrUlRiV0NKZThpZ0JPa3lhem00aDlZNW55bzNFd1MvRlJHMThodkUz?=
 =?utf-8?B?RGhFUU8vOWhhRXFTRDNMNFJvUEdVZ1NFUjBiM2RYK28vSE5CUXJPV1FJRXNi?=
 =?utf-8?B?S1hoc0JzZnRKL1ducWtYQXhWNTBqRkxBbGdKWXZvTWFmMDI4WFlERmJHbWV3?=
 =?utf-8?B?Q0RPV0ozMWt0eERPV2FCVUgxNWZweWRwSVd5b29Bdk5hWkgvTlRKeUd4RlZ0?=
 =?utf-8?B?QVl1eUNqZ3Myb2FVTlBWTFpBQjZWODVUUkd6VHR4b0F1SEJEb3VtbWs5enNu?=
 =?utf-8?B?dXpxMUt6N1ZYeHBsUnJROEc0ZmFBTFR4bDFWVGQ0and3QXM5aUpFaVMwU0Rr?=
 =?utf-8?B?OHJsYnA3Ykt5d0xBK2ZTUVpOMTRKSXRXSEZVeEJPYzg2NnQrQTI0Wm03YjEy?=
 =?utf-8?B?NXRmSU85K2VZTy9aSk1aY0hjbzE3QXVoc0lGbVlDTjQ3RURjd3pYRE5qZW9x?=
 =?utf-8?B?L1dWWSsxOGt5LzZUYi9nS0lIY0J0bDJJYkthK2lPd2UzRDZiMFBMeGtFUGVl?=
 =?utf-8?B?NkJHbUlFOE42M0NOcDNiK0htNHN1YW10cVhKMVgzbEVIOWdwbTVWUWhhbEVU?=
 =?utf-8?B?MDRibHAvR1NCR014eE5wK3gwenZHY1UxdHlxNGpWbGN0SWVGZFpKZWVOZ1NT?=
 =?utf-8?B?Zk1YUW85YVlNeC9BRFJuaFhHQ0lOTUN5WnBhMzZHNHdTSlZvR3VNeFovYXJL?=
 =?utf-8?B?eFRBSGZFejEyT0FVc3pINEFOYXBVallFd3hyWkVCMmVIdmlmczkyVFlxTkZ6?=
 =?utf-8?B?ZnQrT3YrUS9pNjRibEVrZnNFdWpReW9NQTBIb0E1RitibEc5emNKcExXRmZq?=
 =?utf-8?B?RzA0WmlpZy9ZK0hVUnJJYnFnTVljZ0dVZFZRbll2bUI2RHJPMWNQUVV0UDNR?=
 =?utf-8?B?dzdiRm5iVnUzUHZQd0UvM0NMbytSdUJXUDkwWXNablJKdVRnTllmOC9NRG5w?=
 =?utf-8?B?b0s4b3Z4V2tmcHcxSjJzZXdFVWd0SDJ4N21WbXlMVU5qb1IrbTBYZW9Wc25q?=
 =?utf-8?B?MFJxZ0lEdmQxR2MwT1Rhc3laRjk0U1ZMNDYxQ0xJMjNHQmMxb2lIV2U2V3ox?=
 =?utf-8?B?N1Z1K2JzU0hORklWSU5VT2p3NW5kR0pSRlB5T0xGRXJaMnlSaHJFTi9OdE4x?=
 =?utf-8?B?cnU3Z2VnZy9kMnIvZS9QVVEyQ2xUWFpMWEVDelpzT1BRR3laUTJWTW9panpL?=
 =?utf-8?B?S0U4VCtWT0lFQlh4NElnR3c1Vk1RaE1yaXphRlB2SnFaQXBjSG1Ic1V4dnI1?=
 =?utf-8?B?Z2dvaHN4V1BzK01FUkplZDhyQW9RPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8a3eeb-3e3c-457a-04f7-08dbda5ffcc3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 22:23:20.2099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uM6y95shtWo967egBdUWvyc8tEvL/2XIbeNzjWfK51obbcroxCXKPmV6E6fZfKQa+0Nw8mPnK816nhbYUojs4bGVEcTqCFSidXdfFyvlXYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7898
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

Thanks for your work! Please find a few comments inline:

On 10/30/23 13:25, Mehdi Djait wrote:
> Introduce a video node-centric driver for the Rockchip CIF

Missing period at the end of the sentence.

> This controller supports multiple interfaces, but for now only
> the BT.656 interface could be tested, hence it's the only one
> that's supported in the first version of this driver.
> 
> This controller can be found on RK3066, PX30, RK1808, RK3128 and RK3288,
> but for now it's only been tested on the PX30.
> 
> Most of this driver was written following the BSP driver from rockchip,
> removing the parts that either didn't fit correctly the guidelines, or
> that couldn't be tested.
> 
> This basic version doesn't support cropping nor scaling, and is only
> designed with one SDTV video decoder being attached to it a any time.
> 
> This version uses the "pingpong" mode of the controller, which is a
> double-buffering mechanism.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> ---
>  MAINTAINERS                                   |    7 +
>  drivers/media/platform/rockchip/Kconfig       |    1 +
>  drivers/media/platform/rockchip/Makefile      |    1 +
>  drivers/media/platform/rockchip/cif/Kconfig   |   13 +
>  drivers/media/platform/rockchip/cif/Makefile  |    3 +
>  drivers/media/platform/rockchip/cif/capture.c | 1156 +++++++++++++++++
>  drivers/media/platform/rockchip/cif/dev.c     |  293 +++++
>  drivers/media/platform/rockchip/cif/dev.h     |  142 ++
>  drivers/media/platform/rockchip/cif/regs.h    |  192 +++
>  9 files changed, 1808 insertions(+)
>  create mode 100644 drivers/media/platform/rockchip/cif/Kconfig
>  create mode 100644 drivers/media/platform/rockchip/cif/Makefile
>  create mode 100644 drivers/media/platform/rockchip/cif/capture.c
>  create mode 100644 drivers/media/platform/rockchip/cif/dev.c
>  create mode 100644 drivers/media/platform/rockchip/cif/dev.h
>  create mode 100644 drivers/media/platform/rockchip/cif/regs.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2e69b642609..83ea760e0450 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18523,6 +18523,13 @@ F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
>  F:	drivers/hid/hid-roccat*
>  F:	include/linux/hid-roccat*
>  
> +ROCKCHIP CIF DRIVER
> +M:	Mehdi Djait <mehdi.djait@bootlin.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml
> +F:	drivers/media/platform/rockchip/cif/
> +
>  ROCKCHIP CRYPTO DRIVERS
>  M:	Corentin Labbe <clabbe@baylibre.com>
>  L:	linux-crypto@vger.kernel.org
> diff --git a/drivers/media/platform/rockchip/Kconfig b/drivers/media/platform/rockchip/Kconfig
> index b41d3960c1b4..faaaae15b3ea 100644
> --- a/drivers/media/platform/rockchip/Kconfig
> +++ b/drivers/media/platform/rockchip/Kconfig
> @@ -4,3 +4,4 @@ comment "Rockchip media platform drivers"
>  
>  source "drivers/media/platform/rockchip/rga/Kconfig"
>  source "drivers/media/platform/rockchip/rkisp1/Kconfig"
> +source "drivers/media/platform/rockchip/cif/Kconfig"
> diff --git a/drivers/media/platform/rockchip/Makefile b/drivers/media/platform/rockchip/Makefile
> index 4f782b876ac9..fb24ff7bf63c 100644
> --- a/drivers/media/platform/rockchip/Makefile
> +++ b/drivers/media/platform/rockchip/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y += rga/
>  obj-y += rkisp1/
> +obj-y += cif/
> diff --git a/drivers/media/platform/rockchip/cif/Kconfig b/drivers/media/platform/rockchip/cif/Kconfig
> new file mode 100644
> index 000000000000..68fc50c51f1c
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/Kconfig
> @@ -0,0 +1,13 @@
> +config VIDEO_ROCKCHIP_CIF
> +	tristate "Rockchip CIF Video Camera Interface"
> +	depends on VIDEO_DEV
> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> +	depends on V4L_PLATFORM_DRIVERS
> +	depends on PM && COMMON_CLK
> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_FWNODE
> +	select VIDEO_V4L2_SUBDEV_API
> +	help
> +	  This is a driver for Rockchip SoC Camera interface. It supports
> +	  parallel interfaces such as BT.656. This camera interface is both
> +	  called VIP and CIF.
> diff --git a/drivers/media/platform/rockchip/cif/Makefile b/drivers/media/platform/rockchip/cif/Makefile
> new file mode 100644
> index 000000000000..e44ef687aeb6
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_VIDEO_ROCKCHIP_CIF) += rockchip-cif.o
> +rockchip-cif-objs += dev.o capture.o
> diff --git a/drivers/media/platform/rockchip/cif/capture.c b/drivers/media/platform/rockchip/cif/capture.c
> new file mode 100644
> index 000000000000..44dac450452c
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/capture.c
> @@ -0,0 +1,1156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip CIF Camera Interface Driver
> + *
> + * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2020 Maxime Chevallier <maxime.chevallier@bootlin.com>
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +
> +#include <media/v4l2-common.h>
> +#include <media/v4l2-fh.h>
> +#include <media/v4l2-fwnode.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/v4l2-mc.h>
> +#include <media/v4l2-subdev.h>
> +#include <media/videobuf2-dma-contig.h>
> +
> +#include "dev.h"
> +#include "regs.h"
> +
> +#define CIF_REQ_BUFS_MIN	2
> +#define CIF_MIN_WIDTH		64
> +#define CIF_MIN_HEIGHT		64
> +#define CIF_MAX_WIDTH		8192
> +#define CIF_MAX_HEIGHT		8192
> +
> +#define CIF_PLANE_Y		0
> +#define CIF_PLANE_UV		1
> +
> +static struct cif_output_fmt out_fmts[] = {
> +	{
> +		.fourcc = V4L2_PIX_FMT_NV16,
> +		.fmt_val = CIF_FORMAT_YUV_OUTPUT_422 |
> +			   CIF_FORMAT_UV_STORAGE_ORDER_UVUV,
> +		.cplanes = 2,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_NV61,
> +		.fmt_val = CIF_FORMAT_YUV_OUTPUT_422 |
> +			   CIF_FORMAT_UV_STORAGE_ORDER_VUVU,
> +		.cplanes = 2,
> +	},
> +	{
> +		.fourcc = V4L2_PIX_FMT_NV12,
> +		.fmt_val = CIF_FORMAT_YUV_OUTPUT_420 |
> +			   CIF_FORMAT_UV_STORAGE_ORDER_UVUV,
> +		.cplanes = 2,
> +	},
> +	{
> +		.fourcc = V4L2_PIX_FMT_NV21,
> +		.fmt_val = CIF_FORMAT_YUV_OUTPUT_420 |
> +			   CIF_FORMAT_UV_STORAGE_ORDER_VUVU,
> +		.cplanes = 2,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_RGB24,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_RGB565,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_BGR666,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SRGGB8,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SGRBG8,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SGBRG8,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SBGGR8,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SRGGB10,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SGRBG10,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SGBRG10,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SBGGR10,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SRGGB12,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SGRBG12,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SGBRG12,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SBGGR12,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_SBGGR16,
> +		.cplanes = 1,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_Y16,
> +		.cplanes = 1,
> +	}
> +};
> +
> +static const struct cif_input_fmt in_fmts[] = {
> +	{
> +		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
> +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
> +		.fmt_type	= CIF_FMT_TYPE_YUV,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
> +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
> +		.fmt_type	= CIF_FMT_TYPE_YUV,
> +		.field		= V4L2_FIELD_INTERLACED,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
> +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
> +		.fmt_type	= CIF_FMT_TYPE_YUV,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
> +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
> +		.fmt_type	= CIF_FMT_TYPE_YUV,
> +		.field		= V4L2_FIELD_INTERLACED,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
> +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_UYVY,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
> +		.fmt_type	= CIF_FMT_TYPE_YUV,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
> +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_UYVY,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
> +		.fmt_type	= CIF_FMT_TYPE_YUV,
> +		.field		= V4L2_FIELD_INTERLACED,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
> +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_VYUY,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
> +		.fmt_type	= CIF_FMT_TYPE_YUV,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
> +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_VYUY,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
> +		.fmt_type	= CIF_FMT_TYPE_YUV,
> +		.field		= V4L2_FIELD_INTERLACED,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_SBGGR8_1X8,
> +		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_8,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW8,
> +		.fmt_type	= CIF_FMT_TYPE_RAW,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_SGBRG8_1X8,
> +		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_8,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW8,
> +		.fmt_type	= CIF_FMT_TYPE_RAW,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_SGRBG8_1X8,
> +		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_8,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW8,
> +		.fmt_type	= CIF_FMT_TYPE_RAW,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_SRGGB8_1X8,
> +		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_8,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW8,
> +		.fmt_type	= CIF_FMT_TYPE_RAW,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
> +		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_10,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW10,
> +		.fmt_type	= CIF_FMT_TYPE_RAW,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_SGBRG10_1X10,
> +		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_10,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW10,
> +		.fmt_type	= CIF_FMT_TYPE_RAW,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_SGRBG10_1X10,
> +		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_10,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW10,
> +		.fmt_type	= CIF_FMT_TYPE_RAW,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_SRGGB10_1X10,
> +		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_10,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW10,
> +		.fmt_type	= CIF_FMT_TYPE_RAW,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_SBGGR12_1X12,
> +		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_12,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW12,
> +		.fmt_type	= CIF_FMT_TYPE_RAW,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_SGBRG12_1X12,
> +		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_12,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW12,
> +		.fmt_type	= CIF_FMT_TYPE_RAW,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_SGRBG12_1X12,
> +		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_12,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW12,
> +		.fmt_type	= CIF_FMT_TYPE_RAW,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_SRGGB12_1X12,
> +		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_12,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW12,
> +		.fmt_type	= CIF_FMT_TYPE_RAW,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_RGB888_1X24,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RGB888,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_Y8_1X8,
> +		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_8,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW8,
> +		.fmt_type	= CIF_FMT_TYPE_RAW,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_Y10_1X10,
> +		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_10,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW10,
> +		.fmt_type	= CIF_FMT_TYPE_RAW,
> +		.field		= V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	= MEDIA_BUS_FMT_Y12_1X12,
> +		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_12,
> +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW12,
> +		.fmt_type	= CIF_FMT_TYPE_RAW,
> +		.field		= V4L2_FIELD_NONE,
> +	}
> +};
> +
> +static const struct
> +cif_input_fmt *get_input_fmt(struct v4l2_subdev *sd)
> +{
> +	struct v4l2_subdev_format fmt;
> +	u32 i;
> +
> +	fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> +	fmt.pad = 0;
> +	v4l2_subdev_call(sd, pad, get_fmt, NULL, &fmt);
> +
> +	for (i = 0; i < ARRAY_SIZE(in_fmts); i++)
> +		if (fmt.format.code == in_fmts[i].mbus_code &&
> +		    fmt.format.field == in_fmts[i].field)
> +			return &in_fmts[i];
> +
> +	v4l2_err(sd->v4l2_dev, "remote's mbus code not supported\n");
> +	return NULL;
> +}
> +
> +static struct
> +cif_output_fmt *find_output_fmt(struct cif_stream *stream, u32 pixelfmt)
> +{
> +	struct cif_output_fmt *fmt;
> +	u32 i;
> +
> +	for (i = 0; i < ARRAY_SIZE(out_fmts); i++) {
> +		fmt = &out_fmts[i];
> +		if (fmt->fourcc == pixelfmt)
> +			return fmt;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct cif_buffer *cif_get_buffer(struct cif_stream *stream)
> +{
> +	struct cif_buffer *buff;
> +
> +	lockdep_assert_held(&stream->vbq_lock);
> +
> +	if (list_empty(&stream->buf_head))
> +		return NULL;
> +
> +	buff = list_first_entry(&stream->buf_head, struct cif_buffer, queue);
> +	list_del(&buff->queue);
> +
> +	return buff;
> +}
> +
> +static int cif_init_buffers(struct cif_stream *stream)
> +{
> +	struct cif_device *cif_dev = stream->cifdev;
> +	unsigned long lock_flags = 0;
> +
> +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> +
> +	stream->buffs[0] = cif_get_buffer(stream);
> +	stream->buffs[1] = cif_get_buffer(stream);
> +
> +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> +
> +	if (!(stream->buffs[0]) || !(stream->buffs[1]))
> +		return -EINVAL;
> +
> +	stream->drop_frame = false;
> +
> +	cif_write(cif_dev, CIF_FRM0_ADDR_Y,
> +		  stream->buffs[0]->buff_addr[CIF_PLANE_Y]);
> +	cif_write(cif_dev, CIF_FRM0_ADDR_UV,
> +		  stream->buffs[0]->buff_addr[CIF_PLANE_UV]);
> +
> +	cif_write(cif_dev, CIF_FRM1_ADDR_Y,
> +		  stream->buffs[1]->buff_addr[CIF_PLANE_Y]);
> +	cif_write(cif_dev, CIF_FRM1_ADDR_UV,
> +		  stream->buffs[1]->buff_addr[CIF_PLANE_UV]);
> +
> +	return 0;
> +}
> +
> +static void cif_assign_new_buffer_pingpong(struct cif_stream *stream)
> +{
> +	struct cif_device *cif_dev = stream->cifdev;
> +	struct cif_buffer *buffer = NULL;
> +	u32 frm_addr_y, frm_addr_uv;
> +	unsigned long lock_flags = 0;
> +
> +	stream->drop_frame = false;
> +
> +	/* Set up an empty buffer for the next frame. */
> +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> +
> +	buffer = cif_get_buffer(stream);
> +
> +	/*
> +	 * In Pinpong mode:

Typo: missing "g" in Pingpong

> +	 * After one frame0 captured, CIF will start to capture the next frame1
> +	 * automatically.
> +	 *
> +	 * If there is no buffer:
> +	 * 1. Make the next frame0 write to the buffer of frame1.
> +	 *
> +	 * 2. Drop the frame1: Don't return it to user-space, as it will be
> +	 *    overwritten by the next frame0.
> +	 */
> +	if (!buffer) {
> +		stream->drop_frame = true;
> +		buffer = stream->buffs[1 - stream->frame_phase];
> +	}
> +
> +	stream->buffs[stream->frame_phase] = buffer;
> +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> +
> +	frm_addr_y = stream->frame_phase ? CIF_FRM1_ADDR_Y : CIF_FRM0_ADDR_Y;
> +	frm_addr_uv = stream->frame_phase ? CIF_FRM1_ADDR_UV : CIF_FRM0_ADDR_UV;
> +
> +	cif_write(cif_dev, frm_addr_y, buffer->buff_addr[CIF_PLANE_Y]);
> +	cif_write(cif_dev, frm_addr_uv, buffer->buff_addr[CIF_PLANE_UV]);
> +}
> +
> +static void cif_stream_stop(struct cif_stream *stream)
> +{
> +	struct cif_device *cif_dev = stream->cifdev;
> +	u32 val;
> +
> +	val = cif_read(cif_dev, CIF_CTRL);
> +	cif_write(cif_dev, CIF_CTRL, val & (~CIF_CTRL_ENABLE_CAPTURE));
> +	cif_write(cif_dev, CIF_INTEN, 0x0);
> +	cif_write(cif_dev, CIF_INTSTAT, 0x3ff);
> +	cif_write(cif_dev, CIF_FRAME_STATUS, 0x0);
> +
> +	stream->stopping = false;
> +}
> +
> +static int cif_queue_setup(struct vb2_queue *queue,
> +			   unsigned int *num_buffers,
> +			   unsigned int *num_planes,
> +			   unsigned int sizes[],
> +			   struct device *alloc_devs[])
> +{
> +	struct cif_stream *stream = queue->drv_priv;
> +	const struct v4l2_pix_format *pix;
> +
> +	pix = &stream->pix;
> +
> +	if (*num_planes) {
> +		if (*num_planes != 1)
> +			return -EINVAL;
> +
> +		if (sizes[0] < pix->sizeimage)
> +			return -EINVAL;
> +		return 0;
> +	}
> +
> +	*num_planes = 1;
> +
> +	sizes[0] = pix->sizeimage;
> +
> +	*num_buffers = CIF_REQ_BUFS_MIN;
> +
> +	return 0;
> +}
> +
> +static void cif_buf_queue(struct vb2_buffer *vb)
> +{
> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +	struct cif_buffer *cifbuf = to_cif_buffer(vbuf);
> +	struct vb2_queue *queue = vb->vb2_queue;
> +	struct cif_stream *stream = queue->drv_priv;
> +	struct v4l2_pix_format *pix = &stream->pix;
> +	unsigned long lock_flags = 0;
> +	int i;
> +
> +	struct cif_output_fmt *fmt = stream->cif_fmt_out;
> +
> +	memset(cifbuf->buff_addr, 0, sizeof(cifbuf->buff_addr));
> +
> +	cifbuf->buff_addr[0] = vb2_dma_contig_plane_dma_addr(vb, 0);
> +
> +	for (i = 0; i < fmt->cplanes - 1; i++)
> +		cifbuf->buff_addr[i + 1] = cifbuf->buff_addr[i] +
> +			pix->bytesperline * pix->height;
> +
> +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> +	list_add_tail(&cifbuf->queue, &stream->buf_head);
> +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> +}
> +
> +static void cif_return_all_buffers(struct cif_stream *stream,
> +				   enum vb2_buffer_state state)
> +{
> +	struct cif_buffer *buf;
> +	unsigned long lock_flags = 0;
> +
> +	if (stream->buffs[0]) {
> +		vb2_buffer_done(&stream->buffs[0]->vb.vb2_buf, state);
> +		stream->buffs[0] = NULL;
> +	}
> +
> +	if (stream->buffs[1]) {
> +		if (!stream->drop_frame)
> +			vb2_buffer_done(&stream->buffs[1]->vb.vb2_buf, state);
> +
> +		stream->buffs[1] = NULL;
> +	}
> +
> +	while (!list_empty(&stream->buf_head)) {
> +		spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> +
> +		buf = cif_get_buffer(stream);
> +		vb2_buffer_done(&buf->vb.vb2_buf, state);
> +
> +		spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> +	}
> +}
> +
> +static void cif_stop_streaming(struct vb2_queue *queue)
> +{
> +	struct cif_stream *stream = queue->drv_priv;
> +	struct cif_device *cif_dev = stream->cifdev;
> +	struct v4l2_subdev *sd;
> +	int ret;
> +
> +	stream->stopping = true;
> +	ret = wait_event_timeout(stream->wq_stopped,
> +				 !stream->stopping,
> +				 msecs_to_jiffies(1000));
> +	if (!ret) {
> +		cif_stream_stop(stream);
> +		stream->stopping = false;
> +	}
> +	pm_runtime_put(cif_dev->dev);
> +
> +	/* Stop the sub device. */
> +	sd = cif_dev->remote.sd;
> +	v4l2_subdev_call(sd, video, s_stream, 0);
> +
> +	cif_return_all_buffers(stream, VB2_BUF_STATE_ERROR);
> +}
> +
> +static inline u32 cif_scl_ctl(struct cif_stream *stream)
> +{
> +	u32 fmt_type = stream->cif_fmt_in->fmt_type;
> +
> +	return (fmt_type == CIF_FMT_TYPE_YUV) ?
> +		CIF_SCL_CTRL_ENABLE_YUV_16BIT_BYPASS :
> +		CIF_SCL_CTRL_ENABLE_RAW_16BIT_BYPASS;
> +}
> +
> +static int cif_stream_start(struct cif_stream *stream)
> +{
> +	u32 val, mbus_flags, href_pol, vsync_pol,
> +	    xfer_mode = 0, yc_swap = 0;
> +	struct cif_device *cif_dev = stream->cifdev;
> +	struct cif_remote *remote_info;
> +	int ret;
> +	u32 input_mode;
> +
> +	remote_info = &cif_dev->remote;
> +	stream->frame_idx = 0;
> +	input_mode = (remote_info->std == V4L2_STD_NTSC) ?
> +		      CIF_FORMAT_INPUT_MODE_NTSC :
> +		      CIF_FORMAT_INPUT_MODE_PAL;
> +	mbus_flags = remote_info->mbus.bus.parallel.flags;
> +	href_pol = (mbus_flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH) ?
> +			0 : CIF_FORMAT_HSY_LOW_ACTIVE;
> +	vsync_pol = (mbus_flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH) ?
> +			CIF_FORMAT_VSY_HIGH_ACTIVE : 0;
> +
> +	val = vsync_pol | href_pol | input_mode | stream->cif_fmt_out->fmt_val |
> +	      stream->cif_fmt_in->dvp_fmt_val | xfer_mode | yc_swap;
> +	cif_write(cif_dev, CIF_FOR, val);
> +
> +	val = stream->pix.width;
> +	if (stream->cif_fmt_in->fmt_type == CIF_FMT_TYPE_RAW)
> +		val = stream->pix.width * 2;
> +
> +	cif_write(cif_dev, CIF_VIR_LINE_WIDTH, val);
> +	cif_write(cif_dev, CIF_SET_SIZE,
> +		  stream->pix.width | (stream->pix.height << 16));
> +
> +	cif_write(cif_dev, CIF_FRAME_STATUS, CIF_FRAME_STAT_CLS);
> +	cif_write(cif_dev, CIF_INTSTAT, CIF_INTSTAT_CLS);
> +	cif_write(cif_dev, CIF_SCL_CTRL, cif_scl_ctl(stream));
> +
> +	ret = cif_init_buffers(stream);
> +	if (ret)
> +		return ret;
> +
> +	cif_write(cif_dev, CIF_INTEN, CIF_INTEN_FRAME_END_EN |
> +				      CIF_INTEN_LINE_ERR_EN |
> +				      CIF_INTEN_PST_INF_FRAME_END_EN);
> +
> +	cif_write(cif_dev, CIF_CTRL, CIF_CTRL_AXI_BURST_16 |
> +				     CIF_CTRL_MODE_PINGPONG |
> +				     CIF_CTRL_ENABLE_CAPTURE);
> +
> +	return 0;
> +}
> +
> +static int cif_start_streaming(struct vb2_queue *queue, unsigned int count)
> +{
> +	struct cif_stream *stream = queue->drv_priv;
> +	struct cif_device *cif_dev = stream->cifdev;
> +	struct v4l2_device *v4l2_dev = &cif_dev->v4l2_dev;
> +	struct v4l2_subdev *sd;
> +	int ret;
> +
> +	if (!cif_dev->remote.sd) {
> +		ret = -ENODEV;
> +		v4l2_err(v4l2_dev, "No remote subdev detected\n");
> +		goto destroy_buf;
> +	}
> +
> +	ret = pm_runtime_get_sync(cif_dev->dev);
> +	if (ret < 0) {
> +		v4l2_err(v4l2_dev, "Failed to get runtime pm, %d\n", ret);
> +		goto destroy_buf;
> +	}
> +
> +	sd = cif_dev->remote.sd;
> +	stream->cif_fmt_in = get_input_fmt(cif_dev->remote.sd);
> +
> +	ret = cif_stream_start(stream);
> +	if (ret < 0)
> +		goto stop_stream;
> +
> +	ret = v4l2_subdev_call(sd, video, s_stream, 1);
> +	if (ret < 0)
> +		goto runtime_put;
> +
> +	return 0;
> +
> +runtime_put:
> +	pm_runtime_put(cif_dev->dev);
> +stop_stream:
> +	cif_stream_stop(stream);
> +destroy_buf:
> +	cif_return_all_buffers(stream, VB2_BUF_STATE_QUEUED);
> +
> +	return ret;
> +}
> +
> +static const struct vb2_ops cif_vb2_ops = {
> +	.queue_setup = cif_queue_setup,
> +	.buf_queue = cif_buf_queue,
> +	.wait_prepare = vb2_ops_wait_prepare,
> +	.wait_finish = vb2_ops_wait_finish,
> +	.stop_streaming = cif_stop_streaming,
> +	.start_streaming = cif_start_streaming,
> +};
> +
> +static int cif_init_vb2_queue(struct vb2_queue *q,
> +			      struct cif_stream *stream)
> +{
> +	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	q->io_modes = VB2_MMAP | VB2_DMABUF;
> +	q->drv_priv = stream;
> +	q->ops = &cif_vb2_ops;
> +	q->mem_ops = &vb2_dma_contig_memops;
> +	q->buf_struct_size = sizeof(struct cif_buffer);
> +	q->min_buffers_needed = CIF_REQ_BUFS_MIN;
> +	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> +	q->lock = &stream->vlock;
> +	q->dev = stream->cifdev->dev;
> +
> +	return vb2_queue_init(q);
> +}
> +
> +static void cif_update_pix(struct cif_stream *stream,
> +			   struct cif_output_fmt *fmt,
> +			   struct v4l2_pix_format *pix)
> +{
> +	struct cif_remote *remote_info = &stream->cifdev->remote;
> +	struct v4l2_subdev_format sd_fmt;
> +	u32 width, height;
> +
> +	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> +	sd_fmt.pad = 0;
> +	v4l2_subdev_call(remote_info->sd, pad, get_fmt, NULL, &sd_fmt);
> +
> +	width = clamp_t(u32, sd_fmt.format.width,
> +			CIF_MIN_WIDTH, CIF_MAX_WIDTH);
> +	height = clamp_t(u32, sd_fmt.format.height,
> +			 CIF_MIN_HEIGHT, CIF_MAX_HEIGHT);
> +
> +	pix->width = width;
> +	pix->height = height;
> +	pix->field = sd_fmt.format.field;
> +	pix->colorspace = sd_fmt.format.colorspace;
> +	pix->ycbcr_enc = sd_fmt.format.ycbcr_enc;
> +	pix->quantization = sd_fmt.format.quantization;
> +	pix->xfer_func = sd_fmt.format.xfer_func;
> +
> +	v4l2_fill_pixfmt(pix, fmt->fourcc, pix->width, pix->height);
> +}
> +
> +static int cif_set_fmt(struct cif_stream *stream,
> +		       struct v4l2_pix_format *pix)
> +{
> +	struct cif_device *cif_dev = stream->cifdev;
> +	struct v4l2_subdev_format sd_fmt;
> +	struct cif_output_fmt *fmt;
> +	int ret;
> +
> +	if (vb2_is_streaming(&stream->buf_queue))
> +		return -EBUSY;
> +
> +	fmt = find_output_fmt(stream, pix->pixelformat);
> +	if (!fmt)
> +		fmt = &out_fmts[0];
> +
> +	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> +	sd_fmt.pad = 0;
> +	sd_fmt.format.width = pix->width;
> +	sd_fmt.format.height = pix->height;
> +
> +	ret = v4l2_subdev_call(cif_dev->remote.sd, pad, set_fmt, NULL, &sd_fmt);
> +
> +	cif_update_pix(stream, fmt, pix);
> +	stream->pix = *pix;
> +	stream->cif_fmt_out = fmt;
> +
> +	return ret;
> +}
> +
> +void cif_set_default_format(struct cif_device *cif_dev)
> +{
> +	struct cif_stream *stream = &cif_dev->stream;
> +	struct v4l2_pix_format pix;
> +
> +	cif_dev->remote.std = V4L2_STD_NTSC;
> +
> +	pix.pixelformat = V4L2_PIX_FMT_NV12;
> +	pix.width = CIF_DEFAULT_WIDTH;
> +	pix.height = CIF_DEFAULT_HEIGHT;
> +
> +	cif_set_fmt(stream, &pix);
> +}
> +
> +void cif_stream_init(struct cif_device *cif_dev)
> +{
> +	struct cif_stream *stream = &cif_dev->stream;
> +	struct v4l2_pix_format pix;
> +
> +	memset(stream, 0, sizeof(*stream));
> +	memset(&pix, 0, sizeof(pix));
> +	stream->cifdev = cif_dev;
> +
> +	INIT_LIST_HEAD(&stream->buf_head);
> +	spin_lock_init(&stream->vbq_lock);
> +	init_waitqueue_head(&stream->wq_stopped);
> +}
> +
> +static const struct v4l2_file_operations cif_fops = {
> +	.open = v4l2_fh_open,
> +	.release = vb2_fop_release,
> +	.unlocked_ioctl = video_ioctl2,
> +	.poll = vb2_fop_poll,
> +	.mmap = vb2_fop_mmap,
> +};
> +
> +static int cif_enum_input(struct file *file, void *priv,
> +			  struct v4l2_input *input)
> +{
> +	struct cif_stream *stream = video_drvdata(file);
> +	struct v4l2_subdev *sd = stream->cifdev->remote.sd;
> +	int ret;
> +
> +	if (input->index > 0)
> +		return -EINVAL;
> +
> +	ret = v4l2_subdev_call(sd, video, g_input_status, &input->status);
> +	if (ret)
> +		return ret;
> +
> +	strscpy(input->name, "Camera", sizeof(input->name));
> +	input->type = V4L2_INPUT_TYPE_CAMERA;
> +	input->std = stream->vdev.tvnorms;
> +	input->capabilities = V4L2_IN_CAP_STD;
> +
> +	return 0;
> +}
> +
> +static int cif_try_fmt_vid_cap(struct file *file, void *fh,
> +			       struct v4l2_format *f)
> +{
> +	struct cif_stream *stream = video_drvdata(file);
> +	struct cif_output_fmt *fmt;
> +
> +	fmt = find_output_fmt(stream, f->fmt.pix.pixelformat);
> +	if (!fmt)
> +		fmt = &out_fmts[0];
> +
> +	cif_update_pix(stream, fmt, &f->fmt.pix);
> +
> +	return 0;
> +}
> +
> +static int cif_g_std(struct file *file, void *fh, v4l2_std_id *norm)
> +{
> +	struct cif_stream *stream = video_drvdata(file);
> +	struct cif_remote *remote_info = &stream->cifdev->remote;
> +
> +	*norm = remote_info->std;
> +
> +	return 0;
> +}
> +
> +static int cif_s_std(struct file *file, void *fh, v4l2_std_id norm)
> +{
> +	struct cif_stream *stream = video_drvdata(file);
> +	struct cif_remote *remote_info = &stream->cifdev->remote;
> +	int ret;
> +
> +	if (norm == remote_info->std)
> +		return 0;
> +
> +	if (vb2_is_busy(&stream->buf_queue))
> +		return -EBUSY;
> +
> +	ret = v4l2_subdev_call(remote_info->sd, video, s_std, norm);
> +	if (ret)
> +		return ret;
> +
> +	remote_info->std = norm;
> +
> +	/* S_STD will update the format since that depends on the standard. */
> +	cif_update_pix(stream, stream->cif_fmt_out, &stream->pix);
> +
> +	return 0;
> +}
> +
> +static int cif_querystd(struct file *file, void *fh, v4l2_std_id *a)
> +{
> +	struct cif_stream *stream = video_drvdata(file);
> +	struct cif_remote *remote_info = &stream->cifdev->remote;
> +
> +	*a = V4L2_STD_UNKNOWN;
> +
> +	return v4l2_subdev_call(remote_info->sd, video, querystd, a);
> +}
> +
> +static int cif_enum_fmt_vid_cap(struct file *file, void *priv,
> +				struct v4l2_fmtdesc *f)
> +{
> +	struct cif_output_fmt *fmt = NULL;
> +
> +	if (f->index >= ARRAY_SIZE(out_fmts))
> +		return -EINVAL;
> +
> +	fmt = &out_fmts[f->index];
> +	f->pixelformat = fmt->fourcc;
> +
> +	return 0;
> +}
> +
> +static int cif_s_fmt_vid_cap(struct file *file,
> +			     void *priv, struct v4l2_format *f)
> +{
> +	struct cif_stream *stream = video_drvdata(file);
> +	int ret;
> +
> +	if (vb2_is_busy(&stream->buf_queue))
> +		return -EBUSY;
> +
> +	ret = cif_set_fmt(stream, &f->fmt.pix);
> +
> +	return ret;
> +}
> +
> +static int cif_g_fmt_vid_cap(struct file *file, void *fh,
> +			     struct v4l2_format *f)
> +{
> +	struct cif_stream *stream = video_drvdata(file);
> +
> +	f->fmt.pix = stream->pix;
> +
> +	return 0;
> +}
> +
> +static int cif_querycap(struct file *file, void *priv,
> +			struct v4l2_capability *cap)
> +{
> +	struct cif_stream *stream = video_drvdata(file);
> +	struct device *dev = stream->cifdev->dev;
> +
> +	strscpy(cap->driver, dev->driver->name, sizeof(cap->driver));
> +	strscpy(cap->card, dev->driver->name, sizeof(cap->card));
> +	snprintf(cap->bus_info, sizeof(cap->bus_info),
> +		 "platform:%s", dev_name(dev));
> +
> +	return 0;
> +}
> +
> +static int cif_enum_framesizes(struct file *file, void *fh,
> +			       struct v4l2_frmsizeenum *fsize)
> +{
> +	struct cif_stream *stream = video_drvdata(file);
> +	struct cif_device *cif_dev = stream->cifdev;
> +	struct v4l2_subdev_frame_size_enum fse = {
> +		.index = fsize->index,
> +		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
> +	};
> +	struct cif_output_fmt *fmt;
> +	int ret;
> +
> +	if (!cif_dev->remote.sd)
> +		return -ENODEV;
> +
> +	fmt = find_output_fmt(stream, fsize->pixel_format);
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	fse.code = fmt->mbus;
> +
> +	ret = v4l2_subdev_call(cif_dev->remote.sd, pad, enum_frame_size,
> +			       NULL, &fse);
> +	if (ret)
> +		return ret;
> +
> +	fsize->type = V4L2_FRMSIZE_TYPE_DISCRETE;
> +	fsize->discrete.width = fse.max_width;
> +	fsize->discrete.height = fse.max_height;
> +
> +	return 0;
> +}
> +
> +static int cif_enum_frameintervals(struct file *file, void *fh,
> +				   struct v4l2_frmivalenum *fival)
> +{
> +	struct cif_stream *stream = video_drvdata(file);
> +	struct cif_device *cif_dev = stream->cifdev;
> +	struct v4l2_subdev_frame_interval_enum fie = {
> +		.index = fival->index,
> +		.width = fival->width,
> +		.height = fival->height,
> +		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
> +	};
> +	struct cif_output_fmt *fmt;
> +	int ret;
> +
> +	if (!cif_dev->remote.sd)
> +		return -ENODEV;
> +
> +	fmt = find_output_fmt(stream, fival->pixel_format);
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	fie.code = fmt->mbus;
> +
> +	ret = v4l2_subdev_call(cif_dev->remote.sd, pad, enum_frame_interval,
> +			       NULL, &fie);
> +	if (ret)
> +		return ret;
> +
> +	fival->type = V4L2_FRMSIZE_TYPE_DISCRETE;
> +	fival->discrete = fie.interval;
> +
> +	return 0;
> +}
> +
> +static int cif_g_input(struct file *file, void *fh, unsigned int *i)
> +{
> +	*i = 0;
> +	return 0;
> +}
> +
> +static int cif_s_input(struct file *file, void *fh, unsigned int i)
> +{
> +	if (i)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int cif_g_parm(struct file *file, void *priv, struct v4l2_streamparm *p)
> +{
> +	struct cif_stream *stream = video_drvdata(file);
> +	struct cif_device *cif_dev = stream->cifdev;
> +
> +	if (!cif_dev->remote.sd)
> +		return -ENODEV;
> +
> +	return v4l2_g_parm_cap(video_devdata(file), cif_dev->remote.sd, p);
> +}
> +
> +static int cif_s_parm(struct file *file, void *priv, struct v4l2_streamparm *p)
> +{
> +	struct cif_stream *stream = video_drvdata(file);
> +	struct cif_device *cif_dev = stream->cifdev;
> +
> +	if (!cif_dev->remote.sd)
> +		return -ENODEV;
> +
> +	return v4l2_s_parm_cap(video_devdata(file), cif_dev->remote.sd, p);
> +}
> +
> +static const struct v4l2_ioctl_ops cif_v4l2_ioctl_ops = {
> +	.vidioc_reqbufs = vb2_ioctl_reqbufs,
> +	.vidioc_querybuf = vb2_ioctl_querybuf,
> +	.vidioc_create_bufs = vb2_ioctl_create_bufs,
> +	.vidioc_qbuf = vb2_ioctl_qbuf,
> +	.vidioc_expbuf = vb2_ioctl_expbuf,
> +	.vidioc_dqbuf = vb2_ioctl_dqbuf,
> +	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
> +	.vidioc_streamon = vb2_ioctl_streamon,
> +	.vidioc_streamoff = vb2_ioctl_streamoff,
> +
> +	.vidioc_g_std = cif_g_std,
> +	.vidioc_s_std = cif_s_std,
> +	.vidioc_querystd = cif_querystd,
> +
> +	.vidioc_enum_fmt_vid_cap = cif_enum_fmt_vid_cap,
> +	.vidioc_try_fmt_vid_cap = cif_try_fmt_vid_cap,
> +	.vidioc_s_fmt_vid_cap = cif_s_fmt_vid_cap,
> +	.vidioc_g_fmt_vid_cap = cif_g_fmt_vid_cap,
> +	.vidioc_querycap = cif_querycap,
> +	.vidioc_enum_framesizes = cif_enum_framesizes,
> +	.vidioc_enum_frameintervals = cif_enum_frameintervals,
> +
> +	.vidioc_enum_input = cif_enum_input,
> +	.vidioc_g_input = cif_g_input,
> +	.vidioc_s_input = cif_s_input,
> +
> +	.vidioc_g_parm = cif_g_parm,
> +	.vidioc_s_parm = cif_s_parm,
> +};
> +
> +void cif_unregister_stream_vdev(struct cif_device *cif_dev)
> +{
> +	struct cif_stream *stream = &cif_dev->stream;
> +
> +	media_entity_cleanup(&stream->vdev.entity);
> +	video_unregister_device(&stream->vdev);
> +}
> +
> +int cif_register_stream_vdev(struct cif_device *cif_dev)
> +{
> +	struct cif_stream *stream = &cif_dev->stream;
> +	struct v4l2_device *v4l2_dev = &cif_dev->v4l2_dev;
> +	struct video_device *vdev = &stream->vdev;
> +	int ret;
> +
> +	strscpy(vdev->name, CIF_VIDEODEVICE_NAME, sizeof(vdev->name));
> +	mutex_init(&stream->vlock);
> +
> +	vdev->ioctl_ops = &cif_v4l2_ioctl_ops;
> +	vdev->release = video_device_release_empty;
> +	vdev->fops = &cif_fops;
> +	vdev->minor = -1;
> +	vdev->v4l2_dev = v4l2_dev;
> +	vdev->lock = &stream->vlock;
> +	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE |
> +			    V4L2_CAP_STREAMING;
> +	vdev->tvnorms = V4L2_STD_NTSC | V4L2_STD_PAL;
> +	video_set_drvdata(vdev, stream);
> +	vdev->vfl_dir = VFL_DIR_RX;
> +	stream->pad.flags = MEDIA_PAD_FL_SINK;
> +
> +	cif_init_vb2_queue(&stream->buf_queue, stream);
> +
> +	vdev->queue = &stream->buf_queue;
> +	strscpy(vdev->name, KBUILD_MODNAME, sizeof(vdev->name));
> +
> +	ret = media_entity_pads_init(&vdev->entity, 1, &stream->pad);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
> +	if (ret < 0)
> +		v4l2_err(v4l2_dev,
> +			 "video_register_device failed with error %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void cif_vb_done(struct cif_stream *stream,
> +			struct vb2_v4l2_buffer *vb_done)
> +{
> +	vb2_set_plane_payload(&vb_done->vb2_buf, 0,
> +			      stream->pix.sizeimage);
> +	vb_done->vb2_buf.timestamp = ktime_get_ns();
> +	vb_done->sequence = stream->frame_idx;
> +	vb2_buffer_done(&vb_done->vb2_buf, VB2_BUF_STATE_DONE);
> +}
> +
> +static void cif_reset_stream(struct cif_device *cif_dev)
> +{
> +	u32 ctl = cif_read(cif_dev, CIF_CTRL);
> +
> +	cif_write(cif_dev, CIF_CTRL, ctl & (~CIF_CTRL_ENABLE_CAPTURE));
> +	cif_write(cif_dev, CIF_CTRL, ctl | CIF_CTRL_ENABLE_CAPTURE);
> +}
> +
> +irqreturn_t cif_irq_pingpong(int irq, void *ctx)
> +{
> +	struct device *dev = ctx;
> +	struct cif_device *cif_dev = dev_get_drvdata(dev);
> +	struct cif_stream *stream = &cif_dev->stream;
> +	unsigned int intstat;
> +

No need for a blank line here IMHO.

> +	u32 lastline, lastpix, ctl, cif_frmst;
> +
> +	intstat = cif_read(cif_dev, CIF_INTSTAT);
> +	cif_frmst = cif_read(cif_dev, CIF_FRAME_STATUS);
> +	lastline = CIF_FETCH_Y_LAST_LINE(cif_read(cif_dev, CIF_LAST_LINE));
> +	lastpix =  CIF_FETCH_Y_LAST_LINE(cif_read(cif_dev, CIF_LAST_PIX));
> +	ctl = cif_read(cif_dev, CIF_CTRL);
> +
> +	/*
> +	 * There are two irqs enabled:
> +	 *  - PST_INF_FRAME_END: cif FIFO is ready,
> +	 *    this is prior to FRAME_END
> +	 *  - FRAME_END: cif has saved frame to memory,
> +	 *    a frame ready
> +	 */
> +
> +	if (intstat & CIF_INTSTAT_PST_INF_FRAME_END) {
> +		cif_write(cif_dev, CIF_INTSTAT,
> +			  CIF_INTSTAT_PST_INF_FRAME_END_CLR);
> +
> +		if (stream->stopping)
> +			/* To stop CIF ASAP, before FRAME_END irq. */
> +			cif_write(cif_dev, CIF_CTRL,
> +				  ctl & (~CIF_CTRL_ENABLE_CAPTURE));
> +	}
> +
> +	if (intstat & CIF_INTSTAT_PRE_INF_FRAME_END)
> +		cif_write(cif_dev, CIF_INTSTAT, CIF_INTSTAT_PRE_INF_FRAME_END);
> +
> +	if (intstat & (CIF_INTSTAT_LINE_ERR | CIF_INTSTAT_PIX_ERR)) {
> +		v4l2_err(&cif_dev->v4l2_dev,
> +			 "LINE_ERR OR PIX_ERR detected, stream will be reset");
> +		cif_write(cif_dev, CIF_INTSTAT, CIF_INTSTAT_LINE_ERR |
> +						CIF_INTSTAT_PIX_ERR);
> +		cif_reset_stream(cif_dev);
> +	}
> +
> +	if (intstat & CIF_INTSTAT_FRAME_END) {
> +		struct vb2_v4l2_buffer *vb_done = NULL;
> +
> +		cif_write(cif_dev, CIF_INTSTAT, CIF_INTSTAT_FRAME_END_CLR |
> +						CIF_INTSTAT_LINE_END_CLR);
> +
> +		if (stream->stopping) {
> +			cif_stream_stop(stream);
> +			wake_up(&stream->wq_stopped);
> +			return IRQ_HANDLED;
> +		}
> +
> +		if (lastline != stream->pix.height) {
> +			v4l2_err(&cif_dev->v4l2_dev,
> +				 "Bad frame, irq:%#x frmst:%#x size:%dx%d\n",
> +				 intstat, cif_frmst, lastpix, lastline);
> +
> +			cif_reset_stream(cif_dev);
> +		}
> +
> +		if (cif_frmst & CIF_INTSTAT_F0_READY)
> +			stream->frame_phase = 0;
> +		else if (cif_frmst & CIF_INTSTAT_F1_READY)
> +			stream->frame_phase = 1;
> +		else
> +			return IRQ_HANDLED;
> +
> +		vb_done = &stream->buffs[stream->frame_phase]->vb;
> +		if (!stream->drop_frame) {
> +			cif_vb_done(stream, vb_done);
> +			stream->frame_idx++;
> +		}
> +
> +		cif_assign_new_buffer_pingpong(stream);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> diff --git a/drivers/media/platform/rockchip/cif/dev.c b/drivers/media/platform/rockchip/cif/dev.c
> new file mode 100644
> index 000000000000..3edb8ba0bf11
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/dev.c
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip CIF Camera Interface Driver
> + *
> + * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2020 Maxime Chevallier <maxime.chevallier@bootlin.com>
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#include "linux/platform_device.h"
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/reset.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <media/v4l2-fwnode.h>
> +
> +#include "dev.h"
> +#include "regs.h"
> +
> +static int subdev_notifier_complete(struct v4l2_async_notifier *notifier)
> +{
> +	struct cif_device *cif_dev;
> +	struct v4l2_subdev *sd;
> +	int ret;
> +
> +	cif_dev = container_of(notifier, struct cif_device, notifier);
> +	sd = cif_dev->remote.sd;
> +
> +	mutex_lock(&cif_dev->media_dev.graph_mutex);
> +
> +	ret = v4l2_device_register_subdev_nodes(&cif_dev->v4l2_dev);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret = media_create_pad_link(&sd->entity, 0,
> +				    &cif_dev->stream.vdev.entity, 0,
> +				    MEDIA_LNK_FL_ENABLED);
> +	if (ret)
> +		dev_err(cif_dev->dev, "failed to create link");
> +
> +unlock:
> +	mutex_unlock(&cif_dev->media_dev.graph_mutex);
> +	return ret;
> +}
> +
> +static int subdev_notifier_bound(struct v4l2_async_notifier *notifier,
> +				 struct v4l2_subdev *subdev,
> +				 struct v4l2_async_connection *asd)
> +{
> +	struct cif_device *cif_dev = container_of(notifier,
> +						  struct cif_device, notifier);
> +
> +	int pad;
> +
> +	cif_dev->remote.sd = subdev;
> +	pad = media_entity_get_fwnode_pad(&subdev->entity, subdev->fwnode,
> +					  MEDIA_PAD_FL_SOURCE);
> +	if (pad < 0)
> +		return pad;
> +
> +	cif_dev->remote.pad = pad;
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_async_notifier_operations subdev_notifier_ops = {
> +	.bound = subdev_notifier_bound,
> +	.complete = subdev_notifier_complete,
> +};
> +
> +static int cif_subdev_notifier(struct cif_device *cif_dev)
> +{
> +	struct v4l2_async_notifier *ntf = &cif_dev->notifier;
> +	struct device *dev = cif_dev->dev;
> +	struct v4l2_async_connection *asd;
> +	struct v4l2_fwnode_endpoint vep = {
> +		.bus_type = V4L2_MBUS_PARALLEL,
> +	};
> +	struct fwnode_handle *ep;
> +	int ret;
> +
> +	v4l2_async_nf_init(ntf, &cif_dev->v4l2_dev);
> +
> +	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
> +					     FWNODE_GRAPH_ENDPOINT_NEXT);
> +	if (!ep)
> +		return -EINVAL;
> +
> +	ret = v4l2_fwnode_endpoint_parse(ep, &vep);
> +	if (ret)
> +		return ret;
> +
> +	asd = v4l2_async_nf_add_fwnode_remote(ntf, ep,
> +					      struct v4l2_async_connection);
> +	if (IS_ERR(asd)) {
> +		ret = PTR_ERR(asd);
> +		return ret;
> +	}
> +
> +	ntf->ops = &subdev_notifier_ops;
> +
> +	fwnode_handle_put(ep);
> +
> +	ret = v4l2_async_nf_register(ntf);
> +	return ret;
> +}
> +
> +static struct clk_bulk_data px30_cif_clks[] = {
> +	{ .id = "aclk", },
> +	{ .id = "hclk", },
> +	{ .id = "pclk", },
> +};
> +
> +static const struct cif_match_data px30_cif_match_data = {
> +	.clks = px30_cif_clks,
> +	.clks_num = ARRAY_SIZE(px30_cif_clks),
> +};
> +
> +static const struct of_device_id cif_plat_of_match[] = {
> +	{
> +		.compatible = "rockchip,px30-vip",
> +		.data = &px30_cif_match_data,
> +	},
> +	{},
> +};
> +
> +static int cif_get_resource(struct platform_device *pdev,
> +			    struct cif_device *cif_dev)
> +{
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev,
> +			"Unable to allocate resources for device\n");
> +		return -ENODEV;
> +	}
> +
> +	cif_dev->base_addr = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(cif_dev->base_addr))
> +		return PTR_ERR(cif_dev->base_addr);
> +
> +	return 0;
> +}
> +
> +static int cif_plat_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct v4l2_device *v4l2_dev;
> +	struct cif_device *cif_dev;
> +	int ret, irq;
> +
> +	cif_dev = devm_kzalloc(dev, sizeof(*cif_dev), GFP_KERNEL);
> +	if (!cif_dev)
> +		return -ENOMEM;
> +
> +	cif_dev->match_data = of_device_get_match_data(dev);
> +	if (!cif_dev->match_data)
> +		return -ENODEV;
> +
> +	platform_set_drvdata(pdev, cif_dev);
> +	cif_dev->dev = dev;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, cif_irq_pingpong, 0,
> +			       dev_driver_string(dev), dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "request irq failed\n");
> +
> +	cif_dev->irq = irq;
> +
> +	ret = cif_get_resource(pdev, cif_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_clk_bulk_get(dev, cif_dev->match_data->clks_num,
> +				cif_dev->match_data->clks);
> +	if (ret)
> +		return ret;
> +
> +	cif_dev->cif_rst = devm_reset_control_array_get(dev, false, false);
> +	if (IS_ERR(cif_dev->cif_rst))
> +		return PTR_ERR(cif_dev->cif_rst);
> +
> +	/* Initialize the stream. */
> +	cif_stream_init(cif_dev);

I think the function name says it all, no need for a comment IMHO :-)

> +	strscpy(cif_dev->media_dev.model, "cif",
> +		sizeof(cif_dev->media_dev.model));
> +	cif_dev->media_dev.dev = &pdev->dev;
> +	v4l2_dev = &cif_dev->v4l2_dev;
> +	v4l2_dev->mdev = &cif_dev->media_dev;
> +	strscpy(v4l2_dev->name, "rockchip-cif", sizeof(v4l2_dev->name));
> +
> +	ret = v4l2_device_register(cif_dev->dev, &cif_dev->v4l2_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	media_device_init(&cif_dev->media_dev);
> +
> +	ret = media_device_register(&cif_dev->media_dev);
> +	if (ret < 0)
> +		goto err_unreg_v4l2_dev;
> +
> +	/* Create & register platform subdev. */
> +	ret = cif_register_stream_vdev(cif_dev);
> +	if (ret < 0)
> +		goto err_unreg_media_dev;
> +
> +	ret = cif_subdev_notifier(cif_dev);
> +	if (ret < 0) {
> +		v4l2_err(&cif_dev->v4l2_dev,
> +			 "Failed to register subdev notifier(%d)\n", ret);
> +		cif_unregister_stream_vdev(cif_dev);
> +		goto err_unreg_media_dev;
> +	}
> +
> +	cif_set_default_format(cif_dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	return 0;
> +
> +err_unreg_media_dev:
> +	media_device_unregister(&cif_dev->media_dev);
> +err_unreg_v4l2_dev:
> +	v4l2_device_unregister(&cif_dev->v4l2_dev);
> +	return ret;
> +}
> +
> +static int cif_plat_remove(struct platform_device *pdev)
> +{
> +	struct cif_device *cif_dev = platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +
> +	media_device_unregister(&cif_dev->media_dev);
> +	v4l2_device_unregister(&cif_dev->v4l2_dev);
> +	cif_unregister_stream_vdev(cif_dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cif_runtime_suspend(struct device *dev)
> +{
> +	struct cif_device *cif_dev = dev_get_drvdata(dev);
> +
> +	clk_bulk_disable_unprepare(cif_dev->match_data->clks_num,
> +				   cif_dev->match_data->clks);
> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +
> +static int __maybe_unused cif_runtime_resume(struct device *dev)
> +{
> +	struct cif_device *cif_dev = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pinctrl_pm_select_default_state(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return clk_bulk_prepare_enable(cif_dev->match_data->clks_num,
> +				       cif_dev->match_data->clks);
> +}
> +
> +static const struct dev_pm_ops cif_plat_pm_ops = {
> +	.runtime_suspend = cif_runtime_suspend,
> +	.runtime_resume	 = cif_runtime_resume,
> +};
> +
> +static struct platform_driver cif_plat_drv = {
> +	.driver = {
> +		   .name = CIF_DRIVER_NAME,
> +		   .of_match_table = cif_plat_of_match,
> +		   .pm = &cif_plat_pm_ops,
> +	},
> +	.probe = cif_plat_probe,
> +	.remove = cif_plat_remove,
> +};
> +module_platform_driver(cif_plat_drv);
> +
> +MODULE_AUTHOR("Rockchip Camera/ISP team");
> +MODULE_DESCRIPTION("Rockchip CIF platform driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/media/platform/rockchip/cif/dev.h b/drivers/media/platform/rockchip/cif/dev.h
> new file mode 100644
> index 000000000000..f7dff4d1fdb0
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/dev.h
> @@ -0,0 +1,142 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Rockchip CIF Driver
> + *
> + * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#ifndef _CIF_DEV_H
> +#define _CIF_DEV_H
> +
> +#include <linux/clk.h>
> +#include <linux/mutex.h>
> +
> +#include <media/media-device.h>
> +#include <media/media-entity.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-device.h>
> +#include <media/videobuf2-v4l2.h>
> +
> +#define CIF_DRIVER_NAME		"rockchip-cif"
> +#define CIF_VIDEODEVICE_NAME	"rockchip-cif"
> +
> +#define CIF_MAX_BUS_CLK		8
> +#define CIF_MAX_SENSOR		1
> +#define CIF_MAX_RESET		5
> +#define CIF_MAX_CSI_CHANNEL	4
> +
> +#define CIF_DEFAULT_WIDTH	640
> +#define CIF_DEFAULT_HEIGHT	480
> +
> +struct cif_buffer {
> +	struct vb2_v4l2_buffer	vb;
> +	struct list_head	queue;
> +	u32			buff_addr[VIDEO_MAX_PLANES];
> +};
> +
> +static inline struct cif_buffer *to_cif_buffer(struct vb2_v4l2_buffer *vb)
> +{
> +	return container_of(vb, struct cif_buffer, vb);
> +}
> +
> +struct cif_remote {
> +	struct v4l2_subdev	*sd;
> +	int			pad;
> +	struct v4l2_mbus_config mbus;
> +	int			lanes;
> +	v4l2_std_id		std;
> +};
> +
> +struct cif_output_fmt {
> +	u32	fourcc;
> +	u32	mbus;
> +	u32	fmt_val;
> +	u8	cplanes;
> +};
> +
> +enum cif_fmt_type {
> +	CIF_FMT_TYPE_YUV = 0,
> +	CIF_FMT_TYPE_RAW,
> +};
> +
> +struct cif_input_fmt {
> +	u32			mbus_code;
> +	u32			dvp_fmt_val;
> +	u32			csi_fmt_val;
> +	enum cif_fmt_type	fmt_type;
> +	enum v4l2_field		field;
> +};
> +
> +struct cif_stream {
> +	struct cif_device		*cifdev;
> +	bool				stopping;
> +	wait_queue_head_t		wq_stopped;
> +	int				frame_idx;
> +	int				frame_phase;
> +	bool				drop_frame;
> +
> +	/* Lock between irq and buf_queue. */
> +	spinlock_t			vbq_lock;
> +	struct vb2_queue		buf_queue;
> +	struct list_head		buf_head;
> +	struct cif_buffer		*buffs[2];
> +
> +	/* Vfd lock. */
> +	struct mutex			vlock;
> +	struct video_device		vdev;
> +	struct media_pad		pad;
> +
> +	struct cif_output_fmt		*cif_fmt_out;
> +	const struct cif_input_fmt	*cif_fmt_in;
> +	struct v4l2_pix_format		pix;
> +};
> +
> +static inline struct cif_stream *to_cif_stream(struct video_device *vdev)
> +{
> +	return container_of(vdev, struct cif_stream, vdev);
> +}
> +
> +struct cif_match_data {
> +	struct clk_bulk_data *clks;
> +	int clks_num;
> +};
> +
> +struct cif_device {
> +	struct list_head		list;

list does not seem to be used anywhere?! Please remove if this really is
the case.

> +	struct device			*dev;
> +	int				irq;
> +	void __iomem			*base_addr;
> +	void __iomem			*csi_base;

csi_base does not seem to be used anywhere?! Please remove if this
really is the case.

> +	struct reset_control		*cif_rst;
> +
> +	struct v4l2_device		v4l2_dev;
> +	struct media_device		media_dev;
> +	struct v4l2_async_notifier	notifier;
> +	struct v4l2_async_connection	asd;
> +	struct cif_remote		remote;
> +
> +	struct cif_stream		stream;
> +	const struct cif_match_data	*match_data;
> +};
> +
> +static inline void
> +cif_write(struct cif_device *cif_dev, unsigned int addr, u32 val)
> +{
> +	writel(val, cif_dev->base_addr + addr);
> +}
> +
> +static inline u32 cif_read(struct cif_device *cif_dev, unsigned int addr)
> +{
> +	return readl(cif_dev->base_addr + addr);
> +}
> +

The methods from here...

> +void cif_unregister_stream_vdev(struct cif_device *dev);
> +int cif_register_stream_vdev(struct cif_device *dev);
> +void cif_stream_init(struct cif_device *dev);
> +void cif_set_default_format(struct cif_device *dev);
> +
> +irqreturn_t cif_irq_pingpong(int irq, void *ctx);

...to here are defined in capture.c, hence I would have expected to see
these forward declarations in a header named capture.h.

The remaining parts of dev.h could also be named common.h or cif.h or
something like that.

> +void cif_soft_reset(struct cif_device *cif_dev);

This does not seem to be used anywhere?! Please remove if this really is
the case.

> +
> +#endif
> diff --git a/drivers/media/platform/rockchip/cif/regs.h b/drivers/media/platform/rockchip/cif/regs.h
> new file mode 100644
> index 000000000000..bad1f2f302e6
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/regs.h
> @@ -0,0 +1,192 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Rockchip CIF Driver
> + *
> + * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#ifndef _CIF_REGS_H
> +#define _CIF_REGS_H
> +
> +#define CIF_CTRL				0x00
> +#define CIF_INTEN				0x04
> +#define CIF_INTSTAT				0x08
> +#define CIF_FOR					0x0c
> +#define CIF_LINE_NUM_ADDR			0x10
> +#define CIF_FRM0_ADDR_Y				0x14
> +#define CIF_FRM0_ADDR_UV			0x18
> +#define CIF_FRM1_ADDR_Y				0x1c
> +#define CIF_FRM1_ADDR_UV			0x20
> +#define CIF_VIR_LINE_WIDTH			0x24
> +#define CIF_SET_SIZE				0x28
> +#define CIF_SCM_ADDR_Y				0x2c
> +#define CIF_SCM_ADDR_U				0x30
> +#define CIF_SCM_ADDR_V				0x34
> +#define CIF_WB_UP_FILTER			0x38
> +#define CIF_WB_LOW_FILTER			0x3c
> +#define CIF_WBC_CNT				0x40
> +#define CIF_CROP				0x44
> +#define CIF_SCL_CTRL				0x48
> +#define CIF_SCL_DST				0x4c
> +#define CIF_SCL_FCT				0x50
> +#define CIF_SCL_VALID_NUM			0x54
> +#define CIF_LINE_LOOP_CTR			0x58
> +#define CIF_FRAME_STATUS			0x60
> +#define CIF_CUR_DST				0x64
> +#define CIF_LAST_LINE				0x68
> +#define CIF_LAST_PIX				0x6c
> +#define CIF_FETCH_Y_LAST_LINE(VAL)		((VAL) & 0x1fff)
> +
> +#define CIF_CTRL_ENABLE_CAPTURE			BIT(0)
> +#define CIF_CTRL_MODE_PINGPONG			BIT(1)
> +#define CIF_CTRL_MODE_LINELOOP			BIT(2)
> +#define CIF_CTRL_AXI_BURST_16			(0xf << 12)
> +
> +#define CIF_INTEN_FRAME_END_EN			BIT(0)
> +#define CIF_INTEN_LINE_ERR_EN			BIT(2)
> +#define CIF_INTEN_BUS_ERR_EN			BIT(6)
> +#define CIF_INTEN_SCL_ERR_EN			BIT(7)
> +#define CIF_INTEN_PST_INF_FRAME_END_EN		BIT(9)
> +
> +#define CIF_INTSTAT_CLS				0x3ff
> +#define CIF_INTSTAT_FRAME_END			BIT(0)
> +#define CIF_INTSTAT_LINE_END			BIT(1)
> +#define CIF_INTSTAT_LINE_ERR			BIT(2)
> +#define CIF_INTSTAT_PIX_ERR			BIT(3)
> +#define CIF_INTSTAT_DFIFO_OF			BIT(5)
> +#define CIF_INTSTAT_BUS_ERR			BIT(6)
> +#define CIF_INTSTAT_PRE_INF_FRAME_END		BIT(8)
> +#define CIF_INTSTAT_PST_INF_FRAME_END		BIT(9)
> +#define CIF_INTSTAT_FRAME_END_CLR		BIT(0)
> +#define CIF_INTSTAT_LINE_END_CLR		BIT(1)
> +#define CIF_INTSTAT_LINE_ERR_CLR		BIT(2)
> +#define CIF_INTSTAT_PST_INF_FRAME_END_CLR	BIT(9)
> +#define CIF_INTSTAT_ERR				0xfc
> +
> +#define CIF_FRAME_STAT_CLS			0x00
> +#define CIF_FRAME_FRM0_STAT_CLS			0x20
> +
> +#define CIF_FORMAT_VSY_HIGH_ACTIVE		BIT(0)
> +#define CIF_FORMAT_HSY_LOW_ACTIVE		BIT(1)
> +
> +#define CIF_FORMAT_INPUT_MODE_YUV		(0x00 << 2)
> +#define CIF_FORMAT_INPUT_MODE_PAL		(0x02 << 2)
> +#define CIF_FORMAT_INPUT_MODE_NTSC		(0x03 << 2)
> +#define CIF_FORMAT_INPUT_MODE_BT1120		(0x07 << 2)
> +#define CIF_FORMAT_INPUT_MODE_RAW		(0x04 << 2)
> +#define CIF_FORMAT_INPUT_MODE_JPEG		(0x05 << 2)
> +#define CIF_FORMAT_INPUT_MODE_MIPI		(0x06 << 2)
> +
> +#define CIF_FORMAT_YUV_INPUT_ORDER_UYVY		(0x00 << 5)
> +#define CIF_FORMAT_YUV_INPUT_ORDER_YVYU		BIT(5)
> +#define CIF_FORMAT_YUV_INPUT_ORDER_VYUY		(0x10 << 5)

This should be 0x02.

> +#define CIF_FORMAT_YUV_INPUT_ORDER_YUYV		(0x03 << 5)

I am fine with either BIT(5) or (0x01 << 5), but please let's NOT mix
both approaches.

Thanks and best regards,
Michael

> [...]
