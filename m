Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6A87DDAB9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377293AbjKABr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377053AbjKABry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:47:54 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2012.outbound.protection.outlook.com [40.92.99.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9C5E4;
        Tue, 31 Oct 2023 18:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwXwOXR7qYMxUPr/4tXVwbU0aQSX1SKzE8j2qVlMRrAAxJ5ewLGtqacKrHABY0C1kmVTSqWHjkzTQ6hdp2Y/DNx6GCAuEIzrBuUYLIJrZb55rir/fqf5affk0Qgwn7jJO7dr6gYSxdYuf5j+NzlO/jqG20dUVjvtPKOYlOEmitLZ4F874bQw1Lnj33WMpNBYH6QOiek3008WzE1BzKSwhbcHRawPIkDvIpzlDRWaV9SqWqhgEeUOQdCQLdoTSDVMBgfgZY/6Q98/rkQVII3QAfPZpHvWUIBl+MyOYMEtrZcRJDukIaUr9dNAogV20F56eBp4t48Sx2Z7hQ+UNrQljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oekaFV/H6G7/kTQrVCsZZH6TZkqMHF9EilX+awNCAGY=;
 b=Iq/YXLsUqmhhy+v8Nq0ww7Vluf31n/+hhxdcOfoT0wO0nUrnvag4/sGJgiso+c7QcdT1V0YEzhNgxRHqCzwh0ywH3CzbSRmWybmk5ZwrpZ19vZPQ9KK876/88lVUe+G0YnuE3ArU3/LJpiZw45wTFsZ47BqLtTl/4jMdGI9ZsT926/OSRavrOsRCvRs56WRDLCQRZq+Adrj2xvoPildPqC2Tm2gti/5hIHzg6KYo19kZHyDxSTvnzQQyRIuSRPQwkF9VEQpOt8zhiUnb8kEyzMD0Hth/D3L6Pd4ltEs365Fznu6ZXZ2TJjdQJVp70mrAqE3cVVTho8Pk2/m5TnAyGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oekaFV/H6G7/kTQrVCsZZH6TZkqMHF9EilX+awNCAGY=;
 b=Q6A30MLnKNBkxyBVDzj6f3VjnGWMXDyV76GR1ce5M9dGyQWb/4b9jMp0iuxB2Yx4yMFlXpSLIGWN+0Q9qdsAKzzATLc3cI+9DoIhcd/59nqcoml3JX1NFiHJcNa6l+txss7n9+r6KQB1xj+4uYYt1KVU8juwHFbLOmc2XtUpjjVO+6I9Z2dNtZYnLVK2uy3Lhkt19YUuQs1eYNcpZOrV7vtbk0MJcZe8BDujXUKcLeOGuJbaeC/k0qbPJxzMR16zU8RM47nnlw5te530QWsl5/ckJ1s6u1bjFGkXYiJNYcicx42oSzcQXErEocm8Sa14CCP0eYfnfQyjm8sCF6/EFw==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TY3P286MB3795.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:406::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 01:47:43 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 01:47:43 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     robh@kernel.org
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        oliver@schinagl.nl, pavel@ucw.cz
Subject: Re: [PATCH v2 2/2] dt-bindings: leds: add "internet" and "rssi" function definitions
Date:   Wed,  1 Nov 2023 09:47:31 +0800
Message-ID: <TYAP286MB0315C0414CC9420993D18DAABCA7A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031180305.GA1813504-robh@kernel.org>
References: <20231031180305.GA1813504-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [MX3eettV9n7PyP5EVhlpK+u/QOEr4qNB0/T1RBQXxek=]
X-ClientProxiedBy: TY2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:404:56::35) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231101014731.9270-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TY3P286MB3795:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b37e9d-3abc-4af0-ce81-08dbda7c89ca
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0dZJJIHSikN1RWV+JS0Dq5hUme1cVgTlHWGHIyNkoCrze3hNjP03clPtIPWfaWYfc4R3MNsjUttKOfn9YIB43PG5PipgQT3sg0m2gRaCnD1NNkCfzs4JPWIZCUkfKfHrDpJ874o8rPWD3PlkzuxdTysKwuspkdvOqN14gSO0buLbOAHmTfcjfa9CyFERS/F5CDbK2VEjR+OD0EwtcPzH1XtTG9UtHsdM0o4iBDv+bLZtGlCgeUvvl4u1MW5Pamnxo5fnKAyvfpjF7cWL7vnY9tbDXe7iNBTSQfvkBaBYPy1Q7XVYhcc+LoZlBqQHaWqW2uhrHQt7+cB2szOVLi7RWKZ/XnlVY9ZPpHt2giZjl7tUuLRkCocasv+YG+TKZNmsy+dwIpwmxhrfh9yfA2MlerK7LhVnOmDLZ8mAszzKtMlE4OZwNFlFJojR33S0/hTLIbQIBC4OUTgkMZfaunI1AOw7RhMGA4TEiLJLY3MboTBP+HSXNyzpc9q9Z4KMWpYGM0IVjMyVR71QHxXf1ZsS/hrQZ/BsjbKLaFAG9W802wvuuNB11fK8jguvJCOCtKjQxxpQmH5DV7eLR90YZspm/dPFkxWbx+heFSnKxLQd+CM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1huRzVRcWk2SWFJSFRrQm9mU2E3OHV6U3djTlJPTExwNy82bmpDL1FwdDdS?=
 =?utf-8?B?YmdIYTZpeURoUXVGcWxhNEV1ZHU1QkN6dEJhQUxZSkFQSnY0ZFNlSkxleWo4?=
 =?utf-8?B?aFdBZ0VpWnFabVlVTnFXQ2tYUnhDUXJzSmJFZ0prUVVXRGNObElzWSsvMXVl?=
 =?utf-8?B?Wk9lOWd5NVdFUmFMZnVzS0swTVZZUXBsR2xaOXdvZXBkUGxSUncvQ05PTTZ3?=
 =?utf-8?B?UjZseUpMWHl0Y2IvNXRWdmFWTVZsTWg0OG4zcXR6Q0dLeVZCc3E4RytmcnFl?=
 =?utf-8?B?QlZtQ1JpYjRrZWVGU0hmRXVNdGM3Ym52ZGhpcWs2dERTODZSY2tUa24zaGpz?=
 =?utf-8?B?S2tKdnJjNGpOa0VjenhUTkU2WFBWTEhjY1d3UkV5SVJTTWI5cnVkQjdvN0ZS?=
 =?utf-8?B?SnZVMGM5Y0d2a0lOU3JOcndZUDk2c0hNK040dVlIck1ER25BMHhnaVA0L09Y?=
 =?utf-8?B?aHNUTXBaZGVma2lkYVZsMTh3aEVPaVdyYWZNZy8zS2dOM1ZQVUVEQUd3OWY2?=
 =?utf-8?B?LzhldjliTEJUS2V0WGM2R2s4RTNMNXNHUlJ2Y0k1TE1EckZ2RXVESWtvS2Rs?=
 =?utf-8?B?YTg1MFY0NnlJb1N0RHdKOEZwQ3FsZ2cxbVRGU2V1YUpBYzhkTjdjSURIRlpW?=
 =?utf-8?B?VFloTmJyMWF1d0JiODQ2dmZmTjlVSERWTStsTHlZUjhqeWlJc3JNeFVscWk3?=
 =?utf-8?B?NVl5REp4YmFCaythaldQcXIrZ1JqSys4eGFUREI3VFZmQk9LQmlwc0UyejlV?=
 =?utf-8?B?ZDd0M2R0NGd4QnRta1lFWGJTb3Foa1hyOG5OOFB3NnRQWjZvSGduZEs0MDM3?=
 =?utf-8?B?NGZRQ1QxMlBWODE0Wm9XTEpjK3g5em9RUm00KzFaT01teEpIS01CdXZ5clZa?=
 =?utf-8?B?Z29DQm9VNVZYRGpVSG9hNE1EWUwwdFVWKzNDWEVyZm9rTGY3UTlPMGpkS09N?=
 =?utf-8?B?ZTByZVVrSUJZUkduelFzTklnQnU3UEp5NW5lRXZNclpmVEF3cnpkRFN3ZFg1?=
 =?utf-8?B?NW14Z3haM05ESVRlbGhnQWkydlVJdmpkb21FVEZ5YStMZzlZZ1BERXVHbkxR?=
 =?utf-8?B?UXhQQnpIeGdpdFQvOS9nQVRxbFdwRU5RczBvNVZFSW9RZ3J4N20wREtTai91?=
 =?utf-8?B?citWcFl5WEc5RVlvY0pTUkxvK3RyUVFPMGRHU3F4L2RRZGhmbSswbzVaRjdj?=
 =?utf-8?B?cTNzdTliYUIyVjNvQ1g0aEV3bkdvRkYyeXBJY3FzNjIzcWJ6TVYxM3NoZjAv?=
 =?utf-8?B?Y1VhWElURzZGTmpQL0RaMElsSEt3M0FVODNqQzljSGxJaDlnd1ZlZXlZRGdu?=
 =?utf-8?B?ZElzbkV4dll5ZDVGMmd6QjdHa1NkeCt2clVuWmo1WUpuV1RuZ0dpc1poMWpw?=
 =?utf-8?B?eWZhZy9vWHo3YU15S3VDMktkSU0yQUt1b1J3N25UbjIxZVkwUnpxaFFIcHYy?=
 =?utf-8?B?Z0pxcmwyVTJTSkp1R0kzM1dBcHJwcFh4ZFhTcWJLc2wyY1VUMkxyMUpIN0FO?=
 =?utf-8?B?MFl6TUdwN2lhNzhwUFliZktDb2RnUmFJdW5talZOYisvaGtTb20yeC9WZU5N?=
 =?utf-8?B?dGxhdHY3aURlQmhKWXpGRm9wS0ppZnd2ZERvK1VDY0kzaTNaNnFuWXJvK3pz?=
 =?utf-8?Q?o/d9mJ22Ogjw6o+wedn5J4ImAN2GIUHcGzD23H5LQ3f4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b37e9d-3abc-4af0-ce81-08dbda7c89ca
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 01:47:43.3719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3795
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 13:03:05 -0500, Rob Herring wrote:

