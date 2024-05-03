Return-Path: <linux-kernel+bounces-167657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E0C8BACDC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1382C2817B0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFBD1534E7;
	Fri,  3 May 2024 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bnYO8W3S";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JZX4INjO"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A21139CE0;
	Fri,  3 May 2024 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740887; cv=fail; b=IuC5Gw1tZPy2LhmDcod3PPwoVYNMxUvY1daC8cEiGHqwd8W+2iMqtPYlsOOdsnx7PpCxE+3TOTVQCfvKcY8iaVFiN8my/DEraINc9eqllTntliE4O2jcGr9VVzAggGC6NOsmy8bwhH/XSYZKxDMUYQY+E8JvmFKT0tf5pYUlWtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740887; c=relaxed/simple;
	bh=40RUPK77rucAvVhvzECrNpoEkn49tCbAzwCxLZIKLDo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SUqkTTs8X1+pJTPYmPpj74I/edvXC8YL2SQ/n2pHF4zVMzz8rNGyPANDnKE+D88NJTP5nSH3jz39Oeoimpfnv55ssVZrF9SkrBKnEx49vra7VpvB1Scl/OM8HcACTW+BQbzsqxK4/ai8RFR8syvG60gWUDZwiHKp2fXxiz4A3qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bnYO8W3S; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JZX4INjO; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714740885; x=1746276885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=40RUPK77rucAvVhvzECrNpoEkn49tCbAzwCxLZIKLDo=;
  b=bnYO8W3SqiIVP6kvXYwiW45HGCTi5YB2mbm0s+IcuCO6I1K71hUB4Qrv
   w4iev+eGA7ElaYQ46rMLdv+1u0QJDCARoRmJwuDwWuKckwN1WmHl56TfY
   3ozIHRQPxPwuN6qSinrzXl3ST8hpaFZuA2I7zN+HvqKl+4eVPPt+D1EnD
   HTrxJSYm82s16kGtm4HxebIIXL/9eapQ9XG9hwooVz/Y7wdytDlN4qx13
   r4l0W+hT917OF1OnguzrFOAEzo3aj0Pe83/YN8pqSp/b4n6qqR4CTHa4l
   tBOk6Pc1u//4kZj7EP64uxwmFyT2BeEIrdTK1PlA1xAKfAwwN+4mpIUZZ
   w==;
X-CSE-ConnectionGUID: 6OePRW2VSAmEcriAavjNkg==
X-CSE-MsgGUID: yPh822BRSru5EL2JoeKB3Q==
X-IronPort-AV: E=Sophos;i="6.07,251,1708412400"; 
   d="scan'208";a="24077381"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2024 05:54:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 05:54:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 05:54:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHs1McTQYIlP+PSe+iSN8aR2PTQJXdfk5IiGLbrnWDgGQaxIhpbZkPlLIILYgHb75GJpGARSsfZV/YWoVCCS/gzTYSpOJhOoMugF5m7CRjlnSPQxsXj//ghuCSA0ESYIeDaMhE49kWhnPe5rN0pSuzdHW1I9UHdVsYIDkCHDXra2zFYEJKI/oS+K34zRhkbDfwc/lfDgbcsSSRx6XFIIqeW+Rld7BlpkWOduG4gyDItkcj1TsYGja0Iu/+oi70LRD6yr5BJdmYvVOklFo+vPDQ/NgqcuTONZFRFbOM+nu9ZWNlIHKS3NID/kyGQuBoW22+iOaqXQwx9emlLsukq9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40RUPK77rucAvVhvzECrNpoEkn49tCbAzwCxLZIKLDo=;
 b=X4L5qeTXNmwyr+ep18eSH3e1/T2dCsY7AZOpkGsk/eW4goRFnNppmWaD/u3G8VrI6ESlnb1YRQ4El+Ly9M44shZOr1iIJ4o27aY9DetqZwTQv3YTTOIn2yP+wQSMmUKE7TrQZGQcf0a3uPrwsaqr9JRnSWZadbXkZUsBr37mRHFFt6s/ziLIXe2HTF5MtqDpUsyQWVxyfSeXJNSrZbot7oOVKwVZa78K/QBtS2/+OEbIw8/uPcw8vp0i0GlPDvclW8DhFQWafBZP4VFNCtukJOBsUNJNLZpYKawkDIW3hwgE0TqcimHuTOQ2cV/+tE9SdAjN2dz7dDzWdn4uBeyUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40RUPK77rucAvVhvzECrNpoEkn49tCbAzwCxLZIKLDo=;
 b=JZX4INjOJsaOSYAXL0m5CtP9+5C89VSL3LLxOdiRDQrNsYn2Pl5+h8e3VcMXac+aC/t/3qgBqLskgzDEo431beG0pQau7/zDJvASZvF9WTGz8bpDReL0JDjAmYgZi2oyIX/SJ1g3n3/OJ8zFHDxWafbcbawPGS+GYSwPZlpx71Qd6L3w/BMwu/iSahkSamYxLJdG/QE62aWsDxdG6eXy8+yezbOKy/cIylbUQwLRsZy8N3VBIbKW6HDzg9U4Gjnr8Gi5z/RYUDtcZ9vJWsXDAucZcE+iJAkEzveXnM44msrRwYHalqQ9chlM1t9bhxralRaPPDOLJO8aURvGXU1HRg==
