Return-Path: <linux-kernel+bounces-111202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FA1886914
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4001F23730
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEA11CA8F;
	Fri, 22 Mar 2024 09:19:40 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2114.outbound.protection.partner.outlook.cn [139.219.146.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF2F1B95F;
	Fri, 22 Mar 2024 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099180; cv=fail; b=E+TBjvyKw4en9rkqTULU9ZmyNFIMGrE+ZWh0hWS7ax82YhzC7D09p5vt/H/jYONr2Z637hp5iqhPYWn+Tf+xeeNKjdkIhXV7QBJccnGtvLvnpsY3YeL37nX/CT3cb+kmimdfJtCLVmu8cbFjq04WmOWHK1xseX1C96QnekFtsg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099180; c=relaxed/simple;
	bh=j93IPEKqGhjc6EFWEH3oXRRq1HQzmGMpwQOIkUekOks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Txeb2+loRyrm69vQNGvUlXLEzrrgkhwYf+IxZDKwOjRknpx/pLZcu7m5i2t+yd90n1h+JpcydFGRyU2sqeqFUftuRZXQEucH9SX2pAaKkcziqADODmY8SWBGoVnxPoUkgeDuQZBXoNSilMsJ4OG5lLR1OAeZFEK3Td4m1+1eZls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FySlpK37XNPcYoqJwQ/py1W3S71LPHlsXDK0S16yF68uEdWgpSdBmMqidr+J+RwmvogkMch/+3Zq6lWmXdy+zBQ3gyZdxWXbpuGtuKGvDhwlZyO/IKSl91L4+j5AdIPeRYnZ+h10+MNVLhYR8GqGqQWqffvk02Okn6o36M/ZsDVxNK5S++srpBzmp324OIFCCTu1eexXbgBbnZjOpam/WQiOb8OiE4e7QjWmbHzfKBscdVYy5UaYCYHUt7zO7cMpcshLwusJC7HVbBS9p0TcaNBvaXHq1vyieTZM8mlTYdfDuU5ZIhl2Ew69xfRuhawQ7e3JsIyvqpkqlggi1rOOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j93IPEKqGhjc6EFWEH3oXRRq1HQzmGMpwQOIkUekOks=;
 b=UMs0hZd3v9XqrRus78f9ccG78mDTXZXTYVIrdoRbWvmMMMPrTMmwDLiDIMD5oqBXoYbLnmhXUxBsDoNyK9EY7bNMOwxzES+2+4DufgsCpQ/Rx53x6HK2sQWOKQEinlT33m8b4Up7r8BkkehDyRsub40Y3rjqnntzUwiFD2DEnibdA40Bo7kPza9CS6AXqQCSMtxmI5LOpWx57yTYhzVMJt3CUSKPf9j70jG1VIv6rPqkuw1prb3nfOXh24wC/EHQolU0l2Qh3j2GnxRFcsYxywY9jPmn0DZED0tAt29z6AttJ0ch8B9iTycP/wu7pr5GEs1LgfUNkhJqubO9nFYIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1180.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 09:19:26 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45%5]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 09:19:26 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: JeeHeng Sia <jeeheng.sia@starfivetech.com>, "kernel@esmil.dk"
	<kernel@esmil.dk>, "conor@kernel.org" <conor@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"emil.renner.berthing@canonical.com" <emil.renner.berthing@canonical.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>
Subject: RE: [RFC v3 01/16] reset: starfive: Rename file name "jh71x0" to
 "common"
Thread-Topic: [RFC v3 01/16] reset: starfive: Rename file name "jh71x0" to
 "common"
Thread-Index: AQHaQ8lbJe/Wz9EBr0GrwvbdHBoGmbFD6vfQ
Date: Fri, 22 Mar 2024 09:19:26 +0000
Message-ID:
 <ZQ2PR01MB13077FDD80B6FF4F2D2CBBC1E631A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
 <20240110133128.286657-2-jeeheng.sia@starfivetech.com>
