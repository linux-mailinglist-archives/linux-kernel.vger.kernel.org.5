Return-Path: <linux-kernel+bounces-57405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168E684D803
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34067285EED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACCA1D52C;
	Thu,  8 Feb 2024 02:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kWEay0zP";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QhP7OBUe"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3501DA4F;
	Thu,  8 Feb 2024 02:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707360838; cv=fail; b=LPT6u4Hh0bkpVA+m7GeVOLGhnWWLJ+A768rNnlVP6PsjeRbIhg/ykBB5kJsdFnMD1W15RIvxeCNuWLQGND4DVhJ3T2WzayN4V6Ky3prLQthvsYq1yCsCaYKTetvgenve3Q30XVlDOUkdVz/Wf8ZKtuKGkOlS0K/0snCFfZsRUeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707360838; c=relaxed/simple;
	bh=Zf54XUJtwO7DeCFG1tz+mdQsNJDGrD5sf3PFSps3Exs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o8sXwbEbVC2xBqR2IzVi7WcgRtfr5ZHjinJ1LRfauiM1kScVauoFCMZ/7MN4gEo8SB4zgkd+BeocY45NOCLwDNO0jWi8NWj4kj8CevZsxM0O9GsQy3dhUmpu2bS0spxd7qhxBmyl2i9KucVu66YAcgdeXn1gDayZvnZq29wf8Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kWEay0zP; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QhP7OBUe; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707360836; x=1738896836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zf54XUJtwO7DeCFG1tz+mdQsNJDGrD5sf3PFSps3Exs=;
  b=kWEay0zPksj+Ko5KJ1v8RlfjN/e1YQTi92vhhFlH3TUlwPq62aeihbbK
   7QGCtV3xwfvbNGLrmXvIGIypH2xLyJtqhYDS+ljlbZW4wSZlnscQYk8oG
   1ZN059DLBbjs9sgVMnOscn+9t7b/DzavLxEXLj3yUoynvHcWhjux6qWSs
   WznMgNJ+TnFrqnOzGHoIBG1Hlf1htFbWlYTj/pqgQPnxei3uOdXmyA5XY
   DVorHc7myF7kdnY7tAnzxcCR5xRh+JOLg/UqqMt+XKAXfyb6wcSJSLIC8
   mnSYS2D4FIx/9dx2m9dYLK7xZlOCgy4eD/0jkJvrYWTRhMmIg1t0zfXmd
   Q==;
X-CSE-ConnectionGUID: J1IAsIzmSRiENg9MOflihA==
X-CSE-MsgGUID: jJj3e/szTjW3LQzDWC0jpg==
X-IronPort-AV: E=Sophos;i="6.05,252,1701154800"; 
   d="scan'208";a="183206076"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Feb 2024 19:53:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 19:53:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 19:53:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aW2LL1tV1CXjOmF9/+7Xj3PXKM8mptJo500PBTRgVZjWFLcd68gq49VPrNTk9OsdXnfZId1XpkMFQQF2vOMpaBBnzQQGg0Au3v4nf1rfI70Qfp39DuhVCdmXvGRg1Ih8fQIOdSJ4McVqB1hRQAI+WQ8E8FO6S6WA23vUTUc0pgRQTk5TLvmlcvWgBhfuGGJmL2hjGCWCEZ2O2aVcH3prkpK+bdwhO/kNev1Ja8ZxgXwUWKL+OHCA/IHBpc4FShAbLUrUrxZaiTxDLquUum1H64uRkNXBIr8Y1tZTzv2ZNgPAEBmD/HTcEAXoyretyluZtPVywFgV0pD4B4ao5xHOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zf54XUJtwO7DeCFG1tz+mdQsNJDGrD5sf3PFSps3Exs=;
 b=N4XpeR8d8YyQDLRNW0p1KVh89q9Glf4Qn14gOUqUzOU16oemaGZzboUsck5hZrmWYQ46fMozkaBPCJU8xRBjCpySlZBFfybDbBZzrGocKI95Nag75UIIzjZkxckYDIobjGbSX5Gog88IdwNuf4A7Qg769CPC9QnvoQS/irzL5jSphp1UUTYoNt3N2We4/WrSB9bDwNf7mFD4unXD/ExvLQgXZvwxWci+4CuP2y9O0lGR8c1N5d1HgFhXlluvawn0wMa5qLUCncWJxiGqWmBphaTvDUHifpGhJg1n03OZl+rfpBQeKB7PhrdkF87zqrvKzPVORhjl0kUKEXtt3ZZdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zf54XUJtwO7DeCFG1tz+mdQsNJDGrD5sf3PFSps3Exs=;
 b=QhP7OBUe3UkthJjPbmt8+jlQggrF55RKT60PGkukNzat+UvR5meE8pSUs+98PQVyB9maxv9j20kJ0Dc4HqbH6uA3i5Or1UImubmkoiOaqxS7HmyDK5Sb0WmppNmCC2CrsTz1yA+472dvGkG+YaBbjab/aOesz+iCG0TeOv9cb0Y7Tzp15jMaUmdIk18RnUL6jFSJQ9s86n7FkDZUvKkOdeBdlYqa1/HL4/TezrlPBzDrIk4I4XoKwg2yoBoDSH1rwuEelsIqYSlOIzaWpB8fuNxnQkQqG4lZMDZSoV9HkHt3bDv/D1eOLzRO3rexT1x/aQtqPqZEFsReaguR6VQ6VA==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by BL1PR11MB5509.namprd11.prod.outlook.com (2603:10b6:208:31f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 02:53:39 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::db66:9b2b:5611:c30c]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::db66:9b2b:5611:c30c%7]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 02:53:39 +0000
