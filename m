Return-Path: <linux-kernel+bounces-105750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D351887E3D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608B61F2170D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD53225D9;
	Mon, 18 Mar 2024 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KJNLO7CC";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bdvrQjrR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9972D1CA89;
	Mon, 18 Mar 2024 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710744637; cv=fail; b=WLHtBBPbI0pPRQzMyectbJjS6XCdEa4KZq2lfDs8ujkjeIniThDBLGKPQ5G5z92JQvO0sQz2U2RwbCC2/0e24Ho/UzYvUQ1+A8ZovV48PCqahFGhZvqcerfGxlX3gK6/SQjizb69FydJ6hmt4LCfrB1F2Q8tNVkIU/Bq3GKkshY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710744637; c=relaxed/simple;
	bh=W85Ug9jWlq3zRsl0p2busBAOy2JUuchPht0QSJ8sBlQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PG6jtYrgA9KaZBFZeilo1SL9OKTNFXcTG+xtTh0xZpoxcavj1zJu8jUFm0PZc0EEcKgj39xCQQeNWxFAwWAsG8N+pfVOvQB5DlKrOUlobTvwslEPVWPztPNLChz/JUSfzJGghnNNm8gAnZEVegHvsHbPbH2bu09Z3jsgbujSrCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KJNLO7CC; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bdvrQjrR; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710744634; x=1742280634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W85Ug9jWlq3zRsl0p2busBAOy2JUuchPht0QSJ8sBlQ=;
  b=KJNLO7CCVNVeVIrMYRJzVPErwTVdhOurBRIxUwqcng4VPmE8HVEVbxJ+
   VPuTsYSxWuMtriYsXxJn1hth2pjkxaEbQkv+ZDCneVvP23jy5INcfd9qq
   hC8XQVWnbXIZGXuVd9ehwafCADcsK78KWN2kZLk8krULieZ5LFEgTJXG3
   fS2y0QLtXGDaRM5Wzol262a3chItudR2JqtxjB10RRglv65sXGUX35pcG
   71MRSrteSEMeN9Y4ptZtiw3IjwnRJudKPJnHUW3IY67pa86UGlYl68jyX
   9iAUoSZEGtZGCXboGFu+Gaytx87olttL2rmcJkqbv5UQ1rLC5StGMjeIq
   w==;
X-CSE-ConnectionGUID: S1oWklTGRDOrqwkkGRUXkA==
X-CSE-MsgGUID: 8aJ7PLyQSei1+MJYVzKTYA==
X-IronPort-AV: E=Sophos;i="6.07,134,1708412400"; 
   d="scan'208";a="17744334"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2024 23:50:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Mar 2024 23:50:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Mar 2024 23:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EijVi93kxlTJrpbxCSxp6r+bc3t9yP0ZXeUo7gRJCSrbcU89sVyew4SM5XNrp0K1Frv1PZnYBmiVvF4un7d1UejqfI2PchznbepPDGPN2OLNLpjT6/NnF3PJDdwg7VrjLDctUbtXR4iXVfF6KQpXfNdmEoYVWlaSgs486qeIJkMS5U9JetENyOkP/1w6Hr1GMpv7Ui4a2ntsWSgn7fRBQZSQpRsn2vjEYx4bZLkYiraC588vjv3STC9fP0ImMDN/tfChV+AMGTYZo98Ijjs/DDQU+WOJ04+dbM+ItM/BwuwV94fzYNpyKzII8Xj4jVHYRCNw4WbPo8dqC0QfoEfZqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whDpa4gEPtA4GHwE8o/vCkilNautuF/VJ267jk3K/co=;
 b=XD3RCLFiQKwu8lUQ8JUzKzf6VMi1AI1TRaMmJFc2kHRllSKroHJoZYvUOV4LP3bm+DcljPK55ZE+xZ8Ek8tSDJsKRju3mfgMh1DzuU/snFiR8KpmgTley55v+jGsvC02ZFUXKmHXEcz1dTQ30JPw1rVGnHU4qsmm2d3KMOZ9tALNTVdiQYZgPYMYSK/ODB8YTwhtnVLqTu1Lmb6SD0/eioqB+3axgIQdmVhidHGBy7R3F4oqhOvW2Mt2MuS5+tUlmb209FJoArEo+i2IsI/8kKdrRXKbw0lyZ0T3+joLfNAO4SC8LYkwhsnbyNV+W31qhPATIyuYTd3lCXrlrt5U1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whDpa4gEPtA4GHwE8o/vCkilNautuF/VJ267jk3K/co=;
 b=bdvrQjrRnhY5g1G9EWuvWuxatcuqSeIKxV6VcOzCbj9LcoWFMUgoDQp84fmw8RdyxZvjAmElbPfUMzr7i7kT61cxpRFDnNpjK7Yc01IG0ER7Cna4AYdbA2Mblyb8X+fq18lSz3ysj0juR6YLpB4z53BxJCDoEpHWMiJBadpqoU7YlTHmiUhOKNJ/TXYT1ytiFzbPx1oYTKmm9iZwncgrJrPFBGuGRDecGCxDoWjPgu1iw/DAAGpmfU8uDePyPPeY4jJiticULDsE6n+8A3/iONMaHv9BTc6M6gcjxM/cJ5xVk6fSIrbadExhwKzTL5uKyc5lkL36enrNPbj75SKeMA==
