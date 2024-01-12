Return-Path: <linux-kernel+bounces-24392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C9E82BBF4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC06B1C25042
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B686E5D739;
	Fri, 12 Jan 2024 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PDNE0Y7A";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="sgDTzDCO"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DFA5C8E1;
	Fri, 12 Jan 2024 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 64072c3ab11e11eea2298b7352fd921d-20240112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WmFQmXsb86TjKn3XLJvRZ4Yg6VIKRbN46uGIAFViUB0=;
	b=PDNE0Y7AK9+FyIaj0vTk83aBRKVMCfRx5bO+58g8qE3d5n97psiSD/DRZFGjSy5rjgVX6xXrOu1OLfLEcYh5aaf3qSuDqxD3UrV7xlBpY/TLTfDmMRbFr7JxkF6FwusEczRrIk/M9O+10beJjY5xhiVK0mK3CKpw4vBAvIaa85o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:971fed77-2eb3-4cf4-9a9a-c0d22d51f45c,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:5d391d7,CLOUDID:c541c682-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 64072c3ab11e11eea2298b7352fd921d-20240112
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1030982000; Fri, 12 Jan 2024 15:44:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Jan 2024 15:44:16 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Jan 2024 15:44:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqEfKUqMqtt8TrqqhdydCtBPAl9jGrWVVbei0MePk4j35zM58BTYHR6OhLXDdzDETvZKCSxPezQqo5Xx4obBgEd1ch2jxhKfhZs38KuTMVr9BMjZd9NGTF8BvPEsWBPVZADG0+eSqYSLHjg9v8Kf32Sy3RRiC81LNoKvfjFaxi5k1xQDRJ7Dzo4PTFts4XWq+6V9JBT1soIGlvbuWr0xw4m4cTEqHEWtBG/V90RiV0H6cwLj0V7mS8Je+PbCETBVDAoe8XdFX9jFZpMSu7M2T8Xn74Bs50CZPirawUNCCBtRB14Nt358BNRLGIR/pL54MkeWkRcQ2wCs/kHINgnV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmFQmXsb86TjKn3XLJvRZ4Yg6VIKRbN46uGIAFViUB0=;
 b=T4hK+ySKoqD0/Cb34FQlGuV3AOBQAXwB203Nuvvbwu7nxMF0fQNz/dGt/lE815WFnJNtfVi2LnLMZFpTODfk45XoYCxA7WyvQffClAq+xjEhKXuu9c/9elRh1z8yY3L2u42ELTumAZOoqUoMkYLmC9dQPpIVqxs/6Wydyf/kN9ffWfS18QP0nWu9pV/Z3tvJSW+TqjJ7IRs6cjs9kWUgbTTabXwT3fadnhpZLYwzAcCXlk77VbmbvuAEINcS4aIbvnMnLJg5Eun+XB1WRof40lAb9CBwN/miqlSFsaCJSpAUl3i/VAfJk73hzu+LOD4h5eIpWhwaXN/4AlTPx65nXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmFQmXsb86TjKn3XLJvRZ4Yg6VIKRbN46uGIAFViUB0=;
 b=sgDTzDCOuPH8Bj127KB0CJceuDsKZW9hf+galXBXxt7MJmEi4tUmcG9aN7+L2GbKtb2EqVol4X6YPURHBoZQ/Qx18cgYVoQHUf9S5/fm2tF8nf6Hy612V+XTDvoYcv2t0RhxsPyqDwYKAlujx7Tg5ku8uL1FMtWDASrgbSiwr4g=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB8498.apcprd03.prod.outlook.com (2603:1096:101:1fd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 07:44:14 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%5]) with mapi id 15.20.7181.015; Fri, 12 Jan 2024
 07:44:14 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
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
Thread-Index: AQHaQ49Q/kjMpPuFZkuoMhc+qwpaZbDS2qqAgABkfoCAAaGoAIAA7laA
Date: Fri, 12 Jan 2024 07:44:13 +0000
Message-ID: <5eaccb10853215a6399759a715d2f0356782bac9.camel@mediatek.com>
References: <20240110063532.14124-1-jason-jh.lin@mediatek.com>
	 <20240110063532.14124-3-jason-jh.lin@mediatek.com>
	 <20240110-grumbling-tattling-0202fc5e21f2@spud>
	 <8c4004d5b6f68dc096aaf2a537e429c310b60c08.camel@mediatek.com>
	 <20240111-anthology-dock-c60d28ac7f1c@spud>
