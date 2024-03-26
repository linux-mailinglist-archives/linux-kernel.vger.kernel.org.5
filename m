Return-Path: <linux-kernel+bounces-118534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D69488BC3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E810F2E2287
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65130133998;
	Tue, 26 Mar 2024 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ev2fH26g"
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9091292FD;
	Tue, 26 Mar 2024 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441664; cv=fail; b=GCNMB7STVqSM9gQVZqd9+luI2AYobAapZvxA9PylL1QUSbzY5sj8saHrlvKHZo/TnIVXnN772bUMGNZ1d6b6WYBMz6Sd7JuZ5IJT4tuR2tT/9eK9JPyomTzs8J49PzviDhRcX+HPSHbR8gyPwBEPiHKHPSVffR5PgiDOogL6e1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441664; c=relaxed/simple;
	bh=eWtcXl2zckthjkczo8pKX3GfgDJQpjcnlj82R61yApU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YDngzh3UqJjI98BE6B98wZBbxsTuVFyVQbrmYUj5cc8SaYqrUSsrhIeqJq2UFP8QN3tuvgdL3zbLqHC40nBoL904d+/4R0/wSP++8XbKmuUluS6T4V6nsIUPaRq3sAa+3InK0D0Ssp4Jl+GiDKcmmyssz5kfAye599VVNP9CgnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ev2fH26g; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1711441660; x=1742977660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eWtcXl2zckthjkczo8pKX3GfgDJQpjcnlj82R61yApU=;
  b=ev2fH26gDjFcSSv3617lkCxr/zC5tL3AXdSGjcWNCZQ97M8rB+OcC5AK
   yGWiAGSvC2vxKSzJRom33KJm7UMedSQLBWc/N6xMKbHHz56zRbL43RDza
   mpkxMWtWuODLosXD7NVtDw84rjrqllnT4wCBSOwt7q1XoD/WO4Ssxbh/T
   VqTO+4keEpbzUj60cTNrRL6ut1CLQ2aFqHCfN7La9Q2bptGMkdezsP+e4
   uuq3j7fP9Fn+DFEq27Qi1M0J2Mc9j/iwvTvKa9Lc4L3ZzVgncxs30pmNO
   E5jQYL2LXkj74WkypgFOwFEpClhjJr1yCR7q/JZKv3dNXsu84mglq5N6X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="115017532"
