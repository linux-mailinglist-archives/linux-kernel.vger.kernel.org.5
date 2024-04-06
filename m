Return-Path: <linux-kernel+bounces-133976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C90089ABA6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A016E1C20D08
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC3B3A1DB;
	Sat,  6 Apr 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIsWvaQ9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD043987D;
	Sat,  6 Apr 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712417493; cv=fail; b=VXsAIp9RMPXwjrANlTktqgOZydY4KTAkMfw7GEm6Co90MLgB8tt4SPhkd7xBCIfpKR8uYL/Xse+wcTX8HZM6Qgkhqn7GnslU8yNitjKgqrQ0HhtOWvCIGFYJrkS/rFRPGD0MLrGgV+Ucp5nfKoWX5nk1f8XBY0Pt/Q3iGJogJgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712417493; c=relaxed/simple;
	bh=IItLQYkKzaw4kBGAL35X8jNoobqaR2SlFpegYsg7a6c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=npoiLhTdj2nA3PrgVdOhvk2TjBjlqXHsRo4jD72qrIQId/Jk6jBhILE1gbCvSTJOVKgDZJY2rRPfq2NT4wF8GlKXElhpKJHw08OpwXw0fawTFp8/HSmZ0Bl8Fo54kHI4Dw0ZMUYXXV76MYxldQ2QSw/13zlrRMnJO/k5FoKhxNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIsWvaQ9; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712417491; x=1743953491;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IItLQYkKzaw4kBGAL35X8jNoobqaR2SlFpegYsg7a6c=;
  b=JIsWvaQ9HB0dE90QpdcOCCi2DZ5ShZ5hphjfByQ9qF0O6Ti9J+hgmDRG
   vSS5KyIRBvAnfPzrvLN24b2CIxrNExTFQphbMoRmuSWihn0Mu6OLEyE/f
   ZSsGlvKV/9YVlbfC9ggb3A1rQMi9Tiv0JE+gJqhSROk3YZO9rMzzal0Om
   UYuDngunFwiPv49m/fOlWWK5D5w3GiDF0FY39si+y4KqcP4IJ7Y6YUIYX
   RnubENXonzqjd8I2SpC2dYtQvZNztWel47ot3zApDXxRt89SMVi0ODToe
   QBnjTUmnDKUBpgP7Dx7FKMnlMCECsJ76NSgUSjFPaA6Z3uVBauC/7HvBa
   g==;
X-CSE-ConnectionGUID: Soj0JcB/SlO7hEes2zuiew==
X-CSE-MsgGUID: 8z/0rNYOT72ZD+VBcWqAvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="7595788"
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="7595788"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 08:31:30 -0700
X-CSE-ConnectionGUID: E12h7OrtStKCUe79DdqNzA==
X-CSE-MsgGUID: 4FEmX2AUQHqolwCyf47bTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="50660352"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Apr 2024 08:31:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 6 Apr 2024 08:31:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 6 Apr 2024 08:31:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 6 Apr 2024 08:31:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvnPRHm15hRyZYR02HBvvjiup12xUVFIM2k0pnrQHKovB/EYdkdYSmQZiJvCB+UZpcf1iS+UMxUGstYDkoWozKnsAkHr7y6ZzXAiMSdgKVjKBicIeIaEoi+iAZGJp2hIY6V1fTaUvAL2MHzlB8A+1nFCWCGOd9itk+o0xiD4/iYHBEMUQjNb1Xl4Xgi8Az92BqMfJM9fipO2FF5/bgEc+UdPFCcE4rY98iLV8ehdJ4te4cKrxxxHdX9h+rJRguj50bo+07mzr0KCpsLcOjOz9Gz3fPjb74s5SdbioswsYgMANGjME+iEBmpI2fx/6sXeAIJ8FgmeG5u+bZEuH/WBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2dJOEgx7UZl/Ows5silAUHM92gfsUp8VtPBuI2SuN0=;
 b=lP9tqBBwWM1Si291agExpy/WSXoda4ZraPyiNqE9wFA+VeBbp70+GwGWS/fkkxpZ6sI8jtA3nv4BEInhbekC+a2aWDlqC3SPgZFia72cZw9WTXQRR867BnTDVhuZxDmlQ1WN8rxixbS+fOQ3Q37T3XVsPBnYiRL1KfG4PM8qlR/aq15feAlHl5/h3Pd0rmOZTB0b6/+Gi1ZqluoLCi2HEw12cbDiE50iGeP+RFZatuQN8D9zPmx7CCZP1WzFLpWaLVoOcJl7zUqrNGyyHT1v0eWgNmottnusjOIs8jd3VNUuxftFRwu7HpCmU5CmeHfQqJExQ51Xjp8ohAXIPx/PPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by PH0PR11MB7524.namprd11.prod.outlook.com (2603:10b6:510:281::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Sat, 6 Apr
 2024 15:31:26 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf%3]) with mapi id 15.20.7452.019; Sat, 6 Apr 2024
 15:31:26 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Avri Altman <Avri.Altman@wdc.com>, Jens Wiklander
	<jens.wiklander@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "op-tee@lists.trustedfirmware.org"
	<op-tee@lists.trustedfirmware.org>
