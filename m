Return-Path: <linux-kernel+bounces-137069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DF689DBEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C794CB216A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118CC12FF70;
	Tue,  9 Apr 2024 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1b0iCZJn";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mbGlXune"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CE275809;
	Tue,  9 Apr 2024 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672064; cv=fail; b=qYeUOmDTB+tNh1ILzamqoKwhVGj1RzFA73LW78Mv2a4vhwgCxV6OIilGno6QFDy+guVk06KB6FLcTUjuNz3AyPf1ihrHSGQprriOwzJecJ92MaE3TOX6yuN7y11Q+LahERCk6KWhnDcjPAjXt/iK2sHXKlN51KbQj0Nn+aC5UyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672064; c=relaxed/simple;
	bh=p9Y6i4U78okTRPf1Jv7B5oEVDviAGwVVQ+2Xu2g+Ix8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=keCldc1ZuM0o18gwOw0mGxDVSFAKgPZguCz1Pelz70HDPZ2ROjCRb4E+gwDjs3vMp7C08usQUwilaRj6CCB2jn07XsTUm2Eax7t4Q58WNWtXnaWYsp1sZd5lj9TceHPYwfwIu5KWBLPvdlGiJDaYuBqHendjAC/wcwTZd8Ciz0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1b0iCZJn; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mbGlXune; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712672063; x=1744208063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p9Y6i4U78okTRPf1Jv7B5oEVDviAGwVVQ+2Xu2g+Ix8=;
  b=1b0iCZJnEpELGQEiEXcRPV2gO6/toE6AOnSRZyGezTk/4A+EN3uLXBDZ
   HvQXPl9zNwVGuF2aRtxjpgXYsQFtE/g4WcPVv3+rqpJ/zkUsh0nN9F4zy
   BCGBjqsB9vNdGLfSELpY5RKazsppe6KizhiPkR+sPCpBgr0/OKvn+gl92
   Ne+V5HQ2kTnEdSUGoOnGF1W5zyaMeVxyQyymNRtYOcuZ2XUkT7OQo9ZOo
   jOfTD6v8GB3WRIPJIBYoLKPFqaCLgzbrJGeuSIczSiIcxe7jOq7ph3GsH
   QxpEHSHmk9jNWqe75wYF+1T2NOiX+FbA+TZHFaAuQA2QaA+/MScyeekZl
   g==;
X-CSE-ConnectionGUID: pgUlRW+VQ5+cwT08ApHVVQ==
X-CSE-MsgGUID: 16l4y6YWQTyYX0aq21Nf0Q==
X-IronPort-AV: E=Sophos;i="6.07,189,1708412400"; 
   d="scan'208";a="20732336"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Apr 2024 07:14:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 07:14:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 07:14:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESSYnBrKWyI1FYxaKvl0lartqjbkXAdCY/1W0DH/7UHbNCPpbBRYdC9bejxhwSfjWTTjbYf97iptSeDqsw8G+H9SrqIBS2fI1LVW2Qz+fTG2FYLShfWqXjXaVUg61Z3R6c2ISx75UIfaU2ypMje8wQUMYqXrmp8pZT1XF77S7OL52h495PxNZRyZYLlIpESR/2YjlMq8jIeQ9YHGixijQyxu0t1B82kw91MUK4muqHcBvlG2eEU4nWIAdzkti8ReeLqCN5HitQTN+FJq4I06nbuQfacXhCoKvKOkv2FkJjwrBFtn9bOiVV20HAryxEVtfucpsa4n0WKRK4zjBpg/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9Y6i4U78okTRPf1Jv7B5oEVDviAGwVVQ+2Xu2g+Ix8=;
 b=OwwX/n5eEngQZHJAqOieEkuVCsmNVJunNrGyukqvAjn3BZgj4IENmVkzjTEFQcAPDBvLNk52JkDuxIhX9Tg1KZNR3Z8EbUhtoxKk4XhWVetNl5JK2IDkHz+5YX7xa8+4KNitAoG/d0+pdoDsA9PwnQTViBd4vd+6nhJsCFODl/JKgKwfxAb+Fe6fPCom8rSNarkUBdCkT68zxhfP9F5P9V5CN4flquYscGqh8UjHSL8M2GOd8FLCEJ5A7XXMeXCRLMKgVgyiVUGEYd9YNtKGHTbPlMN0A8ajKuvf03ORJiDz/NuTucRCAaScUZAp7mtKfFVDcFcoyqqY7fR5yJIxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9Y6i4U78okTRPf1Jv7B5oEVDviAGwVVQ+2Xu2g+Ix8=;
 b=mbGlXune2Z93sMAiBJ9qAzWAb/HfKcJN8x+gqQlT722jNJh52FXUhDjeZiR0mHjQmQUy3YIvK/oBJxsOTnDiZhYLq8PTjTphoelGQnxgjlEtVKOIxIzhvXZAkYMB5ODlVXGL32zCwwkqe08xbQLIl8T9wZxzPy0KIozreAJuB7lf7qpU19X1kpgi5uUO2VvFEeGIiz6uunsM9ctFNPU1sUUMK7RxlR4bodVzexUkAy2MLhyMa72aUIiFFHCCWUWE00UHzIioCYz2Ias5rNm/JWIjShjiNi7S4xjziPUZ6FgBZ8luURYFeKOxjB/Bv85ChBpAJfRJ0GwB5rK0HDUDwg==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by MN6PR11MB8171.namprd11.prod.outlook.com (2603:10b6:208:471::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Tue, 9 Apr
 2024 14:14:04 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7430.045; Tue, 9 Apr 2024
 14:14:04 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <dsahern@kernel.org>, <san@skov.dk>,
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v5 4/9] net: dsa: microchip: add multi queue
 support for KSZ88X3 variants
