Return-Path: <linux-kernel+bounces-381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF6381403F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D965A2846B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657F2CA67;
	Fri, 15 Dec 2023 02:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bgdFrQS+";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="iQCZecoc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7072C8BF0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cb6deeee9af411eea5db2bebc7c28f94-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tPLMCK/Mo+Icdzv0PqjjhT9m7FIJC1ibfzMpPoDjz7A=;
	b=bgdFrQS+uN90XEwLjXFU/Zvc6RdAEB+qzDmXCYBiEDhzrNqicrS4lSb8RUNIMJ0A79nih5PgAHXKLQfnHSKWeVeCT/5sWh9pxXCXxHSPOR3B6sQf4LJeav4lTFP5X3amC/3H02mbL9Sf1Jpha4BavqWLEZ/uG12i2wCj+5mtVMw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:eeacb7b3-e75b-4d20-9273-98ebb9ffb706,IP:0,U
	RL:0,TC:0,Content:5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:5d391d7,CLOUDID:b5ffcf73-1bd3-4f48-b671-ada88705968c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: cb6deeee9af411eea5db2bebc7c28f94-20231215
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1426195305; Fri, 15 Dec 2023 10:51:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 10:51:05 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 10:51:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK4PRBZYtnB62Ln9ocQ9EvmTWJJ7ppaQnyOejak542ttUPYCVBb+0v2Rdvq5Q1o6m9jHllqgONDNffRZqd+iuE+givT4Gwr+flWywaQeTt8dSLkHbd4Z4dT+/Oi6KBfnfqBoKWmkdE70e4aBaS0wfGtbSds+FOXF7nA0xTOReMsejDyul1dsUFpFZhWFFoYUs8ySCMzd+HpC8AISXU9wkpeg3j6TnLIhAR3yk8x40WuYXeDInC2RS9wTFxlJ5XWXmEUgBgGzSVJjggiPIUqOfbgXd0ylZNxfbCXwxDj8qu9NTgUtpgHFhtswyqIhWOmL718X3S+3HzT7rwC9QFraaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPLMCK/Mo+Icdzv0PqjjhT9m7FIJC1ibfzMpPoDjz7A=;
 b=mYw9tup+ZwLu3heYLTwbJiEpUeIqsL602dU8Agpj2ldOjLUxLp5SECUmDTXft6KhH0/fOhRV8YPo4EDF2y5t2+A3KuwLgichUfY3m9TWkbZxpIIrZh6lUzpW9PW5+aw0+mL9lUf2bRfOZMcKj1vsXSG9C58BeT+Mt3/SAQRDFGjaecyNoo/iLP1l6n9H5sWCVpm9AfuFKsKJftsetRtYgUBb7fJ0O/54op5KR2LHj5zYFq/o1/6D7AeKrwFB0olUvCmgzfjerxL/mJrn3HSznbVT6jbfxv7wvprewI7QgnCteJmKchQH/FDHYpOmjLYcXLOkJ0wqdKntsFlH2k2pwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPLMCK/Mo+Icdzv0PqjjhT9m7FIJC1ibfzMpPoDjz7A=;
 b=iQCZecocYN/gxI5qGTaGS9ChwTzadXnWiQzK5GRQjI2Qg+KWAMieHeDmLbjIZSJsD4NmzaSynyqw9FCq/Lc+CMWRg5K5oUV9cmPCVWnHEabDo2GpF8dzowW6kFf4xlWezf0pA295ANCSvZV//pZcOl8rVg8JUPeTGe9xYNqxtMg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI6PR03MB8705.apcprd03.prod.outlook.com (2603:1096:4:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 02:47:58 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7068.031; Fri, 15 Dec 2023
 02:47:58 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "jkardatzke@google.com" <jkardatzke@google.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/2] mailbox: mtk-cmdq: Sort cmdq platform data by
 compatible name
Thread-Topic: [PATCH 1/2] mailbox: mtk-cmdq: Sort cmdq platform data by
 compatible name
