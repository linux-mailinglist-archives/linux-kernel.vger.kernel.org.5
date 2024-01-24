Return-Path: <linux-kernel+bounces-36537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2F883A2CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2797B284BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578F3168DD;
	Wed, 24 Jan 2024 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c7PnqSGd";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JgAKKizA"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5815168AC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706080870; cv=fail; b=OspejSVTgsHyNw+q4yDsZXRjRkgYY1biaIN+FvmRZ13rg8csM0cojrdAGNxKdQX1jxuY9cUe2OwhcBHY6XgwEgrePonpPHAwAntAjTnpnAjbcHzQTIn4pGDMHXA2SWItgNxjbOzilnqwmVvZ0MpbnFz0JaVhsDLxG6sggS2TC3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706080870; c=relaxed/simple;
	bh=EY2ZPKba9hBpNIiQHTtR5i1UopYxjBOhmgtmosYPK70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uvop/HIc2CaaMtS3MaL2MYRLG2ColuvcxZ5vCFsYE+nOmEH+nIliiAT30874EOhgDlQ14Y2pVYhrEjF4JhCzDxFHOqZJziMkHXh8p1UIw0tKpnzW9CILE79Vz9+oTZ7XWFHP1jTbHfkWVXde/g4Qf8vyDImSn9JFyoxtd3DxDDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=c7PnqSGd; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JgAKKizA; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1dbf706aba8911eea2298b7352fd921d-20240124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EY2ZPKba9hBpNIiQHTtR5i1UopYxjBOhmgtmosYPK70=;
	b=c7PnqSGdmh/tKFhgp4YLV3lK8xWnj+Km+4sZycXBDN86Bz+B0NI84ckZHUPAicv3Sg2aPPxgTIK3x1Mb8nAGXkspTWZ7bTGGa4g6wTHTMTFjZJjxDpB7KqIlCmUV/F15dobBaVsuaQKToNUpboPE1jhfH1AmJLfc7kSnMAGYD8Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:c11e6424-513d-473e-86c1-e24c5d961383,IP:0,U
	RL:0,TC:0,Content:8,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:8
X-CID-META: VersionHash:6e16cf4,CLOUDID:067317fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1dbf706aba8911eea2298b7352fd921d-20240124
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <haiqiang.gong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 767639072; Wed, 24 Jan 2024 15:20:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Jan 2024 15:20:55 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 Jan 2024 15:20:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnADOS2Vxse6Ixk6cL65yKECyR6m2LRLqHYsFHGQUEdrq0tVDJI7sTcxB6ppgeNlMqmrjXB2VjjiEZevWs8i2DBjq6ks4PFej8/toGtynoHcIPPu46kxtXr1kS7Nlwv1Xw57ZtJYYdeEHKjOvahALagREKloj70hpTGcW0O7u/8qrT2lpwygpXUFY8/mkmkV2zUtxx945P7Alkq58D+cFx+Ny36DyvIYzdv0sigxlk4kfUbQr+ZThW1SZOdmoLjivhnZ+jgOlY+H22Cn1KIvY6gjylrMb9rfP2I1707Nq7fnkyhZ3lICOyr4arWz9D/YwlYRvtznT6Le3FPgz3FTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EY2ZPKba9hBpNIiQHTtR5i1UopYxjBOhmgtmosYPK70=;
 b=ZWeWrhPNc/z9H6dlWqdOKaxXMz9fAFm62tni1j9OSfx1nqHAxylx59c8YiJZFkHhGYy6U2wRKMehm8Q6thP6HLYqK9VmzA23WZOfGPJ29BlKNqRpzkcSvuRbWyfukEO/sn2oBhz3q/C0+3e9LfJcNrtQi+AjxbCpdm3DEiZEB0nGn9UkfG44RKd2RAl5SljmzC1JyWDIzXQQcgUqGALtu5e2DyoSGwpHg6DFYJyOuMfwDZX2W9eTWpu/Raci4cz2ncfTXHI0Fi8KRMKVZtC0uusJam0yeh5gA0+2nFqdxZvH7vAH/0p0OaQOuxltctfF29WWpP9WaglXBt+zf5HRYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EY2ZPKba9hBpNIiQHTtR5i1UopYxjBOhmgtmosYPK70=;
 b=JgAKKizARQbaeakF84n5ihcTzxeOalpFMI/qQyuR4Hau/c3uOlkFz5FTBKnwnKUYpuk52FcrrsjL/j5c325vPBh3ABQeztrToPhiWaIJwDY8e0TdzyDETgj4yH7b9ZbvxfoQzMvYg3d5/Y3daRnuGzc86g5wLn/hVf19pEPEuR4=
