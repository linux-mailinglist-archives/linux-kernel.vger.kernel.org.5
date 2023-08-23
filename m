Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A423B786197
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 22:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbjHWUb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 16:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbjHWUb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 16:31:27 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41C10D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 13:31:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E5E825C0180;
        Wed, 23 Aug 2023 16:31:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 23 Aug 2023 16:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1692822684; x=1692909084; bh=bp
        vvuo87WPjaUR3mEzx98/2E5yu05uhgkK4nIFzL+Lg=; b=fpp9bc9cwdKMTa17T7
        5ERA7o4uaG+f32PAwYLA45n3EGFjxGtLCytBx8A9uHAvaN9Y9PBzetNZtIt+oCp2
        h9MS1nl2SizeZbNXs9fsfk2VGEuFbUxtTYw8PGK18v3pH4M322K4bKobuu/gsbXi
        UA1MjSYO55pY8piRAyk5TMrDkXJzpbCvjog/q/TPsCg4uZQFECRC9w25M1zbJS74
        1dIsBiPeWwcAx8SYU+nWCPAvp4U4qistuPwJcvXIDYB40AZw9q6L05xIFr+vee/2
        iCcwSNh/W/oHvrJCk42Z1/jgy+oG15Gf3IQ6hOmJpLes2qYAjtTv3tQQXewENtzr
        Vm4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692822684; x=1692909084; bh=bpvvuo87WPjaU
        R3mEzx98/2E5yu05uhgkK4nIFzL+Lg=; b=fo4Z936gDZOi0ky+GW2SVGIFHa9Xv
        gL+afwqjFU3mQt1XLzf7GK9klCWSwXlIRE5QSRYNW2vHDk6wsHs/WFwUqaXY38Hz
        077ZC+di9iuC4fXp7uuVCyIFQSAodsn0mX9KkjZnr8OS7I1Bvp4EGtz0sTsKxM17
        qT77Xd5QnDSo/IvYM67Sl1tF9hxFyx5eiH0JsiBcIMb5tytaCRfo8TuA50CCRhm9
        1ZZdVcnGJSWbcLrmj0SK5unOMBn6aOxCLOCoqWVm7CatVxAe94ZuwKzt/GxyQlZT
        /NehvLblzmoX2Z8Qpn+nxmLR6I9Wbuxb/ZNtN2Am1Vp71fPCdFXAEoTIQ==
X-ME-Sender: <xms:nGzmZAA5nrr0NUluO2uT38D3o183p1hdvagG46sdjEgAWp1SSzSxxg>
    <xme:nGzmZChhinDzAmHXLGTeUPgeMQQ2Oc0grSWrsri7BoHwKAkRdTFm0dTxhydaniIV7
    lee6U35bfJ56ekeWqw>
X-ME-Received: <xmr:nGzmZDmmdXa6ZVoACIL3poURBnjhtmdp4aLFq3dFMYQpJ9D6JHh2UqrPZ5tOfw_On4HTnsao>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpedvvdegledtheefieejgfevgeefiefhtdevteefteduhfevtdefleethfetgeeluden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:nGzmZGxo3hK8pjCziBIpahW6ZOxcmnX-mA_dabxE752gb5n6zzuuwg>
    <xmx:nGzmZFRCVwLRtKFQleznWpI7mBm_jLgjCY5qHF5BGitroukDkXbNmw>
    <xmx:nGzmZBZSFeMa6diVfpJ1UcShkCpIUdvWjKxzB-wuk1ODvjthJZwaAA>
    <xmx:nGzmZEHeCx7NF3ySFFbb4RKi8iBGCjhd0NroCYrglvSIV-G8bvR3qw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 16:31:19 -0400 (EDT)
Date:   Thu, 24 Aug 2023 08:31:06 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: RE: [PATCH] ALSA: hda: cs35l41: Support ASUS 2023 laptops with
 missing DSD
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     'Takashi Iwai' <tiwai@suse.de>, tiwai@suse.com,
        james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        'Jonathan LoBue' <jlobue10@gmail.com>,
        patches@opensource.cirrus.com
