Return-Path: <linux-kernel+bounces-24314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D5E82BAE5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380AE1C24B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01F15C8E8;
	Fri, 12 Jan 2024 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="calq4z+O";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="X/dRU5qg"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC225B5C8;
	Fri, 12 Jan 2024 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2d656384b10c11ee9e680517dc993faa-20240112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=JVsxsdgmV2RQ9I+Cl6FcfCe2KzDwchzy6sNjhrJ30HY=;
	b=calq4z+OST/ffpZ8nXPazt2ZB+MDKNQtqpfqodTg06QS6uXh5aWAIabAkfIyIu1kMiCyQPzr+Ck1NlYULQUCea1hLoia8MmKb0gRXClrW+H6Az37b4NqXUJulv9a8Pgu6xT4/sYJcStg4pdufbx5PCjhE2i/YlR7hGcyl4Ioe+k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:a12de627-6e32-4f2a-8583-eb2dd0d93cd6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:60c5c482-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2d656384b10c11ee9e680517dc993faa-20240112
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <deren.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1108538382; Fri, 12 Jan 2024 13:33:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Jan 2024 13:33:51 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Jan 2024 13:33:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chOR8pAtXElMPHwn6O1pD+Pr5cOQIA7CsRjDf/dDXT8mWEJJeWDtQ0A0eZgrrqUa8DQjia7RuM/FjX3eKPp8Og6SxklpRHP9Iws+CGHDC2hsM29jl0XbsK9YYDrYPWwUqNq04WKWCAuWOx9FQrwZXwVLaPtJI+sdu8ntKUUg3zPE5uUfbOd8MjtMzUHkslaH5DSMFw1FjIcJ1AVVj/uBmhMaGQ+AVEv1id3c1cPRRiQHpnKaPdsK3hjgvWi3cvQznTquELZSCxyGUK7fSmMturD5HJ7bwJx1eXaGlb9nsSFIEW30gTqJLWja2rs7eIXuyz8MkmR21nF7SnME6V4oZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVsxsdgmV2RQ9I+Cl6FcfCe2KzDwchzy6sNjhrJ30HY=;
 b=cX/i5y3/5KxYZStZVjiH7y9euzwvUpyE7/KfT6HMYeVUY5udtx2667U0/4plYmk4pOIB5ZaBsEbeVrvjSN4ZTgxDXKPZ048OCcv+OieV1O3U7uO7bFnXjY5V0RAF7g3wbSssXy7R6qfhwkocZ+TbTFB60rXzpjskDHQDhSFJ+hGkbIchAcwyBy3/aeAmJku5hiNSCn9EeD841wTqDefP6z6/mEhxaaFWMEjK3X1x2ls+PtaIef2VsqibvV/a9ejsOZqgD6L3YZDGcNMiKTtZwmrmNG2bBvoEL4Sk+LvmI8h+hfbagwWWhd5bNSYaOVm6X8cDX+wseWPwyvzH+Iyw2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVsxsdgmV2RQ9I+Cl6FcfCe2KzDwchzy6sNjhrJ30HY=;
 b=X/dRU5qgM3XxxzWMl8vI3zlM9dI+6HBndbz18e4afrX4bRhitRQCwLn8tJB7kUTNjRBLYo3A0FTplM8IsEx6Nuq9AvHCHDwXTE5FL/9kObrlhKLX7/jF57fzlsx/0Cm0OmhLvdfDqFpaxqsvIqgpybN9/W7QnRsYlYXo2qbNjJ0=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 TYZPR03MB8615.apcprd03.prod.outlook.com (2603:1096:405:b6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.19; Fri, 12 Jan 2024 05:33:49 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::fb6f:5270:c66b:79b7]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::fb6f:5270:c66b:79b7%6]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 05:33:48 +0000
