Return-Path: <linux-kernel+bounces-102872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FF687B7E3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1C3B2229F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1DBDDDF;
	Thu, 14 Mar 2024 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bnNjSuHx";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MkbckHNO"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C2AFBF7;
	Thu, 14 Mar 2024 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710397471; cv=fail; b=Nleupb6vl5qGc9Q4aNm1dHjrKoB1L1W3Bq8mrXp7Wg1dn2JBrjqsKMzn6rCWx4dO0inFdUP9+IT9LvadGaz7lllTBJgPasx31VNS1RnY2GqJW/4BXg/QNob3Dj4ILHFVzTc+W5QFbV2A17XWkt4y4P+lAmqrorVOFxsUAese4UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710397471; c=relaxed/simple;
	bh=56ecDTtMMQO9mE7hL9Y3HiT6J24jtLcRUKwrwvd5uyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VCDSmnwfDUYruCtLnL3CZMLvik88IlGojpnKqxXxijf0id9GQVNyn/P+QRm+fXTCjFKvHJ1W3X1SDb4WnP1eaebG/f2oNME2frN/aglP7FDRoVx8Ksm5K75vW9nanWwO8Tc0+WrSmRekKFv3gj7S59bkFNAsxXKtJogUQY5RYEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bnNjSuHx; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=MkbckHNO; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7efec330e1cb11eeb8927bc1f75efef4-20240314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=56ecDTtMMQO9mE7hL9Y3HiT6J24jtLcRUKwrwvd5uyY=;
	b=bnNjSuHxnPyvfpt8upeQTUKiLqwwP+TdreKKqZqfELTtI+8KCOE8gKLi7Tu63rX4qZoHiYg+0hUCbpGAaiK/xKd7Yqk1D+POiyd3C/FRJDEDymFv+UcZybPaieR9i5RJ6zW2RpIQrVuaxNcK5HVCr5rUuctly+q8JhpsNpc5N7k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c3fb405b-5134-4325-b25f-cb6fcf9292d5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:4d1bfd84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7efec330e1cb11eeb8927bc1f75efef4-20240314
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1629596132; Thu, 14 Mar 2024 14:24:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Mar 2024 14:24:20 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Mar 2024 14:24:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr/DgucZnY4ByWtrrIcQRneAioMqYlAXgleIZ0ZDcMd3FTe/JSvu+b+sPgGoNo+qe+JY1UPGDLLsVq/FGad/V/ruLBSdV+rLR0Fw3qzF2sm+WRVjil5I0L+13V6rhKIZZQPspTZ/j8aX14r0/oqkyVT4TOleGewaVWTY6PuyikexsIWg6W0/KYpfrn/XQUngRaVlvdYcPuE2mbz7kA1YBRmg8stsyVFKV/rsZKtbL9pDwYahgkxGkvSRel0LqxOz5DTxOtA5k2rvzGqMoQAA1hvICZ1M3jBcvbDno/euDjLY4zCpDhfwssuWgMzMSjjaraeR+ReFsy/H+XrnOhbHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56ecDTtMMQO9mE7hL9Y3HiT6J24jtLcRUKwrwvd5uyY=;
 b=INtsXh8Nzl8uyV+yak+QCvcbff9w6Wi8IE5o5CxUhY+YRVS2pzzPDqM76tgIHwZWkeocXgk3QhM8OXw21G6J/TEheuCIIvtVLw9L5sMQuOkUh1YgFWsHTJTHm+jTpNr2TInTp43By2SXCnJx42IT3PMwGmvRA9vjzPe4Y7knh945KXqtf4PzNA+iKFpDSQLXd+Z8Zr8t8Bf9aSO6zTLx+Qu6WwGzKRlRnseBkOwJinP/YEtThgWkKnSkzLWuKeqOZSOmHJjIPv0m+DJtKp0sBznUqVgdlo0X3MZH70rWTRxQG2p6VR+dWyF65vCbunOAyQfFPYh/viraAxk28+LRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56ecDTtMMQO9mE7hL9Y3HiT6J24jtLcRUKwrwvd5uyY=;
 b=MkbckHNOUdWQoq4eb7h0sCKkaTxo6wyNBLfpionxGwHCzyzpQf3weOy2BaWjrMK88BZ40Cxb+OYtgb1DsZF4OAQu8IHztFwtFmmPrcxftpkG8mp3kjwleb3+gYk+yZrBdQPFQhQyr3Rtn7qtCgrKYk9Zf9H4mMzY5dN9ZBBcBZI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8341.apcprd03.prod.outlook.com (2603:1096:405:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Thu, 14 Mar
 2024 06:24:18 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7362.031; Thu, 14 Mar 2024
 06:24:18 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
	"shawn.sung@mediatek.corp-partner.google.com"
	<shawn.sung@mediatek.corp-partner.google.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH 05/11] drm/mediatek: Rename "mtk_drm_hdmi" to "mtk_hdmi"
