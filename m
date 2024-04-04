Return-Path: <linux-kernel+bounces-131026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B9B898224
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D26B287243
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E5859B75;
	Thu,  4 Apr 2024 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Oy5fHIYn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RsjzlJrZ"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7371CFB9;
	Thu,  4 Apr 2024 07:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215350; cv=fail; b=qz36t4v+q4ZgcYSbQienJysaCOwRV2Ca5a4w6BjH8mk7bHNJfauULdLJg4l4cdBTpjSA+pD8D0X0QjNsb68B7c8azUOsn9N+JhPd4JCs5Uvm+8DJnrPvYN/O2dq3k6zor/gfOCdrp3s8k/epl9iW8T5kw8/AFv/S6NTil+0ax2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215350; c=relaxed/simple;
	bh=6l8aufAwj5/GRGg6JFg+cnGfx7Uu/3BNP1h6/jLTXm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XWXva2+ymbIX9OCQfIZ1T3xkJRnG6VlARpfjbY1vE/XBmfiDPFf1nr5GbyVjxYkSxzcEFMNZ02HvFeWqvgz0iWyAVeEzF2YKwr2J610ZSSWWWNO149BO8Yxqu9d77uKcIuS81l3dsdcpWZShIXyKtFpyXzUYD9QqzFWt/W0MglY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Oy5fHIYn; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RsjzlJrZ; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712215348; x=1743751348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6l8aufAwj5/GRGg6JFg+cnGfx7Uu/3BNP1h6/jLTXm0=;
  b=Oy5fHIYn4gzeMocipFxbldhz0Pa4uAgdYI+y9PK6eQ7E81LwVpzvN+MC
   WWsyXF9OLPAoeYynexH9CYjYUACdNuxO6tmwHAAol2txmfGbdFwGZAQJV
   ocKIpcKyOPlw6sCVJef61QACDjbgvd0HMUR2k14ClZVFmiVyPnSD3CK9Z
   Y+lBdr5tW/TGaoBsrea3u9PtWUJP7xFoxI7xI5JdGEwjabah8PBKJcclU
   MKR28/vhrS8RPFlvsOCELkXm8RhZXb5dLPD0Sc8c/TJ3IG/PaXKZk7YAY
   URMhoN38ARHOKKojiSZ4HGK6J6wC0DhX+rSG00UizZiutkmjtUNp65FSr
   w==;
