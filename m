Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D087840CE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjHVMaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjHVMaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:30:14 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2095.outbound.protection.outlook.com [40.107.21.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C40196
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APRzgH5zA3ihqxH9WLB/o8q+mnQYvfXhKgJk9pk+X2x8VkL6B3Dn3mUyC/nIVRZjXo3wVHrjEw5fI+DulnOKNNBMx6Vxo9pp0A0v6oY+zB3sRfxVcwCb9wQiBPg3pSA+o6cKfH57aIHkHM37ERJo21KypRSppJZCImzx+IR5CO5aSjFkxnGdt2WYT4jvWCUtbS/yMf8gdfnVnKiccspkS78Cuuqm3qKiPP77rWbwfpkQrJ9a4JNGnaqngPIAYB8EWTVr8mGpueThr9TZXpyYRNGI2heRBH58nPxqNYQjJRmG384yMUwC/rgbmB6wZCRNShEjM3mNVZSsBYG85DiJ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds6WWCUjpCmO7h3pfvPuLg+6zobWOqMGFygX7qvdkno=;
 b=GI4lcapHBGLtXT/0ORtW5hYUHslA75DUa0F80kCw4FOVx64E2NCKWYkv6vDgpXGOu9BUnPvd8RnnBTQh8v8/bpbNYC+cLGQ4vvb4OtZKWP2HWtWBCMEk5+b1aR0LJGhzbZoz4dwlihGAwvy2TFbETJ2cgSDV0pUtMMpswstwH5guTWyP6RRnrNh0s2oqZgQ0XNV8xDPRsBDVGgVlU85KeaCjE0HKxjvsO8GO/q98kv9d3QP91qvg/Q/594GArW62d7Aq7sfH2WkKjXVMXV05EBVNQMPAA+uj1bBIB49c31qgqdQoNe/1F9nxZKcynnZKGgzMg2havWt0qEKGj776UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds6WWCUjpCmO7h3pfvPuLg+6zobWOqMGFygX7qvdkno=;
 b=SsE6DTeL7Of1ZEr5yQK67bOIR+1CkxubVB2uKleL+fad1N+I0jjVRqJIww2B6T/04LTuBaBlVaw9Lzf3qTAZSUIN8H4R7o0wJSscm1PTvRxwc4rzOeeJeTlLGh/EU0mAdHkX86rTRQcpB5cJ/ITQuK+iKrDCnE8c+zwNCyhPFzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS8PR10MB7301.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 12:30:08 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::95ae:6cb:e93:cce0]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::95ae:6cb:e93:cce0%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 12:30:08 +0000
Message-ID: <c435f832-af28-446e-9614-6a51c2127c59@kontron.de>
Date:   Tue, 22 Aug 2023 14:30:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mtd: spinand: micron: correct bitmask for ecc
 status
