Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDC97B8C73
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbjJDTNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343544AbjJDTG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:06:59 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B751726A6;
        Wed,  4 Oct 2023 12:01:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B34F73200A66;
        Wed,  4 Oct 2023 15:01:49 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 04 Oct 2023 15:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sunshowers.io;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1696446108; x=
        1696532508; bh=j4BkRX3dHCjU+8qjgW830kXHGywOWcvQEGez1bheQQQ=; b=V
        jreFZabblm+nW/BtsLzRyRIVXzNa6vOE8tGcffuklWy6pchFVS9Inj0ILuSZAAUR
        sFT3H9MLKlwqA00f/kjR+ifWjR5l1R/9sqtCPjM+QWjLushOiH1s0BjGwqV2LPXC
        Hvk59kg7fQCRafB8WEhHWRuV0QhB30fOr+d7ZNxPSwRikhlSy8cLGNxT1iVT4M73
        jnq2AKMKHumcg2/lOb7xYDd7ikKv2oGS9l0vwBCu3aGBWknZzjEP9Q15ld/wzB4C
        0pCjULT0RD4RAyz4zl1L/rmWxymWDq6lK08TdLLwj3pU538F+AGSamSmj4GVYPOy
        L6HhoCkI7b/fgfgTygpMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696446108; x=1696532508; bh=j4BkRX3dHCjU+
        8qjgW830kXHGywOWcvQEGez1bheQQQ=; b=XnCAxX6Zmm0GU2KCT3hB+66+FMhyE
        3mXSh8eYwyxG+puw9+vhXtAT4bP7fnkkX/ClfNo4T/r5uxB2nueOFDPVPm/6VKHZ
        8XVNyMrn7rdIjrLdFmdxqZ9eNM9jl2TJ6Lb22RASadGiA4Z2Exeu2GTHeybDPFLw
        SK42S4ZsDSGoaW4Bh6UTpN55aJ1iIU2eSf8hkoAHBf7bSHTO5Ydu1oYy8SY8PLj0
        CmjRwIIGkrmb/g+cmv6C/GnNpwAWTwqAhwCqhWwaz61xcaRYQX/uluCHkjgnWYy6
        D/cXPTY/Ow5aPdF2UWAUaZiHJ+YvACMg8Np8BaiR9JCvFsl32DFkPfgvg==
X-ME-Sender: <xms:nLYdZXY6KcIIR-u-IE3sr1P526Si7dmDg3FGCu1RCFKNUTtYefkH1A>
    <xme:nLYdZWYE0jZrwefY8C1Li4KFVsmNLMuoaHbx0k1_zM2H866O0snlDjmKyzB0LKdaP
    WqGcQ3CAL4HvRNoM1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgedvgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpeftrghi
    nhcuoehrrghinhesshhunhhshhhofigvrhhsrdhioheqnecuggftrfgrthhtvghrnhepue
    eguefhieejgeffteffkeehjeeijefhudeifedtieevveeghfekgedvgfektefgnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghinhesshhunhhshhhofigvrhhsrdhioh
X-ME-Proxy: <xmx:nLYdZZ_bx4CLT2P-eWCvoj2WOA25WcD2ILaXyaCP_Ewfb1MwrqAmnQ>
    <xmx:nLYdZdrI4AEwbKxrr8dN6V-MxF1lYmomBnDpofPsS_rTbu4XvNMJMg>
    <xmx:nLYdZSolZTLZLw-QO5CzAlZ33VzoT46kOSe6aDvxWyrArcsWAwDnSw>
    <xmx:nLYdZVVDel5eywCGbphSl1qQyO4pxx_bf3zfslLXHYW-NTS0SXyS9w>
Feedback-ID: iaa1146ff:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ECFAC15A0092; Wed,  4 Oct 2023 15:01:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <e0f33dd3-1a35-4c76-889f-a80e42da2ded@app.fastmail.com>
In-Reply-To: <20230917161802.39716-1-sergeantsagara@protonmail.com>
References: <20230917161802.39716-1-sergeantsagara@protonmail.com>
Date:   Wed, 04 Oct 2023 12:01:27 -0700
From:   Rain <rain@sunshowers.io>
To:     "Rahul Rameshbabu" <sergeantsagara@protonmail.com>,
        "Jiri Kosina" <jikos@kernel.org>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
        "Henrik Rydberg" <rydberg@bitmath.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: multitouch: Add required quirk for Synaptics 0xcd7e device
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023, at 09:18, Rahul Rameshbabu wrote:
> Register the Synaptics device as a special multitouch device with certain
> quirks that may improve usability of the touchpad device.
>
> Reported-by: Rain <rain@sunshowers.io>
> Closes: 
> https://lore.kernel.org/linux-input/2bbb8e1d-1793-4df1-810f-cb0137341ff4@app.fastmail.com/
> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
> ---
>
> Notes:
>     Theory:
>    
>       I think the Synaptics device in the related email to the linux-input
>       mailing list requires certain quirks like MT_QUIRK_HOVERING to correctly
>       reconfigure the distance configuration for multitouch events. This might
>       explain why light touches were not registered originally when
>       MT_CLS_DEFAULT was used by default for the device. Would like to have
>       this patch tested before being merged. A Tested-by: git trailer can then
>       be appended.
>
>  drivers/hid/hid-multitouch.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 521b2ffb4244..8db4ae05febc 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -2144,6 +2144,10 @@ static const struct hid_device_id mt_devices[] = {
>  			USB_DEVICE_ID_MTP_STM)},
> 
>  	/* Synaptics devices */
> +	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
> +		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
> +			USB_VENDOR_ID_SYNAPTICS, 0xcd7e) },

Thanks for the patch! I haven't tested it yet but it looks promising.

The vendor ID isn't USB_VENDOR_ID_SYNAPTICS (0x06cb),
however -- it's SYNA7DB5 (0x7db5) which I guess is an alternative vendor
ID for Synaptics. Would be worth fixing that.

> +
>  	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
>  		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
>  			USB_VENDOR_ID_SYNAPTICS, 0xce08) },
> -- 
> 2.40.1

-- 
Rain
(they/she)
