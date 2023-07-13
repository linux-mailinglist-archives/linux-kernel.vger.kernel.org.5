Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9BC751DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjGMJtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjGMJtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:49:45 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6570F212D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:49:43 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-401d1d967beso208761cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689241782; x=1691833782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ryqyAP9tKPKotwL6vu1Y1mHjFaSNUus4rsld5nnYfgw=;
        b=N8rSQAjlrQXU12Xu6CXnyjqbGWrJsRbPMdvfW5lexfRs8KSdvhxCMMV37SYjqmOxq6
         cAz6C8dWisIxCw0/HL0AjpmvQeEBgIDV3S++YV2Qd5odLidGHOg5ZcFNsxpH6/sG5yx+
         EXD4y92NBKX6LTAOFRlEznn7fDkENIYw+GLO4k0nh5lg3BYkhFIKQjrP2Th4PuXIrZeA
         IUUlGtDsF+BlxIyYQUXwUR3sNe+f1x31iGPx2I2b4uOyUL3jnjSF8auy+fI2I1QJFyzn
         I5EzGiK0UHfKgum7NtMhDMkLWnH2KSQLNhCY0T8mtWvubETEcisTjjZz0Y460cNV/1mF
         aZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689241782; x=1691833782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryqyAP9tKPKotwL6vu1Y1mHjFaSNUus4rsld5nnYfgw=;
        b=LGxLPsE5BuMrli5LhDV+NsYIbT7OGPJvcESyfwHMIiUeDXkwpHlZ0uwXdRFgyF8nJ6
         hlZ9ukldImAJ0lMu7NYNSoDwztG6n/MrSldsmYkxbMR9SlJK7l9ylNmTSxA4T1B1/qOc
         euPR9bUPw+O9Vahin/SzjQPDj1Eh2mOjQ1AIctVl5+Hv4AwzYUX5u7qoXbjHT/Apztev
         F4sOMmjRdXv0LZW4QTQNmreS3LUOEaPJumy3wh/WYAYH2GJnBEFMdYxzuuXt2XRQopLO
         I3Es9HN2ZgvXtj39bX/mgPd0KTlryEFshn5gCwasX4krdP61CFHuN8xQBVyVFCRbZkEi
         nQNg==
X-Gm-Message-State: ABy/qLbD5iWOqDZmoHGwcGL3uanCPXDt+itK4yv5Xpk6JqlXxGo4tXAl
        +aOHZLjO4MO+ENwEE6LnVK1VZ9wEuaMqJPJ3FUlKUg==
X-Google-Smtp-Source: APBJJlEh5CQdsxkwnfLLUE3rHjVYMfQs0H3kiM5Ssy3VD4hCu+ThNpm+zcgvoGeS28sH3cHiUeMFAvwHAveXX24A0/8=
X-Received: by 2002:a05:622a:58d:b0:403:59cb:66c4 with SMTP id
 c13-20020a05622a058d00b0040359cb66c4mr423533qtb.23.1689241782406; Thu, 13 Jul
 2023 02:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221123124620.1387499-1-gregkh@linuxfoundation.org>
 <n9108s34-9rn0-3n8q-r3s5-51r9647331ns@vanv.qr> <ZKM5nbDnKnFZLOlY@rivendell>
 <2023070430-fragment-remember-2fdd@gregkh> <e5a92f9c-2d56-00fc-5e01-56e7df8dc1c1@suse.com>
 <6a4a8980912380085ea628049b5e19e38bcd8e1d.camel@sipsolutions.net>
 <2023071222-asleep-vacancy-4cfa@gregkh> <2d26c0028590a80e7aa80487cbeffd5ca6e6a5ea.camel@sipsolutions.net>
 <2023071333-wildly-playroom-878b@gregkh> <de77578f-a783-a241-3ef5-e74f49029bb5@suse.com>
In-Reply-To: <de77578f-a783-a241-3ef5-e74f49029bb5@suse.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Thu, 13 Jul 2023 11:49:31 +0200
Message-ID: <CANP3RGeiQgcJ6zj3OHvoLy=f+spB7Xmv9gKuGoBwajwMFR08Jg@mail.gmail.com>
Subject: Re: [PATCH] USB: disable all RNDIS protocol drivers
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Enrico Mioso <mrkiko.rs@gmail.com>,
        Jan Engelhardt <jengelh@inai.de>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Joseph Tartaro <joseph.tartaro@ioactive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I know the NCM protocol a *lot* better than I do RNDIS, but...

RNDIS is just passing around chunks of memory (packets with some
metadata) over a usb channel.
*Any and all* exploits can be fixed - this isn't a complex DMA level
HW problem like pcie or firewire.
The trouble is finding the problems (ie. the places where input
validation is missing or wrong).
Indeed if you can write an exploit, it means you understand the
problem well enough to fix it,
and indeed fixing it is going to be *much* easier than writing the exploit.
(the hard part is finding the problems)

The (rndis host) code could probably be audited - the protocol is not
(afaik) that complex,
nor is the driver all that large.

I no longer have the email reporting the problems (deleted in a mass
inbox zero purge by mistake), but from what I recall
at least a few of them should have been fixable by making types
unsigned instead of signed and the like.
(ie. adding basic checks for whether values are in range)

As for things we can do:

- I think we can outright delete Linux' RNDIS gadget side code - that
should be half the problem.
Why? Because Linux/Mac support better protocols (CDC NCM) and Windows
10+ NCM support exists too.
(though the windows driver is afaik a little bit buggier than I'd like...)
Android devices (phones, etc) that support RNDIS gadget side don't
(AFAIK) use the upstream rndis gadget code anyway,
they use out-of-tree versions with offload support (at least afaik
that's the case for qualcomm chipsets).
Devices without hw reasons (offload) to use RNDIS can just switch to NCM.
Deleting it in Linux 6.~5+ doesn't affect older Linux versions anyway,
so it doesn't affect any older devices...

(Though deleting the code does mean we lose the ability to test linux
host side with linux gadget side...
I guess you can always just use an old kernel (or even just an old
phone) on the gadget side to test that combo...)

- I think we could change the RNDIS host side driver to be default
disabled (or even experimental)
However, be aware people (Linux users wanting to usb tether their
laptops off of most Android phones out there) will complain if we do
this and distros will end up enabling them anyway.

What we should really do is just start finding/fixing the bugs in the
rndis_host side.
It *cannot* be that hard.

If someone re-forwards me the kernel-security report, I promise to
send back at least a few fixes...
