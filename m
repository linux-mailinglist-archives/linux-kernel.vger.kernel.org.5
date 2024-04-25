Return-Path: <linux-kernel+bounces-158304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F548B1E13
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09676B218B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F0384DF0;
	Thu, 25 Apr 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="AqpwE6PC"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85A528F7;
	Thu, 25 Apr 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037664; cv=fail; b=Ik2kifWDKL00slyygmD7esZCOHpajEaXxkHAAfqBmi0af8iXW7Wlq1hZjSXl+CXIrjrq2QaCYTOWidrRgBA/EDaL3cqJocYCjRiUMUxlSpcGGIl/3W6DSwGs5rxribGsOT/8iCPOBKNSQqFpv2cqvZ+VDzIztuLO/8aj7YetaMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037664; c=relaxed/simple;
	bh=cIxZvkgthkM6wRcBQ9tKZ4tS52iFAG8RvGcFkMFB3Ds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OlJ4hrjWTg+Qjvohzr7QrIePS+rJyW3licuqjwgHr0J3AZHAJmKImG0azYdDRZBtNWa/PVTigibbFW0Z+BaYjvxPuRmAtHAeJXFe03ZS2G29W1MKt26Wm3dQLxadmdDOVqtGZgYIVKWnx7Tzaj4yOg1uRI1PI41+29dHflQX2nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=AqpwE6PC; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P9FH0a019229;
	Thu, 25 Apr 2024 10:34:05 +0100
Received: from ma0pr01cu012.outbound.protection.outlook.com (mail-southindiaazlp17011005.outbound.protection.outlook.com [40.93.131.5])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xny4n99m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 10:34:05 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxoHAJT2AZ7xbb3k/Z3UiNOAgCxjfyyai4K/L0O/oyk2Nppkr4X3/M2Ac7GHR/MjEZ9gE16TQbTBW/4WrJzGpngKn8RUM1ZrVc1FJEVTjppQ7grXmIhzjZuICLDPhJO0hsqY6NoPCr9Rpkj+31Pw48bDcQQGLo4kuycEx8kYTezTPxMXwPb7GGwjKX720E9SKja78LgYlhKV52XWklAGTiMMiKASlyKaie8+ECOKLm10+0hVgg8Lw3IaIaWSmQaGimYgkQ6/d+mNVsVoR94OfS81SEGOsnrHqligOCeYcLcGY8oo6GMxilr66m6vLvqM095J8qINuOjZ8dRl5G+rCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ve2cYbChshGJ2jNr/CD2x3QoFE+lEZQVOM5jXoQDwI=;
 b=UObse0RYEgTvAn/gYuNC1BHx6IkDvxYe8N5c3IlGCkW4v7ac1oXNllKURGT3lGLHWMN2FQIs17V8udFwVwmzuv/gVLECpAY6DGci91960NbZEVQSznOu0VZRW7d9sOoXNSqgunldIEoHv3CDd+tIeO6k7N3gmk8KPMlGAHlKM0uamN5STegwPj2hTptUEQYCX6yN6T6sSPDvHJUx4iyhMvQSU3m8aGfDaxX9GvjuI63RW1LAxe8GL5n5ixD22pd3EKRyiDVuspAR70FsBInlSI8XoEkqEp2eTsxijXaDSEUhPhs3jDQotktCZ+h2aknj726qEqznlkxWWvWOzRq3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ve2cYbChshGJ2jNr/CD2x3QoFE+lEZQVOM5jXoQDwI=;
 b=AqpwE6PCdtG1xXwMGkNmrd2yzIxPPIKYCFgatCwSnW6r4kx5AweqUK4bQ7RuO9UZM3HrdUPd5DNBiY+fMPmD+Dqn6wdLD+kPHoPkpQVGLe57Fj5BhGZX5TquD/wNjAYg4H6w+nsGdTyMaa/5D2OXhXABJkFmGsv5L3eYTtk2D0Y=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by MA0PR01MB7426.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25; Thu, 25 Apr
 2024 09:33:59 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 09:33:59 +0000
Message-ID: <16091773-b0dd-415f-9d83-7a0e76f9121b@blaize.com>
Date: Thu, 25 Apr 2024 10:33:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] arm64: Add initial support for Blaize BLZP1600 CB2
To: Conor Dooley <conor@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20240424133320.19273-1-nikolaos.pasaloukos@blaize.com>
 <20240424-budget-vaguely-426f34eb305e@spud>
