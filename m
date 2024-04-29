Return-Path: <linux-kernel+bounces-162149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B8F8B56B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A291F2163C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019CE482C2;
	Mon, 29 Apr 2024 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FSXlagds";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y4NP+F7r"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E346B8B;
	Mon, 29 Apr 2024 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390285; cv=fail; b=P9e2Z9UECFnclKHucMrYIrz9WTrdIaWC7Wx8hz5DUM+Mt4fQ/+rqKhcNDgRE34zER6HOoyZ+1mIJmx+4RchPbt8iIBjd811eLt0YtEMQjOtPYqlEEMEpCi2fjbsqfoxJ7J8jcxR6eC2SCQJrDahIoCwrBcfLI/1UcanIAtvD360=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390285; c=relaxed/simple;
	bh=hczI5IG5VjMSJN2hcAb3uWeqN+QWOAfq+cp+O+17uMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IsFNV52BaHcdxeCAADuoAavV900L7nqgS3Y6EPgd4whByUWWqBKRLOULIhexZgJrku+M51ycVLdotrsfDqN5+/BT4+DRhpOX8rv4q0rJ7YuQVSER2KkHq08J06BtwpngPdRj/kb9pSBTv1FhciXh1F+HoH3FZli+LTStw9xeZbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FSXlagds; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y4NP+F7r; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714390282; x=1745926282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hczI5IG5VjMSJN2hcAb3uWeqN+QWOAfq+cp+O+17uMI=;
  b=FSXlagdsIeoRdhbPYqrpYdmSVpwgRgglXe/pOQgsIn0KUmz/4Cr31z6/
   tANiRftgzLFzGHh3ly97+bG2Ov3Qg43diuiKcXNtDRCwxlPDxnMcVWROR
   fV4sa/ntU95LXC0Ioq/hDCEsLICqx8gh0N7uLhoKxUJxSM5zjuB4NhIEX
   RJpoHKFfvuxMm117Zw9g1JXl1Rar3zTsR01tltjQaipMijtwbjjmHbtg4
   bDwDHcNHpfzhzl/sbbsxRUCLbSYji9uNW10dugsvDn83eJdxFUJPg/OMv
   3lnSQrtLRLRVfBbUVcb/aHH7VMq5MhqV6NrMd5jPMbPdxCn6d2QphF3nh
   w==;
X-CSE-ConnectionGUID: S2uky9vbRNCr1gHksCJX6w==
X-CSE-MsgGUID: JH4gzTM+RyOSdLastgjj7w==
X-IronPort-AV: E=Sophos;i="6.07,239,1708412400"; 
   d="scan'208";a="23164977"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Apr 2024 04:31:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 04:31:11 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 04:31:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdLZxN6HpMHtUTGX9ROA2IB/RZSFFNeJpFaW7QH0sgrAbtw3eEHJZhEjfVY++eguBDNEKzIxJ6H+V58+LbEPeihpCLuNX7lWZdSBS1oHgIL+w760cJ3SzuN5pSJ8swZOk38T5AGNL7jQrROSlf57R6jWgHWEopMiZIRnlgtWmSlUFD8lXYuz7x39WVkwSQmelu/x2YAvl+dCJS30nLtDq/mMm2JlXpXmmAZaKrcB+Gpsz2YRS3GEjEeZNnFF+R49Wb/h9OceIGraWtA29OStqiT0kQem7Ro5Hqxo05i0GsgEoyAmFGeyrV1QDWxayU2SuZzOPfZefdTuMCpyqsQ84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hczI5IG5VjMSJN2hcAb3uWeqN+QWOAfq+cp+O+17uMI=;
 b=XQs3MZRIAyjV5lRq62/C/DPYOipGai3Yphc2lZeMVLIB3FR6mKGImfz3atDtJecd9O7D5vfWkjLlkdCxqMapotRTRyz7rsBhca7eA6VdkK4se6Kr7Xf/oJDqQzwLozX/E063eRZaEIJJr0qMsXzU6ftWnNzjsaW2RsYQvFHPDyen+kdq2FAGClF7H4E6qz5DVL/0Ejh7lRWbLOPUWb5WSybieBLE+4nXS4ftR9CtKbfbTYAGI1UzjCiCpU+auq+W5KzUrA3VKYvpAiRlULKBtO9xVz5BNKcyMqAI0oOMrfPCDYbiZQMOvIY4FLryU92xmzSP4Z+AXR4W8SQYerGgwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hczI5IG5VjMSJN2hcAb3uWeqN+QWOAfq+cp+O+17uMI=;
 b=y4NP+F7rn2MGyTF+9s/6Jn+AY7XbNZ0pkgy+u9pvJlKINyQrmR8ZTDpZwZ0aHMZcTHQQiine7mqBbJ5MDnKISgRw0KTcbcT1R2tBfKPFa+QI0avQabplWCs1XctU+BeJ9Py9tzpZ0OG6DxpC+S8Rfhb1GT0kqsLXoV0ynTWDUKN7gTGJapXGg7Hjvpwqy2tWtiM6LT1OctK06cDXg/az+rtTBAra/ECNY7cAuB/0ORVHt6hhFqNpPPa+ndrhm7zYumSsPqKCi05595L4g9HNlD9tDq9NgNWKFtTg4T463EMKICuylidTOCoen6CV82DMIqP1hS1T6+hhR3SO2fD/JA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DS7PR11MB6078.namprd11.prod.outlook.com (2603:10b6:8:86::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Mon, 29 Apr 2024 11:31:08 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 11:31:08 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <bagasdotme@gmail.com>
CC: <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v4 01/12] Documentation: networking: add OPEN
 Alliance 10BASE-T1x MAC-PHY serial interface
