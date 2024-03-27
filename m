Return-Path: <linux-kernel+bounces-120439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3A888D770
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DE41F28FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7F42C1BA;
	Wed, 27 Mar 2024 07:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="XmNC9e6w"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2072.outbound.protection.outlook.com [40.107.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC604C9D;
	Wed, 27 Mar 2024 07:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525201; cv=fail; b=BhvFTWBBMrQvaFCtpEBNKEkokzTvur48oleBTaFLoutmv8oaae5WDPsYKzjIianFbZ2oNt0EYRxu73Ms00trUvcOIdr+73jH4mEEdDBZxSAbiDmgRZ2HeWZA4Gys4wEUJL2OrDhNQaUdgCgA9PsH82DYl10j6QxSxgO5SmqmQfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525201; c=relaxed/simple;
	bh=fQPNb4zVYwu81R5/f7ZEun8yM4VS++gQDR/lEwpO/s4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BLHAMDPY6TFPwD2Migq2P672jjSg4iWYVx3KwssizDJ8gp1J5ZWNfhHEgnBzeDfTbN77prJIrEXzLI6sYNOeF2mCSoqnriSIllW9jSCfKb7viOUxQrbnz3SZC1aE39+8OzG/EdBnyQwZNYgxkyB/pP6zESCfGzOVJRti6YgRPoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=XmNC9e6w; arc=fail smtp.client-ip=40.107.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQMNxsmse0z8GUOL/su+aT1u1v8mHUTa5DT21w0W8eD53o4rySp5KTLrFNVD8qRo0A+3lAjJoiM6Dr1rkhDDhR3hMJsXkVqFr/WEBb96a6yFYQ72IZVYMvdJEEeidvkc/T+GA/E7Wy4nd2/yLAFbI3vhTJRGsvli3IsjzLYJNyFo+0p0lri4xBFnDUK7dBPjpsbuvwd4MzXrWa1Xpj/Y1/4jMyaAVb3Apls9ix7YV63z10gO2jSrAZ1Dt7GS228Y6y1cIAiErBYfIG221lKiJ+a9Y1TwMQ3uI6qzwiiN1Odm+50KtgAJ7nEErJtH0wpC/2JWKW4ScJyL5D7gA2Zrww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQPNb4zVYwu81R5/f7ZEun8yM4VS++gQDR/lEwpO/s4=;
 b=d7xvJ2FdnAs+pvaD9+5f9ShRSTNyIvj6M5A+PP3HhxZlkS5glM8G8dARFBnnsENKk+pbSWpPLt8DbtMloclJApZ/Iu8QQt9nJKPExf42JALLp748Gz5SZxTMfKkRRjVTenqClTOUh41/6okEFTXKjUq3n9794QFf/4ArLYYApJRziW3oOfvb+o1qQe5rOurJedYPEeLqa5t4UWSLWs/vMd4tNo4lfXG4MtUzHeUNqm58NdNupXcBBNEjA0gF9cyS1/E6zpU3t8JX1bwORj2Z/vNd+S8lvXSzjRWhFWi/BXN/bpK9V039vwS8JGqLdS2564Qti4amh9RBQ2eiyBCXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQPNb4zVYwu81R5/f7ZEun8yM4VS++gQDR/lEwpO/s4=;
 b=XmNC9e6wchX9HfL5H+WiRV4E0AN988VzAHkaODakscg6JkY5VFX4phKp4BPHWTfoZJ5mC7as/UTDtiEtT4EC5ol9yf7UEVLC7iLu0IJcSfs4L2E9xjIn84Xewo5f+C4ymyiSoaHJIekYg561sBPqvUTkOy8PeGYnvPcOni77KajCOVQ2Ou141ORJgL9xxbq9F9ypUmb7yzYQ5JSgQNhK3GVGgNfw9Mqp5/5Dg+2zL+nRvREoCLvZhdg2C1ZUaRTqF/UbeufW4rC4CT9NoMoxgGL8MSb5JhEjuMIQSZhohvPGZh7IWv6UFlBvXEaijbS2BtdPu5g42VAWexVHniyhHA==
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14) by TYCPR01MB10680.jpnprd01.prod.outlook.com
 (2603:1096:400:294::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 07:39:56 +0000
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b]) by TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b%4]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 07:39:55 +0000
From: Norihiko Hama <norihiko.hama@alpsalpine.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"usb-storage@lists.one-eyed-alien.net"
	<usb-storage@lists.one-eyed-alien.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb-storage: Optimize scan delay more precisely
Thread-Topic: [PATCH] usb-storage: Optimize scan delay more precisely
Thread-Index: AQHagAnskZ+PrXZ1a0CyN6BGkMIiXrFLFjOAgAAcfLA=
Date: Wed, 27 Mar 2024 07:39:55 +0000
Message-ID:
 <TYVPR01MB107814D7A583CB986884AD4B290342@TYVPR01MB10781.jpnprd01.prod.outlook.com>
