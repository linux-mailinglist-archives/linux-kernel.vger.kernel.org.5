Return-Path: <linux-kernel+bounces-119653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8688CB9D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C311F2F662
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF55685280;
	Tue, 26 Mar 2024 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a4rzMoVT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qWd4Bid1"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DA81B59A;
	Tue, 26 Mar 2024 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476548; cv=fail; b=imUqx76m1IhRb3MGfRmK0iE882qAjHTnm9sKsKEL62TNxrpHboTBGvqPqan9Uh+z9jJHpPb6T9U1U99DLikigkVLOkbAciz7yeS4zcLy4J6sKxwNQaSekYSTmMdIlP2N0T+gB7FaG6CRXt1Vd/ttuO0XOkQKk46MP3JFWxlpayE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476548; c=relaxed/simple;
	bh=SWg3hEr1nh83iXL64yGcj2hJInGCOz8811gx6yRoy0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HUICgijgXtVY6RcRyBU8Jctt5YFNB1gctyiJ39I2xGwkOe5twD1sWLTEUSSrFkKC8cYT3RRzPtLFrOC7XE3z8ivylxxWr1pCqkCVMvHNFSof/f84CRDXOvF8Qcp3hQjKwyDss7zzJ8OHQt0TOZQ8igdhb738Ox7/nqO12nWZdj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=a4rzMoVT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qWd4Bid1; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711476547; x=1743012547;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SWg3hEr1nh83iXL64yGcj2hJInGCOz8811gx6yRoy0A=;
  b=a4rzMoVTTfzJerhbVW4M2yb6C9nb3ZCxyocJT0qTLTYHYvh+eZZqIg/K
   2al6hoxDPtzP1UAuyaj7b4BxIayJwsQz1MKxy9DCJJhE2O2GpFJl6O0CW
   s9oRL9eSQc6GJ0/hsoJJNf3EPcUokGj5cN6buuZTnFY3JVplCbFJokKbv
   Sqkn0t3+lUN3acJzD2Gf65NoUEK/CbZNjmyLKOs0F9KCNlgAwuFY89fac
   F1LKcHpRhS/BJ7rKcLtLhX9S4eRhJtH4K9kxE+Q1TIBEgDeW+mwhWiO+k
   MsvP15JIXJeZv9bPhze8edSQa8o2hYWqRm86UbjYdgjJVN4kcR1Y4o1qR
   A==;
X-CSE-ConnectionGUID: JZulHRKdTLaD8A8BivIVqw==
X-CSE-MsgGUID: tEXI0h0PR5i7Ci7ogYmAiA==
X-IronPort-AV: E=Sophos;i="6.07,156,1708358400"; 
   d="scan'208";a="12376609"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2024 02:09:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyVNQCmoDuUsPaUkz5PLIJOWC3FrwHcibDNWNLrYQyAqChTtjdmKPqmeD5bnLOeclalNokqplN8aqmXRnYPuuToK/hntWJ0qVzsyxHqwoJUorRvn2h9ZxjzENjEfyDp7bUd+RgCaICp+f3E7Ce16Gno318PjuystJ0ujz/W5rw/XOCx/tbVzkA9gnw/LbEXklKjc/cFsLgK/a5pW3TKmJNkJRWMdhGlvSXM8WikD/hqZYX04+afvF74DS+VyUJaz7nDCYQ500eubpu3PN2IZ/zAqTfVy2QzRlq07V3HVQ02RRMCcZk45dkWYPKuaOMXfK7fuFHMxyrLSfMWw1bA62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVxxbSwrbFwuO3ZAbnkdTpzOnO+bf8d0AUfEu34B164=;
 b=SxincW5kZNg1rNyWys0LI9m2MGfepQxXVtgnnqrA+/U6YiwHQam9swGit3ABVKw341yHuniOdNKkd5RbjAGSppBKX71yOGRazphLN5udXHO8+feVT613KnZyuqkYUH3BRzduOMkF2lzxNhBQPbibqiRT3uHQ13TJG2CbYdkiBoQn5f8wH/vnP9C8qhKU8bLYXs8M7HLKVa8jTRiC3qIXrdZmTCPABk8SrFVrJfVa4yU6QQu/4ZGlSdzBsEAPMyIPZzLwHZZNodACSL+Aw+iZBG58X/OenUHlunC96dQnfdFzyjr/4frr4JVJinwalIuUNDlNH7AOYTFGCjwf76hbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVxxbSwrbFwuO3ZAbnkdTpzOnO+bf8d0AUfEu34B164=;
 b=qWd4Bid1YeXp6U/iRlZb426Y8hxQ57N7m2qNLo7p+FjOlycDr9+YfoTEnLbyVIRXlqRLi3R55jDi4M5tN20EwhvWVgQDoFR6gb5Jg11bt4fxfL1qno5UuhiqMr54NXUnjRekdmSDheapVjqVk0rQ76jDjFINUf0KBH0R3KsO3/c=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ2PR04MB8581.namprd04.prod.outlook.com (2603:10b6:a03:4f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 18:09:01 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 18:09:01 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>, Bart Van Assche
	<bvanassche@acm.org>
CC: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, Bean Huo <beanhuo@micron.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] scsi: ufs: Remove support for old UFSHCI versions
Thread-Topic: [PATCH 1/2] scsi: ufs: Remove support for old UFSHCI versions
Thread-Index: AQHaf1hBCRqbUYC+WEG5POc3Xd9iP7FKRQiAgAAArICAAAzeIA==
Date: Tue, 26 Mar 2024 18:09:00 +0000
Message-ID:
 <DM6PR04MB65759B575F7D218385BBB4B7FC352@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240326083253.1303-1-avri.altman@wdc.com>
 <20240326083253.1303-2-avri.altman@wdc.com>
 <7d3a83b5-6dc7-40d2-8a2e-bd5157a3f8ea@acm.org>
 <ZgMEXZffmEqyRgVU@infradead.org>