X-IronPort-AV: E=Sophos;i="6.07,155,1708354800"; 
   d="scan'208";a="115017532"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 17:26:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHZtU4OmOiKIcIbpFdfMdXPXQgJmn7IMlEsbPhapIX0xUtpnX9MWdya8MVJ+OiAiFeHPY7ikWr7jBVhhtAwqb7X5+yTDCt8L27XUDFrtl5Zp35XG5QpLy24xQQvDavveXYAWWRpuwJhk7YsNdYKOhJkhUn7PgxuzDPk3nydNTDKQ6o2bJDFKY1aFWx8C1Uha7EW3DJBJOwMYuOWz8oq+RgGArjikPfe5voXZZoaEFwFD0KfctVXg+JStJKihQnbEl3I8kaPzY6F+wzd6Q5QC/6KjIesfMR63mEPsYjjIplwJ9p37CYZ8uV4A+yvvMFlA1ms+n0WScLw9GbiFDQEXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWtcXl2zckthjkczo8pKX3GfgDJQpjcnlj82R61yApU=;
 b=R5gYLHjZL7QyKA48BMiqqFeA5OeS4j9ldA6At9jd30W+zBLlUAK+UCj+AkOg90qtQsTiTxwwVbgYOBdYfuFDxkkAI0GUGv7jT9dWZ4bbHConueaxLA99abuqaissdi2xfeYkklmGT3q8f2gzi7x0qVNRQmEJV1QMuuaY58wXmLMujaqnIGW9oRJL36QGqnR954iQdNxEpgvf4RZPELTXwoVNYXAkpR9ks3OYh7qVxjYcjA39prL8/dntro+iMy5Ar69C6U6+dwLC2Q3B8hCZ8K0tLtSETYO3F4IcSFum0O09VyJjGgKmQ3gyf3YOQxsxBVE+a/kGkyxaVgQmb48hFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by TYCPR01MB7180.jpnprd01.prod.outlook.com
 (2603:1096:400:f3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 08:26:22 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974%5]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 08:26:21 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xingtao Yao
 (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Subject: Re: [Problem ?] cxl list show nothing after reboot Re: [PATCH v2]
 cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS
 window
Thread-Topic: [Problem ?] cxl list show nothing after reboot Re: [PATCH v2]
 cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS
 window
Thread-Index: AQHaYPF+guY7ES5MRk+p0kfVt2bmsbFDTJAAgAagGoA=
Date: Tue, 26 Mar 2024 08:26:21 +0000
Message-ID: <24b8b11d-a7ec-42ce-9fa6-8a24701cfe46@fujitsu.com>
References: <20240216160113.407141-1-rrichter@amd.com>
 <b0f5e2ce-d39e-4a8e-8f2f-ffa67b604e02@fujitsu.com>
In-Reply-To: <b0f5e2ce-d39e-4a8e-8f2f-ffa67b604e02@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|TYCPR01MB7180:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xwAYLZlKCO856sY2xZoZrvO1c8w1pIwAG0UUNLAAxxTpOBmGw0YX/VT23oZYrU6pCpSfWQ1u7OFV92fp9qhNgE7oM8FH5cn5PLnOX2YwpsA1if4QdbAD04gXXjLit+721Dr0S5fxl+0g4960wRieBTBOuQNcg9Txvw5fFwshQnshDNzg7OnSzt0vmJ70Z8dx9CtoVO2dbZqjPk9TCebP7L6z6K5BLDHLaK3ydjydCwKifYpYVN6zI+1CQ9KzuX14htqbWyne7KVmcuKF+l2/I/sWgRo8fpWMdOttuWG3xFQDfNj+h6KJgDhIt5z5Kv172sIct0ffliTFDaxtJJbHas4D7NoX6wTWsvDk1ynlHub5VXQMbr9vl7pn+SsA7i8ujBIWq87vc3W57glOEIy2kfuXP+zyc2fBsXXrBvqrADxnfAoAFA68aXW9EAs2Tqgm/9VNp0jPa1yU3DDYFKN+q4epDTKJjFxeyocXEanrBnaixFTIEuS+WZHcigwdygabT61aT063k4av9Ii8j7WKIMU9tDmPrhZ0tOBm5AwxVuRk7X1IwpbzDGkZZjh3va85QhoHRvDKMLYtCLy2Ci9Wc9+M2dSiK0xbj88gZeBH5zfYgId2wNwj8SHsPmHRwChBAcKJ5+aQjTi1jHc6Fr575aYbMZc/4066xbaj+DegQr6ZhzhIuLlNXBN5ortrU+MCFN3rXKdNhVWskfxdYJ544Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dW9wK1FEQkVPTnZlaU9oNnppSHVnaVJOQldIcy9HUVlrVytPT0xEMW5qSlVq?=
 =?utf-8?B?dzJDTi84aDZyNEg4eHdWVDErVXJ2bFVwWG9UNkdWY0ExMjN5c0hnTUFFalB6?=
 =?utf-8?B?YVVRenk0bXFrRjZtdVBYeTN4WmJZZUxycXRTQ0RtVHFUcmlKSTduSUpzNjZI?=
 =?utf-8?B?TUNnMi9FcHBYWnNxQkQ2WXllc1V5TUlydkdHYkZ5SHJrVmNPNWtyQVhPcEs1?=
 =?utf-8?B?ODdsRElpQkh2TmdKSHYrU1ZHMyt6ZndNR3hKRzVxU1luUit1RGUyVWRjb3F0?=
 =?utf-8?B?VThkZTJHc1I2MmRSZlJkcWZtYUFpNTc1U2hSVlpBNzgwOEZwTHpRem5yTXdF?=
 =?utf-8?B?OExCSnpRNzIvK2RrblNYL3pmdjJhMHBRQTNzYlB6UFhJOE5IRWVkZ3k2Unox?=
 =?utf-8?B?bTQyVGlLMEZqOFFZTWtLV2ljWEpPbVRYdEFteHMvckhWRzdhUm56cms5azdW?=
 =?utf-8?B?OFVEZVVPTnJLVVlrenVFdHh6Znh5TWpleko2V1F0dUo4alZGcU0zVzltNEVW?=
 =?utf-8?B?Qm1IampLTmlwK3FNOEZ2dFlVd2QvTnFRQkJRZTJtMjVpcXFrQ2R5UUNpYk9B?=
 =?utf-8?B?WHFHRWh6ZE9DZGpWS3FIKzhzTkZuemtidzZwbUxQaStGa3BVM0FoY2VFQkxr?=
 =?utf-8?B?aE9MNGRTdEVhdVB5SWRKUGNaZ0lreUs1dklkNkZLRDJwRDIxd3J5anVRUGdu?=
 =?utf-8?B?U011WkxaVVF5aXFXcW50WVNZK2dsY2Vqb2FPMll3c0E1ZytvWGR5VmM0YmNE?=
 =?utf-8?B?bzJ1VnpnaVdPMmdDVUY2ZTh1WGFYakJiK29aUDdtNER2OTFMdWpDQndkZTRi?=
 =?utf-8?B?ZTN0QzFDUjY1TWt6VFczTHFPOEUrNENmK2hjYlZZVzEvOC95RzNOT3BkQWtD?=
 =?utf-8?B?aUV0NnN3VVFCeG1kQXRKUTNNVGhFM3pRVWo1NjhiWlpyU0VoY2kxNXNnQm9B?=
 =?utf-8?B?QW1oS29SMGZaNkppanhrUDM2WTFRYlVsaEJQTXNOTVUxcDRhQXQ0NGxmbGlw?=
 =?utf-8?B?UjhTU0IvN2lIK3dvWjgxck45eTlVM1UzSUV1MzZaaEt4UVRlZ3kvQUJlMmtK?=
 =?utf-8?B?THFjT2V1ZEwyOHhYcG85aVUzUFFQNHY0MEc5aTZpaU1kZXY1Y0dHT3pmQ2Jh?=
 =?utf-8?B?OTBqTWFZYkNaTjVVSk9ObzFIa0oyRWp5QW81SlBrKys2cVA4eCtYdjFDaGUz?=
 =?utf-8?B?aXlLT29rTGpCaEh6QWVqV0R3SDFzVmF2bzhBeWZ5Z1pSdlZ1Y3BCWHFxbnF0?=
 =?utf-8?B?dDdKVjZSbnh6bEpUendCNjRPdi81S0w0ZFozUW1ScUU3bi9YY2tUbFo5bDNk?=
 =?utf-8?B?OUJxRkxLS2p5WU1pODdPK2FlbVEyTDRiWjlrWFAyc0ZlZDFkeHBncW51Yncy?=
 =?utf-8?B?NHA4RnNhVHdDcnJWSVl6TGxhd09pM2F2amI0TXJpODlGa3ZiNzBpSDlCS1N6?=
 =?utf-8?B?R3VZSUV6Sld4WEJ2QXc3STEyUUFwdjhzekZzQWRsNG1IY0ZCbjBZbVNMR3FB?=
 =?utf-8?B?U3BmT2ExS1JOVHF3Q09walJTSHRGclV6MnZRS0N1WFZrQzNhWGJ0VXlmaG9D?=
 =?utf-8?B?SGVSR3I0VGtrYmhDRnUxQnRnL2NFMkFUVEtHRjdlNEZmQ0lEZWlHZm1yNlZa?=
 =?utf-8?B?Mzg1RFpoT2lFNzBQNTE0eVJrMys4bGFMTDhWUmlnOGU0TE9jR3l6R0lJM1ZW?=
 =?utf-8?B?ajRZWDlwTSsrUDBvc3U4NzlHZS93a0RvekV6ZERkWGl0NGJhQU5nYlZiTG1K?=
 =?utf-8?B?UFVjbWdDUjMzUjE5SXB3djdpem1rTmhRN3JURE81UWpYeXg5VWUzM1BlNFB4?=
 =?utf-8?B?azczNDBtdTk3cEhQWnFya0M1WFRhZVk1L0hJdmdVNU1ZL2l1VEFuTHRtSWlX?=
 =?utf-8?B?YU1oNWZISWtobnNYb1hJR0dHZ2VKN0Z5bEJXV3JvQ2xHanBsa1ZZcnUzNHpi?=
 =?utf-8?B?T1VuY1E4aHFaU0UxNVVUcTFOL0lNY2krOE1kelZDc2Q5eXp2YnNzWDdJR0xN?=
 =?utf-8?B?NUVvVnVOM1JNZVU2cHJ6OTkyNE1PYms3NERlenhLWFVyNEV3WTBaaS95MU9q?=
 =?utf-8?B?Wm14TFdYQmJpdko2aWhXc2tLbTZaMHhlazF0ejJObEQ2MjhhUXlndTVvSFlS?=
 =?utf-8?B?c08zVXdObGVPekYrTG9WVkJ0Wm1xbTVCV2tHd0FxRXcvbEE0Q2VVdmhMU0I1?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C61840F99A4F01449CC6BB9DB9635249@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FKQwpwEGlKHf36XBQWS1CPHOAPufMcYGZSQCn9xcqz3Y/SipMZNZMsOj0qjoJdpC4s2NW2cjj6/F9kfhNqbOrFjxVwum7udCkBhp3cfSJGpycM+oFBGLU9c9vQeYu03hXdxiIJ/HjpVKJlEz41OJIaytIvYNJ12uW8HW81CRikyiqmT30JYUdHUc/yYpiy8bfWPgq/xuKpP8/+9IsBYPTgKmqRzOj4c2EshmwGq2I0nXYDAEoSS0E9OPBY5zDoOjk3/rwXwnVU5Y3ktIMCtQ5uNgLOi0A8MUnguTlqcFaQS7bV0nei8diDu/ANZ6zSY0g1hACMTcL3zlAcCkT1XQZ80SyIowv5X1u3oPOo54nBELjQmqfilfrShEhXO4XgCgRJRZNMLSTomvTQkp1Dv+s+ko+IELMnowRRLkMHD+fprZACHenv5P3dGuONcgACmKxga4fmTToWbIi+pW4ixVGgqa3K2vT08dN4Gyf3DPA1fTh2q6ZnEhBaMB0Zp1D//QJduEaD+X16BHeIYaIu1XS/Xk4oxk3l+mTtQeReVajfl7Li2RuWrcRL0dZUw9RfbQmVV+5qMcqUTeOD96RL7acQPBVvUmcVbyrKP47cBh5bzZ+eq2VqZ00JG39LUzS2FL
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03962e5-8a89-48bd-a0ce-08dc4d6e6b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 08:26:21.8054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JESoYoQhB/69eHAZoF/CJNC7TUmi65nMdmRj9XHvqeGRqFG2r7nkle3DfgSX+PnRiDbKQ/8AlpsP6qmcTxOWwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7180

QWxsIGd1eXMsDQoNCkluIG9yZGVyIHRvIG1ha2UgdGhlIENYTCBtZW1kZXYgd29yayBhZ2Fpbiwg
aSBoYXZlIHRvIG1vZGlmeSB0aGUgUUVNVSBzaWRlDQp3aGVyZSBpdCByZXNldHMgdGhlICJEVlNF
QyBDWEwgQ29udHJvbCIgZHVyaW5nIHJlYm9vdC4gQSBkcmFmdCBjaGFuZ2VzIGlzIGFzIGJlbG93
Og0KDQpQZXIgOC4xLjMuMiBEVlNFQyBDWEwgQ29udHJvbCAoT2Zmc2V0IDBDaCksIERlZmF1bHQg
dmFsdWUgb2YgQklUKDIpIGlzIDAuIFNvIGlzIGl0IHJlYXNvbmFibGUNCnRvIGhhdmUgYSByZXNl
dCBkdnNlY3MgaW4gUUVNVSBkdXJpbmcgcmVib290Pw0KDQpBbnkgY29tbWVudHMgQEphbmF0aGFu
DQoNCg0KW3Jvb3RAaWFhcy1ycG1hIHFlbXVdIyBnaXQgZGlmZg0KZGlmZiAtLWdpdCBhL2h3L21l
bS9jeGxfdHlwZTMuYyBiL2h3L21lbS9jeGxfdHlwZTMuYw0KaW5kZXggYjBhN2U5ZjExYjY0Li4z
MTc1NWE5ZjlhYWIgMTAwNjQ0DQotLS0gYS9ody9tZW0vY3hsX3R5cGUzLmMNCisrKyBiL2h3L21l
bS9jeGxfdHlwZTMuYw0KQEAgLTg5OSw2ICs4OTksMjYgQEAgTWVtVHhSZXN1bHQgY3hsX3R5cGUz
X3dyaXRlKFBDSURldmljZSAqZCwgaHdhZGRyIGhvc3RfYWRkciwgdWludDY0X3QgZGF0YSwNCiAg
ICAgIHJldHVybiBhZGRyZXNzX3NwYWNlX3dyaXRlKGFzLCBkcGFfb2Zmc2V0LCBhdHRycywgJmRh
dGEsIHNpemUpOw0KICB9DQogIA0KK3N0YXRpYyB2b2lkIGR2c2Vjc19jdHJsX3Jlc2V0KENYTFR5
cGUzRGV2ICpjdDNkKQ0KK3sNCisNCisgICAgIGlmIChjdDNkLT5zbiAhPSBVSTY0X05VTEwpIHsN
CisgICAgICAgIHBjaWVfZGV2X3Nlcl9udW1faW5pdChjdDNkLT5jeGxfY3N0YXRlLnBkZXYsIDB4
MTAwLCBjdDNkLT5zbik7DQorICAgICAgICBjdDNkLT5jeGxfY3N0YXRlLmR2c2VjX29mZnNldCA9
IDB4MTAwICsgMHgwYzsNCisgICAgfSBlbHNlIHsNCisgICAgICAgIGN0M2QtPmN4bF9jc3RhdGUu
ZHZzZWNfb2Zmc2V0ID0gMHgxMDA7DQorICAgIH0NCisNCisgICAgLy8gRklYTUU/OiBvbmx5IHJl
c2V0IGN0cmwgaW5zdGVhZCBvZiByZWJ1aWxkaW5nIHRoZSB3aG9sZSBkdnNlY3MNCisjaWYgMA0K
KyAgICBtZW1jcHkocGRldi0+Y29uZmlnICsgb2Zmc2V0ICsgc2l6ZW9mKERWU0VDSGVhZGVyKSwN
CisgICAgICAgICAgIGJvZHkgKyBzaXplb2YoRFZTRUNIZWFkZXIpLA0KKyAgICAgICAgICAgbGVu
Z3RoIC0gc2l6ZW9mKERWU0VDSGVhZGVyKSk7DQorI2Vsc2UNCisgICAgYnVpbGRfZHZzZWNzKGN0
M2QpOw0KKyNlbmRpZg0KK30NCisNCiAgc3RhdGljIHZvaWQgY3QzZF9yZXNldChEZXZpY2VTdGF0
ZSAqZGV2KQ0KICB7DQogICAgICBDWExUeXBlM0RldiAqY3QzZCA9IENYTF9UWVBFMyhkZXYpOw0K
QEAgLTkwNyw2ICs5MjcsNyBAQCBzdGF0aWMgdm9pZCBjdDNkX3Jlc2V0KERldmljZVN0YXRlICpk
ZXYpDQogIA0KICAgICAgY3hsX2NvbXBvbmVudF9yZWdpc3Rlcl9pbml0X2NvbW1vbihyZWdfc3Rh
dGUsIHdyaXRlX21zaywgQ1hMMl9UWVBFM19ERVZJQ0UpOw0KICAgICAgY3hsX2RldmljZV9yZWdp
c3Rlcl9pbml0X3QzKGN0M2QpOw0KKyAgICBkdnNlY3NfY3RybF9yZXNldChjdDNkKTsNCiAgDQog
ICAgICAvKg0KICAgICAgICogQnJpbmcgdXAgYW4gZW5kcG9pbnQgdG8gdGFyZ2V0IHdpdGggTUNU
UCBvdmVyIFZETS4NCg0KDQoNCg0KDQpPbiAyMi8wMy8yMDI0IDExOjE1LCBaaGlqaWFuIExpIChG
dWppdHN1KSB3cm90ZToNCj4gUm9iZXJ0LCBEYW4NCj4gDQo+IEl0J3Mgbm90aWNlZCB0aGF0ICdj
eGwgbGlzdCcgc2hvdyBub3RoaW5nIGFmdGVyIGEgcmVib290IGluIHY2LjguKEEgZnJlc2ggYm9v
dCB3b3JrcykNCj4gVGhlIGdpdCBiaXNlY3Rpb24gcG9pbnRlZCB0byB0aGlzIGNvbW1pdC4NCj4g
DQo+IEhhdmVuJ3QgaW52ZXN0aWdhdGVkIGl0IGRlZXBseSwgSSdtIHdvbmRlcmluZyBpZiBpdCdz
IGEgUUVNVSBwcm9ibGVtIG9yDQo+IHNvbWV0aGluZyB3cm9uZyB3aXRoIHRoaXMgcGF0Y2guDQo+
IA0KPiANCj4gUmVwcm9kdWNlIHN0ZXA6DQo+IA0KPiAxLiBTdGFydCBhIGN4bCBRRU1VIFZNDQo+
IDIuIGN4bCBsaXN0IHdvcmtzDQo+IGN4bCBsaXN0DQo+IFsNCj4gICAgIHsNCj4gICAgICAgIm1l
bWRldiI6Im1lbTAiLA0KPiAgICAgICAicmFtX3NpemUiOjIxNDc0ODM2NDgsDQo+ICAgICAgICJz
ZXJpYWwiOjAsDQo+ICAgICAgICJob3N0IjoiMDAwMDo1NDowMC4wIg0KPiAgICAgfSwNCj4gICAg
IHsNCj4gICAgICAgIm1lbWRldiI6Im1lbTEiLA0KPiAgICAgICAicG1lbV9zaXplIjoyMTQ3NDgz
NjQ4LA0KPiAgICAgICAic2VyaWFsIjowLA0KPiAgICAgICAiaG9zdCI6IjAwMDA6MzY6MDAuMCIN
Cj4gICAgIH0NCj4gXQ0KPiANCj4gMy4gcmVib290IFZNDQo+IDQuIGN4bCBsaXN0IHNob3cgbm90
aGluZyBhbmQgaGFzIGZvbGxvd2luZyBkbWVzZw0KPiANCj4gY3hsIGxpc3QNCj4gWw0KPiBdDQo+
ICAgICBXYXJuaW5nOiBubyBtYXRjaGluZyBkZXZpY2VzIGZvdW5kDQo+IA0KPiAuLi4NCj4gDQo+
IFsgICAgNi4yNDkxODhdICBwY2kwMDAwOjUzOiBob3N0IHN1cHBvcnRzIENYTA0KPiBbICAgIDYu
MjU4MTY4XSAgcGNpMDAwMDozNTogaG9zdCBzdXBwb3J0cyBDWEwNCj4gWyAgICA2LjQ5MDU2OF0g
Y3hsX3BjaSAwMDAwOjU0OjAwLjA6IFJhbmdlIHJlZ2lzdGVyIGRlY29kZXMgb3V0c2lkZSBwbGF0
Zm9ybSBkZWZpbmVkIENYTCByYW5nZXMuDQo+IFsgICAgNi40OTQyOThdIGN4bF9tZW0gbWVtMDog
ZW5kcG9pbnQzIGZhaWxlZCBwcm9iZQ0KPiBbICAgIDYuNTA2MDcyXSBjeGxfcGNpIDAwMDA6MzY6
MDAuMDogUmFuZ2UgcmVnaXN0ZXIgZGVjb2RlcyBvdXRzaWRlIHBsYXRmb3JtIGRlZmluZWQgQ1hM
IHJhbmdlcy4NCj4gWyAgICA2LjUxNTA5Ml0gY3hsX21lbSBtZW0xOiBlbmRwb2ludDMgZmFpbGVk
IHByb2JlDQo+IFsgICAxMi4xODExODhdIGthdWRpdGRfcHJpbnRrX3NrYjogMTggY2FsbGJhY2tz
IHN1cHByZXNzZWQNCj4gDQo+IA0KPiBUaGFua3MNCj4gWmhpamlhbg0KPiANCj4gDQo+IE9uIDE3
LzAyLzIwMjQgMDA6MDEsIFJvYmVydCBSaWNodGVyIHdyb3RlOg0KPj4gVGhlIExpbnV4IENYTCBz
dWJzeXN0ZW0gaXMgYnVpbHQgb24gdGhlIGFzc3VtcHRpb24gdGhhdCBIUEEgPT0gU1BBLg0KPj4g
VGhhdCBpcywgdGhlIGhvc3QgcGh5c2ljYWwgYWRkcmVzcyAoSFBBKSB0aGUgSERNIGRlY29kZXIg
cmVnaXN0ZXJzIGFyZQ0KPj4gcHJvZ3JhbW1lZCB3aXRoIGFyZSBzeXN0ZW0gcGh5c2ljYWwgYWRk
cmVzc2VzIChTUEEpLg0KPj4NCj4+IER1cmluZyBIRE0gZGVjb2RlciBzZXR1cCwgdGhlIERWU0VD
IENYTCByYW5nZSByZWdpc3RlcnMgKGN4bC0zLjEsDQo+PiA4LjEuMy44KSBhcmUgY2hlY2tlZCBp
ZiB0aGUgbWVtb3J5IGlzIGVuYWJsZWQgYW5kIHRoZSBDWEwgcmFuZ2UgaXMgaW4NCj4+IGEgSFBB
IHdpbmRvdyB0aGF0IGlzIGRlc2NyaWJlZCBpbiBhIENGTVdTIHN0cnVjdHVyZSBvZiB0aGUgQ1hM
IGhvc3QNCj4+IGJyaWRnZSAoY3hsLTMuMSwgOS4xOC4xLjMpLg0KPj4NCj4+IE5vdywgaWYgdGhl
IEhQQSBpcyBub3QgYW4gU1BBLCB0aGUgQ1hMIHJhbmdlIGRvZXMgbm90IG1hdGNoIGEgQ0ZNV1MN
Cj4+IHdpbmRvdyBhbmQgdGhlIENYTCBtZW1vcnkgcmFuZ2Ugd2lsbCBiZSBkaXNhYmxlZCB0aGVu
LiBUaGUgSERNIGRlY29kZXINCj4+IHN0b3BzIHdvcmtpbmcgd2hpY2ggY2F1c2VzIHN5c3RlbSBt
ZW1vcnkgYmVpbmcgZGlzYWJsZWQgYW5kIGZ1cnRoZXIgYQ0KPj4gc3lzdGVtIGhhbmcgZHVyaW5n
IEhETSBkZWNvZGVyIGluaXRpYWxpemF0aW9uLCB0eXBpY2FsbHkgd2hlbiBhIENYTA0KPj4gZW5h
YmxlZCBrZXJuZWwgYm9vdHMuDQo+Pg0KPj4gUHJldmVudCBhIHN5c3RlbSBoYW5nIGFuZCBkbyBu
b3QgZGlzYWJsZSB0aGUgSERNIGRlY29kZXIgaWYgdGhlDQo+PiBkZWNvZGVyJ3MgQ1hMIHJhbmdl
IGlzIG5vdCBmb3VuZCBpbiBhIENGTVdTIHdpbmRvdy4NCj4+DQo+PiBOb3RlIHRoZSBjaGFuZ2Ug
b25seSBmaXhlcyBhIGhhcmR3YXJlIGhhbmcsIGJ1dCBkb2VzIG5vdCBpbXBsZW1lbnQNCj4+IEhQ
QS9TUEEgdHJhbnNsYXRpb24uIFN1cHBvcnQgZm9yIHRoaXMgY2FuIGJlIGFkZGVkIGluIGEgZm9s
bG93IG9uDQo+PiBwYXRjaCBzZXJpZXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUm9iZXJ0IFJp
Y2h0ZXIgPHJyaWNodGVyQGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgIGRyaXZlcnMvY3hsL2NvcmUv
cGNpLmMgfCA0ICsrLS0NCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2NvcmUvcGNpLmMg
Yi9kcml2ZXJzL2N4bC9jb3JlL3BjaS5jDQo+PiBpbmRleCBhMGU3ZWQ1YWUyNWYuLjE4NjE2Y2E4
NzNlNSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvcGNpLmMNCj4+ICsrKyBiL2Ry
aXZlcnMvY3hsL2NvcmUvcGNpLmMNCj4+IEBAIC00NzgsOCArNDc4LDggQEAgaW50IGN4bF9oZG1f
ZGVjb2RlX2luaXQoc3RydWN0IGN4bF9kZXZfc3RhdGUgKmN4bGRzLCBzdHJ1Y3QgY3hsX2hkbSAq
Y3hsaGRtLA0KPj4gICAgCX0NCj4+ICAgIA0KPj4gICAgCWlmICghYWxsb3dlZCkgew0KPj4gLQkJ
Y3hsX3NldF9tZW1fZW5hYmxlKGN4bGRzLCAwKTsNCj4+IC0JCWluZm8tPm1lbV9lbmFibGVkID0g
MDsNCj4+ICsJCWRldl9lcnIoZGV2LCAiUmFuZ2UgcmVnaXN0ZXIgZGVjb2RlcyBvdXRzaWRlIHBs
YXRmb3JtIGRlZmluZWQgQ1hMIHJhbmdlcy5cbiIpOw0KPj4gKwkJcmV0dXJuIC1FTlhJTzsNCj4+
ICAgIAl9DQo+PiAgICANCj4+ICAgIAkvKg==

