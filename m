Return-Path: <linux-kernel+bounces-69545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8373858B93
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E78528BDB4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3E57992C;
	Sat, 17 Feb 2024 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FMwlWSke";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yGUwmfCi"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881A3F9F7;
	Sat, 17 Feb 2024 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128660; cv=fail; b=jvY5qtCn/oLTZedLKGYSz+ApKR5UpHnsPOojKI9+2XLsI/x8WWUQ6MZiVoJIAX1/kQ5YRTHR/uvvjHwLDcWr2oti4lnj9y0ax7V0IMT0nPREKPyFS3GAvzp6Ru/ryoyC3gwfeozyfmxz+N9h8M0B1u5/CH+PGNkmDF5FNPYmbV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128660; c=relaxed/simple;
	bh=wT+2yxOZj7ufhadY5QYlsF2l412TVp3F/FNC3Wdoo6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BQpN8YGzrleVdnDzMDLsiKpR74ONKjgAjc2azCgshEsONB9dt7jCuTjRUEzJ8cgNDCubtlKapWXjVorTgkgMuF4eUylJolncUJH4GYx7FafORV4n9vrJsaQzMQCa44CF++sFYhTXlwEAYgOYKoLScDy3CtuQEL74HTDEck/eRAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FMwlWSke; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yGUwmfCi; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708128657; x=1739664657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wT+2yxOZj7ufhadY5QYlsF2l412TVp3F/FNC3Wdoo6k=;
  b=FMwlWSkeuFtLDbrYTQGNqYEHHfPF9cFwNTvGK/1DM0oywh+n8Xs5T3pV
   qZSk24P+KAUN4meqfXlak86wRcC8ufF9u5hXmi5RgnK2Q2lZC8Pjp7PUI
   SI36pj8j82F3mvTR8oUrUxB/5dOacODTgqm2NOAiPecvSMUf3g9s4Wd7o
   Yk/zOf8jgJlIQR4CH+rXDxceyykSlKgCsjl8//hzRAHTt0EOWPB48dyUW
   zXuQN60Xa3lUM5Br/jHPXIWvesZbNuU1gYxI+aAy0eNo7qmZBvFAFwGTS
   9X0IjCpA9qgSSGiJnWjGxy9ZnJDnN4794c3jDdMJV6qXMzUDyXyssT98p
   g==;
X-CSE-ConnectionGUID: YJPOFQWcTzS2AibtPnAdsg==
X-CSE-MsgGUID: ng5Pmcg/S4iM6uDF7Gzdgg==
X-IronPort-AV: E=Sophos;i="6.06,165,1705388400"; 
   d="scan'208";a="16382798"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2024 17:10:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 17:10:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 17:10:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAEk32TPgTkm3Fr9r7OQqKD0Uj7XfYIs5BBBNrY6Sh0GoFIikgFUtDx40o06mcO9BjAJUywlU1XscprFKiUUWQthjtqCCUI79AQ6/pZjUuJIjU+xTddh41TT+FnvXAtNH5BjkIdfUXpH6/x9AdxhzLGUVZKUucRdFRnDeBDOdeKHZ07vA1sW0v9YHe0MyTDgUme9Rc4p+OSSGDmDDpUuNIgSrzyGi8WpLIeRv9FFblwZMq+kmJY70Q4E9EXOw7xLR0OHzxGtzuiwwbGg0J4mWJ6B6euY7XTfgAsAxDUtxnrvNlgGykpRShKTTDuF9LRHZxL4bOk7vq+2jP4VoTDREg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wT+2yxOZj7ufhadY5QYlsF2l412TVp3F/FNC3Wdoo6k=;
 b=L5blWRsl1cnd0QPdb3GGi0j0bscM2sr+NvkowhzG4w6215PXezFPa2FXpuoWNm1Ks44XE0tG56+ZFx++apOm4/hwHpgiKAIdVHGEoyrG0/csdFEboBOVkJzkQGdUGYxoMyE6Y55ijHrBKXjqqfgIofx6AacRSgnUyhCnemr/mMk2fwVYqMM7Oq4DSwYMwDEBsn7BxXwGq4w0mSQMEKH9lYlpZi7A6kz4IQg5CQo0ZMAOY7m1fyrrl+MrW8SuEqNwSVH12T43Znk/jdXjdIzb+aslo1ImVY7pTdLAGbSXq2lkI1Q3zbLQy0iXhemd+DxyXZFFUeMtUKJStKOZ5pMJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT+2yxOZj7ufhadY5QYlsF2l412TVp3F/FNC3Wdoo6k=;
 b=yGUwmfCi8nJeQmy1/FkX8f2nFZxy8t6e71KA4Ily9GPUuSlKc2eT4t71GjyiljtK4TbdeFoq/st7UerAO8/8oYYHrzGTyTz5d8yTIiJGn5Hw9CIhlOyPwX2H04vlREiyQg3HzvlrfW7YawdyQkq2nf5MAkcuMx+d0DTGv8uCuqj8+ZYSWEzUeGq0iLD3/A9J9Eo0JgSsuDSOc70RynXDKDjiXFSBovw2e8nfMr+p7BVTqV8xcpyEP+UHiLAxhjJrguLC9igLUUuocyvE7ZRds1VJsDGHozdq3pcOrXtwPuRbUjFEDbPiwRkoeFmEL3Xq4RL4y/kI8mZnGr9jJwjqew==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CH0PR11MB8234.namprd11.prod.outlook.com (2603:10b6:610:190::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sat, 17 Feb
 2024 00:10:46 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8%7]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 00:10:46 +0000