>On Tue, Oct 31, 2023 at 09:29:01PM +0800, Shiji Yang wrote:
>> These two types of LEDs are widely used in routers and NICs. The
>> RSSI (Received Signal Strength Indicator) LED is used to display
>> the Wi-Fi signal strength, and the Internet LED can indicate
>> whether the device can access a specific server.
>> 
>> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
>> ---
>>  include/dt-bindings/leds/common.h | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
>> index 9a0d33d02..55a426e39 100644
>> --- a/include/dt-bindings/leds/common.h
>> +++ b/include/dt-bindings/leds/common.h
>> @@ -88,11 +88,13 @@
>>  #define LED_FUNCTION_FLASH "flash"
>>  #define LED_FUNCTION_HEARTBEAT "heartbeat"
>>  #define LED_FUNCTION_INDICATOR "indicator"
>> +#define LED_FUNCTION_INTERNET "internet"
>
>Duplicate of 'wan'.


It's different from 'wan'. 'wan' usually indicates whether the WAN
port is connected to the modem (internet services may still
unavailable). But the 'internet' shows if the device can successfully
ping servers like 8.8.8.8 to detected the internet connection status.
When the router operates in AP only mode, we can even connect LAN port
to the AC/modem to connect to the internet. In this case, 'internet'
LED should still be on. On some routers, both 'internet' and 'wan'
are available and be controled separately.

