Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDE97AB473
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjIVPJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjIVPJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:09:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A1CC6;
        Fri, 22 Sep 2023 08:09:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36140C433C8;
        Fri, 22 Sep 2023 15:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695395346;
        bh=XsXHh90rL5Oxz0o4/7pmVqXNIDZlKcy9P9sRX+xLwE8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tYrrz2Jtz5yuQkLWbKIj5PUSQ5gakrnfGiL/P2cbSrXvmawjo7OmJBMcZQK+xcjtu
         vyD4uuAuZygWuXsQPfJAYe/rsgKiZ8v07oU11krDKlbJSBgHOmGm97KbtmilSQT+Lp
         574G9bAn3TEnJZmg3V+0tw69bXAkak3zKv5hveTo1kGfh4t4biM250lC6p+iDo7PUF
         /POOC6MsthXVhyaKl2OU1mXbd1KIVD15wMq67m54udKHe2VWgM/8TqOHIJgvnmOo00
         RRhuQ1y5lZWAZaeH+NORmVwlxBw6lybEF/6yso6/8mfb3/VRliMY8SuKsgbElFJioa
         Vw+dxVzbTsI1A==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-59c268676a9so26705717b3.0;
        Fri, 22 Sep 2023 08:09:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YwlDTiNg7BiAwHenkacGSl+FDR1F8Lo2KT+SVw0KbiB0N6tnSjS
        ZyS9pRx71a0lfBKsXUlCZ81IQk3VAvJk5nqbxsg=
X-Google-Smtp-Source: AGHT+IFqK+0lT+ocRoW+vU5iVCzFG0N9dYlQxc7x8/IbpeAnpbmLGw7poT/AXnftVvW5/P9E2yGZMkozvJDDdkeMLQs=
X-Received: by 2002:a0d:c8c1:0:b0:59b:c6a4:15c7 with SMTP id
 k184-20020a0dc8c1000000b0059bc6a415c7mr9129453ywd.46.1695395345308; Fri, 22
 Sep 2023 08:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <SEYPR03MB704641091854162959578D7E9AFFA@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CA+VMnFyhp9D8cjtvLVzdKGETouOuH=MKgjOu1pn00WDRB=5oUg@mail.gmail.com>
In-Reply-To: <CA+VMnFyhp9D8cjtvLVzdKGETouOuH=MKgjOu1pn00WDRB=5oUg@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Fri, 22 Sep 2023 18:08:38 +0300
X-Gmail-Original-Message-ID: <CAFCwf12sUL5bcXhYKwRkMxLtSDtLfTK003oxkRDVmThx1ARV-A@mail.gmail.com>
Message-ID: <CAFCwf12sUL5bcXhYKwRkMxLtSDtLfTK003oxkRDVmThx1ARV-A@mail.gmail.com>
Subject: Re: kernel.org 6.5.4 , NPU driver, --not support (RFC)
To:     Jagan Teki <jagan@edgeble.ai>
Cc:     Cancan Chang <Cancan.Chang@amlogic.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 12:38=E2=80=AFPM Jagan Teki <jagan@edgeble.ai> wrot=
e:
>
> On Fri, 22 Sept 2023 at 15:04, Cancan Chang <Cancan.Chang@amlogic.com> wr=
ote:
> >
> > Dear Media Maintainers:
> >      Thanks for your attention. Before describing my problem=EF=BC=8Cle=
t me introduce to you what I  mean by NPU.
> >      NPU is Neural Processing Unit, It is designed for deep learning ac=
celeration, It is also called TPU, APU ..
> >
> >      The real problems:
> >       When I was about to upstream my NPU driver codes to linux mainlin=
e, i meet two problems:
> >         1.  According to my research, There is no NPU module path in th=
e linux (base on linux 6.5.4) , I have searched all linux projects and foun=
d no organization or comany that has submitted NPU code. Is there a path pr=
epared for NPU driver currently?
> >         2.   If there is no NPU driver path currently, I am going to pu=
t my NPU driver code in the drivers/media/platform/amlogic/ =EF=BB=BF, beca=
use my NPU driver belongs to amlogic. and amlogic NPU is mainly used for AI=
 vision applications. Is this plan suitabe for you?
>
> If I'm correct about the discussion with Oded Gabby before. I think
> the drivers/accel/ is proper for AI Accelerators including NPU.
>
> + Oded in case he can comment.
>
> Thanks,
> Jagan.
Thanks Jagan for adding me to this thread. Adding Dave & Daniel as well.

Indeed, the drivers/accel is the place for Accelerators, mainly for
AI/Deep-Learning accelerators.
We currently have 3 drivers there already.

The accel subsystem is part of the larger drm subsystem. Basically, to
get into accel, you need to integrate your driver with the drm at the
basic level (registering a device, hooking up with the proper
callbacks). ofc the more you use code from drm, the better.
You can take a look at the drivers under accel for some examples on
how to do that.

Could you please describe in a couple of sentences what your
accelerator does, which engines it contains, how you program it. i.e.
Is it a fixed-function device where you write to a couple of registers
to execute workloads, or is it a fully programmable device where you
load compiled code into it (GPU style) ?

For better background on the accel subsystem, please read the following:
https://docs.kernel.org/accel/introduction.html
This introduction also contains links to other important email threads
and to Dave Airlie's BOF summary in LPC2022.

Thanks,
Oded
