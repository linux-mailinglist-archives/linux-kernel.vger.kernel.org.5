Return-Path: <linux-kernel+bounces-110587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7608860F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B712E284183
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79151134424;
	Thu, 21 Mar 2024 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="dh9GzAIG";
	dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b="plYfXSVk"
Received: from mx0a-00183b01.pphosted.com (mx0b-00183b01.pphosted.com [67.231.157.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D372C133435;
	Thu, 21 Mar 2024 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049269; cv=fail; b=KBCz5UjdyFQL4x8bBry5+PQ9U+1qhwS75ro//bWBayEF5LVUcDWcOEmFxA5DTwoaHyoKl+rKrthuhpDTUKrZLbE37pnWZONLP5PzWRO0d0NXuNGrtnpek3AxHQxsKooQDMCHwy7Vo4zeTXCGu9LfDJMUQ4JBHak6wBp74g4HN2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049269; c=relaxed/simple;
	bh=rBr8LeAIh46SK5BTWJb9OgWMGG3TweCz/KeHjQAnCpM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bakbM/aGUg/QJZ+j1JZKfEStBCtGCkqAwX5KlejeUFgvOempyILV7jfH6Mnp/C6OQUhRUuXiRuBl9eXiNtCN6uIfQmi7p+m87dFs6kd2knyJXDHmC76yEzuED/qDG7hjswtfwKJtrOEBqSs1yKULxbKdkzwWLTN4xJ7xcu7N+eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=dh9GzAIG; dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b=plYfXSVk; arc=fail smtp.client-ip=67.231.157.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
	by mx0b-00183b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L7cnHF002702;
	Thu, 21 Mar 2024 12:49:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pphosted-onsemi; bh=rBr8LeAIh46SK5BTWJb9OgWMGG3TweCz/KeHjQAnCpM=; b=
	dh9GzAIG3JvCOtKq5ll+fIcB/xHutzTZIfgjt+KP23ozDANlR41lt5vChDyhCccS
	9BRDGGgJQCSZmCi1z0GyW1149LH24wdWaw9YVVK1wOSroR8lvfXFDBoQPjTudxyw
	TN3iP55Nu/VKg9WbY7SZt/evUTJZizpuwzVpMD07Z7sTItHHG45vVj0gS0fIVCzZ
	HpAEts/31a3SwDuSa5iflB8Oafr7yc31MTA1E5mK+yC+8/Q3VFDQklSwOReM7Yqg
	YFty6J6/yeF+eooI+Out3e3i4uPxB6xggovqIhc4Tk0ukeXrJOyDfWUSfnXU+M0F
	5xTPD9VipZNeGGwvtzbK+A==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-00183b01.pphosted.com (PPS) with ESMTPS id 3ww6n9dhgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 12:49:14 -0600 (MDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP2jHV0vKtP1r7B2tS8DEryu67ue+VMAkZOBOadNREPUxe93dJgkgBE1KAVfWXX0Ucz58th3bn1byVaXIeA5W35RYeXlnHaAJrhcchL8kgeVKjzNSu2N6azA7O4mQz/48yzxI4D7fVBh3DXb4tkQBj4AdcCFzTdzCWNZnbp3DKMMVbSqOm0RrzRtXXqm5xSsWpxUE+1hPNQiDq0Ma3gX6vTpk2BVNncmxCRX0jMLr9Dohy2sqkX3W9J60qM8hEcO+mQKX1MTiaH+hk3zJVjW29W6G8F3MEvGDHHMZ8dMq7/feyvUtq2xJMebKIW08BVesVG9m0Z1Aq50aK/grEekpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBr8LeAIh46SK5BTWJb9OgWMGG3TweCz/KeHjQAnCpM=;
 b=S3NGxrZqiu/WQl8hzeIaKtzHnMQvtVtqHdMKgSbGWXXjL+2VpRSJ5s/dmku9ucmUZEVjt52gKmacYZctLM6rA3247amXjPgw3t+07dVOynfGhJRXVRw4jjTCrAm6+Eszk00IH5IJEDphAeO50km9oV+uT2yua5LfKTUruslCZ51axeQ8Ibll4cDI3Rw7JUm/4Asm5BoOkzJ2e5NWIE+kGlC6+mtueFz4LcSlOPJnERBtvsPqdU8HFw7rv+cvJ2oHrPHDgMLIfAJL4AdtN6eeGMK9WiiAAeuxxaudYWRznKJjzdTC64quEJZGxsmLrd6LFiC44Ib15GZIYSMgRGgeqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onsemi.com; dmarc=pass action=none header.from=onsemi.com;
 dkim=pass header.d=onsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onsemi.onmicrosoft.com; s=selector2-onsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBr8LeAIh46SK5BTWJb9OgWMGG3TweCz/KeHjQAnCpM=;
 b=plYfXSVk2Ye0R13ZqgIXOSDTWiivBZMqhMAdTxCfZKhr71aUMYkPN9jaKDCezlNCaxkHTSAA7t5CKNuw/sPj/56lPazrXvyv+r3KcsP3X72Vd/XomVUriHCCPkMLve2V2ZHLx58rHGMLQ+NcpPqGMdnTmUtXOkgH8M5cFEffDGQ=
Received: from BYAPR02MB5958.namprd02.prod.outlook.com (2603:10b6:a03:125::18)
 by CYYPR02MB9802.namprd02.prod.outlook.com (2603:10b6:930:c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 18:49:12 +0000
Received: from BYAPR02MB5958.namprd02.prod.outlook.com
 ([fe80::644a:cc48:bf3e:9a0b]) by BYAPR02MB5958.namprd02.prod.outlook.com
 ([fe80::644a:cc48:bf3e:9a0b%7]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 18:49:12 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>, "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "horatiu.vultur@microchip.com"
	<horatiu.vultur@microchip.com>,
        "ruanjinjie@huawei.com"
	<ruanjinjie@huawei.com>,
        "steen.hegelund@microchip.com"
	<steen.hegelund@microchip.com>,
        "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>
CC: "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        "Thorsten.Kummermehr@microchip.com" <Thorsten.Kummermehr@microchip.com>,
        Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
        "Nicolas.Ferre@microchip.com"
	<Nicolas.Ferre@microchip.com>,
        "benjamin.bigler@bernformulastudent.ch"
	<benjamin.bigler@bernformulastudent.ch>
Subject: RE: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Thread-Topic: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Thread-Index: AQHab6N+HTIqnIEDPEa/74PK5t81crFCoO6Q
Date: Thu, 21 Mar 2024 18:49:12 +0000
Message-ID: 
 <BYAPR02MB59589FFEAB8BB9578A61B39083322@BYAPR02MB5958.namprd02.prod.outlook.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-7-Parthiban.Veerasooran@microchip.com>
In-Reply-To: <20240306085017.21731-7-Parthiban.Veerasooran@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5958:EE_|CYYPR02MB9802:EE_
x-ms-office365-filtering-correlation-id: 814ffc9a-51e8-442b-79e6-08dc49d79986
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 bkaQy4Sdi935SS4HVZ6N/zfUHwoJJGRBHpv/n2DEOQhPsMXh91TmcI1YCIaBEHhPDvI0luzrdLtfzrLO/d+WIyyLzltIxylkuGS+VlggSq2LuNna5ivKlOwKTlur2bYFszswpCi95tdjkxIsswhfziLrjT0Q9J4u5csj+u6AQADQDPf/hO9ak3F4ELoLYOa9bocw954EfnEl2X1Z81utT6Qzrenxdb2R9X2WKAQlMrRSCsuDZhQaTxfgyCT0p52meq4T8aIvh7vaB/auBzkC0shtmBnBV8DCNs5vS9z2H7X9w1dwM/2y4n9nwcVL43o7kvq3mI/cYuSSSTdsQMqg39sfclohZ5Gtn+jwlJsLX7WmcrFPT0Y6i+c8d2N5QAomEVrmqd/MAHbmgH+fMkgz058Lutf8PlsJD7uz/3WL/Crfu5ZMikwbdaHsh6SrU05L/Wcd5EiLLCn5dpeHNrmD529P2Iy3AOuW5+tFPpkWqYp0+XElS6z1pMjG0Z2ZlbGKBCFbfz/ML4AdvssMBuqcISgb+39TDsBDS/dA+B5OvMRBF7IDoFFO/pd2kgAyxExCi94PjTatXqU5xW2hCXxQLQAUvhWr2B4ztWXXNV9EPwIKGrl+F1HrcL2COplzxOO/i9pIiCj7tL87/14c3K1XEFSnrVoAZBDNp6JIQuBQngOCMQ87t2hhhYn0C8MQNWXEZR+JY9NLyp/SZBg8v5s9URjAiqmsZZES4yJ6rX40RCg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5958.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eUdpeDFaTDZFaUk1d1pMdjBTYXBMSCtSUUIrcDVWakZCTk5QbXJZWTVQRmQw?=
 =?utf-8?B?T2Y3ZFNuTGdOZWpxdVFZQzVsQlpnU3VxSk1JZ0lZTFIydHBGSU1hckt6aTZ2?=
 =?utf-8?B?MHNWaC9rb2lSWXJIRmFrd0dPbXY2ZU9YUE9xWitNU3pRdk9EVnIwc2JJTDhp?=
 =?utf-8?B?OFRoWnFlbUVZRWxDTHdyRlBCSGMxZ0ZSWmtscXFHWkZTYndTMVl6REYxL0ox?=
 =?utf-8?B?TGZFRCtHNUF5Uzh2TlZKQ2VFdWF6elhiclp4eDhEaS9Ua1AvalErTEMwRTVk?=
 =?utf-8?B?YmltUjFVQjVBN3dHQllYTmNZY1FLWTUzaDFuR3FLQzUyZTBMYXluTE5FK1Vs?=
 =?utf-8?B?UHhkK2hES3l4WkRqTFhiVWJpNEJDa2haRWxEYVowUWw2V0liWVM0UXQ2djVC?=
 =?utf-8?B?QUY1ZHNRTjFWV09ySGFpeTFaZm81UCtvbHg0K2M0TjZzSjhPVHNIWkdDbCtE?=
 =?utf-8?B?ZlkwaGM1WFMzVlVpeWxzS2NHYUNEcXE2YUJ5ZjBqUytSOFYweUowOVpTQVNK?=
 =?utf-8?B?V2kvVHFULzE1MC9FSG9KdmxPalRucHVIbTlGd2lmQVBMRHA3VHpNSjJoOU9J?=
 =?utf-8?B?T2V2YWphTkU0bnZyV29RbHJ4cDNEQ3ZnUlBHbE8zSTFOdkRxTlVrV2hBNDFt?=
 =?utf-8?B?ZlB1SjV4UzZtRkFDSkJqb0U1aDd6dWtsRlN0QThRRFpRQ3R4VHRnTzlXM3R2?=
 =?utf-8?B?WXJnUE1rN1JQb0lLSzZmUzJKUGNqdlU1ckIxSHo3dXJXSW10K1JWQVdqTDhD?=
 =?utf-8?B?QXRVQ1ltN0I3U1Z1bUNCUFR0NFRsOGg3Z2M0ejRkYVdmaVFQMjZET2lKWTkr?=
 =?utf-8?B?c1gvV1ZTYml1TklFLzVmUFlwdjE3d1RvRjRFVWV2RGhTS0Z0bEFWc1paTVp2?=
 =?utf-8?B?czlJZFJvVmhaa3Y3NVpyRDhkeXV6dVhqUHhPRGVhekhsUXZNN0h0a3RWVmJR?=
 =?utf-8?B?THowUEo2TVFGL2IxMThVVUFKYytWMThFLzF3WU4zSmRraEl3aGM2REd5U2RQ?=
 =?utf-8?B?SnllenYzdkRKQnBCczBnQjJyNmNSUDFxU2hDeFBRUnNWUGJoMzFsQnFpaHYy?=
 =?utf-8?B?SmNBL3ZJM2cxL2xoNk12SisrS2pMQ1dxaDMrUE1ORjZIWHNlL3o2K3gram1h?=
 =?utf-8?B?dlNIYmFmVmRWaTVOelhGS0d4ZXkza0YwdmxpTHVEekdPR1FUR0xUUU8rMWk5?=
 =?utf-8?B?dGRuZWRFM0VmU1JCQlJ1N2hDMXowZWZhU05QWjZHdW90YWxud3JGNGJFWGdk?=
 =?utf-8?B?KzE0S0FZTjRJRGdxeElZUElhbER0VVdxQjVGa29iNHk4ZjZWYjFpanFBNWI3?=
 =?utf-8?B?ZjVvdGt5VHlvdDZoS1VsSzZ5M0lHT2VMVDY2MWxyemVjMUw5TkgweUx4bkRS?=
 =?utf-8?B?WUZtdkltcWpGMkFvaEEveDdhcXJzbm4yaFJycjN5VEFiYnNpV3VpOUFnK3Ns?=
 =?utf-8?B?QUZTUm9LOGZaQ2hVQ2RBUVUxR0w5K3FIYmZVN0ZETGMvNzZ1elNzZEo4OFRT?=
 =?utf-8?B?cWl6c3VQYmZnVGlibElmV0lZWUQzNzZIdCtYY2daZi9HQmMwMVNKY2RESWJM?=
 =?utf-8?B?elhKdW50djBkUnFaWjlHdzVTaFU0d1hrT1JyYWVRSERyMUs2b200c0srVFpr?=
 =?utf-8?B?UlV4K3l0UG9tOHZCTHEyT3FmYVA2QjB3S1psUmNqWlNhUUtqZjVndHVRWjJ0?=
 =?utf-8?B?ejJ3TUhzZVRJQXBzc1FpeWdRTjA5M3hZNER0MnN5UzMzVEozQUxpOG84dkhF?=
 =?utf-8?B?ZStjdW85aVcwdytEMmwvbEhpZUV6RUV0VjAzRE8wNHF3K3c4NUpkaFZXSkV5?=
 =?utf-8?B?MzlKUndRRDlDSGIvQXhDM09kNE93T1ptOTMzNDcxcDhjaVNRb1ZCa3UxNFFB?=
 =?utf-8?B?TENDNk0ydHBYcW5FOXZnaDFPbk4zTGxZQTFYelBPR1piY0xRbEN3d3UxeE9H?=
 =?utf-8?B?YlV2RXhuR2ZQMnIydFNDcmRPMU56ZVpjdXJBdUZqY1V1d01qZVBhVEM4eXFK?=
 =?utf-8?B?dm9kQkpvZHVJNUx0UTVXTjFOQ1hhQVZEZi9KSENScHFFUEhtSDVZODdCY3FP?=
 =?utf-8?B?TE9rdmpxTkNvaFM0WlZhZGdHRkl3cytvT3owQW5wKzNIM0Zzd1FlWWlFTEND?=
 =?utf-8?B?TzRnemVnQW9VV2hURXBaNU1Xb3RraVRwQmxQaXNSZW5ocmZ2OGRqOHpZanYz?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5958.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814ffc9a-51e8-442b-79e6-08dc49d79986
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 18:49:12.2004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L243ntzJrN+6jxfM1MKXldqWCdivxfg9g2X63AVL7/pfVNI6p/c5Wt/RQ+zFIi/5GS9zqKW9hXG05g8Z38RcCh/964zdXxvuqD4fulImWGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9802
X-Proofpoint-GUID: jxbPsb8ZVP1gusbl2JUZ8CJkgnuk4Poo
X-Proofpoint-ORIG-GUID: jxbPsb8ZVP1gusbl2JUZ8CJkgnuk4Poo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_12,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1011
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403210138

DQo+ICtzdGF0aWMgaW50IG9hX3RjNl9tZGlvYnVzX3JlZ2lzdGVyKHN0cnVjdCBvYV90YzYgKnRj
Nikgew0KPiArCWludCByZXQ7DQo+ICsNCj4gKwl0YzYtPm1kaW9idXMgPSBtZGlvYnVzX2FsbG9j
KCk7DQo+ICsJaWYgKCF0YzYtPm1kaW9idXMpIHsNCj4gKwkJbmV0ZGV2X2Vycih0YzYtPm5ldGRl
diwgIk1ESU8gYnVzIGFsbG9jIGZhaWxlZFxuIik7DQo+ICsJCXJldHVybiAtRU5PREVWOw0KPiAr
CX0NCg0KU2hvdWxkbid0IGl0IGJlIGFwcHJvcHJpYXRlIHRvIHJldHVybiAtRU5PTUVNIGhlcmU/
DQoNCj4gKw0KPiArCXRjNi0+bWRpb2J1cy0+cHJpdiA9IHRjNjsNCj4gKwl0YzYtPm1kaW9idXMt
PnJlYWQgPSBvYV90YzZfbWRpb2J1c19kaXJlY3RfcmVhZDsNCj4gKwl0YzYtPm1kaW9idXMtPndy
aXRlID0gb2FfdGM2X21kaW9idXNfZGlyZWN0X3dyaXRlOw0KPiArCXRjNi0+bWRpb2J1cy0+bmFt
ZSA9ICJvYS10YzYtbWRpb2J1cyI7DQo+ICsJdGM2LT5tZGlvYnVzLT5wYXJlbnQgPSB0YzYtPmRl
djsNCj4gKw0KDQo=

