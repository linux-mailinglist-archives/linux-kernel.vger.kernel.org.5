Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5128055A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbjLENOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbjLENOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:14:52 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22F098;
        Tue,  5 Dec 2023 05:14:58 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 395F35C013F;
        Tue,  5 Dec 2023 08:14:58 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Dec 2023 08:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701782098; x=1701868498; bh=ei
        yfcAaW8S/0cnNR5qvKPP9FPzFqObUKOJebJtjaT4g=; b=e82s3TzuEm8iFGHKNS
        Gcw1xRqRWMIt+B+zrl3U0DcuJVDFwt45xi8LiyrETrtYnQ1wwLupBHoIqQsyddf6
        xLgfDKb1dMSQmJoElVvQt15tbGwy7+iNWi3jKg2rDxwVif5N6YS1cuKreesIgPUq
        zD3DE4jkp+gB/bwz0CQTZYkghmZZNUTR5KlpTidQP9XU7RUUmL+hZipJ2tmXS7hA
        bZyy5sT9uwijI6dPCHPag6D/oDN/VF3NFZp4mmCIvfl/cPq3WmTafwg/7a3AVA8u
        IGUyrUlV/e8uCgKAnb/Cvf5cOBPJH88SX3/NTZXJ/FsHE0dClpcWsXkubmTc2Wfv
        R1Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701782098; x=1701868498; bh=eiyfcAaW8S/0c
        nNR5qvKPP9FPzFqObUKOJebJtjaT4g=; b=HwSdQyAWxW10UNefYT+kXCz5FDcjS
        W3AhGVkVloQUOHSnpjTfkkghKOTbu44s5p8TcKhEl+SnyyLVMc3/Xjpvc2Ek8ySH
        NuHNha8/kVEiyuotDB7hzu2/jYnZPzJEXWNrwtH4Yg8Fnt/K/VnXGEdS57TabMmN
        ii8E3FocogroF9nuQ7oJOXEn26CU5wWcNFfzvz6cIAt4arVC5ovnC9okSdw0APMo
        Nre8n6G9+BX/KZeaMvpa+Jv9S3TDwSLxOff1e/Y0/efyNaYBKuaDxSfhlXmiZrIl
        CJ70bTRP9NN591XKuEzxPMzeRferbt7Xul1BBNaJWzOhfvLV1higsQPpQ==
X-ME-Sender: <xms:USJvZd6q_qqg8y-myUW2OU3XdoUUet26-KY4YMbQhmxIpGJ1HIuw9w>
    <xme:USJvZa5QkOzymByuv8k2ZrXFpUNnPL_taeqwsClWJF9URxNDSIWSOLSl5TQdCrKGt
    YywaZXVFg3htsISz3o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:USJvZUcGt532mfRjlVgZJK4Y2XADcxhtuKw4tFKzfx02wWZqFEGX4Q>
    <xmx:USJvZWLi6DblaUd28BK613vl7KpjoFKhlqm4ZCa235mWj_lrpjOxnw>
    <xmx:USJvZRI0KIfF8nQeRic7wKBrMOS9L_IdS3EPwoUhNULSNpFw4EkeAw>
    <xmx:UiJvZbz9T_gxgOYCBAmoSkOQ8q9e95L4fubtQWiXR8-oxiJcNAF_ZA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7F054B60089; Tue,  5 Dec 2023 08:14:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <f2b58a5c-5457-485a-974f-cfda2e6dc2d2@app.fastmail.com>
In-Reply-To: <76bbd45b22ef6cc1fa69369aff908c9c4e366860.1701768028.git.ysato@users.sourceforge.jp>
References: <cover.1701768028.git.ysato@users.sourceforge.jp>
 <76bbd45b22ef6cc1fa69369aff908c9c4e366860.1701768028.git.ysato@users.sourceforge.jp>
Date:   Tue, 05 Dec 2023 14:14:37 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     "Damien Le Moal" <dlemoal@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Dave Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Magnus Damm" <magnus.damm@gmail.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Lee Jones" <lee@kernel.org>, "Helge Deller" <deller@gmx.de>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Chris Morgan" <macromorgan@hotmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Hyeonggon Yoo" <42.hyeyoo@gmail.com>,
        "David Rientjes" <rientjes@google.com>,
        "Vlastimil Babka" <vbabka@suse.cz>, "Baoquan He" <bhe@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        guoren <guoren@kernel.org>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Azeem Shaikh" <azeemshaikh38@gmail.com>,
        "Palmer Dabbelt" <palmer@rivosinc.com>,
        "Bin Meng" <bmeng@tinylab.org>,
        "Max Filippov" <jcmvbkbc@gmail.com>, "Tom Rix" <trix@redhat.com>,
        "Herve Codina" <herve.codina@bootlin.com>,
        "Jacky Huang" <ychuang3@nuvoton.com>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "Michael Karcher" <kernel@mkarcher.dialup.fu-berlin.de>,
        "Sergey Shtylyov" <s.shtylyov@omp.ru>,
        "Laurent Pinchart" <laurent.pinchart+renesas@ideasonboard.com>,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [DO NOT MERGE v5 06/37] sh: kernel/setup Update DT support.
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023, at 10:45, Yoshinori Sato wrote:
> Fix extrnal fdt initialize and bootargs.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/kernel/setup.c | 51 ++++++++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
>
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index 3d80515298d2..b299abff68e0 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -30,6 +30,7 @@
>  #include <linux/memblock.h>
>  #include <linux/of.h>
>  #include <linux/of_fdt.h>
> +#include <linux/libfdt.h>
>  #include <linux/uaccess.h>
>  #include <uapi/linux/mount.h>
>  #include <asm/io.h>
> @@ -74,7 +75,13 @@ extern int root_mountflags;
>  #define RAMDISK_PROMPT_FLAG		0x8000
>  #define RAMDISK_LOAD_FLAG		0x4000
> 
> +#if defined(CONFIG_OF) && !defined(CONFIG_USE_BUILTIN_DTB)
> +#define CHOSEN_BOOTARGS
> +#endif
> +
> +#ifndef CHOSEN_BOOTARGS
>  static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
> +#endif

I think an appended DTB is generally better than a built-in
one, as that allows you to still have a single kernel
image across machines and just pick the dtb when installing it.

With everything else being equal, I would suggest not
actually making this an option for new platforms.

    Arnd
