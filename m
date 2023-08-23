Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34F7785184
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjHWH3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjHWH3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:29:51 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C7BE6E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:29:18 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 367B15C00CB;
        Wed, 23 Aug 2023 03:28:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 23 Aug 2023 03:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1692775738; x=1692862138; bh=Wv
        3RiRy2ETYZlnTID86lefuVr+j4C6g6cSewTgQCYEc=; b=OB9EJ9dazC09WveDic
        EKxTLUvlADYE33Vb1UT7NkmXKqctSaKTM2kGztwz4tEUiM3MdfoH6JqEj2IWx2nA
        XONZHg+v524al0ENYsnExheGpTio8vvPn3y78Zj53jiK/kpbviu0gIngUe+LcN5d
        4ypwDe2VrDAuivRTp1XrVIZwQIN7GKdTwH4NxxlGw3VodH1bu4BCycMKI/frapW4
        wzXln/kH1SaT1oFOPFcdBhgJxh30J3ALdTWiQj/a3gBRRfiMZD1yVTmhOe5zdpxP
        Jtcapt/O2/cY46yycwuPpRtw7Sd4JQ+VW6xpQZ2Y/XzcblMtlNkBx1iUOsDdmj0p
        WPjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692775738; x=1692862138; bh=Wv3RiRy2ETYZl
        nTID86lefuVr+j4C6g6cSewTgQCYEc=; b=FKs+woQ/MHGcrpvzEDAfT7nhE8wIu
        Rsrdqj76EfAdxAHGw+u8xuaRiYauRwPlVqREmbvMKN4Aa1VpJYtVmDGwuHbcseOm
        xdoSfXBkx0xlKeZdSnSRIs10B189mCYBtMACwltUhQ/wApKw7KPrqFWJFu20G80d
        ABamTcRCxCFzjval0Cu8StPNCTxjtgEEQxar1rvlI+GWozWB1xTvYfSKgHVE4X1q
        ZYygli2g1MFOUNOiS1zJCxvIEr9BhFnv6bN75K4O4IuLUm4VWsQdFDLlGnJvG/lK
        Zb/NvPyPExl0mMCurqZmfy0Qv054+A9G1s0K2z9Sds7cYXXlIswY4bWXg==
X-ME-Sender: <xms:ObXlZCUyCiQuIMLfP1G80rddM02e497INbmo931r9YU1wf52HNn7VA>
    <xme:ObXlZOmzdhlh94_UeS-vlHEjo1OxuQVyANme2ZLM2QUzmn5uOUPbi6vB1lKxCjME3
    A6BXqQKxEYrt0KU2pU>
X-ME-Received: <xmr:ObXlZGZIWl2WAZ9hFR6uF6NtDoEJEvTNkTjhWACVY6cFHGw-NVsnhvj3ZUeb2NTjNNfY0YmX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:ObXlZJXjZ1PN9M68ZnxzaKV510sD2xP4o2j0N4KOfDR_VkJFNjsMXg>
    <xmx:ObXlZMmIUxlE-41SxnPXHCJClICpGS7Qywf3KXnPja7eM8kZkBvw6A>
    <xmx:ObXlZOdvqL2nWMA_iECXL_v3DnB-oaNWCkrXkW_rVOt_uu7jwUTYQw>
    <xmx:OrXlZLsQ-7lGNt1SiWz7p6kyju1IynoOKW8jIGKz92tne1rS0wJAPw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 03:28:52 -0400 (EDT)
Date:   Wed, 23 Aug 2023 19:28:39 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] ALSA: hda: cs35l41: Support ASUS 2023 laptops with
 missing DSD
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        sbinding@opensource.cirrus.com, Jonathan LoBue <jlobue10@gmail.com>
Message-Id: <R32UZR.6AQKQL1J6UQI3@ljones.dev>
In-Reply-To: <87v8d6cm30.wl-tiwai@suse.de>
References: <20230823011008.13146-1-luke@ljones.dev>
        <87v8d6cm30.wl-tiwai@suse.de>
