Return-Path: <linux-kernel+bounces-105721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315C087E36B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE5C1F21269
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB082232B;
	Mon, 18 Mar 2024 05:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="a1xO4zSz"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACCD4C84;
	Mon, 18 Mar 2024 05:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710741524; cv=fail; b=RDVLV53DsJNd9vEudriFTQKNqgwZZ6XMTIRjUsS5eTggfwIPSu+G3vK/iiqDaIW9xZytKokCY4oMOtELf6jj3KPyV/0wYx6JF5zT5wqQ1hOnk6KFs39g+5mkxS6fm8FAB6o2jX1uLKiFEL5oqfXWgOuAuUR+MEHilMeAfzeCLS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710741524; c=relaxed/simple;
	bh=vZMhh1tS57E3I1BwHYWnfEq2ayIKr3xRX73KypGpo+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fVi1MIiV/JfPrQAEVnFjaLN4914NNRpk2qOVmwpCzrTFPqrBt6CWzNoRp9M0aq0jEa+gVDFxFUeecETaxSfuzQ8bHcnBGK+VC2TuQGRxOaXS+KFkix7uT5Q/YH/5XfJbpAdAj8Lus4uD9hXiQ7YjpB0ZZxGSXAmMgfHOBQFJj8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=a1xO4zSz; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HN11HT016545;
	Sun, 17 Mar 2024 22:58:27 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wwaxgbq50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Mar 2024 22:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcdP2JFMSBf9bdvIu0uEbuMnkR/+eTcCrZdRsxWGhZMNWYdRSFN5MAG7yN7vTF2TUawuhqcuNXFQ5sNWTi9BjSAxTdDPaSd8weRQeMtIIHveP3j+LDtZSRn+ROBA4RJU5XDKs4P7EUy13aHPYL+V0SS4BHmuXzyEFSgYiXazkphGW4aeSDwdf+bCeGYmyjLOOdpU096q+S1T5yO7JdnCR6CNXkzC6r7KdnX2GzZwZVYTJDGpcX2JSqdGOpOpCAVxOljvCqmhIUgNFc0MRjpZEAIe2lWazZtuM7pwvwemO02UV5T+BrMByx4nx85i2vYTMMHH0iNoD1Vq5VVObZ4oCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFEMSMFIro3fNxCwZgs8wiXil/NHez/Kyhq6J4r/H7U=;
 b=GtZ8SCBwkAJIdN0AvNqwUvl9v02tYoBQ6JQtcn23bJ5/ee84/QtwSlIK5fBw53DUKvkif5zaK/BbtvC3X5muKTjpNvajWhtA5edBWlUHgwRlBjpmB73JO5Xjp4tBuE6uSVAOSUrE1+cYRwCWT4acn1jZQYq6PW6xGywctrFxFzbXeqmtT8yQavcMVQPcmYnA4Ldd0WkXaZ/S8z5UealKd/cb5e/cTz7+ZRiPrpDWabqqrV5DPbcqUewzZmGHcjnIXaf/3/ps9IOrcc3wA06dZBQCWOfgVpnn4EIvLweIIhe/xwHl75pEoohvcs4iwMvkelEd+ah+5gK4CM72Qs8wWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFEMSMFIro3fNxCwZgs8wiXil/NHez/Kyhq6J4r/H7U=;
 b=a1xO4zSzGh1dYgC5qAsgG1Zyi7urgCI5+e6osVffkZjoHEFKkUKSdMQfS6WW0uMwB7v1boEsnWM7v2vnoSsHNkUcr8k9eDlEZFlVL06iJVAswWhxVduTVdxBa5qpJqktACJU/4k9sP2QEykD2f2xlmTLLJT9E27chtLARcdTPP4=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by DM8PR18MB4503.namprd18.prod.outlook.com (2603:10b6:8:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 05:58:24 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 05:58:23 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saulo.alessandre@tse.jus.br" <saulo.alessandre@tse.jus.br>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: RE: [EXTERNAL] [PATCH v6 12/13] crypto: asymmetric_keys - Adjust
 signature size calculation for NIST P521
Thread-Topic: [EXTERNAL] [PATCH v6 12/13] crypto: asymmetric_keys - Adjust
 signature size calculation for NIST P521
Thread-Index: AQHadKxnbxR4a5LtXUqbsGZIoA/WRLE9CEiw
Date: Mon, 18 Mar 2024 05:58:23 +0000
Message-ID: 
 <SN7PR18MB531481F0A287ADCED3711193E32D2@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-13-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20240312183618.1211745-13-stefanb@linux.vnet.ibm.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|DM8PR18MB4503:EE_
x-ms-office365-filtering-correlation-id: 4680eb97-6b2c-4661-3113-08dc47106c1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 yrrDh0F5+5z/uswH9NYKE5uoo2l2k8f4XEIomw2DMZv4Pud8klAXuKujMac1Xtai8F2HozfhU/U4ZUfP/I07lEe+rpI6svnlSG5g6onx9ki82O2f+kxe+mjFgEVPLu6Co3gahSXAglkCABTXF5kjZ9TZ00W39TDCU8YXMNmMRMQoXL422P45HS6HB5MuUtRpCM9nfQCHnWJ0PeZpuHUTGYwnDPCWtup/Tb5q9jXCFz7aYxzloCaYQDyeaRuULWX4cGOOtV9MVcE95J12wDMZNOUSBj7kGaMuJOuMkx7vSz52f6BsDEy4VZgan06w8g7K0KRiXZbFLUytIcig7bBwH8saYIpwajDuh/6Tx0s9Rj8uTep+HpY4wcFcz3EtWclYj8NQrE+jcgdUewsKM185qdxsCY9GINtsGq9G23d9XhFTQJkT7HP51Xl+dEtL8uAd+PyNLfqKUwvQPGNbsMb5T/HWJOhB3L3tghesEG863Oic5J0+80eisaYdJqT8o9o3b8iT6RR9J8dKsUzQ7kOHTaX5gc5cNMhLl9Jh30rbYc8i9lRai7kupeWz8ELpWk8bTKEqQuAamYURSSR6iIy6mpyqNU8CEI/rjaQpgcjWvFTK0VlomKycPQZ7gqn7gA9djDQ06paMpkyRkCy+bLD8+t/1Gp2IQxjdEpWoXRmpIcUrXDk/gsK7mG250CKciG5RJ0X91q6goo8e0k1DQz+bQ0Sdirvrxky5r6b5g5MOkxw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?1ss7uPV5gvIBO550qtCCqrKRSe7UWLRnTUDJjoYGYJSmGag7UhA/dwih4GqT?=
 =?us-ascii?Q?esDbR1AL5BkLJTdaiL9wf+gGZL1qwh7hWF+5ZOPIqWa3/A4ewP9PDBrpkYEV?=
 =?us-ascii?Q?1MyhA/gcBrCwM3p30meQ4FcjiA/lZwW43kqugX5pSDEg9W1SEttmFn5klVJX?=
 =?us-ascii?Q?YMpBm1RsqVmdR0o5CwJx9wh2BLVc6upDmiVfsRFpsD74p44KWZBbiB6g51DG?=
 =?us-ascii?Q?LWsEv+d3vDIZiDQ+XmPhrtY/h/IFbVfHJ8GIEThGUKoxvAcc/el5duGzR22h?=
 =?us-ascii?Q?BIv/VBFZ+2Um8hL4sKvBvmFB2H2o+PP6uuWwoC8g3i4/N/EUT4elXfaUM+qI?=
 =?us-ascii?Q?oeHe2z0LEmTUTUcS8C8J+eEXpcUZ+RdJBZwx0QxzBHqqZqhgT/hIVBeUhRsy?=
 =?us-ascii?Q?dOAuujhd7zQdq3iKhmFVni6wzurzkPtxO0Lc+V7ZcBLR1aqtUQS6S7gp3agN?=
 =?us-ascii?Q?MbKwCODcqRmlEinDvauvoFxxTDHlb1Oyu1Nt613teAnG4lwCEClobD00bRqM?=
 =?us-ascii?Q?133GK0TZ2fud1NuGGwsDM55+25VQ8dZu58PSAdqJn9h0v7Jtmw8mSCHtiYc5?=
 =?us-ascii?Q?DptVSROakVcmky0BSd9MTc405BtB2+EeEYdNqHN7W5/D3W7m+IriXOGibveA?=
 =?us-ascii?Q?hZIA3OY1Tups3U2H+u0yaGqGhmSpt5s6sTZmZHchrfyl5AgyI4fNU5zRvHg8?=
 =?us-ascii?Q?Uz24ClkS20Bz3z3Uqqi2OLwS4p8i1WrqES35Rahm/UA6NXVteqXzM58Fovie?=
 =?us-ascii?Q?toAbDZztV4utwEm734KqE5Lx95OUSwAWiaIcrv7uAsn06oLnOOCyU3IVryoJ?=
 =?us-ascii?Q?dMuELvAMxMXMJwj7WOkXOv8xWnurRQrpAhDYAnx3RM4sLsreZR+P0MhaDIs1?=
 =?us-ascii?Q?GcWDTBpcqLxoy8Hu+4m4udcKzoO6CvsoTreOYx1fIfbIHbwTnrj/flQoAZBP?=
 =?us-ascii?Q?SdI+CWqDUKSlRJGSiaMocQme8qeNDUoTo6+ifMSbuXSvxlgyepSigOB/moIA?=
 =?us-ascii?Q?98YVnCS70BY+yRHd+YzNCISF2FmFfINkGhd4BXiwakoYx2Os8C+1QOuis+dN?=
 =?us-ascii?Q?inMrGWo8YMC5oh+bhL0U/OMlcW3rDum4DmxX0xb2hbKMWBX0KSiy6Z7+QIz7?=
 =?us-ascii?Q?htUskiv5uMOg33ezRu9YeLJrQ6Bp5l4vajaGgcxwcx741nnmgBXbx1lIGtHW?=
 =?us-ascii?Q?bKYmrp0WrffE4QdSOVQST2AGPiTuNjA1hExe0JWSScptDsyFKk+2Q2qfDwIJ?=
 =?us-ascii?Q?ENr12xDnYdM8occyGFmPjPNF30rewGWvZuYDjjsHxDzhb7ZaqwIZm7rGhPJb?=
 =?us-ascii?Q?V9y9fPfVUn7mTuQme32vPyWz4OsCVLiJNsJ/WTmStBghP9EtCqpTakwsbSDE?=
 =?us-ascii?Q?2/eOBRelxEDGU/Ubvk5TGEd8OZw5dXBpdioXijr6S2JJYVhH2ADo7oNoFHZ1?=
 =?us-ascii?Q?fxaACznROT1z1TeC9/6W8Q6o4apEqsCFcO4hYhaIKISZwHhLaKCT21rr/8A4?=
 =?us-ascii?Q?a4oKyWTFVhRKM6D9RAsHAauO9GQ8QWLhx5BuPFfn2OUC+6hRsiC3CDIl/A7G?=
 =?us-ascii?Q?9pxtVASDrcfvlqIppn7GryYQdyU5dLwX1802O3ZK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4680eb97-6b2c-4661-3113-08dc47106c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 05:58:23.8749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvp99VZglZS1YcJ/e4khNUuEg4FqJvfVHBPF3tZj9XhRaPqKUIhniSYp9Pn3WohFxcNSVwceLvyR64uTnWDzTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4503
X-Proofpoint-GUID: OaINCsPMB36j2AXaSvgLH4J5FRK4RvuC
X-Proofpoint-ORIG-GUID: OaINCsPMB36j2AXaSvgLH4J5FRK4RvuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02



> -----Original Message-----
> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Sent: Wednesday, March 13, 2024 12:06 AM
> To: keyrings@vger.kernel.org; linux-crypto@vger.kernel.org;
> herbert@gondor.apana.org.au; davem@davemloft.net
> Cc: linux-kernel@vger.kernel.org; saulo.alessandre@tse.jus.br;
> lukas@wunner.de; Bharat Bhushan <bbhushan2@marvell.com>;
> jarkko@kernel.org; Stefan Berger <stefanb@linux.ibm.com>
> Subject: [EXTERNAL] [PATCH v6 12/13] crypto: asymmetric_keys - Adjust
> signature size calculation for NIST P521
> ----------------------------------------------------------------------
> From: Stefan Berger <stefanb@linux.ibm.com>
>=20
> Adjust the calculation of the maximum signature size for support of NIST
> P521. While existing curves may prepend a 0 byte to their coordinates (to
> make the number positive), NIST P521 will not do this since only the firs=
t bit in
> the most significant byte is used.
>=20
> If the encoding of the x & y coordinates requires at least 128 bytes then=
 an
> additional byte is needed for the encoding of the length. Take this into =
account
> when calculating the maximum signature size.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/asymmetric_keys/public_key.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/crypto/asymmetric_keys/public_key.c
> b/crypto/asymmetric_keys/public_key.c
> index e5f22691febd..16cc0be28929 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -233,6 +233,7 @@ static int software_key_query(const struct
> kernel_pkey_params *params,
>  	info->key_size =3D len * 8;
>=20
>  	if (strncmp(pkey->pkey_algo, "ecdsa", 5) =3D=3D 0) {
> +		int slen =3D len;
>  		/*
>  		 * ECDSA key sizes are much smaller than RSA, and thus could
>  		 * operate on (hashed) inputs that are larger than key size.
> @@ -246,8 +247,19 @@ static int software_key_query(const struct
> kernel_pkey_params *params,
>  		 * Verify takes ECDSA-Sig (described in RFC 5480) as input,
>  		 * which is actually 2 'key_size'-bit integers encoded in
>  		 * ASN.1.  Account for the ASN.1 encoding overhead here.
> +		 *
> +		 * NIST P192/256/384 may prepend a '0' to a coordinate to
> +		 * indicate a positive integer. NIST P521 never needs it.
>  		 */
> -		info->max_sig_size =3D 2 * (len + 3) + 2;
> +		if (strcmp(pkey->pkey_algo, "ecdsa-nist-p521") !=3D 0)
> +			slen +=3D 1;
> +		/* Length of encoding the x & y coordinates */
> +		slen =3D 2 * (slen + 2);
> +		/*
> +		 * If coordinate encoding takes at least 128 bytes then an
> +		 * additional byte for length encoding is needed.
> +		 */
> +		info->max_sig_size =3D 1 + (slen >=3D 128) + 1 + slen;

Is "(slen >=3D 128)" valid for P192/256/384 also?

Thanks
-Bharat

>  	} else {
>  		info->max_data_size =3D len;
>  		info->max_sig_size =3D len;
> --
> 2.43.0