In-Reply-To: <20240111-anthology-dock-c60d28ac7f1c@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB8498:EE_
x-ms-office365-filtering-correlation-id: 11359879-39b1-4945-6bf8-08dc134245d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ej//GZ1BdgKn15n0jOPvDTkN1hc+/IeceYVuUXZVokkhU3q7l7BwvGs7KmyAm+uTRGlV9LDno9WV2Jns22RRzYNq7xUE20D0AyVZqckjyRmX+AdR4Iw6y4iqh0Y9kMcjzfdgU13sSlz0g9a/qQ+4sRsB61iDoaesQHqzqsb/NPJ14LqIojeWjkKcMR9i7COLLxnCbC7bOJwPwtKv7Aw3n42MQy9nf3X32kLC8AentdAaoZMVI1crds72KXN34bHYaoOeZq199QaGYdPMeczmIn28db/JvlgNYXMUixmJ2T8wJUYehDpJ6tUc0OAroekdZi9M+S+RDf2cwJAz1L7mvO86wC8lDJBR9o/p032lTWeDVkfiS0ub2T6AIdJO14SoKRW3rMioMdxDg8rjXXg9krCltPTgobu1umTZkJqnZSes7TQ3ltWe7iTH6lQ6OXW9fIP3QVyFpoHFXUvGsYSdmwaoOk1H/gK7ueMylQ9t4/BDcO4DhGGsdSOiml51fTqNVMsbtf/ijDGmKl7hTDjb8wQiUgUlf+lsFk5Gtl2I6827Ovmgm/EvYztfr/3LUSjbNDvCcYTzjhoTUz4ohcqbgfFJLZLF5zkEnO/eYeC4AfU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(83380400001)(6512007)(478600001)(6506007)(86362001)(966005)(122000001)(38100700002)(4326008)(71200400001)(6916009)(6486002)(54906003)(2616005)(91956017)(5660300002)(38070700009)(15650500001)(2906002)(66476007)(85182001)(7416002)(66556008)(8936002)(64756008)(76116006)(36756003)(66446008)(66946007)(8676002)(316002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1kwckZPaHNvMXZvUnRyRUprdFNlM0x1NUVpeTBkZWFDTytUUmlUSEZJNE1r?=
 =?utf-8?B?aTFGaU9wemQ1elphVzRtVjd2YXJkK2gzdlc5dVFTYllVQXJGWmJtMHV3elhj?=
 =?utf-8?B?V3BpNzNMQUR2RitwN2kwbWlzRnlGY0ZvYVVCTlJTUzdINVdxNGlVa0U1QUtB?=
 =?utf-8?B?V1V3Mjd4V2l0YmdRdkZXOWoxVXRCQ3d1NkVZNVlJM1liMDc1dmphdy9QL0V4?=
 =?utf-8?B?eDZQVTRaRG9HdjRNMHcwaUttQjZ2SURuSVh3Q3ZiWFhnTDh1czBZNmRuaTJa?=
 =?utf-8?B?L2dLcW1PeUNScW11LytiejlybEg4Z08zdjRtTFZZbkM5UWtQN0NKM29hN3Aw?=
 =?utf-8?B?MWlDbTd2bklZMG1LMzF1QXhZa2lINmcwZytrUXl2enlsalZicXI3TDNVVVdj?=
 =?utf-8?B?R1h4QzQ1OXdnZ0NCcnprSzV2dUxxVkw2bGxkSkFFRFJndUozN3FjTUdPaEJj?=
 =?utf-8?B?cGRIdDFEZGdKVkgxMG85TW9idGt4N20wV01iQ0V6MnRNQS9FUy91b091UjhC?=
 =?utf-8?B?MjR1Z1pHR2RDNDBCYmhEK3lWRDVkcGhWRGpmdEQ0cnRhbmNGUmNMTFNIZGpD?=
 =?utf-8?B?QVZCaVhZRXlnZys5Sno0TlBRcUxnaUlTOFlSdkt5SkVIcURFc3hQeEU3WitO?=
 =?utf-8?B?SjNKSHFQa0hNUVhRVGxjbmVocGx2QjhSckpsV3JNeTdqWlV2YnY3MDdJckVP?=
 =?utf-8?B?SnNlQU1tUDBIWGdmRlQ5bTFpRjlKZk5PWHRIYjVUWXVaaThKdHJWUXhNaU9w?=
 =?utf-8?B?WGF1ZWZBeG9HTEttU1BPeDlDVlJNU1JyTzg3VkNqSmJnVEhmR2R5Zmgwdmpj?=
 =?utf-8?B?eUo1bWcxckNkV1lPc1R2MzFkSnQ4UVhVU0FvbHpwZTFka1ZqSXhIUU54Z0dQ?=
 =?utf-8?B?MkpCcjVJRjhvV28zbGZKYk5xRmg3N3JSQTYxejV6Kzcrbkw4MGFkQWUzTDdp?=
 =?utf-8?B?UXlFTlJJR1JYV2FMQWJyTStiMDl5cUNYWjN6TjhxMFMwVDJRM2NTQVJteUJ1?=
 =?utf-8?B?dTMwU3BCR3FESXRkUGFYUjZTUTlWQk5kN0ZiTTJNYUcyNUZxeFJja3daWFJT?=
 =?utf-8?B?SVhIdGhJSytUTDJXRlRpUU1SRmtSNGtJQzBubC9QcGNEZlhkelRTUWZwUnJr?=
 =?utf-8?B?bjJKSW00VEZvNkVta0Z0TUhWQlBlc0tkNVYwWGd5MDV5TVlHMUt5Zy9IdmFI?=
 =?utf-8?B?djJvMHduNWR0NUFCYkdlOWZRWXpOVkR1Nm1FQ0tPekRHTFVnVHJ6NjErUEU5?=
 =?utf-8?B?YU9BcjNaVzFUYS9CTjU3cWxhdjBhdC94ekF3UGJtZVlpNzlWUEpNTVd1VXk3?=
 =?utf-8?B?TVNDSDBzKzl0cVNjaFBNMUlGZE51aHF1bm5yUWZSNWZHOXk3L0pXYnEzQU82?=
 =?utf-8?B?VWk4cTVtcXd2NjhkRHlWUjdyTmYybW1kUGJ5UzF6SDl2U3g2VVZZQTVXZDdG?=
 =?utf-8?B?bkhneWNJS1JmLzBqdXRJbkxtQ05ydUpDTFFiL1lpcmxFNjNlNFBpYk5keXZp?=
 =?utf-8?B?TytLY0tVN0x2MkJmQ0JoU2Q5djlCMHM2cnd4RVJkRDRkWEdZRitVUEhDMDhh?=
 =?utf-8?B?aEIrbkwyMG03Wjd3WnI4YjJpYVMyZ3JGM0pKQTFzRXZRTE5LbHAxcC9RQWRu?=
 =?utf-8?B?TzBJMmZrOThpdXp2MGphZjlOZWMyampoSmFqdW1mdExCd0FmU0R1YncwUUE3?=
 =?utf-8?B?K0lQeGx3RDRHM0lmeGFxVkFlUjVCNFlINWpITnNPRjZ4YXNncExmT1V2S1Ra?=
 =?utf-8?B?YzRYWkdNOWVyK2JyV1IrYXhubXdYQWU3UWliR2VZWWtubWNwN3U0cGlFK3Va?=
 =?utf-8?B?MGsrakIxZ3dhWkpYVS9Mc3c5L1B5L1JTckhEbGxIRUZhRm1FYnZXSlpjNVc3?=
 =?utf-8?B?RnlDMGtDcGJIZEhlMjVOQTBLTTgraWhiVWhrVGlhV1lQVnNrVFdrRUZFWStS?=
 =?utf-8?B?L2pNWHRWRnQydTRieTM0RXFWRUZTV3liZWpVT3FqZHdCZGFjczF6T3locDRR?=
 =?utf-8?B?LzFWclBERDRnWHlpVzNIcTZobEI0SFhYNWhJTWRHTW4zeEJNMFBxMmszekZ5?=
 =?utf-8?B?Y29EVXo0STd2TC9CbkdmWHQzR2lBNXJqVmNxTVlIbklINlhXSnNsVGlnVVlF?=
 =?utf-8?B?T09QeHI1VXFmSldGYmlIOURHY0RMb2txbVNsT2V2NnJQdDc2N21nYytUWVVD?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C4B3C5BB8FE6A4982E69B23B7051023@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11359879-39b1-4945-6bf8-08dc134245d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 07:44:14.0003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HWEwk0xnkOaQ3iPJB0I5os4NvpsmGtZ/h/brhqaZMnJYQgOvyISU5ZauOaR2YNExzkOWGLEh6pQLtyQ/y13Iwl4Hl0Sa0tTOk5wRrCDoNg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8498

