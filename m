Return-Path: <linux-kernel+bounces-46462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12162844010
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366F11C22852
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED42F26288;
	Wed, 31 Jan 2024 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BKanfxLa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fbjQuB/S"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D725C14F75;
	Wed, 31 Jan 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706452; cv=fail; b=kz67gM855reVVHetoCkzB8gFy16AB9yIjHDJ60ESGZAcLa35JEigC4mPCSJKRSHSTjMnwa6ih0aVs6AOfUeFaZGZJUrEGhsCqRE1oUpxaHQMAOI8vvBiSRk85zhmxjk9BwIA6z8gxoIQqk/Z98Z0zwyMyHNCFVL4gK9bV6UT3Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706452; c=relaxed/simple;
	bh=Gc82kqebkkFt9UVdpLJwMTm+08+BR+NRzvc04yeF76I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L2cq0eYpht1tH3QwAD/CdyNv8DrLVUXaRn2z0BhdOYSpL14+KUdyBJDThNhPDjrjgHC5dZ7BbaKknjRilY4pVRXpyLjS5caynXlUQGTSw6I5r+SgLhGwhEOz6IpNI81oRDSHcZqzqX6h3NzCq01bBglLPRThWp+xO9CocmBml58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BKanfxLa; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fbjQuB/S; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706706449; x=1738242449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Gc82kqebkkFt9UVdpLJwMTm+08+BR+NRzvc04yeF76I=;
  b=BKanfxLaFl16GMdh6O/nvr05zxx61FcdVfKVSg3Gw+GCP1it7pkydecn
   aPJKjG9vr7+wDYAiCWJvQyIeBCbUa3tANErhsyDhSBp75g//1oKmcO+76
   Dg3quppDlLtQLiOCLl7fBjnAByE6ox2uKwvrjbf+4sKLaOVZbG7H3xXx4
   XL6/wLSVyEluFSXI0Qx9D7EIdUicAdRp1AXCjUvRh0N/EBbpOngZeOms2
   NZt9S/4wAgeRnOk0hNiCVBVbVYw3JXzgQbGIFTapl/1oHR+XTS3J++e3I
   PuhY6MWiuw4co7dITaiR0+qtMDxtUSR9qZYPxk1MWZ1/AtK709GUX0Mxn
   Q==;
X-CSE-ConnectionGUID: GOvt7ikFTdWfu3hQVN846Q==
X-CSE-MsgGUID: TDnXUR7qRVmtLyObPHOSag==
X-IronPort-AV: E=Sophos;i="6.05,231,1701100800"; 
   d="scan'208";a="8229841"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2024 21:07:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PebV+Fb8QUPA6I1u7BdIUlFFrSg1TsIgDHgN6RSQO5M8Iy1i78/SmqmnjtnX75OXA5e5x9Vr7SOFn+7arz4WRCEzBrDleZZhWT0qfdnDl6ZTutMmFf+nL+RspcVgB+Yf/sDB4aEHd7/8N1b9BPMG1eo90gmJrw1yoRdscqdij5hfVHJ0hUtEvtJavYzr2ePJC50YN1zUFpaEeKoszO4G/xVGf65A1c48sOANABqxSxn29YwwlL/PmA3o1fxtNlAdt6UP+Nmsk8JPI6lHUEZiDAoDEF2VyqU9jlNcZ+ile883XoLOGzKBsdf47B8dsX0LWx20mkmtNNg06IGiL1Uteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjF2et+4QBzrE1HK79FVQvXykq8j8u1bmS4KrYPfwAE=;
 b=CtA8448Bz2NKWBYrKv4gS8YZWlpnyOTgRAleoEwW2SI16QrEJ9D+Q6ZMmh6GZUmJtmPzZbyE1bFuBgfwZpvwRZs+Zbr6LfcBNU0igJF+fp8zZl8TJgIgLRQf0c6QV45PNkqgaC+QoZPqIhdhNUCDC4tCI/Vlj2DVXpwg8igR3dxpL9AZ8LiZEpIZDHeMNas8qrWNfVmvi/yEH8mJaWLlITTML/wWHq09Y/ZvVq+ZG+qcoLgAqg3X8uiRD5oapw8LmogWxexDjYkKph8R8YElah8KbvETzEYCDiYolv1HfuoKZhWRDyCCYgztMZl767ksO+cLzh0K5O7aehVGNStXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjF2et+4QBzrE1HK79FVQvXykq8j8u1bmS4KrYPfwAE=;
 b=fbjQuB/S3/chPXTly0gV/+lRE00rqWwT1k4c5adGzs4Omb61T8nR8SMLyuy/vhkq+FaxKy07C6pNN+hsQ7DUjs3D8ZX0rMCLIYjItn26Um8d3OqB5/KaakCVjifLrKLc2dAE8i+08z70OalMbbgVMoluCsSO5tE8Hyq0U6ctx18=