From: <Ajay.Kathat@microchip.com>
To: <kvalo@kernel.org>, <conor@kernel.org>
CC: <alexis.lothore@bootlin.com>, <davidm@egauge.net>,
	<linux-wireless@vger.kernel.org>, <claudiu.beznea@tuxon.dev>,
	<thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC] wifi: wilc1000: fix reset line assert/deassert
 polarity
Thread-Topic: [PATCH RFC] wifi: wilc1000: fix reset line assert/deassert
 polarity
Thread-Index: AQHaXpDVeUNEJsQx1Uu1SAoo0Dj95LEIegQAgAAEeACAAlVDgIACUiP6gAAOkgCAAAA+AIAAFH/ygABlLAA=
Date: Sat, 17 Feb 2024 00:10:46 +0000
Message-ID: <296bfe15-7e4e-4d67-b84f-bd9d9f1266e5@microchip.com>
References: <20240213-wilc_1000_reset_line-v1-1-e01da2b23fed@bootlin.com>
 <2ff1c701f3443e1c612a81f4077b0280850f57c6.camel@egauge.net>
 <081bce96-f485-414c-8051-e1c14271f8cc@bootlin.com>
 <aac398e4-d870-4ba2-8877-b98afecb8d1b@microchip.com>
 <877cj4o0sv.fsf@kernel.org> <20240216-reckless-freedom-4768ce41e939@spud>
 <20240216-spinster-decade-e136ac3e72d0@spud> <87h6i8cmf5.fsf@kernel.org>
