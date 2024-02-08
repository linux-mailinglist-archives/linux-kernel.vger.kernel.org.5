Return-Path: <linux-kernel+bounces-57456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5328184D94E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E7F1C23197
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA062D05E;
	Thu,  8 Feb 2024 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="II2SqVah";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uLucw0Zm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E42D61A;
	Thu,  8 Feb 2024 04:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364809; cv=fail; b=h3lu2ZXUhTnIM4hRWSH6E08ui1nTJ0S0NHsg7xY7bLAhEglBzEQdmU4/dFt277C0ozPFkfV1WPNKZkH+rnzDk8LRjxhMl8YITep2bDOHHMKA3vweggwgWMn3DuHmbyQQBdzwaDbcRYFLW+BQ/Ztf8ThLy6ILjoqZu1p1Q7+/ZrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364809; c=relaxed/simple;
	bh=va/bJiL2sjWmvpiiKFnpo+5AogOkhYlYr9Auoe0hfK8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JveajwUxah30oNqEmzTCYm/1YpqRcR123B2igcOQM4mmeaMSR7+DmS9glGyClTsb2XCf61m2+JH36i8RvgRtFCwj0EqVbGoG5nOm2rg48j/X4TMGzXTrBNYhtsGoxmbq3RO9T9zv3Zgs9uNUWFUk8IGz2qUBVofeuP8WaWYIi1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=II2SqVah; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uLucw0Zm; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707364807; x=1738900807;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=va/bJiL2sjWmvpiiKFnpo+5AogOkhYlYr9Auoe0hfK8=;
  b=II2SqVahkbbnHMiPe3p+NPzhXkuK3rkbumOzADwwhKdKXyzqME54rqGp
   lIIsUeKaDCH0nvkbX+4M0gCSH2WaUHxeAV5tzmYIonpHbWpIzQn+VLFQK
   foaVT9ZIjSV6cABS/437nXT6W/osY9d+UMK7gmAWgxBWYr7XdguI8Llut
   vWC7wQEYr/nDW7bmsCPw0eIcs7IUP4JI8j1jykMeqWgBMpC4g6D71pAxt
   1aPz+NtHUxVeQQy7n4nGEhl1hwVqegQblqwizFOoym76BlTX7Sk0fqNNW
   wfjvLb2VBYSHdikrmJQss8y6NwTrCeH3OR0d8rdC+m+Dx4wAoOrJpywn6
   w==;
