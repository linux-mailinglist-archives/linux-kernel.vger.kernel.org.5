Return-Path: <linux-kernel+bounces-110488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5F0885F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EF91C2094E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D584A28;
	Thu, 21 Mar 2024 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="WTbukJoU"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69B16410;
	Thu, 21 Mar 2024 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041753; cv=fail; b=BWIyU5L78g8XGWKTfpRE0x7Opc1ANAgcaoAC1JfEzE5tSAJVg/ph0U4bfTKsQnU4NdvYV1hCwSVnh/xHb2xws0fRjgXZ1mONkS1fk86VYlhjqMyNXkyl8xxexLemrBw4yyDyJz8E348h55s2RQ7b+bLyr8uGhCRhVtr2RGkh6Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041753; c=relaxed/simple;
	bh=OhkM2HNMeBU5OmW53EeTDfaMfSjlI0VtUNysCthVwKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Echx2BKLtOLatdR62QXGP/g1wRllN+hPSAQIJid5SOOy3buVrIiVyw+gBu8xAe04ql7A49M7BUHr1cW6w8u38pg87jTUMnSyQCOvsqXP5zgV5q6yXQsHfEC7GFYu+zVKydqYEXuViy51mzhzXn3QyDYX09ptrUNex/xX/6uWd6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=WTbukJoU; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L9GnWP001448;
	Thu, 21 Mar 2024 10:22:05 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x04cuv5wu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 10:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgiydwIOd82FoAytEeyUlWhlj393H5tjyIZEuRiWvoX0451uZOQC5YVkZ3sFa1bJbdodM2tkuelTyanz2IY+psQmaVyvpbjMfk3JLIadohjpFKgkpX4auzFvEfC+PZHnsoANiXF54bjvL63hfWNgSWEeqpHLdjiMR6rZzOZNBFPy89Xc0DT+pG2MsEW5YedUm7AGSz/RlihimkVJUOjhBHvKwh1SOdKqvodTIUrzFl2MeI5akIn7CswZ1TXyMIzlEq8gkE3K8ZGJ73eJzX7GMSSeloC87NsiJHCU4lLsGSbtVtQdYjS1aBz24uhXRwVPaUdedzfi34f+K+VFblQmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqExk0W6noGcJSnekTcmdAphbR5JhyfprQkzeppoib0=;
 b=NJSVFcL4gcPK5bS7xcuaJqMzku3GsrCsWKQNztO6XIdcvYJAdhWKbpGQ84YgmFAfKc/JQjLAdkhBZAjC0b/K5qhsV0tkULbOV9EpSGV/ULPvTNjSwDhEy7IySV/aSAFCE9G980CxTj6fcWwH0EEaufsxqZ54wMUj+oNHtItA1nbGfYcajQ5DoQ1t/Xh5x0ulbLXvcRZtte/cHxY2+ojV142VUlwCxW2XFTZ/xlnGqVH2ncFQlF8yEp/57G+1G99VOe7BLQFSkYRHPMxKYBzT8AQz5vNZO8qZodctRn5yUdf1gN9OoZncGdeOlfChGGgNEwHW5pcDm2w57L4C4TaM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqExk0W6noGcJSnekTcmdAphbR5JhyfprQkzeppoib0=;
 b=WTbukJoUX34Ky8N3HFEgaNs9QgOQLfqDENXqKfZ1qs8qqnlbhyCd4L4lrdOCd8X9OasvThGRn0rhZ3/5TGEA0x/zdxhZl4uzwQbNT6OiiLRvY3IKOT88bxlOBpw0yDUdtqGseW6H3wMJsDc5VShaedsvokS22OYF0warWWYcu84=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by PH0PR18MB5018.namprd18.prod.outlook.com (2603:10b6:510:11d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Thu, 21 Mar
 2024 17:22:02 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::7471:7657:9316:1494]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::7471:7657:9316:1494%7]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 17:22:01 +0000
From: Elad Nachman <enachman@marvell.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Taras Chornyi <taras.chornyi@plvision.eu>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
        "dkirjanov@suse.de" <dkirjanov@suse.de>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/5] net: marvell: prestera: fix driver
 reload
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/5] net: marvell: prestera: fix driver
 reload
Thread-Index: AQHaeur1JZLk7MSy40+/riWFv1ZU97FBPlOAgAEzX5A=
Date: Thu, 21 Mar 2024 17:22:01 +0000
Message-ID: 
 <BN9PR18MB4251367BBD2F9EB77679E91DDB322@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240320172008.2989693-1-enachman@marvell.com>
 <20240320172008.2989693-2-enachman@marvell.com>
 <d02e6c38-042f-416e-b5c8-96dc55e1fd5f@lunn.ch>