From: =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To: "mikhail.v.gavrilov@gmail.com" <mikhail.v.gavrilov@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"nbd@nbd.name" <nbd@nbd.name>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Unloading mt7921e module cause use-after-free
Thread-Topic: [BUG] Unloading mt7921e module cause use-after-free
Thread-Index: AQHaQ9fdbKjO/QFV6E6tJMh24OlFD7DVqiSA
Date: Fri, 12 Jan 2024 05:33:48 +0000
Message-ID: <efcb591e162ff0b04a9878f7250ab6ee6907f4a4.camel@mediatek.com>
References: <CABXGCsOdvVwdLmSsC8TZ1jF0UOg_F_W3wqLECWX620PUkvNk=A@mail.gmail.com>
In-Reply-To: <CABXGCsOdvVwdLmSsC8TZ1jF0UOg_F_W3wqLECWX620PUkvNk=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|TYZPR03MB8615:EE_
x-ms-office365-filtering-correlation-id: 27b4cc20-3a4c-404b-b086-08dc13300d63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bAc6RvXwco0vUtv1WbIJD90ydhU5olmsw6ysj4Sxo93uHEvieZ7QI2RGbSRIysHIhMa3X+EHW4sC6AKJjmn69PueUcU2YmlGszezOOta51M14DrbJWneIUP80YeOV+dicyuOYhBJFwo17gg/sk++4Po6O3kO5cHt8WS+vgMfFboUds7KUXEYEnduvJx3+JvJPhkSJaYnv1uJrsFneI6BISHipAwcJX1jMSmbTboU4ijGPHQs5t0Wt7TpQHNV8wKNgbPzAMGUiYyC3xP9EQO3j/8hhMOiheNLzilzMJ3AtsUx7sz8CtOfW8FnGVmi9V54vpPhpSiKrV9aXTZjXOEbPqy7Pc2tYx4yZBiHCCYTrwiuTnb9zdIC8190weQSXZKhcftSGKabHKIr1zt3+oVJEneD2ggKPrBn4IdaMTJe7kZeeUFSHRilLxO+ulVckS3Xcz6R/2Mrok/3VRcrOw8yHpPYH001Jp0RQdR4NUYFnn1vJi/Qb1/0SdX0of4FpbjqK6YJT1OysuL8YfQo6MWzXxjLkrk2KnutJwCQgBLHr5Lgp0I9GEjEVxiAKRISKv8eCExde21CpUZ2bU/+P9uTiWLbinGc6LgDU/znzY4W2qUwgTipqybEDGJ8NorATTkK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(71200400001)(478600001)(6512007)(6506007)(2616005)(26005)(122000001)(38070700009)(38100700002)(86362001)(5660300002)(85182001)(36756003)(76116006)(83380400001)(2906002)(91956017)(8676002)(8936002)(110136005)(66476007)(66946007)(6486002)(66556008)(66446008)(64756008)(316002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0tOUzhnRXE2SjBFTEtSSUFxVGVQSkExdjFUK0hZdDdXdXgycyt4WGMxUGVE?=
 =?utf-8?B?VUI2ZitwNmpyamRZMjk1TnhEL1IweG56SlVqVUpOdXErcjNhSitFYzRsZSsz?=
 =?utf-8?B?WFBMWTJ1MFVGbXhQNzJCZ1hvRjMvbTdXTjdyUEhDQnBoOGtHODVCT3E3WEtu?=
 =?utf-8?B?VnluZ1RNK0dRNEM0bGszUHN6ZC9hOEg1VjdXbzJiR1hxbHJjbDBsTDNRTytk?=
 =?utf-8?B?Mktoc0hCaENRNG1QQzlmQTBmN0hCSjNpUjJDbnhBTUNkS2FBNHZOdkZITzZU?=
 =?utf-8?B?TXFRYXpPVFFlbXNrZ1FpU3YyMFlZQmdwdmYyeHFjcGhITVBHeTliVmF0cDlZ?=
 =?utf-8?B?SjNQTmJ5U3cwYTJIVFJwZ2lLZHd6d09PM3RoQ2RLUkZtNWRocmlKY1oyUWpU?=
 =?utf-8?B?U25KeGFUSWNuR3dRdytidE1lZSs1eTlhL2QxWG5RL3VQd1JDd2xQVUloZ0ZP?=
 =?utf-8?B?b0JyRksrUDVLM2g2bllraStqb2hyeVNiN0l6cGJGM3lIVHM4dWsraFVHTS9J?=
 =?utf-8?B?dTdHTHBpa3Z0NkYxZ0s4YzhlVGsrL2g1MEdLSll0NzRzNW1ObUZGVmVXeUIx?=
 =?utf-8?B?L0YrcjRpRDlHWnZIQ2JGWnN1a2p0eDFuWW0vVzF3cGVja1QyRFB0cnVTTkVH?=
 =?utf-8?B?bURFRTh1ZkxPdENkT3lnN1NpM2N4ZkRqeUFZekJYWStyMjBDODRobHBxcnlp?=
 =?utf-8?B?M1N2MkVJbTVWV3RETFE3RVI0dTJkVEwrd0MyZVBnVlVaWG9sQWNjVm9TVU03?=
 =?utf-8?B?ZGN5NnRUK0cxdEE4d25NaytURW1GdlJQS0lGazVwOExqQWV2YjRjUko4WmVZ?=
 =?utf-8?B?bmtURUtmNkJOaEMwdTUrNWV4b0tPZ3Nua3hEVFZ5Qi9QOGMzNExCQ0N4QktJ?=
 =?utf-8?B?ZDlObjFSdXMxRmc5MjVQcmpiUVJwaHlRWDFEWGJhaGxYeVEyYXA4Qk04a2JW?=
 =?utf-8?B?Q1U1ZU1sMDJPZVl1dkRUYjJ3RzQ5OHZ4NjkvdmdJMmVJeWZwbVRQR2JXYlo0?=
 =?utf-8?B?d2R6ckZ5YzFvdU5UNHBlbWZ4MkdhTU8wUDVBTm1ZdFVhdzNlbTRkMkg0Tyti?=
 =?utf-8?B?V2Y3aVJCSUcyOUxvejVzN1I1cVVIRHpWcXNTN1pQbmN0QmNxT1paRy9mQjJm?=
 =?utf-8?B?RFdwWE13ZVg0V3RWNm5WdlV0djJ0ZHVpZ2NvRVhhWDNDMElwS2ZsM3Z0eHFQ?=
 =?utf-8?B?WHh3S3NHcHhiT2YzMXlnREsvekhlZDgrVG52VTJDVFJTc2lUczJUM2pvU2tm?=
 =?utf-8?B?ZFg2QkNERGdmSVBuc0Nxb0NMd2pmS1NHMXY3amcxNTJIMWZQc2Zjc0psWUVD?=
 =?utf-8?B?VGpqSWhUaVZ1Q0k2akx0dyt3c2RqRnE5R1ZPNGxjL1pWTjdtOFRQZGFYWGIr?=
 =?utf-8?B?S1BoQzIzd0dsL0wzbWdTOXlxUXdlU2I2b2VTSWVya0tZZjBLMjN6RlA5S0Rp?=
 =?utf-8?B?SkM5bklXbXl4dXRaRk0rREJYTW9SYkdzdkFpNmpWb3BNZXFBM0NySFE3cG53?=
 =?utf-8?B?SUQ5cHIrSWZ0OTdCMEVtc2NtakNrajYwR3kvTHdIc3ZZSmt2N1BVRHNFNXhO?=
 =?utf-8?B?K1VYSnR4clJyWEN2TE1SdTVBSUQ0YkhxMmp2Wi8yWnNqWk9VcEJXcm5rV2Jz?=
 =?utf-8?B?SnJJT1lDdlYzZy9lcTVRMUF3c3hEVkYzK0R1SWsrOHhXZUJhNlZMbU9VZzRB?=
 =?utf-8?B?cVVBVnB3YWNqVFBvT00vVXF5WFJuWFp5eEcxZkpoTE93S0VYOTNZeTJrOHMw?=
 =?utf-8?B?Z0ZJSFF0VVg0cmJyV3kwZVhXZ1loWnU3T0JTdjhNZklUUDBFUE9WV21iUWYw?=
 =?utf-8?B?Q2lhdG9IMysxdnF2M3FMTHFIRE1HSUZPajU5ZjZSVUZYamJ5ZitoMU9IMy9p?=
 =?utf-8?B?aHlMUWFkbzB1bjZjQ2orMzlFWEFndHRQa05qZ2RQYkRRdDNHK2hFZFRxdGtB?=
 =?utf-8?B?QUJncWN5bUJXeUtxeGhiSGlMNUY5aTRSMUw4dkltY1YyejJ5RjVaMGV2NjY1?=
 =?utf-8?B?NmdTQk50emE2cVprc0lUS29laVV4RnNLcVlTNXVPUGhoekM1YWo5UmRjZlFT?=
 =?utf-8?B?cEtIYm5OdDZIZk1XZmFrd1FqQ0Z3TjJFaVlXRjgrSjQya1gydDlxd2FOTyt2?=
 =?utf-8?B?S3NaM2NNcXl3OGZlc2Z6eGxOdHJYaGVYNU44WkV5SldwWlNOSGhpTjVSbjNt?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F81121477260849ADCFD9630518DF27@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b4cc20-3a4c-404b-b086-08dc13300d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 05:33:48.3553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UEE4Pmgm1h5y2oLdqXu1cocSZMWZJMZT57zFXknffo6kbgTuHQiaLrZNywMe4HwYX2oUsMN0HxPXt8uEbeKpgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8615
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.047000-8.000000
X-TMASE-MatchedRID: dc8Jy61QoRrUL3YCMmnG4v01ZuXoOacdEhHgAtjqBckNcckEPxfz2Iu3
	renu5Y0weAndNL4zv3R0vq5iD4SHzNB/8y3gYF9vAoNa2r+Edw3Mqev3OPqHcaHP/60e74NCalh
	t3nY7gKt6wp2o0sVM4mRdaS26EKBCEd0YyW6tLbm+dJWHbg4ITg2aa5XTqpYWh8BhJvgqWBk1It
	q0yDsRhi5ceACvvcftJsoDhNVKtSopz7oBrDd6eQPZZctd3P4BXcpmQXLhhkSHlDUCu0I+XNqP3
	/FJpX5vcpxEzdYScViRk6XtYogiatLvsKjhs0ldRjjVhf+j/wpKdDgyPBo71yq2rl3dzGQ19+9Z
	qEp9FTg23+jUaFj78lqI5url27E5K2kVdirYdnfSCeg0qIBLTwHsX0ES9qSzMvaSkL8lcbjdA4x
	Y01cYAwxee+piOTT1S9WCdh5u3VkVsGYRo/D4y/p5zpVeeXvdZuS/RYmMlBOzVpyb4QzyoZ6oP1
	a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.047000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A4935A3AE8F7348D3105D0D08862E1C829837271568447AC5473B7A862EC93332000:8

T24gV2VkLCAyMDI0LTAxLTEwIGF0IDIwOjE1ICswNTAwLCBNaWtoYWlsIEdhdnJpbG92IHdyb3Rl
Og0KPiAgCSANCj4gIEdyZWV0aW5ncywNCj4gRm9yIGJ1ZyByZXByb2R1Y3Rpb24ganVzdCB0eXBl
Og0KPiAjIHJtbW9kIG10NzkyMWUNCj4gDQo+IEJhY2t0cmFjZToNCj4gQlVHOiBLQVNBTjogdXNl
LWFmdGVyLWZyZWUgaW4NCj4gdGFza2xldF9hY3Rpb25fY29tbW9uLmlzcmEuMCsweDZhNC8weDdh
MA0KPiBSZWFkIG9mIHNpemUgOCBhdCBhZGRyIGZmZmY4ODgxNDY4MDY3NDggYnkgdGFzayBrc29m
dGlycWQvNS80OA0KPiBDUFU6IDUgUElEOiA0OCBDb21tOiBrc29mdGlycWQvNSBUYWludGVkOiBH
ICAgICAgICBXICAgIEwgICAgLS0tLS0tLQ0KPiAtLS0gIDYuOC4wLTAucmMwLjIwMjQwMTA5Z2l0
OWY4NDEzYzRhNjZmLjEuZmM0MC54ODZfNjQrZGVidWcgIzENCj4gSGFyZHdhcmUgbmFtZTogTWlj
cm8tU3RhciBJbnRlcm5hdGlvbmFsIENvLiwgTHRkLiBNUy03RDczL01QRyBCNjUwSQ0KPiBFREdF
IFdJRkkgKE1TLTdENzMpLCBCSU9TIDEuODEgMDEvMDUvMjAyNA0KPiBDYWxsIFRyYWNlOg0KPiAg
PFRBU0s+DQo+ICBkdW1wX3N0YWNrX2x2bCsweDc2LzB4ZDANCj4gIHByaW50X3JlcG9ydCsweGNm
LzB4NjcwDQo+ICA/IHRhc2tsZXRfYWN0aW9uX2NvbW1vbi5pc3JhLjArMHg2YTQvMHg3YTANCj4g
IGthc2FuX3JlcG9ydCsweGE2LzB4ZTANCj4gID8gdGFza2xldF9hY3Rpb25fY29tbW9uLmlzcmEu
MCsweDZhNC8weDdhMA0KPiAgdGFza2xldF9hY3Rpb25fY29tbW9uLmlzcmEuMCsweDZhNC8weDdh
MA0KPiAgX19kb19zb2Z0aXJxKzB4MjE1LzB4OGI5DQo+ICA/IF9fcGZ4X19fZG9fc29mdGlycSsw
eDEwLzB4MTANCj4gID8gcnVuX2tzb2Z0aXJxZCsweDczLzB4ODANCj4gID8gX19wZnhfcnVuX2tz
b2Z0aXJxZCsweDEwLzB4MTANCj4gIHJ1bl9rc29mdGlycWQrMHg0Yi8weDgwDQo+ICBzbXBib290
X3RocmVhZF9mbisweDU2ZC8weDkwMA0KPiAgPyBfX2t0aHJlYWRfcGFya21lKzB4YmQvMHgxZjAN
Cj4gID8gX19wZnhfc21wYm9vdF90aHJlYWRfZm4rMHgxMC8weDEwDQo+ICBrdGhyZWFkKzB4MmYy
LzB4M2QwDQo+ICA/IF9yYXdfc3Bpbl91bmxvY2tfaXJxKzB4MjgvMHg2MA0KPiAgPyBfX3BmeF9r
dGhyZWFkKzB4MTAvMHgxMA0KPiAgcmV0X2Zyb21fZm9yaysweDMxLzB4NzANCj4gID8gX19wZnhf
a3RocmVhZCsweDEwLzB4MTANCj4gIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWIvMHgzMA0KPiAgPC9U
QVNLPg0KPiANCg0KSGkgTWlraGFpbCwNCg0KSSBjYW4gcmVwcm9kdWNlIGEgc2ltaWxhciBwcm9i
bGVtIHdoZW4gQ09ORklfREVCVUdfU0hJUlEgaXMgZW5hYmxlZC4NCg0KUGxlYWVzZSB0cnkgdGhp
cyBwYXRjaCBpbiBtYWlubGluZSBrZXJuZWwgKDYuNyspDQotLS0NCi0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL3BjaS5jDQorKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9wY2kuYw0KQEAgLTM4Nyw2ICszODcsNyBAQCBz
dGF0aWMgdm9pZCBtdDc5MjFfcGNpX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikNCiAgICAg
ICAgc3RydWN0IG10NzkyeF9kZXYgKmRldiA9IGNvbnRhaW5lcl9vZihtZGV2LCBzdHJ1Y3QgbXQ3
OTJ4X2RldiwNCm10NzYpOw0KDQogICAgICAgIG10NzkyMWVfdW5yZWdpc3Rlcl9kZXZpY2UoZGV2
KTsNCisgICAgICAgc2V0X2JpdChNVDc2X1JFTU9WRUQsICZtZGV2LT5waHkuc3RhdGUpOw0KICAg
ICAgICBkZXZtX2ZyZWVfaXJxKCZwZGV2LT5kZXYsIHBkZXYtPmlycSwgZGV2KTsNCiAgICAgICAg
bXQ3Nl9mcmVlX2RldmljZSgmZGV2LT5tdDc2KTsNCiAgICAgICAgcGNpX2ZyZWVfaXJxX3ZlY3Rv
cnMocGRldik7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MnhfZG1hLmMNCmIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
MnhfZG1hLmMNCmluZGV4IDQ4ODMyNmNlNWVkNC4uMzg5M2RiZTg2NmZlIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MnhfZG1hLmMNCisrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTJ4X2RtYS5jDQpAQCAtMTIsNiAr
MTIsOCBAQCBpcnFyZXR1cm5fdCBtdDc5MnhfaXJxX2hhbmRsZXIoaW50IGlycSwgdm9pZA0KKmRl
dl9pbnN0YW5jZSkNCiB7DQogICAgICAgIHN0cnVjdCBtdDc5MnhfZGV2ICpkZXYgPSBkZXZfaW5z
dGFuY2U7DQoNCisgICAgICAgaWYgKHRlc3RfYml0KE1UNzZfUkVNT1ZFRCwgJmRldi0+bXQ3Ni5w
aHkuc3RhdGUpKQ0KKyAgICAgICAgICAgICAgIHJldHVybiBJUlFfTk9ORTsNCiAgICAgICAgbXQ3
Nl93cihkZXYsIGRldi0+aXJxX21hcC0+aG9zdF9pcnFfZW5hYmxlLCAwKTsNCg0KICAgICAgICBp
ZiAoIXRlc3RfYml0KE1UNzZfU1RBVEVfSU5JVElBTElaRUQsICZkZXYtPm1waHkuc3RhdGUpKQ0K
DQoNCg==

