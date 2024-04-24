Return-Path: <linux-kernel+bounces-156547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37BB8B045F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8278E1F241FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B7C156C7F;
	Wed, 24 Apr 2024 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="jjF3RS/7"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7072C1420D3;
	Wed, 24 Apr 2024 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947556; cv=fail; b=Xn2QqS8dBL36NImCanX8qACWRgVBZt3tiCnnYqmrgjp7n7rbXt29EK6HqAQCwoyBBkMAf+B2Mal8lV6hDpETIvuAUc1qbXHgfmTvoV+wJ6+pd/ib//wv56cn2FA4ASOcu0f5+Z9muoLXuvBUsjDBuARHa2Nmaf0nJMMs2AvxEG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947556; c=relaxed/simple;
	bh=pSTs6TJP6THeml6/l+ZwJSBJVUyXPsAYrruTc8d3lb4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tnm8fE3ou7JfWUAMm6zNPTH8P9H9zim+HO5MIGgHQk8//VxGC3jWflTamY0d4C6EUlIKU+dKktDP+1piQZKF/RBTtenTznQbPEshXHZAAJUchJAcnzGRx9bD641kDI0dvpaVus8bPOIsi/7bM5rsutSEIz6rPr5/0F80CIndnAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=jjF3RS/7; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O8W2oI012478;
	Wed, 24 Apr 2024 01:32:26 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xpxn18025-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 01:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSP3nlYZLTx87GEk54w6sRyN6K2vdfyVH/xvZ257ES57UibwV9ifwKU2kc7ryJnf63emE1vtPEXRQA2HvaWStSfzWUp8WLuLWrjj6yljtJq0ecVBME9CpnfRW+Z6bd0HsNML2s4mVgy0eoKegitZhPnIySRujuv0EGQvBwzjaEwXyzR+w4kQLIHWtWtJYSd8SHUSekkbdHdrLsgRmtA95r1aNoKDrwC2Gd/TAsHw6uRFE2mILgb9itqjycYrnRllSd9vylFf+Y6SrR+HwlGPDKouun++uRmZolvZSKu0xg3Zw2/DJrbK2CttA/DkEcsQ4YdmlY+O2eJGdjLCuz6DMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQ82Anfa8866/huNgdp+N68nTTeHMqDoHVva5xgBpsM=;
 b=YufZs/Gi3XxG9qEUJZDniXt8cP8H6ESIHkDspBU2b8hqiuLaV0w4p9/BS7yOd8gpS0H3Y614VF1uACoRk44x4FFdh3S70YqSgkJ1huwVZmukTX1Z+c/PWA1AXR3X0y5zxPaaTN2Kb7fjc6D4l1YvXwg9a/va6qRI1LnFloWpklQKP4Ct+KqHeQJlVG1frLVR37xh5pHdi0TMPKdbreno7hy6oNQyBH2iXZhD4Z1+BuI9xXXcejn1wNpMOXAt2MLDJpUU8FANlFmI+i31Q17rrXcCzEksMgClP9qyOdZQsdenyWzpZ5LJrdmu0i3A5G/ju/11RRZJAWE7eBYiCJUdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQ82Anfa8866/huNgdp+N68nTTeHMqDoHVva5xgBpsM=;
 b=jjF3RS/7zXMDFw/8I10yxmzNcFEe0iMPtEh9n+x9a+APfUXPeIYnVPxFhIhYDcYZaSdFztIVRb/G+OIb74vxhZlQA4rAMkTnCYUjpEMXflsXBTnZ/+Ii2kCKAk9FQ5WD3UVlvqor36FgDidj9CzchCIy+ox8d4VWt3e4xOFdppY=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by SJ0PR18MB4883.namprd18.prod.outlook.com (2603:10b6:a03:40a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:32:23 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::1f55:2359:3c4d:2c81]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::1f55:2359:3c4d:2c81%5]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 08:32:23 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>
Subject: Re: [net-next PATCH v2] octeontx2-pf: Add ucast filter count
 configurability via devlink.
Thread-Topic: [net-next PATCH v2] octeontx2-pf: Add ucast filter count
 configurability via devlink.
Thread-Index: AQHaliHuy+VRqHz+okuwEwJ8Kj9CHA==
Date: Wed, 24 Apr 2024 08:32:23 +0000
Message-ID: 
 <BY3PR18MB47073B7DAB65F1DAEBD92C11A0102@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240418190031.1115865-1-saikrishnag@marvell.com>
 <20240422141845.108b9c87@kernel.org>
