Return-Path: <linux-kernel+bounces-96567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A892A875E46
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C998281066
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41104EB5B;
	Fri,  8 Mar 2024 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jue+IQCv";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ef0RA7+4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794502E3E4;
	Fri,  8 Mar 2024 07:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709881959; cv=fail; b=rYIl7OoyCL95FdjY4wMVePve7F2svDjBLbjCXLIauY/mUXfN2ZorilM4nDVx+hz0HuYbbRYhaxzaKavnwRWe/Pss9Jp8CVHhmatZgoLMG14e6vHt77e3oJ8fP88fPh2cy4LvvdY2oYTQSpf+iAPm7PUfAIYp0N9vdez2fGetYVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709881959; c=relaxed/simple;
	bh=Q9onVWUgxzOrYnrDj2JM6NnTwcw7d6dEgkJJxzgHzIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Au+rnfU7F1Tf4XeDnBpOZXU9dCDMxIxixwmNLnvU/30/AMoEH4nXWPckjpXjykE+Ea8JpUjBbQYDLx+QRIrVwLg7YOMdVlvcpIaDA7GH8Pf3atF9t969o6WC1+Ur5h/FimiOgHN4b4f9upxAmeNtUj9kLluBqlZj8TCjZxLVSpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jue+IQCv; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ef0RA7+4; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709881957; x=1741417957;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q9onVWUgxzOrYnrDj2JM6NnTwcw7d6dEgkJJxzgHzIo=;
  b=jue+IQCvG/HBCbz31OivgSYCxJ6yU00O8OnIhkfNOJPpmJiMM7aIN3Q+
   Cvgx3hdOu7gV7uek2f0dXGFVEiV/JNu1/Rg4M8XDOvf1NHbzYAs7kG82D
   yEfj1RXsBC6gXCX5HCxGTtoOLm/FWfxWaHiALfRZpVPnDMzUpe+albpeJ
   xGSe3KHhjwBHgxz7zIgQ6VMj4e7+iqRYqbvNoxlNERabaJtKMEJ6cG18k
   +EugMwnFPlM4w4w8fMYqE7lIBYWYCLOz0CFWF1nNi+intta6QjqrJZ+Qg
   56aYf3MqU/16S5yhv/XN6fYfNuMF4FBSiVd8BvFbhLwIVQwPAvQ4Fr7vl
   A==;