References: <20240327055130.43206-1-Norihiko.Hama@alpsalpine.com>
 <2024032757-surcharge-grime-d3dd@gregkh>
In-Reply-To: <2024032757-surcharge-grime-d3dd@gregkh>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alpsalpine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB10781:EE_|TYCPR01MB10680:EE_
x-ms-office365-filtering-correlation-id: 217abb7f-9ae3-4fba-19c9-08dc4e3118a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TYVr/8sPdWsDtvX1cQEdZVx642wG3LitYbQb132T1DdUvN4EFETLVFFQX8YeNZF1QGwN76dyfAdrUcHDJDl7IslgQv7jQ+ag5PRNLX/gMOEAxC8EH/Vrw8Cgxb4QG5CimMO00ARaH2fjIfKJHWHkwaN8F6RunUwBKBTHVdb6i8PAD4LyFhwYHiNT6oTZ8BEKubdFgzjTj9r1xsKQKuktT89Ib4NIlXkCy+liRQBenEAmnXGgISDZAFQFrjcj4rJDQvmGmhr7SPXkYNLbd3MoNRXpSNQMX8IK0OA1k8akqVhUmz8KRRueeZY28gilbYNUuZdP7KPuVVZugqZEhmOwjqhZqZMUMHEZ46iVmHrlLBecyK0PBY5l8+nqdIEkh1J8PQSpmvl/bbcZTnEhJlEaEGL3eCElhVv63LweZiLXxRJ8WVk2g63flZxrBX/KdgRGbJqKPr33D3PbJlHgtixQ6wu0e3O4JBxw7YGFApFSt7EsLfFd2svwTYBXi43DAnrLDOxa4Y85JdtMKAQzra3F6jRH3pvbHB/ZSr0G64cfYHoT6Fb8sMTeroFK6nV3ofeMbn/NfKJZXOtLtq4oM4B3T3DEFv+b6jj87wGEVAvwIO+ttesbfPE8uwUJoVKUTzJz2uXdSC4mK7Af73rumTaIfxTccxguqUpRGo+CPOLT65eC8hY9Y7CwinF6v1YD+XZ/N/JoIaEvvCxRVmJk9Y8eAV4WXoLY4fP1nwLtLK/09o8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB10781.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?TDlReVZMZ1VxLzVHUHYrLVJCN0xJNjBUa3VvalQ4aW5TcDB2NEhIVkdPSERE?=
 =?utf-7?B?Q3gzbXBwcWxuRVVHU3hoMnVaKy1sZGlwaXAvczVFVFJqWFpxMmNPeGI1SDE=?=
 =?utf-7?B?OCstb2FkSDhta2wwbUt6eFBIWTFqSnZNNUNvc3QvVXU0UXVUeEFzVEtYN29q?=
 =?utf-7?B?Y055bDI1Tmx5VVdheTk5bDY4Y2ZQdE4yMjFFam5QR0cvVG16YW10enMwbzRN?=
 =?utf-7?B?V3plUlJrUlMrLXlFRGJSb3V5MVo5WEp3ZG9yWjdFRkZ2YmxjblNRN05ERENj?=
 =?utf-7?B?clBXZkFsQUtXdDJTNFQ1Q0JiZGJzcHZVMkVJbUt5b3plTU9vNC8rLUZxSmtY?=
 =?utf-7?B?L25nY1VaeWpyMk14Y1RTaHBzeGVIY3RLbG91OUdaeTBERGJpVGZRUjhMZ05P?=
 =?utf-7?B?cG5YTVpsc0pVMmIwV3MySUQwdUN3ekVXN0ZzZkxYY2JYNFhMMEFxVldtRHNp?=
 =?utf-7?B?a1UzNkF6QlcwYystKy1oNVpDWkRxalZjNnY0MzlKNkpoWDY4TGNWWUxoN3c=?=
 =?utf-7?B?Ky1mVFZGNllCd25iazMzRTJidTJrS21nQkdXMUNsR1NRc3g4SjV6U2tvNWhI?=
 =?utf-7?B?TzF2NkhnMi9TOFRXR3BQNGdvQVo2OURyS3h6UjNhOG9mSHlIWGxsdzVrRUQ2?=
 =?utf-7?B?YkZpYWFiQWZqcmdYQ3VmODVYWjFwYzBKTTU2cFNIZkpZZ0RxSVdGZEdBQTh2?=
 =?utf-7?B?Rmo0VEEwZnJGTmFhSHhKZjNxMXhKQzBiTWRIWDhaWXVQaXhmQXNBWEFVTUhU?=
 =?utf-7?B?TTB6N08yR25KbzlwRVZ1bEE2bHRENTJ2UTZ3dTB6ak5hTDZPNjcxY2hDZFdO?=
 =?utf-7?B?L0QyMERrKy1UUVlGcVJnTHRwdlgxS05yMGJXcWQvZkNOM0ErLUJnWjk5dG9n?=
 =?utf-7?B?b3NpWmhpNmVtMS9XKy1XKy1ldFp6SzBhV2NoNVZoNktaQVVaVndPeG1ya25V?=
 =?utf-7?B?aWt5cGZYT2JDNlczUzZEY2FDKy1HMWpUWmhhaGdudmFCcmM4dXF2Vnh1OFA1?=
 =?utf-7?B?NkFUYUo2azZDMVd5Y0U2Rzc0QXhNcGx2NHNreWRDM0x1cnpXRFJJUUtHa2Jm?=
 =?utf-7?B?cFg0aVpIU1ZoeXdoL1FmazhQcG1Lc2dZYjJkNUFTR1lSTzRxTjQxVncvSjZ2?=
 =?utf-7?B?RnpvM1BMMnpVQWJRZFhuVy8rLVJ0VDRBWm9WTXZBSlQwand6empZSE1ZQXdX?=
 =?utf-7?B?WnBxVXJDUjZweFBYZXozU3dnQ0UyenY5Z0NSOUxZblN3TTYvKy1WSHlCcldy?=
 =?utf-7?B?SVFtZWkzWGxldXZHem10UDVsRjh1Ky1PYnRGZkRXRjA2TGxTZHcwL29UNWM0?=
 =?utf-7?B?eGdqSVRYZ01BTllUN0RwSTE5Vk9rNHJtZzR3U3NoRnR4WmZ4Ky1hZFA1Smo=?=
 =?utf-7?B?ZCstQkJrbUVON1MyNVowRlpNRmZOVHA2aFRoVkk2dTgzeHQ5V3RNS3hwMi9r?=
 =?utf-7?B?akQ0YWVtNWRISENYOE9HSXNRRzF4MFhSV29jUW5vcmZ4NHlQMGRMT1ArLVlP?=
 =?utf-7?B?Q2M3MU85U2IzUDN2VDZKUS9UMlBRMXhpMkExVFd6c1pzS3BLOGkxTGpuQWpk?=
 =?utf-7?B?WGQwaWMzMHZnb290Y0dnbSstRm9sdGRST0lQdHFKSmI3blFlVWNKL29YZW93?=
 =?utf-7?B?Q3JZcTYzN3dNRTZrRWx4WFl5akZ0RUJoZTZaMVhhZFNjUkRkS3N1RzJNT01E?=
 =?utf-7?B?NXY3YmFNTVFUbistU2FoVkRxR0FWZGRuQ2tpYUsrLU9pYkM2Y0tTTlByazRY?=
 =?utf-7?B?anNTdmZsd1VEbGJOeU5NaEllWGl6ZystdkppQnNUMjRZdFdKYnFacXV0SXM0?=
 =?utf-7?B?SVRCaHVMSlNUSnFhVEtNbG1aL1JseTZrSDZLc0NzbTRUTm16cEw4Mzh6S0c0?=
 =?utf-7?B?blpuNzB6YjRMUEt6N2tBQUthVS9XTVNFemVIYTRXaWkyVGZRS05aM0crLUJm?=
 =?utf-7?B?Y3ZRWlQ1YmNzR2pNdUhWZUV6RldkSGo5dTNzVEF5MEFrVk9qOGxibkVqY0hz?=
 =?utf-7?B?cFZXb1JmUWRBclNqWEJWN2FwR0MxMlpMSlFPS2prWDBqamhmMEJTMGNidGE0?=
 =?utf-7?B?bG15R2xPNFlzZFI0YkZtOGdkdzZZUkJ3SWtCZjJZQjJ1WWtlb2hTaGw5Wmpr?=
 =?utf-7?B?M3llalJrSy9tVm1WUEhpaU1PaXc0dElvRTZYSXpUbUVtQjFLM05nNUpxSnRW?=
 =?utf-7?B?akZyeHNZQw==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: alpsalpine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB10781.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217abb7f-9ae3-4fba-19c9-08dc4e3118a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 07:39:55.3385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VVprI97L1L+du4U+yaLkYzbeEAHVyhs2OCHI7+o/AtQqa+fk3Te+bgyEv+MezasUn2dmIaTnemnLTSnza8naxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10680

+AD4- Sorry, but module parameters are from the 1990's, we will not go back=
 to that if at all possible as it's not easy to maintain and will not work =
properly for multiple devices.
+AD4-
+AD4- I can understand wanting something between 1 and 0 seconds, but addin=
g yet-another-option isn't probably the best way, sorry.
1 second does not meet with performance requirement.
I have no good idea except module parameter so that we can maintain backwar=
d compatibility but be configurable out of module.
Do you have any other better solution?

Best regards,
Norihiko Hama

