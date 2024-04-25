Return-Path: <linux-kernel+bounces-158113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D292B8B1BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024C81C23C07
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2176BFA3;
	Thu, 25 Apr 2024 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="ctfvXRw9"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B986BFCC;
	Thu, 25 Apr 2024 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029566; cv=fail; b=iW18eQO8A+/bHFAmh9PGwZTZcvAdg8jLaafVVcHyQTEJ99vgkyq82n9bprw0gSWIn2x4aRKDwD5a61dpx3ME4Geil9r39uZ7tyJIbFiaAfjbHlkYQa9SpigbNcBvv3NaQbxzczpgwZUsSBk+vPKstgp69pLAI3lhAvEmQZN/Ips=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029566; c=relaxed/simple;
	bh=8tNumToQ/b8ZYizCZpY8+BJLy4P3c9kz8aIBHtldvts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cZ+Atr7q4yNuI/RZvlrs3YQ5x1YnUEbpeKqHfaRrN7Idn34MA5ZLFxG9OFVa5DTZImem6oHz7IGBvxlCvQTJuqv5vGVndRNeh31A/tIwrchuRuQp+0yElTrA10KAClIZ/qhx+Z0LmPkLaNEuJ8CWA/S3gcMhwk9xmBd7dY5L+7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=ctfvXRw9; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P6x6bF002954;
	Thu, 25 Apr 2024 08:19:11 +0100
Received: from ma0pr01cu012.outbound.protection.outlook.com (mail-southindiaazlp17011006.outbound.protection.outlook.com [40.93.131.6])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xny4n9848-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 08:19:11 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5lA2rLxsY3790KdhJlFbLJrjTFK6axU0udasLqupM67kLgUWo6GUApYZTW3nnrLNMshj78SjgzuPsc9xoJYPxeTds7c5t47QOE1x8RscVOt1lcVRHQ0tXY0tnM7OQ/lS9TwrqsWjTvxuOQa+Yejh+7qFP2flFKNNPlpXL2kQXtm2QVAm7JywA9kvtWm/mQMSJ4A9KiJtxQduG0tpP4iS78Q13IwvdoK/UOS7Jdq5MuCi5ceMLCfdYJ0hyUat6se/7Qjy3rfg/7WYm3TbYi0LYEexyK6pI1gZCiD+EkYThQJfbM02C+IClehEfWNnGdiS0tNhE27DhTPR817g60eWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tNumToQ/b8ZYizCZpY8+BJLy4P3c9kz8aIBHtldvts=;
 b=BPqH3FRlRQnxKlTSztmMloVl5lG/A9uTNb78q6NRNbTBNJBLsEhEiZTmrv7VPYD3I2wuo8tCdv9h+0FrM6rO6+DOU6faQ5oLHMsPlOg/FgF4TaT6DUDfNrQupR1/owBrj9bCl6gUHQhHWQxJWyIoC+opPe9K7Gl11hmxldztGvgZD/paNTltCs+pZqgVHjuQhYZ418CMN4fePvM6ZaVf+OFcX2cVn0EuZMzCLxY1OBDiXhV0eWaMmaXlAUm41LkyC8poO8Ap4TNyXc+m6dCEH/UT3n+gPgecRnX/eNvh6RAQuAWsqbD2skcLm7GGZrkW5Kej2n4wfzbciJckOV+oGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tNumToQ/b8ZYizCZpY8+BJLy4P3c9kz8aIBHtldvts=;
 b=ctfvXRw95Q8t/LB6SggmsZrAftAV3pC5qPlguLeoTjoEuPO3rHSDEYIGJQ4Dlq/8b4ZV7aCOqLZh8FhPSFpFGb0Vi9+ZpVbw4povhIrlPQ4mM1oayGuol7fnbXmy6hSuzWb8mr1cjk4l9SFhpZLuCDUHI0EPqGNAHFQ2OtOvYkU=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN0PR01MB9336.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 07:19:05 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 07:19:04 +0000
Message-ID: <77b837b8-600a-4ad9-b2f9-ee24450e8c5f@blaize.com>
Date: Thu, 25 Apr 2024 08:18:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] dt-bindings: clock: Add binding constants for
 BLZP1600
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20240424133241.19210-1-nikolaos.pasaloukos@blaize.com>
 <fd4072dc-7cd3-4d13-a15b-d63c675a5994@linaro.org>
 <c11194fb-0449-4b36-adf1-c15d7a66344d@blaize.com>
 <b9b3ccaf-7ad1-485a-9ee8-9a9922936e79@linaro.org>
