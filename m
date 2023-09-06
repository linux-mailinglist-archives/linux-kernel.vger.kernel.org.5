Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D04793C31
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjIFMFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjIFMFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42C0BF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694001866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vOfI0Z5MjhyLAvmIJXMu0/H7+FUMujUQo8bT5jmnZS0=;
        b=SqGhIE4ODGrAKbDnaCRbkbfyI1cNEB3OAuw1JQYh5T5RQg/5LX3hzAJGfnBpN+UXAabvhu
        7nvazkStnraJHN9/pdIE8I5hIil+4aAbuyToQTnot/PybVUrdRXZy5ah8YyKo+riB+WTC8
        HC6WqYRINqqXuSIKEqiDquvSH8ll+rk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-gNFUsWmPN6W3hHSVGl7abg-1; Wed, 06 Sep 2023 08:04:24 -0400
X-MC-Unique: gNFUsWmPN6W3hHSVGl7abg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fef3606d8cso22835455e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 05:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694001864; x=1694606664;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOfI0Z5MjhyLAvmIJXMu0/H7+FUMujUQo8bT5jmnZS0=;
        b=YEHHUFiuV9GnsjnpnlEBT7H52nipP4ZS3U7GV7LUmb5+KH6SO8KsSPa8lSLCrcFIsU
         cENvnThl4hSRnix57WQcj8g9VfwVrl8M86nBamf09gkvj0SLr/DuPhZtu6RxgWxqY9aN
         qc3rsFK3nvTC3pf5DMofncqzfPXWHvBEhsrd39x5IZvjOTdg7WlunUz3qIXqzby+Rpcr
         YvZhMBsriy9LG3Uw0/fkfP1ci3TqRQ8ppTAhogkD/O2Z638rmBAzQPzyW+PFiRLG5BYW
         8KwRgPw3NMxuzammG8E6S/856OAYxaW/HaGuufjx1Owp82rvEFkdAv+jxyMroMk2MRZr
         Dq/g==
X-Gm-Message-State: AOJu0Ywh7NORHAqLmsil1MjCwQbX14inhmjEOFdUlokUiU6/cEK0Qa1n
        tSlnCRyEQDfNmSkdZTdArIJJi/3q0Vf9pRstogATAyWn2KFd4Fq+g9/SRc7j6RRZUwM/ByoBK+9
        TnxXXvWZgnbhjB8/ricnSaLnG
X-Received: by 2002:a05:600c:253:b0:401:4417:a82d with SMTP id 19-20020a05600c025300b004014417a82dmr2100413wmj.38.1694001863936;
        Wed, 06 Sep 2023 05:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNZ+Dis0kcL2zRVNyKbfp8V20BhdGDTREB3kH9CFq79qQSpZoJFiutbgd3LwVFeQoDJjXsEA==
X-Received: by 2002:a05:600c:253:b0:401:4417:a82d with SMTP id 19-20020a05600c025300b004014417a82dmr2100392wmj.38.1694001863573;
        Wed, 06 Sep 2023 05:04:23 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z17-20020a7bc7d1000000b003fbdbd0a7desm22583278wmk.27.2023.09.06.05.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 05:04:23 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH] drm/ssd130x: Allocate buffer in the CRTC's
 .atomic_check() callback
In-Reply-To: <yvxmbpbeuis7zjqyg6yrpdfyr3oa2xstcoeb2prqvznczzhj5k@7i37gxyyqfn3>
References: <20230830062546.720679-1-javierm@redhat.com>
 <zitno3p7tbnld5auedkx5g4wey2csng4ncmtdhzinbuhblunyk@chnwsnsgq36v>
 <CAMuHMdWv_QSatDgihr8=2SXHhvp=icNxumZcZOPwT9Q_QiogNQ@mail.gmail.com>
 <4zfgmvfstyjfo5slggfmfuvnirrhrq773el52gkav2r6jxliub@7qjbyy7rkj3g>
 <CAMuHMdV_775mPbTgWmzCo4mKCd3kqL=vfVFrt2W=bR3uveNW_Q@mail.gmail.com>
 <yvxmbpbeuis7zjqyg6yrpdfyr3oa2xstcoeb2prqvznczzhj5k@7i37gxyyqfn3>
Date:   Wed, 06 Sep 2023 14:04:22 +0200
Message-ID: <874jk74iex.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <mripard@kernel.org> writes:

> On Fri, Sep 01, 2023 at 02:08:11PM +0200, Geert Uytterhoeven wrote:
>> Hi Maxime,
>>=20
>> On Fri, Sep 1, 2023 at 2:00=E2=80=AFPM Maxime Ripard <mripard@kernel.org=
> wrote:
>> > On Fri, Sep 01, 2023 at 10:36:17AM +0200, Geert Uytterhoeven wrote:
>> > > On Fri, Sep 1, 2023 at 10:22=E2=80=AFAM Maxime Ripard <mripard@kerne=
l.org> wrote:
>> > > > On Wed, Aug 30, 2023 at 08:25:08AM +0200, Javier Martinez Canillas=
 wrote:
>> > > > > The commit 45b58669e532 ("drm/ssd130x: Allocate buffer in the pl=
ane's
>> > > > > .atomic_check() callback") moved the allocation of the intermedi=
ate and
>> > > > > HW buffers from the encoder's .atomic_enable callback to primary=
 plane's
>> > > > > .atomic_check callback.
>> > > > >
>> > > > > This was suggested by Maxime Ripard because drivers aren't allow=
ed to fail
>> > > > > after drm_atomic_helper_swap_state() has been called, and the en=
coder's
>> > > > > .atomic_enable happens after the new atomic state has been swapp=
ed.
>> > > > >
>> > > > > But that change caused a performance regression in very slow pla=
tforms,
>> > > > > since now the allocation happens for every plane's atomic state =
commit.
>> > > > > For example, Geert Uytterhoeven reports that is the case on a Ve=
xRiscV
>> > > > > softcore (RISC-V CPU implementation on an FPGA).
>> > > >
>> > > > I'd like to have numbers on that. It's a bit surprising to me that,
>> > > > given how many objects we already allocate during a commit, two sm=
all
>> > > > additional allocations affect performances so dramatically, even o=
n a
>> > > > slow platform.
>> > >
>> > > To be fair, I didn't benchmark that.  Perhaps it's just too slow due=
 to
>> > > all these other allocations (and whatever else happens).
>> > >
>> > > I just find it extremely silly to allocate a buffer over and over ag=
ain,
>> > > while we know that buffer is needed for each and every display updat=
e.
>> >
>> > Maybe it's silly, but I guess it depends on what you want to optimize
>> > for. You won't know the size of that buffer before you're in
>> > atomic_check. So it's a different trade-off than you would like, but I
>> > wouldn't call it extremely silly.
>>=20
>> The size of ssd130x_plane_state.data_array[] is fixed, and depends
>> on the actual display connected.
>
> That one can be tied to the CRTC state if needed. It would only be
> allocated on each modeset, so probably once for that kind of device.
>

Yes.

>> The size of ssd130x_plane_state.buffer[]  is also fixed, and depends
>> on the plane's size (which is currently fixed to the display size).
>
> Doesn't it depend on the format as well?
>

Yes and no. The buffer[] size is fixed, but whether that intermediate
buffer is needed or not will depend if the native format was chosen.

So one could say that is either 0 (not used) or the fixed size needed
to do the format conversion from XRGB8888 to R1.

> Maxime
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

