Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A693B7A69D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjISRoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjISRnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:43:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6F4E7F;
        Tue, 19 Sep 2023 10:42:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-530ea522f5eso3363810a12.3;
        Tue, 19 Sep 2023 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695145376; x=1695750176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kny2NAkyZcSHmecq8iXutP5/vcR/e3ga9/aerU/vXg=;
        b=Sl7o99KxtRlUuyb6TtD0H3XQJ/fct5TjvkET8USkM+U3qSdo3Womqj/+RjeZdUzRR7
         H3OGwOh7Hoie4KhUlmJyRQ8KZeZW5RHUoQszu81kYOTTBN55ydG4dAdv/vEGBUjQfoyV
         GDHGPSwxu0v9tEYsRn5zCtlOwzhZIZExSvQEkCr3oteM6Q1yxBhT16mCFY6A7Bjnw2uG
         ub6dWrjELqg0GgEmII0bn13W6oUC7YKH5/lSu7768Tcs4blAFkorg5jI1QDA7FmbdzMi
         Xe1qaD2D2EOIfCpqIwX2a+Ndv1woNU11PBRAy7OudfoD3gda6CPzaGHYxMMcQb6s/VIg
         N+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695145376; x=1695750176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kny2NAkyZcSHmecq8iXutP5/vcR/e3ga9/aerU/vXg=;
        b=V2bn/v0uhs7+WTdCezg0SCmvnEJOHpLN8gF9HU9Ec9rPhlsOr532Q9V4cu0CDt1fAO
         tnq2n/GxqG2Er4zhHoke34jLkwm9J9A2/OtVoJAGjthbb95QrkfiC3xMDl7RYy05l4OP
         mLT3Pgf2BItbMjCZPkT1gaqc3LyvDM/MkKvbxnGWF9zIoaIHBJiseaYAONDAEf4woyZw
         VYrWfLLksQo+87Z2iqxWmAUGtnoMXZn9wW0dOv3eAiWmouiM57eGZEf03JT1QNffMuwy
         CZzexUq+pgDbR4N6Hv/80oEwnwirzm3CnikXQ1Rxd4fYSno44Z+HFfMjQjl7IGQDCJCp
         l1AA==
X-Gm-Message-State: AOJu0YyjRdLX804vVqN6nmR9RNrhCWPr7ZVPkdholL2LwVf3d7UvPnzv
        dlJLbZb72RcdRv6AVZV5gS+ckyLfmr1PvPFZ1GA=
X-Google-Smtp-Source: AGHT+IE6twjvIwO3u2Iuo7xdl0w22r53GB2hC5iMi6jq4Adj5X9LcZ61kvCJAbML/0D/GHEd0Fx1a8yrLELm4mkBBM0=
X-Received: by 2002:a17:906:18:b0:9ae:38c5:1d94 with SMTP id
 24-20020a170906001800b009ae38c51d94mr71777eja.70.1695145375580; Tue, 19 Sep
 2023 10:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me> <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
 <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
 <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com>
 <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com>
 <CAO+kfxQtOKoKdb+LtMeFxgu8VXa73nbmTPSfscbdwjUXM7ME_A@mail.gmail.com> <CAH2r5msNf9WDHrBZSi5FhHDSewSNxMAuXTetMJDnoNh3CF_oMA@mail.gmail.com>
In-Reply-To: <CAH2r5msNf9WDHrBZSi5FhHDSewSNxMAuXTetMJDnoNh3CF_oMA@mail.gmail.com>
From:   Brian Pardy <brian.pardy@gmail.com>
Date:   Tue, 19 Sep 2023 13:42:44 -0400
Message-ID: <CAO+kfxRS8JKympxZGKiP48cTdM+QQjd_4VX=Q5ix02gH7EJdeA@mail.gmail.com>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
To:     Steve French <smfrench@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
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

On Tue, Sep 19, 2023 at 12:39=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
>
> Minor updates (pointed out by Paulo) to patch. See attached.

I can't comment on the updates between the two versions of the patch,
but I can confirm that the second patch also works as expected to
resolve this issue on my system.

-Brian


> On Tue, Sep 19, 2023 at 8:21=E2=80=AFAM Brian Pardy <brian.pardy@gmail.co=
m> wrote:
> >
> > On Tue, Sep 19, 2023 at 1:36=E2=80=AFAM Steve French <smfrench@gmail.co=
m> wrote:
> > >
> > > Does the attached patch help in your case?  It avoids starting the
> > > laundromat thread for IPC shares (which cuts the number of the thread=
s
> > > in half for many cases) and also avoids starting them if the server
> > > does not support directory leases (e.g. if Samba server instead of
> > > Windows server).
> >
> > Hello,
> >
> > I applied the 0001-smb3-do-not-start-laundromat-thread-when-dir-leases-=
.patch
> > you provided against the 6.5.3 kernel.
> >
> > I can confirm that it resolves this issue - no laundromat threads are
> > created, and the reported load average is as expected, not falsely
> > high.
> >
> > This appears to fully fix the issue in my case.  Thank you very much!
> >
> > > On Mon, Sep 18, 2023 at 10:00=E2=80=AFPM Steve French <smfrench@gmail=
.com> wrote:
> > > >
> > > > Paulo and I were discussing the laundromat thread at the SMB3.1.1 t=
est
> > > > event (at SDC this week) which is now going on - will let you know
> > > > what we find.
> > > >
> > > > One obvious thing is that it probably isn't necessary for cases whe=
n
> > > > the server does not support directory leases, but we noticed anothe=
r
> > > > problem as well.
>
>
>
> --
> Thanks,
>
> Steve
