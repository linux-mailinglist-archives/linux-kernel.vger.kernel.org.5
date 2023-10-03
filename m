Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224597B6C00
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbjJCOqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbjJCOqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:46:09 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0A0B0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:46:03 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DE2AC5C0358;
        Tue,  3 Oct 2023 10:46:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 03 Oct 2023 10:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1696344362; x=1696430762; bh=cf
        Lg0FTt870s90m6D5NuIv5XQXp/nmAmNe4tSouovjA=; b=eZGA4ngRNhIErLzsV+
        HXf0v/3NAWge7/pxxpnYxZPncEJo/AQHoE6kDY1hGgtiy+AeDHg+6D4XvG4sQF0/
        t812v+As9dan2YmvlfE1dlEeJG1KMfufOsBPc+0xTVddG69V/hhOn6hZysFk9ndv
        dkmGjuzeWJCj1UChoGXuocv1xuuJ4wKx34e41qVHEecCLtqOLcDCyvGX8i6q7GD7
        y8O1F78DM/ePjldP3mxUDJYS4fWCpKcgUfTk+7PKpDxYSTwo20xX34NXGBCnmEM6
        fjEy0rWGAlUXA2+d7oyKjQ9G3jKk9IeMctt3uv6jklEOc3pPbn9GybTYulZKpehV
        p/zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696344362; x=1696430762; bh=cfLg0FTt870s9
        0m6D5NuIv5XQXp/nmAmNe4tSouovjA=; b=EHEfnzl8tlq/P4QeGBl5+lJnwmOAm
        LaMc4FAXeSOADDplXL2nGQWraiko89Gq3BNVX5E/xZd1NKLRmp72U+M+XTjfbYnY
        eng1tnSOGTKDmuV0GRJfRTHROHwKVp8Yk/UrJM9oXe6euREwVhNaMYDhO8m7Um34
        1DiD0vlHC5k1E0Buii5WjEO6n3girOGj0H7Gfaoso0xleD4SI3Cb0PI5ZG/yM2gN
        o9mwejAaM5X5Hfn4vbjNP5Mv3xM4etDWmEkkvK1aVPEGnVcNzxn1cW6R1uz286Md
        qOGf1hfy0SOW8GkaGj7TP+IHgX+dS118qBsf5BB90tI9A6C0D8j0D0rEA==
X-ME-Sender: <xms:KikcZZaUPbgMW3l1fSp6PaOxllXetWT42hLV4ZvIyACbOUBBVNacHQ>
    <xme:KikcZQYk9Rsofd-97HwDugbcVdAyC2hM1Oom8rwee4ua7ERA2JHAwqA2zhASTSb6_
    Qw0a3oliDjg-KzNWxo>
X-ME-Received: <xmr:KikcZb8SpoaMRye3HGk_jOrcEyX2yoxb_1gRHhkf0FyYJ13aXkvQ3lVNduSQNdnFcyYtlS_LOOvNJtdmAzJjq94BRfNWepD0q2MPxF2fFDIK9VTYW5m09fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeeigdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhkvgcu
    lfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpe
    dvvdegledtheefieejgfevgeefiefhtdevteefteduhfevtdefleethfetgeeludenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslh
    hjohhnvghsrdguvghv
X-ME-Proxy: <xmx:KikcZXoBhbifQpMtTpbXxWPGDs4rlfuZeo8jnj26pxfKb-W5-iNxKQ>
    <xmx:KikcZUoBsXRqJiaVBZPF6HGMqZYJF0-AqfVBHX8BlwJRZz17R36dRQ>
    <xmx:KikcZdSkpJPNrUWGMIzhsS1YuvM6FVSfnkzZtSKdXZyxfNBGHkRpxg>
    <xmx:KikcZVdLMYKUORhWJYv-lz9rGU4q5CYeHfw_crK6WnEG17H1VQ3ikw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Oct 2023 10:45:57 -0400 (EDT)
Date:   Tue, 03 Oct 2023 16:45:44 +0200
From:   Luke Jones <luke@ljones.dev>
Subject: RE: [PATCH] ALSA: hda: cs35l41: Support ASUS 2023 laptops with
 missing DSD
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     'Takashi Iwai' <tiwai@suse.de>, tiwai@suse.com,
        james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        'Jonathan LoBue' <jlobue10@gmail.com>,
        patches@opensource.cirrus.com
