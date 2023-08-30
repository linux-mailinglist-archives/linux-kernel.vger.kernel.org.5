Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1558678DE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238532AbjH3TDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343967AbjH3Riu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:38:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90333193;
        Wed, 30 Aug 2023 10:38:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso7424480a12.3;
        Wed, 30 Aug 2023 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693417126; x=1694021926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jbAT6tVSst61nEOg9/KrYv+5R56n09qvoB/CI4vs9QQ=;
        b=nX4aM4bpvFaff0mnd0PKlSrBDXB9haWEWfunyA+Fydbu5baofYc1JJj114HmYP8yze
         /6rK7NPXfiovIR0o9uNpch1JOzFfIdQcdr/r9p/AjntKZP93TyxMW5+BXHAd4/aJq3eC
         NNjq7YR10UurqMmau/aHY2lsH/ZdIJ+h20qDlJ7u5Anv8z3611yXEcsLYg3iJSX3BPSs
         nyvspCN1BAFtFSt3OUHS9hcBWGPu+DfM+J9cnr3ziEo4SJF0WnDWKGWStrdMZv77K25X
         FYaywnt7y4VeGkKNZ95jLhmldsRuON+Uz/Vz7tCpBUfVIKjqFg5lVzNTLKaXn2XAAyUT
         cPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693417126; x=1694021926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbAT6tVSst61nEOg9/KrYv+5R56n09qvoB/CI4vs9QQ=;
        b=ihidRY5AQrIhM4i2MTVjavIaYyF8plbWlplw5b7F7tQMJuaxLyUBOFxM0RmiCmbU8I
         UB+82q1KsCTHxTrPnn39Ghv1uiStoN3SN9L/q9NY09iyTN7a+MSBpro2JPedZwVaayhq
         RIFcyflE8DAhaqIGPhD+rclXf4anEhZJBtSirmxypqX0hOHhUthY2M7jCkgf906Q5lwf
         4PQb6RCBh4j2jaY209iZCqZKUMF6y38mx6Vj0Y9zXWzgBCKmrsfNKCNowc+IVPhcJxbg
         fLzPtrrBvgpDurfSPymA2wk3ijN5aWiIT5QEzMSNqzUUDINSrrfTZhHtn38WS56GtT/X
         KC9A==
X-Gm-Message-State: AOJu0YxHXi/c+TG9jf6jeOQ/I1CAcPUcBi8jWbjVOVHM9NjjUeDK60k4
        pBPWn4szPecBf2H+EY0CPKqJ8xkIx9aCZwk6azU=
X-Google-Smtp-Source: AGHT+IEDsNd7eXwxh1LNnWZAg+qaWrGjiIX7dw+Do6ISHYsemNHEnLpvwqGM9Tfm4J6v2gaWSRAzM890tlGOr2xWHTQ=
X-Received: by 2002:a17:907:1dd0:b0:9a2:1df2:8e08 with SMTP id
 og16-20020a1709071dd000b009a21df28e08mr2292155ejc.45.1693417125551; Wed, 30
 Aug 2023 10:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230828101149.146126827@linuxfoundation.org> <5b30ff73-46cb-1d1e-3823-f175dbfbd91b@roeck-us.net>
 <2023083014-barley-upscale-518e@gregkh> <64374066-4086-3e92-8650-ab1563350f0c@roeck-us.net>
 <95baa835-9940-a257-cf96-93c543aa389f@gmail.com>
In-Reply-To: <95baa835-9940-a257-cf96-93c543aa389f@gmail.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 30 Aug 2023 19:38:09 +0200
Message-ID: <CAOLZvyEuj=93tpObwDgyAK01Jyz8NfXQzJfAX5=vVwG1wxo-cA@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/84] 5.10.193-rc1 review
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>, patches@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        Pavel Machek <pavel@denx.de>, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Florian Fainelli <f.fainelli@gmail.com> schrieb am Mi., 30. Aug. 2023, 19:07:
>
> + Manuel,
>
> On 8/30/23 09:01, Guenter Roeck wrote:
> > On 8/30/23 03:52, Greg Kroah-Hartman wrote:
> >> On Mon, Aug 28, 2023 at 09:42:11AM -0700, Guenter Roeck wrote:
> >>> On 8/28/23 03:13, Greg Kroah-Hartman wrote:
> >>>> This is the start of the stable review cycle for the 5.10.193 release.
> >>>> There are 84 patches in this series, all will be posted as a response
> >>>> to this one.  If anyone has any issues with these being applied, please
> >>>> let me know.
> >>>>
> >>>> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> >>>> Anything received after that time might be too late.
> >>>>
> >>>
> >>> FWIW, commit 619672bf2d04 ("MIPS: Alchemy: fix dbdma2") should be
> >>> reverted
> >>> v5.10.y since it doesn't fix anything but breaks the build for
> >>> affected boards
> >>> completely.
> >>>
> >>> arch/mips/alchemy/common/dbdma.c: In function 'au1xxx_dbdma_put_source':
> >>> arch/mips/alchemy/common/dbdma.c:632:14: error:
> >>> 'dma_default_coherent' undeclared
> >>>
> >>> There is no 'dma_default_coherent' in v5.10.y.
> >>
> >> But that was added in 5.10.185, from back in June.  What changed to
> >> suddenly cause this to fail now?
> >>
> >
> > Nothing. I started to build this configuration and tracked down the
> > problem after the build failure was reported by others. Sorry, I didn't
> > initially realize that this is an old problem.
>
> We could back port 6d4e9a8efe3d59f31367d79e970c2f328da139a4 ("driver
> core: lift dma_default_coherent into common code") but that won't work
> too well on 4.14 or 4.19. I believe it would be simpler to adjust the
> branches with this patch, Manuel does that work?

Please drop this patch from all stable releases. I didn't CC stable
when I submitted it,
and have no idea why it ended up there anyway.
It was intended to fix a problem initially found in 5.18 (I think).

Thanks!
        Manuel