Thread-Topic: [PATCH 05/11] drm/mediatek: Rename "mtk_drm_hdmi" to "mtk_hdmi"
Thread-Index: AQHaaJE8jx9DFrSmw0+/L1tbc6uq2bE231oA
Date: Thu, 14 Mar 2024 06:24:18 +0000
Message-ID: <f3976174c6e034d7498b0565dcbc88269fd74a2f.camel@mediatek.com>
References: <20240226085059.26850-1-shawn.sung@mediatek.com>
	 <20240226085059.26850-6-shawn.sung@mediatek.com>
In-Reply-To: <20240226085059.26850-6-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8341:EE_
x-ms-office365-filtering-correlation-id: b6adc3e1-35f4-441b-fcd1-08dc43ef612f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zw3ChJ3mXLR37qBGonUY4Ur32utb++EZhwE6n/0jHYIfhDwe8yk65hRMR8dpprlLvxp7QvOOsJTAyJJ10MRfDi/8r4aGnsvy/DKZMzQBYxAE+Gd3Fx8Z+HjlnkWySvgwNxw9ooGdTAvFmR438P7nHca/3+AYwjoBFy9YBUGvfGbWg2pa0HC4ypt+4U6EZhAuOqHAG3L01XZZg6wyaYl/Tx39NbyhDEOBkgr88VAjPuv0C2iPX36MFyhr0qZEKuDD30ixqZK9wqmfVMhcVV9XOI/zC9EBN5IbK9CN5bpJJ1VdCiriF5u5P1M/beJnqv5Ulq8qi/HJAbL/ODe2/eDB3quwV/aHrq8KqTxKZct+cbhJkuRno8T7vwSQtIvLmEQ6CRyIp8ZgkHaf9euHVK8lK5D0vry/4q4S2TVXLq9v4BcT2NRDONlbQVRuCMU0cusq1aGT5N56khPIJw8tl9yY53Q8xLg3O959lX7CVoGQczsPX4tqVpx8pBNvN5TUOsvSsuoLGb0pSItLlpq3keWt3GPSqn2nrjsBoFk+SqP3SHBa+AL83Qgym+2cdZv0DCdpjSk6JCU8MjWTDaWn7mqcGNfbtx1niJOdcUKLGR6rNHkDNwnbzPkXwGS8vffIWI696djV0M4j4kr3k6ByV82uDmCdGdCBHG/YHi5ahruiSvMgCRSSrpVCtoN+uBSiIWAinnJ2jt92ZqIAvQLV1EZ9Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGp5U2ZGYW9mdGFSNkc4bUtsWGhtVXEyQ2ZVamswSnAvdVdOU3RkS0svekJT?=
 =?utf-8?B?Q1NmWTdrSGtvNElkcjI5WE5VY2I3a0xtTy9zVFpCK0x5ME14dDQyOHQ2QW90?=
 =?utf-8?B?RzN2cllmWUsxYnd2RTJUZDRETklvdm5jYjFwbXRjdkJDeUM0dlRaQWRVazZX?=
 =?utf-8?B?ZnpaU0x4UEp6S3ovalZkNjZKeVNIbXlwMjRDd2pISEtWeTBzY25pR20zaWQy?=
 =?utf-8?B?a25la3lnQXpIWEU1NFVRd2c0YnpNb3lSN0pIVGdvMEtwbGg3a00rY21Xbmd4?=
 =?utf-8?B?WGV6bUMvUGVQaDZJR0V0Zmx2ZXBCR1Q3ckw4aXRkYTl1NlBYd3NLN3c4aXJ0?=
 =?utf-8?B?TXJHbFRZcmp6N1VoQUNTeE96bUxWZmJPZjhsVWF0NkpRVUF0ekpvT2Nzb1Rn?=
 =?utf-8?B?c0pEMFNlUU9NMWtCd29OWjFNbHFLU1JDaDc1R3lJbzd6cjA1dzF5ZGpiS2dp?=
 =?utf-8?B?ZHRHc09Nbm1PbE5QeW4veURxV2hFWWNTWFhhY3VZMTloUERmK21HZGVJZVU0?=
 =?utf-8?B?Slh2TkV0c0ZrUjlPcXNsK2hsWitBeXo5RDFPL1RmTGhEa0tBdGNORnlucElY?=
 =?utf-8?B?SWhMWFF1emNINDNFcVBRbC9PZHJGUDhKVTB0Q1RUT1ozTG5sU3FibXRSbURZ?=
 =?utf-8?B?c003QlVHbW1hT3lKN3ZxQnZtbHVJaCs2bnJzMFovcENxcW5kUzZaNHZDRWpJ?=
 =?utf-8?B?OU1OV3l4L0RjSEFDbzczOC85MFYrQnVZNDB0dVZrd3pncW84d2tPVysxYXlq?=
 =?utf-8?B?d1ByVWJFZUQ0ZG5LMHk4MS9ZSmV4ZGdtbkUxZnI3R3NVZ01KYytRL1ZsaUw0?=
 =?utf-8?B?eWZpay9zSnNQeHE1UTQvamttYldFaDBHNG8rM3hsb3JMdXg4ZmFJNE5vaERR?=
 =?utf-8?B?YjA4bnNheGZTWEdxOXNPSXRMT2F1R3c2TjVWQVhPYXNndDQ2Y1pBcGZ2bjla?=
 =?utf-8?B?WU91RVluRGI2UE5vc2FuRHpIZ2luL0MxODFkeWVHR2dTSVBWY3NXZDRoT0VS?=
 =?utf-8?B?TklwUTFNVFlHdFdGQ2M3ZDhoa2FSQjlZVlVoZjI5dUpaWUNBYU5NNG5SemJy?=
 =?utf-8?B?V01TYW03V3hNOE9VN2ZJbHNXbXdYSTh5TnBPRFBIbHltTFF5cUxvanN0ZnE0?=
 =?utf-8?B?clQyN3VzaTMzb0NWV3VzV1c2YStqRzNLdHV6eFJwTUkzT1RBSVExTklvdTlX?=
 =?utf-8?B?MVA0cUxpMC9uNjlmTE52ODZNZDE1Vmx4NTlQcXlNejd0Rmw5bjQ1dEFzTExE?=
 =?utf-8?B?RkVYZ1hyN1NmMElkZUFESFNyUlZMSWZERmFrUXZCSmJxV2QreE1pRTFUdGgw?=
 =?utf-8?B?ZU0rR3g1Q3BXT2c1dWhKakZkU2dJZEVURHdUelhZRCtETUFNZU1Vd3ZDb090?=
 =?utf-8?B?R21ZaGZlRzh2T2VrSlJuaWVYSnU2ZXNrdWt1cmtTdTR0ZHA5VVMxc0NzcEk0?=
 =?utf-8?B?NGdJRkMwN2kyS0lkYzduRTVPc1pDZFg1MGgyenZnbjE2azEzQitsTjlGUGRT?=
 =?utf-8?B?ajhtaG13dmRPUEp2ZjdreEJUQ2pRQ0U3M3l1eUV2SGRPNFNlVzA5QWZJa1Z1?=
 =?utf-8?B?U3NyTEg4VnNRVWtFSnhzVTdjdGMvRzBVY1h3eFRJS3FHWW9SWjBDRFlyVmw0?=
 =?utf-8?B?U0NqNjNkcnROcTFpamNnWUpjRVU3Yy9YQm40Vk5QZnFPWEpud21pRkp4ZjU0?=
 =?utf-8?B?bkt3TnU5TkQxM2dKeS9icCtqM1l2U1N4S3ZEZHJxTk5rNGhyOGwraEQraDA4?=
 =?utf-8?B?cFZ6SkZacTNHeE5vRlpCclpsM2RFSW9xMjdmd0NSQnlTVjd0cEF2ODlSNG9N?=
 =?utf-8?B?YnJtR0JNdUlkYmNQQTFVWFdCQnJ3bzhOblpWdHJIYW9TL3BFc0NoakJNSGV4?=
 =?utf-8?B?L2EvMC9FU3lVVE5MUy9ER3JQOTRRWU9sRHNQcUt2L0FvZVdublREYnhyS0pW?=
 =?utf-8?B?b0gwU1BQOC8wVzZDYUZxcGgyN1pxNUVyTEd2TlMzZnJDSjZwSzcva2k3TWFw?=
 =?utf-8?B?VzVtRlFXa3BaTmEwbUthaFBuZkVNeWZLQW5FWExTTDREN1RhV1hYdUpwa3VN?=
 =?utf-8?B?cm1jUmxzSnRjUG1aUUtnV2YvTUdhKzdXVXBBOXRCUnlKTDZNY00vVGMxb2lu?=
 =?utf-8?Q?yNziqe5KfBK3MePU2YFYP1rFD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C99DBEE3BB5A9B41A72F035422DCA57A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6adc3e1-35f4-441b-fcd1-08dc43ef612f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 06:24:18.6266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ldv3ujHDr6A+I1sYyFROV/2Q2u54zNOwBrdzjKVrwJw5U7XrNFkdHCoKJH8VaJaRmxipeOut9aMcdzA0CwfG+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8341
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.839800-8.000000
X-TMASE-MatchedRID: 9zTThWtzImv+DXQl7XSOUt7SWiiWSV/1jLOy13Cgb49qSjxROy+AU3a2
	v7MgC776yAUgFH8TZu6n86WFQ+HJup/1JE49xL3GDB+ErBr0bAPpJe7BSAYfSNiCsYPC4Ul2+Vi
	hXqn9xLHnYEGGAvPj/D0CGkQ7+PsOKc+6Aaw3enkSEYfcJF0pRaxwr8rYOW+O3BDlUOLc70GjxY
	yRBa/qJRVHsNBZf9aRAYt5KiTiutkLbigRnpKlKSPzRlrdFGDwWgYH/NwMk+woS00CDPFWEZE5+
	a+cIQmzAf3WYoL7bxKeBqpXlD9s+g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.839800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	BD329B29C2DACD553DF55F78881D961BC7F6153B36F38BD291996569CE478A212000:8

