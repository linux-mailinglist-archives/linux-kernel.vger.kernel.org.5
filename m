Return-Path: <linux-kernel+bounces-164016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CEF8B7727
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D61AB20B00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B314176FB7;
	Tue, 30 Apr 2024 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SPvjC6mG";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="p3MQnhP7"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A22175570;
	Tue, 30 Apr 2024 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483865; cv=fail; b=rWExsVc89Ph/5Q6DNmKDnwMu9lZuFFlhgeWOBLCsOkzuEXDDNG83+4inhMcMfweJsRh1DPUoocFh9V5R8CzTD7Tg26r/uEN0doQEJAzly4zqI0EijBU/JkB2G0zaaYXjmhKd9JRDhfjQojzl7eAARIoYM/+XiDJa03MmuJh8bPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483865; c=relaxed/simple;
	bh=w2JmWEtmAXr3iGK37GMc06j8RYXKz1YkkmrzCb+LqWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VOhBhNyQ1gQpFa59qBrSurwSZCMbSQV+SUzhkiDr1gcFBLGtwRTQ9WrAYQ+Aw3JoouHOo2Ry4+LtqP0iwtdCt0vFgTb7rlbtSVKrgVSV7xzYrdKo8pKEeTAERxhWss5ZdVQg+z7AEhbwAfBJDjBDkIGJoJkRLeHFLvYnzK9kigE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SPvjC6mG; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=p3MQnhP7; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714483863; x=1746019863;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w2JmWEtmAXr3iGK37GMc06j8RYXKz1YkkmrzCb+LqWo=;
  b=SPvjC6mGvMaZeNW9zfAiXtAWnDH9Nk6gmY7GEN4KPaADZGcmdo4/33uT
   JYD7knxm4W5/FtSsP8qRH4spkb3hU9PloEMeszoIsYJEh8QstedUnO0xg
   6GyJNZzvuF5x3RbzsiqUHyWcwlN0dgSHpFzy7wrHRJE6x2/VpAWuihN2U
   5yaU3/cpkJwjkVUbUGB5xHiYuPN507hEUh7KfZTGjIycirpVhyrwW5elY
   yxiJ6rXk7Ry+CAvYf1xKt1moMxrwP8k30lE4Ng+COROgURkZVGNQgGMSJ
   WtoeATgkJpDNnLc9RsoiIkEB8RtqinGcXppQgHaPizs4w5DI7U2+SYNHZ
   w==;
X-CSE-ConnectionGUID: Y52SPLXIS8WQv0N81nXAkQ==
X-CSE-MsgGUID: rGfZuIpMSAO52EPoZkWl+w==
X-IronPort-AV: E=Sophos;i="6.07,242,1708412400"; 
   d="scan'208";a="23274355"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Apr 2024 06:31:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 06:30:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 06:30:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmeCE3vbPJ57viLSQKMlKtdNAz+4sh6RZd8oriUlCquOqWsUukwddPh1olMmwYmuRdiWNU/JO1RZvCQdLeijxb+wEK9fYw+OpNUPx1APsgsjfd87aIvoREf5yeLkwgj9vGNUsqfNQOzYnQlv2U2/+j/Su/zbJRYMLYKjtux9EFvIDkCXpMRkrIUaRQsp79/QRfib9WKbtWjT0Ok9sA9kf5ZOFwojagUw/nlr26Mn9sym0ETlw6rtLl6lvLQAeJ2hwfwzOvuOD/YCnv5+ckFcNwxCqn9fW5iszqeVXLjHHVf/zZwb66THgk2ThbrmwN5m9+Q9ltD9OuqZHNwBOPCYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2JmWEtmAXr3iGK37GMc06j8RYXKz1YkkmrzCb+LqWo=;
 b=XZplNouS+ZXmNFBUjmecWQXRNImCvyBrPXuv0fIu8ZZbVexPRFqZLx4ziLKUjoN7DS3WCO7zbTH9GzBdpyqgh8Mh5fYDvsx4xMZ1CGXCedWSkmkiY5Odmd6HWEaEZoiPCkParGCwfNWVuabd3HkBTwg5P+YS6bnq0OY5ogTWaDVALFDgqwuVq4vgF9uN6HZkaDnRwfsjIfsGbsjgpn1bMAjqiQLDQAfapFTgImyuj930jkLR5vO0KG5MxBM+5l748tF8mg3gzr+2EjodFKRhM0yeErhcMJ4E7Y1aRrTGDZlwPAFERqHiKjfI3u7uumfb4+Gqe5JCovrNBeha86U+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2JmWEtmAXr3iGK37GMc06j8RYXKz1YkkmrzCb+LqWo=;
 b=p3MQnhP74WvhWeetEs1i6O35Pa//IZ8G3Ht+BON79gBzLUwQW5NC/guvcp/Ve7ALolv3QItIKqTAjIYuKHeXpLjSZa9DisoXmkxgK4oe8e6ZE5Q9g75xoZLecz9UWZZvnnlIizO1O5HjVFQhWFdx0cKTZD+p/G7gIwUhztQeteE8rHMY5EzqjWbiAc97NHgsu+roqCVOIXRAy4CgTlPQiSrTfdHkHfJWlubLQomF1st8+sUevmEqGo2fMyyPp4acEShOQEfBNqD1WAFPf1cIFO4wrNUc5k9UPZ9MB61WYtZBi25/RmtiTwzcmGGMLH3LtvefTDkOdBfeqsJqqn2oPQ==
