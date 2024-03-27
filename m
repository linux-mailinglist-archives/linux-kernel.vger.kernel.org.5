Return-Path: <linux-kernel+bounces-121671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CFB88EC20
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBC01C2DE62
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5446514D6F7;
	Wed, 27 Mar 2024 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="gYExkU2X"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9312FF99;
	Wed, 27 Mar 2024 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559321; cv=fail; b=TO2QuYgt+pR0dEObFqnqVBbt4Fm5pmQPubZiri7WbLVO2BHEkx1soSXlijDlLacrEP6X9WXNkPEcprfhEjs1F8REuO5JeUkP3CS3AmDpPC3v+WBwRdDMfx3Q8n1J6egMY3LWytU0sj+htdbmi+AirlA7LjGvlb3eH95qIaegjqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559321; c=relaxed/simple;
	bh=KZKCqjEW5wsjjwUTF+/V+F9e2ZFxR0JF3XbTOkLRRww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Am6hfmPmI9lbrkv9S1mVzhe2reId8N6n5PtYy3tvYUwRp96l7/s5JkhROFzvtX3FN7qYHf4eDSRIDrdwf59HgiYamcVJAfzqly+7g/D+3g6Ox6bBIaye/7NWlPQZd6AMHengQgHzHIJeVRemxDjM5gfspeqI1L5MTyED7yE+QUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=gYExkU2X; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RALhWt002476;
	Wed, 27 Mar 2024 10:08:26 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x4hmp9sax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 10:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOw3rX7f0QKQzkwZDraSjrT/JGaLb12Wq9hOZKnVlFSpTNhiIrIgAmIAxtz0ZHnhz8GE6KvuVDxmcIAkFQFAaL8oXOkF/SnSQ1H+w+zsAnbIE4KemhdyZjvrTQEhRH/yur7HX9PIhm/tpwd0RNspnPztKqx/T8EnLNS+GSD00G+ZR4V6IAy56mndWtqLdSZIcmG6ZD2G7xrWS1MJgMrZ687AFNh7k36GUyCFTwO1WOhD26TBzyKOgNdDUwsVG8FlNydohR2K8QNv94fn/bqWNGUR10qcvphR8H6cvUkfHOxIWZHDxBKjpUDgDNPI9cnzOq7p0kkYYxOp52YerHCr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SE401zh08/RRXlrXAYy5Cqke3RJc4qWkmTf5JP+hehU=;
 b=FbLjZzd41ULW5dGcnUZMpwtyySrWVojy8gx08vLUxKRfC0jB2O1fEshWoae/y//4HmOz7ht8qKV0SLaEkZSCnHG9FIfB3tQdVhG8QrhpFCBRy01C33boMXAj6JzzVkHvU6XTiNlSJ8t7uQX2Waf7lJxi9FDrjI2rXhsVU36XRjEK90TOYBEMsVYzjs31HcP0OF3UZNEPr+LTW7wUooggo2IWAJAJ8X3Ye/4IvMQe8/Z3mQT8huS5GYUz53Lkrh5pyrVa2DhSq3snZ6gbLaFaAjiFNC8ZI6nRYgYaoV59c+hr/w7XIwzyaxjiqF4TWIjHz+CBVO/lQI6VgWvixVhuIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SE401zh08/RRXlrXAYy5Cqke3RJc4qWkmTf5JP+hehU=;
 b=gYExkU2XPEqP4mnrVAvJP2POojkvhKR1mJzoigNJmHisUcBzquTHAXjyfFdTo6p4AP0c75/z8mWNdlJn/ULbNmqm8Bjo7xOpCnlemDT/yKkp6aAZ7ViQLNqCBATiNKoX6+2r44wLbLxO7q80/fj7YkwhX1bFdJ8XGDcLamgo+30=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by DM4PR18MB5146.namprd18.prod.outlook.com (2603:10b6:8:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 17:08:21 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5087:a566:c473:1fef]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5087:a566:c473:1fef%7]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 17:08:21 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Ariel Elior
	<aelior@marvell.com>, Manish Chopra <manishc@marvell.com>
CC: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers
	<ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt
	<justinstitt@google.com>,
        Simon Horman <horms@kernel.org>,
        Konstantin
 Khorenko <khorenko@virtuozzo.com>,
        Sudarsana Reddy Kalluru
	<sudarsana.kalluru@cavium.com>,
        Netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 3/9] qed: avoid truncating work queue length
Thread-Topic: [EXTERNAL] [PATCH 3/9] qed: avoid truncating work queue length
Thread-Index: AQHagCfC+qakUE/9NUWNrCxJqKFS87FLnkwQgAAZ6oCAABoNIA==
Date: Wed, 27 Mar 2024 17:08:21 +0000
Message-ID: 
 <CO1PR18MB4666CD328AFA8B8EE49B389AA1342@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20240326223825.4084412-1-arnd@kernel.org>
 <20240326223825.4084412-4-arnd@kernel.org>
 <CO1PR18MB4666DF3B7684D340C3A3646DA1342@CO1PR18MB4666.namprd18.prod.outlook.com>
 <6242198a-8559-4465-918a-36442ea03e32@app.fastmail.com>
