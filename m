Return-Path: <linux-kernel+bounces-120631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321B288DA7F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FF9295CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868833C087;
	Wed, 27 Mar 2024 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CB97dkgJ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nLfaCKeR"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B646B98;
	Wed, 27 Mar 2024 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533088; cv=fail; b=pCpigTH36Ll4v0Xa9LIP0UYrTG9mngy/nvEq1KifO0g/+8PKMRQxZCBDkst7GYRXJUHcrzTNfsLhvIxoirJoDCGD91bSZoeDmaXWROKc/OELDpKOYjI6HVxjvnOgcySqaxcaKuvEhVfTZu2osVizVy6Y9D+cFyTLH8iTOqAZNdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533088; c=relaxed/simple;
	bh=Qm+XilXkViqEOkXsu46xKKU7wGxNmEWKR3qpRaVH2M8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jG0QNe1ZHicSrlO1mwMibeacXHyw2nxGuTvcvvagYzOVAgySui0c8gPuE1QPJdg/4eQFwqQ77zlJTvcZX5JRXjTUIAOsbrqe9qg0YYYjK8f9Zc8s8NiOsNLnGdEPRbPuuPifklWkzefXEB3QCyJKzzQYlNTJ8QC5G72zl+ZJO6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CB97dkgJ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nLfaCKeR; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 903dbab2ec1f11eeb8927bc1f75efef4-20240327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Qm+XilXkViqEOkXsu46xKKU7wGxNmEWKR3qpRaVH2M8=;
	b=CB97dkgJs/ZUMA4wxQTUPs8vOnKxP/r1T+s2V5c7XLap5jVkbPPE+G9qbgkJv9JIzDjrg3UjGMQndAFDOpRA1MbaZsS4tVPbYR4WdWMfnoXA70rlMzRkJsajejabFrsAorssYBGq6ErH74cgyV5raDkTSl8qo1iVbwdQsxqRQSg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e5cad0bf-8ddc-4b22-9259-fa5585613bde,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:ee446300-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 903dbab2ec1f11eeb8927bc1f75efef4-20240327
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 700919959; Wed, 27 Mar 2024 17:51:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Mar 2024 17:51:18 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Mar 2024 17:51:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQsz9ZcXL+FkFz+jAxpbYXUgEgA/3tkY3CSKzgor32D0VuSooPB8k0E9L2oWDf3SX0vlo/QojaD04qhaA+yXWeifUQl+vQiRr6fgj58xzXf9nFgmCPvHMsC+saslLtqnoSf+TDrUXatHaBPRt4SAjLhcTvIXXsn3UPbHTEjp5bijABwc5I4+cUluUlOJ5UJRQVz0mH3kVj7A+aVAUqyvFE/oDQ2ng74KMb2bpsH8MF9Kc/5A8GAisVcPg+pujcbfi3GfM1BL58JvXYJfQx1dA2soMg3kwdbzzL0rb4vLvVrf53zNMHDyWbE0pF/pLstXO7npha839TumwwDgQ7s2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qm+XilXkViqEOkXsu46xKKU7wGxNmEWKR3qpRaVH2M8=;
 b=YVT6UfO2I8y6zkWHbzaFluXdaWYlpAZ2Aj9M9BfDdWWK97O4snRFzKOfuNCNfU1QUAtp0uBFHaaq31gavGo56y2+Kr0cshGPiKW0mc7ria+WIp+c8h6VcdeHqwFnAqABMN2z2pMyr80tTEw5OzH7wv5yDNpxPlFrRKlJIA0/fhDM2+ZwyxK+5ZmNxbnVB7wL/lEiWDUoW0wsUINC4OZCDjjAs53u1LKVE5e7DqqEQTkczl9kxyvPYhneuhgTwr+ok9zRm7iIa6Zf6pPesc+hR6iWgVdEdZB7cwWKhhr1/F/wrdvXyYWHY1zVDXZ8xFoIRE2gfvd9CX1Cc4V4jHnSEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm+XilXkViqEOkXsu46xKKU7wGxNmEWKR3qpRaVH2M8=;
 b=nLfaCKeRCRxGaelm8G/+C0KkcG2BOuipYjYYMoF+0m+8qinE0OhoZpIRgrln9MmG+76NOaw3v4VxoQtxMr482IwYbcP7ZMO4uLVtFhsYi0oa9qt/TEenWwSItV0625uLzE4h0RgZ43xaq/pf7+ijjImzcdK8qkm5uS3A5cV2dMs=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by PUZPR03MB6886.apcprd03.prod.outlook.com (2603:1096:301:102::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 09:51:14 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::85d1:1a4f:cc89:46fa]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::85d1:1a4f:cc89:46fa%7]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 09:51:12 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "arinc.unal@arinc9.com" <arinc.unal@arinc9.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "opensource@vdorst.com" <opensource@vdorst.com>, Sean
 Wang <Sean.Wang@mediatek.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "dqfext@gmail.com" <dqfext@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "bartel.eerdekens@constell8.be" <bartel.eerdekens@constell8.be>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "mithat.guner@xeront.com"
	<mithat.guner@xeront.com>, "erkin.bozoglu@xeront.com"
	<erkin.bozoglu@xeront.com>
