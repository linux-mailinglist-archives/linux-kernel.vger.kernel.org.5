Return-Path: <linux-kernel+bounces-31469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C39832EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3422C286C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7125645B;
	Fri, 19 Jan 2024 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="osYqAFfk";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S7Cxf6ye"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B8C5644C;
	Fri, 19 Jan 2024 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688393; cv=fail; b=A1goOISuMFXPxvgyBqs6lAuru7KFzn06mYyZ03mgwNWSvp/uUP/CowWd4sHRElKEntL5NF3zwjwJ27HjqjPqK04H+W1nVe3T/lvo8VohxH2kW/lzm9/uA9JzmcY9odpYqXyhksopqGBw9IkTwwhqKohEQcrpRwXU0eazO3Ur7EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688393; c=relaxed/simple;
	bh=cU+eaSTfNCVq/q6uAbcQycnf9Co4CHtUVepBekkV3KM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ShOLvWhZ+a55pDj2YMfEF4qXMqkVofXbOgM/krn5G6IDI6uMBbEf/ccGZC/BkzZyT08LXCJcVrMC/3dSYB6fe7uMFpdyprA3Wyn2M6BUt93bcMQrcywQpjboyS9zkj2uldpg3hzpaPVd76PTGpscYAtOH36XgtflGGkTyJsSzWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=osYqAFfk; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S7Cxf6ye; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705688391; x=1737224391;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cU+eaSTfNCVq/q6uAbcQycnf9Co4CHtUVepBekkV3KM=;
  b=osYqAFfk9N4+aszgGBHaaLSYvnNX7eszAYAMuaZX4rmftm/cQLUbNJc0
   vjdy1n3HIQL77OKa3Cbuqa21zG10FU1n0blutiWKWyjFaN4DhthF+eaP0
   3ZeGwE573jPckY+J5MS/CQnGiSzhTxnD4Oq5R5xlclH2T3qSMGwmjvD8M
   SLPHAjbAUep+74lhKuHmEVkRyzKmYRfZcPxZFoGkH9lefAs+0Kuv4PAO3
   cg6rnTR+NU7gWf7Z6oq07zc12V5tCxQnRdziK7et9J5FpJ+19O7enGzEF
   k90udXpgmS9oTl6iuAX1le5wpH7l4xTWEURklMHjCbsRnvVhsrCzCWKL8
   Q==;
X-CSE-ConnectionGUID: rF+Mr8T5R8GWwbJug/OE+A==
X-CSE-MsgGUID: AW/pnnseRhOOmGuV4Zem5w==
X-IronPort-AV: E=Sophos;i="6.05,204,1701154800"; 
   d="scan'208";a="182250030"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jan 2024 11:19:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 11:19:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 11:19:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vs2EH3Z0bNIUHi520NAKSwfZGPtNmawR6xvdN0+srz6A7eRja5bAUJEGKSW1TRFUAojsHHfq82oVpfUfYpBeWKC67kiLTpbCvpJkqJTx6L471C6j+APNrBBjHVUuJrXIokSe9ERLjl+wRp/po/l4H4bWYz/4rmj+W232vasljeo4NWHfm6+06r81Gn7CF8IsUxZ7qDN1m4ICTRjFV7QzRZkJvI8FdmcYVnan48g1sJzhqVxQFaRHYc5ta6kVPcCMEmFH+odWrnMXhVlrTYktoEXH3SX7/p77+7NrmcmnurUQcz+t2UbHyywJeZezvHrf5mTS07dQaGQaz4HJ0Yttmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU+eaSTfNCVq/q6uAbcQycnf9Co4CHtUVepBekkV3KM=;
 b=l3ZIr6+SgsJ360ySxtdZJlYweD+u3gXuxsOAJzigVIxn9A8YdpxPoq5G4t45TcBNSSKhsjZLpJqdatCaMRnSt9ybr6oF/xGFMb9nx1hRD1XE6mWrQe4/ohO6R6Z/WV0+DI6tbY1yTscBojE0dQtDd20n43rcvzDr79EmCOC8ojWFZ9JsXQS5MBe8EZ+zdvuKiwRLEJtObAxPgn+T9NTH0u9C/Nf9gSWgM5b4/eaRpZIOo4KbacxPMm1p3h3/Jqj6xmiG1VBz14QZgMXXOUEDshHKAAHcxUvGtaNWAI+Kk5eFvRX3+Kp5dyrAixUH0Ic1kTStxDzS0VVl1AblX8Fv1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU+eaSTfNCVq/q6uAbcQycnf9Co4CHtUVepBekkV3KM=;
 b=S7Cxf6ye6qexr6EF2/OsUDupK7Wyv1mDqPCsqJGEfaMqXu3UzO26uDjCX/mW6GM3ko9VuM2dc8TSl3ENbhA+Ff+7322iCqo/Uf4MiQnVP60keuIMX//hF7udrIO0yMQtLklz+302da6GRDWI3Bp3Igi9AJnbRRuAz49wLvKotZNPNN/CMcaJmLjVnDynSVluSWz01oAathC9GgWzglqQpDVPSaNPsn74H9tiMP3z8/dNsZH3VGDapjGvMVa3zZb4wF/vUSkoRkbWdV1QPond6zVmtUTe3uyReJ963Ubfr9YENCyi2YzTn/UzvAoxyLWMTQkwlfE1aYBbxHXcg+/HTA==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 18:19:44 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8%7]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 18:19:43 +0000
