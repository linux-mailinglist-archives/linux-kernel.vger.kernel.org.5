Return-Path: <linux-kernel+bounces-109799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB0A8855DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A6B282151
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC411D526;
	Thu, 21 Mar 2024 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vQ7RQRSN";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="O+fqSBwm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717A6C8FF;
	Thu, 21 Mar 2024 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010319; cv=fail; b=sLGP2/BJeKZqhuhNtNkt7vZYiFvfkpKpAy9KUW1vgjMBqCZM/fnPD6067sUlpBJuhI9xor/lXSw9UvJ9yksgOAIyVaZ9mshGk3LY57U4UtLfmDaPqNZ4HVQWedywecXXDoYO3DyfceCp6F7MxdgUYDSVPg1MOYJqI67ZovF1QAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010319; c=relaxed/simple;
	bh=NsUsESMmqzTVk5gSdS1i6JjnxRQpwovcITGOyIaIyfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UrsJNaeVoRrg/UI2cC6KETN19qHGLnOulWjk2TibzI8wvmoPvQz7G7zdhSLMKhV9QYPr0h2xRgOi8HHMc7X4BmqwpPS9hWu8v16uXTZKBrkN1N5WDVzSXvo0FnynrB681Szwx3VtKhD5fMYhL7W8XJ5xD33MfZXEqjRS0TQp6uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vQ7RQRSN; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=O+fqSBwm; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711010317; x=1742546317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NsUsESMmqzTVk5gSdS1i6JjnxRQpwovcITGOyIaIyfo=;
  b=vQ7RQRSNxvvJWcRdjBvOVmMvxvKY2v6yCnF96f7iADw+fwVox6d2tm9b
   ZMfeMXyOoro+VWT6uz5Ql31R4pKOManxF/ZR1TReNqEtol8rv9bTOoHgf
   q1IA703M4DyQW9zukPAixmANunHrW++vMy5WPmraxJlf+367VL8zJHlPK
   +aQ8oair8ojOzvOnAohh7fPUOxj1PWyQswpHsTE4BIQ3PyWGhtqCuTDIK
   FcCTPEOnRTO4hstFcsce6L7AlzEBUlC8/fmMF1zx0K47OCGdUNPqHvSor
   5tGJ0qPTsxjyOJ3XBtlxh/A3z2vgqePXL6UWNXSROQ0ZWSFNOIeR7PMxT
   Q==;