In-Reply-To: <6242198a-8559-4465-918a-36442ea03e32@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|DM4PR18MB5146:EE_
x-ms-office365-filtering-correlation-id: 019c2e2a-3f18-46f5-3401-08dc4e808160
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 18hZ1BmpCkqVCW+qvPARiCHWlPgZlf5YDrietL5b7ti7NqbJa0l0T+Tk8j1zyt+//pShXQ1ZQ9EoK9/BvtX60qiemk2QT/YFvrVAl12efqQDuYH22C/WqGJpuM0DLa7TsYVn+7oG+OEeNsVsz8y1IH7U22zOSz1f/paeEeeh6N6j7BJpjvSpD12LTeDt9GF6MAQ6cwpZCGTWMUc7ANrysT8hCemaozwcj1XhZCGwWON5H6FGC+Tzy/03Z9f4MpPosET3+40IsGuIClGP3ISWNAciZC/DZCKmdP91Vt91zNwbB0gSo1ef9FxaRwyye2DPpksX5L7i6h5HjpKVR1A4GSx3G3ap84GmXBcTbOvESib3C05QgyFwDuKkpmwOvyKL7oERIkK2PVRAL9ShvAM+4l1nM/Ke/UBQ2Muktv8ESIEiS02Xv/+BdE5BYHsnET3kDv+QFuv+UwNMjixIstC2XPCkbz26lpGsHnC0TgQkp7nqe/DDOR5gQkp7jbggLNrGnduuQyBZGr15OtJtdAFzOVqWXILnwag/niIfoZmQNOC/dYV3HC/0rSE5hGzQOHl/SvORqvA58RuxSpoq9vAy2Fo3Z6KYCZbYWf0R2ODWdcasoekxxNhZPo6gJRB0Y93qOakLWornTwerC2zoyeEgjV7BA68ZRQ5yTW12rGNhGmkSLOUGBpmNvevjYwRs1zX3hHpRR8+dceSSaX1XSxciqdzGlkw/NCl1m4C++1UmSvY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?pJiH66A9yOeYcXXz2KyJ7km7JoQgZGLeupEHEugplWI7pX54wNtK/qo+6XTv?=
 =?us-ascii?Q?wvnFAgheHqFZ95i9khCZDveDZ2HEwjgCYVNJ3T31So3QxT4sfAAlK7npf/Ka?=
 =?us-ascii?Q?3aExjmTfu00VJAV3ChwR4i3BfA866+hpsPE7caTMbn9bFCvI538y9gWENoEq?=
 =?us-ascii?Q?tTvMEtI58amqaJdjGk01HR7KSuP66hBtgG/kQIXDoD02c3SXZyHs10q8rC21?=
 =?us-ascii?Q?PpY0uCscOrkFNA4jNL4Z2+PDWsBTyvfS0xzvwMEh9VqjPAxMslXzgCJqXli6?=
 =?us-ascii?Q?7+LI+H/cd262nyD78n7Xzku0u6ncSfxaePTRmSoSOY6E5lvfO3/IwddGtd8T?=
 =?us-ascii?Q?j4Sx+KVd3t1xx+jHiQ3lXgI4nVIklY+oGyORzaGWzC32MtvikH2kSbFmmT5D?=
 =?us-ascii?Q?7c82WP4JZ17S3jPI/wDoBHND8j0s5DCxtGeur3QocRMkhS1NdzrZHkRY0okZ?=
 =?us-ascii?Q?jzhS2HbONxNEDzDVFArPBL415FgCdlkMMtzXmK9e40mI2yEBSHMIOpV1iISy?=
 =?us-ascii?Q?zbfGLjqk3zOy8nGsaCTjCUEdA27w3O1V885A+tWD645uoXB0B1C9PxV4ar+9?=
 =?us-ascii?Q?7NQOK1m6WHWCIPuo8GwFgzpUt7ZRwHMOjOhlWhNYhlEPZXAnw0ingOHL280Q?=
 =?us-ascii?Q?QV8R8o2upHIl5zgS0YbhOixV7QCa8GzNuygKsiyL+QKLedeNZi/M4IJ2vuPx?=
 =?us-ascii?Q?jvltEqFsFhRCNq6hdEeZqrJRS1oaXeRz9B62QyCbDqhkkQpzSF8IisbYcmIq?=
 =?us-ascii?Q?kps1fWBmOgcgGpfiqOEhFQJGC2xvwzFUr/v2CbQcPzicgsWVv0Rl1h9DVBCz?=
 =?us-ascii?Q?6wQOOwZDJdNXMLwRFqe8EtsSciAhOBZk9WfIQHyRaDZt02qc9QZ1FgRVYp3s?=
 =?us-ascii?Q?vdL2bn1e7J7GDLlbKG9I7bIhF+mm9BmRlVhXqLyLnU07xHxnK0WuXrFRClEl?=
 =?us-ascii?Q?REV+dmNrGdfBWFIa8NqfVQfMkzzPPAb1QQmpMESw7ppUCcS19GopmKepIqxX?=
 =?us-ascii?Q?Dxm97egUIYQmft6r6hJdMDWoDrZ2W8/kRzcKjyYpr1TukJnu2cjuwYMv+h0E?=
 =?us-ascii?Q?z4fUS5Wlo5g0XevIjDHIeztCk4c3zy5xiWpojSY7HB3BqYBsh3yYv5Uxzcv4?=
 =?us-ascii?Q?Ig026inyFHQdK9fvXll3SOxHSp1uwONUHDrjeH7PYER6ZyOt3BVJeQ8qMTfC?=
 =?us-ascii?Q?hGu6l6qW473/xZ5mgYZrYLYRSDZiwClwMoF/lE6nvNCWTyuX8j4+YvIah0Ns?=
 =?us-ascii?Q?OQl9uwW8ZPbvAaldtTYVFpyBt1XD4khQa1YPVXqBKTOrNBOTLmQXqLWkoDeF?=
 =?us-ascii?Q?ngEyGk3PQpMvkhnhsBnsGjuH6QXzARDv770nCTbfFdGfbAmpLc0qBiSw/6TP?=
 =?us-ascii?Q?oZ4cesHc13wC24jwWyMihjvB4Dteo3ragauqBSeidDn2aaQbI7a9gJI5faUL?=
 =?us-ascii?Q?F5IFWoRPNKv00sImGbAcH61hrVVcKQx0tD46f3o3pqxB2RrUDjNwao+zDV4a?=
 =?us-ascii?Q?T3T6MINhtGWTvimHS+x8wvmFKl5nhBIn3oTIxwKdaVTXAofPpoZMBfUg9l3t?=
 =?us-ascii?Q?tRnAmfiMgl90ONT372lR8tzuZaqGOI4sBWjTCbtT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019c2e2a-3f18-46f5-3401-08dc4e808160
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 17:08:21.2505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZ7+wPCJKqPh0L/U6X3OW5/i95UXQNEe756hPX5oA9s5+7xZuenNVvrL8PoDLNYRnp7sEOPrxuN/iYWZw7/CUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5146
X-Proofpoint-ORIG-GUID: ibsyrP8y627W6eK70XDI9Ue7-4QGo-mO
X-Proofpoint-GUID: ibsyrP8y627W6eK70XDI9Ue7-4QGo-mO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_13,2024-03-27_01,2023-05-22_02