Thread-Topic: [PATCH net-next v4 01/12] Documentation: networking: add OPEN
 Alliance 10BASE-T1x MAC-PHY serial interface
Thread-Index: AQHakY/6sQRIWqa8eEy+60OQ1lk9aLF9eykAgAGzF4A=
Date: Mon, 29 Apr 2024 11:31:08 +0000
Message-ID: <a5b0a3bf-889e-4b7b-9483-7caad4f6de41@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-2-Parthiban.Veerasooran@microchip.com>
 <Zi4X8NO9SkhffJ98@archie.me>
In-Reply-To: <Zi4X8NO9SkhffJ98@archie.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DS7PR11MB6078:EE_
x-ms-office365-filtering-correlation-id: d25692d4-13cf-43e5-ee11-08dc683fdd39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?b0tjRzVTQUhONlVTQUVLR3U2clYvRGFwU1BlRjJHL0JkZDVkemZPdUVUcnp1?=
 =?utf-8?B?Mk4xNEtuU3RsTituRjdwcnR3aytSSTBJTTNBbmE3R1VKRnpLQnoxQkNXbDcr?=
 =?utf-8?B?cHdWNEhIK0IzZ3JvTkJmamRqbWVzWlBMSk5DTk5nMXExTmFsY1dwc3hXYm85?=
 =?utf-8?B?blp5TW5YVnZ0NkR6UmtHSnBvQS9nYmhSNDAxMGFwMFdOdHVvL0NsUzVkTkJB?=
 =?utf-8?B?VkttSEd1V3FTTHUxSFVYTkxLblNwVkVOZFRQTXJoQVhIKzBCd3hkNGRDM0tF?=
 =?utf-8?B?MTljRHUxSTkzemNUMC9Dd0lBRGF3NUZ3UXR2bmNQSWFDMHZhdFpsYmVBZEtM?=
 =?utf-8?B?RHd3d0ltZXpUREZ4MlB0VTdicXI0cENwcW1IUk5FV1Y2ZFpwZVRLNkplcHRw?=
 =?utf-8?B?bWdnUWZlTXA3S09hdWdGQ2ZFQ0tibFp3ZHl0RXVZamZPTmlIaFZZb29pYjZ2?=
 =?utf-8?B?L0VsVWxVQlNKS0FkcEhlMWE3UEU2aHBTTktnbDB3dFJhMWdJNmdJK2QremNS?=
 =?utf-8?B?eHRoVUZLMWNuQzZ6WXdlR0drMjBGOVBCcllmdnJnbm5pU0tYQVN1RkJ6UTN0?=
 =?utf-8?B?VGYvSnVBZTBSUjI1QVJjbzZVSWNmbTkvVnowVDBtaGxXcWkwQ0JXT1lEYndT?=
 =?utf-8?B?d0RCQTZXanhPL1VHME85NlQ4NnhDQWNYTUV1TWhITHFwVnovdTVEeUthV2Fo?=
 =?utf-8?B?Y0FLRWQ1S1F6R2ErY0IxaEN4NWdDeExPUDB1UmRHMm00UnlBTW1DeENXSXBk?=
 =?utf-8?B?eFBsaUh6WTRlcUVYaFIwS2ZZRENHaG9Zb1UwOVJnYVAyNVBZLzJ1dTRod3Vn?=
 =?utf-8?B?R1VxWmhSeFRUaDk0TGZRdTJZa0ZDR3g0UnprL2RvMTZ1NjVuWVYrb29JdlBC?=
 =?utf-8?B?VVJzM2xRb3BCNWNQNTdoa21DQVJvTmUxSnFCTHhmWnVCRVpkb2UvNGVBeG9x?=
 =?utf-8?B?eHpVazVLd2YxTEpoODBFY0xyY3JDNXF4emVqai95UGpaZHlXeVZKb09OQ1hH?=
 =?utf-8?B?bmdXTG4xUW13YW84dEdoVzgvMHdCTS9YamxDWVp3dTJJU2hMTEJoMUpCbGt3?=
 =?utf-8?B?ZVFFZm5GVlE1VU56eUN4dFMzdHRidVdUcDVjci9QVlRDdHg4UFA2STk0cVpG?=
 =?utf-8?B?QzBvVHRJVndEaDdraTJ5dmxLQllUZWpsdC9kR2t3d3VEMnlYSWhaMmV4QlJR?=
 =?utf-8?B?dmUxR1k4SmN3REZUQTlKZXFvS3V5TUZtNjUrMzVVWlBhV0VySmpDcUxKYXVq?=
 =?utf-8?B?MThhcThMNHpWU1VQakMraExPVEpMK004VzVNWTRWang1MkUybDlMN2lwRjFI?=
 =?utf-8?B?MTFaS25JRnE2d0cxM1M1OTIyeFZBakJ2MXc5dnpqdllHSXlUNG4zTld3R0pS?=
 =?utf-8?B?VGVRNThva3I0cjJsbllISVlFQk1ZUXhCWGsweUVFL2xmZ09xQkFqVkhBMTU1?=
 =?utf-8?B?MTR0V05jS1dEd1R2RHE1a1hEQjVwV3gwNS9vUnBIUHBYQUpnTHArYnQzN2s4?=
 =?utf-8?B?aC8zaS9PUnNoelI4cjBOM01lNTFCSnd3RHBwblNQRnZXMC9Rb2dDa2JCZ0dq?=
 =?utf-8?B?TU1oMVVHWG1mY2NhdGlXNXg1RFdlMjhlK0FiRVoxNEdPTEw3WjliSUdWYnVU?=
 =?utf-8?B?QmFjTTAxajBjbHFrdEJFWk05YWtpQ0FKWFI0cDBXQTRRMlhVM3d0NnhKV0ZQ?=
 =?utf-8?B?T3A2cU9BcXdLL1dKbm1SZG12MjR6UlNjVnY3N21IMXQ0YUFMNzYyOGVCR3NL?=
 =?utf-8?B?WVhDYXJ5NWQ5eVg3Q2NLai94KzJBb3hKQllMK0dOLzYzYmNhV2RWN0Q1ZTE1?=
 =?utf-8?B?OXk3dkJvVEM4TUt1MjFBUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3k5cW1yQnJmL1B6bXA0T2dDcmJQYkxDcHp6MnpEYTJtYjFNV1F1SzRUSXU5?=
 =?utf-8?B?cHd1RDI3YitkTTFWaURaVUJ4NFFxbWpnZ2ZSTW11QU0vM1RIcUFGN2ZROUxZ?=
 =?utf-8?B?cVBGYllZSjMzSlhqckZaOTRscU1ucFhPUmVUUk4rSE9rOUNqUTE1cnVzZzU4?=
 =?utf-8?B?bmJOdFlwejdKN1djVUxoWFZ5R1QwcHZMS2FRdm5ZVlUvTzNoaWFsNEVtOEU1?=
 =?utf-8?B?L1JQcmdSd25RMXdzWm9iZ3JRdWhSMG9pbk9iSDl4bEZrRHRkc2tpN1BIZlV0?=
 =?utf-8?B?Mm1hZkozeW9sNlJuTWlHRk84OTFRd2p5UnRZZXZFcEkzdHc1aEs1M3Bmbytl?=
 =?utf-8?B?RVRlQ2RqQkJQZjkxdytiSkx1eFJQZk5sUENsK2NZSElFdFplSEJZMHRJdmNH?=
 =?utf-8?B?UmFGYmhOKzdTSzFRNkc0Mlc5WFRSakNlZmxPTkNLUFhGL2ZVOUVDLzhkK0Rz?=
 =?utf-8?B?K2JJYXloaGxWZmxVdTlNSnAyVWxwS0FOSUZlUzNjcHdkUU8wa085Slh0OGhN?=
 =?utf-8?B?SVI5Y3A0Zy9UbWZTZEJYSEVxdzRnYkIySzlhZnZqQy9QTVRaZU1WVjZyTXhX?=
 =?utf-8?B?NVR3L0ZqQ1lGQUlNVFZwaFRwaEhYRnd4Z1dOUkJZNG9NV0F2U0F1c29zV01D?=
 =?utf-8?B?Q29EWEw2Q0VJOHh5UE5PRFZKWXJMb0dUWG81NVhKZzcrU3BxT1AxRFhFUEYw?=
 =?utf-8?B?U3ZFWWdxdWNEMnhLdEV4Vm9JQmUraUltWTN0dkplOVdKdVZJN1JDcldWNThk?=
 =?utf-8?B?VFdCQ0JvREZuYnQ5Tm5iWktnbUNkUURCQkwwZGNOMTVGMUlHMkZyMWVmU0F5?=
 =?utf-8?B?dGh1ZUFvOTFDd3Y2Wmx0QnkxTU8way9yazkyZFROQitqdnNEaWducS96WVNI?=
 =?utf-8?B?M1hib3plelJPMEFxa1RyYVRJeUltQUVJUjM4eldTU1grbHNBb3FBd2owbXNN?=
 =?utf-8?B?UlFkMmtGTkU1c2t3SWhmUU9jSlVPVDQyVG5BNVdISnhYcll5T2RlV2xnL21j?=
 =?utf-8?B?NEJnclVBQ2pKYTVDa25abk9xWjJSQTBLOXBjM1hyYkpiUjdHbi9rdjdEZXZF?=
 =?utf-8?B?NS9zeU00UnVuTXduZjlzeHNXTDdjSnNZZXVQOWhXZ0xMNVRwblFUUndwbEJ1?=
 =?utf-8?B?RmpzUi9FajRqY1RFdjRZMzd0OUJCdjBBdGkxeW5OeUgvN3lPLzhYOVdHaHRX?=
 =?utf-8?B?UkNXTnpqVHhGNFI5djB6bmRnYWxaalBmT1cwTk5EUnJaaStwaUNSN2JLS1lS?=
 =?utf-8?B?bE1ZZXkwRGNxTFFMT1ZUMUlHUFc3Q0R6RytWS3F6bFNVQ0c4TjBHOTkvZ2hr?=
 =?utf-8?B?YjVXM1NKNDRFNjQ2NFdpVTlpN2ZVYzM3MFZlT2VMMXZ3T1d0QkpzdUJGVVFG?=
 =?utf-8?B?U3JSdnNCVFpVbGlCM01ORUd4cnZoOXdPQm1saUFFOVlsckpFOEFjeVZKRHp6?=
 =?utf-8?B?akVBSnRtTkw5ODBKbnQ1TUFMcFJWbU53SGNMeVVSZzFOazQ4NDRpVXFQR05u?=
 =?utf-8?B?aTRuMjhNNzNJdnp4R09oaUlnaTA3U0xnbFVGZzBBVFNtWnVlQWxURnFheTJX?=
 =?utf-8?B?WitWbldISS9SaDczbSsvdFpzTFB5SDgvejFBTCt0SFJjdDF2c1BSUlgzU0ty?=
 =?utf-8?B?QkRPbHJUTENHcEJsQmw3MW9HcUFHNjJqWkw1SGZueUV4c3ExYWxEYkNZb081?=
 =?utf-8?B?aDJhYzlCZGdXTmNRaUgrcUptWHFQTU9iMlpQNkZKcWV4SnJFZy93azdjWTV1?=
 =?utf-8?B?dXQyVUlLZnZYNnJPVENCU3JONnFtbUFxa1hXOEhtSXVpWWgyYTJIUjVqTmFP?=
 =?utf-8?B?dWRraWV0d0Jlc2V0bVlkWEFNVkJ0S0tUeWtMcm9sRGY2UzJJb0hISmpUNzY4?=
 =?utf-8?B?TWJwSGxzZnNObmQyWjVFSlhzUktCeWpHeHJzMGtGRm9ic3lpdGhxbjFtaVhB?=
 =?utf-8?B?RFNjcmhzSUhXUkR4dnJvSkI0dlozVWRkdGRnMG1vOWc3ZFliNUdxZXJJODNh?=
 =?utf-8?B?cFFwcWROeExrc1c3UmkzTWlMWTZ0WUxnaWdDdVpwbVhwcU04bHplTE5rMFZm?=
 =?utf-8?B?MzV6VVp6Q1VWY3EzZjVnT1lzbkNXVUR2SmVDQTdyL0t0Uk9DWFJtQXhBbkZv?=
 =?utf-8?B?dHp2dGRqNWxsblhKYXhkcHYyVExvN01ONUlDZm9aSHpvNXpqUzE5M25LYnVh?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95AFF7683DD6BA488068C87A63A7CED0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25692d4-13cf-43e5-ee11-08dc683fdd39
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 11:31:08.3302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: roCqHUoqpx8Wrv3wsQFnhVRBXA7kzx+Yvm5SZzFd5hHDDjpNHdiApC/biHHbtMZiniPxfn2MZLN4DCwA9SURVuByvQsaR3801Dc3Mj9zWKSaCtrq1WwXfuNUQ5aSZaHS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6078

