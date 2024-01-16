Return-Path: <linux-kernel+bounces-27122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3789E82EACF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDCC1F24096
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172ED11CBB;
	Tue, 16 Jan 2024 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uazsnfFt";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BQBaQ8Fg"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3D9125A3;
	Tue, 16 Jan 2024 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3a4971e6b44811eea2298b7352fd921d-20240116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qXOt30xcr11alHK7Lag/O+9dwN5ma1VYe75iYLQELQk=;
	b=uazsnfFts0AgvbIET7T5YxM+tpa3+TblQQ3qqvisaq+gWvHJNgqS7iq1B5wZbGSAiUq9nSidd0Cdq9SEe9yJjsi64ZftDoNVetFs2hF5X2uzppb927rV0b7AoDBjegXBSxLNWocm0GCyvHi447k04bMpoU+yKDHfDdg5lN7Pv8o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:e577571d-ee55-4cb5-921a-1b1d2b3f064a,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:5d391d7,CLOUDID:197ce682-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 3a4971e6b44811eea2298b7352fd921d-20240116
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 45107216; Tue, 16 Jan 2024 16:21:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 Jan 2024 16:21:19 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 Jan 2024 16:21:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqAMx2jZ3pEtDgD+/JuW9LcslndPWaxou//YsVEcNeoQc0JpV7z+ec7+IXHhKQd0M+cwwI8U9unrP7f7DkpUNlOcClJS2tyYGEK+EAKoYqIz1A2Got5F5+vlB4QHx8AOiN0T7KikU4qSZ3gzYb68N3sXzINWM0U1uv/EIjdW0VBzmUayPHa/H5KepGmcbRdMi36uid2savqU7IB+q5iIlfb75+zjYOr8Ut7LCWOf+b+DYEY1RO3pdzvYX9Gvy8Hi/L/fq/pWvILLcGdiq7jb/35MrDAwPWBpAKZzXrhzxQRluzrStr4sok4drKEByYLQNHtcykitPe9EcbMVUbaXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXOt30xcr11alHK7Lag/O+9dwN5ma1VYe75iYLQELQk=;
 b=hOy1JkBcvggkpkevNz91cMaC2LjmEW4Przh++jn/hvGuK8udNKWrvRpGJcNNoAj59DXpgZqCWfJ6U00wsFJMY08Iy+a+RhdWn9WwDx98pKOL/CBmvBwYqLqnucpFGDgzOcDF5yOTS68CoDb/0Uv91bwCpXY1DnQNPub/pmCbpXJC6Em6gR6yiT4yK3J9CMWrEJ8Xs0oltL8VSkr9PytvqhSHk0cXoQYClelo1+gVqTm4RdP23eKJ8pHQsCkP+vEBR68sN17Oy3y5uqhN9X5Eey/HRxBh2R6ibJ3ljO4AA9Fjk2Dcz3NMOIfCMYGIp9lZb/2WjbKdJCLxCYA0a/sARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXOt30xcr11alHK7Lag/O+9dwN5ma1VYe75iYLQELQk=;
 b=BQBaQ8Fggf/ir4TLivTz3J0XtWkT38HFxLBZPYovdU9j4B7+wBkc/chZQHiQcVh0Tel5qhOPakiBEVx+If0SoiBkUDAAzODDvgEPaZoZxkAvsNY5jGFnAD+ZixCZqxYh+9wu88dAlwAQnVfS/NqMjlTJomdCyB0/JbhjGCWjNyU=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB7580.apcprd03.prod.outlook.com (2603:1096:820:ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 08:21:15 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%5]) with mapi id 15.20.7181.022; Tue, 16 Jan 2024
 08:21:15 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: mailbox: mediatek: gce-mailbox: Add
 reference to gce-props.yaml
Thread-Topic: [PATCH v2 2/4] dt-bindings: mailbox: mediatek: gce-mailbox: Add
 reference to gce-props.yaml
Thread-Index: AQHaQ49Q/kjMpPuFZkuoMhc+qwpaZbDS2qqAgABkfoCAAaGoAIAA7laAgAVYtQCAAPr2AA==
Date: Tue, 16 Jan 2024 08:21:15 +0000
Message-ID: <4f1e6bdb3e266cf0e89f8a664095ea1709f9afe0.camel@mediatek.com>
References: <20240110063532.14124-1-jason-jh.lin@mediatek.com>
	 <20240110063532.14124-3-jason-jh.lin@mediatek.com>
	 <20240110-grumbling-tattling-0202fc5e21f2@spud>
	 <8c4004d5b6f68dc096aaf2a537e429c310b60c08.camel@mediatek.com>
	 <20240111-anthology-dock-c60d28ac7f1c@spud>
	 <5eaccb10853215a6399759a715d2f0356782bac9.camel@mediatek.com>
	 <20240115-player-waltz-8efb5885a23f@spud>
