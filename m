Return-Path: <linux-kernel+bounces-167299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CF88BA76D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2BF283119
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2E8146A7F;
	Fri,  3 May 2024 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vnKjB4Lg";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hI2Q7ufc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F30139596;
	Fri,  3 May 2024 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720246; cv=fail; b=aJ/se40cVk5Aog3H9EMlTFPG92xABDaTDby8Hf5MAfI0pg7DglpMUVzarSUER5C450HHBuVfnC2zz00wTO6+Xg7amHOVOqnLYV2r9e0DwBn/ko7cpCxDCKczJPkgguzO0Vqia5gA9DS81zq5GknZNeKDACSei5j1a0aPQeXb1G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720246; c=relaxed/simple;
	bh=+afnBuRvsc/gtJt64oMTXel37HbCnjf/7hw1earVyQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DkNbq7nOcCYrp0D+ZTwVmNK065r3TscPvqiCM6040XXakiH+Mk4WtICnnfEXt9G3Fyla8PhF75YcOQeV0//TzrRb9Mh9BY4lGgXwrv4NQjKnSoACMYB+9ioTH8CKcQauChLPo0mxqVwhc3T2JTQmKkdhrFAVT336hy2/w0OiW18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vnKjB4Lg; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hI2Q7ufc; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714720244; x=1746256244;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+afnBuRvsc/gtJt64oMTXel37HbCnjf/7hw1earVyQY=;
  b=vnKjB4LgN+yOBeFz4y7In1jFYIaUgXAs/lwPItPtN0fLIcUpfC7DTLb9
   vw/7BiU1mvSIeVPLxIZnYmRN0zoDXJAkeL6GOrtUsw0swsaVp4IysM2VE
   Hr4YS+o18gEFWdTb1PGz64GtuCLO6MJf+xfvjXUWtCySyDZXIr1VBiKZp
   QryDXdm6Tp6R/E9WOcrJGa8qgs+K4rteobHYjvJF8Ee2tXvicTyFUapuu
   tFRFpsfawZjBcgK6DqnqsLFpYXRn8Sdgsd8DRVHRhqpeDFhof5emfCf9h
   0VW2cBhlOGQTRq0FPQFToLvkwIBfB4UEasggsp1yOunAWDFsyIQmI3JrS
   g==;