SGksIFNoYXduOg0KDQpPbiBNb24sIDIwMjQtMDItMjYgYXQgMTY6NTAgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+IA0KPiBSZW5hbWUgYWxsICJtdGtfZHJtX2hkbWki
IHRvICJtdGtfaGRtaSI6DQo+IC0gVG8gYWxpZ24gdGhlIG5hbWluZyBydWxlDQo+IC0gVG8gcmVk
dWNlIHRoZSBjb2RlIHNpemUNCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5j
b20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPA0KPiBzaGF3bi5z
dW5nQG1lZGlhdGVrLmNvcnAtcGFydG5lci5nb29nbGUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jIHwgMTQgKysrKysrKy0tLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYw0KPiBpbmRleCA4NjEzM2JmMTYzMjYuLmQyODc2ZGEx
YjQzYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMNCj4gQEAgLTE2ODcs
NyArMTY4Nyw3IEBAIHN0YXRpYyBpbnQNCj4gbXRrX2hkbWlfcmVnaXN0ZXJfYXVkaW9fZHJpdmVy
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAtc3RhdGlj
IGludCBtdGtfZHJtX2hkbWlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
K3N0YXRpYyBpbnQgbXRrX2hkbWlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2hkbWkgKmhkbWk7DQo+ICAJc3RydWN0IGRldmljZSAqZGV2
ID0gJnBkZXYtPmRldjsNCj4gQEAgLTE3NDYsNyArMTc0Niw3IEBAIHN0YXRpYyBpbnQgbXRrX2Ry
bV9oZG1pX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJcmV0dXJu
IHJldDsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHZvaWQgbXRrX2RybV9oZG1pX3JlbW92ZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiArc3RhdGljIHZvaWQgbXRrX2hkbWlfcmVtb3Zl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IG10a19oZG1p
ICpoZG1pID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ICANCj4gQEAgLTE3OTAsNyAr
MTc5MCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2hkbWlfY29uZg0KPiBtdGtfaGRtaV9j
b25mX210ODE2NyA9IHsNCj4gIAkuY2VhX21vZGVzX29ubHkgPSB0cnVlLA0KPiAgfTsNCj4gIA0K
PiAtc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2RybV9oZG1pX29mX2lkc1td
ID0gew0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2hkbWlfb2ZfaWRz
W10gPSB7DQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MDEtaGRtaSIsDQo+ICAJ
ICAuZGF0YSA9ICZtdGtfaGRtaV9jb25mX210MjcwMSwNCj4gIAl9LA0KPiBAQCAtMTgwMSwxNCAr
MTgwMSwxNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZA0KPiBtdGtfZHJtX2hk
bWlfb2ZfaWRzW10gPSB7DQo+ICAJfSwNCj4gIAl7fQ0KPiAgfTsNCj4gLU1PRFVMRV9ERVZJQ0Vf
VEFCTEUob2YsIG10a19kcm1faGRtaV9vZl9pZHMpOw0KPiArTU9EVUxFX0RFVklDRV9UQUJMRShv
ZiwgbXRrX2hkbWlfb2ZfaWRzKTsNCj4gIA0KPiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2
ZXIgbXRrX2hkbWlfZHJpdmVyID0gew0KPiAtCS5wcm9iZSA9IG10a19kcm1faGRtaV9wcm9iZSwN
Cj4gLQkucmVtb3ZlX25ldyA9IG10a19kcm1faGRtaV9yZW1vdmUsDQo+ICsJLnByb2JlID0gbXRr
X2hkbWlfcHJvYmUsDQo+ICsJLnJlbW92ZV9uZXcgPSBtdGtfaGRtaV9yZW1vdmUsDQo+ICAJLmRy
aXZlciA9IHsNCj4gIAkJLm5hbWUgPSAibWVkaWF0ZWstZHJtLWhkbWkiLA0KPiAtCQkub2ZfbWF0
Y2hfdGFibGUgPSBtdGtfZHJtX2hkbWlfb2ZfaWRzLA0KPiArCQkub2ZfbWF0Y2hfdGFibGUgPSBt
dGtfaGRtaV9vZl9pZHMsDQo+ICAJCS5wbSA9ICZtdGtfaGRtaV9wbV9vcHMsDQo+ICAJfSwNCj4g
IH07DQo=