Ref: OpenWrt has a lot of devices that require the 'internet' LED：
https://git.openwrt.org/?p=openwrt%2Fopenwrt.git&a=search&h=HEAD&st=grep&s=label+%3D+.*net&sr=1

Anyway, if it is still unacceptable, please let me know and I will
remove it in v3.


>
>>  #define LED_FUNCTION_LAN "lan"
>>  #define LED_FUNCTION_MAIL "mail"
>>  #define LED_FUNCTION_MTD "mtd"
>>  #define LED_FUNCTION_PANIC "panic"
>>  #define LED_FUNCTION_PROGRAMMING "programming"
>> +#define LED_FUNCTION_RSSI "rssi"
>
>'rx' or 'wlan'?


'rx' and 'wlan' only shows the data transfer speed and on/off status, this
one indicates the signal strength.

>
>Wouldn't you need multiple LEDs to indicate signal strength? Maybe 
>'signal' or something would be more generic?


Yes, usually there are 3~4 LEDs to indicate the signal strength, just like
the signal icon on the mobile phone. We can use `function-enumerator` led
property to mark the different leds in the signal group. I'll rename it to
'signal' in v3.

>
>>  #define LED_FUNCTION_RX "rx"
>>  #define LED_FUNCTION_SD "sd"
>>  #define LED_FUNCTION_STANDBY "standby"
>> -- 
>> 2.39.2
>> 

Regards,
Shiji Yang