In-Reply-To: <20240115-player-waltz-8efb5885a23f@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB7580:EE_
x-ms-office365-filtering-correlation-id: 5d127585-14a3-4949-5abc-08dc166c1b5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VyL33z5uteHmtaNf52j+j4qqnEGKI8GAr95FY7Yv0lkQQ3hEPghfWPFhjni/4Qs6TDmZwhOu7wyUR5zUSqgOr6uCJc2uSKgok0vqOdGCfYDw98j2J1SD225gbnMEhXNV1RW4TGgRS8SfNGrxIORv0eqTI/tFC8tw9/zv5b3k2m81I7ss3XE6Jxj/81avVC9itOG1ecMaQII7chFBZ/B2+C6gFXN+huKPPZKGS9rZXJvPCQVGeb/KPo8YQA3cl2tjhCm6DeBE/n3elym3CMxtIOn9Me2cGmzOLYtlDHVVUz+R3gtgkSYnDGjqqkBCCGbQYG06YfH73BSp0U9w2vLRaPdu/k646MFb8sTC6Z+JvTl9+12obBAfaVG+gr6+9/TrRYTFgftQlStyD2Gn0uhh7BE8jHARRbMMFqUd+aJHlkpnzpyjROcko8Q4KZLp4TJ5rt0cyWBBQ4lg1H5BHFzEyf6CFNpkhvfj62/mrkxb0zvyyP3EPKW8NoVW8SOlI8KAOQcVTSSLC5rEFRv9SE59iLFkXJ3KpZKRH5FaN4L2EfIMtCOixKs7zDf2P8U6CkZ6BJI6pjy0P7Y6LQWAL3au8Id+kg9g/D2437Ed5/PnKxJ12JSa0xJSzi1UQ7itHS7k8nQhPaxgmbx9iI0Ky+Uw1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38070700009)(41300700001)(122000001)(83380400001)(38100700002)(85182001)(86362001)(36756003)(26005)(76116006)(66946007)(91956017)(316002)(66476007)(6916009)(54906003)(66446008)(966005)(66556008)(7416002)(2906002)(8676002)(4326008)(5660300002)(8936002)(15650500001)(71200400001)(2616005)(64756008)(6486002)(6506007)(6512007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGM2bDFoTTM0M2ZqNEFCc2JpNUQyWjNtd21OQlBCN1hTS09qQjRpbzFYOWpn?=
 =?utf-8?B?YWlTMU9CMHhJbGI5bUg5Y01ad0Z3RkkvVzd1SnZrMUgxUCtIMmxsSUlnNS9p?=
 =?utf-8?B?Z0x4Zzh3Um56N1VkZ0tic05Ec2JFQS9rVXdaMWp1K1VHU3BCTk5MZHNkb1pK?=
 =?utf-8?B?VWJ3dy94MUtoRzFwYThlYXVkL1hRWGZDaTVROXA1QlVlQ01zRDZ3T1MxWGJz?=
 =?utf-8?B?dDdKT1JEaGlZMUpwM1laZjRnTUx1czVTdHZDM0FOM0tpVVVUQkxkWUxDMllM?=
 =?utf-8?B?MG50QXhlcUNQdndBQWZIbkZvU29zalpTS2s5VFNLSGNCRm4wZGFXOUhjSUVS?=
 =?utf-8?B?RzI4cDZyQmQ5NU80c2s3bk14TGJGdjdwclp0SkliRXB1MS81V25NWlRXTzNT?=
 =?utf-8?B?aDY3YW9EMVdEQUVsZEU3UFRuVWlmTGVyYUFTVnRKSzBNZGltQlpIV2phdmx0?=
 =?utf-8?B?aUdDZHNyK0xuUWYvVld2VnJoQU9qRGtlUTJUTHdaSzVqK3hDVkhRMDdnamdh?=
 =?utf-8?B?eW12QXdGMmg2a2EzQ0w1czBBN1IvVlBUd3dEVXpDODZScGxXbWF6aWs5L0xo?=
 =?utf-8?B?N0xKYnVxWUlrY1c4dy9YRnBhYlN0dnZuMXJWNWU1YXNDNnBjTjV2SjNqSVA1?=
 =?utf-8?B?Zk9CWVZYZC84QVc0U1pBWktXVDZHOEprY1dqdzNmNEFGQ3Y1ZktIeHY5ci94?=
 =?utf-8?B?YnFOOFh3YTBnaDZ2NHlHSU1oMkkvTHFVdzFWYVVHQm5mOVBLQ09DT1RFYnZW?=
 =?utf-8?B?ejg2WTBQTk9ZcnRQVXJpa3Z0cEIvYlQvUjcvWCtHaHFUNnREbDY4NlRFeGpN?=
 =?utf-8?B?UWQxZCthRWVNc2hqRXZ6cDJwRW9OM2N4aDA5Mm9Td284QmZsK3ZJTVpSdHlR?=
 =?utf-8?B?S1JzUTBpMVNKY01YR3lvR0UrdVlhdTZ4UHc1T1MxdjFJa3JISEl1VS93NzBE?=
 =?utf-8?B?Z00yK1RWTGdVY1pDQmE0SmtLTVgwR2JYWVVFOGJxM1hhcWZURjdydDkvc2hP?=
 =?utf-8?B?bkZEalNGTWIrd1RxbDFEeVJDeVRTYnJhSzBWdExTbW5FV0d2ditMaGM5Zm1j?=
 =?utf-8?B?MXREczloc3phbDZ2SzBQczJrcEFBMm1Nd05iZnhQUXoxblRRUjR3WDNHRGlY?=
 =?utf-8?B?ejBvNzFmYkZHdGFsZFZTRHJWREpGeUxlMW9Fa0dIdDV3cDR2SHdrZGlaTS96?=
 =?utf-8?B?eFpLWk84Z1ZzQ2VzWDl3dzVGeWhwcHpNUWJ2S1FwSXc5ZWJEbDN2aFlwYS9p?=
 =?utf-8?B?Y3h2c3FiZ2taeWRmdWJoMkg5R3EwaUFnYzZheC8vSG1Tb3pYcGM3ODJlNEkr?=
 =?utf-8?B?S1R6cDJwZnkrUS9rTlVzcGVtMlhySHJwRUtGTGF0WGt0VnIrczcvcE1hWWIw?=
 =?utf-8?B?WVVtNTl5eStsb1VnWlZVMzdQMG9JMURTWTBVK1Q0dHpHM3R1Rk95dnhGL0Yz?=
 =?utf-8?B?ZUJybVFaOFRIb0d6eE9GWk02bUp2ZDZWcjNQRk81Wm4zU1o0WkxqTGQzZEFh?=
 =?utf-8?B?NkpjVm9mamJXYWI0YmxQWXZPU2xZR1BkVFZ1OFZJdG1JOFV1TmozaTkwMnFQ?=
 =?utf-8?B?T2Y3bmYyZFhCWFNsM2IzVXNhR0t5YXQ3eVp6MnNYbC9IQVo1NWppRU4vdE90?=
 =?utf-8?B?S2pvMGltSDljTFFnakZCRExXY24rbXNaUDdLeXRIL3VzTCtobkt0K2dXbGpH?=
 =?utf-8?B?NXZlSUV1VGZIYjBsck9OVlNFUCtBM0dncHJmQ0NMWllyTEpQWmdHZE8wMkRq?=
 =?utf-8?B?NWhmdnJVajRBdW40YTIrZ0c3cnV0NGVlNGx6TytsdGVua1Mwc3BoZVZPTk90?=
 =?utf-8?B?K3BIaHUyc2hRKzY0ZitXcVdodWVzU0htcGxsQW1taVBabjN0V25mZFJHYmNv?=
 =?utf-8?B?NzhQbUpnNkxsVEhUc3lUcjAvWlZTOEIrYU94RjlHUGkrR0M3L1ZUT3BqV1ZB?=
 =?utf-8?B?aVNFQXp3VkZQSFJTdmNiT1NxMExwYzh4ZmVVZ0RpNk9UWkhoYzFHZytSUE9M?=
 =?utf-8?B?dDAwQUowc1NFSEZsTTJHM2dzbG5YTWt4OEQvUEpaOSt2MjdWT05RWkRXNkVY?=
 =?utf-8?B?NGRBWkVFSE55OEpaN3FLYXNWU3YyWGx1SDBXN2Q4MEM5enEwWU9oMHNCQmJ0?=
 =?utf-8?B?NlVRMDVLRGVrYTNObmVPK3FWV0dkQUFVSXgrM3B0TzJuNXJCdDBtdjJvVTlY?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB073FD794E7B843AC371EF0188651F4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d127585-14a3-4949-5abc-08dc166c1b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 08:21:15.0629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLOVFWNipSjL3RR7z6ZTudhRafr/l9mSmFUx7o5pC+lCXo8sJyFqk9/nZmgYRZOPcxxyMb+R1ln4AWtnMx26aOJrW7D/pywJj8l7fjt192k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7580
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--32.898700-8.000000
X-TMASE-MatchedRID: gTucSmrmRMP4OiVTWoD8RCa1MaKuob8Pt3aeg7g/usCe9toQ6h6LE6gF
	8LHYfOYG0jn9Iep3RsjcoITUAiubNZHy7oM4lvOn9Ib/6w+1lWRimi8LvNfmr7StxTlX+hJ7eDg
	I4iMaw3I4bIq1WfDWav9Wkj62CydKS22k34pVV33J1E/nrJFED1PgO2JKQydYsNQdhWSMpYQXQU
	5a094tomHFkQL4i7pm3/0OX7sbFJrcx97ZZVZcMkKcYi5Qw/RVNACnndLvXwcifM7JMNHW65Hby
	MTbnMu/g1nzb/gKUwSxSUdSYpajD3yuXBiUcuzxQ1OcCEvT+beRPtwwl97om209dFMcGViwkSt3
	DLcZD56VMlcqqHWd7V+bCijmRHWraHK+b0RwiGoCNMj/7qB/g4/8SyGg0rIRyL0CMroLynW8TCm
	prkybjCUUqHXwIymb2mxdgQTEq3vnWmH8Qoh70rxygpRxo4691kqyrcMalqVrEoFtNYg0Czu+b7
	STKgt0UbTIoaMFc4A7+HoDr4vIo+HxFb2pjr4bYB5JRXlcxwAjo8c0NkYYIgv/nTOPQovs59eaF
	eXgSj7M/98aI0xgdTctfMeuvKJ18Dkz7HlGORzpnOP6QxEGtioTaU3L23VCWthoc/ryGpe5fu+X
	EabSpvIs19Gb68mzabsHM48723VAXbiRmn1bD54CIKY/Hg3AwWulRtvvYxTUHQeTVDUrIldoOfo
	OEDYCjaPj0W1qn0SQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--32.898700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DDBF1BF49F13981D25AE9D06AD6AFABED461C01262E52F236A6AB7693E0CA4A42000:8

T24gTW9uLCAyMDI0LTAxLTE1IGF0IDE3OjIzICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIEZyaSwgSmFuIDEyLCAyMDI0IGF0IDA3OjQ0OjEzQU0gKzAwMDAsIEphc29uLUpIIExpbiAo
5p6X552/56WlKSB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjQtMDEtMTEgYXQgMTc6MzEgKzAwMDAs
IENvbm9yIERvb2xleSB3cm90ZToNCj4gPiA+IE9uIFdlZCwgSmFuIDEwLCAyMDI0IGF0IDA0OjM2
OjIwUE0gKzAwMDAsIEphc29uLUpIIExpbiAo5p6X552/56WlKQ0KPiA+ID4gd3JvdGU6DQo+ID4g
PiA+IEhpIENvbm9yLA0KPiA+ID4gPiANCj4gPiA+ID4gVGhhbmtzIGZvciB0aGUgcmV2aWV3cy4N
Cj4gPiA+ID4gDQo+ID4gPiA+IE9uIFdlZCwgMjAyNC0wMS0xMCBhdCAxMDozNiArMDAwMCwgQ29u
b3IgRG9vbGV5IHdyb3RlOg0KPiA+ID4gPiA+IE9uIFdlZCwgSmFuIDEwLCAyMDI0IGF0IDAyOjM1
OjMwUE0gKzA4MDAsIEphc29uLUpILkxpbiB3cm90ZToNCj4gPiA+ID4gPiA+IDEuIEFkZCAiUHJv
dmlkZXIiIHRvIHRoZSB0aXRsZSB0byBtYWtlIGl0IGNsZWFyZXIuDQo+ID4gPiA+ID4gPiAyLiBB
ZGQgcmVmZXJlbmNlIHRvIGdjZS1wcm9wcy55YW1sIGZvciBhZGRpbmcgbWVkaWF0ZWssZ2NlLQ0K
PiA+ID4gPiA+ID4gZXZlbnRzDQo+ID4gPiA+ID4gPiBwcm9wZXJ0eS4NCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBJIGNhbiBzZWUgdGhpcyBmcm9tIHRoZSBkaWZmLiBUaGVyZSdzIHN0aWxsIG5vIGV4
cGxhbmF0aW9uDQo+ID4gPiA+ID4gaGVyZQ0KPiA+ID4gPiA+IGFzIHRvDQo+ID4gPiA+ID4gd2h5
IHRoZSBtYWlsYm94IHByb3ZpZGVyIG5lZWRzIHRvIGhhdmUgYSBnY2UtZXZlbnQgaWQuIE5BSw0K
PiA+ID4gPiA+IHVudGlsDQo+ID4gPiA+ID4geW91DQo+ID4gPiA+ID4gY2FuDQo+ID4gPiA+ID4g
ZXhwbGFpbiB0aGF0Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gU29ycnkgZm9yIG1p
c3NpbmcgdGhlIHJlYXNvbiBpbiBjb21taXQgbWVzc2FnZSwgSSdsbCBhZGQgaXQgaW4NCj4gPiA+
ID4gdGhlDQo+ID4gPiA+IG5leHQNCj4gPiA+ID4gdmVyc2lvbi4NCj4gPiA+ID4gDQo+ID4gPiA+
IFRoZXJlIGFyZSAyIHJlYXNvbnMgd2h5IHRoZSBtYWlsYm94IHByb3ZpZGVyIG5lZWRzIGdjZS1l
dmVudHM6DQo+ID4gPiA+IDEuIFRoZSBtYWlsYm94IHByb3ZpZGVyIGhlcmUgaXMgQ01EUSBtYWls
Ym94IGRyaXZlci4gSXQNCj4gPiA+ID4gY29uZmlndXJlcw0KPiA+ID4gPiBHQ0UNCj4gPiA+ID4g
aGFyZHdhcmUgcmVnaXN0ZXIgYnkgQ1BVIGRpcmVjdGx5LiBJZiB3ZSB3YW50IHRvIHNldCB0aGUN
Cj4gPiA+ID4gZGVmYXVsdA0KPiA+ID4gPiB2YWx1ZQ0KPiA+ID4gPiBmcm9tIDAgdG8gMSBmb3Ig
c3BlY2lmaWMgZ2NlLWV2ZW50cyBkdXJpbmcgdGhlIGluaXRpYWxpemF0aW9uDQo+ID4gPiA+IG9m
DQo+ID4gPiA+IENNRFENCj4gPiA+ID4gZHJpdmVyLiBXZSBuZWVkIHRvIHRlbGwgQ01EUSBkcml2
ZXIgd2hhdCBnY2UtZXZlbnRzIG5lZWQgdG8gYmUNCj4gPiA+ID4gc2V0DQo+ID4gPiA+IGFuZA0K
PiA+ID4gPiBJIHRoaW5rIHN1Y2ggR0NFIGhhcmR3YXJlIHNldHRpbmcgY2FuIGdldCBmcm9tIGl0
cyBkZXZpY2Ugbm9kZS4NCj4gPiA+IA0KPiA+ID4gV2h5IHdvdWxkIHNvbWVvbmUgd2FudCB0byBz
ZXQgaXQgdG8gMSBvciAwPw0KPiA+IA0KPiA+IEdDRSBIVyBoYXZlIGFuIGV2ZW50IHRhYmxlIGlu
IFNSQU0uIEVhY2ggZXZlbnQgSUQgaGFzIGEgYm9vbGVhbg0KPiA+IGV2ZW50DQo+ID4gdmFsdWUg
YW5kIHRoZSBkZWZhdWx0IHZhbHVlIGlzIDAuIFRoZXJlIGFyZSAxMDI0IGV2ZW50IElEcyAoMH4x
MDIzKQ0KPiA+IGluDQo+ID4gdGhlIGV2ZW50IHRhYmxlLiBUaGUgbWVkaWF0ZWssZ2NlLWV2ZW50
cyBpcyB0aGUgcHJvcGVydHkgdG8gZ2V0IHRoZQ0KPiA+IGV2ZW50IElEcy4NCj4gPiANCj4gPiBF
LmcuDQo+ID4gSW4gc29tZSBjYW1lcmEgc3VzcGVuZC9yZXN1bWUgdXNlIGNhc2VzLCB0aGUgbWF5
IHNldCB0aGUgZXZlbnQgSUQ6DQo+ID4gMTAwDQo+ID4gdG8gMSBiZWZvcmUgc3VzcGVuZC4gV2hl
biBDTURRIGRyaXZlciByZXN1bWVzLCBhbGwgdGhlIGV2ZW50IHZhbHVlDQo+ID4gb2YNCj4gPiBl
dmVudCBJRHMgd2lsbCBiZSBjbGVhciB0byAwLiBCdXQgY2FtZXJhIGRyaXZlciB3b24ndCBrbm93
IHRoZQ0KPiA+IGV2ZW50DQo+ID4gSURzOjEwMCBoYXMgYmVlbiBjbGVhcmVkIHRvIDAgYW5kIHN0
aWxsIHNlbmQgYSBjbWQgdG8gd2FpdCBmb3IgdGhlDQo+ID4gZXZlbnQgSUQ6MTAwLiBTbyBDTURR
IGRyaXZlciBtYXkgbmVlZCB0byBrZWVwIHRoZSB2YWx1ZSBvZiBldmVudA0KPiA+IElEOg0KPiA+
IDEwMCBiZWZvcmUgc3VzcGVuZCBhbmQgc2V0IGJhY2sgdGhlIHZhbHVlIHRvIDEgYWZ0ZXIgQ01E
USBkcml2ZXINCj4gPiBjbGVhcmluZyBhbGwgdGhlIGV2ZW50IHZhbHVlIG9mIGV2ZW50IElEcy4N
Cj4gPiANCj4gPiBDTURRIGRyaXZlciB3aWxsIG5lZWQgdG8ga25vdyB3aGljaCBldmVudCBJRHMn
IHZhbHVlcyBuZWVkIHRvIGJlDQo+ID4gYmFja3VwcGVkIGFuZCByZXN0b3JlZCBpbiB0aGF0IGNh
bWVyYSBzdXNwZW5kL3Jlc3VtZSB1c2UgY2FzZS4NCj4gDQo+IFVuZm9ydHVuYXRlbHkgInNvbWUg
dXNlIGNhc2UiIGRvZXNuJ3QgcmVhbGx5IGhlbHAgbWUgaGVyZSwgaXQgaXMgaGFyZA0KPiBmb3Ig
bWUgdG8gdGVsbCB3aGV0aGVyIHRoZXNlIHVzZSBjYXNlcyBhcmUgc29mdHdhcmUgcG9saWN5IG9y
IGFuDQo+IGF0dHJpYnV0ZSBvZiB0aGUgaGFyZHdhcmUuIElmIEkgaGFkIHRoZSBzYW1lIGV4YWN0
IGNhbWVyYSBidXQgd2FzDQo+IHVzaW5nDQo+IGl0IGZvciBhIGRpZmZlcmVudCByZWFzb24sIG1p
Z2h0IEkgc2V0IGl0IHRvIDEgYmVmb3JlIHN1c3BlbmQgaW4gb25lDQo+IGNhc2UgYnV0IG5vdCBp
biB0aGUgb3RoZXI/DQo+IA0KDQpJdCBkZXBlbmRzIG9uIHRoZSBzY2VuYXJpbywgbm90IHRoZSBj
YW1lcmEuIElmIHRoZSBzYW1lIGNhbWVyYSB3aWxsIHVzZQ0KdGhlIHZhbHVlIG9mIGV2ZW50IElE
IGFmdGVyIHJlc3VtZSwgaXQgc2hvdWxkIGJhY2t1cCB0aGUgdmFsdWUgb2YgZXZlbnQNCklEIGJl
Zm9yZSBzdXNwZW5kLg0KDQo+IEkgYWxzbyBkb24ndCByZWFsbHkgdW5kZXJzdGFuZCBob3cgaGF2
aW5nIHRoaXMgcHJvcGVydHkgaGVscHMgaW4gdGhpcw0KPiBjYXNlIGVpdGhlci4gSWYgYSBjYW1l
cmEgaXMgYSBtYWlsYm94IGNvbnN1bWVyLCBpdCBzaG91bGQgaGF2ZSBhDQo+IGdjZS1ldmVudCBw
cm9wZXJ0eSBmb3IgdGhlIGV2ZW50IElEIHRoYXQgaXQgaXMgdXNpbmcgaW4gaXRzIG5vZGUuDQo+
IA0KPiBXaHkgaXMgdGhhdCBub3Qgc3VmZmljaWVudCBhbmQgYSBnY2UtZXZlbnQgYWxzbyBuZWVk
cyB0byBiZSBwcmVzZW50DQo+IGluDQo+IHRoZSBjb25zdW1lciBub2RlPyBJdCBzZWVtcyB0byBt
ZSBsaWtlIGhhdmluZyBpdCBpbiB0aGUgY29uc3VtZXINCj4gYWxvbmUNCj4gc2hvdWxkIGJlIHN1
ZmZpY2llbnQsIGFuZCB0aGUgcmVnaXN0cmF0aW9uIHByb2Nlc3Mgd291bGQgaW5mb3JtIHRoZQ0K
PiBtYWlsYm94IHByb3ZpZGVyIGRyaXZlciB3aGljaCBnY2UtZXZlbnQgSUQgd2FzIGJlaW5nIHVz
ZWQgYnkgdGhlDQo+IGNhbWVyYS4NCg0KSG1tLi4uDQpJbiB0aGlzIGNhbWVyYSBzY2VuYXJpbywg
SSB0aGluayBnY2UtZXZlbnRzIGNhbiBiZSBzZXQgaW4gY29uc3VtZXIncw0KZGV2aWNlIG5vZGUg
Y2xvdWQgYmUgc3VmZmljaWVudC4NCg0KVGhlIENNRFEgbWFpbGJveCBkcml2ZXIgY2FuIG9wZW4g
YW4gQVBJIGZvciBjYW1lcmEgZHJpdmVyIHRvIHNldCBpdHMNCmV2ZW50IElEIHRvIGJlIGJhY2t1
cCwgc28gd2UgZG9uJ3QgbmVlZCB0byBnZXQgdGhpcyBldmVudCBJRCBmcm9tDQptYWlsYm94IHBy
b3ZpZGVyJ3MgZGV2aWNlIG5vZGUuDQoNCj4gDQo+ID4gDQo+ID4gPiBBdCB3aGF0IGxldmVsIHdp
bGwgdGhhdCB2YXJ5PyBQZXIgU29DPyBQZXIgYm9hcmQ/IFNvbWV0aGluZyBlbHNlPw0KPiA+ID4g
DQo+ID4gDQo+ID4gSSB0aGluayB0aGUgU29DIHN1cHBvcnRzIGNhbWVyYSBmZWF0dXJlIG1heSBu
ZWVkIHRoaXMgcHJvcGVydHkuDQo+ID4gDQo+ID4gPiA+IDIuIFdlJ2xsIGhhdmUgdGhlIHNlY3Vy
ZSBDTURRIG1haWxib3ggZHJpdmVyIGluIHRoZSBmdXR1cmUNCj4gPiA+ID4gcGF0Y2gNCj4gPiA+
ID4gWzFdLg0KPiA+ID4gPiBJdCB3aWxsIHJlcXVlc3Qgb3IgcmVzZXJ2ZSBhIG1haWxib3ggY2hh
bm5lbCwgd2hpY2ggaXMgYQ0KPiA+ID4gPiBkZWRpY2F0ZQ0KPiA+ID4gPiBHQ0UNCj4gPiA+ID4g
dGhyZWFkLCBhcyBhIHNlY3VyZSBJUlEgaGFuZGxlci4gVGhpcyBHQ0UgdGhyZWFkIGV4ZWN1dGVz
IGENCj4gPiA+ID4gbG9vcGluZw0KPiA+ID4gPiBpbnN0cnVjdGlvbiBzZXQgdGhhdCBrZWVwcyB3
YWl0aW5nIGZvciB0aGUgZ2NlLWV2ZW50IHNldCBmcm9tDQo+ID4gPiA+IGFub3RoZXINCj4gPiA+
ID4gR0NFIHRocmVhZCBpbiB0aGUgc2VjdXJlIHdvcmxkLiBTbyB3ZSBhbHNvIG5lZWQgdG8gdGVs
bCB0aGUNCj4gPiA+ID4gQ01EUQ0KPiA+ID4gPiBkcml2ZXINCj4gPiA+ID4gd2hhdCBnY2UtZXZl
bnQgbmVlZCB0byBiZSB3YWl0ZWQuDQo+ID4gPiANCj4gPiA+IERpdHRvIGhlcmUsIHdoYXQgbGV2
ZWwgZG9lcyB0aGlzIHZhcnkgYXQ/IERvIGRpZmZlcmVudCBTb0NzIG9yDQo+ID4gPiBkaWZmZXJl
bnQNCj4gPiA+IGJvYXJkcy9wbGF0Zm9ybXMgZGljdGF0ZSB0aGUgdmFsdWU/DQo+ID4gDQo+ID4g
SXQncyBhIFNvQyBsZXZlbCwgdGhlIFNvQyBzdXBwb3J0cyBzZWN1cmUgZmVhdHVyZSB3aWxsIG5l
ZWQgdGhpcw0KPiA+IHByb3BlcnR5Lg0KPiA+IA0KPiA+ID4gQ291bGQgdGhpcyBjaGFubmVsIGJl
IGRldGVybWluZWQgZnJvbSB0aGUgc29jLXNwZWNpZmljDQo+ID4gPiBjb21wYXRpYmxlPw0KPiA+
ID4gDQo+ID4gPiBJbiBvdGhlciB3b3JkcywgcGxlYXNlIGV4cGxhaW4gaW4geW91ciBjb21taXQg
bWVzc2FnZSB3aHkgdGhpcw0KPiA+ID4gcmVxdWlyZXMNCj4gPiA+IGEgcHJvcGVydHkgYW5kIGlz
IG5vdCBkZXRlY3RhYmxlIGZyb20gYW55IGV4aXN0aW5nIG1lY2hhbmlzbS4NCj4gPiA+IEZyb20N
Cj4gPiA+IHJlYWRpbmcgdGhpcyBJIGRvbid0IGtub3cgd2hhdCBpcyBwcmV2ZW50aW5nIHRoZSBz
ZWN1cmUgbWFpbGJveA0KPiA+ID4gY2hhbm5lbA0KPiA+ID4gZnJvbSBwaWNraW5nIGEgInJhbmRv
bSIgdW51c2VkIGNoYW5uZWwuDQo+ID4gDQo+ID4gVGhlIHNlY3VyZSBjaGFubmVsIGNvdWxkIGJl
IGRlZGljYXRlZCBmcm9tIHRoZSBzb2Mtc3BlY2lmaWMNCj4gPiBjb21wYXRpYmxlLA0KPiA+IGJ1
dCB0aGUgZXZlbnQgSUQgY291bGRuJ3QuDQo+ID4gDQo+ID4gVGhlIHNhbWUgZXZlbnQgc2lnbmFs
IGNvcnJlc3BvbmRpbmcgZXZlbnQgSUQgbWF5IGNoYW5nZXMgaW4NCj4gPiBkaWZmZXJlbnQNCj4g
PiBTb0MuDQo+ID4gRS5nLg0KPiA+IFRoZSBIVyBldmVudCBzaWduYWwgZm9yIENNRFFfRVZFTlRf
VkRPMF9NVVRFWF9TVFJFQU1fRE9ORV8wIGlzDQo+ID4gY29ycmVzcG9uZGluZyB0byBHQ0UgZXZl
bnQgSUQ6IDU3NCBpbiBNVDgxODgsIGJ1dCBpdCdzDQo+ID4gY29ycmVzcG9uZGluZyB0bw0KPiA+
IGV2ZW50SUQ6IDU5NyBpbiBNVDgxOTUuDQo+IA0KPiBJcyBpdCBhbHdheXMgNTc0IGluIE1UODE4
OCBhbmQgYWx3YXlzIDU5NyBpbiBNVDgxOTU/DQo+IA0KWWVzLCBzb21lIGdjZS1ldmVudHMgYXJl
IGhhcmR3YXJlIGJvdW5kIGFuZCB0aGV5IGNhbiBub3QgY2hhbmdlIGJ5DQpzb2Z0d2FyZS4gRm9y
IGV4YW1wbGUsIGluIE1UODE5NSwgd2hlbiBWRE8wX01VVEVYIGlzIHN0cmVhbSBkb25lLA0KVkRP
X01VVEVYIHdpbGwgc2VuZCBhbiBldmVudCBzaWduYWwgdG8gR0NFLCBhbmQgdGhlIHZhbHVlIG9m
IGV2ZW50DQpJRDo1OTcgd2lsbCBiZSBzZXQgdG8gMS4gSW4gTVQ4MTg4LCB0aGUgdmFsdWUgb2Yg
ZXZlbnQgSUQ6IDU3NCB3aWxsIGJlDQpzZXQgdG8gMSB3aGVuIFZPRDBfTVVURVggaXMgc3RyZWFt
IGRvbmUuDQoNClNvbWUgb2YgZ2NlLWV2ZW50cyBhcmUgbm90IGhhcmR3YXJlIGJvdW5kIGFuZCB0
aGV5IGNhbiBjaGFuZ2UgYnkNCnNvZnR3YXJlLiBGb3IgZXhhbXBsZSwgaW4gTVQ4MTg4LCB3ZSBj
YW4gdGFrZSB0aGUgZXZlbnQgSUQ6IDg1NSB0aGF0IGlzDQpub3QgYm91bmQgdG8gYW55IGhhcmR3
YXJlIHRvIHNldCBpdHMgdmFsdWUgdG8gMSB3aGVuIHRoZSBkcml2ZXIgaW4NCnNlY3VyZSB3b3Js
ZCBjb21wbGV0ZXMgYSB0YXNrLiBCdXQgaW4gTVQ4MTk1LCB0aGUgZXZlbnQgSUQ6IDg1NSBpcw0K
YWxyZWFkeSBib3VuZCB0byBWREVDX0xBVDEsIHNvIHdlIGhhdmUgdG8gdGFrZSBhbm90aGVyIGV2
ZW50IElEIHRvDQphY2hpZXZlIHRoZSBzYW1lIHB1cnBvc2UuDQpUaGlzIGV2ZW50IElEIGNhbiBi
ZSBjaGFuZ2UgYW55IElEcyB0aGF0IGlzIG5vdCBib3VuZCB0byBhbnkgaGFyZHdhcmUNCmFuZCBp
cyBub3QgdXNlIGluIGFueSBzb2Z0d2FyZSBkcml2ZXIgeWV0Lg0KV2UgY2FuIHNlZSBpZiB0aGUg
ZXZlbnQgSUQgaXMgYm91bmQgdG8gdGhlIGhhcmR3YXJlIG9yIGlzIHVzZWQgYnkNCnNvZnR3YXJl
IGRyaXZlciBpbiB0aGUgaGVhZGVyDQppbmNsdWRlL2RlLWJpbmRpbmdzL21haWxib3gvbWVkaWF0
ZWssbXQ4MTg4LWdjZS5oLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gVGhhbmtzLA0K
PiBDb25vci4NCj4gDQo+ID4gSSBjYW4gdGFrZSBhbnkgb2YgdGhlICJ1bnVzZWQiIG1haWxib3gg
Y2hhbm5lbCBmb3IgdGhlIHNlY3VyZSBpcnENCj4gPiBoYW5kbGVyLiBCdXQgd2l0aG91dCB0aGUg
cHJvcGVydHkgbWVkaWF0ZWssZ2NlLWV2ZW50cywgdGhlIHNlY3VyZQ0KPiA+IGNoYW5uZWwgbWln
aHQgbm90IGtub3cgd2hhdCBldmVudCBJRCB0byB3YWl0IGZvci4NCj4gPiANCj4gPiBSZWdhcmRz
LA0KPiA+IEphc29uLUpILkxpbg0KPiA+ID4gDQo+ID4gPiBUaGFua3MsDQo+ID4gPiBDb25vci4N
Cj4gPiA+IA0KPiA+ID4gPiBbMV0gY21kcV9zZWNfaXJxX25vdGlmeV9zdGFydCgpIGlzIHdoZXJl
IHRoZSBHQ0UgdGhyZWFkIGlzDQo+ID4gPiA+IHJlcXVlc3RlZCB0bw0KPiA+ID4gPiBwcmVwYXJl
IGEgbG9vcGluZyBpbnN0cnVjdGlvbiBzZXQgdG8gd2FpdCBmb3IgdGhlIGdjZS1ldmVudC4NCj4g
PiA+ID4gLSANCj4gPiA+ID4gDQo+ID4gDQo+ID4gDQpodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAyMzEyMjIwNDUyMjguMjc4MjYtOS1q
YXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tLw0KPiA+ID4gPiANCj4gPiA+ID4gUmVnYXJkcywNCj4g
PiA+ID4gSmFzb24tSkguTGluDQo+ID4gPiA+IA0KPiA+ID4gPiA+IENoZWVycywNCj4gPiA+ID4g
PiBDb25vci4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+
ID4gLS0tDQo+ID4gPiA+ID4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tZWRp
YXRlayxnY2UtDQo+ID4gPiA+ID4gPiBtYWlsYm94LnlhbWwgICB8DQo+ID4gPiA+ID4gPiA2DQo+
ID4gPiA+ID4gPiArKysrLS0NCj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBkaWZmIC0t
Z2l0DQo+ID4gPiA+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWls
Ym94L21lZGlhdGVrLGdjZS0NCj4gPiA+ID4gPiA+IG1haWxib3gueWFtbA0KPiA+ID4gPiA+ID4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxnY2Ut
DQo+ID4gPiA+ID4gPiBtYWlsYm94LnlhbWwNCj4gPiA+ID4gPiA+IGluZGV4IGNlZjlkNzYwMTM5
OC4uNzI4ZGM5MzExN2E2IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L21lZGlhdGVrLGdjZS0NCj4g
PiA+ID4gPiA+IG1haWxib3gueWFtbA0KPiA+ID4gPiA+ID4gKysrDQo+ID4gPiA+ID4gPiBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L21lZGlhdGVrLGdjZS0NCj4g
PiA+ID4gPiA+IG1haWxib3gueWFtbA0KPiA+ID4gPiA+ID4gQEAgLTQsNyArNCw3IEBADQo+ID4g
PiA+ID4gPiAgJGlkOiANCj4gPiA+ID4gPiA+IA0KPiA+IA0KPiA+IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9zY2hlbWFzL21haWxib3gvbWVkaWF0ZWssZ2NlLW1haWxib3gueWFtbCMNCj4gPiA+ID4g
PiA+ICAkc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFt
bCMNCj4gPiA+ID4gPiA+ICANCj4gPiA+ID4gPiA+IC10aXRsZTogTWVkaWF0ZWsgR2xvYmFsIENv
bW1hbmQgRW5naW5lIE1haWxib3gNCj4gPiA+ID4gPiA+ICt0aXRsZTogTWVkaWFUZWsgR2xvYmFs
IENvbW1hbmQgRW5naW5lIE1haWxib3ggUHJvdmlkZXINCj4gPiA+ID4gPiA+ICANCj4gPiA+ID4g
PiA+ICBtYWludGFpbmVyczoNCj4gPiA+ID4gPiA+ICAgIC0gSG91bG9uZyBXZWkgPGhvdWxvbmcu
d2VpQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiA+IEBAIC01Nyw2ICs1Nyw4IEBAIHJlcXVpcmVk
Og0KPiA+ID4gPiA+ID4gICAgLSBjbG9ja3MNCj4gPiA+ID4gPiA+ICANCj4gPiA+ID4gPiA+ICBh
bGxPZjoNCj4gPiA+ID4gPiA+ICsgIC0gJHJlZjogbWVkaWF0ZWssZ2NlLXByb3BzLnlhbWwNCj4g
PiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICAgIC0gaWY6DQo+ID4gPiA+ID4gPiAgICAgICAgbm90
Og0KPiA+ID4gPiA+ID4gICAgICAgICAgcHJvcGVydGllczoNCj4gPiA+ID4gPiA+IEBAIC02Nyw3
ICs2OSw3IEBAIGFsbE9mOg0KPiA+ID4gPiA+ID4gICAgICAgIHJlcXVpcmVkOg0KPiA+ID4gPiA+
ID4gICAgICAgICAgLSBjbG9jay1uYW1lcw0KPiA+ID4gPiA+ID4gIA0KPiA+ID4gPiA+ID4gLWFk
ZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ID4gPiA+ID4gK3VuZXZhbHVhdGVkUHJvcGVy
dGllczogZmFsc2UNCj4gPiA+ID4gPiA+ICANCj4gPiA+ID4gPiA+ICBleGFtcGxlczoNCj4gPiA+
ID4gPiA+ICAgIC0gfA0KPiA+ID4gPiA+ID4gLS0gDQo+ID4gPiA+ID4gPiAyLjE4LjANCj4gPiA+
ID4gPiA+IA0K

