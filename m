Return-Path: <linux-kernel+bounces-59134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 052EF84F1BF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280921C24018
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B04664C8;
	Fri,  9 Feb 2024 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KTHuSyxM";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RU/NBt4K"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76077664C1;
	Fri,  9 Feb 2024 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468811; cv=fail; b=X8pP1CT3vsnWflRvD3ywkBH1wDkX/zcPDH4IgI5WsIgUiF5BLQClq8XfeGJ7sRr9oen39YBAMRCT8it8F63ZfOqg8vGukQVyc5144o4HxZ8/Ho6XzoP1DgKTBKfzN47B3VTSvuaWwVJaCR2m3L69RQ8tzDbpHZAEU30G+PS/ctk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468811; c=relaxed/simple;
	bh=tCmPDsOtFhGHu3lW2ww2n1EWf70yLFnXYxLtaItPA+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AWpNI6rwwXNyZBTp36l8e2gqj4Tt3QZIweXbanXrOQLcMclVj83Yjlw6InfB6kXVM+cmBvA4i/hIQMVl7qTYj9x7dIVaNOVWtZ0WmGhzgrHN1tDduLItjOvFMCjPJH9dN30TnDqFTOUjS1JaOd5YFifPUVYwVqt+sVswrWLh0TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KTHuSyxM; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RU/NBt4K; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707468809; x=1739004809;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tCmPDsOtFhGHu3lW2ww2n1EWf70yLFnXYxLtaItPA+I=;
  b=KTHuSyxMUyrenXRiHkfDYXSivEtipvcQrDSScd7LiAM1Gf/ZfAry+L1u
   sY+RRbSTavsxhtdSHOOcteqplZcqd1BVGuzFd0kDc942mPBhKZpt/H7uv
   S9BtURpaqondjM/E+Wmv+L+ph18uD2V3SFAgo5m3Vs8Pg7pJILfpa8+rS
   f94zSA7B38ceY9Dx5IN7izgsyEyBguyEgg0Npl3QAqNGlQycYAN6BPxGW
   1A/Mf4RUlxiWTgRacfQx5yoiqLHVnpuOypYI9XHunjGNIyPAj1sfc7oNJ
   SU8zRuGutzdw1V6xXUadD0tD74q/UaTL7/1yL9gH2Ece3SmJzNe7CgsAN
   A==;
