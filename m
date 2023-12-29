Return-Path: <linux-kernel+bounces-13023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D286881FE90
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024B71C228A1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F6910A21;
	Fri, 29 Dec 2023 09:18:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C89111A6;
	Fri, 29 Dec 2023 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yunjingtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunjingtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eo2WdK4oEAX219MxC9jGDmb2shLykzFce39rdKhM+MiInuy7/VfDysT5n4JnHGd+BsoJzwwEKz2V6JbbihBT8BbtI73le8AWJqauiCFXN2VRbD6h0r0+KVZ7mdro2KQozPjJrnOsHmDnu1TTZQ+Cwje7gpNxidPgNIdpC4iQVUAN7TS33DWL0jmpLciGzGlV81Etn7nFT7myt6fGVZjAdnfLdi++mqjhH/jDE9ezthsjlZQBk6FNqYaZFicJWFVebW9eZhAeMgJCkHMjsIlZjX6UQ5OMpIi/Owv7CSU7QjSgWwDD8vQid2o4QVWnHop97YSNkR28g/3N00bdVtATHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntPNnvxMTCyQM9Uejk69N3XbjW35sHkh1q4j0FRZ3ac=;
 b=TBagvjdSLk0R95uirZ3duMVoUyDVizebwGIkg47IK5rf7G9FL8K0zfA3Cavd+r2c+t4jaoIR8QbhmvuTAJnxfrVxQKF9OaOQiQ84P9jspg3hnnGk/amgFaVGPJJrFpHdIXBjyCzoNVrVX9f/F6CHyiAT2UVCno4USkGr3bsXdfzG0mCswJ/7mHRLJOlPGNiMpgJ0aeg1Zo96WSAljqfUJYx98eoAnpzJHPAm27xU70bIRCvw/MNIeqsHB8uKuDGRXA/Zx07/q00QZUZvsYCsfILD81iM2PowmRjHGI73fRLDyyiY5WsdJnroVbdh2aXTh/QsYzftUOCIJNSL0yF1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from TYZPR06MB5950.apcprd06.prod.outlook.com (2603:1096:400:333::12)
 by SEZPR06MB5811.apcprd06.prod.outlook.com (2603:1096:101:aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 09:18:41 +0000
Received: from TYZPR06MB5950.apcprd06.prod.outlook.com
 ([fe80::58e4:af9c:1ac0:cd72]) by TYZPR06MB5950.apcprd06.prod.outlook.com
 ([fe80::58e4:af9c:1ac0:cd72%6]) with mapi id 15.20.7135.017; Fri, 29 Dec 2023
 09:18:41 +0000
Message-ID: <0e5b8537-11c3-43f6-ca86-120b12ade3a4@yunjingtech.com>
Date: Fri, 29 Dec 2023 17:18:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V8 3/3] leds: Add support for UP board CPLD onboard LEDS
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 "larry.lai" <larry.lai@yunjingtech.com>, lee@kernel.org,
 andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org, pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
 noah.hung@yunjingtech.com
References: <20231228151544.14408-1-larry.lai@yunjingtech.com>
 <20231228151544.14408-4-larry.lai@yunjingtech.com>
 <f02f1a6d-88fe-463b-b3a0-4feb5a6f8c85@kernel.org>
