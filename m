Return-Path: <linux-kernel+bounces-21044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FD98288F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB6AEB244D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACA03A1BF;
	Tue,  9 Jan 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="UqFB7ITU"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2094.outbound.protection.outlook.com [40.107.247.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36BE39FD5;
	Tue,  9 Jan 2024 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJNL5DEYf0qXXy03JykpSafPw2d9AWKwcCRdmu0GrQ9cws1ffLcxVSH/04+TssNslvibZANHBlJp7VmLwaRGXf1S0enTGvEfUkLuxzR6W5W1DVCFKSwimrTIBYTITwMdClFFpsITJh9av6oABqJLixKBrqXYYu+EI+XfHlkuKX+k2aGe4mHZ1J2KjJGPYNap6Gmc4nA+Jmr39hsloMoOXyQ0ptThKfcCMgJ2YpXi0UrdYO3H/EC7Gn4JuSa3HKLyjF+b11qW6J8GGoYicFE55g+dXCHz45FdMuI5tbbADvJPpdS203GPwG7S0af70XUZRtsxG49mvIEYwF7t3DgpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAF7CdIk+l+ZtdKk4np6EeLILjVq7+pqzpkrklqhrkQ=;
 b=MJIa+5kz2YFDWpYsh89Xyz1gBbgri9oyvN3E8c4tRsuS+MPDGE/Hr1tc6jZN8B6xYJpqA71L5idJ1ttsxfECpuaF3LHpyC5T4fEYs6NNRwi30wEv6uQcc/wkZnFs4ekm+DfGG9Ojz5KU7eYO6csDnZ2L5MKMumThxXspux90PcM08dXguNej6Ra6zATuP1ewz93J0gTUmDJC3XsMl106dlU6lcRIP3dUWaAqHH/ox97Y+nQLBGp74NzIKe+jgL6bU9MFTM/pFJaLUPAcjPP2As65x6JKvMsZWlugIT7CX2RPfitYCPKXZs8GVOwJoiBPRmhrH6F84tfOfULHzQt60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAF7CdIk+l+ZtdKk4np6EeLILjVq7+pqzpkrklqhrkQ=;
 b=UqFB7ITUs1bxDY1XdbDM8kg3g7w2moMamAYle8XNlNBdQxML4UE7xIROu5r+aVWgtZ4FTAF/5zSmi2Ta2F89asWDTL5JKKRvFJBmEudCQuzDQf3ybr8JiDGHFGwK+gFP1KUEeKDwvQYaDfewfAb3hv89KoX0vdakqyGqhJF23zo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by AS8PR02MB6952.eurprd02.prod.outlook.com (2603:10a6:20b:2b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 15:23:39 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::4c56:a71b:d42d:11ba]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::4c56:a71b:d42d:11ba%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 15:23:39 +0000
Message-ID: <568f9350-3807-ed37-db23-d3d050209fd2@axentia.se>
Date: Tue, 9 Jan 2024 16:23:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: mux: restrict node name suffixes
Content-Language: sv-SE
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
References: <20240109082511.15278-1-krzysztof.kozlowski@linaro.org>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <20240109082511.15278-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::25) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|AS8PR02MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 3052e8dc-72a2-42ef-6065-08dc1126f4b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cx3CPB3p7G1WbtLuL6FnkM0sS8xlVAbcBYrFIRGzQUSFnB3qShi1t+joD8fY8Lye2WqCBUXcEIxtwoCg9HU0zn7QcrfDcPUsAsiDSItAZRVMtmSYRFM/LBHYj1pFhBdzJy/tmKzUU4Obl4Bo/ERSzBWglwJNO+zZxjCWy30QIny30pR9Z8iJZ7ZVIwh8EvvLmpLjRPbVLEgeWkOWP62PtBvH2W7217avxO7eSKt4o/6j03jVGXS25RUehHv0w/C12S4bHPO8zMaFPHGzUUnFvv4Bs7e7qomvWoUzyOfnggQhyV0CD1xGJqiVMi7KhV7+Y8WFcPNvG0MDt224pi94/QICO4CQAwXzXo810ogGWCTJoqijgeZyyDI7slHFY/nbLV97nRNC1JW4DJQWlAuAHoWDv9kTVDh8BZhJu9flNgVXrbgUiDEMR7gUgwim+aKhT1bONYEkDQzAYV7EvDuTjzlGkCo+rjyZJUoR8K1actRL0z2Rum9Jra5kVaUg/HWGy53/kVl4Ad275AUegAJQA4phpCW9g1jd7hWWdV+0qNynz8JWalBsCzIdognbFxj4xEvKb2utnbxKDVWH0k594ODZNjZG5JrrD2amskcj622/ULflqoKYSK1hiZ1Z8kaEVwyqA2ruhjh5H2gNis9AHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39840400004)(136003)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8676002)(8936002)(36756003)(6512007)(478600001)(6506007)(26005)(2616005)(66946007)(66476007)(66556008)(6486002)(38100700002)(31696002)(86362001)(316002)(110136005)(4744005)(5660300002)(2906002)(41300700001)(31686004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekdsbG1IMUFobU44Rzg4OFRsTmUyUmJ3VUF2L0VKc0ZEVnZLckZpY3FXdXdH?=
 =?utf-8?B?Z2lQNjBXbHFxK2pyREFRRDNmM0VlaU1YRVBzM0lNZHZoZVlldlVnTm9iVFVM?=
 =?utf-8?B?STJVSEVmbnpOeS9oQ3ZUL1g0Q3ZSZDliWHFHcUJQVlViUlhONWR0UXo5MGpP?=
 =?utf-8?B?bDB2MFFDbmlaQ0MxbzdPM1NaWTlBc1Fid05aeENvb1NHSUZXdlBPdytPUGtw?=
 =?utf-8?B?cUpHeFZ2VnJIZnViUFA5TUJ5ZjNhKzBrM053NDRhZGpXVmFnWS9wYWgrbElv?=
 =?utf-8?B?a1RtSFNxZ0owS0tRU3JmQW0yMTFIMkl0KzBkRXNkMFM0Mzg4V2pRZ3ZWcTJq?=
 =?utf-8?B?WWpCcVUzVjM5dWlwWG92L204bW9DS25Rb3dQM2VkWkFFb2g5Qnp3dW9mdUc2?=
 =?utf-8?B?S2pqSEtqV0R3NW9rOHlMbFhOQ21PdUN3TjlEcitHTXZqZzYwQ2RQd2JjalNp?=
 =?utf-8?B?N3RQbjdnRE9qdC9jbWpzT0xIelFzVCt2N3dJdWh0NTdBa1hYYmZHbk5Wcy9m?=
 =?utf-8?B?YU1NTHNHQXYzaTBRaWZNelVhVkdhK2tIbW9aUnZqTTBvajVCWlZheXdxdDVN?=
 =?utf-8?B?SzV1SC92SHpjR2d2V1B3d00xeXhYdWoxb2RyNmlyTmJLQU1HNUI1Tkl4ZzFO?=
 =?utf-8?B?N0MwNjdobmJtTGI5MGtFZ3RRSi9oNzlyYWo3Y3NWbVFwVWxCSnV5K1BhUUIx?=
 =?utf-8?B?aUo0OFZkV0d6MmJHRCtSeHFKaTdqckUwaXhWT2JIeVVyWFp0bzhaN3JZSWtz?=
 =?utf-8?B?RVlxaEVxdTkwTEVYc01aa3VxdjM1TSszSmhWczVEUWxZUjBXSlMwUHZzR1lJ?=
 =?utf-8?B?cUtmdHJYaHRhRjBJNUVvcUtkSjJ1ZzVqbVIrdmtpd0dVbGYzRXBpQWJpQ3c2?=
 =?utf-8?B?dnBwc1JZMTBxS3JORXRLR0UxQUd2YlF3VDJTRTk1aEdBbTRUK1VjQ0Z6aDJk?=
 =?utf-8?B?cXZZVGJ2UjJhNFdzMjR2TGVHSUIyZGdNVmtBZkJMTndQUnFWYU4xaXVyNmVr?=
 =?utf-8?B?V2NlVkVaZEducXhhaS9uM0pyY2V3RC9NNW02R3lSSUx3dVE0WFRmbExiYjJy?=
 =?utf-8?B?MWZJdDVtS1FBUGhhZm8yenEwUlBXcVRaN0Fwbk8vQldqcVozbERxWjQzbFhR?=
 =?utf-8?B?cmh2S2FpUEI1U2lmMGMxWnlvM2srVkRkdUFCelpKNFExU01KTkVSSkMxOEk5?=
 =?utf-8?B?ZGZzankwa0gvY3ZZN3N2STFmWDcxT1A5TzZxWEM0dUZKTXpVZmptQVIrN1E5?=
 =?utf-8?B?M0JJRXNsMEdPTlhXSzl4eTJNQmZMalo4Ny9pVEZ6WGlPekNHdVZkOTJsWllm?=
 =?utf-8?B?K2dLODlBZVBaNytLdUFDamIrTnNzNmVhTzZ0OE9QUXNHa2pPSXFtYjVyd3Rt?=
 =?utf-8?B?TWo2b3BhY3FwV1NHazVzZVBrNmhLdkJWK3o4NXlPcHUzY2taZEhWK2dlZWJa?=
 =?utf-8?B?dUQ4dU5rdVRJd1VuckJxdWt3SU40aElTOG1lQStmNjNlYnpsKzVETEJkSmNC?=
 =?utf-8?B?NFhTMGkwT01BNmkxdTM0TE9ER05KazdBQzh1V1crTjBlV0orT3FTemdIdkxB?=
 =?utf-8?B?emtZTVV1RzhwSFZDeE9EUGZ6Tmp5dUNoWm9nWm9wMENyN1FlNENFanV6T3lI?=
 =?utf-8?B?T0QrQVpnR05STU5aR1JPdTVzcmI4Zy8vQWJFMnFSOVBqS2xmV3RoSXdhNUF6?=
 =?utf-8?B?S2VCZ0M1c2lReGRxTWdSdjMvRHJCd29NWDVNWFpZaEdEVlBPMGNDUzN4WXQ0?=
 =?utf-8?B?VEIrWm4xdXozQVBYaGtyMC82aWZ4QW9UWld1WEFyVFA4a1RTMDdRTFZyd2ty?=
 =?utf-8?B?dW5LVGlJOHdYcTBSd2tab0R0MWIrRnpHcmdVeU9RUmFnU01QaExQVFlsS2pR?=
 =?utf-8?B?SGg1ZDRXMWwvNWdtckFpOTJtYWk3UGcvalBMS0tUZUt3UzR5cFUyMUlrS2Nx?=
 =?utf-8?B?bVJqL1pta01nRWNqV2YvdjY1YTFwME4yOTEyUWV6ZzNjRElKOWJCb3FCb2Nn?=
 =?utf-8?B?WUtCcnlFTzVFTVJnU1I4ZThrcXZ5d2kzcGFNbm05Z3BzdEhqMTZGNlJoeVlh?=
 =?utf-8?B?UGxlY2hnaXhyL0ViOEhqZmRXcHg2QnZZbHNscit0a3pHNVRnMDRWSENHSlZU?=
 =?utf-8?Q?RYRzq0cEtzy3YDPl5F3olIGp2?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 3052e8dc-72a2-42ef-6065-08dc1126f4b8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 15:23:39.4403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJArOIbIzHs4/Bvgm5hkXCEsVaVfRBPTyMNhYJtx9kO2/G19xwX1N93xMupzBMj2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6952

Hi!

2024-01-09 at 09:25, Krzysztof Kozlowski wrote:
> Make the pattern matching node names a bit stricter to improve DTS
> consistency.  The pattern is restricted to -N suffixes to decimal
> numbers.

Maybe I'm confused, but how is that compatible with the hex I2C
address in Documentation/devicetree/bindings/mux/adi,adg792a.txt?

	&i2c0 {
		mux: mux-controller@50 {
			compatible = "adi,adg792a";

Cheers,
Peter

