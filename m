Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED897944EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244658AbjIFVEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjIFVEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:04:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A79310F1;
        Wed,  6 Sep 2023 14:04:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c4923195dso19225166b.2;
        Wed, 06 Sep 2023 14:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694034241; x=1694639041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayxzwMlaIa8aBHyrJnwJW2G9gVUNOm3mCQTU2C2XbwE=;
        b=ZqoN7n61dXjoRJLwNYjhnTmitRpPvlcQpUEZXB9oGb1dqxDtKPZvd0zuUu/X9F4ZqJ
         6J3tQEvxrfw0TW/lndg5ikCf+R55vVvPQ1d9DRuvG+4r24NB79Z7MUjBbFkaIOMvztjn
         NLvgBcBwqjgWyeCeF8coHgqyt/Qz2VtuWJVs1hzr/y5X9zmAeUslgs+rYv4Ay8lQOxLO
         bSJeptlBQtzChsB5IRknDPTxbJFzuZfdIs0BGZ6onO6cETwTvcT4+VzsAeNq4IrN1TbF
         d0OgPj9H4JL3CJjP/YsHrMRyms7zlnKFeNL3WpKGPrcAixuGTCb6pH43AFQnSkhsza8A
         wkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694034241; x=1694639041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayxzwMlaIa8aBHyrJnwJW2G9gVUNOm3mCQTU2C2XbwE=;
        b=WYuETefHs3ySacWAwpJ6zLoz+bkurJll/jfPareZiiqKDZjlFYDptWPQxzpFDfd3Qp
         VCwHmDlTLjuhpfObzr3+UMzlBqPWo1ntbesKrFvNt49rQwbBs0OxwSEqjtzqaiP61XoZ
         WmfJflNpvlySsNiNR7HNYGn5D7CO9KU0NvkBa64ghheHX8NxRGp3Xs/tt4eBXGYAQmmQ
         62jiMupRiJ6LYsly6c78L8+aR/ImUmxSI/y2fpcr12bYbv4k3r02kyWkfxu3CLMbpXUL
         mQP+GzStoHR9qlOx74aMivzlR/JvYMrckYkCQFzD2Dnl0C5iNm6N6wK8KmDLgS78B9k2
         YCOQ==
X-Gm-Message-State: AOJu0YyYFOtg96nqtPE5YTJYzk7ViGQN2PwfalpumRZMYD7E3pusEon3
        W7AsS5wXOaWP/VzZF5vQPUEmSWJe0ktcxhO0t8O1BIrI
X-Google-Smtp-Source: AGHT+IHZFaYn2Ozf5KGvXEZ9HNBQtrzOXhDAjhZYSjPt87z8JWO2xSAnqi44xFQC2aNFozkZOHjZj5OOMGgIb/uy278=
X-Received: by 2002:a17:906:297:b0:9a5:c5fe:af85 with SMTP id
 23-20020a170906029700b009a5c5feaf85mr3614951ejf.3.1694034240716; Wed, 06 Sep
 2023 14:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me>
In-Reply-To: <ZPfPfyIoVxw5L6El@debian.me>
From:   Brian Pardy <brian.pardy@gmail.com>
Date:   Wed, 6 Sep 2023 17:03:48 -0400
Message-ID: <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>
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

Added committer Ronnie Sahlberg to CC.

On Tue, Sep 5, 2023 at 9:01=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
> On Tue, Sep 05, 2023 at 01:09:05PM -0400, Brian Pardy wrote:
> > I've noticed an issue with the CIFS client in kernel 6.5.0/6.5.1 that
> > does not exist in 6.4.12 or other previous kernels (I have not tested
> > 6.4.13). Almost immediately after mounting a CIFS share, the reported
> > load average on my system goes up by 2. At the time this occurs I see
> > two [cifsd-cfid-laundromat] kernel threads running the "D" state,
> > where they remain for the entire time the CIFS share is mounted. The
> > load will remain stable at 2 (otherwise idle) until the share is
> > unmounted, at which point the [cifsd-cfid-laundromat] threads
> > disappear and load drops back down to 0. This is easily reproducible
> > on my system, but I am not sure what to do to retrieve more useful
> > debugging information. If I mount two shares from this server, I get
> > four laundromat threads in "D" state and a sustained load average of
> > 4.
> >
> > The client is running Gentoo Linux, the server is a Seagate Personal
> > Cloud NAS running Samba 4.6.5. Mount options used are
> > "noperm,guest,vers=3D3.02". The CPUs do not actually appear to be
> > spinning, the reported load average appears incorrect as far as actual
> > CPU use is concerned.
>
> Thanks for the regression report. But if you want to get it fixed,
> you have to do your part: perform bisection. See Documentation/admin-guid=
e/bug-bisect.rst in the kernel sources for how to do that.
>
> Anyway, I'm adding it to regzbot:
>
> #regzbot ^introduced: v6.4..v6.5
> #regzbot title: incorrect CPU utilization report (multiplied) when mounti=
ng CIFS

Thank you for directing me to the bug-bisect documentation. Results below:

# git bisect bad
d14de8067e3f9653cdef5a094176d00f3260ab20 is the first bad commit
commit d14de8067e3f9653cdef5a094176d00f3260ab20
Author: Ronnie Sahlberg <lsahlber@redhat.com>
Date:   Thu Jul 6 12:32:24 2023 +1000

    cifs: Add a laundromat thread for cached directories

    and drop cached directories after 30 seconds

    Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
    Signed-off-by: Steve French <stfrench@microsoft.com>

 fs/smb/client/cached_dir.c | 67 ++++++++++++++++++++++++++++++++++++++++++=
++++
 fs/smb/client/cached_dir.h |  1 +
 2 files changed, 68 insertions(+)

I do not know what other debug info may be useful, but here is
/proc/[pid]/stack output for one of these threads in D state:

# cat /proc/17314/stack
[<0>] msleep+0x24/0x40
[<0>] cifs_cfids_laundromat_thread+0x5e/0x1c0 [cifs]
[<0>] kthread+0xc4/0xf0
[<0>] ret_from_fork+0x28/0x40
[<0>] ret_from_fork_asm+0x1b/0x30

I will provide any other details requested. Thank you.

#regzbot introduced: d14de8067e3
