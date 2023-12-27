Return-Path: <linux-kernel+bounces-11882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7781ECE2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B7F1C22351
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAE0567F;
	Wed, 27 Dec 2023 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="a8dAiMcR";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="GGR9nZwz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AFC539C;
	Wed, 27 Dec 2023 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 76e70732a48811ee9e680517dc993faa-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=UH9q4in7IdhYeW5kKGp1DPeEdxQ7bOcaqb2mrDtdq/o=;
	b=a8dAiMcRzEHCEwKaLaOnmRa42VuUdmIaRUlmpoLYbkk50sn8+LZn2GPc6FCrR+EGl5KFKxFsscdovf7vuVtytdE7uL1GJlIkmGFRnUgQnxqABtkLmugPVm6SE/WcnZR+kspc6WHPJs1WeL3+g7DRSqvBTGgviaECvZJxNA2OW1U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:5b4f1516-b7b2-44be-b390-f0ff68cc8ffa,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:df279e8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 76e70732a48811ee9e680517dc993faa-20231227
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1221925847; Wed, 27 Dec 2023 15:20:51 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 15:20:49 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 15:20:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4cX1e0Bz1sivuZ0uOTg9tACCx/Z2j7Ds4ZCpwB4I2JAn/aJdzd5eT7XOEz3Sh+o31PihtIRtweMUg2RUuuzr+iq+xzKTeuLG5HuuVGm0FnNNNXeYealWSL7FkdJMYy2Gi08iEjeUBE/O9t7fptv4opirUT9l/ft+saUr3gkRlJ5EQ9PKrYBf+1knAg7a8JVwVOP7FGyjwE0ctM7pcEBxXzbHYFcoAJM/fdeY+U5+5rShF+YLgCE3kenD5IfB/u3bnV8e/6L61sY7vjsiM0TcBbub9bDDL/VhXDmUNWLRtwKVCnyxRRplsKs0E7I1/0vTNxHFrV9Pa+g0HEUGJE0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH9q4in7IdhYeW5kKGp1DPeEdxQ7bOcaqb2mrDtdq/o=;
 b=VYTHOT35ZkNUsJTm56hpuRR3uyUSuu3mreqT3h/kppONg9ZCfd0KL0HMm0nSeXtgSbiB6y7lCSkczc4hxEAcWBxfj9x49CqujBisKNs5HluRO7Kuo8caZXG8ATz4+NYjl9SXhp/nz2Q8hA6LyiITmt1JgREj9XXuMx3FSjZPeJ9SGMWPuyrusQwXji9fGhJ9X1K/6tGnNE+iVpOCnQIN1KqJuEPjMsLGWVMbGbLOIgsJ7g6d3VZsfW3EXsAiZjx/NcBce0wDY25EbQqz5MI0pyx0iXMeU9ifY96md5fCuBQ46YmGQcBA0545kxM51buQZBvsugURod9qoN6sw6W/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH9q4in7IdhYeW5kKGp1DPeEdxQ7bOcaqb2mrDtdq/o=;
 b=GGR9nZwzdED3AOYbCS5jQkmy3pIzOZK4BOeroFz7Dhl0E0VrVQYSUF7Sme7B6aAgxAcMiGvnqTC+RdMqgYsdhAT3GSbNgYesCYFFz5e8SsW+qSKtTWDiOUV/o9rdtdMz79A9+ziq3jEURbS2P8+P824MZE6LrJm88FRaTe83biw=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB5476.apcprd03.prod.outlook.com (2603:1096:820:5f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 07:20:44 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 07:20:44 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Topic: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Index: AQHaNJLdXM09BYKw50qe8M+Tbg/FILC7T9oAgAFxZ4A=
Date: Wed, 27 Dec 2023 07:20:44 +0000
Message-ID: <7204d5a3192a37edc2d44e3ddce67a2fc50d0206.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <c179d1ab68298efd314ffbe39fc67c5bb2dc5764.camel@mediatek.com>
In-Reply-To: <c179d1ab68298efd314ffbe39fc67c5bb2dc5764.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB5476:EE_
x-ms-office365-filtering-correlation-id: d77cf939-338e-4e3e-7354-08dc06ac56f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fClmotkjPy6SAhWeqZoZ8JCmOSREuRyjOTYqx6gfV9wRRbPhUU036kNbzPqgDEBc5CwKJzx+DoOHHI97PwFX/MiF8Qug7PbDF3ZaDoymvrgjityjHtWygXK8laqRjTF/hsiHt8QTeHyUEeIAy0bK5qGN/KxyE7gO684w53q1PaMaQ5F7+7rQVMv8m88SEwGgkbJzqdDszW83aLJfX7EBsZ8V+ZEUsqOpRJ2hWOerITMwfOoB4q9TDB397FdArda3Mk3klqMNSH+h2Q+1R3u/lYcpH8J9RMB0fy9dxZiDaqAudDDt0bbvBKj2HtRbiJD4mXyMFuO9jNpiG4cez8P9iLGJEPfopNZp2WQPoBv19/6fYUlhldYcSQHGL3hZ7ypHtgQ3PhUra0bIF6Ru2i22bMVLhRGmhEIL8rne5n6ail7JWtDgzmkr1uN9hpHFvr+pl7eGHUIBDiq777IaGEJLHgqAHDGNhOfmI9/2pXWBV+a5Neqwa4+AHQKPLndAXcOhUyiEp0J4CnwcA1q2pZuD1Xv/VfheGNzDq6c8fFT+1dWO6JWirqZubG6ASFpgHwzSI6raFD7iPQwQ93rzBWRfW5Gfo/B+3/w8vmC8ABnSmekDCuHae17LLnTbUDKgwOtXc6MZrHMp+RK5b/T84WrYEsUq4uLfMnFg6TTjL2n+FE0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(54906003)(91956017)(83380400001)(36756003)(85182001)(41300700001)(86362001)(38100700002)(122000001)(5660300002)(4001150100001)(8936002)(7416002)(64756008)(66556008)(66476007)(8676002)(76116006)(316002)(4326008)(26005)(66946007)(66446008)(110136005)(2616005)(15650500001)(6512007)(6506007)(478600001)(71200400001)(2906002)(6486002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXRiRG5hNitlS3RUaXcxSmh3UzZwTnhDSVMvSWkwNWw0Q3YzSTdUQkk3RzNi?=
 =?utf-8?B?K3lTOVBXLzBub3dPQm42MGNkdjBzK1FUaE93dHJPOVl3REwzNG9EMUhxbXJ6?=
 =?utf-8?B?RWk0MERMUVQ4bkpGa1dxWHo3R1hqcVE1eEJESVB0bjQrTk9DZmRnQjdIMWJL?=
 =?utf-8?B?VjcxTW5udDNoSERZcmVqL3JaK0grSG56TVEyeks3UDFpNUNQU2JaQW1SNkVm?=
 =?utf-8?B?ZXBqRTB1cHBtbHc0VHpCVTRNbWtJOGtoRmE3eStlaG1NZDhmbWhLT0lxcEs3?=
 =?utf-8?B?NTZPU0xFSWpUYVREZWE2T1dpTW1wQk9mUmFjOEpXNnBQdTB4amZQYThQcEth?=
 =?utf-8?B?MEFFT0hsZ0s2SGk3eU9PSThnNlpPU2tmZkxBRS93OEd3dXc2Mi9CLzVHajVm?=
 =?utf-8?B?d24vQ0JkY0dCZ3dlRHJLZnJNM1lpN2FEcGFqRUxuNndhY1lHUFJKSFpSaEJs?=
 =?utf-8?B?eXBOcWNCUEowdUYxMTRPWW1SL3dXeXE0NFBldmhOYjZSKzNGbGMvWktySkhP?=
 =?utf-8?B?YUxzWm1KVk9PSDdBbEVTUjN0NWI4V0tnN0c0Z3NuUTQ2c1UrUWFTZkZQYWVO?=
 =?utf-8?B?RXdlbjFNS1lvLzdjQkQzLzJzSHhhRFhOVlNONVBJc0VzZDJnbFk0azQyVUNy?=
 =?utf-8?B?VEkrL1VsdUo3eDZMRkY0bkZtd2ovUXl6eVJuZWFRLzM2NGR0U3loNmRSYmwx?=
 =?utf-8?B?bldVc1pFdFFXZUdIaFJKeG1DbHJKOFRtV243R0hkWmRUZmdpMmdJRVhReDBD?=
 =?utf-8?B?VkFhMm5DbVZaNHRsQk1jSEJtTkNBcUdOQzI1SngxZVo1cFdDdEhxemQvR01y?=
 =?utf-8?B?NnNvT3ZYcGZ5SzFUTUFPeXlWYU04VmczZi9PZWpYQ0lQOFl2dkc3SzRKOFVX?=
 =?utf-8?B?aENCOXl1TUVBQklKYWtlNzJRdkllbm1EL2JmWXpjRGhTYTFZUkppNkwzTzhW?=
 =?utf-8?B?c2djN25keFZKdkczTHZrWVEzUkNZajg3R2FjL005N3RJRGw3dlgrUGw1dG8z?=
 =?utf-8?B?WDJFVDdHRkRKSlRhckZ6RzkxWWdKMmZVZnpnRkZPU0JFWDhlSTlhZ1ZUdjUy?=
 =?utf-8?B?blJKYVlkblFDME5URlFHMzJMc0tUU2pnSjhOeFNjblV3bnY1T1owNXJUNjhr?=
 =?utf-8?B?UURHSCt4RGhBcG51SStHM05Qa2hEVnViWkoxZzF6RzJmR2MyWVhXTUxqbks1?=
 =?utf-8?B?NTVtOFhOWSthNkNDZm9qQXl3WEhzNkU5eGZMbEMyNWV5Vi9VNnNiSkpsZGsx?=
 =?utf-8?B?M2g5WVpHcGpKemZLRzJCNmYxWkF4Wi9RZWRYajEvU3VHYk9YMHRuelErSWE4?=
 =?utf-8?B?aGV6d0VNY1NKck9tVlkvMlR2M0FjazBqYVd0OVZqeDQyZ0Q3eTkyRWVlTHpC?=
 =?utf-8?B?Sk1yZ3oxUUFWQkhIaldpRW85MldjQ0VVTCthZ0tiOG5sZWdEeEk5d09CK0x3?=
 =?utf-8?B?SUFHQnkzNklseEFhZTFUWXpnbzFpMnNJWHlKM3F4NnJLZWRkNmhVVkViZklT?=
 =?utf-8?B?TTlxVEZ2N08xdTZ5ZzNoNDY5aGpRWW1mSytaNDJiNnpDWmJmdFhLTEJyeXpB?=
 =?utf-8?B?bzRnRjV3VlYyS3Z1L0cwMEsvaWl5Y1dVSTlyVmhTSlZRN2xpTDN6dkFGcDlT?=
 =?utf-8?B?TWI5NDdvLzZCN2g1Rno4SVlVQWhLUHk4bFYrVVE3WW9GOUkxbkdiOTZZWU1F?=
 =?utf-8?B?UGVTNnVVL0lIRkgxT0lCNGxBd0NJNFE3cjRBZjJQS1pCcDI0dS9oYm9qUzd6?=
 =?utf-8?B?TGk3OUdBaUx3MFdHMWd5NkdjeHhScnUrcjcydURmK290ckZPRkladlVlb0Z1?=
 =?utf-8?B?WkdZU2FsY0VCcHJIcGNZL0dlR1ovNldrWFlPcEJuWWVES1FxMnlvT1BqcGFu?=
 =?utf-8?B?NDU1OGhBd3dwaGhqWDl6bHYwa1NrK2szSTNocTkrc3c3eGl0WWIxVnFDd2xT?=
 =?utf-8?B?N1dSaGxaaHU3YnEyRUh2N1FseDYxMFNvT2hFcUx6ZHlGbWViNTFRRUdIT2hD?=
 =?utf-8?B?aWtaOGZVbXFvUVpCS3dxaHpDUmlteXFQblY4SFJPNEJJeVVmcWthd2lnY2kr?=
 =?utf-8?B?aTN2N2t3RU83T1crY0dDMVVsYVBUQzVTNzlTU0h6dkRocnBSYTdSZWZQeDJJ?=
 =?utf-8?B?c1FtSXppcENEcy9NYWN4azJnRVM2K2VudzFIUmIrbEhkZnl0MVpDdHF0RnZp?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DDA4404257EA844A122E3E7224453B3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77cf939-338e-4e3e-7354-08dc06ac56f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 07:20:44.2833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9xHHhZJK/uwmjwWOrlBchlh4ZIClAF05IP1cPARN+/mx0FDxoA4K8UAGE/0CtZTZIYAS51rHl5RN/pfh1PimD9exiqiuTRAAlPxt50ZGZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5476
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--25.950100-8.000000
X-TMASE-MatchedRID: QW5G6BKkLTqnykMun0J1wmjZ8q/Oc1nAjLOy13Cgb4/mNRhvDVinvypf
	0VJZhlxP3gb7k6xpVN4a/3L93pcprQTsy5Ctk/ajdAg4yd14qAQxmbT6wQT2a/t592eq2xoTHye
	T8VIiNb6ykaH8ZceX1d3XkI3b3UUxiyDtdW6F5dAMH4SsGvRsA6cX+euO9ejcAoI6+29MrRl/7A
	y3ZInh8uDs+ZfICHyR3zxdDU86ay5hH/7f6e0Hs+EbUg4xvs+wwJjn8yqLU6LEYvhZV5VohTG1K
	s84Hh014vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0UbslCGssfkpInQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--25.950100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	6DE9206212EC6A78EFD41E36E32FF562E3EF964110DD35EAC1C1746275DEBF8C2000:8

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFR1ZSwgMjAyMy0xMi0yNiBh
dCAwOToxOCArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIEZyaSwgMjAyMy0xMi0yMiBhdCAxMjo1MiArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IFRvIHN1cHBvcnQgc2VjdXJlIHZpZGVvIHBhdGggZmVhdHVyZSwgR0NFIGhhdmUgdG8g
cmVhZC93cml0ZQ0KPiA+IHJlZ2lzdGdlcnMNCj4gPiBpbiB0aGUgc2VjdXJlIHdvcmxkLiBHQ0Ug
d2lsbCBlbmFibGUgdGhlIHNlY3VyZSBhY2Nlc3MgcGVybWlzc2lvbg0KPiA+IHRvDQo+ID4gdGhl
DQo+ID4gSFcgd2hvIHdhbnRzIHRvIGFjY2VzcyB0aGUgc2VjdXJlIGNvbnRlbnQgYnVmZmVyLg0K
PiA+IA0KPiA+IEFkZCBDTURRIHNlY3VyZSBtYWlsYm94IGRyaXZlciB0byBtYWtlIENNRFEgY2xp
ZW50IHVzZXIgaXMgYWJsZSB0bw0KPiA+IHNlbmRpbmcgdGhlaXIgSFcgc2V0dGluZ3MgdG8gdGhl
IHNlY3VyZSB3b3JsZC4gU28gdGhhdCBHQ0UgY2FuDQo+ID4gZXhlY3V0ZQ0KPiA+IGFsbCBpbnN0
cnVjdGlvbnMgdG8gY29uZmlndXJlIEhXIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0K
PiA+IC0tLQ0KPiANCj4gW3NuaXBdDQo+IA0KPiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIHN0cnVj
dCBpd2NfY21kcV9jb21tYW5kX3QgLSBzdHJ1Y3R1cmUgZm9yIGV4Y3V0aW5nIGNtZHEgdGFzayBp
bg0KPiA+IHNlY3VyZSB3b3JsZC4NCj4gPiArICogQHRocmVhZDogR0NFIHNlY3VyZSB0aHJlYWQg
aW5kZXggdG8gZXhlY3V0ZSBjb21tYW5kLg0KPiA+ICsgKiBAc2NlbmFyaW86IHNjZW5hcmlvIHRv
IGV4ZWN1dGUgY29tbWFuZC4NCj4gPiArICogQHByaW9yaXR5OiBwcmlvcml0eSBvZiBHQ0Ugc2Vj
dXJlIHRocmVhZC4NCj4gPiArICogQGNtZF9zaXplOiBjb21tYW5kIHNpemUgdXNlZCBpbiBjb21t
YW5kIGJ1ZmZlci4NCj4gPiArICogQGVuZ19mbGFnOiBIVyBlbmdpbmUgZmxhZyBuZWVkIHRvIGVu
YWJsZSBwcm90ZWN0aW9uDQo+ID4gY29uZmlndXJhdGlvbi4NCj4gPiArICogQHZhX2Jhc2U6IGNv
bW1hbmQgYnVmZmVyDQo+ID4gKyAqIEB3YWl0X2Nvb2tpZTogaW5kZXggaW4gdGhyZWFkJ3MgdGFz
ayBsaXN0LCBpdCBzaG91bGQgYmUNCj4gPiAobmV4dENvb2tpZSAtIDEpLg0KPiA+ICsgKiBAcmVz
ZXRfZXhlYzogcmVzZXQgSFcgdGhyZWFkLg0KPiA+ICsgKiBAY2FsbGVyX3BpZDogcGlkIG9mIGNs
aWVudCBtb2R1bGUuDQo+ID4gKyAqIEBjYWxsZXJfbmFtZTogbmFtZSBvZiBjbGllbnQgbW9kdWxl
Lg0KPiA+ICsgKiBAbWV0YWRhdGE6IG1ldGFkYXRhIHN0cnVjdHVyZSBmb3IgY29udmVydGluZyBh
IGxpc3Qgb2Ygc2VjdXJlDQo+ID4gYnVmZmVyIGFkZHJlc3MuDQo+ID4gKyAqIEBleHRlbnNpb246
IGV4dGVuc2lvbiBIVyBlbmdpbmUgZmxhZyB0byBiZSBwcm90Y3RlZCBpbiBzZWN1cmUNCj4gPiB3
b3JsZC4NCj4gPiArICogQHJlYWRiYWNrX3BhOiByZWFkYmFjayBidWZmZXIgcGEuDQo+ID4gKyAq
IEBub3JtYWxfdGFza19oYW5kbGU6IGhhbmRsZSB0byByZWZlcmVuY2UgdGFzayBpbiBub3JtYWwg
d29ybGQuDQo+ID4gKyAqIEBtZHBfZXh0ZW5zaW9uOiBleHRlbnNpb24gTURQIEhXIGVuZ2luZSBm
bGFnIHRvIGJlIHByb3RjdGVkIGluDQo+ID4gc2VjdXJlIHdvcmxkLg0KPiA+ICsgKiBAcmVhZGJh
Y2tfZW5nczogYXJyYXkgb2YgcmVhZGJhY2sgZW5naW5lcyBwYXJhbWV0ZXJzLg0KPiA+ICsgKiBA
cmVhZGJhY2tfY250OiBjb3VudCBvZiByZWFkYmFja19lbmdzIGFycmF5Lg0KPiA+ICsgKi8NCj4g
PiArc3RydWN0IGl3Y19jbWRxX2NvbW1hbmRfdCB7DQo+ID4gKwkvKiBiYXNpYyBleGVjdXRpb24g
ZGF0YSAqLw0KPiA+ICsJdTMyIHRocmVhZDsNCj4gPiArCXUzMiBzY2VuYXJpbzsNCj4gPiArCXUz
MiBwcmlvcml0eTsNCj4gPiArCXUzMiBjbWRfc2l6ZTsNCj4gPiArCXU2NCBlbmdfZmxhZzsNCj4g
PiArCXUzMiB2YV9iYXNlW0NNRFFfSVdDX01BWF9DTURfTEVOR1RIXTsNCj4gPiArDQo+ID4gKwkv
KiBleGVjIG9yZGVyIGRhdGEgKi8NCj4gPiArCXUzMiB3YWl0X2Nvb2tpZTsNCj4gPiArCWJvb2wg
cmVzZXRfZXhlYzsNCj4gPiArDQo+ID4gKwkvKiBjbGllbnQgaW5mbyAqLw0KPiA+ICsJczMyIGNh
bGxlcl9waWQ7DQo+IA0KPiBVc2VsZXNzLCBkcm9wIGl0Lg0KPiANCj4gPiArCWNoYXIgY2FsbGVy
X25hbWVbQ01EUV9JV0NfQ0xJRU5UX05BTUVdOw0KPiANCj4gRGl0dG8uDQo+IA0KPiA+ICsNCj4g
PiArCS8qIG1ldGFkYXRhICovDQo+ID4gKwlzdHJ1Y3QgaXdjX2NtZHFfbWV0YWRhdGFfdCBtZXRh
ZGF0YTsNCj4gPiArDQo+ID4gKwkvKiBjbGllbnQgZXh0ZW5zaW9uIGJpdHMgKi8NCj4gPiArCXU2
NCBleHRlbnNpb247DQo+IA0KPiBEaXR0by4NCj4gDQo+ID4gKwl1NjQgcmVhZGJhY2tfcGE7DQo+
IA0KPiBEaXR0by4NCj4gDQo+ID4gKw0KPiA+ICsJLyogZGVidWcgKi8NCj4gPiArCXU2NCBub3Jt
YWxfdGFza19oYW5kbGU7DQo+ID4gKw0KPiA+ICsJLyogU1ZQIEhEUiAqLw0KPiA+ICsJdTMyIG1k
cF9leHRlbnNpb247DQo+IA0KPiBEaXR0by4NCj4gDQo+ID4gKwlzdHJ1Y3QgcmVhZGJhY2tfZW5n
aW5lIHJlYWRiYWNrX2VuZ3NbQ01EUV9NQVhfUkVBREJBQ0tfRU5HXTsNCj4gDQo+IERpdHRvLg0K
PiANCj4gPiArCXUzMiByZWFkYmFja19jbnQ7DQo+IA0KPiBEaXR0by4NCj4gDQo+IFJlZ2FyZHMs
DQo+IENLDQo+IA0KDQpPSywgSSdsbCBkcm9wIHRoZW0uDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5M
aW4NCg0KPiA+ICt9Ow0KPiA+ICsNCg==

