Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D437F7A74
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjKXReZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjKXReX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:34:23 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF5B10F7;
        Fri, 24 Nov 2023 09:34:25 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AODvjk2030326;
        Fri, 24 Nov 2023 11:33:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:references:in-reply-to:subject:date:message-id
        :mime-version:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=m1XsxYThaok7qjGnHuWLRhBLda7OSvWudMgiEi4C6n0=; b=
        Ho2tYqQzfVw5dDywaiZEClmcodwxE2tsm4lkGF9iAf+3LJ68iEyFIil1lDcu4X/W
        wEDHOYHW01brXdRQv2VVFqHrg/ncVtBQfZI3zJpq1LbLrXw0ypoUCw/Lh8V5jEYz
        vMiQug3TBivMXlmZLmwG8h3MHpcvwTBgqv8FDHZDo1Mme0I9l3uwugPcnOAfElWW
        tqBDjYilUSAujLKnMHPWVWxeUt9gb0dNU+jgcrt4a2AJ28Ee7QhMSI0zJS+v/g4x
        oB84C2W3OAx15dHDyRzI9Awe33aMJwMyk6qGPdH7OyJXZM6JPDfqBYf+z5baZeVO
        mDHlVi93Npkzl1rWwXAkTQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ueuj2f28y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 11:33:50 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 24 Nov
 2023 17:33:48 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Fri, 24 Nov 2023 17:33:48 +0000
Received: from LONN2DGDQ73 (LONN2DGDQ73.ad.cirrus.com [198.61.65.15])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7E67E15A5;
        Fri, 24 Nov 2023 17:33:47 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     "'Mahapatra, Amit Kumar'" <amit.kumar-mahapatra@amd.com>,
        <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>,
        "'Simek, Michal'" <michal.simek@amd.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "'git (AMD-Xilinx)'" <git@amd.com>, <amitrkcian2002@gmail.com>,
        <patches@opensource.cirrus.com>
