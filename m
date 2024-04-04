Return-Path: <linux-kernel+bounces-131357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5698986AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D04D1C24FF1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAA18592E;
	Thu,  4 Apr 2024 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Dy6V8SpL"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0240684FC8;
	Thu,  4 Apr 2024 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232024; cv=fail; b=AFSoxk+NXERk5SAm2zCpcma/0clzoehfeYZq0LKGpu6IHex3plOJ2zhOcSLANAJ2cLdumtUScu/GwmL/aVUJVhjaI2huvABa9tf73fKMZk8aQE5z7kLdZS0CFVnorH4H3gy7faYXSj1Bhj6NZkOIl17aq82XJ6AaRlHdmeraZXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232024; c=relaxed/simple;
	bh=InlPW5xXIyT7uBQBYqXWC+yKGeFrc8qL7XTwHMM8AKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VJjcRVMqWICfxJNsGUg/RUsAGr0g+Y28YxOYXidVAg4Iw0h8Ua4nV7EVJyrdCY2TEt/J3gwLkhXFfP2sDeOpke1Pl2dbR9K58YlMWq+xamRfAtbxChwTEmwMqtZ9UuDiIuhBF2WplNgWSfR9Gi0qv4MP5g4dkZZxiFILZ4M9q6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Dy6V8SpL; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434B5MWu025088;
	Thu, 4 Apr 2024 04:59:41 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x9em4j3st-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 04:59:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMjT+Tid+E7C3F7BEdzq27N4brtaFXdMlOJcJXNWj7ajOBF5RLQRE0Lm1LzNKQU4TttGBRlqIx2hG3pTbnWgyUPKqI50UllEux81guntgIEr53ht4BJP3i9YsZLVVLsfyqpKbFXbUpDWhhL1639K2gzkVs0kpe9XsD2UDwKKX8uLWsZ5kV5Hu0luArTp648oGDHqrHOxy6jAObq/PZR+j27lYlTP0r/1skquM7fvOmXwyFqlCVMzcTtSmjL4XcPEBLh5/mMt8dFaNO5C1qtepGH/nXXyBpxCzxdlJ/IRhLExHzlT+YlCNCi6qleDF7Mz6wpRY2y99V5du1JfVuurCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDPSAWSwfnTZArYexH9zq1yU9vYAepXw2UrgkkRuNpw=;
 b=Zbje2aGBKFYKOl75Z2rbd+v3jKVRHfqaBSrhbt0f8NXuu1qdGYwxzY+0P6eFo56fxQixxF5bJT0AQRkfBHI0TWjoVOamGN6BYeWpQeOCaT6lF48XLOeDlZ/yJvRhw33d5XU47ydm26XfPW/fYwdIJBxnFmDEADP+zB/DvCuUG12vFUgLCRZYy0obi85eICKVX6WBlyPGw/esFPTyrJsVGPvUySyIdyZPXOoHlx5rkIhs7FH5Buc7iEcAdf+U0yez3FSIBSUUtDPk7mRyq2zsUiefJJX01f6/eVyBEcML0gvg9FStokbxNexm9zTZxjC5vjD7L5vaeb8P1475R9O5Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDPSAWSwfnTZArYexH9zq1yU9vYAepXw2UrgkkRuNpw=;
 b=Dy6V8SpL4dv1VDPd5q990XczeAUWw2nyNhVNClFGZ1m15UpBafCEj5WrJU7MIhhf7yAuhLRLwzTXloLc/N43EsOAYF7YH9caI+yUxFlcUwMdh44M8gpiqkdSR9N9s65OfCmBiCX/htHdvBUpNtNgStnu+8ISdNHq73Z3dsQL4pQ=
