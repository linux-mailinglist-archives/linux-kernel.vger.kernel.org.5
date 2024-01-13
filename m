Return-Path: <linux-kernel+bounces-25151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EFC82C899
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5498F1F212B5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8DC12E62;
	Sat, 13 Jan 2024 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FtK45PQz"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2038.outbound.protection.outlook.com [40.92.102.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143CC12B79;
	Sat, 13 Jan 2024 01:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bekqavMp9B7N1N3gNc7C/FJPdkocqvto8v758MnPk5Ci6QzpSCTZe2itJcjC7lKK4uwD9cPycxNmxVeIzh1cwNJDCgsChhqJ0c0zJRKA+JeM/+YT9dsfo4sg+1yaDW8e2MGkeSu9fvM1B+HfeEwC8GUDoKm1dlrBMzewhqJCDJiXVlx4iXgcuEcK0rlzIPgLr46TLDn7gQi7O7fP6tKovXA4qZhM4hLmXBhrruR3uHIi8hLovzNc2ZOmbBReH9nPqm3zlPIc/scYn4n6nd7Qq9+WE/GVkZ+2gJKS6aL7RyUSZhRwJo9fc/ex1S7mK2Q77z5GHNgqGFkRmGqBuDsWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=228Be95lbJRa1auM9J0dbPVjZ3Blb3lC8z/EsqcsUFE=;
 b=LSAs4Io0l2GWVyC+RWv74StbtmWTj0b9dEd1tSLW/WQcISSi3X+4ymmSuF1Q3ZyxcOSjLH/f1Rp13RG0u6inNwt+cqG7oRjG00iF0lyMKbg1jCzFEEz60DGuUACR3L15QZWKKB1L7T7jzaSFCHvfD36deiBqEEB5wIZf8h/lLFCIp5CeFuKII1Oj4GhVb37i+waypc/IrnLXBZymYW4oVXYZhaboMcJ9vjFUJ7pv68PsMxRatwDomgO4hAzrsIWRcSu8tSvsLHCU1vrnHBILLX3nqf4XzH4LhsABjiL6v4JOu5RLF3JYp0Sk+zQ/2MHN4GaInyHa0Ue5wZaUzXNh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=228Be95lbJRa1auM9J0dbPVjZ3Blb3lC8z/EsqcsUFE=;
 b=FtK45PQz8dm1oOjqD6UMiBxcRn68wI8Hl4hV/VMBitnQnAbjiXzoiLUPKa7nnaW1qgBBnaVU4Ziu4wh1n5+t3tPBDAoE/WeZtlQOYu3gP9IJpKSJ0AIj5gTTpDbu4Mn7tDEOvqX5zmYm+dAtpcZ83XcSHSvsy+cYbQ7W6lMMBLd2P5huZR9wuJEEsXwrnyU/GjiUfYeXI9rJlOSVJDDrNQDxbZHAAeqYa/JKgfAychSe2D/XBgNJ6woFXP6X1vmy/OmA6L32agNdxkK4sjAJm1Yz3fzneIm72dTJQsh5f/GeHN36NRUhLYNYyr4zYHPgjU56W2Zg5RcBMgPLWeKmPg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1180.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Sat, 13 Jan
 2024 01:15:47 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7181.022; Sat, 13 Jan 2024
 01:15:47 +0000
Message-ID:
 <MA0P287MB2822C9D8BEC1C2AEDF750382FE6E2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Sat, 13 Jan 2024 09:15:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] dt-bindings: clock: sophgo: support SG2042
To: Samuel Holland <samuel.holland@sifive.com>,
 Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com,
 krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com,
 robh+dt@kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com,
 xiaoguang.xing@sophgo.com, guoren@kernel.org, jszhang@kernel.org,
 inochiama@outlook.com, Conor Dooley <conor.dooley@microchip.com>
References: <cover.1704694903.git.unicorn_wang@outlook.com>
 <925d99d5b4ece01337cb3389aaea4b631894dd1d.1704694903.git.unicorn_wang@outlook.com>
 <f88b79c3-e44b-4136-ae56-10e1f2502e2d@linaro.org>
 <MA0P287MB2822C7A3C1DC7786708E860BFE692@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240110-untoasted-underfed-fe81479506f6@spud>
 <MA0P287MB282224A6097B4FCCF721C89AFE682@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240111-jolly-prize-930931cc648a@spud>
 <cd856233-06bb-4a5a-ba12-2996c89cb492@sifive.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cd856233-06bb-4a5a-ba12-2996c89cb492@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [RhGdYnw04k+M/bkviVPFovx8TvTIEksF]