Received: from SJ0PR11MB8294.namprd11.prod.outlook.com (2603:10b6:a03:478::10)
 by LV3PR11MB8742.namprd11.prod.outlook.com (2603:10b6:408:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 13:30:47 +0000
Received: from SJ0PR11MB8294.namprd11.prod.outlook.com
 ([fe80::f85b:116f:aab1:9b27]) by SJ0PR11MB8294.namprd11.prod.outlook.com
 ([fe80::f85b:116f:aab1:9b27%3]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 13:30:44 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>, <ramon.nordin.rodriguez@ferroamp.se>
Subject: Re: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
Thread-Topic: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
Thread-Index: AQHambFe+IoUXQDhSE2fgqcXND6Bv7F+xDiAgABLB4CAABxbAIABpiQA
Date: Tue, 30 Apr 2024 13:30:44 +0000
Message-ID: <a3719443-153b-49d5-b039-fa0a7928de28@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <Zi68sDje4wfgftyZ@builder>
 <dd9da345-e056-4f34-8e39-6901bf9c1636@microchip.com>
 <Zi94jdVg8a5MaB3E@builder> <eaa4eb3e-d82a-4b52-a375-1fc84be7225a@lunn.ch>
In-Reply-To: <eaa4eb3e-d82a-4b52-a375-1fc84be7225a@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB8294:EE_|LV3PR11MB8742:EE_
x-ms-office365-filtering-correlation-id: e9200ad2-9b2f-40fa-a9d1-08dc6919bcce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?V2xabG5wdjZDTlRsM1pGMFo1Zzk5dG1FY24wSUpaZzVJdGZEalFYenphbHNq?=
 =?utf-8?B?c0hQcTFad0t3M1NPUitpaU1lUFVtdVl2MzFhSmFkeEJ5NGw2QS9YQkpyWldQ?=
 =?utf-8?B?eTVobEswUkhCYURpZGQvQ1dpTlNHeTE3UG84MWJ4TnRBNjhtTmVRbzA5cW94?=
 =?utf-8?B?ME1KTm1xUjlMakRNcEU5b3EwZXdUb2UyblVKeG1zWThMOUhTOW1OM0ZLQXc0?=
 =?utf-8?B?c0R0TFZyS1Y1VFlCaUpvak9uUWNIa0tHZlQzbnpyaFk2cXNkVWowTDE1QjhD?=
 =?utf-8?B?cldPS094UDdWdm9tU2NkSmlITmk2REZjVHNuSnVGdTdjVVFRWVptdDBiRkd3?=
 =?utf-8?B?c2JzQUZka3BYYTRWYjBPaHlqUTJQb212WWJPVGZiVlFHZm9zSGNlTEZoRlJK?=
 =?utf-8?B?Y2dHSHBTVUU3dWdPZ25tSjVyL3ZxWXJuZ0VDL05tZlZPc3d6MTFvRS9TZ2pk?=
 =?utf-8?B?K0s3YXFvdmY3QmJIOUtKMDg4UGhIbmkrcVJ4Z09NSkl4azJGQWk2TVNCY25Z?=
 =?utf-8?B?VXEvMWhJczRPTG92dStxcWt0Z0RLTzczYjFHS01XaWttaW5qMjZMY0FvZTU0?=
 =?utf-8?B?QUp4TkpDekdIVTFid0VWcldnVWRJajBYRTcrajNsSGRWNnBCTGVlb293SWZt?=
 =?utf-8?B?dnhSL3JCM1NROExtZ2M2VHFpV0ROQytCWk1ibmpXTW1oK2xvVVZWQTRwZUZU?=
 =?utf-8?B?SHJaa0ZTQmVDMm5vZC9zVXlPSFg5eEgzZVF5SmZuYk1RUmZSZ0tmbzNiVlRw?=
 =?utf-8?B?TnMzdVZwYzJGS3FWaFlvQTUzY0tldmxudTNPL1pIVGlHdXZ1b2dFRjB2cUI4?=
 =?utf-8?B?bVR4VjByZVZjL0hDNXpkTlpvMlFEdUZVZUthdTE4SlhXbFI1SGhlZ2Fnc0Fi?=
 =?utf-8?B?VkNYRkxrVkhtUjA0YVk4NHVRS0FJcWpRY0RaTm13eG9PTUowN0hwTHdjTm93?=
 =?utf-8?B?cU1PK1oreGRlT2FLVGwycURVektaa04yVkVTT0Z1dGVvNHlsNk1iZVNkRG5G?=
 =?utf-8?B?cERqK2wxbnUxeDZ5UEhBOTZoTzhjeENvUUlRc3QxdFJlWHM1TkNsZEY0bjBV?=
 =?utf-8?B?Y3ArSUtjK3h0d0plbnVVVWlEeFlBajFYQjM2QmFqa0tHYVFxMUdNZVZxZ0xG?=
 =?utf-8?B?S09XNzlKazFwWGJuYnFKTmJSZ3ZNOVR0VzBJVmJNQ2lPVUJzODFpUmZSeTlT?=
 =?utf-8?B?REpXcTYzVXZwaVZqdXFGZzdLVVExK1dYUVFCekRmdDdNUG5QSnVBRHVrQThW?=
 =?utf-8?B?M1VodnJ6ZFdQRFB5Z0xLcThHVVRoMmFxLzdYR3IzLzJBNFBuTzJGNkpmMm9r?=
 =?utf-8?B?bVFlTXp4dElnT2VibGhjamltUTBUYkNEMDk2OThNVjJHWFFxYmtDWGF0WS9l?=
 =?utf-8?B?TEJiZHlCT09pMnNqQ0RFRFhpanJ3S0lvZHhzWUZzK2ZoT094S25CMEJhZHhR?=
 =?utf-8?B?L1MrWW9BWndEQUpqSW53clBFMlZLM2crRjBmYmZVdHFWUlNQYkJ6bEpQR1Zo?=
 =?utf-8?B?MXdHZUs4YkdEanJINFArZ0t5YnJ3TmFHUWNqTUxtVFJ6Z2Jhd0FVekJVRy84?=
 =?utf-8?B?MUNoWDk1SjkrNGxLaE5FTGNFWWM2c01tWjhDbENadi9jbWtpY25jNTVST21L?=
 =?utf-8?B?bmdyQ2F1MlJ5Q2psclQ4elZOeEFrdnlJcWVRQk1ZSG04QnhuSHllencra1FY?=
 =?utf-8?B?Tm41Uzl6dVQ5YVFIQnI0OUpQUHNGTFlKRzNmZFJtZWVqSTczWEd6TzNMSXFp?=
 =?utf-8?B?di84bnhUQ0hyclBiMlBKdGtTeitTcDZxbGVEZmtqM1VQMDE0T0RKLzltZGJJ?=
 =?utf-8?B?eHArMzhaTEs1dnBJSjVMQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB8294.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEJONkJsWm5RYmZ6a1Z0VmtBa2hMTEl6aDErR25xdStPRFFlVUtOTWcvY21j?=
 =?utf-8?B?dlAwMHFDUE84RVFPN3MzandSTHJjbXdaK2FjOXZ3TlVVOE5HcW9qWmtZd21E?=
 =?utf-8?B?Um93b3hPUVBnSlBwcGxhcFVOcW95R3BxVmh2a0I1VFhjeERmeTRYZEMxNG5N?=
 =?utf-8?B?WnQrMHBWaURFOVhLSUg4QUVJU3lWa2JrcFBQaUttN2JISjRVS0Z5QW1vUnBD?=
 =?utf-8?B?UWxxVTRGY3NQN1ZqYjh3K3IzY2FPQnNWOVVtbkp5ZWt2N2VmT0ZaUGVFUTlo?=
 =?utf-8?B?TXZmTlQ2TThqM1JRZWE5VTBJeGFJempVeWE0QTZuWHRWNHNvTEVrenpBd0ta?=
 =?utf-8?B?Z1hQY0ptRjNveHNwa0IwSy9TRkJvMzhYYkdZYUc5UEN4QzBmSldqNVVUWklz?=
 =?utf-8?B?WUU4dGVPZ2g0Yy8yK2JCRXlBekhucElzUTVOWnZQSVpRNzZjUUNld1grUnc4?=
 =?utf-8?B?TlNBcEFRdEZvZHZydS9VRnVZL3FmVXFEU2lHZHBDTzVyMURyeFFMTFlCUVc3?=
 =?utf-8?B?Nk9SNU9SK2Q4QisvWFVmSmd5eGIyQWJPbFRQNjlsQUtCR0hqdnEySVlhNDI0?=
 =?utf-8?B?dlUrK1JkNUw5d3NZdStiSFFtakRjODQyb0twNE1OZXlhdHcyRSsyNVRZUUZS?=
 =?utf-8?B?TlkvZnA0NUxBenQ1bjhxRGY0RlhkbWRqMHlmUVU3QnJ5dzM2blFCNlVzV0dq?=
 =?utf-8?B?Z1JoMWpjT09FblJGOFBxbkMrVWptRmxZcXpHdUpUdVQ5Y1F6bFBBQnRJdjJJ?=
 =?utf-8?B?YTNOaFErWUpIa1dKQWVsYVZQb1lxUGdDVmdKVGcwZi91bnRtSzJBeUxaWk9C?=
 =?utf-8?B?cVhlSE9Za3o2cVo3eXVlQmt4VjN6LzY5cXFsQjZKUEZ6THNyakVRUHFVR2RP?=
 =?utf-8?B?dmVLL0JkV3hCTDZDYXFPYnZjUzJyU3VZY2FML2RaeEs3b2ZMNjNGRStLV0Fs?=
 =?utf-8?B?K0NLS05oa3Vsa2t2SzJFTVgwOHZKaWVrdnJaMWkyeXdZSjh4d3dhd1JUQUhT?=
 =?utf-8?B?NWNUR3RVR3JUdlFzT0ZIRjlGbnBJMXZETnUrZkdOMXpKWTlZYTJqVUc5alJI?=
 =?utf-8?B?K2hqRlhXYll5cTUxL2dVWS9KWlRINkNpUXlZUTdjZ2VNMGVBRjVKK25uUjJ5?=
 =?utf-8?B?b3RIbkZPZlJnbmdpWlpYVEVxK082UUVSRU1BeFExRk5xSk15RUhmcUxNS1VW?=
 =?utf-8?B?c25FRVdNOERMcHhER0g1SmJ3bmNLWmVPdGR2ZFd4OTJ5UUpXekU2SWhDWHlL?=
 =?utf-8?B?aFdQNTNKMlAwUmZjTndlb0RoL1lNdVZqeisvMXl5N0orcjg4SlNINWp4MUNQ?=
 =?utf-8?B?M0NxNXB4UXFmY29ZYnBOOEFEVlQwRnpKK1Y2SXdvcFFZU0NFcjVSUElUNlJB?=
 =?utf-8?B?NlVsVFI4Sm5VcEtZTWl5M0VXYURLemJLcGpXMGJ6eUt2Vy9FTTJmYWEwV3VD?=
 =?utf-8?B?RHlKOVhWZ05yRHV0Vk5saHFYYmtuUW5yZXNZalBGM2pBQnBNMTBYaDFtS2R0?=
 =?utf-8?B?alZnalJVOHp6d3dFd1pVb09yaVRyRTkzcGRLN3RyUElGMXNBNFdDbzM5a0E3?=
 =?utf-8?B?LzRNR21Ja2lqT3IwMmZBbWJrY1dzRmFWK1A1WmhmZzI1K3lIUEtnQWZkUzFL?=
 =?utf-8?B?dGQ2ekUya1VEZThTVXVKZmtheFJIVWFaS3JBVURzb3AxU2Z5cnlZamgxa0F2?=
 =?utf-8?B?aEZ3Z0ZHNGdHRnJySzlTVUR2MEtQUW9MRzhzdXVLVE1Ya0FMRWNyWXpZNTNl?=
 =?utf-8?B?eVBON25NNUQ0YVVmMnF6NVRxbFJ4M09vaEU2SU9IYjdOUlkvTGxIWDIrREtn?=
 =?utf-8?B?ZkdRWTZKOWdDb1BWU0E4dWlZSXdDSmpVc2hBNnJuL2FhMkprYjZWYmhWejFX?=
 =?utf-8?B?R0hOQUIwcnMrQTREbnVsaXZ1SXBWQVY4cDg5aFpqdVJVVzF4N3NjV0puSE13?=
 =?utf-8?B?dTR1WUFZQzBoN201cG5Eb1owRzd3MkQ2OVRPZUZsc0xhR2RNMkN1dk90TU04?=
 =?utf-8?B?SFR6VWlQRkViRGJYOVdpU2VOY3l2cUhRb2RjbXZEMkxqdEtRRFlHeHl0T0gw?=
 =?utf-8?B?bE1HbFoxY1Qyb3VFQ0hOcHQ5OUVwbVF3UExKMEhlNDNoZVNUclV5MUJ5eFpG?=
 =?utf-8?B?STU1cXNSWWx6UC9Ib2hTRHFUdG81WmRkNUZKaGNRS1JtcXdqbkxxMmpwZFpL?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDCD442846C50A41A2702BE3F1F703A9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB8294.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9200ad2-9b2f-40fa-a9d1-08dc6919bcce
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 13:30:44.2165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5v7Nt7TW0XXJMULl1NmDabz+e7KeAl1IZ7pcqOr5lSn8h/FxCaOg9/hUDAVzXds6KtQTUQxljBZJS/e9KOtL8lIAhhzlsCUDPJcZvEgOUfbtkWVaQb6Jcf6pLZBhEDD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8742

T24gMjkvMDQvMjQgNTo0OSBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+IEFkZGl0aW9uYWxseSBJIGZpZ3VyZWQgb3V0IHdo
eSBteSBzZXR1cCBkaWQgbm90IHdvcmsgd2l0aG91dCB0aGUgSFcNCj4+IHJlc2V0LCBJIGhhZCBt
aXNzZWQgYSBwdWxsIHJlc2lzdG9yIGluIHRoZSBzY2hlbWF0aWMgdGhhdCBoZWxkIHRoZSBJQyBp
bg0KPj4gcmVzZXQuDQo+IA0KPiBIYXZpbmcgYSByZXNldCBjb250cm9sbGVkIGJ5IHNvZnR3YXJl
IGlzIGEgcHJldHR5IGNvbW1vbg0KPiBkZXNpZ24uIFNvbWV0aGluZyBuZWVkcyB0byBlbnN1cmUg
dGhlIGRldmljZSBpcyBvdXQgb2YgcmVzZXQuIEl0IGNvdWxkDQo+IGJlIHRoZSBib290bG9hZGVy
LCBidXQgaSBkb24ndCBwYXJ0aWN1bGFybHkgbGlrZSB0aGF0LCBoaWRpbmcgYXdheQ0KPiBjcml0
aWNhbCB0aGluZ3Mgd2hlcmUgdGhleSBhcmUgaGFyZCB0byBzZWUuIFNvIGkgdGhpbmsgaGF2aW5n
IGl0IGluDQo+IHRoZSBMaW51eCBkcml2ZXIgaXMgYmV0dGVyLg0KPiANCj4gVGhlcmUgaXMgYW4g
b3BlbiBxdWVzdGlvbiBvZiBkb2VzIHRoZSBkcml2ZXIgbmVlZCB0byBhY3R1YWxseSByZXNldA0K
PiB0aGUgZGV2aWNlLCBvciBpcyBpdCBzdWZmaWNpZW50IHRvIGVuc3VyZSBpdCBpcyBvdXQgb2Yg
cmVzZXQ/IFRoZQ0KPiB3b3JkaW5nIG9mIHRoZSBzdGFuZGFyZCBzdWdnZXN0cyBhIGhhcmR3YXJl
IHJlc2V0IGN5Y2xlIGlzIHByb2JhYmx5DQo+IG5vdCByZXF1aXJlZCwgYnV0IHdoeSBkaWQgTWlj
cm9jaGlwIHByb3ZpZGUgYSByZXNldCBwaW4/DQpUaGVyZSBhcmUgdGhyZWUgcmVzZXRzIG1lbnRp
b25lZCwNCg0KMS4gUG93ZXIgT04gcmVzZXQgLSBBIFBvd2VyLU9uIFJlc2V0IG9jY3VycyB3aGVu
IHBvd2VyIGlzIGluaXRpYWxseSANCmFwcGxpZWQgdG8gdGhlIGRldmljZS4gT25jZSB0aGUgcmVz
ZXQgY29tcGxldGVzLCB0aGUgSVJRX04gcGluIHdpbGwgYmUgDQphc3NlcnRlZCBhbmQgdGhlIFJF
U0VUQyAoUmVzZXQgQ29tcGxldGVkKSBiaXQgb2YgdGhlIE9BX1NUQVRVUzAgUmVnaXN0ZXIgDQp3
aWxsIGJlIHNldCB0byAxLCBhcyBzcGVjaWZpZWQgYnkgdGhlIE9wZW4gQWxsaWFuY2UuIFRoaXMg
aW5kaWNhdGVzIHRvIA0KdGhlIGRyaXZlciB0aGF0IHRoZSBkZXZpY2UgaGFzIGJlZW4gcmVzZXQg
YW5kIHJlYWR5IHRvIGNvbmZpZ3VyZS4gRm9yIGEgDQpwcmUgY29uZmlndXJlZCBzeXN0ZW0gdGhp
cyBpcyBlbm91Z2ggdG8gc3RhcnQgdGhlIGNvbmZpZ3VyYXRpb24uDQoNCjIuIFNvZnR3YXJlIHJl
c2V0IC0gVGhpcyByZXNldCBjYW4gYmUgZG9uZSBmcm9tIHNvZnR3YXJlLiBJbiB0aGUgZHJpdmVy
LCANCml0IGlzIGRvbmUgYXMgcGFydCBvZiBpbml0aWFsaXphdGlvbi4gQWN0dWFsbHkgaXQgbWF5
IG5vdCBiZSBuZWVkZWQgaWYgDQp3ZSBhcmUgbm90IGdvaW5nIHRvIHJlbG9hZCB0aGUgZHJpdmVy
LCBhcyB0aGUgUG93ZXIgT04gcmVzZXQgZG9lcyB0aGUgDQpzYW1lIGpvYiBmb3IgdXMuIEJ1dCBp
ZiB3ZSBjb21waWxlZCB0aGUgZHJpdmVyIGFzIGEgbG9hZGFibGUgbW9kdWxlIGFuZCANCm91dCBv
ZiB0cmVlIHRoZW4gaXQgaXMgbmVlZGVkIGZvciBlYWNoIHRpbWUgd2hlbiB3ZSByZWxvYWQgdGhl
IGRyaXZlciANCndpdGhvdXQgcG93ZXIgcmVzZXQuDQoNCjMuIEV4dCBwaW4gcmVzZXQgLSBBIGhh
cmR3YXJlIHJlc2V0IHdpbGwgb2NjdXIgd2hlbiB0aGUgUkVTRVRfTiBwaW4gaXMgDQphc3NlcnRl
ZC4gT25jZSB0aGUgUkVTRVRfTiBpbnB1dCBpcyBkZWFzc2VydGVkLCB0aGUgTEFOODY1MC8xIHdp
bGwgDQpyZXN0YXJ0IG9wZXJhdGlvbi4gVGhlIGRldmljZSB3aWxsIGluZGljYXRlIHRvIHRoZSBz
dGF0aW9uJ3MgY29udHJvbGxlcg0KdGhhdCBpdCBoYXMgYmVlbiByZXNldCBhbmQgbXVzdCBiZSBj
b25maWd1cmVkIGluIHRoZSBzYW1lIHdheSBhcyBpZiBhIA0KUG93ZXItT24gUmVzZXQgaGFkIG9j
Y3VycmVkOiB0aGUgSVJRX04gcGluIHdpbGwgYmUgYXNzZXJ0ZWQgYW5kIHRoZSANClJFU0VUQyAo
UmVzZXQgQ29tcGxldGVkKSBiaXQgb2YgdGhlIE9BX1NUQVRVUyBSZWdpc3RlciB3aWxsIGJlIHNl
dCB0byAxLg0KDQpUaGlzIGlzIGFsc28gYmFzaWNhbGx5IGRvZXMgdGhlIHNhbWUgam9iIGJ1dCBp
dCBtYXkgYmUgdXNlZnVsIHdoZW4gdGhlIA0KY2hpcCBnZXRzIGludG8gYSBzaXR1YXRpb24gd2hl
cmUgaXQgY2FuJ3QgcGVyZm9ybSBTUEkgYW55bW9yZSB0byBkbyBhIA0Kc29mdHdhcmUgcmVzZXQu
IFRoaXMgbWF5IGJlIG5lZWRlZCBpbiB0aGUgaW5pdGlhbCBwaGFzZSB0ZXN0aW5nLiBCdXQgDQpv
bmNlIHRoZSBkZXZlbG9wbWVudCBpcyBjb21wbGV0ZWQgYW5kIHRoZSBjaGlwIGlzIHJlYWR5IHRv
IHVzZSB0aGVuIA0KdGhlcmUgd2lsbCBub3QgYmUgYW55IHBvc3NpYmlsaXR5IHRvIGdldCBpbnRv
IHRoZSBhYm92ZSBzaXR1YXRpb24gdW5sZXNzIA0KdGhlcmUgaXMgYSBwZXJtYW5lbnQgaGFyZHdh
cmUgZmFpbHVyZSB3aGVyZSB0aGlzIHJlc2V0IGFsc28gd2lsbCBub3QgDQptYWtlIGFueSBzZW5z
ZS4NCg0KT1BFTiBBbGxpYW5jZSBzcGVjIHNheXMgdGhlIGZvbGxvd2luZyBpbiB0aGUgc2VjdGlv
biA4LjIgVmFyaWFibGVzDQoNCnJlc2V0DQoJVGhpcyB2YXJpYWJsZSByZWZsZWN0cyB0aGUgbG9n
aWNhbC1PUiBvZiBhbGwgcmVzZXQgc291cmNlcyBvZiB0aGUgDQpNQUMtUEhZIGFuZCBpcyBUUlVF
IHdoZW4gYW55IG9mIHRoZSByZXNldCBzb3VyY2VzIGFyZSBhc3NlcnRlZC4gUmVzZXQgDQpzb3Vy
Y2VzIGluY2x1ZGUgcG93ZXItb24gcmVzZXQgKFBPUiksIHNvZnR3YXJlIHJlc2V0IChzZWUgU2Vj
dGlvbiANCjkuMi40LjIpLCBhbmQgYW4gZXh0ZXJuYWwgUkVTRVQgcGluIChpZiBpbXBsZW1lbnRl
ZCkuDQoNCkluIHRoZSBzcGVjLCBleHRlcm5hbCBSRVNFVCBwaW4gaXMgbWVudGlvbmVkIGFzICJp
ZiBpbXBsZW1lbnRlZCIsIGluIG15IA0KdW5kZXJzdGFuZGluZyBpdCBpcyBNQUMtUEhZIHZlbmRv
cnMgY2hvaWNlIG9mIGltcGxlbWVudGluZyBpdCB3aGVyZSANCk1pY3JvY2hpcCBpcyBpbXBsZW1l
bnRlZCBpdC4gVXNpbmcgdGhpcyByZXNldCwgY2FuIGJlIGEgYXBwbGljYXRpb24gDQpyZXF1aXJl
bWVudC9kZWNpc2lvbi4gSXQgY2FuIGJlIGNvbnRyb2xsZWQgZnJvbSBhbiBleHRlcm5hbCBhcHBs
aWNhdGlvbiANCndoZXJlIGl0IGlzIG5vdCBuZWVkZWQgU1BJIHRvIG9wZXJhdGUuDQoNCkJlc3Qg
cmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAgICAgICBBbmRyZXcNCg0K

