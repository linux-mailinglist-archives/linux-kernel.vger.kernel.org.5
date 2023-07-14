Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61C37535E8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjGNI7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbjGNI7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:59:15 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48872270D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:59:13 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 89C0A3200A89;
        Fri, 14 Jul 2023 04:59:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 14 Jul 2023 04:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1689325148; x=1689411548; bh=Bj
        5d2LGTJs0fZ1RQIj+AZXTLLmMTS4uzAR/g8bU3cF0=; b=gkvr+TauRWO76gemYL
        aAXsVcvm41JQIfc/KTgjymkKu5/ok+o6uZ5U6XAfbDgPC/Fldds8qbkcxvT6orA1
        JUlY8jlk/qK4Gf1XPeA+461/0UY0EfRA84vFmSFi5tdRWV+PLxiToTOfKTTxtGCZ
        WdrFfaMu5ULqmRQrOXtXPZqfw30i92B8j5YU9y1lP64Nqu1a4tIiXCB5w6spDKMY
        g1DfeQXDM1uW2x1LcniEmJmG3IRSlsDS6ZsbaSWuNEIkkIVRsm63QrxCSpHvJT/+
        NY/Id2HS0urAdtrWzPO8C8VfIJKqHt9EyS2Jviyk48jTA8M9uOLqVePuiuY8kcdG
        8dKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689325148; x=1689411548; bh=Bj5d2LGTJs0fZ
        1RQIj+AZXTLLmMTS4uzAR/g8bU3cF0=; b=xwpfI3oOf2/yFJV3psYNaSOgKl3iu
        y8OboD7vY/0SIiKf0XSMc6wZvot85Pww+hNcFS/iZxMw0okRupwISwY1uWa7PO5v
        lnjYpSMGXsqf4fTwItkc1Bgn5pQwyRAfnqUMismidoauNul1nGajzkiQjHyQzR/9
        DEy14IqTAvjeVJREARRcIJJJZ7nv+P05RiBoyF5CC1h0w4vOH3DIdnRfhenL6TKy
        XoamRCGbig44Md61Qi5SWIduGxmYi69qlq9W9BKOsZKxhJtjnnaDLWUus5W7Teth
        ns8TZWnX/TaEVCTZHZ9QyYa1iWX8PlrHkMdilFw4E3e8V384rKOUBpE3Q==
X-ME-Sender: <xms:Ww6xZAtHoA7dwQEQ5oq_qQ6xoa9LHrwOmbRvIKVI6Z_zqp3Ve6BMpg>
    <xme:Ww6xZNc9LIp7he6tZPT83hJ_Sve7EnKb-PWHjKMMzcgQPRz3nn2bJJUEL0WIEHLIi
    q36sgH8swrXVi-NQKE>
X-ME-Received: <xmr:Ww6xZLzW-f_bQg_qgd0eL5GkMls-ka-zr-eV6CapEJOFIqXY5SeMh0G0xmgMOhNy3b5DwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhkvgcu
    lfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpe
    fhieegtdevfeejueekteefkedtfeeffeetkeefffeiieetieeghefhuddtiedtheenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:Ww6xZDPCgLYSlP0Q7L_Jfdn76_UKfZgZXPudVWTd7sLwfES8E5M6fw>
    <xmx:Ww6xZA9GlOC6WwMynoJypWiKcxJZsLf9FXx5NpSvzcpQa4SfGNtooQ>
    <xmx:Ww6xZLXqze6EbxzuTYj7vY_c1gO9MPOSwMZ1JmLqfLbUgJx8yn1cnQ>
    <xmx:XA6xZEWCK4_DS4_kBV8Ea-zwGGcR6MwdwnXe34mdK5vgqUHXWhpTFA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jul 2023 04:58:57 -0400 (EDT)
Date:   Fri, 14 Jul 2023 20:58:44 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 1/2] ALSA: hda: cs35l41: Add fixups for machines without a
 valid ACPI _DSD
To:     David Xu <xuwd1@hotmail.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Andy Chi <andy.chi@canonical.com>,
        Tim Crawford <tcrawford@system76.com>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        Kacper =?iso-8859-2?q?Michaj=B3ow?= <kasper93@gmail.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        Yuchi Yang <yangyuchi66@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Message-Id: <WL3SXR.02LV303LBEC33@ljones.dev>