In-Reply-To: <20240110133128.286657-2-jeeheng.sia@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1180:EE_
x-ms-office365-filtering-correlation-id: 230de0a6-8f71-40f2-5902-08dc4a512bba
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 raH8rqejo8sUwqluhxC/bUIuTXZ3DVxHc4PkL+j1vb+3qYFLLVcEVrpcXNGKIX+oo2ZnU/GChXara2AwM3VY3GM/iHiX9NmI/gjn4EmUes6KKDhndH/IitH5EkTUQFLqOVWVqPxT4ZEmdlJYgLV1C65oJqDO18E56p1C074RLlBf7/A5cinx3/4LaOs+9kEn2aWs/J5S70R3l8XcAjwVycOIyDRK5VfqWFGLK8wEgP8a6zs5x78QCB0aeNYquRweip+jo7eTzeNSkvxekPV2JlQKZxjMb3n3gBg99XD5ptc9A1yXlMu9J5Fm3F8Jfx3T40JjtsBL7yeYfmzGManPUDlxvE0ERPbKzsxY3HfpH02RYL+JLknAs8Ed+W+1RvecjvEaQ/eJmsRZYUJCJ5FdiWL+yzPQdIag9U44Speam6CtLfcmJQMI78Sy/JW4f513xJJ7hg5Hy/dw4jl45YZPUVSEqfUEc9VWc3bDSRK2NGy1cBwFBv5nFQVeudLDxtRnPfCpROVazmLL1FRJcxJQqotvzqJYr+jaDX4T4UWqmEUGT1XNZM5U3kufwXPN6LuJHeVazJFenZoFOnaeahcJuM820MGK4RomqMAAKDFoKSHDR27ASgGIlf7J1UcJjC1vkcR6nRCCam+viFCF24D7pQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nJAvvvbDsx0SPaeCksF2/FXWM1IFQMe4+oZ4nJTCrdapdU2IxxsBmbAGFScM?=
 =?us-ascii?Q?iV4uIDYVNUjhkY93//ticF/zhHjPgpQu4ax6MX4UISiozQVhRqYFW2N5CYqq?=
 =?us-ascii?Q?NVlvNdIhp9y1ueLiwWVByV7gvXuQPHUm1sCL2nlq4hEX3sANAQjXdBSOAr33?=
 =?us-ascii?Q?BuQmQlOcpARLtmZZMOxiZQW8d17QZ2O7P4pIm5EZtwSjibM9KiVd27cmlXcz?=
 =?us-ascii?Q?Uw2MxhNcw266OS86ezRwdOijqxrukSwuldZYUU8+XS5WwtWESiFhmHMXfhnn?=
 =?us-ascii?Q?+WDRuNWWVgqWAujCPhS9JEfaXLUmF3r3tkp2hnsTDI6swS6zKHaeGbrA/8hB?=
 =?us-ascii?Q?M7+Q4uRZ/dwl6QMeF8nXujBn3EEoeB2wxD696xkLJ6SN+TVnqpDiiEgVGYYO?=
 =?us-ascii?Q?s1oZdV6En0zuXW8rH2hMMVs8wzmcD9nLyqcvuusU7yh816TLWEXU2DtgPo+I?=
 =?us-ascii?Q?SHEqbQy7jnTz7RBOMBNV4eAQGGikO03eUpMihAxNgg/hmV87uPcuyV2jk0ku?=
 =?us-ascii?Q?U7vDNcwFqMISuU4rx29Vdm2r2CIGRa/hPqfBsyd3JeEqYE9Sis/7XGU5jqas?=
 =?us-ascii?Q?ja0oF4l0QGKhcJDmqUs5UCB7eO61PdGBATFrH7rLqj1wSQHdhGhkYeQffzGK?=
 =?us-ascii?Q?L1BcCtRLAatk9P/xfxZ/by1WV8alwwRVNgY/AuzB+KIKTEvESKCsdT/nABY0?=
 =?us-ascii?Q?FHFeMdBTzYSc+f24T6jooPLpwSD//giySexnN4evP+B8qxNzCBZ8V4R/7a74?=
 =?us-ascii?Q?oSWkXMQ4i6Fy4yGx/30zJoXgaAORHAH316C3gbJ6vQepWuFasmq/KDyyzmF2?=
 =?us-ascii?Q?+SmYLaPNfR9wBx4uDWQG2sI8saAt0Lxbz2+rRS/ZZSG4OJmVriZQd+Ze0tw6?=
 =?us-ascii?Q?/7ACipkd26EMxb/Nf04fxrarXmDZhkH58nI24DD6kbV7sdKsu8DJsMDwRPuJ?=
 =?us-ascii?Q?yD++cJze7mY5Obp4R/q/f2qYEo46TC2BMtednZx8LuVavyIJ1cilXQ3wwWwO?=
 =?us-ascii?Q?QRl9v7+uS/Q4H54v4unOzTNsmkdqghYuiUl8W+h4RyPmqFve8RnCkzWL9Wn3?=
 =?us-ascii?Q?EKNtjCwyNP92c/VEET/LVO0KXPp8p3+Wn9+WXyrlo0i//9fsQB+OPMwrik7X?=
 =?us-ascii?Q?EnDoQzR/iaFZqKx5EAFDhyT2U2UqsRO4wST61geQ80bv022ArgMjFTvbd2me?=
 =?us-ascii?Q?Vepq1u24aJlAz9pQBNEJq+q+Ucal8DvPT3KNolomC4VHdSUyHGg+dyow+brU?=
 =?us-ascii?Q?IyXn9MdexyW8UMD5E+JonY3iTHyGB46eiOaHjVTPBUcLp8mr+QqA+6RjvW7B?=
 =?us-ascii?Q?iGI+vZkEu+KJxDZK24vnd6vSL9psFHukBbiwxiaJIN0naaMp2xI5iVBf3NP7?=
 =?us-ascii?Q?N/dgYrGuqPhoHej5/uPOOOrAM+X5+oPRl9hzBp45YaVayDcfX8JggHgAcc8X?=
 =?us-ascii?Q?mS0vCSxRT4ufz2JYx1r4r0s8BwL1YjWxMW6Wqx39vC/aYJQMbTUxhR6/Axso?=
 =?us-ascii?Q?KjVpRU5OLzNHNHjVU+2l/8Zo+tOHSo8zgUOLnXakjYmMEh7RzFnuw8puBVnD?=
 =?us-ascii?Q?W2GWFHG+0SvsZnSg2cb8X7KrXDCFllLIz0I2s7Fh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 230de0a6-8f71-40f2-5902-08dc4a512bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:19:26.5911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fYNj8XL1FF9g5yofkrx12y+vNTCPqR82fqJ9VAumBOEcVbeRL+y46vEuwB+SPkXL5tLZ+Jqv+PHA6iu+zZRicqDliE5uW1NVSNSEZNdYvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1180

> On 10.01.24 21:31, JeeHeng Sia wrote:
>=20
> StarFive JH8100 shares a similar clock and reset design with JH7110.
> To facilitate the reuse of the file and its functionalities, files contai=
ning the
> "jh71x0" naming convention are renamed to use the "common" wording.
>=20
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>


