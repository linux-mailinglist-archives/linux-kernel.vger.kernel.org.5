Return-Path: <linux-kernel+bounces-13022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4245681FE8D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2A61C22D55
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CFA10A3E;
	Fri, 29 Dec 2023 09:18:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2124.outbound.protection.outlook.com [40.107.117.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0422410A01;
	Fri, 29 Dec 2023 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yunjingtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunjingtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkRqfZVxibOPMTiKg2uzgZebfV0KNnilq/o2hkLNGpbmeWkWCrEIAqxvhr/EIki+1232ueVBe5Oc9uBi6zKGrPb2aB+OuA0RJNyB8vBsqh+LfnJjl6bRpAlb2AZCH4H2y+caGTzgilVeI/EnkMRmIYYQzvrbNsjCRZXm6DtwVMAshgMouf7J9qpNOGYAyn8J1jHgTxTvqOWOAo0qL/+Abk8bh3UWc963U9g1Q6mQexVKgarh3drT+wAwn814XOHELF9SL/3MmRVn/uuj/7qEPZr/VEWlXrM8xIHmhQCsuqb8eBc7HtxAscp4lqK/C1OtvxX5HG2WCcLgMSIJ2dQqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXWe9tBhQlCaXNFjs+8TuJup8RODQ+ZhdV8QvR/edew=;
 b=Z0JGKVhnh6RJHxbqvpTe6lrbdjijI82VCDpgkq/tC4h9UStBTS3ue5P/0A9DjBVv6iVaxCDoAG9wb01dxuETX9Fmwuqine/KW2SO5kmaEvGwADLnN1Z970cc80govJdpmWsvWx+v4z326w9Zm5DSbJl6tV88UVOMo18YKjX0lh6JfjURy9CHPf4MuXzpXhxkfZsGbxtBla2nPJTutl0aDFxrAMbotGqNBVnbs/4Lvc9moqVIduU86EzWcxWcCdCGcdqb+vhoDSn0QI90CQCTctbqes8QsJZ1KcoOkdRtPlzsf92htLF0v8HXxMWd9EMxNFapuhx7nx1s+UVC0dAHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from TYZPR06MB5950.apcprd06.prod.outlook.com (2603:1096:400:333::12)
 by SEZPR06MB5811.apcprd06.prod.outlook.com (2603:1096:101:aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 09:18:34 +0000
Received: from TYZPR06MB5950.apcprd06.prod.outlook.com
 ([fe80::58e4:af9c:1ac0:cd72]) by TYZPR06MB5950.apcprd06.prod.outlook.com
 ([fe80::58e4:af9c:1ac0:cd72%6]) with mapi id 15.20.7135.017; Fri, 29 Dec 2023
 09:18:34 +0000
Message-ID: <c3a5e8ab-f1ec-e9f4-927b-994bd94a475f@yunjingtech.com>
Date: Fri, 29 Dec 2023 17:18:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V8 2/3] pinctrl: Add support pin control for UP board
 CPLD/FPGA
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 "larry.lai" <larry.lai@yunjingtech.com>, lee@kernel.org,
 andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org, pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
 noah.hung@yunjingtech.com
References: <20231228151544.14408-1-larry.lai@yunjingtech.com>
 <20231228151544.14408-3-larry.lai@yunjingtech.com>
 <49f1ebee-c2c6-426a-8b85-69d8f5b65c65@kernel.org>
From: Jack Chang <jack.chang@yunjingtech.com>
In-Reply-To: <49f1ebee-c2c6-426a-8b85-69d8f5b65c65@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0014.jpnprd01.prod.outlook.com (2603:1096:405::26)
 To TYZPR06MB5950.apcprd06.prod.outlook.com (2603:1096:400:333::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5950:EE_|SEZPR06MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d93282-49b9-4682-0145-08dc084f21f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m5Cmv2mtgZGZVA/cn20OsrwnYbDAdfRrFxbL/dGksvbvlTctM5x3RFrFbYmQXdByYoKBDs7VPuAk9CdUdq60UaTk/NtCnqzFQQta1J23bMqZR6BQYOYl8zNurqk0V8M+00+QUFtGfWK2771Qe8IzWstjpvSj+TQ3MVqatoyr2/hIlH8TPL1zsShLCqYLtyJV1tpul2mIsaop5MiI+gvDalxJyeZu4/xR4AwExvfxQoiPaMkjEtaw+AcylOLuDj5ksZVbBY4rhfpHIqKoM36gxzK7R/TiHm2Uqoe54DeXIF5Z1Y8mMOnfN+iv8Qb3aFf4OJXajWLK9OdCvkeDbdaH6J+HrwIzxGkJZpdZVaGGOgIxcsxKRIh7ODOrSCmSQ7wur9dkzGDM0mAdaH+JafsHlcA7jgtnqIxZwwXKgBYp1nTIbDpMJvY8cIdZ8kdKCS2ayJ4uH7n0QQkr9q8AEOY5kpNLpMb/bb5tBu4nAJ3MfMBuhn5ki2Aakh8JkbGfkzbDdWiilDYDlQBOKVdzTMXcr+qycShkWxoa0134ZZn3MuRdL197QnfTIp4t1X7NTBPv+8l054ZVbPjE/6mn0cipExqnHpjMfaFNtDS9AYfK593rN9FgsyVsGWoRkwL11mrfgUSVQWbdGeHxOWcrU5vI8A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5950.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39830400003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(83380400001)(31686004)(2906002)(4744005)(66946007)(66556008)(110136005)(66476007)(316002)(6512007)(38100700002)(6506007)(53546011)(478600001)(107886003)(26005)(2616005)(31696002)(86362001)(6486002)(4326008)(8936002)(5660300002)(8676002)(44832011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlhVN1VFSytBa3FmK09jOXNEclpYenlMWnRhRUFSNE9PNDN0bloxaFZCenlw?=
 =?utf-8?B?azF0VTM4TjVQaW4xSVBxeTdwRlR2cCt0NEdKSmJFTDdNcFJoN3RxZTU0cThE?=
 =?utf-8?B?dUZ2MHdCZmJST2VwSHFaUW03MmVqVDN5RURvVGRjR3B4Ylpqdzh2aFZmZUJT?=
 =?utf-8?B?SEZyZUczSUlsZW1XZHhQOEhFQ2I5UGVMaGdCUmZ6cDBjOG5DOEpFOTUzMHAy?=
 =?utf-8?B?bHlvUTBlK3pjUyttM2tNY2VpMFhMb3NabVFvNUJXenJRdk5tZ0hsTzhMSlhk?=
 =?utf-8?B?dE9DMGM4ZkMrQm5BYjB0RVk3blFoeFU5YnkvREJrbHQ4bmpUNUF3V0s0VExh?=
 =?utf-8?B?amk5L2hJSnk1blZFL3B4Y3RnRk5LTFpOU1pBVEtIQWNveGVZdHkrQVlGMUpj?=
 =?utf-8?B?NnBQY2Q4MThOd2hWa1BrTkZkalV5Z3d6MWFwS3pzRk9UZzM2aGlyMzVFNmFl?=
 =?utf-8?B?S0tPcVVkSk5vSlpXRkJWWkNuVTBzUEYyMU5HcXdqc3BkdkJWUmpFSGdvUjk1?=
 =?utf-8?B?djZFMDB4T0lXcVlIVStiRm4ydVhGTnlpVzJsS1pUQjE3b21FdEJzUjNPQU1X?=
 =?utf-8?B?OEx3M1o5MzBhRk53S2lwVWpOeEFqRDZDSDNVRWxSZHRqb1dqSjZPbE9ZMmo1?=
 =?utf-8?B?dlJ5UklnR01vd0oyS2Z0c0hoQUpTTEljQnExVEowVm1TZzUrVEgzSjJlWTln?=
 =?utf-8?B?MzVyTzRkcDBhL1FrRnh5SzA5M1BNS29yY1FUV2tKWnQ4R0JvNUM0VmVhSi83?=
 =?utf-8?B?Tk94SzZ0cDllWW84UUc1ZzJZY3JyZnllS252bVNNbjk2TE4xcFUzV3N6YWpU?=
 =?utf-8?B?YnNNOHB5UkNkSlZyNUpncXN6d3lIR3c5Q1ZQckJ0Z3RmbDd6c0M4LzRkU1Zx?=
 =?utf-8?B?L3I5TnpkZ1ZyU1VWcGZrVGFQY01sK3Vyd0NiZWlRQWc1WVhzbUVMZ0hBbGlK?=
 =?utf-8?B?QzdsL3E4TlZKL29BT1FsdUh2dWg4bE04ZWQ0eTdWZUZDRFRPWWpFOGJsODBT?=
 =?utf-8?B?ZG9Lcm5xbVQ4cnNRR3Z5Ry82bGZtVTgrNS9YbzBtcEd0K0w4cit2bzlJNE1q?=
 =?utf-8?B?WENNYzdtVDR2YjVGaTJTNTdSdVlmdDFDekhWTGVER3JhdWlxU1pFQnYwQXJn?=
 =?utf-8?B?ZXZySDA2enB1dGtTUTgwZXVKanJKcU9rRXhKUzhwV1VINHU4WVFUTFRwTmlY?=
 =?utf-8?B?RjBwOTk3RVJNTkY1MUJjN2tpYldaR202Qy91QzRldndpekFESC9UdHBsdUVD?=
 =?utf-8?B?WmVXRDBYejRKc0N6RDkxMGRYYjBlRUF5TWduMmtoblovSlRIZUFFT09DbEhW?=
 =?utf-8?B?RDNLeWdKV1pub2doQ0R6WWpIVERGd3hmYXIyN2FITDRXVjVuaEVRM0NDalZz?=
 =?utf-8?B?dS85YlVCN1ZjelREMWFWajBIVGtMb3ZuRCtrNVFOT3JxQmZjMW9GSTdrUjhy?=
 =?utf-8?B?ZHNRZkdRNEpWREJXdUNqajdhRzhjZ2U3T0pDd29UeUNJQm1PYkg4SmhwWUd1?=
 =?utf-8?B?OTN3ZmRFT0xQUjNwMjFUUnU0VVdma00wSjN3Y2xYdTN1emM1UXBsVklTUjVl?=
 =?utf-8?B?c2lFMXUxYWNyUERWOFNtaUdCQ2JNNjRXeWxHK2o1bXdmRXhOVUVRS3UzRm5O?=
 =?utf-8?B?TUFUMFQ0ZFUvZkt1MVNaZnVLWmZ1VWxZRDAxVUova1lDNmIxdFlVd0pGTkdU?=
 =?utf-8?B?VVFmcUZZNXVQU29VQzNibFRDZTZvaHdlb0ZObkRtZ3pxQXcraGt6cDFzTmsr?=
 =?utf-8?B?aDZKVmFPOU5Xb0dtS2U1ci9jbG9nNG5qdkFkblRndk5LVFM0N1ZlWUIrSW5z?=
 =?utf-8?B?REY0dVU2QTBtckxXKzloakwwdm9FbjhreE9nOGI2cHBOQ2FSYnphNHAxd0dI?=
 =?utf-8?B?ekM0b25SU1RHRDVyQkRKV25jSkJWL045YkVKMnJqa3hBaWVETkNLVm1ZZkdw?=
 =?utf-8?B?KzdZY0NUYXBYSk5zaDUrblVtTFpHbjE1VFcra0ppY252L3poOEFoZXgwZndp?=
 =?utf-8?B?SkNUUFdnQTdzRDZoZFhyQ1pyb0d5WFY1SzVNd01HQnMvc0kwaUpxcDFZUjcz?=
 =?utf-8?B?blZoT2hETUwwVDJpUGZkcnkrTXZXMkFQeVFsWTNYVWRQRklnc2dKc3BubUVM?=
 =?utf-8?B?RXAzM2sxWkRLaFgwdzhrdVhNbGpWTnQxNmc4a0lLV0IvcHN1TDhRNXpOMk5o?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d93282-49b9-4682-0145-08dc084f21f4
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5950.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 09:18:34.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INEWO6Od2QDyvJNNqC55DAD889A24K0Bfra0idlQwRk61rekL9bTWixiMoDB4zwh/UjLnghc8cpVBsciPXw2oWUOrSx50y1QFRICSLULTII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5811

On 2023/12/28 23:28, Krzysztof Kozlowski wrote:
> On 28/12/2023 16:15, larry.lai wrote:
>> The UP Squared board <http://www.upboard.com> implements certain
>> features (pin control) through an on-board FPGA.

...

>> +MODULE_ALIAS("platform:upboard-pinctrl");
> 
> This is a friendly reminder during the review process.
> 
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.

add "platform:" for auto probe these two drivers when upboard-fpga
has probe and register these 2 drivers.

-- 
Best Regards,
Jack Chang


