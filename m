Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB69F7C80D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjJMIxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjJMIxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:53:12 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8BABE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:53:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so3177942a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20230601.gappssmtp.com; s=20230601; t=1697187186; x=1697791986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMsxy+WRFTvVWQUjTpH47x0e7OESMLVwCdR526kLjyM=;
        b=TlwNs/vAUP69k89accyituAFuPK4PIma+nurmzMZPAPL9zP89CP18V3VC+SsXvU3sH
         rcF50lwuaduezrurDZgewrlQ4WTH+TGjoIT5YdyMr0czmZw8v2zbBnKkN41ckLahBZ4y
         Jy+N+NMIWzFl+Y+TvWOZy3w6Pywx3sk29CDTFVder87jCaK4fq2BVz7/TuH0I0z6z3yq
         8BySJl0a1T4pZpLHr2z7FKuiCTXCVUleydSzV+qPUz7cc++TLPjHEvN+Iw5in77nKAUa
         +bWUDvNahhDl8RqXH3mlYsZgpnjkHuUAhjuTcsF7Xa3ZYdbjKQzmb7KJSLEUa8DmWxN9
         MXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697187186; x=1697791986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMsxy+WRFTvVWQUjTpH47x0e7OESMLVwCdR526kLjyM=;
        b=GkLejYH/xaPKCBstZFtTtl3nMw6U2KnZgF8pgtqQu7gi8pWASlVkfE8F5/LoTdtjdj
         pZjAWeBa6hHfEdLQJqRhgkr8GTUAjrJFTfz1ja1gmgwYkeAEpthvOgHW0e6eQxP5g9Iu
         f/WJj9glY0RmAnehNdtaeXmI+ya4MT9j2kJK8QN6s4lDpsRIv3TS6K/XoDW7A1gSO81z
         a2iOcRs6Ip/IHb6hsKRno/3OQUGuGQJLNpEsU16f0I0XnOUu4h95LhdM/oWWK/QmOVOL
         HVq6nUswnK6vzcs0B23oXrg/5HDwHW9blgWg6+KsDdtVXkYdJFDZhuMoNRXw+cH/G7Kh
         bqPw==
X-Gm-Message-State: AOJu0Yw5ZHRqP6HPC0lw66LP3l2xnraV+yw0S4uKSDagEvghFHtS8N9h
        18ENqqg9YxWDfkfNf+NxyrguSTRDUo4h2XYBm07j23YmlDMAjQOg6fI=
X-Google-Smtp-Source: AGHT+IFzZ3t4iS3SNjrv9IvNOzD3bkfOgp0PSof2UEVaezZvcDRgTHOxenIrXXymRL2XU4OeO6Oo5BuOgumTEkNgoLU=
X-Received: by 2002:a05:6402:1219:b0:530:77e6:849f with SMTP id
 c25-20020a056402121900b0053077e6849fmr23219312edw.27.1697187186325; Fri, 13
 Oct 2023 01:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230926230712.516709-1-william@wkennington.com>
 <aa4591dd-b558-3401-4a19-362780ec321f@axentia.se> <CAD_4BXhWbUxuidM47poTKFYYruL5jdJyPUfoZvXnqwDNNLd98w@mail.gmail.com>
 <ba8d31bf-28f5-d8a1-adff-1b9ea7c3a578@axentia.se>
In-Reply-To: <ba8d31bf-28f5-d8a1-adff-1b9ea7c3a578@axentia.se>
From:   William Kennington <william@wkennington.com>
Date:   Fri, 13 Oct 2023 04:52:54 -0400
Message-ID: <CAD_4BXgY0uJU1-TRdqOMXZGyEy_mx7LOui_y_+OFJm8OrOJytQ@mail.gmail.com>
Subject: Re: [PATCH] mux: Make it possible to select MULTIPLEXER if EXPERT
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 4:36=E2=80=AFAM Peter Rosin <peda@axentia.se> wrote=
:
>
> Hi!
>
> 2023-10-12 at 23:52, William Kennington wrote:
> > On Wed, Sep 27, 2023 at 16:08 Peter Rosin <peda@axentia.se <mailto:peda=
@axentia.se>> wrote:
> >
> >     Hi!
> >
> >     2023-09-27 at 01:07, William A. Kennington III wrote:
> >     > Right now, there is no way to enable multiplexer support unless a=
nother
> >     > config option selects it. When using `allnoconfig` with CONFIG_EX=
PERT,
> >     > this is deselected with no way to enable it.
> >
> >     I fail to see how that would be useful? Why would you want the mux
> >     core if there are no users?
> >
> >
> > In this case the user is a custom configuration that is added per board=
 following
> > Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml
>
> (That binding has recently been moved:
> Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-gcr.yaml)
>
> >
> > I suppose the problem is that ARCH_NPCM7XX doesn=E2=80=99t select MULTI=
PLEXER and MUX_MMIO. Maybe that=E2=80=99s the patch you are looking for? No=
thing else that we use has a dt compatible string with mmio-mux or uses the=
 functionality under the covers. This leads to our board config selecting i=
t manually.
>
> Perhaps? I think that's one way to do it.
>
> I'm not sure about what exactly should select MULTIPLEXER in your case,
> but the thinking is that whatever driver wants to use a mux controller
> should be responsible for selecting the mux core.
>
> Maybe that thinking needs revisiting?

It looks like for many of our boards, we are basically relying on
mmio-mux to be able to set the initial state for some of the registers
in the SoC. In our usecase we want the serial port mux registers to be
set to an idle value that never gets updated by any driver, so we have
these dangling mmio-mux entries.

>
> When digging I'm finding nodes that wants to add mux controllers to the
> npcm "gcr" syscon node in:
>
> arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dts
> arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
> arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts
>
> But I then find no mention of any nodes wanting make use of those mux
> controllers. My thinking is that whomever comes up with a dts that
> actually has such nodes will also want to select drivers for those nodes.
> And those drivers in turn should select MULTIPLEXER.

It seems like there are no consuming drivers, we just want a global
initial state set for SoC registers when the kernel starts. There is
probably a better way to do this. I think the intention was to be able
to expose the mmio-mux functionality to userspace but obvious the
mmio-mux in itself doesn't support that.

>
> (The above olympus case is a bit suspect since the mux controller has no
> label, and it is therefore needlessly difficult to reference the node
> from a node that needs a mux controller)
>
> Cheers,
> Peter
