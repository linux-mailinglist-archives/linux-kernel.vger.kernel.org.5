Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF337AD643
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjIYKnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjIYKnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:43:04 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2110.outbound.protection.outlook.com [40.107.215.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83DBBE;
        Mon, 25 Sep 2023 03:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWvYmM/Fs+rqkcbf4otnO8/GjYhwh/gwIufyw8lwUeAJ5q2jIVE2M8dBXaDZFJo7DO0TLlfW0zT6OLdx3I4Oqly6TwOb7Mw8Nrpy3TZQ/B3x2f2s1K4ZDH1nD0grnOfJqpx5D07XMYCuWv/ozbA7KbgGrOsFgRXH4602kJRBiRbGnEy8U1VSkUb3xUBN0cWgJYEMbbuywGmaFZtxqwRu3zMPYM5LKLkCnYE0MEx/Asy7wVmEE2USsGHk1WhI0FBwUu7A5mpJrnuogSZOdfaRtGs5JPIWN9eP2elTS5miPEPnD2dcUpoBcQ404D3+Qa17GtUGNq1B8I6pR//sQrfvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwI0gfbmPjW5pBx3s0+8Kl1TIQo+ZO0ShHR0ZGa6v+A=;
 b=egdyAQ9fWaVNchaCtQpOhJ7+JAro9BzJ0Gnvoogg1tYB6ZQCP3oXuEcl31NvTSfgtf2/RgRmkaNgIMWeDTAj+TD3WAkFZyv8kOpTPGvRfjzwGurDVfdFFyj6G/0MQrZS9zbcrDJBAeopN7i+79lxaEpAZtNW8YrqFr/sTZ8Bs4WXVA9Vi0gdq2PEaZJ/TTLjabunLblkfxCuMODfkEMxk1ziEI/1WB6/oZMxCswRn7x3f/KjkIPyEyeeCqcgIf8p/26hMvPzjPyTZoBwR/9akROHg7Nula4Git29j31hMIKgWa3Bquc7uxUha7ctTdgCfMqelUA5gsvZk1O/WNBq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwI0gfbmPjW5pBx3s0+8Kl1TIQo+ZO0ShHR0ZGa6v+A=;
 b=r1leUs2lMb+pm/xLP5w5ZUdnNmCiQb/65DCzgG81RZYla4hPaHAcuYXrv2xCFF+lGn9tQqFgxuOHQev0MIgPpOBRMIztZqRCGrE5V7qghPSl7uMNxIGYOkC2o79vhvn76ZnnQovPgxQfyyV4/rAkleI+v8jxPKzvqdBxvPFilSU8TqvaT/u57985FQZdAgP6bqoMO/OZ5tE5INAjkOa4tGeUYgI5A6WEWtnuK85+fCePz9WjUvjwVAhSXh0cSWOzh5R1FhwllAQ/8PrE36jUVi2F+A7sG0D6GkQ6YYai7Kt32u7bkHP/BAPM8FUZ3PkWU6s42tCn76U5G4S9O5H38g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com (2603:1096:820:cb::11)
 by SI2PR03MB5860.apcprd03.prod.outlook.com (2603:1096:4:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 10:42:09 +0000
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::3f14:c67:12ac:af39]) by KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::3f14:c67:12ac:af39%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 10:42:09 +0000
Message-ID: <bb20efd5-4f60-5ded-caa6-2c9c94a10a44@amlogic.com>
Date:   Mon, 25 Sep 2023 18:42:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] arm64: dts: Add watchdog node for Amlogic-C3 SoCs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230925090641.1185942-1-huqiang.qin@amlogic.com>
 <51470d7a-65a7-44c7-856b-53ca4b065553@linaro.org>
