Return-Path: <linux-kernel+bounces-159855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F938B352A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2261F22222
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEF9144D24;
	Fri, 26 Apr 2024 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Kh1ykNrR";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Kh1ykNrR"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFC5142E9F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.75
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126603; cv=fail; b=QgogziLhikt8ifTO/SFoy3mouLakN3ObwD7s2YEpytmW2JaxH4Kv04XEFNOXzOyzvr4/4jHzbLXUf9z+pJSxm5taIEXoXZfwGZP77A1/dAAEWcqBoYl3bozHOMp3e+cy+PvAZTCruF0C3Crly2qBWi271o4YeYNVEhuC5LVNIcU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126603; c=relaxed/simple;
	bh=O0H8VIrEghSFsT4F8pzKMTnQdDwKTjdt7Pv06qEEeVQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fskeavYJXg5K/fUi/qXUdgr7YiKVMjUDjm7LHFQiO5FpSTdHukfr4k/OVDb7ku8neMAUFRgWSuHfnfbEoYHj5212bU71UVBtsE2AQv6HC0iKA6If7G0P9dn24iylqKnBn8LZKyqGi+SaKDa8zzV4+lKyAPqg72ATzkgJHe3cIAg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Kh1ykNrR; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Kh1ykNrR; arc=fail smtp.client-ip=40.107.13.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Hw8fqYkkCgZKli7Fr4zaLAUDGRYERNPxGbgnMqHvyLuqsxFAFEdiK2XmdXrEaoazOLbNHYeP+P+KO8xtA8D/N7sXPlZzxwZQoKtNt1me1ybSFN4G95erWEZOId58cLOIKl9CeI/J2plFqui/QxHnBFIsBnnvwg8hJ/rSJwbvuSzy2QbaBnAydqjgyQ3v/Fo/CfLes7ogQ6Gjw8wMF6orCglLjBdDQzjDHB3LCZgRP4/7IRKb+Nh5XXAU/UAeJhxzMWnXbKZlm4JzMihq0bWsgK3Cf1AING8ue5Ux8ejpCHBOsntv0LRq3aEyYVXbc3fM3pb+IrrZyHUDMF7f5v8zQQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8IIbvCY6svIzP0TkgqmF856o+jDEd+VfCncCOwkPs0=;
 b=cqeZmyeW322Zx3yULDqLbeWTy8qr+n+5K25xUkdT4X74Vy3Rkn1AmBzY59oRJdZ1fuBpCoNgjAc3s4AQ7Ho26xB++aD6+T6jbpdPGd4GpaFwEHbNDRZkdREiUDmV5Rw+ZBZJw8oPltLAT9SiL+ZQR55/2kKELC8Vkr/tIhS94J3QzedwksNVhVT7CserELhHRGlm0TfWHeQj/BkVALkcHDEZ2P9Y+xPjjz8mBo+zkF3Gidw8rKrMv1N1iLODxs2fT1wUpfGL0vomlkzuGoL7Ie94UvHsyzs3OBz435yE7PvDfbi8LiUi3Qyn0iYyEiGAQ8/0tmPkAe+187h0dCzDqQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8IIbvCY6svIzP0TkgqmF856o+jDEd+VfCncCOwkPs0=;
 b=Kh1ykNrRemE0+pgbNH9LE8UZw5u8pje0GzxhJwPj9A+kOKBWBHU9g2fjjVc0BHSVUmumk3QKGjVhWsUowpyhZEG82e1Ots6eFGsdUpgQpKvnw+DAswUOqYzk/mXOSWIOym6dV7TyGJnEHe2ebGNY0MeWsPgkgpxT10zrXbSsQrQ=