In-Reply-To: <ZgMEXZffmEqyRgVU@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ2PR04MB8581:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rAQTQVo3I34Y3qvZND68gCR/5eol4SIHGdi9vADn7o4LNbBOdqe6m1morXdnHb99MJzJMvG78cdec8GUG9rldQvh9P9ttZWKt62jf26/DhtVZTLL87d6KTOa8ZS6qNgFqxhV/qyP5BlI/dZNMvvcB3zgHyOIikXINPoKsmAhDivUUP5rSk5Kmvnch3Cuab75BAD0po/hLQYN1upkmtNTvpZhPC63c7re3q4I8FB7vj5lElvJNMyCav8gq/Dy8pSEl4g1+PV5/XueJJ+t0PSoPXdsRN+rD5xquWnZjpC1osHFOZn+P2CSTisglSBKPKKbWmu6l+jX7SxOukRYMJjlZ3dbFIEBK1WGkHEWose7kCdvW813ePkomp7MiKgPBEVIH0YNUJTU2+rwBBSMzENboJYW9bY5ONsE2YsFFIY3fh5v9aoKwoGnBinNhGf5V8QBlYBNrqR/NuJjoig1Eg9Kr1kvnrEYueDbfMtBYijirfFEl0tvnwJFLdlMbJEax5/9LVg1zyt0mNGa/j1YyQRw+jh/fP1mNS6Z820goft+Ubne2nLlKHptcSBhwGDHfHpCXEjB+hyi7WVv6MPCrl4Rpw8zvtGVe766RsQu+sOx1WSKA8kYLMRRKrtI078b3ldt3nmsh47FzQiKczF4NOWD437etZrNEuichW9JAqgeHmg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AltgCZZOKKbc0q0l+s6uUe3y2wJL1HYKPnFeC5r//h8GK4BRgFYr2CULlRNP?=
 =?us-ascii?Q?Y7YAhnjRIz6L1lJ8XUyOPuzPthLqSgstUqGoMQmC5fBeNLZmT9UuBPzZTLUh?=
 =?us-ascii?Q?L493bHO4GFJNbv316JdorAwPbTCjJQvi1/0hcTBtRu3AW2KHaPMjSE/nD7mw?=
 =?us-ascii?Q?3C1qgjga0PWPE5QErJxPZhHle/nhgb1H2oX9Rsc+CgBTmNJmCbcaGH+uaUl1?=
 =?us-ascii?Q?vus/pUXBTDA8bhn+2R9Hwq9OQWD8KwHcFUEBmpny/bWUHqSFUaYJ5tfGMTkM?=
 =?us-ascii?Q?qHsAmQMORXDOALBJbz97N4BbDmg9a7zr1D/X87XNG4NHxcPrwtl432qviX/k?=
 =?us-ascii?Q?zy/3htZVwoTijJJrom1H56tR+rO9nRrUIn4vPA7t1Z7ohjt5EkcZ7U2SgWcE?=
 =?us-ascii?Q?eheInF4zGPoBIU4y63TUe6oRqhMvtiKBFkObawLN1KRKiRp03H97keW1IOtO?=
 =?us-ascii?Q?503KWuQ1JX4c+Dgw7sUk1WGB0fvs9cRcrmjywyPD/9Lg/RJta7NbaPbZUWku?=
 =?us-ascii?Q?RWtQrNPLpsP+swL+4rN65qdFNdRzImUMyODb88s4bw3s4jPy06sh5DDCI6yT?=
 =?us-ascii?Q?JVFhOP85liKMjNR5QUPyRZGjbDxodQOO6FxmXRGwLwyQiMc56boPsMqS1GX8?=
 =?us-ascii?Q?+4xzMCpyiT6gz/wgzL0CnZBLaobMXrLZaO3AXT6yO49fYHGhhVPD1MM/c476?=
 =?us-ascii?Q?KnIKWg8sHkXz9HNalZCUZXXwxbGXHrbW0w9ldUdzGXXxJpgn7GQHB1kJt2Cn?=
 =?us-ascii?Q?OiXCkiMnt1k4OFjpPJDTVQwvmG8RnES7dtuRi7W7WH8EHM4GS0aU6M06rNzd?=
 =?us-ascii?Q?Ib77gtVLuybjucsLvmJuUc+JgksKITM2n4IUxov4cBnB0beSi1E0IfaPOSfX?=
 =?us-ascii?Q?iMzoruznPADu+Ui6EK3/NNbe5kJVWyssyqFo0oGZh9lJ0AR+aRqsBIMZjV/R?=
 =?us-ascii?Q?Y13kTPxSQWo8KUif3+jzCrSqT9s8kFNLGwEgCrRIo2UatCGKeTQRQIfWiSO1?=
 =?us-ascii?Q?Aa6K+HPA9QzJ8PZX02nj4XZPOavzZDztrkmvsxhG38c3tfRWAUr9zgdbR+Sp?=
 =?us-ascii?Q?ZgaHSsG7AJl8RZ3fnxLATa0Z3XsaULvgnVPQySi6R39VOTLcnCzTKIRQnfjC?=
 =?us-ascii?Q?bg9OtP6sHQ/m09XW5wU6mfMUGq3oyBQSipUIUR7uL9Z1URnxI7MPFFZodfuI?=
 =?us-ascii?Q?5NLCTznJ+cywQhkzAryrIpJgnGdlG3PusUbfgBXPVjMwzoEkrqkhMkHLNrsN?=
 =?us-ascii?Q?2mxd8INy7DXA9usBcBDivF0AkkVHyhqcrJt3zSSt0TA3IfnpeF0Q7X9BDqX9?=
 =?us-ascii?Q?ADiZoOq/0Gaz/W5q0lnpS8zoRx28mXMWyi07L1bpOAyczl2CC75r/L/LyBUH?=
 =?us-ascii?Q?2VEFrIKJlm9+kaf/ub1n4Eq9TV0dsjMVRLv6g0SOahykXkrookFEh3K+/PA7?=
 =?us-ascii?Q?/tHtALCH9k53xmUwtW2fMrMI2jQEGNC73eH1d82iUNwl4ajtMgCPyP4T3Ktn?=
 =?us-ascii?Q?08vE1R/DIb8JSDyZw2NFqXYKermnBeQ5sN1ffnfEgNiqsgDCm/Smz6ul9J7t?=
 =?us-ascii?Q?SW6s4UgRvsOp2RTCFgJDVVGqxeBUzhGIP4wCUXFm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8zlFKoEw4dLmAOGaltk0aeIAGRStR8tPpUzPWsBiZ+MJkxe2z8kxSlbemGNnOG86k1ZN35BcA8qVCP9azBKImrvzNLvWUdW/Ksz1crNFp8XnSjXBddCgq90LhLCF9MVV/0plz1rsvJAJWm/GYtWUYFy029YsurSfwMJnNBbX4AB8SpzvdiZCJedvKYq2Dbk3b3VrApkS+My4XBTLbuZEQ/u8Y8c6VUZNrd9oFuu7wZZ9bxbh4TaQXzFn0zQ97QJ5ilnrcoKjLg/Y41Xat2Vlp15/AlJn7UGx+0duOZvwN0HklEC9WuwZOsd4qF6kGjLh7MZjI2y3anoObFc9Uq8mohkJlN5j4odXwz+G81bnu7OoJjygYolgSJn/l8aJSBZN/dZZL0TuATe9unilyExjn1Ft2Lqy7p7c3YGRyPzqu0uwPexMqxReZ4RjQwDU+7XLMxkPNUC+kR5goq6YB4BhklPjoHSpNIA2Jx2HxtbiVXruawziSflzPqyKtNz8O1ftYF0kt58dtw/Mc/4Wi/t3haTIkbyxP74f5JkFoo+KbJpj7jCGwegUrNc7lQO4LVwBdEslhJNmS5/Pet8vfx6o+v3c2o+Dii1x11uXXm9H3fh0a7FNsHLzp3hUKUiO1yih
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5993ab-c606-4c29-0dc1-08dc4dbfd065
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 18:09:00.8653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IdpetTTqQJN9rBaqHLryZmmUkAnljLd/KrkfEN7N2BHs8f/Bmoj2zTXg1fPcIPp0F9301UY+ejfTeHylmJUUEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8581

> On Tue, Mar 26, 2024 at 10:20:13AM -0700, Bart Van Assche wrote:
> > On 3/26/24 01:32, Avri Altman wrote:
> > > @@ -992,10 +976,6 @@ EXPORT_SYMBOL_GPL(ufshcd_is_hba_active);
> > >   u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba)
> > >   {
> > > -   /* HCI version 1.0 and 1.1 supports UniPro 1.41 */
> > > -   if (hba->ufs_version <=3D ufshci_version(1, 1))
> > > -           return UFS_UNIPRO_VER_1_41;
> > > -   else
> > >             return UFS_UNIPRO_VER_1_6;
> > >   }
> >
> > Please fix the indentation of the only remaining return statement in
> > this function.
>=20
> Even better just remove the function and use UFS_UNIPRO_VER_1_6 directly
> in the two callers.
Done.

Thanks,
Avri

