Return-Path: <linux-kernel+bounces-95070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E233D8748E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BFE1C21BCD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5764863131;
	Thu,  7 Mar 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tckWg+W8";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vgnzBs4F"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0491629EE;
	Thu,  7 Mar 2024 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709797208; cv=fail; b=E5Gt0LrtldVWW+kCgtGFNDR1SMLscimBmVRMcsFys+Ukv1H5xHSJ0CLOywLyhKBc9fl+6r1WjuQTpdJ7MV1+CxvlE2OQrdDvH7grHgYDZF+uRszAZiWm8cKyqdYmPJht+5DQVmlhj/b8ILsDCF/SMi5qJuxqqsIS6HG8tf43z9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709797208; c=relaxed/simple;
	bh=CAeZvuY4trbMUgtnH+MgN6JAX4T0YINU0/ZHqxEeAmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LANvSv0J0gX1vbhkNqATxSnK5EVNYWLo6Rm0jwE/TffEuDp4THH9G2ezNMlIkxp9le7mFK02Xz+2Mjq3Nka3bGFussCkLhXpy2jGRWtUFb33/ujZwb4SKsEG/yZbPROLJBoGz0LaWgIXg49/Bo4EC/MW7RNllDDWh1/ywqBtse0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tckWg+W8; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vgnzBs4F; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709797206; x=1741333206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CAeZvuY4trbMUgtnH+MgN6JAX4T0YINU0/ZHqxEeAmI=;
  b=tckWg+W852rcWdY5mJXAwQHvK+vBbPBnzaO0gXqB6fYL/ECdoNp4oQGE
   rBwerf95Bx8uYqaENMzABJshuTzTJQeL9Bd9BiXxzM/+RddiD8t/nZAbw
   FZxnjCGMlTpww65nibgIE1LafGh0kf2odSTULY/EJssaXQeQ+2FHkBQBY
   wHrhtW3LFpjvjPv19ycl8Q7E6k3ZuMS7tpx/QWYqH+cWNTyg3S4AxASsw
   nQDkg2F+cVS0tPN3NSEXUqw59uCRJMzI22yiv6jSlg3z1S7eazxjGbVQ+
   c7AsqCChQPsCTjfR8NjXzHEYRiD1tnjVY+GfewSYhtUggzq577U+Ld4U0
   w==;
X-CSE-ConnectionGUID: Jmgys8F7R7mC6zUvpZYwUA==
X-CSE-MsgGUID: r966WzXPSuuTRRGmru5Cpw==
X-IronPort-AV: E=Sophos;i="6.06,210,1705388400"; 
   d="scan'208";a="17335610"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2024 00:40:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 00:39:46 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 00:39:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql2ZcjlBRbb6dtou8xeQjTGxcowCpUXOfJquufA94A72m53hlhDe861T5GEAQSAKzs/ZuRrOQIeqlekra4WHVtzSMgs4n5JjR7l+TsBsjyGs3tKM5YV6VJapcnKrUNDpzgRhGYX3Qbm4U0Jg32ehTgzFivIj01eVoTKGhxXOPsQDxqdU6FbviEPg0j6oFMBZMMNxc6dF5SrI5asFV+y8Ml2cch7XcQnjfpvY0zzC+/+ycZN7cYTyx8LkSMgzNOoS+vwayNqONLP0odtxIktCxQWqt5NEmnp+8vFlInAME1AKCRqSjVX5KZhCQb7gUT8wld3lW9FKf/48dM98z6Qbdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAeZvuY4trbMUgtnH+MgN6JAX4T0YINU0/ZHqxEeAmI=;
 b=J5oX1W7ySVAwvf81H/pB12MW9Zu9alCGmYJnjwidXxQ9up3VO1JCnDxMcIy9GoX9yMxVACj67AT3iMZyc7si8FlSByTfiYcNqZuMNxY2ks2bV1jZq7Rw7SA01dAQ68ecZNfJUf63p/6Cojd9JdnJZPYuB63jNKtQ9Z4orxPtT2DjAA14/OKPTnMSoKgcudECEv+8LHa9jwQHyHBiDXJvZh+t5ZSvHeaffnM+m5l86faZZrrDkFfJN8c3qiGWddSXg2Yl20PxCK8W+1vE9X+Qhc7Rp1398kJOOCE73g19yhXzOj+sJ2qzAe2O2quHaf5057Jnlle2GQsVGOqq9taYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAeZvuY4trbMUgtnH+MgN6JAX4T0YINU0/ZHqxEeAmI=;
 b=vgnzBs4FZ16qeB2fzbDL21+ce74VV4cGkp67ja7q6od4AayWLphzSLJASGvbx2hSsu8HV5kIAlEYA6b+W3DxWqz0Pra1CU4ytN5GKHQyr77kQM+7zlR22RusEnf0V/NURg+tsai9REAzoe7ao9FgmvZVkkHa0eLZpM402ij+dXHYu51cIRWlJHkptwqdbcqTbA+s0dpEu1133lelqQMvjqylNgRLLbvrsRXLmz3B17ETxa4d360valSmnNqtSnHm45jAKtuUl6B5p8Jsst3HlfAcp4Oc3BWMkBTs61NCCtmlogOOotDqoNIhegnl0fodS49kGqgUsBi4FE4ID+cCVw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH7PR11MB8123.namprd11.prod.outlook.com (2603:10b6:510:236::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Thu, 7 Mar
 2024 07:39:44 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 07:39:44 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v3 04/12] net: ethernet: oa_tc6: implement
 software reset
