Return-Path: <linux-kernel+bounces-86339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B69386C41B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A60B238C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16408535CE;
	Thu, 29 Feb 2024 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oewyCICa";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="wCEgMUxo"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C3253E23;
	Thu, 29 Feb 2024 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196473; cv=fail; b=C7pJdPME3b64ryh+rfxg0wKng1e5y7p3Gu+9Z6yexwrXqBZetOYPPXaDsxzmRnlXXI2iZ8mZ1rQP04uDxQBDxLumtmvxWrUgPQCNRZi3EFb/kQ05zWEHNwdvgVIQyDIeJP6Heoc0eA0Y26M/UZRxy9eOQTpbbbTLMWZ03w1Fxk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196473; c=relaxed/simple;
	bh=FD70Egp4eK8vGqNzJAWntb+OgiwySfR5nvk3f/xeJ+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZDK3TN1Nsp4WnPTIrg0KPDXOFgCaM0/mpvczhH+jCFy5Gnx4bpnRIsi5l6qvVYABiWvpgfXehrY3mz57EnaKi6tMEJFAOznQ2/xD3vWbUsyS9/CalJyKTURxOAFYC7FRq/0x83tx3uu76Zij3wUXyjDzRAq8KSR8u8BdLWrFfjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oewyCICa; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=wCEgMUxo; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 34ed268ed6df11eeb8927bc1f75efef4-20240229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=FD70Egp4eK8vGqNzJAWntb+OgiwySfR5nvk3f/xeJ+0=;
	b=oewyCICazGbOI2xtZL/cLJGsUbeOtJs9pWSKuRLRvg8Rnywc/dqfFPusjyW5CfWN+0cO/EP+e4E6fkhUtAp+nQjnMj6ylrKso5eveMQa+yKqe6eereIPTJvVGBfl254QLChfUymbHZdBan7E5DKE29SIpsXcwtyv5sAnRDzDWDE=;
X-CID-CACHE: Type:Local,Time:202402291625+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:9eb50b44-fefa-4508-9c3d-f3226264029d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:0602d98f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 34ed268ed6df11eeb8927bc1f75efef4-20240229
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 281496792; Thu, 29 Feb 2024 16:47:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Feb 2024 16:47:43 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 29 Feb 2024 16:47:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkfENlz64qejsS3b897G224fCWDFGi+HqVzA/ol1nAVj7HGFutvQdpZuy43RhX66u6dDTMlIkkES3ZGdkM18Ly/M16NR2ZMXMCjOpCdg6+czBJMauYSCIT5AYEKkMDIKM9HvpKcyqiEWfAXHvpfe5uNZdGdzQnynW5DdCF0p3BPppTaX/pfyvmHV6hJov29Hw55H5eQPbHGCPwwub8UifB7uPZB2huN2idUWd/7XPyQ0MVpDYWIWSWATdEO4bd/bI5SCxbXZJAJ0JbeNCgs0eoHKJd5n/bJzSLwptbOjW32t/NgBa8AN3cYcmyeqVJUVmm/pJIc60ELREaOBNQYqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FD70Egp4eK8vGqNzJAWntb+OgiwySfR5nvk3f/xeJ+0=;
 b=AjUTsOnt2duw0JIJZD4l5r4oWXnZYi7xAS5Vf1Pwdh+UoJ8pQsgSMcphrD+T1ZTBtsLJh6fQ/I2UisrrLBzV5joCKrRST3w0wAn3eQelxlB7LRzTVJPVnSZERDySnkehqXPjRbdKyxQb63AtQRJQF4TBELtbL9bpMajJjJpNOaOexeGD5s5V/0XDCaIEEMfgdioDYm5P+tyYyxeCq5TK2YaJdY+DFrWQzVbLUMwv+eqFpPdzVPyriPO7jX1CdUaBn0oR1mE95DSm8j1/CJ5NXlJLxsBhJh1R9PJNtG7HJx0038aM+DQXEnI7eEykHHI7Chy7CvvUHBIHZjzuZOk3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FD70Egp4eK8vGqNzJAWntb+OgiwySfR5nvk3f/xeJ+0=;
 b=wCEgMUxo5M8iR3zwkmStHxtXT3apOjdbqT22AwgvvuOJ63q6EnV6Lu/noVOOp1Ze6sBBE2bUDVYK+dnmXiA+puhRUcXEUUyquQQCfbGDs31uno9LdtBPC9UylxWIrodL86lY7jHminc4L8wEXMhvyPm9n1HHXmbfLlTtlQGFrPY=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by PUZPR03MB7014.apcprd03.prod.outlook.com (2603:1096:301:f0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 08:47:40 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea%2]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 08:47:40 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, =?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net v3] ipv6:flush ipv6 route cache when rule is changed