In-Reply-To: <d02e6c38-042f-416e-b5c8-96dc55e1fd5f@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|PH0PR18MB5018:EE_
x-ms-office365-filtering-correlation-id: c4dea6cf-b98f-421a-ed60-08dc49cb6bd6
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6i/wcmGLJXjzIaHicdtlkQd7/nbxKLB3TOpKSKIc/1csrA13ODWqKs/IReNSWPnNvZQ8Xu4XdqYOlPq3bjdvnUBYb0B73KDWslmyU6ab50iHbBGiksthw+UMRInnA7FJnU+ZL37/FBp2CkSrOFFBlj76bEYdTtLZ28m3/8DteOaqd/KRWZxf5zg6PGgRf7kSnIt4++Tg2pJrWPnhjyKos9hun2xFe2yf9YWc2tK4nvDLcdjb/WszrwQLYiddw7gb8OG+KHsGIcR3urB2u1fsf295KACFin8uDwhAy5pg0NNxP8nyuhdWa8Z0RyWgn8dpE4YHOouknbCeFG8xo+NvMU1TG8UtI9GQ60C+P/u0i0AE4p1fd08ld7cyWr2LHcHkA7YOvTAK6VX+Xln9FDaIj2lHUpoC9G4px97zEiXcnOngx+1ZMpFNRYHNNSbH39aEOj94ZcZSGd2P2/KB9lKb5F5GLZMbPWnjLKxNOqEqVT4Sk8LPe2MxSY9zxrZDsHtCWFCk3K3796T+OrW3hUi2BNq3Ntrxh5gWL1Spa92f7HkRQivpqlMrsQCIlkE0BqVpKjQasWuZuXSjUU6jVN7qDUYWhfGZXsDgFPlhZSR83HjCDlpCBoMbUvr9NvrHZL3s992r4zzcOOKOiDTYFW0tl+rRFDM9iCKfpP3kuPz59XOuoxU19ikIkiGuryUsH+SRx38SqrwIztLkvuf6YKtavdqUvy0tDoizui4g2yRkjmE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ChtzwnMIVLt4y7o+Gp7WbKSpKjxGx6eVocqdRyf+knwc74UXKx7PH3yFIkca?=
 =?us-ascii?Q?wTDVEsxRCy34m+ZKay+V8IBEi49Yo20iifzw9UzRrQ8u2Lf0i5+osa7L24e4?=
 =?us-ascii?Q?/NCquymRho+rJocWz9RYrRo73wQQQF/mxzSCroUHLWU57S/rU1auzG9kIwrn?=
 =?us-ascii?Q?xI3p/GuR1cEXpNT1qq2ZLkqtU++JUhtXgkVibWtHbWcocp1Z9qpnesJFmwdj?=
 =?us-ascii?Q?Q7z2OgztiTl2flC8lfgF3lMEPdKyAtXKgzrm/jMi+Htqdk/fdbKlm/2ebU5W?=
 =?us-ascii?Q?/7R8Q+8oLqVa7nhdrUny7bwIxb0AEmNh03KAcM+8S2UeDDLQeDhr2BE46xIU?=
 =?us-ascii?Q?hhaJVWnNkuQEz9WmKN2e38TK4tHO85u9oBAfaG5+xVYO1HfohFZlQb0ChHfy?=
 =?us-ascii?Q?zcguWUI5b8KmLRCu8y6/OrBf+KAQ3wNFnQJwxGERgKiYF6ln+bZuehOd/4NE?=
 =?us-ascii?Q?v/fLmxZ7h6ReE5zn7fZJAtIKw+0b4hggtNx4HG0S22XBwU1PBRKj3MqWPsnK?=
 =?us-ascii?Q?YsfD90XraRJmH0QoW+bdhFa82WVWSRWnXwo8u4FKtK87hyeOHOJtpf+K2fbU?=
 =?us-ascii?Q?2c0MQ0MRf20Ey4CW68TxZfUMNDiLmSiwYgv12xE954Ju/ZbD1bj0QMDPxWFP?=
 =?us-ascii?Q?hUVC1sGBnNLROswxmPodl1akTTWIxRueuO3KbldsWXSJbV5TEcG4AOdDrA+M?=
 =?us-ascii?Q?IwHkB+BLJchaIrJPpOQGEOgU1LBqv3Kx+3oinvKbV9/pwVcHr+znb6lvA/7y?=
 =?us-ascii?Q?vzKAbU7BiodlQdDpzt/WIjH+YU1l9/vJpEd03VyE3HT95/p3QP5HoJz9YuC/?=
 =?us-ascii?Q?Buboq2aqrOoRLa+h8MW5p/VPTUAY4aULRixfyg1wr/tHuRO7jhHImtJc4gyM?=
 =?us-ascii?Q?wDu4fn+K1QbPanQY5jIssdGcr6NkEG7afJHbD25YuYNHojNcm0Edrp+IEKev?=
 =?us-ascii?Q?7duGZ6KddOIMupQUFT56Zkv2hSIfrpYqSVV0dDyXr4VVnKgdHEZRqKRWJk26?=
 =?us-ascii?Q?QLB9z2l3tU5j6JOL3kGCfCpKcXm0Swf+08vW5mXIPCJpPzCMm2Sxl0XO6auU?=
 =?us-ascii?Q?B3/TKEnDh/CDlLqSB8SIsQCyGOn4alKWJr7o8F4Wv+7LxkP2rspz26J6MSB7?=
 =?us-ascii?Q?xu6b3YNT5V1bfKVrnNMlP9a3E0Ze3cNLkIaf1/oTR2s5uW1M981meQK+Ca/Y?=
 =?us-ascii?Q?0FUKbFpMBuIF0Ij6SjXRErxYL5VUeWi2z+WkX5etnaWGQ/X7Kqua8wCLNpYJ?=
 =?us-ascii?Q?9d+vAdtt7LoETMdIyk+IZlPJdPHpI56RvJxJtvaJ8VB06bmj1ZgB9CPz10lC?=
 =?us-ascii?Q?hPFLWUW3RqQRzj43gYQaSfj2tOQnMMOrTp3P8rWMgnXd2x4ZRdVOtxeWp8KO?=
 =?us-ascii?Q?kBLYG4kuYwrOuDiz/ZuMHz4RR+PLJdua64yGUIHv70OtkWMn7qiTVpH30YU2?=
 =?us-ascii?Q?8vnQrHJzE6nIZmhNgbD6PEm6dcCo+Fwqqy+Fj3AyMzNd7Y0EP+pNs71jN+Cp?=
 =?us-ascii?Q?slO1z6qiiLLljjSb8QL2TdOApRzs9mGIXEgZ9t/N3kxEhX0EaHB+OZwrt2QD?=
 =?us-ascii?Q?g8JsYtLWBeDiorYp7jKSeThnCM2bzeb7iTzftyEG?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dea6cf-b98f-421a-ed60-08dc49cb6bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 17:22:01.6162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSqfTmD+mgsv8HtYmqstc9bWAgxGl0fjMGq0yLeKMMeHe++WZ/UdV/ouft6KPneA1rtW1CPtdl+o7dPq4I9r/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5018