Received: from CYYPR11MB8386.namprd11.prod.outlook.com (2603:10b6:930:bf::13)
 by CH3PR11MB8210.namprd11.prod.outlook.com (2603:10b6:610:163::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 12:54:20 +0000
Received: from CYYPR11MB8386.namprd11.prod.outlook.com
 ([fe80::22ac:bfa1:678f:f510]) by CYYPR11MB8386.namprd11.prod.outlook.com
 ([fe80::22ac:bfa1:678f:f510%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 12:54:19 +0000
From: <Prajna.Rajendrakumar@microchip.com>
To: <broonie@kernel.org>, <krzk@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<Conor.Dooley@microchip.com>, <devicetree@vger.kernel.org>,
	<robh@kernel.org>, <linux-kernel@vger.kernel.org>, <krzk+dt@kernel.org>,
	<Valentina.FernandezAlanis@microchip.com>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH 2/3] spi: dt-bindings: Add num-cs property for mpfs-spi
Thread-Topic: [PATCH 2/3] spi: dt-bindings: Add num-cs property for mpfs-spi
Thread-Index: AQHanJ37n9FOOFXPxkOxyyvGvn4yU7GEB80AgAFxNIA=
Date: Fri, 3 May 2024 12:54:19 +0000
Message-ID: <1edb6c4c1a66c1a2009278b99f897e3a71b592c6.camel@microchip.com>
References: <20240502143410.12629-1-prajna.rajendrakumar@microchip.com>
	 <20240502143410.12629-3-prajna.rajendrakumar@microchip.com>
	 <10671947-f418-4520-a29f-4ce129770e65@kernel.org>
In-Reply-To: <10671947-f418-4520-a29f-4ce129770e65@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8386:EE_|CH3PR11MB8210:EE_
x-ms-office365-filtering-correlation-id: f80b1741-fd40-43f4-b721-08dc6b702605
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MXB4WlNwaWI5M2F2Z0dLazFnNXEvQVhoV0RIcU1QbWRKQ2VLUlFuRHV4SmxI?=
 =?utf-8?B?ZnVaNU01OXdFN0Mrd204U1NCVGR0UTZGSGFOYXp5NW5IQmdLOExCS2p2a00r?=
 =?utf-8?B?QXFvUExORTNQbk80TzVPelNJN2N6aTBPMHN4b1VpVHhkWDBXQkZVMEZkUThj?=
 =?utf-8?B?eWkvNVE4b21DdEVWSmlPcWhZSUtjZnFxaWhPYXdPWHdoUXc1OXdtWWYxbVZG?=
 =?utf-8?B?elo5cEhCSkhSUkZ3dUNtZXZqakVlYjJhbE9nTWFoNzlQSjN2a3BsdVFTejU0?=
 =?utf-8?B?YTZ1cDcrZ1dzTzMvNTkyUkpDeklxMFB3bnhGdUtGbjA2NTdNK0FvNzFvdU5k?=
 =?utf-8?B?c2RWUHQyb2dOR3cyS0RqTlJQdHFJcll2Q0Rmek84VFpOemtFS2ZlSU54Y3A5?=
 =?utf-8?B?UXBOQnlNUnFHSGs3Skc3MWZMWGd0RjJFTWFGZ1kydXFzV2o1TWVSZTFtVDBS?=
 =?utf-8?B?Sk1GQnlTTDJuTGVFaUhPU1VEQURhTlI0eFpUZ0U0SmY4eTQ2ZHpXeTBkL2JX?=
 =?utf-8?B?V2NxZ0dZKy93czUxbHJ5bVZOOC9qSTNRRHIxU2VDVzRvOVEyc3RRckgwTnlQ?=
 =?utf-8?B?ZUtNcTBvbVpWQ1VPTVUwZTUzV1A0Z3I0Ukl5ZHF2aHQ5ei9WUmNmZ1QwR0FJ?=
 =?utf-8?B?L1hEVUdOdTZJTnIya1pnTk93NjRqYnhBc2dvSnJ4TXpkSmF6Ulp0ajdoTjZn?=
 =?utf-8?B?VVR1U3VyenRsdEFZK0phQUpSdXFBaU84SWRiTXZPaU5Tb2hGTDNleVJIOXVi?=
 =?utf-8?B?WDV0aEkzaTMrK0xXb0xKNExjVGY1cHNVVGNYL25WRWx0VVlPY1ZhOWtXTnVr?=
 =?utf-8?B?TFAzS1NSdDI5Nm9lcnp2SHlOMWtRTVhPTitucGVYcDlvRjBrWU5DaUVwRzRk?=
 =?utf-8?B?cXdMZ0JUTUNvcm9oUitPRUdSYXdjT1lDQ2hoY2Fha0h4VVlSSHlWYTROTzVS?=
 =?utf-8?B?Qm9RYTNFU1piYkdBdVBja1BmUkFNbFc5TEEzd3J3NDJpeEJZRmg0aTd6MWVS?=
 =?utf-8?B?S2J4eWJneEp4NFhiZkJpM0htQjZhREhBRUNaRlJ0SENCU1N2ZFJzU2lBSXpy?=
 =?utf-8?B?eEErbm5XRkw3dEJZbWFXQXpyejdaUkVSQURJdGdlRVVxc1d3TDEyNEZsRG5U?=
 =?utf-8?B?UjVrTVE2UDM3M0U2bDRKQWZXM0hleEkya0NGdDRDc0N4VUp4dnMrL1dCUWRV?=
 =?utf-8?B?bEg4NWtOUktTbXRKQVRwK3MxU3JrTXliL1FHa3hvOENyTUUvMXcxNnQyZWxw?=
 =?utf-8?B?L2YzRWhwemFiNGNxKzl1SGp6RjJaenJkNTA5Qld3WmxtczVRT1QvUm1qQkpa?=
 =?utf-8?B?eXpadTg1aWdkNkFKRTVKcGtVYXRObVF3T3lMak1OU01rUWRkZVFUWTRKY3dj?=
 =?utf-8?B?Y1RScHR1enN5RkdUZUtmL2hudDV3dStjdHVuV3dqZE1PYm1tWThvY0c4ZHM2?=
 =?utf-8?B?WW1Cc05KWTNvMk5Bc0R5bVc0R2x6V3ZSTnBHUFJGd2V0N0tiNmxpY0hCNEsw?=
 =?utf-8?B?c3c1MmdOY2tJQktTS0VsRkkrMkVwc1hjR25TR1VqUUJUVmpWRk9QYlVEV0Zq?=
 =?utf-8?B?V280b3lRYVVaUVRBU3BONmpSelVZb0hkYjl6MkNXU0w4cmxLNnJjUzk3eG9n?=
 =?utf-8?B?TGgrcVN3TkdGNVpGQUo4akE3VEVMU0orakE1WGUwRjZxM1QvdkZoQmVidEN1?=
 =?utf-8?B?VHRuaDVxbGRKcDRtRjJ0VDFMZTJEQU5EUzN2a2lyb1pjc2luRjQ4YUFZZHMw?=
 =?utf-8?B?dWhJTXViNWRsMUVKdlIwQTJVMjIwK2xOMjlLVmdRbW1YNW04UC9xNWRuVGN2?=
 =?utf-8?B?a3JZQUFsdE9tQ3Q0elFPQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8386.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHZjQk9zMHZEWlNEYzJnUXNHSXZSN25TUU1uK0J2bXNqamZ6VjFBaWhLQ0hB?=
 =?utf-8?B?T3E5Tmo1Q3VIMTN5Z1FtWDNhbVZqaXFiN29mVDdOREllTEI1aDFaQ2lZemdY?=
 =?utf-8?B?UFYxbmdyNExxdWUxeGttSm15RGJVSDBycHA3Qyt2ZFhKTFJLZGNreHRuZC9X?=
 =?utf-8?B?ZVNnTytjMmxMRTZMM1lZSEhvSFE3ZmR6a011eGszYWJQcE9GUWI4Wm5nYzJU?=
 =?utf-8?B?bEE4bUF1Sk10Z3laSXl2RkRtaHVGUkVWcmFVZnNpRENaV2p2V2l6L21HVC9o?=
 =?utf-8?B?eGtZQWpTLzdmWm41YldiZ2lnMjFOM3E5THgxbFArWTFoemgzRWMvK2RrSG5z?=
 =?utf-8?B?Y085YVZsVTMxbUJ4SXQ2Rk5Ec3pYK0YvR2RCRzBCc0poVkQzekZ1VkpLM0h6?=
 =?utf-8?B?QXJwSklKSnQxUDNENG0rTlE5UEZNbWJqQ3V2Q1J5SWtkaVVlOWxmYjdaaVlD?=
 =?utf-8?B?eVV6UHdzK3FkN1h5dEFzNExjQjl1ZEkzZVpKV25mMHFZYjFXSUlZanl2bW1V?=
 =?utf-8?B?ZjZ5TWRoQjJNcmMvZHRjV0QvbnZPZExmNWJweEZGWkFsMXVHZFMwaEgzL1VU?=
 =?utf-8?B?Ukl4T1Y5eEcyaHpoVVh1U0Y5eTZneEo1a2xwQnJSS3lSSmszSHRIVFdmRkJw?=
 =?utf-8?B?OHgrRm43Z3VHU1REYVI5Y2llZ055Sk14ZzNYQk5MZXFXbzZvdlFBVm1XajVE?=
 =?utf-8?B?T3dFN2NMSUVkdmdNazZNd1c0aTFZTGs3RlNsUUk5dVl2SUZMQi9BZHRVK0Vz?=
 =?utf-8?B?ZW1KMTQ4aU1IUnlnLzIrVk5ONU1HWWtUZ2ZrVWlZWFlud1V2S2lFUFRWSFUx?=
 =?utf-8?B?S2dHVDlCY3hJNlB4bkpwK2NHaFFpWTJyYXkxcDVLRHAxcTRmQUNDVFRzTTlZ?=
 =?utf-8?B?Q2kreld3ZWJWNVUraDJKRjRvcHZkUHkzLzBBSXJ0VkV1M2xsVUJLWTM2LzM1?=
 =?utf-8?B?L2h3ZHRlbEh4TlVzNHZKdzI0YlpnU045dE85aHU5Z3JPWDZWU21kYUxSSEY0?=
 =?utf-8?B?TFVkZklYL0VESW11Z0hrb0pmNDdTTWVOUEQ2SEx1N2dEQkdiay94SFg3SktW?=
 =?utf-8?B?Y0lRc2t4MGlrUFZKdDR5L3lQV043OTkrOElKNFFUYTcyNVlBQm9QYUlmWktv?=
 =?utf-8?B?d2NQVXpKVnZ4WTNydTRPRnpzTjluRnJuTDdkRHVsNXFTRFY0UkRrVUlnZ3I4?=
 =?utf-8?B?SkkweDZKaGNYREdxYU44eTRhTk0zMGt3V3E4dGNSeklKR3IvbXRrTG55NlI1?=
 =?utf-8?B?UFpIdGJrVnJJWGE3NnNuOE9IOGJJK0o1UU1Bd1IwSGdBb2JaSzlhbDRZSTZy?=
 =?utf-8?B?QldGSUxhK1FURnZUcU1Ua3NhaVNPdVhLcFU2RGZ5OE5FS2N1MkplR1djd2Nl?=
 =?utf-8?B?b0kwdGlwdDVDMHprR2xNNjRuUHpRSTNobGNGR3lQaWNNV2JHRE9EWm4xNUd1?=
 =?utf-8?B?bDFJdmdKV1dvNGp5MEM5NW1CNUkvcGZscDYzWTBqL2M2Z2xXbTJFeTVtdmls?=
 =?utf-8?B?VGorcHBYSVNpRmRnQnNramxIdGVKNnpDR0dUMThSVXY5em9uSW9DRndnb3dp?=
 =?utf-8?B?emNNTTNieFJZZUVlSFVWRkZ4dnFZckhCaXBBQzB1R2pyMU5PT1ludHFmbXBH?=
 =?utf-8?B?M3hGdm1vV2xlTVNHdU9Td0VzK21PdHhuYXVYL0V2MWlwU3BxN2NWd24wZVNG?=
 =?utf-8?B?REptc2RCMCtFVngyamozdDBhNGc3cWpBSjB4c0RpRUJmUEwrY1NhTzNselNy?=
 =?utf-8?B?dVdnVFdoM1Z5L0ZuQUFzeks1L0ZlMmFjSSs4Q0V6YWVPQk5qT0lpejZhSTFH?=
 =?utf-8?B?bkY4YWFwZzhoSWh4U1AwUUFVcFByM2l3Lzd5c2ZLb2lpUlZ6WXVwd2hxWmVR?=
 =?utf-8?B?ZmhRbjZ0UnpidExBdlltSUs3NndpSEpSL3BJWHNPMGExV1d0N3c5dGVkRjl0?=
 =?utf-8?B?ZGd1N2lBSW1oKzhsWnozcjhwWXBFQmgyZmxCZEg4UEg5V2ZhdjhzeHI1Zm8x?=
 =?utf-8?B?TkxtYTFjTWNHdW5rZHhwUEpCYlFSRGkzZXptYlhwMkZubVM3cDhEL1hyeGpM?=
 =?utf-8?B?MXNieFRlRnJYM2x2Q2pKZDQxTDRQMjZqTDE5YTR6d3Q4Z1AyWjhQQW9NV1hl?=
 =?utf-8?B?bzJEbFM5NGJjVEU2TzdwL3RyUmNzYnBTN2lqTGFiQktTcktOOHI3Y2hnNE1Y?=
 =?utf-8?Q?dkfimRrzU0KNBbgDoyAYpIA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFC84B1F84F31F46BFD12BB8B87462A2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8386.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80b1741-fd40-43f4-b721-08dc6b702605
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 12:54:19.7725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7e/21Q3gq9GxoaEGBXaDvWMuMnerYgp9v6WBjKzgaKPYHR0G8z53MAelirAzz5TJdwpCNOvt6HSxyEUsAkFLdDpjnuS7hhfK45Ih1W7jGw0rTrpUW+Jk3p3+w64TSd7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8210

T24gVGh1LCAyMDI0LTA1LTAyIGF0IDE2OjUzICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDAy
LzA1LzIwMjQgMTY6MzQsIFByYWpuYSBSYWplbmRyYSBLdW1hciB3cm90ZToNCj4gPiBUaGUgUG9s
YXJGaXJlIFNvQyBTUEkgY29udHJvbGxlciBzdXBwb3J0cyBtdWx0aXBsZSBjaGlwIHNlbGVjdHMs
YnV0DQo+ID4gaW4NCj4gPiB0aGUgTVNTLCBvbmx5IG9uZSBDUyBsaW5lIGlzIHBoeXNpY2FsbHkg
d2lyZWQuIFRvIHJlZmxlY3QgdGhpcw0KPiA+IGhhcmR3YXJlDQo+ID4gbGltaXRhdGlvbiBpbiB0
aGUgZGV2aWNlIHRyZWUsIHRoZSBiaW5kaW5nIGVuZm9yY2VzIHRoYXQgdGhlICdudW0tDQo+ID4g
Y3MnDQo+ID4gcHJvcGVydHkgZGVmYXVsdHMgdG8gMSBhbmQgY2Fubm90IGV4Y2VlZCAxIHVubGVz
cyBhZGRpdGlvbmFsDQo+ID4gY2hpcCBzZWxlY3QgbGluZXMgYXJlIGV4cGxpY2l0bHkgZGVmaW5l
ZCB1c2luZyBHUElPIGRlc2NyaXB0b3JzLg0KPiA+IA0KPiANCg0KSGksDQoNCj4gWW91IG1hcmtl
ZCBpdCBhcyBGaXggZm9yIGJ1ZywgYnV0IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGVyZSB0aGUgYnVn
DQo+IGlzLg0KDQpUaGUgYnVnIHdhcyB0aGF0IHRoZSBQb2xhckZpcmUgU29DIFNQSSAiaGFyZCIg
Y29udHJvbGxlciBzdXBwb3J0cyBlaWdodA0KY2hpcCBzZWxlY3RzLCBidXQgb25seSBvbmUgY2hp
cCBzZWxlY3QgaXMgY29ubmVjdGVkIGFuZCBjYW4gYmUgdXNlZC4NClRoaXMgd2FzIG5vdCByZWZs
ZWN0ZWQgaW4gdGhlIGRldmljZSB0cmVlIGJlY2F1c2UgZGVmYXVsdCBudW0tY3Mgd2FzDQpuZXZl
ciBzZXQuIEhlbmNlLCBpdCdzIG1hcmtlZCBhcyBhIGZpeC4NCg0KPiBEbyB5b3UgZGVzY3JpYmUg
YWJvdmUgdGhlIGlzc3VlIG9yIHRoZSBzb2x1dGlvbj8NCg0KSXQgZGVzY3JpYmVzIGJvdGggdGhl
IGlzc3VlIGFuZCB0aGUgc29sdXRpb24sIGJ1dCBJIHdpbGwgcmV2aXNlIHRoZQ0KY29tbWl0IG1l
c3NhZ2UgYXMgQ29ub3IgRG9vbGV5IHN1Z2dlc3RlZC4NCj4gDQo+ID4gKyAgLSBpZjoNCj4gPiAr
ICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICAg
ICAgY29udGFpbnM6DQo+ID4gKyAgICAgICAgICAgIGNvbnN0OiBtaWNyb2NoaXAsbXBmcy1zcGkN
Cj4gPiArICAgICAgbm90Og0KPiA+ICsgICAgICAgIHJlcXVpcmVkOg0KPiA+ICsgICAgICAgICAg
LSBjcy1ncGlvcw0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgeW91IGFyZSBleHByZXNz
aW5nIGhlcmUuIERpZCB5b3UgYWN0dWFsbHkNCj4gdmFsaWRhdGUgaXQgdGhhdCBpdCBhY2hpZXZl
cyBleGFjdGx5IHdoYXQgeW91IHdhbnQ/DQoNClNpbmNlIHRoZSBjb250cm9sbGVyIHN1cHBvcnRz
IG9ubHkgb25lIGNoaXAgc2VsZWN0LCB0aGUgbnVtLWNzIHNob3VsZA0KZGVmYXVsdCB0byAxIGFu
ZCBjYW5ub3QgZXhjZWVkIDEgdW5sZXNzIEdQSU9zIGFyZSB1c2VkIGFzIGNoaXAgc2VsZWN0cy4N
Cg0KPiA+ICsgICAgdGhlbjoNCj4gPiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICBu
dW0tY3M6DQo+ID4gKyAgICAgICAgICBkZWZhdWx0OiAxDQo+ID4gKyAgICAgICAgICBtYXhpbXVt
OiAxDQo+ID4gKw0KPiA+ICB1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gDQo+ID4g
IGV4YW1wbGVzOg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQpCZXN0IHJl
Z2FyZHMsDQpQcmFqbmENCg==