X-CSE-ConnectionGUID: SPiBj3hbRUu0v9NOP4wn5Q==
X-CSE-MsgGUID: boyG+1BUQyKgB1vQcm2oWw==
X-IronPort-AV: E=Sophos;i="6.07,108,1708412400"; 
   d="scan'208";a="17925623"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2024 00:12:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 00:12:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 00:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViSfHQvAOW+atbjw4aMnw6P8wR4JUDp1L0Rm2W8staGuC+iF1aEegPLICQ1o/Ja61eHMdh0ZuKfURRbkQBW1NmmZhZWmVNIDiFKZbxotQHqexrBsYlgnK4qSdLJQCAqBxnN4XXIZ8l1nZh8dLx123qy8IAf90mI3rxfbdQAevVRKT0k1c/G7CvLQPQ1P/X8XtoWyztfIwfJzMcNIlrF53kRExqfS+Q0RyvQoeKaAM/fAsPb2FgIqzYTUl5/J08qKTXc5Ea8GCi8ibFB8Gesci5AK0FEodQ9iL7A15KV8wt+DvG3s/IiyUS08dLktEVZEZyiEgBJEsTV3XpF1gs5Hbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9onVWUgxzOrYnrDj2JM6NnTwcw7d6dEgkJJxzgHzIo=;
 b=FatQz511LzXXApybiLAM66XqyyuPctpf/VrETWCTnKBeAfet6sR3zaG21/rK/l5QLdaxGgi2o6yIfhwDdCVVYIUwCLEOsvNV/nNEp9+p1MJjufmwV9Wv3e4S7K9jJIqXTdtDl21iFWguQr0GCHHL2Pu5/bJ6jrsAtuLixeGAjicZWEr4jddMIuXU4aZynZONapNL7qAg9oVVBrNsiRN0mJn1WT7gBb+2nXIS67uTgXLA1HQovJ/YrKgp8KP8pPXDvuWRW2es6uy5JenJ3gGup/Vw0uGf6BmhgFt8VWXRqcX9Y0+GvfPBd+0trl0AihNFHKSYsbcNN2D4HPXTiH0Fqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9onVWUgxzOrYnrDj2JM6NnTwcw7d6dEgkJJxzgHzIo=;
 b=Ef0RA7+4byDkb5MT033yjMyms5UuC4ZorIobDE4/Xnzh+mNr3Y94vOtTpDnGeAvh6HbJ2t1pl7B0WE+Wy9KaSqYI05tFAcG9Mjo0kKbsBhlDmCIbBd2FM9MFlx2/gvwZUtbPkVuVsAjZQ7Eg0mISFB+7JKJPtxD/zGkQUrw8ZyD6YdugW6Eyz85hCuTfyrgR5WLadFyAKyzyGGaTiNWc0bq8eLgCO3I7d+KCwZhN1UYpnLWBW86Yh+3fJXPGdt7pImMXFxDEbj7QdXRCgGVj252vb1M1T5N2MgLGCGm7e3SH3Xqw00WpzHgOrwEkVVRk9Rn77ySndA2TqRCel5AApA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CH3PR11MB8467.namprd11.prod.outlook.com (2603:10b6:610:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 07:12:12 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.006; Fri, 8 Mar 2024
 07:12:12 +0000
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
Subject: Re: [PATCH net-next v3 03/12] net: ethernet: oa_tc6: implement
 register read operation
Thread-Topic: [PATCH net-next v3 03/12] net: ethernet: oa_tc6: implement
 register read operation
Thread-Index: AQHab6N33BKSiButbU+b9vGzVOsXAbEraxEAgABw/QCAAGmdAIABKuyA
Date: Fri, 8 Mar 2024 07:12:12 +0000
Message-ID: <07d3d73b-c920-4503-ad6a-d59fb1b5458a@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-4-Parthiban.Veerasooran@microchip.com>
 <48b65759-6e69-46ef-a2ed-857d04eadac8@lunn.ch>
 <83e0b340-521e-4d60-90bb-92d2ca6f5abe@microchip.com>
 <d2f254b9-7e7a-46ed-a979-00bdf92899ac@lunn.ch>
In-Reply-To: <d2f254b9-7e7a-46ed-a979-00bdf92899ac@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CH3PR11MB8467:EE_
x-ms-office365-filtering-correlation-id: 88ccfb7d-8c0a-4372-aae9-08dc3f3f13ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KucZGWzI9WrzfoLNBLinTQ4vU4TO07VJMTSxcyppZ5n0AnUpJCUfmN+LqBE8/ObTfc8gV/QYcgY8x1W7khUjsWqCgRf15NjkECowGT47jwm3aMv8bokaKVlLiiy2L6SEbzrBG1KRaXLbdp3vVPDOHy3FDKDL8nzw7Pb+OKKGjDj6jSXG+hdlIzIya8H65UCpWfWkeUlk5fR2ZQuwPN0AcD+z22TqOJjbNG4A2jtqkxMfnKMZF/aHaOHqRFuFuoWwndUXosSJsx3Y2MOhuvpVZEUY/2bqo6ZwSnR7oQVB8QnJNjC+2FLhgNWMO5CVijrlA+fvik9J8rqMJKSJi8tsAqjIQbYFZKv3T477is6hiafV8wpYTmJceHsjrhlZ7+PFtCMJJYpIohAqEoukU+r3taHjD+SWcG9quEQjYUNeDOWZb4iriz5nr5SOQdcPLqo9VaPzCGwMEVuOFBG+32BSvTsE2xEkHsaEf//NJdvW+QOq5qyL/UWb0PoOPYlhagJJ212zAmB4lqVXtXq/7KUvvr1Ehxp9qSw6Yk8CFXgt+6OZmv193WAPPzH+r6FffpIeygfDlGbzZcLKsHyPIFmRU2AqLkgm6rmbsOd/S1Uniabji0ok09kyURMC+DnPle81U9akGSXALcD3Nxy0hp/ODlzzx6Pao7+3Tip979cw24YDDqRNSd811YCX7YHy8ALsh/xkVIsIenWCJBzuWGq9DpmPq1982mpBBFrrF47Glrw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEdTSEJHKzdJaDFqNGwwYTYxNGh4OEdXekVUYU4yVVJtNmFqYzRSM3FpZVdJ?=
 =?utf-8?B?NDI3djRGd1lseGZvakh3ekZoa1c0YUNNcGFHR2dSVUhoMXZjbzZOK3NIOUIw?=
 =?utf-8?B?eHpWaTdtNTlkZlo2YnNXWkM0UC9xNy9tV0tkdUZZVXlnNTRHYWhzeEFaeWU2?=
 =?utf-8?B?dGJmeDlkano1YTJDU3daQkNpTTlPVVd5dnJsV2g0UkUrdnRSdkRlbEJPcE5l?=
 =?utf-8?B?MlZqTE4rakIwSFpFL1BJaUFJR25vN2l1STBXdkthS09jbS9PcE5FQnJ4MU4x?=
 =?utf-8?B?bWpGa29kNkhzTUFLL013akxOcVl1MTVQcmc0c0VocWdJbU9ZVXV6Ry9VVnRn?=
 =?utf-8?B?WVJvaW9obFZpM1ZDUzdXQUU2QXJhMGhCRHpkc1FrUm9yOVpPUG5aazh0ckpi?=
 =?utf-8?B?R0F4a0kvL2RBd05jM0JSclBFVGFKSGxkY1JBZWJ5Qk5mdjdxN1VsMlVaYkZE?=
 =?utf-8?B?dVhPUkswZndmeXU0c1NBeS9jd01BRUVBZXIzTE9DWHpONHNENmlkMUdtY2F3?=
 =?utf-8?B?VjZBUkN1anNJdnVKTzNzakNxVTV5VVNtbUREc2kxL0FHLy9pS3V1dURKQWFr?=
 =?utf-8?B?RGRXUzN3cFo1Y1RQRVg1UzJNbDNqenFsbkt2Y0dBL1RMTnRsbTdLNElJM2FP?=
 =?utf-8?B?NnJQKzg2Mk02OEFaS3p6TU92L2hZYlVuL252ZktFRFhXU1ZpblRyc0wxTmFp?=
 =?utf-8?B?UWw2VmJoN212M3BneHRXWHdzelNkRGlvcDFXZWs3ZWdKcC9CKzluV1pZTzcy?=
 =?utf-8?B?UVF1SHlGZ2hjWWFjOGE2WlNEMTk5TkFnUytDMGJLV3BOdlVteEpCbktvWStR?=
 =?utf-8?B?VHFuZHhRVHNHai92d0o2WUZHT3pmUkhXN2NJT0tQdnJ4VE15SkNKZ1ZzeHZV?=
 =?utf-8?B?QngzdHJJN2dxbjJ1SWNLaUhCUENvSXc3b0FDdC9KT29vRGVLd1JwdHVNMEdt?=
 =?utf-8?B?bmVHZDJhZ3hxNW5mYWQ0dE5yaWtjWHlRcm5IekRneTFXWVNWajdDbnQxNEpN?=
 =?utf-8?B?NDNETVM2TlJwQVdROFlwUStPQkZGQ2VNVjRlT3NIZDdmL1FvYkhWdlkwdE1q?=
 =?utf-8?B?TXd1MFVMNGZGTEtJRnZBT1dISDQ4YnBISUVzbWFIVktUQWFyNVFuUFhQbTM0?=
 =?utf-8?B?bUJKWmQvSkxzelZ2eVo1azc2YVFmazQxS1NMd2dWQ0R3NGdWNUZIWVpMdjlV?=
 =?utf-8?B?a3c0QnFZNHV0aG8rU3lKSmxFaWJlTm1tenVqQlhIQ0doajFDMjE2WVB6SzNN?=
 =?utf-8?B?Vk5SQ1g5bi9QalN2S3hiZWkwbk5MRlBpdk5BaTM1L0xvY0NBaENZbUdXZnZ6?=
 =?utf-8?B?Skllayt0WHl3b0lRY3pBY1BFdGpFOEhNMUpKZkdqcEJWVUhMU1dGcmk4WWZk?=
 =?utf-8?B?RDJBTThOSUhzcU5WbjdEdGtSU0FicHlMZkNaaE9Id3l4R3RXcTRMZVB0bGdm?=
 =?utf-8?B?cy82aXJhdnNGcllFNFEyM1Y5M0s2SG5DOVdDUm5FbjdnUForVlJaVVVjMUFG?=
 =?utf-8?B?enAyU0VOM0JtcTZTR0Z5bEJSQUliZFlBUDhzdVhIOFZHUzNNQnpjeWZQbHcx?=
 =?utf-8?B?NWgrNWliRjRzTlV0NGIzRXAxYmxyTExvbGE5Wk82V1ZFRFRmaW9ucnB4SE01?=
 =?utf-8?B?ZE91dWhqWlg4TWo4TlB0aTlvSVNudDhCTVNFSXI0T2VEN0JWWTF4Nml0aHRT?=
 =?utf-8?B?N3hIQU51SlNxU013dGJySU9Rc09NdGRsYmJzV3NzRWlVZm9RWXlTYnFmYUdj?=
 =?utf-8?B?Q1VCWCtjVDJIL0JFNmhhNWFoY1BFUnJpYmdTM1QzKzZobzg1UEN6d3ZSM2ZP?=
 =?utf-8?B?UnN5STVEK0xzN2F2bURDcGJIbVk5VkVBSWVkNTlBeGEwc3dVYjNhVEhHY0Mv?=
 =?utf-8?B?R096TXlzdXo3NEVGYWlTL0ExNjE4aUFJUjlLdmdPRDZLdzVySklwOXdtd2lo?=
 =?utf-8?B?QitlSUpmSTVjWHp4eW41T20vdjJtckdGeHV1Ukh1cSsrOVZGbGhsUUU3MWg1?=
 =?utf-8?B?WGNCUTEvRWxLUDBGcGdhdlQ1Z2R4NkJha1FySERUeEs3SE5ERmxwK0V1aThQ?=
 =?utf-8?B?dnQvZHJUYWptTFhXTnlCQXpBREd0T2hrckY4Zjg4YnpCbzd0OTdlNkxnWEN1?=
 =?utf-8?B?UVlkZ2JpMUdOcnRlL0tSZXlEelM5YjlibjBzTFdidGpzSU1GVytpY3pDcy9P?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C87D3FC4A62B1140BA43D6612E439CEE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ccfb7d-8c0a-4372-aae9-08dc3f3f13ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:12:12.5160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wlOgRFt5E8NHIm785ER85NHKmEGuZ5av3w3S2+O0YdxUHHe1xmgcg1VretEvyj13leWEGFc5DMYemwaVtAfabR+U+qRajp5dWKtgAJ3dRglVxPHPVV6Ps/7aHn7bOLA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8467

SGkgQW5kcmV3LA0KDQpPbiAwNy8wMy8yNCA2OjUyIHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIE1hciAwNywg
MjAyNCBhdCAwNzowNDoyMEFNICswMDAwLCBQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4+IEhpIEFuZHJldywNCj4+DQo+PiBPbiAwNy8wMy8yNCA1OjQ5IGFtLCBB
bmRyZXcgTHVubiB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4+Pg0KPj4+PiAgICBlbnVtIG9hX3RjNl9yZWdpc3Rlcl9vcCB7DQo+Pj4+ICsgICAgIE9BX1RD
Nl9DVFJMX1JFR19SRUFEID0gMCwNCj4+Pj4gICAgICAgICBPQV9UQzZfQ1RSTF9SRUdfV1JJVEUg
PSAxLA0KPj4+PiAgICB9Ow0KPj4+DQo+Pj4gSSB0aG91Z2h0IGl0IGxvb2tlZCBhIGxpdHRsZSBv
ZGQgd2hlbiB0aGUgZW51bSB3YXMgYWRkZWQgaW4gdGhlDQo+Pj4gcHJldmlvdXMgcGF0Y2ggd2l0
aCB0aGUgZmlyc3QgdmFsdWUgb2YgMSwgYW5kIG9ubHkgb25lIHZhbHVlLiBOb3cgaXQNCj4+PiBt
YWtlcyBtb3JlIHNlbnNlLg0KPj4gT2suDQo+Pj4NCj4+PiBUaGUgYWN0dWFsIHZhbHVlIGFwcGVh
cnMgdG8gbm90IG1hdHRlcj8gSXQgaXMgYWx3YXlzDQo+Pj4NCj4+Pj4gKyAgICAgaWYgKHJlZ19v
cCA9PSBPQV9UQzZfQ1RSTF9SRUdfV1JJVEUpDQo+Pj4NCj4+PiBTbyBpIHdvdWxkIGRyb3AgdGhl
IG51bWJlcmluZywgYW5kIGxlYXZlIGl0IHRvIHRoZSBjb21waWxlci4gVGhlDQo+Pj4gcGF0Y2hl
cyB3aWxsIHRoZW4gbG9vayBsZXNzIG9kZC4NCj4+ICJkcm9wIHRoZSBudW1iZXJpbmciLCBkbyB5
b3UgcmVmZXIgdG8gdGhpcyBwYXRjaCBhbG9uZSBvciBwcmV2aW91cyBwYXRjaA0KPj4gYWxzbz8g
SWYgaXQgaXMgZm9yIHRoaXMgcGF0Y2ggYWxvbmUgdGhlbiBpdCBtYWtlcyBzZW5zZSBhcyB0aGV5
IGFyZQ0KPj4gZ29pbmcgdG8gYmUgMCBhbmQgMSBhbnl3YXkuIEJ1dCBpZiB3ZSBkcm9wIHRoZSBu
dW1iZXJpbmcgaW4gdGhlIHByZXZpb3VzDQo+PiBwYXRjaCBpdCB3aWxsIGJlY29tZSAwIHdoaWNo
IHdpbGwgY3JlYXRlIGFuIGlzc3VlIGluIHRoZSBiZWxvdyBsaW5lIGFzDQo+PiBpdCBuZWVkcyAx
LA0KPj4NCj4+IEZJRUxEX1BSRVAoT0FfVEM2X0NUUkxfSEVBREVSX1dSSVRFLCByZWdfb3ApDQo+
IA0KPiBUaGF0IGlzIHdoeSBpIGFza2VkOg0KPiANCj4+IFRoZSBhY3R1YWwgdmFsdWUgYXBwZWFy
cyB0byBub3QgbWF0dGVyPyBJdCBpcyBhbHdheXMNCj4+DQo+PiArICAgICBpZiAocmVnX29wID09
IE9BX1RDNl9DVFJMX1JFR19XUklURSkNCj4gDQo+IFNvIHRoZSBhY3R1YWwgdmFsdWUgZG9lcyBt
YXR0ZXIsIHNvIGtlZXAgaXQgaW4gdGhlIHByZXZpb3VzIHBhdGNoLg0KPiBEb2VzIHRoZSB2YWx1
ZSBvZiBPQV9UQzZfQ1RSTF9SRUdfUkVBRCBtYXR0ZXI/IElzIGl0IGFsc28gdXNlZCBpbg0KPiBG
SUVMRF9QUkVQIGV0Yz8gSWYgbm90LCB0YWtpbmcgYXdheSB0aGUgPSAwIHdpbGwgZW1waGFzaXNl
IHRoYXQNCj4gT0FfVEM2X0NUUkxfUkVHX1dSSVRFIGhhcyB0byBiZSAxLg0KU29ycnksIEkgaGF2
ZSBkb25lIGEgbWlzdGFrZSBoZXJlIHRoYXQncyBjb25mdXNpbmcuIFRoZSBkZWZpbmUgbmFtZSAN
Ck9BX1RDNl9DVFJMX0hFQURFUl9XUklURSBpbiB0aGUgRklFTERfUFJFUCBpcyBzdXBwb3NlZCB0
byBiZSANCk9BX1RDNl9DVFJMX0hFQURFUl9XUklURV9OT1RfUkVBRC4gVGhpcyBiaXQgZmllbGQg
aW4gdGhlIGNvbnRyb2wgY29tbWFuZCANCmhlYWRlciBkaWZmZXJlbnRpYXRlcyB0aGUgdHlwZSBv
ZiBvcGVyYXRpb24uIElmIGl0IGlzIDAsIHRoZW4gcmVnaXN0ZXIgDQpyZWFkIGNvbW1hbmQgYW5k
IGlmIGl0IGlzIDEsIHRoZW4gcmVnaXN0ZXIgd3JpdGUgY29tbWFuZC4gU28gcmVnb3AgaW4gDQp0
aGUgRklFTERfUFJFUCBhY3R1YWxseSBzZXRzIHRoZSB0eXBlIG9mIG9wZXJhdGlvbi4NCg0KVGhl
IHZhbHVlcyBvZiBib3RoIE9BX1RDNl9DVFJMX1JFR19SRUFEIGFuZCBPQV9UQzZfQ1RSTF9SRUdf
V1JJVEUgYXJlIA0KbWF0dGVycyBoZXJlLiBTbyBsZXQncyBrZWVwIHRoZSBudW1iZXJpbmcgZm9y
IGJvdGggYXMgaXQgaXMgbm93LiBCdXQgSSANCndpbGwgY2hhbmdlIHRoZSBiaXQgZmllbGQgZGVm
aW5lIG5hbWUgYXMgDQpPQV9UQzZfQ1RSTF9IRUFERVJfV1JJVEVfTk9UX1JFQUQgaW4gdGhlIG5l
eHQgdmVyc2lvbi4gSG9wZSB5b3UgYXJlIGZpbmUgDQp3aXRoIGl0Pw0KDQpCZXN0IHJlZ2FyZHMs
DQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAgICAgQW5kcmV3DQo+IA0KDQo=

