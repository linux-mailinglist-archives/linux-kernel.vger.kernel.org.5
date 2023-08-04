Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF3B770253
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjHDNwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjHDNwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:52:31 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC60359A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:52:03 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BF8D55C00E1;
        Fri,  4 Aug 2023 09:52:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 04 Aug 2023 09:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691157122; x=1691243522; bh=Jg
        vZReq8iA61Z8KtPmrQBU08Y+PuLT1WsYNUvHwPkig=; b=gnNyr/VHGMyKvVdG8U
        2n64QMQHuKkNaVU3KgsJbGKrpsRZnzzHuV3IqA0RVRHi/A4qU8VMs8wjhkYAIrRa
        y6za+vQ8TE5831Pu+5GtezcheGpQ6qThqtmsgQdx+7ccqYn1xTnZQ01I06KuHaxI
        4X88tWPWBbXE2Kg+0VA5szENrukAQlInTPh7WExBxQvTDweSIk5FHxT4UBV7eQ2I
        k+I640+wR85Hh86OHyICncixcfxD0gWTX/OTe2IcS8E38if9M+No1IN7ob6ipx6Q
        plzUsSsgqu634xnQsg2Ft7ksEeP8TdCxZS2L/2RzqpoEjRGbFZ2Z4a/MmASchNfE
        BpdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691157122; x=1691243522; bh=JgvZReq8iA61Z
        8KtPmrQBU08Y+PuLT1WsYNUvHwPkig=; b=HJWo7XBel1KSJBh2EAT06ZgpI4uDa
        p7xVArK5PNJPE0j6WYNxMXBScbOS9herC2DUzpfkk58QaHllYP86+KBLE+4KYGq1
        dpYUEGQ9UUakti9A7UnqPuT7d2gP1F1/0jhKanFOMBlg/RrN3jJr0xMh5BbjVjBu
        In50Mt2HwKT/scFR2bK4FtQBGA5IPCbpysOZtbD6trYoS/k/ebjJIn5KynuUCmSl
        XdriZWqqU0J90EZ2mxgXi7sx5QrthVH4SO7ocAvABT1EIrUluWCLX9sfJA2ILHyf
        VxH6UPOEDbJuiDigxuqveW/qAXfMNaez679Rff66mTcYHIUBZEeigIpBA==
X-ME-Sender: <xms:gQLNZCK92PalC2e179ZqXi83ty5f6oKYT-HYVV0EUaq5XrMFzfuM8w>
    <xme:gQLNZKIvg_OlAcmHxqoXhwXxhAVkSM0kRBmrziSu2Ed9u8htzaN52izdXvbbXLQty
    zOEJ5W7204g0G4y_M0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:gQLNZCssX-i8VJtmt7i66ltEhvEWMdIikyl-hxcLpedJqSaxsGfHJg>
    <xmx:gQLNZHbcu7h50EY1vRQx1C7BzJ0G8qmMRZUIS9hzZ_g2_Wvj0-rstw>
    <xmx:gQLNZJamGj3gxS4CVqJRkabsaexq416S0sAG6Co3yvUSjMEI6wFHag>
    <xmx:ggLNZHN1rRlYyb7InlmRLVtJG-GHfLeDl8Xs855KLtjrebEo2tH92A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D7163B60089; Fri,  4 Aug 2023 09:52:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <19a2a2a0-2f35-4c4e-926c-47b75e6f9353@app.fastmail.com>
In-Reply-To: <CAKMK7uH=7m=2Y0SxPm2Q1J+u2MRWHNQrYy7M5se7Ua9ZA19y=A@mail.gmail.com>
References: <20230804125156.1387542-1-javierm@redhat.com>
 <CAKMK7uH=7m=2Y0SxPm2Q1J+u2MRWHNQrYy7M5se7Ua9ZA19y=A@mail.gmail.com>
Date:   Fri, 04 Aug 2023 15:51:40 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Daniel Vetter" <daniel@ffwll.ch>,
        "Javier Martinez Canillas" <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Arthur Grillo" <arthurgrillo@riseup.net>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Dave Airlie" <airlied@gmail.com>, "Helge Deller" <deller@gmx.de>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Drop select FRAMEBUFFER_CONSOLE for DRM_FBDEV_EMULATION
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023, at 15:07, Daniel Vetter wrote:
> On Fri, 4 Aug 2023 at 14:52, Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> The commit c242f48433e7 ("drm: Make FB_CORE to be selected if DRM fbdev
>> emulation is enabled") changed DRM_FBDEV_EMULATION from 'depends on FB'
>> to an effective 'select FB_CORE', so any config that previously had DRM=y
>> and FB=n now has FB_CORE=y and FRAMEBUFFER_CONSOLE=y.
>>
>> This leads to unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
>> as reported by Arthur Grillo, e.g:
>>
>> WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
>>   Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
>>   Selected by [y]:
>>   - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]
>>
>> Arnd Bergmann suggests to drop the select FRAMEBUFFER_CONSOLE for the
>> DRM_FBDEV_EMULATION Kconfig symbol, since a possible use case could
>> be to enable DRM fbdev emulation but without a framebuffer console.
>>
>> Fixes: c242f48433e7 ("drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled")
>> Reported-by: Arthur Grillo <arthurgrillo@riseup.net>
>> Closes: https://lore.kernel.org/dri-devel/20230726220325.278976-1-arthurgrillo@riseup.net
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Yeah originally this was just to help people not misconfigure their
> kernels and end up with a black screen. But select is really not a
> nice way to do that, imo we could drop the FB_CORE select too :-)

Droping the 'FB_CORE' select only works if we make FB_CORE user
visible and add a 'depends on' for it instead. Not sure this
is any better since this would only ever be used when either
CONFIG_FB or CONFIG_DRM_FBDEV_EMULATION is enabled.


     Arnd
