Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B00785651
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjHWK5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjHWK5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:57:18 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF234FB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:57:15 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37NAieQV024828;
        Wed, 23 Aug 2023 05:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:references:in-reply-to:subject:date:message-id
        :mime-version:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=VMv+RPE4jRGUP0nFqNA27OuALDFKASEjInLTT97+DJ0=; b=
        gcNos8suS6pSauHDjgyRTpcib4qH58K4LrtlBa1CaYm88PY+goJDyT6b1tKpimJO
        3eTOjObhpxdTRmxvwXFboJ89c+FBMBbmyQSH8/KosKKHnL5IFE9qJLkHV7/H9/93
        9IVFFg74CciM9ov82x1RubwbZvPh234YkE3EBhm98Tr0ChwxI+1SVqgmiGcWk4u9
        ukACH/1fxOlqzRgibAqpXLpO4orOhwRAJi80aRtkqU0Grb45wMNqvEERfiJfUCQZ
        Y06dWOCZeMI4aLEWrRHSbOBdgwdPrMMZRuQXSP+C1l4rwbX0E58aI5sjXUof5vXV
        9ltkz4gM6ykG0vhQDKY3UA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sn1y1gphy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 05:57:06 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 23 Aug
 2023 11:57:04 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Wed, 23 Aug 2023 11:57:04 +0100
Received: from LONN2DGDQ73 (LONN2DGDQ73.ad.cirrus.com [198.61.64.167])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 76CAD2A9;
        Wed, 23 Aug 2023 10:57:04 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     'Takashi Iwai' <tiwai@suse.de>, 'Luke Jones' <luke@ljones.dev>
CC:     <tiwai@suse.com>, <james.schulman@cirrus.com>,
        <david.rhodes@cirrus.com>, <rf@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        'Jonathan LoBue' <jlobue10@gmail.com>,
        <patches@opensource.cirrus.com>