Thread-Topic: [PATCH net v3] ipv6:flush ipv6 route cache when rule is changed
Thread-Index: AQHaalw91Rv7H6OFS0Wr4eaCYscTYLEf5w2AgAESBACAAAeyAP///qsA
Date: Thu, 29 Feb 2024 08:47:39 +0000
Message-ID: <263e5591e162a662b96a574b3629d0e82bd276f5.camel@mediatek.com>
References: <c9fe5b133393efd179c54f3d7bed78d16b14e4ab.camel@mediatek.com>
	 <Zd9WU1bpoOlR9de7@nanopsycho>
	 <5a422630db12a06a4e8d064d9dd2c7402a4bbe07.camel@mediatek.com>
	 <ZeBCpOAiQ_-DKEKi@nanopsycho>
In-Reply-To: <ZeBCpOAiQ_-DKEKi@nanopsycho>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|PUZPR03MB7014:EE_
x-ms-office365-filtering-correlation-id: cb6cfacd-18c5-4ec8-fc60-08dc3903162d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eaysJc+BeoUlBL4kERI9HQAYoLWyn6TPzP7Wjoa+Ns2bGEHPbcRpCVxLNimE7kkajcOZMmSGH+lNzcASXvoivmESwTlIy9qh/lQOAFKdXMgIYQiyg0+6xWpppConWPqGhVxJ2krSvElxwigcxUJFtPsH5XcEKTIgji3VstWTYy3Myl1qE7UUBScJtxLRT/nHPw20lhzTOsnnNZNL83W4EN6Zg4G8ylGOavcS4y7198iMi236LhHYRgEBjMJzTLc+aFpI5+o+UD9wDSb2vfyE2Hto19w/UIq0OBljNvxL6dNXvi54ESldlJ92LuVacqD68Bsdn/C/qQB6/XLzkAoPPCODsRZZBhPnw3EG13YHVCn3wOK8k9hct8qbq0m9aVBvb1zCIMUacsVyU5PI5dWC5MW65pbaWD0dWtZNKTUHqfuJHLJwQAPxdqJ82BTn0jgxeP1TLMl6JlpYu1f19Rad/R4CkIvWx6cZO8YkpGBdmecxSI11AH09ONPYjwawr55cHT8WOhvNHaBzMt6+tE9BFjoqWpUlPEnAJbaVx5+k5jaie2tN2KFkvi8H0ZBY5OEcteC+nccpOS+f8rX0Kt4aS+80JkUyGYFluXsTlRyzu5iSb3tyv2/iHUkkeY5xb4CytG0Y44xtlk2tsealVrX14bRI096asUPR+Ia2AmpdNZU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFJBUU96bkdOUmRrQ01OS3pxbWg5K1EzUjRvRWZLZk03dVd1T0NRTlJ6SzI5?=
 =?utf-8?B?ZUdSeDVFSmxxUi8rRWNuOHdkUCtRcW1rL2E0ZW9sMFdWRTR6U0NiZk9MZGRy?=
 =?utf-8?B?WnkyRTFVTE96UWZ1TVFkVkg4RnZueTFpWm80KytyZ0haVkVnY3VSYmZVekMy?=
 =?utf-8?B?L0hIRTdJYWN6emp3Y2t4dy9CTTFyQUpqM2NPMUQvNWFWanpJQ2hZQ2Vibzds?=
 =?utf-8?B?ZmFiUFdVQnpGYnJKbFVXVFcwbWJVS0JvOVVwaGs2bVpwVURNUWZTaHUxeVR0?=
 =?utf-8?B?YXNncHNRQzJ4Z0lCMDloanFxK3g4aDlZK0t3dGZBM3lVR3cwYVovWlhVUVlh?=
 =?utf-8?B?dmpZb28xU29vSlVybHcwcUN1SE5aT0tYZm5SL09aNmVJT2QvRWpTazRIRE5B?=
 =?utf-8?B?ZGNveHNyNDM1NnA2cW4vTmNnVFpDVWRhU1kzZE5kTFhISndMM2JRUmFjNmsx?=
 =?utf-8?B?V2N1SHB1dEpaVEMwdU9KOHRaZGNIMDZub3pEZjhzRFlFbTk2QnlPeGM1cHFX?=
 =?utf-8?B?VkFaMnBMekQvUzZGZVBYbnFaZ3dqMU1ZTzhpTFJycHFLZTdCV2Q1UUJrMUdI?=
 =?utf-8?B?L3MxS0pvdThlWXRGdGtydG1CUlNMRXZZYkpWU3h2ZkNpZ3NWODVaNXJXVGd2?=
 =?utf-8?B?M2VXSUNBN2ljbk00T2tFUDVQQk1JN2pFSkd5ZUU5UzBSbnpET1luc1lvYVpw?=
 =?utf-8?B?RGFuYzdQQVRQbFBuSnNjTkZ3V1ZxZG93VGdjaXBDeFJLckwrdi9paU1SWDlK?=
 =?utf-8?B?REVXVjVzeWQvYTRLdWtWSC91THN1Q3cwV0wvNzc3ZitnakdYWkdFUldnKzVC?=
 =?utf-8?B?M1M2K0JCWktyejlXN0thbmtOTk9oVHV6SFAzbXdxK3lTRU5pZ251SFJxVjRq?=
 =?utf-8?B?UDBkVVZhdlFzM25LN1k5TnRVaTM0UlQ0SFdwd1ZERDd6bVNTMFFnOG9vTlQx?=
 =?utf-8?B?WHRCcWZHU24zcHdDOURKVnpiZkEyczlUNndYV1VoV0JwdUNnZW4vWWJ2OVd6?=
 =?utf-8?B?SUVMVG9RbEN1NjdxNFBiYUxDQ0o1SGNEMmRndHRZSHBjbzg5NitKKzRkdSt1?=
 =?utf-8?B?djNEeUI4cUFDbC8xcCtPQVZwU0VzUlVZdGFFY1NlaWhIYXhxVERIUjJ3Y2c1?=
 =?utf-8?B?ay9HTmdyb1dOQm9oZ0xhbTBGenRRSk9BcmoxdXNQbjBwbDZQUDg3QTFhaVFm?=
 =?utf-8?B?aWMzTDdkZ3VHV0tCb041R2tNa01EN1BodHd2ZHVtMzE4UUNmeXVaekEzL1hG?=
 =?utf-8?B?Vitia1k3MG90WlY1VjBmTzhUeWl0U0hYd2RVK3ozY0tRSmlSM3MyUlN0cWlT?=
 =?utf-8?B?bVh4aEk1dnJyRlFXa1RRTmNFUC84NVhNOXByaTA0d2o4b0l0emNHQk5pZCs3?=
 =?utf-8?B?VU9HMFBEdmtLdFZ4MDBtRGxHdmhqQi90YWhyRFZJVmVkWUk0ajNoNlB0RmRa?=
 =?utf-8?B?VE1MQUpUS2I0UUZXdFlmdEVwMXNXc1RMUTZBNTQ5N21XcktrYURqUzd3NGR5?=
 =?utf-8?B?VTAxNGxKdUFtNGZ4WEFFZ0FrQ09abnhLM0hIYm9mb2NEekNVa2FOTi9Jc3h3?=
 =?utf-8?B?ZmFRNFBEZVdDT3NqSWpDeDlRdTFZUGVKeHJ6bmszc2ZEN0RRN1UzTFNlTDI5?=
 =?utf-8?B?NWc3RExONk0zcnVlajkvMUZlWnpjMzZhR1EzcGtBUU5lN2xGQ1dHTTM3V3lu?=
 =?utf-8?B?S09ZajBQNHJKWTZuNDN5NDFhWWZUUjFUNWJIdEdmRFB4MnIvd1BWWEk3RE4x?=
 =?utf-8?B?Ujd0N09BNkdyRXJYT1VOamdsSnA1MGJEOTlxY3BxQUtNUDd1Q1FOa0ErOGla?=
 =?utf-8?B?OUwxdjZIUnFNR0JPaVdGbTlHNFF1a2VsaDlKanBYUGViN1RoM0NPYmh4YUVu?=
 =?utf-8?B?a2dLUlFhTGkwZzNaWFZHeGk4ejUyNEx3QVJqNjlEL1h4QXM4aUVxOEp6WVNv?=
 =?utf-8?B?TzVvdWRCU2M2QlIwSFBhZ0x3OElRR3JaSnRwRUtGVUZycnp1eEZBNE1PN0h4?=
 =?utf-8?B?Q2lXeXp4akNZbjVrY21qWEZiUjdKR3VYZFg4djVLeko3TjFXcHNrVzl1d3FC?=
 =?utf-8?B?ZkJNTjhRRDhteENSYlVGTHZqU3cwWk8yQ2YxajVjY09mSHA5aVhtdDZPZDNm?=
 =?utf-8?B?WVR5cjlITXFFVVpwYWNWSDBMSVk0d21mR0w5bC90YWFkOG0zUC9pMW5TMGlJ?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09816B3D86A64C4392CBDC0CA80BF593@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6cfacd-18c5-4ec8-fc60-08dc3903162d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 08:47:39.9025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXofx1gfBRgQ9I06H2xbZiSVA6Wl0VXKBYEXf6CHLDKOgxM5no4tMo6Z9IaptF0pk4eeK0i7EEAhmQxH2QdyvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7014

