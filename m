Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF56B793A97
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbjIFLDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbjIFLDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:03:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941CE1BB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:03:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-500cfb168c6so5803972e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1693998212; x=1694603012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cP1GgEPsuH5x3JwCdVLlQl6m1HOoYau4dFR4xNCE00=;
        b=UorI0YmeynhPkNvprOgRfYrsJ5o9LKPskI3FOdtg9wDVY33E7XSBX8Zqo+aPVVR70q
         sVREWufSBEYeEgD22Sa/LWymVTPbKY/y2Zq2ytjRYfo6fti5IfKZPlAG6qyn2HOvvNjv
         NzsmMO1CXkf/xroLTu6/5ZfmSqGMzZorHUvi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693998212; x=1694603012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cP1GgEPsuH5x3JwCdVLlQl6m1HOoYau4dFR4xNCE00=;
        b=KoMzkdG9e3vxL7Ys3XR0135DW/C+zwR84AQfJSkPF3RIaTtemlYpFDldo4mhFGNRKg
         CnqcR+gXSqlSrLKNigWXObt8D6pyZFkTndWj8A2JiHP3+q6Y7povb17YGwIWl1vumLYI
         3BCsGOs7aNxsFxr1NTeC/5yEIt4hdV+kh9V/RdhM8bYjk6u2qE8DqFcjWUqgQeFntt9s
         R9O37oJ1TQq3eKCyiEuFLN/nY4hQkp5KfdxqOxh2AkxUynp5bIunz2a3yTbuqNAvEPzI
         c7OPv+yunZcbxX4eWSS2KtUR++jyXP3mpnk1GXgZaDzKfhdeyxFqCLUZ2y0tqFQJ67Zl
         en1Q==
X-Gm-Message-State: AOJu0Ywksf9JIAkojzVyq+OWYlQVb4VWviHPaFmBxxoBf/XGsEfX2ZBJ
        N3rpZS/V9ZA1ynMe7gXkV7vHSfww9PEyFVfJ+eLeAAedkbtQGPw/xg==
X-Google-Smtp-Source: AGHT+IGajkHriDp2V73gLnt8w9Q25yWyd69bww3RGThTXV/dyVspDiEGJ6yxe7gAgW9hORJWYBsEuf4z+KZwKyH4opw=
X-Received: by 2002:a05:6512:2393:b0:500:b5db:990b with SMTP id
 c19-20020a056512239300b00500b5db990bmr2354910lfv.47.1693998211695; Wed, 06
 Sep 2023 04:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <878r9sga1t.fsf@kernel.org> <CAG7k0Epk6KJvoDJKVc86sc_ems3DTbKvPLouBzOoVvn1tZwQ=w@mail.gmail.com>
 <87o7ifelt7.fsf@kernel.org>
In-Reply-To: <87o7ifelt7.fsf@kernel.org>
From:   Ross Lagerwall <ross.lagerwall@cloud.com>
Date:   Wed, 6 Sep 2023 12:03:20 +0100
Message-ID: <CAG7k0Ep6ZT6f_wcr67ZOz-kDjNx2M-wax8QFoA5-WfyMhycR3A@mail.gmail.com>
Subject: Re: [regression v6.5-rc1] PCI: comm "swapper/0" leaking memory
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 9:40=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrote:
>
> Ross Lagerwall <ross.lagerwall@cloud.com> writes:
>
> > On Wed, Aug 30, 2023 at 10:21=E2=80=AFAM Kalle Valo <kvalo@kernel.org> =
wrote:
> >
> >>
> >> I noticed that starting from v6.5-rc1 my ath11k tests reported several
> >> memory leaks from swapper/0:
> >>
> >> unreferenced object 0xffff88810a02b7a8 (size 96):
> >>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
> >>   hex dump (first 32 bytes):
> >>     80 b8 02 0a 81 88 ff ff b8 72 07 00 00 c9 ff ff  .........r......
> >>     c8 b7 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  ................
> >>   backtrace:
> >> unreferenced object 0xffff88810a02b880 (size 96):
> >>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
> >>   hex dump (first 32 bytes):
> >>     58 b9 02 0a 81 88 ff ff a8 b7 02 0a 81 88 ff ff  X...............
> >>     a0 b8 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  ................
> >>   backtrace:
> >> unreferenced object 0xffff88810a02b958 (size 96):
> >>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
> >>   hex dump (first 32 bytes):
> >>     30 ba 02 0a 81 88 ff ff 80 b8 02 0a 81 88 ff ff  0...............
> >>     78 b9 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  x...............
> >>   backtrace:
> >> unreferenced object 0xffff88810a02ba30 (size 96):
> >>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
> >>   hex dump (first 32 bytes):
> >>     08 bb 02 0a 81 88 ff ff 58 b9 02 0a 81 88 ff ff  ........X.......
> >>     50 ba 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  P...............
> >>   backtrace:
> >> unreferenced object 0xffff88810a02bb08 (size 96):
> >>   comm "swapper/0", pid 1, jiffies 4294671838 (age 98.120s)
> >>   hex dump (first 32 bytes):
> >>     e0 bb 02 0a 81 88 ff ff 30 ba 02 0a 81 88 ff ff  ........0.......
> >>     28 bb 02 0a 81 88 ff ff 00 00 00 00 00 00 00 00  (...............
> >>   backtrace:
> >>
> >> I can easily reproduce this by doing a simple insmod and rmmod of ath1=
1k
> >> and it's dependencies (mac80211, MHI etc). I can reliability reproduce
> >> the leaks but I only see them once after a boot, I need to reboot the
> >> host to see the leaks again. v6.4 has no leaks.
> >>
> >> I did a bisect and found the commit below. I verified reverting the
> >> commit makes the leaks go away.
> >>
> >> commit e54223275ba1bc6f704a6bab015fcd2ae4f72572
> >> Author:     Ross Lagerwall <ross.lagerwall@citrix.com>
> >> AuthorDate: Thu May 25 16:32:48 2023 +0100
> >> Commit:     Bjorn Helgaas <bhelgaas@google.com>
> >> CommitDate: Fri Jun 9 15:06:16 2023 -0500
> >>
> >>     PCI: Release resource invalidated by coalescing
> >
> > Hi Kalle,
> >
> > I can't reproduce the leak by loading/unloading the ath11k module. I su=
spect
> > that the leak is always there when PCI resources are coalesced but
> > kmemleak doesn't notice until ath11k is loaded.
> >
> > Can you please try the following to confirm it fixes it?
>
> I run various tests with your patch and I don't see leaks anymore. I
> also veried that without your patch I see the leak immediately.
>
> Thanks for fixing this so quickly, it would good to have this fix in
> v6.6 if possible.
>
> Tested-by: Kalle Valo <kvalo@kernel.org>
>

Thanks, I will send out a proper patch now.

Ross
