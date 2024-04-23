Return-Path: <linux-kernel+bounces-154675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 341A98ADF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAA0287C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F42551C5B;
	Tue, 23 Apr 2024 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LDbZ55uj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Vc+UOy6Z"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76B21A0B;
	Tue, 23 Apr 2024 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860533; cv=fail; b=u65+kU7nk8Kuom+goncIw+ulqHEp2lgWhpbzXGMduoZ+SuPRdxscf1YGqAqL+EedUXCGIu6IX3PlU5BN1MmkCSY8hZ9V1bN3OutHxAhRj1IAHctlP/KHHlXzvvjhvqcyZlYfNvsqfiLPvSnYO0pT0pWVClv7h05Ym+QZatwamAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860533; c=relaxed/simple;
	bh=k7GO3i3MsdaV5g5QTL2AyceTRCUqRgdpTRfZ/VKB4i4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nW6NDb6vRbkWNdqBlGeVLCL0Zc/Z9NOclBp/UTPgOaaLj3WnfLShQelMIEuHj7eKzuz78BnWqQwqhs4SZvoaTAguVu08GXmK+gCKlC6ToCRGOylQ9SWHy8bYJSB9rvF3h4l1ghOVAPUjITEEU8NcAgyyxadnQ8O2XJ14FCMQkOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LDbZ55uj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Vc+UOy6Z; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713860531; x=1745396531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k7GO3i3MsdaV5g5QTL2AyceTRCUqRgdpTRfZ/VKB4i4=;
  b=LDbZ55ujltv+Vj3DcgQpUIwLFtKtx2Po4P4yg9/kGMnDQ9s42rxxao4G
   Qv/io76Pu5qTPDDfgwIXO38KDKY/ILoO7PUNuxy/1cmirUpgz4PfTyqi0
   xZtvl62G10DTtrJuQejErgs470Y9Exk6ikU7ghA0lNVh2L15J8ud1Xbvw
   +l3hEgHSBO2UebgO6E3X0zR2n2l5liVxmt/GXd4jItbzXhb9t7GfsB/2L
   ICJEvlLFkRBvAKBHaM7bGKdwNesgw3Q95YSL7ZBCaCO1cKulKFxHryHOP
   hTeHaAxkKs6glC0JU2DFDvnwtsZYIapcRMXBj1ty5qwVUjCzbwe8ANxJP
   Q==;