Thread-Topic: [PATCH net-next v5 4/9] net: dsa: microchip: add multi queue
 support for KSZ88X3 variants
Thread-Index: AQHailaeULprcvidk0CkpQunbT4rkrFf/BmA
Date: Tue, 9 Apr 2024 14:14:04 +0000
Message-ID: <78e905b30c3c19ca74a651c0a541965abafda266.camel@microchip.com>
References: <20240409081851.3530641-1-o.rempel@pengutronix.de>
	 <20240409081851.3530641-5-o.rempel@pengutronix.de>
In-Reply-To: <20240409081851.3530641-5-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|MN6PR11MB8171:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c8NQK1trBNkW5K7BG+g4bYUDntLFI1SeXiLbw8IiZ5CY0pNDzr6nBE1TQKTVFzn7L3CvcbCrhadY27dRdilZZm51p4qVHKL3B2OdjYYZZgBoozOLczVazLfrAeOabvlau01HFNKai8jKO1CpTAO0lx1bdggVFvRJTSps0PnroxmuJq3y7xd9X3uXKP4UEgldyC0sNfZkQ6oZvvcXbZhtxIseRH7f9kTGo8QWf9y25mVXaG1c6cHKsCJj83kx89nfG3vi8OLse2TbpXcWI29Z4QHAB6svHalHrLcuS84XHmm5romvARq9gzYISOM05lGvwC+ybO3ogYlZxTGdBfjmvsjxlOAd//vtjIjPiK72l74bkV90fL/TMzEUYPltVcQzW7YzhLENURtwlviQiUHPjDXX+LW9B0kjFEjZQeCwtj2HdAUicc7y+RYz5J5/3i1H9/veKPfNUrSmX8V45TY6eafJxGhTk8k7PNja8MKsVSr11Z3NiIcvr7+3LvR2TqUa373Z/g3g2O+pvCY17e3hddTxb31OGudko7q/vbnfeBsXb/OoZtUM7uUNe4nL0+oc1DBTBnG2ILzVvQz2M23H/eXjQ8t/bZnZz1JQIMaS+afC1Ch7UW18TZbVmf57ootTmSGYKtbi6XIdCI1qUDOdb8bZ8j0mzJxvz6vvW7oOuQc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3czVFFYZGJSREdaakNHZnFDOXdFYS93QXZreFVUTHBzNm5SNFNKMFlMUHFW?=
 =?utf-8?B?NW9OMzFYTFd3RHZVQUxWdk9ZeWpNSmNZaG9ySEU3Z0lDYU1zV3NiYlhodkR6?=
 =?utf-8?B?bDdYUVB5ZzlQQmlwWDdqT2hSNmd6NG9DUjl1Zjc2bktCTnl1QUlkb0lid3kx?=
 =?utf-8?B?TjhPaEtCZU5mUmE1UmxiemZLODU4Y21uQjRXZGRZd1hwTjhqVGR5K3YzQlo5?=
 =?utf-8?B?aGl6by9jWThkTGUzeVN2U0VSNDZFaENIRXA4UTJLOThCVTNEc3FBenFOdHVm?=
 =?utf-8?B?ZGk4SjJaVlc2a0tkV21wQjdNbWNnVkNlcEpGUmFxdnFRaVpoSW9sWTZiVDEz?=
 =?utf-8?B?OUI3T3RXM0NxWGZ2WmxCNlRyZHplaFRUNlpUcVRxYnQ2enQ3eDB5OUd2bmt1?=
 =?utf-8?B?NHNhTHl0ZDVEdStvaVdBK3dDUEw4MS91cSsrM0hoZ3U0Yzdxblgzc2dMZEdV?=
 =?utf-8?B?NVhPdGp4eXVvM09HZVJPZ2VDS29RSldJYjlMQlBad21sbDVJUVo3bFFmdDIr?=
 =?utf-8?B?RnZFckhSb3ZGMWpjSzNCM3Y1QTBHR1p5TXdlbHpwYjREK0k4YnoyaXd6ZlRw?=
 =?utf-8?B?aXNGWFZoSjJSY0s2eVM1Njc5UU1VZUpzNjBzMmF6TmVXYW9LL0VleGpqTmZV?=
 =?utf-8?B?UnpZZjFvbDNsMlNpY1N2SUhydExUMFg4TUc3TmUreTd1dVVZZWlya01qVkV3?=
 =?utf-8?B?MWM2ak93Vm1QQlVJSjAxMkw2ZmxpQTRtd09uUzZWWHBZS0ZudW0xQTJEZUpt?=
 =?utf-8?B?S25KOCtHTGZQdWZRN3YycDNLV08wMzQzUVBZTnQ1Y0lmOVE4b1EyOVVsb0M1?=
 =?utf-8?B?NGptaTloZ3U4cHJlMmVDeVdQbVJiVld2MGNGaVFMcGdNQ1l2Yi84Uys3MVg4?=
 =?utf-8?B?by9EMWkyR28wRnJRbkNBOGxQcktPN0dyTGp0bXJkeldodThIS0hHb2dEWUZI?=
 =?utf-8?B?NmYwbHVTT1VjME9oQ1kwVy8vYXNHY0NBd1M3MkNJbDRQNSt0SWEwNnlYbS9i?=
 =?utf-8?B?cGJIUXVoR1lFd1BYRG9WRjdSSGRmWkdWVTlQczF1Q1M4K0IyUm1lNFRqN2lD?=
 =?utf-8?B?cTZHL0FxYm8ya29hb1RBaXVCazJqS3lycEJGblpaaVltN29BeTJOTmxvVU9m?=
 =?utf-8?B?b25TNWdBbnltZmxVT0FZUHBjNTd0c0UwdDVtbGJ1ejhxNWRtVXdFUktJaG1R?=
 =?utf-8?B?eDF5WThRYnV0R0RYeHlzdjlLSmxWU2d5RWdKRlM0UEF3SCtuU1o5Q1ZuL1NF?=
 =?utf-8?B?ZzgxcktWQmVxdXh6ZC9DWEtodVhlUm9rUDczWnlBL2pGeUZIM2ZTSmQvSDFq?=
 =?utf-8?B?Ty9TcktRc0hSbVZWblNWUjBBbEp1emE3VVJPYVA2SGRsOFNuT0FCWUNBUytn?=
 =?utf-8?B?UGVOcjdMOFZPbThTeEFLQ0s5elAxY0dLRkY4ZDgwd0UyTlpJNFJlaW1uS0N1?=
 =?utf-8?B?bkR4czllTkJ4dWpINWZyWHQ5ajMvTGNiZzh3ZTV2N1F5U0NmQlVySCtQZVp2?=
 =?utf-8?B?eG1BUDdiQmNxbG05NjR5R3ZuZHQ5YVZQL2FTeVA0Q3dEeHZONWN1R01iVHNU?=
 =?utf-8?B?eFNkdm5lM2o1N0lENzJ0Q0hYRkpvRTNMcU5SY0dzQUdEM2xCT295ZGl6ZU16?=
 =?utf-8?B?MERrVGNPZTBxM0Q5UCtISXJMUGg5bmlGU2ZDTmZYdyswVWF5ZktQd0txaDNy?=
 =?utf-8?B?MTBSYmxuS3d2TlpFOWREeGdRS1pLdVppSkNlVkdyekhmbUhrN2VkaW5sN2Fk?=
 =?utf-8?B?bVhVTS90U05DdUUvYzZ0MGNxTzVZVVFkNy9wZTRsSjRqZEp5VXF2bGtUYmVk?=
 =?utf-8?B?L2dWMzRqdEFSZkJoNUdOOWtjTDI3ak93SXlvRFVCU3cwd1NBS25CTDJLZEQ3?=
 =?utf-8?B?NG93VmsvVWpqUysrRXB4akF1OFFSNVh2YTY2MDRDVVhUM0FLM2RVT0xuc0Yr?=
 =?utf-8?B?dUZyVTJQcDl6dTVxWnluVytLZUFQNlJsNUtPcGxXdElETDNhMzUwMUVsNml1?=
 =?utf-8?B?U1RjbExKd3VraXNiUVJ6NDg2WW5FeUp6SUoxYTRRd3lkcW5VUWxTcU04VjUr?=
 =?utf-8?B?OWNvSC9MZENrTkx3WlNKUGZtU3FPRys4aC9lajI3QVJOZXRSV3Y3Q0dFNnRO?=
 =?utf-8?B?dVZZQXV4Q0FRVll4RnlFMTd1UkNmRHNHWkdicDlKd0lvZjlxaDhIbU9rSndJ?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A52EB6463DEDD04899C761BC6357CAC8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d8426f-e964-48d3-3344-08dc589f4fc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 14:14:04.0852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6/jaftusTwORbSYHTFhkn+tPofLn96rwj/jfIyDl009qMgMS0WKoaEUFqJ2Fgn1r798+iYdP1GspMUvoe71OVPPXFN4xKhpv6fijvc2pYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8171

