Return-Path: <linux-kernel+bounces-110491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9092885FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB4B281E98
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18685937;
	Thu, 21 Mar 2024 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="VQi6kr8O"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596C117590;
	Thu, 21 Mar 2024 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041886; cv=fail; b=DsE2vHGCT8nqaoKsl1uOucC/6/oepsgLjkP/jRyrsyVVvtIS8B+tPShJSRPtxWktRAqui1MPS8yRs2inTa7R1U+Mo6tqJrvWkXBv+wAGHwn+D1JOQaJ0b8cnf2KeJbT/Kxqm8NAm9e1XXBKIZLlF9w3L75sbx2T9SEOhhRuvpKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041886; c=relaxed/simple;
	bh=d8+aG3PDNfASjgeMQ/gHxgiOqXzgiHUzyJKPTy43JZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tsvey/McT8IdhuAsbQBNIRNOLJQCXNSlkFqZTFSvFkpd4pOGb/MEqmJEpaaWKvgt8P92UbT1QMezKtfzoUUyyF1Tg5HBDTiq/OWgnilZD7sw4T9H4CLbdZZMRcOErE+upZBLtdYVh6Q8nKnPPdpoAg6KPgzV0z6EPoY9xE7NbU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=VQi6kr8O; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LGxcFx014577;
	Thu, 21 Mar 2024 10:24:17 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x04cv4bn8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 10:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FImOC0LPOJsFCld207zptjGEUEKJjnI+wKMz7z/G9W0bf3kXQY6D+eJCwOHYO/lO1277tCcNAzNeBe/0w4C/sqBoQI3Kv3IgxSLoqMA/6FHpW7I2Hs7t2zRVNis78Mq1RlD0bejpDCwi+xxHhZ5ttDF4byTKqyqpsP3hIjAZHcN7W+78UxLAwoAEw2fykVwzpvLJ5+68bBnu945j9q/kAyyUAaaXIKiJEojZ+KO8wiAHd1tt94q4pzwtrR8FjtMQBAR+xn6YimKdP4W2GK0Q96d0eKH2hm1tgtKkTOYyozVK3BpY23RU6Alenw+h4YSiUTfGYCrdVBgU0D1xwsQdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pusqkcstop4h61htxsuTkwJ+43/BPiNrSDFbSQOuT9Q=;
 b=fJudFzvludh0EXkn/FtuHQwLilwMMbTTC6EbgxoJH2DkV0ulJatSPPTE47EfLqIqrQh0+wC91f78DhMkmc3FxTEM4K771u0DYk0U2GwHZxcRFtKytuDg9PMTZReIi528aYz0QY+qYoLx2ut0S5z0ZT0YiN3uGnX8weWuoOk8YpDJadoyG9Bb6wg3FWH5ql1xlOg4J/8YmsxtKBObdYIxZUhypU6oJa4pQ3B9LOUlMidtBhuVzLOxQLljbdIiYP+QnXa1lF1EvBYDnDmoMibyOWICvrgArdT2TL5kuVWZ/xNAJvrgvJeXqxMB4QJnhVyzVwvYNbemF30Q+8YY6YVSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pusqkcstop4h61htxsuTkwJ+43/BPiNrSDFbSQOuT9Q=;
 b=VQi6kr8O0o3ILMEyc90hBsn0J/6qk90fBs/W+nmHtu7WL9gFydbcE4Mh3ADj2Rz3Bj/JVIRkNF4cZ+LdNdwZypru2ix/v09frLh85goA5KFvLCDGYmULqpc6PYWg+jtgmbHWYa5p8hS1xliMFgYSTQsxISRv/BJIqN0MVduwQfk=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by CH3PR18MB5931.namprd18.prod.outlook.com (2603:10b6:610:1de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 17:24:12 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::7471:7657:9316:1494]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::7471:7657:9316:1494%7]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 17:24:12 +0000
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
Subject: RE: [EXTERNAL] Re: [PATCH v2 2/5] net: marvell: prestera: enlarge fw
 restart time
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/5] net: marvell: prestera: enlarge fw
 restart time
Thread-Index: AQHaeurmiTlx7bmp+k2S6EhWb4zCerFBUn4AgAEgSaA=
Date: Thu, 21 Mar 2024 17:24:12 +0000
Message-ID: 
 <BN9PR18MB4251B959F294310757394374DB322@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240320172008.2989693-1-enachman@marvell.com>
 <20240320172008.2989693-3-enachman@marvell.com>
 <259379aa-e9b9-4524-a092-5338314791d4@lunn.ch>