Content-Language: en-US, de-DE
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        kernel@sberdevices.ru
References: <20230822122534.872646-1-mmkurbanov@sberdevices.ru>
 <20230822122534.872646-2-mmkurbanov@sberdevices.ru>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20230822122534.872646-2-mmkurbanov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::11) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS8PR10MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f09799c-861c-44c6-5fd9-08dba30b858c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhEdbDYkeoyQwPbZAIAJap0WYlT7dSOgmO5ZwGYFrekp4qGXNDntK+JAd0JgtwdUJ6G+DB0nOvQkF7Q4zev7pqpD5lQeATRrfllGAaqWa59u7sTMWfJvnUgnOr9YoOeHVUGaE7NdjgOFRsW5E/fnHo8IzwUqTTDfQBGivhTZQF9ps7AEtQyt/wu9HuIERXORXGjnEehFUMhF1GQ3b39/SIhfOh2plw9hzzd9Cz7ZiXOWHdjclWDMjpxbCXvk+d80khpdhmQvvb1HM2t80o8X4RZbHbGUVVUd39bGo7rNbZBthUG9f+uyhB5T58rGDxXb5kltJuftPt+peR3QHaTr/8NEkiwkr+VgealZHRSa9SX93tWwfl7g7slWrgIgD2eUzcWyoR/21Ls/9aoB+P28kKMXgx/hUtK2s2fgP4dCiP1uoS7bHVwH2cSbhUp3Bbyi5U3I/q/M0HPNYkQ8yS3hQzoqXUmGlUFxG6wCb1FG7VhIt+dZ2OBewM7gEodYLus7TJ1xcNOwx4+yD8Z+Dw/v/4KqCDFnylAbo6yCyVQf5ZSMYeawajj9ziUk5mpJdq0upyCCZLMgdvQDUEsUtKYEZyQRSIX+zaokMUzU0ZDzwtCYaAO4k8VToDkGpNV1XVBJ6cWsqqnX6q+0FwnpwaMlIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(66476007)(66556008)(316002)(66946007)(6512007)(110136005)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(38100700002)(6486002)(53546011)(6506007)(83380400001)(4744005)(2906002)(86362001)(31686004)(31696002)(44832011)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1FXMHhDbEVnM2FxNjhIcXFPbm5pVDJUVFRZb0ZIZUplaHlIaGswZXFKa0RN?=
 =?utf-8?B?cTVqdVJLSE5DVm1wRWphMGE2L0I0WXppUVkyQVlhRXlNRm9TUDJFRmpMT1BK?=
 =?utf-8?B?REY4VVkxbUxLNFJLT0hhd1NpZHFQQlVBSDJKV0ZrNDU2aE0yOUxkdVFjK3dr?=
 =?utf-8?B?L2VLVUhSZ2xnZWtPZ2NSREU5UXBNbjNrME01WFhQYmcyd1BqTE9sR3FOeUlP?=
 =?utf-8?B?TWVNaEt2Z1hxQ3YraVNib2VHT2V6dXlMNUJuZFUxV0phVGhreFdoNTFIb0xZ?=
 =?utf-8?B?YjVJTStuUkZ1S01EN3Y3RWJBZU5mRXVGNFFISTJnZnUrbzN4VkRuM0tGdHJl?=
 =?utf-8?B?d1RBNGNZREhLR2ZheTQ3MHBWc2tZWnRzN2xJT2d0cFVJbkhUaE1TcTBwTktz?=
 =?utf-8?B?bi84RlB2OTlEVkRBMWdGQ0hiSTJJVngxV3dkOGIzdTRVakg5V083MW4wb3F2?=
 =?utf-8?B?c3VvSGFMVERZQzlYNVNsT2o3YlJ0eGpQak1KMlIzdGNGc21ueVlObE5wTzZo?=
 =?utf-8?B?WWFuYjlhK1hwVmpqV3AzSVFSOFdQWi9KTTEyV3JnRHNtc2ZaWUdVMExnZHNU?=
 =?utf-8?B?Zm16Vmt2L3RDTFUzeGFpVExHUFFhdFQzQVVhdFlZZ1I4WU1FSFBKVjN4WlMv?=
 =?utf-8?B?ZUwzcUc1K3hPY3V5YUR2T01JRU9zUmxiVFVQL0hIVDYyQnVaWFZOVnNDWUpC?=
 =?utf-8?B?S2N4TnVybE1iY3h2MG1Rb0lCMm9DNm9pQndqcEZHdXB2eC9GUWxMYzYvUllm?=
 =?utf-8?B?SENDYWU5SDhxanYxZktiREgvRkFzbk9JUXpJWVBOWG1jcjU2c29PblVYQ1pt?=
 =?utf-8?B?dkNUaGYyc2ZCN3dIc3MyWGdhdHdzWm1NM1UwS2VuOHlBNGNtdWRjd3RnNEhz?=
 =?utf-8?B?cnJPSmxjRlBvNmlIcklvMnVtTnQraHRTZDNXWlpNQmtKNW9CdzMrb3dQOGJO?=
 =?utf-8?B?emRweW01bm9Qa3l4MGV4YldtVVdQZFlxZGZVcWZFMkdXWWtkSnBiMHNSck5s?=
 =?utf-8?B?RVZVdnEwN1hwdnh6UUZTVnJzd1VkL0N2YVJ3SzAvU1NlZExyYmJ4Z0hWQTUy?=
 =?utf-8?B?UCtCVUZiNTJDczNIYXdLME1Va0xuZGx6WUpnOHd0QnJhYm50akxjZjErY0hE?=
 =?utf-8?B?dFN0RXlpRnd3R0tZVFJyQnhHVjhtY0I1RVhBRTZOOEUrNnJ3WCtJS3I5Q2xV?=
 =?utf-8?B?VWJRbkN6MjN1S0EySHFwbHU5ZTVwZUxNQlJ5OHJ6LzR5SWE4bCthS2VsTHJz?=
 =?utf-8?B?RGg5RWZISVdKK2xZaWVzTnpvZG9Kams5clZ2K083WlhtVnpaMnRlampzZVFL?=
 =?utf-8?B?eWg0NG5haHQxVU1MSENTS3R2OWdRdGdXUVlFdHg5SmFJTlE5UjB0cGxJc3BC?=
 =?utf-8?B?S1lTWDh4V00zdDRIekhqSGNzS0xEckE4Q1RxcFRYTHRsSGtFZzViMEVnMDZR?=
 =?utf-8?B?ZkdqOXU1YWlFV2ZTR3JHZnVHTjh5QmN5R2VET3ZvREh4WXRObGxNYWZiclFV?=
 =?utf-8?B?Y1lhNU5GN3ptaUZYZlpZL3BLa2lPakF5emFHcjBINm9MeEhLSFhIQ2syVXFF?=
 =?utf-8?B?QzNQMVJFaWpCUHAzczF4RzlTTnRHQjAzK25sYjlNVXBsWDNTeTZGa2lIUTJT?=
 =?utf-8?B?b25DZURSamdodUQ1L2srYXBpMUxOVjhwZkJlZVhRMmMvcjdQSGJsbmFPOFpv?=
 =?utf-8?B?by9Kd3ZZR1NzSEJDY0tLZTJUOE53RldEdGo3S2Y3cmE5L2NrbmMycVZ6UjBp?=
 =?utf-8?B?NkdiRlRYYUswZCtxc1VnSnRhV1hoRGJpMkplN2lOZ3lkUktzN204bGNQOGRq?=
 =?utf-8?B?TkVHMlpFUmE2U291dEozZTFBSWR5cXJ6SHROWksreXdkSjRXTTRNM0h3dTMw?=
 =?utf-8?B?V3pIMHJpWm5mMDdSWVNvR0gvVHNFODRlMWNvNzJZeW9BNTMwekR6N20vNXM0?=
 =?utf-8?B?QS9ickxNZkx3cXdOd1EwVmVRZkZCSVJ2ZlN0dTdhdTZYZGpVR2I4M2dGUUMr?=
 =?utf-8?B?cnNVUlpxWC9Mak9wV0NBOGoydlNkZHhFZW5wSSs0UWtiYURNZmlhcEhsU3Ns?=
 =?utf-8?B?QjZ0L1ZxYk5PckZZOXFBQWFCL21zMUZNdXl2MlpZN2tQLzg2WDJUUFhoREJV?=
 =?utf-8?B?ZEwrWmc0c0hnck1ER3Zod3g2ZFV0V24yN0FPbktpaWF0U0xhQ0dmc3haOHRi?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f09799c-861c-44c6-5fd9-08dba30b858c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 12:30:08.5811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlv6ZWXch2dR+n71QdULkg7XjpO/XqdlU3sUN4l8fqThbL2LshPe3RJHSFJlX8Snrf3GrhewzdSyM1J89rojBGBp7326ft4z7Qckxk8RUFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7301
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.23 14:25, Martin Kurbanov wrote:
> Valid bitmask is 0x70 in the status register.
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>

This should have a Fixes tag like:

Fixes: a508e8875e13 ("mtd: spinand: Add initial support for Micron
MT29F2G01ABAGD")

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/mtd/nand/spi/micron.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 50b7295bc922..12601bc4227a 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -12,7 +12,7 @@
>  
>  #define SPINAND_MFR_MICRON		0x2c
>  
> -#define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
> +#define MICRON_STATUS_ECC_MASK		GENMASK(6, 4)
>  #define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
>  #define MICRON_STATUS_ECC_1TO3_BITFLIPS	(1 << 4)
>  #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