X-CSE-ConnectionGUID: n4Eu7LcJRL6Y5HoC8m/h8A==
X-CSE-MsgGUID: 6d5HJiDwTR6712OBl5HwwA==
X-IronPort-AV: E=Sophos;i="6.07,142,1708412400"; 
   d="scan'208";a="17922992"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Mar 2024 01:38:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 01:38:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 01:38:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROXfSen7x2oXXM/ejaJi/Tup3V6gNnzmqhdQhQT94yx3PdQ8eNzWIojxJNXGHzjdXYVATBL5iMnFNPmqXgJA1Toyv6ZN+mn6hGN1P/jw+FVap6n4MCW8+gKAuXlqmVbxScVqY26VLOhUdKx6UCLNUZAwlsLpQmom3uLCs+38hgIsGu8jXt2wX8OG5Ml96E+uvac8dq/Fe1734Qo8t6AYQiSh5LEEHDow64GIrh+/+n8Z9xJ4r5F7S+SgKut0c7RE+s+BcvH44mimLb+Lkb5N/wKauacTofzwSymZY7KphAfW3xEiyeo/EMQUA12H6t613KDDJc+i2A2oaTjQ0CnARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsUsESMmqzTVk5gSdS1i6JjnxRQpwovcITGOyIaIyfo=;
 b=ODuzNruY1O4o3wOxBW9BIxbGWVEdBXSx2fsy9xS0E+0zf2tVeklK5RDX5zU1lED2FimOPW0W0Wytc5EQ0u6IrCHxeC0/Gbchc2iTOX1+eSfk97R739u1koMJOmSdZCzZJ8qcFXegkFgXGguZ6CGhIsGrqVVeEwrjp/Osv4rRaPlh510Pwsrk9g46157ohVQ3r6a0i8LWq50vPrCD+GKdBwgPjdYgYcTdmIhexXL0EMsryPFsTpTipEq0oL5YNgirew3tAFaOoet1e0WjGiVM/uI+zV7QQdyum+s+q5lP2l3ufHKtDqsuOXedZ9Yn7WzB0fFFiBDg0kfCbhL0s9nlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsUsESMmqzTVk5gSdS1i6JjnxRQpwovcITGOyIaIyfo=;
 b=O+fqSBwmfYcWbk/ZvilVfMqf769Dc3vxDgJv/DzVXC7IQEBMj+bfDwSed0IVtPFLeRKug2htgOTOku2xhVuwXSQHlvNrpQDFB5WbIj5gG2inv9CDcaThOoXMmmg7ZGHTZmcNv72kqf89tJDvYdpHzk7g1MS3gviqRubx5phPResPl0u7CkGAGK1o27gTYtgtRNP3sp+fRxKHQX/xFvZ5ipgLgoADUKAY8OnTvecbBt+XcTOS8GCs+WRZKNolaF4l5VXZeAAEaiDLLtiCYAi7CecxpjSep7w0eknjgS7d3OGEFH3Jj1TxIiur2fUM12Tj4iF0wjoiHx7ExlduUatKBA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH7PR11MB8552.namprd11.prod.outlook.com (2603:10b6:510:2fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Thu, 21 Mar
 2024 08:38:11 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.015; Thu, 21 Mar 2024
 08:38:11 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <krzysztof.kozlowski@linaro.org>, <conor@kernel.org>, <andrew@lunn.ch>
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
Subject: Re: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Index: AQHab6Ox6ghenOTJpkWNbGLTwd03cbErBYYAgAAJFoCAAANkgIAVU1wAgAAUTICAAX1RAA==
Date: Thu, 21 Mar 2024 08:38:11 +0000
Message-ID: <ba37c212-fb98-407d-9bee-6d14801754d9@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-13-Parthiban.Veerasooran@microchip.com>
 <20240306-spree-islamist-957acf0ee368@spud>
 <4c5968a3-c043-45fc-8fff-2a9eaa6de341@lunn.ch>
 <20240306-ripeness-dimple-e360a031ccde@spud>
 <05a9a7ee-e4f0-443e-9c8a-8ee649a11448@microchip.com>
 <2f384a54-74a0-4a75-a325-8985257b5d66@linaro.org>
In-Reply-To: <2f384a54-74a0-4a75-a325-8985257b5d66@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH7PR11MB8552:EE_
x-ms-office365-filtering-correlation-id: 3879c0a1-c5b3-4857-12b8-08dc49823e3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NthKGKdUrMJBHw8XL1uit664xwG8IvWWj6X54yoyAMVGvHe74d4Jx1FsnFiWjE5N6CQ1nXwugX0FbbC22izeOUeudSdGu6hmMClN+jcuapgbDEY/zQOACqFnq/XHUYdweytLkWv327mYjV703LEOG5f89CfBdE1s+SkIsWNLCNxfSJ33Vdxz3rT7L/g4bb0CnffP7WCKcRlivPlv/gEtZx6jsmx7QdM763uYBO2GUYEyS8kU79IWVorlA4nD95JOdKjD+P9ozceBeGWKidVTY3CgrktIXZTEkGqRjKlhNHT13cmGuRpkZpaGxOgTFZQScnWoR7hZJECCohQbNCT373CEuLTFDrz5Arp6R0j0IZdWhhyhMqPiOTNtZp5OqLivF/NnjNbr4IpWYQCGP1/7uwn04eUET/FFRaBmwmW/OQjB1fK3/wUgxdpGZB5htcn7S5ZTXL+9x7n2PKDYJ/ihZuvYKaH2opzfpzkyioPSHEtSo4kwLrWQMkMdqq09/ytQ0QNvM1x+CEZXPoP66il7Q9mD9GF0zkAFbsbICyx1uvSTWP7wv8ET92ENjO/6LXi/hcnSQvnQcTsCs2k4GBoWxhtrozdB8lbNknF+iJmAlVAvbfmUXBdHa2Ht95wH9uE4rDRcGI1Crf+jHAaj/TD8rKkiReAp0tRz2Qw6/i5IgITLYd8ijTGaBGS1srLvD6EM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVBFMHVPOXZFRUNORHNiZlpvY1EyYUlrWDVBSkwrazRtcUp4aHhOV2tlSFA3?=
 =?utf-8?B?K3B2MHdIYkNHc1BhcHhqZHZzTmJvS3pPeWdFUHUxVnhyTDlpSkZMNXBxK3dC?=
 =?utf-8?B?NFVBVXVWRGdXMDdTV2p1c3JicUF5OFQzaDFxeDV5Z1JNMi9RdnFHWWIvdTRO?=
 =?utf-8?B?QnFsVTN2alYzV3U3R1BKdWk0Y2x3UUt4MVNrTnUrbncxSzFBT0FUZTJwZ1l4?=
 =?utf-8?B?enMvYXZBbFZLdC9iMGNwRVdOV2JJV2NSbFN5M0ZIbjdLM3VrRC9UV3M4M3B6?=
 =?utf-8?B?b3RQSklvdUI2OVBZcjR4dGU2OHYyYTFNcTJNY0xBdmtHZVQ1ZEZSUzZRWUt6?=
 =?utf-8?B?QklsNnVVWmhjU000NlRyNStiSnNpUEQxMjM2RGV6Y09pd1l5T09UWVQwc25T?=
 =?utf-8?B?YjBZaG1qblJZWkJnalNacG1UZ0FIQzRqWDlpc1M2SkxBOUxNd0U5VlJyWTEv?=
 =?utf-8?B?T2pxemthR2JLL1AzVmxWUVRvU3BPTGVNUVMrUHM3bDFxWm9hdFl1R2NDVm5y?=
 =?utf-8?B?UGZTeENQVnNUOXUyYlpLZzIzbkl1WVY1Ny9ib3FLNW9EdWZyUVJkRmJCTjZM?=
 =?utf-8?B?KzlKUEZZV1RGZEdJYWJtejlBYmJmNjBRcWtaU2VDVURTN3VMaURZMERaNWlY?=
 =?utf-8?B?SU5lMUxaTVZuUkdXNGNoaFZibXljcEV2dVhEMEtXQUJqOXJVa2RqMGE2Qnp0?=
 =?utf-8?B?TkRuV2I0Y2FDQk5rMWlKWHBOM2xSbVF6bThKMU1nc0ZOakhHRytKQXVuak10?=
 =?utf-8?B?OGNNRXJCSFFFbjBidnd5d0hkRXF0bE1vSnVoeS9sQU5GL3hKWWFRY01yendU?=
 =?utf-8?B?Qy9JdmNMYVF5RTUyVTA3Y0RBYnRWUkw1LzZlMU1lSGNhZjUvVklBQUltSEJv?=
 =?utf-8?B?QndGRGJ2djdad00waG0xODhFUTBiUCswd2pONXNUdWZyRFdNdFhiaXVlUkJ1?=
 =?utf-8?B?c0V2MUlUTTNOQWh5ZDRhR2VtTk5jN3RrZmxZY2o2MTVVSy83QXZTSVRUbjdW?=
 =?utf-8?B?a0kzaURMOXh2alpMOXd2MitwL3BjNXBXN3dxOEd2dW9qWk41TUhmanV4UWZG?=
 =?utf-8?B?M1prK0JqUENZZEVmdzdIQVd1YVB6Y2xLRnEyRUt6OUYxWFc4RmdHWkxPWmx4?=
 =?utf-8?B?QVpQdU5yVWh5MEo0MmtHWXRuSkgyWEJrZ2RyTEJncHk4U0p1d3lYNmNnVWVL?=
 =?utf-8?B?ZWQ1RW45YkJJS0FDTy9JalJIK091VkpWcEJRazVIRjJsYlFoU3pJZHBMSlZE?=
 =?utf-8?B?YjNKaEtpUi9NSUw1WjVxdUxPNGtzbUdMdktmV1FKQUxFdEFSYW1MTE5GSGUx?=
 =?utf-8?B?enArWXk4K2xvS2xmRGF6UUl2a0xxU2Q2V294eExtQzFzMWlQMENvaGdZeVVX?=
 =?utf-8?B?bGU2dUl4dTV0M1dBcExDSEhkc0hmRUxLYnphR3c1YzRzL1cvVHM5YjE5elho?=
 =?utf-8?B?SGZmQ1RodUpaZk8rZ3FsT0VEZzZGN2x6NVZnRXJlRmN3TXRrRWJreDBaU3hi?=
 =?utf-8?B?TklDSDRvSDdCaTg1Yk9QZ1k0OVlSa0tacnZaU2xNVFF5M2VXSStBSlN5bkIv?=
 =?utf-8?B?aE9naVBEL3ZrdStYbDZqY2VrT2s0MXZJL2hFUFNIZGNITEtaSGJTbFNDQmZK?=
 =?utf-8?B?Q3hjVXpkV2xhMFJRVEw2Snl5MXZQL2tDeTV0WkhUZkJNdEtaQTdLRStrbThS?=
 =?utf-8?B?bklrbC9WSm9PckhXeDdJVjNLVE5zKzNoSE93MndjZjdYN2RRU2wyZTYwYWdJ?=
 =?utf-8?B?M2xoWHdkYm9yWjc2akFibHVKc2JEazlvOGNVRU1MYmNJa29ETGROT3dlQXhl?=
 =?utf-8?B?VDZZeUlqRnM0V0QySS9uSFJQYXFZRGVxcE1JVXZDclhYQnZJZU9BaGZteFJu?=
 =?utf-8?B?emM2UkEwYjdrK1MwdTNwRkFOVWEwVUc3L0tRQng2YTNKOW5tSU1NbW82TGs2?=
 =?utf-8?B?R3FkZ2hhTGcxN09uc3dXbDNJaWxyRDRZYmhPajQ2b0lHcGVLcGdzU2pxQzcz?=
 =?utf-8?B?VUV4S2xxd1IrcXlIN1gzQmxYdlhvREFkTTFMSFpTVWF3cSs5biswOUlVVW8v?=
 =?utf-8?B?MXBJajhRS2psRUdpK0VNdGFFZXBOT1VBakt3ekNZN1BFNWRmMWpHMGZJUGRv?=
 =?utf-8?B?am94YTBVenQ3b0Qrbm1DZWxlSlNHZXFBdFRITldSOXNidU9hTVFqU3hyTE8z?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <006BF04DC22B0749BB0CC1AFC42CF8F7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3879c0a1-c5b3-4857-12b8-08dc49823e3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 08:38:11.7918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6EG3hN6pUqqgq5/w2dUf+8qudvRzAM+qk3Od8NXZj0U80SPOa+GC9uNPE7eqtC5P8Fs0fyV+wWUgZMxPtXtKjDw9Q0/31oWLK3/GNVwNXu1L40U2v0096nG4CEn9xYG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8552

SGkgS3J6eXN6dG9mLA0KDQpPbiAyMC8wMy8yNCAzOjIzIHBtLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDIw
LzAzLzIwMjQgMDk6NDAsIFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPj4gSGkgQ29ub3IgJiBBbmRyZXcsDQo+Pg0KPj4gUGxlYXNlIGZpbmQgbXkgcmVwbHkgYmVs
b3cgYnkgY29uc29saWRhdGluZyBvdGhlciB0d28gZW1haWxzIGNvbW1lbnRzDQo+PiByZWxhdGVk
IHRvIHRoaXMuDQo+Pg0KPj4gT24gMDcvMDMvMjQgMTI6MzEgYW0sIENvbm9yIERvb2xleSB3cm90
ZToNCj4+PiBPbiBXZWQsIE1hciAwNiwgMjAyNCBhdCAwNzo0ODo1N1BNICswMTAwLCBBbmRyZXcg
THVubiB3cm90ZToNCj4+Pj4+PiArZGVzY3JpcHRpb246DQo+Pj4+Pj4gKyAgVGhlIExBTjg2NTAv
MSBjb21iaW5lcyBhIE1lZGlhIEFjY2VzcyBDb250cm9sbGVyIChNQUMpIGFuZCBhbiBFdGhlcm5l
dA0KPj4+Pj4+ICsgIFBIWSB0byBlbmFibGUgMTBCQVNF4oCRVDFTIG5ldHdvcmtzLiBUaGUgRXRo
ZXJuZXQgTWVkaWEgQWNjZXNzIENvbnRyb2xsZXINCj4+Pj4+PiArICAoTUFDKSBtb2R1bGUgaW1w
bGVtZW50cyBhIDEwIE1icHMgaGFsZiBkdXBsZXggRXRoZXJuZXQgTUFDLCBjb21wYXRpYmxlDQo+
Pj4+Pj4gKyAgd2l0aCB0aGUgSUVFRSA4MDIuMyBzdGFuZGFyZCBhbmQgYSAxMEJBU0UtVDFTIHBo
eXNpY2FsIGxheWVyIHRyYW5zY2VpdmVyDQo+Pj4+Pj4gKyAgaW50ZWdyYXRlZCBpbnRvIHRoZSBM
QU44NjUwLzEuIFRoZSBjb21tdW5pY2F0aW9uIGJldHdlZW4gdGhlIEhvc3QgYW5kDQo+Pj4+Pj4g
KyAgdGhlIE1BQy1QSFkgaXMgc3BlY2lmaWVkIGluIHRoZSBPUEVOIEFsbGlhbmNlIDEwQkFTRS1U
MXggTUFDUEhZIFNlcmlhbA0KPj4+Pj4+ICsgIEludGVyZmFjZSAoVEM2KS4NCj4+Pj4+PiArDQo+
Pj4+Pj4gK2FsbE9mOg0KPj4+Pj4+ICsgIC0gJHJlZjogZXRoZXJuZXQtY29udHJvbGxlci55YW1s
Iw0KPj4+Pj4+ICsNCj4+Pj4+PiArcHJvcGVydGllczoNCj4+Pj4+PiArICBjb21wYXRpYmxlOg0K
Pj4+Pj4+ICsgICAgb25lT2Y6DQo+Pj4+Pj4gKyAgICAgIC0gaXRlbXM6DQo+Pj4+Pj4gKyAgICAg
ICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsbGFuODY1MA0KPj4+Pj4+ICsgICAgICAgICAgLSBjb25z
dDogbWljcm9jaGlwLGxhbjg2NTENCj4+Pj4+IFRoZSBvcmRlciBoZXJlIGlzIHdyb25nLCBsYW44
NTYxIG5lZWRzIHRvIGNvbWUgYmVmb3JlIHRoZSBmYWxsYmFjayBvZg0KPj4+Pj4gbGFuODY1MC4N
Cj4+Pj4gSSBkb24ndCB0aGluayBpdCBpcyBhIGZhbGxiYWNrLiBUaGVyZSBhcmUgdHdvIGRldmlj
ZXMsIGFuZCBoZW5jZSB0d28NCj4+Pj4gZGlmZmVyZW50IGNvbXBhdGlibGVzLiBTbyBpIHN1c3Bl
Y3QgdGhlIC1pdGVtczogaXMgd3JvbmcgaGVyZT8NCj4+PiBJdCdkIGp1c3QgYmUgYSB0d28gZW50
cnkgZW51bSB0aGVuLCBidXQgSSBkaWQgdGFrZSBhIHF1aWNrIGxvb2sgYXQgdGhlDQo+Pj4gZHJp
dmVyIGVhcmxpZXIgYW5kIHNhdzoNCj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2Vf
aWQgbGFuODY1eF9kdF9pZHNbXSA9IHsNCj4+PiArICAgIHsgLmNvbXBhdGlibGUgPSAibWljcm9j
aGlwLGxhbjg2NTAiIH0sDQo+Pj4gKyAgICB7IC5jb21wYXRpYmxlID0gIm1pY3JvY2hpcCxsYW44
NjUxIiB9LA0KPj4+ICsgICAgeyAvKiBTZW50aW5lbCAqLyB9DQo+Pj4gK307DQo+Pj4NCj4+PiBU
aGF0LCBhbG9uZyB3aXRoIG5vIG90aGVyIG9mX2RldmljZV9pc19jb21wYXRpYmxlKCkgdHlwZSBv
cGVyYXRpb25zDQo+Pj4gbWFkZSBtZSB0aGluayB0aGF0IGhhdmluZyBhIGZhbGxiYWNrIGFjdHVh
bGx5IHdhcyBzdWl0YWJsZS4NCj4+Pg0KPj4+IFlvdSBjcm9wcGVkIGl0IG91dCwgYnV0IHRoZSBw
YXRjaCBoYWQ6DQo+Pj4+ICsgIGNvbXBhdGlibGU6DQo+Pj4+ICsgICAgb25lT2Y6DQo+Pj4+ICsg
ICAgICAtIGl0ZW1zOg0KPj4+PiArICAgICAgICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxsYW44NjUw
DQo+Pj4+ICsgICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLGxhbjg2NTENCj4+Pj4gKyAgICAg
IC0gZW51bToNCj4+Pj4gKyAgICAgICAgICAtIG1pY3JvY2hpcCxsYW44NjUwDQo+Pj4gU28gaXQg
ZG9lc24ndCBhcHBlYXIgdG8gYmUgYW4gYWNjaWRlbnRhbCBpdGVtcyBpbiBwbGFjZSBvZiBhbiBl
bnVtLA0KPj4+IHNpbmNlIHRoZSBvdGhlciBjb21wYXRpYmxlIGlzIGluIGFub3RoZXIgZW51bS4N
Cj4+IEFzIHBlciBBbmRyZXcncyBjb21tZW50IGluIGFub3RoZXIgZW1haWwsIGJvdGggTEFOODY1
MCBhbmQgTEFOODY1MSBhcmUNCj4+IHR3byBkaWZmZXJlbnQgdmFyaWFudHMgYnV0IHRoZXkgYm90
aCBzaGFyZSBhbG1vc3QgYWxsIGNoYXJhY3RlcmlzdGljcw0KPj4gZXhjZXB0IG9uZSB0aGluZyB0
aGF0IGlzIExBTjg2NTEgaGFzICJTaW5nbGUgMy4zViBzdXBwbHkgd2l0aCBpbnRlZ3JhdGVkDQo+
PiAxLjhWIHJlZ3VsYXRvciIgd2hpY2ggZG9lc24ndCBoYXZlIGFueXRoaW5nIHRvIGRvIHdpdGgg
ZHJpdmVyLiBUaGF0J3MNCj4gDQo+IFNvIHdoeSB0aGlzIGlzIG5vdCByZWZsZWN0ZWQgaW4geW91
ciBkcml2ZXI/IFdoeSBkaWRuJ3QgeW91IGFkZHJlc3MgdGhhdA0KPiBwYXJ0LCBidXQgaWdub3Jl
ZD8NCk5vLCBpdCBpcyBub3QgaWdub3JlZC4gVGhpcyBkaWZmZXJlbmNlIGlzIHNwZWNpZmljIHRv
IGhhcmR3YXJlIGFuZCB0aGVyZSANCmlzIG5vIGNvbmZpZ3VyYXRpb24vc2V0dGluZyB0byBiZSBk
b25lIGZyb20gZHJpdmVyLg0KPiANCj4+IHdoeSBJIGhhdmUga2VwdCB0aGVtIGFzIGZhbGxiYWNr
IGFzIENvbm9yIHNhaWQgaW4gdGhpcyBlbWFpbC4gSG9wZSB5b3UNCj4+IGFsbCBPSyB3aXRoIHRo
aXMuDQo+IA0KPiBEaWQgeW91IHJlYWQgdGhlIGZlZWRiYWNrPyBZb3VyIHJlc3BvbnNlIGlzIG5v
dCBzb2x2aW5nIGhlcmUgYW55dGhpbmcuDQo+IEhvdyA4NjUwIGNhbiBiZSB1c2VkIHR3aWNlPyBQ
bGVhc2UgcG9pbnQgbWUgdG8gRFRTIHNob3dpbmcgYm90aCB1c2FnZXMuDQpNYXkgYmUgSSBoYXZl
IGEgbWlzdW5kZXJzdGFuZGluZyBoZXJlLiBMZXQncyBjbGFyaWZ5IGl0Lg0KDQpMQU44NjUwIGFu
ZCBMQU44NjUxIGJvdGggYXJlIHR3byBkaWZmZXJlbnQgdmFyaWFudHMgYnV0IGJvdGggaW1wbGVt
ZW50cyANCnNhbWUgZnVuY3Rpb25hbGl0eS4gVGhlIG9ubHkgZGlmZmVyZW5jZSBpcyBMQU44NjUx
IGhhcyAiU2luZ2xlIDMuM1YgDQpzdXBwbHkgd2l0aCBpbnRlZ3JhdGVkIiB3aGVyZSBMQU44NjUw
IGRvZXNuJ3QgaGF2ZSB0aGlzLiBUaGlzIGlzIA0KaGFyZHdhcmUgc3BlY2lmaWMgZGlmZmVyZW5j
ZSBhbmQgdGhlcmUgaXMgbm8gY29uZmlndXJhdGlvbi9zZXR0aW5nIHRvIGJlIA0KZG9uZSBpbiB0
aGUgZHJpdmVyIHNwZWNpZmljIHRvIHRoaXMgZGlmZmVyZW5jZSBpbiB0aGUgTEFOODY1MS4gU28g
DQpiYXNpY2FsbHkgdGhlIGRyaXZlciBjYW4gc3VwcG9ydCBmb3IgYm90aCB2YXJpYW50cyB3aXRo
b3V0IGFueSANCmFkZGl0aW9uYWwgc2V0dGluZ3MuDQoNCkxBTjg2NTA6IGh0dHBzOi8vd3d3Lm1p
Y3JvY2hpcC5jb20vZW4tdXMvcHJvZHVjdC9sYW44NjUwDQpMQU44NjUxOiBodHRwczovL3d3dy5t
aWNyb2NoaXAuY29tL2VuLXVzL3Byb2R1Y3QvbGFuODY1MQ0KDQpUaGUgYmVsb3cgbGluayBzaG93
cyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZW0sDQpodHRwczovL3d3dy5taWNyb2NoaXAuY29t
L2VuLXVzL3Byb2R1Y3QtY29tcGFyaXNvbi5sYW44NjUwLmxhbjg2NTENCg0KV2l0aCB0aGUgYWJv
dmUgZGV0YWlscywgSSB3b3VsZCBjaGFuZ2UgdGhlIG1pY3JvY2hpcCxsYW44NjV4LnlhbWwgd2l0
aCANCnRoZSBiZWxvdyBkZXRhaWxzLg0KDQpjb21wYXRpYmxlOg0KICAgZW51bToNCiAgICAgLSBt
aWNyb2NoaXAsbGFuODY1MA0KICAgICAtIG1pY3JvY2hpcCxsYW44NjUxDQoNCkFuZCBpbiB0aGUg
bGFuODY1eC5jLCBJIHdvdWxkIHJlbW92ZSB0aGUgYmVsb3cgbGluZSBiZWNhdXNlDQouY29tcGF0
aWJsZSA9ICJtaWNyb2NoaXAsbGFuODY1MCIgYWxyZWFkeSBzdXBwb3J0cyBmb3IgTEFOODY1MSBh
cyB3ZWxsLg0KDQouY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuODY1MSINCg0KTGV0IG1lIGtu
b3cgeW91ciBvcGluaW9uIG9uIHRoaXMgcHJvcG9zYWw/IG9yIGRvIHlvdSBoYXZlIGFueSANCm1p
c3VuZGVyc3RhbmRpbmcgaGVyZT8NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCg0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo+IA0KDQo=

