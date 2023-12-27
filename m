Return-Path: <linux-kernel+bounces-11807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAAB81EBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1532C1C20C16
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2983C24;
	Wed, 27 Dec 2023 03:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IN1Czjql";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="khlIjDNz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6F290B;
	Wed, 27 Dec 2023 03:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: befc9fd8a46911eea2298b7352fd921d-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=h6GkiCg/El3SKerJ/WbtoRWPHyy/D4kTNOPxouuwOc0=;
	b=IN1CzjqlHZoVm39BgI2I5AZfV4GzRFJYvoIHPVyMOz3pJ7/76KcP4VHBvX87v9HVq/ZFDQGnkNadm174MBdwBwZXzfpeHcmjYg8i93xEwre/Y3uk7zcFFjm2gEpxoUfaXWKoSO20N8lDJzJEIZYXbXX2VO8i0z4X3KRlQ5lGeYY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:4a258585-adbe-4108-9172-13bc5588fe8c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:c310b57e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: befc9fd8a46911eea2298b7352fd921d-20231227
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2126978380; Wed, 27 Dec 2023 11:40:57 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 11:40:56 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 11:40:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gN91rcpJk//Bx7hqyHQLSJOoQsmNCSuoeXW+6+tlqUMfROkfQy7ssmGubhucaqJilNEC37Su9hczH49Sx+jmEPoKWnXWNYb7Jnpvdm8G3c+/gYAKmJi98rMZzEC0HPNDpImHm44YFdMSN6OtyJfLYuzV13Zm2A18LQMBXt7pzRHXrvzrr1jDLzvIiNGuCW9uzy9jzVRH85VWOyH72hq2/MNS8WN11QniPkiZcBxPJ1H00j0azA2TcvjquCpiT3NV6dT+EoH835Hga2uCQV4vVNhJAnIqzHrwT2vG0YqB6BtQhnOv/cEgXuEaO6J9mEdhVCvZTFi4J1RGaZ6YNNpY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6GkiCg/El3SKerJ/WbtoRWPHyy/D4kTNOPxouuwOc0=;
 b=SPpPB8WAogTRATPuh80VASxnfzAmiuMYbakUCBhmVwE8iJBXVTzXITvfJCbeFhlOEnqh38ontsUUJv/JRP2bFGdJIgYcT65Hl8n/xZYJo2okRN6z3jVYET2CdF7M8Hrj+c9/gEGKQtk4wbShukBrFo2ck4gXmwpbiQyihp2yfyRJ6f+gyZFhScSdiENNAoOqWhaq/AzjXizvT9BSiV24nq+Ipk/MvPQNinpYcefqF52pKB5YDMVkEiGVJPkY2oGpb1aALPt1TKktCFidpQwYPw/ueGtninl0W2ccjjV4L7T0h74EzlV/CpN2PLOqZD9Mpy30qrQnjBt55kuIhx0rWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6GkiCg/El3SKerJ/WbtoRWPHyy/D4kTNOPxouuwOc0=;
 b=khlIjDNzAB43L3b5n1TXkYDVekA4Z5TLzA98riypfyWiO6Q9dqV/6Mm29KAWfsU0mxKL5LkVf13S+zl89FnBV6TvqlF8tAmADaDVsdeymm9KNUiECcnddvtXaN6FFKHzx3LbucGsu0ZjFxDMJOAQEkYLRPkf2TBaf2QuY6fCeFE=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEZPR03MB8633.apcprd03.prod.outlook.com (2603:1096:101:22f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 03:40:51 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 03:40:51 +0000
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
Thread-Index: AQHaNJLdXM09BYKw50qe8M+Tbg/FILC7HKUAgAFnLQA=
Date: Wed, 27 Dec 2023 03:40:51 +0000
Message-ID: <a1c4f29bc8d8b12f962fd791cacf22ff489c6fc6.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <8234222df9443008db31158bfb7f203da9d5b4f0.camel@mediatek.com>
In-Reply-To: <8234222df9443008db31158bfb7f203da9d5b4f0.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEZPR03MB8633:EE_
x-ms-office365-filtering-correlation-id: 7f4e0755-d129-4d83-9cde-08dc068d9f5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lIE8nHQBtYqkdIEZ4hIZNRe+67bJsXd+T0HFa+VOYfPhILJXapBz+haPzFNduD10djc3KwebXDr32LKo1aqQiw6c4n2kN+r0olj8/qKY7uWCus6h4YJEXboPsMom8YEco5Dgc2Mo1Jnui82MpROgRdnS1NBainboMBqyXK795M1hEN4CyelPE+Hh6xWmCgoyBpJt2/2IZlYSleS0hYTjsuD3z8bp6YMFQZAJ27DbxM+6UlqHfMDXzI2D1nrVNBxnDfyMAAp1n3uTNYF/s8MwRvadBFQ5NlLnGfjGgXiaif4yBkV7LIRPnJwdBYi11KQs3NSfyoUPRDUH6JC95sl4GwzmHhJl46Wa21QC5V2WIZCxCGcvvr+TDUcH9dxWbcMPWKMGTUwcWfBF1v6B+ebsrGP3SFNDflkAUsDhnuwyqCOKdgweVydKTpVeetwI+tt1lqO+Ak3RwDbweqLm/LfbnCGVe2xMrNN741Iv6wpxBej/jYQQxaIS4+2n1Oy5aiDKqHklfh9eJwcNjhq6q8Xw1DVcAgozDqqt0IWG7xPBoka8LFq1aaj+3DqP+h/ujNymMKTz9sKCIQf9kEdc/U7LWYEQ0ayGXLEc4JWoxMbtg0EqY3WoVMFVOVMbbKA6pAsmDwVBeSAGOkj0Us7YU5HMbhHl6gBU0lwKJrzxCqZhVv4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(41300700001)(2616005)(38100700002)(26005)(122000001)(110136005)(54906003)(316002)(4326008)(8936002)(8676002)(7416002)(15650500001)(2906002)(4001150100001)(5660300002)(478600001)(6512007)(71200400001)(6506007)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6486002)(38070700009)(86362001)(36756003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjRKY0g0bVpyVWptOWdoZVJQbG1lL1VlSnFDc2h2TkVNRmFJeXZOdG41NUxZ?=
 =?utf-8?B?azJaMk5md051QlN1NVR3bGREUlFMVHdPYWh2aWYvcndPOGIvU214R1RZNGJL?=
 =?utf-8?B?T0RUaWtnUVBNVElOZDdLWHdNeG15enplMmpmanpMQVJtYmQvSUx4TUEzV2tM?=
 =?utf-8?B?NnpjRHp4VmVsckFFL3pqNTNXcGVMaXJKcmlMNDZxMEhVb3E2dml2QVJyZFBk?=
 =?utf-8?B?QUpWNWdqQjJLT3BnNTk1NytpdUFydDdxeWRqbmJGeUY5ak03UGQxVHh4amRw?=
 =?utf-8?B?R1AvTGpRNUVTUEQwenVjTzNtVWNPZkZCNm95dHRweENUdDZkRE9MWWYvQTQ5?=
 =?utf-8?B?K2xqc2c1ZkdqUzlKamd1Q2RQVUErcEJJMmYyVnI0dzdHaWk1djVNQzhqOUVB?=
 =?utf-8?B?Q01XcmFRdk1lcHFidEpSRmhRTm1sYStvUDNEamgvejdDOFR4R2lwdEE1bDJs?=
 =?utf-8?B?V1lUaThsTzYyNWZscDd5RFpsbUR5b0g5THl3OWJDQ1BLZlM0L0tFRUxMUnBi?=
 =?utf-8?B?a0JPWkNRcUZkdjU1ZGZxSW9ESG1oTW40Mk5XNEJCSDQxK2F5T3V6bWh5OU5a?=
 =?utf-8?B?VWt3WDVGeHJZa1dVSEtXSG1oSUZIOVU5TThmRnVFcEh6RnBid2tySTk0TVFu?=
 =?utf-8?B?R3NxUmlOQ09XSHhTUlNEZ3VwREFiTzQ4a1lFSGdqTDl6WG5KaW9idlZ5VG5P?=
 =?utf-8?B?SW9FdTlvK3c0UkczSm5JSVBGTWFnZUdFNUtrNXIvRkxuNHZpdDZ1dFgrL0Y4?=
 =?utf-8?B?NlR4dXFkaUlKQjM5VkJ6WW1OZEhGbjRnbmJvU2U3K3BNRDIvaXVSeS9DQytF?=
 =?utf-8?B?WUh4WGpnNXNRa1hmdEtva2dGQ3dXYW1vTGh0RVRRWXlPV3R4SVhpdWYyb2tq?=
 =?utf-8?B?WmtxdTdlRGIzUy9SeG1UbDRWV25WbThkWUdHLzBiU3Q5WHhiQzIwQms1QlAy?=
 =?utf-8?B?c1R4WmtQSlRjb2ZyVEE4ZStIYUpBZWRON1BYVkVZK2t6bzZRZk9ITFdobXJQ?=
 =?utf-8?B?czkvNDNOK0YxTWJqb2Npa1g3VkFSYmROTktGNmpuL0Y1VU5LTkZkMnZ0Q1U4?=
 =?utf-8?B?SlVPQVdteVBNcjBJMDB1Yi95dkxocTZrZ0RLRjdFaXpIK3JxdmJkeTA0YnFn?=
 =?utf-8?B?VDBQVzV1VXB4VnRhUkZ6MCtORTdUaVZ3WjJ3dUV1UnRnd1p2OXlFM2FyUmo1?=
 =?utf-8?B?VUdLc3ZMK0g0U2U1VDVOT3NsS3hSRlhUYmpHQVk3SGFwMzc3NGtiVlhicDBB?=
 =?utf-8?B?b0ltVFM4QmFTN0tpRTVzS0RyU1lWc0laZHBvejdISDh5ZE16eUZuUzh2aDJk?=
 =?utf-8?B?ck1GRTVJSTFyUGpUaUltd1dFdFpVTFMwUTkxejN4ekF2c0dXMTYvSTRROUha?=
 =?utf-8?B?cHkvL3c1REwzUlJOQXZNcXFrS2UyR0ZnSU5KOVFYb3J5Z3VWazh2VjMycHRv?=
 =?utf-8?B?bGp0QjB3LzRhYjdrMlJYOGRyNlJzOUt5WTd3Qlh2YlE4YkQ5TzFQYUswc0x2?=
 =?utf-8?B?Vm83U0YxMVl6M2U4Tm9vcCtncUVDWGUvcW9DcHpHelBBMFRCSWU2N2cwOU1D?=
 =?utf-8?B?b0FIMFJWalJxL2JkMERaZ2tyWmlkNlNUZEtROTZPVnc1bmQ0TDZuMXpQdTVu?=
 =?utf-8?B?Q3hOdnlFQThnTEUrRTIwWU5YdFArT1VvUUl3bzM2WVVuaUw2L2txTmFsREpG?=
 =?utf-8?B?TlpwOEZFQ05NQlI0RmtjT3FsN2lkVVhpeHlmeGZQWVNUeFRIT1hvdEdDS0Nx?=
 =?utf-8?B?TmF4R0VoQ3llWWliLzlWeWY4cWhFd0RRK0wvMExkajlVSDVrQy9MWkpQUmlJ?=
 =?utf-8?B?Q0dmbGNORmE2YmRmT3AyTVphLzNvS0RlVlUwbWdlcnVVQXh0d0ttNEwwQXp0?=
 =?utf-8?B?ajlXMDlFdjYrd0IwMUs2QTlvMEpFTFJvaDVYZEJ4ajdTc2NYT0ZjUUxUcTF1?=
 =?utf-8?B?SVNsUnFmU09PbEVhekxZdnlxTlhBamxkOEorQ2hPYWJGYXg4WEVDT1RjZTc1?=
 =?utf-8?B?cmVjSEU1NW44eEkvSHVwd3lneUxzTVB3UWNObW5JRjFXTHhpSXF3ejROS0NE?=
 =?utf-8?B?Q3Z3UEVTVnV6STczYlJDaWRTMm9EWjQyS0tmM2FzR0pEZ1IvV3NvcDRRR2Ur?=
 =?utf-8?B?dm1aM005ZHdjK3RZUUxTNlgrWEw2RFIwUk0yZS82T2s4V0tJRzhqamptNWd1?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72B154F148703C4EBB8F10DD3DAAD8AA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4e0755-d129-4d83-9cde-08dc068d9f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 03:40:51.3463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iPm3F/MdeIJS6jLjez73fVFcK71SK+vhrxb+zfAkc5yjZ2Kn8jsdvgJ0W7AeBMI+7DGyKWMhifxAIAXYREtVW14WBzqMZt64gz+oUJynVQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8633

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFR1ZSwgMjAyMy0xMi0yNiBh
dCAwNjoxNSArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
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
PiA+IC0tLQ0KPiANCj4gW3NuaXBdDQo+IA0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgY21kcV9z
ZWNfdGFza19leGVjX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrX2l0ZW0pDQo+ID4gK3sN
Cj4gPiArCXN0cnVjdCBjbWRxX3NlY190YXNrICpzZWNfdGFzayA9IGNvbnRhaW5lcl9vZih3b3Jr
X2l0ZW0sDQo+ID4gKwkJCQkJCSAgICAgIHN0cnVjdA0KPiA+IGNtZHFfc2VjX3Rhc2ssIGV4ZWNf
d29yayk7DQo+ID4gKwlzdHJ1Y3QgY21kcV9zZWNfdGhyZWFkICpzZWNfdGhyZWFkID0gY29udGFp
bmVyX29mKHNlY190YXNrLQ0KPiA+ID4gdGFzay50aHJlYWQsDQo+ID4gDQo+ID4gKwkJCQkJCQkg
c3RydWN0DQo+ID4gY21kcV9zZWNfdGhyZWFkLCB0aHJlYWQpOw0KPiA+ICsJc3RydWN0IGNtZHFf
c2VjICpjbWRxID0gY29udGFpbmVyX29mKHNlY190aHJlYWQtPnRocmVhZC5jaGFuLQ0KPiA+ID4g
bWJveCwNCj4gPiANCj4gPiArCQkJCQkgICAgIHN0cnVjdCBjbWRxX3NlYywgbWJveCk7DQo+ID4g
KwlzdHJ1Y3QgY21kcV9zZWNfZGF0YSAqZGF0YTsNCj4gPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7
DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiArCWRldl9kYmcoY21kcS0+bWJveC5kZXYsICIl
cyBnY2U6JSNseCBzZWNfdGFzazolcCBwa3Q6JXANCj4gPiB0aHJlYWQ6JXUiLA0KPiA+ICsJCV9f
ZnVuY19fLCAodW5zaWduZWQgbG9uZyljbWRxLT5iYXNlX3BhLA0KPiA+ICsJCXNlY190YXNrLCBz
ZWNfdGFzay0+dGFzay5wa3QsIHNlY190aHJlYWQtPmlkeCk7DQo+ID4gKw0KPiA+ICsJaWYgKCFz
ZWNfdGFzay0+dGFzay5wa3QtPnNlY19kYXRhKSB7DQo+ID4gKwkJZGV2X2VycihjbWRxLT5tYm94
LmRldiwgInBrdDolcCB3aXRob3V0IHNlY19kYXRhIiwNCj4gPiBzZWNfdGFzay0+dGFzay5wa3Qp
Ow0KPiA+ICsJCXJldHVybjsNCj4gPiArCX0NCj4gPiArCWRhdGEgPSAoc3RydWN0IGNtZHFfc2Vj
X2RhdGEgKilzZWNfdGFzay0+dGFzay5wa3QtPnNlY19kYXRhOw0KPiA+ICsNCj4gPiArCW11dGV4
X2xvY2soJmNtZHEtPmV4ZWNfbG9jayk7DQo+ID4gKw0KPiA+ICsJc3Bpbl9sb2NrX2lycXNhdmUo
JnNlY190aHJlYWQtPnRocmVhZC5jaGFuLT5sb2NrLCBmbGFncyk7DQo+ID4gKwlpZiAoIXNlY190
aHJlYWQtPnRhc2tfY250KSB7DQo+ID4gKwkJbW9kX3RpbWVyKCZzZWNfdGhyZWFkLT50aW1lb3V0
LCBqaWZmaWVzICsNCj4gPiArCQkJICBtc2Vjc190b19qaWZmaWVzKHNlY190aHJlYWQtPnRpbWVv
dXRfbXMpKTsNCj4gPiArCQlzZWNfdGhyZWFkLT53YWl0X2Nvb2tpZSA9IDE7DQo+ID4gKwkJc2Vj
X3RocmVhZC0+bmV4dF9jb29raWUgPSAxOw0KPiA+ICsJCXNlY190aHJlYWQtPnRhc2tfY250ID0g
MDsNCj4gPiArCQlfX3Jhd193cml0ZWwoMCwgKHZvaWQgX19pb21lbSAqKWNtZHEtPnNoYXJlZF9t
ZW0tPnZhICsNCj4gPiArCQkJICAgICBDTURRX1NFQ19TSEFSRURfVEhSX0NOVF9PRkZTRVQgKw0K
PiA+IHNlY190aHJlYWQtPmlkeCAqIHNpemVvZih1MzIpKTsNCj4gPiArCX0NCj4gPiArDQo+ID4g
KwlzZWNfdGFzay0+cmVzZXRfZXhlYyA9IHNlY190aHJlYWQtPnRhc2tfY250ID8gZmFsc2UgOiB0
cnVlOw0KPiA+ICsJc2VjX3Rhc2stPndhaXRfY29va2llID0gc2VjX3RocmVhZC0+bmV4dF9jb29r
aWU7DQo+ID4gKwlzZWNfdGhyZWFkLT5uZXh0X2Nvb2tpZSA9IChzZWNfdGhyZWFkLT5uZXh0X2Nv
b2tpZSArIDEpICUNCj4gPiBDTURRX01BWF9DT09LSUVfVkFMVUU7DQo+ID4gKwlsaXN0X2FkZF90
YWlsKCZzZWNfdGFzay0+dGFzay5saXN0X2VudHJ5LCAmc2VjX3RocmVhZC0NCj4gPiA+IHRocmVh
ZC50YXNrX2J1c3lfbGlzdCk7DQo+ID4gDQo+ID4gKwlzZWNfdGhyZWFkLT50YXNrX2NudCArPSAx
Ow0KPiA+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc2VjX3RocmVhZC0+dGhyZWFkLmNoYW4t
PmxvY2ssIGZsYWdzKTsNCj4gPiArCXNlY190YXNrLT50cmlnZ2VyID0gc2NoZWRfY2xvY2soKTsN
Cj4gPiArDQo+ID4gKwlpZiAoIWF0b21pY19jbXB4Y2hnKCZjbWRxX3BhdGhfcmVzLCAwLCAxKSkg
ew0KPiA+ICsJCWVyciA9IGNtZHFfc2VjX3Rhc2tfc3VibWl0KGNtZHEsIE5VTEwsDQo+ID4gQ01E
X0NNRFFfSVdDX1BBVEhfUkVTX0FMTE9DQVRFLA0KPiA+ICsJCQkJCSAgIENNRFFfSU5WQUxJRF9U
SFJFQUQsIE5VTEwpOw0KPiA+ICsJCWlmIChlcnIpIHsNCj4gPiArCQkJYXRvbWljX3NldCgmY21k
cV9wYXRoX3JlcywgMCk7DQo+ID4gKwkJCWdvdG8gdGFza19lbmQ7DQo+ID4gKwkJfQ0KPiA+ICsJ
fQ0KPiA+ICsNCj4gPiArCWlmIChzZWNfdGhyZWFkLT50YXNrX2NudCA+IENNRFFfTUFYX1RBU0tf
SU5fU0VDVVJFX1RIUkVBRCkgew0KPiA+ICsJCWRldl9lcnIoY21kcS0+bWJveC5kZXYsICJ0YXNr
X2NudDoldSBjYW5ub3QgbW9yZSB0aGFuDQo+ID4gJXUgc2VjX3Rhc2s6JXAgdGhyZWFkOiV1IiwN
Cj4gPiArCQkJc2VjX3RocmVhZC0+dGFza19jbnQsDQo+ID4gQ01EUV9NQVhfVEFTS19JTl9TRUNV
UkVfVEhSRUFELA0KPiA+ICsJCQlzZWNfdGFzaywgc2VjX3RocmVhZC0+aWR4KTsNCj4gPiArCQll
cnIgPSAtRU1TR1NJWkU7DQo+ID4gKwkJZ290byB0YXNrX2VuZDsNCj4gPiArCX0NCj4gPiArDQo+
ID4gKwllcnIgPSBjbWRxX3NlY190YXNrX3N1Ym1pdChjbWRxLCBzZWNfdGFzaywNCj4gPiBDTURf
Q01EUV9JV0NfU1VCTUlUX1RBU0ssDQo+ID4gKwkJCQkgICBzZWNfdGhyZWFkLT5pZHgsIE5VTEwp
Ow0KPiA+ICsJaWYgKGVycikNCj4gPiArCQlkZXZfZXJyKGNtZHEtPm1ib3guZGV2LCAiY21kcV9z
ZWNfdGFza19zdWJtaXQgZXJyOiVkDQo+ID4gc2VjX3Rhc2s6JXAgdGhyZWFkOiV1IiwNCj4gPiAr
CQkJZXJyLCBzZWNfdGFzaywgc2VjX3RocmVhZC0+aWR4KTsNCj4gPiArDQo+ID4gK3Rhc2tfZW5k
Og0KPiA+ICsJaWYgKGVycikgew0KPiA+ICsJCXN0cnVjdCBjbWRxX2NiX2RhdGEgY2JfZGF0YTsN
Cj4gPiArDQo+ID4gKwkJY2JfZGF0YS5zdGEgPSBlcnI7DQo+ID4gKwkJY2JfZGF0YS5wa3QgPSBz
ZWNfdGFzay0+dGFzay5wa3Q7DQo+ID4gKwkJbWJveF9jaGFuX3JlY2VpdmVkX2RhdGEoc2VjX3Ro
cmVhZC0+dGhyZWFkLmNoYW4sDQo+ID4gJmNiX2RhdGEpOw0KPiA+ICsNCj4gPiArCQlzcGluX2xv
Y2tfaXJxc2F2ZSgmc2VjX3RocmVhZC0+dGhyZWFkLmNoYW4tPmxvY2ssDQo+ID4gZmxhZ3MpOw0K
PiA+ICsJCWlmICghc2VjX3RocmVhZC0+dGFza19jbnQpDQo+ID4gKwkJCWRldl9lcnIoY21kcS0+
bWJveC5kZXYsICJ0aHJlYWQ6JXUgdGFza19jbnQ6JXUNCj4gPiBjYW5ub3QgYmVsb3cgemVybyIs
DQo+ID4gKwkJCQlzZWNfdGhyZWFkLT5pZHgsIHNlY190aHJlYWQtPnRhc2tfY250KTsNCj4gPiAr
CQllbHNlDQo+ID4gKwkJCXNlY190aHJlYWQtPnRhc2tfY250IC09IDE7DQo+ID4gKw0KPiA+ICsJ
CXNlY190aHJlYWQtPm5leHRfY29va2llID0gKHNlY190aHJlYWQtPm5leHRfY29va2llIC0gMQ0K
PiA+ICsNCj4gPiArCQkJQ01EUV9NQVhfQ09PS0lFX1ZBTFVFKSAlIENNRFFfTUFYX0NPT0tJRV9W
QUxVRTsNCj4gPiArCQlsaXN0X2RlbCgmc2VjX3Rhc2stPnRhc2subGlzdF9lbnRyeSk7DQo+ID4g
KwkJZGV2X2RiZyhjbWRxLT5tYm94LmRldiwgImdjZTolI2x4IGVycjolZCBzZWNfdGFzazolcA0K
PiA+IHBrdDolcCIsDQo+ID4gKwkJCSh1bnNpZ25lZCBsb25nKWNtZHEtPmJhc2VfcGEsIGVyciwg
c2VjX3Rhc2ssDQo+ID4gc2VjX3Rhc2stPnRhc2sucGt0KTsNCj4gPiArCQlkZXZfZGJnKGNtZHEt
Pm1ib3guZGV2LCAidGhyZWFkOiV1IHRhc2tfY250OiV1DQo+ID4gd2FpdF9jb29raWU6JXUgbmV4
dF9jb29raWU6JXUiLA0KPiA+ICsJCQlzZWNfdGhyZWFkLT5pZHgsIHNlY190aHJlYWQtPnRhc2tf
Y250LA0KPiA+ICsJCQlzZWNfdGhyZWFkLT53YWl0X2Nvb2tpZSwgc2VjX3RocmVhZC0NCj4gPiA+
IG5leHRfY29va2llKTsNCj4gPiANCj4gPiArCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZzZWNf
dGhyZWFkLT50aHJlYWQuY2hhbi0+bG9jaywNCj4gPiBmbGFncyk7DQo+ID4gKw0KPiA+ICsJCWtm
cmVlKHNlY190YXNrKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwltdXRleF91bmxvY2soJmNtZHEt
PmV4ZWNfbG9jayk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgY21kcV9zZWNfbWJv
eF9zZW5kX2RhdGEoc3RydWN0IG1ib3hfY2hhbiAqY2hhbiwgdm9pZA0KPiA+ICpkYXRhKQ0KPiA+
ICt7DQo+ID4gKwlzdHJ1Y3QgY21kcV9wa3QgKnBrdCA9IChzdHJ1Y3QgY21kcV9wa3QgKilkYXRh
Ow0KPiA+ICsJc3RydWN0IGNtZHFfc2VjX2RhdGEgKnNlY19kYXRhID0gKHN0cnVjdCBjbWRxX3Nl
Y19kYXRhICopcGt0LQ0KPiA+ID4gc2VjX2RhdGE7DQo+ID4gDQo+ID4gKwlzdHJ1Y3QgY21kcV90
aHJlYWQgKnRocmVhZCA9IChzdHJ1Y3QgY21kcV90aHJlYWQgKiljaGFuLQ0KPiA+ID4gY29uX3By
aXY7DQo+ID4gDQo+ID4gKwlzdHJ1Y3QgY21kcV9zZWNfdGhyZWFkICpzZWNfdGhyZWFkID0gY29u
dGFpbmVyX29mKHRocmVhZCwNCj4gPiBzdHJ1Y3QgY21kcV9zZWNfdGhyZWFkLCB0aHJlYWQpOw0K
PiA+ICsJc3RydWN0IGNtZHFfc2VjX3Rhc2sgKnNlY190YXNrOw0KPiA+ICsNCj4gPiArCWlmICgh
c2VjX2RhdGEpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsJc2VjX3Rhc2sg
PSBremFsbG9jKHNpemVvZigqc2VjX3Rhc2spLCBHRlBfQVRPTUlDKTsNCj4gPiArCWlmICghc2Vj
X3Rhc2spDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJc2VjX3Rhc2stPnRh
c2sucGt0ID0gcGt0Ow0KPiA+ICsJc2VjX3Rhc2stPnRhc2sudGhyZWFkID0gdGhyZWFkOw0KPiA+
ICsJc2VjX3Rhc2stPnNjZW5hcmlvID0gc2VjX2RhdGEtPnNjZW5hcmlvOw0KPiA+ICsJc2VjX3Rh
c2stPmVuZ2luZV9mbGFnID0gc2VjX2RhdGEtPmVuZ3NfbmVlZF9kYXBjIHwgc2VjX2RhdGEtDQo+
ID4gPiBlbmdzX25lZWRfc2VjX3BvcnQ7DQo+ID4gDQo+ID4gKw0KPiA+ICsJSU5JVF9XT1JLKCZz
ZWNfdGFzay0+ZXhlY193b3JrLCBjbWRxX3NlY190YXNrX2V4ZWNfd29yayk7DQo+ID4gKwlxdWV1
ZV93b3JrKHNlY190aHJlYWQtPnRhc2tfZXhlY193cSwgJnNlY190YXNrLT5leGVjX3dvcmspOw0K
PiANCj4gSXQncyBub3QgbmVjZXNzYXJ5IHRvIHF1ZXVlIGEgd29yayBoZXJlLiBTcXVhc2gNCj4g
Y21kcV9zZWNfdGFza19leGVjX3dvcmsoKSBpbnRvIHRoaXMgZnVuY3Rpb24uDQo+IA0KPiBSZWdh
cmRzLA0KPiBDSw0KPiANCk9LLCBJJ2xsIHNxdWFzaCBpdC4NCg0KUmVnYXJkcywNCkphc29uLUpI
Lkxpbg0K

