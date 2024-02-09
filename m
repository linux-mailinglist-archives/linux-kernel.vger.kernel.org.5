Return-Path: <linux-kernel+bounces-59148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB9284F21E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFB61F29485
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D647664D3;
	Fri,  9 Feb 2024 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DyqXEgop";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="22zeL0hU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B525A664BC;
	Fri,  9 Feb 2024 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470212; cv=fail; b=Luy+rZtRPz+dgakyzgShZcqrCovsgfqA4LN4QRYWO5Fn44W0Mg/y0dMKN3WcFgPPHbVehdbIVNklb9fPV4GYa4lz9vZoDqNfF65ipy7LHUK5FyXbVY5gZRVBS3d+UKLIhsgNeWURwLOxJNvREUOxm3SdkcBzV+i8w0TX5LIJ9HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470212; c=relaxed/simple;
	bh=PsvUpEK7NNcZSaPLQjmbqY2Wif+FySXDW7BnARDVpqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NXneVyEg22dC5vBXk9xp4v0yEUyyjw1q56HKgHz751MsChJT+mn129qogKSfhOYIFwU/BD2KUQp23YaqsACiA76DCrNfkipo/SN03xF/sLhnaWZ2qA+V0KM9Wck+3iL+2Om32yKeQVush+Uvqe8IbwOECYK59YzK5gvaPfduKMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DyqXEgop; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=22zeL0hU; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707470210; x=1739006210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PsvUpEK7NNcZSaPLQjmbqY2Wif+FySXDW7BnARDVpqU=;
  b=DyqXEgopwYYcxnFoDB2sWYDOBv+h092ecatyc3J0ZZCVO9uN6gXTmeyb
   oQwWdc6JbOzNkZTih39fKKFe3ET4jrsI2kzcfuH50BTrqMRjRp5+6TMlZ
   ytirf4cGjuJUMxRj4ZgJhglWptvcbv1sNjIx+ZHxTsf1Ot5oZb973Gl2+
   f+v+LVHbMjDnE+5EMhN5gA7piyPdQb8T5V+8AIoaFRdEbHa4+/b+SS68J
   wnYbC6N6w+waE98qahKY6pxvD9zNfJW+UN3VFVQRnd6N56ETBQnQ2HHun
   wuy8P5YvqF0EjJxR0sUdHFv8czBqzLeqSoexfn8BSjcCjcfOdUepzXXu2
   A==;
X-CSE-ConnectionGUID: vpwJvwgNRI+AUfxWalXOQw==
X-CSE-MsgGUID: HREc7+w2QAyu2lew5pmSXg==
X-IronPort-AV: E=Sophos;i="6.05,256,1701154800"; 
   d="scan'208";a="17414093"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2024 02:16:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 02:16:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 02:16:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSosRHQxgdAJpfgd7Vv4hsJ5qDGccDkkRUm8A23EUfzRsMLIvrNYdeVAgxIAXOdpXu6OKdQ72GDBCqyfrXcgnpBAyB7g4Lejbdhwu3QTRSFr/c/yo0l+rbkyI/wNCT7BYMEo8Yo8iarTquzwaOWrL6BD6iamYsukzbopyotHK8LsnUyXkPvaxd4w0XffcJ7Yd866+IXYdmvfOjs5VDG2GpHQWlQd4MIsaBytNAQEsHBLqpQP+3wl0gj6xqk3Jhu+1i4VAeDN06IlXN0AujhNc4gbMi/Uy0UNC2jljMAGDToHZ+Nj7pIh4s6v8K5Y9CW85JMOvC82FBD3rkXHxUGXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsvUpEK7NNcZSaPLQjmbqY2Wif+FySXDW7BnARDVpqU=;
 b=H/NKPjP8+6kJ6N4+e7/goyWk4eIx+G/G60/sIJo5d8wvNzDXH+5NuKlFkLI4y/dr0ZXFt5zQSpb9R6OpjFkwdh0wKN/S6og5GrXX7l3OWhTAFz47IruhyuScRw4EliAlTFQFkpOo/jIfJOTJvk8xDtS+7iKQz+1tnWsNNbIP7PRXLhPjQcVRUHKvl3TyLmXMnD5aSzEouDuBxaAvMdBQZaZV32WnBo4y0DM03ZpQv19uMKMLfbgUf/9ObGmFEPHpuA0JuV/2o+ttH/RrdWifPbmOd8xZ6hOBBovGz3DWW6VeLdM8qOXmtd+K03YYYqg99LNQCO+/JoMYflrPWsfk+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsvUpEK7NNcZSaPLQjmbqY2Wif+FySXDW7BnARDVpqU=;
 b=22zeL0hUgXe6R+m1fmMS4nYVImY+teOkm17zVvCbYVPBzRGJ/oSx0KGtFy+zxLbmcC4WBwiyODK3k/sOwg6a/ifgiL0/FD/7ZS56q+PBHLD+eP2/BGgwl+0vFmaXJ0zbDr6+2i/TiQnWXD3sOFXX4nVcCU9pdpWL2TLuuA9PDmNLddJyOsHmv3ovFzBI5f0v9E0eMq/frSMX2NodAn3nxVOmXCK2gOuAfnjO11+Ycsj7YI93qW/SSKRyQhYrBxjK+jwyiVpaMgSI/e9FqB/M/LDf0KYVs3zcyFHQUBPNO/bpAGJScPBbS3qJT79Hbo1KpYW5orzz/NRPg/NvqFCnAw==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by CH3PR11MB8659.namprd11.prod.outlook.com (2603:10b6:610:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Fri, 9 Feb
 2024 09:16:19 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee%3]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 09:16:18 +0000