X-CSE-ConnectionGUID: Zy1oJnMRQWivB9NAwN8PkA==
X-CSE-MsgGUID: 6Gsk/wkNS9iqOsz6bhyAJA==
X-IronPort-AV: E=Sophos;i="6.05,252,1701154800"; 
   d="scan'208";a="16461730"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Feb 2024 21:00:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 20:59:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 20:59:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJX9e3kFRkMkh8l967eS0bzs6TUSSVVomKbiQlx4FAnmDumkj5kptozQ0F/LcwWOSZStE68fUPIQRQff8YEMHEgk5S6JB6EeEsR63biRYFp+6Wfo+0UVQ9Un+E+prCaWrPx2OXUbeVqQJo32eD0xdGXgRf/MAuiOWVSnZJpCosCQBC+tVSO9koIw7wmbqXxnb8ytA+fVFB9HY20+/rh1+ayZTZp5qP/PyrocJPwrIXkYJpGR7VclA48KiXl8BoPkiK7oEMSh4J0/t9YYGaTOkrqEV5Qz5PRNw0E6PezAtiUL6UiKiCa8ZbM9wg1WjX4XHEZZYdk8dCyHclMQrVL0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=va/bJiL2sjWmvpiiKFnpo+5AogOkhYlYr9Auoe0hfK8=;
 b=YTbgyhTpxBaAUfO9T/vZkH289ShFIddaE9Ww7R520C070QDvSTRHBpPLzKcmKPqe5g1HRjbGxCbeBDXLdYPVq7ne3GkLt6l838543NWXpSsZ/mcX41H5Z9+FvFFtHbH9rrWcyKV8LuiaHe184ewB8Z6p/TdXA6VEPzhqWQV4d+qz4KTdYtgi/Z/tYR52oeIN95HEnlwuD1YvVNwSPHOnp+Ljv6Ur0gigUA3lVUJzh2QinvtV2kd7W8R71oy7T01tk+9gQJhu+zIB6f0ydzT/0aZ34hfDLRH1YrwsmoxaSxJ/9owIyXJ44YTUI9PBLUrir18USMhfNoo/jRbT0bnrig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=va/bJiL2sjWmvpiiKFnpo+5AogOkhYlYr9Auoe0hfK8=;
 b=uLucw0ZmPCwJsleZctIm/R2frEVMX742MoPcoyeJXaNQdafzFkco4XtD+U2iYgwytzl941MVLV9SlN+0g5uYDxbKQNRMIbj9VY/WgW+ZcJNv5gxUpUMZebOCTI9DGM4/27c1Rg1M/pAb4+J5po/bMH23JgSyPlm1v0Y+mOd3hvyQl2SLZkBk3XU/gNDdBo91qqnc3s5HRAuKj7obA+EBBADVi3Odbpp/iSO0/7v9dg8JE6e46b/ZqJITHguAv6go7UhkgViqtG9QC04jgxRCTLpmN2YZDFjNsYmQuGDzhcTs664HFfpDgTnM9MBtyhsTFp60vrfAvfWSFACs6apHcg==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by MW4PR11MB7127.namprd11.prod.outlook.com (2603:10b6:303:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 03:59:56 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 03:59:55 +0000
From: <Dharma.B@microchip.com>
To: <krzysztof.kozlowski@linaro.org>, <dmitry.torokhov@gmail.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: input: atmel,captouch: convert bindings to
 YAML
Thread-Topic: [PATCH] dt-bindings: input: atmel,captouch: convert bindings to
 YAML
Thread-Index: AQHaWaVZ3HXNK2d4rUGusN/lqEUw5rD+/aOAgADVnoA=
Date: Thu, 8 Feb 2024 03:59:55 +0000
Message-ID: <09c25824-f56b-4598-b8cc-1df992812754@microchip.com>
References: <20240207090853.188400-1-dharma.b@microchip.com>
 <982e81db-3bf9-49e9-b57f-a91612d62f5c@linaro.org>
In-Reply-To: <982e81db-3bf9-49e9-b57f-a91612d62f5c@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|MW4PR11MB7127:EE_
x-ms-office365-filtering-correlation-id: 2d6b871a-a675-4904-4f1c-08dc285a6945
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O0XGXavIroVkBVDDcNhf2JUlGnSGvS6HexPGPh07CndKBOelJ4NQyhwslz70/djZIDeXAzf2lIM7o4Lsx9xXT9XU89+lvCfHANVS6XD8rD37vW3uFUUBx1NC6ivUWlUhNARCbxumnOt2ht96cl7p6x6u3PHSLIeiKLIxXWbkdP0x8NZVXxTi2FMOF5bqkm6Ns0Z8QX3ep545ouQIALTDeU/D5kJ01Hippy8ighxqCVN54yL00i30o6G43sTemytvSn0rPziqOQ8JiUbNrSj0+rQEAO196S89NfNcybQh9t5FS73iiHYHoVkeMEOzduv+9UEXwMlfuHtp+13LPPMpXjQeH747DoExlkyuBKgL8QPkq1TPi60BJYZBDAYUY3uTpK7oE7BZQICIFMV1K8pkw9Kucg8MmsSkK44+rZu69S+5RXOB45nwyAopiuKIkbyKhA1dZ48bDiRIqRNNOfvcoiHUaRpsOaSZsKqk0doEeipzWGWSYzt47sIkk7x5EUWsbbeHlFKOxlz5pqaowbLvqS3+e3cYzZp89yf9s/eE5blCqY8o4C4Va+q1b06VK9Q4/6xC0cFaINKbp+R9bwKZ8XlmBN1866T5Rsnq5LIDf0goeZ2QwWMmDCNGEn1tUtsGQ2gPWOU6NCBqIrI6e9sq3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230273577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(921011)(5660300002)(7416002)(31686004)(41300700001)(31696002)(38100700002)(122000001)(26005)(2616005)(86362001)(53546011)(66476007)(110136005)(66946007)(6512007)(66446008)(66556008)(64756008)(71200400001)(76116006)(91956017)(36756003)(6486002)(478600001)(6506007)(38070700009)(8936002)(8676002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejZWZzBBa1FTZ0FEUUhIMEVMbDZDRDloL2M0SUt0MCtMS1BsdnZrKzl2ajhH?=
 =?utf-8?B?cDlQYW5jZG9JWWNZdWIzOVBNK1EvWTljblAwcUxHVmJieStBSmNaVmJWVmUx?=
 =?utf-8?B?cXk0VmNRRWlXcld6N21JaXBaWGl1QXJHaVgwZ0hIZmdwZzB1Q3ErVUFzUXVQ?=
 =?utf-8?B?b2VwMGF6QkV2eENDNlEwdWdFLzBmU0V5VHRmSDdYNG1JZ2E5VmNOdmhKVnRJ?=
 =?utf-8?B?RG5nRzM5OFNLZGJZOW54dEJoU2V4NUk1czFDcWJSYzhCYUpQK2NrL2pRM01o?=
 =?utf-8?B?OVN3d2R3dDhNVWFWdDJ3MnpNSE1WRTkzZk1PUkxIT2JTWnAvMndLM3RDc25h?=
 =?utf-8?B?THV2SStNMzVraUdweU9OWlhES2huWkRhbU1GNmprb2VrWThMSHBoM2swNTR5?=
 =?utf-8?B?SVNXcm1QMStWQ2MrOHFlM0Z0dnpRbmNDaWdQVk1aT0tKYm15Zys3T1ZzakVN?=
 =?utf-8?B?U3hVWllBeWF5ekFNVmZYSWRNb2krL3M5VmNqZkxMZ0ZyVUZnc0s5TU94MkVC?=
 =?utf-8?B?TFl0K1RrTVNWUVRWWm5iRkRKNzVEMEt4UGNucjJYNTVUVSswYUNPc1ZYbHZz?=
 =?utf-8?B?R0NML2VXVVVnazY2c1NnRW9SaWhZOThkMHR3ZEx0bis4dWprbms4RUxFemt6?=
 =?utf-8?B?dXFsS0p4TGRCL2VNRjFyY2xmNVNGM0dBUFBEMlZYeGFZSWxIT0wxNTkySGo5?=
 =?utf-8?B?VUpsNjZZZEFBOWNSTG5wblQ2dmk1RlF0NTlDVVFWVUtrSCtpenduSDMzaHdq?=
 =?utf-8?B?T2VaUk0wQm55SUpYV042OFZmRW84WnVkaDN1clpyWVUyNzZXZnovd1ZIbnFR?=
 =?utf-8?B?clFITjB4Si9YdlVIUXQ0UWRPTGhyNDhuTnBPQjBZNW1vRDBiK2g1UjMrOTZu?=
 =?utf-8?B?dHZMM2pYd3JHU1JBMDF0T3FEVE5OeGNNM0RmVld5SDlTSXRpWlBjTXBwNzE1?=
 =?utf-8?B?SitOYVZOWHdXcjRUM0dmaGppVVlaaHFTekpBWU9yK3BLTlB4Y3p4NjhSZG9Y?=
 =?utf-8?B?LzNMMnUvTU00eTFVc0l1cy9FcjlUcDJXSWhVcUFSTCtIMEZPdTFudVRBTEFs?=
 =?utf-8?B?RVZGY1QvMlhhemlSRDhKekU3Zy81c3BLQXhZUGhqeXpQdUR3Vll2UHZrdDR4?=
 =?utf-8?B?Y3N3Vi9VNEc3SWE5eCs3QlBjZTVXRE1Kb09jMjBma0o4UitJdDN2cDg1dVIv?=
 =?utf-8?B?SzJTUGRPaEpqbkorNDJQSjZCczFWMWJTUlhKVGV5aG5md2RqazkvaXlWMnRo?=
 =?utf-8?B?QnltSEVVTVNvNFVGZmpFLzJoUTJQZ1JxZ1FMNGFlekNOWlFaVGdlWUJFZDhH?=
 =?utf-8?B?YmpKeUJSZzNFMWovaDBocjAvaXh1RnlCemhqTmNTZ2p5Y29IczMxbGhYSzFs?=
 =?utf-8?B?bktwdEo4YURTMzlId01GZXIvUGR2b1NGMitsNUUzcWgyNS9RQis0dXdTQStW?=
 =?utf-8?B?bktHWWNmWU9udzBRdlNmbVgxeWc3cXBVeHBOT1VGSUtSVTg4TnN0ajErenFU?=
 =?utf-8?B?dXdsSHFEc0dYZ0t3bit2TWNjMDdhUUNIbXlxUkFnMHhhL2E1b01CT1oyRThm?=
 =?utf-8?B?bTVpbjNyRmxXbEtxMmRlRzI5WHBibHR5M20wN1ZVaURIZm9XTTk0RlcrZlVS?=
 =?utf-8?B?ZzN6dUkxVk5pRnl3dFlkbkRQREN4bGdGQ1BZdUwvNkdhQVBsNVZrcGVyTmxO?=
 =?utf-8?B?TkZEZ1FCNnF2SnJWcFlhMkdFRkFMN3lsdXpVdmVYbnh5YzB6RkkxbEZ1K1Q3?=
 =?utf-8?B?N0FzUGdMQWZ6ekp3eXA1UXJNM29TMUxaWmY0M0dnVXFlSTh6d1k4QjBFd0lP?=
 =?utf-8?B?UUVqaVVTVCsyY0RhOGRyejE4K1RXRUg1TFNqM1huUW42Z0Y4ZGNUSGZNZVJm?=
 =?utf-8?B?TmdLdGVSNGU1UzYzZk9ZUHdKSUFmMm8reWFnNEEzVWRyRFEvSUJVdG5ZUHRx?=
 =?utf-8?B?US9CdldNcURuRGNQNnNPVVArbFk3QTJadllYR0lxRnZTK3dkQ05zOEkzdlBi?=
 =?utf-8?B?QWdldW9CR0w4cGY2VjVaZ0ZEblNndUVQM3FkUlh2bjB4b1dHRWhJVWRkamxT?=
 =?utf-8?B?cVBOdFNWVDRsSWV5QW5VYVRKc1pyWnZkeXZwQzVIaTZEUXFnSlhiYjArdXRi?=
 =?utf-8?Q?7s7zFCa7pnA6mWXWV+jhBXS5Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44CCA08CCC61FB4A81D188B1C20938FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6b871a-a675-4904-4f1c-08dc285a6945
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 03:59:55.7707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t5S0cyYAf1voXtltiXyJP31jm9jzbreggD0dEDrnv9llmoHK/jkpEk281RPf+kDXCmTUg1d+eZ3zpXGiRGLftw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7127

SGkgS3J6eXN6dG9mLA0KDQpPbiAwNy8wMi8yNCA4OjQ1IHBtLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA3
LzAyLzIwMjQgMTA6MDgsIERoYXJtYSBCYWxhc3ViaXJhbWFuaSB3cm90ZToNCj4+IENvbnZlcnQg
dGhlIEF0bWVsIGNhcGFjaXRpdmUgdG91Y2hzY3JlZW4gYmluZGluZ3MgdG8gWUFNTCBmb3JtYXQu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRGhhcm1hIEJhbGFzdWJpcmFtYW5pIDxkaGFybWEuYkBt
aWNyb2NoaXAuY28NCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4gVGhlcmUgaXMgc29t
ZXRoaW5nIHRvIGRpc2N1c3MvaW1wcm92ZS4NCj4gDQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+
ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIGNvbnN0OiBhdG1lbCxjYXB0b3VjaA0KPj4gKw0KPj4g
KyAgcmVnOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgaW50ZXJydXB0czoNCj4+
ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGxpbnV4LGtleWNvZGVzOg0KPj4gKyAgICBt
aW5JdGVtczogMQ0KPj4gKyAgICBtYXhJdGVtczogOA0KPj4gKw0KPj4gKyAgYXV0b3JlcGVhdDoN
Cj4+ICsgICAgdHlwZTogYm9vbGVhbg0KPiANCj4gWW91IGNhbiBkcm9wIGVudGlyZSBwcm9wZXJ0
eSwgY29taW5nIGZyb20gaW5wdXQueWFtbC4NCg0KU3VyZSwgSSB3aWxsIGRyb3AgdGhlICdsaW51
eCxrZXljb2RlcycgYW5kICdhdXRvcmVwZWF0JyBwcm9wZXJ0aWVzLg0KPiANCj4+ICsNCj4+ICty
ZXF1aXJlZDoNCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSByZWcNCj4+ICsgIC0gaW50ZXJy
dXB0cw0KPj4gKyAgLSBsaW51eCxrZXljb2Rlcw0KPj4gKw0KPj4gK2FkZGl0aW9uYWxQcm9wZXJ0
aWVzOiBmYWxzZQ0KPiANCj4gSW5zdGVhZDoNCj4gdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxz
ZQ0KDQpOb3RlZCwgVGhhbmtzLg0KPiANCj4+ICsNCj4+ICtleGFtcGxlczoNCj4+ICsgIC0gfA0K
Pj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+
DQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnB1dC9saW51eC1ldmVudC1jb2Rlcy5o
Pg0KPj4gKyAgICBpMmMgew0KPj4gKyAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gKyAg
ICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPj4gKyAgICAgIGF0bWVsLWNhcHRvdWNoQDUxIHsNCj4g
DQo+IEluc3RlYWQ6DQo+IHRvdWNoc2NyZWVuPyB0b3VjaHBhZD8gaWYgbm9uZSBvZiB0aGVzZSwg
dGhlbiBqdXN0ICJ0b3VjaEA1MSINCg0KSSB3aWxsIGdvIHdpdGggdG91Y2hANTEuDQoNClRoYW5r
cy4NCj4gDQo+PiArICAgICAgICBjb21wYXRpYmxlID0gImF0bWVsLGNhcHRvdWNoIjsNCj4+ICsg
ICAgICAgIHJlZyA9IDwweDUxPjsNCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRv
Zg0KPiANCg0KLS0gDQpXaXRoIEJlc3QgUmVnYXJkcywNCkRoYXJtYSBCLg0KDQo=

