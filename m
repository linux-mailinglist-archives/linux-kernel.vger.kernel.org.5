Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D7E7FF941
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346350AbjK3SYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjK3SYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:24:44 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6544AD6C;
        Thu, 30 Nov 2023 10:24:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XU1ZUGMeCBe78KjEkhgpvg6n/ARTYoFPlFiLXocb1n7bQsTOdS8MNOsK8CLKv7vmGp0lDNOxqfBHECyvR85SMvmMycRIRzkOXjz8x0feJreJ2bXaTF4lfIknQAk/VtyTFk/6BJmZmzvrneO37r/clRMRWCulv4cuWxs7Nu0fMysm3tA9DJIJEgkH0/Oq/nVTSomyvDUGJ094IIk7Wiw2SB/aS0aqXeHZAHbmpEv8UK/rSDkvSl0vkLR51l1wzoxuMI1dELZsQQHE9yOIF+My5k7U3ZaUZ7nMIYGdp1M8RKOp40LZs0tX43Muwj6/D2xtdomiT46a844TW8aKymMKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6MrvYpslfCRFbZUnhL28A6LLeSmwtJM4cudtoEmDDM=;
 b=MjqPef27LJC0aT1kPL0yqRiQhCEPbIM/sFZVQ9Xeu/2pyMfvZszvZDJhVQPyw0eGDapyuXIWnXqm4YxGmgPK7utNdYSCTe0YsVX2lnjBpQiwZq+6eM2FEJhpkZ0V3J778Sm2CGlYL1xrcCUO/rrI+K7unQl0N/y4PjBc+bNLfBTGnSIPh+zeUUAc+POizQKjXwktkm7x8b9U9io+G446eX0ff2+EnY1DauMCTh99OUCjZUTpmbCPx3E5Yjd1B6PIbPm1vA/FutvheQN6bJwy61NHTFpb82jkKp1AKD1vRXllPjLYIPFR2JVuFKxsKQB1fnFdVfX7dG6/dN6Ak9BcuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6MrvYpslfCRFbZUnhL28A6LLeSmwtJM4cudtoEmDDM=;
 b=p1gDzJ1E0yRCtNZ2I+SoFIfWFLK37veklEeZLi6SQxCkhDVgYHlPdp1Am4Zr8MaZBWYwzq9COhtNNfmSAvJWmMsXcU6bFYw2obMmD4jcCotq0J4wASx+IHc8ynFaLIqd2nGbsJPDjjj3mNAfquaTtA6BIGavciRBToGl8SXuaY7zfnxHMyMKfik8+3MjEyteXJkM4mdJiG5+K9tui5K5CkcT9IaaEC4JxOYqQh4Yi7XraIfQqZ6E2enezFOymRxLYyQ3dtV0qzIY/voEnE59E1vkMGzoEEfEJQFy9eqXMsAIBno77qir5BDo0l8NgcIi9HnUUA8yr84ZO92xM5FgCw==
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Thu, 30 Nov
 2023 18:24:47 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::e5c8:60b5:d02d:d427]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::e5c8:60b5:d02d:d427%4]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 18:24:47 +0000
From:   David Thompson <davthompson@nvidia.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Khalil Blaiech <kblaiech@nvidia.com>
Subject: RE: [PATCH v2] mlxbf-bootctl: correctly identify secure boot with
 development keys
Thread-Topic: [PATCH v2] mlxbf-bootctl: correctly identify secure boot with
 development keys
Thread-Index: AQHaHJWP1srYXz3Ikk6DJj8B30Zs7rCGKeSAgA0Q0UA=
Date:   Thu, 30 Nov 2023 18:24:47 +0000
Message-ID: <DM6PR12MB55341582E9127EEB70613B71C782A@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20231121161216.3803-1-davthompson@nvidia.com>
 <1967c625-6d63-badd-6b2c-fe7267bfeb@linux.intel.com>