X-CSE-ConnectionGUID: yck0rHmqT1Wqq8u5TBBwSA==
X-CSE-MsgGUID: WAA5u62QR0KFQ4sFlQ4Xdw==
X-IronPort-AV: E=Sophos;i="6.05,256,1701154800"; 
   d="scan'208";a="183273577"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2024 01:53:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 01:53:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 01:53:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsDxTfp1ka7LHQo8TaxWhtZeYFZSOYM7EFb5shIaUcoGmgm/axPlyyIo5vvyofm976K9zc9c3YxfMZwPnq55+gH4/HBthdn2rmajX48sncapTOsgjcD5dOUGsdSqXt/6FqnC5zObD4cDuAVRuMi9qZvtXshp+TLogQjde2Fm6pZA+oAbQ2A5VMgmY8d6nYepPjUUZI9FnqXIHQOk8m6Oz0DUuKg4SxydFPISyUlqrv7RMFVjXf0maZhK+4H++YQQcKcOeAaNuErOmJwlJJ2CtjA14tVUsjMBnhQRa4Fy1E5i6nP/yPgtR5LyJrUmd8Ya1UzcEi0yiQEGzBo166JGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCmPDsOtFhGHu3lW2ww2n1EWf70yLFnXYxLtaItPA+I=;
 b=TJd/noHy4hTVlnx6q6q4bLKFRgo6SKxGU2Uxnn1cHFqL4AvCEIQYirC2L31IShB182BySA1f9dZJVLbX3tuu0C3zgm5OfEZ9fh568k5VqXU391UAN7FbsQBGxeyNtzk7/3JAyeVaY9BLziPs8PwcytlWlIQa9L02sX8Ef8uHUBkVaT0PTm984kwLq0q0dP66WazUcw+mr0HtZFD3rfK2yuV/hzHVpZN4jNa7wqlkD8Rrf5lRqRzmPSyJQsGDktflWwp52dNfayGSPd+UydVwfMxC9j7GjBKjc4U2s8cyjlyzFhxgDaSjBsRLnoHGhHIs3V/vL+yQcHiPu+FY/PMnfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCmPDsOtFhGHu3lW2ww2n1EWf70yLFnXYxLtaItPA+I=;
 b=RU/NBt4KajYUGXVGfGHa40ZNvUIPJXv+q3NMyLfqPM8qEWc33WNFCrdzNutMAl/T7IsrXYziy/+5AUUvePTI4wIIXfFvDRyRDNN3XAbp3BYNBleRHMfpkWxQOrv3aYV7RdewtUqHY8YVWPP0wpUKoCfaV6YvP4ks8a2t79L36PtW/vfql382XZetgm8nwI9pe54fe/5r1SEOYhtPjQWl2z+cvzAfBDRjf/6FzjndO4ZeBrnA9tCLbPw7k5HiCYNTmxybTdO4CHlVqUyBtA7h03CIM6ESgH70K0OmwFgvEQFzLkzxoOVYbwxAqa6n5L7dQSXyFPfr791f5Na98FpX9g==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SA3PR11MB7653.namprd11.prod.outlook.com (2603:10b6:806:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Fri, 9 Feb
 2024 08:53:12 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::51c7:3b29:947a:9e39]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::51c7:3b29:947a:9e39%4]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 08:53:12 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <christophe.jaillet@wanadoo.fr>, <Christian.Gromm@microchip.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] most: Remove usage of the deprecated ida_simple_xx() API