X-ClientProxiedBy: SG2PR03CA0092.apcprd03.prod.outlook.com
 (2603:1096:4:7c::20) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <8364d287-3aa1-4c3e-ada5-2fc8d95fc2d1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1180:EE_
X-MS-Office365-Filtering-Correlation-Id: b226b22f-47dd-46c8-4fa5-08dc13d52afd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o6gvCE5gprqCmp+yg35b6ycd3hw+YsQtzGFMgeDuIPX0WVsEoZa3oj9J24dUX81yY3i6n5KHz6t6SsgZXOmHiIyx1VvDrzgXEcAtpDIia2lSNY65UA4dHDRZ1sGYpy+6L1AfnMWtAd4+udgRpa3eMvVylKz2Vxcj8bo75w1agdNRosw04fpv0py7DlWDbOI3VS1vFDl8i07uPGs5lOTCJhJJ9b1N1FbI0o6F+J2A3pRqynJj8AQnyyf4FWXk53za3kYJ/DoknpcAeTv4JOV/wvAz1S35avLsKi7lSe7H9jEJon5mwmaYJxp7Nbz/YZKyafn9WnJOpkkhjgJ3Jp7X2fw/YBn9w34izcuGUTOY2mlgUQpuEU3CEQxqzOPjYkzdnwLV/xi7VITUpMNrPWUCwxf49IQVi6c2ILdxhUAMa/avBFgqn9BfXmFXumOR+sWOVLAt3xbL6yNzuAcAxS7y6Wj1QxtvZ7wmlH7EUwS3FuQM4QoOmVh/VjwhuYi6vFYsXe2vda2dpvPAFEmsaQ4ycozyGy1+Ahv0l4Try48CIYEnKyIKkptTXy0u7FL3f754
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGNLUFE1Q0ZNYXd3clJ5ZGNpTkRodlIwOG5YU1NIV3V0SnBvVHNEUjBHQVZQ?=
 =?utf-8?B?bFU5NzJHZTJGdUZtREZwWTN3aDlVN0RLU0JqU0owSWhlM25DcTZrbm1lVHlp?=
 =?utf-8?B?TVV6UDZIM2lyRm1rbGVNbjFmeXJIQXNiYUtQU21qWVNUZkREQkJyRnJ3R0hw?=
 =?utf-8?B?MllVZmhJQlhMODJDbHNzZkhWZXgzY1czb1J3QmNlMEZDVDJmQytyUmZzUDJ5?=
 =?utf-8?B?eStTTU5jcVFpK2RJVE03SjMxVXlHNENIWFhXT29SSFdNUytFRFRPWHEzZ0RO?=
 =?utf-8?B?ZnNsajQrTEFOY3J5V1YrQnl6YnhPWGJxK1NqK1hZV2VZcWpNcnVCVHBzbXpp?=
 =?utf-8?B?aVN6UFFsREZFdzZXVW8vbXFiajNoVU5WKy9lYkxaZEM3ZXl5NGNvUXZVUTBJ?=
 =?utf-8?B?RHZRNVNOK0VUYjJYNUtFTmRJR0srd2lOc2VPWDI3cHJzZnhVWDVmVlRYZEZR?=
 =?utf-8?B?aHBTbDM2ODdSVnVJUk9WQTlhcmE4dWFjWnVTUmxacWh2L0JyY3o1MENUNWtG?=
 =?utf-8?B?UUtwdUVpSkNzUXI3N3MyQ0ZES0M5RGZHQWNiTC9LdEhlbEdra3BRNmxOUy9l?=
 =?utf-8?B?QjBWejUyUElqUm16U3pUcUZGcVR0KzREWnl4Z211ZkJYSWt1NVU0VHZxSkxa?=
 =?utf-8?B?c1VUOWRhK3h2VHhTSC9UdmRLczlEckFVVlhwS0pURW9oUzlrenpRdlFURHVz?=
 =?utf-8?B?eDV0UnphMm5lQVJRZ0QwT0VNTHEzUFh2cW5jdkpsMk4wUlArNmVKd29MTXM4?=
 =?utf-8?B?Q0Izb3VLaEJWNGllcmxqSjBIRytIVEFsUEpseStWa3pFTVpRQ0ZyNUZWdk42?=
 =?utf-8?B?L09iRm1NaVpxenF5ZU1jNVAvM0lZZ0JEcnV5UUF3ZmJxK242OVBpZ1RYSUd3?=
 =?utf-8?B?WFF2bjZqVEtWdk95RzBCYi81NWpvaGZUNEZDK2pNclNKblVjajFJZjJYTWhY?=
 =?utf-8?B?VUpia2tiR3hjUUMrNWtSdk5JOFdqNjJKY2sxWVV4UzBzckFEWUdvMmxRSEtD?=
 =?utf-8?B?SGRFVGlmU256YVVPQy8yVCtIeDM2akRzN2hEaG84eUdpY2RDT1h3d1lTVkx2?=
 =?utf-8?B?a3NxMDVTcmk5TDhvemNvY1dsM0Q2eWJDWWNLTlN4bzBFRlhyc3hZMDdkM2Jw?=
 =?utf-8?B?VnpYUnNuWDB3ZGxLSmI0bFlIRXVVTFlWVytma0NxVzBrU0hJSGQrU0hKLzdq?=
 =?utf-8?B?M0wyWVY4Z002ZFBxeGFUSmdCS0RqdlhleHkvOThNSUZ3bmg0Vi9GSVFtQjh1?=
 =?utf-8?B?amxWbkQxKy9hUUozL09iMjBvaFhuZmkxUlBYWUpldEV0ak9kSVZUUHFQYm9s?=
 =?utf-8?B?MmRRZHlnYWNaYXFseVJZaE1aZDZMYzlDcmhucnJqT2o0dWllbHVjNHlBRkx3?=
 =?utf-8?B?aUM4MVBabUo1ZjBkUmxXMVlDbVFlNmR1MG9ZWlRTY3lDVVF6WnNYUDF6S002?=
 =?utf-8?B?YXZmMThwUnFWZTJvV201Ky9UNER0QWVyLzkwclpwQ1kwVVd6V0Q1OHZYa3U2?=
 =?utf-8?B?Nmh6RnMxOVBTS09JQ0JEVHBEMCtQcE1ybzBJT21OZ20rWkRvajlqMSsraW43?=
 =?utf-8?B?d3BTaC8wSjljbTdzQXdLNWM1WTZKWE13dUU5eUhnOFphOE8wUjdjUFZXSUY1?=
 =?utf-8?Q?iFvKZtrHuaphVfvLxBARGjHVRts2722JrEd4yQeZ7+/Q=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b226b22f-47dd-46c8-4fa5-08dc13d52afd
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2024 01:15:46.9782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1180