T24gVGh1LCAyMDI0LTAyLTI5IGF0IDA5OjM5ICswMTAwLCBKaXJpIFBpcmtvIHdyb3RlOg0KPiAg
CSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gIFRodSwgRmViIDI5LCAyMDI0IGF0IDA5OjI0OjU0QU0gQ0VULCBMZW5hLldh
bmdAbWVkaWF0ZWsuY29tIHdyb3RlOg0KPiA+T24gV2VkLCAyMDI0LTAyLTI4IGF0IDE2OjUwICsw
MTAwLCBKaXJpIFBpcmtvIHdyb3RlOg0KPiA+PiAgIA0KPiA+PiBFeHRlcm5hbCBlbWFpbCA6IFBs
ZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbA0KPiA+
PiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+PiAgV2Vk
LCBGZWIgMjgsIDIwMjQgYXQgMDQ6Mzg6NTZQTSBDRVQsIExlbmEuV2FuZ0BtZWRpYXRlay5jb20N
Cj4gd3JvdGU6DQo+ID4+ID5Gcm9tOiBTaGltaW5nIENoZW5nIDxzaGltaW5nLmNoZW5nQG1lZGlh
dGVrLmNvbT4NCj4gPj4gPg0KPiA+PiA+V2hlbiBydWxlIHBvbGljeSBpcyBjaGFuZ2VkLCBpcHY2
IHNvY2tldCBjYWNoZSBpcyBub3QgcmVmcmVzaGVkLg0KPiA+PiA+VGhlIHNvY2sncyBza2Igc3Rp
bGwgdXNlcyBhIG91dGRhdGVkIHJvdXRlIGNhY2hlIGFuZCB3YXMgc2VudCB0bw0KPiA+PiA+YSB3
cm9uZyBpbnRlcmZhY2UuDQo+ID4+ID4NCj4gPj4gPlRvIGF2b2lkIHRoaXMgZXJyb3Igd2Ugc2hv
dWxkIHVwZGF0ZSBmaWIgbm9kZSdzIHZlcnNpb24gd2hlbg0KPiA+PiA+cnVsZSBpcyBjaGFuZ2Vk
LiBUaGVuIHNrYidzIHJvdXRlIHdpbGwgYmUgcmVyb3V0ZSBjaGVja2VkIGFzDQo+ID4+ID5yb3V0
ZSBjYWNoZSB2ZXJzaW9uIGlzIGFscmVhZHkgZGlmZmVyZW50IHdpdGggZmliIG5vZGUgdmVyc2lv
bi4NCj4gPj4gPlRoZSByb3V0ZSBjYWNoZSBpcyByZWZyZXNoZWQgdG8gbWF0Y2ggdGhlIGxhdGVz
dCBydWxlLg0KPiA+PiA+DQo+ID4+ID5TaWduZWQtb2ZmLWJ5OiBTaGltaW5nIENoZW5nIDxzaGlt
aW5nLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPj4gPlNpZ25lZC1vZmYtYnk6IExlbmEgV2FuZyA8
bGVuYS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPj4gDQo+ID4+IDEpIFlvdSBhcmUgc3RpbGwgbWlz
c2luZyBGaXhlcyB0YWdzLCBJIGRvbid0IGtub3cgd2hhdCB0byBzYXkuDQo+ID5JIGFtIHNvcnJ5
IGZvciB0aGUgY29uZnVzZS4gTXkgcHJldmlvdXMgY2hhbmdlIGxvZyBvZiBmaXggdGFnIGlzIGEN
Cj4gPndyb25nIGRlc2NyaXB0aW9uIGZvciAiUEFUQ0ggbmV0IHYyIi4NCj4gPg0KPiA+Q3VycmVu
dCBwYXRjaCBkb2Vzbid0IGZpeCBwcmV2aW91cyBjb21taXQuIEl0IGlzIG1vcmUgbGlrZSBtaXNz
aW5nDQo+ID5mbHVzaCBzaW5jZSB0aGUgZmlyc3QgY29tbWl0IDEwMTM2N2MyZjhjNCBvZiBjcmVh
dGluZyBmaWI2X3J1bGVzLmMuDQo+IElzDQo+ID5pdCBPSyB0byBhZGQgdGhpcyBmaXggb3Igb21p
dCBmaXggdGFnPw0KPiANCj4gTm8sIHRoZSAiRml4ZXMiIHRhZyBuZWVkcyB0byBiZSBwcmVzZW50
LiBJbiB0aGlzIGNhc2UsIGl0IGxvb2tzIGxpa2U6DQo+IEZpeGVzOiAxMDEzNjdjMmY4YzQgKCJb
SVBWNl06IFBvbGljeSBSb3V0aW5nIFJ1bGVzIikNCj4gSXMgdGhlIGFwcHJvcHJpYXRlIG9uZS4g
SXNuJ3QgaXQ/DQo+IA0KT0ssIEkgd2lsbCB1cGRhdGUgaXQgbGF0ZXIgaW4gdjQuDQpNYW55IHRo
YW5rcy4NCg0KPiA+DQo+ID4+IDIpIFJlIHBhdGNoIHN1YmplY3Q6DQo+ID4+ICAgICJpcHY2OmZs
dXNoIGlwdjYgcm91dGUgY2FjaGUgd2hlbiBydWxlIGlzIGNoYW5nZWQiDQo+ID4+ICAgIENvdWxk
IGl0IGJlOg0KPiA+PiAgICAiaXB2NjogZmliNl9ydWxlczogZmx1c2ggcm91dGUgY2FjaGUgd2hl
biBydWxlIGlzIGNoYW5nZWQiDQo+ID4+ICAgID8gcGxlYXNlLg0KPiA+WWVzLCBJIHdpbGwgdXBk
YXRlIGxhdGVyIGluIHY0Lg0KPiA+DQo+ID4+IDMpIENvdWxkIHlvdSBwbGVhc2UgaG9ub3IgdGhl
IDI0aCBob3VycyByZXN1Ym1pc3Npb24gcnVsZToNCj4gPj4gDQo+ID4NCj4gaHR0cHM6Ly93d3cu
a2VybmVsLm9yZy9kb2MvaHRtbC92Ni42L3Byb2Nlc3MvbWFpbnRhaW5lci1uZXRkZXYuaHRtbCN0
bC1kcg0KPiA+PiANCj4gPk9LLiBJIHdpbGwgZm9sbG93IHRoZSBydWxlIGxhdGVyLg0KPiA+DQo+
ID4+IHB3LWJvdDogY3INCg==

