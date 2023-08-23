Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F6B784E17
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 03:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjHWBSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 21:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjHWBST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 21:18:19 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FDBE4C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:18:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id EEFA85C023C;
        Tue, 22 Aug 2023 21:18:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 22 Aug 2023 21:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1692753496; x=1692839896; bh=VN
        W/Q5VnePq5xhS52gG+uI2qhErf3EnANCpUreONCho=; b=DwYOzlP9ev5kGmhRbm
        R7XKrD+maGaD5VgE+1b5RzYJb1IypkpCymN0gjSD1PXY3slsw3DApA3h3nB4oiok
        UMXZoEOCgC2IclEWERIFA++Zds6q2QuHGes2xhXUk2w3jjLySsdFWhSKCANuqrt+
        eitu0PuXEqa6Vhui8UbTlBdBU1wmvW+Ru+mpQu1Hk4wUFsORSBvYzGQFnWsSWLMO
        rg0CUTZQsfNmNoBmmDoUf7pPeDfzN9GdYwQSnGk/am5s+9qwpTATo/Q+de/bBqSq
        +GX5Uu3NnoCpnuj/fpzDZq4gKN1w+NAHI16qUdCjzTe+dKD7O3yulHMfIGKVNgwx
        q3zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692753496; x=1692839896; bh=VNW/Q5VnePq5x
        hS52gG+uI2qhErf3EnANCpUreONCho=; b=zyh8a6qm/6pI2zX8WNMRd3/yNv0YL
        /PIvJsTzBGxvgrRPhJL/TmGmmLS/h1YNwzqGln+n0lGjIk/5S8lSK0b6TRgGqi6j
        F1qjE2eNU7e48UgB830+Qy9TMANoMit349dGC8KNIwoUqdna5blJ997BqV4BAfgj
        g9t+2qqj2jcJ1OJwBKZa6zFafsDE0F3OuPtKtX4vAT90KJ10PUFS3dj/wxMu9sxk
        qrcLrYqa6JJys+kFZIh+Qze6i+FyxwdHF2ksa69MBQGpJpTJjrHBd2tqKPI3K2hj
        zpDy6FNITLGaqbzlxjXyXYdTNTNhYKR0OmN4Ct3O579Yi0+wa7sbV7YkQ==
X-ME-Sender: <xms:WF7lZJNQehP3xpa_ht7M4G7wP7rNRoAuu7LFLWTF6MrLYPNf7rI0sA>
    <xme:WF7lZL988jin17cI_PS3w6JFj1Etk8YRFCydl1SQ0Af9aKlfLs7_jF5Oma9NbN6PG
    WHIQDod9YUaxeYRqQw>
X-ME-Received: <xmr:WF7lZIQPx7TbYJDp8CkY1cbxv1iyDIdYWyoMt3sX0yCYUCzjxC5u_Es8pK_gzQId-qdmU7bX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:WF7lZFufRdu0yFBYfbM5p4tSQPrmu8wxCVBA0iWtYGHwig-P_6piZA>
    <xmx:WF7lZBdg-PcWg2YVHTcQ-xYfUp4hl_M_0PHOKipSdSwdShAxiQWzdQ>
    <xmx:WF7lZB0wMMMQGpqR-wf2NnFjr11HNeZkPynAj3hICqKBoHsBodmHRA>
    <xmx:WF7lZI6nl3P9spVZVnljIfaAhPP9NmPjYVNni5y04hUeTVqOaGob8w>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 21:18:12 -0400 (EDT)
Date:   Wed, 23 Aug 2023 13:18:01 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] ALSA: hda: cs35l41: Support ASUS 2023 laptops with
 missing DSD
To:     tiwai@suse.com
Cc:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        sbinding@opensource.cirrus.com, Jonathan LoBue <jlobue10@gmail.com>
Message-Id: <1YKTZR.WLJAL07F7FT02@ljones.dev>
In-Reply-To: <20230823011008.13146-1-luke@ljones.dev>
References: <20230823011008.13146-1-luke@ljones.dev>
X-Mailer: geary/44.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Aug 23 2023 at 13:10:08 +12:00:00, Luke D. Jones 
<luke@ljones.dev> wrote:
> Support adding the missing DSD properties required  for ASUS ROG 2023
> laptops and other ASUS laptops to properly utilise the cs35l41.
> 
> This support includes both I2C and SPI connected amps.
> 
> The SPI connected amps may be required to use an external DSD patch
> to fix or add the "cs-gpios" property.
> 
> Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>
> Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> Co-developed-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  sound/pci/hda/cs35l41_hda_property.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l41_hda_property.c 
> b/sound/pci/hda/cs35l41_hda_property.c
> index 673f23257a09..69879ab57918 100644
> --- a/sound/pci/hda/cs35l41_hda_property.c
> +++ b/sound/pci/hda/cs35l41_hda_property.c
> @@ -43,6 +43,31 @@ static int lenovo_legion_no_acpi(struct 
> cs35l41_hda *cs35l41, struct device *phy
>  	return 0;
>  }
> 
> +/*
> + * The CSC3551 is used in almost the entire ASUS ROG laptop range in 
> 2023, this is likely to
> + * also include many non ROG labelled laptops. It is also used with 
> either I2C connection or
> + * SPI connection. The SPI connected versions may be missing a chip 
> select GPIO and require
> + * an DSD table patch.
> + */
> +static int asus_rog_2023_no_acpi(struct cs35l41_hda *cs35l41, struct 
> device *physdev, int id,
> +				const char *hid)
> +{
> +	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
> +
> +	/* check SPI or I2C address to assign the index */
> +	cs35l41->index = (id == 0 || id == 0x40) ? 0 : 1;
> +	cs35l41->channel_index = 0;
> +	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, 
> GPIOD_OUT_HIGH);
> +	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, 0, 0, 2);
> +	hw_cfg->spk_pos = cs35l41->index;
> +	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
> +	hw_cfg->gpio2.valid = true;
> +	hw_cfg->bst_type = CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
> +	hw_cfg->valid = true;
> +
> +	return 0;
> +}
> +
>  struct cs35l41_prop_model {
>  	const char *hid;
>  	const char *ssid;
> @@ -53,6 +78,7 @@ struct cs35l41_prop_model {
>  const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
>  	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
>  	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
> +	{ "CSC3551", NULL, asus_rog_2023_no_acpi },
>  	{}
>  };
> 
> --
> 2.41.0

Although this does work for SPI connected amps, it still requires the 
chipselect DSD patch:

DefinitionBlock ("", "SSDT", 1, "CUSTOM", "CSC3551", 0x00000001)
{
    External (_SB_.PC00.SPI3, DeviceObj)
    External (_SB_.PC00.SPI3.SPK1, DeviceObj)

    Scope (_SB.PC00.SPI3)
    {
        Name (_DSD, Package ()
        {
            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package ()
            {
                Package () { "cs-gpios", Package () { Zero, SPK1, Zero, 
Zero, Zero } }
            }
        })
    }
}

I am unsure what to do about this and any advice would be appreciated.

Cheers,
Luke.