From: Jack Chang <jack.chang@yunjingtech.com>
In-Reply-To: <f02f1a6d-88fe-463b-b3a0-4feb5a6f8c85@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0024.jpnprd01.prod.outlook.com (2603:1096:405::36)
 To TYZPR06MB5950.apcprd06.prod.outlook.com (2603:1096:400:333::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5950:EE_|SEZPR06MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c45d97-d1f2-4e79-4477-08dc084f25d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tb6zndVpmuBpQ2Ax9ZaaoBVQuyNPDDK75ZJwtUyJUQnyy4U20yXilEEWYf0IE5qZfXOducjt3qDOmY6Zpb4pIFqyq7y2VD7tctJWs66ARrkWtGd8QMlZtr/TmkcBVPuvcEcSk9y6AZ/WSofQ6C9QxIVuk3Km4O7CUUM0F/FRlU0YTVvv3hf5stmJEZrZyaD5mzHGr8BrvSQKkVXyOv54QlJhO2Op9EYy+cBwyo0/XAcd4soKTi5u7XTOgeq2FfInGaH4tgBcrQAKvHQSj5tjS6Ohw3bVy8bP/phJO1T34w3y4SWK7j78EfIzUr6XxM1VOVrwyrCfB/H80ilaXtWv6HYKQ1wQMQ6N6PHji+ciw2ZcQWkJ9Uq0iHbDP0V0ZbuH6WZ7Jfeet41uN5AtliI2nA1Pquoj74t4xmK9MOwX3qiIX25lEKsnYDoPuHdarkitEifRUOZqCXENXgC7vxUXBjQgHh2L+aAbe8kCKGrMoe5Q5MExkUVpRfgTUymWwSyAyY9IUbATh2N61YoMZLqWZn7mqSmfQNUtgJnCcJGjduy4BqS0fZQjdHlVdyFGdo35WuRVgOE58WyG0u57q3Gv9cyMmFoJWec7WZpffqgVFZCsQqKTnW+vJXDi0MGbgxysOena96Q/CyAaszUOixDZuw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5950.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39830400003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(83380400001)(31686004)(6666004)(2906002)(66946007)(66556008)(110136005)(66476007)(316002)(6512007)(38100700002)(6506007)(53546011)(478600001)(107886003)(26005)(2616005)(31696002)(86362001)(6486002)(4326008)(8936002)(5660300002)(8676002)(44832011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzJKeVpOVUdNSjlxK1M4TDFNV2czeklRcEpUOTV2RVFQbTRGSE1TSGRYMjd4?=
 =?utf-8?B?ZHZWbzR4SFlGRVk2ZGdqU29jcWFqUHQ3RlNjVTh0SUtuQSs5dVF2d0pRU1BX?=
 =?utf-8?B?bXk0WndLQTBhdjZ6Sy9sa3VMTUZ5cEpIZGtNbWx3N3UvQXJEY2FTUkVIdVc0?=
 =?utf-8?B?UVBRQVJyY3FkSllpL0R5OFRuamxpUStGa0w2Q0lSb2FsL1BFa0tCK05HbzJN?=
 =?utf-8?B?OW5GK0ZvM0drNzRiZ0ZOK3RvdkdRUmdva3h3TlB1d1lHQW0vbkcyVXVrYURn?=
 =?utf-8?B?U0I0bldCWm85UWFlbTJnbVBRNUJGbnRGRkpSRjJDbWdpRTh1MlJtNE5LbTFh?=
 =?utf-8?B?cWRTU095ZHJzMlBLRVgyNTByd1JWY2ljMFkvZ3czRzFsblFFZlZmNmtFdU50?=
 =?utf-8?B?R20wc2s4K2JMWXY1aFBTVEZQNFQ5aWY4N0EwcXd3SG5WQ0hIOGlFZ3JLNkZK?=
 =?utf-8?B?aDlFcnBXSzRFNVF0Nk1kYXltc0RTZTUwQWExbURQc0VyRzlyeFVlWFRaN0xE?=
 =?utf-8?B?WmVYcjBQNmZ6M3dQUENGRTdjYlBEcWJzN1Ruc0VleSthYVp2QWM5UUY3cjYr?=
 =?utf-8?B?WUpRMXN5VjNNZFE1S1hXQXppRlp3Vk9sRm9wb2tVS2Z6ZDZpY2d0dUdFNlZt?=
 =?utf-8?B?S2tDSjlLYnJHTDgyS3BCZGVCTnBGZ0lQOENQMWpzajBEdU1lV0R1OXhjV0Nw?=
 =?utf-8?B?YVRRTXZXbWNpQkxmTDdpY2p3TVFiL09HNTNSVk1oYlM5SE5WRHNBMFdvMDVU?=
 =?utf-8?B?eWVYNVVCeEsrZ1pFVXVRMDlFUVdBZFpZSGVXUFNuL2xWN2EyL2Y2ZzJObWpY?=
 =?utf-8?B?VVZiNFh0YkoxbTFiTS9Tank1bGdOY0hSMzNsVGRlK1V0bVpmNDNFUHRlVEdj?=
 =?utf-8?B?MzdndmZXRGRXT1NuOTg4WTBSTU10aFFGRUFHQVlHMy8rOWh3TEpMZXlLaHFO?=
 =?utf-8?B?OEVuWUlsTDN0eUpwcHU4MStHSWhCS0grRDEwcXI0VDN3bkx1K25qa2xIVWRw?=
 =?utf-8?B?VDM5azFBOENjNlFDaWFvVjlpT1JzbE1BODQrM2JOOWZWamFTN2dBZC90MkJ3?=
 =?utf-8?B?SEFmb0dTOEZEM3h5a1ZFMDFzQVlqMkg5ZWJ1QW1PUFdVcDQyR1h4NTJ4a0p5?=
 =?utf-8?B?dnR4MTF0cnExNlBIZTFjQmxzTmpqckM3K2l6MWFiUDZqVjBmWVVFQTRWQm1p?=
 =?utf-8?B?MDN0cGRiL3ZwQmtLT0FIK25xT0VEOG1icU5rcUJDSzlxdVBwaDgvdHJObnZX?=
 =?utf-8?B?WW5FVEJsekFSQ1RVUE9ZWDgxTk1oWm1rN0tCWFpsQ3dFM3VYaVZVK1gzUVBD?=
 =?utf-8?B?VGxFVVRyWVliM0dhRDF3cmVWTXNQV1FyRS9sY1pIeUpPdHJyeWswUldiK0Vw?=
 =?utf-8?B?Y1JHbmJDV2VvUVJxeUN1bURIdXVvL3JXc0ZXeTVlMSt3TVViR2l4ZUZTWTdi?=
 =?utf-8?B?dVhwck9sb29TVTViMUZORTlTd2lmNjJDQW1rNVFLRHN4bkdBM08wdHA3VkxQ?=
 =?utf-8?B?bFNBbDFORnBEUTdGWUVoRzIvRlR4OGRvZytSelY2Q1o2b2pOblZBa0c0VXlR?=
 =?utf-8?B?a3VMWDdpUzA5RURjZWtlb3krOW1IQnJ4SlNUaml2V3FtdzJUNGJZaSt5TEFv?=
 =?utf-8?B?YzFtUTNBRlFUTHlNSEhIYkNwaEpocUMzdGZPM3A0eExrbDdkVnJVTFR5eEhM?=
 =?utf-8?B?NnRIQnhMWkE4ZTR6QXJWYm43VDc3dWR2MWlpeEwxL0JwM01WQ25kSUJ4VUcz?=
 =?utf-8?B?R3paYlVDZmNQK1I4Rlk1ZlRucUZpYUpJWUlRKzIvbloxdFR1Qkc1SWFEOXpY?=
 =?utf-8?B?NVJhYmI0ejBVSHdmb0tRMHVwbDBQc3FyM2l2WnRKVEFFaXZNWGhOOEZjUjlK?=
 =?utf-8?B?bzdUemJ0MDhFQ2RWTDJDVmJwNkV2SFFPb3kvSVFSWldISTlOcUhYZElXdEcz?=
 =?utf-8?B?SWppWTlyaGw5MGgwUks1UjUwcUIzVTFYNXhtR2ZMOG91T3BHNFlwQ0IrdE4x?=
 =?utf-8?B?TnovV1Z6NXF5cmc1L2Noa05JdVJ4bnZnMlRMeW9MOVZDQ0hQaWgzaXVabFR4?=
 =?utf-8?B?djVBU3hyZUlLMU5odEVITnkyRFN0NGJhbHFxZCtMV3Q3ZURKeUhQK2ZJaHNY?=
 =?utf-8?B?MCtKOTFnSG9ib1lIQ0QvcUcwZERrY1BpSEIwRGY2c0djaVU0YjhjU01mVVNU?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c45d97-d1f2-4e79-4477-08dc084f25d6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5950.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 09:18:41.1067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UtoSSjvQWwgBXRgVQCuXt180JDMtfJ5y3EgzOyjOs06YiW18ncS6B1QYJbVvKlJ4zH1lLjWNcNZDOQVeEMzkA1cIGK15jLLSHFNL6aXPno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5811

On 2023/12/28 23:29, Krzysztof Kozlowski wrote:
> On 28/12/2023 16:15, larry.lai wrote:
>> The UP boards come with a few FPGA-controlled onboard LEDs:

...

>> +static int upboard_led_probe(struct platform_device *pdev)
>> +{
>> +	struct upboard_fpga * const cpld = dev_get_drvdata(pdev->dev.parent);
>> +	struct reg_field fldconf = {
>> +		.reg = UPFPGA_REG_FUNC_EN0,
>> +	};
>> +	struct upboard_led_data * const pdata = pdev->dev.platform_data;
> 
> Your const does not make sense. Please read C standard how qualifiers
> are applied.

will do

>> +MODULE_ALIAS("platform:upboard-led");
> 
> Nothing improved here.
> 
> This is a friendly reminder during the review process.
> 
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.

the same as pinctrl-upboard doing

-- 
Best Regards,
Jack Chang


