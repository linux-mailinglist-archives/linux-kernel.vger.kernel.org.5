Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273607B77DD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241364AbjJDGfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbjJDGff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:35:35 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3D4B4;
        Tue,  3 Oct 2023 23:35:32 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d84f18e908aso1832877276.1;
        Tue, 03 Oct 2023 23:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696401331; x=1697006131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV98O++0wueY4Se3RDk4FS6DnLpx+AEq9azMKtwZP3M=;
        b=V0985F8ykDY0xsmflVX9zHC6U0HsC0i+aq258+2/KB5ecuBvErreCCfd7PuxuNhj7W
         RoHzymRMLmAbc96X8AIG+v1KZKZqirXWxS2hMs02qqrFHYYZcDnmnTs3oBUnHUFztCfo
         ajNhg/lzM9W50XrHPHG2mnqTEEFLzXvqDLwyJIAqHWNZQ94qeK1n/7QcNRiw5+dsqnW5
         6dbGhrxmomg4cacXcgoiQ3x9vy8YOhV5Ashb+JBayXZ88S7FeNW8dp2MqBioHNK8QdAG
         TwEsKzzKV8JnYxwa+sbq80FCEzC2Po14D/+ZmyhTWCL70ZdXeqMWol9XIks5AV25UiZw
         T0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696401331; x=1697006131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rV98O++0wueY4Se3RDk4FS6DnLpx+AEq9azMKtwZP3M=;
        b=kU0pEacaQcmTTW0dFVj/7lPurwzyHDaOyWSvbo6Z90Q6h1O5rjGYX+rWeUHTtAqdIn
         tNXz+w46I50W3bGtsaMuw1092ejdLJRG+qqOEdhIzqHN8FAbj/Tl5iplEeRf8Y/Dy61Z
         /byG6LvODBAPb0x24zvwRhe/pcF7yPdR36qSJJZQYcicDUd0Mw2K3bDXfXh5/KEQm9tI
         5XEz5vjQyH+n0oHf6zf3nSqavQh068qB6d1E1WeBNwonEs9nrf6mM+P49z7xemeGkbwa
         unPHwQznt0owJZwSRZfVPQejinXeXal5Rb1XNZqN/XmuhI85uEgLMWhmr4lAxMMQ7XvT
         V/9g==
X-Gm-Message-State: AOJu0YyWJ5XYIpApvcpUfLzLMVgr05Q4BbkCv/CujPxS5P6iH0kgYskZ
        YfmeInFI4avA7Enpp4py5t25d7VDnW2g3qGkL0Q=
X-Google-Smtp-Source: AGHT+IG7t8/D8MEUEDHRVj12H+fsSO3OXBRZh3THZje73nXUbViNRQLJzuIsSOZ8BZVwVH1m0A8ACfq2fRgIxM82ZRU=
X-Received: by 2002:a25:d18a:0:b0:d84:b0f8:90e with SMTP id
 i132-20020a25d18a000000b00d84b0f8090emr1303793ybg.5.1696401331543; Tue, 03
 Oct 2023 23:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAH7-e5sb+kT_LRb1_y-c5JaFN0=KrrRT97otUPKzTCgzGsVdrQ@mail.gmail.com>
 <ZRtWcgiH5JhD5NU2@debian.me> <CAH7-e5uspavg_VBJxKLOKJfU3nAq-OrPqzihF2opffY-ReiC-w@mail.gmail.com>
 <834062302e6a98e773dc4b03d7ed568a0f1c44fc.camel@nordicsemi.no>
 <CAH7-e5uZzmnFJAJrG664G6_JbK--DfbKC50aeVN5gMMxDJ51UA@mail.gmail.com>
 <ba7aaaed859ea2c4f5aac597deb382cceab33d65.camel@nordicsemi.no>
 <CAH7-e5unq6ggNjVkSsriUAmpvk4s7-NCYJrZnLK_3BjFO_Dceg@mail.gmail.com> <3e86e69c-64bc-4776-9ee8-75b98be1bf3e@leemhuis.info>
In-Reply-To: <3e86e69c-64bc-4776-9ee8-75b98be1bf3e@leemhuis.info>
From:   =?UTF-8?Q?Erik_Dob=C3=A1k?= <erik.dobak@gmail.com>
Date:   Wed, 4 Oct 2023 08:35:20 +0200
Message-ID: <CAH7-e5vfhcsPiM4qqFdTxv4C=1An=y0uk1o44ryPc+FZ5wa=cw@mail.gmail.com>
Subject: Re: bluetooth issues since kernel 6.4 - not discovering other bt
 devices - /linux/drivers/bluetooth/btusb.c
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     =?UTF-8?Q?Tomasz_Mo=C5=84?= <tomasz.mon@nordicsemi.no>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Mediatek <linux-mediatek@lists.infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023 at 07:20, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 03.10.23 18:10, Erik Dob=C3=A1k wrote:
> > Sorry Tomasz,
> >
> > that must have been a reality glitch with your commit (cant find the
> > page refering to your commit now). But yes it is probably a kernel bug
> > as it manifests kernels 6.4 and not in the 6.1 LTS version.
>
> Could you then please try a bisection to get us closer to the problem?
> You might want to try mainline (e.g. 6.6-rc4) first, with a bit of luck
> the problem is fixed there already; FWIW, a few BT fixes that might or
> might not be relevant for your case are heading that way and will most
> likely be in 6.6-rc5.
>
> Ciao, Thorsten
Hi Thorsten,

i was able to compile vanila kernel 6.6-rc4 yesterday and the issue
was still there. as it takes ages to compile i will try the
precompiled artix kernel 6.3.4 next to see if the issue disapears.

Regards

E
