Return-Path: <linux-kernel+bounces-27106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6613182EA9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5DA9B2281F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EBF125B8;
	Tue, 16 Jan 2024 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rLZqB0AU"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2090.outbound.protection.outlook.com [40.92.23.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FF5125AF;
	Tue, 16 Jan 2024 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fP/dCO8ny2HRG5pI2NHyZugN2vsG0La5QzxDkl8BtH5mwRrwpcuc0fSz54IE5x1R0n+pKERjiHbqo5FGLKII/za5HqnRc0oBQ+tQgb0gvUXJzeh5lPNtPRtkWqBVStdjm9xFEVJeesVb4aQvDhoOROpwJSfV+O7I8Fvnap3d3A8Elb5woHiT4+hROOMor7veUQu9DUzvTAbArhDLwRbFg2gTTM4EnN3x5QFa9Bsz0YVU8NVMmFhDA+NozQWSema/BFMZ0BlQ0XXQkpGGzdOlpVzMn7jnocIITDqt5P/qZxmpnNSI1z+Z0ZxU2VAGcyTf9cS+eYRYcDzrNNgCVjxKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2s7tA/VJo+HAjI4XzO53a3JP19aUUFxXLh8/UIBsBs=;
 b=lHMu7ZyKn8NjGlpMOzA+WhWRr7j0AMxqYN2Y8rLR+S6q7rI9G/x4ApPMRDPm7quvh6Fhk+5g5bVXp63cqozmOMthAvEetf+Wo8P+gvPqVWRDJEocds9wbshELoYHegtADgrc4qisVIHJOL0lAgzT9/wPdWszdbkge3xz1NIQfeWqTifb6jCMUfsWuRleuLCPnGf07xuJhe7wx1tzw4V/En4uExo9fV4efIcSrCuT1Wpnzph77/FZJL/F4p4fWYEFEohxpPTTqG8/TM06vxYFZ91yUB2sqvmUfjh/sgGOC4TMs0uJk9UAHqNh9RB5DcIVPhPO16GPgu0JddRz3XhCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2s7tA/VJo+HAjI4XzO53a3JP19aUUFxXLh8/UIBsBs=;
 b=rLZqB0AUxYM2wqsHNsw0p3UlJR9M1EW6t2tiOpFkqVTM9rj7s0zItx0kwmNiyfye/vpfZeLJ611MhI54vhaVa69d2k9hdxaA2DDl2u/90TN4ADahnVGoSSTFh3xi00GO5ynF8gPH3ksmlevTEoY+WmdduaXopG6Hp6jGXQcOU9kKVgql+SKLRHx66UOe+0o20FZF/qlh6xjPVx9Y1pg/FGsv9/aXhAnevb0+PfVAAUgKgt+SbGW88guogNNUlyWnu2giSkrygat2QnaI7wdnvpgP1s/TYcYy4TvnbOGI5Is7DmF4OHIFA2gGcTWm3TjyHjGFfCVWRgpT3gVDdqjnNg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5258.namprd20.prod.outlook.com (2603:10b6:510:1b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 08:00:55 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7181.020; Tue, 16 Jan 2024
 08:00:54 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	Conor Dooley <conor@kernel.org>,
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
Date: Tue, 16 Jan 2024 16:00:45 +0800
Message-ID:
 <IA1PR20MB49535AA4F070E70BB5C9848ABB732@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116-doubling-fanning-2a46405942ae@wendy>
References: <20240116-doubling-fanning-2a46405942ae@wendy>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [hGYXQUDUu9jb6LcZazFs9LEIN7e42KpMIxH9PZX0KPirQfNN5mOuUgHURxhKdMSk]
X-ClientProxiedBy: TYAPR01CA0115.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::31) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240116080046.756811-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5258:EE_
X-MS-Office365-Filtering-Correlation-Id: fd79d720-0eca-43d0-1f5a-08dc166943df
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WoZtlgRkTEUrgvl4Kk1QBrL4CgkDbtl29ONpeaGU/2wO6mhYfBZkBfkhnXqGgiFiros5MTXAjpHAJgDl7JI1EFT0Qq9JP2W+4OtxdzCz9bG08qu1n2MeHy3dNJ2dZIbtvpAKN+EafQ2WfbiyjSxzmaf5mFARBIzShLvHjshi4GZ6viqhRkEZdZrR5mJOVi7W7nk9e8Hpt9+IQRm1p5KtiPcXsRVyuhlmcCZyTSbiJj0sN1GUJMM15fsYMolqEogQAsD0FCAHAeibwKTPwp49sQXFhwKDS7Agtagcm1YoTApYGNG1vIPmTZqY8UAXhXyJh/CRiGTTDwgJj2Nn65ZH6YFxzaN396Vxmn1BGN6UGyjDy8x3f9UHHu5pmoXk/rfMRcG1LM38d5hVcnR5m5Q98p62fWIF7qDKCunL3jeU+LPMHLVNinrM8jTsS6akyNYb1YLmv/Yh1+V1bFBb/KNHFbBLBlxFtI4EzVPN6o1YatYycSG4AZyd73whCrhMaVlwhRn37NGQ5182Luh5nThP2TMqsEpU9ENxKfKTd5e0nqngvnt8NBNMSj50Obk3sGbzBzxwDyb8nV+RAJqTHQETUlorjH3nzY6wwMJwdza+38MolC5J/OEQD9+ARJiFaPO2zOeYmH1+MrZkcwnm0EvlY5FE4Hn212zJfjWdDcspxcI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qQ8lEXL28JPy7spIFwibE//eEU+RZoUVrQurKyUfMOX9PC6i3fzGkVE31WKe?=
 =?us-ascii?Q?NxgdBtZymTWxgvJlSCR4XCORaJ5A3aj901/CdMUBNxFxivEs8x6TLVAcRwV7?=
 =?us-ascii?Q?wsfqVjgoP2uIQwDFrqW+PwEY9Qlfq8r5Oc3HssDArRlJ7M0M8Bk+htKt+aET?=
 =?us-ascii?Q?OOP185/9EVneENYtOyFcNAh6ONHLPopoSvQlAuQQSEstfJiuHQjT0RjHm2g+?=
 =?us-ascii?Q?hbEJ/wtnG1N2VM2jDE4oWyNgCd57/cO7JZHP7FVKffGLCKwxg32BZ9qNZXp1?=
 =?us-ascii?Q?STqLjvqC1B2Y1xOVxw/GpLGh2OoByGzftRUx1uGPS5MzlR1CM5+cdqZM/NLi?=
 =?us-ascii?Q?1gaUDUitb21wiII+dnypMkSfHxJX3XIu+VTjP/GOHsprbGbDp3WZSoaqp3gt?=
 =?us-ascii?Q?t1B3IrVJgcAR3qq1joQJOf2BaJ/e+oKHGU8ta/BcJUsPUWHJ4hiAArIwekSL?=
 =?us-ascii?Q?qwA0aHz+sDYe74EUMF0PpeJ9zobxtw9pZOTwvV9DekHsVHOxkYxdr9yjF/Q2?=
 =?us-ascii?Q?tfvBt7qCga1hz05mC+DFScbjTAdBaC5G7U/acQKQIZYqE3YKaN4qMXGvMQZV?=
 =?us-ascii?Q?8o8MkdViSlkhfWOnTS6rF+zm/JJLSnx6fYPIicv11srHsWVE5lcCdWBQdc1M?=
 =?us-ascii?Q?GQBlY3ipBDJpjMwbTJl7GxIGIynqzxMx5KfUJYRjYcwQwCxZC/c9FuBX9AS+?=
 =?us-ascii?Q?EiKyPBF5I1mcLCDZOBVNNTATEaefgWr45XZmkrF+SUyAAVpc9/9TY2PpVIlq?=
 =?us-ascii?Q?EzaNFlcU3D7TRuvFhzuKTjO0O68Qn4Nu4nQ+PhhF9zlAIJ9P8IzXWVl86jEZ?=
 =?us-ascii?Q?9e+B5DtjgwwIPMesZpocrRGuStg/M9x39K0f/efn0PS9/Lnhryc/anA7PbGI?=
 =?us-ascii?Q?Ai2d9BW6yqvVgaTkmqKp+imen8cW0RWXnhRqEGTM5JSPGKPQ0TS2J8pBDpnE?=
 =?us-ascii?Q?Z8HIScuv2WiitstwpO6tIcEuB8pFBcWlywKsr9w2d+MqBwGVQwy2CfzKCR/6?=
 =?us-ascii?Q?IiandtdTCoCE2vJNLhwdmwz0MPhFWb7SuqI1YWhKKEk8g8cTVE10aiv3vYya?=
 =?us-ascii?Q?WiizkS8GT1QiZ9U/i0qbFocDobsGPoXS4L0jeL3nyXvR/morfkfMmgMa7xRp?=
 =?us-ascii?Q?BVRpU0/qCdzpYIRhsj6ZgGGx6uuWAaLOCw4dMyuzGJUFib9GDC6WrO+NGErW?=
 =?us-ascii?Q?/QL0dsFPn6pb83XIpixoy7EsD4ta0wt+0GKTFDNEiEXF2YusbbYfd0Bnt0/H?=
 =?us-ascii?Q?bk5Yd8BjEVl62wKjfD9VCFR35CxUES7Jlv971e3gog=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd79d720-0eca-43d0-1f5a-08dc166943df
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 08:00:54.8166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5258