X-CSE-ConnectionGUID: /nMZV1mtTcyzaoFBo4efNw==
X-CSE-MsgGUID: mARlVVTvR1uWvThTXezBcA==
X-IronPort-AV: E=Sophos;i="6.07,222,1708358400"; 
   d="scan'208";a="14635073"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2024 16:22:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnMyU7unWflib5Fra0TEUdsugx5j9aQaY1/47J0aB3GvPBeWNU/CvKcaD0SFDNMR9LY2AdxP8k/kdxn5H1Mk+jTz9DovX/Somsyv09XkFDT5DhaOvqRb3ymn70mt3y80opk3PJzu7hq//FfmuWm3urZNV5Mtam8iTwyLXBqp6nqeLjKPQT5+sTFay2blcGUYTRVNzDSHj/YU1z1H78TseNEUhH/H/uNIah+/XDQIdcfkbVYTcI74mMGR2bLorcxQHLrPlHkhYcvHY6r/bSS5KZnOKW9EhxM23FefIjQWrXayR5qLV6BhzbjxzRs+YqWPqqBIFeN4J13pxPeNbgBEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7GO3i3MsdaV5g5QTL2AyceTRCUqRgdpTRfZ/VKB4i4=;
 b=DX+fgiBlNOebStK7QIKNcX5cWZyqWk0jiHzQFajAvU8uSSIPbe0gvpLlH+TEb0Kj2mDfQ6LFOgNoUoUJrzJ7iYpMN3HYCPIMVu/zqUuZtPgEaqPBm7wq/Rwtg1eXkSwmEZXgDmISjPj64tWgylWxUnZGNDg2SGOhhNRrSQ8/ROQkRa3vwavYTgGK1eP5+rIxHYeuLiOYkZ8hqjsR89vSJi4WscxZgapV8L42bAfE3tp085nIEf/u09ljWVntBK4r7FvGBriQt7T/g+zGm5cMBMC8NLtuI+s3vZ9tpp9hLZc6iJDIy4ZcSw56KIkTxXpOsI0Ij89t6F4W7kNkoqoHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7GO3i3MsdaV5g5QTL2AyceTRCUqRgdpTRfZ/VKB4i4=;
 b=Vc+UOy6Z8LGt0OFOeX48KFTdgoCTIpiUN4R4zdeSJLyJc05v1RiXjadYaSMwMUz3qljrpRJMJNO7tokSQjJxfYHz9sxrPWJHTVEN2YAW9q4njPZLHliYuYA/0Xxb6rlp3kupzNNQjxpLI0lrHHcuyauE/s8dh/sbI2TK3mHIFPI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA1PR04MB8468.namprd04.prod.outlook.com (2603:10b6:806:33d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 08:22:05 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 08:22:05 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Shyam
 Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier
	<jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche
	<bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: RE: [PATCH v5 0/3] Replay Protected Memory Block (RPMB) subsystem
Thread-Topic: [PATCH v5 0/3] Replay Protected Memory Block (RPMB) subsystem
Thread-Index: AQHalJY+lZ6WHfQ3U0uUl8CgTGkiY7F1Z+KggAAOwgCAAAz4sA==
Date: Tue, 23 Apr 2024 08:22:05 +0000
Message-ID:
 <DM6PR04MB6575E485C2CDB40CC79A3081FC112@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240422091936.3714381-1-jens.wiklander@linaro.org>
 <DM6PR04MB6575CE5A70F2C733DF40E54CFC112@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAHUa44EzMpRbhJ=-h4hJifgtrMsvDZj=Zt4C3JkDxjKE4gz=7A@mail.gmail.com>
In-Reply-To:
 <CAHUa44EzMpRbhJ=-h4hJifgtrMsvDZj=Zt4C3JkDxjKE4gz=7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA1PR04MB8468:EE_
x-ms-office365-filtering-correlation-id: 0b2ecfd5-712e-46b4-d424-08dc636e75ea
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?MjBWaHFvdk5OcjkyQmQxTnpKYXJmOUFWamVEa0lUSk9rSWhMUTBxN2Yxd21r?=
 =?utf-8?B?MFVDeHRwbFJqN1J0TEhicWt3MENqZ3U5MG9IQVNyOENxZTBib0cyTjJ5SUFr?=
 =?utf-8?B?OC9sM0NnYVZ6MzROR1I5NlpZUWRURUJPRE8rT01pNGJObk5UNkJmZ1MxMG1T?=
 =?utf-8?B?TmhZZS9BMVd0NUd2bWp4ZXJsMEw4RnQ0ejhlQnJoNWlIWDdSYThwaTFSUldG?=
 =?utf-8?B?blVhTTQ4dmtFUm9mY1V5amg1WVhmQlA4NkhBUjZ6SXJmcE1HN2ljOXJ4L3ZU?=
 =?utf-8?B?YUdEejBWeGhrSDJjQlR6aDgyaFY3NTRQRlphMXdDYUJGTlM3eS9uRlhFUE0y?=
 =?utf-8?B?TjhySEZZZko3WlBMQytseWNhbmZ0VG11VHhJN2V0L0ppcWhZYlp6Uk1lSWhQ?=
 =?utf-8?B?U0o4d0tWdWp5Q1JTYzlhbGVCN1ZGdWg2SjJlVzZGQ1Irb0xsMGg2YndCajZL?=
 =?utf-8?B?ZGZ0dTJxakN6OGtzdnZheFB6R2gxZXhWZnV0bkxvdVhCSDVPWmxqaFZNZkpR?=
 =?utf-8?B?U042UnRSNWxmWWlWeDhlV2x4YmxDVVlvMUI3MGZ4ancrTFhMSC8xQWN2RUxM?=
 =?utf-8?B?ZXd3Nm9SUUlIRnFJQ2xMMzlpTWo2SkxGSzRkV1VJVCtjS2FNY3ZyMzRqUHM1?=
 =?utf-8?B?SHk4WWMrMWdiN2JUYjlNRXIwajV1czFNRGg0SmlxSy9PRGRDeXVuZDY0VEJx?=
 =?utf-8?B?NlBVZFZiREd5MHZXK0FVUlVuS2pBUmdCZDh0OHUwOVVSWlo2M3NuQlBnY2Zy?=
 =?utf-8?B?UE1pRzJRRS9HaDZrYWJrMG1jdXExdnJ1a24xWlZyekVsVSs2MXdrd09sbDJG?=
 =?utf-8?B?SXFyYUhRR3RlS2I5V3V2Unp6R1F6VDEvd2JBNktnbk1KUlMyUnBQWHp4SlZ0?=
 =?utf-8?B?SERWMzRxcEdoejRwRzRLN2RlYVZWQ2lDV1paSVVWeVRBSDlmenBmQjBrRW5R?=
 =?utf-8?B?bzJDSU9ZYzlyV3FFd0JuYWpjeE5nSTc3N2pEOFhZVHZYT3oyMUxrRERUbFQx?=
 =?utf-8?B?TS9UeUVPNGEvWmR0amFsOW02QTlBV1U3OW5XNkQxSkhLK2kvZXJ2YVdjLzI4?=
 =?utf-8?B?M0xQRlRZaE5EKzJiZnF0bUovRXFKWFNZdTJqYzJZZHpHWGZPVE9iWFFCWm1p?=
 =?utf-8?B?anc5a3BYK1IvOW9Ra2tKbmFFOENieGtPS2V5TmhZLzlWblVlbkowYjQxRlVS?=
 =?utf-8?B?NThrRGFPalJqWGlFcTdKQm8zcWNPWHY4eVdYUUxXYzVXMHVPV3BFQ1BtZkJu?=
 =?utf-8?B?YzlDaE1jd3hxTWNHcDRYQUphYVJqTys1VTMwQTJFYmlObHFHSE96eEJITCtp?=
 =?utf-8?B?S05tdFRKNXFmOGFCSkJiYkZuSUtGVHl5VktkZU9pTUtmV0plS2dzRDJ5WFha?=
 =?utf-8?B?UStxZit4VUxwNHk0OW1zM04yQzZaSkN6eUJEN1poVjNsN2RNYklBUERxQ3Z0?=
 =?utf-8?B?WWt1WmpqcERFaWhrNUxGbkUzM2g0bHE5K0tncmgwbUxDaGRuMU9FNmFsUDJh?=
 =?utf-8?B?MTlHSGlLVEhmMnE4aDlpOWhhcnZMUlpMUHlyYmFHZ1lOR1M3dStqeXlwcllH?=
 =?utf-8?B?ZHlWYmNXZHYxVmtINlJuakgzTUwrYmt4S0pmcG1CQW84VUNzYlRMVmk2bkpa?=
 =?utf-8?B?dkhaWlpra25zZXhGRVlVYnFxWFA3RTQzY3dzOXo5eGI3RnhwNlZRT2RQbEhB?=
 =?utf-8?B?S0w1TE9tNENPdk9Oa3o1c0V3dXNVZ0oyYlp6VE94QTRXZ081alluS2RBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEFIY3BrUkxraTdCd21QMU16Mzh6U0lYcXhqQmNLTHE2bjRqK3JHeVJUVDZz?=
 =?utf-8?B?ZktxU0lVbkdpWnZGaUkzNnJKV0Q1OExnaUZQTDNySFN1cEp3MW56eFVMbjJZ?=
 =?utf-8?B?ekJXcVdpZFJxWGhkUlM3TnEzZVVrenFybWJETkhiUXAvRUFSUDEzdkZ6K0Ix?=
 =?utf-8?B?c3BGcmhjS1VtN3NGNC90WXJKa04yT0dyMitEYkZhUHdaWUNOWjJkSXRQeXlq?=
 =?utf-8?B?T01UeHJYdEoyZDNsQ0hrMTFDUlNCRnh2NkpMVG1hMEYyVGxOdGEva3NWS0VS?=
 =?utf-8?B?UmR4dnlpOHAvRnArcHlqR3hUTXBuVnVJUE5HSWN1YThsenVkSGkrb1dUbWdZ?=
 =?utf-8?B?c1ZBR0ZBSHZ4b2RCODdnSGxOa1R2dTJabnhIcFdvMEFGa1pMdkhGWUtjRFo1?=
 =?utf-8?B?WmFwQi9kY1lNS2NYV1MyWXBTbjM0azZ3YXNFaThNNjhraFNNTTNQZ3k0WitX?=
 =?utf-8?B?OEJNL2ZRcUJGSnRvMHgzS2tDK0dYdjE2N2Y5bU52cE8vajJzS1VTd0UwR2t2?=
 =?utf-8?B?aHJRMWZHVE1LNkIvbUpSMDFkTmNZWWthSHo0ODBLSU9ES2NPZjMxVkpRQ1pF?=
 =?utf-8?B?cld4blF1UmJpSzdzRVhJcS96WnFERlNnc3hUMmJ1RStXN1dYSm9ndW5ab25s?=
 =?utf-8?B?QjBpMVV0djJ5MmVJZlNYenVnNVNFZHZRYVpranI5blNEby9SczRDOTJtODNW?=
 =?utf-8?B?V3hOMUFhQ0NnSlBraHplTi9PbFpCRm9UN1ZPeUQrNXZ6aEFqUkZoZE50SUND?=
 =?utf-8?B?OUw2KzV5akVXR0ZIUnVSNEVYbG9yc2Fxa0RJbVF1UUtEcjF6UEVVbjBWSld4?=
 =?utf-8?B?cVR4L1YrTHRkYlRKSlFIYXpXaGxJTXRIZm05YUxxV1UzTVZzcHdaK3E3c1ZE?=
 =?utf-8?B?ZlZZQWFidEZSNU9WWW9uYnNwSUNoaVlYS1Q0T1ZLRWlneE1yZDVjcmI0YmJv?=
 =?utf-8?B?UW1Dam5jb2J3V01uSjJiVFkrRy84Rlhpb2cwdEFBQWd2SkpXbHU2VXAvbTdH?=
 =?utf-8?B?MXRQUnZnejhyalVFV3Fpa1kycFRKa1NNUHBBQzdBR2NkbCtiNWdzZ2pHbkdG?=
 =?utf-8?B?TjBCeWh5UnA0UDN6UndnOUl1UTBFSlZFd2lDK05NRnFhR2pNalVxSHh1RG40?=
 =?utf-8?B?TDgrMjE2MTdOV1J4bWlZZmIxajdMYkYyVTN2OUpKY09NTXFVdnA3a2JQZkEw?=
 =?utf-8?B?S2IyMHEyZ1ZHcDVVcEhKWW92M0dvSi9sMEFoQ2RlUXlTczFuMm5FakNwaE9R?=
 =?utf-8?B?UFNKMHJqZHkxbGRObWltS0lmOHV3UTlSVThNUklaSSsxaXpaYVFVaHV4aVhr?=
 =?utf-8?B?dHhWcDY5S1FxbjBHNTlnN29MUHA4c1JkMUZGSEx1cytVejhLUFpSTENMdzJa?=
 =?utf-8?B?bS9WdjhsOGwxM0dYWERvUUxSRTVwbElTWTEreDQxT0R2dGp0SFF5NEd5ODhH?=
 =?utf-8?B?dnFSdlhIT2dOMVdySzAzY3lLMENPaWM4RTB5eDc3cWRqOHJjNFFrNUM0d0h2?=
 =?utf-8?B?UXF6enZuK3laU2d4eWpzd0NSUUhkK0VpNVB0dHBoZjdPQ1hDYW5FM0I5KzBD?=
 =?utf-8?B?emphRFVmUXlaRU96L2ZUWkZLMDlUYlJsQWRTN0R4OGpXaWRuZmhULzZRUExr?=
 =?utf-8?B?dEhyZVpETnplMXVPRVlzTThOeERsaTFtQ2I2TUUwL2FIWTJWcktYWDFMWWtw?=
 =?utf-8?B?Nll0UjViMVNldU9pUEd3dURjQnd5Q2M5bzlKTTM1SG1mL1pJanZmQnU1WkhK?=
 =?utf-8?B?VHZLczhud2p5UVNkSzBMWHJ6TCtjQXVFYzdpYURUTTRmY1JxOGY1L0FmbFgv?=
 =?utf-8?B?NlJLUm9KbTl2YTgrYWFKMnNTOTRFLzBnL3pXZGswcEYvL0Jac1NvYXhCcFJw?=
 =?utf-8?B?bUMzK3R0SE0wY1ltY01sUTJaa0dwK3J3dmpIS3Nlb2lTbFk1VkhJZ1JyS2RK?=
 =?utf-8?B?eFJVTVF4QXVNMUlvWE83VVJhaHNISE5yd3RMSDVyYjZNdldXY3FaRmI2Vmk2?=
 =?utf-8?B?SUs2ZXExbGJtNGYxUHcxMjB1SFlXOHBMSTNCTWhpamI0WVFwekJrUHJEeWcz?=
 =?utf-8?B?aHJmeWlwZDkvSjhrL3U5VjV3TkpLaEJJOEhoYStIUDUyT2xXbUpqNUh2dVEz?=
 =?utf-8?Q?i6Z5CFkhrczMQeRliL3pM50oL?=
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
	xKUsUqkQ+fAUAPKiS9LkqLxBm1vfoTrBBfS6GlReLdxev1/my/3gDcNqcmHQ6mQDiDkrVMVMc2GPSpk3M0Di3jNxE7FQutM1sLKHcGTJJiTcpP+Kgworgob3hB3TFVVaxy7PAaq0yWOsn/TaLIWDQwjrrfdLXhYWyN5PPdewFIWJS10ufYskwyUEdlNaKpZgd3fLuiz8Qar8n9zyPZoDsM/MC4Ed25ZBOm+avPxzWM18CThuVfJU8iA1yD+i89golw++5sei637+6F/uwRFQ2ajEUfJPy9RCYg4HMhzCyNPZxQKgYguidKHWkVq9+qUzYOl++mH520yGzNOWSCEMLm3sZz1kaj7Kb8D8Y3ACjEWYaW+JQrLyNaqIBGKTsNmP/C6tVJdFUiY+DSJI+hU42JOjuogncv9CukpzvJZQmdPwUDV5kQs0rd1GCn8VBJB2BWDsN/kPllEH8+ZinCwNfxmfy04SA2yOT15+eky7VypY5QDnpqUu2ckmJcQCrj8oU4MxI39u3FiRXQMQ69JxFCmpx7I/LJjJVA1qJuitubIKLCsyfGKE6cD68ALf8tgnMaKk0JxelfgKnoCRNwFw2PZemYlhgJk2QsXlkuFc3WJ0PsfcsfmaYeGmf5yLLr/z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2ecfd5-712e-46b4-d424-08dc636e75ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 08:22:05.5049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQITu3KofJpZc66ec+yqhJLdJvc48DoiyBuphkftcaytS9J0EwGzkEsEA23b917GIiKoFIDLemJk/yqUaxwwWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8468

PiBPbiBUdWUsIEFwciAyMywgMjAyNCBhdCA4OjQy4oCvQU0gQXZyaSBBbHRtYW4gPEF2cmkuQWx0
bWFuQHdkYy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiBUaGUgT1AtVEVFIGRyaXZlciBmaW5kcyB0
aGUgY29ycmVjdCBSUE1CIGRldmljZSB0byBpbnRlcmFjdCB3aXRoIGJ5DQo+ID4gPiBpdGVyYXRp
bmcgb3ZlciBhdmFpbGFibGUgZGV2aWNlcyB1bnRpbCBvbmUgaXMgZm91bmQgd2l0aCBhDQo+ID4g
PiBwcm9ncmFtbWVkIGF1dGhlbnRpY2F0aW9uIG1hdGNoaW5nIHRoZSBvbmUgT1AtVEVFIGlzIHVz
aW5nLiBUaGlzDQo+ID4gPiBlbmFibGVzIGNvZXhpc3RpbmcgdXNlcnMgb2Ygb3RoZXIgUlBNQnMg
c2luY2UgdGhlIG93bmVyIGNhbiBiZQ0KPiA+ID4gZGV0ZXJtaW5lZCBieSB3aG8ga25vd3MgdGhl
IGF1dGhlbnRpY2F0aW9uIGtleS4NCj4gPiBEZXZpY2VzIGluIHBsdXJhbD8NCj4gPiBJIGFtIHVu
YXdhcmUgb2YgYW55IGJvYXJkIHdpdGggbXVsdGkgZU1NQyBkZXZpY2VzIHNvbGRlcmVkLg0KPiA+
IENhbiB5b3UgcmVmZXIgbWUgdG8gc3VjaCBhIHBsYXRmb3JtPw0KPiANCj4gSSdtIHRlc3Rpbmcg
d2l0aCBhIEhpa2V5OTYwIChIaVNpbGljb24gS2lyaW4gNjIwKQ0KPiBodHRwczovL3d3dy45NmJv
YXJkcy5vcmcvcHJvZHVjdC9oaWtleQ0KPiBJdCBoYXMgb25lIHNvbGRlcmVkIGVNTUMgYW5kIG9u
ZSByZW1vdmFibGUgZU1NQy4NCkkgdXNlZCB0byBoYXZlIHRoYXQgYm9hcmQgYnV0IHdpdGggYSBV
RlMyLjEgdmVyc2lvbiwgc28gSSBjYW4ndCByZWFsbHkgdGVsbC4NCmh0dHBzOi8vZ2l0aHViLmNv
bS85NmJvYXJkcy9kb2N1bWVudGF0aW9uL2Jsb2IvbWFzdGVyL2NvbnN1bWVyL2hpa2V5L2hpa2V5
NjIwL2hhcmR3YXJlLWRvY3MvaGFyZHdhcmUtdXNlci1tYW51YWwubWQjc3RvcmFnZQ0KaW5kaWNh
dGluZyBvbmx5IGEgc2luZ2xlIGVNTUMgZGV2aWNlIGFuZCBhIFNELg0KDQpFaXRoZXIgd2F5LCBB
RkFJSyB0aGVyZSBhcmUgbm8gcHJvZHVjdGlvbiBkZXNpZ25zIHRoYXQgbWFrZSB1c2Ugb2YgbW9y
ZSB0aGFuIGEgc2luZ2xlIGVtYmVkZGVkIGZsYXNoIHN0b3JhZ2UuDQpUaGlzIGdvZXMgZm9yIGJv
dGggZU1NQyBhbmQgVUZTLg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IENoZWVycywNCj4gSmVu
cw0K