References: <20231118135446.52783-1-amit.kumar-mahapatra@amd.com> <20231118135446.52783-2-amit.kumar-mahapatra@amd.com> <8182135b-6f4f-47ae-ba53-e94a058d466f@opensource.cirrus.com> <BN7PR12MB28026E2EBD64F0D49A1084ABDCBBA@BN7PR12MB2802.namprd12.prod.outlook.com> <b10252e3-41bf-4d5c-bbd1-0af4c723884f@opensource.cirrus.com> <BN7PR12MB2802ADDA7C5789CADC1D89D2DCBBA@BN7PR12MB2802.namprd12.prod.outlook.com> <d5b50766-b8f8-45b4-8a53-7baad200c6c2@opensource.cirrus.com> <BN7PR12MB2802C60FAEAD1716F76517ACDCBBA@BN7PR12MB2802.namprd12.prod.outlook.com> <d39b587b-fffc-4e5f-b213-8c4029d829f2@opensource.cirrus.com> <BN7PR12MB280260CE5F139840D144C10BDCBAA@BN7PR12MB2802.namprd12.prod.outlook.com>
In-Reply-To: <BN7PR12MB280260CE5F139840D144C10BDCBAA@BN7PR12MB2802.namprd12.prod.outlook.com>
Subject: RE: [PATCH v10 1/8] spi: Add multi-cs memories support in SPI core
Date:   Fri, 24 Nov 2023 17:33:47 +0000
Message-ID: <005001da1efc$619ad5a0$24d080e0$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQJ/6D8wsmUQ6gOAzzXffUuI56wCdgJV4O4vAtOeZjgCfcgjLAGoFXKiAVPe5l4BaiixAwG2kM3oAOuu/oQCahD9ia61Wcbw
X-Proofpoint-ORIG-GUID: xlftanPG9dpaOXROkGdJmO3KJarycEpe
X-Proofpoint-GUID: xlftanPG9dpaOXROkGdJmO3KJarycEpe
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
> Sent: Wednesday, November 22, 2023 1:23 PM
> To: Stefan Binding <sbinding@opensource.cirrus.com>;
> broonie@kernel.org; tudor.ambarus@linaro.org; pratyush@kernel.org;
> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
> michael@walle.cc; linux-mtd@lists.infradead.org;
> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
> claudiu.beznea@tuxon.dev; Simek, Michal <michal.simek@amd.com>;
> linux-arm-kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>;
> amitrkcian2002@gmail.com; patches@opensource.cirrus.com
> Subject: RE: [PATCH v10 1/8] spi: Add multi-cs memories support in SPI
> core
>=20
>=20
>=20
> > -----Original Message-----
> > From: Stefan Binding <sbinding@opensource.cirrus.com>
> > Sent: Wednesday, November 22, 2023 4:51 PM
> > To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
> > broonie@kernel.org; tudor.ambarus@linaro.org; pratyush@kernel.org;
> > miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com
> > Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
> > michael@walle.cc; linux-mtd@lists.infradead.org;
> > nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
> > claudiu.beznea@tuxon.dev; Simek, Michal <michal.simek@amd.com>;
> linux-
> > arm-kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>;
> > amitrkcian2002@gmail.com; patches@opensource.cirrus.com
> > Subject: Re: [PATCH v10 1/8] spi: Add multi-cs memories support in =
SPI
> core
> >
> >
> > On 21/11/2023 19:18, Mahapatra, Amit Kumar wrote:
> > > Hello Stefan,
> > >
> > >> -----Original Message-----
> > >> From: Stefan Binding <sbinding@opensource.cirrus.com>
> > >> Sent: Tuesday, November 21, 2023 11:07 PM
> > >> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
> > >> broonie@kernel.org; tudor.ambarus@linaro.org;
> pratyush@kernel.org;
> > >> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com
> > >> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
> > >> michael@walle.cc; linux-mtd@lists.infradead.org;
> > >> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
> > >> claudiu.beznea@tuxon.dev; Simek, Michal
> <michal.simek@amd.com>;
> > >> linux- arm-kernel@lists.infradead.org; git (AMD-Xilinx)
> > >> <git@amd.com>; amitrkcian2002@gmail.com;
> > >> patches@opensource.cirrus.com
> > >> Subject: Re: [PATCH v10 1/8] spi: Add multi-cs memories support =
in
> > >> SPI core
> > >>
> > >>
> > >> On 21/11/2023 16:35, Mahapatra, Amit Kumar wrote:
> > >>> Hello Stefan,
> > >>>
> > >>>> -----Original Message-----
> > >>>> From: Stefan Binding <sbinding@opensource.cirrus.com>
> > >>>> Sent: Tuesday, November 21, 2023 7:28 PM
> > >>>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
> > >>>> broonie@kernel.org; tudor.ambarus@linaro.org;
> pratyush@kernel.org;
> > >>>> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com
> > >>>> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
> > >>>> michael@walle.cc; linux-mtd@lists.infradead.org;
> > >>>> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
> > >>>> claudiu.beznea@tuxon.dev; Simek, Michal
> <michal.simek@amd.com>;
> > >>>> linux- arm-kernel@lists.infradead.org; git (AMD-Xilinx)
> > >>>> <git@amd.com>; amitrkcian2002@gmail.com;
> > >>>> patches@opensource.cirrus.com
> > >>>> Subject: Re: [PATCH v10 1/8] spi: Add multi-cs memories support =
in
> > >>>> SPI core
> > >>>>
> > >>>>
> > >>>> On 21/11/2023 07:39, Mahapatra, Amit Kumar wrote:
> > >>>>> Hello Stefan,
> > >>>>>
> > >>>>>> -----Original Message-----
> > >>>>>> From: Stefan Binding <sbinding@opensource.cirrus.com>
> > >>>>>> Sent: Monday, November 20, 2023 8:00 PM
> > >>>>>> To: Mahapatra, Amit Kumar <amit.kumar-
> mahapatra@amd.com>;
> > >>>>>> broonie@kernel.org; tudor.ambarus@linaro.org;
> > >>>>>> pratyush@kernel.org; miquel.raynal@bootlin.com;
> richard@nod.at;
> > >>>>>> vigneshr@ti.com
> > >>>>>> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
> > >>>>>> michael@walle.cc; linux-mtd@lists.infradead.org;
> > >>>>>> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
> > >>>>>> claudiu.beznea@tuxon.dev; Simek, Michal
> > <michal.simek@amd.com>;
> > >>>>>> linux- arm-kernel@lists.infradead.org; git (AMD-Xilinx)
> > >>>>>> <git@amd.com>; amitrkcian2002@gmail.com;
> > >>>>>> patches@opensource.cirrus.com
> > >>>>>> Subject: Re: [PATCH v10 1/8] spi: Add multi-cs memories =
support
> > >>>>>> in SPI core
> > >>>>>>
> > >>>>>>
> > >>>>>> On 18/11/2023 13:54, Amit Kumar Mahapatra wrote:
> > >>>>>>> AMD-Xilinx GQSPI controller has two advanced mode that
> allows
> > >>>>>>> the controller to consider two flashes as one single device.
> > >>>>>>>
> > >>>>>>> One of these two mode is the parallel mode in which each =
byte
> of
> > >>>>>>> data is stored in both devices, the even bits in the lower =
flash
> > >>>>>>> & the odd bits in the upper flash. The byte split is
> > >>>>>>> automatically handled by the QSPI controller.
> > >>>>>>>
> > >>>>>>> The other mode is the stacked mode in which both the flashes
> > >>>>>>> share the same SPI bus but each of the device contain half =
of
> the
> > data.
> > >>>>>>> In this mode, the controller does not follow CS requests but
> > >>>>>>> instead internally wires the two CS levels with the value of =
the
> > >>>>>>> most significant
> > >>>>>> address bit.
> > >>>>>>> For supporting both these modes SPI core need to be updated
> for
> > >>>>>>> providing multiple CS for a single SPI device.
> > >>>>>>>
> > >>>>>>> For adding multi CS support the SPI device need to be aware =
of
> > >>>>>>> all the CS values. So, the "chip_select" member in the
> > >>>>>>> spi_device structure is now an array that holds all the CS =
values.
> > >>>>>>>
> > >>>>>>> spi_device structure now has a "cs_index_mask" member. This
> acts
> > >>>>>>> as an index to the chip_select array. If nth bit of
> > >>>>>>> spi->cs_index_mask is set then the driver would assert spi-
> > >>> chip_select[n].
> > >>>>>>> In parallel mode all the chip selects are =
asserted/de-asserted
> > >>>>>>> simultaneously and each byte of data is stored in both =
devices,
> > >>>>>>> the even bits in one, the odd bits in the other. The split =
is
> > >>>>>>> automatically handled by the GQSPI controller. The GQSPI
> > >>>>>>> controller supports a maximum of two flashes connected in
> > >>>>>>> parallel mode. A SPI_CONTROLLER_MULTI_CS flag bit is added
> in
> > >>>>>>> the spi controller flags, through ctlr->flags the spi core =
will
> > >>>>>>> make sure that the controller is capable of handling =
multiple
> chip
> > selects at once.
> > >>>>>>>
> > >>>>>>> For supporting multiple CS via GPIO the cs_gpiod member of =
the
> > >>>>>>> spi_device structure is now an array that holds the gpio
> > >>>>>>> descriptor for each chipselect.
> > >>>>>>>
> > >>>>>>> CS GPIO is not tested due to unavailability of necessary
> > >>>>>>> hardware
> > >> setup.
> > >>>>>>> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-
> > >>>> mahapatra@amd.com>
> > >>>>>>> ---
> > >>>>>>> Hello @Stefen,
> > >>>>>>> We restructured the SPI core implementation, for handling
> > >>>>>>> arbitrary number of devices connected in parallel(multi-cs) =
or
> > >>>>>>> stacked
> > >> mode.
> > >>>>>>> We have tested this updated patch on native-cs setup but
> > >>>>>>> couldn't test cs-gpio due to unavailability of a proper =
setup.
> > >>>>>>> If possible, could you please retest the cs-gpio use case =
with
> > >>>>>>> this updated patch and provide
> > >>>>>> your feedback.
> > >>>>>>
> > >>>>>> Hi,
> > >>>>>>
> > >>>>>> I tested this chain on 2 different systems using GPIOs as =
chip
> > >>>>>> selects, and see the same error on both:
> > >>>>>> [    2.842045] pxa2xx-spi pxa2xx-spi.6: chipselect 0 already =
in
> > >>>>>> use
> > >>>>>>
> > >>>>>> Let me know if you need any further testing.
> > >>>>>>
> > >>>>>> Thanks,
> > >>>>>>
> > >>>>>> Stefan Binding
> > >>>>>>
> > >>>>>>> ---
> > >>>>>>>      drivers/spi/spi.c       | 192
> +++++++++++++++++++++++++++++++---
> > ----
> > >> --
> > >>>>>>>      include/linux/spi/spi.h |  51 ++++++++---
> > >>>>>>>      2 files changed, 191 insertions(+), 52 deletions(-)
> > >>>>>>>
> > >>>>>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
> > >>>>>>> 8ead7acb99f3..ff66147ba95f 100644
> > >>>>>>> --- a/drivers/spi/spi.c
> > >>>>>>> +++ b/drivers/spi/spi.c
> > >>>>>>> @@ -612,10 +612,21 @@ static int spi_dev_check(struct
> device
> > >>>>>>> *dev, void
> > >>>>>> *data)
> > >>>>>>>      {
> > >>>>>>>      	struct spi_device *spi =3D to_spi_device(dev);
> > >>>>>>>      	struct spi_device *new_spi =3D data;
> > >>>>>>> -
> > >>>>>>> -	if (spi->controller =3D=3D new_spi->controller &&
> > >>>>>>> -	    spi_get_chipselect(spi, 0) =3D=3D
> spi_get_chipselect(new_spi, 0))
> > >>>>>>> -		return -EBUSY;
> > >>>>>>> +	int idx, nw_idx;
> > >>>>>>> +	u8 cs, cs_nw;
> > >>>>>>> +
> > >>>>>>> +	if (spi->controller =3D=3D new_spi->controller) {
> > >>>>>>> +		for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > >>>>>>> +			cs =3D spi_get_chipselect(spi, idx);
> > >>>>>>> +			for (nw_idx =3D 0; nw_idx <
> SPI_CS_CNT_MAX;
> > >>>>>> nw_idx++) {
> > >>>>>>> +				cs_nw =3D spi_get_chipselect(spi,
> > >> nw_idx);
> > >>>>> Thank you for dedicating your time to test my patch.
> > >>>>> As per my analysis the error is reported from here as we are
> > >>>>> supplying the former SPI device structure to retrieve the CS =
value
> > >>>>> for the new SPI devices.
> > >>>>> To fix this, could you kindly substitute the above line with
> > >>>>>
> > >>>>> cs_nw =3D spi_get_chipselect(new_spi, nw_idx);
> > >>>>>
> > >>>>> and rerun your tests?
> > >>>>> If it works correctly, I will incorporate this fix into my
> > >>>>> upcoming series.
> > >>>>>
> > >>>>> Regards,
> > >>>>> Amit
> > >> Hi,
> > >>
> > >> I've attached my log.
> > >> I notice that you add a print to of_spi_parse_dt, however since =
the
> > >> laptop I am using is an x86 laptop, it uses ACPI rather than OF, =
and
> > >> I don't think this function isnt even compiled in.
> > > That=E2=80=99s correct, I missed it.
> > > Upon reviewing the logs, I discovered that in the ACPI flow, I am =
not
> > > initializing the unused CS[] to FF, as I am doing in the OF flow.
> > > Consequently, in the ACPI flow, all the unused CS[] are =
automatically
> > > initialized to 0. During the __spi_add_device process, the SPI =
core
> > > faces difficulty distinguishing between a valid CS value of 0 and =
an
> > > unused CS value of 0, leading to a failure in the driver probe.
> > >
> > > Incorporating the following modifications should resolve this =
issue.
> > > Kindly apply these changes on top of 1/8 and re-run the test.
> > >
> > > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
> > > ff66147ba95f..d0301c17d4f8 100644
> > > --- a/drivers/spi/spi.c
> > > +++ b/drivers/spi/spi.c
> > > @@ -619,7 +619,7 @@ static int spi_dev_check(struct device *dev,
> void
> > *data)
> > >                  for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > >                          cs =3D spi_get_chipselect(spi, idx);
> > >                          for (nw_idx =3D 0; nw_idx < =
SPI_CS_CNT_MAX; nw_idx++) {
> > > -                               cs_nw =3D spi_get_chipselect(spi, =
nw_idx);
> > > +                               cs_nw =3D =
spi_get_chipselect(new_spi,
> > > + nw_idx);
> > >                                  if (cs !=3D 0xFF && cs_nw !=3D =
0xFF && cs =3D=3D cs_nw) {
> > >                                          dev_err(dev, "chipselect =
%d already in use\n",
> > cs_nw);
> > >                                          return -EBUSY; @@ -764,6
> > > +764,7 @@ struct spi_device *spi_new_device(struct spi_controller
> *ctlr,
> > >   {
> > >          struct spi_device       *proxy;
> > >          int                     status;
> > > +       u8                      idx;
> > >
> > >          /*
> > >           * NOTE:  caller did any chip->bus_num checks necessary.
> > > @@ -779,6 +780,9 @@ struct spi_device *spi_new_device(struct
> > > spi_controller *ctlr,
> > >
> > >          WARN_ON(strlen(chip->modalias) >=3D =
sizeof(proxy->modalias));
> > >
> > > +       for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++)
> > > +               spi_set_chipselect(proxy, idx, 0xFF);
> > > +
> > >          spi_set_chipselect(proxy, 0, chip->chip_select);
> > >          proxy->max_speed_hz =3D chip->max_speed_hz;
> > >          proxy->mode =3D chip->mode;
> > > @@ -2514,6 +2518,7 @@ struct spi_device
> > *spi_new_ancillary_device(struct spi_device *spi,
> > >          struct spi_controller *ctlr =3D spi->controller;
> > >          struct spi_device *ancillary;
> > >          int rc =3D 0;
> > > +       u8 idx;
> > >
> > >          /* Alloc an spi_device */
> > >          ancillary =3D spi_alloc_device(ctlr); @@ -2524,6 +2529,9 =
@@
> > > struct spi_device *spi_new_ancillary_device(struct spi_device =
*spi,
> > >
> > >          strscpy(ancillary->modalias, "dummy",
> > > sizeof(ancillary->modalias));
> > >
> > > +       for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++)
> > > +               spi_set_chipselect(ancillary, idx, 0xFF);
> > > +
> > >          /* Use provided chip-select for ancillary device */
> > >          spi_set_chipselect(ancillary, 0, chip_select);
> > >
> > > @@ -2732,6 +2740,7 @@ struct spi_device
> *acpi_spi_device_alloc(struct
> > spi_controller *ctlr,
> > >          struct acpi_spi_lookup lookup =3D {};
> > >          struct spi_device *spi;
> > >          int ret;
> > > +       u8 idx;
> > >
> > >          if (!ctlr && index =3D=3D -1)
> > >                  return ERR_PTR(-EINVAL); @@ -2767,6 +2776,9 @@ =
struct
> > > spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
> > >                  return ERR_PTR(-ENOMEM);
> > >          }
> > >
> > > +       for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++)
> > > +               spi_set_chipselect(spi, idx, 0xFF);
> > > +
> > >          ACPI_COMPANION_SET(&spi->dev, adev);
> > >          spi->max_speed_hz       =3D lookup.max_speed_hz;
> > >          spi->mode               |=3D lookup.mode;
> > >
> > > Regards,
> > > Amit
> > >
> >
> > Hi,
> >
> > I no longer see that error, or any errors printed from SPI, however, =
all of
> the
> > transactions are now broken.
> > Every transaction seems to read back 0x0, on all SPI devices, =
whether
> native
> > CS or GPIO CS, and I dont see it toggling the CS GPIO anymore.
>=20
> I believe the issue stems from the fact that in the ACPI patch,
> spi->cs_index_mask is not set to 0x01. As a result, in spi_set_cs,
> it fails to meet the condition that governs the CS asset code snippet.
> In the following code diff, I've included the necessary fix along with
> the earlier changes on top of 1/8. I've also included a couple of =
debug
> prints to aid in further debugging in case my analysis is incorrect.
> Please apply these changes on top of 1/8 and re-run the test.
>=20

Hi,

I've tested this on several laptops, and it all seems to work now.

Tested-by: Stefan Binding <sbinding@opensource.cirrus.com>

Thanks,
Stefan

> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index ff66147ba95f..b2e035c3d494 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -619,7 +619,7 @@ static int spi_dev_check(struct device *dev, void
> *data)
>                 for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
>                         cs =3D spi_get_chipselect(spi, idx);
>                         for (nw_idx =3D 0; nw_idx < SPI_CS_CNT_MAX; =
nw_idx++) {
> -                               cs_nw =3D spi_get_chipselect(spi, =
nw_idx);
> +                               cs_nw =3D spi_get_chipselect(new_spi, =
nw_idx);
>                                 if (cs !=3D 0xFF && cs_nw !=3D 0xFF && =
cs =3D=3D cs_nw) {
>                                         dev_err(dev, "chipselect %d =
already in use\n",
> cs_nw);
>                                         return -EBUSY;
> @@ -764,6 +764,7 @@ struct spi_device *spi_new_device(struct
> spi_controller *ctlr,
>  {
>         struct spi_device       *proxy;
>         int                     status;
> +       u8                      idx;
>=20
>         /*
>          * NOTE:  caller did any chip->bus_num checks necessary.
> @@ -779,6 +780,9 @@ struct spi_device *spi_new_device(struct
> spi_controller *ctlr,
>=20
>         WARN_ON(strlen(chip->modalias) >=3D sizeof(proxy->modalias));
>=20
> +       for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++)
> +               spi_set_chipselect(proxy, idx, 0xFF);
> +
>         spi_set_chipselect(proxy, 0, chip->chip_select);
>         proxy->max_speed_hz =3D chip->max_speed_hz;
>         proxy->mode =3D chip->mode;
> @@ -787,6 +791,7 @@ struct spi_device *spi_new_device(struct
> spi_controller *ctlr,
>         proxy->dev.platform_data =3D (void *) chip->platform_data;
>         proxy->controller_data =3D chip->controller_data;
>         proxy->controller_state =3D NULL;
> +       proxy->cs_index_mask =3D 0x01;
>=20
>         if (chip->swnode) {
>                 status =3D device_add_software_node(&proxy->dev, chip-
> >swnode);
> @@ -1024,6 +1029,8 @@ static void spi_set_cs(struct spi_device *spi,
> bool enable, bool force)
>                 if (!spi->controller->set_cs_timing && !activate)
>                         spi_delay_exec(&spi->cs_hold, NULL);
>=20
> +               printk("%s() [%d] spi->cs_index_mask =3D=3D =
[%d]\n",__func__,
> __LINE__, spi->cs_index_mask);
> +
>                 if (!(spi->mode & SPI_NO_CS)) {
>                         /*
>                          * Historically ACPI has no means of the GPIO =
polarity and
> @@ -1038,6 +1045,7 @@ static void spi_set_cs(struct spi_device *spi,
> bool enable, bool force)
>                         for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
>                                 if (((spi->cs_index_mask >> idx) & =
0x01) &&
>                                     spi_get_csgpiod(spi, idx)) {
> +                                   printk("%s() [%d] idx =3D=3D =
[%d]\n",__func__, __LINE__,
> idx);
>                                         if =
(has_acpi_companion(&spi->dev))
>                                                 =
gpiod_set_value_cansleep(spi_get_csgpiod(spi,
> idx),
>                                                                        =
  !enable);
> @@ -2514,6 +2522,7 @@ struct spi_device
> *spi_new_ancillary_device(struct spi_device *spi,
>         struct spi_controller *ctlr =3D spi->controller;
>         struct spi_device *ancillary;
>         int rc =3D 0;
> +       u8 idx;
>=20
>         /* Alloc an spi_device */
>         ancillary =3D spi_alloc_device(ctlr);
> @@ -2524,12 +2533,16 @@ struct spi_device
> *spi_new_ancillary_device(struct spi_device *spi,
>=20
>         strscpy(ancillary->modalias, "dummy", =
sizeof(ancillary->modalias));
>=20
> +        for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++)
> +               spi_set_chipselect(ancillary, idx, 0xFF);
> +
>         /* Use provided chip-select for ancillary device */
>         spi_set_chipselect(ancillary, 0, chip_select);
>=20
>         /* Take over SPI mode/speed from SPI main device */
>         ancillary->max_speed_hz =3D spi->max_speed_hz;
>         ancillary->mode =3D spi->mode;
> +       ancillary->cs_index_mask =3D 0x01;
>=20
>         WARN_ON(!mutex_is_locked(&ctlr->add_lock));
>=20
> @@ -2732,6 +2745,7 @@ struct spi_device *acpi_spi_device_alloc(struct
> spi_controller *ctlr,
>         struct acpi_spi_lookup lookup =3D {};
>         struct spi_device *spi;
>         int ret;
> +       u8 idx;
>=20
>         if (!ctlr && index =3D=3D -1)
>                 return ERR_PTR(-EINVAL);
> @@ -2767,12 +2781,16 @@ struct spi_device
> *acpi_spi_device_alloc(struct spi_controller *ctlr,
>                 return ERR_PTR(-ENOMEM);
>         }
>=20
> +       for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++)
> +               spi_set_chipselect(spi, idx, 0xFF);
> +
>         ACPI_COMPANION_SET(&spi->dev, adev);
>         spi->max_speed_hz       =3D lookup.max_speed_hz;
>         spi->mode               |=3D lookup.mode;
>         spi->irq                =3D lookup.irq;
>         spi->bits_per_word      =3D lookup.bits_per_word;
>         spi_set_chipselect(spi, 0, lookup.chip_select);
> +       spi->cs_index_mask      =3D 0x01;
>=20
>         return spi;
>  }
>=20
> Regards,
> Amit
>=20
> >
> > Thanks,
> >
> > Stefan
> >
> > >> Thanks,
> > >>
> > >> Stefan
> > >>
> > >>>> Hi,
> > >>>>
> > >>>> I still see the same error:
> > >>>>
> > >>>> [    2.748546] pxa2xx-spi pxa2xx-spi.6: chipselect 0 already in =
use
> > >>> Thank you for the quick testing. For further analysis I have
> > >>> incorporated additional debug prints on top of 1/8 patch. The
> > >>> corresponding diff is shared below. Kindly implement the =
specified
> > >>> changes, rerun your test and share the kernel logs.
> > >>>
> > >>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
> > >>> ff66147ba95f..7f59ea81593d 100644
> > >>> --- a/drivers/spi/spi.c
> > >>> +++ b/drivers/spi/spi.c
> > >>> @@ -618,8 +618,10 @@ static int spi_dev_check(struct device =
*dev,
> > >>> void
> > >> *data)
> > >>>           if (spi->controller =3D=3D new_spi->controller) {
> > >>>                   for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > >>>                           cs =3D spi_get_chipselect(spi, idx);
> > >>> +                       printk("%s() [%d] CS[%d] =3D [%d]\n",
> > >>> + __func__, __LINE__, idx, cs);
> > >>>                           for (nw_idx =3D 0; nw_idx < =
SPI_CS_CNT_MAX;
> nw_idx++) {
> > >>> -                               cs_nw =3D =
spi_get_chipselect(spi, nw_idx);
> > >>> +                               cs_nw =3D =
spi_get_chipselect(new_spi, nw_idx);
> > >>> +                               printk("%s() [%d] CS_NEW[%d] =3D
> > >>> + [%d]\n", __func__, __LINE__, nw_idx, cs_nw);
> > >>>                                   if (cs !=3D 0xFF && cs_nw !=3D =
0xFF && cs =3D=3D cs_nw) {
> > >>>                                           dev_err(dev, =
"chipselect
> > >>> %d already in use\n",
> > >> cs_nw);
> > >>>                                           return -EBUSY; @@ =
-659,8
> > >>> +661,10 @@ static int __spi_add_device(struct spi_device *spi)
> > >>>            */
> > >>>           for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > >>>                   cs =3D spi_get_chipselect(spi, idx);
> > >>> +               printk("%s() [%d] CS[%d] =3D [%d]\n", __func__,
> > >>> + __LINE__, idx, cs);
> > >>>                   for (nw_idx =3D idx + 1; nw_idx < =
SPI_CS_CNT_MAX;
> nw_idx++) {
> > >>>                           nw_cs =3D spi_get_chipselect(spi, =
nw_idx);
> > >>> +                       printk("%s() [%d] CS_NEW[%d] =3D =
[%d]\n",
> > >>> + __func__, __LINE__, nw_idx, nw_cs);
> > >>>                           if (cs !=3D 0xFF && nw_cs !=3D 0xFF && =
cs =3D=3D nw_cs) {
> > >>>                                   dev_err(dev, "chipselect %d =
already in use\n",
> nw_cs);
> > >>>                                   return -EBUSY; @@ -2401,6 =
+2405,9
> > >>> @@ static int of_spi_parse_dt(struct spi_controller *ctlr, =
struct
> spi_device
> > *spi,
> > >>>           for (idx =3D 0; idx < rc; idx++)
> > >>>                   spi_set_chipselect(spi, idx, cs[idx]);
> > >>>
> > >>> +       for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++)
> > >>> +               printk("%s() [%d] CS[%d] =3D [%d]\n", __func__,
> > >>> + __LINE__, idx, spi_get_chipselect(spi, idx));
> > >>> +
> > >>>           /* spi->chip_select[i] gives the corresponding =
physical CS for
> logical
> > CS i
> > >>>            * logical CS number is represented by setting the ith =
bit
> > >>> in spi- cs_index_mask
> > >>>            * So, for example, if spi->cs_index_mask =3D 0x01 =
then
> > >>> logical CS number is 0 and
> > >>>
> > >>> Regards,
> > >>> Amit
> > >>>
> > >>>> Thanks,
> > >>>>
> > >>>> Stefan
> > >>>>
> > >>>>>>> +				if (cs !=3D 0xFF && cs_nw !=3D 0xFF
> && cs
> > >> =3D=3D
> > >>>>>> cs_nw) {
> > >>>>>>> +					dev_err(dev, "chipselect
> %d
> > >> already in
> > >>>>>> use\n", cs_nw);
> > >>>>>>> +					return -EBUSY;
> > >>>>>>> +				}
> > >>>>>>> +			}
> > >>>>>>> +		}
> > >>>>>>> +	}
> > >>>>>>>      	return 0;
> > >>>>>>>      }
> > >>>>>>>
> > >>>>>>> @@ -629,13 +640,32 @@ static int __spi_add_device(struct
> > >>>>>>> spi_device
> > >>>> *spi)
> > >>>>>>>      {
> > >>>>>>>      	struct spi_controller *ctlr =3D spi->controller;
> > >>>>>>>      	struct device *dev =3D ctlr->dev.parent;
> > >>>>>>> -	int status;
> > >>>>>>> +	int status, idx, nw_idx;
> > >>>>>>> +	u8 cs, nw_cs;
> > >>>>>>> +
> > >>>>>>> +	for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > >>>>>>> +		/* Chipselects are numbered 0..max; validate. */
> > >>>>>>> +		cs =3D spi_get_chipselect(spi, idx);
> > >>>>>>> +		if (cs !=3D 0xFF && cs >=3D ctlr->num_chipselect) {
> > >>>>>>> +			dev_err(dev, "cs%d >=3D max %d\n",
> > >>>>>> spi_get_chipselect(spi, idx),
> > >>>>>>> +				ctlr->num_chipselect);
> > >>>>>>> +			return -EINVAL;
> > >>>>>>> +		}
> > >>>>>>> +	}
> > >>>>>>>
> > >>>>>>> -	/* Chipselects are numbered 0..max; validate. */
> > >>>>>>> -	if (spi_get_chipselect(spi, 0) >=3D ctlr->num_chipselect) =
{
> > >>>>>>> -		dev_err(dev, "cs%d >=3D max %d\n",
> > spi_get_chipselect(spi, 0),
> > >>>>>>> -			ctlr->num_chipselect);
> > >>>>>>> -		return -EINVAL;
> > >>>>>>> +	/*
> > >>>>>>> +	 * Make sure that multiple logical CS doesn't map to the
> same
> > >>>>>> physical CS.
> > >>>>>>> +	 * For example, spi->chip_select[0] !=3D =
spi->chip_select[1]
> and
> > >> so on.
> > >>>>>>> +	 */
> > >>>>>>> +	for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > >>>>>>> +		cs =3D spi_get_chipselect(spi, idx);
> > >>>>>>> +		for (nw_idx =3D idx + 1; nw_idx < SPI_CS_CNT_MAX;
> > >> nw_idx++) {
> > >>>>>>> +			nw_cs =3D spi_get_chipselect(spi, nw_idx);
> > >>>>>>> +			if (cs !=3D 0xFF && nw_cs !=3D 0xFF && cs =3D=3D
> > >> nw_cs) {
> > >>>>>>> +				dev_err(dev, "chipselect %d
> already in
> > >> use\n",
> > >>>>>> nw_cs);
> > >>>>>>> +				return -EBUSY;
> > >>>>>>> +			}
> > >>>>>>> +		}
> > >>>>>>>      	}
> > >>>>>>>
> > >>>>>>>      	/* Set the bus ID string */ @@ -647,11 +677,8 @@ =
static
> > >>>>>>> int __spi_add_device(struct spi_device
> > >>>> *spi)
> > >>>>>>>      	 * its configuration.
> > >>>>>>>      	 */
> > >>>>>>>      	status =3D bus_for_each_dev(&spi_bus_type, NULL, spi,
> > >> spi_dev_check);
> > >>>>>>> -	if (status) {
> > >>>>>>> -		dev_err(dev, "chipselect %d already in use\n",
> > >>>>>>> -				spi_get_chipselect(spi, 0));
> > >>>>>>> +	if (status)
> > >>>>>>>      		return status;
> > >>>>>>> -	}
> > >>>>>>>
> > >>>>>>>      	/* Controller may unregister concurrently */
> > >>>>>>>      	if (IS_ENABLED(CONFIG_SPI_DYNAMIC) && @@ -659,8
> > >> +686,15 @@
> > >>>>>> static
> > >>>>>>> int __spi_add_device(struct spi_device *spi)
> > >>>>>>>      		return -ENODEV;
> > >>>>>>>      	}
> > >>>>>>>
> > >>>>>>> -	if (ctlr->cs_gpiods)
> > >>>>>>> -		spi_set_csgpiod(spi, 0, ctlr-
> > >cs_gpiods[spi_get_chipselect(spi,
> > >>>>>> 0)]);
> > >>>>>>> +	if (ctlr->cs_gpiods) {
> > >>>>>>> +		u8 cs;
> > >>>>>>> +
> > >>>>>>> +		for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > >>>>>>> +			cs =3D spi_get_chipselect(spi, idx);
> > >>>>>>> +			if (cs !=3D 0xFF)
> > >>>>>>> +				spi_set_csgpiod(spi, idx, ctlr-
> > >>> cs_gpiods[cs]);
> > >>>>>>> +		}
> > >>>>>>> +	}
> > >>>>>>>
> > >>>>>>>      	/*
> > >>>>>>>      	 * Drivers may modify this initial i/o setup, but will =
@@
> > >>>>>>> -701,6
> > >>>>>>> +735,9 @@ int spi_add_device(struct spi_device *spi)
> > >>>>>>>      	struct spi_controller *ctlr =3D spi->controller;
> > >>>>>>>      	int status;
> > >>>>>>>
> > >>>>>>> +	/* Set the bus ID string */
> > >>>>>>> +	spi_dev_set_name(spi);
> > >>>>>>> +
> > >>>>>>>      	mutex_lock(&ctlr->add_lock);
> > >>>>>>>      	status =3D __spi_add_device(spi);
> > >>>>>>>      	mutex_unlock(&ctlr->add_lock); @@ -942,32 +979,51
> @@
> > >> static
> > >>>>>>> void spi_res_release(struct spi_controller
> > >>>>>> *ctlr, struct spi_message *mes
> > >>>>>>>      }
> > >>>>>>>
> > >>>>>>>
> > >>>>>>> =
/*--------------------------------------------------------------
> > >>>>>>> --
> > >>>>>>> --
> > >>>>>>> --
> > >>>>>>> -----*/
> > >>>>>>> +static inline bool spi_is_last_cs(struct spi_device *spi) {
> > >>>>>>> +	u8 idx;
> > >>>>>>> +	bool last =3D false;
> > >>>>>>> +
> > >>>>>>> +	for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > >>>>>>> +		if ((spi->cs_index_mask >> idx) & 0x01) {
> > >>>>>>> +			if (spi->controller->last_cs[idx] =3D=3D
> > >>>>>> spi_get_chipselect(spi, idx))
> > >>>>>>> +				last =3D true;
> > >>>>>>> +		}
> > >>>>>>> +	}
> > >>>>>>> +	return last;
> > >>>>>>> +}
> > >>>>>>> +
> > >>>>>>>
> > >>>>>>>      static void spi_set_cs(struct spi_device *spi, bool =
enable,
> bool
> > force)
> > >>>>>>>      {
> > >>>>>>>      	bool activate =3D enable;
> > >>>>>>> +	u8 idx;
> > >>>>>>>
> > >>>>>>>      	/*
> > >>>>>>>      	 * Avoid calling into the driver (or doing delays) if =
the
> > >>>>>>> chip
> > >> select
> > >>>>>>>      	 * isn't actually changing from the last time this was
> called.
> > >>>>>>>      	 */
> > >>>>>>> -	if (!force && ((enable && spi->controller->last_cs =3D=3D
> > >>>>>> spi_get_chipselect(spi, 0)) ||
> > >>>>>>> -		       (!enable && spi->controller->last_cs !=3D
> > >>>>>> spi_get_chipselect(spi, 0))) &&
> > >>>>>>> +	if (!force && ((enable && spi->controller-
> >last_cs_index_mask
> > >> =3D=3D
> > >>>>>>> +spi-
> > >>>>>>> cs_index_mask &&
> > >>>>>>> +			spi_is_last_cs(spi)) ||
> > >>>>>>> +		       (!enable && spi->controller-
> >last_cs_index_mask
> > >> =3D=3D spi-
> > >>>>>>> cs_index_mask &&
> > >>>>>>> +			!spi_is_last_cs(spi))) &&
> > >>>>>>>      	    (spi->controller->last_cs_mode_high =3D=3D =
(spi->mode &
> > >>>>>> SPI_CS_HIGH)))
> > >>>>>>>      		return;
> > >>>>>>>
> > >>>>>>>      	trace_spi_set_cs(spi, activate);
> > >>>>>>>
> > >>>>>>> -	spi->controller->last_cs =3D enable ? =
spi_get_chipselect(spi,
> 0) : -
> > 1;
> > >>>>>>> +	spi->controller->last_cs_index_mask =3D spi-
> >cs_index_mask;
> > >>>>>>> +	for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++)
> > >>>>>>> +		spi->controller->last_cs[idx] =3D enable ?
> > >>>>>>> +spi_get_chipselect(spi,
> > >>>>>> 0)
> > >>>>>>> +: -1;
> > >>>>>>>      	spi->controller->last_cs_mode_high =3D spi->mode &
> > >> SPI_CS_HIGH;
> > >>>>>>> -	if ((spi_get_csgpiod(spi, 0) || !spi->controller-
> >set_cs_timing)
> > &&
> > >>>>>> !activate)
> > >>>>>>> -		spi_delay_exec(&spi->cs_hold, NULL);
> > >>>>>>> -
> > >>>>>>>      	if (spi->mode & SPI_CS_HIGH)
> > >>>>>>>      		enable =3D !enable;
> > >>>>>>>
> > >>>>>>> -	if (spi_get_csgpiod(spi, 0)) {
> > >>>>>>> +	if (spi_is_csgpiod(spi)) {
> > >>>>>>> +		if (!spi->controller->set_cs_timing && !activate)
> > >>>>>>> +			spi_delay_exec(&spi->cs_hold, NULL);
> > >>>>>>> +
> > >>>>>>>      		if (!(spi->mode & SPI_NO_CS)) {
> > >>>>>>>      			/*
> > >>>>>>>      			 * Historically ACPI has no means of the
> GPIO
> > >> polarity
> > >>>>>> and @@
> > >>>>>>> -979,26 +1035,38 @@ static void spi_set_cs(struct spi_device
> > >>>>>>> *spi, bool
> > >>>>>> enable, bool force)
> > >>>>>>>      			 * ambiguity. That's why we use enable,
> that
> > >> takes
> > >>>>>> SPI_CS_HIGH
> > >>>>>>>      			 * into account.
> > >>>>>>>      			 */
> > >>>>>>> -			if (has_acpi_companion(&spi->dev))
> > >>>>>>> -
> > >>>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0),
> !enable);
> > >>>>>>> -			else
> > >>>>>>> -				/* Polarity handled by GPIO
> library */
> > >>>>>>> -
> > >>>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0),
> activate);
> > >>>>>>> +			for (idx =3D 0; idx < SPI_CS_CNT_MAX;
> idx++) {
> > >>>>>>> +				if (((spi->cs_index_mask >> idx)
> &
> > >> 0x01) &&
> > >>>>>>> +				    spi_get_csgpiod(spi, idx)) {
> > >>>>>>> +					if
> (has_acpi_companion(&spi-
> > >>> dev))
> > >>>>>>> +
> > >>>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
> > >>>>>>> +
> > >>>>>> !enable);
> > >>>>>>> +					else
> > >>>>>>> +						/* Polarity
> handled by
> > >> GPIO
> > >>>>>> library */
> > >>>>>>> +
> > >>>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
> > >>>>>>> +
> > >>>>>> activate);
> > >>>>>>> +
> > >>>>>>> +					if (activate)
> > >>>>>>> +
> 	spi_delay_exec(&spi-
> > >>>>>>> cs_setup, NULL);
> > >>>>>>> +					else
> > >>>>>>> +
> 	spi_delay_exec(&spi-
> > >>>>>>> cs_inactive, NULL);
> > >>>>>>> +				}
> > >>>>>>> +			}
> > >>>>>>>      		}
> > >>>>>>>      		/* Some SPI masters need both GPIO CS &
> > >> slave_select */
> > >>>>>>>      		if ((spi->controller->flags &
> > >> SPI_CONTROLLER_GPIO_SS) &&
> > >>>>>>>      		    spi->controller->set_cs)
> > >>>>>>>      			spi->controller->set_cs(spi, !enable);
> > >>>>>>> +
> > >>>>>>> +		if (!spi->controller->set_cs_timing) {
> > >>>>>>> +			if (activate)
> > >>>>>>> +				spi_delay_exec(&spi->cs_setup,
> > >> NULL);
> > >>>>>>> +			else
> > >>>>>>> +				spi_delay_exec(&spi-
> >cs_inactive,
> > >> NULL);
> > >>>>>>> +		}
> > >>>>>>>      	} else if (spi->controller->set_cs) {
> > >>>>>>>      		spi->controller->set_cs(spi, !enable);
> > >>>>>>>      	}
> > >>>>>>> -
> > >>>>>>> -	if (spi_get_csgpiod(spi, 0) || !spi->controller-
> >set_cs_timing) {
> > >>>>>>> -		if (activate)
> > >>>>>>> -			spi_delay_exec(&spi->cs_setup, NULL);
> > >>>>>>> -		else
> > >>>>>>> -			spi_delay_exec(&spi->cs_inactive, NULL);
> > >>>>>>> -	}
> > >>>>>>>      }
> > >>>>>>>
> > >>>>>>>      #ifdef CONFIG_HAS_DMA
> > >>>>>>> @@ -2222,8 +2290,8 @@ static void
> > >>>>>>> of_spi_parse_dt_cs_delay(struct
> > >>>>>> device_node *nc,
> > >>>>>>>      static int of_spi_parse_dt(struct spi_controller *ctlr,
> > >>>>>>> struct spi_device
> > >>>> *spi,
> > >>>>>>>      			   struct device_node *nc)
> > >>>>>>>      {
> > >>>>>>> -	u32 value;
> > >>>>>>> -	int rc;
> > >>>>>>> +	u32 value, cs[SPI_CS_CNT_MAX];
> > >>>>>>> +	int rc, idx;
> > >>>>>>>
> > >>>>>>>      	/* Mode (clock phase/polarity/etc.) */
> > >>>>>>>      	if (of_property_read_bool(nc, "spi-cpha")) @@ -2295,14
> > >>>>>>> +2363,52
> > >>>>>> @@
> > >>>>>>> static int of_spi_parse_dt(struct spi_controller *ctlr, =
struct
> > >>>>>>> spi_device
> > >> *spi,
> > >>>>>>>      		return 0;
> > >>>>>>>      	}
> > >>>>>>>
> > >>>>>>> +	if (ctlr->num_chipselect > SPI_CS_CNT_MAX) {
> > >>>>>>> +		dev_err(&ctlr->dev, "No. of CS is more than max.
> no.
> > >> of
> > >>>>>> supported CS\n");
> > >>>>>>> +		return -EINVAL;
> > >>>>>>> +	}
> > >>>>>>> +
> > >>>>>>> +	/*
> > >>>>>>> +	 * Zero(0) is a valid physical CS value and can be located =
at
> > >> any
> > >>>>>>> +	 * logical CS in the spi->chip_select[]. If all the =
physical CS
> > >>>>>>> +	 * are initialized to 0 then It would be difficult to
> differentiate
> > >>>>>>> +	 * between a valid physical CS 0 & an unused logical CS
> whose
> > >>>>>> physical
> > >>>>>>> +	 * CS can be 0. As a solution to this issue initialize all =
the
> > >>>>>>> +CS to
> > >> 0xFF.
> > >>>>>>> +	 * Now all the unused logical CS will have 0xFF physical =
CS
> > >>>>>>> +value & can
> > >>>>>> be
> > >>>>>>> +	 * ignore while performing physical CS validity checks.
> > >>>>>>> +	 */
> > >>>>>>> +	for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++)
> > >>>>>>> +		spi_set_chipselect(spi, idx, 0xFF);
> > >>>>>>> +
> > >>>>>>>      	/* Device address */
> > >>>>>>> -	rc =3D of_property_read_u32(nc, "reg", &value);
> > >>>>>>> -	if (rc) {
> > >>>>>>> +	rc =3D of_property_read_variable_u32_array(nc, "reg",
> &cs[0],
> > >> 1,
> > >>>>>>> +
> SPI_CS_CNT_MAX);
> > >>>>>>> +	if (rc < 0) {
> > >>>>>>>      		dev_err(&ctlr->dev, "%pOF has no valid 'reg'
> property
> > >>>>>> (%d)\n",
> > >>>>>>>      			nc, rc);
> > >>>>>>>      		return rc;
> > >>>>>>>      	}
> > >>>>>>> -	spi_set_chipselect(spi, 0, value);
> > >>>>>>> +	if (rc > ctlr->num_chipselect) {
> > >>>>>>> +		dev_err(&ctlr->dev, "%pOF has number of CS >
> ctlr-
> > >>>>>>> num_chipselect (%d)\n",
> > >>>>>>> +			nc, rc);
> > >>>>>>> +		return rc;
> > >>>>>>> +	}
> > >>>>>>> +	if ((of_property_read_bool(nc, "parallel-memories")) &&
> > >>>>>>> +	    (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
> > >>>>>>> +		dev_err(&ctlr->dev, "SPI controller doesn't
> support
> > >> multi
> > >>>>>> CS\n");
> > >>>>>>> +		return -EINVAL;
> > >>>>>>> +	}
> > >>>>>>> +	for (idx =3D 0; idx < rc; idx++)
> > >>>>>>> +		spi_set_chipselect(spi, idx, cs[idx]);
> > >>>>>>> +
> > >>>>>>> +	/* spi->chip_select[i] gives the corresponding physical CS
> for
> > >>>>>>> +logical CS
> > >>>>>> i
> > >>>>>>> +	 * logical CS number is represented by setting the ith bit =
in
> > >>>>>>> +spi-
> > >>>>>>> cs_index_mask
> > >>>>>>> +	 * So, for example, if spi->cs_index_mask =3D 0x01 then
> logical
> > >> CS
> > >>>>>> number is 0 and
> > >>>>>>> +	 * spi->chip_select[0] will give the physical CS.
> > >>>>>>> +	 * By default spi->chip_select[0] will hold the physical =
CS
> > >>>>>>> +number so,
> > >>>>>> set
> > >>>>>>> +	 * spi->cs_index_mask as 0x01.
> > >>>>>>> +	 */
> > >>>>>>> +	spi->cs_index_mask =3D 0x01;
> > >>>>>>>
> > >>>>>>>      	/* Device speed */
> > >>>>>>>      	if (!of_property_read_u32(nc, "spi-max-frequency",
> > >>>>>>> &value)) @@
> > >>>>>>> -3100,6 +3206,7 @@ int spi_register_controller(struct
> > >>>>>>> spi_controller
> > >> *ctlr)
> > >>>>>>>      	struct boardinfo	*bi;
> > >>>>>>>      	int			first_dynamic;
> > >>>>>>>      	int			status;
> > >>>>>>> +	int			idx;
> > >>>>>>>
> > >>>>>>>      	if (!dev)
> > >>>>>>>      		return -ENODEV;
> > >>>>>>> @@ -3164,7 +3271,8 @@ int spi_register_controller(struct
> > >>>>>>> spi_controller
> > >>>>>> *ctlr)
> > >>>>>>>      	}
> > >>>>>>>
> > >>>>>>>      	/* Setting last_cs to -1 means no chip selected */
> > >>>>>>> -	ctlr->last_cs =3D -1;
> > >>>>>>> +	for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++)
> > >>>>>>> +		ctlr->last_cs[idx] =3D -1;
> > >>>>>>>
> > >>>>>>>      	status =3D device_add(&ctlr->dev);
> > >>>>>>>      	if (status < 0)
> > >>>>>>> @@ -3889,7 +3997,7 @@ static int __spi_validate(struct
> > >>>>>>> spi_device *spi,
> > >>>>>> struct spi_message *message)
> > >>>>>>>      	 * cs_change is set for each transfer.
> > >>>>>>>      	 */
> > >>>>>>>      	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits &
> > >>>>>> SPI_CS_WORD) ||
> > >>>>>>> -					  spi_get_csgpiod(spi, 0)))
> {
> > >>>>>>> +					  spi_is_csgpiod(spi))) {
> > >>>>>>>      		size_t maxsize =3D BITS_TO_BYTES(spi-
> >bits_per_word);
> > >>>>>>>      		int ret;
> > >>>>>>>
> > >>>>>>> diff --git a/include/linux/spi/spi.h =
b/include/linux/spi/spi.h
> > >>>>>>> index 7b4baff63c5c..871d3a6d879b 100644
> > >>>>>>> --- a/include/linux/spi/spi.h
> > >>>>>>> +++ b/include/linux/spi/spi.h
> > >>>>>>> @@ -20,6 +20,9 @@
> > >>>>>>>
> > >>>>>>>      #include <uapi/linux/spi/spi.h>
> > >>>>>>>
> > >>>>>>> +/* Max no. of CS supported per spi device */ #define
> > >>>>>>> +SPI_CS_CNT_MAX
> > >>>>>>> +4
> > >>>>>>> +
> > >>>>>>>      struct dma_chan;
> > >>>>>>>      struct software_node;
> > >>>>>>>      struct ptp_system_timestamp; @@ -132,7 +135,8 @@
> extern
> > >>>>>>> void
> > >>>>>> spi_transfer_cs_change_delay_exec(struct spi_message *msg,
> > >>>>>>>       * @max_speed_hz: Maximum clock rate to be used with =
this
> chip
> > >>>>>>>       *	(on this board); may be changed by the device's =
driver.
> > >>>>>>>       *	The spi_transfer.speed_hz can override this for each
> transfer.
> > >>>>>>> - * @chip_select: Chipselect, distinguishing chips handled =
by
> > >> @controller.
> > >>>>>>> + * @chip_select: Array of physical chipselect, =
spi->chipselect[i]
> gives
> > >>>>>>> + *	the corresponding physical CS for logical CS i.
> > >>>>>>>       * @mode: The spi mode defines how data is clocked out =
and
> in.
> > >>>>>>>       *	This may be changed by the device's driver.
> > >>>>>>>       *	The "active low" default for chipselect mode can be
> > >> overridden
> > >>>>>>> @@ -157,8 +161,8 @@ extern void
> > >>>>>> spi_transfer_cs_change_delay_exec(struct spi_message *msg,
> > >>>>>>>       *	the device will bind to the named driver and only =
the
> named
> > >> driver.
> > >>>>>>>       *	Do not set directly, because core frees it; use
> > >> driver_set_override() to
> > >>>>>>>       *	set or clear it.
> > >>>>>>> - * @cs_gpiod: GPIO descriptor of the chipselect line =
(optional,
> > >>>>>>> NULL
> > >>>> when
> > >>>>>>> - *	not using a GPIO line)
> > >>>>>>> + * @cs_gpiod: Array of GPIO descriptors of the =
corresponding
> > >>>>>>> + chipselect
> > >>>>>> lines
> > >>>>>>> + *	(optional, NULL when not using a GPIO line)
> > >>>>>>>       * @word_delay: delay to be inserted between =
consecutive
> > >>>>>>>       *	words of a transfer
> > >>>>>>>       * @cs_setup: delay to be introduced by the controller
> > >>>>>>> after CS is asserted @@ -167,6 +171,7 @@ extern void
> > >>>>>> spi_transfer_cs_change_delay_exec(struct spi_message *msg,
> > >>>>>>>       *	deasserted. If @cs_change_delay is used from
> @spi_transfer,
> > >> then
> > >>>>>> the
> > >>>>>>>       *	two delays will be added up.
> > >>>>>>>       * @pcpu_statistics: statistics for the spi_device
> > >>>>>>> + * @cs_index_mask: Bit mask of the active chipselect(s) in =
the
> > >>>>>>> + chipselect array
> > >>>>>>>       *
> > >>>>>>>       * A @spi_device is used to interchange data between an =
SPI
> slave
> > >>>>>>>       * (usually a discrete chip) and CPU memory.
> > >>>>>>> @@ -182,7 +187,7 @@ struct spi_device {
> > >>>>>>>      	struct spi_controller	*controller;
> > >>>>>>>      	struct spi_controller	*master;	/* Compatibility
> layer
> > >> */
> > >>>>>>>      	u32			max_speed_hz;
> > >>>>>>> -	u8			chip_select;
> > >>>>>>> +	u8			chip_select[SPI_CS_CNT_MAX];
> > >>>>>>>      	u8			bits_per_word;
> > >>>>>>>      	bool			rt;
> > >>>>>>>      #define SPI_NO_TX		BIT(31)		/* No
> transmit wire */
> > >>>>>>> @@ -213,7 +218,7 @@ struct spi_device {
> > >>>>>>>      	void			*controller_data;
> > >>>>>>>      	char			modalias[SPI_NAME_SIZE];
> > >>>>>>>      	const char		*driver_override;
> > >>>>>>> -	struct gpio_desc	*cs_gpiod;	/* Chip select GPIO
> > descriptor
> > >>>>>> */
> > >>>>>>> +	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/*
> > >> Chip select
> > >>>>>> gpio desc */
> > >>>>>>>      	struct spi_delay	word_delay; /* Inter-word delay */
> > >>>>>>>      	/* CS delays */
> > >>>>>>>      	struct spi_delay	cs_setup;
> > >>>>>>> @@ -223,6 +228,13 @@ struct spi_device {
> > >>>>>>>      	/* The statistics */
> > >>>>>>>      	struct spi_statistics __percpu	*pcpu_statistics;
> > >>>>>>>
> > >>>>>>> +	/* Bit mask of the chipselect(s) that the driver need to =
use
> > >> from
> > >>>>>>> +	 * the chipselect array.When the controller is capable to
> > >> handle
> > >>>>>>> +	 * multiple chip selects & memories are connected in
> parallel
> > >>>>>>> +	 * then more than one bit need to be set in
> cs_index_mask.
> > >>>>>>> +	 */
> > >>>>>>> +	u32			cs_index_mask :
> SPI_CS_CNT_MAX;
> > >>>>>>> +
> > >>>>>>>      	/*
> > >>>>>>>      	 * Likely need more hooks for more protocol options
> > >>>>>>> affecting
> > >> how
> > >>>>>>>      	 * the controller talks to each chip, like:
> > >>>>>>> @@ -279,22 +291,33 @@ static inline void
> *spi_get_drvdata(const
> > >>>>>>> struct spi_device *spi)
> > >>>>>>>
> > >>>>>>>      static inline u8 spi_get_chipselect(const struct =
spi_device
> *spi, u8
> > idx)
> > >>>>>>>      {
> > >>>>>>> -	return spi->chip_select;
> > >>>>>>> +	return spi->chip_select[idx];
> > >>>>>>>      }
> > >>>>>>>
> > >>>>>>>      static inline void spi_set_chipselect(struct spi_device
> > >>>>>>> *spi,
> > >>>>>>> u8 idx, u8
> > >>>>>> chipselect)
> > >>>>>>>      {
> > >>>>>>> -	spi->chip_select =3D chipselect;
> > >>>>>>> +	spi->chip_select[idx] =3D chipselect;
> > >>>>>>>      }
> > >>>>>>>
> > >>>>>>>      static inline struct gpio_desc *spi_get_csgpiod(const
> > >>>>>>> struct spi_device *spi,
> > >>>>>> u8 idx)
> > >>>>>>>      {
> > >>>>>>> -	return spi->cs_gpiod;
> > >>>>>>> +	return spi->cs_gpiod[idx];
> > >>>>>>>      }
> > >>>>>>>
> > >>>>>>>      static inline void spi_set_csgpiod(struct spi_device =
*spi,
> > >>>>>>> u8 idx, struct
> > >>>>>> gpio_desc *csgpiod)
> > >>>>>>>      {
> > >>>>>>> -	spi->cs_gpiod =3D csgpiod;
> > >>>>>>> +	spi->cs_gpiod[idx] =3D csgpiod;
> > >>>>>>> +}
> > >>>>>>> +
> > >>>>>>> +static inline bool spi_is_csgpiod(struct spi_device *spi) {
> > >>>>>>> +	u8 idx;
> > >>>>>>> +
> > >>>>>>> +	for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > >>>>>>> +		if (spi_get_csgpiod(spi, idx))
> > >>>>>>> +			return true;
> > >>>>>>> +	}
> > >>>>>>> +	return false;
> > >>>>>>>      }
> > >>>>>>>
> > >>>>>>>      /**
> > >>>>>>> @@ -399,6 +422,8 @@ extern struct spi_device
> > >>>>>> *spi_new_ancillary_device(struct spi_device *spi, u8 ch
> > >>>>>>>       * @bus_lock_spinlock: spinlock for SPI bus locking
> > >>>>>>>       * @bus_lock_mutex: mutex for exclusion of multiple =
callers
> > >>>>>>>       * @bus_lock_flag: indicates that the SPI bus is locked =
for
> > >>>>>>> exclusive use
> > >>>>>>> + * @multi_cs_cap: indicates that the SPI Controller can
> > >>>>>>> + assert/de-
> > >> assert
> > >>>>>>> + *	more than one chip select at once.
> > >>>>>>>       * @setup: updates the device mode and clocking records
> used by
> > a
> > >>>>>>>       *	device's SPI controller; protocol code may call =
this.  This
> > >>>>>>>       *	must fail if an unrecognized or unsupported mode is
> > >> requested.
> > >>>>>>> @@ -567,6 +592,11 @@ struct spi_controller {
> > >>>>>>>      #define SPI_CONTROLLER_MUST_TX		BIT(4)
> 	/*
> > Requires tx
> > >>>> */
> > >>>>>>>      #define SPI_CONTROLLER_GPIO_SS		BIT(5)
> 	/* GPIO CS
> > >>>> must
> > >>>>>> select slave */
> > >>>>>>>      #define SPI_CONTROLLER_SUSPENDED	BIT(6)	/*
> Currently
> > >>>>>> suspended */
> > >>>>>>> +	/*
> > >>>>>>> +	 * The spi-controller has multi chip select capability and
> can
> > >>>>>>> +	 * assert/de-assert more than one chip select at once.
> > >>>>>>> +	 */
> > >>>>>>> +#define SPI_CONTROLLER_MULTI_CS		BIT(7)
> > >>>>>>>
> > >>>>>>>      	/* Flag indicating if the allocation of this struct is
> > >>>>>>> devres-
> > >> managed */
> > >>>>>>>      	bool			devm_allocated;
> > >>>>>>> @@ -677,7 +707,8 @@ struct spi_controller {
> > >>>>>>>      	bool				rt;
> > >>>>>>>      	bool				auto_runtime_pm;
> > >>>>>>>      	bool				cur_msg_mapped;
> > >>>>>>> -	char				last_cs;
> > >>>>>>> +	char
> 	last_cs[SPI_CS_CNT_MAX];
> > >>>>>>> +	char				last_cs_index_mask;
> > >>>>>>>      	bool				last_cs_mode_high;
> > >>>>>>>      	bool                            fallback;
> > >>>>>>>      	struct completion               xfer_completion;