Subject: Re: [PATCH net v2 1/2] net: dsa: mt7530: fix enabling EEE on MT7531
 switch on all boards
Thread-Topic: [PATCH net v2 1/2] net: dsa: mt7530: fix enabling EEE on MT7531
 switch on all boards
Thread-Index: AQHae60CUSPbrXf5nkWiwkOJoLXcMLFLYTyA
Date: Wed, 27 Mar 2024 09:51:11 +0000
Message-ID: <70bc9c503c8ce1ee821a22e0739344229646dbe2.camel@mediatek.com>
References: <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-0-9af9d5041bfe@arinc9.com>
	 <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-1-9af9d5041bfe@arinc9.com>
In-Reply-To: <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-1-9af9d5041bfe@arinc9.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|PUZPR03MB6886:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SVob3jmiMxMKA5ItYBBpHXU5mKM5yAhrUAvtgRbb+aUu/dJRholqUfck6TBk4C9U18QdzIxTyGa/M/QW7toAJoSPPe21vFSyQPsPPpWHsEguq/m99P1eENOzAfInW26sKRLJd0w+6IOHpuLKf//1xfxeYLZ0PzJce4P2FuQIQBlF+EJuwgsM8PtFYGd5/XUAu02L836hk9sGTVlyXQ1/kZnMoNKHEByb5QhlowalhS34oImgtxsKKuKXSIuKuL63tqGGm/5kKDJ69AfBbJwcebI6CT1rz7hn0KGl9pip9UGeZPh1Tx7h/VeR/XV9zXCEp48D43AG25/8iScmZ8KEDZb9oG/CaZCqkXV1TO1KUsGil/KxzhPEEadivSYwf1ZYksHUBkv8H3L+MixudmPHdoP93yHKgblcMnUNFuDqFEWOTbDhgb2nhNma9hOcKQmJtHSlULX5Km+HNDZZ3eMG/LB+mW6tjuPETXO4E1otWsvmDIJoAFyPb8lCkMNgXUMkUGiGytQaEoX+MGo1CdcbBKU/a3CppBrWvdtY2yfN9jOMkyhvEohvoLcU3twqVx92NkyQxXzW4bd0QgdFCuNl3Rl46Q1N/xJxySEd2BFB+9VpvH+Sn3ZIRBEPYGxGclibR8TcI6WYMbP+il4s5WDhHCkwbyYZryX0Fpb+T3PW2tRDC/qS6pmYIVwuH76FOC5oud9rJLjVdrXuWt21lVc0toi4U9gZUard+RnZJ1yH/hQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011)(30042699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGNPeGZ2SVhnTWhBTDVlV2RUdCs4aWNtZittZzhtaHBoSklhUHNMQ21GU2pq?=
 =?utf-8?B?MVg1cHJkLyt4d1grRFB1VFoyUGM5TlVWbFlFTlJPc3Y1blFVcFNHTHF4cm9P?=
 =?utf-8?B?OHRaazE0ZUJQTW9zTERpdlo3VjNYTGIwbFNOblRFeVh6TUdzNlRGdGRYcUdY?=
 =?utf-8?B?QXFrRUtDRTFzNklVUE0rNGE4NWRGbmtzeldpaFVTYVZZLzFZYlF1YUZhT3pk?=
 =?utf-8?B?NXVVN0JxQ3RpeDVhVklpQ0swbW9waDNnQzI5RlVsaGRWODB6emUrYkY1bHc1?=
 =?utf-8?B?OEJmMXBCNUJpRENUcW56ajk2STJFVyt2UTZYcklZN0g1ZmFSeG90Q2pUSVdl?=
 =?utf-8?B?cU5vQ1ZoaDRyV2lvVXlnT0o4SGJGclEyaVdiNDZsM1l6TEZteXJUdzU4TFND?=
 =?utf-8?B?UGM3L2VXMXlYbHEzcEI1YXIwVTRtdmI3TUhJWXJrUUVzcjNWaDQyazc3cjNx?=
 =?utf-8?B?Yi9ua090VkNHVUVnWmpML2pDQUQvaXIwMTlwM0RqTlkyRGpiS1N4bjdqcnRy?=
 =?utf-8?B?enRSRzRUYXJReXBrTTlXY25YUzBGdkFmVUs4d0RPYmxkZUxJYUdoTXJwck1r?=
 =?utf-8?B?RFlhZXJseEh4VWEzTjh2SXVaRVhpSTNjemtjd1lxV3h0Yk1vWnFXRFVxazUv?=
 =?utf-8?B?VzFkWGNEMTBjcjN3dVZZZXByVHF2NERuenFRQ0xncmdSdkZvSkNZa3d4MCtL?=
 =?utf-8?B?b21UdU5RSVptV0VPdG5zSm5oVGoyRUMwL0kzWldwZnZpVXdjU25jYmJpdEdY?=
 =?utf-8?B?K1BsNWxJQjFjdnI2VnNQSHFmZThBc3pqRjhLSElPS0tiSGE1V0JpVVRsUlN6?=
 =?utf-8?B?ZVVPU3VLY1crVzFHUVF4am5QTVZvSXRLU3lja2lvNVFPY0dONDdRV01Cc29y?=
 =?utf-8?B?MWwrczVuMWZnRXN4MW9qdFhwa1VFTXJ4alR4d3JGdjZNMjhCSndtSWtyL1Ex?=
 =?utf-8?B?d1ltb2IyWm1KQlYxaTBSRi9oaHFqWjJwaVdSeUJVL3l3eEV5alZoN2tMTGlG?=
 =?utf-8?B?MjVha25CWjlLSUc3NUU3NXpiclBMbHZJcDZGKzVTdHJjSkpyWi9uRVQ4bktU?=
 =?utf-8?B?NGQzdUlqNHByUzJCTzJjcmIxcHM2UG9rVkpYb002U2RUeTZaS041b1VKaVEw?=
 =?utf-8?B?RW1rTGM2Y2J1WWRvRjdHWEJPdWFyTDFDR3ROVHJld245TXhCY3dyNllLL3Zu?=
 =?utf-8?B?VFJDM3BOanhjNlBFbThlQ1RPK29VUHpHakRJem13TncxZFc4Y2dIOExDVGpB?=
 =?utf-8?B?aUdCMEVjNy8xa2E2c1ZDNXNGTitSRncyaGl2cDh2aFlUTlkxNnhuODVxMUpj?=
 =?utf-8?B?WmRKL1NtbERPZ0toY1VTRlY2aU5GWU5tcXc0Q1M3WFhibXl4MStMenI5bzdI?=
 =?utf-8?B?WFgwTG9ER3BsQ3R3d1N0bDYvLy83b2tsRkNXV2dyZ3B6SWxWOFJ4OSs1TnlY?=
 =?utf-8?B?blIwRGRRUm90YWtndUFwYmdWT1ZBRUxtem1iUzNyUTA4TG1ycEREZEo0QU9I?=
 =?utf-8?B?dHo1dW9KVHpsYStYYWFQTXBhSFJNMjV3Y1lTZ2hDbFdjN3I2Q0N3QWZ1aGFq?=
 =?utf-8?B?ZHY0dVJnQVM1elJIZDIwZjdXc3U3elRrbWo2VHNsTUYzZUJYaGZDWkw5S2dX?=
 =?utf-8?B?QzdLYUNmWWkxVkVJVkdlZDBiWlltaDJLTUZwNHVqV2RvL2FOV04zWi9OakNR?=
 =?utf-8?B?MEdsaFQ1NlRJczRzRlZZYUowdGRtNktBT2JvNHQrSVoxd1F6NDhleUNQS2tq?=
 =?utf-8?B?K0ZCRmhrcWQyY29RaUNHVG1ydnY1OEp1eFozRmFzR1p4Q1pvNVJkN3RlQzVv?=
 =?utf-8?B?MVRVZU92V1RQMDhxcGZWaWl6SWwxSkNuWlhxRE9zTFBKL1RQRm1BK3VjSWEr?=
 =?utf-8?B?UDcwQi9uZnBOVk5QYzRRejNnalYvdmhIc3ZtcFdsV09ES24yUStmcXpaN1RY?=
 =?utf-8?B?VHArU201UkFCL1NZdmVnK29TbDV1VzRDVWRsWGRMK2RNdHMzSjdXSTFiOXY2?=
 =?utf-8?B?R3dSSDBqd2FBV0IrWUhhSFhhNndTY3E4OTlyU0l1WW9LOU5ISUFUSkFwa0lH?=
 =?utf-8?B?c1lydEd5eXhZYUc5eTNjMjlycmNtbWxpYzEyNlpiMHkrZVFqWjRDTE9vaHdB?=
 =?utf-8?B?b1J4cis4b240WGtZK29mRmFVcFJmL05TVG8yL0ZhUGd0SmZYazE4RzZLSitm?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3752BA6C327D543AED08A612BDD302C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e3beef-2355-40cd-90d8-08dc4e436f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 09:51:11.9888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdybEoZKNb6egDobJLWZHAUtOJ5iAUXt9KO0fc+HUTeXmXFmNXwjp+mXfBhvl/JDo/EbRHSmTTf6K7dSIOM+uRSggrj7wYXBaCeohPbV+M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6886
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.963400-8.000000
X-TMASE-MatchedRID: Xkw7PMv+UUXUL3YCMmnG4gLZZHfPgUBPjLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo29UVHiwLx0/IxmbT6wQT2aw6QlBHhBZuw5eX
	8PPkQnowA2RE7+cEvhWk5x2oaTnVUO/TM4zIYP/HZR3/Wd6mSk6APS3vFyaW6EwE+ZrvyQeerl7
	44dJIMXNivMxyivZ7H8AvsmPyKUTgrYainbx8zkmw+ImH2wqNjnvBHr/aFnM5fXk0kfCOnbs+cw
	CLpvDnEwCvw6cgh9GQQkEWOYEwCV3BuE9LemwIWY1bQMCMvmn619kcMOF8gVyz+5QCTrE/sdyG0
	kjowQuMyVRDcQBa7IC2EoE4opjGR2v02uJpYZ8MbmaDSnOqZfnMeZN8H36Iz82HMiBe0UlXUZkF
	1QAMbmQcFk0jN46CMvF0nfNkNDAVAR00KFNNstV0inMD086vyNNuh+5zmS6+IrS6rLgqPm6PFjJ
	EFr+olFUew0Fl/1pEBi3kqJOK62QtuKBGekqUpI/NGWt0UYPCrIF0AmhkUA0RyWuirEzuaGbNZo
	V4fIuscsDTBNt919HgyfO92pZKz
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.963400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	81EC4BF2B5F360ED485C137D3E1D497D6F4D685DDF6F79FAC269BBFD398C35B12000:8