SGkgT2xla3NpaiwNCg0KDQo+IA0KPiAtc3RhdGljIHZvaWQga3N6ODc5NV9zZXRfcHJpb19xdWV1
ZShzdHJ1Y3Qga3N6X2RldmljZSAqZGV2LCBpbnQgcG9ydCwNCj4gaW50IHF1ZXVlKQ0KPiArc3Rh
dGljIGludCBrc3o4X3BvcnRfcXVldWVfc3BsaXQoc3RydWN0IGtzel9kZXZpY2UgKmRldiwgaW50
IHBvcnQsDQo+IGludCBxdWV1ZXMpDQo+ICB7DQo+IC0gICAgICAgdTggaGksIGxvOw0KPiArICAg
ICAgIHU4IG1hc2tfNHEsIG1hc2tfMnE7DQo+ICsgICAgICAgdTggcmVnXzRxLCByZWdfMnE7DQo+
ICsgICAgICAgdTggZGF0YV80cSA9IDA7DQo+ICsgICAgICAgdTggZGF0YV8ycSA9IDA7DQo+ICsg
ICAgICAgaW50IHJldDsNCj4gDQo+IC0gICAgICAgLyogTnVtYmVyIG9mIHF1ZXVlcyBjYW4gb25s
eSBiZSAxLCAyLCBvciA0LiAqLw0KPiAtICAgICAgIHN3aXRjaCAocXVldWUpIHsNCj4gLSAgICAg
ICBjYXNlIDQ6DQo+IC0gICAgICAgY2FzZSAzOg0KPiAtICAgICAgICAgICAgICAgcXVldWUgPSBQ
T1JUX1FVRVVFX1NQTElUXzQ7DQo+IC0gICAgICAgICAgICAgICBicmVhazsNCj4gLSAgICAgICBj
YXNlIDI6DQo+IC0gICAgICAgICAgICAgICBxdWV1ZSA9IFBPUlRfUVVFVUVfU1BMSVRfMjsNCj4g
LSAgICAgICAgICAgICAgIGJyZWFrOw0KPiAtICAgICAgIGRlZmF1bHQ6DQo+IC0gICAgICAgICAg
ICAgICBxdWV1ZSA9IFBPUlRfUVVFVUVfU1BMSVRfMTsNCj4gKyAgICAgICBpZiAoa3N6X2lzX2tz
ejg4eDMoZGV2KSkgew0KPiArICAgICAgICAgICAgICAgbWFza180cSA9IEtTWjg4NzNfUE9SVF80
UVVFVUVfU1BMSVRfRU47DQo+ICsgICAgICAgICAgICAgICBtYXNrXzJxID0gS1NaODg3M19QT1JU
XzJRVUVVRV9TUExJVF9FTjsNCj4gKyAgICAgICAgICAgICAgIHJlZ180cSA9IFJFR19QT1JUX0NU
UkxfMDsNCj4gKyAgICAgICAgICAgICAgIHJlZ18ycSA9IFJFR19QT1JUX0NUUkxfMjsNCj4gKw0K
PiArICAgICAgICAgICAgICAgLyogS1NaODc5NSBmYW1pbHkgc3dpdGNoZXMgaGF2ZSBXZWlnaHRl
ZCBGYWlyDQo+IFF1ZXVlaW5nIChXRlEpDQo+ICsgICAgICAgICAgICAgICAgKiBlbmFibGVkIGJ5
IGRlZmF1bHQuIEVuYWJsZSBpdCBmb3IgS1NaODg3MyBmYW1pbHkNCj4gc3dpdGNoZXMNCj4gKyAg
ICAgICAgICAgICAgICAqIHRvby4gRGVmYXVsdCB2YWx1ZSBmb3IgS1NaODg3MyBmYW1pbHkgaXMg
c3RyaWN0DQo+IHByaW9yaXR5LA0KPiArICAgICAgICAgICAgICAgICogd2hpY2ggc2hvdWxkIGJl
IGVuYWJsZWQgYnkgdXNpbmcNCj4gVENfU0VUVVBfUURJU0NfRVRTLCBub3QNCj4gKyAgICAgICAg
ICAgICAgICAqIGJ5IGRlZmF1bHQuDQo+ICsgICAgICAgICAgICAgICAgKi8NCj4gKyAgICAgICAg
ICAgICAgIHJldCA9IGtzel9ybXc4KGRldiwgUkVHX1NXX0NUUkxfMywNCj4gV0VJR0hURURfRkFJ
Ul9RVUVVRV9FTkFCTEUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBXRUlHSFRF
RF9GQUlSX1FVRVVFX0VOQUJMRSk7DQo+ICsgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiArICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArICAgICAgIH0gZWxzZSB7DQo+ICsg
ICAgICAgICAgICAgICBtYXNrXzRxID0gS1NaODc5NV9QT1JUXzRRVUVVRV9TUExJVF9FTjsNCj4g
KyAgICAgICAgICAgICAgIG1hc2tfMnEgPSBLU1o4Nzk1X1BPUlRfMlFVRVVFX1NQTElUX0VOOw0K
PiArICAgICAgICAgICAgICAgcmVnXzRxID0gUkVHX1BPUlRfQ1RSTF8xMzsNCj4gKyAgICAgICAg
ICAgICAgIHJlZ18ycSA9IFJFR19QT1JUX0NUUkxfMDsNCj4gKw0KPiArICAgICAgICAgICAgICAg
LyogVE9ETzogdGhpcyBpcyBsZWdhY3kgZnJvbSBpbml0aWFsIEtTWjg3OTUgZHJpdmVyLA0KPiBz
aG91bGQgYmUNCj4gKyAgICAgICAgICAgICAgICAqIG1vdmVkIHRvIGFwcHJvcHJpYXRlIHBsYWNl
IGluIHRoZSBmdXR1cmUuDQo+ICsgICAgICAgICAgICAgICAgKi8NCj4gKyAgICAgICAgICAgICAg
IHJldCA9IGtzel9ybXc4KGRldiwgUkVHX1NXX0NUUkxfMTksDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBTV19PVVRfUkFURV9MSU1JVF9RVUVVRV9CQVNFRCwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFNXX09VVF9SQVRFX0xJTUlUX1FVRVVFX0JBU0VEKTsNCj4g
KyAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biByZXQ7DQo+ICAgICAgICAgfQ0KPiAtICAgICAgIGtzel9wcmVhZDgoZGV2LCBwb3J0LCBSRUdf
UE9SVF9DVFJMXzAsICZsbyk7DQo+IC0gICAgICAga3N6X3ByZWFkOChkZXYsIHBvcnQsIFBfRFJP
UF9UQUdfQ1RSTCwgJmhpKTsNCj4gLSAgICAgICBsbyAmPSB+UE9SVF9RVUVVRV9TUExJVF9MOw0K
PiAtICAgICAgIGlmIChxdWV1ZSAmIFBPUlRfUVVFVUVfU1BMSVRfMikNCj4gLSAgICAgICAgICAg
ICAgIGxvIHw9IFBPUlRfUVVFVUVfU1BMSVRfTDsNCj4gLSAgICAgICBoaSAmPSB+UE9SVF9RVUVV
RV9TUExJVF9IOw0KPiAtICAgICAgIGlmIChxdWV1ZSAmIFBPUlRfUVVFVUVfU1BMSVRfNCkNCj4g
LSAgICAgICAgICAgICAgIGhpIHw9IFBPUlRfUVVFVUVfU1BMSVRfSDsNCj4gLSAgICAgICBrc3pf
cHdyaXRlOChkZXYsIHBvcnQsIFJFR19QT1JUX0NUUkxfMCwgbG8pOw0KPiAtICAgICAgIGtzel9w
d3JpdGU4KGRldiwgcG9ydCwgUF9EUk9QX1RBR19DVFJMLCBoaSk7DQo+IC0NCj4gLSAgICAgICAv
KiBEZWZhdWx0IGlzIHBvcnQgYmFzZWQgZm9yIGVncmVzcyByYXRlIGxpbWl0LiAqLw0KPiAtICAg
ICAgIGlmIChxdWV1ZSAhPSBQT1JUX1FVRVVFX1NQTElUXzEpDQo+IC0gICAgICAgICAgICAgICBr
c3pfY2ZnKGRldiwgUkVHX1NXX0NUUkxfMTksDQo+IFNXX09VVF9SQVRFX0xJTUlUX1FVRVVFX0JB
U0VELA0KPiAtICAgICAgICAgICAgICAgICAgICAgICB0cnVlKTsNCj4gKw0KPiArICAgICAgIGlm
IChxdWV1ZXMgPT0gNCkNCj4gKyAgICAgICAgICAgICAgIGRhdGFfNHEgPSBtYXNrXzRxOw0KPiAr
ICAgICAgIGlmIChxdWV1ZXMgPT0gMikNCj4gKyAgICAgICAgICAgICAgIGRhdGFfMnEgPSBtYXNr
XzJxOw0KDQpuaXRwaWNrOiBpdCBzaG91bGQgYmUgZWxzZSBpZi4gDQoNCk90aGVyd2lzZToNCkFj
a2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxhcnVuLnJhbWFkb3NzQG1pY3JvY2hpcC5jb20+DQoNCj4g
Kw0KPiArICAgICAgIHJldCA9IGtzel9wcm13OChkZXYsIHBvcnQsIHJlZ180cSwgbWFza180cSwg
ZGF0YV80cSk7DQo+ICsgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBy
ZXQ7DQo+ICsNCj4gKyAgICAgICByZXR1cm4ga3N6X3BybXc4KGRldiwgcG9ydCwgcmVnXzJxLCBt
YXNrXzJxLCBkYXRhXzJxKTsNCj4gIH0NCj4gDQo+IA0K

