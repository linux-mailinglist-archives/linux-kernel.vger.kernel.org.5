Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254237EFB5A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344610AbjKQW0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjKQW0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:26:03 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E11D4D;
        Fri, 17 Nov 2023 14:26:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVmVVkjgequQUeIbCK0tYHELem4eV8e82hBo0K/097Jm7xskedxBzj1uMl/jeLgAzX+4y7J6xxAvPD2BY9X5//3ZuCdOx35G/fJ+N7IOULWhVhwmwvE6yajwj7p5yX/XyzBbuT3EGkqMdxOXew15gacanRD9D+p1CECRJ8LQMG5edpcQoks6vB5N8Yj4TcBK3p/nXdGqAu/Kf5rIZJLbP6zKrbjHu5IpLyen2KtcSxC9YcSxncuYrmSpaJDqJsibTa9DoWr287TU1VeoHZuU+7uo9mUtUGbGx2gQyBmrDyfYY3CLkyOyU1HqXMY5XftDq6nAuUcRTgvlPN5/+THPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20h1+XXOdYobLWf8HKoZX44YrlZDcU6G1Ju1nV8OZTo=;
 b=WCme0w7gacrBKn8xdFAY7IXEpUPAsPbzgCd+wMnWBdqTmCKwLVLAYE4lyCotyVz7Iw7uENr3M4dOU16ZV1Rk80BeObr8TaDv/pVIwGswUp0vG3ey1jhH/2OaY7nvh6e8MRFpDk6NT5jsZ2yVpVUZogJRHMBAwN6A7gURxCKxZVcYQDxgRITQQuV7LWsWNDyavdlwrPOEfg3AXmgZmMbX5NymWrpaYzOK9Iyee41dJ4r56zCPAT4L+kgysvR5Osre1Lvb+/rRBU/YqF+uJsLkR3Ds5DJ1TJ85mn2+JXztfCXQH9Ko22mlJ6vlJH1FUjlV5hKpQ995rbrzhjqhe+MMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20h1+XXOdYobLWf8HKoZX44YrlZDcU6G1Ju1nV8OZTo=;
 b=jARbkjoIE7CtaxbfjzaQW1mwlPdWroAKcwyZC3HDmO2cQ2/ZiN9liEmlsyDCAxkthCKLWZ2XgcSHn41zH4oXlrXEIytoH3sepwcKoaFUo2Ucj3Xtbig8YllE9RL4Lt6umBfAVctZynt7JmKwPRz67gcl/PnWKrqUeUy6ir8dFL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by PR3PR08MB5867.eurprd08.prod.outlook.com (2603:10a6:102:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 22:25:57 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad%4]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 22:25:57 +0000
Message-ID: <465b920e-9a0a-42c1-bf6c-451fb2471956@wolfvision.net>
Date:   Fri, 17 Nov 2023 23:25:54 +0100
User-Agent: Mozilla Thunderbird
From:   Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v11 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
To:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com
References: <cover.1700132457.git.mehdi.djait@bootlin.com>
 <db605935ad21c4780b73db87605b52d30bc936a4.1700132457.git.mehdi.djait@bootlin.com>