In-Reply-To: <1967c625-6d63-badd-6b2c-fe7267bfeb@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5534:EE_|PH7PR12MB7456:EE_
x-ms-office365-filtering-correlation-id: 3bdbdcdb-a6af-42ae-e2cd-08dbf1d1a253
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ayHChy3Rz8iT6w+0QyNVAIVgrXMOhyeoD70uiHDNFTaIpCHhZu8MRsZOUDdWqWiJBTC3TEMYxTSNLhi+c6+MgWHyu+pFCcfoUIs2rYrt5Lzr9y84x6Q1PrKD2iacuke31iUIigyi4Gaslq7BfPHQ19UyXQXqZ5xDF6jJpEqCFQ2pxSu1wKlEhF0/A2mlHmGU9iG37y8ljT/6nskQWEG9nc7fHh3wYxtzdJN7GswBaPfKNutkcMowNojIqTl+Vo+h2KjDAoN5xi9wSb2Tx278ggX8dBc0QT8s/nHQYFllDKU47EEs1vTapC131Wacd+uwIpopVaBQKwTKu2bG3uk9adAVyT+x73E2hInKYfJas+4dwCljkIRM+ZoizeSDP5yhlT6YYCE96C5a2xP9abCUSL0NK1dWHjmeyVln3wvQ9pk6eDTK8nuf9FdnAncRh2fFtOZO8k/Qg5WZETawYuFdIPSpLFGddrkpI2ArV8Lx8amhsdMBNbJXbeRx/sY8t9lBegZiHe8YaM0Y73VMLvTPxWtLEo/FjwUZJuI1BrHi85mbcl4QkoesG7UdOP5gFxOVJ8VOmO9UmREysqn2IvfE0p+GnS/yxLMft182jzc29mLrP7xe7HHatWKPqCimI/wt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5534.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(376002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8676002)(5660300002)(8936002)(4326008)(64756008)(6916009)(66476007)(54906003)(76116006)(316002)(66946007)(66556008)(9686003)(41300700001)(53546011)(52536014)(66446008)(7696005)(6506007)(71200400001)(55016003)(478600001)(107886003)(26005)(66574015)(83380400001)(2906002)(38100700002)(86362001)(122000001)(38070700009)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SGa//nWD3GVAHxjRrvYmBsTtN2wREIr2IP9/ne/t0q1Z/G0fikVZsLFq4T?=
 =?iso-8859-1?Q?CuC0+cDaUTWZFwREdcUbzUdoppzQE6iSRI9oNR7NhK6mAry/uWCwXnoc1T?=
 =?iso-8859-1?Q?p1GcBH91j8HIo/FYK+AIW0/OV5CtxWCHcwctqynjHMJg1z1n8f+rq3ZCs8?=
 =?iso-8859-1?Q?KPkH2/VZDcKBBNDmqlasnURSIAre09/bX2JPg4ifWlDy/cw2UQ6OD/p9qw?=
 =?iso-8859-1?Q?qJfV0073/TdrT8fRdvhjPXtNqIWqqG+GluZNB6GhuT6qCDFG3j8TQXlt3E?=
 =?iso-8859-1?Q?r4CYCFSw0cusaktxQJAvOUOlAmAt4TWvFB5Pb3F07/pHzh3X5t45hbs/Ut?=
 =?iso-8859-1?Q?cJaTaXAet5gscCdVze9Zy4KP2krFvf5s2P523KwQHz/rL5iPXxehDmhfL1?=
 =?iso-8859-1?Q?cWmtj91Eel5+skrheMNVzQapGAmcyF9sp2iIxwk3+tPAm/ah8RtR5/CBu5?=
 =?iso-8859-1?Q?YRxF7T8j+jgeNTYFanjJv8OYQQ5ITrAR18rgudTA2wJwIJHRsY0uwvAgVz?=
 =?iso-8859-1?Q?duWRBnb77ACiA0ve789goB0Vomx2BGLcxGDpAtiZCjrH3Asswv20EDX6HI?=
 =?iso-8859-1?Q?8cH0gBdd632LJ6aNyo8nRq0x28sqDg9hegtH/19s5aG3vky0f5z1Vy+rea?=
 =?iso-8859-1?Q?/e0IOMp+IGy1cMWSGs+7VxERbi81+Q3zDqfhyyM6hGty5lqKdIkPqyayWu?=
 =?iso-8859-1?Q?pv45qnuUxw8MyXVckWGMLrHPQ0gWlXarnzSdL8gXMKqMQuYEug6ThPnW0L?=
 =?iso-8859-1?Q?KBryyhB4LRYmpmXUraMHrGQNUVpNUMQX7OvKElv8HxvBJX0NtS7BsDL6ek?=
 =?iso-8859-1?Q?ZVJhVAB8RdpROjKRqIdtALIve1cHMVnlEO9qHPXV3LFnd21bwAmNm7NZ5M?=
 =?iso-8859-1?Q?IR+Ti3IA/ZvknVihfOsUdMEJ1kmhY5RpcOZGIr6F0ycXNSzX084YN3ws+m?=
 =?iso-8859-1?Q?NQF7mH04Y2L+dqr9jQV/v1b4r50eptWrx5X1MfZoRmdNEsumcZKH9g7waf?=
 =?iso-8859-1?Q?Lrg4oPpcCidWqBX7l9uRZe1uqF7wfV+UfVDjXg5BSD8MtLFiR2AQRyiUGQ?=
 =?iso-8859-1?Q?wpMYvJkadG2lRxCbdR59BrItu07I/XX0PBWMGOUqz2mmdYuSlkSj4nMgGa?=
 =?iso-8859-1?Q?wqOUFfWSltHPqK0yKTzJRBdrLVdJMosE26pda/KryXXux3mBotUipOC+mZ?=
 =?iso-8859-1?Q?BF9nN9eSdb83O8qRGMRXgkywuGeYLdpEFtfunnW9f9YpqwpLP16Jj8fMzT?=
 =?iso-8859-1?Q?iW1760kgiCBt1gtfCKhdLlLN6lxo4NtAtMf8pI28p8SslmHbn9488XN2Z2?=
 =?iso-8859-1?Q?6BGzV98OM+XkXCsbxp9fY2SkSMWgL+iqK1UTZtIcWeK/tajIUpstA9Xymr?=
 =?iso-8859-1?Q?U9AdoS/brI0K+ztCVNbajE409/2aL48+NhFt7/j0583Nl+GxRu31+geKwS?=
 =?iso-8859-1?Q?JOcmvKhhak6/iyVZHPCASN1e9ub3H49gkJmdSoD4KO6cpC26ltD1fVFagh?=
 =?iso-8859-1?Q?mDvyTy0EL4WSECRGZKESHrSnHpOpKj4ql+Y/VqjuAYj1lhtq0uhgBSFUso?=
 =?iso-8859-1?Q?g5F/nRE6JZnJ1WcUevy3bFTA0iPkLe/KFdy5PmYyglFzrC7nFJbcFIG6Ts?=
 =?iso-8859-1?Q?i0aZFmpBzHllKjZ+TWETSoeIVD7YeGfoX+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdbdcdb-a6af-42ae-e2cd-08dbf1d1a253
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 18:24:47.6827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ltEr1enIR4vcGyaCdKknNYKycoy8EaXzk0YYYUNQpLAAvt/tZQjAucnNwkS4rbhEkcD7cdPfla1qbbWLVW+cEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Wednesday, November 22, 2023 5:49 AM
> To: David Thompson <davthompson@nvidia.com>
> Cc: Hans de Goede <hdegoede@redhat.com>; markgross@kernel.org; Vadim
> Pasternak <vadimp@nvidia.com>; platform-driver-x86@vger.kernel.org; LKML
> <linux-kernel@vger.kernel.org>; Khalil Blaiech <kblaiech@nvidia.com>
> Subject: Re: [PATCH v2] mlxbf-bootctl: correctly identify secure boot wit=
h
> development keys
>=20
> On Tue, 21 Nov 2023, David Thompson wrote:
>=20
> > The secure boot state of the BlueField SoC is represented by two bits:
> >                 0 =3D production state
> >                 1 =3D secure boot enabled
> >                 2 =3D non-secure (secure boot disabled)
> >                 3 =3D RMA state
> > There is also a single bit to indicate whether production keys or
> > development keys are being used when secure boot is enabled.
>=20
> Thanks for the extra details but there are more bits that come into play =
here and
> you mention anything about them. More about this below with the relevant =
code.
>=20
> > The current logic in "lifecycle_state_show()" does not handle the case
> > where the SoC is configured for secure boot and is using development
> > keys.
>=20
> This still doesn't state why the current state is a problem. That is, why=
 "GA
