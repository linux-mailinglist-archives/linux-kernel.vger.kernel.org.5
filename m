Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A01B7A6AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjISSYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISSYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:24:03 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78378F;
        Tue, 19 Sep 2023 11:23:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-502153ae36cso9731232e87.3;
        Tue, 19 Sep 2023 11:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695147836; x=1695752636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwdzojJepsaJdah6ocqUuoQIoGD1sEl1BnvEuQsR990=;
        b=lmDUWyV180yTarYyqkD+KocaH+jqK59jvlsZONl5T10vmVuwH2QSXmEWwUKlURDd5R
         Dmv2CXyin2OLsRB+fYqcZZ/ge0tFIg197L+ylXVoSEiS05vhyVa1Wrk8g3bgfJ98jncy
         WpSDZBXiCHRKdeKQk5iH9bhwj8yjZLYjIy7k37H7cKGTOYdtYX4h/U9dk6ZG5Rvb0LrY
         ntDUFv4XEIOiqHQJ7eVM4UGd78qh8JycITqhcz5C0PizCaiB0RD87rOHL/51YRT9Pplx
         3RhNfkvBnnvpC309jf44tSdr/MADSp6JZL7FQpCKklBldq3WHdOiwCzcDfY/J3POw1dD
         /zAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695147836; x=1695752636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwdzojJepsaJdah6ocqUuoQIoGD1sEl1BnvEuQsR990=;
        b=fEnE31PbeZgTTwupG5vbZ5i7lCBCGQwoyM65UA01WMw1MCzbgs2tQIHF4Yy7ngh8KR
         E7nQRggh+Jzc4MyMWuzmzu4E0PInK5bHZjJvjZJ/VHSoqO4nSlCmHoQ+kq9QW8YvZmsz
         vcT1/tSzHPsLmEe2S8Ps9U70nT+o8lcDWPbkBsQp4zlsbkUcyIK9cM/oUDTX1m3Rcm9/
         p8N2wzRIobYrrz0tLCproyIi2swX4yKf5ZaP/e+/Kl5mdjgvu27WOxbX9dvfam7bb5BA
         xd9NhU37NXhIxRNu9iC6V+yrxcx3ra9c6nPMvpNEyi2Zg8PbGPpvg/o6Qvzi+2Tbly3U
         1dSA==
X-Gm-Message-State: AOJu0YxphvHgEo2oYj6uapeZWsAQE8htvwWK6ljinNk22AmoAyx3qMq+
        8U2MzQkaAKV03UKb+OvHl6r5On6VlZhvin/BK28=
X-Google-Smtp-Source: AGHT+IG7gFNTF7iTz5rY5TEprFxZe6zQ90t2hC4Tzng9aArvXIfBQ31lvfKSBX8kjpfFzT5cXvxUkkCpkmu2BVUC1vk=
X-Received: by 2002:a05:6512:2f6:b0:4f9:6842:afc with SMTP id
 m22-20020a05651202f600b004f968420afcmr370132lfq.64.1695147835658; Tue, 19 Sep
 2023 11:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me> <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
 <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
 <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com>
 <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com>
 <CAO+kfxQtOKoKdb+LtMeFxgu8VXa73nbmTPSfscbdwjUXM7ME_A@mail.gmail.com>
 <CAH2r5msNf9WDHrBZSi5FhHDSewSNxMAuXTetMJDnoNh3CF_oMA@mail.gmail.com> <a895f860-11fa-e6d9-d042-a32bd08f9e9d@talpey.com>
In-Reply-To: <a895f860-11fa-e6d9-d042-a32bd08f9e9d@talpey.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 19 Sep 2023 13:23:44 -0500
Message-ID: <CAH2r5mszCxPtdURenMVgeVDX5zc8knumH=ASXyUufPa7SxbJBw@mail.gmail.com>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
To:     Tom Talpey <tom@talpey.com>
Cc:     Brian Pardy <brian.pardy@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Paulo Alcantara <pc@manguebit.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Bharath S M <bharathsm@microsoft.com>
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

On Tue, Sep 19, 2023 at 1:07=E2=80=AFPM Tom Talpey <tom@talpey.com> wrote:
>
> On 9/19/2023 9:38 AM, Steve French wrote:
> > Minor updates (pointed out by Paulo) to patch. See attached.
>
> So, was the thread crashing before??
>
> +       if (cfids =3D=3D NULL)
> +               return;
> +

Without laundromat initialized cfids can be null - so we need to check
if cfids is initialized in a few places (may help in a few corner
cases if there is a race in closing laundromat thread at umount but
was added to avoid oops at unmount if laundromat not initialized)

> These changes are good, but I'm skeptical they will reduce the load
> when the laundromat thread is actually running. All these do is avoid
> creating it when not necessary, right?

It does create half as many laundromat threads (we don't need
laundromat on connection to IPC$) even for the Windows server target
example, but helps more for cases where server doesn't support
directory leases.

> > On Tue, Sep 19, 2023 at 8:21=E2=80=AFAM Brian Pardy <brian.pardy@gmail.=
com> wrote:
> >>
> >> On Tue, Sep 19, 2023 at 1:36=E2=80=AFAM Steve French <smfrench@gmail.c=
om> wrote:
> >>>
> >>> Does the attached patch help in your case?  It avoids starting the
> >>> laundromat thread for IPC shares (which cuts the number of the thread=
s
> >>> in half for many cases) and also avoids starting them if the server
> >>> does not support directory leases (e.g. if Samba server instead of
> >>> Windows server).
> >>
> >> Hello,
> >>
> >> I applied the 0001-smb3-do-not-start-laundromat-thread-when-dir-leases=
-.patch
> >> you provided against the 6.5.3 kernel.
> >>
> >> I can confirm that it resolves this issue - no laundromat threads are
> >> created, and the reported load average is as expected, not falsely
> >> high.
> >>
> >> This appears to fully fix the issue in my case.  Thank you very much!
> >>
> >>> On Mon, Sep 18, 2023 at 10:00=E2=80=AFPM Steve French <smfrench@gmail=
.com> wrote:
> >>>>
> >>>> Paulo and I were discussing the laundromat thread at the SMB3.1.1 te=
st
> >>>> event (at SDC this week) which is now going on - will let you know
> >>>> what we find.
> >>>>
> >>>> One obvious thing is that it probably isn't necessary for cases when
> >>>> the server does not support directory leases, but we noticed another
> >>>> problem as well.
> >
> >
> >



--=20
Thanks,

Steve
