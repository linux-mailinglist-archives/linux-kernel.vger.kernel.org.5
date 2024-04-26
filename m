Return-Path: <linux-kernel+bounces-160080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F008B38CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80821F23951
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66242148304;
	Fri, 26 Apr 2024 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KtdTDYLh";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="6We4iEeC"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E7145B0C;
	Fri, 26 Apr 2024 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139142; cv=fail; b=MrLJlDA3XLlzpGVBlJFTa5t/gaxC/QIP+klCFdaq8WkZUZfN9+dNG1CuS/aXqQE6sTbGVKzuPI2lDmWT+DP/4lNYC1JkGhMXwOXhlc+f3Emizz2ll24Zd7KNXXED48Z9REFVtW5bEof6RhmxASh3Cm44cH7fe5sHZNn531c61XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139142; c=relaxed/simple;
	bh=8aTT1vM44k7j1Cs5YpA9c/QIuaiZtpa7Kv1y8wzdeaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q2m9BtXl4d1QSmc6GPy+nuZgVXQeVT9D1I4tjdu6Ah/o9G2vTPDQ1FiMFRUfsTvZOwvhqGLktiGLUnAaZMNCnvcQ4za+lNhU84NebyWKWluJgU7xUIFLOWfAqyRXAOBfh1pBS5nQ5sioR+8fdMQMoLVamZf8rKPrLBvK2WgeEcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KtdTDYLh; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=6We4iEeC; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714139140; x=1745675140;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8aTT1vM44k7j1Cs5YpA9c/QIuaiZtpa7Kv1y8wzdeaU=;
  b=KtdTDYLhkuR0TrCRZAu4u7tz+32eF0POotdzQwABf6+RQcEs3Dw4gXSl
   rDAPzenYq/HoifxM1VCK47waVWnINhhNTOAWWy7V/BZAF7Dsc1uNPJmXx
   GTbAKEdfsHyWiJVlkdxE/muxVor5wpy0NHvN1PUnr3BbRfPaiuYY4/Npw
   uOdBdEPc3cD0Rxovj26eJi1gShhp58tOqBLTZi/Bmf6V7axXDG0YnKVE8
   rVpIcXwMhUvr1l0qT8XR6GucXmq8tHCxuuc+dC+ICxLmF6VAUS6C9Bod3
   BZzgorm8MoXvjR0KYVNHaHRrnEpzp4WEULwMk0FtG3Q2yFTrjr9GqzfAb
   A==;
