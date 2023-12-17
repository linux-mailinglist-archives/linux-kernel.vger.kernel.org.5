Return-Path: <linux-kernel+bounces-2477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C03815DA9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 06:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9EECB229E0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 05:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEE6567F;
	Sun, 17 Dec 2023 05:26:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2057.outbound.protection.outlook.com [40.107.117.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532405667;
	Sun, 17 Dec 2023 05:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVjvWJGT0t/PhrOe8Ne6WcaDrHVbia/QPV/gGuA4ciYwb/vWMM+s6LQlxYe6G0GAACi0WihTknb2puwo3MPF+/x1CLkl4X8uiXUW2gC6d/X34Of/6rnT+uVz1eigOBRFdLy0y4e6EwWxxODK9YhUUZuOCLOdFVfkTDjQyrKgPC5OzQC0h8LTC8f0fsIj/C/It444XIURnrURihbwqDjtQWDUJ3n7qt9kCcLu1CP0AIRoli7ebNcTS8XmB2I5R2Wjzt/LMtGBma0PxCDkRnAxocTdKu+sJyovu9hsaZjJFlCJkkHJuiAfSyXbR3jNOOSe0cp+OE35epTMopfLA8i2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1Hz1J+cfdSiJlvuV0NBKAgd9gNCrqilPSjAVbeOQU4=;
 b=VYiUisSbGVQbObT4l+FRytJWT7LqSMvjVo+ghAV79hbgPLUNlftf9xhh3c7SyWWNALx71/BuIFj8KPNJt3e1lqxSwyI2rZ4X13nQ6MwmQtvYi9wxKO/QdrXxaqTg871wRpqX5qHGPmB2dqrFj7yYrwAIPajKo626HVDzS/+2J+knGlSNx5UQhlbzvakHlSahk4GML3xsh8hHWV3FNzyBX8lcjvFVcDrTtIdjFDAzdrsVOHZgTFtaDGPhAHFYP5wwG/JR8kZuJaUMdYb5lpmdKbMDuD8byGLI2V+aWBKaIi8tdzFXc96PjRFeFppIsA418JlM/ecsq9eI+lDhb8M5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5)
 by SEYPR06MB5205.apcprd06.prod.outlook.com (2603:1096:101:8b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:26:11 +0000
Received: from SEYPR06MB6278.apcprd06.prod.outlook.com
 ([fe80::c664:8a1e:66d6:4e62]) by SEYPR06MB6278.apcprd06.prod.outlook.com
 ([fe80::c664:8a1e:66d6:4e62%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:26:10 +0000
From: "Joakim  Zhang" <joakim.zhang@cixtech.com>
To: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>, "andersson@kernel.org"
	<andersson@kernel.org>, "mathieu.poirier@linaro.org"
	<mathieu.poirier@linaro.org>
CC: "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>
Subject: RE: [PATCH V2] remoteproc: virtio: Fix wdg cannot recovery remote
 processor
Thread-Topic: [PATCH V2] remoteproc: virtio: Fix wdg cannot recovery remote
 processor
Thread-Index: AQHaL2YhTuXVOJIOaku8Me1AqSoZ+bCqkEIAgAJikXA=
Date: Sun, 17 Dec 2023 05:26:09 +0000
Message-ID:
 <SEYPR06MB627880579FD241453E287F378291A@SEYPR06MB6278.apcprd06.prod.outlook.com>
References: <20231215145023.2248366-1-joakim.zhang@cixtech.com>
 <70376b4f-0fbe-4087-8c7c-eb7167191a37@foss.st.com>
In-Reply-To: <70376b4f-0fbe-4087-8c7c-eb7167191a37@foss.st.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB6278:EE_|SEYPR06MB5205:EE_
x-ms-office365-filtering-correlation-id: 92acc229-dec0-4d4d-9084-08dbfec0ad68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5ifXdDl6eHX+r9+7+wGZ4h4js3MIZejNBK5voevU6+Dl8dEFeCSMr+QvqkgaKrV15LhCtwM4rGAjGYTwUoLSSmekmBp68gp2cgT74RlQ9C/KCgcIluuCC8VibiHdK+126rBITNBvTVmlVhB8EtRRRtfb5Godj9i0xs5R317MguG8D/of+APYq7I3E/jNMDexKCfv2AoyKAjI0xfQRCuxPcmYVUuWaH+QHS/ysFS2NIrnbmebr5og8ouMZgiE3ENVQPnDlyZ6fcwx+3o/GfpRdb0szZTflSN20Mfe5aG+WthG040Nxvngqpy8alni5E6LeYWTuFPgGjCzCUSCGRjTGRlpC17zhntu20+Cr7aKLfkWSPjAb6g7Do4BdfpkQp2maNwCdhtmL9pQvSzTIqfVgWm5TUeFCRwy9/hAFe0UcXT7G0/zrTHqy8TbANGeMqzPWoYxoyDDKBFzXEdvY8jst2rwM1bGKixWIDCA03cmhtAV1QhUPkkRxoBU91Ivzd0ayRKrsWnYgmjyZrSOs49XPkBvZoXqeCUTwSkNzbe2yX2LaSRDW4Oh8+isaEifiU1abyqoQHeRqeho4o4rfXUyNRvLYd4+DP+hiH97izY7cfTVrhyOUylXV9Lom+70rwlZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6278.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39830400003)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(66946007)(66556008)(107886003)(55016003)(66476007)(66446008)(64756008)(76116006)(110136005)(478600001)(54906003)(316002)(38100700002)(26005)(4326008)(52536014)(8936002)(8676002)(6506007)(53546011)(7696005)(9686003)(71200400001)(5660300002)(2906002)(33656002)(86362001)(122000001)(41300700001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ADn3YuV1fUFNrkhQM9Tpckuu/jC5fs6TIiL2WqtEobAgdSiELpFlwibWhuzu?=
 =?us-ascii?Q?6PU4JW7HzuogzaIlzqYaV7/XzoYdnJ0DXvfkuCx63rLDj79c8qppV2gtuunm?=
 =?us-ascii?Q?BC+wcr5wkr9HTGSiu3GC0u9DYXZ7/U88XMyVf2Z/lpH3eIFGt8iujCu3RQlW?=
 =?us-ascii?Q?kB7Nex7enfypP0dAoaEyZir9K/SocUQv8v4qCx7ixdSO1NhmrjitgKj2Yvs8?=
 =?us-ascii?Q?7NsnJZEvX8TKV+poexq8UJ2FCd5U/a/6joHTTtr3UjizZjG0lVJ96H/nnLFC?=
 =?us-ascii?Q?C46TH1lWrM3cWLSv6tmqEx5oEU1J/ESfAZG9eSKPJFOACSTCA8zgOjpKjuh+?=
 =?us-ascii?Q?lrUKgqO9+wb41W+xQVAHasTHS21oIjX5jc33H73nkbS6kK83sDuPTqFP30je?=
 =?us-ascii?Q?KYPF2cPPuNGIvi7WT5E2ucdBVXs9PqTh1MJ/yhTczqcmqkDTfiKqIQ2asUo7?=
 =?us-ascii?Q?Ff69DBTSOHMdVMUSQ1s0a2imnTq18WaaMcN6f9vCynxcy41ePWJoMqAOIvgK?=
 =?us-ascii?Q?vh698JLORWWH5e4qkkX5f70PlbjdInxJ2ybz21argjsirddY2Vk0xbeHWWIf?=
 =?us-ascii?Q?hpRuEoCqTdQ3F13iQVw4jWKArfh87Q3yDXfML0+jAPfyti06fI2+mk5IwIhR?=
 =?us-ascii?Q?DTET3Ia8CXkZy4bWvISoGqPtBjqmT7qZ4u1WqFOHCItdFthj+5DIWN4DgP3r?=
 =?us-ascii?Q?A76zWWAb93atW5uyksTd6Z//UUTCQS4TJ+gYgSVdVZ+bBHvtFKPV9wfQiKpX?=
 =?us-ascii?Q?sn/oVK9t9o6xhXTtSiU8Rkdo9LiGOZOzjuPIeCHac+ccBFZhTLIRhDucMckK?=
 =?us-ascii?Q?PRUKk86VmhTdvd6y0Miys29DkytAjd3w+UKpsN2rZfO8f6ePZLBklX6mnKTq?=
 =?us-ascii?Q?JJnDxLJdMKbz08cn0yUick0gg5gcDvS8GK4gP+aWDgDHLfzifXTJJSJ+7OwG?=
 =?us-ascii?Q?EwpN2sb6kEUoeuJoXj/L0SzW1GgV+q7V/NA/1I9KTke7NrZXt4DgUNZdoIWn?=
 =?us-ascii?Q?tzhQ/+KxHonLgXuqmIXyjXK3j9kjHKRYv/+tM7hdtV+R28Ha1LkvD/6K+DU9?=
 =?us-ascii?Q?sXxIKBebAGhhtkKpg16xpoYBgCeaTcrmN9PP43h42P/JL3nauyKKY4cKNkFM?=
 =?us-ascii?Q?g10EgCgdvcvGDoBhbtcyKY3Gt4vhfDhCPBwziwUGJIYafAloGPJF7TW0AWyp?=
 =?us-ascii?Q?TqCnIVlrMKt1r+Gqtq62CsU02Qg8+dD1BF4ohq0DRWZnsp67gSEgdJIzHrQt?=
 =?us-ascii?Q?wzfh184qVLVYQHl1yKb4LXhTmky554/2YlZ/lZNXxI8KkRU0TfWc0a8tNPIo?=
 =?us-ascii?Q?2pAAsc2tByHnFOF5OsF3iQCC3pvKINuYA97Du8c/nDEqAptWhKvR+JrWjBbk?=
 =?us-ascii?Q?AYZXN24GldG040cE4ZnLiLM4AzOYvmn2nJNNAFDZvt5MC3ZQ93ag2hMKivt3?=
 =?us-ascii?Q?b+Cgdnpz1aZxD3qORV7aN5I0Xchd8wJIac6tvA/B+v3uRB8KLRnjc5wJaHNK?=
 =?us-ascii?Q?TdrGrdCQoFEQNam73ujBPSDYVhxAHPv35JVIaUpQTyuSu304c16kwOpBjNtC?=
 =?us-ascii?Q?4CRd2Mt0qQ++Kds5yIbF+VYLKIJZ2QRPKoz804G/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6278.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92acc229-dec0-4d4d-9084-08dbfec0ad68
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2023 05:26:09.9299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6ju3vEYNMf1QZrAfc6ZrQ5OI1EAdMVXIBvQ6FDP1wXxbLnGyKaBo5IFm4McTNr+Q9xHVgBy+qK4cQOJM8lGHk27UCfFmYrxeUdAFvzYc1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5205


Hello Arnaud,

> -----Original Message-----
> From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
> Sent: Saturday, December 16, 2023 12:56 AM
> To: Joakim Zhang <joakim.zhang@cixtech.com>; andersson@kernel.org;
> mathieu.poirier@linaro.org
> Cc: linux-remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; cix-
> kernel-upstream <cix-kernel-upstream@cixtech.com>
> Subject: Re: [PATCH V2] remoteproc: virtio: Fix wdg cannot recovery remot=
e
> processor
>=20
> Hello  Joakim,
>=20
> On 12/15/23 15:50, joakim.zhang@cixtech.com wrote:
> > From: Joakim Zhang <joakim.zhang@cixtech.com>
> >
> > Recovery remote processor failed when wdg irq received:
> > [    0.842574] remoteproc remoteproc0: crash detected in cix-dsp-rproc:
> type watchdog
> > [    0.842750] remoteproc remoteproc0: handling crash #1 in cix-dsp-rpr=
oc
> > [    0.842824] remoteproc remoteproc0: recovering cix-dsp-rproc
> > [    0.843342] remoteproc remoteproc0: stopped remote processor cix-dsp=
-
> rproc
> > [    0.847901] rproc-virtio rproc-virtio.0.auto: Failed to associate bu=
ffer
> > [    0.847979] remoteproc remoteproc0: failed to probe subdevices for c=
ix-
> dsp-rproc: -16
> >
> > The reason is that dma coherent mem would not be released when
> > recovering the remote processor, due to rproc_virtio_remove() would
> > not be called, where the mem released. It will fail when it try to
> > allocate and associate buffer again.
> >
> > We can see that dma coherent mem allocated from
> > rproc_add_virtio_dev(), so should release it from
> > rproc_remove_virtio_dev(). These functions should appear symmetrically:
> > -rproc_vdev_do_start()->rproc_add_virtio_dev()-
> >dma_declare_coherent_m
> > emory()
> > -rproc_vdev_do_stop()->rproc_remove_virtio_dev()-
> >dma_release_coherent
> > _memory()
> >
> > The same for of_reserved_mem_device_init_by_idx() and
> of_reserved_mem_device_release().
> >
> > Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for
> > the remoteproc_virtio")
> > Signed-off-by: Joakim Zhang <joakim.zhang@cixtech.com>
> > ---
> > ChangeLogs:
> > V1->V2:
> >         * the same for of_reserved_mem_device_release()
> > ---
> >  drivers/remoteproc/remoteproc_virtio.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_virtio.c
> > b/drivers/remoteproc/remoteproc_virtio.c
> > index 83d76915a6ad..e877ee78740d 100644
> > --- a/drivers/remoteproc/remoteproc_virtio.c
> > +++ b/drivers/remoteproc/remoteproc_virtio.c
> > @@ -465,8 +465,12 @@ static int rproc_add_virtio_dev(struct rproc_vdev
> > *rvdev, int id)  static int rproc_remove_virtio_dev(struct device
> > *dev, void *data)  {
> >         struct virtio_device *vdev =3D dev_to_virtio(dev);
> > +       struct rproc_vdev *rvdev =3D vdev_to_rvdev(vdev);
> >
> >         unregister_virtio_device(vdev);
> > +       of_reserved_mem_device_release(&rvdev->pdev->dev);
> > +       dma_release_coherent_memory(&rvdev->pdev->dev);
> > +
>=20
> At this step, the virtio device may not be released and may still be usin=
g the
> memory.
> Do you try to move this in rproc_virtio_dev_release?

Oh, yes, thanks for the hint, I tested, and it can fix the issue, I will se=
nd v3 soon.

Joakim
> Regards,
> Arnaud
>=20
> >         return 0;
> >  }
> >
> > @@ -584,9 +588,6 @@ static void rproc_virtio_remove(struct
> platform_device *pdev)
> >         rproc_remove_subdev(rproc, &rvdev->subdev);
> >         rproc_remove_rvdev(rvdev);
> >
> > -       of_reserved_mem_device_release(&pdev->dev);
> > -       dma_release_coherent_memory(&pdev->dev);
> > -
> >         put_device(&rproc->dev);
> >  }
> >
> > --
> > 2.25.1