On 2024/1/13 3:35, Samuel Holland wrote:
> Hi Conor, Chen,
>
> On 2024-01-11 10:58 AM, Conor Dooley wrote:
>> On Thu, Jan 11, 2024 at 04:00:04PM +0800, Chen Wang wrote:
>>> With this change, we describe the plls defined in system control as pllclk,
>>> as a child node of system controller. clkgen will use pllclk as "input"
>>> because pll clocks are parent of div clocks .
>>>
>>> But there is another remaining question about the gate clock. For those gate
>>> clocks controlled by CLOCK, no problem we will provide then in clkgen, but
>>> for those gate clocks controlled by registers in SYS_CTRL, they are child
>>> gate of the "clk_gate_rp_cpu_normal", which is a gate clock provided by
>>> clkgen. If I extracted those SYS_CTRL gate clocks and define them in system
>>> controller dts node, I may have to use "clk_gate_rp_cpu_normal" as their
>>> input, it looks a bit wierd becasue there are cases where each other serves
>>> as input. I try to draft below DTS to explan what I meant. I'm not sure if
>>> it can work and I'd love to hear your guidance.
>> I'm not sure how this sort of circular relationship works for probing
>> works either. Stephen etc would know more than me here.
> It generally works fine. The common clock framework can handle the child clock
> being registered before its parent, even when using a DT (fw_name) reference.
> See for example clk_core_fill_parent_index() and
> clk_core_reparent_orphans_nolock() in drivers/clk/clk.c
Learned and thank you.
>
> Regards,
> Samuel
>