T24gVGh1LCAyMDI0LTAxLTExIGF0IDE3OjMxICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFdlZCwgSmFuIDEwLCAyMDI0IGF0IDA0OjM2OjIwUE0gKzAwMDAsIEphc29uLUpIIExpbiAo
5p6X552/56WlKSB3cm90ZToNCj4gPiBIaSBDb25vciwNCj4gPiANCj4gPiBUaGFua3MgZm9yIHRo
ZSByZXZpZXdzLg0KPiA+IA0KPiA+IE9uIFdlZCwgMjAyNC0wMS0xMCBhdCAxMDozNiArMDAwMCwg
Q29ub3IgRG9vbGV5IHdyb3RlOg0KPiA+ID4gT24gV2VkLCBKYW4gMTAsIDIwMjQgYXQgMDI6MzU6
MzBQTSArMDgwMCwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+ID4gPiAxLiBBZGQgIlByb3ZpZGVy
IiB0byB0aGUgdGl0bGUgdG8gbWFrZSBpdCBjbGVhcmVyLg0KPiA+ID4gPiAyLiBBZGQgcmVmZXJl
bmNlIHRvIGdjZS1wcm9wcy55YW1sIGZvciBhZGRpbmcgbWVkaWF0ZWssZ2NlLQ0KPiA+ID4gPiBl
dmVudHMNCj4gPiA+ID4gcHJvcGVydHkuDQo+ID4gPiANCj4gPiA+IEkgY2FuIHNlZSB0aGlzIGZy
b20gdGhlIGRpZmYuIFRoZXJlJ3Mgc3RpbGwgbm8gZXhwbGFuYXRpb24gaGVyZQ0KPiA+ID4gYXMg
dG8NCj4gPiA+IHdoeSB0aGUgbWFpbGJveCBwcm92aWRlciBuZWVkcyB0byBoYXZlIGEgZ2NlLWV2
ZW50IGlkLiBOQUsgdW50aWwNCj4gPiA+IHlvdQ0KPiA+ID4gY2FuDQo+ID4gPiBleHBsYWluIHRo
YXQuDQo+ID4gPiANCj4gPiANCj4gPiBTb3JyeSBmb3IgbWlzc2luZyB0aGUgcmVhc29uIGluIGNv
bW1pdCBtZXNzYWdlLCBJJ2xsIGFkZCBpdCBpbiB0aGUNCj4gPiBuZXh0DQo+ID4gdmVyc2lvbi4N
Cj4gPiANCj4gPiBUaGVyZSBhcmUgMiByZWFzb25zIHdoeSB0aGUgbWFpbGJveCBwcm92aWRlciBu
ZWVkcyBnY2UtZXZlbnRzOg0KPiA+IDEuIFRoZSBtYWlsYm94IHByb3ZpZGVyIGhlcmUgaXMgQ01E
USBtYWlsYm94IGRyaXZlci4gSXQgY29uZmlndXJlcw0KPiA+IEdDRQ0KPiA+IGhhcmR3YXJlIHJl
Z2lzdGVyIGJ5IENQVSBkaXJlY3RseS4gSWYgd2Ugd2FudCB0byBzZXQgdGhlIGRlZmF1bHQNCj4g
PiB2YWx1ZQ0KPiA+IGZyb20gMCB0byAxIGZvciBzcGVjaWZpYyBnY2UtZXZlbnRzIGR1cmluZyB0
aGUgaW5pdGlhbGl6YXRpb24gb2YNCj4gPiBDTURRDQo+ID4gZHJpdmVyLiBXZSBuZWVkIHRvIHRl
bGwgQ01EUSBkcml2ZXIgd2hhdCBnY2UtZXZlbnRzIG5lZWQgdG8gYmUgc2V0DQo+ID4gYW5kDQo+
ID4gSSB0aGluayBzdWNoIEdDRSBoYXJkd2FyZSBzZXR0aW5nIGNhbiBnZXQgZnJvbSBpdHMgZGV2
aWNlIG5vZGUuDQo+IA0KPiBXaHkgd291bGQgc29tZW9uZSB3YW50IHRvIHNldCBpdCB0byAxIG9y
IDA/DQoNCkdDRSBIVyBoYXZlIGFuIGV2ZW50IHRhYmxlIGluIFNSQU0uIEVhY2ggZXZlbnQgSUQg
aGFzIGEgYm9vbGVhbiBldmVudA0KdmFsdWUgYW5kIHRoZSBkZWZhdWx0IHZhbHVlIGlzIDAuIFRo
ZXJlIGFyZSAxMDI0IGV2ZW50IElEcyAoMH4xMDIzKSBpbg0KdGhlIGV2ZW50IHRhYmxlLiBUaGUg
bWVkaWF0ZWssZ2NlLWV2ZW50cyBpcyB0aGUgcHJvcGVydHkgdG8gZ2V0IHRoZQ0KZXZlbnQgSURz
Lg0KDQpFLmcuDQpJbiBzb21lIGNhbWVyYSBzdXNwZW5kL3Jlc3VtZSB1c2UgY2FzZXMsIHRoZSBt
YXkgc2V0IHRoZSBldmVudCBJRDogMTAwDQp0byAxIGJlZm9yZSBzdXNwZW5kLiBXaGVuIENNRFEg
ZHJpdmVyIHJlc3VtZXMsIGFsbCB0aGUgZXZlbnQgdmFsdWUgb2YNCmV2ZW50IElEcyB3aWxsIGJl
IGNsZWFyIHRvIDAuIEJ1dCBjYW1lcmEgZHJpdmVyIHdvbid0IGtub3cgdGhlIGV2ZW50DQpJRHM6
MTAwIGhhcyBiZWVuIGNsZWFyZWQgdG8gMCBhbmQgc3RpbGwgc2VuZCBhIGNtZCB0byB3YWl0IGZv
ciB0aGUNCmV2ZW50IElEOjEwMC4gU28gQ01EUSBkcml2ZXIgbWF5IG5lZWQgdG8ga2VlcCB0aGUg
dmFsdWUgb2YgZXZlbnQgSUQ6DQoxMDAgYmVmb3JlIHN1c3BlbmQgYW5kIHNldCBiYWNrIHRoZSB2
YWx1ZSB0byAxIGFmdGVyIENNRFEgZHJpdmVyDQpjbGVhcmluZyBhbGwgdGhlIGV2ZW50IHZhbHVl
IG9mIGV2ZW50IElEcy4NCg0KQ01EUSBkcml2ZXIgd2lsbCBuZWVkIHRvIGtub3cgd2hpY2ggZXZl
bnQgSURzJyB2YWx1ZXMgbmVlZCB0byBiZQ0KYmFja3VwcGVkIGFuZCByZXN0b3JlZCBpbiB0aGF0
IGNhbWVyYSBzdXNwZW5kL3Jlc3VtZSB1c2UgY2FzZS4NCg0KPiBBdCB3aGF0IGxldmVsIHdpbGwg
dGhhdCB2YXJ5PyBQZXIgU29DPyBQZXIgYm9hcmQ/IFNvbWV0aGluZyBlbHNlPw0KPiANCg0KSSB0
aGluayB0aGUgU29DIHN1cHBvcnRzIGNhbWVyYSBmZWF0dXJlIG1heSBuZWVkIHRoaXMgcHJvcGVy
dHkuDQoNCj4gPiAyLiBXZSdsbCBoYXZlIHRoZSBzZWN1cmUgQ01EUSBtYWlsYm94IGRyaXZlciBp
biB0aGUgZnV0dXJlIHBhdGNoDQo+ID4gWzFdLg0KPiA+IEl0IHdpbGwgcmVxdWVzdCBvciByZXNl
cnZlIGEgbWFpbGJveCBjaGFubmVsLCB3aGljaCBpcyBhIGRlZGljYXRlDQo+ID4gR0NFDQo+ID4g
dGhyZWFkLCBhcyBhIHNlY3VyZSBJUlEgaGFuZGxlci4gVGhpcyBHQ0UgdGhyZWFkIGV4ZWN1dGVz
IGEgbG9vcGluZw0KPiA+IGluc3RydWN0aW9uIHNldCB0aGF0IGtlZXBzIHdhaXRpbmcgZm9yIHRo
ZSBnY2UtZXZlbnQgc2V0IGZyb20NCj4gPiBhbm90aGVyDQo+ID4gR0NFIHRocmVhZCBpbiB0aGUg
c2VjdXJlIHdvcmxkLiBTbyB3ZSBhbHNvIG5lZWQgdG8gdGVsbCB0aGUgQ01EUQ0KPiA+IGRyaXZl
cg0KPiA+IHdoYXQgZ2NlLWV2ZW50IG5lZWQgdG8gYmUgd2FpdGVkLg0KPiANCj4gRGl0dG8gaGVy
ZSwgd2hhdCBsZXZlbCBkb2VzIHRoaXMgdmFyeSBhdD8gRG8gZGlmZmVyZW50IFNvQ3Mgb3INCj4g
ZGlmZmVyZW50DQo+IGJvYXJkcy9wbGF0Zm9ybXMgZGljdGF0ZSB0aGUgdmFsdWU/DQoNCkl0J3Mg
YSBTb0MgbGV2ZWwsIHRoZSBTb0Mgc3VwcG9ydHMgc2VjdXJlIGZlYXR1cmUgd2lsbCBuZWVkIHRo
aXMNCnByb3BlcnR5Lg0KDQo+IENvdWxkIHRoaXMgY2hhbm5lbCBiZSBkZXRlcm1pbmVkIGZyb20g
dGhlIHNvYy1zcGVjaWZpYyBjb21wYXRpYmxlPw0KPiANCj4gSW4gb3RoZXIgd29yZHMsIHBsZWFz
ZSBleHBsYWluIGluIHlvdXIgY29tbWl0IG1lc3NhZ2Ugd2h5IHRoaXMNCj4gcmVxdWlyZXMNCj4g
YSBwcm9wZXJ0eSBhbmQgaXMgbm90IGRldGVjdGFibGUgZnJvbSBhbnkgZXhpc3RpbmcgbWVjaGFu
aXNtLiBGcm9tDQo+IHJlYWRpbmcgdGhpcyBJIGRvbid0IGtub3cgd2hhdCBpcyBwcmV2ZW50aW5n
IHRoZSBzZWN1cmUgbWFpbGJveA0KPiBjaGFubmVsDQo+IGZyb20gcGlja2luZyBhICJyYW5kb20i
IHVudXNlZCBjaGFubmVsLg0KDQpUaGUgc2VjdXJlIGNoYW5uZWwgY291bGQgYmUgZGVkaWNhdGVk
IGZyb20gdGhlIHNvYy1zcGVjaWZpYyBjb21wYXRpYmxlLA0KYnV0IHRoZSBldmVudCBJRCBjb3Vs
ZG4ndC4NCg0KVGhlIHNhbWUgZXZlbnQgc2lnbmFsIGNvcnJlc3BvbmRpbmcgZXZlbnQgSUQgbWF5
IGNoYW5nZXMgaW4gZGlmZmVyZW50DQpTb0MuDQpFLmcuDQpUaGUgSFcgZXZlbnQgc2lnbmFsIGZv
ciBDTURRX0VWRU5UX1ZETzBfTVVURVhfU1RSRUFNX0RPTkVfMCBpcw0KY29ycmVzcG9uZGluZyB0
byBHQ0UgZXZlbnQgSUQ6IDU3NCBpbiBNVDgxODgsIGJ1dCBpdCdzIGNvcnJlc3BvbmRpbmcgdG8N
CmV2ZW50SUQ6IDU5NyBpbiBNVDgxOTUuDQoNCkkgY2FuIHRha2UgYW55IG9mIHRoZSAidW51c2Vk
IiBtYWlsYm94IGNoYW5uZWwgZm9yIHRoZSBzZWN1cmUgaXJxDQpoYW5kbGVyLiBCdXQgd2l0aG91
dCB0aGUgcHJvcGVydHkgbWVkaWF0ZWssZ2NlLWV2ZW50cywgdGhlIHNlY3VyZQ0KY2hhbm5lbCBt
aWdodCBub3Qga25vdyB3aGF0IGV2ZW50IElEIHRvIHdhaXQgZm9yLg0KDQpSZWdhcmRzLA0KSmFz
b24tSkguTGluDQo+IA0KPiBUaGFua3MsDQo+IENvbm9yLg0KPiANCj4gPiBbMV0gY21kcV9zZWNf
aXJxX25vdGlmeV9zdGFydCgpIGlzIHdoZXJlIHRoZSBHQ0UgdGhyZWFkIGlzDQo+ID4gcmVxdWVz
dGVkIHRvDQo+ID4gcHJlcGFyZSBhIGxvb3BpbmcgaW5zdHJ1Y3Rpb24gc2V0IHRvIHdhaXQgZm9y
IHRoZSBnY2UtZXZlbnQuDQo+ID4gLSANCj4gPiANCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIzMTIyMjA0NTIyOC4yNzgyNi05LWph
c29uLWpoLmxpbkBtZWRpYXRlay5jb20vDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBKYXNvbi1K
SC5MaW4NCj4gPiANCj4gPiA+IENoZWVycywNCj4gPiA+IENvbm9yLg0KPiA+ID4gDQo+ID4gPiA+
IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRp
YXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWFpbGJveC9tZWRpYXRlayxnY2UtbWFpbGJveC55YW1sICAgfA0KPiA+ID4gPiA2DQo+ID4gPiA+
ICsrKystLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxnY2UtDQo+ID4gPiA+
IG1haWxib3gueWFtbA0KPiA+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tYWlsYm94L21lZGlhdGVrLGdjZS0NCj4gPiA+ID4gbWFpbGJveC55YW1sDQo+ID4gPiA+IGlu
ZGV4IGNlZjlkNzYwMTM5OC4uNzI4ZGM5MzExN2E2IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxnY2UtDQo+ID4g
PiA+IG1haWxib3gueWFtbA0KPiA+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxnY2UtDQo+ID4gPiA+IG1haWxib3gueWFtbA0KPiA+
ID4gPiBAQCAtNCw3ICs0LDcgQEANCj4gPiA+ID4gICRpZDogDQo+ID4gPiA+IA0KaHR0cDovL2Rl
dmljZXRyZWUub3JnL3NjaGVtYXMvbWFpbGJveC9tZWRpYXRlayxnY2UtbWFpbGJveC55YW1sIw0K
PiA+ID4gPiAgJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3Jl
LnlhbWwjDQo+ID4gPiA+ICANCj4gPiA+ID4gLXRpdGxlOiBNZWRpYXRlayBHbG9iYWwgQ29tbWFu
ZCBFbmdpbmUgTWFpbGJveA0KPiA+ID4gPiArdGl0bGU6IE1lZGlhVGVrIEdsb2JhbCBDb21tYW5k
IEVuZ2luZSBNYWlsYm94IFByb3ZpZGVyDQo+ID4gPiA+ICANCj4gPiA+ID4gIG1haW50YWluZXJz
Og0KPiA+ID4gPiAgICAtIEhvdWxvbmcgV2VpIDxob3Vsb25nLndlaUBtZWRpYXRlay5jb20+DQo+
ID4gPiA+IEBAIC01Nyw2ICs1Nyw4IEBAIHJlcXVpcmVkOg0KPiA+ID4gPiAgICAtIGNsb2Nrcw0K
PiA+ID4gPiAgDQo+ID4gPiA+ICBhbGxPZjoNCj4gPiA+ID4gKyAgLSAkcmVmOiBtZWRpYXRlayxn
Y2UtcHJvcHMueWFtbA0KPiA+ID4gPiArDQo+ID4gPiA+ICAgIC0gaWY6DQo+ID4gPiA+ICAgICAg
ICBub3Q6DQo+ID4gPiA+ICAgICAgICAgIHByb3BlcnRpZXM6DQo+ID4gPiA+IEBAIC02Nyw3ICs2
OSw3IEBAIGFsbE9mOg0KPiA+ID4gPiAgICAgICAgcmVxdWlyZWQ6DQo+ID4gPiA+ICAgICAgICAg
IC0gY2xvY2stbmFtZXMNCj4gPiA+ID4gIA0KPiA+ID4gPiAtYWRkaXRpb25hbFByb3BlcnRpZXM6
IGZhbHNlDQo+ID4gPiA+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gPiA+ICAN
Cj4gPiA+ID4gIGV4YW1wbGVzOg0KPiA+ID4gPiAgICAtIHwNCj4gPiA+ID4gLS0gDQo+ID4gPiA+
IDIuMTguMA0KPiA+ID4gPiANCg==