Received: from LV8PR11MB8700.namprd11.prod.outlook.com (2603:10b6:408:201::22)
 by SA1PR11MB8575.namprd11.prod.outlook.com (2603:10b6:806:3a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Mon, 18 Mar
 2024 06:50:11 +0000
Received: from LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda]) by LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda%6]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 06:50:11 +0000
From: <Raju.Lakkaraju@microchip.com>
To: <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <linux-kernel@vger.kernel.org>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net] net: lan743x: Add set RFE read fifo threshold for
 PCI1x1x chips
Thread-Topic: [PATCH net] net: lan743x: Add set RFE read fifo threshold for
 PCI1x1x chips
Thread-Index: AQHacG3yS1E5foLphE+kzgFysANBzLEuPHyAgA7hfmA=
Date: Mon, 18 Mar 2024 06:50:11 +0000
Message-ID: <LV8PR11MB870091AE0A368C03BC81DDC29F2D2@LV8PR11MB8700.namprd11.prod.outlook.com>
References: <20240307085823.403831-1-Raju.Lakkaraju@microchip.com>
 <20240308192735.GA603911@kernel.org>
In-Reply-To: <20240308192735.GA603911@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8700:EE_|SA1PR11MB8575:EE_
x-ms-office365-filtering-correlation-id: 2e770de0-5567-4601-a723-08dc4717a84f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9gou9gmf2qvNSPkM0PvQeXFRCb+zpgIQIIKMzYyiKxbVp7JlDANQhhVTQUllZ38y1X0FM8mpyPO8yGIEf7eCs2EyylTLNUDfFiY9X9TpXsqRFjZedMrOIMSAo9VbsJFnHbZt1juoYTSWBAfiVGYYZyMweJDhp0ibFCXSKDXF7fPA3at6TmrHqCcz3fK/imlBvj40+EVANEHY0pCI/OdVBQQvP2HHURY42pBHddDtGaV9wUZ5/AjDUW0U8dAZBy9g3Pwnbp6xsBoCWpR0ubc9/NFdEb0mZqPEOeXDZW8PVnvEJ4SVDBqTge4Re/dGsy9GtvLDPRrOlErlY184iDNwh5ItQCHFmyL+5StjwUXgo4TT3NCDhGO1sCdY3wBoElkTOTkmFXqIpemqPxIn1E7z0tsCP1yg6hBLx9F4bsJ5MHq395OjCOdkfwih8S7J/d+ncEptMtJoQANXCmyeERIHsFfpITgQvCsr+0M+HUSTMy55ZEgVqokEH/XsatSj4PHBRUhInozje/5pf27M/oLUUnREsodXg7wX1b2revc8GQOlpg4SlZiKN+oRBWTDMhSMq4+nz7OX+ssFQlglVJZtxGPBm7N3gzslxlSqnUPfQhYnmZJqZTYm02Txqh4ZRvjk6s9hppwpDeoBA96sFbiBKVkC29A1kjA3QYRPwyaqX+tOLvt5DJVBLFz326OqHpdY/xUrnK2wUrfcBNSpQ96Ht/ryZisgSh1VqmnG7VgWG2Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8700.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LZnSY5swxF1r2U0BjbzhMQHFYBCUmcsH5oZ3ICWe13A/EXMChmX6Mz3rDD8l?=
 =?us-ascii?Q?frqaEUMLAviBq4Wh5RZ/P/w3ArCXvzU+NFOFkGeb2EH9j2qHaOh15LeghnMs?=
 =?us-ascii?Q?OGLlb2NK2/Hk5DC9qc/XId6kbkJjx2SHAE1eh/Q6u8/X5pSkCea7XjYD6Qm8?=
 =?us-ascii?Q?U5g/3ADMW+3ARTb2FsIj0lashtN4ZxTW2ut4FOsau3bITLUWcsdyYXB7j7ie?=
 =?us-ascii?Q?CkmatNuOYYclIdORIUsS+LrrQPKnaiG90AdHq+bv1ni8urGZs5sZmfEBS9LP?=
 =?us-ascii?Q?liLpuclRwrKOjdSU7ZoyzZ5IcNodvX1//MPrEYjWdYizpZtkjEilHgOZEFtH?=
 =?us-ascii?Q?eaFyaCNQ7TjyyFgYEQL/ASCM041x71F1J+o7Yx++qMgJOwGyYkE1Vrv6QO4a?=
 =?us-ascii?Q?RL7ce9nqHXn1tJcMeREYCE3wEo8jRELThFoLyZRKpS2g1v2V8xsi0Lnnkhg/?=
 =?us-ascii?Q?VU4YqkoLCq6PsFWv1R5jWkpu6brrH1MWFYERLcmQFuFcV4MFXH6udAH/8Bhw?=
 =?us-ascii?Q?V8nwMiKvJXI3Un9shWnoPHSV+I6J7k9H6jJYHGCgzC9gFazgcoUPBlWSCmpc?=
 =?us-ascii?Q?Qq+L2Oj9A2im+h/jYO/Qr4jd6QF+RLRYZDhO0FIGsB1ILsV+mU5pfbf7qnjn?=
 =?us-ascii?Q?s9eBZUrvCOpFd7x0lYlp7M0+If9jY4tFCdKJLLOcVL0ZJYEBOrUyUX+bD86R?=
 =?us-ascii?Q?FGdzDR5nfsezhzpjGW3OsNgxXA7YGwPzELwtzN8zqPaMBUQrbTZOrW/k0rAa?=
 =?us-ascii?Q?6CKoWCkofVgrmzTx6eFKEoclc+YVj5jK3ldpZ3Mvwx86fk9cJoX+bmyir7JU?=
 =?us-ascii?Q?CQWMLB3nj9rssl9UMikk1lyJc61tVCof9u6A2wK0AuIwJ0zVRDEofz+hNUSs?=
 =?us-ascii?Q?hj+ktcv7FVNypOEb/dnXqGo57JJ8LfKHhqk5d1V5UbuaeNVofRPZyTm5LRRq?=
 =?us-ascii?Q?L6bjO7OX0Mn1kXCIY3vYo0hoBY9uCzt7DYNog2fA3ZcN45p5oiEj8sqIHbQf?=
 =?us-ascii?Q?l53cBFvUlkOA9xe9m8S3Mkut0JQXWI1F3GnoFMM0G6hz1X3NZlgKKEUIbyK2?=
 =?us-ascii?Q?qFMUaKNf8LBg3nGIDsO1IMrQerMRXv6XDI+W5+XSc6uf1ahqMhBkMDXlFllB?=
 =?us-ascii?Q?Hu5pKFdmWBv33x5EMirIopdH65K0JjkWEdn33OoAiqagOP3xMoFremd+e6lk?=
 =?us-ascii?Q?lerlmiAlJv1dWKd0MNY5dOyZGvSEcOplGPrbywWHDnUsjXpkWbS+Ez6GCq6y?=
 =?us-ascii?Q?085BQzyGRttzk4GteFasY0bHOCGgdfj01SO8oDtGw4M5eHpV7RVRaBLrhJJT?=
 =?us-ascii?Q?dB56PrXuuvWfM1DS6VulaT7RYVS7++tEW7TGqXWR8nhJBXepPQCXr5JL8lEy?=
 =?us-ascii?Q?4hUMsXLyjq+zYIeR+rSvlAABptz0bJ4w2yml23Bmls0w/8BcpVtBTato07GH?=
 =?us-ascii?Q?ni4+7po6tNV3dmUpT29vheVxy9lWAf35mxwci9L2/3B2avk191tXL9uRgjDp?=
 =?us-ascii?Q?p7IAhM4Mj4sUq6gBcXEccy3nMsUmuC2S8W5JCjbEO/Yxdbj6FEmZhmzLyTXz?=
 =?us-ascii?Q?hA0aJ9N77I+PJDbAps88HuOueqmkCAMp/Rglgf50KWZTgK+K38I6gR3HHlJN?=
 =?us-ascii?Q?Ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8700.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e770de0-5567-4601-a723-08dc4717a84f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 06:50:11.2862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fiQRnIsQIbHilsWUmYnVJMeHKhlfSgpXwnQ5+G5vmJigSS1hlhMkxVpkovQKUkQHY3vIhCqzT7gttfnFkSAMetjEMKGuR4sUSnvHxuCrCyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8575

