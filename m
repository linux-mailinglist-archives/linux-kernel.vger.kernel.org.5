Return-Path: <linux-kernel+bounces-96425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F229C875BF1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92F528391B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595D422EF4;
	Fri,  8 Mar 2024 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="soqzusbb";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="l5GbHh+8"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F0923B0;
	Fri,  8 Mar 2024 01:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709861078; cv=fail; b=dgY+wLRkM8Co5iTnsM16YzegERmLd6gZZ5++gqq66Ld7d3UxisTZ5EAwQ/FqxKAJG7qZpIed8xk4OQlfRD+VIiqxc0pdPZHPE3WKcfepqQXUeOI9XCBTIc/lcAw+PGgiapNtMvJ4/yEld6mnjSH5uXSAlgTV/E37M2guFDTFRpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709861078; c=relaxed/simple;
	bh=iejS9U0B2gz0zwGq8cK0hXNxrOif96FJRkNfWWEGGcs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AUYfSjuSf+X01uIo/mhjjeiOCIVn8907oBeKeTP8vivQiUBUrgP4m9I42Hl549qkCbT6udsUk1IyHv5/qDIx9SdKvWJS543zTBvfflTcx6IuQ+oBoLKB8MeGmVPjGR8ThSB4HwUWFbQOdANIYb6h3gtvbEjOLaTCSuXwe1a18Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=soqzusbb; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=l5GbHh+8; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9bcd0372dcea11ee935d6952f98a51a9-20240308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=iejS9U0B2gz0zwGq8cK0hXNxrOif96FJRkNfWWEGGcs=;
	b=soqzusbbmQ4fQDOHWjeFmC/eTdZXXEU582+5AzWOHKclmEytnp4VrT+ELB4sNYDA5H9p+NYvDpSCt47zHdKPuSHmmHzLCHeh5Renu/K6VpA2N2RGtGtk3/xyQq5i5eccGp5CPLbMiHFQp8G5qKAphP3s2bsPMudCBG4YYXsZdFs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:efd77065-1107-4308-ae16-eebc99084e54,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:0fd92690-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 9bcd0372dcea11ee935d6952f98a51a9-20240308
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2064460330; Fri, 08 Mar 2024 09:24:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Mar 2024 09:24:27 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Mar 2024 09:24:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i81h04t1WFeQCaXTJQQdI0r9IA8BpEfbM3z+/fpU9UeNpdRKqb31Ts2LjpZv55ekmdeMHxolO+X78Il+wTVqwq0WfoVuYSUPyIf5SeqGmGfqtdVLkw3a9yTyk/GExZvqnPHAz7O0mljS7M+OonGzQVMlOOvtO3uIgw8F3ChywlvdSjhayjqxd8RCyVjsBJ400+2qccsM5ibmxqM/gay1inmkdrGdpayWWcEzWz4kMhBz9bVjkoQrBxfFtj4BfE5KnY2vzog0Vsxqr/jL7N3fFoO0Nxwj/zZAr9L0hTJUl7XGxmsvUFm5F3CHLSUSFzdgYSNsHTyMvvZNZogkoAJlqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iejS9U0B2gz0zwGq8cK0hXNxrOif96FJRkNfWWEGGcs=;
 b=TV88QoZ9JHp4M3DfhuV4Nwq3YUfchih8uQdI0fYsBnbZi/L3ABiu2yKDJPvxJSHOAUdechFP9oT54fpRPOFLSLnpeyoF82Qpmu8kLBkf9ErT5YfDw/6UffFRGQ4Zy6FT/H9vi0y//jM9BYW43tq9Jbi25N7OgscxI2uspSEh2FXkuQmLgp5wxZQgV7pr4tpXMPVzLGU+nDG2TF/keCCc8R8PAy8FN+tWsB+tgUX+Q4dDZviMTw9F2881S5AGQTiP3ajlbyXXzsgX1wFSikB+M8gXpxqmK4nZaO/WSGNhRSQp7ST9VBxmeCAX9UbuhUuOUUmgX428KeMvF+u7Rbg2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iejS9U0B2gz0zwGq8cK0hXNxrOif96FJRkNfWWEGGcs=;
 b=l5GbHh+8Azpwph6Q4xBVkR3c/6MS5K0az/Yj76iLcwd+wKDzgmzBQDl/ayBHgyuPCxMDrPsJdqzhqBqIDJtH67eOtV0+cYnX2p4++s0dqzf6naa6AqOA/KzLLj6dUAyUXXbtEtsnUdKDS6aNHHvizgLN5AkrxGF1U0I+SfcNGTs=
