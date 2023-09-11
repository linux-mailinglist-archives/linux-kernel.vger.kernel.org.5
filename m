Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC67279B1A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350150AbjIKVfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbjIKI1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:27:31 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C461FFB;
        Mon, 11 Sep 2023 01:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+z1kiHeHE0Lqi6YOuG5EpgAq7DxFCw5nEpcNoW/C0xn5G4twVOO01ezvNAmM5+SheUapa0kg4K0nzhsd9aJFtiaFYCdV8QN0GEdF6T8qLshk8BCONIFXPwz/0PHNUmFA9kdeFVR3ic63AYk31hN3qW0wreuAOa2T3LTvyE5KDlHGWKHbKV6KxavUvYQSzrJ2EtFpCJyWqk8RDD2nEdzFx9D9Vsb7VFXVmEVamI7m/fSHPR32Lx+o00Am2SABhDiBVOd27EHfXfPDzFM0VYT0XuVD/YrtKbJ3oyQERWsoWgjYp/le97gqZ+UgQ/EMjhMrF0BZ6v6j08N/xPSfbTRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tc2NnA1+1d2DU+ANMDyVXFJRMg/UaaFLG+rQVJqF33I=;
 b=Q8wEIr09RnOJQd9z86frhPteqWaqg6JX/Qe8B+9W388hbHFNFgGS6NjpWjWrBQNn+vpqKsqE9ojV9bHUH0brcu1UhLXeOGvLeCRww+tQ48vdRKtrsxMp9F0sjkI6PzAEBLDi3RHv6J5NbP8eRoF8Z6ITBZ/Xkys//sTWWyc9TczNpK1xI40Yq3DnatKLvq0oTLQtF1YUD0N7sd7PsMHuh6D+hjiyuksE3vR2Jx1XEnvqua8po0uHgg6QN6cl2avIsKdUNZ6olpGJGba5203tHSYS2xDc1P+Ad/ejFV9aSUoIHHuuaUY4//FuvbeSN/eixCgkWaBBRroBlKfoZM7MRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tc2NnA1+1d2DU+ANMDyVXFJRMg/UaaFLG+rQVJqF33I=;
 b=dyfetfzFqIMliQYWiiIjNvqtppeCXVYrMpwK9l8OwqM5tNoRTm+BGobEYwNcD0pkklIwPPQeHmIjir/+J1iycbgkzo1wH8NPpastTE433EhAzMkwa/0gE1j8YtyjPeEJlorgAe9ztyZmdIWNtxuEnX3ipSWjNdxesghbFj/5jWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PA4PR08MB5904.eurprd08.prod.outlook.com (2603:10a6:102:e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Mon, 11 Sep
 2023 08:27:22 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 08:27:21 +0000
Message-ID: <8d1a49ac-3abc-5b75-34b0-9573971e61da@wolfvision.net>
Date:   Mon, 11 Sep 2023 10:27:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: rtc: pcf2123: convert to YAML
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chris Verges <chrisv@cyberswitching.com>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230907-topic-pcf2123_yaml-v1-1-40e82bed2066@gmail.com>
 <f0224983-d276-8d9c-f6ce-bd77f350bc3c@linaro.org>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <f0224983-d276-8d9c-f6ce-bd77f350bc3c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0052.eurprd09.prod.outlook.com
 (2603:10a6:802:1::41) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PA4PR08MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 35963d24-6b8f-4a50-6c99-08dbb2a0eb6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TrNv2pYnBpSee/dr8ZGJ80bC6FeQhkoAOpM7m0Qda3eHhPd74uyXM0TYpyXda77nAWASZ36aVsAE/wRHz3m9vSbbi2lSnr5GbAdD8sNV03tXEThyKFQ5YKibuUToZ1yOeXKh6ls5tXlR/uqSGp9dVbyQzqfTmsx4qtLLxHjqFMpm7D7GzGFT4kxGZT+iOawPxKAwwlc22DeeVdLIDfp2MSSU/J7XYtxn5lMB8JIhPMgMjyxYPZEWssQd0PdBDGJ+dlnKU2+rAPddwV6BLbV36X1ayiUQDqFmkla8IplhCHRKcrjLpVzPMZT34R/P6LS8+PItnqg25ckBjfSN3iObndB//KIt0+oeTJBCFfPhAcYKrAVFv/Gg7nOiNhzMezRoCG+nLsgvHiT6Df/8DcvLXTtL+pdriXFm6pG9JSgNHyR22BDz3LwnFpqfm2e2svcppCLlS8EtWGavagVf/sGZkghq0ZCvtOMIgN4ruDR3e+PwdiCiKT/5Avlo1JRQ4tysGQbNMs7s8mGeF0veeuHraITNzt09F5dQJz6CaFo6hz4NETCN3wD+sK8pMtOmtt2JS32schqs5t/vnnbSy/baztO9+hbks6hC+Bs10yW9eBz3UWUGU48DPt9xp/BNnon7oOHiHG4ybNSxe8iEUz9fLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39840400004)(136003)(346002)(451199024)(1800799009)(186009)(31686004)(6486002)(53546011)(6506007)(31696002)(36756003)(86362001)(38100700002)(26005)(2616005)(4744005)(6512007)(478600001)(110136005)(41300700001)(316002)(8676002)(8936002)(5660300002)(4326008)(2906002)(7416002)(44832011)(66556008)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODNVWnFpS1JyeTZXNjFBeGw0a3g5dzNFNGt5UjdmZUVheUtUSDlVUlM4aitr?=
 =?utf-8?B?Qm5FSjFaeHN6NjZaYjFkOWdJclkwSnROZmpneERTSjIzVVZaTFlOdWhuSU9r?=
 =?utf-8?B?eWNkelZ3cStHQ3p6NThHMzl2WVBEM1Y2Q1N0OGFublJvOTk1eGRJbUNGalpD?=
 =?utf-8?B?WE9OeHNJNWVINFNUUVViRUQzb0laUlFYOEs0Mk44RkFQMXFwN2p0S3h4VnpO?=
 =?utf-8?B?VVJpZXk1VXVMMzcrOWxjREpIMC94NElBTFczNmI3YzZrMzdwL2x1aEpnZHU3?=
 =?utf-8?B?QUFWNmtCSHBLbHg3Q0dJMzBqbnZTMGVjN2RBUWE5eXdPWjRkVExNT0ZZNUhW?=
 =?utf-8?B?Q2dkOEw4UHZJWHRRcXcxTGYzOVNDL1hEVUF2ZVk1TTBZR3BtVVZxN3Y2ZFlN?=
 =?utf-8?B?TWlVTFZBVXdVNU0weWpBVm1uY24zOGUyS01Rd0U4TkNGN2h1aWwrenhGNEtQ?=
 =?utf-8?B?RE1pMW9FSTZWYnI3ZW90emVMdGxrN28vWm1kRmY4SlRRV3gvdmE4bWNmM0RV?=
 =?utf-8?B?NmpnNTZQSHQyOCtQYXN4ZllkNk1HZElHR3VhMEpmUEdvRzY5UjE2ZlNYRU1N?=
 =?utf-8?B?aDlJUHhRZk5DTHV1VEpuRzZhLzZBMllvbCtYRzZmOWxOMlg2NjIyYXhHTlhP?=
 =?utf-8?B?cVlBMmVjUVJ5LzJrT1FKdXRhcDdHS0NmQjZ6dGMvdjBVSUFyYVBiRlZUN1V6?=
 =?utf-8?B?OEZ3amM2REZDYm5zajZOK0MwdHQxWlVaZkc5NFU4SWxhYVdxNXJoYUNxRnFI?=
 =?utf-8?B?VW1hVXpiMHBIaEtlZFhCRlliZnBNTGI1Ym9WUThNSWVzcnZQQk94TU9ITGpN?=
 =?utf-8?B?SlJlVmpSbE1veDdhS28rYUdLVE9PQk9xSnZicGl2dUp2UlcxRTRqdm9hNmlD?=
 =?utf-8?B?LzBQZmFVZ3dtOWdVNnNjZzExODNYL1VkaHllSUkwS2hRN1hWYmtUK1lrM2Zh?=
 =?utf-8?B?OWpuMjZUWHg1NnZheGVnYTJ2MUdiQ0QzN0F6SnFONnppMktGa21rbmF3RXI5?=
 =?utf-8?B?c1pOYUZwWGpsNlA2RkoxdGUvV1FlT0RCaWwxdk43WU9SZ1RYbUU2VjNEK01q?=
 =?utf-8?B?ZGdrZm9BRGhDa3lBeDQ3WGFMWGpQYSs5RnVFOTBQcnh0NFJiSUQxWE9wWlpS?=
 =?utf-8?B?NkYxeXBycmdRelFOeHNtY2d5WjBRWmw4cVZVc29pY0dJV3ZVREVobFdTN21W?=
 =?utf-8?B?ZUdBa3ZWcDg0MEQwOFRmdGZQVHN6RGJlTU9OMmVRcmdpZ3dGVzVLUkdxU1V0?=
 =?utf-8?B?Vm1vMVFIMXNsMnZITE5FN0YrY2FEQ0xzZVZSM1FHK1ZodFRCMzFRRVhDcHdS?=
 =?utf-8?B?REZLZU11MkJ0ZG5heEV6OGVORXZlSXpLc2lIVnB5Skp6cEhvM2FaSklyWjU5?=
 =?utf-8?B?R0lVWXRrRVM4VlBaQUZTMkVKQUQzK1J2cGdSaEl2ekY2dFB0djRxczB3aUY1?=
 =?utf-8?B?QVZ6NjQ1TEdWMUI5SzdtelFWRmI5aEtFQkZocldhYkZMSFJKMjZiMUtMaGxH?=
 =?utf-8?B?cnNhVlZQRnhDdlZMbm9lU1ZwWGhGWlhteGdXSWJVSG9KOEdHaEtJdUsxbUJr?=
 =?utf-8?B?elU4ZTVXMEo0OFhETFZ2ejN3dDMwdklvVHl3czVyRGs0TDM0eHl6bmthZzA0?=
 =?utf-8?B?Yll6Y0EzVDA5eWZoQlRQZGQ5Ui9vN3F3TE1VRlN2NXVkUFdhTnRDZjhYVlFp?=
 =?utf-8?B?L1FhZzB1MVBMZXo1UVZTNGVvdE85UXJNeGZkTjR1ekJiNVoya0JqSS9vdXYy?=
 =?utf-8?B?b00vYWkrVjZmeFg2K0ticldlQ1dUSkFtWUc2ZU5YT0hDSHRDaE9mUjNMT0Yv?=
 =?utf-8?B?NUl2Rk1hS3EzUjVxODZuTmVOTjJNMVIyVkNndHJCd1EzL3VDUVJsZ0l6NEha?=
 =?utf-8?B?R2ltTFVUbHhhMzRkSGVpS3Y1cGZRM0ZQZVFiS3d3Y29jRkQyNWthd1NDVGhm?=
 =?utf-8?B?QVNQNjhpWU45RHowQ3RvOXFKL3JlbWlrUmFNRjhCZkZITTd0ZXhGeXFmSUUy?=
 =?utf-8?B?ZzRFOWt4aDJUdWNBV3ZXcmpSTW1kY0tTTHRObmpESlRrS3hRRE9aWDlMU2Jw?=
 =?utf-8?B?c1ZWRGdoZVZ1cUVqUGpkTndMUmNHbStkajllQ1h1SGFSd2Z2Nkc1ZkJiQzli?=
 =?utf-8?B?a1NJSHRUZUg5TnBwOThybXVxend3NEVMN0ZIZWJBNVFPTktSbjRFTGtMQUtQ?=
 =?utf-8?Q?9zMhaguvDUmwbJYCxvPYRcw=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 35963d24-6b8f-4a50-6c99-08dbb2a0eb6a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 08:27:21.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OV2+zsZeyU7bxHbSJ6kY7NxT1112ASmC8HWI+JB1rHPWuC5eblZEy3oYBiJgZRgzds+E4soTh4MK2joQx+C4ejVoGlGWl5aqaBc3WR0OLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5904
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.09.23 08:17, Krzysztof Kozlowski wrote:
> On 10/09/2023 13:00, Javier Carrasco wrote:
>> Convert the existing txt binding to the preferred YAML format.
>>
> 
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    spi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        rtc@3 {
>> +            compatible = "nxp,pcf2123";
>> +            reg = <3>;
>> +            spi-cs-high;
> 
> Example should be complete, so preferably also with interrupts.
> 
> Anyway:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 
Thank you for the review. You are right, adding a line to complete the
example with an interrupt does not cost much. I will add it for v2 and
wait a few days in case I should change the maintainer.

Best regards,
Javier Carrasco