X-CSE-ConnectionGUID: hm8Qac35QsyQVESFZ6PYJQ==
X-CSE-MsgGUID: qHXxg3wzRyKXSCqvMRR8yg==
X-IronPort-AV: E=Sophos;i="6.07,178,1708358400"; 
   d="scan'208";a="13058101"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2024 15:22:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKNWybV6zi3KxniB5HpkjRAKXu2tL1m302vvOZcCYiYJWk+7wVL9dyRmrBYYItjPrktX7maf4CzxWGJHoLOKK4OmxDTcuHk7rukKO7O2pURZ+O6cUrEoL+ZY1+EY7TMvkSN1c+6TJDI5K+au3NYtEc2g5zQmalxTel/10wPUGzQB94ANdEA1fupnTKfQNk4N73xNoD9x5nq5Qrv3kxmYcNwuwdCJ1+fKcpBs9xZyYVTSWp0GmJyN6xHVR3QtmtK0a1RhFOidu6VGROICdiAM9HAswTal0i43aCDXtRYHoxIzEmSuv+0UELVonet5PTMnK+EER+aZfh5kojm4hSdh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l8aufAwj5/GRGg6JFg+cnGfx7Uu/3BNP1h6/jLTXm0=;
 b=ZhUXWrediYCQnDOrPXVMqJIm64h8/ttW9vQwp47cTEwhIW/O+YA0wGKSrdmGIA2rC5g+vM2yfqe5pPZ0XD6AijTgVErKKVzkeewOi8fBnPvMtzKYfQbkJymjg24Wd/Svc5FMkNHtUONeLUgrIoIho5AjLIma5mK3Imf7LQ73wLWw6f5l5UUz3Roy10/7BZ/KK0YQwm1bLiU8jozTeBZJRSK1/yTGvkYr7YzAi/JbGQAse5EUM/uK2nJOrKWrWvknJaRP5x3ljJ5Cda7O/aBqa/Y3TIkmZ1FO/exKiwlaDAZ8EgwOrBim+bAcTntNn0HubRe9C1CQTnR33xfMGCXC/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l8aufAwj5/GRGg6JFg+cnGfx7Uu/3BNP1h6/jLTXm0=;
 b=RsjzlJrZTK2X71VQXbzzjxdQ0X3X6lLwXdRjqKLoWGzuk6tVA9oJej0apJK+BPCUnlZ6wxu8RVvTBm3N7CtciGmP8Mfmy3RbO4vb/Y5LzLf7cpZ4kTaSFu0JJe+q4V7EDxu6jdlldzCx/j/8bOEqvviE9hSihmsE5YTwkuxcuQ8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ2PR04MB8780.namprd04.prod.outlook.com (2603:10b6:a03:537::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Thu, 4 Apr
 2024 07:22:18 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 07:22:18 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, "James E . J . Bottomley"
	<jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
CC: "hch@infradead.org" <hch@infradead.org>, Bean Huo <beanhuo@micron.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] scsi: ufs: Remove support for old UFSHCI versions
Thread-Topic: [PATCH v2 1/1] scsi: ufs: Remove support for old UFSHCI versions
Thread-Index: AQHagBbadNnO08pKSkSNxLt/0+cGXLFWx02AgAAuM1CAACMUgIAApyeA
Date: Thu, 4 Apr 2024 07:22:17 +0000
Message-ID:
 <DM6PR04MB6575CDA039392B495837708CFC3C2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240327071714.757-1-avri.altman@wdc.com>
 <20240327071714.757-2-avri.altman@wdc.com>
 <66431679-26f0-48eb-8303-35e151481292@acm.org>
 <DM6PR04MB6575BEBF605C9095E62F49E3FC3D2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <4b90d403-b18c-42c9-99b4-013eb7fcf8a8@acm.org>