T24gVGh1LCAyMDI0LTAzLTIxIGF0IDE5OjI5ICswMzAwLCBBcsSxbsOnIMOcTkFMIHZpYSBCNCBS
ZWxheSB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBGcm9tOiBBcsSxbsOnIMOcTkFMIDxhcmluYy51
bmFsQGFyaW5jOS5jb20+DQo+IA0KPiBUaGUgY29tbWl0IDQwYjVkMmYxNWMwOSAoIm5ldDogZHNh
OiBtdDc1MzA6IEFkZCBzdXBwb3J0IGZvciBFRUUNCj4gZmVhdHVyZXMiKQ0KPiBicm91Z2h0IEVF
RSBzdXBwb3J0IGJ1dCBkaWQgbm90IGVuYWJsZSBFRUUgb24gTVQ3NTMxIHN3aXRjaCBNQUNzLiBF
RUUNCj4gaXMNCj4gZW5hYmxlZCBvbiBNVDc1MzEgc3dpdGNoIE1BQ3MgZWl0aGVyIGJ5IHB1bGxp
bmcgdGhlIExBTjJMRUQwIHBpbiBsb3cNCj4gb24gdGhlDQo+IGJvYXJkIChib290c3RyYXBwaW5n
KSwgb3IgdW5zZXR0aW5nIHRoZSBFRUVfRElTIGJpdCBvbiB0aGUgdHJhcA0KPiByZWdpc3Rlci4N
Cj4gDQo+IFRoZXJlIGFyZSBleGlzdGluZyBib2FyZHMgdGhhdCB3ZXJlIG5vdCBkZXNpZ25lZCB0
byBwdWxsIHRoZSBwaW4gbG93Lg0KPiBUaGVyZWZvcmUsIHVuc2V0IHRoZSBFRUVfRElTIGJpdCBv
biB0aGUgdHJhcCByZWdpc3Rlci4NCj4gDQo+IFVubGlrZSBNVDc1MzAsIHRoZSBtb2RpZmlhYmxl
IHRyYXAgcmVnaXN0ZXIgd29uJ3QgYmUgcG9wdWxhdGVkDQo+IGlkZW50aWNhbCB0bw0KPiB0aGUg
dHJhcCBzdGF0dXMgcmVnaXN0ZXIgYWZ0ZXIgcmVzZXQuIFRoZXJlZm9yZSwgcmVhZCBmcm9tIHRo
ZSB0cmFwDQo+IHN0YXR1cw0KPiByZWdpc3RlciwgbW9kaWZ5IHRoZSBiaXRzLCB0aGVuIHdyaXRl
IHRvIHRoZSBtb2RpZmlhYmxlIHRyYXANCj4gcmVnaXN0ZXIuDQo+IA0KPiBNeSB0ZXN0aW5nIG9u
IE1UNzUzMSBzaG93cyBhIGNlcnRhaW4gYW1vdW50IG9mIHRyYWZmaWMgbG9zcyB3aGVuIEVFRQ0K
PiBpcw0KPiBlbmFibGVkLiBUaGF0IHNhaWQsIEkgaGF2ZW4ndCBjb21lIGFjcm9zcyBhIGJvYXJk
IHRoYXQgZW5hYmxlcyBFRUUuDQo+IFNvDQo+IGVuYWJsZSBFRUUgb24gdGhlIHN3aXRjaCBNQUNz
IGJ1dCBkaXNhYmxlIEVFRSBhZHZlcnRpc2VtZW50IG9uIHRoZQ0KPiBzd2l0Y2gNCj4gUEhZcy4g
VGhpcyB3YXksIHdlIGRvbid0IGNoYW5nZSB0aGUgYmVoYXZpb3VyIG9mIHRoZSBtYWpvcml0eSBv
ZiB0aGUNCj4gYm9hcmRzDQo+IHRoYXQgaGF2ZSB0aGlzIHN3aXRjaC4NCj4gDQo+IFdpdGggdGhp
cyBjaGFuZ2UsIEVFRSBjYW4gbm93IGJlIGVuYWJsZWQgdXNpbmcgZXRodG9vbC4NCj4gDQo+IFRo
ZSBkaXNhYmxlIEVFRSBiaXQgb24gdGhlIHRyYXAgcGVydGFpbnMgdG8gdGhlIExBTjJMRUQwIHBp
biB3aGljaCBpcw0KPiB1c3VhbGx5IHVzZWQgdG8gY29udHJvbCBhbiBMRUQuIE9uY2UgdGhlIGJp
dCBpcyB1bnNldCwgdGhlIHBpbiB3aWxsDQo+IGJlIGxvdy4NCj4gVGhhdCB3aWxsIG1ha2UgdGhl
IGFjdGl2ZSBsb3cgTEVEIHR1cm4gb24uDQo+IA0KPiBUaGUgcGluIGlzIGNvbnRyb2xsZWQgYnkg
dGhlIHN3aXRjaCBQSFkuIEl0IHNlZW1zIHRoYXQgdGhlIFBIWQ0KPiBjb250cm9scyB0aGUNCj4g
cGluIGluIHRoZSB3YXkgdGhhdCBpdCBpbnZlcnRzIHRoZSBwaW4gc3RhdGUuIFRoYXQgbWVhbnMg
ZGVwZW5kaW5nIG9uDQo+IHRoZQ0KPiB3aXJpbmcgb2YgdGhlIExFRCBjb25uZWN0ZWQgdG8gTEFO
MkxFRDAgb24gdGhlIGJvYXJkLCB0aGUgTEVEIG1heSBiZQ0KPiBvbg0KPiB3aXRob3V0IGFuIGFj
dGl2ZSBsaW5rLg0KPiANCj4gRml4ZXM6IDQwYjVkMmYxNWMwOSAoIm5ldDogZHNhOiBtdDc1MzA6
IEFkZCBzdXBwb3J0IGZvciBFRUUNCj4gZmVhdHVyZXMiKQ0KPiBSZXZpZXdlZC1ieTogRmxvcmlh
biBGYWluZWxsaSA8Zmxvcmlhbi5mYWluZWxsaUBicm9hZGNvbS5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IEFyxLFuw6cgw5xOQUwgPGFyaW5jLnVuYWxAYXJpbmM5LmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL25ldC9kc2EvbXQ3NTMwLmMgfCAxNCArKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9uZXQv
ZHNhL210NzUzMC5oIHwgIDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL210NzUzMC5jIGIvZHJpdmVycy9u
ZXQvZHNhL210NzUzMC5jDQo+IGluZGV4IDY3OGI1MWY5Y2VhNi4uNmFhOTliNTkwMzI5IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvbXQ3NTMwLmMNCj4gKysrIGIvZHJpdmVycy9uZXQv
ZHNhL210NzUzMC5jDQo+IEBAIC0yNDU4LDYgKzI0NTgsMjAgQEAgbXQ3NTMxX3NldHVwKHN0cnVj
dCBkc2Ffc3dpdGNoICpkcykNCj4gIC8qIFJlc2V0IHRoZSBzd2l0Y2ggdGhyb3VnaCBpbnRlcm5h
bCByZXNldCAqLw0KPiAgbXQ3NTMwX3dyaXRlKHByaXYsIE1UNzUzMF9TWVNfQ1RSTCwgU1lTX0NU
UkxfU1dfUlNUIHwNCj4gU1lTX0NUUkxfUkVHX1JTVCk7DQo+ICANCj4gKy8qIEFsbG93IG1vZGlm
eWluZyB0aGUgdHJhcCBhbmQgZW5hYmxlIEVuZXJneS1FZmZpY2llbnQgRXRoZXJuZXQNCj4gKEVF
RSkuDQo+ICsgKi8NCj4gK3ZhbCA9IG10NzUzMF9yZWFkKHByaXYsIE1UNzUzMV9IV1RSQVApOw0K
PiArdmFsIHw9IENIR19TVFJBUDsNCj4gK3ZhbCAmPSB+RUVFX0RJUzsNCj4gK210NzUzMF93cml0
ZShwcml2LCBNVDc1MzBfTUhXVFJBUCwgdmFsKTsNCllvdSBtYXkgdHJ5IHRvIHNldCBiaXQgNiBv
ZiBDTDQ1IHJlZ2lzdGVyIGRldj0weDFmLA0KcmVnPTB4NDAzKFBMTF9HUk9VUF9DVExfUkVHKSwg
d2hpY2ggaXMgYW4gaW50ZXJuYWwgRUVFIHN3aXRjaCBjYWxsZWQNClJHX1NZU1BMTF9ETVkyLg0K
DQpSZWFkIGl0IG91dCBmaXJzdCB3aXRoICJzd2l0Y2ggY29tbWFuZCIsIGlmIHlvdSBoYXZlIGl0
Og0Kcm9vdEBPcGVuV3J0Oi8jIHN3aXRjaCBwaHkgY2w0NSByIDAgMHgxZiAweDQwMw0KICBQaHkg
cmVhZCBkZXZfbnVtPTB4MWYsIHJlZz0weDQwMywgdmFsdWU9MHgxMDkxDQoNCkFuZCB0aGVuIHNl
dCBiaXQgNjoNCnJvb3RAT3BlbldydDovIyAkIHN3aXRjaCBwaHkgY2w0NSB3IDAgMHgxZiAweDQw
MyAweDEwZDENCnJvb3RAT3BlbldydDovIyBldGh0b29sIC0tc2V0LWVlZSBsYW4xIGVlZSBvbiB0
eC1scGkgb24gdHgtdGltZXIgMHgxZQ0KYWR2ZXJ0aXNlIDB4MjgNCnJvb3RAT3BlbldydDovIyBz
d2l0Y2ggcGh5IGNsNDUgciAwIDB4NyAweDNjDQogUGh5IHJlYWQgZGV2X251bT0weDcsIHJlZz0w
eDNjLCB2YWx1ZT0weDYNCg0KVGhlbiB5b3Ugc2hvdWxkIGJlIGFibGUgdG8gZW5hYmxlIEVFRSB2
aWEgZXRodG9vbCB3aXRob3V0IGNsZWFyaW5nDQpFRUVfRElTIGJpdCBvZiBNVDc1MzBfSFdUUkFQ
Lg0KSWYgYWJvdmUgQ0w0NSBjb21tYW5kIGlzIGdvb2QgZm9yIHlvdSwgSSB0aGluayB0aGlzIGNh
biBiZSBtb3ZlZCB0bw0KbXRrX2dlcGh5X2NvbmZpZ19pbml0KCkgQCBtZWRpYXRlay1nZS5jLCB3
aGljaCB3aWxsIGxlYWQgdG8gY2xlYW5lcg0KaW1wbGVtZW50YXRpb24uDQo+ICsNCj4gKy8qIERp
c2FibGUgRUVFIGFkdmVydGlzZW1lbnQgb24gdGhlIHN3aXRjaCBQSFlzLiAqLw0KPiArZm9yIChp
ID0gTVQ3NTNYX0NUUkxfUEhZX0FERFI7DQo+ICsgICAgIGkgPCBNVDc1M1hfQ1RSTF9QSFlfQURE
UiArIE1UNzUzMF9OVU1fUEhZUzsgaSsrKSB7DQo+ICttdDc1MzFfaW5kX2M0NV9waHlfd3JpdGUo
cHJpdiwgaSwgTURJT19NTURfQU4sIE1ESU9fQU5fRUVFX0FEViwNCj4gKyAwKTsNCj4gK30NClNv
cnJ5LCBJIHN0aWxsIGNhbid0IGZpZ3VyZSBvdXQgd2h5IHRoaXMgaXMgbmVlZGVkIHNpbmNlIHdl
IGRpc2FibGUNCk1ESU9fQU5fRUVFX0FEViBpbiBtZWRpYXRlay1nZS5jIGFmdGVyIHJlYWRpbmcg
cHJldmlvdXMgdGhyZWFkcy4gV291bGQNCnlvdSBwbGVhc2UgcHJvdmlkZSBzb21ldGhpbmcgZWxz
ZSAobGlrZSBkbWVzZyBsb2c/KSB0byBzaG93IHRoYXQNCnNldHRpbmdzIGluIG10a19nZXBoeV9j
b25maWdfaW5pdCgpIG1heSBmYWlsPw0KPiArDQo+ICBpZiAoIXByaXYtPnA1X3NnbWlpKSB7DQo+
ICBtdDc1MzFfcGxsX3NldHVwKHByaXYpOw0KPiAgfSBlbHNlIHsNCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2RzYS9tdDc1MzAuaCBiL2RyaXZlcnMvbmV0L2RzYS9tdDc1MzAuaA0KPiBpbmRl
eCBhNzExNjZlMGE3ZmMuLjUwOWVkNTM2MjIzNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQv
ZHNhL210NzUzMC5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9tdDc1MzAuaA0KPiBAQCAtNDU3
LDYgKzQ1Nyw3IEBAIGVudW0gbXQ3NTMxX2Nsa19za2V3IHsNCj4gICNkZWZpbmUgIFhUQUxfRlNF
TF9NQklUKDcpDQo+ICAjZGVmaW5lICBQSFlfRU5CSVQoNikNCj4gICNkZWZpbmUgIENIR19TVFJB
UEJJVCg4KQ0KPiArI2RlZmluZSAgRUVFX0RJU0JJVCg0KQ0KPiAgDQo+ICAvKiBSZWdpc3RlciBm
b3IgaHcgdHJhcCBtb2RpZmljYXRpb24gKi8NCj4gICNkZWZpbmUgTVQ3NTMwX01IV1RSQVAweDc4
MDQNCj4gDQo+IC0tIA0KPiAyLjQwLjENCj4gDQo+IA0K

