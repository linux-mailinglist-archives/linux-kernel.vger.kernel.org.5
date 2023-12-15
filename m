Return-Path: <linux-kernel+bounces-502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F20081420B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9366D1C2152E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701FA107B4;
	Fri, 15 Dec 2023 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qffuRMvz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="uDWm1wGL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E2610788;
	Fri, 15 Dec 2023 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 827b7e229b1711eea5db2bebc7c28f94-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Y5JJBjAWAyfY3QIjQH9ebAJ3kKGYpn46ngYGJ2lyEF4=;
	b=qffuRMvzU4YxqC/TBDfJkH9SysCY68ZFFC+CbtIVwq2VHSG0bYMxJSn/1Csu/vuRrPnLTSg7/S9UhVEFCKjxlTs6cHcH0R0M+EXRAYnatPoNxGS+JPWFyvgMOuXKHrcwfOu1lsiql+KIi9gIxD74f2vJjaweWYlRn7y0QLIeZLE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:62294fb2-82c6-4888-9757-428792466799,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:0f5f3b61-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 827b7e229b1711eea5db2bebc7c28f94-20231215
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <peter.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 706835168; Fri, 15 Dec 2023 14:59:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 14:59:35 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 14:59:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuLDbHJNr7yCAXCV/3FOJPkbYrt5DGC+jdLxuqLjIB2fzC3UcSJSEqHwaqRl1A2ahS8lcCMyBfFmMu7Fme9j6Dfr8urhwxuIIqwcMtZSNhhyUspf6G7L7uW2XV1txVcxhRBjbLTPzHEC6NwELINCiCpycOylrc4i5H4SlQuC/AFs/wh8KkSEjJ7SSG9zJw9GlYcGemsPGShd97KvcIZYFjzRaF0HE748Fid9zrEAr1xwz0hG9L18+cPw8a5F8KEYyspy9DjYEyVgizGmlz9i1L+NZsPMtr3baB/dZ1Y+wrFma9SvFOce74FDpNL85zWyrsjfSjw3m3P82fcSvxTBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5JJBjAWAyfY3QIjQH9ebAJ3kKGYpn46ngYGJ2lyEF4=;
 b=cmXIwCHj7Syj3d4BTCvjVjNtiJ0RuI6QyryizVdDU77rZxj7qwwRAOw75l9Qdl9SHvPHLedl8at54gx0LhBajajQ2BEJKOXzk6ERLyRhIrPinttLpKz04YuaUwGT8C+cBwza3bc/QbVa9rWkUwyzXXECLzvMXp5ZVjgizpSbdUfV7kLHRA0S1Z6NdBTpch9Y1wxbtVDFn9ZbiFd5N+4FxrtjzermJHztTYAKSQTSu2FpdRmQPVnqga5T1W/1aKzjdyqEYDVZNw3Q4PeUhDJTJUQSU1f2RWcCmG+sQHq3oTZOMYIWAek+F4Sxof8nm0Yw+X8SwWYHzjSYSUCAa5b54w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5JJBjAWAyfY3QIjQH9ebAJ3kKGYpn46ngYGJ2lyEF4=;
 b=uDWm1wGL+JS0XDueXC05veoaZJofOMcP38lttZ5NyBh7Xqb6ojdrg8lgN6rnFhhA5iaHwNPoCGCgYq9IJVWfuZflzRqW4DO6Tqtt8pFHbI//+iyePK1GHE6JwJPHiKqVQNNtK4MFPO32kldc1rBhliI6KIL7pH+mehIM+vIJiGs=
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6)
 by JH0PR03MB8951.apcprd03.prod.outlook.com (2603:1096:990:7a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 06:59:32 +0000
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::4cdf:58fb:79dd:4b7f]) by PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::4cdf:58fb:79dd:4b7f%4]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 06:59:31 +0000
From: =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "jejb@linux.ibm.com"
	<jejb@linux.ibm.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "quic_mnaresh@quicinc.com"
	<quic_mnaresh@quicinc.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>, "avri.altman@wdc.com"
	<avri.altman@wdc.com>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>, "chu.stanley@gmail.com"
	<chu.stanley@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "quic_cang@quicinc.com"
	<quic_cang@quicinc.com>
