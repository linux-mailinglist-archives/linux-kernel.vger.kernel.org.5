Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692117F4830
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344241AbjKVNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343568AbjKVNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:50:11 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926A9BC;
        Wed, 22 Nov 2023 05:50:07 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c887d1fb8fso33751431fa.0;
        Wed, 22 Nov 2023 05:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700661006; x=1701265806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGvo2wK/qUHrm7e4nS+FqOamAmN2Y01aRBg4wudRWCI=;
        b=nFo3rrRtfsbe3+X6hbnd2uJJiwLwJWqkz/JmWE/HGWtroXsPBhUfnwRtgZEnf5oL/w
         JjRZyljTXeyIpmc+ngJKrt/TtejzxmGvUbw8+6GCpoLpl24eH29XpehMYjRqh9oXdlbF
         BF6ILc93UmA8eHIDqHAH8UcHQQTemBeEATlPLdubNojn9ZEtjJirKGr4HK6EAUWaJcla
         yZqkuFZM4pxbr29U/6OrXaqvfJWia8SYfCF7y0+X+ND3ud3dy1/Oue/lOoQfrGVdr0Hj
         9ZPkcHfwxQ5GS3Vyn3Mu/NwRXhex81TN9csm01Z+Rh6sEfHik6yZkA5/2/LGFD2kd11I
         KS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700661006; x=1701265806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGvo2wK/qUHrm7e4nS+FqOamAmN2Y01aRBg4wudRWCI=;
        b=LkcHq0Wc5gwKjLMPy2yjhPUkNgCy3CDBJGRbz94+BvL4No/PlNJFvnTNDsLw1W/dcJ
         ip0iClPAw59qLsWh4GdzRjYs+A3gPPU/PrJBXLrMNBvJ6MpKx0DOVNxckXrA0pYlE9gz
         wJ5VbKlqnfznRQZN+rop7TxTU1J9hbKXlZV2ZMVNyONW34ukxANgp6k0AvW0kwklu+4u
         czuZX258qvVosVQDoVsI9VdhYOcou5MAYbQq7ecjIMVkYbvr/jX3f857WVv5fQ0oGGo3
         4YmbgsJR71nmWFB3I5Pk1Ght5cZ6o0hkRxRMZCcGZ4G+RFS03lRIUAUuzoeQr5A+UJet
         8UUQ==
X-Gm-Message-State: AOJu0YwvHrMrs4WCG0yXv9qDJui0OauBilofsDNev16Rcbgy4RAs9g1A
        UsNizHH63bMuvYEW8ecAPmFYrMea98YrslyeCTU=
X-Google-Smtp-Source: AGHT+IGADla5AngdafjZj4xVSn2bMpwu94RIXGs1aggs+dTW20GqVt+KqN6QW83yuruj4ESEnG/vy5fguAMd3CGAzQY=
X-Received: by 2002:a2e:908f:0:b0:2c8:874b:8f19 with SMTP id
 l15-20020a2e908f000000b002c8874b8f19mr1706701ljg.51.1700661005611; Wed, 22
 Nov 2023 05:50:05 -0800 (PST)
MIME-Version: 1.0
References: <20231122054142.31322-1-lukas.bulwahn@gmail.com> <mku6gvd4rfkxzk2vrdjbizglte526ygyfhnwialtri44oqzikt@pq2l7mk25jgc>
In-Reply-To: <mku6gvd4rfkxzk2vrdjbizglte526ygyfhnwialtri44oqzikt@pq2l7mk25jgc>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 22 Nov 2023 14:49:54 +0100
Message-ID: <CAKXUXMwGgtJVWmrFX0chpgNC++Ok54t-qXxware+aEDiyZFszw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add section MIPS BAIKAL-T1 SOC DRIVERS
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 2:32=E2=80=AFPM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> Hi Lukas
>
> On Wed, Nov 22, 2023 at 06:41:42AM +0100, Lukas Bulwahn wrote:
> > In recent years, a number of drivers for the MIPS Baikal-T1 SoC have be=
en
> > added to the kernel tree, but there is no dedicated MAINTAINERS section=
 for
> > this SoC.
> >
> > As all of the code has been contributed by Serge Semin, let us assume h=
e is
> > still the active maintainer for this code rather than marking it orphan=
.
> >
> > Add a new section MIPS BAIKAL-T1 SOC DRIVERS in MAINTAINERS.
>
> Thanks for submitting this patch. I was going to send a similar change
> in the framework of the arch-series which is hanging up in my local
> repo and alas is still under construction. I know I shouldn't have
> been waiting (I'm sorry about that), but I didn't expect the entire
> work would have taken so much time. On a way to finishing it up I had
> to switch my efforts to the EDAC and network drivers and got sucked by
> the amount of work there. But I will definitely submit the Baikal-T1
> SoC arch patchset when my work on another area is finally over.
>
> Here are several comments about this patch. (Please see my last
> comment should you be ok with accepting the patches with already fixed
> notes.)
>
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >  MAINTAINERS | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9613c9c3cc97..820f1ab1ee80 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14474,6 +14474,19 @@ F:   arch/mips/
> >  F:   drivers/platform/mips/
> >  F:   include/dt-bindings/mips/
> >
> > +MIPS BAIKAL-T1 SOC DRIVERS
>
> > +M:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
>
> It's better to change the email to
> +M:     Serge Semin <fancer.lancer@gmail.com>
> I quicker respond from my private inbox, than from the corporate one.
> This will also be useful should the corporate email eventually change.
>
> > +S:   Maintained
>
> +F:     Documentation/devicetree/bindings/bus/baikal,bt1-*.yaml
> +F:     Documentation/devicetree/bindings/clock/baikal,bt1-*.yaml
>
> > +F:   Documentation/hwmon/bt1-pvt.rst
>
> I'd prefer this and these -+ being in a separate entry (see the
> attached patches), because | the respective device IP-cores have been
> re-used in another SoC. So | eventually the entries will be updated to
> reflect that.              +---------------------------------+
>                                                              |
> > +F:   drivers/ata/ahci_dwc.c                               |
>                                                              |
> I believe this is already listed in the MAINTAINERS file.    |
>                                                              |
> > +F:   drivers/bus/bt1-*.c                                  |
> > +F:   drivers/clk/baikal-t1/                               |
> > +F:   drivers/hwmon/bt1-pvt.[ch] <-------------------------+
> > +F:   drivers/memory/bt1-l2-ctl.c                          |
> > +F:   drivers/mtd/maps/physmap-bt1-rom.[ch]                |
> > +F:   drivers/pci/controller/dwc/pcie-bt1.c <--------------+
>
> > +F:   drivers/spi/spi-dw-bt1.c
>
> This is already marked as maintained by me in the framework of the
> generic DW APB SSI driver (See the "SYNOPSYS DESIGNWARE APB SSI
> DRIVER" entry in the MAINTAINERS file).
>
> Anyway in order to save your time from editing this patch. I've
> prepared a series which takes into account all the comments above. If
> you are ok with it, I can submit it for review. What do you think?
>

Sure, go ahead and submit your series. I just wanted to have all files
in ./drivers/bus/ have a proper maintainer and then got to look at the
BAIKAL T1 files.

Lukas

> -Serge(y)
>
> > +
> >  MIPS BOSTON DEVELOPMENT BOARD
> >  M:   Paul Burton <paulburton@kernel.org>
> >  L:   linux-mips@vger.kernel.org
> > --
> > 2.17.1
> >
> >
