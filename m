Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592FD7D45BA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjJXCvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjJXCvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:51:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05A611A;
        Mon, 23 Oct 2023 19:51:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so58897081fa.1;
        Mon, 23 Oct 2023 19:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698115893; x=1698720693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZaWM6/+je0+6Ad3eiiKjXQ3HfajEyj0oCdz07xSxDw=;
        b=WZkfdl0/YfGH8XajsJB1LpL6o6SKOi9ZlEAeZhlIEjaPzMS9F3Zn/VZ0k68jeL/5t9
         IgppkNMH4xKhslCbAZ5Mt7tEcs86l8WcUIU2SWL97sDtgDirjZ3gb3KrccWdWyMz15vH
         crMQbCHDIYmG14z8rDvcyWQ0SNFQsgdJgNg0mXDWD/cR+uzPqu/zGv7psKK9VHXJfjBq
         SZDdneuxqGW+SyqUrro3R+D6x7urxRtW32tED+hlFh1zsnDID3Zq08RsopPAPByCWubP
         J5MER8WEkYkVclS25H9gDABefCHFiezPcrLACDg2sPoecGLx21izi39lsT6ONr+CijLg
         vlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698115893; x=1698720693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZaWM6/+je0+6Ad3eiiKjXQ3HfajEyj0oCdz07xSxDw=;
        b=q17pw/KeB631du8rHoBJhLajTzN1UlpPkyiPYDgiftX/if+6u0XlQwH4u9oolbKdEx
         CdUqwmUoFydWVbE2p7b4V6eS+pyN41kr16cy7cIMZqHEXjvm326ZfPyGLmLXz793UUaK
         9asIOyAZdbP4vV5EO0y7oDtKYRZBiIrzvfIXGwlnSe0E1KNM0RMfnKUhGUbJ1izPHU0G
         UhVsyedYtVLnVuDM5ule86AGGBANO3lwmYbTklnZ8ShDkuovJQ1ljt0Gf0E6unLD93x5
         XKUPHhpWxehjjyE4F1FKmLN7tR5r74B+IZ26pC0zIGNYabKWfPkvq3w/t66nfw1dCfyY
         9fpg==
X-Gm-Message-State: AOJu0YyORpUw3aPQDvmuS2N9J1g67e/BStn2IrTJRWKlhYQH0/KwTHgg
        7pt6mfsBDqoZDJtkvCcaVHmSj/tKv6tQuPsMt3w=
X-Google-Smtp-Source: AGHT+IE15gUn9K7p+MAoiUp78PHfvPFV8p3z4lXTdH0WVzVhQJC7geJvFnoRawPbvYwyDQxTWNWSLhDT2MuUwDpIUfo=
X-Received: by 2002:a05:6512:10c9:b0:507:aa8d:a572 with SMTP id
 k9-20020a05651210c900b00507aa8da572mr9566227lfg.49.1698115892433; Mon, 23 Oct
 2023 19:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me> <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
 <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
 <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com>
 <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com>
 <CAO+kfxQtOKoKdb+LtMeFxgu8VXa73nbmTPSfscbdwjUXM7ME_A@mail.gmail.com>
 <CAH2r5msNf9WDHrBZSi5FhHDSewSNxMAuXTetMJDnoNh3CF_oMA@mail.gmail.com>
 <a895f860-11fa-e6d9-d042-a32bd08f9e9d@talpey.com> <CAH2r5mszCxPtdURenMVgeVDX5zc8knumH=ASXyUufPa7SxbJBw@mail.gmail.com>
 <ZRN9MtBqYnT6oX60@vaarsuvius> <85d538fec5a086acf62d5a803056586a6c00e4bd.camel@uniklinik-freiburg.de>
 <83d00d50bc628a85db71adb440d8afb5@matoro.tk> <E1F307C7-9B1E-40F6-860B-6050856E8395@manguebit.com>
 <CA6E0F87-65FD-4672-AA0C-A761E5006B7D@manguebit.com> <CAH2r5mse_2sfXF+tdTmie5LLtBuc+6DOumDH3rn=5V24yhrYVQ@mail.gmail.com>
 <c88b2ecd27524153c2acd8aba6ae3c80@matoro.tk> <457a5483c3c4ca5bb6c7ec6f4231074c.pc@manguebit.com>
 <779ef3ac542e7e39027dee19d669ad2f81b05bcc.camel@uniklinik-freiburg.de> <b8e37bfc992532038f9d562f5596cbf3.pc@manguebit.com>
In-Reply-To: <b8e37bfc992532038f9d562f5596cbf3.pc@manguebit.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 23 Oct 2023 21:51:21 -0500
Message-ID: <CAH2r5muM71aR9gwgu7ep0dP3SBTkMjVnH5OmXz5JEiB2JsuBBw@mail.gmail.com>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
To:     Paulo Alcantara <pc@manguebit.com>
Cc:     "Dr. Bernd Feige" <bernd.feige@uniklinik-freiburg.de>,
        "matoro_mailinglist_kernel@matoro.tk" 
        <matoro_mailinglist_kernel@matoro.tk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "paul@darkrain42.org" <paul@darkrain42.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "ronniesahlberg@gmail.com" <ronniesahlberg@gmail.com>,
        "bharathsm@microsoft.com" <bharathsm@microsoft.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "brian.pardy@gmail.com" <brian.pardy@gmail.com>,
        "nspmangalore@gmail.com" <nspmangalore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We probably want this one as well ...

commit 2da338ff752a2789470d733111a5241f30026675
Author: Steve French <stfrench@microsoft.com>
Date:   Tue Sep 19 11:35:53 2023 -0500

    smb3: do not start laundromat thread when dir leases
     disabled

    When no directory lease support, or for IPC shares where directories
    can not be opened, do not start an unneeded laundromat thread for
    that mount (it wastes resources).

    Fixes: d14de8067e3f ("cifs: Add a laundromat thread for cached director=
ies")
    Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
    Acked-by: Tom Talpey <tom@talpey.com>
    Signed-off-by: Steve French <stfrench@microsoft.com>



Any objections to adding that one to the list as well?  The patches
all seem to apply fine to current 6.5-stable-rc

On Mon, Oct 23, 2023 at 9:07=E2=80=AFAM Paulo Alcantara <pc@manguebit.com> =
wrote:
>
> "Dr. Bernd Feige" <bernd.feige@uniklinik-freiburg.de> writes:
>
> > I can confirm that the patches apply cleanly on 6.5.8 and help a lot
> > with the issue here (vers=3D3.1.1, gentoo client, MS AD server with DFS=
).
>
> Thanks for testing it.
>
> Steve, I would suggest below commits for v6.5.y
>
>         238b351d0935 ("smb3: allow controlling length of time directory e=
ntries are cached with dir leases")
>         6a50d71d0fff ("smb3: allow controlling maximum number of cached d=
irectories")
>         2da338ff752a ("smb3: do not start laundromat thread when dir leas=
es  disabled")
>         e95f3f744650 ("smb: client: make laundromat a delayed worker")
>         81ba10959970 ("smb: client: prevent new fids from being removed b=
y laundromat")
>
> If OK, please ask stable team to pick those up.



--=20
Thanks,

Steve
