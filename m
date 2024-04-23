Return-Path: <linux-kernel+bounces-154458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF97E8ADC47
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C8B1F21C73
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427321BDDB;
	Tue, 23 Apr 2024 03:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CWWLJ1Ql";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FRvnL9SR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2C51B952;
	Tue, 23 Apr 2024 03:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842861; cv=fail; b=QQpDYNopBr9D6RPkPUo4N/wsNSgrDy4mwjlGxwsDFuMnR7s+XuRRBD8M4SwlP9s7IqgWO5xty46YNEr3YhEx3sUTVXL1IBYfeRGg3crFy7z7YWsse5bD04UaIdmpTZlfT3tPpeR8YMeO1LQw/S+p+EnN1SDj9CUQYGsrOKeCPlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842861; c=relaxed/simple;
	bh=1LMehHutUEYut8GKyRvkNjtV4y3oHdGuu2eE+TxxZkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cpk9Q1A2eE/iMr5Yr5afpHn0f/0RNLyoZhl3ZkYVj1ZOiHIxbHnLSILlJOn4NZfinCWkhpHRFlo4JGVVnBZVng1/oMz+iVRst929KqjH1s4AyiiCRvC3ncvE6pjHwhBNw9pnPVBcdmkYIF6IpZZUbHoXi2u+psjmXgFGUyHGiyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CWWLJ1Ql; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FRvnL9SR; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713842859; x=1745378859;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1LMehHutUEYut8GKyRvkNjtV4y3oHdGuu2eE+TxxZkc=;
  b=CWWLJ1QlJEPnqAgmJotj2FPCJj4XFRb5pG9YvYmw2oqIkBtRjb2bGs6w
   lmLCkaIumkOxjRLNbX3tnnufqSqLu2IbyiHIClUJa7G8HAGg4qqWpU5Jg
   3hh5jZfoA2DDJ5VwaAzAfQjL9c83qEe2edspM+LKxP1f7EeaEMa/HQFBy
   4P3ZvTGtQGDFILSOac3CqPg07cH7TXiSiegtU7OxAzs7cou5vh9mmDwp2
   1gYaQ+GHhX0xIzzyjDptv+edlK8wrfsA4Rhh6+EqE8tj5hGK1uWG3FZ0Z
   lhAtxKkzfaSbyOR9swF4MjX0BxjmGxDH9t4EgYTTcRiNmkJTyaEJFPYdU
   w==;