> Secured" is a problem.
>=20

"GA secured" is when secure boot is enabled with official production keys.
"Secured (development)" is when secure boot is enabled with development key=
s.
Without this fix "GA Secured" is displayed on development cards which is mi=
sleading.

> > This patch updates the logic in "lifecycle_state_show()" to support
> > this combination and properly report this state.
> >
> > Fixes: 79e29cb8fbc5c ("platform/mellanox: Add bootctl driver for
> > Mellanox BlueField Soc")
> > Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
> > Signed-off-by: David Thompson <davthompson@nvidia.com>
> > ---
> > v1->v2
> > a) commit message was expanded and re-worded for clarity
> > b) replaced use of hardcoded 0x10 with BIT(4) for
> > MLXBF_BOOTCTL_SB_DEV_MASK
> > ---
> >  drivers/platform/mellanox/mlxbf-bootctl.c | 24
> > +++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c
> > b/drivers/platform/mellanox/mlxbf-bootctl.c
> > index 1ac7dab22c63..13c62a97a6f7 100644
> > --- a/drivers/platform/mellanox/mlxbf-bootctl.c
> > +++ b/drivers/platform/mellanox/mlxbf-bootctl.c
> > @@ -20,6 +20,7 @@
> >
> >  #define MLXBF_BOOTCTL_SB_SECURE_MASK		0x03
> >  #define MLXBF_BOOTCTL_SB_TEST_MASK		0x0c
> > +#define MLXBF_BOOTCTL_SB_DEV_MASK		BIT(4)
>=20
> You only covered MLXBF_BOOTCTL_SB_SECURE_MASK and
> MLXBF_BOOTCTL_SB_DEV_MASK in your description above, is that correct?
>=20

