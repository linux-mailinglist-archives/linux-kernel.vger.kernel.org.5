Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8015E7BF6D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjJJJHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjJJJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:06:47 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B619AF;
        Tue, 10 Oct 2023 02:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696928806; x=1728464806;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mUFnrkRcJhWUo1gnDF1onJD7bXBuVZ2+vUn0luzEPGA=;
  b=IldugP5WqbbNpXzIHgjHBwfBg4DVsOavMnGZH+ExLgdG1k70LBDYdMol
   /C45pYB6R4iO3MtcOl+YFENmeQ+5ZkzSedDsLEaacruuBuOtxC+GJ4V48
   CoASwyffVygcPWwGc+Kf5hhmTH+YIPgshAyBMlEr/rzVHWp3BJIM9i2Fm
   +yJ36ipZhPN9H12UVxAaFrd0QmRIYbB0kWEcZnkuYJ46m0pyHsHlBwtDJ
   r844ykTlUKlxrLN63BltotUICK+2X602eHGCbMU0AtRCdnHz/OCQixD0d
   uaOykT07VQBkH+95189GhtpxZmyTuwDv/8WwUsVTN+4uOQNcHRIj/4Q94
   Q==;
X-CSE-ConnectionGUID: OG9cZ2vETMqi14DzMkgkxA==
X-CSE-MsgGUID: Jbpcf5QiR2K6m/Yq1boiWA==
X-IronPort-AV: E=Sophos;i="6.03,212,1694707200"; 
   d="scan'208";a="351522480"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2023 17:06:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrnBYyBHM/NJM+JVZXIdSD44DVbnRy5gNMd8Faj2p2d4Lk94y9ahpfXMp/zqUwgStgpdZg9AKQt/EWybHjHIZXFsXAtWz1ZfphYcfQ201fuYPYI6vew3X9CWGLUvVzXQ+iLqWyBI+bKbEYhQuoXw0HtN63jvkFhJlkheBZl3Om7X8ya/Vh3hkxqc6jJEyuxbPQr9lCcPOd61sOiYT0N1FmtM+WMSi+RjQxZGM0pzWpU4NeKfsr26g4KkOZ9AVitS66qWElcxGyLEoExz9uNixNTGPCsJjEDF9zFWGo1/3u3pXC4+IKO30sDnIUFyF1mhKKcyB6yVt8ob+hR/EKLVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdNnrcCJwe56IBR35JYGzZq1yaQkKELeeBRMj+7FdjU=;
 b=XvHgvbhBTEedvN6muKNLJHxs61ae8FUlp9fkZ/uFdCCx+o0ZuiRCuzYkpb2Fr44/YeAaHpx6OoSHq8eYP9Tgew95ga9Br5oXPHGjXRhP3NzKZpxBoccX1ZnmQcYHiK8smsXF2GjIbRxRe3xLTQymbxWX9fYuRtCLkNjtPcave6laVRjeZcAtBVwwohS6NASTqUY1NxnnD7fNXkGvrLncjud0Us+Cg2MehZGV0ujV0ztWP5pkX6HFxBnteKAP6WK5ZXHee/cPsV47NPmKlnJmSFRb4WJHQFXrX6B9+WIj64ffEaySljas5vU38I+iTjzsVPl6D1OB3bqJS1hbLBN46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdNnrcCJwe56IBR35JYGzZq1yaQkKELeeBRMj+7FdjU=;
 b=wvUmLxHG1Nt6dInCx8ehHUUsqmSAF8sce5otErZsnk8z+ELl5byEqy+AC5eeEFrtG1tuZgkToxkFJ9EoDI30h0N9O8UzjrXAdT0aocBSNrITwffhFiKAJmDhDqWeg7Yj29byaJzxK+amgSRUj256W+/kc7dOZJgTZoGnVt3ISDY=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MW6PR04MB9027.namprd04.prod.outlook.com (2603:10b6:303:23e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 09:06:42 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 09:06:42 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     Ma Ke <make_ruc2021@163.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ata: sata_mv: aspeed: fix value check in
 mv_platform_probe()
Thread-Topic: [PATCH v2] ata: sata_mv: aspeed: fix value check in
 mv_platform_probe()
Thread-Index: AQHZ+1kU5B4BC+3D3EianOt6+pON8g==
Date:   Tue, 10 Oct 2023 09:06:41 +0000
Message-ID: <ZSUUIGgzcAPudwdK@x1-carbon>
References: <20231009124955.4046988-1-make_ruc2021@163.com>
 <2c877878-7e30-43d6-ba93-d37cc2fbb1ef@kernel.org>
In-Reply-To: <2c877878-7e30-43d6-ba93-d37cc2fbb1ef@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MW6PR04MB9027:EE_
x-ms-office365-filtering-correlation-id: 3c841f23-8ca5-4fdd-85f7-08dbc97037c5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jgn6oBYECp+mfdkOLCmh/QVjExXV9JKb9nAJNb8jlCFTfBIRlW5r3pgWmpep8CP/CzMWkHvX8PmLmrkU9vOgtF9TqtqDisCbG/MmBWFKWQMToJPfJGo9gpwFwrf1Am3JTvTUr6hiS1RKT9Jfym/GfvmbWNKRBmifL+O/KfzxIW7kvDNCbSzkgQm/128p029J+dLJSw5DzGDv7wP0IGuCmnR/SOXe+fVeM1cYsUQ3fW3rceP3IGLKl8t8iPmjRva6kBKCnHLLExZneitFe7wIYxj/GTR8GmVX9f2Ln1iHRMWvEa15w+pv7t6y/8j9QClmqgn6QCjmiHYQQR/jDo+fx1uVfFHudlIV9AvAz3TsAifUlZ5eBUNxj+1/70gsQSq58jNvlAT1QDzi4f/q9ilqXvgTx3YErJN+tu8ASabKqqwIb4+s9FI2N3shhwiQoTmWgTFO88/3b8elDObhIMMMer+GZYOH3nagSvkUG5ROwyNBicBj/9F4zjC8kKDEEw5B8GgIk67+WsvDpfoVQ3pkREW7C+8wLPou9qOjkq1j+8li2GzCGHLfrRlC1SrnPb4ofi4uRb7T2bq6VDbWUxQHKylTWeCxSnlBr1mez6iSveUJ1jLS3OQwqpMHpXvi5mln
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(9686003)(26005)(71200400001)(53546011)(38070700005)(82960400001)(86362001)(122000001)(38100700002)(83380400001)(4326008)(2906002)(6512007)(6506007)(8676002)(478600001)(54906003)(5660300002)(6486002)(66946007)(316002)(76116006)(6916009)(8936002)(41300700001)(66476007)(33716001)(66446008)(91956017)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7s/WW3MxqSqVQaIun1/c1yd0TTYIxU5C2rHYi2ygmFCpTYqa/vNMPHF5lNm3?=
 =?us-ascii?Q?U2QTdMqDkvurrXSbvQH0ECUDPgKOe2MTCKjFDBsxjIYt3a8XUzEmllitP09l?=
 =?us-ascii?Q?JAlGELKp2b3NyBznQITTtJX7DjtiNjbe7OZEPIBkBinXS1opgyVY4UJCGCwL?=
 =?us-ascii?Q?Z/xt3XZAgBYN0PDQqKbaHHfCER+X28MVmKdiYCjQymR924F9aGmLT+aFJOIT?=
 =?us-ascii?Q?QBRf5YGK4KnPRgyTG4cPkcQPy0cTuBKLnLsG0rz5rBoA3EcOpzw4GE4FA8bd?=
 =?us-ascii?Q?5vud2f3GYNKZLsfjY6Xy86hUkqZEaFPd4WwDObqVK95YkWSqa/IJbjQq+lgC?=
 =?us-ascii?Q?Bk3XDjDVZyYnz4+4RvWVqAPAZI2k6hLLv4MwgsFjtR1wVq2IsJaT7Wwvx++S?=
 =?us-ascii?Q?YHHk3DFFTlh7A+SRCBBKFD+sq9AfsKaBN9P6ywV7PNQRDwGC7OvCSTIm2UVu?=
 =?us-ascii?Q?OH2KP2KSaG6OR3Ohr0ubNEqjKz5JXhQrdQFe3F8tgRwdVOxO1Nww28zetg67?=
 =?us-ascii?Q?DbXEPlMGmYcozvLuhMS5h8YFeIfm4GfA5dt2n7jDSE8sWx0c8gDbn4tuQ8lE?=
 =?us-ascii?Q?b37IOl4mCJWrGIZgSE+LctNnHJsJ5LKnifHvivjsJYSq+SWMWXl+K8LpCeds?=
 =?us-ascii?Q?7lXI+5Zj2sBx1dkEu0hS/zgAm+USEhH43Ls/5xJd8UpdLFGg9JOGmcEDWAMq?=
 =?us-ascii?Q?oN6OefreH4NIX7IkHH2B3WXhtoeGtlVZajPIIJCyoQUCZmldH3/9Gsob0870?=
 =?us-ascii?Q?fObgYpgjIL5pL/fdAgUUQaaRSGgxS2AdOc2FmzJMGDsCRLbfUkae5spdB0h/?=
 =?us-ascii?Q?b0FXhPtxw1kOP/FSHCpAcw9yeMQ4oXps/ce+vnbiUUbiNtH99TjOjHtR0f1p?=
 =?us-ascii?Q?VofBtef5LavLkdcMLiEP1JVw5gVmsG0yb6n/KseudTEK+bK3Mjv9s8ywG64s?=
 =?us-ascii?Q?OP8Nm1mi2s6n6DSCwKELd3tZzzWkEeRzYiziGKvKatdNnqEcUDfpbD4NnIQz?=
 =?us-ascii?Q?YR79+qi1aebGvOwUijP+CXOU9CdTJkMOHCMqFO5GmQ8+MPK/h6dPWdid69qI?=
 =?us-ascii?Q?isvTNM7VXU+VhnovM65YqhS0wYaGAqoT6rRdAaCcSYFlI025IKpP/GYQF7ZF?=
 =?us-ascii?Q?ZvfpzVrx2gn97MzDHXY9HiQdmMGvutgs68qoMtx/26e26TCNodqFCxnpFYWU?=
 =?us-ascii?Q?hUUgQoyfaseqznoo7eT9Vnx+yHpW/9/aR2Y/EnnN6uzSpzBft7hNt4QGNRko?=
 =?us-ascii?Q?oxLhLnl7xLa+71W6z4DmIkPQsJMjEzClTuUWO/dqLPRQpK5vrPY6cW3V/CI9?=
 =?us-ascii?Q?Dy2zmN+MRFc9ZNRLDVJwwzlcvDFZixwBCuKTn/9JiCtIhuQvbO6fKnv8T4I4?=
 =?us-ascii?Q?0zyMsM6SqFGkPHTVV41E397z2rfw2kyN8/ViXim3PAGaDjFWIQZHiQAzZOlk?=
 =?us-ascii?Q?NZjme5+F/2brOyUOyXEb/0s03o3HBwCF5pZ+FdV8epeLhhm5XSanZJxRR7L5?=
 =?us-ascii?Q?en67Erku6bvwtZMeQAl9Sw9KI+r/8vjR+AyG2OvC4Q8wDZXL3jWPE4Lq2BTG?=
 =?us-ascii?Q?hjKNd2lIlsjMeEo9r7yPVEna/MeN6kY2FnChoYpbmolSvgzbk+qNsnGaKotw?=
 =?us-ascii?Q?5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4EAB608EC30A214C8A0DD96C3F510E4B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9oJaR0xrW+8hkcifMP7Ia6nwF0JZk0zz1nQGya+wDp5a4sYjUGMiyIcMuu9g/pCDGoL3fBXx+Fso8KvjnZYelnGRa97L6s6uXjVUJ+RoCTKj7SozxfooBNEwGMEsjE5XMQpQMFJ2bQKIWQgheLdDk/ZhrLi8Qkut5WjYxZG0f0kN1lBBWgV3YviFPIkmzZSWFjyIFYDt2LiQqiD60h6aIgI88Lb+gnRyGbCGsTUY0x3xfWbqSUTmDivXxgBgXgjqbsdV4ocQwwPyBLPQnWdtegJfwjqYWJ91wxJotjU6mi/OjQVyfb7T9vc8i7OjwneKmXYvG/9MjCydneeISCVj2bWMgVOGB4CLEEttS7w854qm7xIQOgn2pM22SulQjTK+rIGMjOt//4DpvGqflTa9mjxxI41QJbt9UDbZQqTlCAJKdgEFVz+/YAoh6I2EIDO3EhlF+yCarulnp05lm8x0bOyCa//g3NASbrNsukD33t7OGvA7h0RWIw4EphMms2Sf9fqJf1tB3PhEZvMyKKxmRD7CV1i8lHOGFY6pbp59wqkJTqpdAZJn7Z1i3ZPv4fB/DwbyGlErslfB7VEr6LNKvLUR575p/yypfH0F2bOuAvsPTKbPHp/axQN+cnVqAzQxa7vk/QG9bhNt+ifSCyuOrcIWwM7AMpiV/ev/1Q0nwvlIjmoPREc+gHNQ78tuCPIiYLpPMDgzImXR/GYgIrWf0qpC1ua2g9PTdDAHHMhRIOA36zd0PvU9hCQkh6yDQPvEshI+OL6oTFPMGbXsOZgGc+rx3iE1RyinpvQuF4XvGi2hdeusOXmXJyzgeOTfjZcSqW6tcPVO9uDlVJYFihMBPg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c841f23-8ca5-4fdd-85f7-08dbc97037c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 09:06:41.2054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdlNCupGr93PLYExR56gL2AYz1FDwc9Qs0mzfgtGhsCW5b/3iT4VfeZ25sTRAw2G2eFqjMRfDr7p3LpLLqeN1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB9027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 07:33:49AM +0900, Damien Le Moal wrote:
> On 10/9/23 21:49, Ma Ke wrote:
> > In mv_platform_probe(), check the return value of clk_prepare_enable()
> > and return the error code if clk_prepare_enable() returns an
> > unexpected value.
> >=20
> > Signed-off-by: Ma Ke <make_ruc2021@163.com>
> > ---
> >  drivers/ata/sata_mv.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> > index 45e48d653c60..df3a02e7a50b 100644
> > --- a/drivers/ata/sata_mv.c
> > +++ b/drivers/ata/sata_mv.c
> > @@ -4125,8 +4125,10 @@ static int mv_platform_probe(struct platform_dev=
ice *pdev)
> >  	hpriv->clk =3D clk_get(&pdev->dev, NULL);
> >  	if (IS_ERR(hpriv->clk))
> >  		dev_notice(&pdev->dev, "cannot get optional clkdev\n");
> > -	else
> > -		clk_prepare_enable(hpriv->clk);
> > +	else {
> > +		rc =3D clk_prepare_enable(hpriv->clk);
> > +		goto err;
>=20
> This is wrong. The goto err should only be done if there is an error.
> Did you even test your own patch ???

The "if (rc)" was there in V1....

I should have caught this in my review of V2.

BTW, if we want to be compliant with the coding kernel standard,
you should also have braces on the if (IS_ERR()),
since there are braces on the else-clause.


Kind regards,
Niklas=
