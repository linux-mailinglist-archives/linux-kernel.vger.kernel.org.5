Return-Path: <linux-kernel+bounces-107541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A58387FDE2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6C21C220D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B9A80033;
	Tue, 19 Mar 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Wm1VrsJs";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="V4JcuOAE"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897893F9D6;
	Tue, 19 Mar 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852918; cv=fail; b=Trch+tbiMZ/rFjHvzT46DSGJe9xRKPt5qCY/ifIx3HR+5lZKXAs5VeioQruWJHTL78OpSk3F+WJgUAIfmTw2/0jfQXHDRBR7cSKwrhKknf8YDbRoygzicjNT/1oVpi2Ssvc4t6uBcR8ZldA2nrflYD3hOrHr9+u39e7l0eTzIYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852918; c=relaxed/simple;
	bh=0SeBbASOhEKoAxJoVLtg/5p5SaF78KzrBNnh21JBC6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qbScDvtgFaGlLY278l0YibCrKOpI0mRCX66VgLZD+Yvt/Lw+uzPjtAbpVpWUGENGyJPb9+wBARJXFGBDnD+9Xqs9k6TP8fL0kdX4TLV6KHaAqfERIGgrjqqkeuhOwdcqkiLnwSuI6EC4o3qc9DyKwXzO7PHYOmV0mbPca17MVr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Wm1VrsJs; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=V4JcuOAE; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710852916; x=1742388916;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0SeBbASOhEKoAxJoVLtg/5p5SaF78KzrBNnh21JBC6E=;
  b=Wm1VrsJscV1wbq4K2wX6lb3NzLulcZdCvXOceqNl80MMb3h9f0YEqcdc
   zka/iOS/0/wPBo0FEfN12LnATR4rQ1GNTRBSV/3XTa/c4zp4NM8S2IiTS
   KXuhbTjFrAhV5xbqSAT5G18ba7OdNKk+ocOMxx/+met5B+W0cuOMQ4ERD
   +PuiA6Mn27iw2WG/XzFPziGOcwDmbYnAxBmnQC3aI+6TenOp754PRAQHa
   QI1H/tu2VsliD90HbfEhoh5vrKdgwq92aEbeTdcBdcRJBKZtPl6oWldSB
   zbxxrPNm+tm4h09JJ8CPQZLlbZKUPCdgsMDami8ZFFJZ+5BqBJf/BD4a0
   w==;