Received: from BL1PR18MB4248.namprd18.prod.outlook.com (2603:10b6:208:311::15)
 by DM4PR18MB5449.namprd18.prod.outlook.com (2603:10b6:8:180::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 11:59:35 +0000
Received: from BL1PR18MB4248.namprd18.prod.outlook.com
 ([fe80::1aec:98f1:125e:8fbb]) by BL1PR18MB4248.namprd18.prod.outlook.com
 ([fe80::1aec:98f1:125e:8fbb%2]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 11:59:35 +0000
From: Elad Nachman <enachman@marvell.com>
To: Breno Leitao <leitao@debian.org>,
        "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "elder@kernel.org" <elder@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "Mark-MC.Lee@mediatek.com"
	<Mark-MC.Lee@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Taras
 Chornyi <taras.chornyi@plvision.eu>
CC: "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "dennis.dalessandro@cornelisnetworks.com"
	<dennis.dalessandro@cornelisnetworks.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net-next v3 2/5] net: marvell: prestera:
 allocate dummy net_device dynamically
Thread-Topic: [EXTERNAL] [PATCH net-next v3 2/5] net: marvell: prestera:
 allocate dummy net_device dynamically
Thread-Index: AQHahoZqP8FVQ8wG0EWJ9wkRDreQkrFYAftg
Date: Thu, 4 Apr 2024 11:59:35 +0000
Message-ID: 
 <BL1PR18MB42485B5BE1D65A5E4BFFAD66DB3C2@BL1PR18MB4248.namprd18.prod.outlook.com>
References: <20240404114854.2498663-1-leitao@debian.org>
 <20240404114854.2498663-3-leitao@debian.org>
In-Reply-To: <20240404114854.2498663-3-leitao@debian.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR18MB4248:EE_|DM4PR18MB5449:EE_
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YkO/3RaYjgXQeU2sHefCYtrBpZYmIP4KXBznzZjEhhbi0hd/uY7Q4dgIzOGWDWBC2QicSuYb2DqAIPFhNIqQD0yPK5yrSHJvWPdVsXJplPaNa6c/8smtMzrcu7BmHwNvWgnzMWHeEBCN4f76VItHa1p2U6JmSnzUR62UiyZDRqa/AkMi65l0AyMpPXkG/UGpg88GNW9cBCrs6xxcg1FtU8HYOHlOW7472hRCTmLlgKjILEbtw6KQHhsUKaUsmMx+X8KLYIcz0e0S1pyzDBK0BtA1pNF1pYw7Yw4k09uP9yNB/LWiY6giICfeamPd3wFMKUuBR87d5lo77P+rSN162fweO5L14xZqwwpOIror8LZKDRFvieUPzE2jt/tKDKwvrp8l6BL1oE0fMrK/9naTlBZsOkd4ZLJOnYzGQa7yjXXXFG5ay0KM+azsnixsm8O2ky+B0i2ck2OQiiwlsbw6T2qNO5CSTBYrZ8Ti+/NIvK5SoS99zqea0/JYzpPsdj5bw9TpiV0q6lioUkU36xNgvQ+Rr6TtfuHYfh2yC2wJExrwIYgXl6vJHNfuPmKAUr1tJqrpjiuF3RBG+VROurlwsEmz1GAFG+IaPZ3XBHf4N6r5W6V+RLsYgf1CtYxRbOOKR1qja4yXtHV+H8EYhBqojQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR18MB4248.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?bm6xj5h0/eB2hBqqtFqpNizBrGt8vWDGLOO9sQ7jDEv0VF/3FI4QOWH+0g23?=
 =?us-ascii?Q?6Z2rGtljgvODKWmOYloBWwSb+G8cHfvh80QitNpgNsILEij3eKYDZGbgQT+H?=
 =?us-ascii?Q?jZAx5vjvrn+Nm80LIUyjLL70b2w6koaDNwTEv0DQx2HKLpRukJU3hsdpOT72?=
 =?us-ascii?Q?ZM3X2Ycb7TlGYN+nlu7hGqAxp+v/3Z9FC55QtQOqYk1Jm3M7DntuY+IUEkT6?=
 =?us-ascii?Q?VSQMvRb2lTXbpgzBpPLBMt2pXb51xgUz2xR3F7L6/dJPjsf6WDzlVBZAssKG?=
 =?us-ascii?Q?dvb72zeCCyMM3gExPbqufBUWJVw5QdkiIYrhUBJfVDav0SKiTbXqbh7SVNNJ?=
 =?us-ascii?Q?jECA9GWYwxD1q/1HdUmx7CIiePA6CCImVH2pikXhdXTN8rz8Rcypzl9p2QTL?=
 =?us-ascii?Q?zyT6ybYLb4gEIpwm1CiqJDx+fkFT+8TA6NlTcuPT4p0rbnyuo1HbmBC8QEhT?=
 =?us-ascii?Q?G/yCNJEM2j00ucceFUNvwluuWKA0U9cx3BwvmzWspcnM4Z4ZBnkd7/qjscVy?=
 =?us-ascii?Q?n/QT1M70U77KUsa0Bj5LHARzOJQMgHJ4ZeiP9yD3FjThLlV2p553VAbcgZDy?=
 =?us-ascii?Q?7eamCetGp68vGwtC+HzXTaD/viO6/oBJdEmAg/3lHKKkNHC0CjAR/mfXLEGW?=
 =?us-ascii?Q?2euY/5OMzrfRFFQzugvdicQG0wzM7DQd8BMpmpnfv5KbGltDpcogXlM7f6+B?=
 =?us-ascii?Q?yxK4x0wXNeQXit/wj6rOe7chTZ7PWEW8MNTJuIPwLixINsg51/4K1RHk+ue4?=
 =?us-ascii?Q?E/PBMCNGFM3092+JOrvvJll66T1Aci5Pez3cVtXXqDl/iJlrGVAo8QYSExGO?=
 =?us-ascii?Q?Qur5C3hjeYeoY8rT00CGAAjTfAlSszWbp6KLvECopSTqQr7NCqVxvEi1x0N0?=
 =?us-ascii?Q?7Aa2+0wdyvdxNuiSqBe2RmWtThRQLPr8okT5aDl6xDFaz4H3+6NQuTFFdv6u?=
 =?us-ascii?Q?HAXNlGu2prfGNOBWnlxZHlKFOs5wtmDbPsWvvp5xXkuaPyXi04dOHAQd7We1?=
 =?us-ascii?Q?jUSJd1uJO8Te9NzoMSHxXvmnOTpQMfIQQTEPJnn9Yx2zPYKi9X/8QDqxQdcV?=
 =?us-ascii?Q?2Y2YrYaoTw2a9dgSUU/sF05g4Kcpa5fRpNgwjMQIFiO87AN5MxZR4LFgyoz/?=
 =?us-ascii?Q?pNqzh6qGkNemviEFQ2JWfz8VzW8sobX/nEM42Q50Eq1ZuOiJgQwO/ITny49g?=
 =?us-ascii?Q?xNJuP2W/adRBGtbvSYiIX9q0mlJTXl0KtP86MBd7xLlSupsvtTnJJeUNmRAC?=
 =?us-ascii?Q?US5dpNtUBzRTiOazlSjDlZbDSyaER2LiUGN4DX6X5bde68pOre57ZPyHxODm?=
 =?us-ascii?Q?btM71aFJagrZOletp200VmjbAeeu1rRBhmSLqApfih85iQpbWzW6hG1wfV4N?=
 =?us-ascii?Q?3NFhnCvbOwnDhftoiycHFF/+jFiO5wl7SdG3CgbWYQjXVzae27Q4FOGXDwMR?=
 =?us-ascii?Q?wtbOJ0S0w03V18sZZ9obnHx5IbM3QC1h9B8zSnTlZXxsVmxlyokEMZJZZ/1i?=
 =?us-ascii?Q?tfvBcFn25B7TK5MBlF/Z3+JTT3s+QFE+AeD5cJCvOAidVH7GaDcwb9uoZRo+?=
 =?us-ascii?Q?7IT+oRq00U3/dDzbUMoq1DKICo4QSPRC0a8JrOaHS0Foko+Ia918vQKPtayW?=
 =?us-ascii?Q?6d8COoqOnC36x7ve7ihrOEV7upVDUvVdMq8n2eduk5kO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR18MB4248.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc65f80-31cf-439f-3411-08dc549eb244
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 11:59:35.1707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ha22FzKSmSDhfu5WB4jv4fXuWk3yKFq1gY6pchfdavoYKfwpoRWharb0QevipPb91Geo87D1oBexLt8/nlXhJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5449
X-Proofpoint-ORIG-GUID: OYo3Zh_de3VvhoORAxnAbfcn4934T1cO
X-Proofpoint-GUID: OYo3Zh_de3VvhoORAxnAbfcn4934T1cO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_08,2024-04-04_01,2023-05-22_02



> -----Original Message-----
> From: Breno Leitao <leitao@debian.org>
> Sent: Thursday, April 4, 2024 2:49 PM
> To: aleksander.lobakin@intel.com; kuba@kernel.org; davem@davemloft.net;
> pabeni@redhat.com; edumazet@google.com; elder@kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-mediatek@lists.infradead.org;
> nbd@nbd.name; sean.wang@mediatek.com; Mark-MC.Lee@mediatek.com;
> lorenzo@kernel.org; Taras Chornyi <taras.chornyi@plvision.eu>
> Cc: quic_jjohnson@quicinc.com; kvalo@kernel.org; leon@kernel.org;
> dennis.dalessandro@cornelisnetworks.com; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org; bpf@vger.kernel.org
> Subject: [EXTERNAL] [PATCH net-next v3 2/5] net: marvell: prestera: alloc=
ate
> dummy net_device dynamically
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> Embedding net_device into structures prohibits the usage of flexible arra=
ys in
> the net_device structure. For more details, see the discussion at [1].
>=20
> Un-embed the net_device from the private struct by converting it into a
> pointer. Then use the leverage the new alloc_netdev_dummy() helper to
> allocate and initialize dummy devices.
>=20
> [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__lore.kernel.org_all_20240229225910.79e224cf-
> 40kernel.org_&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DeTeNTLEK5-
> TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=3D8Fqw_UUg1WoXjQcCjAtMa9J6QAd
> lmUzCuk3nWriMXtYMbgBqNpdDSO4rBUanJDxw&s=3DlXBodHe9jPOjWAOTFCjnZ
> 2ZDZYoF79OGsWN38gbxhTE&e=3D
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  .../net/ethernet/marvell/prestera/prestera_rxtx.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c
> b/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c
> index cc2a9ae794be..39d9bf82c115 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c
> @@ -96,7 +96,7 @@ struct prestera_sdma {
>  	struct dma_pool *desc_pool;
>  	struct work_struct tx_work;
>  	struct napi_struct rx_napi;
> -	struct net_device napi_dev;
> +	struct net_device *napi_dev;
>  	u32 map_addr;
>  	u64 dma_mask;
>  	/* protect SDMA with concurrent access from multiple CPUs */ @@ -
> 654,13 +654,21 @@ static int prestera_sdma_switch_init(struct
> prestera_switch *sw)
>  	if (err)
>  		goto err_evt_register;
>=20
> -	init_dummy_netdev(&sdma->napi_dev);
> +	sdma->napi_dev =3D alloc_netdev_dummy(0);
> +	if (!sdma->napi_dev) {
> +		dev_err(dev, "not able to initialize dummy device\n");
> +		err =3D -ENOMEM;
> +		goto err_alloc_dummy;
> +	}
>=20
> -	netif_napi_add(&sdma->napi_dev, &sdma->rx_napi,
> prestera_sdma_rx_poll);
> +	netif_napi_add(sdma->napi_dev, &sdma->rx_napi,
> prestera_sdma_rx_poll);
>  	napi_enable(&sdma->rx_napi);
>=20
>  	return 0;
>=20
> +err_alloc_dummy:
> +	prestera_hw_event_handler_unregister(sw,
> PRESTERA_EVENT_TYPE_RXTX,
> +					     prestera_rxtx_handle_event);
>  err_evt_register:
>  err_tx_init:
>  	prestera_sdma_tx_fini(sdma);
> @@ -677,6 +685,7 @@ static void prestera_sdma_switch_fini(struct
> prestera_switch *sw)
>=20
>  	napi_disable(&sdma->rx_napi);
>  	netif_napi_del(&sdma->rx_napi);
> +	free_netdev(sdma->napi_dev);
>  	prestera_hw_event_handler_unregister(sw,
> PRESTERA_EVENT_TYPE_RXTX,
>  					     prestera_rxtx_handle_event);
>  	prestera_sdma_tx_fini(sdma);
> --
> 2.43.0
>=20

Acked-by: Elad Nachman <enachman@marvell.com>


