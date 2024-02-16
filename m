Return-Path: <linux-kernel+bounces-68137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A37857652
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490452813C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A614AA8;
	Fri, 16 Feb 2024 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iHbupFZB";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mEJ7sJ2c"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31767FC01;
	Fri, 16 Feb 2024 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066701; cv=fail; b=mQVFTXVRuXnuvONXl6vM47/EB80UsVQQ6HinNIETKLzKY+FAC+jTYNbwRvR3/jZUPHVX39mDxHUuoAphM8Zf7b5H31lW7b8MZr7S85fhHVEtmKTAvC8C+L5l5MaAW4hIN65ugdZzEoPNhh+wuqAYZy44Rwcgpt5DDcXp0OTIy8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066701; c=relaxed/simple;
	bh=CC7t/Gk05SL9/dacteDGMwdajomf9PfHBUJ4VGHlywE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gy/IPH5UuYkapsSR16NxOTH4WPmUi+VA9iyVMzrQ8tEYzgmpj+9n1dsKwcUOhxyrMWV91HhcBbrL1mU97PLmFZpA3xVyOvqsmgoTeXCAMdMy5G5ORviL+Bvwjel+gjCg8I1rZa4bgwfr+3BEqL6d3KROmTM91Ng08fifJtjkpqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iHbupFZB; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mEJ7sJ2c; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708066699; x=1739602699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CC7t/Gk05SL9/dacteDGMwdajomf9PfHBUJ4VGHlywE=;
  b=iHbupFZBFYDLhq2vshOfNVZB8dqA9tklIrWrW1JWp40C3J5gSJNJHASY
   Xti6vTVJHjyXHKqI0K0ggixUKlt4iAf0OOyp5FnHpEfcIym3vAqJCJbM8
   qRF6HGqpF+w48lynf3D+6qp313zcDF9rvxx2ba6tP53yIiRuUPglkyR+V
   bLT6rTVNBEo11C1ib3VyZTOZpDpaUWUSMswpXUMY4fcqdxq/sMbG/3u7L
   wFGcSE2WKZN6gu6icSQ+tvgDbSXCJHfzEnGxvX0MeIO+z0uWNVa1qB6h3
   pMgSWZdNZmJz5dB9YXT4gGYHXy/9+NX3oGur6XNzbDy2/tEQIG1RR/An1
   g==;
X-CSE-ConnectionGUID: PzXjFMCCSIacsRETbMjO9Q==
X-CSE-MsgGUID: NSpveMM3QI2/ofg+eN9n0A==
X-IronPort-AV: E=Sophos;i="6.06,163,1705388400"; 
   d="scan'208";a="183606321"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 23:58:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 23:58:12 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 23:58:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbhZbUpiJJcCwMoX9zIUh5U8wD6N8dQVdo8aL9FMkB3U/cUM/KP6JXEK4Dw5e8QSc+Vcc3jdClT54UN2dXWqiNp+nmdskeM6ZZ14WBbOJ7YUO5uUmFiYSBXOFpTKFaXVD+eU8xt6XLj+SSRk82h5yfCq9UNKerRt5VI3hSyqTmVG2y+fB1grXykyOFBUH/55ORRWry6LRep59Zmgl/hzfXNahshYdPTiUpy6Yu8q4N0srbwcgE5YppjnLk3gh2M7oHRCB8JwtN/GEYrWXwcIIBANRjACnfkPBVHwxKmPpJwXerSbAEb+qOvSF5eK6m5JWFoPnCaLp1BXkIVwAdA7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC7t/Gk05SL9/dacteDGMwdajomf9PfHBUJ4VGHlywE=;
 b=jzhy+vIJCnNxzUN9OBjMNlmmh+84t//1IiTy4fyNPGdImyYsuO1dmhGaPebEu3gDIRvJlae+Ez4Ybf1JDVgRpPKkEm05s2Xpa5vqow/zFG/qwYomXh1OnmOG0ThVGE2HGK7ZcIx8PnFivCDiGcA3RQZgVyt3mnBAtc0Pj3OLYEnYsOwjNT+IBRtlEULahWh6cAYneWiCpQ1Ff87nxCkAWJ4NgzTAjksjWW0Ns1hAFPqIwzXsQtrqTaHRU1b3SYMN4o0TQv6W+XggJdqTE7g5RDyohnRwVfEtwWVoW8DumUXLB7VirH09bH1WfGz0TzuO+VeVt94JypUeUy/IqhsBQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC7t/Gk05SL9/dacteDGMwdajomf9PfHBUJ4VGHlywE=;
 b=mEJ7sJ2c6PEU/QNixwTjItEKIY3A14zzKQ081ekUMB5qJqEf5jfJD7UDSh5ary/txgxb6JrkpRZX5hXPMFsmSV7ChuCqXRK2W/nZOgbknXIukITUyudLOw8YPQYFWyIeX/R6KN2txFQAsXPdRJ1wzuKKe15lHW4ozl+ozE9gkxXMSR3FpUTgLtJfUNazRFew7mTsWT7kgSNz5m+kKTtcu5dIelNw32EjuF7g575Yzx8DzL1sTj4v3arfpRwjlrbg4/2bTuMxtsO40k6IJrqmS2nvvP7VDIG7M3t553uxAl6O/BVUN7hLOofTmpZD5tYzZdSBCePpJwyh9N4ScHE7wQ==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by DS0PR11MB8761.namprd11.prod.outlook.com (2603:10b6:8:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 06:58:10 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::f267:b0f5:662:b562]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::f267:b0f5:662:b562%4]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 06:58:10 +0000