X-CSE-ConnectionGUID: DK9r8ICLT2qBN5CRDfeRaA==
X-CSE-MsgGUID: W3g5CwX/SDG69HVAgLEz3A==
X-IronPort-AV: E=Sophos;i="6.07,137,1708412400"; 
   d="scan'208";a="17808867"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2024 05:55:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 05:54:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 05:54:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGeMgaOKek6vmDpplWzKG5HkdU8jWOwhjWXsDSe9y9+GWIV4MF+2getnGkpxcnEJxG5lo8Yn5k1jjZqrEr3sXrv14FF7o6wG3RXOC5Y+h/WtzLIq31kk7YzR23+3pqdZ7WmvcHTVZapYJXickycIg+Ey5bRtSRrbI5WV77H1PjJQBmHJyAte8FuQlmrk6ZUq/YVDkAR7NFU94uyFX42pm8EyNB+zb3bwbBsLveFg9H1+v8PVZnPqHbdVGvNNPesTOhyFhkhm59T13EI+aLAREEH4H0ZFqPfvc4rT/g9xEaSJKovBGkGVfqyP86w2XoH+4TtlURcOtPr6YKWJgO6X9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SeBbASOhEKoAxJoVLtg/5p5SaF78KzrBNnh21JBC6E=;
 b=e/ItI4QO/2KhgI/+GMhhVEs+NjivBgS6PUXRyUalpjSe7gE3FSPdCU7L4FiFyFMyHCIYkXWRQ17/mar+39sBNC6HEkouhwTm2SepWUzoDgcWBuLI6qvcZica7RWUiy1eNhbEivAmhjIp6Hsy8vO7IZH7xQqbk9mbhGSvD9aPYOzz5SkAG7CuvVeamCoDIeMU8Kyi6Gfzpi8UEgblqZYfowFmWpNft0L+gh9MF7Dfw8gOz6gn5r/VfLQdmlezyP8XByb0jXYGZBUzqd1bPfgZZOGLT5EMH4+r27H6BXP6VsHX/i7BwQ3dOD5fB1gXgIfWexrZhYFufNT09GIaP/zsBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SeBbASOhEKoAxJoVLtg/5p5SaF78KzrBNnh21JBC6E=;
 b=V4JcuOAETrYtLCFm9QAwTwoJxinJJ3FZz2kSQZDJlcxfu9bYssGr4ptjwTpkCzOCo/RdK3EoA/ecWQcnkHO+uTWug8mZzmmTRiqF4CNkPkvxZASAZ7YIcJ3dmvI9OABz/6kM/kbN/wEf2QodcoYH1HUSmhyykLtEcHhTjhn3uM2CX34QNqzM8FcNbfd/XNzu8KGppx/eQZnw41iVK/5qT3xKEZJBXG36313IZUQ8CUsn+52sdglakWiSZdRh0qIG3OTpWwGSkpLI2ZmD7JIvj+oZle5vNMLkLBpa3D2elwDLKjg1p40x2ZBrDLslj31Jai+WB9M+B4CESkbOlEiVUA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.10; Tue, 19 Mar
 2024 12:54:34 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.015; Tue, 19 Mar 2024
 12:54:34 +0000
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
Subject: Re: [PATCH net-next v3 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Thread-Topic: [PATCH net-next v3 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Thread-Index: AQHab6OdU0M6Qlks6kCHViBNnqnl3LEs++mAgBIeCYA=
Date: Tue, 19 Mar 2024 12:54:34 +0000
Message-ID: <cd971029-c1f3-40b0-b940-4d48e03b9f55@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-10-Parthiban.Veerasooran@microchip.com>
 <49f8b067-4e56-4e8f-97e0-bac314619b82@lunn.ch>
In-Reply-To: <49f8b067-4e56-4e8f-97e0-bac314619b82@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DM4PR11MB6335:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hc/MKzK7dz/ISZId3AGobjw4VhnigjkSUt04xLgwx68rlPRZgzeels/eto8n7st+iwThMziATLE8oA4/ShBGnlcUl8Rgu6aEWX6FzJNu8bneMIWsWK0BV2RW4XdMMSCzkxYEIpuwhbnzkL9T6+Kr1KdyvZtW40R5mKzjomX5tLWMBnzpdXC8Zbwrjm1LzaX7L6pu5+e8OfvKml5S/2x1iy7Bzy7xHMzoHbv1wwbMkQsAmZVQHYEbtn3OuZXrwwjcEYCFYm3CDfvmfHkUXitp/zSwCO1ot1iW74EICHEPryBWEN00/LazqVqMkoJvMJjqhrAk5YUdZAu8kZiA1C4T0ia46mROjvNSEjzNUN8Tia+K56UTReUn4rsPOF1XZ8+PxuCshzig4G7FLTIWBeNFWNzH5fFOn0t2sxnyliqkYZbUAnCEFCLDIcB6u4zM3HZRVCWlIwROvQq0l6FFIDMpo/c5xjoUzOdYKE4oMzrZeiTt1v9ZiT1HgbFK/1qJQejZ974OhrRWIxLtul5O/ppSuSyql9pJ4fANuXvdZlu+zv/lnYuc02po6lFbTdyrJn2/eiTWfcCTLdb1g7qp7caWAs0bEqD6GOEvQNMLiGWSWrj3H8hPmOcRe6c5chnss4wt+v/O6ZPrd602POPKhSCA7MokmAKtkp9pmglYyOYKqYM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dng1cCtRdDJ0RXphRGplV0lTaFAzZnVLU1ZlZTNlMzZqSW9PM05YSTlUbEdS?=
 =?utf-8?B?eW1tK1Y3OVBvR051V1lLMm9tZHFQV29Gc2xlZVJMdXRKdUxHTnRTZ2hzMVJQ?=
 =?utf-8?B?a01VT2dxZzdNUkNzWnlnNThFZVh5WHgyTW10a0NIZjgxUmpuTTNWNllyNmYx?=
 =?utf-8?B?K1JDVFM1VW1LTDFQdSt1NGZMNEZxUnQ1Q1NpUDJHeVU2emdCY3FYVVdwbEU2?=
 =?utf-8?B?eG13SVNCN2lac3FESFY0TjQydmk1WmZudDQzRlJpZHdqd1RFR0p0bVNGRUpr?=
 =?utf-8?B?ekpQY296YnZpUlhxa1AwL2huNzY1YmxBMlNmSFpIcUs1OWpIZko4WUYyY2tX?=
 =?utf-8?B?cEo4M2RiL3JKb0hlc1BRdWxNenoyYU0yVEMxSit5dFk0eUUyNWxHamVtWi9x?=
 =?utf-8?B?dll4Uktjc2c1YStURS8rdlp1WEdBb3BXaDZzUEQ3ZEswbFVrS1lQZGJMcWha?=
 =?utf-8?B?KzFzdUJ4RWdza2R1WVNUWUlWMVRXSHZXVHhGNThYSEF4dUV6WWtsdjBLV0Vu?=
 =?utf-8?B?OG9vUzEzenNJdDFIQ1lrZnlQTmtURmFnZWtYd0l4U0kwNzNVR0tIeW82Z3A2?=
 =?utf-8?B?bEc3TU1idWsxeFFId3RyemNMbFRRTmNxMy8zMUVKSm9CVEsvQVgwcStvUzhR?=
 =?utf-8?B?WlZSK2Vpc0ZYaWZzU2EvOHZWWmhGcHZZdkFuNHg4Rnc4VnNhUmtQTlpJOTZx?=
 =?utf-8?B?TkVTTGZodnFkSllYYUp5RjlVK2kxK0pmQnY2Vm9YLzBoTldxYjJzUzU4MkVX?=
 =?utf-8?B?aFMvWC9JSDd2ZnBMYU1wbmFWTThTbFh6aGhwSDVEcmpYclZmRjJ1d0xSRkxW?=
 =?utf-8?B?b3ZYU1M2QWhlNFBScEJNRDY2c2kveXorWlFQODNWdDdOT0Nab0VIZVVhZmdi?=
 =?utf-8?B?aWJqY3pveFhCSXpkWkxSbE1jRGlLWmJEWmtNMGdLNjZRUTZsREE0VnBHWTRv?=
 =?utf-8?B?TTI4bXBySFJFcDRndGQ3WVgwMTZNd1UySDZ2cG5Vak02Ym9PeVdSWkp6bi9J?=
 =?utf-8?B?NUF3N2tIQWlBMnBXbk4wYUxwM0h2YWZvVGM1SEpCZEFqdTNGRFAzOXl0dEdw?=
 =?utf-8?B?ejVmSG84cUlGaEhOcy9aZ3NDMDFFTHdiOVhBQ1UzNzg5ZUg5am9UQllLQnd4?=
 =?utf-8?B?UVl1REhIMVZOR3ZwU3JDV2VpSTNDSlpyUzNnWjI4YXdIcUFxTnFRRUVRMnBX?=
 =?utf-8?B?UnBLNStYWTArbXBGKzFrSHBoT2pvY3lCUW5xWDJ4ZXpEK1kwS1dOeXlLL0Rh?=
 =?utf-8?B?V3JvWVduMXRZRmtwc2lpU2t4Y2taNTczaFpoYWVsQjhwdWpnc29GWDF3MGtv?=
 =?utf-8?B?d29ZRXQ1MVNualdVL21hOFNlK2dPamNwaG9KMCsydVkrc1VMdHZWZ25hRUx6?=
 =?utf-8?B?dkY2bmxCU1Z5V1BZOFp4b0Z2dFNCZ3RJSFZOOUFqOWwvbHpTaitjTmhZOGkw?=
 =?utf-8?B?UkJCRFpuVE5yMXpWemNtN3ZlZk9ZSXNVNHVSUVBQQTRwU0FYN3E1RldPV1JC?=
 =?utf-8?B?TzVzeXVaOEtMS0F2VnpwMnJqbkFCSUdOODl3L3dWRm1BaDgrd2puQVBOTkNu?=
 =?utf-8?B?QmRnb0VkTm9sRGxKQ2RSeTBNVmxaSGRaQ0ZBbHJST1JOdGlXemVkdWpVUysy?=
 =?utf-8?B?cURwYlpOT0Z1V3ZzR0ZRWkxBcTcyQkxPSlhNWFo4NlRPengyMlVVcUUrenh6?=
 =?utf-8?B?Sk40N1pUWmlmLzJkRVNGWTI2Wkk2TGRuVEVJMUlqcTVXNE1BQUZlMWFHaWpM?=
 =?utf-8?B?TDVEemU5ckV0dVV2THhwcUEwWW1qTS9BaHRGcVNkQysrR0w2RWhIQXNNMUhK?=
 =?utf-8?B?QTRoU2MyVXZPVmpmeHJyK013WDE3V1FyYm5WM1ltdzg0OUtqTDB3KytSTS9O?=
 =?utf-8?B?YlFIVnhnTUR3UnVubENFRkN6aVZHa0p3UnFuK05qb2dEWVJueXFsQWZwKzls?=
 =?utf-8?B?MFVnKzU0d3VVNERmR1llN0svZTc1bkNhWFE5MkVFTW5pNDdhOEs0cEs4WnQw?=
 =?utf-8?B?aUlKZ05IOFlLY1VYRGVieU9USDNrK1U4UkY5bHJsa2FmQkpoUG1xc1UvVXM2?=
 =?utf-8?B?MldpVXZHZXY4Z0M2RVEzcmsxcmE1WW5VWWQ5Y2RmemFnb0hsb295elhWU2dB?=
 =?utf-8?B?Qy9uSGx5V3k1czlITTVhN0tHRDNRQnZndGVQTm40cWZEQm5sMkZTM1NvN1FD?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0306A3ABCFB5C4B968BBBB80A9F8349@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b78a812-4599-47be-776f-08dc4813ba4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 12:54:34.6580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edsSOJsCplnE6iC5GlXT+L7lYHUW783qBvyYa/LSH9FyOZOxAL7GvZlkhYKdtI+0J0I339ROc/dY+cykrz6g/MzvEFsbJYevHkR/th4WmMWidcEFh2D98K5MupDIPfUG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6335

SGkgQW5kcmV3LA0KDQpPbiAwOC8wMy8yNCA1OjQ0IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gK3N0YXRpYyBpbnQgb2Ff
dGM2X2FsbG9jYXRlX3J4X3NrYihzdHJ1Y3Qgb2FfdGM2ICp0YzYpDQo+PiArew0KPj4gKyAgICAg
dGM2LT5yeF9za2IgPSBuZXRkZXZfYWxsb2Nfc2tiKHRjNi0+bmV0ZGV2LCB0YzYtPm5ldGRldi0+
bXR1ICsgRVRIX0hMRU4gKw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEVUSF9GQ1NfTEVOICsgTkVUX0lQX0FMSUdOKTsNCj4+ICsgICAgIGlmICghdGM2LT5yeF9za2Ip
IHsNCj4+ICsgICAgICAgICAgICAgdGM2LT5uZXRkZXYtPnN0YXRzLnJ4X2Ryb3BwZWQrKzsNCj4+
ICsgICAgICAgICAgICAgbmV0ZGV2X2Vycih0YzYtPm5ldGRldiwgIk91dCBvZiBtZW1vcnkgZm9y
IHJ4J2QgZnJhbWUiKTsNCj4gDQo+IElmIHRoYXQgaGFwcGVucywgaXQgaXMgbm90IHNvbWV0aGlu
ZyB3aGljaCB3aWxsIGZpeCBpdHNlbGYgcXVpY2tseS4gU28NCj4geW91IGFyZSBsaWtlbHkgdG8g
c3BhbSB0aGUgbG9ncy4gVGhlIGNvdW50ZXIgb24gaXRzIG93biBpcyBwcm9iYWJseQ0KPiBlbm91
Z2guDQpPaywgdGhlbiBkb24ndCB3ZSBuZWVkIHRvIGNvbnZleSB0aGlzIGluZm8gaW4gdGhlIGRt
ZXNnIHRvIHRoZSB1c2VyLiBGb3IgDQp0aGF0IHNoYWxsIHdlIHVzZSBuZXRfZXJyX3JhdGVsaW1p
dGVkKCkgaW5zdGVhZCBvZiBuZXRkZXZfZXJyKCk/IE9yIHdlIA0KZG9uJ3QgbmVlZCBhbnkgcHJp
bnQgYXQgYWxsPw0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAgICAg
QW5kcmV3DQo+IA0KDQo=

