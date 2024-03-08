Return-Path: <linux-kernel+bounces-96972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C8C8763F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15FF0B2177A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64B456769;
	Fri,  8 Mar 2024 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FdWCldLi";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gRtjk6ct"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB5655E78;
	Fri,  8 Mar 2024 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899573; cv=fail; b=Yrr5Dt4h6eA+Q3fQqCfX9x4YDyMJdZLOvAJXKTuD8qzA35wfPOqE9y5vqs4phDi3VOZ7ZrIFnEjUxz4Qf4RS6IzXquw9qEh+4AHhQOPmRwFeAO3hEer/p23PjVEcjMCSGMvDwajmUKRJ5BkN781Dlso03zteteEPs39lB9KKLHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899573; c=relaxed/simple;
	bh=u5BpxHody62mJC6W3xCG2dub5rRy0Tm4O0t3R69U+nw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t1kwk1422vRIjwBef7pnkd4fQFbWz/FXFpOtF/UiCDA4cF5eTCSEoVD5HitAejyecCR92D1bx51HG2yiAdrezNh84T+WBN1ImCODQyhdFRw477NfDA/AfXBOvF//n80cSdgAHBRF+mxRzgwxboKpJB4EchzPWUPTg1HhVvV3BQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FdWCldLi; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gRtjk6ct; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709899570; x=1741435570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u5BpxHody62mJC6W3xCG2dub5rRy0Tm4O0t3R69U+nw=;
  b=FdWCldLinT2quzUvF/knvCq9EKuKrOvUonOyoibIoqktys0BGAEU8GWT
   GjdoT9c5XVV6xTsramSyTGabfNw+G+H3hMZ/kncpd/YGdj1/wL6tcAdup
   SGxcW47Ra0Y1hdhCvrQDvKmOeHVE79xEPD4MtVsyXHLanfuMCSui3z2mf
   R4hdqxGlrZkCNy8uRmS3so/CWG0IRyVf/5ElSRZaaMWN42w9ebRdNNG4w
   ERcMGGmgCLmQqy0/73OS7dmNUuPlj2+GtbaggQlpbx/HrXox7RfzVsLia
   s1U8HquYlkjn2Bi+QL2gEfwK6lwKT7EHNH+SOldwFtOArK/FCJPrNUdxU
   w==;