X-CSE-ConnectionGUID: yNbkMpp7RkewEl5I62fk9g==
X-CSE-MsgGUID: UtZptR/lQmK5IyxHIx5xyQ==
X-IronPort-AV: E=Sophos;i="6.07,222,1708412400"; 
   d="scan'208";a="253023608"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2024 20:27:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 20:27:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 20:27:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHzeRgrfK9BnsWAeKiTkZPVG3AKUImB2zthZ1rR+dfXusX0/IaaJnBUG9OAw/R/9oEH10ox/vjQ8d1/uKT0IQBWQ2j/PSu0vku5aoiBtHY1Wq4CKiWlmYMOjZVbtAtGYKTzfUjpleNQuWSiSTiT2Ioes4JGX0ge2MyxJmIkGHm2XnlUPohuhSZoEd/0VRvxT+k5RKz0oC1RURSF2CSkUKC/mUP9Jik2mHvhOrasqQNWIcxuWAEfYXQC+qEG9keZnwWY7zQe5MKW/dQurYrezDEaUs79C/I4loKZ4Vt4F/Msr8j8KoaI93If7Kl39zjHjDkUHSh3vTmuCClgDXzamiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LMehHutUEYut8GKyRvkNjtV4y3oHdGuu2eE+TxxZkc=;
 b=l9S8ATMFfVfrlSZfavykQT/vvNqdtYXkIXNAjRr89kx+kz7uPqN6MPxfW4I7limF3zmchQDw2j1cdubpqIw1RLw2+ruaJ4BVVlKT1DQ7SuApadzxqe3KivyFjDhCUlm+nvi/fu3IuIkG/jsVZcmB5MycHAp8obyE2c+5AsiLhGtcL/lMwVNBJB5mkeQHLVO1fZuCrCYwMooRstQUyhw19nN3UBOoNAgNHY2C6U3I6J+VZM4fiz/gOLatKk/X3oNSbYAXAnXaE5lFp4UYUlBJeTTI9ZuV+t0dljNYl+1AqSgsRt6/sdAx/IizaNND34r4s2RdUrOUGVBg4p3DuEn5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LMehHutUEYut8GKyRvkNjtV4y3oHdGuu2eE+TxxZkc=;
 b=FRvnL9SRuk8rOpCb26Xm9RssB8NzAJ/O9UVzdfS8EqjFmdlU1yxwxqoxd7xmTrARTxNjfsu7ALBBtSG64wwIITO7rNGgXNSANk6hbXd//VZ+LA614NoCVfB9ezpZinWE57om0CBTpA4+QH/pVF2aOUA15jOfo3KEK87hxrsMpmzpfYWvehpIwi2kEPJPT9072BQB9Sv3z7HDw7xVosiGWLz3DTYbhUA22rXMyyYDqvKptB5x4nBGRon22ouEZ/tsrM7SrqXNCq49BNSFymHMGJj1QUPBFEUG3X+JN0cmt8q8toSTcO+YBIKzHDus0/KA2RgdKk7j5Dh9ntQUdso3Fg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DS0PR11MB7651.namprd11.prod.outlook.com (2603:10b6:8:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Tue, 23 Apr
 2024 03:27:19 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.018; Tue, 23 Apr 2024
 03:27:19 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <conor@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v4 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Index: AQHakZA01VegT/3r7Uq03tjnEIunvbFuKi4AgAWFvoCAAMadgIAAwrmA
Date: Tue, 23 Apr 2024 03:27:19 +0000
Message-ID: <677b2ac8-189f-41bc-802b-38310b801838@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-13-Parthiban.Veerasooran@microchip.com>
 <20240418-hypnosis-oblong-028c107e6c3f@spud>
 <a2c2d5ae-f709-42bf-9b60-c4428da4197d@microchip.com>
 <20240422-duty-skedaddle-37e21a76f3f2@spud>