Content-Language: en-US
In-Reply-To: <db605935ad21c4780b73db87605b52d30bc936a4.1700132457.git.mehdi.djait@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0143.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::22) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|PR3PR08MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 098535c3-1ed2-4dbb-ff2f-08dbe7bc2b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6UgEeI8QDA0RczWyW67TY8ahMQyyUs2Tv9vqJgb+Qny/psIRuoyO4g5/a5i99RH1sCRXqVRYPhKJidpPQauKhAtgtQafMHVieXqktG/gyDA6T4LKkM3FamRpYDgVqax3RokpTLtoqTDpgQh/hmuOhMXzeprbcjsZO/gosMOcCcEr3Rp92QcgHrKeUDSTIzDCGIWiuN9ePGLOi50dwi5rr/oe6QTsx2YDFwmS5vKwxwHZTlJ7YWwFKgsqsOqvn1uCKqVWirD+tmo1b5buqL5Jh1fVr8kLoL4kbt3a0L0sAj7uB0GhPRP8zh1WmZba/WpZbIBv/nitARvIWREW5kApfaJGkpLVCkngLu1pjVr8iE5jAU/FVMtiDaazcxJ9VtUP2EyT293tRv3qsc/S8YyGh99dG3ZwOJFrf5WZWW69mgZgQa0M+UYC/GOO2G3vkQanNi8NKYG3z7aV8w5yDSeVolw4wwLjBabuMgUbi7Lz6T0PSwQlt2T+kIKxmMqx6qsAXqd4aLfk/5orkn6r3ucPUi2b9Ape9to880FjdHB+66rbXs4OV/pX+Lpux5R9M61c/rRbpPLv2fqtlOtpQPe7zYgct/DVotMd/yHmVCltrdE7Cy4XedZn8VvhmZUK3JNTLtiKPGwEcZfu8DFhPydUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39850400004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(31686004)(53546011)(6666004)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(5660300002)(7416002)(31696002)(86362001)(2906002)(38100700002)(44832011)(6512007)(41300700001)(2616005)(36756003)(66556008)(66476007)(316002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzhFU3FJMFVOb1pRK2xTWWpkdG5sY2cyZCt3VlJIdVdHZHhESVlNSUlUc0Nu?=
 =?utf-8?B?MjVOUy90WW9seGJHV0pNTGlXT2JNV3pWN01FaXFmbXZkVTF6eDRkUEFzR2Jj?=
 =?utf-8?B?UVZNUmdaRUJqUnBDVmdnTGdPSFFJMmVCajlyOGg5TmFzN0EwRzZUYWZDWEQ3?=
 =?utf-8?B?eWF2eFVaSGdMWm0zSzNyaVpBendRbDdmbVhlMnluQmw1VngzdzE3d3JGV2Fm?=
 =?utf-8?B?YlJVNXd0ODZZT2IwV2lZbnhpNldWNmFuTUU0SnhPZW5ETEhNMHZJemc2YUVY?=
 =?utf-8?B?VUYzQ3d4dGFlTUNZQlBxaGVKQ2huZmp3aDNkTWZ2SWU0VnhnRHRNakM2VEE1?=
 =?utf-8?B?ekdRa2VmaE81ckV6Z0drZEVCUjBUbjIvUzA3eG0vVVpsS1ZVdUhYYmtIWGlG?=
 =?utf-8?B?TFlVWnBJNlV1UkJSbmswTm5NZE13aTBrdFBBaTdMQi9lcDFVUlBBcVRQRktR?=
 =?utf-8?B?ajZMK1dRamRGSUxEVktHN2oyMVJYc2dzM0lDTytkbXdkRGx1aHVjVmliemgy?=
 =?utf-8?B?U2h6K1hZZ2R4MVYrRUlUa3VKT1ZEWlM2Z0dsN09UWUVhQW9vSlVkbEhuczNi?=
 =?utf-8?B?ODNwZGRURnM0c1ZKZXRSbGNpWjBFdEJTcTRtNmNqSnFCbGRVaEJNWnhUdVhh?=
 =?utf-8?B?MnhFWlVuOU1PUW44UUJvS2xpWTFVZXNDbU5uc2Nneml5ZDJGVi9oMVRqazNN?=
 =?utf-8?B?M04vaUVEQUU0Z0NjVGowVy82eEx6SXpaRUZWSW5OVU9DR1BzQWN5VUc1V1ZT?=
 =?utf-8?B?a3Era0ttbGFQUTBlYlBQcmpROE80N1oycG4xcjZya2N1V3NpdWViWjczaFhx?=
 =?utf-8?B?RjlXcGVWUU15VDhLOVNEMDhoMi8zZ0g4Z1RtdUVGK3hUOXA5OUt4c0N5U1dw?=
 =?utf-8?B?dVUzMXF1TmNRMzJRNnFlNFlrbUVTbDFkWXNIazFSL0ZBR0dINVZIY0RFdFMx?=
 =?utf-8?B?VFVVODhiLytEWEhZaUh2UTg0TXQzRXlSeElhRGd1UndOY3h6YThvVXU4TlBS?=
 =?utf-8?B?VjUraXJnWUZoMFkvbEtZOEJ0NFhnaDBKZ1ZiZ0liK2szL0U1Rnp1RFdYcGJ2?=
 =?utf-8?B?L1BnMXpiT0prV3F1bUZZeURPdzEwL0FSL2lBS1dFSVdBOENQZzlhU09CVjJK?=
 =?utf-8?B?TGRrUDMvbERTd0J1NWxiZ1R3azJhaU84cW9tV1pNSS9Dd292ZlhqRGt3Rm12?=
 =?utf-8?B?TmtrWURNZmFMcXhyR0EvWTE4emVJS1lvTmZDaFVBdkxjcGp5aFNjOHFHWm1m?=
 =?utf-8?B?Q2RrNFR1QWZqRjFxNENadzg4OG1qMUJ6SEhwS1NTM3RpWVZaNkhVSjBFNldj?=
 =?utf-8?B?M3JJYXBCUVFYUUlVWllSZUtEZjdoN2VRUkUvWXZ5TUJtNVNKaDUwYStOYjJY?=
 =?utf-8?B?RWI1QTZXRGVBY0k3eEM3cGtNaVBRbW1KenovZ3F5YjhvUnk0SERJZ3AyaHFF?=
 =?utf-8?B?eGtobEpNclFiMlBvQjBySFovMHBraGk3MjdNVFBJWm81dUJPVk9ZSFU1SzRK?=
 =?utf-8?B?U3MwRnYvMmRSdW1NYlNlVmRzRXFqalI1a3lob1p0cjhDbGdHVWEvMm1kVWhH?=
 =?utf-8?B?bmpyMHp0MkNMbG8yUUtwYzc3azJCNkVYVXNiQ3JvdytjeGwxcXFObVh4dzJI?=
 =?utf-8?B?S255SC85UGNmV2VTVzFpVTdIU2RmQjZVQytIUU1KRXdPZHVhSzBrd3RuTHpU?=
 =?utf-8?B?S1QwZEU1YndvODMyTnhlT0h1V3FtWkxMVTQvY2NyUi9sOTAybmdPOGVUWW9T?=
 =?utf-8?B?bS9ibTFWTGdVYkNGU1ZGbWUxUXlMeWlZNG5XNEpyREtGaTNObFcyRnJRK0ts?=
 =?utf-8?B?eWYyY0RTWndnZWJPZ0d6UG5TUDZ5K3NXaHZuTGJjekRlTGlGRGtXY2NnMGpP?=
 =?utf-8?B?VXlCTVZ3K01Ba1JENlludFFER0FocVRoWi9uanVUQTQ1aW1WVWFaMWpOMHJI?=
 =?utf-8?B?NUZ0OUhSTnk3UFZuUlppdllNTmdjOUdOdzBxbFJVOEtVb1c2YlNUeVNkSFZl?=
 =?utf-8?B?NnlqYUEwSEgyY3JWQ3hkN0FRMHBuY1pMWE5qY1NkYis2TUlyNEt5cVl2OWtk?=
 =?utf-8?B?ZXVVdEhzaksxalFMRGRPamdSNk9HR3JaMmcwNy9iL0hVVXVuUVhWcGRnZk16?=
 =?utf-8?B?R21PcFl4MHpZU3ZhL1c5Y3FjeG5iUnA1Y1cxcXduM1JRYmdYRHY2R0VxdzdW?=
 =?utf-8?B?QVJnNVJyWkQzbloyVXQ4alhjS0lycTRISmlsTVdHd29lMHYzN2hyekhUcXV4?=
 =?utf-8?B?ekVrM3pQR0paNkFaYnBqRnJXQkt3PT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 098535c3-1ed2-4dbb-ff2f-08dbe7bc2b44
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 22:25:57.0310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6p18rYv8PNJL/H+IzSaSfJzmvRODy54bG4ofAZoyPwD9bydjW7fhOZCpzVAaBeK9e+uTjn2NFpZsI4/P7RjbAOMsenBelzIqxCG2jjyP4pU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5867
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

One more thing:

On 11/16/23 12:04, Mehdi Djait wrote:
> [...]
> diff --git a/drivers/media/platform/rockchip/cif/capture.h b/drivers/media/platform/rockchip/cif/capture.h
> new file mode 100644
> index 000000000000..533e62f518da
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/capture.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Rockchip CIF Driver
> + *
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#ifndef _CIF_CAPTURE_H
> +#define _CIF_CAPTURE_H
> +
> +struct cif_device;
> +
> +void cif_unregister_stream_vdev(struct cif_device *dev);
> +int cif_register_stream_vdev(struct cif_device *dev);
> +void cif_stream_init(struct cif_device *dev);
> +void cif_set_default_format(struct cif_device *dev);
> +
> +irqreturn_t cif_irq_pingpong(int irq, void *ctx);
> +void cif_soft_reset(struct cif_device *cif_dev);

This cif_soft_reset occurs only here?! I think it should be removed.

> +
> +#endif
> [...]
With that (and maybe the renaming "Rockchip CIF Camera Interface" ->
"Rockchip Camera Interface (CIF)" throughout the driver, if you find
that suitable) addressed:

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>

Thanks and best regards,
Michael
