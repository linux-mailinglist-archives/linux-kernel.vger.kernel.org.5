Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084A87E89F0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 09:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjKKIx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 03:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKKIx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 03:53:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FFA3C3C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 00:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699692757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYs9FeoeYol+rxwOreW/7O3xwXAsfGjJ3zubYSRMfKc=;
        b=iQlJlXgikABPZQeEvrk9CAovzYTr7TpLr8A4DTt2lV8ZVVlViN97y0r6OPP4WGrjI7Ytg/
        6frkTv6U0PrefICBkjtwHpilVMBe+RNm26AOsA+HLCz/fmKDrvuvq9Wt31tMbtwURBIhlK
        g39m1JaC2/6IoLMilYast8/30txmNgA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-nIHtv1wZOpa80aLFaJqzsA-1; Sat, 11 Nov 2023 03:52:35 -0500
X-MC-Unique: nIHtv1wZOpa80aLFaJqzsA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-542fe446d45so2198329a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 00:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699692754; x=1700297554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYs9FeoeYol+rxwOreW/7O3xwXAsfGjJ3zubYSRMfKc=;
        b=glnV4imtq2s63Fb35OIX98Tuqnpn+KpDq7ij5bLoerd/CnBx/ufw0aDy3bAd3g0Bwr
         wbI/do33z/qV4lg4HF3Gz7t7PxPKcKi5BLaCeI7xgsJOLN8sACqP29ys3/4W71446N81
         W1Q2KO68Z+NgGXrD4ssiLQf4g8UqqJ0E2VDtESnVYtGSWeRkI6Sw7ZRpXhPVBSokw3so
         Xzs8jxItdBNNNy04YSih39gdJEurceQNeVNT3Um83yQILdphi34CX0hWF8nU9WjOQ0bK
         G33A2gBYmAwvcXDg6IoTDzL7cdpDC5d/BKvnaFotrWUYB7ysClm5OmEGPByzqt4fk6O5
         xLVg==
X-Gm-Message-State: AOJu0Yy7iuiCaaJTfPzTu//Pf/x7wPydND12YOdzMJ+zLRYcTcD6KUvg
        3dnbXNCUk0QClka6397TlZ0H/juBYRkvueIWZbYX4mNXAIp4FmqyRidF4smhrY/Xn8pDr3rOc3V
        9Qz5CFqS+IFs2VL5ejqBiqLw5QuH+ymlzdoSs9LPx
X-Received: by 2002:a05:6402:2022:b0:543:54da:1a37 with SMTP id ay2-20020a056402202200b0054354da1a37mr991756edb.6.1699692754326;
        Sat, 11 Nov 2023 00:52:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJYQWi2V3D3IDvJp5SQ14/RkGN22eRWhQZh6OTfPD2qJKV3eHpl7I/7gtmLEJi8hEXvDDKu9DjUh/0rkj69YA=
X-Received: by 2002:a05:6402:2022:b0:543:54da:1a37 with SMTP id
 ay2-20020a056402202200b0054354da1a37mr991749edb.6.1699692754051; Sat, 11 Nov
 2023 00:52:34 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <20231108062306.33f5dcd0@dryade> <CAO-hwJK_xp1A=dEOV-2v3KJAf0bRLDWNcrFQeBpgEuxT-qSBnw@mail.gmail.com>
 <ZUtTpKyP0oxWhnn8@fedora> <CAO-hwJLjtjdr2gtrOWJFPZ-38YzKB8XfhDKWf_2jUPeiaP3EcA@mail.gmail.com>
 <CAO-hwJKNcwcDGEh33NZq4kSYtoxZzg9M2nzE_hVDYNFgA4g_dg@mail.gmail.com>
 <_DEF7tHL1p_ExY7GJlJvT5gRA7ZvNnVMJuURb8_WCV-0fbYXkLN2p5zHloi6wiJPNzGEjFAkq2sjbCU633_eNF_cGm0rAbmCOOIOfwe1jWo=@protonmail.com>
 <CAO-hwJ+zm=R7NwrALaLVmfPDtMNXpj0eoQgLkiS1wa6wd+hu+A@mail.gmail.com>
 <CAO-hwJKJW5jGDdaaS8eB7kcLQUvWO_1XkOzJG4HAcaRzw1cGnQ@mail.gmail.com> <7wmtNlKuYResf5cFQ7M2QTalzIUtw0I6ohvPcz69Jo1c8flezyIlnJu1IwAgXhJ-u0NlRL3IV7HnL0Kza6fVBqd7X7jhc-Z6QCi3oqHEvpY=@protonmail.com>