In-Reply-To: <259379aa-e9b9-4524-a092-5338314791d4@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|CH3PR18MB5931:EE_
x-ms-office365-filtering-correlation-id: 4fa12ca9-d5dd-4a52-6bd5-08dc49cbb9dc
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 XWjsSyx35PrEpEfx4qSPaH4SuxxGYc03qEN5WycqEJNSuATJAksBFiZGGInYDEF8/3g3CKaGhfZHtDU4aEOuFOAek2nUUhmzAksyPd6en7S3z3yFS2MGRePlsqLbpoPCUozuxlpGEAM9Zf2SmUdtlWkd4cgWAFhuLa6aOO0qIJlW1oyYrgrwPG6EwsdQpyQWBqDCXVBmVlIPhoiK0llGbAMiIbgl2aqUOdxuZDSIwbaqhFK4nDlntbWACPzU2Pas4wo5/w0oB1m77TVxMm6HRdveU6MYwyOevwTHAA66ljNm/oFNXrw5/ukr9YP8f6VY0ceQFbacl7H1z6e5YxDKJFDvX2VuuFajIvMGTsge5JqsYsV8iwrF6/vuUlOqa1a+FmrC+IpqfDcO2k7uoKglM+gR+EdlEB38/DUYod6StMxMdI6nakyJT6CDL5px2CDamsv6FlAyjBQqspE2LTBbusXm0+AQDTX4pRUrqCeioI8+ddRhYk1F+RBMsZlgLePtCCVTfy+zzc+KWxKpvANbwJXxA3Xm3tSoQsGx7mPxJ8zPq7UAmVCcUKY1zZyvKa3Pw0Eu6Z4UY3Fh/WHSVd5SyoAEUPbiv9tv4LG68YfkwJlqCrb5boh0vqV1Xwd3/dg5nWAykeNN8l5YMmH4+2uRR4IqU1VCRW2w08F9qh/am8LlKd+Xq8iC8ieTpNYwKjENrxR/E+RY3Kayyd6twVaIejrhrqvkWB4dQVlvWd5A+fk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0MmEnhlgKTTYL40is4tsOcPhnI7uEcs218X/ztYQuyYCXx7NftFasIfi5ytn?=
 =?us-ascii?Q?GQLQa/spKukyBwsfKb5ADaDe8dQRirKOszl19NDReu351LMio5SYB3UDnkwz?=
 =?us-ascii?Q?pDjTEGiPkCgWLbp5U8o2TNeT0JJ6Y0KsxT/IaqU37Vneky8zjp4wuTlgvOaJ?=
 =?us-ascii?Q?8nYbwyKg3u3pthmuoythqfn7wHF3sNHAHdCf7aWmArfKsAUWdMJR5e9bkY8l?=
 =?us-ascii?Q?MJxF0uCOExUPrCZfix/My2Oykkh+hZCswADlHGHr5ksdqB4gxMeHL5v5fhxh?=
 =?us-ascii?Q?Q/WFdIAK+L9o+CElIw203ilx0n0vTNwm1gmbEWUAJDphZGUiEubXGD1vggp8?=
 =?us-ascii?Q?AJpi3SA6wJcXrF3TQMKhSZaHOdP5vAGpBX2fXcImI+eiD+Ay9mmf5t5+SM9A?=
 =?us-ascii?Q?MgGYRTs/fCeWAPCfC9cmVVlXN4ExkJtWGTZm1gZiXwB3pt+XVWAfFIbjhsdJ?=
 =?us-ascii?Q?q6xt7RqO/lFRjby4splemdtNW3urDqcC1GAfG85IO9K+eTBlidhGc2Be8LLD?=
 =?us-ascii?Q?wgm45mbKdm8A4RMz8qOXUq5TkhhOk+sekUJSGZNTb38rbq8wYbwU+zpFJgj4?=
 =?us-ascii?Q?M/VGxcMLM2hSsPPRqVjiNbB5AtsqEu8xopSqj7k8LDtwNPH7y1WWXhpXddqZ?=
 =?us-ascii?Q?xkZkE3l5oRmSG4zm4CUtd8vYjVS4g+T8BeZmJEqZKn6wpL4qY3GvhCQkHvDC?=
 =?us-ascii?Q?H1xwTH/lcCR4NNAoqASDTBykIUiawPIimiMdo7vc/g11AKKqPHlTBB3aGVnK?=
 =?us-ascii?Q?nf9e/f+lVRdHAYtBI2ruI40ZH80iSewhYLSrLnKiwMu597jvSW0qgAqoOcua?=
 =?us-ascii?Q?prXlKiAyLh7Slv6/zVVjuhjXjrNiXyCP+1WeqpcvQlDZGD8f2gg2o3alNGTx?=
 =?us-ascii?Q?MUE1FD5FmJvVxvRJ31UdoIQKJwmQRcgMA0tqqi51+A2dfjsiCAlqrCT6soFx?=
 =?us-ascii?Q?y85jn+jI/J5RzsSqnxXyTpiujCfKiHX/De0sdhmYy0PZHWltcwh8T4gBU9hJ?=
 =?us-ascii?Q?IHOD3c6Uy5L3JveI3FgY2DiTimKgP901v4Ll3SpE5YYmvjBgrgYyovADIqem?=
 =?us-ascii?Q?a9HRakjSq6uSFPGZ+w4+mwBpTm/vV0lqAAjJrOINwO7fOJOQFQnnj74nyezW?=
 =?us-ascii?Q?mA3pCD62ufMRKyMc/8dFYF9l/mCFEXnA9TdlRHHwSZ1oRvLAWG0PgtZ/jyy2?=
 =?us-ascii?Q?FsuCwJNk3KAxkh8Leua17KwqVjdtBLK9H1lpCQHicBu620E0sD/Qz5yOoqs2?=
 =?us-ascii?Q?cPdcrqDH07gq1DpkCQ9fjmsyfSfNFbncEVjiRRwoE+yX3jRnOSV3lu8fPZh1?=
 =?us-ascii?Q?sc1OCtmYbpouVZz3q+18aZ/oybcCb0ouL+cIBhgd55UlYFxgDym5wxVon6je?=
 =?us-ascii?Q?Du1HYCacFc7K4O01CQYCJpEbDmFWI28OtShpYdUzB2CbhZpE607JuLwhxs2C?=
 =?us-ascii?Q?sUjDAoKtA+4xbjhbbh9ov9ZolGvJsKSZpxVvhfqnnAWnjjX1HjhjelFJnAYW?=
 =?us-ascii?Q?LyqaIfuoQU8DXFEk3Iil9vXGozDtBZu2q5iDt5iDvEyd4+LzlmBzu3GvdSKS?=
 =?us-ascii?Q?NN270pyNyg1FBZOxVhnbATfQsrur1RwEHbQHdn6s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa12ca9-d5dd-4a52-6bd5-08dc49cbb9dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 17:24:12.4755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qM2n1Xaq7s8d+ZH0QgSP0QmcMXAhciT2PjgRSy1lt7b83UNS+VhFmCSeqCbUF6GYIr72VP7jRZj7Ql3fUY3taw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5931