In-Reply-To: <20240422-duty-skedaddle-37e21a76f3f2@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DS0PR11MB7651:EE_
x-ms-office365-filtering-correlation-id: 5df5bfa3-3844-4d54-f714-08dc6345483a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UXp3NW11OTMwdGVlS0c5OW5kWk5ibVM3MHpZWjVsYmJmRVlhRWV4c0k0QU5X?=
 =?utf-8?B?YU90K2xBY0lrS2huNGhYeVVTOHlWei9scUZROTB3SkZtSUsrcHh6YjVhZFFk?=
 =?utf-8?B?N0xlM0tJWE85MEpFKzh3dHlyRDUyZ3VPcnFrOVFlNmthR0ZuYnpJVnhMK245?=
 =?utf-8?B?RkpiVU5iYWdPbWtIT1hLWUUvNUhsNXhxOFZSV2NZQ3ZFSGh3YU1TbnJjWnZu?=
 =?utf-8?B?RWY0SFpCaklqczJjWWMzNmM2T0FVSHdkcnVUenV5V0hXYzV1TkNockZwekNi?=
 =?utf-8?B?b1o4ZDltTjJMZjNsdEV6SS84bnBXU2FLTmp0UVZlcUFSbkZ2VVJ2YmZLVkN6?=
 =?utf-8?B?Y3NManQzY1VEcWNMcmVRWkV0UkVUdFFzZkk0ZEtmTkVCN2RYSjVEcjR0b0hy?=
 =?utf-8?B?YU8xdTVuR2xWSzJjVkU4N3Z3NHpkQ05OQkhlb05LcmM5ZnJRaGZnVDM1djVz?=
 =?utf-8?B?UXVBZ2c1c1lYV1ZPYmNqWms4MzVVeEsvdHhKakdKZkRyY2t1SllqNGtaK0Rq?=
 =?utf-8?B?T3ZrNFV4QngvTU8zRGpRNEg0VHRCaVNCdFVYU1FjQ1NoUzFHdk0yV3lrZDlR?=
 =?utf-8?B?NzNaNmRuVXNTNkpmVG5VcTRvYzNyS3FZeEhYSHNzSlo1OW9HZFc2N3VEbzVr?=
 =?utf-8?B?VDlHSCs4YTZvYm5mOGdTOWFNamVtL0F5K2JuWVV4TFh0QlRndXFmOHd1WTdR?=
 =?utf-8?B?RVZOTWdKUjFiQnVNR2ZwZis2RnZ0cjNaWUxKaVd6ODk2MFVHYjZ0WHRmM29u?=
 =?utf-8?B?Sk91TmRqZmF1ODlGRTFhM3Fmc3M1TC8wd1RWUU04TncrVlYwVjNrMG4ySWxW?=
 =?utf-8?B?U3d6VFBBMkNReEQzTkpWZXpwWjdDWWxCQ3FSSlMvYU1NNGV6bHQ0aGhDZFl5?=
 =?utf-8?B?b2hEOFptMU10VWdnWHk0aFN2a2dIOFRiZTFMNHd2UWpZMVF2N0xrLzdZaW1N?=
 =?utf-8?B?SlQxZWl5T1NlTk9UNUVHTFlzNWZTcjdoSXFOQ21CYVdqYzRzUGxvek5lZk9I?=
 =?utf-8?B?N3hnS04xNVlhbjlYbXVzdEw3VUFKVmh1NnhIb3VZalZ1OHMzTXdKQW9XaVQ5?=
 =?utf-8?B?Y3BmNU5qU090RVUrNGhRSEhSMkFHQVlVeUtUMFNOampjVEZtbDdVSkdvSWYy?=
 =?utf-8?B?RmM0ZkVENUxBelFYWXpFcW5acDdMWHR4alo3bEQraGxYR0NjSUtoVWpTTGxi?=
 =?utf-8?B?SktINzJQZU5aNTBBTlZaRk1JaEdSSGRFMTYyRDAvaCtYRG8wcXo1dTlZMG5V?=
 =?utf-8?B?ZjZlaW1nRlNxYmZCUG5PZmptMFF4Ty80Wk1ZUzF4UlZWQi9JT3NkcG5GZlN0?=
 =?utf-8?B?cjh6UTZtNzVUSU1IdERaN0hmVVJkV3FnOXZ3MTd1blU0ayt3NkVwTm5XWlk0?=
 =?utf-8?B?ZHpxWmZ1Sjdxejh4UERsTExMcFZLeHJsWnl3WENybHZ1TDdKL2llNkFrZ3l0?=
 =?utf-8?B?Y0tLUmJJVTZFeTdqbEdWV2ExUU9LdzhLSnl3Qm50aDIrcHhUak9OMjdtNEN3?=
 =?utf-8?B?UkNhS0xvVjB0M1BkdXlyazJoK0lsZ1A0dUpkcjFxekY2QzNXOTdYZDRDQ0gx?=
 =?utf-8?B?Z3VZVG5JMnV4RFEvRnZQTll6UkpzL0hoOUFyMitkbndWMmlaTkJ1M1RXa1hk?=
 =?utf-8?B?RzBsZ1BzSVlQN1EyY3I5M1ArQlgrbVVGVXVwYVcxK0pRTXpPam9KMzVpWUZ3?=
 =?utf-8?B?WjdjS3VpVThWNGc3WUpOdDd6enY0TjEwdDJGQmIxTFpQcEFOejV1MElhTGFH?=
 =?utf-8?B?VUlqakIzTWdiei9CYmg1WUMyUWcwdkFUVEFxdXBxZFRBQnJxSk5FeFZWVWJT?=
 =?utf-8?B?MWlIS0hXUG9wUWxiNWdKdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm5PdXA5YWRmcWRkWHFNSVgwb202WlMzeU1oZmx4ZE02ZkxwZUJTUmZVN3Jk?=
 =?utf-8?B?YjdzZTZ1MGo4ODA0Y3dyWkM3VVpnQ1Vqc2ZEOWMrOGw0dWI0ZG5mZXlta0Iy?=
 =?utf-8?B?TWtDaDNOU2hqWkFrZC9nOHNnTEgwakkzNk8rS29NcjF6Y0ljdldHZmFqb3FR?=
 =?utf-8?B?K1lCRlUydWFNNzAzN1p4N0l1QXRuWHFFL0swd2crakZDQjhQaGx2d3htaCtM?=
 =?utf-8?B?a2QrcEdwUWtqOVBPNlpRNDdiWHRaMUtSTmlVa0xGandTTEN6M1R1VjlZU2lp?=
 =?utf-8?B?U05zYmVFdkdrQUc0bjhraWw4MHFsd3BFd2sxVXJMWFFreUNoNjMwY1IrRWdy?=
 =?utf-8?B?UHJLaVkyeWZkWjB6bktnZmRxcFRNQU0yM2NsUFQ2SVFOdUNqU1hkN1I5SW82?=
 =?utf-8?B?dGZYSEVJT1FaK1FkWjZtNFFGV3ByRm90bzIxZ3FaRTZaeDJUSjhybGZzRVYz?=
 =?utf-8?B?VkJrd0ZrUlc5aW55K0p0UmpwdXlmNFJvTERDaGhYbUUraFRFSjFPZloxSVlI?=
 =?utf-8?B?MlgvT3ZQMDdxZm5GdjdLWkJGd3JEVEFkM3ZKMERSWnZWY1lpaWFuNWJXYTht?=
 =?utf-8?B?RmFmVkx4SDZVUEtkdUhINDFkMitKL091TDM1TDdhR3I0eDM1c1hBZkhSUms4?=
 =?utf-8?B?ZERCK2tOMjhMTUNjR1pnQ2VvbU9aQ3VyeVZoT2pVeUFvaytCNkVla2FWbmZQ?=
 =?utf-8?B?SkNRZmt2cjhLcUhmQzdJZVd3TWk5YmhRTjkxUU5TZ2lKVXZNaU8vVlNKUFd5?=
 =?utf-8?B?aUhraFEzWHZrdTVzZnBsOW5nU3FtV0FXajFwQThpMFZraHBYbVJoMWU0c2ti?=
 =?utf-8?B?VkFWRGdKREJ3UnluazNKMlc0ZlppdDFuZkdiRWZNQ3o0YW9CTWVkS0xUOFZY?=
 =?utf-8?B?bEFPMWZPeFRyRU5aZlA2OUl1ZTZ0QlF1NmlEQlpVcHIzT1RDMWhhWFRqZHgv?=
 =?utf-8?B?ZVZjK2sycGxnMCt2Sm1OeVk1alhrdFQ5SEZ1aFo2ZllsSHRzUUFoWFhpOE5m?=
 =?utf-8?B?Z3ZNN3dneTJaU2tnQXNMMklGcjRYM2hhM1N4VWh5SFQyZmtGU2p6Tkxrajkw?=
 =?utf-8?B?UHcrMXBTenhKL3l6NFJhSVVjcmgxVDBoZC93ZUhMOHB0SkIrTlhEM21UQUFS?=
 =?utf-8?B?S3MyQWJSeUNHTE1Falo2UDNiYloxbHE4Z28yMUV2dlRia0EzWUJud3IwcVQz?=
 =?utf-8?B?QTA2U2haOFJTSytHOCtaRlpzYW9GMncxLzdKRDJyWEpLRHRHc2NGTXZFS25Q?=
 =?utf-8?B?emVKWkFUNUZuN2ZQc2tvclhXL0RFYTlDVW9FbnpER3dxUk4vS3hzclEzMkNj?=
 =?utf-8?B?U1E1MGsyOC9PTjdaU0VqaC9ZNGNTOVRxNWlnTmdwT2QzWDVGZTg0TEVNQUpi?=
 =?utf-8?B?ZkdLK0hXVTd2a24rdUFrL09WK042Ryt2NG85bmdGUUxtTktLQlFMWUo4WGh0?=
 =?utf-8?B?eHRQRTVDY3hQbWwvNzZGengrZ1NtTzloTXFaWWdNNnJaa2xEc21qK1p6TUJY?=
 =?utf-8?B?enJLYmRRNHRpRUNNV3UxbzN0MUR2OXdoMUd2cC9hU2swWUxRTUQrNEUvQk81?=
 =?utf-8?B?VWF2M2VVOFdaVkNITVo0bjROVTJvdE9rYm1iS3ZvV1czamZUM29jMjliRkU0?=
 =?utf-8?B?eXdDSU5UUURZd01lUEZ4YUtIM3A5RnVXaHZHRmdSMTNUWUZKVzdqYmtlalRu?=
 =?utf-8?B?bGJZK0VSZjJPay9XRndvRU9wRjRiQ1VZRi9ybkNiRHJpdGM3ZWhTbEtUTG9q?=
 =?utf-8?B?aDZnOUtSOTZEU0tMc3Q2WTNGR09rcU9rZUoxRWpZUTlIb3FZRTUxZzIwbGR4?=
 =?utf-8?B?amNlSW9kbTc1Sjg2VDR1SDZOMmNpQVdsdHNZSmFyR1ZnRVFrM2w0ZzZMbW5Y?=
 =?utf-8?B?MmZyTU1PNmdINm9NOFIzUHl4UktYQU9JbVZWd0xrVWdnOGlvdkhXL215N2Z2?=
 =?utf-8?B?cGkybWNpT0pGZi9FenhMdlpFWkk5c3NrYXFUWURyODliallEaStYQnE5dmNV?=
 =?utf-8?B?TjNGYkk5ckFwSW80aVVnWUVZRGthSSs1Q1Zta1Z6MWQxYVRYanlYRjFqdU01?=
 =?utf-8?B?UkFlcXJlKzRKRk9HYmFVdmsyMU1uOHZkZnMrejdqU3BUamhOby9MdFRMR1V4?=
 =?utf-8?B?TUEvUXA0azZ4YmFUOTltRXJGdHRwUjJsY080VFFOMzc0VWROR2dSZFpOUHFZ?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44CB3D662B0AF743AE2A79DAC6C59C42@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df5bfa3-3844-4d54-f714-08dc6345483a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 03:27:19.5442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VaZUmdFwy/5+VNJYkHpgSnb2g6qaeF1Kx4ofQgZ3Caf4Cf24YFw21J63zqSKil7iLTAwlr4p1XmPp4uHouNfUrrsdKx7K4lny3jQ3yRfHiXjTM5sHeXkKDblUTJyQQJw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7651

SGkgQ29ub3IsDQoNCk9uIDIyLzA0LzI0IDk6MjAgcG0sIENvbm9yIERvb2xleSB3cm90ZToNCj4g
T24gTW9uLCBBcHIgMjIsIDIwMjQgYXQgMDM6NTk6MzFBTSArMDAwMCxQYXJ0aGliYW4uVmVlcmFz
b29yYW5AbWljcm9jaGlwLmNvbSAgd3JvdGU6DQo+PiBPSy4gSWYgeW91IGFncmVlIHdpdGggdGhl
IGFib3ZlIGNoYW5nZXMgdGhhdCB5b3UgZXhwZWN0ZWQgdGhlbiBJIHdpbGwNCj4+IGFkZCB0aGUg
dGFnIGluIHRoZSBuZXh0IHZlcnNpb24gd2l0aCB0aGUgcHJvcG9zZWQgY2hhbmdlcy4NCj4geWUs
IHRoZXkgc2VlbSBnb29kLCB5b3UgY2FuIHJldGFpbiBpdC4NCk9LLiBUaGFua3MgZm9yIHRoZSBj
b25maXJtYXRpb24uDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo=

