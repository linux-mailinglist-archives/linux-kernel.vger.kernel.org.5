Return-Path: <linux-kernel+bounces-106967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A1087F61F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 715C4B22101
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF70E7BB15;
	Tue, 19 Mar 2024 03:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ujI7+WC5"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8C67BAE5;
	Tue, 19 Mar 2024 03:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710819520; cv=fail; b=Bx6I2i5y6bccvWkTeOswPgsxLTx2F7gj6MrmPsuf1FKtGlPcV9lRqg5+7ozbyXz/JX/Ac81Bma06s0mm4nrN1iipdjPKXBmE2wIV9fQ+ufFYnv1EetUhU1tjgsB8fEA+FYOba6dB8BVlWPPhNiqW/dT7lIyCMEc7MXa3BABolho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710819520; c=relaxed/simple;
	bh=5HbsjFrYd7jZR0eNsVNPVuWeJfhQDEs+zwcR1tGccS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jNPgVrvXiz48edla4n17zZdhFVhf6EwGuOS980ZtK1bM50FvPNUo0BqOPGn3tlAfxxvxAHZqFPxf1AIoFKmt5pZjCRrirC2cFngXxie3leAxwvznJL0E4J0OpbjDGEeR4OnR0Dp9el06+Qul3M3MGFJNARPzhjengOussP6WK9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ujI7+WC5; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42IL1DXj010335;
	Mon, 18 Mar 2024 20:38:12 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wxka4txxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 20:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSgNY29omO9mN0NZGf3qRWagAPnOH+wPdOHfthLYJIs3PdTqVoR0KCl7srTs8ROIEIEAW7j5FwXWAK2qnqW5hBHX57fAKwLNVm4P22lzfTOnnaqWdxyxNmROoVtdgQe3i4mSLWkzPwjo0PGtE5oi9StHzr/6zbaI2K7aKBCrp2tQGWV5iyDKQwcs4l6pEdufjd4f1eAaRV67RwDTlzi6aCEa769ZZklfFLuck5/lCnbS9q5VP1JELWEoEO/rI7QwwzG/R+XJVTZR5n7ICv17T64+V+J+U9Od7toCeKo7i6alPh1lg+qCsw9R0zEJ49SNlyQT2PaPbunLaBwaXDwwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0x0dzPMrixBWIIjClRlT2dNrCA/KTabX6z31UMqFhRI=;
 b=Gw/CrAZaHRXylPDxrR6/qzzszBWc3JBkA2UqCb+PljStOWLP3gpGkJlVGp0h92e2Hnq2VdlOcMO0njGlkrV3vMoqNwE/8SDbXc3+BmI8uWSrnodeIkSgegp4JYglWSuuOJ2lK996YcUGzK8YU20shtn8Rs0TdhYg+muPDl+SzBN7TFqAGAqxDLYx5UxDp6zd3w0vdjfO6peSWZJXUqhpIOf4bNp0p/Cj20PlegLFSAAyqtdQl1zD/KmXZqAXXJTiJ4IH+nuMLdEWilp23GEQQJ0uIFxjEiKTp5ykrDAO99Ka9UcvuuoaUrkGBLgUVsPobh72ax6IPBIQDWV7ommjXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0x0dzPMrixBWIIjClRlT2dNrCA/KTabX6z31UMqFhRI=;
 b=ujI7+WC5HZMG7YbRuhvuCsx/5jjRN7+dBp8YF+Z0+gB3EW2t4k5Pkgl9AQO7KFakrvlxvzT7B9XpVoe7igkMBsfCtxkJD0uZFj9TdxAmiqlYrMO4+/kf4aGyr6cvLrLGUhcdxks5nQ7oJ9f5S+bM9kV9KMTS2pFHjZJXv0le/II=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by CH0PR18MB4370.namprd18.prod.outlook.com (2603:10b6:610:d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 03:38:07 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 03:38:06 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saulo.alessandre@tse.jus.br" <saulo.alessandre@tse.jus.br>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        Stefan Berger
	<stefanb@linux.ibm.com>
Subject: RE: [PATCH v6 12/13] crypto: asymmetric_keys - Adjust signature size
 calculation for NIST P521
Thread-Topic: [PATCH v6 12/13] crypto: asymmetric_keys - Adjust signature size
 calculation for NIST P521
Thread-Index: AQHaea7ac1b+fmXpakWfH1bgb29sxQ==
Date: Tue, 19 Mar 2024 03:38:06 +0000
Message-ID: 
 <SN7PR18MB5314615936DD467648916D7FE32C2@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-13-stefanb@linux.vnet.ibm.com>
 <SN7PR18MB531481F0A287ADCED3711193E32D2@SN7PR18MB5314.namprd18.prod.outlook.com>
 <Zffn2XpvwPk9GVhv@wunner.de>
In-Reply-To: <Zffn2XpvwPk9GVhv@wunner.de>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|CH0PR18MB4370:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Q5RPZtvooVxZXcyXwPbADTrNI8eiVTJwb57CwxelglcEoAyJuoVSczgXxLo94VuhIx3T2sbsOUsxo7vIEVwZj1JF8Wev65escEXbQ43YARG4SkFSFf96PaSog+zz7Ui1bC32+5dF/afF7JIk9sVMSNYH23T1c78YxmsU1hN1MdkR3mpR6BTqas3gjTfPFABjtGqVDmDXlg9pGdXH8zdNu1XEMlp7Ujvgqf/Cs7mRSiJk/BXCk/qUMNVjQ/pWqRLw/h6Vve7utbM4iFX5nMeO5PUIgjLINmzYImkCXl3POASzgJAK10w7NlsC0GMs3N9A8bWeuVzqzJiJNEteCuxpD2wG1t5vJLbC2MVQDcQaHwrEqJVt678OffuWgBFmamNl0Kx3q0NxIg5dQwJf/A/Cb9NaYlk9bVb0cq1gXvj99YwuVWgLo34GWvVKUfrjjA52sV1MAJji2m0bwqZLngzmmVcPR0i3pOW5BJU9Z5mLA5NP9wS5p/Ezh+WfNUi9iOWh186jUZdWYNogwqQPNHtLNX7Bld2K3UJRIrj9OB7/c7rBt3Do9BecVgNfDr+u3XUCgppLXtJ08U/yt0wsnrDUz2/jVtchJZ1oKQzMHD6CGAQKSyDkrzXJPCuCp9i5syn3eVk5U9FjVc3THo+AnXYSBmnt9esJ9BBMbasJS6pdAZQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?x/dFre8KMv6X0fLwjqnRenyhuuHKyJlr6QJBZas5m1zC310yDI+vu/8A+MI0?=
 =?us-ascii?Q?x5uZjVISqf0G1m622RZpOwRIKXxp3L8E8kfFFEw3YWBovd/yp8r0HYByaBJo?=
 =?us-ascii?Q?1/nTk2pYTt3Ez/AOYeCTlSuwGFbJEHI3bd7a71ukJFDTuRkaSezt346u5Tn7?=
 =?us-ascii?Q?mxp94OzHU+LbeQ5bv50s44u0BL0cCTpXlu4/324uy1MSNR7bF+eoxHXwkZlp?=
 =?us-ascii?Q?xDwjOB21YyHeJOPyR9w3ZqLFxmYq7qhGG58WqXHZdRY4auOfBisKu/mD4NJw?=
 =?us-ascii?Q?no97s7BTac0pH6urWSmRaJp2oT6Lv+/Z9A6zgG73dm9/P6jdc7ksFcscGy8W?=
 =?us-ascii?Q?F8bzYoQJvznoRP0CYVvlPGf7sYw4bDNvDxBZx0bDisPIaCazChdBOScIVxlI?=
 =?us-ascii?Q?gluzOVoyfIdB5c+CPMLsptD5t4EP0iMb2oABxJmlvfGJqoeocHdng4C/7x+u?=
 =?us-ascii?Q?gpreUNAcB7HmQtI8sZR0wVXla+GfNZlifTUVHlt8CicW2keezUCS8WSXTXeJ?=
 =?us-ascii?Q?j+ibkbGaKM89DnE2G/R0iGHD6NBih7IO9PZIElotwkowVb8YKyWU0R0xVPn0?=
 =?us-ascii?Q?Gc02uUhfEm3VRxcVqtTCBpI+uRpIPzwf4oSZfWFNvuW9urvfRh4Ol97oLTMM?=
 =?us-ascii?Q?17sbHRYT1XxrgLApyF26CdFn32LRhBULmYw9uxshcBmAgrg/Sie4jnm/pf/0?=
 =?us-ascii?Q?Bqsfc3y2H8mGskNJz2XY8FEUU2qepS7onc1uD8KKE4Zk7Ol/5EeVDT0Htzug?=
 =?us-ascii?Q?R7liOf4dkDadWipCVbgFeeJhaClHKKQvUxsjL3JiJjPm/G2WXxQ8vD//QyF7?=
 =?us-ascii?Q?G649ViJCtF/K+Ql7J9RIJ+THBgMnrX+14VCzCv2TRGRRvJ/Uj+LsjScaAKNA?=
 =?us-ascii?Q?DphGuaqN9YonGMqqOJ3xFleOorDB6fwMJLK+MWZUjg8HSSiI3iLk1xkjWFH1?=
 =?us-ascii?Q?40rmv+g4W6aGpm9Oqs6tar4C6JInHvdqSBNAjDHDNytehhQ+t4dIMGeytNYb?=
 =?us-ascii?Q?8Fso3bzCROjZTuszdajl1YAlL+prfUhZDCfmGHKC79wdPUCNugmtcOZod2Ig?=
 =?us-ascii?Q?A4MFggPKrh1exTWoclBpnJX5984c0JFA1VTgajP3gU9nRrDDVq3Javc4eYeA?=
 =?us-ascii?Q?C40gaatMk7ozdl7ht9znTqA5bGlUHyUTZcHv2cSCrLHxAo+HNOJ2/ic7XJQt?=
 =?us-ascii?Q?li8MWLFOVzFMLDYn0Fcfesx8mNc2FG2oTnhJgGNEtAQgeZqsrzw1opJPjqBZ?=
 =?us-ascii?Q?wqHfYSQkZEAGWIYQwvHTA7tAFTA3dm0pqRwpGinRs00Le8hgNeRPm7110kW+?=
 =?us-ascii?Q?iNNq2JEMrXXO2xGZxg95no8dyeUuhkbK2QOdLnIIABxwU/aj1/7M74nowEMN?=
 =?us-ascii?Q?PHibBdVOiNChDr3eBci8w2oKvvDCdINw4w8D67XlSAfDkcCbIaSwniKQWAAv?=
 =?us-ascii?Q?QZj8wjbeU7CJlmbZ18aw59zqdcpVo7pUz9uoU5MrgOlPofsukKDizX1MhYLu?=
 =?us-ascii?Q?OL6yAckIovGDYTLwJYYmCmaOChv2iHn7h6Tbsmbe+pQlBX53UNrvruIcqmhK?=
 =?us-ascii?Q?rEst+5xNQlnsU3muNTIvUFBB05esTCWz98fvwfux?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR18MB5314.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889d4d3d-24cb-423b-d514-08dc47c5fd6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 03:38:06.5773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4meQJmYwyhYEWXHNypj4UUVGXWxmNNAHFff6PJsuUKv4aW2IU8JM3YiTfEfBfL/bU6eyqOKk36ZxxwSd30BQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4370
X-Proofpoint-GUID: q4KfBGeIKbBwqfq_aSSMSkqtoVbKA48Z
X-Proofpoint-ORIG-GUID: q4KfBGeIKbBwqfq_aSSMSkqtoVbKA48Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02



> -----Original Message-----
> From: Lukas Wunner <lukas@wunner.de>
> Sent: Monday, March 18, 2024 12:36 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>; keyrings@vger.kernel.org;
> linux-crypto@vger.kernel.org; herbert@gondor.apana.org.au;
> davem@davemloft.net; linux-kernel@vger.kernel.org;
> saulo.alessandre@tse.jus.br; jarkko@kernel.org; Stefan Berger
> <stefanb@linux.ibm.com>
> Subject: Re: [EXTERNAL] [PATCH v6 12/13] crypto: asymmetric_keys - Adjust
> signature size calculation for NIST P521
>=20
> On Mon, Mar 18, 2024 at 05:58:23AM +0000, Bharat Bhushan wrote:
> > > --- a/crypto/asymmetric_keys/public_key.c
> > > +++ b/crypto/asymmetric_keys/public_key.c
> > > @@ -233,6 +233,7 @@ static int software_key_query(const struct
> > > kernel_pkey_params *params,
> > >  	info->key_size =3D len * 8;
> > >
> > >  	if (strncmp(pkey->pkey_algo, "ecdsa", 5) =3D=3D 0) {
> > > +		int slen =3D len;
> > >  		/*
> > >  		 * ECDSA key sizes are much smaller than RSA, and thus could
> > >  		 * operate on (hashed) inputs that are larger than key size.
> > > @@ -246,8 +247,19 @@ static int software_key_query(const struct
> > > kernel_pkey_params *params,
> > >  		 * Verify takes ECDSA-Sig (described in RFC 5480) as input,
> > >  		 * which is actually 2 'key_size'-bit integers encoded in
> > >  		 * ASN.1.  Account for the ASN.1 encoding overhead here.
> > > +		 *
> > > +		 * NIST P192/256/384 may prepend a '0' to a coordinate to
> > > +		 * indicate a positive integer. NIST P521 never needs it.
> > >  		 */
> > > -		info->max_sig_size =3D 2 * (len + 3) + 2;
> > > +		if (strcmp(pkey->pkey_algo, "ecdsa-nist-p521") !=3D 0)
> > > +			slen +=3D 1;
> > > +		/* Length of encoding the x & y coordinates */
> > > +		slen =3D 2 * (slen + 2);
> > > +		/*
> > > +		 * If coordinate encoding takes at least 128 bytes then an
> > > +		 * additional byte for length encoding is needed.
> > > +		 */
> > > +		info->max_sig_size =3D 1 + (slen >=3D 128) + 1 + slen;
> >
> > Is "(slen >=3D 128)" valid for P192/256/384 also?
>=20
> It is valid but never true for those.

Okay, just want to check if that was valid for P192/256/384 and this patch =
is fixing same as well.

Otherwise looks good to me as well.

Thanks
-Bharat
=20
>=20
> The signature consists of two integers encoded in ASN.1.
> So each integer is prepended by 1 byte for the tag and 1 byte for the len=
gth.
>=20
> The two integers are bundled together in a "sequence", which in turn requ=
ires
> 1 byte for the tag and 1 byte for the length.  However, for P521 the leng=
th of
> the sequence is at least 2*(1+1+66) =3D 136 bytes, which exceeds 128 byte=
s and
> therefore the length of the sequence occupies 2 bytes instead of 1.
>=20
> For the shorter key lengths, the sequence fits in less than 128 bytes and=
 does
> not require the extra byte for the sequence length.
>=20
> So the code is fine AFAICS.
>=20
> Thanks,
>=20
> Lukas