Content-Language: en-US
From:   Huqiang Qin <huqiang.qin@amlogic.com>
In-Reply-To: <51470d7a-65a7-44c7-856b-53ca4b065553@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0167.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::7) To KL1PR03MB7221.apcprd03.prod.outlook.com
 (2603:1096:820:cb::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7221:EE_|SI2PR03MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c27e15-cfd4-462d-52f3-08dbbdb410ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iXPs9bXzO50b/eluq7ljD9CV2loEUbfLrmx2FqplWdJKMptL4g6Da+FPC4Roz2HdzagiXL5pp4IEIluoHtr5I2ST+mUnCetrMluiZw1UeM9oTsRjBUmQlaQ9/Km6CWSZeauxWaAJXspb1lPpjf6+xNGnFimWntuLKVpuym62qD61vBTkHpZazF5jBYeKFENN76rt0O70sabmiKrxfLooEsLo7D6nY8FXU15JhL/ZPVqZy14+duQFVT9Z4ZcKRbw3Ed7yGmWpLxhIxAqeRYKBLw1/P2TChIG5ov5+DvKlDnKEsM71Ta6ojYh00xoH+DwiJFyPK2/4GbqzzNReWTjTHrwL3nhieQDkMkFoxz8RAzFThcSa9iLuWMVBT8ACeUvn9ll5iTupmSnsr4HYHdXZiVZF/e6Ca4t7J0l/pInOkeCkfsCIyGurFTQ6/09M1jsyxOvWcy7pVJolq2d5g5B+NKPrJbsh0SrtH7yyQEWblMV1FjaSZe6vRu9lrAS1KYlJvbIsxqQwhrC1rHiJFjMUBdG+/ximne+H9W3Q6KwuoBxkqnZvWu0Oy7Xo9t3XLhNQhvnxrQeH8rTwwLFnrZ4gTpYdl8pTulHi98eux/ZJp/WNN0HSeWLwnz0iry78K3UBP7AHwlYkqxhW/iPeJdEh6aa18A+hK9shoCzS/5DAex6jF8gCm+AVfwszflUFFnqp9x6JkRLPAH4Gx/+uK3AESL2Pwps7Jf+SRScLmoPUaQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7221.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(346002)(136003)(376002)(366004)(396003)(39850400004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(53546011)(6486002)(6666004)(6506007)(52116002)(31696002)(86362001)(558084003)(38350700002)(38100700002)(36756003)(2616005)(26005)(44832011)(2906002)(31686004)(8936002)(8676002)(4326008)(41300700001)(7416002)(66556008)(66946007)(316002)(66476007)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFMzbUVTdXI4ZlAwWXN0MVQ1MTBZRlh6OVYxSDVqVFZ0b0tWUXRMSEVvNXJN?=
 =?utf-8?B?R2hkWlYxT1Y2R1lHZnNRN2d3UXFNNG1DNjFJTTNPZ1IxNmJoM3I5blVkSnVw?=
 =?utf-8?B?aXoxUlhsdnBXVGwzVVlMWStBN2F4ZkxSaVRqTTZIOHVQdFpPM3FqUUJkVEdJ?=
 =?utf-8?B?Nmo1VEgzcFlIK0VObFlBZFVLdnMzVjZSb0xDMEtUeGw2WDJBelZ0MUVhcS83?=
 =?utf-8?B?RTliV29nWnpjZHNLU09uSFBjYzhoZUc3RGo4aUkyZDVBS1J2ZThkZE95c2M3?=
 =?utf-8?B?NURPbURMN3Y4aFNBL24vdDZ6MU9uNlU5bmx5QXVackxBSHg3OGlDeTltWStV?=
 =?utf-8?B?ODY2UXRTWHhxL3g5SU1rODk3SFJIRW1KSnZMYTB0YnBwTXIxOVR4T1FEVm1J?=
 =?utf-8?B?RWxEdFFQamQ5b1pIVC8rTGVxM0dGNXI0MUZXamdhdE1NQ1NzdnVYZnBLbE1y?=
 =?utf-8?B?TTVZeVpaM2ozSTA0OTR2LzkxblRhNGhFbmNGcUtCWHkxcThlaWVJTlZPWG11?=
 =?utf-8?B?eSsvcUl5Z2lCMXFhTlpibFNMenR1ckJzZjlCdHB3Sm9sVzhRNDdYQkFBVzJn?=
 =?utf-8?B?U3lhN3l2M0lWYno5ZU1FV1RFMkJpUzgyZGJqVkhVN3ErUE8zMXlVdUhESDJE?=
 =?utf-8?B?UTYrN2RNQjB4TmVjUVdTUUZnbmRzMUZoZnhJMnJZdUN4bjJPM3hRYUZQZDFH?=
 =?utf-8?B?R1VMV3pROEVaaGRwWk0wZ2VXSjIvRFY4RzI1SG1jSE1SckxlbmNucGpjNVJP?=
 =?utf-8?B?QXNtTTMwNFFJanhiNHdMZGl2MzdzUWlBQjdyVlR2VVNxVGk0ako2L3RrUmtM?=
 =?utf-8?B?YUJGeUQrRE5RaklNd05QMzkzK2dvNXVvV1pONG03ejBOcUNUaFNlWTBUTzNp?=
 =?utf-8?B?Z2JsWitTV09Jd29LU240a0ppelRFeXM0elFrTVdBak1ZcHpkUzlhK1ZsK2Za?=
 =?utf-8?B?MGgyZG9Ia0Rhb0t3TStoVEt3STNJNjBSd0o2UTlMSzkwSlFPRTRWNGcvK05r?=
 =?utf-8?B?aVc3dnk2anBvc3pCMTdhVTBKWlBwYlRQT0cvV0JHclJWZHY3N3pXVHppcm1Z?=
 =?utf-8?B?TEw4cnNKcjhsMjVmNnEreWhjaDRodzdpUThnWGF3dmk2YWl3NUYwd3JNbEVD?=
 =?utf-8?B?a1dXTHE1WXF1Z0cvdWlLdHk4SkZWN3pNcWVsWk01QzV4VXFKYlB2Slo3S2ZM?=
 =?utf-8?B?MWdvaXAyczY4d0JYZ1puNnU3cVpGajE5b0prRzJyaFhDQnhoS0dESDUwcEcz?=
 =?utf-8?B?Z2J4aWNIc3N0NENqdEFBYUlWYXU2WkZ1bjExMFd6Y0xwWEhYREYxYnJTcnMr?=
 =?utf-8?B?SHhIRnNmZjgreFhnUU1idlVFTkJSbmNtMlgweGlXd3krWUlMQUQ5REJTc1p3?=
 =?utf-8?B?T1NSRkZlbS96dkJBaCt3UGpDWC90bWFNY1IvT1Q4ZmtUMXdibW1PcVJXQlEy?=
 =?utf-8?B?cGZrZnMzTENzQjg3WmRNdWoxZVFIUTl0ZFpjUmRIZHBxanFwZzV3eDlERnNw?=
 =?utf-8?B?aFJ0cUovR21xQ0txZVhQaFZRYmJwUXhhSDlIS29Pc1dEcDA0WGtCTWc4bzRK?=
 =?utf-8?B?blZpWXZKTk8rWDFIS2d0U0hKQzZvZlU0M3hxc0hzaDhvSlJOOGMxOE5BZlNa?=
 =?utf-8?B?R0MyS3FNdW9jaU9TTXJxK0owa1I4RytMd2lsTTNkVU1DdXhyRDd4U0c1ejVT?=
 =?utf-8?B?MVVGaWlJczM0TVhlZEtNaTNUN0l0VHRSd2RTUUwydzByaURUaVVDOWxEeUNL?=
 =?utf-8?B?b21oK1Z4NEJsUjFGaTRxQW5YcGJBSGV5Wm92UDdERDJONm5oR0VhbkExeE4y?=
 =?utf-8?B?WEp5UGpoMnRLMlBmd1NvMGRhbGVXU2xGVE9saXRTNmxZK2pJVEwyTjF4MDky?=
 =?utf-8?B?dVA2T1piWGRhRE9DNG5IbWhIdktZWGFhdWpTbzA4Sm5kVnM5NjhFUmFvaUc0?=
 =?utf-8?B?TWp2UzNtNHdLRTJGb0JmN205RU5ndU1xYU5GZG5ZK1M4NmlUV3hKbVFCMWNO?=
 =?utf-8?B?MnpuTkdxWVhKTGk0OHg0N040Vk54NFU1UW41NFVTdnhKc0xUOW1jeEIydlk5?=
 =?utf-8?B?S2Jub1JWZGhGOXZaeHFNTVQ3c3FHSFNMNnlXQ0Nxb3B4aTNxS1NHNFVDNzBu?=
 =?utf-8?B?TmJxUFB2c0hQL2x1bDVTL3U4Y1JuQ3JVVHcvMUEwaFBzS2tBQWFpZFMzUUNL?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c27e15-cfd4-462d-52f3-08dbbdb410ec
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 10:42:08.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkKH+7y+4V6GTlgvwRkofpM6BsUgk8u0/ppPnPBvyFkJ1SJtp/TrZYUT2UPhObrxDLlTNptzgGooUeAwyssIcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5860
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2023/9/25 17:33, Krzysztof Kozlowski wrote:
> This is c3, not t7. Why do you use t7 compatible alone?

The C3 and T7 use the same watchdog controller, so they are compatible.

Best regards,
Huqiang Qin
