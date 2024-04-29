Return-Path: <linux-kernel+bounces-162588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45C28B5DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF7B1F2511C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2211D7CF1A;
	Mon, 29 Apr 2024 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="uZzJ9niU"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163F7BB17;
	Mon, 29 Apr 2024 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404453; cv=fail; b=mMNzXogv2FKBZxXtNWjk72tbwIxIHXdzj9fKd/CzEbwv3TylJYslTtZh+nGFj6APDo34bUx8qGhMRFDVIXTgC643bskacdzccYjRvez4f4/0oVblTqxA0+p/i2/pRiehWMCWut5e+K4ShMrzjJLKapnUE6JxvcU+rKl5M0Hz5do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404453; c=relaxed/simple;
	bh=f64kwjZNweyDQO/G43s9BQ5i6qigkusRM8Ucp2Nc3y4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i4ZWoAiG9ayvYXIfGeSPqfr4Yd3A/75nMx+Cuc8tyk83iWS653Y8YdUJgt4uIOMn7bOqmbIl3kBSJXzQlQP+GM//vQrJpeKTfIeJdzDnrE6aK+3QVNrUjF7XRWwkelx3bjVUzKVtxNscADbsjyelg5BCvM4b/lkbmDGXk0GNKPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=uZzJ9niU; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T3vVK3005327;
	Mon, 29 Apr 2024 08:27:25 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xt43aumwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 08:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1UyqPYzTKsmqYNQnpOcDYAXp5fukddjLjhS5XKghf73iZEhfyWTGJV546zqxqsMEps8EbcugcPgyBU7dJaOLnaTvhbjEc1TVmRTMrwseQ6KYXUSuyzUOXDfgeHCmliz67Mq+HVdduFem6THVa6HJG2dp16Flgm9yqA/oJsjLdAqdaDx6e5SV8eCPhD5f8IEGDjo/tpnyFotGXaSSin9vsuqTwyxDjNsJSWc0oaI5QXnk2uI3tLq39dbbtY3jvDpxDM/AOuzwViAyYiczHmzmMayPl2pEFaZ7mBkTHc4B1WpKDxurn+M0z/5lTkcwuuaLoDuw89Hgggvr/Qpyd2O9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJmiqj0Z6/KCTY7HAYGb0JLrnw3XWh15l6MdO0EIRJQ=;
 b=L2zjmkmd7dAk0iqGVHR8fj4R3MAntUBMMqagYxsBH4cI87KupPDL30ZGPfU0uyC9k3yHIkJh+2OvTANxoNB4xRLvqmcyv282BvlWgOKrq7bdJJM0upynknJajHVoHmlcVMvBJVPGgSDm/E4JJlNLk19cWso9Q5hHDkH2ZnTBdWnNUFMcHAMbx94nk1EhzhdTLaTMenqcy4+ZowseQ8eEm6BJdVzr2CdoMYcey5ai9o3xewYrEwLGhottTw9D7JbQIzUuW3l2vXZdQ3amaZJTfbezOfb9YqnbPO3mgpwaFZpgHQXFb7LFFl8NbWR7yRlFQpCaSYYqNXTT6ZYWH89dkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJmiqj0Z6/KCTY7HAYGb0JLrnw3XWh15l6MdO0EIRJQ=;
 b=uZzJ9niU1Hn9Yv2fzTaa6S3pIBEZzbCE0R/UJkugNT0xZ5KgaEKvRFhX/uXFP27bMSTpOkoZoradtI84Lafv+ED6HCCPcwjzxyVwz1jO76Y/yQQ55Wghd2alSKC1ZyVvp3n5u2mtJHQsUT0AGWLqCy89Ix4aY4rSehBcvlv9d9Y=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 SA0PR18MB3469.namprd18.prod.outlook.com (2603:10b6:806:9b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.35; Mon, 29 Apr 2024 15:27:23 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 15:27:23 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpawar@cadence.com" <jpawar@cadence.com>,
        "pthombar@cadence.com"
	<pthombar@cadence.com>,
        "konrad@cadence.com" <konrad@cadence.com>,
        Wojciech
 Bartczak <wbartczak@marvell.com>,
        Wojciech Zmuda <wzmuda@marvell.com>
Subject: RE: [EXT] Re: [PATCH 6/7] spi: cadence: Add Marvell IP modification
 changes
Thread-Topic: [EXT] Re: [PATCH 6/7] spi: cadence: Add Marvell IP modification
 changes
Thread-Index: AQHZE7g77QR4QGOigEOdIGFr7/+Gq651h7IAgwzhMCA=
Date: Mon, 29 Apr 2024 15:27:23 +0000
Message-ID: 
 <CO6PR18MB4098FAFE58A705F6809D8727B01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20221219144254.20883-1-wsadowski@marvell.com>
 <20221219144254.20883-7-wsadowski@marvell.com>
 <Y6CtGEmi0wZUKaxT@sirena.org.uk>
In-Reply-To: <Y6CtGEmi0wZUKaxT@sirena.org.uk>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|SA0PR18MB3469:EE_
x-ms-office365-filtering-correlation-id: f2f06a27-668b-4188-ae88-08dc6860de34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?aqWC4STEsEkxI4aavqSCV5IjTYZM09TRMuPAjR1TFHvofRdzkR/RoQDl22P5?=
 =?us-ascii?Q?yTCnB2vpP1KX5zYZKeELtX7xe+3SEdgWalrQXkowAW8XRUfUl7w/ykaDBYKC?=
 =?us-ascii?Q?EVB7Jt3gtzrbG6MWlKknBKgumT/gI+X0cBdH+X4LcDsBTTOUVRM3GyFONI71?=
 =?us-ascii?Q?HBic4PqZJBGH8R8hqhaMvd2FCOOpnrfYzUSpwvse654SKjQQ1NgKG5cHFkEx?=
 =?us-ascii?Q?ENhQEM/PU0jMqmdk21SQ/jWokNh0vpVVHUCHRWYRWcNKF00YVxEIAJPocvNU?=
 =?us-ascii?Q?+XJX3WQKRfSyEygM4it2yQPa53nkOHaovO5dUYdzVlzGqQm5YkuHQVdp7GuG?=
 =?us-ascii?Q?kbspdzFjbhP1YCwFEjGtm++DMjyfU3O16dQ3lGU0BYewhVY/U8+9lFQsA4X1?=
 =?us-ascii?Q?Cn9XsNEyjaAlaC1ZR/nWX45Jm8mGexmdnY/R58GETS1KmSSQQRabp7W8slIy?=
 =?us-ascii?Q?6f97f5ewUrX4Sq77JXRxmaBRtxj9iAEWIABKnLfZq+qI1hCuy8nrIyfQUb0L?=
 =?us-ascii?Q?E3yrqGzs+PMWLmLWU+b9dn1fJD5weGe6iZ16eo1iamuMN8+ZwA2REBsnr/yU?=
 =?us-ascii?Q?fbbFgjZ41tXaBeMlAOWeuSSLN8pKlSVNgDT8Bftu9Flx2ndzJ+5/b1GsKAfJ?=
 =?us-ascii?Q?WtvqqYD+GYz+LkFQOVHSbkevNAfVHUuhDa/UgQqIjG0Mn8IlTmcF0hTW7mCt?=
 =?us-ascii?Q?m6WMYJjbUKHNdP3NVNObF2/maKzUPSj8OZ0GKEeDnOwzGd1clHATMAH86Gw3?=
 =?us-ascii?Q?ppRBsJNHxewzmyvd/65xQQ8UfgWLGZMF97empGToFi2BJtFihwsBBwyZ4+pR?=
 =?us-ascii?Q?dLrMCVMDVFkiVnzM4Q/kaT24Sk0/33Nnim7qusyR9Hdswbk6lJrUK3wKkLHd?=
 =?us-ascii?Q?D0H0y0nNRUS0jyAuOqR/sJcMHpwTSa8Beho4KaX69g4praeGSaJebJc1/1KY?=
 =?us-ascii?Q?ZGsC6M/Ygk2hTeRCIubBevlDVr84EpTzC0zDLlkrQQ2orCTjNOTcGtrIROFA?=
 =?us-ascii?Q?/Qd/UugSKMe+V4b13n+BmdwBOztD19CxNMWxYZV1nyFPE9MamV0jCc7UM9d8?=
 =?us-ascii?Q?2GlC+iKaoszZ3ofIIyuplM3K6hT5UBwLn8G3ydLuZa0BTMAH/u3sr2obEDw9?=
 =?us-ascii?Q?n17N/V3a17xOlRfyyoX2WYfHZyA0K1/g+Orir6q8MG0E5bX4CEgMo91eabCC?=
 =?us-ascii?Q?tynzjMUCw7GDvhT2tIdYgxH1hSW8WOS6pguPyA4fA1iXyO9+PxW+yJB8SJCz?=
 =?us-ascii?Q?v6tzEHt+dSpvaUP92zDgxYYu8y/cSc8wJgOLt803J7skuojB3seTvbS/qVSi?=
 =?us-ascii?Q?0C7wzcxC4lm0idMbCiaX+IVb8xjOu5qHA0q1GVskIOFsSA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?dCI/Avv151wLDm+/9iAum4d+zxE8Cm0Fw4C1pFb0TF0uLEfJFIDCFwr0ntJp?=
 =?us-ascii?Q?39d7gUZyG2inAC+EDU8fPaMK0vfO4PadOBAy2cNU0sqOVgvo7XZYA/zS4t51?=
 =?us-ascii?Q?Z07BqWlwUdNvpJWogihGc03aPK/a8C0dn+V/rUoRNkB6qhLMXOl1O4qXs6/2?=
 =?us-ascii?Q?q2bdDrpi+SC7HGw4B4nX1gTKiM6OzLHngwydOnUPO4IMnH69bxQvXhefsD3R?=
 =?us-ascii?Q?NRLMT35kwvY+dSfyCs+uWkplk3xAdLzu1ttHwL/pm1Pub18zxV/M0eAlz1p1?=
 =?us-ascii?Q?wR1YeVHmZIky7f15SU470TdKWXd59QBByeiiBrXIZoNxvxCjf/iEWgJA4O2p?=
 =?us-ascii?Q?wbA+kptqZ4hzBUn419qW8EGyT4qGrOVPMPki/pj9xZbmSBkqP7dofqVuqxoY?=
 =?us-ascii?Q?s1KAICoM9PSY6v1mAOtBq66osZhK3E7xuHeXT8H/t1kcPOj2JE5GOkAJoLRx?=
 =?us-ascii?Q?/wBnGXkTkM1n2SIQ/AtMN9oz4/RuLnwgpGx5urJGQM4t8w1ugeJeBlhYOeew?=
 =?us-ascii?Q?ivwInLDNawFnhmErctlz2yLO9qmuB6lWxXwgAPA8HagWFYp2GQlgQmwMGlH9?=
 =?us-ascii?Q?Oiy5AWmthaQhrBrzCXyZ3sGEQoRAkTGKMHwK1WezH+9auy0O/QZaWrqV70XA?=
 =?us-ascii?Q?qjHHmVH9/QWl24xLrJC5LFfc6SIvgqA7WoRim3Dp2kwqMqvzTeSxZ8FjS6jq?=
 =?us-ascii?Q?OfhVibysEixiR431ACnNLObrnRyhBzIXo9udt8hp44TUTpSLKLhtgcXec0m+?=
 =?us-ascii?Q?z16HcbPJXuMTDCeaZl4n0pN/zaMUZifgvQyBESLWVHarqF8uLiawf0U9H/Wh?=
 =?us-ascii?Q?3hSRhv8CXsQPsviYQqys5MrfibV0SJt8oRy8i1/933vY/XsQBpfjy85qGpk9?=
 =?us-ascii?Q?ZcE347DKMIHsYqPrq3jU/z4Y3TIk/EOgHZc+GiNt63ztj5ERYjiHoOzavvUh?=
 =?us-ascii?Q?I0Fge1i59UDTTO6kWuk/JoQPn7J0SLIfBJ+M5tiR47peka+Cq6BGQioDL1J8?=
 =?us-ascii?Q?odgbPxzCg8raEFdkroWmHd26EY/zZA1NktOSBGH6Z+CiylKwUUSlZyuZCqrf?=
 =?us-ascii?Q?deXRCVLBB5cfOrlRvT4ArftgYQi/mDzOnord7tBDmiCnd5QSSKsQNGxWoh6p?=
 =?us-ascii?Q?b1fpHNip4mwlLdlU9MVtLIU9O1R8884o0vom2Fe9lNVqH9YLUw/NKmgl41G5?=
 =?us-ascii?Q?Hv/MwERBHP4gsFAsbj8GueScHWrsoGGsCc/VzdG+DBpn28yj9oS8ahFlf4OA?=
 =?us-ascii?Q?zANJ8t8wQ9vygmmdcecSmzPOzO1fooVTbx0ks2K84U1fNaBgmMDiIYaCgszP?=
 =?us-ascii?Q?sdmJvCovi24idsc6sIYpF9MVxi468fdvt7kEMdtXIZP3fwXYbZUJ/1EjN+LF?=
 =?us-ascii?Q?QU1AIc9PAjj9NldtCiWxorI+hWua14SKBfxwkZz9+88Wxt7nLY+U1Ek27jB3?=
 =?us-ascii?Q?Fo5awKY+zML14IfVVAAeStS4wuHuPMv16CuRdjSJ5zBaD1oVvjoJX0bo08bp?=
 =?us-ascii?Q?mvQfm151+3emB9Co3aVW+cN6LTf0yXgQBBBBvT9i+VjelsICCpW9pxSkTczi?=
 =?us-ascii?Q?9ij16nSDkU7tMS54G8GMLsLoxDi4JSWzsfrIia+S?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4098.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f06a27-668b-4188-ae88-08dc6860de34
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 15:27:23.3656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PaO7H+qT+Q/ii7T/ma+wiYtUr8yQ64CwR23HUVdmTTe8i0ACKPA1OBd39bEx/njgdrfBvCvhDyxm9pkoVBtyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3469
X-Proofpoint-ORIG-GUID: DnHPGZ_ZmIdfJN8PQuAqrHw5GsB2b7gn
X-Proofpoint-GUID: DnHPGZ_ZmIdfJN8PQuAqrHw5GsB2b7gn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_12,2024-04-29_01,2023-05-22_02

> ----------------------------------------------------------------------
> On Mon, Dec 19, 2022 at 06:42:53AM -0800, Witold Sadowski wrote:
> > Add support for Marvell IP modification - clock divider, and PHY
> > config, and IRQ clearing.
> > Clock divider block is build into Cadence XSPI controller and is
> > connected directly to 800MHz clock.
> > As PHY config is not set directly in IP block, driver can load custom
> > PHY configuration values.
>=20
> What is a PHY in the context of a SPI controller?

In that particular driver, we have to set control registers to predefined
Values, that depends on feeding clock/internal architecture etc.

>=20
> > +config SPI_CADENCE_MRVL_XSPI
> > +	tristate "Marvell mods for XSPI controller"
> > +	depends on SPI_CADENCE_XSPI
> > +
> > +	help
>=20
> Extra blank line (does this work?).  It's not clear to me that there's
> enough code here to justify a Kconfig.

Kconfig is removed now.

>=20
> > +	/*Reset DLL*/
>=20
> Please follow the kernel coding style.
>=20
> > @@ -328,6 +468,9 @@ static int cdns_xspi_controller_init(struct
> cdns_xspi_dev *cdns_xspi)
> >  		return -EIO;
> >  	}
> >
> > +	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE,
> CDNS_XSPI_WORK_MODE_STIG),
> > +	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
> > +
>=20
> This is done unconditionally, will other instances in the IP be OK with
> it?  Should it be a separate commit since it's affecting everything?