Received: from JH0PR03MB8809.apcprd03.prod.outlook.com (2603:1096:990:a1::10)
 by SI6PR03MB8653.apcprd03.prod.outlook.com (2603:1096:4:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 07:20:53 +0000
Received: from JH0PR03MB8809.apcprd03.prod.outlook.com
 ([fe80::e7fa:4f8d:2a6c:57cb]) by JH0PR03MB8809.apcprd03.prod.outlook.com
 ([fe80::e7fa:4f8d:2a6c:57cb%3]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 07:20:53 +0000
From: =?utf-8?B?SGFpcWlhbmcgR29uZyAo6b6a5rW35by6KQ==?=
	<Haiqiang.Gong@mediatek.com>
To: Matthew Wilcox <willy@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?TWlrZSBaaGFuZyAo5byg5Lyf5LyfKQ==?= <Mike.Zhang@mediatek.com>,
	Andrew Morton <akpm@linux-foundation.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG1tL2NvbXBhY3Rpb246IGFkZCBjaGVjayBtZWNo?=
 =?utf-8?Q?anism_to_avoid_cma_alloc_fail?=
Thread-Topic: [PATCH] mm/compaction: add check mechanism to avoid cma alloc
 fail
Thread-Index: AQHaTNn7A5RvAL1alUa4iZhYRPGYZrDlLS+AgANkdoA=
Date: Wed, 24 Jan 2024 07:20:53 +0000
Message-ID: <JH0PR03MB8809FC349066C215C28DE119947B2@JH0PR03MB8809.apcprd03.prod.outlook.com>
References: <20240122022317.30091-1-Haiqiang.Gong@mediatek.com>
 <Za3hf6A4V5QECvDy@casper.infradead.org>
In-Reply-To: <Za3hf6A4V5QECvDy@casper.infradead.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMjA1MTFcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0xYTEyZTQxMS1iYTg5LTExZWUtYjczYi1jOGQ5ZDIxNTZlMWVcYW1lLXRlc3RcMWExMmU0MTMtYmE4OS0xMWVlLWI3M2ItYzhkOWQyMTU2ZTFlYm9keS50eHQiIHN6PSI2NTYyIiB0PSIxMzM1MDU1NDQ1MTYwMTY5NDgiIGg9IlVSek5PSnlYREUzTERIdWtibGVYTUJkek5Rdz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB8809:EE_|SI6PR03MB8653:EE_
x-ms-office365-filtering-correlation-id: 97f78ffd-33be-497a-3124-08dc1cacffc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vwwJjz5zFrGE0cjVnQy7I+eWm4QD4dP3wWYXxgvrmkLipscs1tUAxtma/SrMaSVldSbMce88rO7d90hCL+hq9KZs2nkdBpQR9XXEIvGHmwIJnEfhO6WaREHSO2iNlHlXmMhSsqUBUUBjYjEfNcdCvYFrZkURwoaM+43b1NwOlO94re/kQNxhlUvOMtQ3Dk9r4/Yr+6PVLr6PrSacOXaWsPeAUgyAu3+zpvc9vrXr2LS00TTNM/loHx1KhHgihYkfhzv2DyyK+E5TKM8PnFoIhT3G660qaml0jR60Z2r9zq9jR8dEaxWnlKcUvxCkLsqWDvnyqFNfXeXNBoXMU5BJR3oEegopFO064CAFardaJaNWlDryDyFY0ZE3Dt/5JXemMWUYE6GXU+g37e+ZDEL1K2oHHhCUa/CYN97DiFGrVFVzUD5YP4qJz4ertuDxQNmD9AZKYsDZCptEP5nhW6yZnmAROHqgHuPMv/7GMcKvz/K9JAZkRLt7jnLojykla0wCW4Ix+0v4OR65ozzKmpS2VcQCz1BIFrZyiX1H+ac2GbBeAPcvDxx+yPAgplL+3BB2jiAPvgYpoxv1PAeKYvS9ja6I3FTipbNIq6Dfi6OcbXjiqCn4tbzk+Oye1eZCJcqYfDhnsjeGEMHijq2f1SE5wlmqLEBOSyOGcKTCT8LRXUs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB8809.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(83380400001)(26005)(9686003)(5660300002)(38100700002)(122000001)(55016003)(2906002)(33656002)(66556008)(66946007)(76116006)(66446008)(54906003)(66476007)(6916009)(64756008)(316002)(86362001)(7696005)(41300700001)(6506007)(38070700009)(8936002)(71200400001)(4326008)(85182001)(52536014)(478600001)(224303003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWZrMElnaTRGWHpxNTY3Y25PMVhUU0FjSks4Zk9vS0d1czhmUlFLM29aZ2JK?=
 =?utf-8?B?ZjJab24rZXhQYmtKQmhxUmNWbXAwMFpnQTNDRFM1TEQ0MDV4QnVNYU1Ebit4?=
 =?utf-8?B?TzFZYkZkcDVJSXd4UmR6Y3BCeWRvTURuN3FBRnVJNjlmZUpMZ0tPMkRqc051?=
 =?utf-8?B?MEY5Z29VclZ0RzdKUTJiVTdCL3lYSlJHeWpKem5aaFJuQnVUMlRJSzNtN0Ir?=
 =?utf-8?B?L05LeGUzQTdtNnZTRTZvWlRtd3lIOW0vSUQrNWNCOTYxMXJlb2JiUlZRdFIw?=
 =?utf-8?B?bm9ybjErQTMreXZHdHZWWlVoWmNPRWdZQ2ppRFQ2Z2twUUhpLytFRVdzM0Fv?=
 =?utf-8?B?YkVNT0g1SzFCSVFOb1N0cmlORmdBdHJDVXVISy8zNlYwU2RUUGtoK1RCRW1r?=
 =?utf-8?B?bTNYTk5lSExucUZ6eHN3N0FKTnM4VVZ5R1J6K3A1ODV5eis0K25ydXN3anh3?=
 =?utf-8?B?RzliUjhETHdRK2ZBdG92YUZZZWdRN0xDMXRSOEhUN3czSkh4ZWFSVUYwRGUy?=
 =?utf-8?B?akVDTnYrR1JqcjBnMHVYekI2ei9STzRwdVphaFZHLzBKazNqNytCZ003VXVp?=
 =?utf-8?B?QjNEbVBRMFFIVkRhKzREODZhaGlWVXlBTnE0OUtSSy9reTJSQk11c2FOQTUw?=
 =?utf-8?B?SG9VNGdwNEFWekF1aS96N0JBRDBYRnExaTBJQTJLT1dVM1YrL1VONlI4TDVx?=
 =?utf-8?B?Z0FKeU5OK0w3SERkUjlQekk0R1JYNmplWW1sYzRqTUlucDB6MWdPTUZDaXQ2?=
 =?utf-8?B?cnFXcCt0ZHR4a3poaFJ6UlNSNWlSbWJlRmVIK0E5VU9MSE5tZ2w5RkhSUEo2?=
 =?utf-8?B?RU1idXB0NWVNMEpZbis4RVRzcW1vV0lIcS80RmUvUXlPbkFhYWtnUk12SDhZ?=
 =?utf-8?B?TTI2RW9RVm4rS2pJa0d3VFNoWW4yVG9vK2EvWXJGNE1lRG5aZmxhb2JlbVc0?=
 =?utf-8?B?YjNpbk5SWFRvREZ5OUY4RDhFYUhYVnVTNlMvUUZxRk0rc1hQd0lwczNJUVpI?=
 =?utf-8?B?MWZ3aEptMWRncWRxOHFKSS9aTmNXUkZxcHFoNjhNa3ZIbmN6UDRQWUhlVnlZ?=
 =?utf-8?B?YXh1WWdxT1R4WnNsekFkQVhFaXRqRHR1ME4wV25MdENFeWVzYmpQWFR4KzVO?=
 =?utf-8?B?M24xTmIvVzR1M0puVjR2dFVFdUY5d2hRRGlsZ2tFeDQ0Q3BzRGV2WkRSaitE?=
 =?utf-8?B?TThxTFJWVWRYSUZLeTU2S2ZoQXp0YTJlQXpWY25LWWtVS0JWazh1TGNxa3Jk?=
 =?utf-8?B?dURqcW0zQ0lwaDZvUDNzeGNTN1FodVVHdWNTSThucEZpNzZ4NFhDN1RRWWF5?=
 =?utf-8?B?UlZta0szbHZ5RzFiOEo0OFlsYk1WQVRXR2hXOXE1WEMwTUw3WkRKR2R5Q0Q5?=
 =?utf-8?B?ZTd2UUlrazFwZ0ZQM211SS9xcXJYdTVXQ3lKVGp1M05BT25YR3BZeDVYbUhM?=
 =?utf-8?B?NEd6VEwwdW56MU1HR3R4ZCtkZXcxY3N3ditCOG9iNDdTam0vbmNkYXN2aUJK?=
 =?utf-8?B?bXBqRzdTT2NSb0M5bWVzZjlLOHlLd1VGTE80UGx3aTJsamFEWENvbTFJNkZz?=
 =?utf-8?B?blNMeFhWUE1xVVQwb1BKYllsSU5yZkxKKzl3eHB3aitzTVhnQTNCWXhmOHBG?=
 =?utf-8?B?ZlNxc0NEK29paXh4RVpvTCtBOFNWZFlEcU5WY3cxcmh1eGRKbjJkQkYwdkhH?=
 =?utf-8?B?TEhQK2RKenViL1FFVjl1UlJVSVRtN29hMzVVWmo3bzZPdldpQVZqYzZXS3Nl?=
 =?utf-8?B?bEYrbDZKK0UzelhzUHhGWDFhMExxSGttdER0V3ZscXk1QkRmU1dpaDdJNkZO?=
 =?utf-8?B?Y2xQbk9xbUtFenN4aXEyS2VuVGx6N29ScldqWGcrTnNndGoyZ1M1MDIwV2hx?=
 =?utf-8?B?Zm04SExJNGRTZkNMMXM1K0VaaVBtNVdBclBuYkliUUpKK3RTMHVPdHhRSWhE?=
 =?utf-8?B?NldVc2xxRGMzZ3JxeHQ3bGVTcDRxMk52Z3ByTk1NUkdmZnk4WDR6MFZtTXVY?=
 =?utf-8?B?V3ZSa0h6UHN3VHk5alprRFFhQlZpVUNKQU96RUVOS0RGVVRNS1YvYUJhajdF?=
 =?utf-8?B?cHowOVRJZjJNTHd4VUpnUVlTTTlwa1AwckJiUiswUlcyQ2pCeVl1SW11KzZJ?=
 =?utf-8?Q?WoTcmSuNY3yr84iNN9vUySvqV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB8809.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f78ffd-33be-497a-3124-08dc1cacffc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 07:20:53.0385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6lLO+nH2jBDqS/IlnB9mtlpkOwKEkdjhEQImWl+HDniSh+67FelF7BYg3smDgwRhK9TBgVW5mQ2w00ePT7NxLxVwhd66vBX0//6Jmir17M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB8653
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--28.003100-8.000000
X-TMASE-MatchedRID: 2SDSohiwfqRbRbA/K/rHzENTnAhL0/m3gGa+oYp5i6pjPrlNB+gMqzUi
	2rTIOxGGe9t1NXv/UuBoVUje5WpMRJG468S7yeiwVU3yVpaj3QyRPtwwl97om2/FuxNGz9PYQ12
	OR9jMV+BnU1t8LQ9ljxNDJOaBVlnyN0y7mRIiBXeEryjhqiyzyl3X7EtRykI8Nl3oIse+0d5eL2
	ZaBHgvvs2ee3KAaGx5ziu5qPlyxtZG8ymvS3KrJrxygpRxo469nMghmZKNmqZVaiL9Jo7jBng4C
	OIjGsNyhIJdJ4y5Y5JFLaw7Qp58ck6M27pFjx1LzlJx3TJWz5t5ybkwtj/jvjP56v3wlS/ZEUbg
	QYFHh3jN6a40TQfOI6AIPQUyzd3eXHEPHmpuRH3SBVVc2BozSlkMvWAuahr8+gD2vYtOFhgqtq5
	d3cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--28.003100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	FC6455DF99B59B2CCF4B6D90E05559C77428BFA90F5D7490D517B416E9B8B9972000:8

PiBJIGRvbid0IHVuZGVyc3RhbmQuwqAgWW91IHNheSB0aGF0IHRoZSBtZW1vcnkgaXNuJ3QgbW92
YWJsZSwgYnV0IHRoZW4geW91IA0KPiBzYXkgdGhhdCBpdCdzIG1pZ3JhdGVkIGluLsKgIFNvIGl0
IHdhcyBtb3ZhYmxlLCBidXQgaXQncyBubyBsb25nZXINCj4gbW92YWJsZSBhZnRlciBiZWluZyBt
b3ZlZCBvbmNlP8KgIA0KU29ycnkgZm9yIG5vdCBleHByZXNzaW5nIGNsZWFybHkNCldoZW4gZG9p
bmcgbWVtb3J5IG1pZ3JhdGlvbiwgdGhlIGtlcm5lbCB3aWxsIGRldGVybWluZSB3aGV0aGVyIHRo
ZSBjdXJyZW50IA0KcGFnZSBjYW4gYmUgbW92ZWQgYmFzZWQgb24gdGhlIHJlZmNvdW50IGFuZCBt
YXBjb3VudCBvZiB0aGUgY3VycmVudCBwYWdlLg0KVGhpcyBtZW1vcnkgY2FuIGJlIG1vdmVkIGR1
cmluZyBrZXJuZWwgY29tcGFjdGlvbi4gQXQgdGhpcyB0aW1lLCByZWZjb3VudCANCmlzIGxlc3Mg
dGhhbiBvciBlcXVhbCB0byBtYXBjb3VudC4NCkFmdGVyIHRoaXMgbWVtb3J5IGlzIGtjb21wYWN0
ZWQgYW5kIHBsYWNlZCBpbiB0aGUgY21hIGJ1ZmZlciwgdW5kZXIgDQpjZXJ0YWluIHNwZWNpYWwg
Y29uZGl0aW9ucywgdGhlIHJlZmNvdW50IG1heSBiZSBncmVhdGVyIHRoYW4gdGhlIG1hcGNvdW50
DQrvvIhleDp0aGUgY3VycmVudCBwYWdlIGlzIGJlaW5nIHVzZWQgYnkgZnPvvIksIGFuZCB0aGVu
IG1pZ3JhdGUgd2lsbCBmYWlsLg0KDQo+IFdoeSB3b3VsZCBmb2xpb19tYXBwaW5nKCkgYmUgdGhl
IHJpZ2h0IHdheSB0byBkZXRlcm1pbmUgaWYgbWVtb3J5IGlzDQo+IHVubW92YWJsZT/CoCBUaGUg
dmFzdCBtYWpvcml0eSBvZiBmaWxlc3lzdGVtIGRhdGEgaXMgbW92YWJsZS4NCldlIGZvdW5kIHRo
YXQgdGhlIGZpbmFsIHByb2JsZW0gd2FzIGluIHRoZSBfX2J1ZmZlcl9taWdyYXRlX3BhZ2UoKSAN
CmZ1bmN0aW9uLiBUaGlzIGZ1bmN0aW9uIHNlZW1zIHRvIGJlIGEgY2FsbGJhY2sgcmVnaXN0ZXJl
ZCBieSBmcyB0aGF0IHdpbGwgDQpiZSBjYWxsZWQgZHVyaW5nIG1pZ3JhdGlvbi4gVGhlIHJlYXNv
biBmb3IgbWlncmF0ZSBmYWlsIGlzIHRoYXQgdGhlIA0KcmVmY291bnQgb2YgdGhlIGN1cnJlbnQg
cGFnZSBpcyBncmVhdGVyIHRoYW4gbWFwY291bnQuDQoNCg0K5Y+R5Lu25Lq6OiBNYXR0aGV3IFdp
bGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz4gDQrlj5HpgIHml7bpl7Q6IDIwMjTlubQx5pyIMjLm
l6UgMTE6MzENCuaUtuS7tuS6ujogSGFpcWlhbmcgR29uZyAo6b6a5rW35by6KSA8SGFpcWlhbmcu
R29uZ0BtZWRpYXRlay5jb20+DQrmioTpgIE6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IE1pa2UgWmhhbmcgKOW8oOS8n+S8nykgPE1pa2UuWmhhbmdAbWVkaWF0ZWsuY29tPjsgQW5kcmV3
IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47IE1hdHRoaWFzIEJydWdnZXIgPG1h
dHRoaWFzLmJnZ0BnbWFpbC5jb20+OyBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxv
Z2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPjsgbGludXgtbW1Aa3ZhY2sub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LW1lZGlhdGVrQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCuS4u+mimDogUmU6IFtQQVRDSF0gbW0vY29tcGFjdGlvbjogYWRkIGNo
ZWNrIG1lY2hhbmlzbSB0byBhdm9pZCBjbWEgYWxsb2MgZmFpbA0KDQoNCkV4dGVybmFsIGVtYWls
IDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsIHlv
dSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQoNCk9uIE1vbiwgSmFu
IDIyLCAyMDI0IGF0IDEwOjIzOjE3QU0gKzA4MDAsIEhhaXFpYW5nIEdvbmcgd3JvdGU6DQo+IGNt
YSBhbGxvYyBtYXkgZmFpbCB3aGVuIHdlIGRvaW5nIGNtYSBhbGxvYy9mcmVlIHRlc3Qgb24ga2Vy
bmVsIDUuMTAvNS4xNS4NCj4gDQo+IFdlIGZvdW5kIHRoYXQgdGhlIG5leHQgbWVtb3J5IGNhbm5v
dCBiZSBtaWdyYXRlZCBiZWNhdXNlIG9mIHRoZSBhbGxvYyBvZg0KPiBmcyBhcyBuZXh0IGJhY2t0
cmFjZToNCj4gX19hbGxvY19wYWdlc19ub2RlbWFzaw0KPiBwYWdlY2FjaGVfZ2V0X3BhZ2UNCj4g
Z3Jvd19kZXZfcGFnZQ0KPiBfX2dldGJsa19nZnANCj4gZXh0NF9zYl9icmVhZGFoZWFkX3VubW92
YWJsZQ0KPiBfX2V4dDRfZ2V0X2lub2RlX2xvYw0KPiBfX2V4dDRfaWdldA0KPiBleHQ0X2xvb2t1
cA0KPiBfX2xvb2t1cF9zbG93DQo+IHdhbGtfY29tcG9uZW50DQo+IHBhdGhfbG9va3VwYXQNCj4g
ZmlsZW5hbWVfbG9va3VwDQo+IHZmc19zdGF0eA0KPiBUaGlzIGtpbmQgb2YgdW5tb3ZhYmxlIG1l
bW9yeSBpcyBub3QgcGxhY2VkIGluIHRoZSBjbWEgYnVmZmVyIHdoZW4ga2VybmVsDQo+IG1lbW9y
eSBhbGxvYyBidXQgaXMgbWlncmF0ZWQgaW4gYnkga2NvbXBhY3RkIHdoZW4gdGhlIGtlcm5lbCBt
aWdyYXRpb24uDQo+IEl0IHdpbGwgY2F1c2UgbWVtb3J5IGNhbid0IGJlIG1pZ3JhdGUgd2hlbiBj
bWEgYWxsb2MuDQoNCkkgZG9uJ3QgdW5kZXJzdGFuZC4gIFlvdSBzYXkgdGhhdCB0aGUgbWVtb3J5
IGlzbid0IG1vdmFibGUsIGJ1dCB0aGVuIHlvdQ0Kc2F5IHRoYXQgaXQncyBtaWdyYXRlZCBpbi4g
IFNvIGl0IHdhcyBtb3ZhYmxlLCBidXQgaXQncyBubyBsb25nZXINCm1vdmFibGUgYWZ0ZXIgYmVp
bmcgbW92ZWQgb25jZT8gIA0KDQo+IEFkZCBjaGVjayBtZWNoYW5pc20gaW4gdGhlIGNvbXBhY3Rp
b25fYWxsb2MoKSB3aGVyZSBrY29tcGFjZWQgYWxsb2MgZm9yDQo+IG1lbW9yeS4gV2lsbCByZXR1
cm4gTlVMTCBhbmQgZ2l2ZSB1cCB0aGlzIG1lbW9yeSBtaWdyYXRpb24gaWYgdGhlDQo+IGFsbG9j
YXRlZCBtZW1vcnkgaXMgaW4gdGhlIGNtYSBidWZmZXIgYW5kIHRoZSBtZW1vcnkgaXMgdW5tb3Zh
YmxlLg0KDQo+ICtzdGF0aWMgYm9vbCBmb3JiaWRfbW92ZV90b19jbWFfcmFuZ2Uoc3RydWN0IGZv
bGlvICpzcmMsIHN0cnVjdCBmb2xpbyAqZHN0KQ0KPiArew0KPiAraWYgKGZvbGlvX21hcHBpbmco
c3JjKSAmJiBpc19pbl9jbWFfcmFuZ2UoZHN0KSkNCj4gK3JldHVybiB0cnVlOw0KPiArDQo+ICty
ZXR1cm4gZmFsc2U7DQo+ICt9DQoNCldoeSB3b3VsZCBmb2xpb19tYXBwaW5nKCkgYmUgdGhlIHJp
Z2h0IHdheSB0byBkZXRlcm1pbmUgaWYgbWVtb3J5IGlzDQp1bm1vdmFibGU/ICBUaGUgdmFzdCBt
YWpvcml0eSBvZiBmaWxlc3lzdGVtIGRhdGEgaXMgbW92YWJsZS4NCg==

