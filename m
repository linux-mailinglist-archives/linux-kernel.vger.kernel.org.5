Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AA27E011D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346899AbjKCJNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346858AbjKCJNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:13:20 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E77D42;
        Fri,  3 Nov 2023 02:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Skknibk8AQP9Es1+7qbN47dOErYXkGWxbOP3ePD2r4GD7kG6eHugoq8FmLcSQ+V4p0QdS2ilr+tO77sioESKT2z2KnIyCTyrEYVNBoseoc12Z3vqXcHANmoNwaFY9ys9Q20csG3cb42ZaKFHVyMa9DYctlkoOfzwvPfpoVFuwOvqycLmxgrJ5XlRww4QqDBduVO8TD434nOs12+sC9FGAzXWRsW9m7W2VJmDM0iwJUNEABk707PVG5jup/lcBhYseY+zZJO89a1uIkUvl9vbMk7ocL6Nl1ALuNq+IF6H8XU6YzvBGfookqF0/WF+MMCnodkc5Hura+1EYOSzbmSCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DL7twOXpZQYFKXkcgN1nSVgGXU6KBUHQVhUEFZ5aYT4=;
 b=l5+klzVcZR8WK5xbpeEjui4b3zRGuqmOFL2B0Ifk/YvSqjwwshndylg1bDNa+SY+XXbb+ZxTjO7GdUWJ/GhMNwURAEGUlZ0E0urH8FB32AKgwFxBrB/0fm2E3BNzeDZB0DDS634dtYW05JO1OyO+CACzRqbPMgkvSQRN+J4MXNSJ4zC3LyFChq4ehE/FUY99exBCoYZj/W4eNFSNPR7y4wlMM+vfwiMZBqC1+f1Otap15GFonalHekvooS7seCS5QTMa/ggwu9xgalw0Neco3evNPPQUfV/WVUxIjts6WAFTYJQTACphykX7K1e77imMlkGgvK2o5ghoELfFGPln3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DL7twOXpZQYFKXkcgN1nSVgGXU6KBUHQVhUEFZ5aYT4=;
 b=qiVHMV7VG/x53TdbBjraCwIPoFV/wNRuT5oirXhzv0egKUVs+qsy28bqyueSnmwJlIBs/AlsnamovvUJUobDOixNqI55FsEikyNNrVoJyvmIu7pqTHTtRh1DWb92H38Lx6v15Pd+EByS+fqfuV/4WXDVFXu2gudBFo8S+NCvG3RvDKb4K4VlpeMhkN8ID9YVJDzQGjkANecAG+W+uVJWRz9koFvgVbH2S9ROOpMk5lvcEPRU15CVgnNmkGPbtHYhdlecuwhF19MjmNfRJRvMthiu460zKG/9PyxddSWcyfd3xcuBPRqi8BqJ81rn3mSgk3FSKUe7lRCm3JRdMBksvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 09:13:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 09:13:12 +0000
Message-ID: <14e08512-8664-4290-b5a0-348f8a5f9e2d@siemens.com>
Date:   Fri, 3 Nov 2023 10:13:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: ti: iot2050: Add icssg-prueth nodes
 for PG2 devices
Content-Language: en-US
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
References: <cover.1698773019.git.jan.kiszka@siemens.com>
 <c46fddcf96f59af0796cefbe51dfff844261f22d.1698773019.git.jan.kiszka@siemens.com>
In-Reply-To: <c46fddcf96f59af0796cefbe51dfff844261f22d.1698773019.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4017:EE_
X-MS-Office365-Filtering-Correlation-Id: efd6b9fc-0882-41c5-7ba3-08dbdc4d1a7d
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UI0jXTNjgX2I7yl2MCoddvkLrOpQQDxQBI3XBACRvsvRJgVpT5PcR9fdjTblwi3Yn1A8l9uHxrofWjlNV1uNw0xSfrvfd7HzeSKXgqgo2lqmNvMxZgQUn/nxyYyk5tTljMtivsejwY5s9JnH5CcbH0HD/91C0ucPPe6rMKdbWT8hPQIzLKLaaZJ/KKQlNLcG/XFCrumwiboqOM+kYM1vJpeylT0XVaF+re5iMIl4mIhWA6ybRRK6XC+nmeEOYe1eI1ZZSHwt/88AlTY488i/g6TmGALkdSfARcq6Z1N47cVxwQXrZDon6uFUD73T/9NiAHy8R5Y1z0RG/BiiLKwe4DGHH0hQk6ZwpobmBJcnVT5M6Fej8UB1tuTjmloxd+h2tkKYRZdt+TBwNe5dsLzout6dzEAF1WpplahCxGo6ymt3ZEXut8gM4P39NH8hK76bluAyTbRSpJ4qLM50YJ9pumyDLabjmpXZ18jOeNBUtJqhJd3zMvB7ce+EhXQf+9PmpHwLz5YX/SYU2Dd68AuC/BF4OniX7LuA2TsyVsXSBh+o87OutnjLNAdCZa9esqUKwvxLZoyCbWZKAvoOCEYpUvBelFGYZzfkdG+8naPs1vK3mf62qlDhAZoS7naBIoc2/fNZRreZHi1C+GPSoSnOug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(53546011)(6512007)(6666004)(2616005)(6486002)(478600001)(6506007)(44832011)(83380400001)(26005)(2906002)(107886003)(66946007)(5660300002)(41300700001)(4744005)(54906003)(66476007)(66556008)(316002)(110136005)(8676002)(4326008)(8936002)(36756003)(86362001)(31696002)(38100700002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZvd094U0dJenlWWk1Lc1RKU3JUd3podjQ5TnhMVGFFWkJybGcrK2lOZ1Bs?=
 =?utf-8?B?eHFKaFZKUEFXY3pSRE5nMy9Wa2YwbFB3UFpZV08xc2hBa042NTRJRDBnWDJo?=
 =?utf-8?B?dmRhUExHMnBrK2g3MnZoQm5CbldhZTlzMURtL0lXL1E5WXRCMm1kRy91VktS?=
 =?utf-8?B?VDk5OG1odGNuTmxPTE9ZYnpSNnNaUmtZdDZ3bnhrODAzMmFSU21BK1pVUUJ2?=
 =?utf-8?B?aWlxRk00SVF6SkJvRXFyclpkQ3pNMFY2RWlVNXN3bENLVnkvM0F4NEt1aFpR?=
 =?utf-8?B?M0ZwYjdMbmpuQXRveWMrV2k2a0Y2VTFVU1drR3dUbUFxekZ6Z25oUmJRMDVD?=
 =?utf-8?B?ZTJCSUdlT2lvekV0N3F6c3M3Rm5tV0hiQ3lPWHJQbmJVZXgyVVZJRUp5WWMv?=
 =?utf-8?B?NXlRTk9QYVNvR05yUUd1OWhSajZRVVk2dEw4cExPcytrY3UrY0t0Vjlmd3pG?=
 =?utf-8?B?WTQ5RGpUakluY1lrV1FmUm1JTWZiYzlRSFNydkhha1JGNjRsRmpFKzRBT0Uy?=
 =?utf-8?B?aXN5Qjd3SVV0Q0tVVzI0YkxQclNMNEl6VlBqd1U5MTJweHhTRGM1cjlEZXVN?=
 =?utf-8?B?bFlyRmd0bGNEWmFwNVhuay9odnRaZG1SVG1KVFl1cEFoei9HVzN0RlhTT3F4?=
 =?utf-8?B?YWpEMm9oNTJWN2FQT096SWpQSDFxaVA3am1aZ1pIZ3BNeFRlVWtROEIvRnFK?=
 =?utf-8?B?eWI3RjZabjloWVB6dGJPTjFtcGdsTTlJV1pMenN3cnFIMERJZ0JQaERSNmxi?=
 =?utf-8?B?Y3ZxVzVuZlljTWdoenczK05HRU9XQy93ZGdDVzZ1YnhXZTNpOVc3VlU4K1NV?=
 =?utf-8?B?VHJyeHlFQmErZG01M3hWcWMvUjhJZUp3QzY5NVdqNW9HaTc3bFU4S0YyYkNN?=
 =?utf-8?B?bGpUY3R4eW9XeS9SSXBncCtPaVFRcmNCMW1kREZsaGZ6Tkh5bStPSTFkVFZL?=
 =?utf-8?B?c3dnNlJZUEczZEVRYXBKb1AxU0lndGFBWlV1WlVFenpZbWpZNE94OGgySzdD?=
 =?utf-8?B?RS94ZFd2QnZCbDlwYTRZZVJIeGtSVjFXWFBwK0xZYTFUYXNWQ25pc1hibUwv?=
 =?utf-8?B?bzRVbUJsNXI1cjdrSmlIdEl6ZDEvL1UzcC8xMUlvbXVkYUtMQkp1S2FIbUMx?=
 =?utf-8?B?Nksrazk3OXRLTEtEbWlOZmNOS0JPd3YxdCtoV0wySmxESDR1TldudVRLZXd1?=
 =?utf-8?B?R1A3NkF4MHI1RGIxZ3g0c3hnQitOeWwyT1VlSm1Yb3dCcG4yWlNGSVQ0RGg3?=
 =?utf-8?B?TjJaS2tFMlAvakM1VGRRSC9lSklIUU9JSGZsUGZlM0lnMG9aMHJud25qa0ti?=
 =?utf-8?B?blAvWHhGRkExaVhpbTR4anZTMHQwQUx5TlAwOGNmRVRHaWp0Q2czZ3NYaTJS?=
 =?utf-8?B?bzVKdlhQZ29udkFYbGRDWUFtNDh5eHJoaUtIOW1WblRjeWEzLzI1eWVvcjFQ?=
 =?utf-8?B?VUtiKzVmTFdOT2FJMW1zU1IydU52VjNpTFRvQmJ4NlpJTVFJSERJanovdnJ3?=
 =?utf-8?B?aENlaVNEYXc2K1Exb29NRU5BcW4zL0E0Wk5QQTZXWmdHdjJRbTR2KzNIbHFZ?=
 =?utf-8?B?NXd1M2FSMFBHc3JUZ3E1UXpJbEtaVlo0UGVsV1RqSWlFdXV4b1dVNFQveXZT?=
 =?utf-8?B?c1c5Mm5Tb05EWFI4WDczREFGL1UzS2lzK0pLUlJqc1MxdkFraSswWjBSTkpE?=
 =?utf-8?B?Nml6MmdqWHpXSWRJUHZVaGlMZ09BZmtxWVhSR2wxbWJMSU45bXowd3lxZThT?=
 =?utf-8?B?VktWVWFjbEpoYXZ1YzNwcUs0ZCs4TGJJSFNQT0VoZ1BZWGpjYjNQeXFCbXdx?=
 =?utf-8?B?ckIwSXM2WnVkSVNjRnhMV2pFSEFUSTJaUUJ6UjVsQ2p3eGJXbzR0d1YxVDBl?=
 =?utf-8?B?WUpGN1pTNEFxMnRBeTVub3hYdGo5dTRVK2R2L1Rjd1NsVkdPbzZLYWVlQ2xV?=
 =?utf-8?B?a21uY1lxRHFDdHNmLzRRNG0xUW9SZGM4czFwTmR3VFhybDVEbW80dkh2ak1p?=
 =?utf-8?B?TnFncVI0ZGd0SGhURGppY0pxeFhNdy9JYTBVa0lvTWMwWVNncDNQYnIzN3pV?=
 =?utf-8?B?cGFscUFkNllnbm1FQTJxU3lMZUFUenFFTGJydC8yUnhZYXMxbVBFR3kzNVha?=
 =?utf-8?B?TEUrdE9YRElOTGl2R1FkYytvMFIrOVB1QnZGVGJlQXo0eVVyZXZYRXJWMFU1?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd6b9fc-0882-41c5-7ba3-08dbdc4d1a7d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 09:13:11.9891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3+dMNov3ghxnE+dkNKX6RPZjPixIQ0naXDxFROu73AZsrW8Ns/LD4mFJS1+d+B3ncNV8EGrdTG/5AJF0XkKlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4017
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.23 18:23, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Add the required nodes to enable ICSSG SR2.0 based prueth networking.
> 
> As the driver still needs to be extended for SR1.0 support, keep related
> nodes disabled on PG1 devices.
> 

I've noticed some PG1 bits and some not yet upstreamed properties in
this. V3 will follow.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