X-CSE-ConnectionGUID: VmB/uq37RC6yy2P+NILB0w==
X-CSE-MsgGUID: 59bQu5KKTeaptK3ne4B7iQ==
X-IronPort-AV: E=Sophos;i="6.07,232,1708412400"; 
   d="scan'208";a="22771936"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2024 06:45:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 06:45:23 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 06:45:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWTomt9uFUCbh5IETiDrBl8Mdc2VKUu9y3ws9+NfzEH0R0PhkCa5efnCsFpPvmAD5VBFxTk9KyLWMf6IMT9xuy1UvdRVYVq1rtXftFsdm8ydDd3DbTZ1NCq3vt6qmKu0LJR5sajJiv2hRndxAshcuiD+J+AR8teOjK0Fgs81qJSDOT8w7yHBFC5i0839kKBrT3H0vRiilQA4R2BU0/9RKryPRtThOu12J72ZmHPnxISs2RDXS1Ju/noTNFpZ4lrPGNY0t8jRilb5iJC/sAvrkIHSKGyjkn6uwrSzYv4LSBx/5oBi/Q+fqNdd/oZwF179VAKdRS9XZ7KsegiB0Ey19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aTT1vM44k7j1Cs5YpA9c/QIuaiZtpa7Kv1y8wzdeaU=;
 b=BDpRxNPP9FxqLil9DyiELjQp/DDbnZDZMVty0ToMAZ3OEtB8ivaDjFTT2qwKgVO90QRPwXLMXVW/9ZxWPGE6VjR3vjLhV7mbau44txQTga93YnXUvaJ43cguKyodgI9qI21FkGJEJBX21kI80DG8+WQK5js1OG2DExneCpmmwLYpgsY+PwtC86EhdMCdUgtUVbYEknrLtTs3GOwMg+rlDowegzuQ2wQUA54dTu/k8btETPDO/JLCQCAChDzCH0HRv3P1dlOQwF/mrUSjeG4RXTE1Q4tBz63+xQS2hy3lEWzzo44cY3jImIXgWbhAcaPuCSd9K6W3irZ6LWGsfR7OkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aTT1vM44k7j1Cs5YpA9c/QIuaiZtpa7Kv1y8wzdeaU=;
 b=6We4iEeCLJSfrbJnJGI5u4L5o+fIVL5msnC9L82S+/1UAUkwR5hsJYRQRLdoBJjHCAmOm0q7DWDGdoiMK/+DlH7fjwbX5T52iaIIjEREE9WbZ/yffXF+hf1EV6oV0ULjPiFub4dLlaRTBwErLIxm0mTUT3Pon1i6yQuiQSyLRv97Bt8ZOLX+H9Utq7XwdNJ2NzgIAAcOGX0ynKnBVMMefPlsXQuc19hYI/6I5jsd5kN3I4rfddoE37DEVSmAlTRs2GbR4BX4uLJo/bo1G4SOtEu4dQ1zso+lUiHmUbzVZFImwCyOi75lASZNxkqUJbqzDRRtm/jtKQJKEq8Qf5KPgQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM4PR11MB8089.namprd11.prod.outlook.com (2603:10b6:8:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Fri, 26 Apr
 2024 13:45:20 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 13:45:20 +0000
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
Subject: Re: [PATCH net-next v4 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Thread-Topic: [PATCH net-next v4 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Thread-Index: AQHakZAeMmJyUl87WkuqM6F297dNprF2k/SAgAQI+AA=
Date: Fri, 26 Apr 2024 13:45:20 +0000
Message-ID: <6e529720-3caa-4dc4-b9be-bc6674806ba5@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-10-Parthiban.Veerasooran@microchip.com>
 <574fec4d-5a23-490a-ba12-c40432ebe4b8@lunn.ch>
In-Reply-To: <574fec4d-5a23-490a-ba12-c40432ebe4b8@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DM4PR11MB8089:EE_
x-ms-office365-filtering-correlation-id: f0dbc5ca-9bbc-40bf-e19a-08dc65f71d49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QVh4YjNLOUJWeFB4UE44YVFkaFhkdjNLUklBZTFLY2EwbkdNemxNd3hQdEVs?=
 =?utf-8?B?YWFDZGdrTGRic3dQMWVuSGNxNlJFNEdpWTY3SEozdGkwZUpiUmcrcTZZaVdM?=
 =?utf-8?B?blp5RTIzNmR3My9WbE8rTUg5UEY2RVM0RGE1a3pWYUNpR0Y4aEZKeEtIcm1X?=
 =?utf-8?B?aWdhMHk0UlNTR1ZVdGZCak9qR1ZoSmFtYXR5WWhyKzlDZnhFZFF3ZWwyRmpP?=
 =?utf-8?B?NDVlL3VBTjErK1ZCNk5oaVdkRzNCZnF4N090NUQ4eGR6ajM5U3NiTGtrUTRK?=
 =?utf-8?B?VzM2TWUzYkRrcEhpdU1EcUwzS3dqQmVvT0c4ZjRlbUhUWXRUTmNrSklBQlla?=
 =?utf-8?B?WXltVFIrUW9POVhMQW0weG9FZys0dEZrMXFVNnFNMXAybVRJMytCZkRYU3l0?=
 =?utf-8?B?aVBjWVA1TFJjeEVuVit0d21GSEdhKzMzRE0yVzJuOTFqOFBTWDFXc0xhUkoz?=
 =?utf-8?B?elZpQTl5a0QyeFJvSi9DMmpjMURFWlZDZ0dIRVVrajNESnowQzRWWm5oWmox?=
 =?utf-8?B?TVJJL05teVpCQkk3TVAwajd4NXBZc1AzNlVUQ2NEemdPMDhZTXROSVYwcVNk?=
 =?utf-8?B?c2E5QWtPdFNyR1MwUE42THZvSHlFOXFyVEJDa2t3MnJZZ2RjU2ppb1lORlRl?=
 =?utf-8?B?bTFXS1liTDh3a0dCdS9ROGtkR3lnU3V0V2lnR01qRjJLWm1JUlp5VXc4bWpw?=
 =?utf-8?B?M3ZSZmo4UkxiRExJR1pFeG9jL1NzTGc4MUREWkFMS1VOY29CT1FwbUtXdTRs?=
 =?utf-8?B?azRjVVJMWGZ3T3prbnhrZGNZRktVdkZheCt1RFMzdEJWQjVxczgwZTZrenFE?=
 =?utf-8?B?MUNhdll0MDBoWHBOd2o2N3RwUUoraUZtWnNQdkVJZGVtZHhwOHZJSURBOXp4?=
 =?utf-8?B?a0hNV24zZFVJejg3Smg5U0hmejRiVnd1cTQrQzlMU2Z2UmRPVVZnWExkdUli?=
 =?utf-8?B?bWp5SU1BcjZzRVhSNEN0NlBEbk5EYTR2R1JsclZ2ck51cGduVk5UU3hVbFlV?=
 =?utf-8?B?bWxPSkRXSDgxc2NMbU1CcGxLaHNuSmZuUDA1aHNhMkVWZGVUQXEwZjNDYlNO?=
 =?utf-8?B?cHVKSXRMWXlRVU0wL1pkeTl4L3cvbEp1RENEcXlCQ2hPdUcxMGJiSTYzWXRD?=
 =?utf-8?B?T2J2UU1GZlgvdEZ3YWU2VkxYamVhYUVGY3N1MlBMZFB0Yy9WUmxneEZJbFRS?=
 =?utf-8?B?OG4xQ3Zja1c1S09lNWZ3QjNLZ3dyYWo2V0d6bzAyVlJ5NTVYZXp0anBGVWM4?=
 =?utf-8?B?dkFqSTlXSnUyZ2xzZmYrQ1V1RVYxQXZUN1ZxYlpEbExrdGw1V29qZWNQUE12?=
 =?utf-8?B?Tms5Y1R3M0pNUExNNERxV1ZwTVdWekVZVDNaZFQzVXBRKzBmQVp4UTljUGh4?=
 =?utf-8?B?WjF3ZzJ4QnRwQiswYWF6TUlQaFFHeDhzOGxIWk5malQzZnJjVy9jY2czN24z?=
 =?utf-8?B?clRBTmtOUnh0K2M4dXJramIvR3VGdnZ6REYyQ3JyemdUeW9CSlJGNVVmWnJD?=
 =?utf-8?B?NG02SGFyVERndWRoMlZybGtNM1B4dXZURVdYekwxZ1pNYmR1ck9aUWRzb0hF?=
 =?utf-8?B?Nmh1ZmdVVDZQSU5MK0c0citDRnUydFo0clpneG44bzQvZ3RRajk5QU8vMWZX?=
 =?utf-8?B?bE02UEZJdVcvMngya1I1Sm1xZFNuNHRqVk9xUkVlUWRQZnBBQUo3OHJHMk96?=
 =?utf-8?B?SlYwN2NxdEhiUmtCNmxTUVBSY2hNTFJ0U3c5L1k3N2ZPZGRJSVpqQmJxRDh4?=
 =?utf-8?B?RHhZdmFNM3lVb3VzY09nTXo4V3JVazA4bENqbEFqVWlXREQyZStob1FOM3Jw?=
 =?utf-8?B?MFAwVmdjZTJSTDU5T0VKUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlRGR3VpK0dQZlk0TTNiTWswWWxLRGRHS0VZWXdDcUVoN3VEZXg0WXlKaFI2?=
 =?utf-8?B?ejhkM3pzaE1rMGd2Zk5jQXRoczNlZy9QM2NZUXl4M045K1ljWm9lcTZORjQ4?=
 =?utf-8?B?djM4VDJFcEZkYllaaWFSUm9aOHozQm9LdEdtK3ZPOERmbmpNWXhqekU5NlZD?=
 =?utf-8?B?Z09iVjlycGtjRDcvMWliYVRsU3pIMGpCQUVKRHFoSFBTZ1BTRW1vUU5ReGE5?=
 =?utf-8?B?ZFJ6c0JzcitTbnEvZENwdE9Eam0vKzZxLzdHc0F0bDdMYzZUQitieFdSVVFR?=
 =?utf-8?B?NUJYaDJYSW9kYTd4L2JtSDYwdG5rRUpPYzFIbWN4dFJZYkE2YUg4d3lHL0Zp?=
 =?utf-8?B?dWMxb0o1T2FCbzh6ZGdRWDhlTlJZb3BjNFgrU2J3Y2poWWZPSlRFL05kMjNO?=
 =?utf-8?B?M3o1aUo3dUM2L3JZMTdIZzdNajBvS0JYZDkwUC94U2ZPeEFZajhDN3ArcEEr?=
 =?utf-8?B?WW9RUHRnS3d1UVYwL0hQNzJPeW1ONkh0Q1gxQytTZHdRTWhkUUFoekE0RmNQ?=
 =?utf-8?B?aWkrY1JBUlBHaGRrTXdML2VLQVZZOWNVemhyMjFhRmFFZmVjcy93dWkrVEc5?=
 =?utf-8?B?NSt0ZUtwazc0VkszZ3pPb0NRNjF4aE9rbnNvUWNIUFEvazRmTHpBNCs4Y2FL?=
 =?utf-8?B?L2tDQXhzTldmbGQ4R1JXNGgvNEpFVEthaUlqdUlmajRHdzRWU1kveFBIK3BZ?=
 =?utf-8?B?MGQ1eDlxdVNJMHg3WG9TOUlZamxCekYvQmdRUVlPS3FnZXJjMHNaM0x0VGFq?=
 =?utf-8?B?WUF4UTFMWXorWXhqQTNzdDIyNXhKclJ3dHB2QWV0bXdDbmRQVndFMy82b0dO?=
 =?utf-8?B?UVpVWVNGQ0Fia0kvN0VvekpBVE9JZzlrYkNwejhIMFZmdG0yZzRncndvKzRY?=
 =?utf-8?B?MEpmSXBLRi9zL2Z6TklwYlRVbU5ubVdiQXlvcVFiWTdlNWc1SEYxNFRnek5E?=
 =?utf-8?B?elJYRzlaa2xYbzNyamRyK1RnM3BoSWJTTUFMbFlqNlpiNTlKSlVyZXc4Zk9M?=
 =?utf-8?B?VGxZb3JEVHhDN1JuSGkzRktHcHRNTEk2ZjBUdUIxdDRpK29qOHZ1bGZCS1I4?=
 =?utf-8?B?bkxDWXZvZTBlY1Z5TURWMWtjUzdFZXdFTW82WjZnbTZVOFpxSTc5aHZON0d1?=
 =?utf-8?B?MDhMUU5valUyWmpySTdjRUtiZUdIK24rYkgyZHRuY1R4emFONXNzNzFTeHkx?=
 =?utf-8?B?Uit2bjk5RzdFNzRCMmhYYjR6aEVTMk0xRkRFcVJaRWUvTGp4d3dmNlNGMm1a?=
 =?utf-8?B?VTA2bjRQeHJjTFlVcDVjcEk2aGYyTFZXTlNMYTNLbmtKL3RFb0gyanFmZTEw?=
 =?utf-8?B?a001blRmUFZNYkJBSy9iV1V5UzF6ZGMyclB1dEE4Q0RtSFJhdkZUZ2ZnRFZU?=
 =?utf-8?B?VGliQ2k4TGk4eStlTkIzL0Y2Mzc4T0JGaUszWHh1VlZvWGRYV0RlK3l0d282?=
 =?utf-8?B?VUdlZGczUSs1a093YndldTZnSFZVVG9zR01xSGRUK2ZRMWhRSUVRWG92dHRp?=
 =?utf-8?B?aURBRkNmd2VvdjZOMzAvSjQvR0dkMms4d0UraWNhbjlEVE5xMnVjSEI3Qktp?=
 =?utf-8?B?Q2srSW4raG5RUW0rdDNIS1MxYnh2TXB6TmZ4T1dIendGL1hKWXExbEh6ajFw?=
 =?utf-8?B?VTkrbEJsU1pFZXRWYmhVN3J4UkYxVC96U2NRSHE2MUtiSVVYUkZ2dW9SVUJI?=
 =?utf-8?B?NDdXNjBDOW9pSm1KSTh5cmkvOVBVNVhJbXgxeXJMejZ0S05yWW9QWEViaXNV?=
 =?utf-8?B?OEZvNVJGdWM1SUNseGhUZUhrSW8xWmx5Tis1Rk9wcXBIN1Yvc1NZSlpodE5D?=
 =?utf-8?B?MVlrb01mMW53ZTUxL1E4ZVVrMWh2QzRIbWM5eGllYVV2djZCakhkTWZib0gz?=
 =?utf-8?B?NVZzNkNmWkU3ZFNKQ2FEb2RhZ1gxRENPZUdZcENFeU1JVkNZU3ZYV0pmVTMw?=
 =?utf-8?B?YWxrTkw4MEZFdzJVOTlpbUowaEJlajIydlo3eEl2Yjh0YUUzeWU1Qmc5cmV6?=
 =?utf-8?B?a0R3NE1QK1dyTjFQSnlmbXg0QUJFR0ZFUDhETjNwNnM1Y0ZXMEk3RnphalBp?=
 =?utf-8?B?blRiRHJGOVpRZzZXZGoxWmdIRUVLbll4UzV6My9BYS84d21NcC9Ld1dwbmZR?=
 =?utf-8?B?Q3lReExSSUkrb0ZwSi81NGpVZFBna1VwdGp0bGFxQkZtTVBlclFSQnR4WWFK?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E298BE1B63DF824BABC8D3E1D9B40BA5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0dbc5ca-9bbc-40bf-e19a-08dc65f71d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 13:45:20.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ffBhyMO3a+APNEHU2PgFtrcWmRaf2KfOhRBroY3H0U3XxJfVyehEJWExFoTuC5r8VPRtEaeKHJdpC2ge/b1aeC8HTrTrbNZWXrITzQnUDBJeD4K5rjS93vW7ksqgRhl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8089

SGkgQW5kcmV3LA0KDQpPbiAyNC8wNC8yNCA1OjM4IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gK3N0YXRpYyBpbnQgb2Ff
dGM2X2FsbG9jYXRlX3J4X3NrYihzdHJ1Y3Qgb2FfdGM2ICp0YzYpDQo+PiArew0KPj4gKyAgICAg
dGM2LT5yeF9za2IgPSBuZXRkZXZfYWxsb2Nfc2tiKHRjNi0+bmV0ZGV2LCB0YzYtPm5ldGRldi0+
bXR1ICsgRVRIX0hMRU4gKw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEVUSF9GQ1NfTEVOICsgTkVUX0lQX0FMSUdOKTsNCj4+ICsgICAgIGlmICghdGM2LT5yeF9za2Ip
IHsNCj4+ICsgICAgICAgICAgICAgdGM2LT5uZXRkZXYtPnN0YXRzLnJ4X2Ryb3BwZWQrKzsNCj4+
ICsgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+PiArICAgICB9DQo+PiArICAgICBza2Jf
cmVzZXJ2ZSh0YzYtPnJ4X3NrYiwgTkVUX0lQX0FMSUdOKTsNCj4gDQo+IEkgdGhpbmsgeW91IGNh
biB1c2UgbmV0ZGV2X2FsbG9jX3NrYl9pcF9hbGlnbigpIGhlcmUuDQpBaCBPSywgdGhlbiBkbyB5
b3UgbWVhbiB3ZSBjYW4gcmV3cml0ZSB0aGUgZnVuY3Rpb24gDQpvYV90YzZfYWxsb2NhdGVfcnhf
c2tiKCkgYXMgYmVsb3c/DQoNCnN0YXRpYyBpbnQgb2FfdGM2X2FsbG9jYXRlX3J4X3NrYihzdHJ1
Y3Qgb2FfdGM2ICp0YzYpDQp7DQoJdGM2LT5yeF9za2IgPSBuZXRkZXZfYWxsb2Nfc2tiX2lwX2Fs
aWduKHRjNi0+bmV0ZGV2LCB0YzYtPm5ldGRldi0+bXR1ICsgDQpFVEhfSExFTiArIEVUSF9GQ1Nf
TEVOKTsNCglpZiAodGM2LT5yeF9za2IpDQoJCXJldHVybiAwOw0KDQoJdGM2LT5uZXRkZXYtPnN0
YXRzLnJ4X2Ryb3BwZWQrKzsNCglyZXR1cm4gLUVOT01FTTsNCn0NCg0KQmVzdCByZWdhcmRzLA0K
UGFydGhpYmFuIFYNCj4gDQoNCg==