X-Proofpoint-GUID: _CH7fYfE4rqG9p1XX7yn23NWFPjvxFNg
X-Proofpoint-ORIG-GUID: _CH7fYfE4rqG9p1XX7yn23NWFPjvxFNg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, March 21, 2024 12:58 AM
> To: Elad Nachman <enachman@marvell.com>
> Cc: Taras Chornyi <taras.chornyi@plvision.eu>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> kory.maincent@bootlin.com; thomas.petazzoni@bootlin.com;
> miquel.raynal@bootlin.com; przemyslaw.kitszel@intel.com;
> dkirjanov@suse.de; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v2 1/5] net: marvell: prestera: fix driver
> reload
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> On Wed, Mar 20, 2024 at 07:20:04PM +0200, Elad Nachman wrote:
> > From: Elad Nachman <enachman@marvell.com>
> >
> > Driver rmmod after insmod would fail because API call to reset the
> > switch HW and restart the firmware CPU code loading procedure was
> > missing in driver removal code handler.
> >
> > Firmware reset and reload is needed as the firmware termination will
> > make the firmware loader change its state machine to the firmware
> > loading state, and thus will be able to load new firmware, which is
> > done at the beginning of the probing of the prestera_pci module.
> >
> > Without this reset, the firmware loader will stay in the wrong state,
> > causing the next firmware loading phase in the probe to fail.
>=20
> What is missing from this is an explanation why you need to reload the
> firmware at the next re-probe. That just seems like a waste of time if yo=
u have
> already loaded it once.
>=20
>     Andrew

Unfortunately that's how the firmware loader on the firmware cpu state mach=
ine works.
There is no ABI interface to verify which firmware is already loaded, and t=
hen supporting
Warm boot reading of the values back to the kernel.
Since many of these firmware binaries are secure-boot protected, upgrading =
is very tricky.

Elad.