In-Reply-To: <4b90d403-b18c-42c9-99b4-013eb7fcf8a8@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ2PR04MB8780:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eWnKyVLEYNQifxt23THd9hPfn94XfoLdf3A6gJnBmH/0pt34zF4OtiTFGU3sLyvHyGUUa/xZ18dmJ2ayF4LbuDCRd4uwmqBrRdSEMXXA6EmIgyfnKqGG2bUIeP7o+wDW1wSjTc5xjYJTfNN/CZH1e7uKS26ofitmCHhqa4Bir7jtPtB+Hf/25jMHWueiyfrVsGlJ6T3KUSlpJYd4wvlqR2fM0YiCR1OHQGw07LwyF+k5/tDtIUJ4AuVpNEibYDesims/erB5j1VAFdrvnxX+uqCEXfV8uNpxadDDeDbeUJSr788wY/KBMy8Y65+wB0gMxaJskmbbHpL1VrDDXS63FBAitKN9VV9ohxBbJOb/mI39vHnXTm9YiDEn+suor+EZksazfo3Wk0Xuq64jTMSKEHbOq7mm/UVfbdtlMFTJEi6AGW6AcAPaTnk0x/+XgnXW3Y044NKnBn84ls5BFulyIjqvJOXa0qpbAO2aDvP3Dsi5JZRx29j9NcF+46VO7kcb70QBk0UW+KoY7hGyJu2YbVN1fN6R12rQ432525OkromUJYiAj8/e0JGBKJy16K7udLvB+9XXsKkHHH3L2pY3e7ylf1Z/h3ePKorKo8pF6Qk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFVKRGQvNVR5SWNrdzd3c2pRa1phZzZ3YmYvVVdmU2RGcjhPaWNqbFFSZmZT?=
 =?utf-8?B?SjQ1NStvaUlYdWxNWUllUTJESi94bDZqcWloTnZVSVVSTzZIdGMyR3NySXpT?=
 =?utf-8?B?TVJmM2dxaU1ZZENvSmwraGt6WGJpOUljR3N5N1p1a1V3OWZYU1o3OGJlVmVG?=
 =?utf-8?B?QVl0bTkxZTJyZzZGWSs4OE5ZNGc0Y3lGQmVZc1c5QnpwN21aL0lQWUVwWk9Q?=
 =?utf-8?B?UmNLM2N4S0NlRGpoSjV3K3JqZktSRDU4bUlodGdEY09zeWQrOERUVDlhN3F1?=
 =?utf-8?B?UG5wNjFXMVBUN2pOVDRMSjBqZ09ZMnUvdWY0MDVCRFpwNC9pemx1QzRtVVA1?=
 =?utf-8?B?NElKUnU0WWtVS3dGdytVUnNHcDZMVTltaldYWDgzMDAzQ0JnRHgzMEJpK1pL?=
 =?utf-8?B?VW5Tdmk3VkhHb0xlUHZhRkExSWRnTXcwaGhVSnlUdzUvbEpqeUs4Wk9ndWlI?=
 =?utf-8?B?ZkNKNjlUM0ZhSVRzZ0ptbFlBZjMyRGZFRThybEcrVVBEQ0RYVFI1QlI1YUtm?=
 =?utf-8?B?SEI3QTVYQ1orZE5LWTdpLzgydmJtMldkbnlqUDRjU281S2ZtNmxhTXdHWEdL?=
 =?utf-8?B?QzV5dTlXbXN1Y3V2WjdZMFpUSk9ncWlyeDhieUNoWGVoeDFmTHhlRGxFaGtH?=
 =?utf-8?B?cW14Q3hPdDBBMXYyT1FmZzcyUTA2NnY3RE5RU3FvTHQ3aUloN0d4S2FRSGM5?=
 =?utf-8?B?MU1iTkFEdmNUYndaSFFqT3N3RmJjK1BPNEhxRlk0Tk1sM2tFQ2tzRHpkRGNN?=
 =?utf-8?B?Tk1VMWdJUGtFempYSDNaOEtlcHA2OUh4OG10MFlEeUFQVk5jaHlORmt1SnhM?=
 =?utf-8?B?VWNrSWphNFkwS1ljTzRKdVl0QlRwN0tNZnBRUHNCZzRFVW9BRDhwaUdEektT?=
 =?utf-8?B?QnA3VklUWUlQbXRqZkJqR0g2TkR1djUwa3g0ZkgzSE8rb0FLanJHR0tuRGVl?=
 =?utf-8?B?QnpYN1hzY0tLSm5jV1diMnJneDhRVCt1U0NWdmxIQ2p5NW5BR3VabUZoR2Rm?=
 =?utf-8?B?M0ladnVXeDcrTUR0d0RKZ3dBbnUvQ2d3SE5kQUNuWlJVekd3MHQ2Yis3STJP?=
 =?utf-8?B?aXB5RGlXaCtRVHJQRlJ5ejBiVFdoOWFZRU9vUEUrV2lOR0xMaS9McTB6Nk42?=
 =?utf-8?B?TW13alhSOHYybGJxay8zS1UyeHl3a3JPLzFKUERCQ0lPU1NyOWRWMy9HN04y?=
 =?utf-8?B?eEdvZHpVUE9pNisycVZhZytmMDRmcnhtS01PY1h4NXpMeTlMa0ZyVDl0WXJj?=
 =?utf-8?B?TlAvRVM3RXpkU3FEanllZkZLMmtoZEVwT2l3TWwxMExmWlZKSjV2T3RsOTht?=
 =?utf-8?B?TjRIdTdhMHF2R3hIQ2hKckFwdzdDaWxYRjBONjBySDZSVzlyenlSM2FqME9p?=
 =?utf-8?B?WVM5NFlONFJmZ0xlRkhBK1ZyUkRGaXNXcjVPUjRWZTRURUFqWEVhTU4xaitJ?=
 =?utf-8?B?SUdqdHpINTIvV1pIcVU0ZHlzZE95V3d1cmFsVE9SZGZPVnRRTVdmY2c4REY0?=
 =?utf-8?B?c2cwSG5vampJdEVPc0NCMUlVQjU3OEdUQ3J6LzV3RllObTRJN3VqZm1abXk1?=
 =?utf-8?B?RXJPMUh0OSthb2FFSEhiSDFIT1NmaFNnQ1BDTGM3b1pkYXhBUzRGVGo5ZCtn?=
 =?utf-8?B?K1U4ZVFOL0tLdFpnRVdzSklEdEY4Z1JNRlZuQjhhOUJQWXBCcXgxTUJ0NEJl?=
 =?utf-8?B?WUlDRE9PVThnRmJiMXprQ0ZJYjRmZWVqYml1VlY0ZVhkcFpzdE0yTTV6djBS?=
 =?utf-8?B?SDlyNk1wZjdrZEtpT3pDcmcvcjJjUmZNL2NFWENoVXI1LzdweTRjVE5makh6?=
 =?utf-8?B?T1FQS0FCUWxFL0NSR3NpcjUweU1Sa2hMSlljUkdoamFWa1ZkRC9IR0pkLzNo?=
 =?utf-8?B?bmhha1Y4aU1zT0EwLzZxMmhEdEgwK2RUVDU1WXU5K0k5OGViT1M3NjZJNk9P?=
 =?utf-8?B?L25kWHVDQ3kyMTNGWEV6UGlidjR5WXB4QkN2THBkaDczVXV5aEZiMWxmQlNn?=
 =?utf-8?B?a0pXNzhPTWYyeWhuanZNcFNSUmc3b04ySFUvMUlpVEpDZGl1dmhCc0pqMnZY?=
 =?utf-8?B?UTFmQjdjYUpFamNEVENUVUVKWHJmK2NnVGdXOEhHU0xvbDJ0Q3YzLzFiZnJB?=
 =?utf-8?Q?gmBqnYQqaqOIYEa0WcGikrDCe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aTiFxF8qtvjibjuVO6GH2GLwI0AujV82Vyyjapsc961xkHsQvTJ2wqtH9+oMQXY3uSZEw4gAAzYzkMNOTxrjhghNEKkmZdiyP5E4pqonMjvvzq2J413m4fxa2vQnhSqBrsvhVEh+BW4leIBAT+jIk2NW3Q+HIzz0mfkMoiY6d4kWX9RIPQ/Tec9r0uUhjoCj6KshUHSl7TW6gRABpbh7jbf1G1Y8l02QVRVkSurGuknUwVUC0t6GHxFg3F3UaJ73xZXmzK8IdFOdG1I07gvVBk+59xtwv3J+ClDv4IfIoHI65OYkzObPYb8qzEbBLDuJ+G15OiIKW7NvbDmadq2gUG2B8tCBhqFKuuukZN9Im2H2ckeL2DjsCsK8ovIb/LMzwoqbt3JUuneqTJR1LRJFMzo7YEWGd14jDV2uZZSeqMvdiMRE+E5sGRW8TwFEl/RmXnQCO/p7Pj1emO5QaVHOguEvHqK7a+ixuiW83u/JD+Zs86EsjZev25d1DtEymqf+ztrEaHOQJwnHVcRvMJtwEdQ350JARJKA0Qp83FOM1HKQsqeWs8eI2G19prE20BK2PyJ4us/E7UpE3CKAkwIvXSLIxNq/LgO/f33DYQEm8b1Gz/FFIh/iXus/mewS3IY1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f526b7a0-074d-4815-0a8c-08dc5477f5ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 07:22:17.9843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kfnvYOOOrES6/K6zMFNUNTIxW5iAX3TpX1sFPH05xwmznw29sFlFvXKh5QWdWfiE1dAL1p5XgcPHBpiajSgLqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8780

