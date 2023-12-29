Return-Path: <linux-kernel+bounces-13021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2866881FE8A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4953284A58
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7653010A1B;
	Fri, 29 Dec 2023 09:18:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2098.outbound.protection.outlook.com [40.107.117.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE610A01;
	Fri, 29 Dec 2023 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yunjingtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunjingtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6065q4u/00Y8iWEj/HhCDqQgtoicYak5M57ImXTFzLL27iu0vHK8rGAS0OUbqP/No/ISF7CaYx4YqacclYIQ390uH5wMEU48au+HyrupAxva2rokpC2st/NmzxO8GsxZwyU7rzl9lRyR/A+El0XrXoOPKgqpNHre28UZAk15Q249xYwGBlfg0EW0YdYrU7Or73WQ397bukeRgNMzwErWkNaPXyCF3wTwQZ4a/PViROn3IM34+ox44O9wvvmxdtXiJMi4CYpnHjAONedbMxzYOSAkUkC4FZf85cRzPHJfBeYLzLdJumOgKNyWDCdWyzlFRFEiBtDfb7K8QjXoC6FNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqXUZonMt0FQ/okir3HQ3KaPHZQS5fIT6MadhiAV3Nk=;
 b=HYN8U1hw3XmgTJ5c78WyxNED46UqYuC+/jlEcGNj8vtT4Rm9xfL8CqoC/OPqRsNVmXe5s65QTqAnSQOjsfAiaCG+CLICoItW/coxa0YFbET9NmgcOJrK4Ah8jJ7NFcp2jqrzUH5439wlkPCkcX9KnKNXZzVHDD7aRGDt7Iiu3+jDcB5acHysUfBHN5D9g3oSJS4yKWRIObrpxQ6VVhOZdsDopKSNUHodACXra6brJjCCDEF1zT5j+ZatX07RzlO6v2Yjomp8gH0AxAxTBk1xsi1zUfyNlSnr+Zv7NEDjF/LgJWn6VXytb7E9C7aAEizdC4K5EGuDI/Izkh+3f5lWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from TYZPR06MB5950.apcprd06.prod.outlook.com (2603:1096:400:333::12)
 by KL1PR06MB6394.apcprd06.prod.outlook.com (2603:1096:820:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.28; Fri, 29 Dec
 2023 09:18:28 +0000
Received: from TYZPR06MB5950.apcprd06.prod.outlook.com
 ([fe80::58e4:af9c:1ac0:cd72]) by TYZPR06MB5950.apcprd06.prod.outlook.com
 ([fe80::58e4:af9c:1ac0:cd72%6]) with mapi id 15.20.7135.017; Fri, 29 Dec 2023
 09:18:27 +0000
Message-ID: <635956ac-67e2-5b7c-82cc-6331b9555a7d@yunjingtech.com>
Date: Fri, 29 Dec 2023 17:18:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V8 1/3] mfd: Add support for UP board CPLD/FPGA
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 "larry.lai" <larry.lai@yunjingtech.com>, lee@kernel.org,
 andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org, pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
 noah.hung@yunjingtech.com
References: <20231228151544.14408-1-larry.lai@yunjingtech.com>
 <20231228151544.14408-2-larry.lai@yunjingtech.com>
 <c684f26c-029f-4264-9cd8-d3a2bb330ad2@kernel.org>
From: Jack Chang <jack.chang@yunjingtech.com>
In-Reply-To: <c684f26c-029f-4264-9cd8-d3a2bb330ad2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0013.jpnprd01.prod.outlook.com (2603:1096:405::25)
 To TYZPR06MB5950.apcprd06.prod.outlook.com (2603:1096:400:333::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5950:EE_|KL1PR06MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a31856d-4ea0-4154-97c3-08dc084f1deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b01Jemfv0fRTzKZ2saYMi+lblEaZyxj3suFmy4ETO/n6NdVkrAcuo1EXEXxn/iWZo1r650hsRcze3Fwqm6oCKD7xtrVzTEQ9OphTAtd1JQhcHKrOxPKS0YlC01Py6DJUiamJsgadra18lIOPIi4fA220eLo6+D+Q76dnl3ipKi8Na6swiRPLyMUxo/ci2G278cp9x6WyvMdsqdYHA7+EFtd13P02/n4d58V/cu2jxYhraKga3N8T8etMZm1uwyIBszxkHOKCzjaFkLk4UYorxqGnZzeqCjppom6MFBuVVIVp6skq9/tcGWWKfkjHSPw2+D8SImH8WmTlYI4IIkPaUxAtDjnXYfpoQRQPA1qGZRcJZYa/0mq+OiVUQuJnM9c3u24GPcY/zCS82QGwRZRlHlLQ31Neatz6ITVrYq/wK1L2u+rLq7IGEU44Mta9gDqEcpo2Gz0O18SiBObLSoa/ZUgXcEaQxYrodE76bYj5fnNk1TT+9uKfSimASZ0gMI1neCDL8bSIkWL9U3Xd0e+gsmM1hj+pabcuGSRvOO+aK3cjIGtNA7zkpZVWYMhbd1UsqWcl0kk3juxkIJh1wqLG85qc6zeVnEJWYLVsPYkapdwSGSIgw7DdhCaQs3NIE/fr/uh8xsbJU9x4wHUOt2+PDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5950.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39830400003)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6666004)(2616005)(478600001)(110136005)(6506007)(66476007)(53546011)(6512007)(31696002)(41300700001)(36756003)(86362001)(66946007)(66556008)(316002)(6486002)(31686004)(8676002)(8936002)(38100700002)(2906002)(4326008)(107886003)(44832011)(4744005)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTVyQUQ3SHVwbHJva1YwMzBPSStZRnp6SHBpNThaMEtXVmI3eHVWR0tCWTc3?=
 =?utf-8?B?S3poRDdudFFkVnl6WWE4Mnd6am9sbEo1NE8zQ2MrT1Z6WGE4WUhtaitkN1F5?=
 =?utf-8?B?NTNSRE1OYnpjcGtxMXJmV0Q0TDh5M0lBam1QeUZuSERGNmRaK3ltSjdzdGZT?=
 =?utf-8?B?aHQ3K05iS1BoQ2g2YzROVXNmckQ5MThNRUdRYWRlSWIrYmNPblQ5WWlNeHA0?=
 =?utf-8?B?T3lsVVo3bDU5aDZ6MTYzeUxTdUw3TmJ0VUkvMjZvUS9lak9iNys2blFncVUv?=
 =?utf-8?B?NklHdGNHVy9yM0Q2MGt1NEFyVzFOZHRjdk1Fd21SY1c3cXh3ZnZSMHJ5RmZG?=
 =?utf-8?B?SE1wT2F3VVMxQWFQWVJiSUN6ODZqdzY3bG9qRDB0UHdNOHh5UmtKN2NtSmJC?=
 =?utf-8?B?OGNLcDAybHRRRktKUTdNU1BENTNHcEJ5MElXRWJabzFJZXh5TWFScysydEtV?=
 =?utf-8?B?YlpDUGFLSk04M2c2YXVGVDFZeFBLWitiUGlsZ1JBcmpwZXk5NVl1cUNrK0tX?=
 =?utf-8?B?cG9mbHFzZTE4cCtMU2x0aGozY1VtUzZtNFk5ajE3cDJGR1c5djd1SXNxenVB?=
 =?utf-8?B?dzFaUCszcUxpY1h3ZmFJd1hxVTJwQ0c1djJZT2NsYlZEK2ZCM0oxQ2FIT3FP?=
 =?utf-8?B?TXpzQzdhM1d4TjA4K0VJSXFkc3BSczlHTTRqZHB5U3RFeXgyTFNKazNpL05R?=
 =?utf-8?B?UTVUTkIwdnhjMjlYbkV3RGRkS3Z2b2wwZnBBWXpiWTJTL3RLQ2lETVFvTzdn?=
 =?utf-8?B?VjBnZVZMS2pxWjdHaFFMWVkzSU5ia2c4SDA4bmtGVFZNMjBlTDFteFpHRmhM?=
 =?utf-8?B?Zk82T1c2emlNTU5RSzByYzM2U1lBRDZLdnhFYzdVNVRJZ0ZqSzlYTXNLV012?=
 =?utf-8?B?aFN2MXNrZ0Nxd1dmUTRpN3orYTNzRHZ4c05hUURkQ0RKaDlBME1jZ3gyaFFK?=
 =?utf-8?B?Um12WGZjT1J6c2xlenI5TmpyTUs2dldiQW44OFgxN2lqT0RGRU53S3dHSDdD?=
 =?utf-8?B?YmN3UnRsR1hmaTA3bFJxc0F0czcxbjhvRVZsTk5HVm5hY05WWlo2ZktUWm95?=
 =?utf-8?B?VXFqdktObDVLeEp5N25XWk9KdEZzVGU5U1BiS2lqWVM0WmNPdUJlelBxRURr?=
 =?utf-8?B?TTRKTjNZTnh2ajJaSFZscVRDQTJIdUtNVXRuRVR4a3Z6Umg5bi9OVW5VdmJZ?=
 =?utf-8?B?U2l3dEtNS29ncnJQeUlPWkxYMDZOQ3p0TzFGYS9HL0N6YWhKbVpVNXFXYzkv?=
 =?utf-8?B?N3RRcHVtN1h5K3ptczZ3bElaMHhoaG8wUHNVeHE5S1dic1p5OUxFTmlNT3c2?=
 =?utf-8?B?aUQ5ZHBOaFBLU0xwbUhsY1d5eDN4c1p5OHpRK1J5elltTkw2MG1haDFVMVJT?=
 =?utf-8?B?T1I1WFc4aXpuaGJXOS9MNDJSVVdLWE9nMXVydjlObUE2Nk1FakozQkxURnJ4?=
 =?utf-8?B?YnowZ1h1NS9yRWJtRmNqb091TjNFRTJZWWgyMkpLL20wV2pvdUF2MW83MkNQ?=
 =?utf-8?B?aThKQmtUTnZGM1lkZTNTbDJiMWZJcDNFdWE2THZEYThyakVVeExGVzlIMjYv?=
 =?utf-8?B?cUl2UWVtVjNwaW4rRVQ0QTZlQnVMb2dYWmk5K0YzeHZadXBrY0FtLzVYY0xj?=
 =?utf-8?B?L0QyTG05ZUd2dU4rT0dPS3ZtS09LelZFQUVpYTljNEloVHBmYmFkeGZqTnY5?=
 =?utf-8?B?bCtjVWdiQ1BPbmJQRUJmOElqMmJhK0UwdFEzQ250ZmNnVGpQVmRNSXlzQkRK?=
 =?utf-8?B?WEE4UWY3WFVGQzhDa0NTVFVnRHc1am5Idk5MY0dOcnRuTEtMTy9GRVJFQ29Q?=
 =?utf-8?B?NDNLZ0Y2VmRnalFkUGYyWjUvVCtvT0pLWHdQbGZESUVWZVdJNWdER0NnOFd5?=
 =?utf-8?B?bWVTb0QwZUZsNHpZWm9acEdOV1p0a2xkR1ROdVdCY1cxdGlYT0k0QUdrcFBt?=
 =?utf-8?B?NmNGNWtLK3ZWWDloNTFBOGpHQVFjSDJaU04xNUtaOTlxZ0dNSG9maUpZT1Ja?=
 =?utf-8?B?WTBPN2xMaUo5TWRDUHRKc1BaWGRYanZpd2VlL2QrU01iSWxsckJJMHdpK3FJ?=
 =?utf-8?B?Ukk5dlBqclNkd0cvVXVHK3BtWWFMMkhUSmp3bVJ1YUw4V1JYajhoS3hRaFBm?=
 =?utf-8?B?emEzdjkxOTFJb3pJYWh3V2lYaCt1MlhxN01CU285OXVYQzZZaDh4MGR0ZmdR?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a31856d-4ea0-4154-97c3-08dc084f1deb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5950.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 09:18:27.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1y0xSRvkFN0q1/oulvzVcoYkvJJIz9rkgu4FhBWggXD/k6Ohbd6YRgoqVC6M88i6COf4lBnKybXHctJC8tSTLGyjP007QXARPycmylwd5Rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6394

On 2023/12/28 23:31, Krzysztof Kozlowski wrote:
> On 28/12/2023 16:15, larry.lai wrote:
>> The UP Squared board <http://www.upboard.com> implements certain
>> features (pin control, onboard LEDs or CEC) through an on-board CPLD/FPGA.

...

>> +static int upboard_cpld_read(void *context, unsigned int reg, unsigned int *val)
>> +{
>> +	struct upboard_fpga * const fpga = context;
> 
> This const does not make sense. Drop it. Unless you wanted to say
> something else, like struct is not modified, but then please read C
> tutorials. This applies to all your three patches.

will do

-- 
Best Regards,
Jack Chang