Thread-Topic: [PATCH] most: Remove usage of the deprecated ida_simple_xx() API
Thread-Index: AQHaLHETwc2Lhwppyke8RQUcWa9qZ7ECEeQA
Date: Fri, 9 Feb 2024 08:53:12 +0000
Message-ID: <cd56d073-04ad-40ad-968b-7e137d10f456@microchip.com>
References: <988c218ef3d91bffaf4c3db9b6fba0d369cbb2b2.1702326601.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <988c218ef3d91bffaf4c3db9b6fba0d369cbb2b2.1702326601.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SA3PR11MB7653:EE_
x-ms-office365-filtering-correlation-id: 89b9b5f1-2420-45ed-c6f7-08dc294c8c40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EaJc8EOxShsdtJWB7NLMDPL0+0fDyJcitm9eSWmgvT/lcn4JRDlU4hYDJKrEhl9it0niALQQ9MJ/j0635n4cIVAhA+NohTaSxnWuDdWCoExdgvltDGH/HiSbwFqnVBAPjmvagXnk2HMJTf51bGwYfTUzJK1k6FTQYvOR8O4KprJ9cJUhcbV5mEHqfKEf59gTM7RhlHwBw6WUwl8txhcg3bhSVijkNU5833odB9A0Stw45gwTfUGHh2NQk0yl51LcaoeqHL+yYro88OVnhuSqHKpyDS95PWn6hJ+8zZrL7AGUFX0jjGxnFS2Kz9BiIdFPP+CYmOiD6Oia04W2v+Z/Jmul1rejLiCjT2XZ6EK6RlOdyq11mwWmlivWJ78SH+3C0zO+5PF9CezAUJg173Quy/w6PYFa8QIk/2i6eo4gXP34qTrtxVx06kDOS4zAcp03Byuee9kvdZAwQmI6ZFaGQvOKCSC3nV4KMIAXj0rvEN2dhf/59uXB833y2vK+1r8DUDFpDkBVRWsA/elBXft6g4t7/UYstmOcAoDa7cALDhMxrUiDddstt3n/uqQUHXns+7H2XesJQKgImj/b4F8iT2/oHtp9pmIOnXd/CG4u9822lxj23F0Z4ltLr9GFsGxp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(316002)(76116006)(6636002)(66946007)(41300700001)(86362001)(8676002)(4744005)(4326008)(2616005)(8936002)(71200400001)(5660300002)(53546011)(478600001)(36756003)(6486002)(6506007)(6512007)(54906003)(26005)(38070700009)(66556008)(66476007)(64756008)(66446008)(91956017)(110136005)(31696002)(122000001)(2906002)(31686004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXl1VzB1Y1N3Y2ovL3VVWUVXYnBnd3pOU0grY0JEZWlEOUVEZXZtTWhuMnRH?=
 =?utf-8?B?Q1JXclJUYy9xTEdhNDk4aUw0aG1oN1VudjBMS0lmOGhkdUVOdjRBYU9UME1R?=
 =?utf-8?B?TTF0UHdERFJzQk1KdFY4YnZ0L2ZmZEhZMU1tUUVPQzFPTU5xMXZSRUtISUJv?=
 =?utf-8?B?T0tyZG9iVkh0SUdZRUhTRHlvZlp0aG96MmZyNXMwZzU3bWhSTGJNTkJlRTc4?=
 =?utf-8?B?L0xDYUErM2dlYnFyNXduQ1RMNW9PWGVHa29wZ1l3MXBHZ25kTkZuSE9lK2dY?=
 =?utf-8?B?TEhZdDRCQWxqTlV0SExiblVzSHFvNzRjS3cxWURIS0ZkUmZjaFVRd3JWd1RW?=
 =?utf-8?B?MVE0cWxXTlY3NERwYmo4RmhEamVGVVg2MkcwajR5YVZ4WGN1eWRURG03bTdJ?=
 =?utf-8?B?OVUzYWhyalowb2VQdFE2dUlrcDZZMFdvOEo3dE5mVXYzTFlORkN0Wmp5RTd3?=
 =?utf-8?B?ZHR6bFhYemVhSnV2ejU3UzNNMWdwUEdKWEcyUWNYN0NGZ0I3ZFBybFd5SnQz?=
 =?utf-8?B?SFhCOFBreC9VTGU4MVcvcDh5Y1N4dVIra1E3bEkrRFRSZDVCMDBEbisvRGtq?=
 =?utf-8?B?Ums3ekdxendTYUVGN0ZLN0VnbkltK25NdFFDZnpyQmM2dHN0U0FJbkdpZ1NW?=
 =?utf-8?B?NG1IZE9MNUhuZlc1UUZRdWRteUpZc3B6RThDNnBENGdmM3lReCt2dUZzWVVN?=
 =?utf-8?B?UmplNlNzdVFPRjUyejlxcGYvWk44aUFnUGV6VlZtRWtrd3hCV0kra0VMWWtL?=
 =?utf-8?B?Nmd4S0d5L3NOZm41aU8xNU0wQzhVQXNhcXRtMTZnZXlpS2EzdnZTa20reTN1?=
 =?utf-8?B?Q2dlUmpQV1ByZmV1Yk9zczFCZmdCQUNKeENFNnFEQXFsV2dFbjVsVmFJOERD?=
 =?utf-8?B?S0I5dVVUak04MzhiOWt1TFlISGo4WUlXelppY1RKbWZUdnJFUXBxcjY4dVVs?=
 =?utf-8?B?cTdLYmtIL3ExbFRFOENwKzVsZXRycFJRREd1WHE0SWhJbTVsVEF0T2RHdTYw?=
 =?utf-8?B?YjFCSzNnTUpabW45aHdaTHduOUtON1NnbWwyWlVKOXJOT0JET1VKZ1FFTmpU?=
 =?utf-8?B?UnNNVVhsdjZOTlF2aTNVUXJOTlpLR0JUWXh3ZjR4SWNjMGh6dGk2VUNCaGNW?=
 =?utf-8?B?MDFQbklVWHpqMWxnTjRrUUdsT2l1SzczOGRXeGVhUzk5N05kTE9TaExIbUlD?=
 =?utf-8?B?SUVaY05xR0pqcHp6MzVPM1E2VGY1VlkrelEwdVZIcXdxZFd2OEkzZmx0Q0NJ?=
 =?utf-8?B?N0o1SXgzZ1Y3OVVyLzE1eGZYUHdSTkVQYS8wNWNNVjdQVEUzWVM2cUEzaDd6?=
 =?utf-8?B?VW93VGp5QUs5QnJteVlQLy9uMENWeDdodElrQXNqRnhxTGJYTmk2bkw4SVN3?=
 =?utf-8?B?dDRuVTFRTDhUN0wvVWxLRlpEeEtSRmwzeWNjNFZPRlZ5VzRTdEJQbitaOTZY?=
 =?utf-8?B?Sk5xSXc3VW9IbFFmTExkcUQ2b0FkZWtIQ2dsaWIvYXlLeERaLzlFM085cmg4?=
 =?utf-8?B?Z3BtblR5SWt5dktmd1NLN3hXM25XSmtRQ3NYbDJtdThlSmFnV2M5VU1jSHlm?=
 =?utf-8?B?WEY4NjNvYmtGTENGQ3hCWUxVVWh2OXQwSmJzMDUzZ3FSSjlNVmU0OGlEVGg0?=
 =?utf-8?B?a09qQThVQzZ3Q0Z2UmpRWXlxWTVnaVg0YVRyc0FFbWVXYkp1MjhrTFNrT2Z4?=
 =?utf-8?B?V3h2VkhwNHB1RTk1SWEvaDlZcGVXdEFSSDdmYUdweHdCRzY2VlY4UExVdlJ6?=
 =?utf-8?B?MzF2bkRISFd2SFR5QUdnMlB4VHMyVkJRbDFvQXh0NnEzaDFPVW0rUThaZlRF?=
 =?utf-8?B?QmxjZy8yK1ZORWpkZ3IzTjNOZTJJQ29UNHNOVjVZYWxrMzk1Rk15Q285UEpP?=
 =?utf-8?B?b2RzODZNeitnbkx5ZkFIY0IrNE9XeUFOZWhmUmdMM1pqSS9FMmRsQWN6UDgx?=
 =?utf-8?B?d1dsU09lTTdpaE9Pci9wMFdUcUtsb0xxYlJDdzVOWVorMDF5VXBkaWpaYXZi?=
 =?utf-8?B?L0VvaDd6Qk5aNS9FaGxLSWMvcnlrUVZUdEkrWktFTDVxNzBYNEwxYlptbFlP?=
 =?utf-8?B?VHFnSkpYL3lpOUt2azYzZEVsZCtGQWRwdUtleHBFQ1B3dldocWltWWR3NHJv?=
 =?utf-8?B?T0FwdjBjRkpzclN3TWVWUDArZm5sM2VsS0tlOTUrQmMwS0JhRWZvbkpucU1K?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48C176C089C269408DF6C9BE2593418A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b9b5f1-2420-45ed-c6f7-08dc294c8c40
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 08:53:12.6559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ygy5aXaKpnLNhTPN+MlSzmWB0vsUaZeB0qKmgS+iaO9CNmuw3EeG4OZFBdW/qlhXPn/TC15zYbHC5/oBVZioVfjI2dP0asLs0BTNgn5CpCnnJnKlzmB285mS4fvdfB1x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7653

T24gMTIvMTIvMjMgMjowMSBhbSwgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IGlkYV9hbGxvYygpIGFuZCBpZGFfZnJl
ZSgpIHNob3VsZCBiZSBwcmVmZXJyZWQgdG8gdGhlIGRlcHJlY2F0ZWQNCj4gaWRhX3NpbXBsZV9n
ZXQoKSBhbmQgaWRhX3NpbXBsZV9yZW1vdmUoKS4NCj4gDQo+IFRoaXMgaXMgbGVzcyB2ZXJib3Nl
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmph
aWxsZXRAd2FuYWRvby5mcj4NCg0KQWNrZWQtYnk6IFBhcnRoaWJhbiBWZWVyYXNvb3JhbiA8cGFy
dGhpYmFuLnZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+DQoNCg==