Hi,

>-----Original Message-----
>From: Arnd Bergmann <arnd@arndb.de>
>Sent: Wednesday, March 27, 2024 9:05 PM
>To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Arnd Bergmann
><arnd@kernel.org>; llvm@lists.linux.dev; Ariel Elior <aelior@marvell.com>;
>Manish Chopra <manishc@marvell.com>
>Cc: David S . Miller <davem@davemloft.net>; Eric Dumazet
><edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
><pabeni@redhat.com>; Nathan Chancellor <nathan@kernel.org>; Nick
>Desaulniers <ndesaulniers@google.com>; Bill Wendling <morbo@google.com>;
>Justin Stitt <justinstitt@google.com>; Simon Horman <horms@kernel.org>;
>Konstantin Khorenko <khorenko@virtuozzo.com>; Sudarsana Reddy Kalluru
><sudarsana.kalluru@cavium.com>; Netdev <netdev@vger.kernel.org>; linux-
>kernel@vger.kernel.org
>Subject: Re: [EXTERNAL] [PATCH 3/9] qed: avoid truncating work queue lengt=
h
>
>On Wed, Mar 27, 2024, at 15:04, Subbaraya Sundeep Bhatta wrote:
>
>>>-		snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
>>>-			 cdev->pdev->bus->number,
>>>-			 PCI_SLOT(cdev->pdev->devfn), hwfn->abs_pf_id);
>>>+		hwfn->slowpath_wq =3D alloc_workqueue("slowpath-
>>>%02x:%02x.%02x",
>>>+					 0, 0, cdev->pdev->bus->number,
>>>+					 PCI_SLOT(cdev->pdev->devfn),
>>>+					 hwfn->abs_pf_id);
>>
>> Confused. This should be alloc_workqueue("slowpath-%02x:%02x.%02x",
>> cdev->pdev->bus->number, PCI_SLOT(cdev->pdev->devfn), hwfn->abs_pf_id,
>> 0, 0);
>> Right?
>
>I still think my version is the right one here, see the
>prototype:
>
>__printf(1, 4) struct workqueue_struct *
>alloc_workqueue(const char *fmt, unsigned int flags, int max_active, ...);
>
>so the first argument in the format, while the printf arguments
>start after the flags and max_active arguments that are still both
>set to zero.
>
My bad. Got it

Thanks,
Sundeep

>      Arnd