X-Mailer: geary/44.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Aug 23 2023 at 08:24:51 +02:00:00, Takashi Iwai <tiwai@suse.de> 
wrote:
> On Wed, 23 Aug 2023 03:10:08 +0200,
> Luke D. Jones wrote:
>> 
>>  Support adding the missing DSD properties required  for ASUS ROG 
>> 2023
>>  laptops and other ASUS laptops to properly utilise the cs35l41.
>> 
>>  This support includes both I2C and SPI connected amps.
>> 
>>  The SPI connected amps may be required to use an external DSD patch
>>  to fix or add the "cs-gpios" property.
>> 
>>  Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>
>>  Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
>>  Co-developed-by: Luke D. Jones <luke@ljones.dev>
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>  ---
>>   sound/pci/hda/cs35l41_hda_property.c | 26 
>> ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>> 
>>  diff --git a/sound/pci/hda/cs35l41_hda_property.c 
>> b/sound/pci/hda/cs35l41_hda_property.c
>>  index 673f23257a09..69879ab57918 100644
>>  --- a/sound/pci/hda/cs35l41_hda_property.c
>>  +++ b/sound/pci/hda/cs35l41_hda_property.c
>>  @@ -43,6 +43,31 @@ static int lenovo_legion_no_acpi(struct 
>> cs35l41_hda *cs35l41, struct device *phy
>>   	return 0;
>>   }
>> 
>>  +/*
>>  + * The CSC3551 is used in almost the entire ASUS ROG laptop range 
>> in 2023, this is likely to
>>  + * also include many non ROG labelled laptops. It is also used 
>> with either I2C connection or
>>  + * SPI connection. The SPI connected versions may be missing a 
>> chip select GPIO and require
>>  + * an DSD table patch.
>>  + */
>>  +static int asus_rog_2023_no_acpi(struct cs35l41_hda *cs35l41, 
>> struct device *physdev, int id,
>>  +				const char *hid)
>>  +{
>>  +	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
>>  +
>>  +	/* check SPI or I2C address to assign the index */
>>  +	cs35l41->index = (id == 0 || id == 0x40) ? 0 : 1;
>>  +	cs35l41->channel_index = 0;
>>  +	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, 
>> GPIOD_OUT_HIGH);
>>  +	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, 0, 0, 2);
>>  +	hw_cfg->spk_pos = cs35l41->index;
>>  +	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
>>  +	hw_cfg->gpio2.valid = true;
>>  +	hw_cfg->bst_type = CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
>>  +	hw_cfg->valid = true;
>>  +
>>  +	return 0;
>>  +}
>>  +
>>   struct cs35l41_prop_model {
>>   	const char *hid;
>>   	const char *ssid;
>>  @@ -53,6 +78,7 @@ struct cs35l41_prop_model {
>>   const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
>>   	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
>>   	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
>>  +	{ "CSC3551", NULL, asus_rog_2023_no_acpi },
> 
> I believe this breaks things badly.  cs35l41_add_dsd_properties() is
> always called no matter whether _DSD is found or not.  So this will
> override the setup of all machines with CSC3551 even if it has a
> proper _DSD.

These are the entries I know of so far since they definitely had to be 
added and have a DSD patch:

- SPI_2
    - 0x1043, 0x1473, "ASUS GU604V"
    - 0x1043, 0x1483, "ASUS GU603V"
    - 0x1043, 0x1493, "ASUS GV601V"
    - 0x1043, 0x1573, "ASUS GZ301V"
    - 0x1043, 0x1c9f, "ASUS G614JI"
- SPI_4
    - 0x1043, 0x1caf, "ASUS G634JYR/JZR"
- I2C_2
    - 0x1043, 0x1d1f, "ASUS ROG Strix G17
    - 0x1043, 0x1463, "Asus GA402X"
    - 0x1043, 0x1433, "ASUS GX650P"
    - ROG ALLY

You can see the variants are V, J, X, and P. A grep through the DSL 
dumps I have collected reveals that these machines are all indeed 
missing DSD entries. These are a mix of I2C and SPI.

The patch I submitted was based on Stefan's work only, and tested on 3 
SPI machines plus 2 I2C machines with no issues except the SPI machines 
needing a chipselect DSD patch.

It's worth stating that the DSD patches people were using all followed 
the exact same template except for the SPI number, or speaker ID.

I'd wager it being a safe bet to assume that every one of the ASUS 
laptops this year using the CSC3551 will be missing the required DSD 
entries given the trend so far.

> The existing entries of CLSA0100 and CLSA0101 are OK since
> (supposedly) those never had _DSD.  The current code is a bit
> misleading as if it's applicable easily, though.
> 
> That said, we have to apply the setup only conditionally for each
> specific device.  One easy thing would be to move the function call
> after _DSD check.  But, I *guess* that Stefan applied the function at
> the top so that it may cover the all cases including incorrect _DSD
> properties.

Given the trend of what I've seen this seems like a reasonable 
assumption and desired.

> And, the question is how to be specific to each device.  This can be
> messy, as the sub-codec driver is probed independently from Realtek
> codec driver, hence you can't pass any flag from Realtek to CS driver
> at the probe time.  In the end, we might need to keep another table of
> IDs (either the same SSID or DMI) to distinguish which machine needs
> which properties.

Is there some other ID we can use? I see:
[   13.569242] cs35l41-hda spi0-CSC3551:00-cs35l41-hda.1: Cirrus Logic 
CS35L41 (35a40), Revision: B2
and I'd assume that 35a40 is unique? A bit of searching on my discord 
reveals that all the machines I listed that require the same patch also 
have this identifier (including a ProArt laptop).

I can get a fairly large test base if required.
> 
Cheers,
Luke.