CC: Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, "Jerome
 Forissier" <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche
	<bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Usyskin, Alexander"
	<alexander.usyskin@intel.com>
Subject: RE: [PATCH v4 2/3] mmc: block: register RPMB partition with the RPMB
 subsystem
Thread-Topic: [PATCH v4 2/3] mmc: block: register RPMB partition with the RPMB
 subsystem
Thread-Index: AQHah0/iKlz7KaE/+kKJpZ9yXKNnRLFbGrkAgABCs8A=
Date: Sat, 6 Apr 2024 15:31:26 +0000
Message-ID: <PH7PR11MB76050B745987B7169C8EDA0EE5022@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240405115318.904143-1-jens.wiklander@linaro.org>
 <20240405115318.904143-3-jens.wiklander@linaro.org>
 <DM6PR04MB657580885C16AE4F5743357EFC022@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657580885C16AE4F5743357EFC022@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|PH0PR11MB7524:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hOFHVJ3DEddhrBvXFm1CfpqzFS9D6fqKI/z/n1M0MjSkToYWW+Zr96ttsRhGfNN6/fI7c4MH4vXA1lAKyO0kzqTr6LJp76WrFB+RP0r4nuAboUNo/MdpAFXg2CDthwmvmavsljLZKUudEpKJkB6slrSt2R97T4dERyY0wTiASX6Ug6KZpT3KsQXZOxZWu/fQU0WgQrllGeoiuNv3/KAbHMtmNuDdtpL0RDMs4AAptq5zHb5QiBHrjclUkChDjFCwAvqLtiPkovOj5i6JNAlly9vE9r5ZiGz3Y2YTmF+n1cRaJwwIUwadyOXAux1SubKI1zcZs0Ocb1mvTyie8xhcEElz5Hu6QQYduERaeVEy1gRLGaAQ7KCd6dslREA4IpvApJUncSob/y0WRghnPCmsmqsLQ0FTGFZyG1G15izDyKiSDLyCD+obt32KwAViFtyrnFLLcY519AKwjEaAeZY8xDZOzagOKnCaZMVO6enJ/39vwVMo+4auk8OQkwAnVKWhgDRTg1zEcvI1iieAI5O9bf3BeNnwwb5B5G2TjRBwHiEpwDrwX3FhyM9PqrSyWVeqXUFwApWU0ClFXqjOin97DlJ4M/52UaEf8YjKNYygO9+QjXoL4MqXfBphpODdBsYcbWk6wG+Q0gmiRc8guO4dOjhTviFtvrNSnmXnd62P450=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mV1RuPWGE2t6euJJy5/bTbBRBGrCckZKr3YEBy+uDBxx8sZArb+bX2cE6WWf?=
 =?us-ascii?Q?1RBFpbFZwpwgPaM5hsXnEeWqG61ihTWga++ft46zR0PLPXbF3sFoDcIg2VVV?=
 =?us-ascii?Q?+M2h0122OiQ5EXGDN6UFIeedlEoD5TMyDwLZb1ThDtnYe1KmObqkWOPLfQN3?=
 =?us-ascii?Q?RYkdiuFXyZj55S6OfygUzTL0Y8yA99LIu/JwXEmJAytFXas4g2hB9QsphZ5O?=
 =?us-ascii?Q?Njju5YUOkOOwRSOh9tS9n9VTfO+xyHiqN2ybGm0QJVLD3acwQT0OQOvWke2W?=
 =?us-ascii?Q?oXCuXibDLdDDVkqfqIKLnHVrVQIF+xuDsUi0t28ld70XWaaOI7T4aPgwhR1e?=
 =?us-ascii?Q?EBnUG403ZgoMhL8XYuTdAyckoGv9QxUcm1GZ0Z/AFRbJUo5oFxpmojF3an5f?=
 =?us-ascii?Q?ZzNzhiSuWSixQ3rVwP5z09JEPXgJ/gE93WlJmvoFB1wPG9bm/BuVFzHtc+OX?=
 =?us-ascii?Q?tx9qJW6NxD8G2M+6E4tnGhkCuXMHmnFsRY4EGZJF7U8EEenD9H3XFogZDsYH?=
 =?us-ascii?Q?vmkJd+UgaduCqC8FJutJ3KhWKPwf6aqQ2Zdjr83pOK6DETlr+FnsqQmA9Efg?=
 =?us-ascii?Q?HOVtOO0lAzr7899iEA4g4QKq8yH9mxFlm+FEF6Zr32Qsg24rFGHcKYwaZ2X3?=
 =?us-ascii?Q?UuiQ9rEJ6jPKeMo6F3a4aRKNyqxwrBcVZhrmeC7m4EwV6Aq0Dc7wkmKuaJxE?=
 =?us-ascii?Q?8bSXBzHAIEbZ+2VbFqrmBpvlXjUiLAaM97efDZi4AXoqbnRZr51NqYeBXbAv?=
 =?us-ascii?Q?EqxGeAnWxsc6hQP13m0bXJWy6y4GGoC2Z97ymE7OwgyTh3aR6Bc3ZMfbUm9e?=
 =?us-ascii?Q?cdz63BihIGxUu+1vSYDdPII9YfSG9Z1i4gwJyirBn1LIsX0LDvEQJE3MJi8L?=
 =?us-ascii?Q?KWrQ9upF3g7YBgTMb4SoJ9nU1PeoJot13gZ6+V5QSIHrL40YVv1uZVw8a1IW?=
 =?us-ascii?Q?4UeDMuACR9IK9tXW6hzPda9s/bVQK68TTmKyqJqeKcGGtMQnAJBt5CSfFoDs?=
 =?us-ascii?Q?DcfgVLCxbrm+nZHqwJNMOEo97NpiC9uATp25bDq9fkAK7RboasLXWMLPFqRF?=
 =?us-ascii?Q?crqUzNR7P61Eh0borOo4bTpRAeudXVtd1+akUrDkV1agdfQ2Tsvpm2CEI6ef?=
 =?us-ascii?Q?oXgBkgZX2dffsL0Ok2mshZ2GC11g3DlDtlKk7gqqLXm4VX4akNKOrvH6zTuN?=
 =?us-ascii?Q?H1SMrP5cyYcd5dsAcvGviOCX3xLw4hViQjRg6RQ12dgxC50YIuh7Goz25ktx?=
 =?us-ascii?Q?phTJ5cDZbN8H0LiSbSsdzMwvbGdA1HR+DgQjekYUe4wRP/qOqove3cW7OHgs?=
 =?us-ascii?Q?Zsg2MGgaLklpRma+fGuBqkjwQ5r/HmJsc7JsCDcfio3Q0mlZv+O0UXydB2EK?=
 =?us-ascii?Q?m07m2KmACnezoYqSC6q57matY4E4zpUZUheSIzKWMdlpB6uYwtb2Z3zrSXi8?=
 =?us-ascii?Q?F0Tbyxjt8P9jUmKhfMzr2omEqvtkVdbdd/xi3vNSath6Fewr485sooBVamzO?=
 =?us-ascii?Q?SscrQqLldqZwT/aV4ztdzU1gz1aWAFJzeRS0Cu8/AbAh1kfs1ao57cHghjLT?=
 =?us-ascii?Q?0HFqCKEPyk0Cj24DskLL2fD3WwvPhqFn7T2Rqw98?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1caaca8c-524f-47bf-66c3-08dc564e9faf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2024 15:31:26.5862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGJFsZ4SIUaE09VRFwq1G19pXRw11VtKRSL1AGYuEGP1KA5bA6j0reJDwkwgNjQImU+Dk9/7BiXph/NsXh9jiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7524
