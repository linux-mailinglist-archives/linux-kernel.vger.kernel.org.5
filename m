Return-Path: <linux-kernel+bounces-27326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68CB82EDD3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7C3282D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAE71B940;
	Tue, 16 Jan 2024 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="U/ce1Mgk"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2127.outbound.protection.outlook.com [40.107.6.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ACE1B800;
	Tue, 16 Jan 2024 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvIe/3Mcwv/BRQfnAS07zi7moT/OssZ3QtpE13OtlGpkefHbyz6uLOG4IviT4QFF9O//oO6XEE+yHxUSJ8IxUTI0J1CysXW6sPmGgbwCsVKweiSkEFe/cnM17BNhCnsYFph6psgjx62vlfpP5B0VZBhkGos6nuOuNbyxov9jMLwT7Sf3w5FMI1rvIlm0dnbXXQbFN/A4Rv7ce2IQfZV0CWGtNuHvExD4b8W5/TOkO0X3RHFFnIGgOv9XmD3psG23vd/+OQUes6ODUGWu8HWf2zbtNG3Qi8Izin+vxuBIT/XI1eVq8StPUYSvMOvgUxmoItexY+tfxDqdYsNaAhKqUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QtwA8IOOQZGoAbs29LfzS6BSh2yfFZ2wWkMHJm+9+8=;
 b=MQNTFLlTrvG3aXp75/LNKeUu4II412gQDUrooW7Cypa2EYWQa0pcURH6rQ9VbF3ENogDFGmyRHXwHLbin/O6dx3Q0S5Hn76Uhl+bhgR5PJ8CZusKrVQNxudhL5ExoeGdo0qRm5I1C0e3YQyCDpsvkA3pUqaAbLtS7ZSDW68MPg14vSSFhDc9Gd+d8PxIbfRi1XjfNDtC3MHPhL5j4zvSzqTFb7Jn/sqpscYdlJNPrJ20AKAX/TDjdVrZbw5txe7rHujEaa1mbufDSzM48G3OTpFSulvgxzISK9QjDTLSI421v3P6tQuejuA0PqWsqyQn1u/8pr+SA6sv5jyrkYDPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QtwA8IOOQZGoAbs29LfzS6BSh2yfFZ2wWkMHJm+9+8=;
 b=U/ce1Mgk+Gd2CI7wyozU5EGhIKpxPRQ/FulMTCBsmhxwyLgEwq2SGi9p30C6JP/aAXuOYSPhRM8WdlGqzSkV0uRjTPFO72OoT9P9ShB3eacGeKw8q10saF76u3xScVojyEb5LuXbzyGeqCL8yWZCT8zkbZ0x//HhjCV2xW4SFkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS8PR10MB6150.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:548::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 11:36:50 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9ecf:9946:bc16:21e6]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9ecf:9946:bc16:21e6%6]) with mapi id 15.20.7181.020; Tue, 16 Jan 2024
 11:36:50 +0000
Message-ID: <6ca830f6-09cd-433a-ae85-d8f4038dad90@kontron.de>
Date: Tue, 16 Jan 2024 12:36:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: imx6dl: Add support for Sielaff i.MX6 Solo
 board
Content-Language: en-US, de-DE
To: Fabio Estevam <festevam@gmail.com>, Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>
References: <20240116105317.267525-1-frieder@fris.de>
 <20240116105317.267525-4-frieder@fris.de>
 <CAOMZO5DONvb8GpH0PrBaa_EW+br6jWeMC=Jx_y_Etz1EUg11mw@mail.gmail.com>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAOMZO5DONvb8GpH0PrBaa_EW+br6jWeMC=Jx_y_Etz1EUg11mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::12) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS8PR10MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: daf5d03d-b876-4d38-bce7-08dc16876dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JtoQg3Gb1ugJ+M9j2U0MlfYLX3uc+n7gzmMXW5bzPpRXmSzIEkNH3j/iNFHMRu1wSYN19Vy6ITcgZSMZQdo2j7vT9Y6/ZKuY1tzHagXU4z9/SdQYM6gQtKMyCQUVEe1ELGPqen8o0cxi6+Rrz0JzxZl0259eeV2RV/mg8hlmOhfTRSduR+u6hMiDNGzXhZz4aMVGEOq7ICk3giQQdsIjGODxckmq1EEgQ2ffeLM2/jwUcg49O90+G/7SUnCvEsg7jk/MdGv56EZGNUvEwBnKwXRXj+GgrA1/hKf3ZUI+OPrsQ+j3KQ+7hMlTwxq0vO9Ap5JX0lR+19vbqaS7HBakM80dOpe39uWqUfK7wnURoCthWJrzgKO0xBjcOVkO4fyA3E8rFiMMaUaTrOhUTGK8aCNyQkHN7WQ7ZQ+ql1tc4AL7DBr6mC7Xsy/0YntepXoU/sckn3+d09U83F5dll0ptuAMc6PV+bBnQptzBzhGMMn75B96A0uWZegyG/BtsgzrKh/w2ZEDmLlhY4ob5axVefo05pe2MPd88Bh9/qZtX1sxjwy+12OWpxRGFjWXkMd4FEyhU8gW76PJXF15Llf3RpBv/YYdvpMGb9w4AC7hIgT3J4HJfF3rmho+yQD9/L2Nec10n4PMsBipbIRgaE63wVmFV/qzANAxssVGNuLN1pw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(41300700001)(6512007)(31686004)(36756003)(7416002)(2906002)(5660300002)(4744005)(83380400001)(26005)(2616005)(53546011)(6506007)(44832011)(478600001)(6486002)(6666004)(66946007)(66556008)(66476007)(54906003)(31696002)(316002)(4326008)(86362001)(110136005)(8936002)(8676002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm02WFNYazZKZ0QyUjNESnNNZXN2WTBsRjFSWktyNlFuendoWlZMdzJvRHcw?=
 =?utf-8?B?YUxVSjBybVpCcHB4ZHBFczZZR055c09FNUF2ZnRXdWFsR2U3ampCR3Z3VHg5?=
 =?utf-8?B?QnRYQy9hUzhleUVwZ0R2VjkvZUdnKzIzUnVzYlJPQnNpaHhpVkRkcTEvMVlD?=
 =?utf-8?B?TnhjRDY0WDVyT2UrS210M1lLeHBVTk5GQnJmS1lLM2ZMMHl0RUlPc3ZiWkdF?=
 =?utf-8?B?ZHZheS9rYkk1a2hyUVhXenJnVlBnRm5oNDNJU2hubjd5MExwYUxJUjJXRXQy?=
 =?utf-8?B?b3dXdmQ0ektyR05iYkM1VnovcTZKbW1zbUQ3VWRtdExUcWZUZ1JYa0tXVmhH?=
 =?utf-8?B?TEVkcWFsMnZXaTNxL1phQ1NiZjExUWlZRXBncllJZ0F6UEdyT1Y1bldTbXB4?=
 =?utf-8?B?SnJ6MVJHWVB4NjhhN0UyeWJ4NGpoQlZnUE00dDF4YkhIUko5QnprN2t2NFZH?=
 =?utf-8?B?T1Y3eDdoMS9zV2QyOEhJTS8rRjhnYllUUjZlbmtGQ3didnpwMG9DYllLeUF1?=
 =?utf-8?B?VVBqYmF6OEY4ZHRjTkZjcW5GenN5alF4T0pNeVQveG9ZZ1ZjVm5XeDBWSWFM?=
 =?utf-8?B?MUFKdXNHVWxXRVhNVEErVHAwQ2lCcklVQmtNei9jaytFMDlnemtnalh5T2Vl?=
 =?utf-8?B?dURnRU5FdDFvTkhkdFBrb1lWcEkvSUJGbDFIODJkRGo4WitIdkUrdzF4VTFQ?=
 =?utf-8?B?VE5WK0QxNm5rWmwzRG4xaGFRK2IxM1dGeVV1b0R0SFNjNWgvK1M0Zmg5YW9v?=
 =?utf-8?B?dmJxcXVBWmZ0R2tSQnpDbmlUbGdxRU9FUG03SmZ0bzMrMEIvWXNRUGUrdEZV?=
 =?utf-8?B?SHMxdXZvV3c3Z2JFQ1V6MnhBT0JHS0RCQVlNQ2NzaVdJbW44VUR2SFE1amNt?=
 =?utf-8?B?Z1ZnNkN6enJZTXlNY0hSbERIUXgvd1dnK25vZGZCbkxnb3dWeGNoUDU2WlhP?=
 =?utf-8?B?STB4MXIzWnRjRkZNZVRyYmhmcHBVV29Va2krem9FVnM5bXdTSGJOOEQ5NGVK?=
 =?utf-8?B?eWdTOWJZZ0NKbWJlQmlWVGxiWE5YK0NSMnJGdFdHZ2h6WVBqWkFZYzI1VkZT?=
 =?utf-8?B?NUszOUEza2JLSWVzZE55Z2hRZmNVRXNlSWkrcUI2MGZMNFFaclo0M2h3bWZC?=
 =?utf-8?B?Mlp4aTdOZnlqZmVVbUpMOGpHY0F5Mlh6VVhuaDd2ZjVucnFtVFE2UXFQOWRs?=
 =?utf-8?B?MExOb1dOb0lQTTdDT3J3cFlBVm4rb2hDQ0VtN3RXTVRGWlArYzg4NGVqb3dq?=
 =?utf-8?B?a1l3VDhMSGdiSUdDbTRFdCt0RHhTb1FaRnNWajVDQjNZREtPaWI0N3FNYVpq?=
 =?utf-8?B?aEYva1ptRGJWR3RHMmJRU3ZySDYwOVRkQkNJVnZhMjFRU0lKdHJKL2tEdktm?=
 =?utf-8?B?NDRWRFpza3R1YXpmNVI5TVN2Z0FRaTVxTXlCQ1pma3QvUFltNGd2bFFpYkhi?=
 =?utf-8?B?ZlcvaVllTW1XSVgyRzVDSFpSdXBSQTM3akkyeDIvTnFUUGoyZEVvVlFlRUFi?=
 =?utf-8?B?czl1QzZXaElSWlJERFhIamNqMGl1VitJK0RxWTJUVVUzOE8yVjVMc1B1ZmNq?=
 =?utf-8?B?TkRDMkVyNTg5T2hQWXI4dUZObWRVMXA1RmxiSlBVOFprazBJeDVoTmt3bEVx?=
 =?utf-8?B?dXRRWjZrYXVlUzhzSUdFeE9pUWVTSWVnVlI4SjQweVlxN1IvMzlnUmNQMXRX?=
 =?utf-8?B?TlhJbFNlMzlPWElrWVQwMDA3SCtVaHNJcC9adnNydCtOZ0pzNHVVTVJ2ZjE5?=
 =?utf-8?B?NnkwbHVhOGNuQ2dPQ3dKallqT3J0cjA4SGgwenU4aUJiZ0tuNlNWVmJNMWxo?=
 =?utf-8?B?VmFDRHFDWHBJa2NSMXlQU0JRQmIxRmRYQzZCMEFZS3JqaHduK3gxRDNpTnRS?=
 =?utf-8?B?TFpZdjBKM3h2UnZWaHFrcExnVG9HNjNBa2FZV1V1d3BObzRzai81VS8rZE1y?=
 =?utf-8?B?U1FDOEVYVXNwclgvWS9jcHlFejZBNWVZd2xEbzJSUE9tUmFKd1h5V2l2OXBH?=
 =?utf-8?B?a3BleWZMNXM3Y1Zhd2R0dmhkbEVpZVJpS05tb3BkWVhnaW1Rb1BJSUFraUQ1?=
 =?utf-8?B?L1dWMDUzanhHbkdQcHFMUHhwWnlLcUtRZW9wM1JndldVa21STEQ1cTlNU2wy?=
 =?utf-8?B?WWJmSDhTR1FPM1dPQ1I5OXdhNVpsQXkrVnUzUE01V1JFZCt1NlJVMS9yWTIx?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: daf5d03d-b876-4d38-bce7-08dc16876dd1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 11:36:49.9965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OH8w0irsuCn1wMj5KtQ4rXKX6kLe0XZpGeQJEkKj6Qb2h5MKuKaOtHFvbUWl96YNg3Wgvqq45/5cQpED1iJHdKyQ77IzWPfa20oA6tPp3c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6150

Hi Fabio,

On 16.01.24 12:21, Fabio Estevam wrote:
> On Tue, Jan 16, 2024 at 7:54 AM Frieder Schrempf <frieder@fris.de> wrote:
> 
>> +&i2c3 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_i2c3>;
>> +       clock-frequency = <100000>;
>> +       status = "okay";
>> +
>> +       st1633@55 {
> 
> Please use a generic node name.
> 
>> +       gt911@5d {
> 
> Ditto.

Ok, I'll change the node names to touchscreen@55 and touchscreen@5d.

Thanks
Frieder