X-CSE-ConnectionGUID: nTiBvZidTiemjEjdOoV/0Q==
X-CSE-MsgGUID: ioMxiYcaQ2ij7fheqtY0vA==
X-IronPort-AV: E=Sophos;i="6.07,109,1708412400"; 
   d="scan'208";a="17402867"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2024 05:06:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 05:06:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 05:06:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9ZstmUh2ci9P15cRE5G0Xxsg7PVGjqkXALmZDECauXVnhzIEL3nzK25eT50sJDshOi/feDWURu9CNlAIjfvJtCfVjoJN1YcH25wR7fXzjZvgIwbv/YhrnWVMGwDjIxFUPkbFiUmRXzWiLYsCProPrbGLuRfT4/hoCoKy0WU5Wqt4noFW4E2oMcYw0xyX9fZzHew5uDOuVcX8yatQlNEOj1RNQliOaDDfxfdGdxKLFJIi61T+MSpV0UaZ7XI1NOTji7WYfyZU9erAAJTfjB4r267FdP1NGtp3fr5edhh17OIVApmpb+cY3YFSICq3VnzOxvVKpzslH5olW5ClBnhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5BpxHody62mJC6W3xCG2dub5rRy0Tm4O0t3R69U+nw=;
 b=VYWXAebMpuLb/mM2U3tMsyHwRu5BsSVwLpRAKA9Ul4DuNsRtI0vLX7dnvDDeVI1SOm3ATh9o90TKI9+/W6IR+3rgJDgTnBzpRXOIz6DqrxTGvaQlCqSzylqe+HjkgTUUAijMXaew/aTaJW209d+b3ABP3/GfKIanNnOc1GZMhhSsFHL2ViiNvf5HUcK0PjvQd6JVoRQOQ/ICBaqJXuW36sLQKXqe2CI28ZHq6XDDI46mcSgN5mBSBy7vduK6wYrSX1d6tgHoCovh5ELuyLlCvTOUcjmyHnLlR3dowdhStnWnFJEtekDHRpHx5ZSiI0F/tDW/eezQFjST/pSnkA71EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5BpxHody62mJC6W3xCG2dub5rRy0Tm4O0t3R69U+nw=;
 b=gRtjk6ctBk5fAtnchA4yPWZLQWBaTqGMdFIZOTSomTd3g8e4/ka6DvC5aWU7hmMh1JuvfgNB5mcY2IK/9svJDzg2DOZgfrzYltmIUmoDpE8RgCls6meMwS1HVwKTyfKKvNQXX0SD1bNRx+27J4ZTMrZgWOb2oIymZRAFrx2FhpcNA1spYlspXydKP6q/9zqGpQlGT7QP3LT5lDX6FAUVJNWJNitOjc+EOb9GMofbX7OzT3nIe0akMUMRmHyKaqfpxujcXHd96AthrI6E+UWrn1BBBl+iGouVk1VwIrhULRv/OQbfbgn7DCeyWM+wVDACgKpSuxlfWMuHZmIycYjnQA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SJ2PR11MB7599.namprd11.prod.outlook.com (2603:10b6:a03:4c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 8 Mar
 2024 12:05:57 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.006; Fri, 8 Mar 2024
 12:05:57 +0000
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
Subject: Re: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Thread-Topic: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Thread-Index: AQHab6OHj5kLkYW7WEGlK1Xe+8KWTLEregYAgADhwoCAACAwgIABRrCA
Date: Fri, 8 Mar 2024 12:05:57 +0000
Message-ID: <e9bc573e-61f0-484a-b1fb-b5100eb9ee0a@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-7-Parthiban.Veerasooran@microchip.com>
 <8c2b95f4-75a7-4d6d-ab9c-9c3498c040d8@lunn.ch>
 <eeb57938-e21e-406d-a835-93c6fb19b161@microchip.com>
 <7ddbe599-187e-401f-b508-4dc62bca8374@lunn.ch>
In-Reply-To: <7ddbe599-187e-401f-b508-4dc62bca8374@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SJ2PR11MB7599:EE_
x-ms-office365-filtering-correlation-id: 41b438b6-c22c-485a-1529-08dc3f681cb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YIza9dADfOV4risNt+zuwOojPy71Drf+m58HtAVryf5iNFisTV7BFAQCqngelyuRhSeBzVsc924gV4lYcSdas8ey84bI8VrQfVHfyEV3Sa5Ax3akISXA01elfOikMus+vjOL8mbr+aUfjrcU3MVdFLnFDSP4J6Dw1aesaxU1AXp3xPdaZkDxwhnhGzlYIyMRzl3GS2rMkqFsf6Hg3hbZs7prCPDH7A6RsIlfDXFgdRClSmXrcSaBslEF58NyJIM8J5FBqZacAjHik1kP8EGvA/nugzrMcuZW0zh8AOvPK0ts+FGYzCZkaD0aZdH7V4Srs/K3wMo9DJbl3LPAE0PQ4dyLktECw5AWWzRGp8CtqCAuEa8BChWtWy710k8pojK70ZrlxVbqSD+5revnTajZNY988+/xlij+DzFTsZ8bkh8vqWT90u9jHJJCnUwpXgIdSzmYQkZniNceABGClS5TKAlNF91jK2hZ/qUTd9dLJKJtqcDQY7mN7lJvaFSmOEyt191rm+aqdlpFnt8OOUdLpNKKqSVsSJ/mxds+BAPdmOi8MQxXaLZYc0nllGtDsbvmvs1K36ePUpltW7w6x5gTGChGDjNn8hKGYEFCTSaGrcNRyjuvLm176SKZLFnJHpdBmnsKEDeKtSp5EWtqmi0fF/q92y2jNm/Qvu/HrP+YiZ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3Y0OVg0UTJPV2pxZUhJb1FtQ3UwRXY3Q0pYK04vUXVwRUFDVDFVS0pLY085?=
 =?utf-8?B?a0VJUVBvaVB1WjRoQkM5T2EvUFpNb3QrUTJaMG04bHFlZHVzNW9lUlN2dzYx?=
 =?utf-8?B?U2hKNVgzRFZuR2Zkb2ZBeHU4TWZ0L28xU05kK08zVm1wdjNkYWRQMWYwdUJ1?=
 =?utf-8?B?Nlg3U1BkdzM1Q1hXTDEveHVDNnRIVkw3REpZWWFUeUw5MTZCTzlhb002RElk?=
 =?utf-8?B?UzFVWlRGZC9MdE5iT2s3dlNneU9kYjRlL0JhWVc5WmFjQXBMUEVYeE1kR2l4?=
 =?utf-8?B?V0JhN2FZc0RicElCRFNRM2t6UWpaWVlOMjJadzh1M1BJcGNuQWRwZTY1L1hT?=
 =?utf-8?B?a2hXdThGa1h1eHR1aWZrQklzcGFSMnRNMjJKdUFycGxtcWUzNlMvL1FUdTFC?=
 =?utf-8?B?UmhzcHVPRk9kb0Q2RDNXWEJkOUpZdGoyM0xoRjVhRlhYT2c3WXhYa3Z0d01S?=
 =?utf-8?B?MGV6d1gvNG4yaW9yMTRRanhpTHBqWFNzblBRM3N3SVpOblFYS1pWUEZpaHV3?=
 =?utf-8?B?NFJzYXFWYjE0enc2VGFyMHo0WEJ1Uno2T21JT0dxL2JMNFMwRWNHQ3VRWTN5?=
 =?utf-8?B?R0RvUzQ4QXREb1pxTkRtdjcyT1g4Q01FeTBkdnpFVXdwSmhYZ0FjV1VvNXhh?=
 =?utf-8?B?WVlac01wZjMyM0g3TWZLVWdpUUh5QzkrZW9RNU40dDJXNmxuN0dsR08ydmN4?=
 =?utf-8?B?amUwOUdKbTBlalZqNlkwZVRIeDZqN3BEZGhaWXAydm5SQXFZSDl6RmxOZjFu?=
 =?utf-8?B?L2RXSU5rYjVzVWZlQXFZckk4cDE5LzJ0M3VuL3puTEpmSDNvbW9aa2ZFYkpC?=
 =?utf-8?B?OXpHNXJQZHRiMXBlRGxUOXRMd2lQTDAwaTJJR1ZpODF5OFdrMHVpeWRFYkJ0?=
 =?utf-8?B?ZGZVa2VmTkJxamMrblVxOTdsenlhNC80YW5aNDkrK3AwM2ZFeEdYK1hwc2Vy?=
 =?utf-8?B?a2pzcmtvQzZEY0o1L3FkZmxFem5Memp3WW9kbklvK3lXa1g1NkZPU1YxbEJH?=
 =?utf-8?B?UXhTTnFIWnNaVmYxR2p1Ri9ocEdrYWxvTUF6WURtcjVoYS8yL2NiQlQxN0dV?=
 =?utf-8?B?Z2tnZGZjaGhEVGgvMm9rRXphSEQrWm1lMzlQYjI5RjB0SkduS255c2FKYUhL?=
 =?utf-8?B?ZGx0bDFpQ0wxenJ0ZkVySGNZb3JtNDlUNEVWdGRRTWVEak1YQWZzZy90a0Mx?=
 =?utf-8?B?VmVwV3RLY3ZKUjBsbm5JamtpWDc3Z3lFT3R2NmNVQVZDbCsxTm9YRFNpS2Jl?=
 =?utf-8?B?K2JyWGpqWWhzUS9hSFNYTWEyQTBnSzFRWWZkSlh6a3BZcmNFdFdGL1FOUTA4?=
 =?utf-8?B?YTJCUmpaVkNTdVNkWXpsczZRRHlsYmlYblMwQXNmUHBydVhYcnlGVHhzK29B?=
 =?utf-8?B?SWVROGtSUTZIVEtzd2E3WXhKaEVmVEEwLzlKN2svZGdXUFZVcEhveHJCa0Nm?=
 =?utf-8?B?RDNNY0d0NCtPaVdGSndrR0tYWTYrdnVEL0t4WDVyZVFQSWZYbFR4TzZPbjhT?=
 =?utf-8?B?TmRmSllFOTlEb0VTNVpqNDZ0bW5oaHJKb0g3VkFHdmxxL0ljT0JxSzM5Nng3?=
 =?utf-8?B?YlBVbGZhaXJNVkg2UHdUNThhRkVSZm5kdnR0aUh3YUpLRDd1N1U0TDE3Z1ZX?=
 =?utf-8?B?ZG9JZkZMVXQvSHlSUGRKSVVJekdMY2F4LytsTFJ1VDVJQW9KVDFCZkd2akRj?=
 =?utf-8?B?djRIb0crYVBXaEJmcDVIeXFRbEQ1czlpUC9tNmNQNitrQklwNmlNK3R2MzFQ?=
 =?utf-8?B?b0Z2RWV3NVJjdTZRYWk5MG53dCtIazZQOHY2UDRKOWd0SG10OEtLQ1JCNHdp?=
 =?utf-8?B?V0RiSldpV3FDMTIyTHNyeFpMbFNsMzI1RmtoZ1dubUVDUHlXczhkVXQzeFha?=
 =?utf-8?B?b1dWRGlqOHhUdTlwODZIcXdKZXJvS0lGeTQwWWMrWXZPanhITnNTY3lQdUFP?=
 =?utf-8?B?QXhKVW8rc2cvWlBrOWtPb3BMNFE0bHFBa2k5ZENtU0ZPb3Y4R2gyV2lIRzh6?=
 =?utf-8?B?emRjMTFEWFJ6TjNudzFpLy9jT3hmbG92UmoyUy9iRG1LT0ZYS2Qxbm1Jbjlv?=
 =?utf-8?B?UzQ2bjRtbnVVSGxBaFFydmVWOU4zQUY5a2Uzd3JQVXk2dXBWSGx5ZUxsb0ZG?=
 =?utf-8?B?RWFBUy9UZVhRNktBa3Ayak5xcTF6VXVFdCtxN1psZFZqS0tLQXVJZXYzeDR3?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C22D00F8C7DA9A4C8BB80F1598D3DDA1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b438b6-c22c-485a-1529-08dc3f681cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 12:05:57.0511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVim1V94GKVU/Wj+2swbZkA+qqzhGBkkJZelJHbzZ3xeOS2f8QBlxjlSfMOyfEa+6qoZSu2yBnFVYk7SP3HHGwiUKdCJc57EEW/m5M4E+LUqAY7DmFpfgCQLqdSWHG+c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7599

SGkgQW5kcmV3LA0KDQpPbiAwNy8wMy8yNCAxMDowNiBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+Pj4gK3N0YXRpYyBpbnQg
b2FfdGM2X21kaW9idXNfcmVnaXN0ZXIoc3RydWN0IG9hX3RjNiAqdGM2KQ0KPj4+PiArew0KPj4+
PiArICAgICBpbnQgcmV0Ow0KPj4+PiArDQo+Pj4+ICsgICAgIHRjNi0+bWRpb2J1cyA9IG1kaW9i
dXNfYWxsb2MoKTsNCj4+Pj4gKyAgICAgaWYgKCF0YzYtPm1kaW9idXMpIHsNCj4+Pj4gKyAgICAg
ICAgICAgICBuZXRkZXZfZXJyKHRjNi0+bmV0ZGV2LCAiTURJTyBidXMgYWxsb2MgZmFpbGVkXG4i
KTsNCj4+Pj4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4+Pj4gKyAgICAgfQ0KPj4+
PiArDQo+Pj4+ICsgICAgIHRjNi0+bWRpb2J1cy0+cHJpdiA9IHRjNjsNCj4+Pj4gKyAgICAgdGM2
LT5tZGlvYnVzLT5yZWFkID0gb2FfdGM2X21kaW9idXNfZGlyZWN0X3JlYWQ7DQo+Pj4+ICsgICAg
IHRjNi0+bWRpb2J1cy0+d3JpdGUgPSBvYV90YzZfbWRpb2J1c19kaXJlY3Rfd3JpdGU7DQo+Pj4N
Cj4+PiBUaGlzIG1pZ2h0IGdldCBhbnN3ZXJlZCBpbiBsYXRlciBwYXRjaGVzLiBQTENBIHJlZ2lz
dGVycyBhcmUgaW4gQzQ1DQo+Pj4gYWRkcmVzcyBzcGFjZSwgVkVORDEgaWYgaSByZW1lbWJlciBj
b3JyZWN0bHkuIFlvdSBkb24ndCBwcm92aWRlIGFueQ0KPj4+IEM0NSBhY2Nlc3MgbWV0aG9kcyBo
ZXJlLiBEb2VzIFRDNiBzcGVjaWZ5IHRoYXQgQzQ1IG92ZXIgQzIyIG11c3QgYmUNCj4+PiBpbXBs
ZW1lbnRlZD8NCj4+IE5vIHRoZSBzcGVjIGRvZXNuJ3Qgc2F5IGFueXRoaW5nIGxpa2UgdGhpcy4g
QnV0LCBhcyBDMjIgcmVnaXN0ZXJzIGFyZQ0KPj4gbWFwcGVkIGluIHRoZSBNTVMgMCwgcmVnaXN0
ZXJzIDB4RCBhbmQgMHhFIGNhbiBiZSB1c2VkIHRvIGFjY2VzcyBDNDUNCj4+IHJlZ2lzdGVycyBp
bmRpcmVjdGx5LiBUaGF0J3Mgd2h5IHRoZSBkcml2ZXIgaW1wbGVtZW50ZWQgdGhlIGFib3ZlDQo+
PiBmdW5jdGlvbnMuIEkgYWdyZWUgdGhhdCBpbmRpcmVjdCBhY2Nlc3MgaXMgc2xvd2VyIGFuZCBy
ZXF1aXJlcyBtb3JlDQo+PiBjb250cm9sIGNvbW1hbmRzIHRoYW4gZGlyZWN0IGFjY2Vzcy4gU28g
aW1wbGVtZW50aW5nIHRoZSBkaXJlY3QgYWNjZXNzDQo+PiBvZiBDNDUgcmVnaXN0ZXJzIHdpbGwg
b3ZlcmNvbWUgdGhpcyBpc3N1ZS4NCj4gDQo+IEl0IGlzIG5vdCBqdXN0IGFib3V0IHBlcmZvcm1h
bmNlLiBJdCBpcyBhYm91dCBjb21wbGlhbmNlIHRvIHRoZQ0KPiBzdGFuZGFyZC4gVGhlIHN0YW5k
YXJkIGRvZXMgbm90IHNheSBhbnl0aGluZyBhYm91dCBDNDUgb3ZlciBDMjIuIFNvDQo+IHRoZXJl
IGlzIG5vIHJlYXNvbiB0byBleHBlY3QgYSBQSFkgZGV2aWNlIHRvIGltcGxlbWVudCBpdC4gSXQg
bWlnaHQsDQo+IGJ1dCBpdHMgb3B0aW9uYWwuDQpZZXMsIHVuZGVyc3Rvb2QuDQo+IA0KPj4+IFRo
ZSBzdGFuZGFyZCBkb2VzIHNheToNCj4+Pg0KPj4+IFZlbmRvciBzcGVjaWZpYyByZWdpc3RlcnMg
bWF5IGJlIG1hcHBlZCBpbnRvIE1NUyAxMCB0aG91Z2ggTU1TDQo+Pj4gMTUuIFdoZW4gZGlyZWN0
bHkgbWFwcGVkLCBQSFkgdmVuZG9yIHNwZWNpZmljIHJlZ2lzdGVycyBpbiBNTUQgMzAgb3INCj4+
PiBNTUQgMzEgd291bGQgYmUgbWFwcGVkIGludG8gdGhlIHZlbmRvciBzcGVjaWZpYyBNTVMgMTAg
dGhyb3VnaCBNTVMgMTUuDQo+Pj4NCj4+PiBTbyBpJ20gdGhpbmtpbmcgeW91IG1pZ2h0IG5lZWQg
dG8gcHJvdmlkZSBDNDUgYWNjZXNzLCBhdCBsZWFzdCBNTUQgMzAsDQo+Pj4gdmlhIE1NUyAxMC0x
NT8NCj4+IFRoYW5rcyBmb3IgdGhpcyBkZXRhaWxlZCBjb21tZW50LiBJZiB1bmRlcnN0YW5kIHlv
dSBjb3JyZWN0bHkgYnkNCj4+IGNvbnNvbGlkYXRpbmcgYWxsIHlvdXIgYWJvdmUgZXhwbGFuYXRp
b25zLCB0aGUgZHJpdmVyIHNob3VsZCBwcm92aWRlIEM0NQ0KPj4gYWNjZXNzIHRvIHRoZSBQSFkg
dmVuZG9yIHNwZWNpZmljIGFuZCBQTENBIHJlZ2lzdGVycyAoTU1EIDMxKS4gQXMgcGVyDQo+PiB0
aGUgc3BlY2lmaWNhdGlvbiwgVGFibGUgNiBkZXNjcmliZXMgdGhlIFJlZ2lzdGVyIE1lbW9yeSBN
YXAgU2VsZWN0b3INCj4+IChNTVMpIEFzc2lnbm1lbnQuIEluIHRoaXMsIE1NUyA0IG1hcHMgdGhl
IFBIWSB2ZW5kb3Igc3BlY2lmaWMgYW5kIFBMQ0ENCj4+IHJlZ2lzdGVycy4gVGhleSBhcmUgaW4g
dGhlIE1NRCAzMSBhZGRyZXNzIHNwYWNlIGFzIHBlciBzcGVjLiBUaGV5IGNhbiBiZQ0KPj4gZGly
ZWN0bHkgYWNjZXNzZWQgdXNpbmcgcmVhZF9jNDUgYW5kIHdyaXRlX2M0NSBmdW5jdGlvbnMgaW4g
dGhlIG1kaW8gYnVzLg0KPiANCj4gWWVzLiBJIHRoaW5rIHRoaXMgaXMgcmVxdWlyZWQgdG8gY29u
Zm9ybSB0byB0aGUgc3RhbmRhcmQuDQpPayB0aGVuIGxldCdzIGltcGxlbWVudCBsaWtlIGJlbG93
Lg0KPiANCj4+IEluIE1pY3JvY2hpcCdzIE1BQy1QSFkgKExBTjg2NTApLCBQSFkg4oCTIFZlbmRv
ciBTcGVjaWZpYyBhbmQgUExDQQ0KPj4gUmVnaXN0ZXJzIChNTUQgMzEpIG1hcHBlZCBpbiB0aGUg
TU1TIDQgYXMgcGVyIHRoZSB0YWJsZSA2IGluIHRoZSBzcGVjLg0KPj4gVGhlcmUgaXMgbm8gb3Ro
ZXIgUEhZIHZlbmRvciBzcGVjaWZpYyByZWdpc3RlcnMgYXJlIG1hcHBlZCBpbiB0aGUgTU1TIDEw
DQo+PiB0aHJvdWdoIDE1LiBObyBpZGVhIHdoZXRoZXIgYW55IG90aGVyIHZlbmRvcidzIE1BQy1Q
SFkgdXNlcyBNTVMgMTANCj4+IHRocm91Z2ggMTUgdG8gbWFwIFBIWSDigJMgVmVuZG9yIFNwZWNp
ZmljIGFuZCBQTENBIFJlZ2lzdGVycyAoTU1EIDMxKS4NCj4+DQo+PiBJIGhhdmUgZ2l2ZW4gdGhl
IGNvZGUgYmVsb3cgZm9yIHRoZSBDNDUgYWNjZXNzIG1ldGhvZHMuIEtpbmRseSBjaGVjayBpcw0K
Pj4gdGhpcyBzb21ldGhpbmcgeW91IGV4cGVjdGVkPw0KPiANCj4gVGhlIGNvZGUgZ290IG1hbmds
ZWQgYnkgeW91ciBtYWlsIGNsaWVudCA6LSgNCk9oIHNvcnJ5Lg0KPiANCj4+IC0tLSBDb2RlIHN0
YXJ0cyAtLS0NCj4+DQo+PiAvKiBQSFkg4oCTIFZlbmRvciBTcGVjaWZpYyBhbmQgUExDQSBSZWdp
c3RlcnMgKE1NRCAzMSkgKi8NCj4+DQo+PiAjZGVmaW5lIE9BX1RDNl9QSFlfVlNfUExDQV9SRUdf
QUREUl9CQVNFICAgICAgICAweDQwMDAwDQo+PiAsLCwNCj4+DQo+PiBzdGF0aWMgaW50IG9hX3Rj
Nl9tZGlvYnVzX3JlYWRfYzQ1KHN0cnVjdCBtaWlfYnVzICpidXMsIGludCBhZGRyLCBpbnQNCj4+
IGRldm51bSwgaW50IHJlZ251bSkNCj4+IHsNCj4+DQo+PiAgICAgICAgICAgc3RydWN0IG9hX3Rj
NiAqdGM2ID0gYnVzLT5wcml2Ow0KPj4NCj4+ICAgICAgICAgICB1MzIgcmVndmFsOw0KPj4NCj4+
ICAgICAgICAgICBib29sIHJldDsNCj4+DQo+Pg0KPj4NCj4+ICAgICAgICAgICByZXQgPSBvYV90
YzZfcmVhZF9yZWdpc3Rlcih0YzYsDQo+PiBPQV9UQzZfUEhZX1ZTX1BMQ0FfUkVHX0FERFJfQkFT
RSB8IHJlZ251bSwgJnJlZ3ZhbCk7DQo+IA0KPiBZb3UgYXBwZWFyIHRvIGlnbm9yZSBkZXZudW0u
IEkgZG9uJ3QgdGhpbmsgeW91IGNhbiBkbyB0aGF0LiBUaGUgY29yZQ0KPiBwaHlsaWIgY29kZSBt
aWdodCB0cnkgdG8gYWNjZXNzIG90aGVyIE1NRHMsIGUuZy4gaXQgbWlnaHQgdHJ5IHRvIHNlZQ0K
PiBpZiBFRUUgaXMgc3VwcG9ydGVkLCBieSByZWFkaW5nIE1ESU9fTU1EX1BDUywgTURJT19QQ1Nf
RUVFX0FCTEUuDQpPaywgYXMgcGVyIHRoZSB0YWJsZSA2IGluIHRoZSBzcGVjLCBQSFkgQzQ1IHJl
Z2lzdGVycyBhcmUgbWFwcGVkIGluIHRoZSANCk1NUyBsaWtlIGJlbG93LA0KDQpQSFkg4oCTIFBD
UyBSZWdpc3RlcnMgKE1NRCAzKSAgLS0tPiAgTU1TIDINClBIWSDigJMgUE1BL1BNRCBSZWdpc3Rl
cnMgKE1NRCAxKSAgLS0tPiAgIE1NUyAzDQpQSFkg4oCTIFZlbmRvciBTcGVjaWZpYyBhbmQgUExD
QSBSZWdpc3RlcnMgKE1NRCAzMSkgIC0tLT4gIE1NUyA0DQpQSFkg4oCTIEF1dG8tTmVnb3RpYXRp
b24gUmVnaXN0ZXJzIChNTUQgNykgIC0tLT4gIE1NUyA1DQpQSFkg4oCTIFBvd2VyIFVuaXQgKE1N
RCAxMykgIC0tLT4gIE1NUyA2DQoNCk1NRCAxMyBmb3IgUEhZIC0gUG93ZXIgVW5pdCBpcyBub3Qg
ZGVmaW5lZCBpbiB0aGUgbWRpby5oLiBTbyBpbiB0aGUgDQpiZWxvdyBjb2RlIEkgaGF2ZSBkZWZp
bmVkIGl0IGxvY2FsbHkgKE1ESU9fTU1EX1BPV0VSX1VOSVQpLiBNYXkgYmUgDQpuZWVkZWQgdG8g
ZG8gdGhpcyBpbiB0aGUgbWRpby5oIGZpbGUgd2hlbiBjb21pbmcgdG8gdGhpcyBwYXRjaC4NCg0K
aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuOC1yYzcvc291cmNlL2luY2x1ZGUv
dWFwaS9saW51eC9tZGlvLmgNCg0KSG9wZSB5b3UgYXJlIGV4cGVjdGluZyBsaWtlIGJlbG93PyBJ
IGJlbGlldmUgdGhpcyB0aW1lIHRoZSBjb2RlIHdpbGwgbm90IA0KZ2V0IG1hbmdsZWQuIElmIGhh
cHBlbnMgdGhlbiBzb3JyeSBmb3IgdGhhdC4NCg0KLS0tIENvZGUgc3RhcnRzIGhlcmUgLS0tDQoN
Ci8qIFBIWSDigJMgQ2xhdXNlIDQ1IHJlZ2lzdGVycyBtZW1vcnkgbWFwIHNlbGVjdG9yIChNTVMp
IGFzIHBlciB0YWJsZSA2IGluIA0KdGhlIE9QRU4gQWxsaWFuY2Ugc3BlY2lmaWNhdGlvbi4NCiAg
Ki8NCiNkZWZpbmUgT0FfVEM2X1BIWV9QQ1NfTU1TMiAgICAgICAgICAgICAgICAgICAgIDIgICAg
ICAgLyogTU1EIDMgKi8NCiNkZWZpbmUgT0FfVEM2X1BIWV9QTUFfUE1EX01NUzMgICAgICAgICAg
ICAgICAgIDMgICAgICAgLyogTU1EIDEgKi8NCiNkZWZpbmUgT0FfVEM2X1BIWV9WU19QTENBX01N
UzQgICAgICAgICAgICAgICAgIDQgICAgICAgLyogTU1EIDMxICovDQojZGVmaW5lIE9BX1RDNl9Q
SFlfQVVUT19ORUdfTU1TNSAgICAgICAgICAgICAgICA1ICAgICAgIC8qIE1NRCA3ICovDQojZGVm
aW5lIE9BX1RDNl9QSFlfUE9XRVJfVU5JVF9NTVM2ICAgICAgICAgICAgICA2ICAgICAgIC8qIE1N
RCAxMyAqLw0KDQovKiBNRElPIE1hbmFnZWFibGUgRGV2aWNlIChNTUQpIGZvciBQSFkgUG93ZXIg
VW5pdCAqLw0KI2RlZmluZSBNRElPX01NRF9QT1dFUl9VTklUICAgICAgICAgICAgICAgICAgICAg
MTMgICAgICAvKiBQSFkgUG93ZXIgVW5pdCAqLw0KDQpzdGF0aWMgaW50IG9hX3RjNl9tZGlvYnVz
X3JlYWRfYzQ1KHN0cnVjdCBtaWlfYnVzICpidXMsIGludCBhZGRyLCBpbnQgDQpkZXZudW0sIGlu
dCByZWdudW0pDQp7IA0KDQogICAgICAgICBzdHJ1Y3Qgb2FfdGM2ICp0YzYgPSBidXMtPnByaXY7
IA0KDQogICAgICAgICB1MzIgcmVndmFsOyANCg0KICAgICAgICAgYm9vbCByZXQ7IA0KDQogICAg
ICAgICB1MzIgbW1zOyANCg0KIA0KDQogICAgICAgICBpZiAoZGV2bnVtID09IE1ESU9fTU1EX1BD
UykgDQoNCiAgICAgICAgICAgICAgICAgbW1zID0gT0FfVEM2X1BIWV9QQ1NfTU1TMjsgDQoNCiAg
ICAgICAgIGVsc2UgaWYgKGRldm51bSA9PSBNRElPX01NRF9QTUFQTUQpIA0KDQogICAgICAgICAg
ICAgICAgIG1tcyA9IE9BX1RDNl9QSFlfUE1BX1BNRF9NTVMzOyANCg0KICAgICAgICAgZWxzZSBp
ZiAoZGV2bnVtID09IE1ESU9fTU1EX1ZFTkQyKSANCg0KICAgICAgICAgICAgICAgICBtbXMgPSBP
QV9UQzZfUEhZX1ZTX1BMQ0FfTU1TNDsgDQoNCiAgICAgICAgIGVsc2UgaWYgKGRldm51bSA9PSBN
RElPX01NRF9BTikgDQoNCiAgICAgICAgICAgICAgICAgbW1zID0gT0FfVEM2X1BIWV9BVVRPX05F
R19NTVM1OyANCg0KICAgICAgICAgZWxzZSBpZiAoZGV2bnVtID09IE1ESU9fTU1EX1BPV0VSX1VO
SVQpIA0KDQogICAgICAgICAgICAgICAgIG1tcyA9IE9BX1RDNl9QSFlfUE9XRVJfVU5JVF9NTVM2
OyANCg0KICAgICAgICAgZWxzZSANCg0KICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT1RTVVBQ
OyANCg0KIA0KDQogICAgICAgICByZXQgPSBvYV90YzZfcmVhZF9yZWdpc3Rlcih0YzYsIChtbXMg
PDwgMTYpIHwgcmVnbnVtLCAmcmVndmFsKTsgDQoNCiAgICAgICAgIGlmIChyZXQpIA0KDQogICAg
ICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOyANCg0KIA0KDQogICAgICAgICByZXR1cm4gcmVn
dmFsOyANCg0KfSANCg0KDQpzdGF0aWMgaW50IG9hX3RjNl9tZGlvYnVzX3dyaXRlX2M0NShzdHJ1
Y3QgbWlpX2J1cyAqYnVzLCBpbnQgYWRkciwgaW50IA0KZGV2bnVtLCBpbnQgcmVnbnVtLCB1MTYg
dmFsKQ0KeyANCg0KICAgICAgICAgc3RydWN0IG9hX3RjNiAqdGM2ID0gYnVzLT5wcml2OyANCg0K
ICAgICAgICAgdTMyIG1tczsgDQoNCiANCg0KICAgICAgICAgaWYgKGRldm51bSA9PSBNRElPX01N
RF9QQ1MpIA0KDQogICAgICAgICAgICAgICAgIG1tcyA9IE9BX1RDNl9QSFlfUENTX01NUzI7IA0K
DQogICAgICAgICBlbHNlIGlmIChkZXZudW0gPT0gTURJT19NTURfUE1BUE1EKSANCg0KICAgICAg
ICAgICAgICAgICBtbXMgPSBPQV9UQzZfUEhZX1BNQV9QTURfTU1TMzsgDQoNCiAgICAgICAgIGVs
c2UgaWYgKGRldm51bSA9PSBNRElPX01NRF9WRU5EMikgDQoNCiAgICAgICAgICAgICAgICAgbW1z
ID0gT0FfVEM2X1BIWV9WU19QTENBX01NUzQ7IA0KDQogICAgICAgICBlbHNlIGlmIChkZXZudW0g
PT0gTURJT19NTURfQU4pIA0KDQogICAgICAgICAgICAgICAgIG1tcyA9IE9BX1RDNl9QSFlfQVVU
T19ORUdfTU1TNTsgDQoNCiAgICAgICAgIGVsc2UgaWYgKGRldm51bSA9PSBNRElPX01NRF9QT1dF
Ul9VTklUKSANCg0KICAgICAgICAgICAgICAgICBtbXMgPSBPQV9UQzZfUEhZX1BPV0VSX1VOSVRf
TU1TNjsgDQoNCiAgICAgICAgIGVsc2UgDQoNCiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9U
U1VQUDsgDQoNCiANCg0KICAgICAgICAgcmV0dXJuIG9hX3RjNl93cml0ZV9yZWdpc3Rlcih0YzYs
IChtbXMgPDwgMTYpIHwgcmVnbnVtLCB2YWwpOyANCg0KfSANCg0KDQotLS0gQ29kZSBlbmRzIGhl
cmUgLS0tDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAgICAgICBBbmRy
ZXcNCj4gDQoNCg==