You are referring to mode switch? That will affect only one IP, different
Will not be affected.

>=20
> > +#if IS_ENABLED(CONFIG_SPI_CADENCE_MRVL_XSPI)
> > +	writel(CDNS_MSIX_CLEAR_IRQ, cdns_xspi->auxbase +
> > +CDNS_XSPI_SPIX_INTR_AUX); #endif
>=20
> This is not how we do support for variants of an IP, we need to support a
> single kernel image for many different systems so variant handling needs
> to be done with runtime selection not build time selection.
> Please handle this in a similar way to how other drivers handle support
> for multiple devices.

Ok, that was reworked to base on device-tree compatible property.
Also, that part was changed in v2 overlay.

>=20
> > +#if IS_ENABLED(CONFIG_SPI_CADENCE_MRVL_XSPI)
> > +static int cdns_xspi_setup(struct spi_device *spi_dev) {
> > +	struct cdns_xspi_dev *cdns_xspi =3D
> > +spi_master_get_devdata(spi_dev->master);
> > +
> > +	cdns_xspi_setup_clock(cdns_xspi, spi_dev->max_speed_hz);
> > +
> > +	return 0;
> > +}
> > +#endif
>=20
> Note that setup() might be called while other transfers are in progress
> and should not affect them.

Clock set function will act only when actual change is needed. And it seems
Changing the clock is not affecting xSPI block

Regards
Witek