Thread-Index: AQHaLv+UsSvzwAFnA0SY/FevORlLCbCppDkA
Date: Fri, 15 Dec 2023 02:47:58 +0000
Message-ID: <8c66d825d771392718e4acda37ce59a438a4cea8.camel@mediatek.com>
References: <20231215023546.6594-1-jason-jh.lin@mediatek.com>
	 <20231215023546.6594-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20231215023546.6594-2-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI6PR03MB8705:EE_
x-ms-office365-filtering-correlation-id: 100f53d5-d7d6-4989-ba27-08dbfd183f70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7CZOZE2Wf0llI6unFXfPOqVwk+14iUPNk0tSlpLxoGkfPB0lr5kBC35gjnFkOPV/pf4r9ExWVZLYjDX7gGkuBPDQ2CNzChHXMNjfpADLAeqyeiRmrQm563fpqYPsatuoIJhxqdI7v1zIntRiuuunpodkZVwn5FLFvgsSHD+5To7qrMT2YaPMvx3Bm4Iawu3d2nIbncp2V+41R3M+Fgw1cCU1Ky1QuOuQukKdesnajOlrgrXCNcT8+H/KRE3d+73BzcAKmvGen26r4k+H9UNrzbAimMlU17qEYckZIwdbhMyzK4rJal4w/xBYwAfaJlD8FXhdx2IutFJ7bzjKVlJzxt8Bh6deksM+XT8AevB3poWVZxynfnVHzv+LNLBwTPqnkBDOFi3hsiluZJwUq7NLwlp8cILkhWU7Ad9ooyGpTKvq5GmOm1RfWd2mN9/vaTZ38qihQYNqmx3Lp2tZ3mRddrn3JqdVTJpE0CUC8q0+6BP/4ONVVTYO0Pa2npJtSRPl0T0AmgbJX9pTvCqpiCuuF2XsRbnIo1lVGklnlLF6ChfZajIxAdA95rlYES5DJeRL7P7bG6cjvQzvg8fk4QT1GpZ1e7zVXUvp2ZfbrTlhGlYAsw724H2bG/rjuvcV8HoXgOw5bNYfRkkAYGGuYQ7prqDK8VQ2Nun3tLh0kskEH60=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(38100700002)(6512007)(6506007)(71200400001)(83380400001)(26005)(36756003)(85182001)(478600001)(6486002)(41300700001)(64756008)(66446008)(76116006)(66556008)(66946007)(66476007)(110136005)(8676002)(8936002)(54906003)(316002)(4326008)(4001150100001)(38070700009)(86362001)(2906002)(122000001)(5660300002)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3ZGdXdVOFRXbTBsT0hFYW5pOFdVdUczTGlDV2FCczVvZTZ5MC95VDVGZDA3?=
 =?utf-8?B?TmJNdVMwVTRxdURqSjV4RkdRdEliaGZQMzBmUjkyWTA3eVYwbG4rbWhaOElM?=
 =?utf-8?B?OUtwQ0hkZzcwSlBROERZSTdLVlBNdkFWODZEcnl6M2MvUk11VThOYTNjNWp0?=
 =?utf-8?B?YnFEUkVlZ1RnNEJkblU0eUFIMGxrTXJubTlZTDdwTnd3SnhKdytLWk5KZmFH?=
 =?utf-8?B?VVhoL2d6c1Z3WUo4TzNOeEgzTUJpcUk5VTNmUGk0S3B2ZnZnL3lpTFFtTVkv?=
 =?utf-8?B?YkxFRXNIbVltbFd2N1o0eS8zNHQ4Q1I3MU9rdUJqRG5kcjZ6Zk1mWGdDZnY0?=
 =?utf-8?B?WGR1TzlvNTEvZG9Ub2RSRXE5NC9hdW9xblJQWXFvaW9RYVV2blh6cjl0T2Qv?=
 =?utf-8?B?UnIrKzRPa2ZLcUI3NFNzZEJuM1dydW5JTTEwNW02cmFVand6ZkNSbHovT3Iv?=
 =?utf-8?B?TExIN0NhTXZlWEsweWdNZHpPM0JSckVkdGlXTDVXWkplV0hDWmxESkhlUml3?=
 =?utf-8?B?MjYxWUFJYVN3c0R0YXJ0dmpxMVNpbFp5cXhxWDMrakVIYVREUXgxTUpSZ0d0?=
 =?utf-8?B?M2xwTkRuQzg4dVFpUXdKU0p6djcrWWxOMkJlckRITEZubi95dDRsUVdrWXk4?=
 =?utf-8?B?TmZRMno2bDRXc1BJak9FQkFPN1l1YUZ6b2EvUXh1ZWxVcWJZUGdTL1YzWTNF?=
 =?utf-8?B?TkZnZmNzUUFBb2wxdlE0Rm5xc1E4aEtGdDc5RzBDNk9kejkrYStvSUhKRVBQ?=
 =?utf-8?B?TUlFcnBud2tDQ3pXc0ZHRzFCTVVkVjZtZEFVMjNFTkNrVDAvdHBDREhrLzEz?=
 =?utf-8?B?b2NleFZEcTFHV2Zzdkx0T1pZQzVPM2t4WFJXRzJ4cUpOaXRmUVFsc1lYdFBw?=
 =?utf-8?B?UUVkRzZSSm5ZT0hrbkd5UjdObHMrajJkTEFSRk50SHJHUXRucnY3eVo2aTlu?=
 =?utf-8?B?d1JkZmY1b2VkQjZ0aW5mQ21tYW9wNk1CK0wzcE5ndHl6RDlyNWk5b09WT3dK?=
 =?utf-8?B?ODc5eXVOdThWZDh3WkhqNjZwTjdSTFhOcmJuWEZKZDI1aTR2UWdqbVJ3blRa?=
 =?utf-8?B?cyt3R0REVUVoMkNEZXpzM3c5SkFrbDdnTjRzdmFpSnhCZnMvTzh0T3A2ZExx?=
 =?utf-8?B?R0tiU1JkSFhaVEd5WllocXZuQ0VqSHVWRDliZm1sdzl0ZTlvbXZNcEZXY2ht?=
 =?utf-8?B?OXZza0tOTjJrYzRrUmNMeWpKNUVRVVBQVXpmci9tZ05hZkFtaGt4cEVmbHh2?=
 =?utf-8?B?UkJNU3p0VmEyMkJVYS9iU1o5MUw0U081Z0xkODF1aWUrZDFKM3d4TGpIakVL?=
 =?utf-8?B?a0xIYUhoWlFCZm5OMUdjSFdGeE1ZNmQvajJBaVZUUlFGZis1a0JxVjFWcCtN?=
 =?utf-8?B?YXpkMkNKQ0lYVzFVbTdXektGWElOUTc3UTdmbll1a2lPVXliQjhGdGRQQXBN?=
 =?utf-8?B?Sy9xMUo0SXg2QlpIaHlkdDM1U3JOVWpJb0QrdmxPRDVQYjdvWGNyc091UElJ?=
 =?utf-8?B?eEFvTERmYndGRStWM2lWYUxKNWZRak10T0dnSlVlcUJ0NmNDRFRscmZQQWhH?=
 =?utf-8?B?bjJ4b29udmEwcktVTndaNGJ6SEN5ZjJkVktnSTFyRTYyNERVTnBPeXdNc1Fm?=
 =?utf-8?B?bGxCRnVuZjJsWEw2U1JBMlVLSTdtTThQTzIxVnJtMlIrLzFFdVhrQUIzOE40?=
 =?utf-8?B?TERCWW4rMWplcWNSRStFSFZiQlFrYlBWOGYwMlpsV3dkZXZDNnVRaVo3V1dP?=
 =?utf-8?B?WXptc1pHdWE1WFFPZnVDUnczaytubkRJMU54OGF6T1J6SGNsWm1sSGJ6QklX?=
 =?utf-8?B?UytMOFo2RUVTMWxLTHJ0aFNvNG8yMGNJODNFUDFsOTdVUHYxb2xwSzJHWUF0?=
 =?utf-8?B?M3hBRmM0MHJUWXZvdlhhdXR5QW1nVjhDWXBzcnBQUWlHMEdNSkZiT1JEbTF3?=
 =?utf-8?B?V3lNS0RYZ1dKOVBWUWEzaE9RbVpyMGNpMHV2ZkhyVzVoZU8zU3orMzAzM1Zo?=
 =?utf-8?B?ZlJZRGQycUNjZXFQNG5WcGFGMGFZREdXRHU0OVphd3M1RVozK09MU2JIT2tK?=
 =?utf-8?B?dkFPZ00vSmwzbzRkTmVkQlFnaHZsL2gzWWQ1clM1cFFZZlAxWGprQnM3d3FR?=
 =?utf-8?Q?eRm+hZhXBPCyu64meNEB4vNIp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <235724D42C69E94B9C737B1F0876375D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100f53d5-d7d6-4989-ba27-08dbfd183f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 02:47:58.8036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIsup9wiFeTeiNlzBlyZHChDlyIXtTwkqRwbGMmpx9CpKJDOrX0QnPC/QWPlWoQpzOxah3bJ+Dao6OHTIydtYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB8705
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.429200-8.000000
X-TMASE-MatchedRID: u1zqiMeMcroOwH4pD14DsPHkpkyUphL9pfVcx39Kq+44YKAM3oRt9lO4
	BD7nLMxnThbvLLI8RvPxY0WGgfScA/85GCR7+GthngIgpj8eDcDBa6VG2+9jFNQdB5NUNSsi1Gc
	RAJRT6POOhzOa6g8KrTvELQuaABpSqsSh6MH090kuqwn9UtUXl6I+YmKKAJeb2z4b4vqFg8kMWS
	nYcIzUSnvWG+cFZNZtSjmsUrRQjhG+EyEJzKoXnHOWjFC52UVP9edTJzeSS9vi65ijgz6k6GCGL
	FiGs7u/iKJKI7cVvfOUTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.429200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0FDEA8EA47B0E3DD60D9FDE181D550C0A95B2BFC24054A94FACB8780727A66342000:8