X-Proofpoint-GUID: dn0H1syRXcb5vzMWd7gwIFsJFOnsHhiX
X-Proofpoint-ORIG-GUID: dn0H1syRXcb5vzMWd7gwIFsJFOnsHhiX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, March 21, 2024 2:10 AM
> To: Elad Nachman <enachman@marvell.com>
> Cc: Taras Chornyi <taras.chornyi@plvision.eu>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> kory.maincent@bootlin.com; thomas.petazzoni@bootlin.com;
> miquel.raynal@bootlin.com; przemyslaw.kitszel@intel.com;
> dkirjanov@suse.de; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v2 2/5] net: marvell: prestera: enlarge fw
> restart time
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> On Wed, Mar 20, 2024 at 07:20:05PM +0200, Elad Nachman wrote:
> > From: Elad Nachman <enachman@marvell.com>
> >
> > Increase firmware restart timeout, as current timeout value of 5
> > seconds was too small, in actual life it can take up to 30 seconds for
> > firmware to shutdown and for the firmware loader to shift to the ready
> > to receive firmware code state.
>=20
> So this means the probe can be waiting 30 seconds?
>=20
> This seems like a really good reason not to reset the hardware during -
> EPROBE_DEFER.
>=20
> 	Andrew

Unfortunately that's how the firmware loader on the firmware cpu state mach=
ine works.
The so called HW reset will force exit of the current firmware and will mov=
e the state machine
To the state that it can receive the next firmware.

Unfortunately, there is no ABI interface to verify which firmware is alread=
y loaded, and then supporting
Warm boot reading of the values back to the kernel.
Since many of these firmware binaries are secure-boot protected, upgrading =
is very tricky.

Elad.

