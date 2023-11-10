Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E9C7E84B3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346537AbjKJUrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbjKJUrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:47:18 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2064.outbound.protection.outlook.com [40.107.249.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBE934834;
        Fri, 10 Nov 2023 04:50:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9/kqf3S1H4CVT2RP+jsEERoE6mvBX4wtqZzZouEP/zyhi88GLGNMVawYqRCRlch82s6EJfhgZ4jAa0f496jeYEFgmsRa/5gK9+WVVXt6cz4sO3FiqjzTcTIHYaj5fvJ5dmJYfgCGLg2MThSoQ6cK3JYVPsjv4KCoHtylY1s9jZiTjp0TQ4ju1VdLXLPQT2sgKoVeNDaAiPTA1vHTA0LXs/oWikOctmUBsdsYXv92K8eW9MbvigTcALjVX8hGykhbwGNALvO113PD9zpXTBGBJUnQliL4Tts6Xkf9viXsHH96B6AieSZh4aGb2seMVios6Pmn72Pi2IeupxIFWqnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsF5MARRPre2eWxj7bIpAzlHX3tHkSuxTSs6hMIta1k=;
 b=bbEC8v13MaFocX/mEmM2mNIOdYJQ/ksR9PM3KoH9Leon44u3dqc1VvMTdXodMaKYFLi7bH65U3YHdg4kG7UJ10kzH+icAlbq74XrHOjfrw9UB17sP3jIVZ5/3/ofhE0PHyAWxyFpTbCah33fusiwHj1QKkNRHknJnugltsousHLDXdHVgOVcPgkwG2egly8qNNZcz2AG+5AIBUNNJSiY2kjiB3JEHVvX5zuqCD+R0BzHkY9cE8dbew7ZJqXeav6Q1ThGee537yiMLefQy14+xIGTyMivp1uq/1nbf7xfoY4vH5vjubrBqVJj3x5ijm+Mvrnnjh8orqzTRkoRUt2EZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsF5MARRPre2eWxj7bIpAzlHX3tHkSuxTSs6hMIta1k=;
 b=USYZNbIqb5whNAcwkPDHqb3CisjgpKL1VaLhWXjgmPfGcrSrkTA9Pg7nQ9acMf9fcpaP/DWx5DPsGx0Bs9dU0BemrPR1R0mySgAr0vg0hfx0WOuPEFV81U0O+P5hlGhJCJCBAtWkadMsXnb5GwDnbNbCzaIq1gvUdHSc9q/F7ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AM8PR08MB6451.eurprd08.prod.outlook.com (2603:10a6:20b:315::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 12:50:04 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad%4]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 12:50:04 +0000
Message-ID: <f817728d-6377-4fff-b8e8-ac0c652e5c29@wolfvision.net>
Date:   Fri, 10 Nov 2023 13:50:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/3] media: rockchip: Add a driver for Rockchip's
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
References: <cover.1699460637.git.mehdi.djait@bootlin.com>
 <bcc0b84f4a6a8cf4c007cfe25025060b22627408.1699460637.git.mehdi.djait@bootlin.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <bcc0b84f4a6a8cf4c007cfe25025060b22627408.1699460637.git.mehdi.djait@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0168.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::25) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AM8PR08MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: e2535769-9983-400e-0a59-08dbe1eb8f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sgQ8KhM2JaI9ZAebOWdBxfzu1OjCMH6x7QkfsKA2/M+1fsbHOk6/mKOdroR+D6a+DrPqf5+EkNuwB4/MyaPcIRSVkVkLSIvSTbeZzJyZLbOskSZ12OqxZfoe2AQAQ4wn8B9Zy6WXYX62UkL9do7P6K2IdbY3j9ONAOqXppb1kMGG8xAhT43amccppCfgAPhnr6HHNzpxcmPftRlw7zFX9nZecEAbhrc5fk8MXVLyF4wDTQzfOtaLDZebWckgG71Wi72wnyyOz48DrXgDCMuHCK6WkyTymG4BFKsLwflT4CCY7T2ir1mtPsUBHzPrDHRmWNIUogYavMHphnwdq9pj8utVzqRfBBau+6i1soxvwDGrd+WSyLEzlqRtxfKaHgPoJ/Ba3m66Iu63pw1LnwMu73Qq1s6X5UlRp2Fd/FX2YRr1tXa3T7lKsOZiUyUW5FqdOKnD+lhN0TGjRA9imwClZIj5clJRWzvVfP7IiNqcZSI1j53UgdjJtOWCN0Qn2c/RLYcVIooU4M6Kkzs4npSUbCbo1c5xKMHxw/H9m0EwS++u/BJ75DpTA6DuCgCYk8Pokab0vRaV9lfNYHuuAQXAxfxzU/GZzKB0G+r2gVWSfMqBaFeG27qlSBHjB6RHwZr2N7bbZA4CUJQTr4s2F06GDj7ohF2Ky9MpD4TxFRtwQre3cmJdGsVjqK74kqPrP1Mig/YTnaqCeKbwrYwpQ4eRjbehWBjZ/44BiN+ymfxmBCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39850400004)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(5660300002)(7416002)(38100700002)(41300700001)(30864003)(86362001)(31696002)(36756003)(2906002)(36916002)(53546011)(31686004)(83380400001)(8936002)(8676002)(4326008)(6506007)(2616005)(6486002)(6512007)(66946007)(316002)(66476007)(66556008)(26005)(478600001)(44832011)(6666004)(461764006)(43740500002)(45980500001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2ZZYTE4VUFMdElmbkpMU2FqU0VuTFNRNzlOTHV4MGY0Ymx1ZlgrTnYxSU1T?=
 =?utf-8?B?cmp1eEZ5VjR5S2MyNXlwZjlLMXhONHRqa0kwK1l3aHlLb1ZkaVM0b3c5MjJ1?=
 =?utf-8?B?UWRVeFVvNEh0SG9Kdi9wVFh1U2R0bXBUQldIT0dIRFVKRURhRXBBc0tveHow?=
 =?utf-8?B?QWlDd0NNeUltME1kY1hqVkowWk9La2pOR0R3MTBSMjdFOEJQZ2VIeVU4V3NU?=
 =?utf-8?B?NU1kbFVhOTEvVXVoV3pVSVVjYmZOcUlMSFhJeEQxaXZ0UWtKL1ZqRk9sSTBU?=
 =?utf-8?B?V0NZMG9nTXYwSGVEMTRSTmhtZWtNcnJrOThMdmhzQStSLzZ5N1NucG1yZGVm?=
 =?utf-8?B?QXlReU9lSnNPcjBNWlRIUXFCN0RTKzBjMXJubHZ5NndUdzZvSWVZQkJpSDBy?=
 =?utf-8?B?QmxSb09GMzMzbXJjN0pvZWw3UWRMM1RKd3F6QVpORUZidDhsYXF6T09mbmlx?=
 =?utf-8?B?dlNaaExvTlhzcTFvT0JkSm5oUEpqb2lPNDJ3RTlCYXl4S1VxWkp2RXJQRXlr?=
 =?utf-8?B?Qy85L05iYXlWSHJHKyt5NXl3dVhqRjF5c2cyUkd6S1E1V2ZXaWdwSGtuV2Vl?=
 =?utf-8?B?cjlob0dScGpzRVNEakJQWmRnemhDcDJ2clQ3WHh4MUoyNUt2a0RKdnlsK2V0?=
 =?utf-8?B?bnFHQlpFRy9nWlBmQ1A3SXVFdmp2Y3B2V2ttKzlLVXpOc2twVG83U2kwdnBL?=
 =?utf-8?B?OE9DbUc1eldGeUo0a2VvZHNtLyt6NEd6bmRac3JHcXh4azFEZmRJUnBsN2Yw?=
 =?utf-8?B?Z0dqdTBGQzRYb1BnRlNxTFpyZXo3VEdhdTN3eHprdW1UVk9HdUsxdFljVUMx?=
 =?utf-8?B?S2pUcm5wblZXSEkwMGQ1eXRCRG5RSzFid2pKSmwxZXdib2gxbU5oSU01a0wr?=
 =?utf-8?B?b2VIWURTdEN3ZHI4bHRDZEhuRnlyeFJ4UGIwRlVaWGljNDE1ZE4zTDFCZE05?=
 =?utf-8?B?L1ZWS0F4VkRld1lFY2VQUU8raGV1V1pWL1liZm93TGRYcEUwb3AvS2FMWDBF?=
 =?utf-8?B?UTNDaHFNSGVYVk1HSWZIUEd2T0JBUjEyclRxa2h3bnBmUERqV0srTkZGNDhm?=
 =?utf-8?B?NnF4czdPWGh3aVJlblV4RnZEK21QU1ZTUTMycWlHTWNmTkRrK1dXTWFrYkJT?=
 =?utf-8?B?U0FpU2lZcDk1N3YyZ1pEbHkzdGIyejlCbUxraFdoN1A4U1JOcUpOUGt4MnFF?=
 =?utf-8?B?UnMzMTJJNjYvcmFqUkdoR3BvRTJDaUtVUm0vVUlRTTd3OGlkbTRCdFI4Sm5J?=
 =?utf-8?B?MDQvM1d2QXFXck5tM1AzZkVCaGNxN2YxUC9qWkRXc2dMTDNQVFVybjZFZjh3?=
 =?utf-8?B?YlFwK1hISlhSSzBqMUlyYVhkWjZ1TTNSWUZtY1NuV1RYVE1pbVR3YXBmZ053?=
 =?utf-8?B?Q3E4aWViNG1pdnA2OTVUVFJOZ1ByeHhpMTVvaysxcUtFNWs5dDdDRHB6a3hE?=
 =?utf-8?B?NG5Ddk1iSmdpOGlOV3c5cTFXRi81dU5EdDZ2bFJmM0ZNSHBaK3pLQzlQaVZK?=
 =?utf-8?B?bndhQlZLcW03bHo3TzVKNVgvZmNlYWFZZHVTL2NUQUsvTVFXMzdGS0E1UjJ6?=
 =?utf-8?B?TkV1dnRCK3VKN0MyUFZySTF3Y1E5ODlkRUQwUTF3aytmdnR1Ty9IbW0vQ05z?=
 =?utf-8?B?L252UW1lNjZZSXphQmJtdDJWTk01NHZtd01KSDl1UytFK3FvYWZDc09iMU1n?=
 =?utf-8?B?cmxlK3h3WkVidVkyVlc2NWJhUXRuOElEWm9waDRYSTh5NjFRbnJDQjBvUE9W?=
 =?utf-8?B?a3pIZTA3YmdoN21xcUoxYm8vaXVlMGJnd3N1L0RTdmRxK0Z1NHpaSWRhazZL?=
 =?utf-8?B?TVRZaW9EbEVFajNUVlUwWkpQdnUxbXR3TU1FcklyV2JrK0ZRZXlaMzE2VDJH?=
 =?utf-8?B?R0NlM0tEMjhKRm9LdFhhMVlRZW1VMnd6eWFVMHdJSTZoSmM0WnNqQ2ZsM3My?=
 =?utf-8?B?WndBV0Z4aUtHMEhCZUdzZXJNRXY3NUVZdWZudTBMQllWRkpJZi9VaVQ5QXZY?=
 =?utf-8?B?cHg0VnJ5blBrZm5GWmNZdkp5VFU2ZGxZWnd3M2kxME9kQzRNakkvcDQzVVZj?=
 =?utf-8?B?c1NPb1FiU3NjQ2pONHo3TUQyckR0ZU9hb2lHZU5tSzI4cXdRdkNzRGFQSUl4?=
 =?utf-8?B?Y2FveGIyYk5WdUFOSURBVXBTTkRZeHlXSVkzOE05eFVwektKU21TTjlPMUwr?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e2535769-9983-400e-0a59-08dbe1eb8f18
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 12:50:03.9648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oz0R/UHk86FeWrrlA3aqXv0xyO7EcqrE2AKOerAHt3vdjkWyjyVyAH98vu0Iac4fZK3xr1/3mZjAcpnivtx+KJ1iYJCkqFD2Z/eBzCXen5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6451
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

Thanks for your patches.

The good news first: with some hacks applied I was able to capture the
video stream from a HDMI receiver chip via BT.1120 on a Rockchip RK3568.

As a next step, I'll clean up the hacky RK3568 support and submit them
for review.

Still, there are some issues that needs to be addressed. Please find my
comments inline.

On 11/8/23 17:38, Mehdi Djait wrote:
> This introduces a V4L2 driver for the Rockchip CIF video capture controller.
> 
> This controller supports multiple parallel interfaces, but for now only the
> BT.656 interface could be tested, hence it's the only one that's supported
> in the first version of this driver.
> 
> This controller can be found on RK3066, PX30, RK1808, RK3128 and RK3288,
> but for now it's only been tested on the PX30.
> 
> CIF is implemented as a video node-centric driver.
> 
> Most of this driver was written following the BSP driver from rockchip,
> removing the parts that either didn't fit correctly the guidelines, or that
> couldn't be tested.
> 
> This basic version doesn't support cropping nor scaling and is only
> designed with one SDTV video decoder being attached to it at any time.
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
>  drivers/media/platform/rockchip/cif/capture.c | 1152 +++++++++++++++++
>  drivers/media/platform/rockchip/cif/dev.c     |  289 +++++
>  drivers/media/platform/rockchip/cif/dev.h     |  139 ++
>  drivers/media/platform/rockchip/cif/regs.h    |  192 +++
>  9 files changed, 1797 insertions(+)
>  create mode 100644 drivers/media/platform/rockchip/cif/Kconfig
>  create mode 100644 drivers/media/platform/rockchip/cif/Makefile
>  create mode 100644 drivers/media/platform/rockchip/cif/capture.c
>  create mode 100644 drivers/media/platform/rockchip/cif/dev.c
>  create mode 100644 drivers/media/platform/rockchip/cif/dev.h
>  create mode 100644 drivers/media/platform/rockchip/cif/regs.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b47e0b56859..f47a828d08a5 100644
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
> index b41d3960c1b4..f73d68d1d2b6 100644
> --- a/drivers/media/platform/rockchip/Kconfig
> +++ b/drivers/media/platform/rockchip/Kconfig
> @@ -2,5 +2,6 @@
>  
>  comment "Rockchip media platform drivers"
>  
> +source "drivers/media/platform/rockchip/cif/Kconfig"
>  source "drivers/media/platform/rockchip/rga/Kconfig"
>  source "drivers/media/platform/rockchip/rkisp1/Kconfig"
> diff --git a/drivers/media/platform/rockchip/Makefile b/drivers/media/platform/rockchip/Makefile
> index 4f782b876ac9..1a7aa1f8e134 100644
> --- a/drivers/media/platform/rockchip/Makefile
> +++ b/drivers/media/platform/rockchip/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-y += cif/
>  obj-y += rga/
>  obj-y += rkisp1/
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
> index 000000000000..f5f30884ebcc
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/capture.c
> @@ -0,0 +1,1152 @@
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

What is the point of this csi_fmt_val field? If the strategy is to kick
everything out that is not explicitly required then this should be
removed (and added at a later stage, if needed).

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

What is the difference between this entry (in_fmts[2]) and in_fmts[0]?
Similarly, between in_fmts[1] and in_fmts[3]?

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
> +	unsigned long lock_flags;
> +
> +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> +
> +	stream->buffs[0] = cif_get_buffer(stream);
> +	stream->buffs[1] = cif_get_buffer(stream);
> +
> +	if (!(stream->buffs[0]) || !(stream->buffs[1])) {
> +		spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> +		return -EINVAL;
> +	}
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
> +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> +
> +	return 0;
> +}
> +
> +static void cif_assign_new_buffer_pingpong(struct cif_stream *stream)
> +{
> +	struct cif_device *cif_dev = stream->cifdev;
> +	struct cif_buffer *buffer = NULL;
> +	u32 frm_addr_y, frm_addr_uv;
> +	unsigned long lock_flags;
> +
> +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> +
> +	buffer = cif_get_buffer(stream);
> +
> +	/*
> +	 * In Pingpong mode:
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
> +	} else {
> +		stream->drop_frame = false;
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
> +	unsigned long lock_flags;
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
> +	unsigned long lock_flags;
> +
> +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
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
> +		buf = cif_get_buffer(stream);
> +		vb2_buffer_done(&buf->vb.vb2_buf, state);
> +	}
> +
> +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
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
> +
> +	/* Stop the sub device. */
> +	sd = cif_dev->remote.sd;
> +	v4l2_subdev_call(sd, video, s_stream, 0);
> +
> +	pm_runtime_put(cif_dev->dev);
> +
> +	cif_return_all_buffers(stream, VB2_BUF_STATE_ERROR);
> +}
> +
> +static int cif_stream_start(struct cif_stream *stream)
> +{
> +	u32 val, mbus_flags, href_pol, vsync_pol, fmt_type,
> +	    xfer_mode = 0, yc_swap = 0;
> +	struct cif_device *cif_dev = stream->cifdev;
> +	struct cif_remote *remote_info;
> +	int ret;
> +	u32 input_mode;
> +
> +	remote_info = &cif_dev->remote;
> +	fmt_type = stream->cif_fmt_in->fmt_type;
> +	stream->frame_idx = 0;

Those lines are somewhat mixed. The reset of the frame_idx should be
made more visible. The remote_info line could be integrated into the
declaration. For the fmt_type line please see the comment below.

> +	input_mode = (remote_info->std == V4L2_STD_NTSC) ?
> +		      CIF_FORMAT_INPUT_MODE_NTSC :
> +		      CIF_FORMAT_INPUT_MODE_PAL;

This seems to be an oversimplification. How can one use BT.656 here?
(Aren't you using BT.656 as mbus format between your video decoder and
the PX30 VIP?)
You should not assume that the remote is capable of any TV standards
(this statement holds for the driver in general).

> +	mbus_flags = remote_info->mbus.bus.parallel.flags;
> +	href_pol = (mbus_flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH) ?
> +			0 : CIF_FORMAT_HSY_LOW_ACTIVE;
> +	vsync_pol = (mbus_flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH) ?
> +			CIF_FORMAT_VSY_HIGH_ACTIVE : 0;
> +
> +	val = vsync_pol | href_pol | input_mode | stream->cif_fmt_out->fmt_val |
> +	      stream->cif_fmt_in->dvp_fmt_val | xfer_mode | yc_swap;

May be a matter of taste, but why don't we use ONE u32 variable for the
register content and OR everything into it? yc_swap is not set anyway, BTW.

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
> +	cif_write(cif_dev, CIF_SCL_CTRL, (fmt_type == CIF_FMT_TYPE_YUV) ?
> +					 CIF_SCL_CTRL_ENABLE_YUV_16BIT_BYPASS :
> +					 CIF_SCL_CTRL_ENABLE_RAW_16BIT_BYPASS);
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

Unknown format (stream->cif_fmt_in == NULL) must be handled appropriately.

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
> +	if (ret)
> +		return ret;
> +
> +	cif_update_pix(stream, fmt, pix);
> +	stream->pix = *pix;
> +	stream->cif_fmt_out = fmt;
> +
> +	return 0;
> +}
> +
> +void cif_set_default_format(struct cif_device *cif_dev)
> +{
> +	struct cif_stream *stream = &cif_dev->stream;
> +	struct v4l2_pix_format pix;
> +
> +	cif_dev->remote.std = V4L2_STD_NTSC;

Not every subdevice supports TV standards. Is this really reasonable?

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

Wait, we are a camera in any case? How does this fit together with your
video decoder setup?

> +	input->std = stream->vdev.tvnorms;
> +	input->capabilities = V4L2_IN_CAP_STD;

Not every subdevice supports TV standards. Is this really reasonable?

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
> +	strscpy(vdev->name, CIF_DRIVER_NAME, sizeof(vdev->name));
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
> index 000000000000..f7d061a13577
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/dev.c
> @@ -0,0 +1,289 @@
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
> +	if (IS_ERR(asd))
> +		return PTR_ERR(asd);
> +
> +	ntf->ops = &subdev_notifier_ops;
> +
> +	fwnode_handle_put(ep);
> +
> +	return v4l2_async_nf_register(ntf);
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
> +	ret = devm_request_irq(dev, irq, cif_irq_pingpong, IRQF_SHARED,
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
> +	cif_stream_init(cif_dev);
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
> +		goto err_unreg_stream_vdev;
> +	}
> +
> +	cif_set_default_format(cif_dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	return 0;
> +
> +err_unreg_stream_vdev:
> +	cif_unregister_stream_vdev(cif_dev);
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
> index 000000000000..3be3db08c75b
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/dev.h
> @@ -0,0 +1,139 @@
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
> +	/* Lock between irq and buf_queue, buffs. */
> +	spinlock_t			vbq_lock;
> +	struct vb2_queue		buf_queue;
> +	struct list_head		buf_head;
> +	struct cif_buffer		*buffs[2];
> +
> +	/* Vfd lock. */
> +	struct mutex			vlock;

The comment adds an extra value of exactly two letters. Please explain
the purpose of this mutex properly or remove it.

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
> +	struct device			*dev;
> +	int				irq;
> +	void __iomem			*base_addr;
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

I think the preferred style is

static inline void cif_write(struct cif_device *cif_dev, unsigned int addr,
			     u32 val)
{
...

Thanks a lot and best regards,
Michael

> +{
> +	writel(val, cif_dev->base_addr + addr);
> +}
> +
> +static inline u32 cif_read(struct cif_device *cif_dev, unsigned int addr)
> +{
> +	return readl(cif_dev->base_addr + addr);
> +}
> +
> +void cif_unregister_stream_vdev(struct cif_device *dev);
> +int cif_register_stream_vdev(struct cif_device *dev);
> +void cif_stream_init(struct cif_device *dev);
> +void cif_set_default_format(struct cif_device *dev);
> +
> +irqreturn_t cif_irq_pingpong(int irq, void *ctx);
> +void cif_soft_reset(struct cif_device *cif_dev);
> +
> +#endif
> diff --git a/drivers/media/platform/rockchip/cif/regs.h b/drivers/media/platform/rockchip/cif/regs.h
> new file mode 100644
> index 000000000000..cc39bf9ce8da
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
> +#define CIF_FORMAT_YUV_INPUT_ORDER_VYUY		BIT(6)
> +#define CIF_FORMAT_YUV_INPUT_ORDER_YUYV		(0x03 << 5)
> +#define CIF_FORMAT_YUV_INPUT_422		(0x00 << 7)
> +#define CIF_FORMAT_YUV_INPUT_420		BIT(7)
> +
> +#define CIF_FORMAT_INPUT_420_ORDER_ODD		BIT(8)
> +
> +#define CIF_FORMAT_CCIR_INPUT_ORDER_EVEN	BIT(9)
> +
> +#define CIF_FORMAT_RAW_DATA_WIDTH_8		(0x00 << 11)
> +#define CIF_FORMAT_RAW_DATA_WIDTH_10		BIT(11)
> +#define CIF_FORMAT_RAW_DATA_WIDTH_12		(0x02 << 11)
> +
> +#define CIF_FORMAT_YUV_OUTPUT_422		(0x00 << 16)
> +#define CIF_FORMAT_YUV_OUTPUT_420		BIT(16)
> +
> +#define CIF_FORMAT_OUTPUT_420_ORDER_EVEN	(0x00 << 17)
> +#define CIF_FORMAT_OUTPUT_420_ORDER_ODD		BIT(17)
> +
> +#define CIF_FORMAT_RAWD_DATA_LITTLE_ENDIAN	(0x00 << 18)
> +#define CIF_FORMAT_RAWD_DATA_BIG_ENDIAN		BIT(18)
> +
> +#define CIF_FORMAT_UV_STORAGE_ORDER_UVUV	(0x00 << 19)
> +#define CIF_FORMAT_UV_STORAGE_ORDER_VUVU	BIT(19)
> +
> +#define CIF_FORMAT_BT1120_CLOCK_SINGLE_EDGES	(0x00 << 24)
> +#define CIF_FORMAT_BT1120_CLOCK_DOUBLE_EDGES	BIT(24)
> +#define CIF_FORMAT_BT1120_TRANSMIT_INTERFACE	(0x00 << 25)
> +#define CIF_FORMAT_BT1120_TRANSMIT_PROGRESS	BIT(25)
> +#define CIF_FORMAT_BT1120_YC_SWAP		BIT(26)
> +
> +#define CIF_SCL_CTRL_ENABLE_SCL_DOWN		BIT(0)
> +#define CIF_SCL_CTRL_ENABLE_SCL_UP		BIT(1)
> +#define CIF_SCL_CTRL_ENABLE_YUV_16BIT_BYPASS	BIT(4)
> +#define CIF_SCL_CTRL_ENABLE_RAW_16BIT_BYPASS	BIT(5)
> +#define CIF_SCL_CTRL_ENABLE_32BIT_BYPASS	BIT(6)
> +#define CIF_SCL_CTRL_DISABLE_32BIT_BYPASS	(0x00 << 6)
> +
> +#define CIF_INTSTAT_F0_READY			BIT(0)
> +#define CIF_INTSTAT_F1_READY			BIT(1)
> +
> +#define CIF_CROP_Y_SHIFT			16
> +#define CIF_CROP_X_SHIFT			0
> +
> +#define CIF_CSI_ENABLE_CAPTURE			BIT(0)
> +#define CIF_CSI_WRDDR_TYPE_RAW8			(0x0 << 1)
> +#define CIF_CSI_WRDDR_TYPE_RAW10		BIT(1)
> +#define CIF_CSI_WRDDR_TYPE_RAW12		(0x2 << 1)
> +#define CIF_CSI_WRDDR_TYPE_RGB888		(0x3 << 1)
> +#define CIF_CSI_WRDDR_TYPE_YUV422		(0x4 << 1)
> +#define CIF_CSI_ENABLE_COMMAND_MODE		BIT(4)
> +#define CIF_CSI_ENABLE_CROP			BIT(5)
> +
> +#define CIF_CSI_FRAME0_START_INTEN(id)		(0x1 << ((id) * 2))
> +#define CIF_CSI_FRAME1_START_INTEN(id)		(0x1 << ((id) * 2 + 1))
> +#define CIF_CSI_FRAME0_END_INTEN(id)		(0x1 << ((id) * 2 + 8))
> +#define CIF_CSI_FRAME1_END_INTEN(id)		(0x1 << ((id) * 2 + 9))
> +#define CIF_CSI_DMA_Y_FIFO_OVERFLOW_INTEN	BIT(16)
> +#define CIF_CSI_DMA_UV_FIFO_OVERFLOW_INTEN	BIT(17)
> +#define CIF_CSI_CONFIG_FIFO_OVERFLOW_INTEN	BIT(18)
> +#define CIF_CSI_BANDWIDTH_LACK_INTEN		BIT(19)
> +#define CIF_CSI_RX_FIFO_OVERFLOW_INTEN		BIT(20)
> +#define CIF_CSI_ALL_FRAME_START_INTEN		(0xff << 0)
> +#define CIF_CSI_ALL_FRAME_END_INTEN		(0xff << 8)
> +#define CIF_CSI_ALL_ERROR_INTEN			(0x1f << 16)
> +
> +#define CIF_CSI_FRAME0_START_ID0		BIT(0)
> +#define CIF_CSI_FRAME1_START_ID0		BIT(1)
> +#define CIF_CSI_FRAME0_START_ID1		BIT(2)
> +#define CIF_CSI_FRAME1_START_ID1		BIT(3)
> +#define CIF_CSI_FRAME0_START_ID2		BIT(4)
> +#define CIF_CSI_FRAME1_START_ID2		BIT(5)
> +#define CIF_CSI_FRAME0_START_ID3		BIT(6)
> +#define CIF_CSI_FRAME1_START_ID3		BIT(7)
> +#define CIF_CSI_FRAME0_END_ID0			BIT(8)
> +#define CIF_CSI_FRAME1_END_ID0			BIT(9)
> +#define CIF_CSI_FRAME0_END_ID1			BIT(10)
> +#define CIF_CSI_FRAME1_END_ID1			BIT(11)
> +#define CIF_CSI_FRAME0_END_ID2			BIT(12)
> +#define CIF_CSI_FRAME1_END_ID2			BIT(13)
> +#define CIF_CSI_FRAME0_END_ID3			BIT(14)
> +#define CIF_CSI_FRAME1_END_ID3			BIT(15)
> +#define CIF_CSI_DMA_Y_FIFO_OVERFLOW		BIT(16)
> +#define CIF_CSI_DMA_UV_FIFO_OVERFLOW		BIT(17)
> +#define CIF_CSI_CONFIG_FIFO_OVERFLOW		BIT(18)
> +#define CIF_CSI_BANDWIDTH_LACK			BIT(19)
> +#define CIF_CSI_RX_FIFO_OVERFLOW		BIT(20)
> +
> +#define CIF_CSI_FIFO_OVERFLOW	(CIF_CSI_DMA_Y_FIFO_OVERFLOW |	\
> +				 CIF_CSI_DMA_UV_FIFO_OVERFLOW |	\
> +				 CIF_CSI_CONFIG_FIFO_OVERFLOW |	\
> +				 CIF_CSI_RX_FIFO_OVERFLOW)
> +
> +#define CIF_CSIHOST_N_LANES			0x04
> +#define CIF_CSIHOST_PHY_RSTZ			0x0c
> +#define CIF_CSIHOST_RESETN			0x10
> +#define CIF_CSIHOST_ERR1			0x20
> +#define CIF_CSIHOST_ERR2			0x24
> +#define CIF_CSIHOST_MSK1			0x28
> +#define CIF_CSIHOST_MSK2			0x2c
> +#define CIF_CSIHOST_CONTROL			0x40
> +
> +#define CIF_SW_CPHY_EN(x)			((x) << 0)
> +#define CIF_SW_DSI_EN(x)			((x) << 4)
> +#define CIF_SW_DATATYPE_FS(x)			((x) << 8)
> +#define CIF_SW_DATATYPE_FE(x)			((x) << 14)
> +#define CIF_SW_DATATYPE_LS(x)			((x) << 20)
> +#define CIF_SW_DATATYPE_LE(x)			((x) << 26)
> +
> +#endif