In-Reply-To: <87h6i8cmf5.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|CH0PR11MB8234:EE_
x-ms-office365-filtering-correlation-id: 1158729a-2982-4438-adb0-08dc2f4ce387
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S24JpI7GE9YD5tZprTiEOt5UI71ce1KvNjgfgb1YA9xP4kzq0zSty7YL1pbSUaLrWmW/sZap1N4Qnt+bZOX7JUaqn3uw4M/FgiiZOR3iR6Vdxb0Pur9Pq1bC1C0qLwe8nn1tYdN1fzfTxrARw5MsVRZb4xK2Y/lpo9QW4ncBkxaBrS7Tdoo0Wikn38UpAGUY4QjBm+aVh1uvN/LnXlZcE2ts/FevDBsaY5MUQWn9Pgn9TY+ENVhc+eOBFUL99lkBPJlPUY3A4ps7gStIaM4E2TmodExyd09msek1HZMwVFIwaaxXTYvH97aMmHxtgLnqmmSFVSqGNtJLLr4EH2Zv6gqeaMtZBcnsIyj7XoRdcqyIHvNc943GZphHpg0kzsRCwjFx1qWndKE5EwJgfzdsVEjhsQWeIPVSqd1ATnbeaQedWHn5fZzg9aFUTxx9GcZSZrxenLFOrmKCBcd6l1q2oFCWrEtFMkWczNcXy/nhBzHBgZZPq2/iTwuGpgOofvfdii+HDnDX8yQUHQPEjcpWUO3M6E6Njysm0OYWEGntzlFs37oBP2b8sKOlxRSyeTjEBsVQNqFsl9P85yz8qsmOlahPcaInM/CcZk8V9Bs9oVHh3WLnFcQJCNvRbF34x4v4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(71200400001)(31686004)(86362001)(66446008)(76116006)(66476007)(2906002)(8676002)(8936002)(64756008)(66946007)(66556008)(4326008)(38100700002)(5660300002)(54906003)(53546011)(316002)(31696002)(6506007)(36756003)(122000001)(6486002)(478600001)(38070700009)(41300700001)(6512007)(110136005)(26005)(2616005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1RYTTNwU2F6T1FrS05uSXVySTlOeDBjQUpiV1RtOEJGTGY0SzJnTW5IOUdT?=
 =?utf-8?B?SWtNWWdtU05pNkRJY3JyWEhLNTZSWnVGREJacHhQeFZPbmdUM3Q3NGxOTGR5?=
 =?utf-8?B?SllRRnZ1MFpLbnlTMHFadE04QkxuQmM2Nk9FYVpmZ2kxTlJ1Mm54UFU3ZWxX?=
 =?utf-8?B?Tm1ETzcvZ3dnRUxFdGJNMGsrMlNGTE5IdWR0Ry9CSWNpcVdOZ2Z3emYxNmRU?=
 =?utf-8?B?aFlDZDBLb1JTUjJwbzAwb1BKTzNxRzBVR0NzWDFEVm1PWkt3R1lNMlA4eWVq?=
 =?utf-8?B?TG41QWwzQ0xuLzc3ZHhENnFua3dJOEF0TUs1S0ZXRmswblhIWmxGaFJCQkEw?=
 =?utf-8?B?cHE2eDRCaXVmTTUwbitLMTc3Ym1aUmI0ZnhaaVVTMWlib0JFMGNCVE9iTTEr?=
 =?utf-8?B?b0ZFc0NWZ1ducXY5YStyQ2FUb09ZQTNPUUdXWDJOUytLTUVXOGxvTUlJa2Vo?=
 =?utf-8?B?OUIyaHhlNjV0bWhvZFVTYnJUb0EzV1QzT0lYWG1HeFpDK3c5S3ovdkZCZnhH?=
 =?utf-8?B?aFloY0pnQkgvSGpoY0xTc1haNElrYnNNRkNFaVp1OTc3NWtmTUlHN0ZSM2U4?=
 =?utf-8?B?Sm1YOElMRU5kVU1xRjZHZ3ZvQ2plZG1qT0Z1dEREVytld3JkUkZzTk00UXFQ?=
 =?utf-8?B?RTZXVnNFYVhoZEllOExEcTkxbzczOS9EOGVUeDZUcXEwSW1KeUZtVnV2UU1D?=
 =?utf-8?B?eEdHd25lOU4vZFg1YjRiK2hJYXRqY2I4TytSb3NQdTZnRHBvL2ZjRG96S1Fz?=
 =?utf-8?B?VHhoTXJycEZKV2dNd01Cb2dCbG8wMWN4ZzdBVWliRmcxS2tLMGR2NDlCUjhy?=
 =?utf-8?B?VHZRcDg2QU9EUEltYnh0ZC9hdmh4MkdiSUJ5enlKb3o3VTNLaUhVQW94L241?=
 =?utf-8?B?OUY3QmJpUHBKOTlhU1JjVlJWa2NHZGZKb2lMUWROeDZzdGk3NVcvZFBONk1z?=
 =?utf-8?B?bStNVkJHbFcxbTFNc2tNbnZRaUJISlBNazFGNTdhL2JCdStRL2RqempqaElh?=
 =?utf-8?B?TDVpTFZ6djFLU3dhdjNyRzJRZ2dtVi9UV29aNlNNalJKNVlyaDNFM2pHWEdh?=
 =?utf-8?B?ZXA4WWhPenBUbjRVQ3Q4MU9nNkdQSDB5WTZZSWJacWZYQUM1bUh0bldlQm91?=
 =?utf-8?B?d0VtUGJzcENVR2lDOWxrNWgvc2JQc2pjSHo0SklGSmV0aGlUbEVMMDVLc0VW?=
 =?utf-8?B?bEFvSDUrTXZBOWc4YzN0M0Q0ektLL3J0emY2NWQ3cXNVMTZSK2Y5V3FQUytk?=
 =?utf-8?B?ZGlacG0zbjRQNGZQQkJFblJQbCtHeERvZmRSYWIwM1ZUdWlSN0xEYm9QRjcx?=
 =?utf-8?B?THl5L2huaHd2TzB2N0pyMHpjRHZOSW8wbjJlVVBETkpVZjdDVHlrOWdOcVNt?=
 =?utf-8?B?R1F3SGMrRVM3SWJ3R0dlUm0vb0NvbUVlTGtxYVVUZWJWaVoyRkN4c0JOcDB1?=
 =?utf-8?B?ZTVKK1l5QlNiNzZuMFAydDI4L0w5Ylh3T3R4WVArMllYMXBIaTRDUlZOalBI?=
 =?utf-8?B?UkF4aXhvYUJSU3VuNjlERFk1SENuMzd6SmRCa2lIYzZjdVNaYnZPMkpnQ3o1?=
 =?utf-8?B?c0hnYzdnNFd4TGd0YnFBT29oUEt2S1FWeG9wdkJqNi96UkZncTNjRktVWTM1?=
 =?utf-8?B?NUd1QzFPL1BZaVNkeEJTMkpEMjNRUHBqSmhhM3hQZk1EMUZ4emI4cmh5d3d3?=
 =?utf-8?B?QU5uRHovTHlMMnY0c3o1Y3BKcERzSDBiM2ZseW5IZitMajczTmkvZklOQ296?=
 =?utf-8?B?c1pLd0RYbm1PWWFmWEY4Z0phL0RUUWFCVEUzdkFzaWozemtBbHRUUnkxL1Q0?=
 =?utf-8?B?ak9PZ2t0U0dKeGRSN2EwTGVpcW1VUkV3eXJQbG9jSGJQZ3VZUkQ2M2gvemMv?=
 =?utf-8?B?SGwwbHc3SnJpRW9zZjNSTGc3ZFJrTnlCdlU0REpyU2pUeFk5ZG15S2hRQi9U?=
 =?utf-8?B?L0JYb3FtNXBaejBkd3BjQVBnRGQwWGZGL1NjZm5Zb2REZzFGclRicEF4dkZ4?=
 =?utf-8?B?bVNwaGFKY2taOVRDSDFGeG5rbC9EM25kU1I0czZwdmJTT0pEaDhVU1lrV0Rp?=
 =?utf-8?B?c0VCYUU4MURqLzFrWkJlUXVRRzN4TzVpNTJ3ZlhiMjI5WWk2UG1CZkJKZEJF?=
 =?utf-8?Q?23hbn7F+54Tew4xfT1Qn4zEJB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C49540F361BE04DB9E00D6332289AFF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1158729a-2982-4438-adb0-08dc2f4ce387
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2024 00:10:46.0634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhSz0cMtGfwMbkPc1WH6s/137tW2ckNNGcN7bm0s//MaVEED8R+RFOBOW4PyFLtcJ2F5oLQ7ofICuIOIlI7WFTTmoA1hsaBIDvWoZiLZcok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8234

T24gMi8xNi8yNCAxMTowNywgS2FsbGUgVmFsbyB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5lbC5vcmc+IHdy
aXRlczoNCj4gDQo+Pj4+IFNvIGlmIEknbSB1bmRlcnN0YW5kaW5nIHRoZSBzaXR1YXRpb24gY29y
cmVjdGx5IE1pY3JvY2hpcCdzIHBvcnRpbmcNCj4+Pj4gZ3VpZGVbMV0gZG9lc24ndCBtYXRjaCB3
aXRoIGtlcm5lbC5vcmcgZG9jdW1lbnRhdGlvblsyXT8gSSdtIG5vdCB0aGUNCj4+Pj4gZXhwZXJ0
IGhlcmUgYnV0IGZyb20gbXkgcG9pbnQgb2YgdmlldyB0aGUgaXNzdWUgaXMgY2xlYXI6IHRoZSBj
b2RlIG5lZWRzDQo+Pj4+IHRvIGZvbGxvdyBrZXJuZWwub3JnIGRvY3VtZW50YXRpb25bMl0sIG5v
dCBleHRlcm5hbCBkb2N1bWVudGF0aW9uLg0KPj4+DQo+Pj4gTXkgcG9pbnQgb2YgdmlldyB3b3Vs
ZCBkZWZpbml0ZWx5IGJlIHRoYXQgZHJpdmVycyBpbiB0aGUgbWFpbmxpbmUga2VybmVsDQo+Pj4g
YWJzb2x1dGVseSBzaG91bGQgcmVzcGVjdCB0aGUgQUJJIGRlZmluZWQgaW4gdGhlIGR0LWJpbmRp
bmcuIFdoYXQgYSB2ZW5kb3INCj4+PiBkZWNpZGVzIHRvIGRvIGluIHRoZWlyIG93biB0cmVlIEkg
c3VwcG9zZSBpcyB0aGVpciBwcm9ibGVtLCBidXQgSSB3b3VsZA0KPj4+IGFkdm9jYXRlIHRoYXQg
dmVuZG9yIGtlcm5lbHMgd291bGQgYWxzbyByZXNwZWN0IHRoZSBBQkkgZnJvbSBtYWlubGluZS4N
Cj4+Pg0KPj4+IExvb2tpbmcgYSBiaXQgbW9yZSBjbG9zZWx5IGF0IHRoZSBwb3J0aW5nIGd1aWRl
LCBpdCBjb250YWlucyBvdGhlcg0KPj4+IHByb3BlcnRpZXMgdGhhdCBhcmUgbm90IHByZXNlbnQg
aW4gdGhlIGR0LWJpbmRpbmcgLSB1bmRvY3VtZW50ZWQNCj4+PiBjb21wYXRpYmxlcyBhbmQgYSBk
aWZmZXJlbnQgZW5hYmxlIGdwaW8gcHJvcGVydHkgZm9yIGV4YW1wbGUuDQo+Pj4gSSBndWVzcyBp
dCAoYW5kIHRoZSB2ZW5kb3IgdmVyc2lvbiBvZiB0aGUgZHJpdmVyKSBuZXZlciBnb3QgdXBkYXRl
ZCB3aGVuDQo+Pj4gd2lsYzEwMDAgc3VwcG9ydGVkIGxhbmRlZCBpbiBtYWlubGluZT8NCj4+Pg0K
Pj4+PiBJJ2xsIGFkZCBkZXZpY2V0cmVlIGxpc3Qgc28gaG9wZWZ1bGx5IHBlb3BsZSB0aGVyZSBj
YW4gY29tbWVudCBhbHNvLA0KPj4+PiBmdWxsIHBhdGNoIGF2YWlsYWJsZSBpbiBbM10uDQo+Pj4+
DQo+Pj4+IEFsZXhpcywgaWYgdGhlcmUgYXJlIG5vIG1vcmUgY29tbWVudHMgSSdtIGluIGZhdm9y
IHN1Ym1pdHRpbmcgdGhlIHJldmVydA0KPj4+PiB5b3UgbWVudGlvbmVkLg0KPj4+DQo+Pj4gRnJv
bSBhIGR0LWJpbmRpbmdzIHBvaW50IG9mIHZpZXcsIHRoZSBhZm9yZW1lbnRpb25lZCByZXZlcnQg
c2VlbXMNCj4+PiBjb3JyZWN0IGFuZCB3b3VsZCBiZQ0KPj4+IEFja2VkLWJ5OiBDb25vciBEb29s
ZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IE1heWJlIGFuIFItYiBpcyBt
b3JlIHN1aXRhYmxlIGhlcmUsIHRvbyB1c2VkIHRvIGFja2luZyB0cml2aWFsIHBhdGNoZXMNCj4+
IHRoYXQgYXJlIGR0IHJlbGF0ZWQuLg0KPiANCj4gT24gdGhlIGNvbnRyYXJ5LCBJIHRoaW5rIEFj
a2VkLWJ5IGlzIHRoZSByaWdodCB0aGluZyBoZXJlIGFuZCBtYWtlcyBpdA0KPiBlYXNpZXIgZm9y
IEFsZXhpcyBhbmQgbWUuIFRoYW5rcyENCg0KQWNrZWQtYnk6IEFqYXkgU2luZ2ggPGFqYXkua2F0
aGF0QG1pY3JvY2hpcC5jb20+DQoNCkFncmVlLCB3ZSBjYW4gZ28gYWhlYWQgd2l0aCB0aGlzIHBh
dGNoIHRvIG1ha2UgdGhlIGNvZGUgaW5saW5lIHdpdGgNCmtlcm5lbC5vcmcgZG9jdW1lbnRhdGlv
bi4gSSBkb24ndCB0aGluayBhbnkgY2hhbmdlIGlzIHJlcXVpcmVkIGluDQpkdC1iaW5kaW5nIGRl
ZmluaXRpb24gYWZ0ZXIgdGhpcyBwYXRjaC4gSG93ZXZlciBleHRlcm5hbCBkb2N1bWVudGF0aW9u
DQp1cGRhdGUgaXMgbmVlZGVkIGFzIENvbm9yIGhhcyBhbHNvIHBvaW50ZWQgb3V0LCAgSSB3aWxs
IGJlIHRha2luZyBjYXJlDQpvZiBpdC4NCg0KUmVnYXJkcywNCkFqYXkNCg==