Content-Language: en-GB
From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20240424-budget-vaguely-426f34eb305e@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::17) To MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:12a::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB10184:EE_|MA0PR01MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b900c3-1765-48c7-0014-08dc650ad613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QnFCRElzMnV5bnFJNVdMNzcvVEpqdE8yYjlDcXVKWG4ycGNsZENqUlRwcWgz?=
 =?utf-8?B?bU9WL1haUzNYdDdBUVJPaE1EQzVBdmpMYjE1REwzSWFsaHp1OTdhMWlxZi9D?=
 =?utf-8?B?bVIyTzdwMUszZGFYSHRJejM5cUxVVXByNVRUNnIyWUJNa3VHK3hMVEQrbTRJ?=
 =?utf-8?B?djRNWjh3TW5hdyt5VkIraXFQYURiUERtUEFuNHMxUE9YNWlTcUdSTk5sckZZ?=
 =?utf-8?B?QVRTbnhRblZtNUdKbEljL2RwYmFNU3l4NkJPZ2R1WlNHZEl5YWdvWVZ2WFJq?=
 =?utf-8?B?Vzk3NUo0bXRpMlQ3Wi9JOEUwSXJGVW9QUVlzaGJkOXpPWFdZMkhPZzAwdGdu?=
 =?utf-8?B?d0dPZ21lR0J6d3gwUWdDY3lGdGlnY2lSbW1nR0FJWDBkQkpjSDRlYVhKUlpR?=
 =?utf-8?B?THVlTUc4b0pLTXBDVWtZQVFicXo4L2RTYng3ajBvS3RFUjA4ak9mcGFxbDRo?=
 =?utf-8?B?WGxndHZnY3EvN3hGRm9wdVBGaUhmQ2J5TUIzeWFCUWlHRkNPOGZqTllxdGFZ?=
 =?utf-8?B?Nk5HNlhkaFBQT0hmNHFvUHdTWnludWIzcWVYUmFVdmUxT29FdmUxYkQrL2k3?=
 =?utf-8?B?dncrSXZMUWhZK0VJY3FsMFFuaHFEbGVTaC9GbTA4QTZ0cVU4NzRHbTE2TWdn?=
 =?utf-8?B?d3Jibjhvb0FrT0JOLzFSL0RYZEszcjdSbnVZak9KeU1sQ0dSYUd2dWg2V3JC?=
 =?utf-8?B?Q0EwNnduTVJObUliQ2pWaEFzOCtET1ZEbXlxY3NQS0FJcEIreUlhYVhaWFNF?=
 =?utf-8?B?VElMa2hzQXlmYlNPSkkwQWd5aDBjWmR3T1hURDBNWFFreW5xcWRsenYwRW9T?=
 =?utf-8?B?UGM0RitTQUYzTTZ2UE4yd3NUM1hkMWdybEg4elJOV1lMYlFVMDlxbG5FaVRr?=
 =?utf-8?B?MXg5clFyRzBpbERTdld4RG1aY09sNUxHT1N5dDlCcC9za3A2OVgwUVQwVUFC?=
 =?utf-8?B?Qy9KbUdGZE1GZTNzZXkzdWlUSjR3dCtTMEVWOEtDVEJUenA0dFFwWnNsdVF3?=
 =?utf-8?B?azgzV0ZBczZZZ3lPWEN3aDk0Q3BpL3BHbWpjM3ZsdFpBNHR4bTJsb0FIV2x2?=
 =?utf-8?B?OGpSVGdva0hQdnhvalNLZ04wbVJUSmJmUHBiUWY4dnFsRE5WRVdCNlovOXBP?=
 =?utf-8?B?MmZjS1QyOG1kY0dGdE9uMHcxeW9ZTUtMME9ZbVFKWlVGUVFOeXhPRFAvUXpC?=
 =?utf-8?B?ZWtlM2loeFJETzB4aFBJeEI3MzlGV1VkUk5IQ2xvNEV2VUdibDZibUtYOVJE?=
 =?utf-8?B?eldLODlYM3pWS05yMXNPZkE1c0ZIdnhqYmRaL0xGREFoYzhpVTFVekF4L3RL?=
 =?utf-8?B?Y2RzVFlDSnVNZzdvK0VLWDgxanNjcDNYMXAzelE3cTJFNXU4YjhMOWllOFpU?=
 =?utf-8?B?OHVNbVYwUDVZQVJ4b3d0OVluZ05HVDZMUlVnOSs1R3RaYmg4TkxFQktIU3FZ?=
 =?utf-8?B?M2RRR0JVbVkwRVoxb2NqazF4bGdoenA2dHZ1SFhVdmh2Zzl5eG4ySnh6T0Zt?=
 =?utf-8?B?cFhadWhvL3hGYzMzckdZMzB0RFArWVJ0UkFBVkRCb0I4UXQxWVBsbXFRL0RD?=
 =?utf-8?B?L3BqRnl0NUtMQzdVcnovT1Y5TzFwbmZQbG1XTnNyR0FuMlZlb2plL1EwNmwx?=
 =?utf-8?B?MGduU2VZekFLUDlXNEdQS2Z1SjF6cXc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3hBbHE5OUpmU2xzNkFLSisrOW9DTkloVVVjVlB0SWsrMGFQWjNjbEZESEpM?=
 =?utf-8?B?bkpWdjFqdlViN3Fpb3lEc1cyS3NZNlRXajcxZ1gwRVRTWTlrcEpVZk12eGZJ?=
 =?utf-8?B?VEQxUGw0eitzSkVPU2FYMHh2TXlhZGVIWTh5ZStlcElmM3JmOGxEV3BmNW9X?=
 =?utf-8?B?KzJ5Tkh3KzV1aVpGanZwY0ptdnJxUkFza09NVDZaQkhNeEFwd0FZZDQzKzJh?=
 =?utf-8?B?MURNd2hadnBNYkdvazVsNHhJVEJ0UXF2TjRtZzRiYXYweWtBZmJlbWc0eTZB?=
 =?utf-8?B?eW03SkNCdmhwK0g3QUNLcDZ4WkdPQjQvb3lxZWE5Y1p3a2h2bXpkcXJRSytz?=
 =?utf-8?B?M2g3eUUvZitoU3FyaTI3WHdGTWk2VU1odVlrZ3EyV2xWb25ORjVleVJhMlpu?=
 =?utf-8?B?bDRNbnNWbWt0aTg3SkFqS0Q1cWpEV1RLdStnM1pIanYvZDRkd0o2c0h3UDda?=
 =?utf-8?B?WWorKzY1Y1ZUVlo0M3FTYlJpbzkxelhkZU9ZVkFlQ3VUVGpzQjdYVlhTMnNi?=
 =?utf-8?B?d29iWHVjbDVhL0hvSGROK2ltd056MWdXQzJIbzlteEJ1ZGR0dEViSjNDbWUz?=
 =?utf-8?B?b2dxOWxSTGpLMHE1ZHVWSkZIYnlRekg1YStiaUg4UVRIZkQxMHBaS1VVTHhl?=
 =?utf-8?B?NWRRLzNwMUkxZ0lVNDRYTDc3YmFhNDEzelI4TlE2Z3JvK0QrM1hYUGowUnhD?=
 =?utf-8?B?YUR5Y0djTWdvM2E3UDNreVZOWkFhZUZGd0tTV0hSUHBtODVVbFllbktobktQ?=
 =?utf-8?B?VE4xVXBSSEZHVFRsNkNqWjVtcXllZHQrTFIvaFJ2blRVekhzYkdPWEVnRlZw?=
 =?utf-8?B?UVdvNkhSR3hFOXpPZS9nckdQMTcrazJmZXk0Um15alhqcGs3blRPODgvR3dK?=
 =?utf-8?B?M1V4WVN6aTlqU0Y4VEhmTHZCaEJkTTF0d1FFcHRpZ3BiUXlQMW9rMGlTTHkw?=
 =?utf-8?B?NDNRb0hoU2ZQNnRuNjJBdDFqTW1xMWlwMkhHak05ZHVFZEFlSDdYS1pMUTB4?=
 =?utf-8?B?aHJZMldZbFdIK2I2WTBYdCtpMlZxYWNPSHY0RUJEQzl5Z2FyajBDWGpMMUVX?=
 =?utf-8?B?VElPVjloYkxvOHlrc1FWeWw5Y080cHNKNEFBVlIrMlJKWGZrRHBxMnF0TC9V?=
 =?utf-8?B?Vk43V3gxN2RRZzlDaWJsdE43VVlqV3dIVi93N25xZUFJZXFvMHkvZWkwQ1Jq?=
 =?utf-8?B?VjNsNXQ3T0J4dWFSb3dLNXNIYlJwcFc5UUUvWlBpL1dHVkc5Um9BUldlMUNw?=
 =?utf-8?B?dFh3QkFXV3hETzFkalcxWGdrbEo5RUpVZ2dGU1l3NEJHdGplclV3Y0g5UkFa?=
 =?utf-8?B?MWhSbklKQ2JyVWRnMm5CbXBFTDR4cUlNVE1DNEgyWjhwZlhPbXZsMjRqSDdu?=
 =?utf-8?B?S1lTekRBNzNGdjR0cnd5eU5obE93ZTFkYUtYSUZscUhyRTltWURrN0VHNVZ6?=
 =?utf-8?B?bWcwS2ltNVBrQTg3bUdrUWxKMG5YL2w3a1VkdzR5OHV5cDNUWFBxSFNNTGFL?=
 =?utf-8?B?VzR4RkFzTytQRHhWNDFqYmd0RTY2RWZzVFIyelhFVFQweDB5MS9DRFNJZndu?=
 =?utf-8?B?TVhZcE11cUxhRElzSkswZG9EVU10Nmp6YkwwOWdaWDBvZnJPaTBScmlrQXJP?=
 =?utf-8?B?bmo5a3NaaTRvam9saHA0VmNCclFqOHNBYjJtQlZObVplSlBZaGVmYnlCT1hQ?=
 =?utf-8?B?Q1JTbFlueEx6SWVmcVo5ci9ZVEU5ZlZaSDVFTTJtbjA5TjF6Y093TkU1d1Rw?=
 =?utf-8?B?L0h3U29HV1d3V1RNVkNmUUd1bEdGeXFHemNZc2xqT01RckZzRWxDZlR3eEg3?=
 =?utf-8?B?em9qamh0V0g4TzBwYlFwRWRLYXRnK1ZXZjFVZDhGT1p2bnpvREtOOFR0UjQ1?=
 =?utf-8?B?cEdpYnJWYUIzdWhkTVYzZUdJSHBvSjZQTGFISlptMGEySEwwYjRPQXpaVEdZ?=
 =?utf-8?B?dlRNeW5YWFBDbzRGcTRQU0dvcUcvTk00dythYkF3WkE0VWFveCsveEQ0d0Vh?=
 =?utf-8?B?bDlCVGZKWVVHdmI0TW10S0NwajdmOGpkK1ZnbFNXS01qSmxXdFlxejFsRmVR?=
 =?utf-8?B?S21TRWk2UHNaWmsyWHF4TmwwZ1VDSENIeEZyMUVQWHZ5eXdJVEpNeEFMcHhv?=
 =?utf-8?B?Q3hxdkF2SHpaUVNaajM0cUREZ3k2SktNTnhBaFVOajVqMkJ2ckV5ZzhjNEpW?=
 =?utf-8?B?ajU5SzVaSmgzVXE5aGp3ck02TlZDODV6Um5yU3BFUDcrd1lNWWdJL2dMYWlm?=
 =?utf-8?Q?lDHuIwWzL4OqC0WiicGeTlSYJwh5gDKyJ2Z2X1EdLM=3D?=
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b900c3-1765-48c7-0014-08dc650ad613
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 09:33:59.8144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcfLRCzmH/ntPdFbMTBCuLwqDk43uY6XsZadHWxtujAVjORe5/IpJXRa4N2c43V1cv08fBmd5aY0bJD7Q4lCUrh2GuR8+1yLSQsmMByCs5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7426
X-Proofpoint-GUID: abWl3JnyZdwUrgmnPmNK73gGp-46B_O8
X-Proofpoint-ORIG-GUID: abWl3JnyZdwUrgmnPmNK73gGp-46B_O8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_09,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2404010002
 definitions=main-2404250068

