Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5606378C826
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbjH2O6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237185AbjH2O6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:58:25 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2091.outbound.protection.outlook.com [40.107.114.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32108BC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:58:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlTiPao3KcG+GJUqfMM0OcLLbm4MwRA+Vi5CyRGUZpbH4dDCeWccS8pT4v3H6SjFp1qNUrzDYEa/ZON7dUb7vf0UwbFnB0IutAw1xFcHTfT9bHf+q7QYVfWEx7dnrEorJRSrR5YnPdLAXcFDPgRZKsvchVFKiSuX366CDgElVZAkBFjbbNi0ICsDHEHxoNTFgCfnIr4YK+lTTo9SqxH3bFReMozrQXtVRxt6GtzaSF0iarasVIF4TSe+ZxPZmVJc9wliSPXqWsiJnv+pedzUFajwEe9t+RG/pcqZ4zCa6rWXeiKg/4RA3009BgrIInrhHcXv2LOfM2K6Ov7/y3HRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6N0BEywH8jrkXlBGKMkMcwAcgrcMAEwtG4bUjVi669M=;
 b=ddK3aSzm8r0XjoVtzsVR/FW/JmjPwQVmsZ7weGpM5fTsjrHLZOeiRknbjbpJgFfR+mArqRaIVD1c2Y8tgLYhSrC//4TUdx6AaIFfcjGw6FHmM8USgagmqobRoizDDfxDzUqxWIIfi4NiE/UchbGPEu6R53Jhvw5B8Rjv82iHMA6QVsPSxDp4w05tFFQRd2QC82SsjfEbKQK6RYf0zKDJ3pV3gIfoJguDOeib67I2KUlZ+Y6yTqHmjGV19Zv/IXbdBYJCA0pY8prKSjaPxJPdqemz9TrK5FhqqLrT/XL0rZTXRTJMp439ty8VGE8j2sbTBr2w5FUR+PkE2Q3GsDJKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N0BEywH8jrkXlBGKMkMcwAcgrcMAEwtG4bUjVi669M=;
 b=PlW/eI3AsXprU9Z/JywCSlNUHRXm52/WC7UtNCiHxI8wbmBvgMa50S4OWfQkpafYyHjYKP+D7gbYIXF1WLH4WotOpp0rbb0frI1ct372ko/DR7JXnHbIMP9pYX5/BUNRASOuyHGyp4nxshJtNOPGmrK2qjdxtDvi+KRtKxlOWe4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8520.jpnprd01.prod.outlook.com (2603:1096:400:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 14:58:20 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 14:58:20 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Lee Jones <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mfd: max77541: Simplify probe()
Thread-Topic: [PATCH v2] mfd: max77541: Simplify probe()
Thread-Index: AQHZ2cWowor76gAUW0m01pMBhMsYLrABXYIAgAABFMA=
Date:   Tue, 29 Aug 2023 14:58:20 +0000
Message-ID: <OS0PR01MB5922AE1C328FD2485C4D83BB86E7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230828153805.78421-1-biju.das.jz@bp.renesas.com>
 <ZO4GViBrAvAG5EPT@smile.fi.intel.com>
In-Reply-To: <ZO4GViBrAvAG5EPT@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8520:EE_
x-ms-office365-filtering-correlation-id: acdd0131-da6a-4837-2aab-08dba8a06280
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dPuuXmWfiX45eNoubnWbcPo9plcoxSZV4c2N32qFLxVZvk+2t1JQ/BHjcHCGhlabRb6FtDL0MXb2QPFu43/PJebGCVJ28NIdlpFVmOJWejvvI2rDIuA8aUgkx8sJqcn7Oqz/1PwpobpfsPj7xM0JSo0f3oi60E6c3S8CkGZ/8azGc/npiRs9ui5etl1ydOmL9+wOJIzq8IX9ep7R++ILndHXoc8RFssnf8q4nwWWUPlqfjf8GKR3G3tMfXRhTMzPQXvKEV2B1ssLa1F0WG4pr2laW6XSe9Wx0ySRw1UgJXitnjF60uoh1mwkBUDcxlFBZR3RMRei+MqoS5UjLCMavhTySI2vSg3DzagHsZRiOVrLFEN+UQGJB/Og5rlzTvSdxN4tHQmGY97OYNlbl7j0hZTaQNgGZhx2TEgfGuLqhUrNd/TVO1tYrwcRK+CVno4ppE05qP1Ij1sJ65AgeypDRgNn/aM+RYzuZxw1qZyBLpltTDFtB0TSYZIQmhGxy01ETGcA9FdjShdtw3nZIpjp3+TyFsCWMD1koVOkxNp/+jvC8FWM/ECTeh6hFfEUw+8i0mymvRopiVSImz8YabkKzj8YICogsAQjdTJg8wRcj9C1Mqul5UrsYRB8zf2hVLvi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(186009)(451199024)(1800799009)(6506007)(9686003)(7696005)(71200400001)(478600001)(4744005)(76116006)(2906002)(316002)(54906003)(66446008)(6916009)(64756008)(66946007)(66476007)(66556008)(52536014)(41300700001)(5660300002)(8936002)(8676002)(4326008)(122000001)(33656002)(55016003)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xm673BRU6guYvjPXvMv3LWuTlg9uGvw5tkM9jn+yFXzk17EFS2bh0CRvaTmu?=
 =?us-ascii?Q?Wiyn/RHNlc8OlAmuU5Kkqu09uTvB+0B+fF2odfWjbQ9JuRDvzwnMUwgOb0mB?=
 =?us-ascii?Q?augNldHhpJ1SSBB39Cp+/O4EzRSyB7/9n9u+3BWLAA7uCBAyysis2Z0JhBIu?=
 =?us-ascii?Q?+8KxqF8YRVnEFz0LTmtFg3XtcGEWywNcWkhcK/BwK5KdAzCjr0VfKL8Ki8Fs?=
 =?us-ascii?Q?QBBF1H6hcsCZk67b3+mHrwbzGVH82WGmCvVUrcj2b0HOm5M80oZsf/l3LGJx?=
 =?us-ascii?Q?MBtME1oLt8BCTs90fYZVRrnP6ycB3QpYwVt9I03PFsYyUaS3aeJ5t0qYN4LQ?=
 =?us-ascii?Q?HuL5qhf9XJMNPQWSpkZRAFo44hijQ1VLnYWNWOfLPKnPC1EiUObkjpR14aWo?=
 =?us-ascii?Q?57Txf6Q3KuJoCvzDI1Z7otmocknCOEg1yXnVJ4JjzmHA9JAJjDWRR2KeE+g5?=
 =?us-ascii?Q?oyr4Ip449lpvesO9VTtJTij3S5SOaoUkpze0FyDG3bTi91tv4p0bFplKmcJC?=
 =?us-ascii?Q?V/5NEQPJZKMPLFpwqFIZ61NFaK8gOlWycFZfW+8k6Gj3zZNAHsu4MDgH4gxr?=
 =?us-ascii?Q?gdpbcH9yFHQIkN8J3SnirLK399macdxGQF4eK3SBhebOcgfnghzQL5yIeJAK?=
 =?us-ascii?Q?qrbR/JtXQqcJ+98Hy6FmC+3wAtZYzmB9onktO07jxVRMWOLRcL49+HEJxXLX?=
 =?us-ascii?Q?cQDY6rhpk7w0hzb/Q4UtJi12bjjJa9Cb9oKlQZDUb2RotcLoUIahLM2vOQKq?=
 =?us-ascii?Q?7vccDrL1XrAAkYe61Iwr/TETweCmhEqMMF/GyLVIMeMqjkhEXc2ixLcXD8pZ?=
 =?us-ascii?Q?e6JiHSZ18sWD2ETWgwaE7W6ploPLLvMZkrJ7igK4F55fsW1SjxzF3cdC+cDv?=
 =?us-ascii?Q?kJu7EMR+LNz8Ky3daBx69MAnndUDHftzzapOHHkcRW9Erg/Qu4Bc8FTLzZje?=
 =?us-ascii?Q?wxBmGPlEWgVrUhaA7w1kE7PTqOlLFCnzcZ5pqAf0at1cXVr14oSDAJhlI77k?=
 =?us-ascii?Q?tmYQnrh8clZYyMpOzTb6E07pf2Bxf9uLt3H29gyKC6QX6HaM5CEdWjd89nsd?=
 =?us-ascii?Q?MnbCXNX8Fjnfqq+Xg5VR1VKMkVxAgqp6d+P/2wZk1uOCSSCF/go4ZXcciBA3?=
 =?us-ascii?Q?cu24WrZ2RFTDWXnje7nAYmh4zP8ZKNpaKj5XUPwnfgyvNNCZskDcuI+8bi/Q?=
 =?us-ascii?Q?Eh8/33wM+RGlVYlrT2qxYcLUkJedvfhL0cYdO85tL772LjPnAUFPMshIe+Il?=
 =?us-ascii?Q?oHumxSdrZwKk6QtSpZ3S/j3jYe071GF19cJ0kuzo7K90NHcncg7pdz4sc7GW?=
 =?us-ascii?Q?3Ijl75jDUmq6Y549h4jhQHgj6AlkSeNg9i1aqkSuo29HW+KW4HgPSxkgY2ZH?=
 =?us-ascii?Q?kdOhRdQ2EBKk+CLcj+kTRKPrtuUsi0pZEFE9BIx/jCpVY/YnN9Ups93eH3Ep?=
 =?us-ascii?Q?X6z9ioAg8jrU/yJGzks733JRSZtUPEcHJQFx5f9n/+IH/IxSmNjMV2layVv6?=
 =?us-ascii?Q?vYmEvLbljS5k4Tylfhvt3liASHZjXRna8u4sJBgDwm95S4IZs0oqXXHvmGlJ?=
 =?us-ascii?Q?ZJc+FCWroTeje3L9qUE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdd0131-da6a-4837-2aab-08dba8a06280
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 14:58:20.3633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SnIzrpM9vXJd/nBO0Dilga6MsUQPoA1LJEGyWJpcYg6i1+QDgigDo/o+RmVBeIJul1hSSvviPltO/vIsoyp185ClYQTp4W+C8XWnApOVNZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8520
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy Shevchenko,

> Subject: Re: [PATCH v2] mfd: max77541: Simplify probe()
>=20
> On Mon, Aug 28, 2023 at 04:38:05PM +0100, Biju Das wrote:
> > Simplify probe() by replacing device_get_match_data() and ID lookup
> > for retrieving match data by i2c_get_match_data().
>=20
> ...
>=20
> > While at it, drop leading commas from OF table.
>=20
> Sure?
>=20
> ...
>=20
> >  static const struct of_device_id max77541_of_id[] =3D {
> > -	{
> > -		.compatible =3D "adi,max77540",
> > -		.data =3D (void *)MAX77540,
> > -	},
> > -	{
> > -		.compatible =3D "adi,max77541",
> > -		.data =3D (void *)MAX77541,
> > -	},
> > +	{ .compatible =3D "adi,max77540", .data =3D (void *)MAX77540 },
> > +	{ .compatible =3D "adi,max77541", .data =3D (void *)MAX77541 },
> >  	{ }
> >  };
>=20
> Seems to me an unneeded churn as nothing has been changed here (except
> commas and indentation). If any, it should be a separate change.

See there is a comma after every .data, that is leading commas right?

Cheers,
Biju