Message-Id: <8OJY1S.X7HJ24U4D5AG2@ljones.dev>
In-Reply-To: <UB2VZR.B7HP6HUMGFA03@ljones.dev>
References: <20230823011008.13146-1-luke@ljones.dev>
        <87v8d6cm30.wl-tiwai@suse.de> <R32UZR.6AQKQL1J6UQI3@ljones.dev>
        <87lee2ciqj.wl-tiwai@suse.de> <NN3UZR.VNYA824H66Q8@ljones.dev>
        <87il96cfnb.wl-tiwai@suse.de>
        <000601d9d5b0$8d6817f0$a83847d0$@opensource.cirrus.com>
        <UB2VZR.B7HP6HUMGFA03@ljones.dev>
X-Mailer: geary/44.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Aug 24 2023 at 08:31:06 AM +12:00:00, Luke Jones 
<luke@ljones.dev> wrote:
> 
>> 
>> The second member variable in cs35l41_prop_model_table is the SSID to
>> match against.
>> The Lenovo laptops in the initial patch didn't have different SSIDs 
>> so
>> the entry was set to NULL for those.
>> Future entries using CSC3551 MUST always have an accompanying SSID
>> with this entry.
>> Takashi was correct, the implementation is intended to also be used 
>> to
>> patch incorrect DSD.
>> 
>> We have a potential solution to workaround the SPI cs-gpios issue
>> inside here,
>> though the drawback for that is that it only works for laptops with 2
>> SPI amps.
> 
> Can you provide me this so I can test? I have laptops with SPI 2 and 
> 4 speaker setups.

Hi Stefan,

Do you have any further information about the status of this in regards 
to the 2023 laptops?

> 
>> I also took a look at the function for applying DSD properties for 
>> the
>> 2023 ROG laptops.
>> Unfortunately the one-size-fits-all approach will not work, some of
>> these laptops are i2c
>> and some are SPI, meaning the GPIO indexes are different for 
>> different
>> laptops.
> 
> Do you mean "spk-id-gpios"? For all the laptops I know of this seems 
> to be
> Package () { "spk-id-gpios", Package () {
>    SPK1, 0x02, Zero, Zero,
>    SPK1, 0x02, Zero, Zero
> } },
> 
> There is one laptop where it is One not 0x02 (the GA402N)
> 
>> Some of the laptops do no have Speaker IDs.
>> Also, no laptop other than the 2 I added already should ever use
>> CS35L41_EXT_BOOST_NO_VSPK_SWITCH (in fact I believe all these laptops
>> are internal
>> boost anyway).
> 
> Grazie.
> 
>> 
>> We are currently working internally on adding support for the 2023 
>> ROG
>> laptops, so we
>> ask for you guys to hold off on trying to upstream support for these
>> laptops.
> 
> Ah great. Thank you. I apologise for trying to rush things, but I do 
> have a discord server of over 4000 people, many of whom have laptops 
> with cirrus amps.
> 
> For now I'm including a patch in my kernel builds with this mapping:
> 
> const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
> 	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
> 	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
> 	{ "CSC3551", "10431433", asus_rog_2023_no_acpi }, // ASUS GS650P - 
> i2c
> 	{ "CSC3551", "10431463", asus_rog_2023_no_acpi }, // ASUS GA402X - 
> i2c
> 	{ "CSC3551", "10431473", asus_rog_2023_no_acpi }, // ASUS GU604V - 
> spi
> 	{ "CSC3551", "10431483", asus_rog_2023_no_acpi }, // ASUS GU603V - 
> spi
> 	{ "CSC3551", "10431493", asus_rog_2023_no_acpi }, // ASUS GV601V - 
> spi
> 	{ "CSC3551", "10431573", asus_rog_2023_no_acpi }, // ASUS GZ301V - 
> spi
> 	{ "CSC3551", "104317F3", asus_rog_2023_no_acpi }, // ASUS ROG ALLY - 
> i2c
> 	{ "CSC3551", "10431B93", asus_rog_2023_no_acpi }, // ASUS G614J - spi
> 	{ "CSC3551", "10431CAF", asus_rog_2023_no_acpi }, // ASUS G634J - spi
> 	{ "CSC3551", "10431C9F", asus_rog_2023_no_acpi }, // ASUS G614JI -spi
> 	{ "CSC3551", "10431D1F", asus_rog_2023_no_acpi }, // ASUS G713P - i2c
> 	{ "CSC3551", "10431F1F", asus_rog_2023_no_acpi }, // ASUS H7604JV - 
> spi
> 	{}
> };
> 
> These are the machines I have verified the gpios and such for.

I have a new version of this patch with all listed models confirmed as 
working, and with slightly different settings for some. The only thing 
missing in a solution to the gpio-cs issue.

Can you please provide an update on where you are with ASUS support in 
particular so that I may consider if it is worth my time submitting the 
updated patch.

> 
> Cheers,
> Luke.
> 
> 