In-Reply-To: <7wmtNlKuYResf5cFQ7M2QTalzIUtw0I6ohvPcz69Jo1c8flezyIlnJu1IwAgXhJ-u0NlRL3IV7HnL0Kza6fVBqd7X7jhc-Z6QCi3oqHEvpY=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Sat, 11 Nov 2023 09:52:21 +0100
Message-ID: <CAO-hwJJ+nx72_TPfxcWRPBDZdDaPrO5yMNH4Y_mj6ej651Mesw@mail.gmail.com>
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
To:     David Revoy <davidrevoy@protonmail.com>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Eric GOUYER <folays@gmail.com>,
        Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        jkosina@suse.cz, jason.gerecke@wacom.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, Nov 9, 2023 at 11:04=E2=80=AFPM David Revoy <davidrevoy@protonmail.=
com> wrote:
>
> Hi Benjamin,
>
> Thank you it works! =F0=9F=8E=89 =F0=9F=8E=89 =F0=9F=8E=89
>
> > I've pushed an update of the file[0], turns out I made several mistakes=
.
> > As a general rule of thumb, you can follow the MR I've opened at [1],
> > click on the pipeline, open the last job ("make release"), then browse
> > the artifacts and pull the file from there.
> > [...]
> > > But just to be sure, you don't have a custom configuration in place
> > > for that tablet device?
> > [...]
> > [0] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/jobs/5139939=
2/artifacts/file/udev-hid-bpf_0.1.0.tar.xz
> > [1] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_reques=
ts/27
>
> I tested the latest artifact on kernel 6.5.8-200.fc38.x86_64 and I also r=
emoved my custom configuration at startup (I had not much: an hwdb files fo=
r the 24 Pro =E2=88=92mainly for frame buttons=E2=88=92 and an xsetwacom ba=
sh script for each tablet).
>
> During the tests, the styluses of both 24 Pro and 16 Pro Gen2 worked perf=
ectly: right-click on upper button out-of-the-box, and the eraser tip of th=
e 16 Pro Gen2 continued to erase as expected.

While polishing the patches yesterday I realized that there was a bug
on the 24 Pro: it would never send proximity out events unless on a
very specific case: if you hold the pen perfectly vertical. This might
have an effect on the session and the pen behavior.

Could you please once again attach the hid-recorder of the Pro 24
while doing the following sequence:
- touch with the tip of the stylus the tablet
- while touching, press the upper button (the problematic one)
- still while touching, release the button
- remove the stylus

I need it to check what the device is sending when an "eraser mode
button" is pressed while the tip is touching the surface. Because I
think that's the only one problematic proximity out event as it would
"break" the current touch.

I have created another MR[2] to fix that, and I would appreciate it if
you could also give a test of the artifacts of job 51469284[3].

The points to check are:
- if you right click while touching the surface, do you still get only
a right click or some weird glitches in addition to it?
- if you right click while not touching (hovering), no glitches?

Cheers,
Benjamin

>
> I could also target with xsetwacom this 'button 3' of the styluses, and I=
 tested random available shortcuts (but I'll keep default right-click).
>
> So, good job, and many thanks!
>
> I want now to write a follow-up after the first blog-post. I see it is a =
MR [1], maybe it means if it get merged it will be part of libevdev? What w=
ould you advice to write for the ones who want to benefit from the fix?
>
> Thanks again,
> David
>
> [1] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests=
/27
>

[2] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/3=
0
[3] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/jobs/51469284