X-CSE-ConnectionGUID: Hx+33qEHRnCYIvWSY1f22Q==
X-CSE-MsgGUID: BJr8617+R4WTvGG4X/LFxQ==
X-IronPort-AV: E=Sophos;i="6.07,247,1708412400"; 
   d="scan'208";a="190801486"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2024 00:10:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 00:10:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 00:10:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuEjyDJHj4kuLuVZ620zAf86vzTSoFebuic7nYoRxE6/9sVVV3YnodnV+z3SHKvCe6ZrLa2ok8eU9yhbEQHJi+4W2BjVvVlKZEX1sLnJ0d1JFa4Dg9bUjmS+40JqCFEdoxhUn4FNsbd+7H15I7TBSC1kGYGFKa3GVeJyP/DSqh9b3N+Z3TT+2proLujhhLDzCxJpq6cLKPGW8RbJK3L8zCk53YAonM7tMyOTIWryoYhPM/cWyMi7BTHfwjy9sRlXMWU0tU3af64vV5/isDH/e7KIWeZy9yE3prNXRQzOeUyJ04srnmDcMqmXe23jvwRThS8rBEIGx6FWF4CFPWeRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+afnBuRvsc/gtJt64oMTXel37HbCnjf/7hw1earVyQY=;
 b=a3EdUc+7hPg5E/rV0Hdva7cJbHpBloyJ72ZJM6faIYF9I/gPSTgii73o50DWb0jwXp+N5AJbwSMGR8NYR94NnZ9+09M43SwjityIpJd7Xb+WE0MgW6rG7TmRHN+sUKZ9Q3TPPkciMBI4e/ejxgln94Tg159mNBob9a+tUR6Z6Uibm6LSM6DLcFxkzUBC73lkyEzs3cjFHpwe1tLoJf5gNP4ElaGI7wdnRA+l9mIxgbLsFVMycdw+x5zuhqWGu9AXgb0y6L2eszJ1KCpzzhB0mutuMTNsGhC5fGwD1M5EgCYtIM99Q9sBLm6cE4zWWGNnQj9b8r4BVDPuIBU3cYHLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+afnBuRvsc/gtJt64oMTXel37HbCnjf/7hw1earVyQY=;
 b=hI2Q7ufc+sR+aHX+l1HHJd/DlsME6qUf93kZq9DRPFzInwWifQMBE1KqrEgIBYaEPCfeouSbqn3+y2vkllsO7D0xOGsYdl2HpcL8lJ/8PRFec1EYYXxbiySesQafn8ThTIJJ3UBNXhjic2hHKbeMNJx03A4qvH2olb0aP19n2ogV9tN2dLaZdZYKttMKS5x9fktmEgZSFxmTthTmUlVdHw8bNQfqkD2YItsSDydpOHy5XIhi44dNkascSVmiIs4OsljWntLe4hbf98vXRcZ9ccDbCm8SC7E6BOrrfQjDxfgIsWxQjKHcWtos2bs8o5PHkpB0d2MHHwXNXSBs63VCfQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by LV8PR11MB8745.namprd11.prod.outlook.com (2603:10b6:408:204::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 07:10:05 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.031; Fri, 3 May 2024
 07:10:05 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <ramon.nordin.rodriguez@ferroamp.se>
CC: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Topic: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Index: AQHakZAQrurZHAw3l0Wxg+eFKGxGMbF8la2AgAAX2oCAANNtAIAAVU8AgATxiICAAQb4gIAAAoaAgAFdYYA=
Date: Fri, 3 May 2024 07:10:05 +0000
Message-ID: <ae801fb9-09e0-49a3-a928-8975fe25a893@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
 <Zi1Xbz7ARLm3HkqW@builder> <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>
 <Zi4czGX8jlqSdNrr@builder> <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch>
 <ZjKJ93uPjSgoMOM7@builder>
 <b7c7aad7-3e93-4c57-82e9-cb3f9e7adf64@microchip.com>
 <ZjNorUP-sEyMCTG0@builder>
In-Reply-To: <ZjNorUP-sEyMCTG0@builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|LV8PR11MB8745:EE_
x-ms-office365-filtering-correlation-id: 2648737c-f78e-4e72-c186-08dc6b400ef6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SVJNMThNVDZvNzlCYWpMaStlc3VPaHZEU2FmcDNsaFFNRytRQmhzS1llRk1K?=
 =?utf-8?B?dnBmdHFlYm5oWVkwZnBuNzFONHNaWGlYbkdtRGt2ZW1SZEdVcUhGeEI1UG9S?=
 =?utf-8?B?Wk8zZHR0Q2wvejkwR1N2eUU5Z1NrakQvSkgwamxBVXlaYjRYaEFqT2RSbXhH?=
 =?utf-8?B?aGRDbnVmRzZVanFKVE81TFRUK3BiRko0eEtLdjUyWVNJcWZhTjk4ZGVoLzdC?=
 =?utf-8?B?VnlDZmkwa0dPVWdTRUdjRzRWMjNhKyt5T3pPZnNCUGI1SURZWEc2UkxmK2w2?=
 =?utf-8?B?SDJaNlMxODZCVlZHbmZyaE1GYTNENEhZbEE1SzlRQnNtSkV0ZzE0MUlGWkp4?=
 =?utf-8?B?L241L1czTXFqK1VPamo5eU1tUkJnM3pua1o1c1dqVGJMU0s5L3lxUVYwaFl4?=
 =?utf-8?B?dGp3VTNCT0dFNi9rTkQ3MC9JSWRXMi9KWXFOZUt3YUg4Q1BPdlBFUTdweFBv?=
 =?utf-8?B?NGRyRUNSamp2UTI4UW9OUUtCbjdyeTdBdDZyQzVVWlhub3VyRzRTMk01NUJL?=
 =?utf-8?B?VStIdkNuNmVLa3BkQlBlZVJVTUtCdzc3cHY2RDVsQVNNeVVPRG8zR3A2dVgr?=
 =?utf-8?B?VXVUM205TmpUam9ub3l1NW9NcEdCNTg4OFNkWUU1L3hGanFDaFdnRlIxd0pY?=
 =?utf-8?B?eUtiVWJzQm05SU5ueUUvcXNPOEF3alJ1T29nM1h5ZjJaQWxLT1ZmTE4xZVV6?=
 =?utf-8?B?WXhuVFJkdlNnSVhGWnRKV1doK3UyNEkwT2Y5S3lrMm9mM0QrMVVhVFgvS2pt?=
 =?utf-8?B?YVBRYWgyU044U2ljZlFjb3phblVPQWpUWFJncEJNRzJyY3FNNlYwWmoyeFBM?=
 =?utf-8?B?N3VhVi9QcEdDZjB1Ykx3SzVld1RPK3ZkVE54VHB3Zks4YmwwSXNxNDdmcG8r?=
 =?utf-8?B?RkJkemhDSitZVG4waDNOMW5PVVk4ajJhb1BnNHhCMHd2bk9zYXdBSTRZODMv?=
 =?utf-8?B?aVBpNnU1REM3YkZzOENoMXowaWNVbUxSVm5Xa2JjWWl0NEJhUS9MdnhIT21n?=
 =?utf-8?B?SXp5Q3BHNE1DT2xuUFk1NWRiVjgvTkViZlZvdUVLV0NHNjZyVHlYcEtvb1BV?=
 =?utf-8?B?alVpUzYyWWU3a1l3Z3M4djN1VWhna1czM252QXhiTHpDUEErK3lhejNMb3k2?=
 =?utf-8?B?SVV0UjVzZVcwVkxjdm9NQ2xiZ2JOWmhsRHNNcE5paFVkMUxISmpLbkVnbHNY?=
 =?utf-8?B?MUtqY2s1TnJGdS9pZ0NKMUxHZGZxZ1VFcVh2Rys5Zk5Oek15eWFLN1NYeHZu?=
 =?utf-8?B?L09ZRjBYUG83TG9STjdLelBmWk9RVlBUY08xZ1RvQ3BSSW1sZHNqNEkydGhZ?=
 =?utf-8?B?Uy9aWmNaVGtEN05ldStaR2pNQ1hjaTZUUk0zcnVidzg3MUg0WTJReVlLK3o2?=
 =?utf-8?B?bFVGNkRTZ3ZQTHl3UHBRNnlodUlzeE1BVEIvazB2ZnhIV24xT0tueUtaeVFj?=
 =?utf-8?B?S0Nqc0ZWTHkvSFdvMmIweXFaYUJHTURIMFhaVy80ajBpUy96L1AvakNIcmFh?=
 =?utf-8?B?d3MxUm9xSnJmOExhVVMvZkt3Ylc4TlRkcmFaTjB6MFgwU1BwMHZ0SEtKM01l?=
 =?utf-8?B?dEwyMy9Jek82YmpKYTFvdGR6aC9vakNLUGhKNGxMaC96emVLSis3MmZmUHlQ?=
 =?utf-8?B?dGJMMGo3V0VGemY4ZWplVXFITzNGNUF5UTdZc0laN3ZTb0RHTmhmRU9tekhh?=
 =?utf-8?B?QnJrUE1ScmVLVmwzb3JUYXFUQ3pvZlpqUzNnTkFYTFVON2NYR3dVa3ZBQWIy?=
 =?utf-8?B?VXFGN2g2SThZN0pNd2hicUZDR3NkMDAzcnNqdHUxRTBuZTNiSVB3Rk00SGNa?=
 =?utf-8?B?VlhDZ3JWU0c5MUp4UlhwZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTJGZVl2SVYxQTJiZndIN0lRcTg0d0RaTDYvbEhKYjFjbnN3T1FvSFVkRUxq?=
 =?utf-8?B?R3BJUi9aZTdVQ1E4UWdtbHhQb200cjJUQUFpRDFFM01yc3owbTlEVUVnQzh3?=
 =?utf-8?B?a2h0V0FXOU45eVJUYXVNU3NVeTMwNmFkY3NXazFwL0FEcjN5ODByUG83VXly?=
 =?utf-8?B?NGtmdGY1bDU1VDZyb2drOGdreXFyVVdlQllicDA5cWdDWXY3QVlIbHhZUG1S?=
 =?utf-8?B?VFcxR1dRV2NKZERUd0RCM3pBWmdFaEM1bWhVZlNvOWNybW1JYjM2MFNoRGlY?=
 =?utf-8?B?SGs2MzNNSEwrVUZJUzkwZ3ZHa3g0enFNUXQ4TGgrcHNkZ2hhRjZNTVNVNGhl?=
 =?utf-8?B?N003Slh6KzV4UlhNUDhWcm4rMTBjK01nTXlqQjdOdHdOOTlGOVZKdWJIL1pK?=
 =?utf-8?B?NVRKTk9oOE15ZGJUMk10NWF2ZUxSTVBjMWRzUUxUclZ2UGF2eXRyWXprYlRI?=
 =?utf-8?B?M2h6Nm4wVnErVnR1bmgwc21aYVFoSWttRHJrN056SzVuZ0dvMW8xMUFHSXpl?=
 =?utf-8?B?TDRqYTRyVVUvWFZUandacUJUUmxUbkxOUXFnWDNVMWxvSEtybTU2NlU1NThL?=
 =?utf-8?B?NkJzZW1aMTg4WkxWaXNTeDJkSDJxSTFpbm00OE5rclQ5ZVNReVN6dy9iaEI5?=
 =?utf-8?B?UUZNem1NYXFTT3czbGtLTDYydjcxTVR6RUlUK2ZCV3p4d21ZS0pwTDlqNUhZ?=
 =?utf-8?B?TGxNbWljOHBjejJVMDVZVG9ubWh6V2UzZkNqVzN0Rk9zY20waFdxSTZFa0Ux?=
 =?utf-8?B?QzBPNC8rdndVbmFNa1o0Uk84ZVdpVGVxclpXMkplZGxmb0NLU3BWbmMrcUlW?=
 =?utf-8?B?Nm82azN6WWlaeHBHbnhZU2pPbTMzaWVpOTg1eWRubk5NNi9zNkpxMXVnNXRF?=
 =?utf-8?B?eGp3R3BuYzdGNm15aHdCSTFYdTdheVMwVFUxeVdMK3NTak9ISmovVlY4QklD?=
 =?utf-8?B?UWVpWEtPMGY2NXJkeUM3Smx6OExHeVFCSXdXeFRISHdtS2Y3aFA4SVROYWJS?=
 =?utf-8?B?emhVV1RKLzJrOGd0UUV6ektBaFMyN3ozckVvYTFvbXZucXA5MHEwZmR4OHZF?=
 =?utf-8?B?T0w5UVhLcW85SWJ0RERkRWk1MXlqUjV6ZEZ2SXllSHhMNzMyK1lWb3NCRUxy?=
 =?utf-8?B?NWEwbTdadjRFc0tsZ3g3UXZoak5od1pKRk1rSjN5dkJybUlOWE9Xd0N2T2Jy?=
 =?utf-8?B?Q3BzT1c0L3dvOWVsTHFUd3hMUm9sa2IwcC9hYm81bGF5QmpRdmNWNlE2OU9G?=
 =?utf-8?B?aExmZEpsSUhuSmk1MzVBTEN6MGZxMG5uUStHK3J1U1hJSTdRVUFZUHc0WnlY?=
 =?utf-8?B?QngzVllrUm1jUVY0ZWNab3ZOU0VNVGVSbTcwVUJMamJmRTg2RXpyajlEdFB3?=
 =?utf-8?B?TWhQdFIrY2NOWlVuMVB2bGdhVW5ZYVhyL1JocFFDRlFCWlE2cVdmT2pLdXlO?=
 =?utf-8?B?Q2tmSzhRY1BXSlh4VWFxc3lzV0YzVTNzSzFxS2tkSUVtdzlmNmZQWkJBaXZ1?=
 =?utf-8?B?NVRyMGdXK3hUd1ltRStIWWxxNlN2UmVtRXFmd2hTNGQvSU1jR1BXVG5ZVTc3?=
 =?utf-8?B?emwyaXFNSDhTdkZLZmRUWEtCd2MyWExMZDEvcWFuUjNSWWc2cjVEaWNadzlr?=
 =?utf-8?B?WFlwYVlzSWpHMExpb2xZTnExSkRDLzR3ekRhdU01clNDb1pOaWJwQXJBZnNo?=
 =?utf-8?B?S1JRZjUzYUdYWlYvc1JiVUpSYVk1RC9VYzZFSDIxdHZpTndhNVFINCtOc09I?=
 =?utf-8?B?M0UwL2ZVTEw0UGw5LzJOY0Vrc2tyWXJHSVVGd1BaNGQ1RkdRakJGZ2l1aEhY?=
 =?utf-8?B?c0RlTXNNSzg2RG5NdmJWOXFwcEhIRXRNOWFxSEMreXRTWXArKzNGUlNzdTdN?=
 =?utf-8?B?VXRzL05WcUREcUxxemhLMFBEbHlRTEtCRlA5dUgyTTY2TWtyME9XdkpWNFo5?=
 =?utf-8?B?aWlWMzZpNXU2bkQyWTVYclVZSXl0Q3VkUThla3JVdzE0YXJYbFVqWG1MeUN3?=
 =?utf-8?B?SDJTMTZJOU5ZV3JpeEh6Y0hNazA5eHFPbm5IZXFsTFNWNEdIaXNoRXdxYmxj?=
 =?utf-8?B?YTVqMjU3eVVDamFHaFJUd3didmN3VWhuZm5PSU9tTXU3SjJ0Y2RPY2hBVVQz?=
 =?utf-8?B?OFRNdjFJVGh4SzlESlJEU3RnK3Rad3hJMGZkR3V2ZU9DYXpzM2hPMjFzVm90?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16B5EB3C353B8243AFDDBE4A7E75D3DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2648737c-f78e-4e72-c186-08dc6b400ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 07:10:05.2504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7xD7numHkLNbM+OYQfmMOyL3QpDD7surHn4iqZ220KtEjbl+l3oP1RsJbcqI/co6Difaq0hgFkMA7EHXgn17TkH6j6SDsV4NGUmUsBkJBTYt5h1m4zGwmRbSk7Pim20
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8745

T24gMDIvMDUvMjQgMzo0OSBwbSwgUmFtw7NuIE5vcmRpbiBSb2RyaWd1ZXogd3JvdGU6DQo+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+IEkgdHJpZWQgdG8gcmVwcm9k
dWNlIHRoZSBpc3N1ZSBpbiBteSBzZXR1cCB3aXRoIHlvdXIgYWJvdmUgYXBwbGljYXRpb25zLg0K
Pj4gQnV0IHN1cnByaXNpbmdseSBJIGNvdWxkbid0IHJlcHJvZHVjZSB0aGUgaXNzdWUgeW91IGFy
ZSBmYWNpbmcuDQo+Pg0KPj4gT25lIGVuZCBpcyBSYXNwYmVycnkgUGkgNCB3aXRoIGxhbjg2NTEg
TUFDLVBIWSBhbmQgdGhlIG90aGVyIGVuZCBpcw0KPj4gUmFzcGJlcnJ5IFBpIDQgd2l0aCBFVkIt
TEFOODY3MC1VU0IgU3RpY2suDQo+Pg0KPj4gbGFuODY1MSBNQUMtUEhZIHNpZGU6DQo+PiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4+DQo+IA0KPiBEaWQgeW91IHJ1biBib3RoIGNsaWVudCBhbmQg
c2VydmVyIG9uIGJvdGggZW5kcz8gVGhlIHByZXZpb3VzIHRlc3RzIEkNCj4gaGF2ZSBkb25lIGhh
dmUgb25seSBzZW50IHRyYWZmaWMgaW4gb25lIGRpcmVjdGlvbiwgd2hpY2ggZGlkIG5vdCBsZWFk
IHRvDQo+IGEgbGl2ZSBsb2NrLg0KPiBCdXQgYm90aCBzZW5kaW5nIGFuZCByZWNlaXZpbmcgYXMg
ZmFzdCBhcyBwb3NzaWJsZSBpbiBib3RoIGRpcmVjdGlvbnMNCj4gdHJpZ2dlciB0aGUgcHJvYmxl
bXMgb24gbXkgZW5kLg0KT0ssIHRvZGF5IEkgZXhlY3V0ZWQgYm90aCB0aGUgY2xpZW50IGFuZCBz
ZXJ2ZXIgb24gYm90aCB0aGUgc2lkZXMuIEl0IGlzIA0KcnVubmluZyBtb3JlIHRoYW4gYW4gaG91
ciwgaXQgZGlkbid0IGNyYXNoLiBCdXQgdGhlcmUgYXJlIHNvbWUgIlJlY2VpdmUgDQpidWZmZXIg
b3ZlcmZsb3cgZXJyb3IiIHRpbWUgdG8gdGltZSBpbiB0aGUgZG1lc2cuIEkgZG9uJ3Qga25vdyB3
aGV0aGVyIA0KdGhpcyBpcyBhbiBleHBlY3RlZCBiZWhhdmlvciB3aXRoIHRoaXMgdHlwZSBvZiBz
dHJlc3MgdGVzdC4NCg0KdG9wIG91dHB1dDoNCi0tLS0tLS0tLS0tDQoNCnBpQHJhc3BiZXJyeXBp
On4vbGFuODY1eC92NF9tYWlubGluZSAkIHRvcA0KDQp0b3AgLSAxOTo0NzowNyB1cCA1NCBtaW4s
ICA1IHVzZXJzLCAgbG9hZCBhdmVyYWdlOiAxLjIzLCAxLjIwLCAxLjE0DQpUYXNrczogMjA1IHRv
dGFsLCAgIDEgcnVubmluZywgMjA0IHNsZWVwaW5nLCAgIDAgc3RvcHBlZCwgICAwIHpvbWJpZQ0K
JUNwdShzKTogIDAuMyB1cywgIDcuNSBzeSwgIDAuMCBuaSwgOTIuMSBpZCwgIDAuMCB3YSwgIDAu
MCBoaSwgIDAuMiBzaSwgDQowLjAgc3QNCk1pQiBNZW0gOiAgIDc4MTAuMCB0b3RhbCwgICA3MDEz
LjUgZnJlZSwgICAgNDAyLjYgdXNlZCwgICAgNTE4LjAgDQpidWZmL2NhY2hlDQpNaUIgU3dhcDog
ICAgMTAwLjAgdG90YWwsICAgIDEwMC4wIGZyZWUsICAgICAgMC4wIHVzZWQuICAgNzQwNy41IGF2
YWlsIE1lbQ0KDQogICAgIFBJRCBVU0VSICAgICAgUFIgIE5JICAgIFZJUlQgICAgUkVTICAgIFNI
UiBTICAlQ1BVICAlTUVNICAgICBUSU1FKyANCkNPTU1BTkQgDQoNCiAgICA3MjE4IHJvb3QgICAg
IC01MSAgIDAgICAgICAgMCAgICAgIDAgICAgICAwIEQgIDI4LjYgICAwLjAgIDEzOjUxLjEyIA0K
b2EtdGM2LXNwaS10aHJlYWQgDQoNCiAgIDYzODUzIHZuYyAgICAgICAyMCAgIDAgICAgMjMyMCAg
ICAzODQgICAgMzg0IFMgICAwLjcgICAwLjAgICAwOjAwLjIzIA0Kc2ggDQoNCiAgIDY1MDkwIHBp
ICAgICAgICAyMCAgIDAgICAxMTcyOCAgIDQ5OTIgICAyODE2IFIgICAwLjcgICAwLjEgICAwOjAw
LjA0IA0KdG9wIA0KDQogICAgICAxNyByb290ICAgICAgMjAgICAwICAgICAgIDAgICAgICAwICAg
ICAgMCBJICAgMC4zICAgMC4wICAgMDowMS43NCANCnJjdV9wcmVlbXB0IA0KDQogICAgICAyNyBy
b290ICAgICAgMjAgICAwICAgICAgIDAgICAgICAwICAgICAgMCBTICAgMC4zICAgMC4wICAgMDox
Ni42NyANCmtzb2Z0aXJxZC8yIA0KDQogICAgIDI2OCByb290ICAgICAgMjAgICAwICAgNTAwMjQg
IDE2MTMyICAxNTEwOCBTICAgMC4zICAgMC4yICAgMDowMi4wMiANCnN5c3RlbWQtam91cm5hbCAN
Cg0KICAgICA5NTYgcGkgICAgICAgIDIwICAgMCAgNjk5MTk2ICAzNzg5NiAgMjkxNjAgUyAgIDAu
MyAgIDAuNSAgIDA6MDMuNjAgDQp3aXJlcGx1bWJlciANCg0KICAgIDczMjggcGkgICAgICAgIDIw
ICAgMCAgIDE2MjgwICAgOTIxNiAgIDUyNDggUyAgIDAuMyAgIDAuMSAgIDA6MDcuNjEgDQpweXRo
b24zIA0KDQogICAgICAgMSByb290ICAgICAgMjAgICAwICAxNjg2OTIgIDExMzQwICAgODMyMCBT
ICAgMC4wICAgMC4xICAgMDowMy42NyANCnN5c3RlbWQgDQoNCiAgICAgICAyIHJvb3QgICAgICAy
MCAgIDAgICAgICAgMCAgICAgIDAgICAgICAwIFMgICAwLjAgICAwLjAgICAwOjAwLjAxIA0Ka3Ro
cmVhZGQNCg0KaWZjb25maWcgb3V0cHV0Og0KLS0tLS0tLS0tLS0tLS0tLQ0KDQpldGgxOiBmbGFn
cz00MTYzPFVQLEJST0FEQ0FTVCxSVU5OSU5HLE1VTFRJQ0FTVD4gIG10dSAxNTAwDQogICAgICAg
ICBpbmV0IDE5Mi4xNjguNS4xMDAgIG5ldG1hc2sgMjU1LjI1NS4yNTUuMCAgYnJvYWRjYXN0IDAu
MC4wLjANCiAgICAgICAgIGV0aGVyIDA0OjA1OjA2OjAxOjAyOjAzICB0eHF1ZXVlbGVuIDEwMDAg
IChFdGhlcm5ldCkNCiAgICAgICAgIFJYIHBhY2tldHMgMTk0NDU0MSAgYnl0ZXMgOTA5MTkxMTY4
ICg4NjcuMCBNaUIpDQogICAgICAgICBSWCBlcnJvcnMgMCAgZHJvcHBlZCAyICBvdmVycnVucyAw
ICBmcmFtZSAwDQogICAgICAgICBUWCBwYWNrZXRzIDI0MDI4NTUgIGJ5dGVzIDMxMjkxNjI2MjQg
KDIuOSBHaUIpDQogICAgICAgICBUWCBlcnJvcnMgMCAgZHJvcHBlZCAwIG92ZXJydW5zIDAgIGNh
cnJpZXIgMCAgY29sbGlzaW9ucyAwDQogICAgICAgICBkZXZpY2UgaW50ZXJydXB0IDU1DQoNCmRt
ZXNnIG91dHB1dDoNCi0tLS0tLS0tLS0tLS0NCg0KWyAgMjg1LjQ4MjI3NV0gTEFOODY1WCBSZXYu
QjAgSW50ZXJuYWwgUGh5IHNwaTAuMDowMDogYXR0YWNoZWQgUEhZIA0KZHJpdmVyIChtaWlfYnVz
OnBoeV9hZGRyPXNwaTAuMDowMCwgaXJxPVBPTEwpDQpbICAyODUuNTM0NzYwXSBsYW44NjV4IHNw
aTAuMCBldGgxOiBMaW5rIGlzIFVwIC0gMTBNYnBzL0hhbGYgLSBmbG93IA0KY29udHJvbCBvZmYN
ClsgIDM0MS40NjYyMjFdIGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9yDQpbICAz
NDUuNzMwMjIyXSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAgMzQ1Ljg5
MTEyNl0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsgIDM0Ni4wNzQyMjBd
IGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9yDQpbICAzNTQuMzc0MjIzXSBldGgx
OiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAgMzU0LjM3NTQyMl0gZXRoMTogUmVj
ZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsgIDM1NS43ODYyMTldIGV0aDE6IFJlY2VpdmUg
YnVmZmVyIG92ZXJmbG93IGVycm9yDQpbICAzNTYuODk4MjIxXSBldGgxOiBSZWNlaXZlIGJ1ZmZl
ciBvdmVyZmxvdyBlcnJvcg0KWyAgMzU3Ljc4MjIxOV0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3Zl
cmZsb3cgZXJyb3INClsgIDM1Ny43ODMxOTRdIGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93
IGVycm9yDQpbICAzNjUuNDQ2MjI0XSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJv
cg0KWyAgMzg3LjcyMjIyMV0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsg
IDM4Ny43OTAyMThdIGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9yDQpbICAzODcu
OTUwMjI0XSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAgMzg3Ljk1MTE5
OV0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsgIDM4OC43OTAyMTldIGV0
aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9yDQpbICAzODkuMDEwMjIwXSBldGgxOiBS
ZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAgMzkxLjA2NjIyMV0gZXRoMTogUmVjZWl2
ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsgIDQwOS43NDYyMjVdIGV0aDE6IFJlY2VpdmUgYnVm
ZmVyIG92ZXJmbG93IGVycm9yDQpbICA0NDIuODM1Mjc4XSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBv
dmVyZmxvdyBlcnJvcg0KWyAgNDQ3LjQxMDIyMl0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZs
b3cgZXJyb3INClsgIDQ0Ny41MTAyMjBdIGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVy
cm9yDQpbICA0NDcuNzU4MjE5XSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0K
WyAgNDQ4LjA2NjIyMV0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsgIDQ0
OS41OTAyMjBdIGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9yDQpbICA0NTAuNjg2
MjIxXSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAgNDUxLjIzODIyMl0g
ZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsgIDQ1MS40OTAyMjBdIGV0aDE6
IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9yDQpbICA0NzIuMjU0MjIxXSBldGgxOiBSZWNl
aXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAgNDczLjMwMjIyMl0gZXRoMTogUmVjZWl2ZSBi
dWZmZXIgb3ZlcmZsb3cgZXJyb3INClsgIDQ3NC4wNzAyMjBdIGV0aDE6IFJlY2VpdmUgYnVmZmVy
IG92ZXJmbG93IGVycm9yDQpbICA0NzUuMjYyMjIwXSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVy
ZmxvdyBlcnJvcg0KWyAgNDc1LjM2MjIyM10gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cg
ZXJyb3INClsgIDQ3Ny4zNjIyMjRdIGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9y
DQpbICA1MDEuOTE4MjIxXSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAg
NTA1LjUxMDIxOV0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsgIDUxNi40
NjYyMjBdIGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9yDQpbICA2MDAuODMwMjIx
XSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAgNjc1LjYxNDIxOV0gZXRo
MTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsgIDY3Ni4zMTgyMjNdIGV0aDE6IFJl
Y2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9yDQpbICA2NzYuNTk0MjIzXSBldGgxOiBSZWNlaXZl
IGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAgNjc4LjcwMjIxOV0gZXRoMTogUmVjZWl2ZSBidWZm
ZXIgb3ZlcmZsb3cgZXJyb3INClsgIDY3OS4xMDIyMTldIGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92
ZXJmbG93IGVycm9yDQpbICA2NzkuNjQyMjE4XSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxv
dyBlcnJvcg0KWyAgNjc5Ljg5NDIxOF0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJy
b3INClsgIDY3OS45MDYyMjRdIGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9yDQpb
ICA2ODIuNTI5Mzg2XSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAgNjgy
Ljc4NjIyMV0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsgIDcwMy4zNzQy
MjBdIGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9yDQpbICA3MDMuNDYyMjE5XSBl
dGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAgNzE2LjYwNjIyMl0gZXRoMTog
UmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsgIDcxNy4xMzQyMTldIGV0aDE6IFJlY2Vp
dmUgYnVmZmVyIG92ZXJmbG93IGVycm9yDQpbICA3MjIuODM4MjE5XSBldGgxOiBSZWNlaXZlIGJ1
ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAgODAxLjUyMjIyMF0gZXRoMTogUmVjZWl2ZSBidWZmZXIg
b3ZlcmZsb3cgZXJyb3INClsgIDg3MS45NDYyMjZdIGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJm
bG93IGVycm9yDQpbIDEzMDQuMTkwMjIwXSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBl
cnJvcg0KWyAxMzA3LjczNDIyMV0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3IN
ClsgMTMwOS43MzgyMjRdIGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9yDQpbIDE2
MDUuMjIyMjE5XSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAxNzM5Ljky
NzEyMV0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsgMjI0MC4wMDIyMTNd
IGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9yDQpbIDIyNDEuMzU1Mzc4XSBldGgx
OiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAyMzAwLjM3NDIxOF0gZXRoMTogUmVj
ZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsgMjMzMi44NTAyMTRdIGV0aDE6IFJlY2VpdmUg
YnVmZmVyIG92ZXJmbG93IGVycm9yDQpbIDIzNDcuMzIyMjE1XSBldGgxOiBSZWNlaXZlIGJ1ZmZl
ciBvdmVyZmxvdyBlcnJvcg0KWyAyMzc3LjcwMjIxNl0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3Zl
cmZsb3cgZXJyb3INClsgMjM5My45NDIyMTRdIGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93
IGVycm9yDQpbIDI0MDQuOTg2MjE0XSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJv
cg0KWyAyNDA3LjUzODIxNl0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsg
MjQwNy41MzkxOTBdIGV0aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9yDQpbIDI0MTEu
MjY2MjEzXSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAyNDIxLjU0MjIy
MF0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsgMjcxMy4xNDIyMTRdIGV0
aDE6IFJlY2VpdmUgYnVmZmVyIG92ZXJmbG93IGVycm9yDQpbIDM0MDEuMjI2MjE1XSBldGgxOiBS
ZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KWyAzNDk0LjM5NDIxNF0gZXRoMTogUmVjZWl2
ZSBidWZmZXIgb3ZlcmZsb3cgZXJyb3INClsgMzUxMS44NTAyMTRdIGV0aDE6IFJlY2VpdmUgYnVm
ZmVyIG92ZXJmbG93IGVycm9yDQoNCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gUg0K
PiANCg0K

