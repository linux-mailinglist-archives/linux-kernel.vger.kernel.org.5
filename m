Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE727C92F6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 08:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjJNGcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 02:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjJNGct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 02:32:49 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E6DBF;
        Fri, 13 Oct 2023 23:32:48 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso3047139276.2;
        Fri, 13 Oct 2023 23:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697265167; x=1697869967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5xaWOo1D+HhhlwPdSC9+vAnZB9g/JHmWJaQdfHTbHA=;
        b=GW74oVZtoD83QmniCy5H3KOl78xBU+hvJ2YZJTxAt7zXRD2tRq12teVeW6h0wgxQyU
         5BUcp4zx6Akgogw3B+s5Z2dr/slLOgpMUVbhKjIX0HcI54mQJ5EXQCBiNZA47EnRTdpC
         qnwqzLZSHVHxApReghe5e072hEwdsYg4hjKNaXvLfLm2Hw0mLnCl9mXyxNQ9Q3hwBc80
         Zn4Su+uiBjV08nnjtvCUPHJ36omLjaW4ULpFh7mdAodvBJdqh1nAai52Ul1jN+NcfgNC
         0XNVzvh3bTn8fsoKve6+RX5tDTLvF5IUmiN7aFArCrI3GHlgtJjS/huJuOCWcWVUsWgh
         XvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697265167; x=1697869967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5xaWOo1D+HhhlwPdSC9+vAnZB9g/JHmWJaQdfHTbHA=;
        b=sSVj57VxC24PWmCACfh7Eea0X0S1gNDo7xQWgCyUUHamd51rteZFWpJC/fVskzA34Z
         rSxFMrJxa2QfK9OL6+lnKyCElNXU1BoFdntjzMVChYLAZD5oluK2iNV0UmgiDG8xxtZX
         esVnxPa2jtqSxAQMqwCkkpavaLhuutKpDaRPW81TsAB+V7r3tPodePQiskhyrT85gsnM
         mebBtTNu6/y++0mVHzQltv2gxxJZtJnR6X/Esuou9xJAaA4MkAwAe1aXDsMjzEs3gI0R
         WPTP1OQ/5AJAjqNDSS9/YIko2p07HYHyyXUlJbj4gS9J6pgvhkHUJ4jKWLFr1zjIOyH0
         Ax5Q==
X-Gm-Message-State: AOJu0YzWukohOZQ/kkMgBDfX2S7IfE04WEGxc1GyzszI91IJpeSQvNiX
        TbDcF1EuNOUzkw0ha95Joiw45TWDKbzex9NqjzIT4RjGCEA=
X-Google-Smtp-Source: AGHT+IGPiXdzPkbTZU28IfldxGb2Y7+zxLcJpBsvmBNVWYVOL7sa/F/x0SdIGq9PR/oFl2J8SrF3RzB9iRnLCSi/BfQ=
X-Received: by 2002:a25:230e:0:b0:d9a:b9fe:a318 with SMTP id
 j14-20020a25230e000000b00d9ab9fea318mr6951399ybj.58.1697265167476; Fri, 13
 Oct 2023 23:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+fyA4RABYNPZZSk9+9U51u53kbSzqgwdi1KDDGRxXi8q5TtxQ@mail.gmail.com>
 <ZSm9zeepuZ94A-ZI@google.com>
In-Reply-To: <ZSm9zeepuZ94A-ZI@google.com>
From:   John Salamon <salamonj9@gmail.com>
Date:   Sat, 14 Oct 2023 17:02:35 +1030
Message-ID: <CA+fyA4QD6ojC7NMaYigK2xvHt0cpEPY3daGx01Hh3NVHV1sfMQ@mail.gmail.com>
Subject: Re: uinput: waiting for UI_FF_UPLOAD events will not inform user when
 allocation is required
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for the clarification.

> The handler of force feedback effects should know what effects (with
> what IDs) have been uploaded to the device so far, so whenever it sees a
> request for an effect with previously unseen effect_id it should
> recognize this as a signal that a new effect/id has been allocated by
> the kernel.

In that case, would you consider accepting a patch adding a sentence
or two explaining that handlers will need to keep track of effect IDs
in this manner? Either in uinput documentation or just in the comment
describing how to implement upload_effect() in uinput.h. Something
along the lines of "Effects received here will never have an ID of -1.
Handlers of these effects must recognize previously unseen effect IDs
to know when a new effect has been allocated.".

Cheers,
John


On Sat, Oct 14, 2023 at 8:29=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi John,
>
> On Tue, Oct 10, 2023 at 05:38:27PM +1030, John Salamon wrote:
> > Currently the "fake" input events generated by uinput in response to
> > effect uploads will return an effect with an id that has already been
> > handled by input_ff_upload in ff-core.c, which can modify the effect
> > id. This causes a problem specifically when the effect originally
> > uploaded via the EVIOCSFF ioctl contained an effect with -1, as the
> > userspace code handling UI_FF_UPLOAD receives an effect with an id
> > other than -1, and therefore will not know an allocation was
> > requested.
>
> The kernel never changes ID of an existing effect, the only time ID is
> changed is when userspace indicates that a new effect should be created
> by setting effect ID to -1.
>
> The handler of force feedback effects should know what effects (with
> what IDs) have been uploaded to the device so far, so whenever it sees a
> request for an effect with previously unseen effect_id it should
> recognize this as a signal that a new effect/id has been allocated by
> the kernel.
>
> >
> > I notice that the "old" field on the ff_effect struct is set to NULL
> > when the -1 id is changed (in input_ff_upload), which can serve as a
> > flag that an allocation was requested. If it is the intention is that
> > uinput users check if old =3D=3D NULL to know when allocations are need=
ed
> > I think uinput documentation should describe this.
>
> No, not really, as explained above.
>
> >
> > I first noticed this using python-evdev, see my issue report here:
> > https://github.com/gvalkov/python-evdev/issues/199
>
> Thanks.
>
> --
> Dmitry