In-Reply-To: <20240422141845.108b9c87@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|SJ0PR18MB4883:EE_
x-ms-office365-filtering-correlation-id: 03b6df0a-de57-4c29-c27e-08dc643910db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?s+5isR4C7MLsWiy/EBk6NTJI8KtACEHa1RO72QV5ZLn9v/kKTML/z8r5VdyF?=
 =?us-ascii?Q?ioxX539TNf08b7nF6lmXbWoel+SVG8ETsPCRHlelNn4v65zwfmV0J6z0gYzE?=
 =?us-ascii?Q?GfxSN9gt71LfRnIw3Pu8cRRELE5mE2nqg52pVgx18Kii5qCWqHyvGdiJNGcp?=
 =?us-ascii?Q?+GE8kUpRIvFFYLywgBBnhcrx2p3G3God1as66lRSAV5niJH6ulRFVLZ8dgL4?=
 =?us-ascii?Q?Lw9PxqnhAR47L/jtwYkvHsYIpXwtHmPQ3M5sILL9LAyYO1COjM7O4vsXZxmm?=
 =?us-ascii?Q?3tdTj8g53VL8xsKtxZGnTF3oif7RiHr9Kheb8D+GuLcea+xSPY3dVecuYLAC?=
 =?us-ascii?Q?kYSQLgTYg6CuJAwElbs0h4IPLY4lzFHjQJo7KOWxVA88Pbgqs58UGS9S3QjG?=
 =?us-ascii?Q?KXIVciyBndScNyAgzhYg4ah2jXr1ObWs8DqVciLfzFKuLbMUEuUEv3m5Y/+Y?=
 =?us-ascii?Q?Ev5Z4AhyUiYzO8hdTdUO1H9Ch0WI7/3kRo5QjQYT6pz/MbdJZ4wIOpTP9HYT?=
 =?us-ascii?Q?aAJD77Hg9OQldmzbOaroRCuFZl4fxGL18ARnujAWn57imsLH8eAe67KhnZ4F?=
 =?us-ascii?Q?HAmoVwWGNCuKLZgrel3AiiS/awMZdTY7RTRusDf50rf/tdv06QdMqENKnLml?=
 =?us-ascii?Q?cZ83g66Biaf+EYEp8HM39ejp0lZ0Hf3Oz0SDLeoHTB2nrVxv4mD3YpfuMYxt?=
 =?us-ascii?Q?triCTIn5FSd82XdRbdnhutNhlcmK2I+irFF/ATgWULUlb3QeFf0UPglk6Mkn?=
 =?us-ascii?Q?KDpIJxkFRRex5ml24/oN0u+RfYrtSyZpBk6s39BeF5S+D7cEUUKg9aqSou2F?=
 =?us-ascii?Q?jnMFbc7M2yQLHaFAZxHWo7os1LYCF1UaprGkmuAsbyDeTtaeVJbj/U67aTb+?=
 =?us-ascii?Q?Smj+pX2W1BX+I2uTp2kSP+ylkLlhQAuKZg0onxb3DT22FBJ7XKTE9xgC+N3/?=
 =?us-ascii?Q?t4dutnkeGgZO5fQgtYwarlQB31I6sHsI4yg5qzApIvfz+5Xcr6zIZo9eRFSI?=
 =?us-ascii?Q?JLRyAy7mrrIMkDFPAbEVIc6f5xrhQgStS42SlPTLV5pz3smvGby7cabd3Hs2?=
 =?us-ascii?Q?GQ5RWUcKqNHCBZdNBikuhmiy4ABA74rYThdBUft7YmiX1p1uNo1Xid7HfAmE?=
 =?us-ascii?Q?FhQ08Q9grD2ITTqn3yM8UQAUlmH7XFuM+YDvxNhx2Y0GBhUF/yjUih7d/ChD?=
 =?us-ascii?Q?XvL5kr71rLtwZ7NwU805REVRw4jHiWMzgE1T0F0H0x+IXGOi4dLhiEneUrxu?=
 =?us-ascii?Q?tAzIDnzKT1Vk7/fyqSQXs/odHsRTc2cVgN1jhohAFOa/HLoSP2xHYJZsNgv9?=
 =?us-ascii?Q?+nHLp12204yxalUW4VnTFnehFnqnD/vAE0D45tyieszVmA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?sizxkZ2E29rCE7Tx0c66vmFRQXz41WrShz4YS3Qk67Qvs2439nxIEXqIw0+O?=
 =?us-ascii?Q?mvT9HzX0xwZmD2yJwCEmT7bbYna+4M1U+uG0//hPfEVOhjHWwqu9iMvoVpMm?=
 =?us-ascii?Q?ZTNVpCbjWg6UdMEb2g20HlG5HRSHc0TErVK1zeo/b4g0dxeTZser3R0Ie8GP?=
 =?us-ascii?Q?R/NdczPaiXXTrIj9YoVaP5WMSZBE6lWWvI90i0Xare0tonQfqorKTnKWI9x7?=
 =?us-ascii?Q?aXMFuf67lShOgavLhspzrS1SFjb3BJ46+dLpjkPNGuYPvQiOyXeJ9GtJU/dS?=
 =?us-ascii?Q?mKri0h06yf61uJo6UV+C/IAdBYOnsMqzRm3pszflTyyf5mrDaJx2bQ0IIary?=
 =?us-ascii?Q?aPAzOT6bENzyw13GJka+T1ehNeIonWHmEe2wpCn/J907dZgC2hUvWrFZZd/A?=
 =?us-ascii?Q?kLu0tQ3FOy7Gutd5nO+H6ZvwzViZ3ngOYwlk5jQLfc/QbHVjcQ2gSf0kCiFW?=
 =?us-ascii?Q?ryvJzgchHUb8D4dxjCFOxYNwAGFbbYbfmirrB8ookw6qbFpN/gTDIIaLk7zI?=
 =?us-ascii?Q?VwFB0DRVrIQjmov417/MAF+FyQaN/Ceo/6iA7kTG7E9s0y0sjG92yvMBp8jG?=
 =?us-ascii?Q?/Oi8+6WVyXEOLM110h77ykBXxZue/RFXBqw1toJZvaY2JkLIr54othZP1O9o?=
 =?us-ascii?Q?Mf0ZeFHWl4sStL6hR05uwm+EdkKWSpzx02qbCmAcbHTlYJQNc9XLEnP6dhSW?=
 =?us-ascii?Q?lHyr/IPU5TtpLgf5iDsCnxs2E0g6EfxAn0JlwIVTa59WeUYgnUAz2O3Ki8Qr?=
 =?us-ascii?Q?ebBUzG0GeqdSPJ/gj0RsZ5k/jXxa6PpbAJ3buBbwK3/MY+/I6gupMnCgqrPG?=
 =?us-ascii?Q?RtZeqgV6dZ3zbY7Uw4HuVIIg1ByWKWfyON0h9nfyCUD4zX7pCmsXO1GbV1E+?=
 =?us-ascii?Q?QSUyuKae9lCOj3phracQoeH7w43q1E/xZkd7CNgykIWWi4xvx8R1bt9u1c6N?=
 =?us-ascii?Q?ePoFfT2pbOrXLHaZThWnxBqZFu5lsHUZCD2nbI2LNuJq3SMRpq9Hh98MBW/L?=
 =?us-ascii?Q?sEjX51vFy/7HG8rfI4We87AvSOv0TnDfo1EIbaf1dksUaL0BiWZO4D5oaxvQ?=
 =?us-ascii?Q?+Pha10ws/fn3OHuOVMwcKkDxjks3SoHSGBAjdATCmk6bNo99EsgAX7r1q7iF?=
 =?us-ascii?Q?lkBoaArZxyOAAXlqh8nMqtpWTLu20JBLcLPgWXejxxPJmh+t5lHKLx4nQGsr?=
 =?us-ascii?Q?TB2AXooKuKIo/j1OxHIkyfbCNae6RYhM2iNBUpYfhoJGz+3zx6eEatG26wTC?=
 =?us-ascii?Q?DNioJv+DqEejgz0XFu3CNuUGdw53QLEVXtso52Q673y+yLsQajjt0Gpn8nWl?=
 =?us-ascii?Q?c5WYknLGtq7ma+qqmEPh/aUw2MvOQlF/yKY2snJ0YdDn711uLDAllUykBrKI?=
 =?us-ascii?Q?JS6cmVmjCsvHpO8Bbk9L/xfIEn1Qh+xis2BsZPVs9qwfaw7auiO4n2IDY7Yv?=
 =?us-ascii?Q?XAaijqOP0iNEFlj9YXSM1IrlkFnMVrn6DJ/eLH8OzQjzJ0iLwpxeMULiInWV?=
 =?us-ascii?Q?ra+JNM82NzUJK0fAPh2O5eu2CCGTHFFL+kskrA87vkY7oalFMc7wtvqQgKYa?=
 =?us-ascii?Q?2Z13lqFnij3Xddw9cELDV/pd1aw9PqjY+7Vk4Zjt?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b6df0a-de57-4c29-c27e-08dc643910db
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 08:32:23.8160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qVtM8/UBTO4zDdQKJdhKPNcmgsugou1CxC8DcfgMhqCrhd4O1C9Ge5WDAZ8cjltHKEnYuLJ0RoxIIk/iQA19wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4883
X-Proofpoint-GUID: wIVCBcYVjbg5w70KFgQLsvBiYppAfX2j
X-Proofpoint-ORIG-GUID: wIVCBcYVjbg5w70KFgQLsvBiYppAfX2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_06,2024-04-23_02,2023-05-22_02


> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, April 23, 2024 2:49 AM
> To: Sai Krishna Gajula <saikrishnag@marvell.com>
> Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri Gouth=
am
> <sgoutham@marvell.com>; Geethasowjanya Akula <gakula@marvell.com>;
> Hariprasad Kelam <hkelam@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>
> Subject: Re: [net-next PATCH v2] octeontx2-pf: Add ucast filter
> count configurability via devlink.
>=20
> On Fri, 19 Apr 2024 00:30:31 +0530 Sai Krishna wrote:
> > +
> 	DEVLINK_PARAM_DRIVER(OTX2_DEVLINK_PARAM_ID_UCAST_FLT_C
> NT,
> > +			     "unicast_filter_count", DEVLINK_PARAM_TYPE_U8,
> > +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> > +			     otx2_dl_ucast_flt_cnt_get,
> otx2_dl_ucast_flt_cnt_set,
> > +			     otx2_dl_ucast_flt_cnt_validate),
>=20
> All devlink params must be documented
> (Documentation/networking/devlink)
> including the explanation of the tradeoffs involved in changing the setti=
ng.

Ack, will add the documentation details and submit patch V3

> --
> pw-bot: cr

