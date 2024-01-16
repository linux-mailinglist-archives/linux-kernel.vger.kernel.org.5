Return-Path: <linux-kernel+bounces-26805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F27382E65F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555E528478D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7F364CFA;
	Tue, 16 Jan 2024 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="m4e6wKiX"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2043.outbound.protection.outlook.com [40.92.23.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD8A64CF7;
	Tue, 16 Jan 2024 00:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1uUlmIEjQdi/asXP767RRldD3GFiOakDuuws1Uc/BILi4SBUQ4wLr/KSSTWzKq8zN2BDb4g8rKNHCqKVL0UiqqBdVogP5Y0Y3R94i/Eb9Hb0709JMeQklTvhBhT/1YNu6X5xXyXjYdb6ICRO5wcpFe/NLuv1UAQX7ktvXiOe1Wdijvd5Mv412F60qlQfnntioTPYnVRoFZpjqNT/R1Eczrk6Pb1QqAhQbMTeA6y4Z8yUyx/2t0NpONTLomyPVKhKpdS5u/PVIeUHf1K36gSjc01xU9G0Vvi7L8xE57V7BH0/8W/QpCi2wpwot2Hp+KBrvIAuNC0z26li/l8JcoZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONfRYbDARKTQP2V6d/ooSYmjl3yohg4lhwiIf9csgJQ=;
 b=L9StBhNIEvSkIGrZcIOpl3mAHziuWIwwq+M9Oz5uJ1USbiIvGRYVWfgyxvXiLURHr536RH9LpTertixxk65GShlCbvf/AF59roDjCwODP+AhWhz1+HoKje9udzGmtANqV2DS6o06eDQZMPaSKvVIj5zs+qeeMHRim9CITdvPlYqKtCkNPAoQhs2eEwy0fv8NRaitYy/IdC25M62dyF6W5MCyOu6GaZCwRCMSWOt8nTrXxZsmTcrtpkv8DthnBkNKjPK/mlOExr5JItJal3eIGh/vV2GQI/P+3d6hYi5SL7ksuyCKnhe/PPyB8O/VxJJU5Kc7YaIOd701M5s/U2z2Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONfRYbDARKTQP2V6d/ooSYmjl3yohg4lhwiIf9csgJQ=;
 b=m4e6wKiXK06Xl5R+3hZuNkLxsInvJBrM5YxE0xHyaZ8O4aUN6FQAPmjiDPgBioZArcQhmAGaS4xlsRV3FQMnXmR8MfU9CsCKVEeZWiOZIjYm2OpOsAzMJ9WSxzjnRdishWti/i2EfvERcjc/gu6KEPpvGySb6bVKaTWRi+/n/Vs93SiSpswqswOFpZgSuGWxCiphHcwHczqTgkmzJXqWubmzx8CNgAdzKkxVtuM4D+J2tmCE7Ebr8J5tPbvIuQF5yU3hLDg5e7B+yf3bBEZGJ84BSdEq8RLpGDTxNKAlBSYvVmJgtJjL/8zZ/L/OViK7eQs2aV+UsY3t78/p1dfvOQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB6502.namprd20.prod.outlook.com (2603:10b6:208:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Tue, 16 Jan
 2024 00:28:47 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7181.020; Tue, 16 Jan 2024
 00:28:47 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Conor Dooley <conor@kernel.org>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 1/4] dt-bindings: clock: sophgo: Add clock controller of SG2000 series SoC
Date: Tue, 16 Jan 2024 08:27:59 +0800
Message-ID:
 <IA1PR20MB4953C0E6DCC3C4CC0A398529BB732@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115-spendable-achiness-cff7918fe810@spud>
References: <20240115-spendable-achiness-cff7918fe810@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [BedqMMboeOzTtmBgOg/K8bmboI6MGw4OLMBegRqieqzAkczIoZoogGBn//8kDIt8]
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240116002800.190847-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab3a8da-5afc-4801-d46c-08dc162a1a86
X-MS-Exchange-SLBlob-MailProps:
	cn60g5V53KPB7lvfker9BJFmDCjmgus+fVRuVNJmHyrFt7HSnXiUFArAdhxCnH+QDUCXPRqnLZc4nxrJPDcwbiwSzS392zhXptxEvjeUom1K75ap+ZLBhsYwdCib7DR6VGD33KXaSlv1vaTE5v5HJ1bGnoPWLAqCD2aTWLWNHiwOsETHz8mVlxVDX9bHDzoSdNbIqPcswEjMb/vdb5c24Hx1bdnsJHJSFQkglFiRDwuUuhSMbcwoi9b1CWqTgvC416EQ8ndqOwGRsM1a7H8RfmMLed0a18t6wnRRi3ZLVKS79aki+tAES/aqae0yaXDMdKe4I2y63Uw0mEibuRR1R46v5CtYqVcwui/E98mr8WvXjMxQwvBgwNK5AyASSQfKAVucWel9L7MD4++IvXeWEwg4AgxDCdy4gHOU6py7u5KB1u39dtwTN7K7etalDbzRbYWpNP6Ja8+P47EguRwXJKAPilT8ctbRc47giLVQuiZAWeH7zZREXZN2UENb7DWGQdLlbjkBCHJ4W3dV8LuwMQbVTTmefMHhicBQd3yZfF8IiMEn1WrF6lCs9b4u2RBChDeRJB6E0puo82KxWLaSY7hA+uW3z6hpaCnpd60w/XQX/TS2ZI8zGhPabEBkh9QYLsphTaGXyOjRxhxRCYS9fjIRzj4Dhp0PPazKHyqKnODvJ80/+FSm6GXbfsG5TkPAbm0QzJnOZ20jVMKFCxd5aaGNQdwnQnT8C26Hv1tXJ2vDj47r0g/bw+E4Yj+bchBiftktsGAkgw+AGHAnQho7ju/zjlWJ0XVzpkETJPkOVumvuiWto50bGbzLKyUOSXPxtb8vulC1BtWYgitEtFuPaepqvFJntXarOnXnFpHevaxRqkK3BcGl0w==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xXexdaK48cvvMkdreUMvT762uVgOXBiwLgZEm16uzClB7VKUQ9LG7SlmFyCBETwGeMagD0K5dcVdvanWRLCWpDqDe6RCFsV3Lr8KjG+58PB7b7qVUw3ZPcwloCsRIZWNtDVGKauu/wo8pssuO5U5byj8HTAfO2lbbVcGBZFi8fewNurtiZK+uDj9/YOtzSEkCNEk/D5QVjib32aalp+FpY5gK80f8IxhmwBnEVuK1xrY75gwi1rAmfyFPenin2VwWKgqDKIudI8/1uDt6efJL/HfuPmUjPJ+fSEIa++ejYmx8ULcmkCdqkavmf+JLbJS+BI4RuLKr1PwSSAslY44smzIk1OMOooBSDOEFJI+NiscZzaWEtZR14ZvXi+p0gSbGtPZ9pTe2Tu09QfNLlJMZsvtnIQ0S/ol+ZXva5pNo2Bsj/CdJidxB6HnTpTnn1MCHPrD+H2Xl8Y7e8XepX9YpQUqZwkHM8d9EIJwSniInBxI2LXsx6tb0k5UUjyEFMEW9+JxZi+Jc97u07D6Wirc0dSGY96DogfR9i0BgO4NnsW7SCC9jlE1VXJDhcg7dKg85ukITtDGuO2wkUZVo6zfkUCoQ81T4/q7yKQyZ0J51R+JNIoboF4p0q8IaExHl5N8VTJmc7u85Jyqk0rvFxxq7yAyb63ai3cXkA4ySDXVmkg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+95F0tmVYM6RyLCE1t21/k/dhq/sRGKVVG3LoM7g5B4+QvNQPGXCUoivu2Yq?=
 =?us-ascii?Q?ZMP2ywdEIDEpC/S0yFAcXidI+LTLilyKswBGSaSGiXvK9uS5YyWpX36VyGxR?=
 =?us-ascii?Q?6S/n3HNy6EobkOvWVnHZhVVJLT3jsKO/+NXWrcRFTHule+P97V2FDk5QLc3y?=
 =?us-ascii?Q?3bWEY4Et7yG8KQ1TyBfF428emwq1dQUk7wpUnqStgBkd09Tby+GmDe7gUEJQ?=
 =?us-ascii?Q?7O1NK5/qBhVoM21CIEAjBR3xkoeAHmFX0WSEGnaP8mduDoEAG3sbp1v7areA?=
 =?us-ascii?Q?a1CeOvkZt9vAXjQsqweOj+nkLBhhCL64FQ6cOj1mvV1bc7WpiiSDi4xVKkQK?=
 =?us-ascii?Q?UKss003BLoV+8JehseXAbUkH+cDBLlMC265FvzQeLmo+Yuzw5FaxdB8iwUkb?=
 =?us-ascii?Q?Gh7xkrH9C1X97KR2lIP1deiVCij5UZ+8ugRo1XBZgnEMRRP6P1hvuHJSIfTp?=
 =?us-ascii?Q?1YoRQq4vA9yxtOFv+oPeyB9g2YLhuFPMnnfrAyrWqSLYrcAv9oW6I/8JOJFk?=
 =?us-ascii?Q?mIM3RVbEoa/PNiXGhzwjmdRZ0v3ANsNQW3Ji/Dtad0Xxpo8tzWqg39fdb31w?=
 =?us-ascii?Q?LmBSuB1PWSp0mjoRnU4K0AANcN9uZe3DIwU0GWNEcC7BjZNK/aAwDJldrzvC?=
 =?us-ascii?Q?oZWDqzek+NGHA/XEnWCQvhCN0IAJjzGat8ZHGaxoqp/kGU3Z3WHgaA9cHyij?=
 =?us-ascii?Q?JDwBhyyGI+PlSW9FtOFxRyhFuMWisqipk7HiIugNrgTl5V/HSDU1aE/6dT3V?=
 =?us-ascii?Q?vXwx/m18Cmf4Ych5xYc6wun9jAF5BSVfGtfZhPfbeNjsDK4V9yUAt8PTlQ5S?=
 =?us-ascii?Q?M2zdXH7Zg4ywN9EI85rvuNoQudEj6v76T0V4ljG/zjIg46B/B9OIJbETfKDZ?=
 =?us-ascii?Q?g4wRxXl6pbRPNrJlvgfiwjqNNLnGKkk/Xba4v4xriEZHO0KTpAvmYD7++tU8?=
 =?us-ascii?Q?Znc7JloLzp3xMzCVv2w93O6wmuFE3KIEzr7HggbY1JaTfm9hnC/2AJEzX6LN?=
 =?us-ascii?Q?/d0rT7izoYnV4yEEKWaP6c9uMKuQHID+T+uGianRdDQx+w0axQLhB0UuVYqs?=
 =?us-ascii?Q?/BTidVJtGxURnLncFB5DkXC6L/qPr+rxHs3Ymzng2mKkiNgl88yPU1x7nPm7?=
 =?us-ascii?Q?/o6z5wrtUAX/pmwGHRd2ZGBfBnKVtah5EyaxPKZoEkTCqmsvdxKExbdArfRb?=
 =?us-ascii?Q?nH0pv/v+gjoHZB5dpZsANgp/41I8Z2lvtumX93nG5JK45pDzEwDXPf/3zPfl?=
 =?us-ascii?Q?5R7mCiuGeeIwOtT/JqjTir9dCMEE5QR4RtPA2t2UIQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab3a8da-5afc-4801-d46c-08dc162a1a86
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 00:28:47.2707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB6502

>On Sun, Jan 14, 2024 at 12:16:58PM +0800, Inochi Amaoto wrote:
>> SG2000 series SoC has the same clock as CV1810 series, but the clock
>> related to A53 is functional in SG2000 series. So a new compatible
>> string is needed for the new SoC.
>>
>> Add definition for the clock controller of the SG2000 series SoC.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> Link: https://github.com/sophgo/sophgo-doc/releases/tag/sg2000-datasheet-v1.0-alpha
>> ---
>>  Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>> index c1dc24673c0d..59ef41adb539 100644
>> --- a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>> +++ b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>> @@ -4,7 +4,7 @@
>>  $id: http://devicetree.org/schemas/clock/sophgo,cv1800-clk.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>
>> -title: Sophgo CV1800 Series Clock Controller
>> +title: Sophgo CV1800/SG2000 Series Clock Controller
>>
>>  maintainers:
>>    - Inochi Amaoto <inochiama@outlook.com>
>> @@ -14,6 +14,7 @@ properties:
>>      enum:
>>        - sophgo,cv1800-clk
>>        - sophgo,cv1810-clk
>> +      - sophgo,sg2000-clk
>
>I recall before you mentioned that the Sophgo folks were considering
>renaming one of their devices. Is the sg2000 the renamed one, or a
>different chip?
>
>Thanks,
>Conor.

Hi Conor,

The sg2000/sg2002 SoCs have one A53 core which cv1812/cv1813 SoCs
don't have. I prefer sg2000/sg2002 are different chips, or at least
an enhanced version of existed cv1812/cv1813. It is not a simple
rename.

For this patch, the sg2000 doesn't need to disable A53 related clocks
like cv18xx series. So this compatible is needed to bind to this new
logic.

Thanks,
Inochi

