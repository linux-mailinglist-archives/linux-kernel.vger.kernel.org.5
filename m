Return-Path: <linux-kernel+bounces-43923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE157841AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F6A1F27163
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C918D37719;
	Tue, 30 Jan 2024 04:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tKXEV2kp";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2k8nZQhb"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9385B374EE;
	Tue, 30 Jan 2024 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706587451; cv=fail; b=pLh9VzgR+DUsqB2vlW5DIHh7bQEaZFbvJ2RaEr/QwKiMie8bp5lEWnyr5kniCsUsMRXTyCaem/QVx4IGOVFUWTYz5ueiJ/OPtGEWPCMFnhoB+oRSGdq9/HT0JK2wnYoKUYQGg9qLhD7bFySxHNIHciXK1N6LjZtQlBLgrL8j8PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706587451; c=relaxed/simple;
	bh=V880FAtmvgNy5CYuS508ati9KyrVV5HEn6j/geDowDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T7fwYcmAJK+gt9AjHhDeXV9YQ4Qm71CmaQ8qGwZVC7CbOow/rlO7WcPMeY63CHR46RMjdMXOEF1+iZIX0nW/UM5Xn0ayqAY02xtae9eo1kCvIpYQWusIVR3+1cTzLgdkGt5n4M7FKWANZP7Is+6MtNurAJyvoe2pUVHAxA3bXlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tKXEV2kp; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2k8nZQhb; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706587449; x=1738123449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V880FAtmvgNy5CYuS508ati9KyrVV5HEn6j/geDowDw=;
  b=tKXEV2kpncnkpVsDZtHIJyJh79v5TRzU8lrNXbdEWA3MucYEba9pGZmO
   ad+/IWetwkNbbAXuaPkW++M73VVddJ4RzQ8R7b1yjEnWtwIuJFbZKLDqC
   UQu1OOSWLPCY8JQVlZwmncQqYCJ13+J8dMEQHIFVb+ygvOOgI1lnYri4X
   +XdxnJeMbOxuesiHkIhH7THYEzhuW6MOvISnjEM+jzP2Ma219auDfJQNJ
   ey5gq+g/jKKetJ8fxRzXx6OViMK3YIVgtGoDFitT0IYtGs1rPGEPUm7Mx
   CgPfm2D8zQEQvMG9bZ/4OK4AdI8oef52qDndUHLffzzJaTfcnxWlcBrvk
   w==;
X-CSE-ConnectionGUID: 9low22QMQTmx+2YtM3y18Q==
X-CSE-MsgGUID: 6iSCTbA9RfK3/7GvR4OJrA==
X-IronPort-AV: E=Sophos;i="6.05,707,1701154800"; 
   d="scan'208";a="15478389"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2024 21:04:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 21:03:36 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 21:03:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBVPtBRjBawAEtn1BbZaIerMQFcvGSNFlGjboKVmamqayB9Yx/pUl6t7eW5XbhShLZD8C19zmIK+f2q7QV5/hZKHNDQZjePPm39cUxwuHkBRqkEbEnwquMsEM2WAMe+kN93HTiPvrGZO0dKw2//UudLppFvUMPhZgLNNn+UW6obi9r9hohEzsqeRERqbV0tLrk3IZGfEuIWiyvSqlIuHExl7eGYcLvPdY9+8VL2pOqISTBfERUSMgE4T7UnEj9SGv7i63hR5OjkAWU73vaxosgciVz6IKjKovVvDZ+UoiPZXqSskCY86al5vCoxY/Jz/l9a+5IoOndgYHEMX4JCV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V880FAtmvgNy5CYuS508ati9KyrVV5HEn6j/geDowDw=;
 b=k6q/FuY9jjOWJiUSShQlGeoeil+epoZj6mvDDd11wgLs8Vnw0lShZoKEBRe/zpOVT+hOGbu+dyH4l8vEp1U9a6UgC9sTHEN3svWnEIYPmh5QCVYhSCanpswLs0xRBb4vuK0QDn9PlfzPYruzzldPxSC6O78ByrZgB9Jx3YG3wKRD5LQCXY64ZvOz67WZrQ/xFPSr9BXGAL5gzppHnJhME+YC6QlKoYn2N51V1ZCkqPxZhLgmZS15ZsdKCzLIMsqznxxEjipeUHe9WCwYWdmXeJRN3bSjJZGvbqouogXx6ZFi8kj4+WLQILQUNEPfPm4oiPi3ayzxrL1QMarDNp8F1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V880FAtmvgNy5CYuS508ati9KyrVV5HEn6j/geDowDw=;
 b=2k8nZQhbMtMy9fSnvqs14PDM5BtFh87QQ+70t1nnhM5XrbE0tH2ubXOqPUWHS7Lpg0iXf6y2LDbDQvTwi3ci33q9E6CbogbxyCyTDI6JIzjJB8/Ht+ou8ipA1/wzGTJRM6BfMwFNovkxzqNL2yy/C/7SIaEAhP2Urvm8qhVZUk3Z/2JS1ZdSUfhS5/KGR+DH7sMoI9qUj7E658IF5Ff7sd6K+MWo5J5he3WadNKQQrQ87Ig6yU7Dzxkc3+Pcy7+B2Dpo1BFQtbJ0tb2LuO3NUEh/G+cBV4fkDkar9yqu1jEHlKKesezKgZrk9xz7Ln3HF+YFSIVNLZVtJBY9mWxgJQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by PH8PR11MB6659.namprd11.prod.outlook.com (2603:10b6:510:1c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Tue, 30 Jan
 2024 04:03:33 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::18cb:134a:e51a:2ce4]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::18cb:134a:e51a:2ce4%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 04:03:33 +0000