From: <Ajay.Kathat@microchip.com>
To: <alexis.lothore@bootlin.com>, <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <claudiu.beznea@tuxon.dev>,
	<davidm@egauge.net>, <thomas.petazzoni@bootlin.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] wifi: wilc1000: set preamble size to auto as default
 in wilc_init_fw_config()
Thread-Topic: [PATCH 1/5] wifi: wilc1000: set preamble size to auto as default
 in wilc_init_fw_config()
Thread-Index: AQHaR8N1F/E9+Yo0nE2y0lDjNrL3d7DfUqEAgABeLICAABz/AIAA+QwAgACxxQA=
Date: Fri, 19 Jan 2024 18:19:43 +0000
Message-ID: <2a7cdcb3-03ef-46b8-8cda-e5d28801f6a0@microchip.com>
References: <20240115-wilc_1000_fixes-v1-1-54d29463a738@bootlin.com>
 <170557027237.2797779.2354857290141885659.kvalo@kernel.org>
 <000e823e-ede1-408b-b8e1-fd9c1c73fd6e@bootlin.com>
 <5c5e1332-39de-4d6b-9646-661c78cee900@microchip.com>
 <b215909e-43c7-47b5-ac0b-2a194b55cb39@bootlin.com>
In-Reply-To: <b215909e-43c7-47b5-ac0b-2a194b55cb39@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|DM4PR11MB6192:EE_
x-ms-office365-filtering-correlation-id: 14164bf9-23ae-4006-7c57-08dc191b35d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0CjdXyEf3XeSup8lUrdFZB7yspToxALGFtIuYKUcsOAyBkmrwkWwWJUBKI1nKc2+lumJoSzlO/kJe9ObrJjj5k3htFMYAbwtGav9GyMwXnQ62sTFpV3llP20+9FFc68iQn1+HuL40ayPNNBnStVsszDU8PZ+BJwwdGnFXLOUuUqyewlzqobaaL/AQWniIzJU+6AGkIhLAfRNac2ISkPPa/f1BpdZFL2eBISlVtN41GWavKgcO6b8UM88sMpjsWprAFvCVhg3Mw5ZuvuFwZ6K+IEewHdbI3UIkmNF8YfdJHmPMsuQBmMG+PSMV6U6L30+ZOHBJNexaYPkPLN/DXuX3Hx7laBxrFo4nXPK7jifmTgFH3ZSO6aNFRX2WUdW7ExwX9vh7udjQrw+mKz/nV93QEeO+79s2MXDe8KqMF9qfqeZ7HZNXfrMwc+F5aqD8fURKYgEDDsJboMaAFZun/Oopbv1sgH/KQt3fuMwJFD9wlKE/GCfBNy5RTTSKI/t+L3wvNk+0E90uP6MIaCCA+1Qp4Iq9AqT5P3ze67CruHOqq4hI72uM/9ZilcUScKF6n7YD9HwhPmOb8vuL4WtGB2QSMHyvj+dZFGANsshytIfYoCs+3Id6ppLfi0q7KPIU7VLM9JI7bJJUTdNjJwbv8HODAV3yrhl64gb89H+pVEZhjdksLImdwq7Kw+TPpYxyuR1lqwaPwGTXAaufOXzCTDdAGjpmnayFwmDNIBTt/fHU60=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(1800799012)(64100799003)(26005)(53546011)(478600001)(2616005)(71200400001)(6486002)(6506007)(6512007)(83380400001)(5660300002)(2906002)(41300700001)(316002)(66946007)(66556008)(76116006)(66476007)(66446008)(64756008)(91956017)(110136005)(54906003)(4326008)(8936002)(8676002)(38070700009)(38100700002)(86362001)(122000001)(36756003)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3hSV2orN2c5bjZiMENyUTlLZCtnWUlzQ044dWw1ZFVvV0YwejdZcVdHNnZk?=
 =?utf-8?B?eWxiRWFtVUpkT25mSkIwK01odVdjZTNVV3BKUGRiWnlUVzNVL0JDRzcyY2t3?=
 =?utf-8?B?MkVCYTlhOFk5OEZObElvUEdBa29jMTdGeW9Kd1NrN21uNjlpQ04vNVZwMXlx?=
 =?utf-8?B?ajB1eE45bkxZdnErNWRhY1l0ZFZjZG5JbVBzZ3k2VEVTSzJ2aGNUZDBtRkV4?=
 =?utf-8?B?REpxVXE0UXlNZ01DM1ovKzJyNEQwQlE3MWwvQk1UWjAyVDhRNE5HdU0zYi9i?=
 =?utf-8?B?dG5VTFVONU5ESmw0QnZxV0d5VzNsaU1pNEZYOGlRL1hEYTV3ZW9KbjlhUlE0?=
 =?utf-8?B?R0piL0Ric215emZST3JVNHNackhrOWEvZmNrVTI0czFyYjNERXNBZ1lpRTRa?=
 =?utf-8?B?WWxOd0NaazFocnRrZ3FOOGovTkUydlNlVmJMckYxaEJkQjlleGErdTY1RXlV?=
 =?utf-8?B?Y3QrdStrREhHNThHYnJ1bjJrY2o0NkVNNTVSeit4V1I2Q3FSdmpxRjk4M0Yx?=
 =?utf-8?B?MGttaUIvWldUcmNxZWozTlRRTXRrcERiekhCU1FXMU1BR3A1eGtoQWxwYVRn?=
 =?utf-8?B?ZERZT3dYYjFhK1pPNmt6NzJHemwxWk05N0drNUQwMWVJSG5IT2JKQjdpWWlw?=
 =?utf-8?B?OHBIUXF0ZzFWTWxQVzM5bk5zeWhXcVBscjF2UjVseXM1NUJwQXRwWHlhb0Rn?=
 =?utf-8?B?dzlHQnRwUXFBV3RZYkNJUEsrREEyQmNiTHJQamU0dG1UYzUySWZaY1E2cndI?=
 =?utf-8?B?OUlNSnlmN2ZNd2pnUnIyRi9BMXZtc2h3bjBUNklUQ0FReHN6UXpXaEE4WGp1?=
 =?utf-8?B?Ui9SMWR1VVhEVm5pdjlycFBaU0JzdXh3STBkeDVHMXZjMmFIRGlZWW9Dc0Qv?=
 =?utf-8?B?RS94RlpqaC9HSXZiWEliVUZSdElRdC90azFBUm1YSzlpQ1BxbGJyd1A5c0hC?=
 =?utf-8?B?a3dXNzZVYUYyazZpTmZ3b1hkSWFHK0drRW5OYlZ1UVl3OVV4YmNTMXluTlFN?=
 =?utf-8?B?NkRGQ1ZVMEJYSnlqMkQ5a2hraG1SN1c0WTkybnJSa095RHJ4Y1U5ZEtJVXo1?=
 =?utf-8?B?VXFtN29XQ2FVZzJQV1ZEd0ZNMkNxbVh5Mk5kQUc4VDFacmw5cWJKSEQ4S0JF?=
 =?utf-8?B?WGd0WU5QVndzQStLMFk5TmhKRmR3NEFOa0phNExSN3Y2akZxSFp4Y1FWZ0hS?=
 =?utf-8?B?aGJWYVhjMWgyd0o5bFh5VkJ6Q3AvUDIyZGd2WU53YWlaT3JUWXFJNW9BY2RD?=
 =?utf-8?B?NUpSUE95VVFiRDZkcldjWXZ6dmtseGZFcDAwckczM0VjNzErYUdvRGgwWDAy?=
 =?utf-8?B?akIwL3puZHlUTWVJZWNNZkszeWhRa1RmdjhtSkFzTk9kSTFDVkFQWCtqUVVj?=
 =?utf-8?B?WTgwbllUOXluVnR5azVjem5MN2MrNU5jbUZWWkNvM3pYNjlTM1pLMnh4YVda?=
 =?utf-8?B?dUFpQWVUK0Zkd2krdW5vRGYxNGtmRWlzM3dkNVVFSm43V1cyVFpLbFpSRWlO?=
 =?utf-8?B?YXpXYVhySDlwVXVHQStMdXF4S2Z1eDdvL3I1UmtTSEx5Yi9GaDBpTndVQktr?=
 =?utf-8?B?UXZHWXRHVmpEOGVCNTlrMjNHandqMjVRTGlJUFhIMy9UTzdqdlgzdWFmellY?=
 =?utf-8?B?a0phcm93UEtiK3JoRkJ4NWdCaEFjOW90ZlFRL2Y4ZmJVSXFPdnBzTk1saEhB?=
 =?utf-8?B?clF3TXhYeUF0Q0RadFRNRzhKbUZKdmRvdTR0bEl4Z1hoWXJYTklnOWpna0t0?=
 =?utf-8?B?STI1cHNjOVZ3ZTV3U29tcEhHV3Y3MS94T3B3c2pOLytlT2pQMmVvREZVeHlo?=
 =?utf-8?B?WGo2aVBPYTRGQXFjNjRYYlR1V0lRdlF6aHUzbzVQZW5JZ0lncDh4aG5mZjhH?=
 =?utf-8?B?UHFoTUNZaVZ1NFJxSmdKUVNnTkJTalg1NERnNytZVWVhR0tyNkZPMHdYRlZW?=
 =?utf-8?B?cGRTcjBVbXRZVk9xY25xYVhac2hhOWo5U29mZStVSWhZcXJxeEVnTVNjaldE?=
 =?utf-8?B?V3MwTTNlUXpna0xyOXF5RC9TU0puaWxxb3ZIcjM5RURNazd2Vlg3ZUhudzIr?=
 =?utf-8?B?dCtyQ3pWMVcyZzBPZXNpa2hHSzN4SkpiZFJBOWtzbnJDNmd4a1pHeGl3S2Ry?=
 =?utf-8?Q?/bPjADvPmiEyk8VInmkyYMlLW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5105D3C90C4CEA43910DE9B68B28135D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14164bf9-23ae-4006-7c57-08dc191b35d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 18:19:43.7789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a4D5AMcH3sh6OxIQsGkViifDrg/u3UOaD6hU9aDJNQKSXcPH/oVbGsN2/Z5hlyl+i+vs4Xbh3c+cRY9iEWkUXwyjEmQK+ulYYnDSALYxCe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192