X-OriginatorOrg: intel.com

>=20
>=20
> > +
> > +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication
> You expect the key to be already programmed - so you don't really need th=
is
> operation?
Depends in what manufacturing flow you program the device,  second I believ=
e in the original series was also a simulation device,
This is important as the real device can be programmed only once.
>=20
> > Key */
> > +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter
> */
> > +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition =
*/
> > +#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition
> */
> > +#define RPMB_RESULT_READ       0x5    /* Read result request  (Interna=
l)
> */
> > +
> >  static DEFINE_MUTEX(block_mutex);
> >
> >  /*
> > @@ -163,6 +205,7 @@ struct mmc_rpmb_data {
> >         int id;
> >         unsigned int part_index;
> >         struct mmc_blk_data *md;
> > +       struct rpmb_dev *rdev;
> >         struct list_head node;
> >  };
> >
> > @@ -2672,7 +2715,6 @@ static int mmc_rpmb_chrdev_open(struct inode
> > *inode, struct file *filp)
> >
> >         get_device(&rpmb->dev);
> >         filp->private_data =3D rpmb;
> > -       mmc_blk_get(rpmb->md->disk);
> Maybe add a comment that this has moved to mmc_blk_alloc_rpmb_part?
> For those who will look for it.
>=20
> >
> >         return nonseekable_open(inode, filp);  } @@ -2682,7 +2724,6 @@
> > static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *fi=
lp)
> >         struct mmc_rpmb_data *rpmb =3D container_of(inode->i_cdev,
> >                                                   struct
> > mmc_rpmb_data, chrdev);
> >
> > -       mmc_blk_put(rpmb->md);
> Ditto.
>=20
> >         put_device(&rpmb->dev);
> >
> >         return 0;
> > @@ -2703,10 +2744,157 @@ static void
> > mmc_blk_rpmb_device_release(struct
> > device *dev)  {
> >         struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
> >
> > +       rpmb_dev_unregister(rpmb->rdev);
> > +       mmc_blk_put(rpmb->md);
> >         ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> >         kfree(rpmb);
> >  }
> >
> > +static void free_idata(struct mmc_blk_ioc_data **idata, unsigned int
> > +cmd_count) {
> > +       unsigned int n;
> > +
> > +       for (n =3D 0; n < cmd_count; n++)
> > +               kfree(idata[n]);
> > +       kfree(idata);
> > +}
> > +
> > +static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb_data
> *rpmb,
> > +                                            unsigned int cmd_count) {
> > +       struct mmc_blk_ioc_data **idata;
> > +       unsigned int n;
> > +
> > +       idata =3D kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL);
> > +       if (!idata)
> > +               return NULL;
> > +
> > +       for (n =3D 0; n < cmd_count; n++) {
> > +               idata[n] =3D kcalloc(1, sizeof(**idata), GFP_KERNEL);
> > +               if (!idata[n]) {
> > +                       free_idata(idata, n);
> > +                       return NULL;
> > +               }
> > +               idata[n]->rpmb =3D rpmb;
> > +       }
> > +
> > +       return idata;
> > +}
> > +
> > +static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
> > +                     int write_flag, u8 *buf, unsigned int buf_bytes) =
{
> > +       idata->ic.opcode =3D opcode;
> > +       idata->ic.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> > +       idata->ic.write_flag =3D write_flag;
> > +       idata->ic.blksz =3D sizeof(struct rpmb_frame);
> blksz =3D 512, so maybe add a compile-time check on sizeof(struct
> rpmb_frame)?
>=20
> > +       idata->ic.blocks =3D buf_bytes /  idata->ic.blksz;
> > +       idata->buf =3D buf;
> > +       idata->buf_bytes =3D buf_bytes;
> > +}
> > +
> > +static int mmc_route_rpmb_frames(struct device *dev, u8 *req,
> > +                                unsigned int req_len, u8 *resp,
> > +                                unsigned int resp_len) {
> > +       struct rpmb_frame *frm =3D (struct rpmb_frame *)req;
> > +       struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
> > +       struct mmc_blk_data *md =3D rpmb->md;
> > +       struct mmc_blk_ioc_data **idata;
> > +       unsigned int cmd_count;
> > +       struct request *rq;
> > +       u16 req_type;
> > +       bool write;
> > +       int ret;
> > +
> > +       if (IS_ERR(md->queue.card))
> > +               return PTR_ERR(md->queue.card);
> > +
> > +       if (req_len < sizeof(*frm))
> > +               return -EINVAL;
> > +
> > +       req_type =3D be16_to_cpu(frm->req_resp);
> > +       switch (req_type) {
> > +       case RPMB_PROGRAM_KEY:
> > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > +                   resp_len !=3D sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D true;
> > +               break;
> > +       case RPMB_GET_WRITE_COUNTER:
> > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > +                   resp_len !=3D sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D false;
> > +               break;
> > +       case RPMB_WRITE_DATA:
> > +               if (req_len % sizeof(struct rpmb_frame) ||
> > +                   resp_len !=3D sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D true;
> > +               break;
> > +       case RPMB_READ_DATA:
> > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > +                   resp_len % sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D false;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> Looks like the above input validation section can be reduced to is
> RPMB_WRITE_DATA and default?
>=20
> > +
> > +       if (write)
> > +               cmd_count =3D 3;
> > +       else
> > +               cmd_count =3D 2;
> > +
> > +       idata =3D alloc_idata(rpmb, cmd_count);
> > +       if (!idata)
> > +               return -ENOMEM;
> > +
> > +       if (write) {
> > +               struct rpmb_frame *frm =3D (struct rpmb_frame *)resp;
> > +
> > +               /* Send write request frame(s) */
> > +               set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK,
> > +                         1 | MMC_CMD23_ARG_REL_WR, req, req_len);
> > +
> > +               /* Send result request frame */
> > +               memset(frm, 0, sizeof(*frm));
> > +               frm->req_resp =3D cpu_to_be16(RPMB_RESULT_READ);
> > +               set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
> > +                         resp_len);
> > +
> > +               /* Read response frame */
> > +               set_idata(idata[2], MMC_READ_MULTIPLE_BLOCK, 0, resp,
> > resp_len);
> It is confusing to me that your response is holding 2 frame types:
> The status frame and the response frame.
Refer to the spec.=20