From: <Rengarajan.S@microchip.com>
To: <andriy.shevchenko@linux.intel.com>
CC: <jiaqing.zhao@linux.intel.com>, <Kumaravel.Thiagarajan@microchip.com>,
	<gregkh@linuxfoundation.org>, <ilpo.jarvinen@linux.intel.com>,
	<john.ogness@linutronix.de>, <tony@atomide.com>,
	<linux-kernel@vger.kernel.org>, <Tharunkumar.Pasumarthi@microchip.com>,
	<jirislaby@kernel.org>, <f.fainelli@gmail.com>, <tglx@linutronix.de>,
	<UNGLinuxDriver@microchip.com>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v1 tty] 8250: microchip: Add 4 Mbps support in PCI1XXXX
 UART
Thread-Topic: [PATCH v1 tty] 8250: microchip: Add 4 Mbps support in PCI1XXXX
 UART
Thread-Index: AQHaT3ZxJm6lVWei10mqPlqZTMvpIbDvXg6AgALYrYCAAzSBgIAKapEA
Date: Thu, 8 Feb 2024 02:53:38 +0000
Message-ID: <5759d744b4935fe88cc55617dc463336ad6d50bb.camel@microchip.com>
References: <20240125100619.154873-1-rengarajan.s@microchip.com>
	 <ZbZyW_g4OOkCqIxf@smile.fi.intel.com>
	 <8406d8866968950b9bb2f2c01aaa92e3107a7a00.camel@microchip.com>
	 <ZbuF53TlbnD09rZA@smile.fi.intel.com>
