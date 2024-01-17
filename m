Return-Path: <linux-kernel+bounces-28544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB0B82FFE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720FC28967E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E2B79DC;
	Wed, 17 Jan 2024 05:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="R//zaiAr";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="F0SmdD0s"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585248F45;
	Wed, 17 Jan 2024 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705470170; cv=fail; b=f04UACWITLKzOSTvX7Qz4ADF7mGKi/4HMVAo/aiRJ9HLU2cAEDxUDpJRXjdwZLsKuCQwY6jfSwJuoCKWGo1jUnwoByU7q4eXyMGYCxA9XGCBQBCA0Bwxuyl/HGKfbVeKeEvzUSikNCuPRt/wY4lhymMARjGEuFjEPDJORNd0XVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705470170; c=relaxed/simple;
	bh=enB03P1DWlP+sMa5XrC1r4SQE/qPN4nj6vQ+6Ni5tgA=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:ARC-Message-Signature:
	 ARC-Authentication-Results:DKIM-Signature:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=UkmNy7Yia5Q7Nn6TtFckJyjF/EGlZRNx9ECg06K4w2BitrIX9H2kdYQoLalbioO39dlte16ePnDM0/DuVnU2EBwJic46R5yt4g0Er3qDr1TfmVWGgis9RDlNuhv6ENgbec/5Us4QXN4rpuiRb/54Wa8ObaDO2vXcMEYBvlIlsnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=R//zaiAr; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=F0SmdD0s; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705470168; x=1737006168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=enB03P1DWlP+sMa5XrC1r4SQE/qPN4nj6vQ+6Ni5tgA=;
  b=R//zaiArsyKJKRLf6WVpvWx++ugSbWoBPzMXbl4ppm/STQJL6HPwwefR
   9uULIKY9qeQP55d+P9MtNc9Sln3e+ijH1Isp9XJDfE4ionHcfTvgDBces
   6VhwEtaTb2uaCIpmJr7sR9j3M0Qfvn81MW45pG8se62BSfLTH4o4NhWmv
   3uX1gYFJPL0+uApLoZJc7OqLnYEoXTcnCKUViasxPtPVSxtUKUqxQnu2P
   Tn9XvMJUeT5y7OG5xBrkAT/khLkfQq5Ulkw1Bw748SN1zbsXM6W6HiIvg
   3ke7jShtsecSY+syOfygFb5CQ3JzVA3HmN2kHqRXDRk+HlGxTyyDgRH/2
   Q==;
X-CSE-ConnectionGUID: 9PkubHkSSp29xaoHmNquag==
X-CSE-MsgGUID: i7uM3n6HQJeeTcRMzgws7A==
X-IronPort-AV: E=Sophos;i="6.05,200,1701154800"; 
   d="scan'208";a="15326629"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2024 22:42:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 22:42:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 22:42:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obcz5CGA4irLZtgo3Jf7G5ljOQh+ocmzWsdHPw12DeH0gzaeuyRP6R97Gw6p+JkRZKWD4zyku1lmpqmXt4+9TP48gdpHHMntvtKpBFcEHCfPypZzvGlsTfqSriD7t8FFf/A6Vih7cWBZdBUzWcLkwTmP4SUqdttQBxNaQDE/fcVWfmlLc0rT1rxxgLf02KtTuz6Doq1HfsEtqPRBEhS6gXBsiKis1UUs7dWjdKlfhzHk0+105lkTdBC27ir5kHiYatiY4xIUp8C0hSMFqSuY5QkjAHuKP6kzilZpmkFNvmWPXlJHAQXtzJOz2sNWJXyjsI7PkVMTDkKGw//wjR5BVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfO6QQAeyOG4TQgbmdtYu8PcbZyususF+Wx3/4IKxYY=;
 b=RzwMgBKPLSRUQkMd3Kfol5dOmLLWPd1VWi3Ol35puTAouOPYnMi4bNd1wnVSP4hJ/bDS77oywNCbXiVq5bBnC4ihxnz/MQWQP8IdmFKeZx46WXfcAmRqNThbCt2FvHy+e57l8vpTiz/4qVFlgZU09s3RXnPFhMGVa+voJ62ACw73lFoBlj6f7LPWJjj0R6C+GFHM3fJuq/mAf0RLATOX7TE6uUmw1K7R3hors6fb2Ni70MeL7ki+rkbq9KJXQmNTdfjmdS8jqTB7J1RKgAXsGsHOhI8jjVBSttpozEqBFL2PZzPgY7o6mDXzcObNKLWtOKYfXMhV10Y3bJF67KWNWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfO6QQAeyOG4TQgbmdtYu8PcbZyususF+Wx3/4IKxYY=;
 b=F0SmdD0s8/Cprxp37Q14YWNV+YdZ7JHSp1Cvofp1PItAa3I3mwwFKvuDN7+XPpPHTupHKY3AomsTbxt7T4DFvNZ0VMINGTMZUjGAjlnOJeamvLMWicYhzH/eiZIuKP01bnL7M2RYmU/hkH8FmLPrMLgkTDt40Y3mLMW4t2y7xg4kvKGpZDKOcvV6J0xf1btbYn2qMtXoIViFlIK87+AhO9LEMAUlBP63NFBkjeQ80dCj7yjRTUa/0mE6dC7JN0Ua9GIOMjSQfsK4LkvG9XFwNZJy3KV6bwowY+pA64L3mBysxfxevgkOe1aLC+dg5CjzSYJQtu7Hi0aF68h+sjnAvA==
