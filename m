Return-Path: <linux-kernel+bounces-159539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEB58B2FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51AB41F227DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0C013A41C;
	Fri, 26 Apr 2024 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="H4DUyBpW";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nuSAhAfd"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF7763F0;
	Fri, 26 Apr 2024 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714110977; cv=fail; b=EnIZFM9TDh/j3gMqP+wjr26HvpheZpupqPjsMs7BP7URaCm568/ni3hd2KdLndSkTTTQV8ycztBY1i9DWTYSD7qyGjkmNqukj6yrLzD2/HZoI4k/PwFyy8/oDyDYF0NG1L8P+DgyarrToCq92zQlV635XGUjZucXqWzQSJ7NeWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714110977; c=relaxed/simple;
	bh=BKR5OundeA8h1qP6oA/R6718h4DF2q+cxeo+Mrv82gM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IgCDWfJ6YTNSws9b/4eTYwsh3/5BTXlUO9/4mlQCNRxop99dOYC/rvnFY3sUCEtrw1nWJN9KR9g//9KSlkgxFneq+zyPyhwHUXmp5MQzWRlg+0XbcYjPFUdbYTZGiKBlA2WLR7tspTV5WpWuYOFVNpgfGRJMuNSTB54Ci/a4VrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=H4DUyBpW; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nuSAhAfd; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714110974; x=1745646974;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BKR5OundeA8h1qP6oA/R6718h4DF2q+cxeo+Mrv82gM=;
  b=H4DUyBpWSd+dkB5YUh38cjvpCO7tI+HhMQ9ZAu4CrGhlMz9hxzY9L0pN
   3qY2wJIJE1+GSrHKznTVKPmGbUCFtgWS7AkfattvHn/lkTob3lwVzk2do
   3wN+dTyt606YNXNp1/PvhlH9m+DQBKPK+3qFhksNafyexq4eEgMzplLld
   Qo5ExtQvujaC+lTlpKpUTCw3N5nnPLq1kEZtg8EcDvZYH6+DKiR+eWyuB
   Mbln6oKwGeKIlCbvI4Si/pYvvzli3GyKJe5412i/b/7v4STN2M15Zy7Al
   RGHoaRPEKqoKee9tCgi4P2HIw3+fbWsTNSJbcypfcPrwIQ+HZ1PanAH05
   w==;
X-CSE-ConnectionGUID: E5W5f/C4SIK/optP5DzXeg==
X-CSE-MsgGUID: dfPcG2TjTtCz5o8EkhRQvA==
X-IronPort-AV: E=Sophos;i="6.07,231,1708412400"; 
   d="scan'208";a="253565800"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2024 22:56:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 22:55:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 22:55:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFlniuT38l6Sxeu0ktAuxiiPDia3PQlduxlLhaHbprZBHYBUerL0EH50cHs7MxejZZ/d9bsFj+QpmIjEG4rOnitdR4pUrbXT7IG3keC5xQCpDJRu6T/R0SPTjeLVAitHAGRZfJM/NofLqsvcdTJUdJdk7OCmB4b44xHIfmZYYNNXYnEKxHUBhuGcUvbXIzEOku8GHKUvsfndqmCv6xrf0ZyIGdIFpfrz7ES+OnG65N2JJPen5PdUE8Dqlb2G4kFjjF1OV3IshcQe7rUBclTInXqovFD4BE6NcNN9yRsORCvMIZOKOKOzYruyrdn0m7vv5YeCCscyTgD2uXfkybyKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKR5OundeA8h1qP6oA/R6718h4DF2q+cxeo+Mrv82gM=;
 b=htkskcpz+VlXjUyWLtvoyHIMxMbTZC03YFIPptf0lel6fJV6qfLjuouYal4wny6QWnCqYY8tVuqGROQsKVYRreLCwZvixbSqFNlfWbnbASZy+cY+PZQ19w6/ROPZ6ifIpzKFWnd8qjk5sU9HhT+2tsADIwQGJLWOxh0MhKik0dj+c48J+UHodeqko7ImscKndOT4wKfM96qq8ALSi6n9/IlZaydHpKaLmL71s9Ss1iQ0nDEjgmvNsLtmAYdqbIGcVDhXFBwqFDglj8JyFa+qn3i0PMfvokLK1FrnjneZvY2vXqn1Yca6l3Wl3jk480BlFc92QAmik8PRuHfn8CnDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKR5OundeA8h1qP6oA/R6718h4DF2q+cxeo+Mrv82gM=;
 b=nuSAhAfdv9p6ihuZKWJaJi+9FMu3jQqqLQAidqScPsKddLwbWrFiQLqF75k89Nl6zMq9Cn4eFr36FGEOT/92dQ2Q8fYgpjma+N/h35hEG4eFQzP8s+qMPP2G9hGoNkKWyVVoR6Rg0sS+599uBsUGn0+o9FYiiAErtxKhJWKJkBc9BYBs7dCYwjm/CapvLOtPjOhp3J744+mlXbfgGGSdKjT3R7RQmFW2BwcKcLryquWTO7uBPcF5lUrtJK1/4OjTlXy2kbVZdFIWT4xJVgAWM9jhqYj/1Un5kjHvyPSNfxLkbKRSErIuyyN2C5Ad4NWMDrDKMjXAp+/AYnBwY5XeGg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Fri, 26 Apr
 2024 05:55:45 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 05:55:45 +0000
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
Subject: Re: [PATCH net-next v4 02/12] net: ethernet: oa_tc6: implement
 register write operation