Content-Language: en-GB
From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
In-Reply-To: <b9b3ccaf-7ad1-485a-9ee8-9a9922936e79@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0236.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::7) To MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:12a::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB10184:EE_|PN0PR01MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: 65848b63-a622-4314-f203-08dc64f7fd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Yzh1dnVxU2gxQTZReTFKeXllRDN3YXZMWTR2c2Z4Z0k0em9zeUJOY1g5MXpC?=
 =?utf-8?B?NzA5bWxaQTBxa2s1K0YzMnkxOTdKNVc1Z2xISXh6d0hDRUZNdUdJMUgrNXd1?=
 =?utf-8?B?SlNCaStVbFdqT2FlZTlWcmdYVllCSzR0QkduT2RWWTZWdlNXcGkvUUk0Wlpk?=
 =?utf-8?B?OVlJVll5VE5JZ1VDa1AzMjU4UlNyaFZFOFRrYnFlR0tyYjZkRU9kdlpwOHRw?=
 =?utf-8?B?RWczWTd5UjBaUHdheVRPdGMrc1ViSnU3UzhZZmZsLzd2VTVSdDFQcnAwWG0y?=
 =?utf-8?B?RGFmcEcvei9NM0VGdkU0aTBYdjhMWkR4Qm1OM2RGZjJLMGJac056b3VVL3A4?=
 =?utf-8?B?T2QvaHZqNlhRQU9mL0FPL0lYZURORlJtdExuK1JvL2NJZ0tWV2U1bWdlSzFJ?=
 =?utf-8?B?bTI2U2hhZ0FqTituQXVYTiswakpkTTVMVFBwQkcyNUZkRHp1YVd1S2U4MjNt?=
 =?utf-8?B?U3gzUU1vNmphMGo3MVorV0RKSStwbCtOOVFma1lBWFR6TkdUaHZhRlZYd1lZ?=
 =?utf-8?B?VjM3QzhYdVRJUUFNVnZxOGUwTGYrMmxORTRPVUNFT04yTy9ZdVFrcGNPWW9i?=
 =?utf-8?B?WFRSVnRjRzI5aFV1Um42REt3RlFBM3JXMGhNTHhqdTNKN2t2cmFSNmh3Zzk4?=
 =?utf-8?B?RjF4aHBqOVorY2lBa3BLVG9za0NPa0JsOGVrK2ZTYnJBWmk5Q1VVa3BabjRK?=
 =?utf-8?B?OEhidGdUbDUyR3RyaHNnQ3FBdVNRdXZLWjA5SWlGelZQOGVOMjJMMFlGSkow?=
 =?utf-8?B?VFNpU1dPRjhtUGJHUWU2K2g4emdpNGpHaGlwVmFKYW90V2NCR09kVXgvaE9z?=
 =?utf-8?B?WnROWm1ETlpibTJFUVZiRDY2cUJLTG5nTmppSWZvWWU1NlhrU25sR1VET1hH?=
 =?utf-8?B?ZkZCU0EvbGdWKzVkNS9nT0htWHRYS2lhQjI4WjlLaDlDWForVDQ0MlhUcHp6?=
 =?utf-8?B?UFdhRzVwREtFMHgyNzJZSVM1WGtvRlJTcHFSNTFwdVE5Y3l4aVM2YVRmQS9u?=
 =?utf-8?B?aHFSWEY2YVV1Sk91ZEZETmIrcG1OY01kTG8ySFg0ZWRMaVZxRGVtclFFWkxo?=
 =?utf-8?B?aU5jdk0vUFZWYzgrYisrZVlxbjM2S0p6OWdsU1hhVjkzTXhRTWVvODBiL3Ax?=
 =?utf-8?B?WkZBeHVTN0RDVzdjNnNBSHErWU1tZlAwdkI3WWFjZnU0VnFzUWZGL0RNd0sx?=
 =?utf-8?B?cldyZm02ekp0RmpnOEJBZjBhcnhoSG96WjFqSlpOdEVXMUJlZ0VZcjNlZjVW?=
 =?utf-8?B?L3V3OWltYWtTdEpubFVkdk1WVmtQYVRuaVlTOHlUdm9waHFjMU9CanNPMnA2?=
 =?utf-8?B?bXdGdWdTWmI2aEVUU2pKUjg5N0QwMk4yZXBpM3pHMnBLR3pLNUJQdzNKcmVs?=
 =?utf-8?B?VTJLZjJJT1p4T0gwVVNDZVVLMVVYeXBqMUttUlhEcFo3ZlN6YjdKZ09SMjgv?=
 =?utf-8?B?VHFTbVRIU1FMbmxSbzFlVENhTVo1V1Rzc3ZlcVZSWXkwd2oxRDJNMlFZK0JZ?=
 =?utf-8?B?VVo4bGQ5S08waC9JMlFZRHJUQVVlZHN3VkdLTzlkcFpYWGxmL3dOM2Z6bUw0?=
 =?utf-8?B?SnNVMklHU3FsVEtGamJod3NiOXY1MVJUZlpMNzRMRkdBLytuMkNyZ2lEelRk?=
 =?utf-8?B?VHJMeFhpMXJuY010eEdseU8rYjlTWlpzd2tMNHgvNlZJZkUydy93R3pJWVJl?=
 =?utf-8?B?d241eFR2OGMrbnVQcGN1aDk0ZjlSc001S0FTbXpsd0Z3TmRjTlFWTU13PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eG4vV3BJY3lFemxuZWdBWFl3LzJTWnliRm5XRVF6eFUzUzY1TnJtV29qa1pn?=
 =?utf-8?B?WnJHcndNRFN5cldiZjhQb3d6UC9GN1J2K3FqQ1laTVFuZU1OL042ekhvR25Q?=
 =?utf-8?B?RWZFSEQrM0orK3ZqejA4Y1RhQ3ZJZ3lzQklEOHZveXdLYjZwYTZNLzNnZ3hw?=
 =?utf-8?B?MmlOdktzeUlRaXFGSzV3TUtVMFlrT0NwTEdtQVQ5SG1FclZYaWxtRHoyMFk2?=
 =?utf-8?B?cDNuaVdZSDhiOVFyZkd3RmRzc0hkUWhrdTgyOGVVd2dJSjV6UmNZKzdvQVJ3?=
 =?utf-8?B?VmZma2xVR2kzNWY0aU93aU9lS0tZVHRIRkgycEs4UmhtQmlrOUhhWFVoMkJQ?=
 =?utf-8?B?ek81b0IrdWl0YVFQUTVicmFJbm9xdEU1YmxRU1pMb1pkQ3AwYW5iajdEblBC?=
 =?utf-8?B?STAveDd1aUtra2MrT0ExT2tIMWlvQWI2YkRsdUdXeXZOK2ZQaGhqNW96VjZ2?=
 =?utf-8?B?Tk9oZ0NjK0plcGFkY1dYYlJTSXdodXZOeXdSM1RudExDaC9QdXdsSVF6Y3FZ?=
 =?utf-8?B?YWI2eTdnNFYyV2ZCekFhcFZGUWxzOHd6WktIeldpSnc5U3U0dTdUK1JNUk9s?=
 =?utf-8?B?V0hsMlNGZFNESjh6eDdnU3hMOWRsTVYxMk1JTXYrY0xUbXJmTWl6UmJPWmJW?=
 =?utf-8?B?NC9IWmthUXEyVTR0Q000VzN0K1BhWHI2dEdjdkJoWTNDajNqdjRwcHhhNzRI?=
 =?utf-8?B?dDZ5ZjBEd1c0NjhJUkgwV2FLbUV0UXZRN014ZzlmaTFTNmlaa2Z4U0xwZ3li?=
 =?utf-8?B?ZGplUDYrQW5qMW5WSVp4Q0U2dnNSU2VaemNwaGxNOEkwRlU0OGNtaHpJVXhP?=
 =?utf-8?B?TVcvRys4K0diOFE0MENLcE1lbWxJR3FFVjdiMGdpUTEzWVRqeittVk91Q25X?=
 =?utf-8?B?eTVLdkJ5Wm1oWjB2clduTzUrd0Jxck43bUZmSzRZOXhpOWVTSW5OQlRBYTQy?=
 =?utf-8?B?WG9FZGRUdXBDSGJ0bkJBb0dmQURnMDhuOHRQeGZmSUx5NDZZUy9VcnByN0RP?=
 =?utf-8?B?cFJjSEROcnVvdHp5KzJZbDIwbEMzWjhmMGlnZjhxNHE1S254cVVUTEkxL09P?=
 =?utf-8?B?VHpGZFFZcENxUk9CZDhBMTNzbmlKOCt6WEd2UUZWMmErU2cyQ0hod2sySTg5?=
 =?utf-8?B?dUc3U2NlOWh6M095ZC9SejlWSFZoV3hjdkhBcWFhakxtT1hrVUhtRnZKSWs5?=
 =?utf-8?B?bE85U0NWM2xEVXQvTGJnTkF1SC9xUmx6alVUekg1STZkZ2NPMkpaaHhFNkFM?=
 =?utf-8?B?T1NTU3pvd1RRM3BaaVdVQmtkZk5uUjdKVU1PdkVYb3VwQWpmYmpYUXl5N2xN?=
 =?utf-8?B?UFZXanZTZ3lFakMvbTh6ZkJBcGUyWW13bUdvTkVjMTlYQjM0VnhDb29ncnFP?=
 =?utf-8?B?SHFTWXYvQWVEcTJZYXlKWENXeFlkaVZGQlFRQnI2a2xRcmtrWFBxaGpBNFJp?=
 =?utf-8?B?TTVqSVVxem55Si9VQ1RTcGg1TW42ajlkSXl5VW1HVFBqR09lajFuQ3lVaFV0?=
 =?utf-8?B?bTZsYkN3NEN0c2xCV2VVeXVGZ21vby9tVHA3WUR5aEljN1VTWHd6V0s4cmdX?=
 =?utf-8?B?MzVyUkk5Y29tNzcrdDJ1NlNhK0ZJOXY2MmNIem1GMjBrRFBRQVdsWWhoYjQ0?=
 =?utf-8?B?S2JMYVpXK2IyRHFXckFSSDNtcXVNTTFPL1d6SkxCdmhaNi9kZ00ySWtzZmJB?=
 =?utf-8?B?Nndad3IzVW5sRW5NMG5vbmd1RjVVN2VzYzlHV1YyektJem4vLzN1dmpZTENL?=
 =?utf-8?B?L3JJOEphdWk2ZFdVS1loYnlDaFptRDZuV0VTSWpjMFdqL0szeTcxWWZoNDJF?=
 =?utf-8?B?c2wvbTZJWGNFSkhocGo1TkdhSGtnRkk2WUd4N3Q2bmE4UG84ZERtejlDOGkv?=
 =?utf-8?B?SDZZVXlqRm1KSnJudzhFeFhBUDZvSEZMWmxTOXFzTnpuWGVPZnBYcmxwWVpI?=
 =?utf-8?B?YmowMldCVXZnSmg1aVhoNXJjVmZVcjFtTlhlTW9JWFZsL1RRN3pwUGNCS0RT?=
 =?utf-8?B?bENtNnNNdlgzSTlUaUxyT2hPQ0oxK2FQZWFpRHliaWRBWlMyTndEUVdlL1ov?=
 =?utf-8?B?cHZBNW8zZTFGMmR2V0JZTG04RmxiL1FQWnlFWWJ6T05pdTBaNjVablRTYTNU?=
 =?utf-8?B?TmFieEtlNk40NHVtNW1mdVkzYTZzaDhRcHF5RzN4WHpNWjNONmljOVk5MWNt?=
 =?utf-8?B?Zmczc0d5R0xFNkpBWk5BSzUrT0c0RkZRcmtlU0p4SEIwM2drRjJwT1ptNXV1?=
 =?utf-8?Q?9EabroZmaUMkiIgObn1Db7dgZZ1tjD/zTalFuni7Bg=3D?=
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65848b63-a622-4314-f203-08dc64f7fd06
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 07:19:04.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlAw/5LwgzWnxxhoXYoIpPHD3w19msA2tSn4s46WtP3Bg3GE177jpu1K9WKM5ETZoDx06+upKut4ybh1kIHWxu3sreE42PDfbxK+sAl7HwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9336
X-Proofpoint-GUID: 0w7rnmwZF64Fw-pN-EBQHvyskiPKKsBI
X-Proofpoint-ORIG-GUID: 0w7rnmwZF64Fw-pN-EBQHvyskiPKKsBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_06,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=808 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2404010002
 definitions=main-2404250051

