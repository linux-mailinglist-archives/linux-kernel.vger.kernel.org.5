Return-Path: <linux-kernel+bounces-86125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF19286C000
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9383D283EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB43139AEB;
	Thu, 29 Feb 2024 04:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P/5f7TBY";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BYqa/D0w"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A823A267;
	Thu, 29 Feb 2024 04:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709182295; cv=fail; b=d+PpNcS/lmZsyirscFlUL5wDm/uR4cEhiu7sEZ6rpfJnBY4r0og1ydcmXlFvL2A2+WROpM+BpWcBJUYafqf07teFH+28JIRohbQy44ArPcOQVAblPzWbn6jcTzF24i2xkpTfwWovhDZj1JM/8F9XSpgewWTrXeDhWTEYk2MtyGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709182295; c=relaxed/simple;
	bh=Lb+r8WQ6uxVo/EJAJF5mdCQ+7Mc6pBoIeKWnvWkZo3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rgw7iXkThtKBbc79PKH3YIugqV91zkZ4f1tjao666dYMVBnzgQEV3Ze733Xz9DsU77djjWFJMqSaWBDKcscLjL4SoBBnuJvUGNL6rOzZ9uTs3litQDiUWlAj0DKj+8T8Lhx3OU2g2E6UKYFp2H5XFXkrQzFlf/sNexpEf3r/YBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P/5f7TBY; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BYqa/D0w; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709182292; x=1740718292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lb+r8WQ6uxVo/EJAJF5mdCQ+7Mc6pBoIeKWnvWkZo3U=;
  b=P/5f7TBYnplczxAzfObQPE+f8YZ3r98m8DI2uIzGmO0zDi8s4sSzC0l+
   imUuWaG/hPcKLW35Zy4Z73SFsg4vtqNlO9SU3BOhlTN4cfjsS8AOpmEdM
   2Rqb/U4XKy5toJJ/2K+yIAxHCsOAop0HD0Gh69IkZaQ2MuAt7puk3tKXp
   dHDAr8pCDTJnIo/+X2S+ERGd/dkWtV5Fw2Ejy91vE4w9iuyXVKlIo0L8X
   fHW3Q3Y45b7danJQe9EE5V58V9+lni407FQjjI0aGCXTODajZyNkCm+Kt
   Jp6xjbzfOZ4p1yPMu2ms8wcJTs11LkxSIxbNVu1GPzhwCofYj/PW177nH
   g==;
X-CSE-ConnectionGUID: Qubm0xCcQeyVaZmWWbgt0g==
X-CSE-MsgGUID: oxxkICt1TMWB3Ov/+30C3A==
X-IronPort-AV: E=Sophos;i="6.06,192,1705388400"; 
   d="scan'208";a="18584616"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2024 21:51:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 21:51:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 21:51:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeIn+mlP3/fZ7dArHR/wErOm9ZgMT19xvSOAur8+fYxstLTtCi71bG6cN+sl2O4CstLHL1hC/ZAgJH7u1q/zS2tCKFlbS1oXJNe7iVAbuiNGSu7f0OmRyNbksh3TV5XezcZVyoYO3LAMG6NJrqeT3GWVaeIp9gNBorOhQS5+isQK4AEHDLDNmyjSyisQ0MXBExp7sLa6UnkviaNY7g/TKpZawh2JSej/ssIUnVwAlu/Dn3PdqTqbG9AIuhJjwqYZmDsIObj6eeiUKzveYUH3NNx0bwrfRTk1CC1wnlQgHeK68Ox5r72btclWc6jVkIPuOsnpLl/fbYI+0gjuTvbVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb+r8WQ6uxVo/EJAJF5mdCQ+7Mc6pBoIeKWnvWkZo3U=;
 b=XkuJ/oKqRJ8hBAWZAxJFmq4RXWPuoJVORbe1YnC0783EdxnUfywI/sAw0yfRu7Ju/NFz4QnJXQAHUbZMPIqxCEGoaNGrEK6U68EFN7BDV9PbWaivuYaqnJ4sYK0R6YHrZpjXyOdUTInJKlTYyNh//vL7ZiQeyhLQd7jkHnJrhHga5lRW7SsQVUyP1vCnFjf0J1HCLzBr6LPGPyWK/oDDRzv5om5ccQKQM6MQ8x2F6AqUoxgLFCf3bGJn12fnySTFnkWJB+QPqATaAkc/xFc1XGcGZzRWtb/AijD5VTe7QbgpydKroLYlW/sruH3peH93YPtn5WtA/k4XVhvklX8f3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb+r8WQ6uxVo/EJAJF5mdCQ+7Mc6pBoIeKWnvWkZo3U=;
 b=BYqa/D0wxbnyRWJqzxanwq0p/LRkyANavZhoKzWF01Y1ztDk6+bYzwiU44zaMW3meJV0UtDQdKxcKUsSh2tcYysXZnw6mOzcBH/c2xQ2A8MbLmSQRDIqSxPrS6bIgyI9AcK6el/YPQTBdZd45VZfwTxlJEjh148N1ZcwhS3LKrsjfroBJPo96NAKT5DPnMsNQwrktyFs+isq0xZjq3FXgRmuy7SgOXhKWqzhyv0jdkNj8Xf+GMKwwGbeNXFI41/4hVcdQ95MoVewnw85ppU1FGAAXiLzNRFEkerwla9Dx2cbN4zP3YBqMR2Z25rX9wFsgqpuMaltK+8fVes/rVxxEA==