Thread-Topic: [PATCH net-next v4 02/12] net: ethernet: oa_tc6: implement
 register write operation
Thread-Index: AQHakY/7YkCkDGvlBEeB5IUYnNps7rF2hL0AgAOU/YA=
Date: Fri, 26 Apr 2024 05:55:45 +0000
Message-ID: <6277a960-7979-433d-8757-a78e5dde0c55@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-3-Parthiban.Veerasooran@microchip.com>
 <c0ffd864-f85b-4dd7-942b-f9cc2c88f678@lunn.ch>
In-Reply-To: <c0ffd864-f85b-4dd7-942b-f9cc2c88f678@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MW3PR11MB4748:EE_
x-ms-office365-filtering-correlation-id: ea6ee666-ef3e-485e-1c44-08dc65b583bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?L3ZTWDdZalUyc0MxRGx0UkRBMmdyaUZLYWF3QytQRkhWeHpRMmFRRnlPelpB?=
 =?utf-8?B?RE5JLzBOUk4rdmRERDdWbEtCWnQxbEZJbzdaSHhzNDZBOTFSQzRUcm1LT1da?=
 =?utf-8?B?dWdNdEFOOEJPRHBmeFdXeFhZYS82eHA2dFYza3F3a1UzY0VNamFPeVI1Y2hi?=
 =?utf-8?B?MFVjcUNRMWh6WmhFY2FCNk5VcjZZbDRKY0dEVS9CQTRFaGdpT2cyMzhuOHVB?=
 =?utf-8?B?ZWI4YjNaUFBSZFRrMzZXWGxZVTIwMVlwYk00UzZzZHhWK05LanAxRDVRK0RQ?=
 =?utf-8?B?bWZjNk1ka0YwVmt4dmpsWkI5ZUFKdldBVzZXelNoZnZpcklrOWljdTVWdkxp?=
 =?utf-8?B?WTBZd1ZNZHBMTnROeGN5Y2VLUXZFQTdnYjNBNDZyR1RoZERNcmJpQmsxWStI?=
 =?utf-8?B?a09SMmlYQkw3ZGxNZUlrR2s4MVdjczY0cGJwcU8wQjd5MEc4Y0JaTEFnRHhl?=
 =?utf-8?B?cHBkZXlGL0lqV1RYNDNSSGdQQ2k4VDNtd25RZlg4ZFMwRmJXYXB6clpxV2VR?=
 =?utf-8?B?SzdiTkR4TzdLam0yd3BNM3BsM2dOMmhZNzV6RkdDR2grRDBWR1hKeXJhU0ow?=
 =?utf-8?B?U2dmejk2eFBWYnRONHNYR2hJQW0wOUtNZmYwTGUwa3ptMW1JOVNNelVLYXRx?=
 =?utf-8?B?VnFLcFE5bG5UUHA2U2EzRk94Yy9oWFdmcVVSUE1vNmNSRXNFeThCdzNzcThY?=
 =?utf-8?B?aW5FZVpIK3R6c2hGZlE1ZklIQXZrWDhjQ2tDcVF3em55QkRlTEFhUHBoTjlo?=
 =?utf-8?B?cGVhWVR5OFl4bGJKUm9uOEYzNkFGbTlsZ2FMVDJGN2pDV0FXRFRvd29Ea3Qx?=
 =?utf-8?B?eE5aMEJRUjZodm1qek4rYVBuSVFPd1VQS0EwQituVzY4cEJsdGdGMXQybUFM?=
 =?utf-8?B?UHBVQTIrVzI3ems3M3lrZ2EwK2R6NmxYWFkzb0Z5L05tMmJZWER6RWRsUTdS?=
 =?utf-8?B?OXJYbVBTNW9SdTlINmZnNXlPRHprR1FTVGJuZ0xiTVZlOGZVa2c2U0k4cVVU?=
 =?utf-8?B?ejNBeCtSeUtmVW5kZUtLMnYzTkI3RWx5QW5xTW5BbmdhQlVoSHJQMldZVHhv?=
 =?utf-8?B?MlZiZDBveVk1bFNQVjdxWFI4alBHK2lPUWkrK3BKRERSZ3ZHUXB5WWZ3dlZI?=
 =?utf-8?B?QW56WVZVbkkyYlBQMGtGMzRXb3Rud3FWbzZaTGVNbWlSQU1McEFGeTRjNVZv?=
 =?utf-8?B?c2tkSm1SYzhNSDBrVGdBdXhEY24vREJtd3BZRDl3WlhLb1B1WFJVYjB2RHhn?=
 =?utf-8?B?c0RCQ1l6VXRaZFdtNWNvY2dOdW1QWkRmZ3RJdU9KOU5LSzVZcVUwNFBQMFFO?=
 =?utf-8?B?aWh3bnJqNGtQbEdXeUV3d0d1bjlUcjRoa1RBekpnSmZXYTY1Sld0TkVaQ3hi?=
 =?utf-8?B?Zkt0a3pWMGhVNlRQZmNiK3Q3c0JCc2J6OWxBMTNpQ3pUR2RoTVYwbjVBc0F6?=
 =?utf-8?B?RjZDUFhzRTI4U1UwYXRNSnZOcDhPY3pHWFVQc0h1a21KWlVreWN6NFkveWNP?=
 =?utf-8?B?dUlCc21wSzYzMDR0THY0UlFzaXk4c1V2MFphYWNNd2NYUm01aXg0NWdKbExT?=
 =?utf-8?B?bzk4QkYwMVJ2V0VmNnBQbmpMWWhmZVp0VzZKOWZKeGV1eUNMQkVKbnhxUkVG?=
 =?utf-8?B?WVNDNWEyd213ajVaM1FZM1o0Y0NuZ3RENmdwSUFybURZOXFsa1dxdlV1TTdz?=
 =?utf-8?B?dnR1R2VqRzFVQkR3UHA1czc0QXh3bis0bGhrOWQ5VlpoT0hTSll6NWFKN201?=
 =?utf-8?B?eHNGZDg0TVkzRncxb3hEUi8wRFU1bDF5REExNzVmWmYyK01wd21jNGV5SFRD?=
 =?utf-8?B?N0FiQjdPTmt5SWk4dVd4dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1I4RVdoRU1IdjBXeUtVR2dtWDNReHBsMWV1am5qVFRCT2hQUVJpZGVxMndr?=
 =?utf-8?B?YVBIVEZxMVk2dDBDZjl5eWVyL0tVVVh1M1FuS3BVdEcyU1ExcjBhQzAyWXdk?=
 =?utf-8?B?MkRPWDNNRGV3SUNNdXBKaURtakRheFZ0ZGZRR2VqQ3NROU5Lc0oyYWVHMUFm?=
 =?utf-8?B?MGNGeDMzSllxVWs5TmJkUjdWRktoK2x3cXBXeUxaQ1paWU9saUF6UGlDNmo3?=
 =?utf-8?B?cmpoMUlkWk9rK3JNdG5qVUQ5M3NHV1lvb2lmd1ZzbFc0djN3eHY4bUIxNUo4?=
 =?utf-8?B?d1FSZ3dRUldhWFNyQmo1azVDNXIrbFZod0JkRGtyNmpHaVRWWmdveDVNeGdR?=
 =?utf-8?B?MEQyaGw4ZUlNUkJhcG9QSmQzSXlxWEhHSzJaYXI4Q3JqbVgrQ1VjTWxUOGJO?=
 =?utf-8?B?S2xpRWE2STQxa1dVMWVlMzVRRkJpUmFXRlhsbzZXQnpUVVh3bEVjZmttczl2?=
 =?utf-8?B?ZzZaVE5LbVR6QjdiRVhFdEdlNFNkRVlVM1M5MjVjNkpMVlM4OVUvTm5Qdm9Y?=
 =?utf-8?B?Z25XbVEwbHlsSDk0WWhuVW85YmtwU0NSdysvQUQrc0VlSDhKMmZSY0JYdVl1?=
 =?utf-8?B?Q3V5b1Q5VUpKeEpReENmcE0xUllqd0QzOTdUN2QreHVHbnR4WEdFOVhnRXRa?=
 =?utf-8?B?blhIQjAyK2NjNnEzQW1nbXgwNHF2U3Y1enk4d1JkR01hUUU0Ry9QTGZjTzhV?=
 =?utf-8?B?cjgxa05YSEhPbkFJQXZIQVpRYmtidUQ4a1htWUQyLzJkK0dXcVZhek9UTllE?=
 =?utf-8?B?dkw3QjNkVExlMXQ1b3FyMjNidVVJWHRsWnA5Qm42cDIzR1J5b2JoTkh4UUZF?=
 =?utf-8?B?ZTE0SXFwS1hNZGpvWUd6bGovbldxNW02WXRFZzFnYWhtbG5WLzYvVSsrK1Rn?=
 =?utf-8?B?RDh0MEg2K2tBRlVjbDFTRVAvUFdMTU5UdVdIUEhqSUdMWkw2WnBDVDQxUkNH?=
 =?utf-8?B?Z3ZkVnVYZGdmUWFRTEdvWlJMenBTeE9jeFBpcFJYNk5jQWduMWJ0OVBKeHlx?=
 =?utf-8?B?dGsxZzZvSytoL1d1VHQ4VVg5cEZjd3Y5dzFVM1hqQzJJS2NXcWJOR0s3bThi?=
 =?utf-8?B?a3k4eG43UEliOEpWc3hZbHRVRHBMS0hDZ3piMzFBblZrN25oc0ZjcjVhdnM5?=
 =?utf-8?B?djhoNzlZcW1hUmtabHVWN0tvSXhKUU5zTDVxQ3hDNkhnSUc4cFRFdjJJODJ3?=
 =?utf-8?B?NUpmNkdqejF6N2FPS1lpWWhqYkwzYWtQRFJVVklxSGpYaFMxYWpyQlNRSmli?=
 =?utf-8?B?SDdUK3NOMXpGdW9UbVI1Z1JhMFpTdWJuWU9ETllGcW5iZzJTMUptTG9oY09F?=
 =?utf-8?B?V3ZRcThrZzQwbzRwWkp0OE51aE1EellIOWRsd0hHU0NlbkFFNHhIbGIzcDlY?=
 =?utf-8?B?dVdTdjZJV2tQaFdSZ2FJZElGMUx0M3R0UDkxK1VXN01sRXFtdjY2bk9IOHdx?=
 =?utf-8?B?akV1YXpoNUVYMUpuQWZ2T0lDUGFkbkFjeTdIRkhXbG9NS2lmbzBjZ2UwSXhr?=
 =?utf-8?B?WXhocDFoYisrVEdhdlF5NHlIZGtXU2h0dTBIaTE0SDFkb3BBVVY0dGt2UHUx?=
 =?utf-8?B?NjRma1VYUTJpeDJnSU53c2lGa3JZZHhDN3kwN1J3b3NJUXc1SUcvdkZNdGJZ?=
 =?utf-8?B?L1N0VGxWZ3JKMTZIS2hUSktiMmdQNUpwbHhtTmhUd1BRRWMxSXp4cjEvS21y?=
 =?utf-8?B?S0pJSWJsZWYzMnVhL3ZJTUFmN1IvNVI0LzRDeklORTBPK2FEM2Nmd1NHZUp4?=
 =?utf-8?B?emJuM1ZEcW03VEc4ckJSZk5JNnI2Wktqcm9xTm1zdDh4TzRZblJiQTAvZHNH?=
 =?utf-8?B?ellFdkFIS3pBUk53NktLbjFrZG93S1RXQS9nWFpKT3VpZUZUQjVPTVgxMlpS?=
 =?utf-8?B?cmt0c1Nnb3BxQXZ2d0ZvQzIrUzRnMzQzdjg3ckJOZUNJNlR3VDJXTGtlL3VK?=
 =?utf-8?B?TzZGajJQQzk5eFZoRGc4MitWZUNxUGhnbTJTcUtWeXBac1Jab0FSL3FHQUhG?=
 =?utf-8?B?Q3h3TzlTd0M3RG01a3R4eHFUTGZxZXlETk9Zdm04cnN1YXNGY3lGcTcvL2xX?=
 =?utf-8?B?OVlqcU5NWTlmYVNSdzd3ZitKanpZK2ZNWUxRS1VhR3p6YlA1Rkt3RlMzaGlS?=
 =?utf-8?B?YzNOQ2Q1aEtPTGwzc2pjTm5weW5xZVVyUVpBYTNheGFPWklwZ1BYN0wvbzVR?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D09E6F63947A334DB6121AE03ED5B186@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6ee666-ef3e-485e-1c44-08dc65b583bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 05:55:45.3395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iaCuSy8JiU0JY3CyyCmLBH+0ipORceBgDMOJcT76/5pMVrYKNZA5JaX9C72Giz4FyqkKtrz3hb+MLf1wlRKwENyyfk5ttMJ2LpW/UkobmhtZx87NzzgKMQ5OZJPRNWVL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4748