Received: from DUZPR01CA0200.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::10) by VI0PR08MB10486.eurprd08.prod.outlook.com
 (2603:10a6:800:201::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 10:16:35 +0000
Received: from DU6PEPF0000B61D.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::23) by DUZPR01CA0200.outlook.office365.com
 (2603:10a6:10:4b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Fri, 26 Apr 2024 10:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000B61D.mail.protection.outlook.com (10.167.8.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7519.19
 via Frontend Transport; Fri, 26 Apr 2024 10:16:35 +0000
Received: ("Tessian outbound ba75727f6dca:v315"); Fri, 26 Apr 2024 10:16:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 14f5a92256355168
X-CR-MTA-TID: 64aa7808
Received: from 8b112b57b501.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 347D22D7-B21A-4D36-8403-8E8116D9757D.1;
	Fri, 26 Apr 2024 10:16:28 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8b112b57b501.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 26 Apr 2024 10:16:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI3cmY12xoSl7z/fz/TJP1nWyZDJ68WC3ZorQrfiWJbhhdBiLLHkkjcduucasDyCpWSmkoYnpL/SIVqXzixlJDXQrUGOuaZcJcGLpO4pZL6aizjxWnwwme7EH5FDfR9IIvbyOvzyX4xgxRxjqvYPSGbXRqIerrwJN17U/qJ08qIU9svrstXbA0eanT9OZbkrn6QyuyUccMvl2jImAxY3ZGbEZtLoeaQpKjMZvPH8oU99YuBg/X2pOWNSTdYPKgW3cUKG2hfJzKX1sVCG+YdrxXBoVJEz1uk38sXbpI+vvgqRI6dr3K/AtoWcP/SHDCc8EBziJHS7Gx2nqM/i3I+/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8IIbvCY6svIzP0TkgqmF856o+jDEd+VfCncCOwkPs0=;
 b=YmLLGOXejNGMDGnMUzf23SaP/lYwcPSWpxbl8SD0/MSrdFO2B56f7T7fqeNDlspTU9nOiuQiJ6TtmHi8y67gAmYp5eujhJaDHON4G18EyAVxcUm2/S14yK3NhC6HhnimplwbDZbFSXp3plha85cAhPFf2FHhqTX4FrM7oGkbiwqhH84tVcL82WPioNxsRvX/CLJ8wj3IOdm5BC/4WP2BO/8Klf/RWQze0OXj94Hq6XWD84Eozn2hN2b3PIIdyOtqKZkR7LXHDSSFlG4D2chxl9rJWZnHU9xWudzSK1S3Toc1Da4A0gW/GzTzi2SxBd+F32cHJ4bXXZm+uJAAN1nM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8IIbvCY6svIzP0TkgqmF856o+jDEd+VfCncCOwkPs0=;
 b=Kh1ykNrRemE0+pgbNH9LE8UZw5u8pje0GzxhJwPj9A+kOKBWBHU9g2fjjVc0BHSVUmumk3QKGjVhWsUowpyhZEG82e1Ots6eFGsdUpgQpKvnw+DAswUOqYzk/mXOSWIOym6dV7TyGJnEHe2ebGNY0MeWsPgkgpxT10zrXbSsQrQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by AS8PR08MB9193.eurprd08.prod.outlook.com (2603:10a6:20b:57d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 10:16:25 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 10:16:25 +0000
Message-ID: <171227c2-8c19-45a0-b648-600a5e8f1150@arm.com>
Date: Fri, 26 Apr 2024 11:16:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de, nd
 <nd@arm.com>, John Stultz <jstultz@google.com>, Hongyan.Xia2@arm.com
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240426093241.GI12673@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::20) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|AS8PR08MB9193:EE_|DU6PEPF0000B61D:EE_|VI0PR08MB10486:EE_
X-MS-Office365-Filtering-Correlation-Id: f7693c68-7adc-4aad-1d52-08dc65d9f3e9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?QUpGVWROVkRsSU9XWG8wWE5taURzNGdURktiSnRRRTV3V2x1OURXTHhhUWdT?=
 =?utf-8?B?TXBmaTZYTXlrNGtXQUlPcGhLQzc5YSsyR2R3dEo5bC9iNW5ZSFhGU2lRZ3Fk?=
 =?utf-8?B?b2lHV3NrRmdPbnJPalR2TzRzaDArcE8wbk5zMXErcEs1V2NoSk80MWE0aWVF?=
 =?utf-8?B?allwcTVYUnVtbFBUOE0rWjRhQTIzUFhaOXNnOWc4ODlTMjRRR2ppRzhFK3BZ?=
 =?utf-8?B?dmRqckw4eU1tVjVubUNtakRtaFlWeFg4SWlIUVQwaFcrNzZFbWFkVUEvcEs5?=
 =?utf-8?B?QlFvQ1lza1NYRmV2TEZKa0ZaMHVzaFZjZ1MvNVhETjViSUxoNlZxazNBcDc5?=
 =?utf-8?B?TzRyZE44K244RCt3d3dqUE5RVjROUTRUWitxV1BYcS8rMGhSWkZxVTRwNG9N?=
 =?utf-8?B?MFJ6MjhEVkpsK0xwbXVnekRQUSt0UGpBSE9uelJmWHlGRHo2SE9VQmFxWWVT?=
 =?utf-8?B?UkVhRXRORGo4UksyN2ZjZVpYUmRxVWI5TUJxTFVyQ1AvckRKcGZrbGUyZ3VN?=
 =?utf-8?B?Nkp3Z0JIejdNcHIwWkI0Uno1TWFHYXFCN3RMRTFPRG1GWFRld3dMaEl4ZHF0?=
 =?utf-8?B?aDZoWFNjK09aTEsyTGJra2k4S1A3MTlqQysyWWMzY2VrV2dhUUxWSDhwZjUw?=
 =?utf-8?B?SWlRalN0UnkvWDFZRHBrVUg5cXZwUHRKUDBqOWQ2VkRvY3VzZ3pHUFEydzdI?=
 =?utf-8?B?MmFvby9taHRQNnZOUm1saDBZZzVmVmxWVk1kMHh0V0FudjF2cnZpYmRuRHJQ?=
 =?utf-8?B?YkRZclJ2RjV6bHJEbmhtZ0ExUmMrVWF5b1B1L1ZxcWs0OE16RUtjWGIwS2F2?=
 =?utf-8?B?ME4vaW1SU0t4RXlhR2duOFB6Q0hjQWdwYnZYYzBHRCt6VDY2R0VycjN1WWpE?=
 =?utf-8?B?QXJ1UkowaE5veCtZUVI2SFVCR2huNWxld0FZdk9MQnZuWkgrNHJYRk9LWDl4?=
 =?utf-8?B?MmVadEtZZjJSTzIwdEJzMjBDaXlSbEtMWVRNbDRQaXlhYmdyT0dwajBWZVF2?=
 =?utf-8?B?MHBJcVBKMDYwRUh3NGJDdGpwRE53WXFpckFkeVFVTXUzbjBmdVZXTllHbDBF?=
 =?utf-8?B?VjBDMjhGWEJKOEhMaWpzYncyMzRTTmJpb3c4cGZNRFhFTDhQV0ZaaFdqVDdQ?=
 =?utf-8?B?RGFsVlJWY1VjdG9CTlNwWjZ6TFh6bDlNOVd3QXdEeUhodHJaWjBtMDRDUjk3?=
 =?utf-8?B?d0VBSHF4cmxNOXZQb2NZb0Z2OGdWNXJGalVUTW5oRzBFekRBdGVFcmVWajBW?=
 =?utf-8?B?VC90cmNtN2l6UlM4MVlTT3JPS0t6OTNZeTlSbVZkUHE0SU56MVhPZlV0Nllr?=
 =?utf-8?B?VFFRbm9ZZjlDVUUxS0tPUEFPZXE4WXVNRFI1TXJPeG5OVWpHYWZaMFNoMnRq?=
 =?utf-8?B?YWZ0Y21ZeURqK3JvK1dnOHpId1RRWm9vbWd1MThKNFFoaDFTOWxibHZMVllx?=
 =?utf-8?B?amRIWjBrRGZHRC9zR2k0V3FSQlRXb2NkVlRWaDFHbitxaEpYWnBQS3JBSEhM?=
 =?utf-8?B?bzFtM2ttMVFZaktKTFFzc0doVnFTd1VDQkp3c2JuRzgwdmNzNXNZQzg1cXpy?=
 =?utf-8?B?UFRsbW9iZk9LdklGY2tHd3BkN1hwd295WWJBVWdaWmI3aFZVemtrQjRLWURw?=
 =?utf-8?B?c2dETHZGYnlPWHAyYU16Nk5SWlFLeG9ZVU53ZUFXWlp2bUxqNG9xOGFJaXla?=
 =?utf-8?B?ZVNQMFg5b1dPZy9nZVFEVVBTVkN0Z3RRZDZXY3JVSjc0d0QyQTVGaDBnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9193
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	28dd7764-d033-4f23-0673-08dc65d9eda4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVRyK0RLWmx2eWlFSVoxSUg5WEtnK3hBUVh5aVdsT01CUEdYRUtuektUdXFK?=
 =?utf-8?B?SW5uK2JFNjJ4Q2FFMkQwUmZ5RDhoV1U5WEdld1lHbkEwRldMNDFCYlh2RFUx?=
 =?utf-8?B?VDdqdG5OTk95bjlZNTVXUmpVMjlIdUQ1REJEVHVOeWhNc3FIcnZ0eTVadFBU?=
 =?utf-8?B?bDRuVUxoWC8yQUlHNk8zWkdhR050Um9ORlVNR0NkWHE5d0JUT25pcGxjcW9n?=
 =?utf-8?B?cDlJcGppaW9OcVlWYUJVbUFPOFhuL0EwQ2Q2RWE0QTE3L3VkT0cyV0R2MUow?=
 =?utf-8?B?cjBvNFlPNWk0T1k2MUJZcGhhT29SNGZGVGF5OGtPQjZ1RmtCS2Q4d1pRSTFn?=
 =?utf-8?B?TmZvUmdqbHhDTVE4L2tqcWUxMDlOQzdZVEtvdTk0ZVNLU25Zako0K3FjUzFR?=
 =?utf-8?B?ajduTnQxdGdZZ2d3bUxQb2RBNzlEL0hFWWxVYVlEVHhGbG5tNXBpR2NlaGM1?=
 =?utf-8?B?UVlaS29ib0d6T0ZYSURlZUh6WmQvWm5uMFdRNGFRV2M0c1FqL1dCbnlCZm8w?=
 =?utf-8?B?MjBrS3ZNNUZ6WEFKcGc0QW5mS2swck1FVm5mSm5vbW1UN3NNeFZFeFNiZ0lG?=
 =?utf-8?B?ZmVmbGQ0eUcvcEpkMlIyUHhRVHJLM0EvK05GRmNiS0ZDcjJkdllFbXNmN1Vr?=
 =?utf-8?B?aUJMK1pROG1iZE85TlF2U1FUcVlXSUlacTd0MSs4RW1xZzZhMDZoR2ZlbjNn?=
 =?utf-8?B?NldXVkJIQUwrQ25YTWQrOUhnMy9CYnNXU2tOVWxybnN5Wm4rK3BCWGpDUmdQ?=
 =?utf-8?B?TEFZbUhOekF3RVZzNkd4NGJiYmxDZUt2NVhWNDdraU0xMGFwU1lPbEdRZjhD?=
 =?utf-8?B?dUdCaHBBWkR3NGd5eDd4OSs0bGxrQzVMem5wcEZKMWplRTZiMG0xUlJFL2tS?=
 =?utf-8?B?Ylk0WVN3NFc1cHBIWUdaWlRrNmRFT0wxU0RscnY0Q1NIR1BZRWpQaDR3Mngw?=
 =?utf-8?B?M3hNMXRnNHQ3c2o0VEdLZjduNnFaRzk1THVpTzVUUE1PSm5tZHZlcDNFWExr?=
 =?utf-8?B?cUhGTERmSGFYODVQUDB4c0d5SEQ2Y2o5bnVoYlpuM0Q4di8rNW9qbVZxYnpp?=
 =?utf-8?B?U0J6elNJK01DQ1pGMDVUdXY5Y0hQWWxIUWVqOENuNjJBSXk5V0M1cVdEWXUv?=
 =?utf-8?B?ZkVoNytHcmpMUnVMWjB2L0I3RE9QSEhuUnluRnlXME4xL3Q4Nkx5Ylpsa21I?=
 =?utf-8?B?OW45NEFwemtLMzF5cFRnK0VkQnRINDZHRVhxSWRyQ1U4OG1sNmdON2xqQXhy?=
 =?utf-8?B?OU9KTlJCNVRKS0E5M0ZiMmRTYnFHVnlPcW1SKzU1UzZBYk1PcDlMbmN0azBD?=
 =?utf-8?B?eU90Z1BWcDBqUnBFQU1MNlhFK0hvUmlxci9rVUxvTTNsU0VURDJXNVZ1OTA0?=
 =?utf-8?B?R1pRSmZTWU5OWTVTWEVOTDhYd0t5bmlJTW84WUxPUDI3Tkt0VkRTelUvUUxF?=
 =?utf-8?B?a2FWd1pkdXRLKzNLdVJDOGEwVUpRdmxCSVFwTXNtcENXZG9JSXRRZ0ZVcDFr?=
 =?utf-8?B?MEE0QjdrZUtNMXJxMUIzVzc0Y3FndG1NVFIvV2N2eE9SYU56bFRKWnVYR3BC?=
 =?utf-8?B?dUFUdnhFVlYwaXFKbGxTeHNwOUt1Tm5kY3NsT2IrZ1phY0h0T3RyTElDZ2tu?=
 =?utf-8?B?K05MMFFrSjVBcW5mOHVZd2lLZU5tTDZGZVNrS1BkZ1dIMDNXcWRLL0lSWU9o?=
 =?utf-8?B?UG9CYWY1K2g1UVYyKzZueU92RUlKcGw4eDV5TjBkK2hVb2dXdEVXbUE3dkEy?=
 =?utf-8?B?YU1uQUwrY0NFNnJoTmRrek5lM2ZaK01rLzgySDRMNUk0TWNOcmdBL0hEcjlN?=
 =?utf-8?B?QVBhMEdMWU5XOHBlbnJENVVodEkycWZ4Nk9ISkRudzZ3WEhVMUI4ekZkWmZ2?=
 =?utf-8?Q?EnJWXx5/Ls3gG?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 10:16:35.3748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7693c68-7adc-4aad-1d52-08dc65d9f3e9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10486

On 4/26/24 10:32, Peter Zijlstra wrote:
> On Thu, Apr 25, 2024 at 01:49:49PM +0200, Peter Zijlstra wrote:
>> On Thu, Apr 25, 2024 at 12:42:20PM +0200, Peter Zijlstra wrote:
>>
>>>> I wonder if the delayed dequeue logic is having an unwanted effect on the calculation of
>>>> utilization/load of the runqueue and, as a consequence, we're scheduling things to run on
>>>> higher OPP's in the big cores, leading to poor decisions for energy efficiency.
>>>
>>> Notably util_est_update() gets delayed. Given we don't actually do an
>>> enqueue when a delayed task gets woken, it didn't seem to make sense to
>>> update that sooner.
>>
>> The PELT runnable values will be inflated because of delayed dequeue.
>> cpu_util() uses those in the @boost case, and as such this can indeed
>> affect things.
>>
>> This can also slightly affect the cgroup case, but since the delay goes
>> away as contention goes away, and the cgroup case must already assume
>> worst case overlap, this seems limited.
>>
>> /me goes ponder things moar.
> 
> First order approximation of a fix would be something like the totally
> untested below I suppose...


Thanks Peter. Let me give it a try and I'll report back.

> 
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cfd1fd188d29..f3f70b5adca0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5391,6 +5391,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  			if (cfs_rq->next == se)
>  				cfs_rq->next = NULL;
>  			se->sched_delayed = 1;
> +			update_load_avg(cfs_rq, se, 0);
>  			return false;
>  		}
>  	}
> @@ -6817,6 +6818,7 @@ requeue_delayed_entity(struct sched_entity *se)
>  	}
>  
>  	se->sched_delayed = 0;
> +	update_load_avg(qcfs_rq, se, 0);
>  }
>  
>  /*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d07a3b98f1fb..d16529613123 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -810,6 +810,9 @@ static inline void se_update_runnable(struct sched_entity *se)
>  
>  static inline long se_runnable(struct sched_entity *se)
>  {
> +	if (se->sched_delayed)
> +		return false;
> +
>  	if (entity_is_task(se))
>  		return !!se->on_rq;
>  	else
> @@ -823,6 +826,9 @@ static inline void se_update_runnable(struct sched_entity *se) {}
>  
>  static inline long se_runnable(struct sched_entity *se)
>  {
> +	if (se->sched_delayed)
> +		return false;
> +
>  	return !!se->on_rq;
>  }
>  #endif