Received: from SI2PR03MB6463.apcprd03.prod.outlook.com (2603:1096:4:1a3::9) by
 SG2PR03MB6480.apcprd03.prod.outlook.com (2603:1096:4:1c7::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.24; Fri, 8 Mar 2024 01:24:25 +0000
Received: from SI2PR03MB6463.apcprd03.prod.outlook.com
 ([fe80::6091:6aa6:efd9:a3aa]) by SI2PR03MB6463.apcprd03.prod.outlook.com
 ([fe80::6091:6aa6:efd9:a3aa%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 01:24:25 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "fw@strlen.de" <fw@strlen.de>, "davem@davemloft.net"
	<davem@davemloft.net>, "pablo@netfilter.org" <pablo@netfilter.org>,
	"kadlec@netfilter.org" <kadlec@netfilter.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH net v3] netfilter: Add protection for bmp length out of
 range
Thread-Topic: [PATCH net v3] netfilter: Add protection for bmp length out of
 range
Thread-Index: AQHabvG0DZxC9eczF0uTSH6BuJVdS7EtDQGA
Date: Fri, 8 Mar 2024 01:24:24 +0000
Message-ID: <e1f1a2ebbbf95d6aa8d2a12811ce379f438ab21b.camel@mediatek.com>
References: <571b3e3f7191b5f67792d1090fc537bf4045c522.camel@mediatek.com>
In-Reply-To: <571b3e3f7191b5f67792d1090fc537bf4045c522.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6463:EE_|SG2PR03MB6480:EE_
x-ms-office365-filtering-correlation-id: 4e44bd0f-757d-41a5-e349-08dc3f0e7da7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UODwQtq53tzOGPkfutprwA/Iv3z2g5qlmEhApoIrm0SQuQ/6eQfEPCcOclXdyAdmCrNdS6uqNsoLZuIIHugAMpz0U9pJ8o3SP2YIwMVMRwTCPiE2V2n6eopke3fsFcnYob4Ut7pmtE2XfclHAgdoT7Df8skDZfRvH4wdVwaZZRvaP1pWEnYXgDpcsPQhbxduVaQy8Sf3rIOlNsy3ZMCqmDrie+Kg4vnCmEX28AL1bvGGkqgVeZeRjw8I2mNXTHRPMJgpJoF+5ddLmYf//Sa1J0Id/EVqXcRlp5nc2SjGpUs99xj4aEWHc/i8X8a4vq+eR6oDNVxqRopXJLHvxgelRmm/iXXUldzzdqPCuZbEa/qKXVAik09b3j1AKNkPWAdfPOUoBz//TfHPn9jx+Yse+UkPpBd6zf1VQEexeDXNI+iCKZEnCa+pCFM9Rq0TO86JCHl0Ub2EkJO59/YcletqEsnqUqAJBbZSqQ14Z7dc36aF/mvmApusHpYCrvWI7Ccuibayt+2PT+ZhqtdiSZ/sWuupsBfyJwuFkYNfmSKydTBiOKFtgm5W+7Hfw7QvoqGtWIDLDbds0p+Y5EIOFTIU+seriHv9XObFFZe4PkDlcqwSHbqnNJCodlFsnKQ4AJor79FyGi1QYt6efDAnbNsc7SjvcVY5FWlXEa8GAyZat3NY3La9XzBZzg5avpM47oKcMD9Jr/54kwKXe0vH2hHuUzOiz+RAEK7Hs2eRCfsM4Q4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6463.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDZYWFByaE5HQTlWREEyRHkwQ3dRR3ZwTjIyRGlnVUlNVy8weU83bG0vNVdZ?=
 =?utf-8?B?eHBPbHZJYTdJZnMrSDlrU3ByYjFCQXdWUllRVGZuQVVKT0x3eWgyeHNKanVx?=
 =?utf-8?B?TkFhNjhEM2luSU9BejduQ0dnU29FZ1J3aWVDUVZ4SjNQRjNHakxmMmZZcW5F?=
 =?utf-8?B?Y3ZHZnc5dnFhL282Z2JpZ2hGQW9WMEFnMm1ZdDhXbTJGQVdub3RVYmlxOXlJ?=
 =?utf-8?B?bGlpeUphdW82WXRBY3I2OVI5Nmdrak5zclgya3pJZ01RVTNrcVhkcnNWNnhZ?=
 =?utf-8?B?ZXNRQkQwaHJJNFlDU2ZsajNFRFVkQkpyU0gyTzJwSG1LTXFJL3JUclZpYWdn?=
 =?utf-8?B?dVZaTzF5ZFhsNE9QZzNNSmNOQVlGdGpNTkkvNjRaUG41QnduK2Z1YjZlYXQz?=
 =?utf-8?B?YmNBSGlYa3BNWFZJbjN5azI0RHQ2Ym1IT3FVWDVjNjhyS1hPYk0ydmFRN3Nz?=
 =?utf-8?B?MFdqZjRhc1RIMjNCelNlMWN6T29tdzk0SkJOTjR2cityeVYySS9DcWRKYVNt?=
 =?utf-8?B?ZkJhRk81NVgrYzJqa3ZQOFNuMjFjQ00xYmluUjBYTmVzMmdOdEY0MWVCK215?=
 =?utf-8?B?K0VHeWdDd005clZCN2JPZW5CeGNRRy9kdXhuUm9MeFlJMTI2VVV4emFKZW9v?=
 =?utf-8?B?TGFUbncxQ3RTNmM5QnFKSTIvcFI0aCtNNFJJNEN2VHFnNTFRTWtoeWxPU2Fu?=
 =?utf-8?B?Y2NFc0tlOUV1ZVlGYm53QlVCcytrSlljMmdTbExCVFBaSVd5S05rWVNXdG9i?=
 =?utf-8?B?R3UvQ0VRTWFsQkwvWGUvT2RjTjdiaGVMNzF3NGxSNGdFYlZIR24wMDRpSllx?=
 =?utf-8?B?U2JjenNSY05PUUdTMkgzZHhuY2hOalByL1pJUDhobUt4S3crTExaNDl2SWJX?=
 =?utf-8?B?UURNUjYxaGlQcTBMdVBPVnp1NW9CR0QyYWZua3Y3MDYwUE9CNzhYSjhOS0N5?=
 =?utf-8?B?T0tOSTlYSkdQc0czUnRQSlM0YmZlb3I2WkV2N2RQVHdqY2dqZXBSTWx0QS8z?=
 =?utf-8?B?V1k1YklEcWo2UldyTmxVY2swWVlzUDZLMmRQaVBvMVpKWWNBSm9INnlCTFk2?=
 =?utf-8?B?RVJlOVY4aE9xTFNzdC8ySHJOMDVSQzEzSHVsZ2pPVXdOUE9jNm9xWitIL25R?=
 =?utf-8?B?cVFMYWJpcEZscjBnQTVPN0g5NTVVNXM1Yzg2WmtCSXJ3R0ZybXFtNHZCVlVB?=
 =?utf-8?B?RUs0bmdlMUJtQUx4RkdGbm05cDkya29iWU1xRTBsZmpkRnVFaVpRL3dMVi9G?=
 =?utf-8?B?ZTJyVU9XaUwyV1lKcjVYL3FnZEFxVHN1K000VjQ0dUxXenZ1T1JocnVySXMv?=
 =?utf-8?B?aU5PY1ZvNGhHSUxyLzRSTnR6a1RjQWJFQzIweWpqQVlJTjN6TkRiMkNvT25F?=
 =?utf-8?B?T052NDRsa2RGaEFsdlBKclFESGt0eUplMndUOXdjNm4rcy80NzJzZmZOeXJE?=
 =?utf-8?B?elN3SnVzR3lhNzdhd3ZlYVRONmRYOGs3UHhld09RK25jcHdmK3lBcTdsVDVv?=
 =?utf-8?B?VXNHU2ppWlZLRG9pSXp4Q0FXOUkzTmE2T1pYVkt0S2ZTUnJPeFRPQnpIWWFF?=
 =?utf-8?B?NEZtN3JUeGQvd3pVMFhTRE01dk4vZk1Zd0pWYklQVGZjaUgveXJ4SXJuUi8x?=
 =?utf-8?B?NFdlRUE4ZXF0Z2ltZ0FsVzR3ZmNTU2VYcU0zN0pVdDBZZmtPNU9PU1VIOVVJ?=
 =?utf-8?B?aWsydnFjZ2RxbUtrZ1RvdEFZT3FVRW5DK3Y3aVRsVmxpbWNFb0xHbERlRjR2?=
 =?utf-8?B?c3F0Q3FMZDBxY2lZNndWSy9yTXFxN09Odk1pakQwMzNvbnk4dGRaUko3RFNN?=
 =?utf-8?B?eUdyRE8wOStIVjV4UCs4LzluUElFMzYzakJEVURJa2tGVTl4cVNXbUp0TEU0?=
 =?utf-8?B?TXlramJUUWFrUE1YYjZHWG5BVVo4OG02SWV6WWg2SXVHVEVaNktJTUJyMWhI?=
 =?utf-8?B?c2RKRStMcVpXRkRPMVhHeGFzNDgyZVFGeUJUMVFIWW4xTEhaM0dtbTJQdExa?=
 =?utf-8?B?QUtESGo4d2poQSt6ajN3WXNLcndtNFJDVFZIbTJFK1RBQVpKWHhUeXdpRW5G?=
 =?utf-8?B?L1hNQWlaMHNjdFVCNnd1ZXArcjcxV2FTalFmeWdJZ1hmNUVzKzByeGhsS2hq?=
 =?utf-8?B?WlF4dXBSaG92bGN4VEpURVJremVoOGRFRUtiQmVzSCtmSU4rZ1Fmdlpubkx1?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F822636415F794D8158A9A6A72FAE75@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6463.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e44bd0f-757d-41a5-e349-08dc3f0e7da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 01:24:24.9669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E2zdSwL5pj3dZAcm02a4TUTkoMlzAZPfDEiATi0oE9Od68WJfY/Vv1tuu33uW6/102ZWGuQrCERDAjZEfkv93w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6480
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.784100-8.000000
X-TMASE-MatchedRID: hls5oAVArl9BfGdIwmVjfCa1MaKuob8PC/ExpXrHizyPcd2jEAJg7b2+
	Pt89anuu7s3FANKtoAUgNFIGSbJIXWFGJky2Zpt1QpxiLlDD9FWAfODDLypXmhjQD3m2MCf7JR7
	lNPN0VZ9YOFrTWedzh6FhcHRcvXnavFOnPbNb4smUa50su1E7W0DwlkRNC6PCBUe+Zw5ql5T5WK
	Feqf3EsfOHGdsHfPNBHhRlNXoVQjOqeo/H3QKcFawOh3D3JSTGCt4iaV1DkENGhLlz15UeamyXv
	LQmhhlM69RbzlHiTFofZdczzDm/ukL9tcyTZdAsgxsfzkNRlfKx5amWK2anSPoLR4+zsDTtCx9q
	oxmS2x0DYq8ppNVrgdbZqh0J0V5RWwUqLb3H3tA3RsY8jDZzSg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.784100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A5C3FA402CBF3267B90DE3631B224C68C53C48E3DC83F8F6C96F04F83A63B3B62000:8

T24gVHVlLCAyMDI0LTAzLTA1IGF0IDE5OjI1ICswODAwLCBsZW5hIHdhbmcgd3JvdGU6DQo+IEZy
b206IExlbmEgV2FuZyA8bGVuYS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFVCU0FOIGxvYWQg
cmVwb3J0cyBhbiBleGNlcHRpb24gb2YgQlJLIzU1MTUgU0hJRlRfSVNTVUU6Qml0d2lzZQ0KPiBz
aGlmdHMNCj4gdGhhdCBhcmUgb3V0IG9mIGJvdW5kcyBmb3IgdGhlaXIgZGF0YSB0eXBlLg0KPiAN
Cj4gdm1saW51eCAgIGdldF9iaXRtYXAoYj03NSkgKyA3MTINCj4gPG5ldC9uZXRmaWx0ZXIvbmZf
Y29ubnRyYWNrX2gzMjNfYXNuMS5jOjA+DQo+IHZtbGludXggICBkZWNvZGVfc2VxKGJzPTB4RkZG
RkZGRDAwODAzNzAwMCwgZj0weEZGRkZGRkQwMDgwMzcwMTgsDQo+IGxldmVsPTEzNDQ0MzEwMCkg
KyAxOTU2DQo+IDxuZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19oMzIzX2FzbjEuYzo1OTI+DQo+
IHZtbGludXggICBkZWNvZGVfY2hvaWNlKGJhc2U9MHhGRkZGRkZEMDA4MDM3MEYwLCBsZXZlbD0y
Mzg0MzYzNikgKw0KPiAxMjE2DQo+IDxuZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19oMzIzX2Fz
bjEuYzo4MTQ+DQo+IHZtbGludXggICBkZWNvZGVfc2VxKGY9MHhGRkZGRkZEMDA4MDM3MUE4LCBs
ZXZlbD0xMzQ0NDM1MDApICsgODEyDQo+IDxuZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19oMzIz
X2FzbjEuYzo1NzY+DQo+IHZtbGludXggICBkZWNvZGVfY2hvaWNlKGJhc2U9MHhGRkZGRkZEMDA4
MDM3MjgwLCBsZXZlbD0wKSArIDEyMTYNCj4gPG5ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2gz
MjNfYXNuMS5jOjgxND4NCj4gdm1saW51eCAgIERlY29kZVJhc01lc3NhZ2UoKSArIDMwNA0KPiA8
bmV0L25ldGZpbHRlci9uZl9jb25udHJhY2tfaDMyM19hc24xLmM6ODMzPg0KPiB2bWxpbnV4ICAg
cmFzX2hlbHAoKSArIDY4NA0KPiA8bmV0L25ldGZpbHRlci9uZl9jb25udHJhY2tfaDMyM19tYWlu
LmM6MTcyOD4NCj4gdm1saW51eCAgIG5mX2NvbmZpcm0oKSArIDE4OA0KPiA8bmV0L25ldGZpbHRl
ci9uZl9jb25udHJhY2tfcHJvdG8uYzoxMzc+DQo+IA0KPiBEdWUgdG8gYWJub3JtYWwgZGF0YSBp
biBza2ItPmRhdGEsIHRoZSBleHRlbnNpb24gYml0bWFwIGxlbmd0aA0KPiBleGNlZWRzIDMyIHdo
ZW4gZGVjb2RpbmcgcmFzIG1lc3NhZ2UgdGhlbiB1c2VzIHRoZSBsZW5ndGggdG8gbWFrZQ0KPiBh
IHNoaWZ0IG9wZXJhdGlvbi4gSXQgd2lsbCBjaGFuZ2UgaW50byBuZWdhdGl2ZSBhZnRlciBzZXZl
cmFsIGxvb3AuDQo+IFVCU0FOIGxvYWQgY291bGQgZGV0ZWN0IGEgbmVnYXRpdmUgc2hpZnQgYXMg
YW4gdW5kZWZpbmVkIGJlaGF2aW91cg0KPiBhbmQgcmVwb3J0cyBleGNlcHRpb24uDQo+IFNvIHdl
IGFkZCB0aGUgcHJvdGVjdGlvbiB0byBhdm9pZCB0aGUgbGVuZ3RoIGV4Y2VlZGluZyAzMi4gT3Ig
ZWxzZQ0KPiBpdCB3aWxsIHJldHVybiBvdXQgb2YgcmFuZ2UgZXJyb3IgYW5kIHN0b3AgZGVjb2Rp
bmcuDQo+IA0KPiBGaXhlczogNWUzNTk0MWQ5OTAxICgiW05FVEZJTFRFUl06IEFkZCBILjMyMyBj
b25udHJhY2svTkFUIGhlbHBlciIpDQo+IFNpZ25lZC1vZmYtYnk6IExlbmEgV2FuZyA8bGVuYS53
YW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+IHYzOg0KPiAgIC0gYWRkICJGaXhlczoiIHRhZy4N
Cj4gdjI6DQo+ICAgLSBhZGQgbGVuZ3RoIHByb3RlY3RvbiBmb3IgYW5vdGhlciBnZXRfYml0bWFw
IGNhbGwuDQo+ICAgLSB1cGRhdGUgY29tbWl0IG1lc3NhZ2UgdG8gdHJpbSBzdGFja3RyYWNlLg0K
PiAtLS0NCj4gLS0tDQo+ICBuZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19oMzIzX2FzbjEuYyB8
IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL25ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2gzMjNfYXNuMS5jDQo+IGIvbmV0L25l
dGZpbHRlci9uZl9jb25udHJhY2tfaDMyM19hc24xLmMNCj4gaW5kZXggZTY5N2E4MjRiMDAxLi41
NDBkOTc3MTViZDIgMTAwNjQ0DQo+IC0tLSBhL25ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2gz
MjNfYXNuMS5jDQo+ICsrKyBiL25ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2gzMjNfYXNuMS5j
DQo+IEBAIC01MzMsNiArNTMzLDggQEAgc3RhdGljIGludCBkZWNvZGVfc2VxKHN0cnVjdCBiaXRz
dHIgKmJzLCBjb25zdA0KPiBzdHJ1Y3QgZmllbGRfdCAqZiwNCj4gIAkvKiBHZXQgZmllbGRzIGJp
dG1hcCAqLw0KPiAgCWlmIChuZl9oMzIzX2Vycm9yX2JvdW5kYXJ5KGJzLCAwLCBmLT5zeikpDQo+
ICAJCXJldHVybiBIMzIzX0VSUk9SX0JPVU5EOw0KPiArCWlmIChmLT5zeiA+IDMyKQ0KPiArCQly
ZXR1cm4gSDMyM19FUlJPUl9SQU5HRTsNCj4gIAlibXAgPSBnZXRfYml0bWFwKGJzLCBmLT5zeik7
DQo+ICAJaWYgKGJhc2UpDQo+ICAJCSoodW5zaWduZWQgaW50ICopYmFzZSA9IGJtcDsNCj4gQEAg
LTU4OSw2ICs1OTEsOCBAQCBzdGF0aWMgaW50IGRlY29kZV9zZXEoc3RydWN0IGJpdHN0ciAqYnMs
IGNvbnN0DQo+IHN0cnVjdCBmaWVsZF90ICpmLA0KPiAgCWJtcDJfbGVuID0gZ2V0X2JpdHMoYnMs
IDcpICsgMTsNCj4gIAlpZiAobmZfaDMyM19lcnJvcl9ib3VuZGFyeShicywgMCwgYm1wMl9sZW4p
KQ0KPiAgCQlyZXR1cm4gSDMyM19FUlJPUl9CT1VORDsNCj4gKwlpZiAoYm1wMl9sZW4gPiAzMikN
Cj4gKwkJcmV0dXJuIEgzMjNfRVJST1JfUkFOR0U7DQo+ICAJYm1wMiA9IGdldF9iaXRtYXAoYnMs
IGJtcDJfbGVuKTsNCj4gIAlibXAgfD0gYm1wMiA+PiBmLT5zejsNCj4gIAlpZiAoYmFzZSkNCg0K
RGVhciBhbGwsDQp0aGUgcGF0Y2ggaXMgbm90IGFwcGxpZWQgYW5kIGl0IG1heSBiZSBkdWUgdG8g
Zm9ybWF0IGVycm9yIHdpdGgNCmV2b2x1dGlvbi4gSSB3aWxsIHRyeSB0byByZXNlbmQgdjQgdmVy
c2lvbiB3aXRoIGdpdCBzZW5kLW1haWwuDQoNCkNvdWxkIGFueW9uZSBoZWxwIHRvIGNoYW5nZSB0
aGUgdjMgc3RhdGUgdG8gQ2hhbmdlIFJlcXVlc3RlZD8NCg0KVGhhbmtzDQpMZW5hDQo=

