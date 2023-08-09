Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B2F776749
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjHISaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjHISaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F72FA3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691605754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VU9lj4736mFcJlFa+niJ6SImF0emcM8nxQWNCZfo+W8=;
        b=IsJWrbF3wyISeLFxO+neuxIMWKKoypsRfRnCU9UMM019HElF3YOn+J60d8k/RY1QcUPE0f
        nPq04zIU5zVDmSgK7DXQt8/OGSz8MJ67dYilZqXmFxxbMbVAhQ4n+CmwP3J+e8tfMwsbI1
        SfsdQMNr273GMrHix8o6oiDs1ta0eeo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-AcE9xnhuMpWtrv6iG8UJ_g-1; Wed, 09 Aug 2023 14:29:12 -0400
X-MC-Unique: AcE9xnhuMpWtrv6iG8UJ_g-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9d5bc6161so255241fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 11:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691605751; x=1692210551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VU9lj4736mFcJlFa+niJ6SImF0emcM8nxQWNCZfo+W8=;
        b=gssZtMszo/rKN8/VZJtgBhp5EiUgx8w2R8jRbhWLm8lgnD0d0Z1uuIC0Pl1BYjps/X
         7C4Hx22M+sWDYZVOPTR49WQw8ri9F6PSqiXhfpcbVFXveF3pBPxwye39Y14wbTVyFFS9
         2CBxWi0SLctAgeLrEaxuIvQFIZz7hQkdMOzSbM/eOQ1izsiERbEeTLekiBryNayP6rdM
         kQC++u8ODcYesjKwGDfBNdQnkh4KVVGMEwWc5zRZSew/sWyTffgjJxLVlg+2y9csAuAC
         u/v98LgtOrDJWd5NlnBAoAGbz0rFdb3/rXS467ygTjiJr/CmxPFV0iigUZOOwPQMLasu
         UaMg==
X-Gm-Message-State: AOJu0YyHZOXf831HzX+s4CufN08yyQ5c9H86d8eC5CEEEA7stWF/svnJ
        X2HiY5AaRpLfrSady+sDYcrvgGCpq9Cat86ofPKBBDBW6TGDstlqRdJBGlGJ4Ux45WuEG/KGGEC
        C5znkyodZPs1cujZTkKtpH0NJBdxN00E8ZKiFFijN
X-Received: by 2002:a05:651c:2107:b0:2b9:a156:6239 with SMTP id a7-20020a05651c210700b002b9a1566239mr1298ljq.1.1691605751377;
        Wed, 09 Aug 2023 11:29:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpZzm/oAXal+SXFMKVcUnRTLHmeHrnw1rp1VRHk+gJDJwU0amodPtO6iRhHhIkzV5jJXafc51j+GnfRMuyRyA=
X-Received: by 2002:a05:651c:2107:b0:2b9:a156:6239 with SMTP id
 a7-20020a05651c210700b002b9a1566239mr1289ljq.1.1691605751013; Wed, 09 Aug
 2023 11:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230806213107.GFZNARG6moWpFuSJ9W@fat_crate.local>
 <CACO55tvZD5U4J8DawFTRVnV-dLYLngfhuqO29_sWNEGofKfnBg@mail.gmail.com>
 <20230807150521.GGZNEIMQ9rsyCmkpoA@fat_crate.local> <CACO55tvWuSdwdirj7S3Dk-r4NAw8jC8g5RHKFd62WXi43iQP-w@mail.gmail.com>
 <87fs4sfu54.wl-tiwai@suse.de> <CACO55tszwFEgt=8xn4auAE7KJVs3ybGG68OzL9HJt19XGVhhHQ@mail.gmail.com>
 <874jl8fngo.wl-tiwai@suse.de> <CACO55ts9YWF7nLi3Zs4xKySpdHyUFgf4r566cKx3FwNTCaz0Sg@mail.gmail.com>
 <87wmy4e4uk.wl-tiwai@suse.de> <60ef0646-b0ab-b4e0-9eaa-a2c431c5d682@leemhuis.info>
In-Reply-To: <60ef0646-b0ab-b4e0-9eaa-a2c431c5d682@leemhuis.info>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 9 Aug 2023 20:28:59 +0200
Message-ID: <CACO55tt=RosBaYPc_wf3NnRC-+prFg2G9E0GEjnV7TSkWjB2HQ@mail.gmail.com>
Subject: Re: 2b5d1c29f6c4 ("drm/nouveau/disp: PIOR DP uses GPIO for HPD, not
 PMGR AUX interrupts")
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Takashi Iwai <tiwai@suse.de>, nouveau@lists.freedesktop.org,
        Borislav Petkov <bp@alien8.de>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 4:04=E2=80=AFPM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 09.08.23 15:13, Takashi Iwai wrote:
> >
> > If this can't be fixed quickly, I suppose it's safer to revert it from
> > 6.4.y for now.  6.5 is still being cooked, but 6.4.x is already in
> > wide deployment, hence the regression has to be addressed quickly.
>

feel free to send reverts to mainline and add my r-by tage to it and I
can push those changes up. Sadly those patches fixed another
use-after-free, but it seems like we have to take another shot unless
somebody does have time to look into it promptly.

> Good luck with that. To quote
> https://docs.kernel.org/process/handling-regressions.html :
>
> ```
> Regarding stable and longterm kernels:
>
> [...]
>
> * Whenever you want to swiftly resolve a regression that recently also
> made it into a proper mainline, stable, or longterm release, fix it
> quickly in mainline; when appropriate thus involve Linus to fast-track
> the fix (see above). That's because the stable team normally does
> neither revert nor fix any changes that cause the same problems in mainli=
ne.
> ```
>
> Note the "normally" in there, so there is a chance.
>
> Ciao, Thorsten
>