Received: from PH0PR11MB4773.namprd11.prod.outlook.com (2603:10b6:510:33::7)
 by SJ0PR11MB5133.namprd11.prod.outlook.com (2603:10b6:a03:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 05:42:23 +0000
Received: from PH0PR11MB4773.namprd11.prod.outlook.com
 ([fe80::9926:6fae:6173:9a4]) by PH0PR11MB4773.namprd11.prod.outlook.com
 ([fe80::9926:6fae:6173:9a4%7]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 05:42:23 +0000
From: <Divya.Koppera@microchip.com>
To: <Horatiu.Vultur@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net 2/2] net: micrel: Fix set/get PHC time for lan8814
Thread-Topic: [PATCH net 2/2] net: micrel: Fix set/get PHC time for lan8814
Thread-Index: AQHaRiLWUn+Omc/2d02iIkxM2gzv/rDdgzAw
Date: Wed, 17 Jan 2024 05:42:23 +0000
Message-ID: <PH0PR11MB4773E467B2A3A76673E2E828E2722@PH0PR11MB4773.namprd11.prod.outlook.com>
References: <20240113131521.1051921-1-horatiu.vultur@microchip.com>
 <20240113131521.1051921-3-horatiu.vultur@microchip.com>
In-Reply-To: <20240113131521.1051921-3-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4773:EE_|SJ0PR11MB5133:EE_
x-ms-office365-filtering-correlation-id: aeec6bcb-a1b9-4637-2943-08dc171f14b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qjUh8XRdATS4ieHQZgzFSixuPLaFqZHoaZegWpdVXX9cEE7cgqKdOJhDipi7OaFtnXPYCVwaM5/4U67lUFrhadoJXDE+4TcCDNW8r9gdv3c1YLgRF7E9QFMHqfu0MkNxLodfw8syCJrd3XHJohiRN9uKDi80Qmcwhvn2GDo855F0VfXok8ZC8re229WRrxHMO36JHDWGNOb1Fnt6Q8LHhP4oQwYbS/YZLOZVgejv3Mx0fRNudd0eo4j6o8PpizwAVLvdEZj75a9Sb644pcgTyufbUqooU3M9Fxvpd+cAhvquR8Ji9XsCVgb8UCIJCOOJJ3JkkeFTZ5JATfMcT+m49fiDa7TLLey+USQCFlIb6ZCDNx0zHzVWMjg4a0fTXjxJnC16Wk2jZzloedOCQ64WApBfDmfTrM0amPJNhDTRqGcGpuDG5m6xJyeYQB5Gq7vx7Mg1r6EUR59KB9X5b7g5x76DUMYLQBSauIMNWHddmM31OGOAMIvcd4+WtuV+QtjFzVoMg/l+np12MD4ZIxivHoF646Ff9FEwqdN5nx6JoYOxJKaXwxkeO5mzBlAdjm03pJd54DLZ3V5wGyH933llX6aRJpj4OXGEnFhcksqeAxv/7gQ8mTLlbxtFCQrG5MyV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38070700009)(55016003)(66556008)(9686003)(7696005)(6506007)(52536014)(83380400001)(64756008)(54906003)(66446008)(316002)(66476007)(478600001)(66946007)(76116006)(110136005)(26005)(107886003)(71200400001)(4326008)(8676002)(8936002)(122000001)(33656002)(7416002)(2906002)(5660300002)(41300700001)(4744005)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sOq8EMlb5VedNB+L8tGZmLbuxUS1eiddFzCBW4MqT4LTzVzWrAFXZkkXEf6e?=
 =?us-ascii?Q?g5dj2S9HdzXWqdkJsD3Ux+TJDa1c9LYwOk95rj5c0kqMHGCsDE2U34a+HLBR?=
 =?us-ascii?Q?vgjTs35DPqZ1Urp0QE7k3omZmL21aGfWPJWzXcL5eUIT6ge74wt4wXvanirT?=
 =?us-ascii?Q?DLTrz8kcPuMPNR3J81RAgr5RwWLfcnKty2M4nY1330lSsAqUqoZ+uNWmCQ6u?=
 =?us-ascii?Q?qXKbAKNmkOuMkbJkT9fbLGbSh0wQUPzvmySd3a1QcNwUO+TwhBHtL+CCWEVT?=
 =?us-ascii?Q?pkZg6JCpsYYOXEqaVoYp41A8Yy7VoUN2/DH391DAxwTtDLBf6f1mc/40iMBp?=
 =?us-ascii?Q?B4xohwGvXu4TF3xS4JXHn22WExBvqR5HSeyNG7/r13Mb131bcH+TWkKSgemP?=
 =?us-ascii?Q?8UbIxQ1QgxWZ96lprb1sqXTNAmst5ia9WRHM0eyYrlOvlfpnTndR5gMG6yL6?=
 =?us-ascii?Q?sHuD3FTG6gWRS9dJwbtWDsF0NdDMbiCG7nJjCjPKITrll//uC9Y5TwHlRqFX?=
 =?us-ascii?Q?zjgsF+flNzxUp9WEkf50looprnRiQaFZOb0cIdTmDjQwtlF5tfpdhIlSAUCp?=
 =?us-ascii?Q?BVgswEqNjBHcnf0ydy6b5kzdEmWB31u5Ovz/k5tojTkPtT97bFkbvtS/yOT2?=
 =?us-ascii?Q?4XPa+Op/kmi6OsLPE8qcGZNmqGYn4VFEMgGwjvUuXD+MfPKQm3V9OdVxq6NT?=
 =?us-ascii?Q?Cq5sZRrFn/Gtnevs5qUPlrkFsD19TS+6NT+jIrYYX7euYsxhJGtni9WXe9Fm?=
 =?us-ascii?Q?gx+5jsR4WClBaadlPCuMLDw2vNT+CJarlwBqJ0xZTM8k+yRDsyypKOCwnDEH?=
 =?us-ascii?Q?q+268jCpkLKG5pcggmwKSgSrKQyPa9VxqMDl2SaTJSx1JiXxluBNlqPwJwRp?=
 =?us-ascii?Q?UXVWcu6DBseNPTtV6+Umcd4MIN825f7kSCPZqesCn0pC3iOflsoCJ8my5xnC?=
 =?us-ascii?Q?jhPfYf2Afk/aCI27xwl4EEfQB8Z6FLI89SGFmCi/7+KPkESb4FfB/oTLMYUd?=
 =?us-ascii?Q?OjuMq2I4XC7ib6GJbD1zJmc3rvIDlG1fEyFmMU/wI1fruGYWFO0yX8iVNjHc?=
 =?us-ascii?Q?2m3F+zI8wsdgpQkLruyJfpr5+FobX6XeAOv0wTEpoCOMyB3Wb7jmINU4VJ14?=
 =?us-ascii?Q?eYmYapLGBsDeNjV5wmO6hstS980QKg3aQzV8ed8JKe/U2UOx9crfNDR0QOAU?=
 =?us-ascii?Q?epzNBDOAo0F/Mo5Js21nAy3eSWZjOXEZbJCsLGLB4iFeuVz9ZOsdjlUWhL5q?=
 =?us-ascii?Q?amceauQjx8s8d/6lE0AUmBQQSIc776QzikGAW+I+phVi2RcKWPE1nAg3iMRK?=
 =?us-ascii?Q?oi+dPmwjU8X2y+WWvqGurD+HvlplSo8Bq/ZDrRwK4cMKx7z7ibV/ofgOCPpf?=
 =?us-ascii?Q?FsoWZ8uM1gnpWAt1f226wpkuDOLZgdPEzt/7iu0oZz7b+aBiEcpHxypB9kpU?=
 =?us-ascii?Q?K1oTYXQxxtFJvoXpP7YA9dYQfEPgGTCWtqn+ha+2q27P7lQ5F0X6gfs2VIBm?=
 =?us-ascii?Q?H6WKzcWDz11Yq52+BNxYm77qmMWVlD3l0aE4HWhs29W5rJ0Iatv428Ij/NF0?=
 =?us-ascii?Q?4lqRJdP3iIfU/nlwFHE3omJT/qLrtRkuLtzvd+4Q44az2tfX9tMv88JE/j3R?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeec6bcb-a1b9-4637-2943-08dc171f14b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 05:42:23.8150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a0w3luQeRclZ/LeGmoebtGxjqSlkqBCH0vsLh9KMZ1d4uK/pu9F2oNgwk+oFJOXsx4wyFrlVaWY+TeJOeI/JCRzePHHfUSsFbCt0krlXswo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5133

> When setting or getting PHC time, the higher bits of the second time (>32
> bits) they were ignored. Meaning that setting some time in the future lik=
e year
> 2150, it was failing to set this.
>=20
> The issue can be reproduced like this:
>=20
>  # phc_ctl /dev/ptp1 set 10000000000
>  phc_ctl[118.619]: set clock time to 4294967295.000000000 or Sun Feb  7
> 06:28:15 2106
>=20
>  # phc_ctl /dev/ptp1 get
>  phc_ctl[120.858]: clock time is 1.238620924 or Thu Jan  1 00:00:01 1970
>=20
> Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Changes looks fine to me.

Reviewed-by: Divya Koppera <divya.koppera@microchip.com>