SGksDQoNCk9uIDI4LzA0LzI0IDM6MDMgcG0sIEJhZ2FzIFNhbmpheWEgd3JvdGU6DQo+IE9uIFRo
dSwgQXByIDE4LCAyMDI0IGF0IDA2OjI2OjM3UE0gKzA1MzAsIFBhcnRoaWJhbiBWZWVyYXNvb3Jh
biB3cm90ZToNCj4+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+PiBp
bmRleCAwNGU1ZjdjMjBlMzAuLjc5ZmE3YWJiNGVjOSAxMDA2NDQNCj4+IC0tLSBhL01BSU5UQUlO
RVJTDQo+PiArKysgYi9NQUlOVEFJTkVSUw0KPj4gQEAgLTE2NDAwLDYgKzE2NDAwLDEyIEBAIEw6
CWxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+PiAgIFM6CVN1cHBvcnRlZA0KPj4gICBGOglk
cml2ZXJzL2luZmluaWJhbmQvdWxwL29wYV92bmljDQo+PiAgIA0KPj4gK09QRU4gQUxMSUFOQ0Ug
MTBCQVNFLVQxUyBNQUNQSFkgU0VSSUFMIElOVEVSRkFDRSBGUkFNRVdPUksNCj4+ICtNOglQYXJ0
aGliYW4gVmVlcmFzb29yYW48cGFydGhpYmFuLnZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+DQo+
PiArTDoJbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPj4gK1M6CU1haW50YWluZWQNCj4+ICtGOglE
b2N1bWVudGF0aW9uL25ldHdvcmtpbmcvb2EtdGM2LWZyYW1ld29yay5yc3QNCj4+ICsNCj4+ICAg
T1BFTiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVEIERFVklDRSBUUkVFDQo+PiAgIE06CVJvYiBIZXJy
aW5nPHJvYmgrZHRAa2VybmVsLm9yZz4NCj4+ICAgTToJRnJhbmsgUm93YW5kPGZyb3dhbmQubGlz
dEBnbWFpbC5jb20+DQo+IEkgY2FuJ3QgYXBwbHkgdGhpcyBzZXJpZXMgb24gdG9wIG9mIGN1cnJl
bnQgbmV0LW5leHQgZHVlIHRvIE1BSU5UQUlORVJTIGRpZmYNCj4gYWJvdmUgKG9uIGNvbnRleHQg
bGluZSAxNjQwMCBJIGhhdmUgT21uaXZpc2lvbiBlbnRyaWVzKS4gQ2FyZSB0byByZXJvbGw/DQo+
IChIaW50OiBhbHNvIHNwZWNpZnkgLS1iYXNlPSB0byBnaXQtc2VuZC1lbWFpbCgxKSBzbyB0aGF0
IEkgYW5kIG90aGVyDQo+IHJldmlld2VycyBrbm93IHdoZXJlIHRvIGFwcGx5IHRoaXMgc2VyaWVz
LikNCk9LLiBXaWxsIGFkZCB0aGUgYmFzZSBjb21taXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0K
SXQgaXMsDQoNCmJhc2UtY29tbWl0OiBiMzA3ZTI1ZDRlNmQzNDFjZTVhZjg2ODJkNTkxM2M3MDY1
NWQxZDM2DQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiBDb25mdXNlZC4uLg0K
PiANCj4gLS0gQW4gb2xkIG1hbiBkb2xsLi4uIGp1c3Qgd2hhdCBJIGFsd2F5cyB3YW50ZWQhIC0g
Q2xhcmENCg0K