Received: from LV8PR11MB8700.namprd11.prod.outlook.com (2603:10b6:408:201::22)
 by DS0PR11MB8049.namprd11.prod.outlook.com (2603:10b6:8:116::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Thu, 29 Feb
 2024 04:51:23 +0000
Received: from LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda]) by LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda%6]) with mapi id 15.20.7339.009; Thu, 29 Feb 2024
 04:51:21 +0000
From: <Raju.Lakkaraju@microchip.com>
To: <Horatiu.Vultur@microchip.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <Bryan.Whitehead@microchip.com>,
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net 1/3] net: lan743x: disable WOL upon resume to restore
 full data path operation
Thread-Topic: [PATCH net 1/3] net: lan743x: disable WOL upon resume to restore
 full data path operation
Thread-Index: AQHaaIt4JiSb9wlTL0mxkmItOFoCmbEcSiCAgAR5WwA=
Date: Thu, 29 Feb 2024 04:51:21 +0000
Message-ID: <LV8PR11MB8700141D4890255D591EBA709F5F2@LV8PR11MB8700.namprd11.prod.outlook.com>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-2-Raju.Lakkaraju@microchip.com>
 <20240226082717.yo5onodu3c5tfvrh@DEN-DL-M31836.microchip.com>
In-Reply-To: <20240226082717.yo5onodu3c5tfvrh@DEN-DL-M31836.microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8700:EE_|DS0PR11MB8049:EE_
x-ms-office365-filtering-correlation-id: 0d587187-b84c-4946-d3ed-08dc38e21320
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BVgOVOtlAr4XweqReh/EqCj8McMtkQujlYxLt6eN3cCU/WSUmLbqvfwou9CZnqAMsk78d3edPo0TCbJ0C+b8l/mskfCHQv4obaG5bykFYaMNoYF9kXdr2atew21TYLQOPYU/qduIU/r6jZDa3POrAmpZ+1riHg2Uv/0fwh6VJkP7kfa9iOOp5q6G/Oc2px09/EQmhBiHR09UxjYu5xyz0jbPmdHVD78Li8JCbgccuJ506gOVAUTU+P1L90yVL5psVuiu6DjiMLaTxakPuMFEnvF82cPKXMLorndoPqRKRzdQtQRkDU+l0bqH8JAlAz7Kon2veuEp4nKsv4GhMrsZ9Rb3zy+mMR9gUNGzwkn36ZYEsxNQGtSZXyHVq4ndWKToGW4qCTkqYClgcCxMYpvB2Fy8T6+5CSRNWB+BW8n/buEg07QLvDPETSGeP1olfN9NWxNzPx1A1+C38Kvhun7mROF/Oh13MW4pWlFYcE6xBc64EoM3ju8AOxjVajPaBjow0u2UBzkFtcJQjKLCFTb12ml1+0VHYr1bvEthx1HQJqU4NiAHUJpmGzPnO713y74+OMUtc/k88ktv6DrtFAKYiCmWvQLspLZTaxDjYInjNLgvScYkGbuUWDB+/ZqoPEhXYg+q6oZZudTTDCdMi7RUrxwyXD9Gjz5tH11wjz1mkFP7PzJ0qcCAXiTN1+A5ezj7DQE6ia/KyWJiZY1oNtqza9bsslyYGo5SETKRf1ol01Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8700.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWJRdHZsaXQybVoyWlZqTkNZZkxLdlhnZi9BcGNBNm9kbGZvQW95WC85OUhU?=
 =?utf-8?B?RDhLS1hONUE4OGk1QmlkWlB5RlRNV2prdlo3ZERpN2hoalEvK1ZMSFp0T2Ju?=
 =?utf-8?B?eHB5OTM2dW95SmxNZ0xYblJpQ0lMU2IxblZYdEtBYmNMUlMwOEFzTjBzNU9O?=
 =?utf-8?B?QzBRWUJHU1p5RTR2aERLOTdhQ0IyaFp1OVV5NFhVS3ZSM1YrYWJRejFpdGpE?=
 =?utf-8?B?Q0NVaE9LREtjTXN2MnJVNFNkeDc3NDQ0RWRSVGlmSlpXVFhlZ2JtWjdQSVRD?=
 =?utf-8?B?dlFvTnNMUTUwN05BZzg5TlQ0TWltaEhQcll4SGpqdFFEV0RZcS9tZVp2VnZN?=
 =?utf-8?B?NEY1UkJuT0lqTHJ5WCtYWlhvSXpSdXlFT0hkOGlaMmFtZVJWQ0thL2c5bUZ1?=
 =?utf-8?B?TXNvTTVicUZ3ZUdpMDhVR0JieHRMSVNrbUdYU29jbVl4YVkwNmNuNzUxSDRB?=
 =?utf-8?B?TVZta2RwQ2pZSlZ6T09HQWJMeHYydGpEMjA1TnB5QTVVQkEyb1RlTWNYcDBm?=
 =?utf-8?B?c2M2RWRwcklRV3YyQzZNOE9XOUExMFNUL28vM0pzc0htSGQ0UktraVhwdVVk?=
 =?utf-8?B?SHJWWmNEM1JmbUU5NlNjSmlvWWxjbXJVa2dJcWp3WlVsYWVxV2dKdWNPb3gy?=
 =?utf-8?B?TUltNEZvUS9SUyt5ZVRZbGkrdTljY2JGdDBiVGtSbklEQnFmYkF6OEs2VWZs?=
 =?utf-8?B?bkhsV2FxaGZSSW9HUk5JcTZMbmd3TGFMdm52dmUwNHlpdncyb3k1UVBoTDcz?=
 =?utf-8?B?ckVKdEFmSllqOElGeFlHY2xNT0lZRmtMd2Q4NXhHdlUrK0VPQmcrM1haK1l2?=
 =?utf-8?B?ZDZjelRPelZHUC84U2s0MHVZeE1yaFRoSTR2dldFYzhVTmZESUhEVW1nUUgr?=
 =?utf-8?B?R2RtZUV3aE9jeXh6YUs3WmFIZ2RyTGJmODhwS2R2dTFJS0pCbEZJZzF3dEdB?=
 =?utf-8?B?bUk3a3NVbmtqRlQya1o2NUJVUGRoaHRaWjExejNFS250N0ZkNmZnVzJXZTNS?=
 =?utf-8?B?T0UxTG1nbzlxOWNQbWhiUWc4U0xCaXc4YlhxN0M4M3BkbHRNd0xyYzZFVjY1?=
 =?utf-8?B?Z3g4aDh1ZkdZTThYam16TkRZOHo1Z0wvWXloVTN3SUVha1JER21Yd1l5Z0xz?=
 =?utf-8?B?MmRPNFpPWUhpelZkUktLbmx1bnZlaTBNdk1IaXFMUnJVeFpIVTYxTjNjSTIx?=
 =?utf-8?B?WlZjeUlNZUw3N2NSQkdRV0hobFFYeDMxVkw1ZlpXNWdzT3VtSktrSjM2U2JE?=
 =?utf-8?B?NGFNTGJtVmdUb0piQUNqSkdDZmlJaTNsemFMZHZIOEYrdDRQYzd2cSsvMUV1?=
 =?utf-8?B?U0RsU2FXSTBTOTREOFZnVWtENGZqZFJmSkE5TjRkT1RjMHNKNFR1OGFDV0Jt?=
 =?utf-8?B?d20vbTgxalpkWEs3c0hLeTArT2Q4S0VLY0lzZUY1SHI5ektNa2toS1E3RDhW?=
 =?utf-8?B?NFpIbk0rZWNqVXB4SUtrLzA5QTZoQUkydWVIZlMyOGJIQkVLcXRUS2JoN0FM?=
 =?utf-8?B?WFZtdjdPRmppbGNwWS9HYVJoSDJ0WTFidWRWQTdMU0JJNDcyMTBkc3A1enhT?=
 =?utf-8?B?VFRVZm5JajVobWs4ckR6dzdwSjFNTFA4WTI4N2JSMUdlVm9uVmhmTVVBODZp?=
 =?utf-8?B?M2FrcWtTaHFDRWdKbjJjMjluQjZmRVJGeGYyOTl2YWs0MkFkRUxFYmhxbXRI?=
 =?utf-8?B?NUNpOU1McTNDUWduRG9ETFMyR1VQbE5FbW4xcFI5bnBlNGdNTU5mSndrOXNi?=
 =?utf-8?B?N2liWWJ3V2VzT0xlSndtMDUzd0JUUzl3bFV1eWI1TVI0SzBpYjRRYWYra0lJ?=
 =?utf-8?B?QW9QR1h4TVRPUVgvdDJzaHlraE4yRXhzbmZxU1Vycng0bzFKaU9zSE41MnZk?=
 =?utf-8?B?Z3BiWGgrRU13WGlTWG5pY1dXT1ZaL1FDRlFJMXBKYnlsRnI0L1pBUHovcjh2?=
 =?utf-8?B?OUE0YWJVYlljdnlIdHRyc3RzMXVaOTRCZENSVzhNLzlJS3dDdDVOa2Fra3FT?=
 =?utf-8?B?UWZIQnp0aUFkN2FmTmUxS1JQTEEyYXdrNkVnYzhtSUFOVEsySVozUUV3MUI3?=
 =?utf-8?B?Q3hIRnZZdkxsYWo1aDNRWXhwdFVvVnc2TDlWYlNOQ1FZalR4S3ZBSUlYZ0Qx?=
 =?utf-8?B?bXRvc3dPRW5mMWF0My9nTDREaVpLcVVUa1kwdEljU3Z1N09JaVRwWkhBbDl5?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8700.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d587187-b84c-4946-d3ed-08dc38e21320
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 04:51:21.4326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AiQQRYhi8FiP/YsvvELsRmv9XHq0ZN88Xzn37yFQniesl/lgtbtYd5vXBfTO+G1hOF9vEs0agHMwxWij+Gq9yu3YEYKxeRzlxgY/JwrVUnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8049