When the chip lifecycle is 0 (production), test lifecycle bits can be used =
to simulate secure boot without having to burn the fuses.
The bits are OR-ed to the real lifecycle bits; thus, we are adding an extra=
 mask to indicated whether we are test mode.

> >  #define MLXBF_SB_KEY_NUM			4
> >
> > @@ -40,11 +41,18 @@ static struct mlxbf_bootctl_name boot_names[] =3D {
> >  	{ MLXBF_BOOTCTL_NONE, "none" },
> >  };
> >
> > +enum {
> > +	MLXBF_BOOTCTL_SB_LIFECYCLE_PRODUCTION =3D 0,
> > +	MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE =3D 1,
> > +	MLXBF_BOOTCTL_SB_LIFECYCLE_GA_NON_SECURE =3D 2,
> > +	MLXBF_BOOTCTL_SB_LIFECYCLE_RMA =3D 3
> > +};
> > +
> >  static const char * const mlxbf_bootctl_lifecycle_states[] =3D {
> > -	[0] =3D "Production",
> > -	[1] =3D "GA Secured",
> > -	[2] =3D "GA Non-Secured",
> > -	[3] =3D "RMA",
> > +	[MLXBF_BOOTCTL_SB_LIFECYCLE_PRODUCTION] =3D "Production",
> > +	[MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE] =3D "GA Secured",
> > +	[MLXBF_BOOTCTL_SB_LIFECYCLE_GA_NON_SECURE] =3D "GA Non-
> Secured",
> > +	[MLXBF_BOOTCTL_SB_LIFECYCLE_RMA] =3D "RMA",
> >  };
> >
> >  /* Log header format. */
> > @@ -254,8 +262,9 @@ static ssize_t lifecycle_state_show(struct device *=
dev,
> >  	if (lc_state < 0)
> >  		return lc_state;
> >
> > -	lc_state &=3D
> > -		MLXBF_BOOTCTL_SB_TEST_MASK |
> MLXBF_BOOTCTL_SB_SECURE_MASK;
> > +	lc_state &=3D (MLXBF_BOOTCTL_SB_TEST_MASK |
> > +		     MLXBF_BOOTCTL_SB_SECURE_MASK |
> > +		     MLXBF_BOOTCTL_SB_DEV_MASK);
> >
> > @@ -266,6 +275,9 @@ static ssize_t lifecycle_state_show(struct device
> > *dev,
>=20
> I'm quoting some extra code not fully visible in the contexts:
>=20
>         /*
>          * If the test bits are set, we specify that the current state ma=
y be
>          * due to using the test bits.
>          */
>         if (lc_state & MLXBF_BOOTCTL_SB_TEST_MASK) {
>                 lc_state &=3D MLXBF_BOOTCTL_SB_SECURE_MASK;
>=20
> Here what is output also depends on MLXBF_BOOTCTL_SB_TEST_MASK, right?
> And those bits even takes precedence over the code you're adding into els=
e if
> branch. So your description in commit message seems quite inadequate to m=
e.
>=20

Please see above for description of how the test bits are used.

> Note that you've also added an out-of-bound accesses here since only
> MLXBF_BOOTCTL_SB_SECURE_MASK gets cleared from lc_state:
>=20

The next version of the patch (v3) will clarify this logic and will prevent
any out-of-bound accesses.

> >
> >  		return sprintf(buf, "%s(test)\n",
> >  			       mlxbf_bootctl_lifecycle_states[lc_state]);
> > +	} else if ((lc_state & MLXBF_BOOTCTL_SB_SECURE_MASK) =3D=3D
> MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE
> > +		   && (lc_state & MLXBF_BOOTCTL_SB_DEV_MASK)) {
> > +		return sprintf(buf, "Secured (development)\n");
> >  	}
> >
> >  	return sprintf(buf, "%s\n",
> > mlxbf_bootctl_lifecycle_states[lc_state]);
>=20
> Here's another potential out-of-bound access if the holes in the above if=
 logic
> aligns.
>=20
> --
>  i.