From: <Mihai.Sain@microchip.com>
To: <conor@kernel.org>
CC: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<andre.przywara@arm.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<Cristian.Birsan@microchip.com>
Subject: RE: [PATCH v3 2/3] ARM: dts: microchip: sama7g5: Add flexcom 10 node
Thread-Topic: [PATCH v3 2/3] ARM: dts: microchip: sama7g5: Add flexcom 10 node
Thread-Index: AQHaX++hqXMnmAeGjEig5SQwnML2drELoc4AgADpUQA=
Date: Fri, 16 Feb 2024 06:58:10 +0000
Message-ID: <PH8PR11MB6804E9353A8EEBD2B829D8B3824C2@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20240215091524.14732-1-mihai.sain@microchip.com>
 <20240215091524.14732-3-mihai.sain@microchip.com>
 <20240215-lustily-flick-69cb48b123c3@spud>
In-Reply-To: <20240215-lustily-flick-69cb48b123c3@spud>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|DS0PR11MB8761:EE_
x-ms-office365-filtering-correlation-id: aadb11a3-ba87-42f0-2fd2-08dc2ebca33f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5FsusZv2PSoUcgQinRO0dYxUFUgQWYMJpr29W2QBwU3gA6Kbv79QMoOST2v2SU8LPvfQaH2rWwi+r4/QwCmT+FWDDmQgSV+pXMQw9Hwh7Y/1KlzLYVQhUbGW7ECdzNRbacSUIevfrDI/VgnPqLC5kqNF1Bza1gdKGOeQTx927hniTAm/EwZmnAf+lOT1HAwBYLPiMSfCWzd7Ik9uKu5g/ionjy6Kt76ENmm8ahUcqMtjnezo3o2eu16u2IUvNw+r2RK1TpeuSuKrKe4sGCBuDPQaclr4iCEY78hiQtcnoumj9c9kNoGPFoDeoYshyRWSAzmfs7TYYibXLH1aNLew1cvddoQgmsMgwjMQxwI6XsH22GMef7Q6oWKRcbvTzTNIolWKy4LFgrPAkOtOEAo+KzIRj6BQFtItiM+RwDwmjSiyiq4ohjTWztE5p9mR4ttM6yVZAXzOV2zOw/sD36iZ+qKG6+MIGCFgUrhoOUpmI9LAJf8Ju4KVUPk9V/KPa1tG8aIc8+ElqO+kqY1X3wh6MIZHm5BH69BkwW0Idg6VATXG3cyb0el8UluuE4C6a1eGw8L2ozZG/Df2BcN87yM7vlXcdS7QSq0crGCJHOCC6gg+dUJU4kAFk0qN9MCTEFYOWx/rJzjd9ee8ZT1XvMMETw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6804.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(33656002)(122000001)(966005)(9686003)(6506007)(7696005)(478600001)(316002)(41300700001)(54906003)(71200400001)(26005)(107886003)(38070700009)(38100700002)(64756008)(66446008)(2906002)(66476007)(8676002)(4326008)(6916009)(66556008)(8936002)(4744005)(52536014)(7416002)(5660300002)(55016003)(66946007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTJIVFR3WURDK3Rmc0twUEN3VVZZMkRnS2NuMENLeHkrcFZ1YnlsbndxN1Rs?=
 =?utf-8?B?aDlHRFc5RmlCdW1DNVlmRytnQXRkK3lORG5Nckw0VnBvWWxRazNOeGlLRitI?=
 =?utf-8?B?V3FoUnEyVmlSaDh3UnBNRkpZNm9EeVhzQkVBcEFvcDNZR24rR2N4MC9sRFdY?=
 =?utf-8?B?c0puT1h2eGdleWhsZXZ1MUc4bHdsSFltZWtsK1Z1aFRKdU4rUEFLMDhnL3VZ?=
 =?utf-8?B?b1VQOHh5UmhmREpQVkkzZ3NxcFdrcnJaNWJ1a2x1bGZHc0JvYnZ3cGo4Ulpa?=
 =?utf-8?B?UnJZaDNDSEZqRU5Qc2ZFV0pOWVVUUHRmSEJiNmxUL3ZNZ2t0bGtyejhaL0Ft?=
 =?utf-8?B?QzB3S2NwUWFKZWRlVHZBcnc4dWtCSEFPc3NneXZuY0YwQlg0SG02NDVMTHBm?=
 =?utf-8?B?MklFQzZ4MkdOY1BnL1ErQWpMMEhDQlZCVW40emp0M2lMelBnV0FYcHJlSHZo?=
 =?utf-8?B?K0RCNUxwWFFGWGtWZlgvSHpvMmRuQlhpZzRxM1hZaE95S05ua1lRVlh6L1Fh?=
 =?utf-8?B?RHFpNlUveWRlQXNMcEZJb3BNVXRBR3Z5ZERIUWtkSEZEVTNkbW1zNmdIeXYz?=
 =?utf-8?B?cE9XWElBV1dNS1Uxd1R3TGNIOW5ZZ1JrNGFRYWFjdGZWdWFMWWpiaklacU15?=
 =?utf-8?B?Q1l5QkNPdVRESk1UOFZXckJvcXJ0ZTQ2b1Vod2J2V09VN1pYTmQzZy91bHFM?=
 =?utf-8?B?M2RoejRSRkJ5RndDdzRxY3dMTkNmQlZHR3dOMStUOVlXdjRsVC9hSTY1VEQ2?=
 =?utf-8?B?VkhzUUl5MTBHU3Y2VXNwckxzcnVjVUtacGR6YXJFbTcva3BoNGt4MnNPNTFj?=
 =?utf-8?B?bUhEVW1UMFQralRKaDVJT05Pd2NiWjRhMWY1bHNXZXBKMWRxMy9EbDN5T0I4?=
 =?utf-8?B?OFhVT1ZROWpFUGw5VmtVSm9FdTRYd0ptc0pBenJSZXd3NEpqLzdxMkExU21l?=
 =?utf-8?B?UzlYKytTK0FENyt5bGlDRlpqSnlFTlg4RU13OVpMb3BzY0laRzdXdElhYmgx?=
 =?utf-8?B?b1ovaVdpcDdoZ0gwWkJ1Y3FWOUQ5WmtoYVE2N1lkVzhxNC9PYjVxdlR3MnNj?=
 =?utf-8?B?SFNjaDdDNkt6OXJXdmlyVXZNVk9ubzN2Yk5haU9TRmpMN0pQRVZyeC9pR2Mr?=
 =?utf-8?B?c05UNWxRZHJyNmpnLzJkUXo4amZOc0hSL2RrZU9yYVl5ZTFBN05hdmZGZEU5?=
 =?utf-8?B?SXVQZS9nd3FmNTEzaUgrNXpCbEpqYTZSMjF3TlU5NmJBL1NZaFUvNk93dnNB?=
 =?utf-8?B?MEdlYTN2WHNUZVozMWI5QklDNlYvY0grdDNaaHJMMkN4UnY2am9hTytOSDJF?=
 =?utf-8?B?b0g5dEoxUVQzRUhhS3NES3NIK2ZuSDFzdGNrMlc5TlVmMXNPbzhOaTRGTSs0?=
 =?utf-8?B?UWtXT0c1QUxUejFNUlZKalkvUDExMkFmekdLOXJZRHcvMm92UWtkSkRTai9N?=
 =?utf-8?B?NDRrUi8yc1V2ZjV1R1JvWVZCVHQ3S2ZaSnNieGNYSkVaZ0NZR1ltN0hCR1Bm?=
 =?utf-8?B?VmZ6ajhyT1lpVkJzekVseFdvc0RUZHg5MlpZeWdCekxoczlNditJZEYvUmJ4?=
 =?utf-8?B?VXJWNnRzRDlvS0Y0dVRNVkl1SXMybTJXNmJTa0RTVlRxZk9FRTlWMzlSdjRz?=
 =?utf-8?B?Z0tCeWdtcUI5L25Zb1dXSVhHOG10VWEzeWlXWUJINmRHdlh5RHU3M3hhTFVR?=
 =?utf-8?B?eEE3a1o3eGdqaDZMV2VhbFAwU2VtVGZrdnlhMjIrdXhpalgxTE5JSjJtUlVw?=
 =?utf-8?B?UXZrdlFCZk5aR01IaGMvU1VXazY1elFLb3IrY3dDNFQ5dVVzem9KcGYraUE4?=
 =?utf-8?B?d0IzSjdQSDdJVGZ2THg5OStUVEQveGNRT0VTZmhmWXh3eVhIZDlZbFF5OElj?=
 =?utf-8?B?d2pNMDlqenBOem9SN2wrWVZPUHRiNDB3WDVKNGZOT0lOeGZLK1FqTnlML0tz?=
 =?utf-8?B?eTYxUU1GeVRMUzZhbXJPZGptejZtRFBncm0zUk1yZnpnclp5b1NQR2JPQTRJ?=
 =?utf-8?B?T3BKdE05TFgvNmVkNFJaWGpPL25wcUQweloxcjVSUFBTZGNNV1VSZ3lTamRX?=
 =?utf-8?B?QnJIUDVxVURGZjF1d1oxUHFPb1B1NjlqWWl6T2wzV3E3akV3Y0RVcWFNOEFk?=
 =?utf-8?Q?Q9LGAmokgYInLpdA9VEPH0Dm9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadb11a3-ba87-42f0-2fd2-08dc2ebca33f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 06:58:10.6724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8ZVSjWXcskNVao7JNASMkIKTey8VWUWL8rWxkTe38+OV27rxj4852e9XlVppd0rAdP8DY+CKiSJJ++47sYRbR7xyOl3zUafVDIVD2yZpNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8761

PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9jaGlwL3NhbWE3ZzUuZHRzaSBi
L2FyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9zYW1hN2c1LmR0c2kNCj4gaW5kZXggMjY5ZTBh
M2NhMjY5Li5jMDMwYjMxODk4NWEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL21p
Y3JvY2hpcC9zYW1hN2c1LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9jaGlw
L3NhbWE3ZzUuZHRzaQ0KPiBAQCAtOTU4LDYgKzk1OCwzMCBAQCBpMmM5OiBpMmNANjAwIHsNCj4g
IAkJCX07DQo+ICAJCX07DQo+ICANCj4gKwkJZmx4MTA6IGZsZXhjb21AZTI4MjAwMDAgew0KPiAr
CQkJY29tcGF0aWJsZSA9ICJhdG1lbCxzYW1hNWQyLWZsZXhjb20iOw0KDQpNeSBjb21tZW50IGhl
cmUgd2FzIGlnbm9yZWQ6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDAyMTQtcm9i
ZS1wcmVnbmFuY3ktYTFiMDU2YzlmZTE0QHNwdWQvDQoNClRoZSBTQU1BN0c1IGhhcyB0aGUgc2Ft
ZSBmbGV4Y29tIGNvbnRyb2xsZXIgYXMgU0FNQTVEMiBNUFUuDQoNCmh0dHBzOi8vZ2l0aHViLmNv
bS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9kcml2ZXJzL21mZC9hdG1lbC1mbGV4Y29tLmMj
TDgzDQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbC1mbGV4Y29tLnR4dCNMOA0K