SGkgSG9yYXRpdSwNCg0KVGhhbmsgeW91IGZvciByZXZpZXcgY29tbWVudHMuDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSG9yYXRpdSBWdWx0dXIgLSBNMzE4MzYgPEhv
cmF0aXUuVnVsdHVyQG1pY3JvY2hpcC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkgMjYs
IDIwMjQgMTo1NyBQTQ0KPiBUbzogUmFqdSBMYWtrYXJhanUgLSBJMzA0OTkgPFJhanUuTGFra2Fy
YWp1QG1pY3JvY2hpcC5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZlbUBk
YXZlbWxvZnQubmV0OyBrdWJhQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBCcnlhbiBXaGl0ZWhlYWQgLSBDMjE5NTgNCj4gPEJyeWFuLldoaXRlaGVhZEBtaWNy
b2NoaXAuY29tPjsgcmljaGFyZGNvY2hyYW5AZ21haWwuY29tOw0KPiBVTkdMaW51eERyaXZlciA8
VU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQg
MS8zXSBuZXQ6IGxhbjc0M3g6IGRpc2FibGUgV09MIHVwb24gcmVzdW1lIHRvDQo+IHJlc3RvcmUg
ZnVsbCBkYXRhIHBhdGggb3BlcmF0aW9uDQo+IA0KPiBUaGUgMDIvMjYvMjAyNCAxMzozOSwgUmFq
dSBMYWtrYXJhanUgd3JvdGU6DQo+ID4gSW4gb3JkZXIgZm9yIGRhdGFwYXRoIHRvIGJlIHJlc3Rv
cmVkIHRvIG5vcm1hbCBmdW5jdGlvbmFsaXR5IGFmdGVyDQo+ID4gcmVzdW1lIHdlIGRpc2FibGUg
YWxsIHdha2V1cCBldmVudHMuIEFkZGl0aW9uYWxseSB3ZSBjbGVhciBhbGwgVzFDDQo+ID4gc3Rh
dHVzIGJpdHMgYnkgd3JpdGluZyAxJ3MgdG8gdGhlbS4NCj4gDQo+IEhhdmUgeW91IHJ1biBnZXRf
bWFpbnRhaW5lci5wbCBiZWZvcmUgc2VuZGluZyB0aGlzPw0KPiBUbyBtZSBpdCBzZWVtcyB0aGF0
IEVyaWMgYW5kIFBhb2xvIGFyZSBtaXNzaW5nIGZyb20gdGhlIGVtYWlsIGxpc3QuDQo+IA0KDQpJ
IGRpZCBub3Qgbm90aWNlLiANClN1cmUuIEkgd2lsbCBhZGQgbWlzc2luZyBtZW1iZXJzIGluIG15
IG5leHQgbWFpbC4NCg0KPiA+DQo+ID4gRml4ZXM6IDRkOTQyODJhZmQ5NSAoImxhbjc0M3g6IEFk
ZCBwb3dlciBtYW5hZ2VtZW50IHN1cHBvcnQiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFJhanUgTGFr
a2FyYWp1IDxSYWp1Lkxha2thcmFqdUBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuNzQzeF9tYWluLmMgfCAyNA0KPiA+ICsrKysr
KysrKysrKysrKysrKy0gIGRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43NDN4X21h
aW4uaCB8DQo+ID4gMjQgKysrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQs
IDQ3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuNzQzeF9tYWluLmMNCj4gPiBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43NDN4X21haW4uYw0KPiA+IGluZGV4IDQ1ZTIw
OWE3ZDA4My4uNTY0MWI0NjZkNzBkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21pY3JvY2hpcC9sYW43NDN4X21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21pY3JvY2hpcC9sYW43NDN4X21haW4uYw0KPiA+IEBAIC0zNTUwLDcgKzM1NTAsNyBAQCBz
dGF0aWMgdm9pZCBsYW43NDN4X3BtX3NldF93b2woc3RydWN0DQo+ID4gbGFuNzQzeF9hZGFwdGVy
ICphZGFwdGVyKQ0KPiA+DQo+ID4gIAkvKiBjbGVhciB3YWtlIHNldHRpbmdzICovDQo+ID4gIAlw
bXRjdGwgPSBsYW43NDN4X2Nzcl9yZWFkKGFkYXB0ZXIsIFBNVF9DVEwpOw0KPiA+IC0JcG10Y3Rs
IHw9IFBNVF9DVExfV1VQU19NQVNLXzsNCj4gPiArCXBtdGN0bCB8PSBQTVRfQ1RMX1dVUFNfTUFT
S18gfA0KPiBQTVRfQ1RMX1JFU19DTFJfV0tQX01BU0tfOw0KPiA+ICAJcG10Y3RsICY9IH4oUE1U
X0NUTF9HUElPX1dBS0VVUF9FTl8gfA0KPiBQTVRfQ1RMX0VFRV9XQUtFVVBfRU5fIHwNCj4gPiAg
CQlQTVRfQ1RMX1dPTF9FTl8gfCBQTVRfQ1RMX01BQ19EM19SWF9DTEtfT1ZSXyB8DQo+ID4gIAkJ
UE1UX0NUTF9SWF9GQ1RfUkZFX0QzX0NMS19PVlJfIHwNCj4gUE1UX0NUTF9FVEhfUEhZX1dBS0Vf
RU5fKTsgQEANCj4gPiAtMzY4NSw2ICszNjg1LDcgQEAgc3RhdGljIGludCBsYW43NDN4X3BtX3Jl
c3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gIAlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRv
X3BjaV9kZXYoZGV2KTsNCj4gPiAgCXN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYgPSBwY2lfZ2V0
X2RydmRhdGEocGRldik7DQo+ID4gIAlzdHJ1Y3QgbGFuNzQzeF9hZGFwdGVyICphZGFwdGVyID0g
bmV0ZGV2X3ByaXYobmV0ZGV2KTsNCj4gPiArCWludCBkYXRhOw0KPiA+ICAJaW50IHJldDsNCj4g
Pg0KPiA+ICAJcGNpX3NldF9wb3dlcl9zdGF0ZShwZGV2LCBQQ0lfRDApOw0KPiA+IEBAIC0zNzE1
LDYgKzM3MTYsMjcgQEAgc3RhdGljIGludCBsYW43NDN4X3BtX3Jlc3VtZShzdHJ1Y3QgZGV2aWNl
DQo+ICpkZXYpDQo+ID4gIAluZXRpZl9pbmZvKGFkYXB0ZXIsIGRydiwgYWRhcHRlci0+bmV0ZGV2
LA0KPiA+ICAJCSAgICJXYWtldXAgc291cmNlIDogMHglMDhYXG4iLCByZXQpOw0KPiA+DQo+ID4g
KwkvKiBDbGVhciB0aGUgd29sIGNvbmZpZ3VyYXRpb24gYW5kIHN0YXR1cyBiaXRzIHdoZW4gc3lz
dGVtDQo+ID4gKwkgKiBldmVudHMgb2NjdXJzLg0KPiA+ICsJICogVGhlIHN0YXR1cyBiaXRzIGFy
ZSAiV3JpdGUgT25lIHRvIENsZWFyIChXMUMpIg0KPiA+ICsJICovDQo+ID4gKwlkYXRhID0gTUFD
X1dVQ1NSX0VFRV9UWF9XQUtFXyB8DQo+IE1BQ19XVUNTUl9FRUVfUlhfV0FLRV8gfA0KPiA+ICsJ
ICAgICAgIE1BQ19XVUNTUl9SRkVfV0FLRV9GUl8gfCBNQUNfV1VDU1JfUEZEQV9GUl8gfA0KPiBN
QUNfV1VDU1JfV1VGUl8gfA0KPiA+ICsJICAgICAgIE1BQ19XVUNTUl9NUFJfIHwgTUFDX1dVQ1NS
X0JDQVNUX0ZSXzsNCj4gPiArCWxhbjc0M3hfY3NyX3dyaXRlKGFkYXB0ZXIsIE1BQ19XVUNTUiwg
ZGF0YSk7DQo+ID4gKw0KPiA+ICsJZGF0YSA9IE1BQ19XVUNTUjJfTlNfUkNEXyB8IE1BQ19XVUNT
UjJfQVJQX1JDRF8gfA0KPiA+ICsJICAgICAgIE1BQ19XVUNTUjJfSVBWNl9UQ1BTWU5fUkNEXyB8
DQo+IE1BQ19XVUNTUjJfSVBWNF9UQ1BTWU5fUkNEXzsNCj4gPiArCWxhbjc0M3hfY3NyX3dyaXRl
KGFkYXB0ZXIsIE1BQ19XVUNTUjIsIGRhdGEpOw0KPiA+ICsNCj4gPiArCWRhdGEgPSBNQUNfV0tf
U1JDX0VUSF9QSFlfV0tfIHwNCj4gTUFDX1dLX1NSQ19JUFY2X1RDUFNZTl9SQ0RfV0tfIHwNCj4g
PiArCSAgICAgICBNQUNfV0tfU1JDX0lQVjRfVENQU1lOX1JDRF9XS18gfA0KPiBNQUNfV0tfU1JD
X0VFRV9UWF9XS18gfA0KPiA+ICsJICAgICAgIE1BQ19XS19TUkNfRUVFX1JYX1dLXyB8IE1BQ19X
S19TUkNfUkZFX0ZSX1dLXyB8DQo+ID4gKwkgICAgICAgTUFDX1dLX1NSQ19QRkRBX0ZSX1dLXyB8
IE1BQ19XS19TUkNfTVBfRlJfV0tfIHwNCj4gPiArCSAgICAgICBNQUNfV0tfU1JDX0JDQVNUX0ZS
X1dLXyB8IE1BQ19XS19TUkNfV1VfRlJfV0tfIHwNCj4gPiArCSAgICAgICBNQUNfV0tfU1JDX1dL
X0ZSX1NBVkVEXzsNCj4gPiArCWxhbjc0M3hfY3NyX3dyaXRlKGFkYXB0ZXIsIE1BQ19XS19TUkMs
IGRhdGEpOw0KPiA+ICsNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjc0M3hfbWFpbi5oDQo+ID4g
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuNzQzeF9tYWluLmgNCj4gPiBpbmRl
eCBiZTc5Y2IwYWU1YWYuLjc3ZmMzYWJjMTQyOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuNzQzeF9tYWluLmgNCj4gPiArKysgYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuNzQzeF9tYWluLmgNCj4gPiBAQCAtNjAsNiArNjAsNyBA
QA0KPiA+ICAjZGVmaW5lIFBNVF9DVExfUlhfRkNUX1JGRV9EM19DTEtfT1ZSXwkJQklUKDE4KQ0K
PiA+ICAjZGVmaW5lIFBNVF9DVExfR1BJT19XQUtFVVBfRU5fCQkJQklUKDE1KQ0KPiA+ICAjZGVm
aW5lIFBNVF9DVExfRUVFX1dBS0VVUF9FTl8JCQlCSVQoMTMpDQo+ID4gKyNkZWZpbmUgUE1UX0NU
TF9SRVNfQ0xSX1dLUF9NQVNLXwkJR0VOTUFTSyg5LCA4KQ0KPiA+ICAjZGVmaW5lIFBNVF9DVExf
UkVBRFlfCQkJCUJJVCg3KQ0KPiA+ICAjZGVmaW5lIFBNVF9DVExfRVRIX1BIWV9SU1RfCQkJQklU
KDQpDQo+ID4gICNkZWZpbmUgUE1UX0NUTF9XT0xfRU5fCQkJCUJJVCgzKQ0KPiA+IEBAIC0yMjYs
MTIgKzIyNywzMSBAQA0KPiA+ICAjZGVmaW5lIE1BQ19XVUNTUgkJCQkoMHgxNDApDQo+ID4gICNk
ZWZpbmUgTUFDX01QX1NPX0VOXwkJCQlCSVQoMjEpDQo+ID4gICNkZWZpbmUgTUFDX1dVQ1NSX1JG
RV9XQUtFX0VOXwkJCUJJVCgxNCkNCj4gPiArI2RlZmluZSBNQUNfV1VDU1JfRUVFX1RYX1dBS0Vf
CQkJQklUKDEzKQ0KPiA+ICsjZGVmaW5lIE1BQ19XVUNTUl9FRUVfUlhfV0FLRV8JCQlCSVQoMTEp
DQo+ID4gKyNkZWZpbmUgTUFDX1dVQ1NSX1JGRV9XQUtFX0ZSXwkJCUJJVCg5KQ0KPiA+ICsjZGVm
aW5lIE1BQ19XVUNTUl9QRkRBX0ZSXwkJCUJJVCg3KQ0KPiA+ICsjZGVmaW5lIE1BQ19XVUNTUl9X
VUZSXwkJCQlCSVQoNikNCj4gPiArI2RlZmluZSBNQUNfV1VDU1JfTVBSXwkJCQlCSVQoNSkNCj4g
PiArI2RlZmluZSBNQUNfV1VDU1JfQkNBU1RfRlJfCQkJQklUKDQpDQo+ID4gICNkZWZpbmUgTUFD
X1dVQ1NSX1BGREFfRU5fCQkJQklUKDMpDQo+ID4gICNkZWZpbmUgTUFDX1dVQ1NSX1dBS0VfRU5f
CQkJQklUKDIpDQo+ID4gICNkZWZpbmUgTUFDX1dVQ1NSX01QRU5fCQkJCUJJVCgxKQ0KPiA+ICAj
ZGVmaW5lIE1BQ19XVUNTUl9CQ1NUX0VOXwkJCUJJVCgwKQ0KPiA+DQo+ID4gICNkZWZpbmUgTUFD
X1dLX1NSQwkJCQkoMHgxNDQpDQo+ID4gKyNkZWZpbmUgTUFDX1dLX1NSQ19FVEhfUEhZX1dLXwkJ
CUJJVCgxNykNCj4gPiArI2RlZmluZSBNQUNfV0tfU1JDX0lQVjZfVENQU1lOX1JDRF9XS18JCUJJ
VCgxNikNCj4gPiArI2RlZmluZSBNQUNfV0tfU1JDX0lQVjRfVENQU1lOX1JDRF9XS18JCUJJVCgx
NSkNCj4gPiArI2RlZmluZSBNQUNfV0tfU1JDX0VFRV9UWF9XS18JCQlCSVQoMTQpDQo+ID4gKyNk
ZWZpbmUgTUFDX1dLX1NSQ19FRUVfUlhfV0tfCQkJQklUKDEzKQ0KPiA+ICsjZGVmaW5lIE1BQ19X
S19TUkNfUkZFX0ZSX1dLXwkJCUJJVCgxMikNCj4gPiArI2RlZmluZSBNQUNfV0tfU1JDX1BGREFf
RlJfV0tfCQkJQklUKDExKQ0KPiA+ICsjZGVmaW5lIE1BQ19XS19TUkNfTVBfRlJfV0tfCQkJQklU
KDEwKQ0KPiA+ICsjZGVmaW5lIE1BQ19XS19TUkNfQkNBU1RfRlJfV0tfCQkJQklUKDkpDQo+ID4g
KyNkZWZpbmUgTUFDX1dLX1NSQ19XVV9GUl9XS18JCQlCSVQoOCkNCj4gPiArI2RlZmluZSBNQUNf
V0tfU1JDX1dLX0ZSX1NBVkVEXwkJCUJJVCg3KQ0KPiA+ICsNCj4gPiAgI2RlZmluZSBNQUNfTVBf
U09fSEkJCQkJKDB4MTQ4KQ0KPiA+ICAjZGVmaW5lIE1BQ19NUF9TT19MTwkJCQkoMHgxNEMpDQo+
ID4NCj4gPiBAQCAtMjk0LDYgKzMxNCwxMCBAQA0KPiA+ICAjZGVmaW5lIFJGRV9JTkRYKGluZGV4
KQkJCSgweDU4MCArIChpbmRleCA8PCAyKSkNCj4gPg0KPiA+ICAjZGVmaW5lIE1BQ19XVUNTUjIJ
CQkoMHg2MDApDQo+ID4gKyNkZWZpbmUgTUFDX1dVQ1NSMl9OU19SQ0RfCQlCSVQoNykNCj4gPiAr
I2RlZmluZSBNQUNfV1VDU1IyX0FSUF9SQ0RfCQlCSVQoNikNCj4gPiArI2RlZmluZSBNQUNfV1VD
U1IyX0lQVjZfVENQU1lOX1JDRF8JQklUKDUpDQo+ID4gKyNkZWZpbmUgTUFDX1dVQ1NSMl9JUFY0
X1RDUFNZTl9SQ0RfCUJJVCg0KQ0KPiA+DQo+ID4gICNkZWZpbmUgU0dNSUlfQUNDCQkJKDB4NzIw
KQ0KPiA+ICAjZGVmaW5lIFNHTUlJX0FDQ19TR01JSV9CWllfCQlCSVQoMzEpDQo+ID4gLS0NCj4g
PiAyLjM0LjENCj4gPg0KPiANCj4gLS0NCj4gL0hvcmF0aXUNCg0KVGhhbmtzLA0KUmFqdQ0K