In-Reply-To: <ZbuF53TlbnD09rZA@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|BL1PR11MB5509:EE_
x-ms-office365-filtering-correlation-id: c021eb2c-0a3e-489e-5c99-08dc285126e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mpRDGtFUv/pcf3UFQwQubAHiXA8Brq6+EurGpjjyuDH0U3Qnk9aWeTpg8r2WCImhhGZNQGFJlOXM8hKNUes/xfEfFfTL/w0plSv0Nv8kiY2ZIHGU3CSAa2SDiKKgn7Kk97MsRdsofdPUOoHtQxK+vy3RoJR5wK5tFlp02TGqwKAlARacazmKJC11EaaeAwe8CZcA7qw8B8+XmYv6tqPu53b62tURvq2qRUV44HYtwhwG2sUYtmMlLy+1ghyAFk3wqgldjBN4usnNXLRR257A5IBKFpat26aUOlq99gCPJjrsokCg8HjGc4SWg5QwI+aKilzfrjnkC8MLBgAQ4/GwxEQA0BGJK7MoFodODReeLLj1/CQvnwxwRpCBzpSCltookyWjN6/gTfuXpW7zHsfbuhNKlsuO0v8yCyku0oh4BWZOvw3L16mSMIGdQeWwFYktvYIZVrwVvWXNSUdgfu89gpUX2DL90thEg9u5lJtKqiEl6yzj3TAWScZBksGGTRQHgn0wxa1hNJQK7FPlxRgmFUTzTMsIL1DfLJPFiXeIC1CyYCGu7Y0XPfRfe+1NiZRTjTbTWyPotrTsXTgRc49+rbYmg+l7k+6vFVHKHqua3fY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(86362001)(38100700002)(122000001)(6916009)(6486002)(54906003)(478600001)(64756008)(316002)(66446008)(66556008)(66946007)(66476007)(76116006)(26005)(2616005)(71200400001)(6506007)(6512007)(38070700009)(36756003)(8936002)(8676002)(4326008)(5660300002)(7416002)(41300700001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RndGT3lSTnViYjhWb1BBTzdLNDI4T3FlS0c1eFVrczFZRXF6OXNTTk52YVlY?=
 =?utf-8?B?ZXR4UWs3ZjQ5THlDemdMMUl5OFBVZ3lmTjZZanJ6eW5ER0FHRjRGV3NOWTFr?=
 =?utf-8?B?MENKVVYrS3c0ZUs1eml1dFc2U1pBcEVMejBsbzYxNXVGZjBmcElDRjErdEcr?=
 =?utf-8?B?UVZhL1JaSHN4b2wyY2dHVEFUeDExNzVTRjIvSzM2eUNUS2hXMHovMVRKTjg2?=
 =?utf-8?B?Q0UreW5mcVBKbVpYVkhXTGhPWkpXdi9rakFtRk9LekZtc044ei8xRDc0SHlU?=
 =?utf-8?B?K1ArdU9uclZBaVBidDNnUkZTeUQ4K0xSZFM1U0FGSktCYWtUWWtGWkovbzhr?=
 =?utf-8?B?OE43eGpYa3ZWT3RQN0F0NnhUL2I5clk2WG9wN2w0MTZ1QSt3ZHZka0kxb1BK?=
 =?utf-8?B?N1JnVFlpcnBRMWhZanFpOU4wNXFCb3I0ZHJHS1psN0hIWDJtaUU5eEF2bzAw?=
 =?utf-8?B?dWZBY3ZLOEZDbUREdlFwMEh0cDZWMkdKTi9hcDloTjdyLzRkZ3JwQTBqY3Y1?=
 =?utf-8?B?VzhkTVZZbDhrelEzKzBkWHAwTHBnSXFDMlRTN25RS2x6M0tMS1NndDNub2NG?=
 =?utf-8?B?MmQreTlicWp3VDE2MWd1UWY4M3RYblJCSEgyVzRVOHpXWm5UeExmU3d0SFM2?=
 =?utf-8?B?bmN1UTB1bHh4anlRS3NwQXovTW5GUFVFbGcwSk5WR0gzd0ZwaFpSQ3l2Qk1j?=
 =?utf-8?B?Z090RlpZQURWeXU5WEFNVXVmZko2ZDhrMGV3Mm9MMFFvU3ZDajluR0Q2d1hJ?=
 =?utf-8?B?cnhDeUt4dFlGa2p0Vk9SY1g0MUJYNGkvdWZNaHUvdTNOMVhiSWhURUVUYjJz?=
 =?utf-8?B?NFdFY1N6TU5wMy8weVpyM2JWcXJvRythMGZZdURxQ0tIdUk0dFU3dDNDTmMy?=
 =?utf-8?B?cm1kMzBJdGJLd0lyNzQ5dnZzclBOU1RkQXZSaFF6YWY0Q2N2V01MaENBT2pq?=
 =?utf-8?B?alY0bFRISU9uREtkMUpqbDhYSTZ5S1k5ajhKTzBkZFlUNzFJSW1FQ0pYcWZL?=
 =?utf-8?B?OE9uSk9ZT2Fnc1NSSWtIdlVmMjd5QzVZeEJsYTNMSWR3cUdaeVRyVm01cFZi?=
 =?utf-8?B?UCtLcGxFUVNCWnNySWt4U0Y3UzdPYlVrZkVxMEZzcWtPVTM4S2xZZlRLQWRC?=
 =?utf-8?B?YzYwM0dzK1VtOURkYTV0TG9RTGZrVUJqY2tBKzlic21qak9mS2V6QjhQamdC?=
 =?utf-8?B?TWxOZVBvUnFxakJTRHF6MFdiVG5aU0tvWHpFd0ltdlVhVFNnNTFNUlJTb2FX?=
 =?utf-8?B?UG9VekpvNW0rMmNRQzkwN2ZPR2V2UnlKUDFNeStaV0s0OTZFMEZOUDlKSjNW?=
 =?utf-8?B?eWUwSlJKaVRpdVhrNHRPOVg5dGZ1aDIzRkNSaGZXd0hWRDdRTFVFY3VBVm5C?=
 =?utf-8?B?Skt0T2szSG5MUG5SQXBXOUtOc2lTVVRYWXRvd1pRaUpNSWdDaDdGbkgrTU1l?=
 =?utf-8?B?azRjd1BUenZkMFFRZnBHemZHNFVFa0JZb3VEc056ejlWTUdudUhRYy9OWG1w?=
 =?utf-8?B?U05Yd1ZqdHJPK3VRaXhiUlBuS1lGTmcvT29zdC9mQ1V1U1BtdFFRL3lxZ0x3?=
 =?utf-8?B?V1J1SlZNSVNZZUZpNGRyZDQ5dHFMclQ1dkhQelR0elVKMlc2OUVvcWJkejJo?=
 =?utf-8?B?T2VDTVFIckVRMjBRY3FlNmFmNHQya1VBVXlxTXVhMmJ4N3lrdEV1Mk0xZTd1?=
 =?utf-8?B?NkFteUFhbUJoLzRKYUlJVmNEaVlWTVZPK0ZyM2Z2UHZxem5vWHhYc21pYW1n?=
 =?utf-8?B?eXdnM3BDVDhCRlArVlhIS1lBVXZwSjJhME85VVN0alJkbDc5ZEV0WkJVRy9N?=
 =?utf-8?B?alVMQkUzbkpWUjROcWVYbWh2WUU4MmtUOHpwc1FPcUVCeDIvZlRGeTR3WmEy?=
 =?utf-8?B?eUkxN0JZQkpSUERQMU5sNGNiaHBGcFg0ajZSYTFubWI1NlBhRUhxMXB1N1lC?=
 =?utf-8?B?SmlGeDRYTlRwTExQUmJFQUNLV3RRcFFNN0dVVDVBd0ZpV3p3dGxVemljaUZD?=
 =?utf-8?B?dlRTMWtVSFh6WE1DOXpYbTJGL1I4RDBEV1dEcVd4dEtDNXBubWNTK0d4S2J3?=
 =?utf-8?B?eHV1a2pHV2ZHalVvb0NxdGtFRVZ1Q0JZeWhvSVFVeC9vRXZxR1NPQmpoT3dz?=
 =?utf-8?B?OWl2T3NZU1ZXSEQxaU03LzJzSmRrcW5MUDhBU2VHNUMraXU4Q2JOaEEvaiti?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E47D19E02D8FE04785B6C34A2CF4424F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c021eb2c-0a3e-489e-5c99-08dc285126e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 02:53:38.9556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jP9VGVjikq33Uxh90EyIDvA2nobOvyDrE9f45v07LOQDhFQzHZT92obUhlzzw/WyW3eaRnNVcd0C3/44P4S+dASHJBJzMbSLCFH4bWGAmwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5509

T24gVGh1LCAyMDI0LTAyLTAxIGF0IDEzOjUyICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVHVlLCBK
YW4gMzAsIDIwMjQgYXQgMTA6NTI6NDFBTSArMDAwMCwNCj4gUmVuZ2FyYWphbi5TQG1pY3JvY2hp
cC5jb23CoHdyb3RlOg0KPiA+IE9uIFN1biwgMjAyNC0wMS0yOCBhdCAxNzoyNyArMDIwMCwgQW5k
eSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBKYW4gMjUsIDIwMjQgYXQgMDM6MzY6
MTlQTSArMDUzMCwgUmVuZ2FyYWphbiBTIHdyb3RlOg0KPiANCj4gLi4uDQo+IA0KPiA+ID4gPiAr
wqDCoMKgwqAgLyoNCj4gPiA+ID4gK8KgwqDCoMKgwqAgKiBNaWNyb2NoaXAgUENJMVhYWFggVUFS
VCBzdXBwb3J0cyBtYXhpbXVtIGJhdWQgcmF0ZSB1cA0KPiA+ID4gPiB0byA0DQo+ID4gPiA+IE1i
cHMNCj4gPiA+ID4gK8KgwqDCoMKgwqAgKi8NCj4gPiA+ID4gK8KgwqDCoMKgIGlmICh1cC0+cG9y
dC50eXBlID09IFBPUlRfTUNIUDE2NTUwQSkNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBtYXggPSA0MDAwMDAwOw0KPiA+ID4gDQo+ID4gPiBOby4gUGxlYXNlIHJlZmFjdG9yIHRo
ZSB3YXkgdGhlIDgyNTBfcG9ydCB3b24ndCBiZSBtb2RpZmllZC4NCj4gPiA+IA0KPiA+ID4gQWxz
byB5b3UgaGF2ZSBhIGRlZmluZSBmb3IgdGhpcyBjb25zdGFudCwgdXNlIGl0Lg0KPiA+IA0KPiA+
IFRoZSBjdXJyZW50IFVBUlQgY2xrIGluIE1DSFAgUG9ydHMgaW4gcGNpMXh4eHguYyBpcyBzZXQg
dG8gNjIuNSBNSHoNCj4gPiBpbg0KPiA+IG9yZGVyIHRvIHN1cHBvcnQgZnJhY3Rpb25hbCBiYXVk
IHJhdGVzIHdoaWNoIGVuYWJsZXMgZ2VuZXJhdGlvbiBvZg0KPiA+IGFjY2VwdGFibGUgYmF1ZCBy
YXRlIGFuZCBsb3dlciBlcnJvciBwZXJjZW50YWdlIGZyb20gYW55IGF2YWlsYWJsZQ0KPiA+IGZy
ZXF1ZW5jeS4gV2l0aCA2Mi41IE1IeiB0aGUgbWF4aW11bSBzdXBwb3J0ZWQgYmF1ZCByYXRlIHN1
cHBvcnRlZA0KPiA+IGFzDQo+ID4gcGVyIHNlcmlhbF84MjUwX2dldF9iYXVkX3JhdGUgaXMgMy45
IE1icHMuIEluIG9yZGVyIHRvIGV4dGVuZCB0aGUNCj4gPiBzdXBwb3J0IHRvIDQgTWJwcyB3ZSBo
YWQgaGFyZGNvZGVkIHRoZSBtYXggdmFsdWUgdG8gNCBNYnBzLiBTaW5jZSwNCj4gPiBiYXVkDQo+
ID4gcmF0ZSBpcyBjYWxjdWxhdGVkIGhlcmUgd2UgbmVlZGVkIHRvIG1ha2UgdGhlc2UgY2hhbmdl
cyBpbg0KPiA+IDgyNTBfcG9ydA0KPiA+IGFuZCBjb3VsZCBub3QgZmluZCBhIHdheSB0byBoYW5k
bGUgYXMgcGFydCA4MjUwX3BjaTF4eHh4LiBDYW4geW91DQo+ID4gbGV0DQo+ID4gdXMga25vdyBh
bnkgYWx0ZXJuYXRpdmVzIHRvIGFkZHJlc3MgdGhpcyB1cHBlcihtYXgpIGxpbWl0Pw0KPiANCj4g
VXBkYXRlIHBvcnQtPnVhcnRjbGsgYWNjb3JkaW5nbHkgaW4geW91ciBkcml2ZXIsIHNlZSBob3cg
b3RoZXIgODI1MF8qDQo+IGRyaXZlcnMNCj4gZG8gdGhhdCAoZS5nLiwgODI1MF9taWQpLg0KPiAN
Cj4gU28sIGl0IHdpbGwgbm8gZ28gd2l0aCBoYWNrIGluIHRoZSA4MjUwX3BvcnQuDQoNCg0KSGkg
QW5keSBTaGV2Y2hlbmtvLA0KDQpUaGUgVUFSVCBjbG9jayBpcyBjdXJyZW50bHkgZml4ZWQgdG8g
NjIuNSBNSHogZm9yIHN1cHBvcnRpbmcgZnJhY3Rpb25hbA0KYmF1ZCByYXRlcyB3aGljaCBhbGxv
d3MgdGhlIHVzZXIgdG8gc2V0IGFueSBnaXZlbiBiYXVkIHJhdGUgd2l0aCBsb3dlcg0KZXJyb3Jz
LiBDaGFuZ2luZyB0aGUgY2xvY2sgd291bGQgbm8gbG9uZ2VyIHN1cHBvcnQgdGhlIGZyYWN0aW9u
YWwgYmF1ZA0KcmF0ZSBzdXBwb3J0IGZlYXR1cmUuIEhvd2V2ZXIsIHdpbGwgY2hlY2sgZm9yIGFu
eSBhbHRlcm5hdGUgd2F5IHRvIGFkZA0KdGhlIHN1cHBvcnQgaW4gdGhlIDgyNTBfcGNpMXh4eHgg
ZHJpdmVyIGZpbGUgYW5kIHdpbGwgdXBkYXRlIHRoZSBwYXRjaA0KYWNjb3JkaW5nbHkgaW4gdGhl
IG5leHQgcmV2aXNpb24uDQoNCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5
IFNoZXZjaGVua28NCj4gDQo+IA0KDQo=