T24gRnJpLCAyMDIzLTEyLTE1IGF0IDEwOjM1ICswODAwLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+
IFNvcnQgY21kcSBwbGF0Zm9ybSBkYXRhIGFjY29yZGluZyB0byB0aGUgbnVtYmVyIHNlcXVlbmNl
IG9mDQo+IGNvbXBhdGlibGUgbmFtZXMuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVk
aWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpo
LmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmMNCj4gYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IGluZGV4IGRl
ODYyZTkxMzdkNS4uNzZlNWY3NjI2MjhjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21haWxib3gv
bXRrLWNtZHEtbWFpbGJveC5jDQo+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmMNCj4gQEAgLTc1MCwxMCArNzUwLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZ2NlX3Bs
YXQgZ2NlX3BsYXRfdjcgPSB7DQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9m
X2RldmljZV9pZCBjbWRxX29mX2lkc1tdID0gew0KPiArCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDY3NzktZ2NlIiwgLmRhdGEgPSAodm9pZA0KPiAqKSZnY2VfcGxhdF92NH0sDQo+ICAJey5j
b21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My1nY2UiLCAuZGF0YSA9ICh2b2lkDQo+ICopJmdj
ZV9wbGF0X3YyfSwNCj4gIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWdjZSIsIC5k
YXRhID0gKHZvaWQNCj4gKikmZ2NlX3BsYXRfdjN9LA0KPiAgCXsuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxODYtZ2NlIiwgLmRhdGEgPSAodm9pZA0KPiAqKSZnY2VfcGxhdF92N30sDQo+IC0J
ey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OS1nY2UiLCAuZGF0YSA9ICh2b2lkDQo+ICop
JmdjZV9wbGF0X3Y0fSwNCj4gIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWdjZSIs
IC5kYXRhID0gKHZvaWQNCj4gKikmZ2NlX3BsYXRfdjV9LA0KPiAgCXsuY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxOTUtZ2NlIiwgLmRhdGEgPSAodm9pZA0KPiAqKSZnY2VfcGxhdF92Nn0sDQo+
ICAJe30NCg==