PiBPbiA0LzMvMjQgMTI6MjQsIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+PiBPbiAzLzI3LzI0IDAw
OjE3LCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPj4+IFVGUyBzcGVjIHZlcnNpb24gMi4xIHdhcyBw
dWJsaXNoZWQgbW9yZSB0aGFuIDEwIHllYXJzIGFnby4gSXQgaXMNCj4gPj4+IHZhbmlzaGluZ2x5
IHVubGlrZWx5IHRoYXQgZXZlbiB0aGVyZSBhcmUgb3V0IHRoZXJlIHBsYXRmb3JtcyB0aGF0IHVz
ZXMNCj4gPj4+IGVhcmxpZXIgaG9zdCBjb250cm9sbGVycywgbGV0IGFsb25lIHRoYXQgdGhvc2Ug
YW5jaWVudCBwbGF0Zm9ybXMgd2lsbA0KPiA+Pj4gZXZlciBydW4gYSBWNi4xMCBrZXJuZWwuICBU
aHVzLCByZW1vdmUgc3VwcG9ydCBvZiBob3N0IGNvbnRyb2xsZXJzIHByaW9yDQo+ID4+PiB0byBV
RlMyLjEuDQo+ID4+DQo+ID4+IEFjY29yZGluZyB0byB0aGlzIHdlYnNpdGUsIFBpeGVsIDEgZGV2
aWNlcyBoYXZlIGEgVUZTSENJIDIuMCBjb250cm9sbGVyOg0KPiA+PiBodHRwczovL3d3dy5nc21h
cmVuYS5jb20vZ29vZ2xlX3BpeGVsLTgzNDYucGhwLiBUaGVyZSBtYXkgYmUgb3RoZXINCj4gPj4g
c21hcnRwaG9uZXMgdGhhdCBoYXZlIGEgVUZTSENJIDIuMCBjb250cm9sbGVyLiBIZW5jZSwgSSdt
IG5vdCBzdXJlIHdlDQo+ID4+IGNhbiBkcm9wIHN1cHBvcnQgZm9yIFVGU0hDSSAyLjAgY29udHJv
bGxlcnMgZnJvbSB0aGUga2VybmVsLg0KPiA+IEFjdHVhbGx5IHRoZSBQaXhlbCAxIGlzIGFuIGV4
Y2VsbGVudCBleGFtcGxlIHdoeSB3ZSBjYW4gYW5kIHNob3VsZCAtDQo+ID4gSXQgd2FzIGFubm91
bmNlZCBpbiAyMDE2LCBydW5uaW5nIEFuZHJvaWQgNyB3aXRoIGEgdjQuNCBrZXJuZWwuDQo+ID4g
RXZlbiBpZiB5b3Ugd291bGQgYmUgYWJsZSB0byBmaW5kIGEgd29ya2luZyBzcGVjaW1lbiBvZiB0
aGF0IGRldmljZSAtDQo+ID4gSXQgaXMgbm90IHJlYWxpc3RpYyBpdCB3b3VsZCBldmVyIHJ1biBh
IDYuMTAga2VybmVsLg0KPiANCj4gdjQuNCBpcyB0aGUga2VybmVsIHZlcnNpb24gb2YgdGhlIGtl
cm5lbCBpbmNsdWRlZCBpbiB0aGUgb3JpZ2luYWwNCj4gc29mdHdhcmUuIE11bHRpcGxlIHVzZXJz
IG9mIG9sZGVyIHNtYXJ0cGhvbmVzIHN3aXRjaCB0byBhbHRlcm5hdGl2ZQ0KPiBkaXN0cmlidXRp
b25zIG9uY2UgdGhlaXIgZGV2aWNlIGlzIG5vIGxvbmdlciBzdXBwb3J0ZWQgYnkgdGhlDQo+IG1h
bnVmYWN0dXJlci4gVGhlc2UgYWx0ZXJuYXRpdmVzIG9mdGVuIGluY2x1ZGUgYSBtb3JlIHJlY2Vu
dCBrZXJuZWwuDQo+IFNlZSBlLmcuIGh0dHBzOi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL0xpc3Rf
b2ZfY3VzdG9tX0FuZHJvaWRfZGlzdHJpYnV0aW9ucy4NCk9LLg0KV2hhdCBhYm91dCByZWZlcmVu
Y2VzIG9mIFVGU0hDSTEuMCAmIFVGU0hDSTEuMT8NCklzIGl0IHNhZmUgdG8gcmVtb3ZlIHRob3Nl
Pw0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEJhcnQuDQoNCg==

