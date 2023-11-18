Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924217EFD73
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 04:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346396AbjKRDgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 22:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjKRDgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 22:36:12 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2055.outbound.protection.outlook.com [40.92.99.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E49E0;
        Fri, 17 Nov 2023 19:36:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBVyy7FK0waDOmE0QnmtwG7Rx9UXkOp17f9/a/OEX+arH0lFJ0nPe0ciFF7l/1sazA9+wAjYANlK+9jtOpt6J9lqHHr9CRtEeiqAzTSnMKj1nBmzmAoY/rr5xluxZ4otz/QGBLl5qTw17Cn6eSPp2Qkb617zUnsrXfRP1YWtI5eIu62BTobNxjjNQOtxaF88W4XrmRWoSTzYU+8EPkr1WJAAlzO8gW1h2g0fxgQIJcvjCKh3rmGJND2eZYh3obdILfm2gejALdQp+m5t7gT4hzT2S7Q2xAihUSSItTQWTi7uqk01gGTFihIQib8Qltsq5w5EYFHnjLaO17INxInJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbTJTqeR4IQH8jOE/fboA9WsMoMQ1UdKMiKkprcx+Vw=;
 b=fhgLCZrQJHX7vUiDTM8xb4iy34Uic12CZxciAN5JCgBFnjXbo+T4/XDO926sskEH099Gy7LAjCwzyMa36wt2vcPyA9wpggMJPcVCmsrXD7TXkyjSd5cwTMSxn1xYV9p6Ia5VujfmtcFYy7d9SOuxsu1FTowhokrY6qGgzZn3yAIYPGkLn/B7oUxy5sdcvrc5Fq7W6JqvsuZiJv9NcU1ya5tgq/L7a8ujwSrJKX6qiJnm+hJiwPadFU1BrvxxR1LN702jUtrpcaVsQ/pWP96hwgROH+0KghrUDwsqhcX4Y8sZIhEzizAIK75Z6G/wePvnXboSLs2GzNk/gc1N9MrOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbTJTqeR4IQH8jOE/fboA9WsMoMQ1UdKMiKkprcx+Vw=;
 b=uvlFMF+J8vkqV2uRO2BSeU1Tn49qwNnQuiCwNRd0nSZeuVPDvwnv2/GSotZ0EJqK4EkHTf2f4HhKpw3AzATT+kyloo55X9TbAVVI6nBpI4AfonuRvERpyzpiPD9SbzBjuBE0CI6o+TFGlNsBqylBfKqJdNJFVmMZZNo94fzSWwPQ/qKOoof+TPONlefsZTe235ZX1xipIsnHkRgz0y/Y72pkUmAD/nmBYsig8eGBSpDFZ6ftz8/ARCFzrH2WwpRxKIXQrw7zrie6xzvGLw79j2w5bUoyTnXyr4sjb9Uvp+q8YqSP/woCKDCGKnU61NMMAk6aeZ9qFi1cuGAB/vD6NA==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TY3P286MB2499.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:228::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 03:36:04 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b840:5197:9b15:ea2d]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b840:5197:9b15:ea2d%6]) with mapi id 15.20.7002.025; Sat, 18 Nov 2023
 03:36:04 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     lee@kernel.org
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, oliver@schinagl.nl, pavel@ucw.cz,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 0/2] leds: add more LED color and function definitions
Date:   Sat, 18 Nov 2023 11:35:50 +0800
Message-ID: <TYAP286MB03150903EBA3D5C4CE570952BCB6A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231117125219.GB153049@google.com>
References: <20231117125219.GB153049@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [OF0diryouMZ8k2scxnIgjzv3OkdWVlqc]
X-ClientProxiedBy: TYCP301CA0060.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::9) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231118033550.1064-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TY3P286MB2499:EE_
X-MS-Office365-Filtering-Correlation-Id: a3359615-52c7-4e0d-9600-08dbe7e77dd6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7k8+ybFieIRYEVzj4TxJ80h7AKTTXYa5bPBpWHVCQQQAFSdEjrcFBQ364cIFt8M6EI2hGiPUDQg0RaPS5mZqxPXMML91BHURALOyOgWgE5wEe5vtYaDy/n2Yyz9MPXZZayj0VBPGc+yQ495XJCRvWfzbGcEP3z9CUg+/PFcZY5VfF5gRqaDGtJ1e6ZiKvBloVDicPawu63tTeTElETkb0En2nMxS1lNY5GtnhEKVbRz/dPw89rSuGSU04LvYJI9HT6eR5bDOvG/L/2/i/7AnPqyZoDhWSRCoWaf/omK1IxvA0PzskMaXONxDQOe3In+9yzHOin1xqS++SqC7qzIIajydfRk39S8U88ZK3C/tY0yy4pDUib5e1ww4lUKm1aC77cXyj72GZNuTpyt0KaQDL0XdriaPM3dHK0ytx1RvGcb149l5FNSGo4G+lMB92NsX7u9dD+Lwp6qoR/i9amF55HzL8eTXGUESuvBzNrqEbQXt0bBUXW3cVG7LQjkMbzgv4rhe04kV7ze+c6OxPPF898Lyk40jcUjVrBQinFPUh1JOLOO1llz6Z3k/CR7XmIB6PEaqVjt0QXHdFD9HUx4WA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXFsYXA3R2RpL3cvQlRCbWhoTGo0c3lENFlWcWNpcDVVdnBYSFRrUzFpQmN2?=
 =?utf-8?B?Vk5QSkIxL2MvMXBjcnR0UlA4Q1ZyTW40dUVQcmV2Z1ZMS1ZHa0JNWU1GOFNj?=
 =?utf-8?B?ampEeWJCU2lHd3F5cTdtZ2w5Yk14NklBRlVQS3p1Si9UVm1lNjhtbktpWXNl?=
 =?utf-8?B?OWdEMVJ3ZndYMVpqSlF3U3F4enl0OWZKa2tzUGtYZ3c3UUc4c2xtZ3MzNXdL?=
 =?utf-8?B?clhTeHFXVE15UmYzQnA2azVXTGVPcjh4eXpURDdDUHdabm9GRTE1RjZvY1c5?=
 =?utf-8?B?djdGQ1I4bWNSc0JMRmEzVkFUaElFRUE0d1gySHNUWXVmYk1CRXhBVTJ5UHlV?=
 =?utf-8?B?UFVhWXlPOCt6MnV2S2tmUUM3dEtLMmdtUHJ1dzM2aytzcno5V1hSTGp2Z2ha?=
 =?utf-8?B?SnpOVzZaMFZzYzVvMDBWclRFbHQremYrSC95eVdENXZSS3BvZTlDckRQUkpU?=
 =?utf-8?B?VGlTVkg2ek01U2ZOTldXMUkyZXgrMDFwSnJtbTcvbHgvTks1cnUrRWFNcnJE?=
 =?utf-8?B?anBmaU4yWnJ2MjFuOTF2V0twMm8rNCtLRjBsd3RKWWxKVWxYMDZaVVlhT0ln?=
 =?utf-8?B?ckhhNEVzR2VQdk5wT05MY1VWa2J2SUF4Z0g1QkdtR2wralkxV0VWb1NXWVJ1?=
 =?utf-8?B?UUpjbkZjL0w0bW5nWDExVGRTUU01WUNQcnF1eFczODBTcnVsRWZYRzNRYUN6?=
 =?utf-8?B?Rkk5S2NhcFpRMjRucTI5aHNqQ0xlcjJpY0VleDZoWHNPN3NpMVRaQ0pBR3JC?=
 =?utf-8?B?TkVMQVI2bnRnOGRHVkVOTXZYTURtbTBVTWpjbWFWb1lTV0Uxem00ME5XdnBv?=
 =?utf-8?B?U3pJWXFWR3ZWSHlXL2hYVy9VWXQ3dmt5cHhNeVkwbjJIN29neFJENzdLUFRr?=
 =?utf-8?B?bTNmQU5zVkpjclZGL0Rvam1BRnd1KzZjUHhlVVlYVFRrN2IyNVZqbU5WUXV1?=
 =?utf-8?B?WjFPRnE0dWdSNFpodVh5YndsVytmVDhBc2V4cFRSYUt5b3ByWDN2TnVlVE5F?=
 =?utf-8?B?R1dEc0RCOURaQzdiRGo1QU10dHpIckZHVTYxN1RUZTR1UlN3aThlSVpiYVI0?=
 =?utf-8?B?QTYvdldLeXg3YkZFSW5aWERTWTRuWVNsbXNrbEdGTE8xUFduNkNDMlZIYUdj?=
 =?utf-8?B?T2tWb05lSVhsTzhtbHdRM0JPRGYya0NCYmZ5Ulp1SjlSTEM1THYyMnRaTi9Z?=
 =?utf-8?B?d0tLT2d5VFZPUW9VSVFsdmJUTmNxK29XbEFOQkVrMXpiVExNdWRwYTZ1VHRF?=
 =?utf-8?B?MmROckk2R3RZOXR5Q2dMbEZoNmVGeDJaRW9KOHlRb0ZrODFCVHZjNlFtdDk3?=
 =?utf-8?B?b0c2Z3BmK25jQWhvVEc2ZzZFeno3S2tCVWFUV01SUGdkckNUcFZUNmpBeGNj?=
 =?utf-8?B?T2RrYjdCYjFkdnNwR1U2UnJVQ0tGMXBJcUhWbmNLUE5uUGxpRWVtRit3UDB3?=
 =?utf-8?B?elptRkw0bWhNR3BRKzhLaW5zaE15S29ZT2MrVXFTVi9VMlQxSTM2a0h6YXRs?=
 =?utf-8?B?UHNLTlUzYXJEVFZBRThGWTFkcW5LL3Z0SUpFQ29iOUMwTHlxemZ2ZjZmTjRi?=
 =?utf-8?B?OG5rMnNrejBzMFA4WHhhMlA1VEN1Q21LcXJWc1JMSkF0TlN0cU00K2JwNWxM?=
 =?utf-8?Q?x8O0Yg/CCnnthQtYGI6hnJyOcJJs75p57TR5jbpL5JMw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3359615-52c7-4e0d-9600-08dbe7e77dd6
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 03:36:04.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2499
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 12:52:19 +0000, Lee Jones wrote:

>On Tue, 31 Oct 2023, Shiji Yang wrote:
>
>> Hi!
>> 
>> This series patches add the missing LED color definitions and
>> introduces two widely used LED functions "internet" and "rssi".
>> 
>> Regards,
>> Shiji Yang
>> 
>> 
>> Changes in v2:
>> * Remove the LED name sorting patch as it changes the ABI
>> 
>> 
>> Shiji Yang (2):
>>   leds: core: add missing LED color strings
>>   dt-bindings: leds: add "internet" and "rssi" function definitions
>
>I don't see these patches attached to this cover letter.
>
>Did you send them all threaded? 
>
>-- 
>Lee Jones [李琼斯]

Hi!
Thanks for your review. Please ignore this patch. My git-email
tool has some issues, so they have been separated[1]. The final
v4 patch[2] has been sent some days ago.

[1] https://lore.kernel.org/all/TYAP286MB03159A83A77E6FD59F271D9BBCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

[2] https://lore.kernel.org/all/TYAP286MB0315F4D71698370875F58F6EBCAAA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

Regards,
Shiji Yang