In-Reply-To: <SY4P282MB183539E5A91B351249A2F8F1E037A@SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM>
References: <20230713162955.34842-1-xuwd1@hotmail.com>
        <SY4P282MB183539E5A91B351249A2F8F1E037A@SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: geary/44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Jul 14 2023 at 00:29:54 +08:00:00, David Xu <xuwd1@hotmail.com> 
wrote:
> As the comments added in commit 4d4c4bff4f8ed79d95e05 ("ALSA: hda:
> cs35l41: Clarify support for CSC3551 without _DSD Properties"), 
> CSC3551
> requires a valid _DSD to work and the current implementation just
> fails when no _DSD can be found for CSC3551. However it is a fact
> that many OEMs hardcoded the configurations needed by CSC3551 into 
> their
> proprietary software for various 2022 and later laptop models,
> and this makes the Linux installations on these models cannot make
> any speaker sound. Meanwhile, at this point of time, we see no hope
> that these OEMs would ever fix this problem via a BIOS update. So
> to fix this bothering problem it might be worthwhile to add some
> model-specific fixups to apply some proper configurations
> to the cs35l41.
> 
> To address the above problem, a configuration fixup function
> apply_cs35l41_fixup_cfg that would be called in cs35l41_no_acpi_dsd,
> along with a fixup table cs35l41_fixup_cfgtbl which is a array of
> fixup entry struct cs35l41_fixup_cfg are introduced. Each fixup entry
> records the ACPI _SUB(vender and device ID) to be matched, and a
> configuration to be applied to each of the cs35l41 device in CSC3551.
> 
> More specifically for the design of this fixup mechanism,
> the maximum number of cs35l41 configurations inside a fixup entry
> is defined as a macro CS35L41_FIXUP_CFG_MAX_DEVICES, and the actual
> number of cs35l41 devices in a CSC3551 system is recorded in the
> num_device field in the fixup entry. The apply_cs35l41_fixup_cfg
> function is responsible for finding and applying a fixup for a
> specific model according to the model's ACPI _SUB. If no valid fixup
> can be applied, the fixup function fails and returns to the normal
> cs35l41_no_acpi_dsd execution flow.
> 
> This patch now contains only several fixups for three Lenovo laptop
> models, namely 16IAH7, 16IAX7, and 16ARHA7 and this fixup mechanism
> has been verified to work on 16IAH7. As far as is known, several other
> laptop models from ASUS and HP also suffer from this no valid _DSD
> problem and could have it addressed with this fixup mechanism when
> proper fixup entries are inserted.
> 
> Signed-off-by: David Xu <xuwd1@hotmail.com>
> ---
>  sound/pci/hda/cs35l41_hda.c | 160 
> ++++++++++++++++++++++++++++++++++++
>  1 file changed, 160 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
> index ce5faa620517..d957458dd4e6 100644
> --- a/sound/pci/hda/cs35l41_hda.c
> +++ b/sound/pci/hda/cs35l41_hda.c
> @@ -1211,6 +1211,159 @@ static int cs35l41_get_speaker_id(struct 
> device *dev, int amp_index,
>  	return speaker_id;
>  }
> 
> +#define CS35L41_FIXUP_CFG_MAX_DEVICES 4
> +
> +struct cs35l41_fixup_cfg {
> +	unsigned short vender;
> +	unsigned short device;
> +	unsigned int num_device;  /* The num of cs35l41 instances */
> +	/* cs35l41 instance ids, can be i2c index or spi index */
> +	int ids[CS35L41_FIXUP_CFG_MAX_DEVICES];
> +	unsigned int reset_gpio_idx[CS35L41_FIXUP_CFG_MAX_DEVICES];
> +	enum gpiod_flags reset_gpio_flags[CS35L41_FIXUP_CFG_MAX_DEVICES];
> +	int spkid_gpio_idx[CS35L41_FIXUP_CFG_MAX_DEVICES];
> +	unsigned int spk_pos[CS35L41_FIXUP_CFG_MAX_DEVICES];
> +	enum cs35l41_hda_gpio_function 
> gpio1_func[CS35L41_FIXUP_CFG_MAX_DEVICES];
> +	enum cs35l41_hda_gpio_function 
> gpio2_func[CS35L41_FIXUP_CFG_MAX_DEVICES];
> +	enum cs35l41_boost_type bst_type[CS35L41_FIXUP_CFG_MAX_DEVICES];
> +};
> +
> +static const struct cs35l41_fixup_cfg cs35l41_fixup_cfgtbl[] = {
> +	{ // Lenovo Legion Slim 7i 16IAH7
> +	.vender = 0x17aa,
> +	.device = 0x386e,
> +	.num_device = 2,
> +	.ids = {0x40, 0x41},
> +	.reset_gpio_idx = {0, 0},
> +	.reset_gpio_flags = {GPIOD_OUT_LOW, GPIOD_OUT_LOW},
> +	.spkid_gpio_idx = {1, 1},
> +	.spk_pos = {0, 1},
> +	.gpio1_func = {CS35l41_VSPK_SWITCH, CS35l41_VSPK_SWITCH},
> +	.gpio2_func = {CS35L41_INTERRUPT, CS35L41_NOT_USED},
> +	.bst_type = {CS35L41_EXT_BOOST, CS35L41_EXT_BOOST}
> +	},
> +	{ // Lenovo Legion Slim 7i 16IAH7 type2
> +	.vender = 0x17aa,
> +	.device = 0x3803,
> +	.num_device = 2,
> +	.ids = {0x40, 0x41},
> +	.reset_gpio_idx = {0, 0},
> +	.reset_gpio_flags = {GPIOD_OUT_LOW, GPIOD_OUT_LOW},
> +	.spkid_gpio_idx = {1, 1},
> +	.spk_pos = {0, 1},
> +	.gpio1_func = {CS35l41_VSPK_SWITCH, CS35l41_VSPK_SWITCH},
> +	.gpio2_func = {CS35L41_INTERRUPT, CS35L41_NOT_USED},
> +	.bst_type = {CS35L41_EXT_BOOST, CS35L41_EXT_BOOST}
> +	},
> +	{ // Lenovo Legion 7i 16IAX7
> +	.vender = 0x17aa,
> +	.device = 0x3874,
> +	.num_device = 2,
> +	.ids = {0x40, 0x41},
> +	.reset_gpio_idx = {0, 0},
> +	.reset_gpio_flags = {GPIOD_OUT_LOW, GPIOD_OUT_LOW},
> +	.spkid_gpio_idx = {1, 1},
> +	.spk_pos = {0, 1},
> +	.gpio1_func = {CS35l41_VSPK_SWITCH, CS35l41_VSPK_SWITCH},
> +	.gpio2_func = {CS35L41_INTERRUPT, CS35L41_INTERRUPT},
> +	.bst_type = {CS35L41_EXT_BOOST, CS35L41_EXT_BOOST}
> +	},
> +	{ // Lenovo Legion 7i 16IAX7 type 2
> +	.vender = 0x17aa,
> +	.device = 0x386f,
> +	.num_device = 2,
> +	.ids = {0x40, 0x41},
> +	.reset_gpio_idx = {0, 0},
> +	.reset_gpio_flags = {GPIOD_OUT_LOW, GPIOD_OUT_LOW},
> +	.spkid_gpio_idx = {1, 1},
> +	.spk_pos = {0, 1},
> +	.gpio1_func = {CS35l41_VSPK_SWITCH, CS35l41_VSPK_SWITCH},
> +	.gpio2_func = {CS35L41_INTERRUPT, CS35L41_INTERRUPT},
> +	.bst_type = {CS35L41_EXT_BOOST, CS35L41_EXT_BOOST}
> +	},
> +	{ // Lenovo Legion Slim 7 16ARHA7
> +	.vender = 0x17aa,
> +	.device = 0x3877,
> +	.num_device = 2,
> +	.ids = {0x40, 0x41},
> +	.reset_gpio_idx = {0, 0},
> +	.reset_gpio_flags = {GPIOD_OUT_LOW, GPIOD_OUT_LOW},
> +	.spkid_gpio_idx = {1, 1},
> +	.spk_pos = {0, 1},
> +	.gpio1_func = {CS35l41_VSPK_SWITCH, CS35l41_VSPK_SWITCH},
> +	.gpio2_func = {CS35L41_INTERRUPT, CS35L41_INTERRUPT},
> +	.bst_type = {CS35L41_EXT_BOOST, CS35L41_EXT_BOOST}
> +	},
> +	{} // terminator
> +};
> +
> +static inline int cs35l41_fixup_get_index(const struct 
> cs35l41_fixup_cfg *fixup, int cs35l41_addr)
> +{
> +	int i;
> +
> +	for (i = 0; i < fixup->num_device; i++) {
> +		if (fixup->ids[i] == cs35l41_addr)
> +			return i;
> +	}
> +	return -ENODEV;
> +}
> +
> +static int apply_cs35l41_fixup_cfg(struct cs35l41_hda *cs35l41,
> +				struct device *physdev,
> +				int cs35l41_addr,
> +				const struct cs35l41_fixup_cfg *fixup_tbl)
> +{
> +	const char *ssid;
> +	unsigned int vendid;
> +	unsigned int devid;
> +	const struct cs35l41_fixup_cfg *cur_fixup;
> +	struct cs35l41_hw_cfg *hw_cfg;
> +	int cs35l41_index;
> +	int ret;
> +	int i;
> +
> +	ssid = cs35l41->acpi_subsystem_id;
> +	ret = sscanf(ssid, "%04x%04x", &vendid, &devid);
> +	if (ret != 2)
> +		return -EINVAL;
> +
> +	hw_cfg = &cs35l41->hw_cfg;
> +	for (cur_fixup = fixup_tbl; cur_fixup->vender; cur_fixup++) {
> +		if (cur_fixup->vender == vendid && cur_fixup->device == devid) {
> +			cs35l41_index = cs35l41_fixup_get_index(cur_fixup, cs35l41_addr);
> +			if (cs35l41_index == -ENODEV)
> +				return -ENODEV;
> +			cs35l41->index = cs35l41_index;
> +			cs35l41->reset_gpio = gpiod_get_index(
> +				physdev,
> +				NULL,
> +				cur_fixup->reset_gpio_idx[cs35l41_index],
> +				cur_fixup->reset_gpio_flags[cs35l41_index]
> +				);
> +			cs35l41->speaker_id = cs35l41_get_speaker_id(physdev,
> +				cs35l41_index,
> +				cur_fixup->num_device,
> +				cur_fixup->spkid_gpio_idx[cs35l41_index]
> +				);
> +			hw_cfg->spk_pos = cur_fixup->spk_pos[cs35l41_index];
> +			cs35l41->channel_index = 0;
> +			for (i = 0; i < cs35l41->index; i++)
> +				if (cur_fixup->spk_pos[i] == hw_cfg->spk_pos)
> +					cs35l41->channel_index++;
> +
> +			hw_cfg->gpio1.func = cur_fixup->gpio1_func[cs35l41_index];
> +			hw_cfg->gpio1.valid = true;
> +			hw_cfg->gpio2.func = cur_fixup->gpio2_func[cs35l41_index];
> +			hw_cfg->gpio2.valid = true;
> +			hw_cfg->bst_type = cur_fixup->bst_type[cs35l41_index];
> +			dev_dbg(physdev, "Fixup applied.\n");
> +			break;
> +		}
> +	}
> +	return 0;
> +
> +}
> +
>  /*
>   * Device CLSA010(0/1) doesn't have _DSD so a gpiod_get by the label 
> reset won't work.
>   * And devices created by serial-multi-instantiate don't have their 
> device struct
> @@ -1221,6 +1374,7 @@ static int cs35l41_get_speaker_id(struct device 
> *dev, int amp_index,
>  static int cs35l41_no_acpi_dsd(struct cs35l41_hda *cs35l41, struct 
> device *physdev, int id,
>  			       const char *hid)
>  {
> +	int ret;

This ret is unused.

>  	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
> 
>  	/* check I2C address to assign the index */
> @@ -1243,7 +1397,13 @@ static int cs35l41_no_acpi_dsd(struct 
> cs35l41_hda *cs35l41, struct device *physd
>  		/*
>  		 * Note: CLSA010(0/1) are special cases which use a slightly 
> different design.
>  		 * All other HIDs e.g. CSC3551 require valid ACPI _DSD properties 
> to be supported.
> +		 * However many OEMs hardcoded the configurations into their 
> proprietary software
> +		 * thus leaving our Linux installation with no speaker sound at 
> all while we see
> +		 * no hope those OEMs would fix it. So we apply a ssid specific 
> fixup to fix it.
>  		 */
> +		if (apply_cs35l41_fixup_cfg(cs35l41, physdev, id, 
> cs35l41_fixup_cfgtbl) == 0)
> +			return 0;
> +
>  		dev_err(cs35l41->dev, "Error: ACPI _DSD Properties are missing for 
> HID %s.\n", hid);
>  		hw_cfg->valid = false;
>  		hw_cfg->gpio1.valid = false;
> --
> 2.41.0
> 

Hi David,

Thank you for working on this, it is something I was considering doing 
myself as there are approximately 56 laptops in the ASUS range, not 
counting the variants, which need similar. Some I2C connected, some SPI 
connected. There is zero chance all the vendors will take action to 
include the correct entries in DSD.

I have tried your patch on an SPI connected Strix G634. As there is a 
lack of detail on some things I am unsure if I got the setup correct. 
And regardless of that there are issues - I don't think I could confirm 
if this worked due to those.

I tried with the patch applied and what I thought was correct setup (in 
driver):
1. without my DSD table additions (in acpi)
2. With the CS part added (in acpi)
3. With my full DSD table added (in acpi)

all 3 instances failed with:

cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: OTP Boot status 80000000 
error: 0
cs35l41-hda: probe of spi1-CSC3551:00-cs35l41-hda.0 failed with error -5

The driver table entry I used was:

+ { // ROG Strix Scar
+ .vender = 0x1043,
+ .device = 0x1caf,
+ .num_device = 2,
+ .ids = {0x00, 0x01},
+ .reset_gpio_idx = {0, 0},
+ .reset_gpio_flags = {GPIOD_OUT_LOW, GPIOD_OUT_LOW},
+ .spkid_gpio_idx = {1, 1},
+ .spk_pos = {0, 1},
+ .gpio1_func = {CS35l41_VSPK_SWITCH, CS35l41_VSPK_SWITCH},
+ .gpio2_func = {CS35L41_INTERRUPT, CS35L41_INTERRUPT},
+ .bst_type = {CS35L41_EXT_BOOST, CS35L41_EXT_BOOST}
+ },

Compared to my ACPI patch:

DefinitionBlock ("", "SSDT", 1, "CUSTOM", "CSC3551", 0x00000001)
{
    External (_SB_.PC00.SPI3, DeviceObj)
    External (_SB_.PC00.SPI3.SPK1, DeviceObj)

    Scope (_SB.PC00.SPI3.SPK1)
    {
        Name (_DSD, Package ()
        {
            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package ()
            {
                Package () { "cirrus,dev-index", Package () { Zero, One 
}},
                Package () { "reset-gpios", Package () {
                    SPK1, One, Zero, Zero,
                    SPK1, One, Zero, Zero
                } },
                Package () { "spk-id-gpios", Package () {
                    SPK1, 0x02, Zero, Zero,
                    SPK1, 0x02, Zero, Zero
                } },
                Package () { "cirrus,speaker-position", Package () { 
Zero, One } },
                // gpioX-func: 0 not used, 1 VPSK_SWITCH, 2: INTERRUPT, 
3: SYNC
                Package () { "cirrus,gpio1-func", Package () { One, One 
} },
                Package () { "cirrus,gpio2-func", Package () { 0x02, 
0x02 } },
                // boost-type: 0 internal, 1 external
                Package () { "cirrus,boost-type", Package () { Zero, 
Zero } }
            }
        })
    }

    Scope (_SB.PC00.SPI3)
    {
        Name (_DSD, Package ()
        {
            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package ()
            {
                Package () { "cs-gpios", Package () {
                    Zero, // Native CS
                    SPK1, Zero, Zero, Zero // GPIO CS
                } }
            }
        })
    }
}


The key thing I am concerned about is how the values for the following 
are gained:
+ .reset_gpio_idx = {0, 0},
+ .reset_gpio_flags = {GPIOD_OUT_LOW, GPIOD_OUT_LOW},
+ .spkid_gpio_idx = {1, 1},

there wasn't much detail provided on this, and I tried multiple 
variations, all ending up with the same errors as before. I will do a 
debug build and get some more info.



Some previous conversation: 
https://lore.kernel.org/all/1991650.PYKUYFuaPT@fedora/