SGkgQWxleGlzLA0KDQpPbiAxLzE5LzI0IDAwOjQzLCBBbGV4aXMgTG90aG9yw6kgd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMS8xOC8yNCAxNzo1
MiwgQWpheS5LYXRoYXRAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDEvMTgvMjQgMDg6MDgs
IEFsZXhpcyBMb3Rob3LDqSB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPj4+ICJXSUxDIGRyaXZl
ciBjdXJyZW50bHkgYXBwbGllcyBzb21lIGRlZmF1bHQgY29uZmlndXJhdGlvbiB3aGVuZXZlciB0
aGUgZmlybXdhcmUNCj4+PiBpcyBpbml0aWFsaXplZCwgYW5kIHNldHMgdGhlIGRlZmF1bHQgcHJl
YW1ibGUgc2l6ZSB0byBzaG9ydC4gSG93ZXZlciwgZGVzcGl0ZQ0KPj4+IHRoaXMgcGFzc2VkIG9w
dGlvbiwgZmlybXdhcmUgaXMgYWxzbyBhYmxlIHRvIHN1Y2Nlc3NmdWxseSBjb25uZWN0IHRvIGFj
Y2Vzcw0KPj4+IHBvaW50cyBvbmx5IHVzaW5nIGxvbmcgcHJlYW1ibGUsIHNvIHRoaXMgc2V0dGlu
ZyBkb2VzIG5vdCByZWFsbHkgZW5mb3JjZSBzaG9ydA0KPj4+IHByZWFtYmxlcyBhbmQgaXMgbWlz
bGVhZGluZyByZWdhcmRpbmcgYXBwbGllZCBjb25maWd1cmF0aW9uLg0KPj4+DQo+Pj4gVXBkYXRl
IGRlZmF1bHQgY29uZmlndXJhdGlvbiBhbmQgbWFrZSBpdCBtYXRjaCB0aGUgZmlybXdhcmUgYmVo
YXZpb3IgYnkgcGFzc2luZw0KPj4+IHRoZSBleGlzdGluZyBXSUxDX0ZXX1BSRUFNQkxFX0FVVE8g
dmFsdWUgKDIgaW5zdGVhZCBvZiAwKS4gVGhlIHVwZGF0ZWQgc2V0dGluZw0KPj4+IGRvZXMgbm90
IHJlYWxseSBhbHRlciBmaXJtd2FyZSBiZWhhdmlvciBzaW5jZSBpdCBpcyBzdGlsbCBjYXBhYmxl
IHRvIGNvbm5lY3QgdG8NCj4+PiBib3RoIHNob3J0IHByZWFtYmxlIGFuZCBsb25nIHByZWFtYmxl
IGFjY2VzcyBwb2ludHMsIGJ1dCBhdCBsaXN0IHRoZSBzZXR0aW5nIG5vdw0KPj4+IGV4cHJlc3Nl
cyBmb3IgcmVhbCB0aGUgY29ycmVzcG9uZGluZyBmaXJtd2FyZSBiZWhhdmlvciINCj4+Pg0KPj4+
IFRvIGdpdmUgYSBiaXQgb2YgY29udGV4dCBhcm91bmQgdGhpcyBvbmU6IEkgZG8gbm90IGhhdmUg
YWNjZXNzIHRvIHRoZSBmaXJtd2FyZQ0KPj4+IGludGVybmFscywgSSBqdXN0IHRvb2sgdGhlIHBh
dGNoIGZyb20gQWpheSBhbmQgSSBtZXJlbHkgZGlkIHNvbWUgdGVzdHMgYXJvdW5kIGl0DQo+Pj4g
d2l0aCBtdWx0aXBsZSBBUHMgKGJhc2ljYWxseSwgbWFraW5nIGEgV0lMQyBTVEEgY29ubmVjdCBh
bmQgcGluZyB0aGUgQVApLCBhbmQNCj4+PiBlbnN1cmVkIHdpdGggd2lyZXNoYXJrIHRvIGdldCBh
dCBsZWFzdCBvbmUgQVAgYmUgcmVhbGx5ICJsb2NrZWQiIHdpdGggbG9uZw0KPj4+IHByZWFtYmxl
LCB3aXRoIFdJTEMgbWFuYWdpbmcgdG8gY29ubmVjdCB0byBpdC4NCj4+Pg0KPj4NCj4+IEhlcmUg
YXJlIHNvbWUgbW9yZSBkZXRhaWxzIGFib3V0IHRoaXMgY2hhbmdlLiBJdCBoYXZlIGJlZW4gaW1w
bGVtZW50ZWQNCj4+IHRvIGFkZHJlc3MgdGhlIHRyYW5zbWlzc2lvbihUeCkgYmxhY2tvdXQgaXNz
dWUgb2JzZXJ2ZWQgaW4gdGhlIDgwMi4xMWINCj4+IG1vZGUuIFRoZSBtb2RpZmljYXRpb24gaGFz
IG5vIGltcGFjdCBvbiB0aGUgb3RoZXIgbW9kZXMsIHdoaWNoIHdpbGwNCj4+IGNvbnRpbnVlIHRv
IHdvcmsgYXMgdGhleSBkaWQgaW4gdGhlIHByZXZpb3VzIGltcGxlbWVudGF0aW9uLiBUaGlzIGNo
YW5nZQ0KPj4gd2lsbCBhbGxvdyB0aGUgODAyLjExYiB0cmFuc21pc3Npb24oMiwgNS41LCAxMU1i
cHMpIHRvIHVzZSBsb25nIHByZWFtYmxlLg0KPiANCj4gQWgsIHNvIGl0IGZpeGVzIGEgc3BlY2lm
aWMgYnVnIChhbmQgbWFrZXMgcGFydHMgb2YgbXkgc3VnZ2VzdGVkIGRlc2NyaXB0aW9uDQo+IHdy
b25nKS4gSGFzIHRoZXJlIGJlZW4gYW55IHJlcG9ydCBhYm91dCB0aGlzICJUWCBibGFja291dCBp
c3N1ZSIgb24gdGhlIG1haWxpbmcNCj4gbGlzdHMgPyBJZiBzbywgd2UgY291bGQgZW5yaWNoIHRo
ZSBtZXNzYWdlIHdpdGggc29tZSBkZXRhaWxzIGZyb20gdGhlIHJlcG9ydCBhbmQNCj4gYWRkIHNv
bWUgbWlzc2luZyBSZXBvcnRlZC1CeS9GaXhlcy9DbG9zZXMgdGFncy4NCj4gDQoNCkZvciB0aGlz
IGlzc3VlLCB0aGVyZSBhcmUgbm8gZGV0YWlscyBvbiB0aGUgbWFpbGluZyBsaXN0cy4gSXQgd2Fz
DQpkaXNjb3ZlcmVkIGJ5IGludGVybmFsIFFBIHRlYW0uDQoNClJlZ2FyZHMsDQpBamF5DQo=