From: <Arun.Ramadoss@microchip.com>
To: <dev@pschenker.ch>, <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <olteanv@gmail.com>,
	<krzysztof.kozlowski+dt@linaro.org>, <Woojung.Huh@microchip.com>,
	<davem@davemloft.net>, <philippe.schenker@impulsing.ch>,
	<linux-kernel@vger.kernel.org>, <edumazet@google.com>, <conor+dt@kernel.org>,
	<marex@denx.de>, <devicetree@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <stefan.portmann@impulsing.ch>,
	<kuba@kernel.org>, <robh+dt@kernel.org>, <pabeni@redhat.com>,
	<f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: Add KSZ8567 switch support
Thread-Topic: [PATCH net-next v2 2/2] net: dsa: Add KSZ8567 switch support
Thread-Index: AQHaT2VsOIA/ZpTWWUSbcFa7xMGyRLDxxAkA
Date: Tue, 30 Jan 2024 04:03:32 +0000
Message-ID: <8b6575afdba8c3207752ebfa1cddc490f7bee5a4.camel@microchip.com>
References: <20240125080504.62061-1-dev@pschenker.ch>
	 <20240125080504.62061-2-dev@pschenker.ch>
In-Reply-To: <20240125080504.62061-2-dev@pschenker.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|PH8PR11MB6659:EE_
x-ms-office365-filtering-correlation-id: 172ab114-efab-4776-04c7-08dc21486d02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1v4T5IS0jiOEb7y014UgHCronI6JyY3tZAfscZp8p22trwVVgJ7xxwXU6xZ4t2kwl07kN7grAYb6O4FE1v5qkYbpqlBSI+pDRuevNfWPQB68zqYYIGYgBmc6+uoD23VoWdMt4pPow8Uigqc5OIw9QKr6V2XveLN5MJdOMHiAViPEorsJjdtrrMIex199WwQ5wy6u/zzwhVQOEzqfvuHGRvQYUADmfWXrgusrpqHUN1B474kq2Z/R10EFtxi93tVorx1x71mwgP4Ilt5u/+722B76rPaudKyHTVfOsdYqNY1yovI+PR8UpcK6OnDPWdg+bDSu1dMn+pYK9r9FSOWDidS7TWN8tPF+oE5erV+dcKCs8yApRZgs+FYCF8SubBSL70PTqnZ6kGFmwzMqhqpTA+lLPFqegEMiB8rV2iJ5k/xYSITwHaabo4GnqR6FlAZo74VhZyRsczYl8trrOW4Lxj6TrwYUMnRmrNeNn39hG8Bm83Hn9zm2v+3KLmWK540QsMGfr1YYoiYczzfxMfvrLe2D4zVc/cddSKR0WGQSp2v2KsAMT30DbFKX+J917IZQzXDizxwSUSt7EBz3ygvnxkqEPjPdUYEqzwCIDvnn/tqj4No+FKkaNdyLOSUlepxy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(6506007)(66946007)(478600001)(122000001)(38100700002)(316002)(8936002)(4744005)(8676002)(5660300002)(4326008)(41300700001)(2616005)(71200400001)(6486002)(7416002)(2906002)(64756008)(91956017)(66476007)(76116006)(54906003)(110136005)(66556008)(66446008)(38070700009)(36756003)(86362001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkNTQUFiT1JhSXpNUmkwQzB6ekJiUUhsVW85YjU3NTI3UjAwZmhCM0xkWEc1?=
 =?utf-8?B?MEZHQjRUL3p3b2o5aC9SdldZRzZHcm1rdEp2bkFpeUhabzR2TUhidHpiUWty?=
 =?utf-8?B?dVo2UUtydCtMWEw3MlM5SGp3dk5Dby9zMDJCY0Z0L1pHenFYUHNiUUNFTHp5?=
 =?utf-8?B?OS9pV1lYSVlHMTErZGVyOFBiZkVRTElqaU0vc0lXMVVsK0Zib1JGbTZRVVRX?=
 =?utf-8?B?TmZsWmEzMG9BZzRKaTJ0WGNJa3I0cVhrYml0WW9DTXNXNUxxRlFuNE5VQXlz?=
 =?utf-8?B?dEFJZ2x3RVRXZnNYT2M3N0dDVlFLbEUvN29Tc1JkTzVRbWxiS2dRRE9TRVlt?=
 =?utf-8?B?a3lGM2hCcVFZdWFGTUxXdHU2VXZxTVRtR1pPWXViZmptWi90SjNhalRNZjhI?=
 =?utf-8?B?bVY2Wkk5SHVpUUdxekFVZzhQYjdKdjl6R242MFdSQXNVV29pd0Qra1diQjY2?=
 =?utf-8?B?azE0azJyTjBrUnl1Nm9ieFdISGNDN0xyNkNGWXpWMjN1WDYrVVhSajllS3V6?=
 =?utf-8?B?VkhmWWp3aGVKRGVnWEllNEJ1aWJSU1Y0aVFFNU5YMkx1cnR6Y1VUNFNoTEhI?=
 =?utf-8?B?dm0reENLdVNib0xNazI5YWg4SW83TjN1TXpRMUc3WWRiUFdSbEkvMUlsRWdw?=
 =?utf-8?B?TWRKTUV3cTJLdHFsWnIrSTRqbU5OeVd3S3lTWXVBR0tleE5tbGxsRUVraFRs?=
 =?utf-8?B?dXU0bXpPQU1ic0ZyTnAzV3RqRzdobTBvaFBLWUZMOVh1ZG5YN2FGNGJrcWc1?=
 =?utf-8?B?WDZhUzBqRytnRVFQa1I3a1lYQ3hFT1hQTVhKd1VQT1g3ZHBSZGI1UHJFYkJa?=
 =?utf-8?B?ejBCUERaKzZ6UzRwUHhBUnhPdzJTWVY1VWdOcGVLUUxpdkQ4bGEzZ3N3Vytp?=
 =?utf-8?B?bWxrVHc0d3plWDRrYlM1cnhScUVtcjdPdHhqbmVYc0FqTEdROERQd3VkdlZC?=
 =?utf-8?B?ZVBBRDVqNmpsQVJTZ2lSeWEyRHRWb2kzWDJqa2x6SjRqV28veFN5dVNyWmIv?=
 =?utf-8?B?bHNXV2l5ZGZZRXducWQ5YmRlTnZpS1Z1TkR6eW5POG94R1JKRGxlODFLeGJE?=
 =?utf-8?B?WnhKWTZHVkFXSzBuMVZyWjVDV016dlZEYllvZktnSnFDaEt0a3o2Q1lUNytz?=
 =?utf-8?B?ZHVnL0g5OFcwR3RZditOSEcrcUVwVXIzNmtxWjNXSEpia2RQNERhc0ZOVzE4?=
 =?utf-8?B?VUVVUFpOMXp1L1NSZVI2Z3R5Z2dFMm5ZRWVuYStXQjJrbjdiYnZZejIrZExu?=
 =?utf-8?B?RmhvUjFkc21JVFBMWEtsaE5UUis5MS9lTVlXUkgyRmxJMGt6UTR5TmN3KzIy?=
 =?utf-8?B?S0tuL3cvZmhPMXdoZG0rNDAzR0tPRUtBK0QvcjBHamhiTFJScWNVTDBpODkw?=
 =?utf-8?B?MnV6OXV0RUp6clNtQzBKMGM2V0NNQmFjQ1I2aTlWalZuc2M2ZEYrRzRDSFVN?=
 =?utf-8?B?TzF2NGtyOW1IU1B4dVN0dkIrc1ZDclh6RDVERXYrcDAwTTd3eXBhd1JmSUds?=
 =?utf-8?B?MEhCdUE5YmVGLyszeHh2ellKOXVwUll0a2xyZzBOTG5hcUhlYUk1VFVZU1B2?=
 =?utf-8?B?cjh4alpEK1B2SVBQVmVBSkQvd2l0aERzYmpnMVNhaFh3dnB2V3ZNOFhlb2Fh?=
 =?utf-8?B?eWdNbXFHcFZFME5UU1dNcmpseUJEazh2dndaOGpidmtrZGpNbXFqWUJFOEZG?=
 =?utf-8?B?VXc0MnVyUkU4NSs0KyswcUxnRGhJVTA0Wkhodk9mSWRSZFZoTVYwNHpNKzhI?=
 =?utf-8?B?SHJUemRXekdma0k5R0NaUmgxV2JBNDdoUnU5a2NrTGZscy9lV2VvdGpHRDZi?=
 =?utf-8?B?cUhjSE5RMkY0WEZVdU1kWENUMFNWZUZLR0FvU0RyNEwxcTBrWTRYWHFNS05i?=
 =?utf-8?B?Rkh5TllUeTJ6ZDJpL2U0UHJvLy9SaXdTZEFBeDRHMW5hU29qWlJSajAxRXdk?=
 =?utf-8?B?YUtWQ0hwN2U3eG9CbWJHeTE1YlVQZ3pHVEdjOTJjdzVTaWsrRUV6SU9lR2tE?=
 =?utf-8?B?YVYzSWt4L2M4TkFYRGx0OUV5ZFIxb1lZaGFvNjJRMm1NZUxGaE5za2hpKzJX?=
 =?utf-8?B?YUxYaFRHeVdRVW5VQWxTZldKbGZSeFQ5K015d2dmQUIwSVpnSzlTRnpyWXFr?=
 =?utf-8?B?WnIrL3B1eG5tUisyU1dLOG1uRUEwTUV4UTB1emxkR2gzVmkwaHZBSXFIWTM1?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B17CD8475E2AD64FAA8F9D3416347C54@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172ab114-efab-4776-04c7-08dc21486d02
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 04:03:32.9412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhEPESp2YvRWTOwqPUQdx7MavIKQwhk04Uccl96nFXxvLbIPs1mnRDWb1G9/oNVG9xXtZJme/JIKBX8WAAy12MTYqkgL5IcjZOXOQTiag4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6659

SGkgUGhpbGlwcGUsDQoNCk9uIFRodSwgMjAyNC0wMS0yNSBhdCAwOTowNSArMDEwMCwgUGhpbGlw
cGUgU2NoZW5rZXIgd3JvdGU6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wbGF0
Zm9ybV9kYXRhL21pY3JvY2hpcC1rc3ouaA0KPiBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0
YS9taWNyb2NoaXAta3N6LmgNCj4gaW5kZXggZjE3NzQxNjYzNWEyLi5jNDQ2NmU1NmQ5ZDcgMTAw
NjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9taWNyb2NoaXAta3N6LmgN
Cj4gKysrIGIvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL21pY3JvY2hpcC1rc3ouaA0KPiBA
QCAtMjQsNiArMjQsNyBAQA0KPiANCj4gIGVudW0ga3N6X2NoaXBfaWQgew0KPiAgICAgICAgIEtT
Wjg1NjNfQ0hJUF9JRCA9IDB4ODU2MywNCj4gKyAgICAgICBLU1o4NTY3X0NISVBfSUQgPSAweDAw
ODU2NzAwLA0KPiAgICAgICAgIEtTWjg3OTVfQ0hJUF9JRCA9IDB4ODc5NSwNCj4gICAgICAgICBL
U1o4Nzk0X0NISVBfSUQgPSAweDg3OTQsDQo+ICAgICAgICAgS1NaODc2NV9DSElQX0lEID0gMHg4
NzY1LA0KDQpuaXRwaWNrOiBjYW4geW91IG1vdmUgS1NaODU2NyBhZGphY2VudCB0byBLU1o5NTY3
LiBTaW5jZSBmaXJzdCBLU1o4eA0KY2hpcHMgaGF2ZSBjaGlwaWQgb2YgMTYgYml0cyBsZW5ndGgu
IE90aGVycyBoYXZlIDMyIGJpdHMgbGVuZ3RoLg0KDQpvdGhlcndpc2UgaXQgbG9va3MgZ29vZCB0
byBtZS4gDQoNCkFja2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxhcnVuLnJhbWFkb3NzQG1pY3JvY2hp
cC5jb20+IA0KPiAtLQ0KPiAyLjM0LjENCj4gDQo=