Received: from MWHPR04MB1040.namprd04.prod.outlook.com (2603:10b6:301:3d::18)
 by SJ2PR04MB8899.namprd04.prod.outlook.com (2603:10b6:a03:542::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 13:07:25 +0000
Received: from MWHPR04MB1040.namprd04.prod.outlook.com
 ([fe80::5c41:d0da:15a9:41ef]) by MWHPR04MB1040.namprd04.prod.outlook.com
 ([fe80::5c41:d0da:15a9:41ef%6]) with mapi id 15.20.7228.028; Wed, 31 Jan 2024
 13:07:25 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: zhaoyang.huang <zhaoyang.huang@unisoc.com>
CC: Damien Le Moal <dlemoal@kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhaoyang Huang
	<huangzhaoyang@gmail.com>, "steve.kang@unisoc.com" <steve.kang@unisoc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
Subject: Re: [PATCH 1/1] block: print warning when invalid domain set to
 ioprio
Thread-Topic: [PATCH 1/1] block: print warning when invalid domain set to
 ioprio
Thread-Index: AQHaVD8dNUpei/ydt0+12iLyo24sy7Dz4E6AgAAEEAA=
Date: Wed, 31 Jan 2024 13:07:25 +0000
Message-ID: <ZbpGDFUGQoaRQWHq@x1-carbon>
References: <20240131121401.3898735-1-zhaoyang.huang@unisoc.com>
 <ZbpCo+90OsXJwFWV@x1-carbon>
In-Reply-To: <ZbpCo+90OsXJwFWV@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR04MB1040:EE_|SJ2PR04MB8899:EE_
x-ms-office365-filtering-correlation-id: cce269de-02a2-4c41-e1d8-08dc225d91c3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Thln//cEkOgecnoa2tULqst5AKPcyjn1vdGeZciS1045UZT6jCXKs4ARyoqSOS585CYVatAZx/eVfXcBc6gBQy5wnrf/J8UlUcvtgGNujQCsS7L5ZdRpyXD3ghdk7rSM4YvdZOY+89g437xGMkgNKCGeXp3qHtF4CGtdR4+yrM/fvdQvQvi4ypcTGvxnQBzJzT297tZ8N3TY1LXir20oCsYEh9AK4h/w7UMgcRjN/LZWWSDva70rEYOuS4J5nVn/R06rLWlql87hW+oQ34wg9Yj4lxagbTe3Kiw+c3c3EPEBCzOVMisEeC/wYxfEzMIfJ+XOoUX1nNEM2QblBWC/A/9P03+Iqlh7UjsdN0QEYTRdNVmlUHYAlfP0Sst74gal+IHjdCT6Uf3fh6/tKklf0mZ+X8ItEocyzV42S9Fk9H1+IFve5Qd8Ue4bv+PgZG7AA5ZZUOSGN1+aTgl1ZJ58xnT8bPuQjm34pgAk79RI+RE3LE/lFOwRskHlLTOYJJzYZM/rdACILtGLM6GQHZl0QIuPVZ4w3B8Ic9jfAQACrbn2GP2kicX0Sqi91M0gj2N/CMTuY4A8uV6KW8r4/erOr89wkPl7ypj5JI9ozjXPc3U12z50pMnkYt6zph5HSp0T
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR04MB1040.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(122000001)(8936002)(8676002)(5660300002)(316002)(2906002)(82960400001)(66476007)(66556008)(66946007)(66446008)(38070700009)(6916009)(54906003)(64756008)(76116006)(91956017)(41300700001)(33716001)(4326008)(71200400001)(86362001)(6506007)(6512007)(9686003)(26005)(83380400001)(6486002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xE1PwtlovIluvWGWwD+GH0V1Lnw3xgPrKi5HkKCcv1uC+NBcZ3rtO8T+EHYf?=
 =?us-ascii?Q?XT9l/1DBbQLio7AN7Me2SoX/2okb/Lew/WCjNZI3KeeNxtDHc58sDTCC9qHS?=
 =?us-ascii?Q?MekUSfqdtX1VZRQ90YaGtvV7sXv2HTtMdOlc+vp5vjxOH40VzwD8K19oZ6z6?=
 =?us-ascii?Q?fKBuHY1/43hF4GsTfJSGTjLZyuZzTFvIuRXR/DFkCwk5PPgKC3zqnGSmVyOz?=
 =?us-ascii?Q?glY2rh05tpTksttyc7go+NscWV7BWwDkjom6YiyJwcRZGfWKdM+rGwunPpU0?=
 =?us-ascii?Q?KFkaJL1LHRZrdGLuCeil+2BmjKqhgBCANH5rFmJYHLYA31XLnPE3Wpl3RhBw?=
 =?us-ascii?Q?tSow0Wd7Bc/6bQAhzrF3rlon7xtWHc83vn2ofQcWQIvmOE8XjrYSoJRSyeDZ?=
 =?us-ascii?Q?cFxux8rl4bsvwFMj/Mp9WdirT0ZXVPbxtzUUn7fZvdQDkSj7KYO9Zz5SQgWn?=
 =?us-ascii?Q?ny//jA7+O069cEdyfi+Hmpw4oQtReKhUcdw9KYFEF1HEujpjq4Nf3p4bnK5D?=
 =?us-ascii?Q?98lGeR4HFSvFm6tXEIgKPK+ECKjgUGqZDGcnfXT1aw/dn/xwP2XElCmxr5Ty?=
 =?us-ascii?Q?ciJ3qBYdmJ17gqTelSfr/eDA2qMe4Vdg/W3WXJnZA6C8ZfPFzgOq1qD8Uw79?=
 =?us-ascii?Q?7w/YR+qguvxU7NMGorydl0f015V9pBQ4xNHVfCByAnMmLUDGx1VBIJ0r8QKe?=
 =?us-ascii?Q?mFg4CThyeOmz1EVfBSpcMfsp6oy2ze82MuQ1Mw6JqVzPHWBKbDCRK+SCzrT9?=
 =?us-ascii?Q?r6rtRrxcfezTMjVeAj3hr81zi7SVZft/Pj71RdX7MRAZMHrIVU47oxGIK7hI?=
 =?us-ascii?Q?/8fHNEp5sT0vtgooKbLSzUqve5svYh4UyGrjtjsLefkvBQ7mWBYPMyLneINk?=
 =?us-ascii?Q?T9lEJbXW21Ry9ifssSt37Hwt4VgvuCcNXcGQevpR3onRZq5SsARDXHD64Zi4?=
 =?us-ascii?Q?0YRGa+R+9tMjlL/hzSRRmjQhX0KUbuL29lr7LLv+C8xgmxj+k8iIPvQHG9sy?=
 =?us-ascii?Q?iXO4jDIVFJKpyM9l4I8BLJk7O9hgaYwYX1uCZgKEToi53lQPX4D2T9lLaIkB?=
 =?us-ascii?Q?xadKUPtmMkE4KEeyACz4eTLhSQGEnXXAeAw8ZfLq8f3OWOVLgSopdQoo5V4L?=
 =?us-ascii?Q?3wXXBT9RUr2zvhEZ2dH6qvgGfag1gg7Xo8gXa5s6z+JB5pJbH6d8IoEL4YxP?=
 =?us-ascii?Q?PnJ3gvNfb2LK48loDH1o5GbMc0MOqj0a6to4piaBBCTqiKrIXlAXUR4kgMdE?=
 =?us-ascii?Q?MKvpg2mAInZy2cDwP1hoKruk5sZsqThI3GtZE71veX0xAybkXLld9+GN1oS5?=
 =?us-ascii?Q?8HnKxHc+w9knlwMiORuH0Gc2ema1UHApfPLo94Rm9BDna1kiW3sMYWFxBpEC?=
 =?us-ascii?Q?9kCBiepQg11wN9Is5Q6ccw5dwJzKart16G8G4zCCc8qZcSIyeh1dwDUFbpaL?=
 =?us-ascii?Q?y24rXuvPs5ntNtL0WZ2ic4ylET5abohryB6F4OhC/stNyq3BVaZxAcPTg67S?=
 =?us-ascii?Q?kzHJUV4VIUjNySc1j+Y9QOnyJCi8uFIH6hLqC3jr8keVtW9hhClp8aXQpZqd?=
 =?us-ascii?Q?MSwf5RdQIWEK/VOIZSVH3gargbwhLYoTuKF4A6ItiOoCl6g+ApU6jWlulN3n?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5B95FCD29764A4419165BCE747F750FB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TYE7ptlD2WEZObkaICoF1V8s+o4Z43n1aqW7va71zvoTyI3Z0Qj5q8Qk6Tbe+lsIVn8g1xQWPxhzm71yrqYljcdEGV4SVf7P4F/BtxIEhJoprBg0QmeWdSLLx/sH9JklTpM2ZMRtozXtG81B1lTjpMGAfxAkHgWsqWc2+5W0HAcqgt3YY00AShicT9fIfG/OTlVQPIFKQGVGrxnHlVhnwNIwuqWkJ4dgB86ffg0EWdCvjRLsVX931SgaRGDjwQISNu13ttGvHOkqmmv94YYPbvQBdeBFiapeT9xI0p3JojQGzS5PtwINZa9oL0021UDqBKwez96kN2XcCrFbnHlChWwC7S8rQ0GNWe5FGuMBSMBfczHfDAYXzop5dmrA7TEcQpD1gz3NLpbV4riHtnz0NHxQ2yq577tFThXG/YahzolGBVb21YpORLViPSh43eyD8rIekC2j/gi3z//R5UI9QvODr7Z9MdtL8iKYu+QGo3K32x6LxLjTD0KnT/d1F9BdtLrj0PnVOABs1es6T/is8n6PzGQcpZrlfmh6nyv0ZCwFyQCUmsdCPtwLwCq+TtUwzY1/qiQhQsOOYtRB/UoPxRbj/tLKyejfDR8kT87Z0xoTzEIgsGKSd53uhRO8NcXJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR04MB1040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce269de-02a2-4c41-e1d8-08dc225d91c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 13:07:25.2523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/qM7bmz61HKTJOk/eq0wOxM7yN5j/MLI+VhklPO5NWDUpeuUtXuzyeIkZQe1qvqz0DcoHnyhDJ7ISj21hO4eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8899

On Wed, Jan 31, 2024 at 01:52:51PM +0100, Niklas Cassel wrote:
> On Wed, Jan 31, 2024 at 08:14:01PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >=20
> > Since few caller check IOPRIO_PRIO_VALUE's return value and bio_set_pri=
o
> > is a open macro to set bio->ioprio directly.It is confused for the deve=
loper
> > who run across kernel panic[1] but can find nothing in previous kernel =
log.
> > Add a pr_err here to dump the information.
> >=20
> > [1]
> > Here is the kernel panic I run across which caused by a out of bounds c=
heck
> > introduced by CONFIG_FOTIFY_SOURCE.
> >=20
> > [exception_serialno]:
> > [exception_kernel_version]:
> > [exception_reboot_reason]: kernel_crash
> > [exception_panic_reason]: UBSAN: array index out of bounds: Fatal excep=
tion
> > [exception_time]: 1970-01-01_08-00-23
> > [exception_file_info]: not-bugon
> > [exception_task_id]: 409
> > [exception_task_family]: [f2fs_ckpt-254:4, 409][kthreadd, 2]
> > [exception_pc_symbol]: [<ffffffc080736974>] dd_request_merge+0x100/0x11=
0
> > [exception_stack_info]: [<ffffffc07a27e274>] get_exception_stack_info+0=
x124/0x2d8 [sysdump]gc
> > [<ffffffc07a27e670>] prepare_exception_info+0x158/0x1d4 [sysdump]gc
> > [<ffffffc07a280128>] sysdump_panic_event+0x5d8/0x748 [sysdump]gc
> > [<ffffffc08016a508>] notifier_call_chain+0x98/0x17cgc
> > [<ffffffc08016a9b4>] atomic_notifier_call_chain+0x44/0x68gc
> > [<ffffffc0810f0eb4>] panic+0x194/0x37cgc
> > [<ffffffc0800a638c>] die+0x300/0x310gc
> > [<ffffffc0800a77e8>] ubsan_handler+0x34/0x4cgc
> > [<ffffffc0800960a8>] brk_handler+0x9c/0x11cgc
> > [<ffffffc0800bf998>] do_debug_exception+0xb0/0x140gc
> > [<ffffffc0810f8bf0>] el1_dbg+0x58/0x74gc
> > [<ffffffc0810f89f4>] el1h_64_sync_handler+0x3c/0x90gc
> > [<ffffffc080091298>] el1h_64_sync+0x68/0x6cgc
> > [<ffffffc080736974>] dd_request_merge+0x100/0x110gc   //out of bound
> > here caused by the value of class transferred from ioprio
> > [<ffffffc080707f28>] elv_merge+0x248/0x270gc
> > [<ffffffc0807146e8>] blk_mq_sched_try_merge+0x4c/0x20cgc
> > [<ffffffc080736824>] dd_bio_merge+0x64/0xb4gc
> > [<ffffffc080723e3c>] blk_mq_sched_bio_merge+0x68/0x144gc
> > [<ffffffc08071b944>] blk_mq_submit_bio+0x2e8/0x6c0gc
> > [<ffffffc08070dd3c>] __submit_bio+0xbc/0x1b0gc
> > [<ffffffc08070c440>] submit_bio_noacct_nocheck+0xe4/0x2f0gc
> > [<ffffffc08070c8e4>] submit_bio_noacct+0x298/0x3d8gc
> > [<ffffffc08070caf8>] submit_bio+0xd4/0xf0gc
> > [<ffffffc080642644>] f2fs_submit_write_bio+0xcc/0x49cgc
> > [<ffffffc0806442d4>] __submit_merged_bio+0x48/0x13cgc
> > [<ffffffc080641de4>] __submit_merged_write_cond+0x18c/0x1f8gc
> > [<ffffffc080641c4c>] f2fs_submit_merged_write+0x2c/0x38
> > [<ffffffc080655724>] f2fs_sync_node_pages+0x6e0/0x740gc
> > [<ffffffc08063946c>] f2fs_write_checkpoint+0x4c0/0x97cgc
> > [<ffffffc08063b37c>] __checkpoint_and_complete_reqs+0x88/0x248gc
> > [<ffffffc08063ad70>] issue_checkpoint_thread+0x94/0xf4gc
> > [<ffffffc080167c20>] kthread+0x110/0x1b8gc
> >=20
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  include/uapi/linux/ioprio.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> > index bee2bdb0eedb..73c420a0df72 100644
> > --- a/include/uapi/linux/ioprio.h
> > +++ b/include/uapi/linux/ioprio.h
> > @@ -112,8 +112,11 @@ static __always_inline __u16 ioprio_value(int prio=
class, int priolevel,
> >  {
> >  	if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
> >  	    IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
> > -	    IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS))
> > +	    IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS)) {
> > +		pr_err("%s: get a invalid domain in class %d, level %d, hint %d\n",
> > +			__func__, prioclass, priolevel, priohint);
> >  		return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;
> > +	}
> > =20
> >  	return (prioclass << IOPRIO_CLASS_SHIFT) |
> >  		(priohint << IOPRIO_HINT_SHIFT) | priolevel;
> > --=20
> > 2.25.1
> >=20
>=20
> Adding linux-block to CC.
>=20
> pr_err() is a kernel function for printing.
> ioprio_value() is a function in a uapi header, so this function will be
> used by user space programs.
>=20
> There is a reason:
> $ git grep pr_err include/uapi/
>=20
> Gives no results.
>=20
>=20
>=20
> I think you should fix mq-deadline instead.
> It looks like the problem comes from:
> ioprio_value() will set class to IOPRIO_CLASS_INVALID (value 7),
> if the user specified an class/level/hint that was invalid.
>=20
> ioprio_class_to_prio[] array in mq-deadline.c does currently not have an
> entry in to translate IOPRIO_CLASS_INVALID (7) to a valid DD_*_PRIO value=
.
>=20
> Although, why does this I/O even reach the scheduler, shouldn't this I/O
> get rejected even earlier?
>=20
> Both io_uring and libaio will call ioprio_check_cap(), which should fail
> the I/O before it reaches the I/O scheduler, but in your case, you are
> submitting the I/O from the filesystem.
>=20
> Should we perhaps add a call to ioprio_check_cap() or similar in some
> path used to submit I/O by filesystems?

On second thought, how can the FS have a ioprio class stored that would
have been rejected at I/O submission time by the user?

This sound like either a bug in the FS or by some of your local changes
that you did for your other patch (ioprio based on activity).


Kind regards,
Niklas=