Thread-Topic: [PATCH net-next v3 04/12] net: ethernet: oa_tc6: implement
 software reset
Thread-Index: AQHab6OCD00I709j00WIKaDUtsZwCbErb26AgAB2hAA=
Date: Thu, 7 Mar 2024 07:39:44 +0000
Message-ID: <bff71d0b-49d0-4a4c-98c1-7df7056c4268@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-5-Parthiban.Veerasooran@microchip.com>
 <4e56f5c2-3d5c-4dda-8a37-01c1dbce27d7@lunn.ch>
In-Reply-To: <4e56f5c2-3d5c-4dda-8a37-01c1dbce27d7@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH7PR11MB8123:EE_
x-ms-office365-filtering-correlation-id: a0359aae-c5dc-4af1-9bc4-08dc3e79c1d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FWpig/NpS+QmXgz4uVy1ylaYwcPQh9PAbr6Ij3C4SfIr40OYc1Cyd7pQc/XvgqJ1mWgE233+rePsA5C+SKWl5ipoBbljI04ARW7dY43yhaB9sgMxCcdMvuYxGft92zc2OB1ui22Mu3uEShyM9PiL8Dxkx58oO3JnT6dT28Mo3XHK0UQdcJhFBlJDt5k7xtK/ttoASmqwTzk3Pnl6c5p3iJYKPpuMt8FhiU7O7mGBwMwBvg3EKbghjOu1ZdpMVFic38VhwXW2GRUiD3SsvrXTExcOKbE+eU7P5XVR/ihsgCfvhUydC5TISKeLk/2v2UriRTKfV2nM6uD6mOT1ttXQM/xgeAicelSdZ0Y4sEC9lFh8bxyGuTDDhndxCR3UN1yhE+i/UKaQTNsTV5A09RkM3vdTZPNS85lBKU4K8/AIll8v4o8p14rVhsDJIxY37EUrUTyw8B3wuOTA/c4ndk5w1D/TqASt8MCxQili6GHkB/GOn6MenfbumxJYHCCWcrtc1M3W/KRLSQBPxAO1bPhq7T6mvFZ8vPD4sCnIHcOkX64unZ6GJj9mNRV4+QWOHnPXJoW8Tl3e2OwPDNVnBP9pGJtMkIA74o/6ak4dytlgkhrL1lOzRbUlj6KDg8SlgrCNXkEWZWv0MklwRvnYsQB3uapmuxQGA9ALyMgK8x7+V8wM19vl6uaYDHKTeOcLLEWQSETgsElddoCyaYaIGudnUdUzZcAH0BjOE9/+LQ/9aVU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWdOTnI3TlpobDBKekZzZVg3ZXJ1bTdNamk5dTBMVEU5d3hNdG5iSGFrWW9P?=
 =?utf-8?B?cERlK3NsVFMxM0x1L0tLREowaWU4ajVmUU9xNmxrWU05TERjcE5EcWF2TUEv?=
 =?utf-8?B?U1pNNWFWMUV3dStWT1BmOEkxVmZJbDFPWmFrRkFRWmY1VkVCalNEbG5NZ2tH?=
 =?utf-8?B?WDFHb1BrREhvSGJ1bnI4OWZXTXNaaDZpeU9YM1FFd05iMG1IYS81dTdWMkhw?=
 =?utf-8?B?SmQyckRDUWdoUjlxSW44cWhhTFN6YjgwL3F3VUUwdTJybW9FTTR0NTUxQllq?=
 =?utf-8?B?ZEpTWUxCR0NXWVdtSitqUlp2MVJIZFovNVJMV0liaCtMNWtmV2V0dytFMjRS?=
 =?utf-8?B?S2tsWVVHR1NtN1krYkJKQ3BJNXBaNjNpUk5QSFlmWkU4MFEzSHFqTFc4Rmg0?=
 =?utf-8?B?SmpWWmcxQVdWUVAraG1vS01nZStRa1pUTGl2UlpsN0c3cXJoazNBOENCYkJF?=
 =?utf-8?B?KzNZZlVWSEttekl1TjR4QVFub3NDTzdzZUdla2I3TU1TYWhKRlRXQ21sVlo2?=
 =?utf-8?B?SzFrcjNIRHBZWlltNFRUcWliUUpVRFdkQ09tRFRPZy9MV2tKKzlRemI4L3dG?=
 =?utf-8?B?MzMvY3RERTdrUkgxWERDbGJoSWxtbEZadkN4d2JjUWdzTnFLOW5USFZROCs3?=
 =?utf-8?B?ajZLRXFxL2JZcTI1ekZzaUwzcHRYaTB0Y1ppMmxTWjE0MWxib2lXemFzMkNx?=
 =?utf-8?B?TGJGUkdQd1l1QnNBSDlPN01OeFhjK09TbjlITU5XMy9Za2dGU2JVdWVOcDgy?=
 =?utf-8?B?WjduV09ZSXhvdkV0dkN1b1U2dnVHTGNQcE5VRm9Ta3pLdlZUaUVBSjRLOHQ4?=
 =?utf-8?B?YTZWb2xNa2EzcFFxTDV0Qm5rSjhPWDF0d1VRL0dWV1prR0ZKUjdvc1JqK2dX?=
 =?utf-8?B?NXFJSWZUSSt4dGhNU0tSemJjV1hRc01tYUZTWDk0TVQ3czE3dEE1S3huRlFV?=
 =?utf-8?B?NzlQOWhQZEM4cnFXZWxpRXdXTW1aVXJrN1NWRnA0WEFPSFBJQkV2N0Fhdk9l?=
 =?utf-8?B?Rlk4Um1kbHg4QTFodUV0OTE0K1BtOHdVRDd4VUQ5RjJUcFM0UlJJc1FKRm9h?=
 =?utf-8?B?SE5LcWV2ZDJSeC9SMTR2ZGpaMW5vQUxJaUV0a2lKSitpRWF5Y1FOSEN1KzZN?=
 =?utf-8?B?TktqS1Y2U1NpWVRjeHhMWTJmQXhXdGtRQ3phaGZodEpRRkZVU2IwMVB3M3Yx?=
 =?utf-8?B?RXhaRWFBYTlhOXB2UGpGR1BURnlDcHdxbUlobkhadFVtZklpOEY4c3NXalNo?=
 =?utf-8?B?Z0oyTFlNM0xlWWdDbW1DQmFLNjNXVjB4TGNNZllzWE1iT0FzczdHbWo3UnBw?=
 =?utf-8?B?STc4cWhPRERyaGdpWUU5b00xRkI1RFNUckxYcmF3TkpGMTAvNWFZak5DbDRT?=
 =?utf-8?B?NUE4UFhPTC83REc0YmJ1dmloWm1YUEhKT3dWN1k4c1Ezc2JJaWRkd3hKdjZP?=
 =?utf-8?B?UlY4bkc2YjhUVk5OTjdvS2xVSnlFKzVNWVZ2NmgyaDBqN2k3NVFtN2wva3Vp?=
 =?utf-8?B?cVR5cFVaWXhUZkl1ekRnbnRDNWsyQnl0UVVnbHE5ellCc1F1NWUrQ0g4UExF?=
 =?utf-8?B?YXZ3akpOU0tFTjd3UGdCQmJ0bmIxSkRSTHQ3RktlVlBLSGRlUEtxVG5qcDlh?=
 =?utf-8?B?c2N4d1BtU2lxREhDcVA0V0VQZFpKRzBucXFpN2orZ1UzWlRNR3MrZnhxODhL?=
 =?utf-8?B?SnJxdWxSYXM4VFBERmpvVXVTanJLVEZXWXc1OWppbTZCbkxEYkhoSkQzWlRs?=
 =?utf-8?B?RXppQ0xQRVhvd084a0dQZ2JoeTJHRDhHMkNkSUxSdlVscXlNcys5RVQzMmQ1?=
 =?utf-8?B?YXA0dFhrVWdBMmlOQkFCNWZCeE5zclFTVTNIeUxMdTB2WjNEWE9EcXJzYUdC?=
 =?utf-8?B?M1RvenVJQ1FuTXM2cWFvMnNBR2hEc2hhUlJMVkc5WHBrTDYzOFNaZVRHc056?=
 =?utf-8?B?T21ZZXMwbXJ5WStodmpyK3pxUDVmbnNOM3BNbWlVR1JOT25Jc3JOS3FQR3Fa?=
 =?utf-8?B?ZkJ5b0FBc3BlcHZ3M1BiM28yRzl0Y2hqL1VQeDhMc0JGNnl0aHQzTkdFcEJP?=
 =?utf-8?B?TjZEWVZrb295ZVllVWFUTkpxZTFianV6UUdQRHVMWlRQNkZ6S1RwWktoRXhV?=
 =?utf-8?B?VlNRVnRXa1NhWUUvOEkvZnhPaEtzMUpKZlViTjlqZHQ0UWlWSTQ3N244ZDNZ?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B10091DFE4113489D1F138CD408DA3D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0359aae-c5dc-4af1-9bc4-08dc3e79c1d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 07:39:44.2881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOBXwM3JRhZYPaiVN7suKJhRQAzEGjpZ5RcpGhuFGhs0SsyQpb/+nBFJ8xiP98E0LaTGY2pTy1pyfd4F1x+px2u+uWiTBB41nhxNzNoO4BgFw+nxfX8cPUv9cl+trSU7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8123