Message-Id: <UB2VZR.B7HP6HUMGFA03@ljones.dev>
In-Reply-To: <000601d9d5b0$8d6817f0$a83847d0$@opensource.cirrus.com>
References: <20230823011008.13146-1-luke@ljones.dev>
        <87v8d6cm30.wl-tiwai@suse.de> <R32UZR.6AQKQL1J6UQI3@ljones.dev>
        <87lee2ciqj.wl-tiwai@suse.de> <NN3UZR.VNYA824H66Q8@ljones.dev>
        <87il96cfnb.wl-tiwai@suse.de>
        <000601d9d5b0$8d6817f0$a83847d0$@opensource.cirrus.com>
X-Mailer: geary/44.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> The second member variable in cs35l41_prop_model_table is the SSID to
> match against.
> The Lenovo laptops in the initial patch didn't have different SSIDs so
> the entry was set to NULL for those.
> Future entries using CSC3551 MUST always have an accompanying SSID
> with this entry.
> Takashi was correct, the implementation is intended to also be used to
> patch incorrect DSD.
> 
> We have a potential solution to workaround the SPI cs-gpios issue
> inside here,
> though the drawback for that is that it only works for laptops with 2
> SPI amps.

Can you provide me this so I can test? I have laptops with SPI 2 and 4 
speaker setups.

> I also took a look at the function for applying DSD properties for the
> 2023 ROG laptops.
> Unfortunately the one-size-fits-all approach will not work, some of
> these laptops are i2c
> and some are SPI, meaning the GPIO indexes are different for different
> laptops.

Do you mean "spk-id-gpios"? For all the laptops I know of this seems to 
be
Package () { "spk-id-gpios", Package () {
    SPK1, 0x02, Zero, Zero,
    SPK1, 0x02, Zero, Zero
} },

There is one laptop where it is One not 0x02 (the GA402N)

> Some of the laptops do no have Speaker IDs.
> Also, no laptop other than the 2 I added already should ever use
> CS35L41_EXT_BOOST_NO_VSPK_SWITCH (in fact I believe all these laptops
> are internal
> boost anyway).

Grazie.

> 
> We are currently working internally on adding support for the 2023 ROG
> laptops, so we
> ask for you guys to hold off on trying to upstream support for these
> laptops.

Ah great. Thank you. I apologise for trying to rush things, but I do 
have a discord server of over 4000 people, many of whom have laptops 
with cirrus amps.

For now I'm including a patch in my kernel builds with this mapping:

const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
	{ "CSC3551", "10431433", asus_rog_2023_no_acpi }, // ASUS GS650P - i2c
	{ "CSC3551", "10431463", asus_rog_2023_no_acpi }, // ASUS GA402X - i2c
	{ "CSC3551", "10431473", asus_rog_2023_no_acpi }, // ASUS GU604V - spi
	{ "CSC3551", "10431483", asus_rog_2023_no_acpi }, // ASUS GU603V - spi
	{ "CSC3551", "10431493", asus_rog_2023_no_acpi }, // ASUS GV601V - spi
	{ "CSC3551", "10431573", asus_rog_2023_no_acpi }, // ASUS GZ301V - spi
	{ "CSC3551", "104317F3", asus_rog_2023_no_acpi }, // ASUS ROG ALLY - 
i2c
	{ "CSC3551", "10431B93", asus_rog_2023_no_acpi }, // ASUS G614J - spi
	{ "CSC3551", "10431CAF", asus_rog_2023_no_acpi }, // ASUS G634J - spi
	{ "CSC3551", "10431C9F", asus_rog_2023_no_acpi }, // ASUS G614JI -spi
	{ "CSC3551", "10431D1F", asus_rog_2023_no_acpi }, // ASUS G713P - i2c
	{ "CSC3551", "10431F1F", asus_rog_2023_no_acpi }, // ASUS H7604JV - spi
	{}
};

These are the machines I have verified the gpios and such for.

Cheers,
Luke.