SGkgQW5kcmV3LA0KDQpPbiAyNC8wNC8yNCA0OjQ0IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIEFwciAxOCwg
MjAyNCBhdCAwNjoyNjozOFBNICswNTMwLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+
PiBJbXBsZW1lbnQgcmVnaXN0ZXIgd3JpdGUgb3BlcmF0aW9uIGFjY29yZGluZyB0byB0aGUgY29u
dHJvbCBjb21tdW5pY2F0aW9uDQo+PiBzcGVjaWZpZWQgaW4gdGhlIE9QRU4gQWxsaWFuY2UgMTBC
QVNFLVQxeCBNQUNQSFkgU2VyaWFsIEludGVyZmFjZQ0KPj4gZG9jdW1lbnQuIENvbnRyb2wgd3Jp
dGUgY29tbWFuZHMgYXJlIHVzZWQgYnkgdGhlIFNQSSBob3N0IHRvIHdyaXRlDQo+PiByZWdpc3Rl
cnMgd2l0aGluIHRoZSBNQUMtUEhZLiBFYWNoIGNvbnRyb2wgd3JpdGUgY29tbWFuZHMgYXJlIGNv
bXBvc2VkIG9mDQo+PiBhIDMyIGJpdHMgY29udHJvbCBjb21tYW5kIGhlYWRlciBmb2xsb3dlZCBi
eSByZWdpc3RlciB3cml0ZSBkYXRhLg0KPj4NCj4+IFRoZSBNQUMtUEhZIGlnbm9yZXMgdGhlIGZp
bmFsIDMyIGJpdHMgb2YgZGF0YSBmcm9tIHRoZSBTUEkgaG9zdCBhdCB0aGUNCj4+IGVuZCBvZiB0
aGUgY29udHJvbCB3cml0ZSBjb21tYW5kLiBUaGUgd3JpdGUgY29tbWFuZCBhbmQgZGF0YSBpcyBh
bHNvDQo+PiBlY2hvZWQgZnJvbSB0aGUgTUFDLVBIWSBiYWNrIHRvIHRoZSBTUEkgaG9zdCB0byBl
bmFibGUgdGhlIFNQSSBob3N0IHRvDQo+PiBpZGVudGlmeSB3aGljaCByZWdpc3RlciB3cml0ZSBm
YWlsZWQgaW4gdGhlIGNhc2Ugb2YgYW55IGJ1cyBlcnJvcnMuDQo+PiBDb250cm9sIHdyaXRlIGNv
bW1hbmRzIGNhbiB3cml0ZSBlaXRoZXIgYSBzaW5nbGUgcmVnaXN0ZXIgb3IgbXVsdGlwbGUNCj4+
IGNvbnNlY3V0aXZlIHJlZ2lzdGVycy4gV2hlbiBtdWx0aXBsZSBjb25zZWN1dGl2ZSByZWdpc3Rl
cnMgYXJlIHdyaXR0ZW4sDQo+PiB0aGUgYWRkcmVzcyBpcyBhdXRvbWF0aWNhbGx5IHBvc3QtaW5j
cmVtZW50ZWQgYnkgdGhlIE1BQy1QSFkuIFdyaXRpbmcgdG8NCj4+IGFueSB1bmltcGxlbWVudGVk
IG9yIHVuZGVmaW5lZCByZWdpc3RlcnMgc2hhbGwgYmUgaWdub3JlZCBhbmQgeWllbGQgbm8NCj4+
IGVmZmVjdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXJ0aGliYW4gVmVlcmFzb29yYW4gPFBh
cnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPiANCj4gQXBhcnQgZnJvbSB0aGUg
UmV0dXJuOiBpc3N1ZXM6DQpPSy4gVGhhbmtzLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4g
Vg0KPiANCj4gUmV2aWV3ZWQtYnk6IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCj4gDQo+
ICAgICAgQW5kcmV3DQo+IA0KDQo=