References: <20230823011008.13146-1-luke@ljones.dev>    <87v8d6cm30.wl-tiwai@suse.de>   <R32UZR.6AQKQL1J6UQI3@ljones.dev>       <87lee2ciqj.wl-tiwai@suse.de>   <NN3UZR.VNYA824H66Q8@ljones.dev> <87il96cfnb.wl-tiwai@suse.de>
In-Reply-To: <87il96cfnb.wl-tiwai@suse.de>
Subject: RE: [PATCH] ALSA: hda: cs35l41: Support ASUS 2023 laptops with missing DSD
Date:   Wed, 23 Aug 2023 11:57:04 +0100
Message-ID: <000601d9d5b0$8d6817f0$a83847d0$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQDVr/niKkW5lcSfWGj/lSgcr+XYNgFZazb0AnhovUgC3lvciQFtQrAvAZcLqMWxslVaQA==
X-Proofpoint-GUID: 7iBn0kmVJqjPcBq7-luvJM1NUExdAPb7
X-Proofpoint-ORIG-GUID: 7iBn0kmVJqjPcBq7-luvJM1NUExdAPb7
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Wednesday, August 23, 2023 9:44 AM
> To: Luke Jones <luke@ljones.dev>
> Cc: Takashi Iwai <tiwai@suse.de>; tiwai@suse.com;
> james.schulman@cirrus.com; david.rhodes@cirrus.com;
> rf@opensource.cirrus.com; linux-kernel@vger.kernel.org;
> sbinding@opensource.cirrus.com; Jonathan LoBue <jlobue10@gmail.com>
> Subject: Re: [PATCH] ALSA: hda: cs35l41: Support ASUS 2023 laptops
with
> missing DSD
> 
> On Wed, 23 Aug 2023 10:02:11 +0200,
> Luke Jones wrote:
> >
> >
> >
> > On Wed, Aug 23 2023 at 09:37:08 +02:00:00, Takashi Iwai
> > <tiwai@suse.de> wrote:
> > > On Wed, 23 Aug 2023 09:28:39 +0200,
> > > Luke Jones wrote:
> > >>
> > >>
> > >>
> > >>  On Wed, Aug 23 2023 at 08:24:51 +02:00:00, Takashi Iwai
> > >>  <tiwai@suse.de> wrote:
> > >>  > On Wed, 23 Aug 2023 03:10:08 +0200,
> > >>  > Luke D. Jones wrote:
> > >>  >>
> > >>  >>  Support adding the missing DSD properties required  for
ASUS
> ROG
> > >>  >> 2023
> > >>  >>  laptops and other ASUS laptops to properly utilise the
cs35l41.
> > >>  >>
> > >>  >>  This support includes both I2C and SPI connected amps.
> > >>  >>
> > >>  >>  The SPI connected amps may be required to use an external
DSD
> > >> patch
> > >>  >>  to fix or add the "cs-gpios" property.
> > >>  >>
> > >>  >>  Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>
> > >>  >>  Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> > >>  >>  Co-developed-by: Luke D. Jones <luke@ljones.dev>
> > >>  >>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > >>  >>  ---
> > >>  >>   sound/pci/hda/cs35l41_hda_property.c | 26
> > >>  >> ++++++++++++++++++++++++++
> > >>  >>   1 file changed, 26 insertions(+)
> > >>  >>
> > >>  >>  diff --git a/sound/pci/hda/cs35l41_hda_property.c
> > >>  >> b/sound/pci/hda/cs35l41_hda_property.c
> > >>  >>  index 673f23257a09..69879ab57918 100644
> > >>  >>  --- a/sound/pci/hda/cs35l41_hda_property.c
> > >>  >>  +++ b/sound/pci/hda/cs35l41_hda_property.c
> > >>  >>  @@ -43,6 +43,31 @@ static int lenovo_legion_no_acpi(struct
> > >>  >> cs35l41_hda *cs35l41, struct device *phy
> > >>  >>   	return 0;
> > >>  >>   }
> > >>  >>
> > >>  >>  +/*
> > >>  >>  + * The CSC3551 is used in almost the entire ASUS ROG
laptop
> > >> range
> > >>  >> in 2023, this is likely to
> > >>  >>  + * also include many non ROG labelled laptops. It is also
used
> > >>  >> with either I2C connection or
> > >>  >>  + * SPI connection. The SPI connected versions may be
missing a
> > >>  >> chip select GPIO and require
> > >>  >>  + * an DSD table patch.
> > >>  >>  + */
> > >>  >>  +static int asus_rog_2023_no_acpi(struct cs35l41_hda
*cs35l41,
> > >>  >> struct device *physdev, int id,
> > >>  >>  +				const char *hid)
> > >>  >>  +{
> > >>  >>  +	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
> > >>  >>  +
> > >>  >>  +	/* check SPI or I2C address to assign the index */
> > >>  >>  +	cs35l41->index = (id == 0 || id == 0x40) ? 0 : 1;
> > >>  >>  +	cs35l41->channel_index = 0;
> > >>  >>  +	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL,
0,
> > >>  >> GPIOD_OUT_HIGH);
> > >>  >>  +	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev,
> > >> 0, 0, 2);
> > >>  >>  +	hw_cfg->spk_pos = cs35l41->index;
> > >>  >>  +	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
> > >>  >>  +	hw_cfg->gpio2.valid = true;
> > >>  >>  +	hw_cfg->bst_type =
> CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
> > >>  >>  +	hw_cfg->valid = true;
> > >>  >>  +
> > >>  >>  +	return 0;
> > >>  >>  +}
> > >>  >>  +
> > >>  >>   struct cs35l41_prop_model {
> > >>  >>   	const char *hid;
> > >>  >>   	const char *ssid;
> > >>  >>  @@ -53,6 +78,7 @@ struct cs35l41_prop_model {
> > >>  >>   const struct cs35l41_prop_model
cs35l41_prop_model_table[] =
> {
> > >>  >>   	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
> > >>  >>   	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
> > >>  >>  +	{ "CSC3551", NULL, asus_rog_2023_no_acpi },
> > >>  >
> > >>  > I believe this breaks things badly.
> > >> cs35l41_add_dsd_properties() is
> > >>  > always called no matter whether _DSD is found or not.  So
this
> > >> will
> > >>  > override the setup of all machines with CSC3551 even if it
has a
> > >>  > proper _DSD.
> > >>
> > >>  These are the entries I know of so far since they definitely
had
> > >> to be
> > >>  added and have a DSD patch:
> > >>
> > >>  - SPI_2
> > >>     - 0x1043, 0x1473, "ASUS GU604V"
> > >>     - 0x1043, 0x1483, "ASUS GU603V"
> > >>     - 0x1043, 0x1493, "ASUS GV601V"
> > >>     - 0x1043, 0x1573, "ASUS GZ301V"
> > >>     - 0x1043, 0x1c9f, "ASUS G614JI"
> > >>  - SPI_4
> > >>     - 0x1043, 0x1caf, "ASUS G634JYR/JZR"
> > >>  - I2C_2
> > >>     - 0x1043, 0x1d1f, "ASUS ROG Strix G17
> > >>     - 0x1043, 0x1463, "Asus GA402X"
> > >>     - 0x1043, 0x1433, "ASUS GX650P"
> > >>     - ROG ALLY
> > >>
> > >>  You can see the variants are V, J, X, and P. A grep through
the DSL
> > >>  dumps I have collected reveals that these machines are all
indeed
> > >>  missing DSD entries. These are a mix of I2C and SPI.
> > >>
> > >>  The patch I submitted was based on Stefan's work only, and
tested
> > >> on 3
> > >>  SPI machines plus 2 I2C machines with no issues except the SPI
> > >>  machines needing a chipselect DSD patch.
> > >>
> > >>  It's worth stating that the DSD patches people were using all
> > >> followed
> > >>  the exact same template except for the SPI number, or speaker
ID.
> > >>
> > >>  I'd wager it being a safe bet to assume that every one of the
ASUS
> > >>  laptops this year using the CSC3551 will be missing the
required DSD
> > >>  entries given the trend so far.
> > >
> > > Yes, I know that there are tons of such devices that need the
> > > workaround for missing _DSD.  My point is, however, that your
patch
> > > breaks the devices that *do have* _DSD, because the function
always
> > > overrides.
> >
> > Ah, because CSC3551 is not unique at all. I see.
> >
> > >
> > >>  > The existing entries of CLSA0100 and CLSA0101 are OK since
> > >>  > (supposedly) those never had _DSD.  The current code is a
bit
> > >>  > misleading as if it's applicable easily, though.
> > >>  >
> > >>  > That said, we have to apply the setup only conditionally for
each
> > >>  > specific device.  One easy thing would be to move the
function
> > >> call
> > >>  > after _DSD check.  But, I *guess* that Stefan applied the
> > >> function at
> > >>  > the top so that it may cover the all cases including
incorrect
> > >> _DSD
> > >>  > properties.
> > >>
> > >>  Given the trend of what I've seen this seems like a reasonable
> > >>  assumption and desired.
> > >
> > > ... and it's not enough.  That's another point.  The parameters
aren't
> > > always same for all devices but may vary.  That is, it must have
some
> > > check of devices and models to identify which parameters may be
> used.
> > >
> > >>  > And, the question is how to be specific to each device.
This
> > >> can be
> > >>  > messy, as the sub-codec driver is probed independently from
> > >> Realtek
> > >>  > codec driver, hence you can't pass any flag from Realtek to
CS
> > >> driver
> > >>  > at the probe time.  In the end, we might need to keep
another
> > >> table of
> > >>  > IDs (either the same SSID or DMI) to distinguish which
machine
> > >> needs
> > >>  > which properties.
> > >>
> > >>  Is there some other ID we can use? I see:
> > >>  [   13.569242] cs35l41-hda spi0-CSC3551:00-cs35l41-hda.1:
Cirrus
> > >> Logic
> > >>  CS35L41 (35a40), Revision: B2
> > >>  and I'd assume that 35a40 is unique? A bit of searching on my
> > >> discord
> > >>  reveals that all the machines I listed that require the same
patch
> > >>  also have this identifier (including a ProArt laptop).
> > >
> > > That's not unique to each *device* (not the chip model).  Say,
we want
> > > to distinguish ASUS GU604V and ASUS G64JYR.  They may have
> different
> > > setups.
> > >
> > > I guess only DMI is suitable at the time of probing this driver.
> >
> > Oh, I'm sorry I should have paid more attention the first time. I
can
> > match against acpi_subsystem_id which would be for example
10431caf
> > yes?

The second member variable in cs35l41_prop_model_table is the SSID to
match against.
The Lenovo laptops in the initial patch didn't have different SSIDs so
the entry was set to NULL for those.
Future entries using CSC3551 MUST always have an accompanying SSID
with this entry.
Takashi was correct, the implementation is intended to also be used to
patch incorrect DSD.

We have a potential solution to workaround the SPI cs-gpios issue
inside here,
though the drawback for that is that it only works for laptops with 2
SPI amps.

I also took a look at the function for applying DSD properties for the
2023 ROG laptops.
Unfortunately the one-size-fits-all approach will not work, some of
these laptops are i2c
and some are SPI, meaning the GPIO indexes are different for different
laptops.
Some of the laptops do no have Speaker IDs.
Also, no laptop other than the 2 I added already should ever use
CS35L41_EXT_BOOST_NO_VSPK_SWITCH (in fact I believe all these laptops
are internal
boost anyway).

We are currently working internally on adding support for the 2023 ROG
laptops, so we
ask for you guys to hold off on trying to upstream support for these
laptops.

Thanks,
Stefan Binding

> 
> I believe many other drivers match with vendor name, product name,
or
> whatever strings.
> 
> > I'll begin working on a patch series for each.
> 
> Thanks!
> 
> 
> Takashi