From: <Dharma.B@microchip.com>
To: <robh@kernel.org>
CC: <conor@kernel.org>, <alexandre.belloni@bootlin.com>,
	<conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
	<Nicolas.Ferre@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert Atmel AIC to
 json-schema
Thread-Topic: [PATCH] dt-bindings: interrupt-controller: Convert Atmel AIC to
 json-schema
Thread-Index: AQHaWnAMbpa2jba9NEOaeGq/acSuiLEAmH6AgAAxpQCAAMQmgIAALJsAgAABggA=
Date: Fri, 9 Feb 2024 09:16:18 +0000
Message-ID: <e8ad01fd-8ec0-42c9-bfdf-b1c80467371f@microchip.com>
References: <20240208092015.263210-1-dharma.b@microchip.com>
 <170740748922.3230402.17318224112819715619.robh@kernel.org>
 <20240208-acuteness-visible-b60cd37c2b32@spud>
 <8dcae60c-1aba-4e76-99cd-de78c2c4ba6a@microchip.com>
 <20240209091054.GA3291998-robh@kernel.org>
In-Reply-To: <20240209091054.GA3291998-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|CH3PR11MB8659:EE_
x-ms-office365-filtering-correlation-id: d9b0eb1a-aa4c-4d1f-e7cb-08dc294fc67b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y8ytWk0ElsSBzftYvnaw24RJ2Rj2/Y1h7LT1w3IsuEuhE21n9dYtFprKEnUYaLIuniRDRX5mMmjEmUwxWTIAHKwz65W5+oDGeP8ZW+oFMo5gvrfYpLK5E8yQpiUWifZ8wt4/OFOGmgrg5El7WXkoHbMGhvmP/QuUM2nsOWfmPl1SWjXQHdpzk0UDbdZCSkxCw/9ToqhrYBwdzBMlN1bSXpbWbWSjiqgk16kIDotlg+rtG/0CkawB7Xcg2KtY2a9sF7bvxzRfN6SXgMK7m+jdnZexKSMwlR+tLNyaAzBj30xWfhLU+mIH3DeWvC58MVh0v1MqN/ygu2yN5RAQhuBXt7wS/MY7pKOlzcQormyWPq/9hSrlSkSFa0wFhf4IOYKlWWsarMcI4w1a2PygL/ih0vZjvVvj4gEkuMQB2seMtAZSmImxAQDarXl+ImiZ3zfFMbMhucYAyULXa/Mi8ImEfWa5MaHkIAxkSkBMKn5J1eROUmsOSzRwrd4n3WxvWZQ+s5tLCFh3NiU+yiZN4pqhYEf5tF0eUXDMB8cTwar7K6XkUEE/J0DpM6pUjPdLjI+uJg89YajSuKiwei89B1oLo0v2bqFFM1VGbeI2/SUaEdZwUIVZMGI4pzwTBvaSlI2+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(230922051799003)(230273577357003)(1800799012)(64100799003)(451199024)(186009)(36756003)(2906002)(5660300002)(7416002)(41300700001)(83380400001)(2616005)(122000001)(38100700002)(316002)(64756008)(6916009)(6512007)(54906003)(66946007)(76116006)(66446008)(66556008)(8936002)(86362001)(66476007)(31696002)(4326008)(53546011)(91956017)(26005)(6506007)(478600001)(71200400001)(6486002)(38070700009)(8676002)(31686004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEZHbmdISGFCbWpyZ3FiSTl6OFN5cndubFFsWExIWlFodUpralg3c2FndVVN?=
 =?utf-8?B?cHFzdWF2TDVjL2FPQ2U2MDhUT3dkQWtKOTFQZ3BzUXJKWkJydnFJdldnWTBT?=
 =?utf-8?B?bm8wTDI2enZrUHhibXVVVGxxRUh5M29aUFdNR2k0NDNSdUJXK1VZaDVYRnBv?=
 =?utf-8?B?dldCeERVZW1uUndwRjZPNTU3ZW12K3pPSkszT2h0cmV4Y2phWjRCekIzVnRk?=
 =?utf-8?B?emtrcFA3ZlkvSkNBV0FuZjZZVkd3SS90SG94ZlFLOXQ1ZVdhTXlRWFVxMitk?=
 =?utf-8?B?L05IQ3Z3QWNGZmdUUlZQeVpkUUFsMzhMMFpVUkg3enNlZDU0T1hWaGV3T29Z?=
 =?utf-8?B?TE1HNXNkS2xxUDVGQWNPelBzNFFDSmkwR0xMSkgvd2RkaWlDT1RnU2lTekcr?=
 =?utf-8?B?Und1dG51WGFjQmZHTjFJbTN1WW4wZGxxYXZxU3NpcXVIYzI1ZUVjbGFEc1Fk?=
 =?utf-8?B?dzVMck4ydnl3Q3ZqYWczbmx1UG9YYVVKLytJREVENVVBTTg2bExpTWtvSCtT?=
 =?utf-8?B?SGEwQ2ZxRmFSd0NiVmdIOEYyWVl1M01LcE95YVAxSDJhSHB0MjFFOVNkOTdI?=
 =?utf-8?B?K0x3WDU0cHBRWDUwTnFzNHIwZUhFa040NmNDQnIzMFFSVjN0R2ErWEttZGVj?=
 =?utf-8?B?WGdpL2N2M1F2NlJQNHFMTS9SV1ZBdVI0b1UxQ1ZMeFY0U0JacnBPODRIdFVX?=
 =?utf-8?B?YndVNStTVi9zU0VNbktLelNmYTZnTDhYYi9QeWFaRTN4bVlxYllKMmtoYVdI?=
 =?utf-8?B?SnNtZndJTWlMZkViblNOUnBUYzNRaEtkTWZra3NSVTZscXFuRVB4NDdBMEJN?=
 =?utf-8?B?engzZ0JwVkIwZlpMMzVSa01lSVpRendpVWFwVGF4RDZpMTI4bk9XTm5CbmlJ?=
 =?utf-8?B?UThUY3RDbEtXV1hwdW1mSWNIZnJGNHNMS01mK0FMSWg3VkhPeThWQkRLUGZJ?=
 =?utf-8?B?Witiako5TW51b0xHT1ptQ2JBaWVaVy9OT3RIZnhRUGFEbXBMSU8xOXR5U1px?=
 =?utf-8?B?dEY3WGdkeVR1ZVlMK2cydXl3OUsvTFJLUVJ0eFpMNUdhWTNhaUtPZ1cwZ3hO?=
 =?utf-8?B?TnQzQ05xcXRUdXphVnJsU2tYREU5eUhDamNoQjRXb2Z2R05CZkoyTkxWRGEv?=
 =?utf-8?B?eUlKYzRDOGRGeXp6Ky9rbzhLcGI2N1FRMnd4UTcrMTdpVDkwM3lYZVpFS1Jn?=
 =?utf-8?B?OFBoZG5RdVlLcXp5UE9EdmF6Q2QxTnZhRjR2SEU2ZmxDRDhIbmZoalkrWGM3?=
 =?utf-8?B?YWQvYUFINkE0UmdpTnNvakVGUHBMUzdMRWYrWFphRDhzOEgyL25YYkV6cUEr?=
 =?utf-8?B?bmZVKzJPeml1NFpJM2R2c1YyQllSNU50MVlhby90MytLVDVRcWlocjF4R2JZ?=
 =?utf-8?B?ZWNQNXFBcHhTTGdNVUNUZzR5U29OMGwxVEJ5RmVLS1hMTCtLL1B4VmdRbGkx?=
 =?utf-8?B?SlpZYy82cmxHa2hHQ2tMRzRqRHZ3LzBlbzRubHVicnFQZjVHMmZsTmE1VFpY?=
 =?utf-8?B?aGFaNDAvYW1BUmZpcFg2UFozektiZ3preEhhZVpIZmxxUHZFdXlUOUJMdWFV?=
 =?utf-8?B?WHdVSDdJbDlnSjJGUmR2UFlRL2ZSOHQ0L2ZNZXlpcWlvZndSeW9yTDMvN3A1?=
 =?utf-8?B?QmJDd29jbWFrRjdjT1hWR0VjRExkY0pTS2FtNUZ2MkE0UzVGSkF3bU4rN0xB?=
 =?utf-8?B?RkNZMG9FbzlJc3JOSWt1TVdGWjVYOWN4Y3NpL1lHNSs2YjY3RVJvMW16RlZP?=
 =?utf-8?B?S2RpeWk1MU1nVEp5dGdoUFB6d0FSVUJhcWpUZE5WZE1mNVkxZEFNYzlTbld3?=
 =?utf-8?B?Rk51MnBWQkpRa0Q1S0Z3dmNLQkQzc2Jua3VtT285dFA4Q3VUUlRyNWhKL2Zu?=
 =?utf-8?B?bHdqcHFGVHhaREdzakVBQzRFYmdwZDdQTGN0bmtrbjlpOG1GTkdqMmNoeTVR?=
 =?utf-8?B?V1c4eDBWcnJVSjJOYjZzei9yK3pVMmJHSHZycE9CTWNUdnVUMVNKYnFjRitv?=
 =?utf-8?B?a0JYNFdETGpSYmtCWmZ0QUZGYTFVRWVHNG1rY0RQNEJ3WFIrMENsVEN4WkpG?=
 =?utf-8?B?dXNQajRVNDgwVWN2U0JqejBxalNid2dsakkrSGZQenBQWWJBNXA0WG9Rbkls?=
 =?utf-8?Q?8JZFoH164l7avlYyKF3o48Oud?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <904A23EC36C68C4BA82A925B3F575965@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b0eb1a-aa4c-4d1f-e7cb-08dc294fc67b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 09:16:18.8317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BCKgNNiuw07rFp8zdmJiAPqXDGZSWK639GD3SJVQdUtXtoEgxgVF/Udzzg6oZHHjACkmBsk9xv8IYmxI/20KNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8659

SGkgUm9iLA0KDQpPbiAwOS8wMi8yNCAyOjQwIHBtLCBSb2IgSGVycmluZyB3cm90ZToNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBGcmksIEZlYiAwOSwgMjAy
NCBhdCAwNjozMToxNUFNICswMDAwLCBEaGFybWEuQkBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4g
SGkgQ29ub3IsDQo+Pg0KPj4gT24gMDkvMDIvMjQgMTI6MTkgYW0sIENvbm9yIERvb2xleSB3cm90
ZToNCj4+PiBIZXkgRGhhcm1hLA0KPj4+DQo+Pj4gT24gVGh1LCBGZWIgMDgsIDIwMjQgYXQgMDM6
NTE6MzFQTSArMDAwMCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+Pj4+IE9uIFRodSwgMDggRmViIDIw
MjQgMTQ6NTA6MTUgKzA1MzAsIERoYXJtYSBCYWxhc3ViaXJhbWFuaSB3cm90ZToNCj4+Pj4+IENv
bnZlcnQgdGhlIEF0bWVsIEFJQyBiaW5kaW5nIGRvY3VtZW50IHRvIERUIHNjaGVtYSBmb3JtYXQg
dXNpbmcNCj4+Pj4+IGpzb24tc2NoZW1hLg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IERo
YXJtYSBCYWxhc3ViaXJhbWFuaTxkaGFybWEuYkBtaWNyb2NoaXAuY29tPg0KPj4+Pj4gLS0tDQo+
Pj4+PiBOb3RlOiBJIGdldCB0aGUgZm9sbG93aW5nIHdhcm5pbmdzIG9uIGxhdGVzdCBrZXJuZWwg
YnV0IG5vdCBpbiA2LjcuDQo+Pj4+PiBTaG91bGQgSSBiZSB3b3JyaWVkPw0KPj4+Pj4gdXNhZ2U6
IHlhbWxsaW50IFstaF0gWy1dIFstYyBDT05GSUdfRklMRSB8IC1kIENPTkZJR19EQVRBXSBbLS1s
aXN0LWZpbGVzXSBbLWYge3BhcnNhYmxlLHN0YW5kYXJkLGNvbG9yZWQsZ2l0aHViLGF1dG99XSBb
LXNdIFstLW5vLXdhcm5pbmdzXSBbLXZdIFtGSUxFX09SX0RJUiBbRklMRV9PUl9ESVIgLi4uXV0N
Cj4+Pj4+IHlhbWxsaW50OiBlcnJvcjogb25lIG9mIHRoZSBhcmd1bWVudHMgRklMRV9PUl9ESVIg
LSBpcyByZXF1aXJlZA0KPj4+IEhhcmQgdG8gc2F5LCBob3cgd2VyZSB5b3UgZW52b2tpbmcgdGhl
IGNvbW1hbmQ/IFRoZXJlIHdlcmUgc29tZSBpc3N1ZXMNCj4+PiByZWNlbnRseSB3aXRoIGR0X2Jp
bmRpbmdfY2hlY2ssIGJ1dCBJIHRob3VnaHQgdGhvc2UgaGFkIGJlZW4gZml4ZWQuDQo+Pg0KPj4g
SSB1c2UgdGhpcyBjb21tYW5kIHRvIHZhbGlkYXRlDQo+Pg0KPj4gbWFrZSBBUkNIPWFybSBDUk9T
U19DT01QSUxFPWFybS1saW51eC1nbnVlYWJpLSBkdF9iaW5kaW5nX2NoZWNrDQo+PiBEVF9TQ0hF
TUFfRklMRVM9RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250
cm9sbGVyL2F0bWVsLGFpYy55YW1sDQo+IA0KPiBIdW1tLCBub3Qgc3VyZS4gV2lsbCBoYXZlIHRv
IGludmVzdGlnYXRlLg0KPiANCj4gDQo+PiBhbmQgYWxzbyBkdGJzX2NoZWNrLg0KPj4NCj4+IHZl
cnNpb24gPSB5YW1sbGludCAxLjMyLjANCj4+Pg0KPj4+PiBkdHNjaGVtYS9kdGMgd2FybmluZ3Mv
ZXJyb3JzOg0KPj4+PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0
LWNvbnRyb2xsZXIvYXRtZWwsYWljLmV4YW1wbGUuZHRiOiAvZXhhbXBsZS0xL2RtYS1jb250cm9s
bGVyQGZmZmZlYzAwOiBmYWlsZWQgdG8gbWF0Y2ggYW55IHNjaGVtYSB3aXRoIGNvbXBhdGlibGU6
IFsnYXRtZWwsYXQ5MXNhbTlnNDUtZG1hJ10NCj4+PiBCdXQgeW91IGRpZG4ndCBzZWUgdGhpcyB3
YXJuaW5nPw0KPj4NCj4+IE5vIEkgZGlkbid0IHNlZSB0aGlzIHdhcm5pbmcgd2hlbiBhcHBsaWVk
IG9uIHRhZzo2LjcuIERvbid0IGtub3cgd2h5Lg0KPiANCj4gVGhhdCdzIGJlY2F1c2UgaXQganVz
dCBnb3QgZW5hYmxlZCBieSBkZWZhdWx0Lg0KPiANCj4+DQo+Pj4gSSB0aGluayB5b3UgY2FuIHJl
c29sdmUgaXQgYnkganVzdCBkcm9wcGluZyB0aGUgInVzZXIiIGV4YW1wbGUgZnJvbSB0aGUNCj4+
PiBiaW5kaW5nIGVudGlyZWx5LiBJIGRvbid0IHRoaW5rIGl0IGFkZHMgYW55dGhpbmcgYXQgYWxs
Lg0KPj4NCj4+IEkgaW50ZW50aW9uYWxseSBjaGVja2VkIHRoZSBnZW5lcmF0ZWQgZXhhbXBsZSBk
dHMgZmlsZSBhbmQgZm91bmQgdGhhdA0KPj4gYm90aCB0aGUgZXhhbXBsZXMgbG9vayBjb3JyZWN0
Lg0KPiANCj4gTWF5YmUgc28sIGJ1dCBob3cgZG8gd2Uga25vdyB3aXRoIG5vIHNjaGVtYT8gWW91
ciBjaG9pY2VzIGFyZSBkcm9wIGZyb20NCj4gdGhlIGV4YW1wbGUgb3IgYWRkIGEgc2NoZW1hIGZv
ciB0aGUgRE1BIGNvbnRyb2xsZXIuDQoNCkN1cnJlbnRseSwgbXkgY29sbGVhZ3VlIGlzIGFjdGl2
ZWx5IHdvcmtpbmcgb24gYWRkaW5nIHRoZSBzY2hlbWEgZm9yIA0KRE1BLCBhbnl3YXkgSSB3aWxs
IGRyb3AgdGhlIGRtYSBleGFtcGxlIGluIHRoZSBpbnRlcnJ1cHQgY29udHJvbGxlciBmb3Igbm93
Lg0KDQpUaGFua3MuDQo+IA0KPiBSb2INCg0KLS0gDQpXaXRoIEJlc3QgUmVnYXJkcywNCkRoYXJt
YSBCLg0KDQo=