On 24/04/2024 16:15, Conor Dooley wrote:
> On Wed, Apr 24, 2024 at 01:33:23PM +0000, Niko Pasaloukos wrote:
>> Adds support for the Blaize CB2 development board based on
>> BLZP1600 SoC. This consists of a Carrier-Board-2 and a SoM.
>>
>> The blaize-blzp1600.dtsi is the common part for the SoC,
>> blaize-blzp1600-som.dtsi is the common part for the SoM and
>> blaize-blzp1600-cb2.dts is the board specific file.
>>
>> 'make dtbs_check' complains about ['ti,ina3221'] and ['national,lm96163']
>> which are already upstreamed drivers with no yaml documentation.
> 
> Might not be what you want to hear, but please add yaml documentation
> for them. Rob told you to do so on v1:
> https://lore.kernel.org/all/20230412140344.GA2234522-robh@kernel.org/
> 
> That said, I went and looked. ina3221 _is_ documented in a yaml binding
> and has been since October. national,lm96163 on the other hand, you'll
> have to document if you want to use it.
> 
> Cheers,
> Conor.

Apologies Conor. It has been removed for now and I'll do it when
we will push it upstream.

Kind regards,
Niko

> 
>>
>> Co-developed-by: James Cowgill <james.cowgill@blaize.com>
>> Signed-off-by: James Cowgill <james.cowgill@blaize.com>
>> Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
>> Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
>> Co-developed-by: Neil Jones <neil.jones@blaize.com>
>> Signed-off-by: Neil Jones <neil.jones@blaize.com>
>> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
>> ---
>>  arch/arm64/boot/dts/Makefile                  |   1 +
>>  arch/arm64/boot/dts/blaize/Makefile           |   2 +
>>  .../boot/dts/blaize/blaize-blzp1600-cb2.dts   |  84 +++++++
>>  .../boot/dts/blaize/blaize-blzp1600-som.dtsi  |  23 ++
>>  .../boot/dts/blaize/blaize-blzp1600.dtsi      | 211 ++++++++++++++++++
>>  5 files changed, 321 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/blaize/Makefile
>>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
>>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
>>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>> index 30dd6347a929..601b6381ea0c 100644
>> --- a/arch/arm64/boot/dts/Makefile
>> +++ b/arch/arm64/boot/dts/Makefile
>> @@ -9,6 +9,7 @@ subdir-y += apm
>>  subdir-y += apple
>>  subdir-y += arm
>>  subdir-y += bitmain
>> +subdir-y += blaize
>>  subdir-y += broadcom
>>  subdir-y += cavium
>>  subdir-y += exynos
>> diff --git a/arch/arm64/boot/dts/blaize/Makefile b/arch/arm64/boot/dts/blaize/Makefile
>> new file mode 100644
>> index 000000000000..595e7a350300
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/blaize/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +dtb-$(CONFIG_ARCH_BLAIZE_BLZP1600) += blaize-blzp1600-cb2.dtb
>> diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts b/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
>> new file mode 100644
>> index 000000000000..0bdec7e81380
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
>> @@ -0,0 +1,84 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2023 Blaize, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "blaize-blzp1600-som.dtsi"
>> +#include <dt-bindings/net/ti-dp83867.h>
>> +
>> +/ {
>> +	model = "Blaize BLZP1600 SoM1600P CB2 Development Board";
>> +
>> +	compatible = "blaize,blzp1600-cb2", "blaize,blzp1600";
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200";
>> +	};
>> +};
>> +
>> +&i2c0 {
>> +	clock-frequency = <100000>;
>> +	status = "okay";
>> +};
>> +
>> +&i2c1 {
>> +	clock-frequency = <100000>;
>> +	status = "okay";
>> +};
>> +
>> +&i2c3 {
>> +	clock-frequency = <100000>;
>> +	status = "okay";
>> +
>> +	gpio_expander: gpio@74 {
>> +		compatible = "ti,tca9539";
>> +		reg = <0x74>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		gpio-line-names = "RSP_PIN_7",	/* GPIO_0 */
>> +				  "RSP_PIN_11",	/* GPIO_1 */
>> +				  "RSP_PIN_13",	/* GPIO_2 */
>> +				  "RSP_PIN_15",	/* GPIO_3 */
>> +				  "RSP_PIN_27",	/* GPIO_4 */
>> +				  "RSP_PIN_29",	/* GPIO_5 */
>> +				  "RSP_PIN_31",	/* GPIO_6 */
>> +				  "RSP_PIN_33",	/* GPIO_7 */
>> +				  "RSP_PIN_37",	/* GPIO_8 */
>> +				  "RSP_PIN_16",	/* GPIO_9 */
>> +				  "RSP_PIN_18",	/* GPIO_10 */
>> +				  "RSP_PIN_22",	/* GPIO_11 */
>> +				  "RSP_PIN_28",	/* GPIO_12 */
>> +				  "RSP_PIN_32",	/* GPIO_13 */
>> +				  "RSP_PIN_36",	/* GPIO_14 */
>> +				  "TP31";	/* GPIO_15 */
>> +	};
>> +
>> +	gpio_expander_m2: gpio@75 {
>> +		compatible = "ti,tca9539";
>> +		reg = <0x75>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		gpio-line-names = "M2_W_DIS1_N",	/* GPIO_0 */
>> +				  "M2_W_DIS2_N",	/* GPIO_1 */
>> +				  "M2_UART_WAKE_N",	/* GPIO_2 */
>> +				  "M2_COEX3",		/* GPIO_3 */
>> +				  "M2_COEX_RXD",	/* GPIO_4 */
>> +				  "M2_COEX_TXD",	/* GPIO_5 */
>> +				  "M2_VENDOR_PIN40",	/* GPIO_6 */
>> +				  "M2_VENDOR_PIN42",	/* GPIO_7 */
>> +				  "M2_VENDOR_PIN38",	/* GPIO_8 */
>> +				  "M2_SDIO_RST_N",	/* GPIO_9 */
>> +				  "M2_SDIO_WAKE_N",	/* GPIO_10 */
>> +				  "M2_PETN1",		/* GPIO_11 */
>> +				  "M2_PERP1",		/* GPIO_12 */
>> +				  "M2_PERN1",		/* GPIO_13 */
>> +				  "UIM_SWP",		/* GPIO_14 */
>> +				  "UART1_TO_RSP";	/* GPIO_15 */
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
>> new file mode 100644
>> index 000000000000..efac0d6b3d60
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
>> @@ -0,0 +1,23 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2023 Blaize, Inc. All rights reserved.
>> + */
>> +
>> +#include "blaize-blzp1600.dtsi"
>> +
>> +/ {
>> +	memory@1000 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x00001000 0xfffff000>;
>> +	};
>> +};
>> +
>> +/* i2c4 bus is available only on the SoM, not on the board */
>> +&i2c4 {
>> +	clock-frequency = <100000>;
>> +	status = "okay";
>> +};
>> +
>> +&uart0 {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi b/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
>> new file mode 100644
>> index 000000000000..ad1e502559d8
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
>> @@ -0,0 +1,211 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2023 Blaize, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/reset/blaize,blzp1600-reset.h>
>> +#include <dt-bindings/clock/blaize,blzp1600-clk.h>
>> +
>> +/ {
>> +	interrupt-parent = <&gic>;
>> +	#address-cells = <2>;
>> +	#size-cells = <1>;
>> +
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +
>> +		cpu0: cpu@0 {
>> +			compatible = "arm,cortex-a53";
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			reg = <0x0 0x0>;
>> +			next-level-cache = <&l2>;
>> +		};
>> +
>> +		cpu1: cpu@1 {
>> +			compatible = "arm,cortex-a53";
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			reg = <0x0 0x1>;
>> +			next-level-cache = <&l2>;
>> +		};
>> +
>> +		l2: l2-cache0 {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-unified;
>> +		};
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = /* Physical Secure PPI */
>> +			     <GIC_PPI 13 (GIC_CPU_MASK_RAW(0x3) |
>> +					  IRQ_TYPE_LEVEL_LOW)>,
>> +			     /* Physical Non-Secure PPI */
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(0x3) |
>> +					  IRQ_TYPE_LEVEL_LOW)>,
>> +			     /* Hypervisor PPI */
>> +			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(0x3) |
>> +					  IRQ_TYPE_LEVEL_LOW)>,
>> +			     /* Virtual PPI */
>> +			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(0x3) |
>> +					  IRQ_TYPE_LEVEL_LOW)>;
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-1.0", "arm,psci-0.2";
>> +		method = "smc";
>> +	};
>> +
>> +	pmu {
>> +		compatible = "arm,cortex-a53-pmu";
>> +		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-affinity = <&cpu0>, <&cpu1>;
>> +	};
>> +
>> +	sram@0 {
>> +		/*
>> +		 * On BLZP1600 there is no general purpose (non-secure) SRAM.
>> +		 * A small DDR memory space has been reserved for general use.
>> +		 */
>> +		compatible = "mmio-sram";
>> +		reg = <0x0 0x00000000 0x00001000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0 0x0 0x00000000 0x1000>;
>> +
>> +		/* SCMI reserved buffer space on DDR space */
>> +		scmi0_shm: scmi-sram@800 {
>> +			compatible = "arm,scmi-shmem";
>> +			reg = <0x800 0x80>;
>> +		};
>> +	};
>> +
>> +	firmware {
>> +		scmi {
>> +			compatible = "arm,scmi-smc";
>> +			arm,smc-id = <0x82002000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			shmem = <&scmi0_shm>;
>> +
>> +			scmi_clk: protocol@14 {
>> +				reg = <0x14>;
>> +				#clock-cells = <1>;
>> +			};
>> +
>> +			scmi_rst: protocol@16 {
>> +				reg = <0x16>;
>> +				#reset-cells = <1>;
>> +			};
>> +		};
>> +	};
>> +
>> +	soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <2>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +
>> +		gic: interrupt-controller@200410000 {
>> +			compatible = "arm,gic-400";
>> +			#interrupt-cells = <3>;
>> +			#address-cells = <0>;
>> +			interrupt-controller;
>> +			reg = <0x2 0x00410000 0x20000>,
>> +			      <0x2 0x00420000 0x20000>,
>> +			      <0x2 0x00440000 0x20000>,
>> +			      <0x2 0x00460000 0x20000>;
>> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x3) |
>> +						 IRQ_TYPE_LEVEL_LOW)>;
>> +		};
>> +
>> +		uart0: serial@2004d0000 {
>> +			compatible = "ns16550a";
>> +			reg = <0x2 0x004d0000 0x1000>;
>> +			clocks = <&scmi_clk BLZP1600_UART0_CLK>;
>> +			resets = <&scmi_rst BLZP1600_UART0_RST>;
>> +			reg-shift = <2>;
>> +			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>> +			status = "disabled";
>> +		};
>> +
>> +		uart1: serial@2004e0000 {
>> +			compatible = "ns16550a";
>> +			reg = <0x2 0x004e0000 0x1000>;
>> +			clocks = <&scmi_clk BLZP1600_UART1_CLK>;
>> +			resets = <&scmi_rst BLZP1600_UART1_RST>;
>> +			reg-shift = <2>;
>> +			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c0: i2c@2004f0000 {
>> +			compatible = "snps,designware-i2c";
>> +			reg = <0x2 0x004f0000 0x1000>;
>> +			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&scmi_clk BLZP1600_I2C0_CLK>;
>> +			resets = <&scmi_rst BLZP1600_I2C0_RST>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c1: i2c@200500000 {
>> +			compatible = "snps,designware-i2c";
>> +			reg = <0x2 0x00500000 0x1000>;
>> +			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&scmi_clk BLZP1600_I2C1_CLK>;
>> +			resets = <&scmi_rst BLZP1600_I2C1_RST>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c2: i2c@200510000 {
>> +			compatible = "snps,designware-i2c";
>> +			reg = <0x2 0x00510000 0x1000>;
>> +			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&scmi_clk BLZP1600_I2C2_CLK>;
>> +			resets = <&scmi_rst BLZP1600_I2C2_RST>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c3: i2c@200520000 {
>> +			compatible = "snps,designware-i2c";
>> +			reg = <0x2 0x00520000 0x1000>;
>> +			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&scmi_clk BLZP1600_I2C3_CLK>;
>> +			resets = <&scmi_rst BLZP1600_I2C3_RST>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c4: i2c@200530000 {
>> +			compatible = "snps,designware-i2c";
>> +			reg = <0x2 0x00530000 0x1000>;
>> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&scmi_clk BLZP1600_I2C4_CLK>;
>> +			resets = <&scmi_rst BLZP1600_I2C4_RST>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		arm_cc712: crypto@200550000 {
>> +			compatible = "arm,cryptocell-712-ree";
>> +			reg = <0x2 0x00550000 0x1000>;
>> +			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&scmi_clk 7>;
>> +		};
>> +	};
>> +};
>> -- 
>> 2.34.1
>>