Hi Simon Horman,

Thank you for review comments.

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Saturday, March 9, 2024 12:58 AM
> To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org;
> pabeni@redhat.com; edumazet@google.com; linux-kernel@vger.kernel.org;
> Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> Subject: Re: [PATCH net] net: lan743x: Add set RFE read fifo threshold fo=
r
> PCI1x1x chips
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Thu, Mar 07, 2024 at 02:28:23PM +0530, Raju Lakkaraju wrote:
> > The RFE (Receive Filtering Engine) read fifo threshold hardware
> > default should be overwritten to 3 for PCI1x1x Rev B0 devices to
> > prevent lockup during some stress tests using frames that include VLAN
> tags.
> > Rev C0 and later hardware already defaults to 3.
> >
> > Fixes: bb4f6bffe33c ("net: lan743x: Add PCI11010 / PCI11414 device
> > IDs")
> > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > ---
> >  drivers/net/ethernet/microchip/lan743x_main.c | 17 +++++++++++++++++
> > drivers/net/ethernet/microchip/lan743x_main.h |  5 +++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/microchip/lan743x_main.c
> > b/drivers/net/ethernet/microchip/lan743x_main.c
> > index 45e209a7d083..aec2d100ab87 100644
> > --- a/drivers/net/ethernet/microchip/lan743x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> > @@ -3272,6 +3272,22 @@ static void lan743x_full_cleanup(struct
> lan743x_adapter *adapter)
> >       lan743x_pci_cleanup(adapter);
> >  }
> >
> > +static int pci11x1x_set_rfe_rd_fifo_threshold(struct lan743x_adapter
> > +*adapter) {
> > +     u16 rev =3D adapter->csr.id_rev & ID_REV_CHIP_REV_MASK_;
> > +
> > +     if (rev =3D=3D ID_REV_CHIP_REV_PCI11X1X_B0_) {
> > +             int misc_ctl;
> > +
> > +             misc_ctl =3D lan743x_csr_read(adapter, MISC_CTL_0);
> > +             misc_ctl &=3D ~MISC_CTL_0_RFE_READ_FIFO_MASK_;
> > +             misc_ctl |=3D (0x3 << MISC_CTL_0_RFE_READ_FIFO_SHIFT_);
> > +             lan743x_csr_write(adapter, MISC_CTL_0, misc_ctl);
>=20
> Hi Raju,
>=20
> Some minor nits from my side:
>=20
> - misc_ctl could be an unsigned integer

Ok.

> - The above could probably use FIELD_PREP, which in turn
>   probably means that MISC_CTL_0_RFE_READ_FIFO_SHIFT_ isn't needed

Ok. I will change

> - 0x3 could be a #define - what does it mean?
0x3 is empirical value of "Receive Filtering Engine read fifo threshold" ha=
rdware value for PCI11X1X Rev B0 chips
I will add the same comment there.

>=20
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static int lan743x_hardware_init(struct lan743x_adapter *adapter,
> >                                struct pci_dev *pdev)  {
>=20
> ...

Thanks,
Raju

