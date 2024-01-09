Return-Path: <linux-kernel+bounces-21050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E1282890E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1331AB22920
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C250239FE7;
	Tue,  9 Jan 2024 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="hUx48fk3"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2109.outbound.protection.outlook.com [40.107.104.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751D339FDC;
	Tue,  9 Jan 2024 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IskX7/r7l6jwtalp0KSf100uEL/noTV3ETYH06BT+QIW9oU4OS1bBw7c0Q2lcZRzZh5k5/wPJNe1Q+ilgp80aa11iNnl1AucZ8il1wxGKItdI35CB96DOXV/h1aMNmRedZnzQ4bg7UhD5tpkoxgpK5vLZPDuRSYJuftiAxpetl4KTDTRmYYKVuraD0KSbqYqS6krwgo+uQY9NA9hSqXHSffqvVaaYLSyRGPI9IMb2vGIZ+eEff9/sDIaOyMtxJGlvhvfcWP82GgmBENJl5muj4J6qIXklpKAGyTHpv7WfqfdtwTRlkEj2TWkabGDJPpjQBu58rh73LMpiajKz2MFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmF8hdt2wNspQGqhyh3xRvuooqwYtT9RefqZedcyXUg=;
 b=JLpWxuDCme/DRx8YVUq6KSkHczQO3X46+ty5CPxClkzM6o+2IWHJptIkl7FQKs8iQRfU3s/3UP/NkrD3d3pLP91RbRmGhdBvv/aki6gQ3vGGg0CI7t5kORCSYUAwVxdwOUXyehFK07D2shfSP4ckFssksLxutrOyJclU82flLL+wp7/K1wejuM9nde9FXImp/GvHAq78EBQ3RSzbYSCaOgq58SrDVuzYAE/kDfurlnaz2hZSycneePUhJYjlRPZXSxm/BPZPMJl7UYWuI2yJkwvxbLjnstkjEhlJA4WWmL7vy1B5YQkARUZXy6eo4zrrk0pYlIMm2/4KkajxNvdtAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmF8hdt2wNspQGqhyh3xRvuooqwYtT9RefqZedcyXUg=;
 b=hUx48fk3j71ajAbWjh/w5Pmg1LiGSy2VskptMK1mAkkhfOePg61FhCHyWHWoMYOuMQDeFHstYNHHvuuYM34gG87mTfY9oaeT99cRQmtxbOgw1FmUGwychXKQSJpTtyhqhQRECp0HkS2c7q4HmZ3cQI+9pRpYbAXFJcncwZ2MLBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by AS8PR02MB6997.eurprd02.prod.outlook.com (2603:10a6:20b:2e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 15:32:27 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::4c56:a71b:d42d:11ba]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::4c56:a71b:d42d:11ba%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 15:32:27 +0000
Message-ID: <22efcd5f-26b0-6c35-92fb-90e4df3f730a@axentia.se>
Date: Tue, 9 Jan 2024 16:32:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: mux: restrict node name suffixes
Content-Language: sv-SE
From: Peter Rosin <peda@axentia.se>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
References: <20240109082511.15278-1-krzysztof.kozlowski@linaro.org>
 <568f9350-3807-ed37-db23-d3d050209fd2@axentia.se>
In-Reply-To: <568f9350-3807-ed37-db23-d3d050209fd2@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF000013E8.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1::1f) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|AS8PR02MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ff66e0-d0ed-4191-71c2-08dc11282f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P4wMP7rXk2fQBtC9W2WmzVYuCIhb7xPTRYI0cVencdOUEl8J22LqQUZOL0ye2XlYcTrDjb2NI2I3ZRzLHyKTla9RnbsZiNZ1qTjNg258IQ894K5toHS2/FM8xHhzTT6/hzX/K4W57IFKgoBVhBvH0g8CfGgZL4fX2d0txH9ARCM84DeIDcjVCbSUDUOH2N2/kLvlJTcO3R13atACCT6Ex8aETZ81JJxctG5anU8AI8b9gtlTMgz/INGai9XmyzRrjFi3P16WaYFaDoWrLFjupcQ8WRDN//3fOj9/WXN8y8PTy729rRDdoGDQcUkvnebWojFL7nmLNZTUk1Ue/K6BKRcTGWoe7ctf+KnN9C6oO8yRL+MW5FnRdUlm2vvWfA2ulnlYvkHatDpI15tC1uS50TRozlDbM8rw0pfb+WLUfG3hSTFnqCGszkUtQbc/GoK1ai9N7Di6K7vHb386/zlZn+3lltkF7AmxXS8ZGwm5nLAxvt3/WhZEPWZYpBhyCIToFdDLkd4DgCiyBk+L4OX+A4VlGI3oTZ28aft2ohooK6WGAAlxdpL/UtWA4s5CWBRSqs4u8E0hlCt9EmSnFM3Oefkylh8mLiuBjJ+BdiXP/dLrEr8GItuf33tQLoYL4kupYJ9lviNZf8+/7e6jBIiAfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(2906002)(6506007)(478600001)(8936002)(8676002)(6512007)(66946007)(66556008)(316002)(110136005)(4326008)(66476007)(5660300002)(4744005)(6486002)(41300700001)(2616005)(26005)(86362001)(31686004)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW85aUh0Mk43NmxCYUZCZkJTNFliQ3JsdzRweVM4UjB2NTNWZFZmYWo3Z3Bx?=
 =?utf-8?B?ZDN5L3F5REVER0daQTF2Ukk0MDNqM2ZLNmVGdEFOSGN2NVdtcDRIYU1uWGZX?=
 =?utf-8?B?bjlhblZwYjNGaVl4ZUlOd0NBYkE3YUk4d0dVZFF5QjVzczB4c2Q3NER0dU1l?=
 =?utf-8?B?M3J1bjJjMWZTNW9pR3ExM2NaYXIzenFEM2xSdDFpQ3o3QjBnR0tuRHFxV1FR?=
 =?utf-8?B?N2ljN1ZMNDA4cFZOa2VZakxSaW1yT1dBM3lGU1VMeEhhdDBwVWsxNlc1ZlFq?=
 =?utf-8?B?MTJJbGRYa1ExR0RJM0l6bXhUN3ZWbER4L0djNTZYYm9hVHBrbGp4SVBla01w?=
 =?utf-8?B?SzBkejVTWDFUdVlXclkwVTUrWE04NWhOZkdZTCtnendOWGtHbDZtSCtuNWZF?=
 =?utf-8?B?clpEd1RMZjl0bjViSWpMTWplc3lXUDJoWjRXaTk2d3RoOXZ0YUpKWG91UFhV?=
 =?utf-8?B?T3pKNCtIMmlLTzdVTFdwN293M3dscGNGSUhveFVDRkVURlFFTklwazM0Q3FM?=
 =?utf-8?B?VnduQk42WUZWdW9CRDhaUGVCWW9qMkRsR0lLRm9Jb1M5ZWxzaVMvYlV3eUk5?=
 =?utf-8?B?Ui8yc2E0S1QwZXRpM3AxdWhtNkQyWU1uUzNnN0pEc1lvNm5UWnhGV0VSdDQ3?=
 =?utf-8?B?YTJVTUkzbkhpQ0ZxYVJGWWhWcHUwcWtsVDRRRGJWWWlpZmcvOU1pcnFGQWFs?=
 =?utf-8?B?aHZIbmtBc2M5VmxNZXhjSWFYV3lIa0k0c2Yxcnp1Wk5IZm5xclhvU2pCdWly?=
 =?utf-8?B?dlNabFpGQlZ2eEFYUXhLVzFXb0RRM2VSdHpYZ1ZuY1lFaDBKU0FEbGtzWHFi?=
 =?utf-8?B?ZWZYV1drRjlreE91OURGWmhMQkhtQzQ3U2paNzF6alhiMGd3bG9hdVpvTHgy?=
 =?utf-8?B?NUZWQnhscVdTN2JXczVqU1E4NURBVFRBc0c5VzJ4UktScWYzU1NLYmh6RHJh?=
 =?utf-8?B?aUo3dVRkaHpJcHd6bTRKcEhZWE5QUUduQ0txWlVNQUdqbUx0b0lDRzdya0tv?=
 =?utf-8?B?Z1ltM2NPN0xsdEMycTBnU3lZTWY1amNYQ2Znb3VRS1kvdW1TU3ByS0xCVmNO?=
 =?utf-8?B?SDlpQ0hTc2FYSnNmc0cxU05GVzAxM3BWZ0FFSDh6dDJHVW5zbUtEUUNJVm1o?=
 =?utf-8?B?RlVuKzRhTXJadEhsbld4ZEFjelJoQ1gxT1IwMzBqeTE3TlNzbGFPRXpnd3RM?=
 =?utf-8?B?RE5NbG5uNjQ1UmM1TTJKa2dlMEhhQ1IxSFEwYnBQRnZsNXJRUjV3cjhQandz?=
 =?utf-8?B?YmNETUJkcFpHRmVxY0d3eGwyMy9aU0NId1BoZTdhbGRiU2ppYTM2dVRlQUZR?=
 =?utf-8?B?YWx5NTFQeWpDZnpKNXM3R1QwcytlSExkYXBjK2lmU05CSmRFRGNxeFc0Y0N2?=
 =?utf-8?B?T0ZQdGxhU3oxNUVmSFZhcXZZM1hQU0FTZU1NYjVYWFBwUHpXeElWNXFGYmJk?=
 =?utf-8?B?Vi9nbThQTkF0T0Y2ZU1DbGw4d3ppWkJlTEJvQVgwM2MzWVVRNUhtMUFya21N?=
 =?utf-8?B?dUtLMkQ3YUJkTTh6VE9PTVE2em52cVkwTTJrK3FTemtXVDYzUnFCSFp0VDJ4?=
 =?utf-8?B?SGE1RDlmdUhwSXJmcnJJeGhTQXpLTzRLMDFaY21SOEFZNUszQ2hvdklncVdq?=
 =?utf-8?B?bG5GZUlHbSs2UklxZDJXbGJNNlNMbGkyUTkwc251YUdxei9BcjN4S0ordU1U?=
 =?utf-8?B?MFFYQ2pPUXN2bWJVYTAwVmNvcGZ1WFo5Zk8wN3VCTWVVazFJTnhZUFpFMjdH?=
 =?utf-8?B?UHZsNzJydTR1N015dWtIRzdJQmc5ZWp2eW1VZWV1V2NlaitQMFh6YW5obnZZ?=
 =?utf-8?B?cnlPS2k1MWhaYmRxSXpGVE4rdGh6MEhsdTI3cWJMa1ZCTzJFVlRjQXJ1Q2Er?=
 =?utf-8?B?ajhjV3RjcXN1a0pYN3UvU1lYM0Rta3dHdEEzV1NMbFJrd3NtMDVmbnQ3aDVz?=
 =?utf-8?B?bFVxYmo5S29vVGtSYlpqeEkzNU5UZUhRNVJOS2RadWpTS2F5ZmdCRGY2Ykk4?=
 =?utf-8?B?aXFlMWFhcE5XOW5pbWd4Vnh5SWhXK2IzYVdBYmRlN2xRdEFLZHlzNjZWNUxu?=
 =?utf-8?B?YUt2RHVrOFFzWXVTRVdhRWFxdTQwbXNwdU9BWExOd2p0dUZqRVRFM3RBbFNo?=
 =?utf-8?Q?ZpADnQvEVECUiQy6zDp89opbe?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ff66e0-d0ed-4191-71c2-08dc11282f51
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 15:32:27.1374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rgZwzR0Rk9sBo7OrpLegEwHw6Ddc7aPqDXVG+HtNpKIDnaow5zFB74Y0GMKiSKV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6997

2024-01-09 at 16:23, Peter Rosin wrote:
> Hi!
> 
> 2024-01-09 at 09:25, Krzysztof Kozlowski wrote:
>> Make the pattern matching node names a bit stricter to improve DTS
>> consistency.  The pattern is restricted to -N suffixes to decimal
>> numbers.
> 
> Maybe I'm confused, but how is that compatible with the hex I2C
> address in Documentation/devicetree/bindings/mux/adi,adg792a.txt?
> 
> 	&i2c0 {
> 		mux: mux-controller@50 {
> 			compatible = "adi,adg792a";

I'm was indeed confused. The @-tail is .* and the decimal digits have
nothing to do with the address. Sorry for the noise...

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