>=20
>=20
> > +       } else {
> > +               /* Send write request frame(s) */
> > +               set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK, 1, req,
> > + req_len);
> > +
> > +               /* Read response frame */
> > +               set_idata(idata[1], MMC_READ_MULTIPLE_BLOCK, 0, resp,
> > resp_len);
> > +       }
> > +
> > +       rq =3D blk_mq_alloc_request(md->queue.queue, REQ_OP_DRV_OUT,
> 0);
> > +       if (IS_ERR(rq)) {
> > +               ret =3D PTR_ERR(rq);
> > +               goto out;
> > +       }
> > +
> > +       req_to_mmc_queue_req(rq)->drv_op =3D
> MMC_DRV_OP_IOCTL_RPMB;
> > +       req_to_mmc_queue_req(rq)->drv_op_result =3D -EIO;
> > +       req_to_mmc_queue_req(rq)->drv_op_data =3D idata;
> > +       req_to_mmc_queue_req(rq)->ioc_count =3D cmd_count;
> Maybe have an additional struct mmc_queue_req *mq_rq =3D
> req_to_mmc_queue_req(rq);
>=20
> > +       blk_execute_rq(rq, false);
> > +       ret =3D req_to_mmc_queue_req(rq)->drv_op_result;
> > +
> > +       blk_mq_free_request(rq);
> > +
> > +out:
> > +       free_idata(idata, cmd_count);
> > +       return ret;
> > +}
> > +
> >  static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
> >                                    struct mmc_blk_data *md,
> >                                    unsigned int part_index, @@ -2741,6
> > +2929,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
> >         rpmb->dev.release =3D mmc_blk_rpmb_device_release;
> >         device_initialize(&rpmb->dev);
> >         dev_set_drvdata(&rpmb->dev, rpmb);
> > +       mmc_blk_get(md->disk);
> >         rpmb->md =3D md;
> >
> >         cdev_init(&rpmb->chrdev, &mmc_rpmb_fileops); @@ -3002,6
> > +3191,41 @@ static void mmc_blk_remove_debugfs(struct mmc_card
> *card,
> >
> >  #endif /* CONFIG_DEBUG_FS */
> >
> > +static void mmc_blk_rpmb_add(struct mmc_card *card) {
> > +       struct mmc_blk_data *md =3D dev_get_drvdata(&card->dev);
> > +       struct mmc_rpmb_data *rpmb;
> > +       struct rpmb_dev *rdev;
> > +       unsigned int n;
> > +       u32 cid[4];
> > +       struct rpmb_descr descr =3D {
> > +               .type =3D RPMB_TYPE_EMMC,
> > +               .route_frames =3D mmc_route_rpmb_frames,
> > +               .reliable_wr_count =3D card->ext_csd.raw_rpmb_size_mult=
,
> > +               .capacity =3D card->ext_csd.rel_sectors,
> The capacity is RPMB_SIZE_MULT and also limited to 16MB?
> And you also need the region size you are writing to.
> If I get your intention regarding reliable_wr_count, AFAIK, rpmb can be
> written either as a single, double, or 32 frames.
> And this should be induced from card->ext_csd.rel_param, and not card-
> >ext_csd.rel_sectors.
This may change in the spec since this patch was written it was few years a=
go.=20
>=20
> > +               .dev_id =3D (void *)cid,
> > +               .dev_id_len =3D sizeof(cid),
> > +       };
> > +
> > +       /*
> > +        * Provice CID as an octet array. The CID needs to be interpret=
ed
> > +        * when used as input to derive the RPMB key since some fields
> > +        * will change due to firmware updates.
> > +        */
> Not sure how the CID register is related to RPMB?
> Is this something internal to TEE?
Yes to identify the device.=20
>=20
> > +       for (n =3D 0; n < 4; n++)
> > +               cid[n] =3D be32_to_cpu(card->raw_cid[n]);
> > +
> > +       list_for_each_entry(rpmb, &md->rpmbs, node) {
> > +               rdev =3D rpmb_dev_register(&rpmb->dev, &descr);
> > +               if (IS_ERR(rdev)) {
> > +                       pr_warn("%s: could not register RPMB device\n",
> > +                               dev_name(&rpmb->dev));
> > +                       continue;
> > +               }
> > +               rpmb->rdev =3D rdev;
> > +       }
> > +}
> > +
>=20
> Thanks,
> Avri