On 25/04/2024 07:56, Krzysztof Kozlowski wrote:
> On 24/04/2024 18:14, Nikolaos Pasaloukos wrote:
>>> No, they cannot be invalid. IDs start from 0 and are incremented by one.
>>> If you have holes, it is not a binding.
>>>
>>> Drop the header or use it properly, so as virtual IDs.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> My intention was to avoid using magic numbers on the DeviceTree. That's why I added them here.
>> Also, we have some custom drivers which we plan to upload and their schemas need those files.
>> The alternative would be to use magic numbers for our clocks and resets.
>>
>> In the commit message and on the header file I have mentioned that these are numbers matching
>> the hardware specification (1 to 1) of the chip not just enums.
>> Some IDs are invalid because of a hardware gap, some others are invalid because the SCMI
>> service will return an error that the number is invalid.
>>
>> Is there another way to prevent the magic numbers in the schemas and device-tree.
>>
>> Thank you very much for your fast and detailed review.
> Bindings describe the interface between DTS and drivers (OS or some sort
> of other software). The purpose of binding headers is to document the
> constants which are used by both, because they are part of that
> interface. Therefore constants are pure abstraction.
>
> Let me rephrase the question: Why you do not have headers for interrupt
> numbers? All addresses? GPIO pin numbers?
>
> Best regards,
> Krzysztof
>
Thank you very much for your feedback Krzysztof, I'll prepare a v3 with proper
threading this time, removing the dt-bindings for the clock & reset.

Best regards,
Niko


