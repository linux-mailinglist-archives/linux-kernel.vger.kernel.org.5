Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F2F7585A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjGRThx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGRThw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:37:52 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8665198D;
        Tue, 18 Jul 2023 12:37:50 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 412425C009C;
        Tue, 18 Jul 2023 15:37:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 18 Jul 2023 15:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689709070; x=1689795470; bh=Rc
        zCcf9Hl17qyDiEBemLiNE/Pce6mEAljFrZ2lCvbC0=; b=M7K52bw79z22/KPj/2
        27O76o/wL+8cEWlz5YixmLrXIkx+C7JpNarPzKmSDxnU1L83fSzznbovSh3roXAn
        fORMW4xsJrKTaPP6HYEZZ4DENH9MEA4zkpxE+VadkOO9p2X7t+wBFY5AiLfBpmG7
        pz0nU5GYSqM8FoCySAnr4+pvCerxhORqx94gTvDVifAZs+Rx3KsH6bYMuAplmoOt
        PJdcoAOkKahSBBZNhOOPm2wmxpltw++SJNl64RHx9r8tBpqiOkSjp3TWWLgbYRRQ
        YOHKMuYiLTFX0mHCUChmXozQ2Gny9mhwFr6sImZOaiCERHZ0goaRqnvlZ9zMesus
        8A5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689709070; x=1689795470; bh=RczCcf9Hl17qy
        DiEBemLiNE/Pce6mEAljFrZ2lCvbC0=; b=lmGtz+G93qFrWfnnhRLMNeZEKoRIG
        JF0sX6/+/cDYQQqXoOGlvH2oqNKyY14skzw9HO/N5gq+QXEXeNXfyt6hgFGlxFeO
        9uqNsfRlIMROPOdH4unUHy7AGYS3U5v4pKnUg21x5f5iWHYhUrACaQdhsi/01Ulu
        D5yMMiXgDM9Cga1uOsSR87N8q7s8FspMAqc+mHhBkwdYHJu1bgeUR6kl+qMEKkSG
        x/Pyl7NBaU7K+waUXOyqTbK/7DVa3IOZnudUc9zj7hSjlJ3YJ2P9cWtQCKI9QwTX
        PWwG5RvYLEqNMnu4n7U1uUyKcFOKRkpDjDwQHFxvz0xzlO53yqtPjbJ6w==
X-ME-Sender: <xms:Deq2ZEd8Atc0p5n_ZcQE7TqfZ4H6Oa3KPlZnxh85MuxVUK84Q8awfA>
    <xme:Deq2ZGPQIDM5Wm5FlmI939-v2n0d7I_2RShdUH0zJjmq-slyc6ZA_udA4QyCi4hZR
    4sAbtGl2HpYVGqYBjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggddufeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepkedugfegvdfggefffeefvdfflefgleduhfeufeejieevkedtveefheejffek
    heevnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdgu
    vg
X-ME-Proxy: <xmx:Deq2ZFgE1ixY_j6rhvVjo9_Su4VjsSU7gut8tT7DReFgFaAzq7Zw8w>
    <xmx:Deq2ZJ9VCvViZ6EStleSkgM5NtEO6Bj8n0dU-obCiSNKmTDDjJRK4g>
    <xmx:Deq2ZAsTK6vG03AyOdPgx8BLBQRkAqkXcNRczXAL1ammK5_VJwOSQw>
    <xmx:Duq2ZA0XeDH5NrsoKxXo-NS92CqAYAtqQ1C0ECkUIcgjnELf4j-P1A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AA293B60086; Tue, 18 Jul 2023 15:37:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <24a36694-6813-47fd-ab30-b939a81935e7@app.fastmail.com>
In-Reply-To: <20230714171642.91185-1-javierm@redhat.com>
References: <20230714171642.91185-1-javierm@redhat.com>
Date:   Tue, 18 Jul 2023 21:37:28 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Javier Martinez Canillas" <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Daniel Thompson" <daniel.thompson@linaro.org>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Dave Airlie" <airlied@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, "Helge Deller" <deller@gmx.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Jacek Lawrynowicz" <jacek.lawrynowicz@linux.intel.com>,
        "Jingoo Han" <jingoohan1@gmail.com>, "Lee Jones" <lee@kernel.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Melissa Wen" <mwen@igalia.com>,
        "Nipun Gupta" <nipun.gupta@amd.com>,
        "Oded Gabbay" <ogabbay@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v5 0/4] Allow disabling all native fbdev drivers and only keeping
 DRM emulation
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023, at 19:16, Javier Martinez Canillas wrote:
> This patch series splits the fbdev core support in two different Kconfig
> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
> be disabled, while still having the the core fbdev support needed for the
> CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
> disabling all fbdev drivers instead of having to be disabled individually.
>
> The reason for doing this is that now with simpledrm, there's no need for
> the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
> now disable them. But it would simplify the config a lot fo have a single
> Kconfig symbol to disable all fbdev drivers.
>
> I've built tested with possible combinations of CONFIG_FB, CONFIG_FB_CORE,
> CONFIG_DRM_FBDEV_EMULATION and CONFIG_FB_DEVICE symbols set to 'y' or 'n'.
>
> Patch #1 moves the auxdisplay drivers to "Graphics support" Kconfig menu,
> patch #2 moves the core fbdev Kconfig symbols to a separate Kconfig file,
> patch #3 does the FB symbol split and introduces the FB_CORE symbol and
> finally patch #4 makes the DRM symbol to select FB_CORE if the DRM fbdev
> emualtion support was enabled.
>
> Since this series touches three subsystems (auxdisplay, fbdev and DRM),
> I would like to merge it through DRM with the acks of these maintainers.
>
> This is a v5 of the patch-set that addresses issues pointed out by Arnd
> Bergmann, Thomas Zimmermann and Geert Uytterhoeven in the previous v4:
>
> https://lists.freedesktop.org/archives/dri-devel/2023-July/411842.html

Looks all good to me, except for two minor things I found in build testing
and replied to separately. With those fixed:

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