Subject: Re: [PATCH V5 2/2] ufs: ufs-mediatek: Migrate to UFSHCD generic CPU
 latency PM QoS support
Thread-Topic: [PATCH V5 2/2] ufs: ufs-mediatek: Migrate to UFSHCD generic CPU
 latency PM QoS support
Thread-Index: AQHaLcIyClbhbxWrEEOr0C6WzGnymLCp7PsA
Date: Fri, 15 Dec 2023 06:59:31 +0000
Message-ID: <f9085437f5ac76ef796f212e377b53da337d4213.camel@mediatek.com>
References: <20231213124353.16407-1-quic_mnaresh@quicinc.com>
	 <20231213124353.16407-3-quic_mnaresh@quicinc.com>
In-Reply-To: <20231213124353.16407-3-quic_mnaresh@quicinc.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5605:EE_|JH0PR03MB8951:EE_
x-ms-office365-filtering-correlation-id: 44074096-cdfe-4f92-d488-08dbfd3b6380
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VHBhkRdV8biPP9tXk6gfKeRO00e65dPYLP52y7xXW5wRmsXNTVrjurpP8rmseFsGuyuDbXgp/TQ5+99C3F0MmEO5aSGyMMS4x22YqqLM5H0Bhvhgd8suD+wXERpGAAkLCUWzmTHPgNtE62FWEMp0XOAubr7qJQ4iDKlXwatQIFVAaw3bnuUWYyRjfNCuPQveY/5gdk0PkYKMEt0656lOsVZWJ3X9zKLt+ydJXPKUNJJUJqy/3j5+8NiMW+nU2NIWlrE6m1HZqOZBTMLBVwTMeLH1AGHK5Lc7RGZngr+l9UpnHdJJHxl6z6qmUYycMFgWl+Wd7TIDd6Dv4UtXZCRpFtiS4crI8EnSWoWoa8MvJz2QVpd9ghUdE7DCou4zspG86Xvyq6J1+kQ0e6XJRzgtje7QHLubRYbxtIvRkHHV5w9/DxqEP3+nKQJYe9VSFdLbsrxDC6eDT3Amvc1MuomEySROZprE+8WyPLQZmE6vN6sYRZBZFMlW8RavnbTduFhHW/GFCB1f4pYMIouUy5AETbIFTm7lxSD93BMtc2eUx3q2XwK4WAWlruGvfyxkVT+4sZNIKqxCpvnp0L/aKG3RaZRxMu+nbYWT9xrCzZ7YKOu2HvuQ12oH36RD8/LiC5NkNbjwO5YJ6s6s/rwf4J+5HjGInHLshmlNWSoy3ap8e3iHQQ5Q/lVcR/mPUOthMqlyh9d9EFHMSvTjam9zBU5mzNcNVF8T+4A1VQxdQ3lS+ebXNG0T0YFPHwg0ddRqGb7/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5605.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(4326008)(8936002)(122000001)(2906002)(4001150100001)(110136005)(83380400001)(316002)(36756003)(8676002)(85182001)(5660300002)(7416002)(38070700009)(26005)(41300700001)(478600001)(6512007)(71200400001)(2616005)(4744005)(6486002)(6506007)(54906003)(91956017)(64756008)(66476007)(66556008)(66446008)(66946007)(76116006)(86362001)(41533002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW9BcFVOTEVVZWtQd2trd0pSMjZlM21CdU1adFNsM0lKVHFBbS9XWXFidTc0?=
 =?utf-8?B?M3o5aGtiQlhacGNUYkVsYzA5K2RhYXNXR2RNc3NOV2poMlFLOVdDYy9ENU1L?=
 =?utf-8?B?bUU3TE9tbVF0ZlVGeUpPY2ExdmlsQzRPaEJwTzh5L1VyL2xJSWw3MDE1SHUx?=
 =?utf-8?B?b1hkVElOSE5PejQwNkVlalluc0VaOFV2M0dsRElqdUVuTzRZYTYrcHphdW9V?=
 =?utf-8?B?SndGbFh3Y2Z1NGJDQ0FuMUZmbHR6d2FNczRqQVYxcDRkUmk2emlabHBJSGEr?=
 =?utf-8?B?ek85Y2tEYmNQVisxM2ZFd1Y0bFRBMC9VRjdUbENOdm9TVWNLb1hlVDBadlk0?=
 =?utf-8?B?ekhaTGdYTTJ5NSszamxYdVh3YXhzZDV2eWpoWTJlRXI5ckRFb1FEelFEWXZQ?=
 =?utf-8?B?c3RFc3lqRUV3cHZFWXpRYzkyMWsrNmMzODF2S0RaUXhoOFpEa09LbVJsbFVN?=
 =?utf-8?B?L1Y1YzJrdGo0TXJpVVBWM1IwcE8xQVM2YnU1SW1VQ3lQZXF0am4wN1hoSFJL?=
 =?utf-8?B?VTg0YVhRSDNNa2JBL3dVR3pxelJGUEYxUVNhOVd3bFNQZ2RvUDRjK0lPRDA4?=
 =?utf-8?B?azBnYVY5aVIrN2ttaXdxL1ppanM0aElNWStueVdUcC9iNHg3eWtsSGZZRHdV?=
 =?utf-8?B?ZGJLbURRemYwYTU0bFBTMVRBR2o2TjNRMGxaeGRSQUovLy92R1R0SUxjUFhK?=
 =?utf-8?B?Z0pCSE80Z1NGYmJyVHdPSlJYMDVSYUptOS91eHJhOEI3M3JCRGl5VG1tU1oy?=
 =?utf-8?B?ZVJSK2FxR05CY1VNVUpzbFJwZ0JwTTJrbGJnN0JiY3BMT2MxVWVnWHlQWk5Q?=
 =?utf-8?B?SENqeVQwR0RQc1Z0QUlxZHhoZUVyTE1UdlRwTDQ3MjA4dm9TOWVhci9jbkNJ?=
 =?utf-8?B?U2tyN1NUV1hRbEU2Q3VveG5Uc2tyTkNITXR0ZlRlNGpwVU9KRHRuYzVaVEdQ?=
 =?utf-8?B?WUZ4UUd1Sk4wNWNCUzNzUytZUXpkTVVoQ1lyQ055UERkTHBMSHpOYjFkbWE1?=
 =?utf-8?B?dVhpbHBoRStXS3lDalcxdzBsbE9HZ2hqNmxucnprRDhLdGlyczh1MXhXbGYx?=
 =?utf-8?B?VU5GWVUzRGtMUkx0Y2JOeHhTSDMwTVVIc1BUcGw3Q0dqajlyYjNlNWhTRDlt?=
 =?utf-8?B?SUhnZExQeFNWVWtjcGZXOG9BWkdpUE5YYk54ZnFQYVRja1lERUQ3OEhZYWpD?=
 =?utf-8?B?ajdPUUQzVXZ2RHlQRlVXT0lBcG84RXZYa3hwVkNqbGp2UWIxcGNHc3VqRERM?=
 =?utf-8?B?eDVJL2xsS1c5SVFSS0dWeW56cFhhYnBNWFFmdnhZSkVWRE9WeG1LNmpOK1kw?=
 =?utf-8?B?R0k0L1hmVDBkOW91Mm81aGZtWVpLajdCT2NNa0Z6S2dUakxoVEZ6ZHJJUXpJ?=
 =?utf-8?B?UFZNRkdiZ0s2K0VXckVJbXluOFcrN2dXWmVCZnA5bzVEVHgxVmlTMU95bjZE?=
 =?utf-8?B?WkIwTjBaSWdJNmlHd29pbWdKdmNVN2VtalZIWnZPb3NUUG5RTklidVljWDNl?=
 =?utf-8?B?MVA0NzAwaEtxYThyeGkvQm44UTZ2N05DZ0d3Ynh4TXk0VFBOVVhob3d5cU9U?=
 =?utf-8?B?KzVXaEFwbllLMmxETXFqdGI0bmxNN0RLcmZSTy84clFhaU5QemEwanBhMGhQ?=
 =?utf-8?B?MjBnNnEzQ1NDbzJuSWtpYUs2d1JkZHFlK3B2R2RXZHo2OEFlUUhtOFhsU24z?=
 =?utf-8?B?dDVHZldYWFM0Y1pUYTRuVWRFMVljS1Fpc1RscWUxSFlTbFpqL29xT3poa2w5?=
 =?utf-8?B?Q2haWkg5eXJ6N3NtSk5jdmoyWUdUNEhmelVvU1I4WlVKQys0R0JxL0xxOVlp?=
 =?utf-8?B?clEwTEhXTjFwbVUwekp1czFnOXZjMVdhRzhaZ0ZkWUE1cUdCM3FXT3lFZkVB?=
 =?utf-8?B?L1E5TGpveWNhS3h0L0lubmtPQlloYXQ0MkxaUE9URTVyTkl3K2ZSYWJOWGxM?=
 =?utf-8?B?KzJKYUthTXc5cHgrbkttSzFQWlllU3JjREJLaDZ3NDk0d01FWHEvWXRRcm9v?=
 =?utf-8?B?UUFzcDV3SklqNzd3VHJFaXJ0T0pQaG5JQzY0cTJlYUJkQU5GOXgvQi9malpw?=
 =?utf-8?B?NUw3WHJGQlZDUkNhLzM4bmUyajgrclc0WlcyZ1hFczdnU0ZNSTlYSkZRbXY1?=
 =?utf-8?B?ZmZtMkR4Z3pOQUtRQjd2QW1YWm5RM1d5MWt2TWJ5cCtTUGU1S2ZYdlV5ZDBN?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E28411104D04254B9AA3179CD7E1C502@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5605.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44074096-cdfe-4f92-d488-08dbfd3b6380
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 06:59:31.7116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVd8tV9IGN30ZvHsDAAmMKYFB0UGR+1IUOFu6ypwdyrsvFEGxdcaiM5qF71jFNICnr+s0QrI0xA+AsOa5RzhOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8951
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.908500-8.000000
X-TMASE-MatchedRID: h20DFeLkM8/UL3YCMmnG4mpvRxhlGy+njLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2hCecAVGCOf1MjQ19j30wyZDZNsgKQU52M1e
	p6kdhO8J55MrUBR+0shvmHdgIY5hMlwV2iaAfSWfSBVVc2BozSlQshXUqyD333ZzbDar2Qzzakj
	6FuUTADwtuKBGekqUpbGVEmIfjf3uJEQG/YtIOYlTXVlThgP0q7lYqB9ofMmok3MKCXh+iF0B81
	AUqavHP
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.908500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	AE1C0613A942B27D74A3386900B1340A8E51742AA8AAFDDCE6261FA80CB0F7602000:8
X-MTK: N

T24gV2VkLCAyMDIzLTEyLTEzIGF0IDE4OjEzICswNTMwLCBNYXJhbWFpbmEgTmFyZXNoIHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gIFRoZSBQTSBRb1MgZmVhdHVyZSBmb3VuZCBpbiB0aGUgTWVkaWFU
ZWsgVUZTIGRyaXZlciB3YXMgbW92ZWQgdG8gdGhlDQo+IFVGU0hDRA0KPiBjb3JlLiBIZW5jZSBy
ZW1vdmUgaXQgZnJvbSBNZWRpYVRlayBVRlMgZHJpdmVyIGFzIGl0IGlzIHJlZHVuZGFudA0KPiBu
b3cuDQo+IA0KPiANCg0KUmV2aWV3ZWQtYnk6IFBldGVyIFdhbmcgPHBldGVyLndhbmdAbWVkaWF0
ZWsuY29tPg0KDQo=