>On Tue, Jan 16, 2024 at 08:27:59AM +0800, Inochi Amaoto wrote:
>>> On Sun, Jan 14, 2024 at 12:16:58PM +0800, Inochi Amaoto wrote:
>>>> SG2000 series SoC has the same clock as CV1810 series, but the clock
>>>> related to A53 is functional in SG2000 series. So a new compatible
>>>> string is needed for the new SoC.
>>>>
>>>> Add definition for the clock controller of the SG2000 series SoC.
>>>>
>>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>>> Link: https://github.com/sophgo/sophgo-doc/releases/tag/sg2000-datasheet-v1.0-alpha
>>>> ---
>>>>  Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>>>> index c1dc24673c0d..59ef41adb539 100644
>>>> --- a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>>>> +++ b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>>>> @@ -4,7 +4,7 @@
>>>>  $id: http://devicetree.org/schemas/clock/sophgo,cv1800-clk.yaml#
>>>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>
>>>> -title: Sophgo CV1800 Series Clock Controller
>>>> +title: Sophgo CV1800/SG2000 Series Clock Controller
>>>>
>>>>  maintainers:
>>>>    - Inochi Amaoto <inochiama@outlook.com>
>>>> @@ -14,6 +14,7 @@ properties:
>>>>      enum:
>>>>        - sophgo,cv1800-clk
>>>>        - sophgo,cv1810-clk
>>>> +      - sophgo,sg2000-clk
>>>
>>> I recall before you mentioned that the Sophgo folks were considering
>>> renaming one of their devices. Is the sg2000 the renamed one, or a
>>> different chip?
>
>> The sg2000/sg2002 SoCs have one A53 core which cv1812/cv1813 SoCs
>> don't have. I prefer sg2000/sg2002 are different chips, or at least
>> an enhanced version of existed cv1812/cv1813. It is not a simple
>> rename.
>>
>> For this patch, the sg2000 doesn't need to disable A53 related clocks
>> like cv18xx series. So this compatible is needed to bind to this new
>> logic.
>
>I'm not disputing the unique compatible - you previously mentioned that
>Sophgo were considering rebranding the cvXXXX series of chips going
>forward and that one particular chip might undergo a name change.
>I was wondering if this was that chip or just another device in the
>series.
>
>Thanks,
>Conor.

For your question, this is the rename chip I mentioned.

This is the name mapping I have known:
cv1812cp -> sg2000
cv1813h -> sg2002