SGkgQW5kcmV3LA0KDQpPbiAwNy8wMy8yNCA2OjA1IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gKy8qIFN0YXR1cyBSZWdp
c3RlciAjMCAqLw0KPj4gKyNkZWZpbmUgT0FfVEM2X1JFR19TVEFUVVMwICAgICAgICAgICAgICAg
ICAgIDB4MDAwOA0KPj4gKyNkZWZpbmUgU1RBVFVTMF9SRVNFVEMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgQklUKDYpICAvKiBSZXNldCBDb21wbGV0ZSAqLw0KPj4gKw0KPj4gICAvKiBD
b250cm9sIGNvbW1hbmQgaGVhZGVyICovDQo+PiAgICNkZWZpbmUgT0FfVEM2X0NUUkxfSEVBREVS
X0RBVEFfTk9UX0NUUkwgICAgIEJJVCgzMSkNCj4+ICAgI2RlZmluZSBPQV9UQzZfQ1RSTF9IRUFE
RVJfV1JJVEUgICAgICAgICAgICAgQklUKDI5KQ0KPj4gQEAgLTI0LDYgKzM0LDggQEANCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKE9BX1RDNl9DVFJM
X01BWF9SRUdJU1RFUlMgKlwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgT0FfVEM2X0NUUkxfUkVHX1ZBTFVFX1NJWkUpICtcDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9BX1RDNl9DVFJMX0lHTk9SRURf
U0laRSkNCj4+ICsjZGVmaW5lIFNUQVRVUzBfUkVTRVRDX1BPTExfREVMQVkgICAgICAgICAgICA1
DQo+PiArI2RlZmluZSBTVEFUVVMwX1JFU0VUQ19QT0xMX1RJTUVPVVQgICAgICAgICAgMTAwDQo+
Pg0KPj4gICAvKiBJbnRlcm5hbCBzdHJ1Y3R1cmUgZm9yIE1BQy1QSFkgZHJpdmVycyAqLw0KPj4g
ICBzdHJ1Y3Qgb2FfdGM2IHsNCj4+IEBAIC0yNzksNiArMjkxLDM5IEBAIGludCBvYV90YzZfd3Jp
dGVfcmVnaXN0ZXIoc3RydWN0IG9hX3RjNiAqdGM2LCB1MzIgYWRkcmVzcywgdTMyIHZhbHVlKQ0K
Pj4gICB9DQo+PiAgIEVYUE9SVF9TWU1CT0xfR1BMKG9hX3RjNl93cml0ZV9yZWdpc3Rlcik7DQo+
Pg0KPj4gK3N0YXRpYyBpbnQgb2FfdGM2X3JlYWRfc3dfcmVzZXRfc3RhdHVzKHN0cnVjdCBvYV90
YzYgKnRjNikNCj4+ICt7DQo+PiArICAgICB1MzIgcmVndmFsOw0KPj4gKyAgICAgaW50IHJldDsN
Cj4+ICsNCj4+ICsgICAgIHJldCA9IG9hX3RjNl9yZWFkX3JlZ2lzdGVyKHRjNiwgT0FfVEM2X1JF
R19TVEFUVVMwLCAmcmVndmFsKTsNCj4+ICsgICAgIGlmIChyZXQpDQo+PiArICAgICAgICAgICAg
IHJldHVybiAwOw0KPj4gKw0KPj4gKyAgICAgcmV0dXJuIHJlZ3ZhbDsNCj4gDQo+IFRoZSBmdW5j
dGlvbiBuYW1lIGRvZXMgbm90IHJlYWxseSBmaXQgd2hhdCB0aGUgZnVuY3Rpb24gZG9lcy4gVGhl
DQo+IGZ1bmN0aW9uIHJldHVybnMgT0FfVEM2X1JFR19TVEFUVVMwLiBJIGFzc3VtZSBpdCBoYXMg
bW9yZSBiaXRzIGluIGl0DQo+IHRoYW4ganVzdCBTVEFUVVMwX1JFU0VUQy4gU28gZWl0aGVyIHRo
aXMgZnVuY3Rpb24gc2hvdWxkIGJlIGNhbGxlZA0KPiBvYV90YzZfcmVhZF9zdGF0dXMwLCBvciB5
b3Ugc2hvdWxkIG1hc2sgcmVndmFsIHdpdGggU1RBVFVTMF9SRVNFVEMsIHNvDQo+IHRoYXQgaXQg
ZG9lcyBhY3R1YWxseSByZXR1cm4gdGhlIHN3IHJlc2V0IHN0YXR1cy4NCk9rLCBhcyB3ZSBkbyB0
aGUgbWFza2luZyBpbiB0aGUgY2FsbGluZyBmdW5jdGlvbiByZWFkeF9wb2xsX3RpbWVvdXQsIGFz
IA0KeW91IHN1Z2dlc3RlZCBJIHdpbGwgY2hhbmdlIHRoZSBmdW5jdGlvbiBuYW1lIGFzIG9hX3Rj
Nl9yZWFkX3N0YXR1czAgaW4gDQp0aGUgbmV4dCB2ZXJzaW9uLg0KPiANCj4+ICtzdGF0aWMgaW50
IG9hX3RjNl9zd19yZXNldF9tYWNwaHkoc3RydWN0IG9hX3RjNiAqdGM2KQ0KPj4gK3sNCj4+ICsg
ICAgIHUzMiByZWd2YWwgPSBSRVNFVF9TV1JFU0VUOw0KPj4gKyAgICAgaW50IHJldDsNCj4+ICsN
Cj4+ICsgICAgIHJldCA9IG9hX3RjNl93cml0ZV9yZWdpc3Rlcih0YzYsIE9BX1RDNl9SRUdfUkVT
RVQsIHJlZ3ZhbCk7DQo+PiArICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4g
cmV0Ow0KPj4gKw0KPj4gKyAgICAgLyogUG9sbCBmb3Igc29mdCByZXNldCBjb21wbGV0ZSBmb3Ig
ZXZlcnkgNXVzIHVudGlsIDEwMHVzIHRpbWVvdXQgKi8NCj4gDQo+IElzIHRoaXMgMTAwdXMgZGVm
aW5lZCBpbiB0aGUgc3RhbmRhcmQ/IEl0IGlzIHByZXR0eSBzaG9ydC4gSWYgaXQgaXMNCj4gbm90
IHBhcnQgb2YgdGhlIHN0YW5kYXJkLCBtYXliZSBzZXQgaXQgdG8gc29tZXRoaW5nIG11Y2ggYmln
Z2VyPw0KTm8sIHRoZSBzdGFuZGFyZCBkb2Vzbid0IGRlZmluZSB0aGlzIGFuZCBpdCBpcyBub3Qg
cGFydCBvZiB0aGUgc3RhbmRhcmQuDQo+IA0KPiBBbHNvLCBwb2xsaW5nIGV2ZXJ5IDV1cyBpcyBw
cmV0dHkgcXVpY2suIEkgZG91YnQgbW9zdCBzeXN0ZW1zIGNhbiBldmVuDQo+IHNsZWVwIHRoYXQg
c2hvcnQgYSB0aW1lLiBTbyBtYXliZSAxbXMgYmV0d2VlbiBwb2xscywgYW5kIDEgc2Vjb25kDQo+
IGJlZm9yZSAtRVRJTUVET1VUPw0KT2ssIEkgYWdyZWUgd2l0aCB5b3VyIHByb3Bvc2FsIGFuZCB3
aWxsIGNoYW5nZSB0aGUgcG9sbCBkZWxheSBhcyAxbXMgDQp3aXRoIHRoZSBwb2xsIHRpbWVvdXQg
b2YgMSBzZWNvbmQuDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPj4gKyAgICAg
cmV0ID0gcmVhZHhfcG9sbF90aW1lb3V0KG9hX3RjNl9yZWFkX3N3X3Jlc2V0X3N0YXR1cywgdGM2
LCByZWd2YWwsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVndmFsICYgU1RB
VFVTMF9SRVNFVEMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU1RBVFVTMF9S
RVNFVENfUE9MTF9ERUxBWSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTVEFU
VVMwX1JFU0VUQ19QT0xMX1RJTUVPVVQpOw0KPj4gKyAgICAgaWYgKHJldCkNCj4+ICsgICAgICAg
ICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+PiArDQo+PiArICAgICAvKiBDbGVhciB0aGUgcmVzZXQg
Y29tcGxldGUgc3RhdHVzICovDQo+PiArICAgICByZXR1cm4gb2FfdGM2X3dyaXRlX3JlZ2lzdGVy
KHRjNiwgT0FfVEM2X1JFR19TVEFUVVMwLCByZWd2YWwpOw0KPiANCj4gICAgICAgICAgQW5kcmV3
DQo+IA0KDQo=

