Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C959F7D145B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjJTQtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJTQs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:48:59 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EF6CA;
        Fri, 20 Oct 2023 09:48:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e84912038so1542295a12.1;
        Fri, 20 Oct 2023 09:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697820536; x=1698425336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCY85xuTO08uoVJ5sJjWD5Qhzy1JSbB53Ehoe5wYMoI=;
        b=UgTEX0BPakXiOXtGOKyA05fs6C4b6d1Gfvr/c03WRLJkTlFbzvcpnod+kWYJZUXV97
         dVFfGrourcs29xBW6cN6/ZwR3UVlS90LQdN/lcObQNR9Ht+M/zGpBgGXXSVd0a2/o1gr
         4QdZuNXw58lKydZfTnQzYQQh3GxBdRqrSOZCRJ27dPCSpBO2D61MDBf1lZRxV0cTNJUM
         KyE4Qz1sV4LY4qFnh+v/F8yUPJNWzrl7/Bav87HWnHIKcS38yZqUJEOIm0fJiAnI0P8w
         MNhgdqjpz48Mp7bAT8fKL7AY96lk0l6oezLEWhAFI6hvgFbTiwCzukwGt0oNZfBWppAb
         Xibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697820536; x=1698425336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCY85xuTO08uoVJ5sJjWD5Qhzy1JSbB53Ehoe5wYMoI=;
        b=EN9J46qNsjnBt4uTuEglrGc762TiAZ4ryLCYoayJtXT25rHQgLw8Hh8mxRpkC71gh1
         JfDdX9YprY2TGLQ2HSk23Y9YkHrasZ+ijPZEfWTqoaDUaKzO66YjJxw4/U+lVyHD/eY5
         Qm1vg628CXfTa1i/SZtphCs2VtmqjaTEqNXF0iaZS4UMpJzBGmwNYy0+eV3TnL+YLQdH
         8IT2Vpf2htbi2OUeeS3nnlQF3+Jcb36K4jaQwqYBL29x+X83Ntfu1EG0u6Ywsgtn29dJ
         yK+YJ7HX1wlXAEBkOtBKMo6ivX1VcRNh9WW/l58c5mrR77hZLjnANgelbBzVPP/Vg/Nw
         QBEA==
X-Gm-Message-State: AOJu0Yx/7Ayzck36AOVSPQy2IFu/cVm+2DvLBFeW1PEAoiFg14brGX1p
        dRLOZQGJTIq4mqTn4ZOtDroO57ufidNd2bfmK74=
X-Google-Smtp-Source: AGHT+IGW2lvHZ4U2Sa/juwb72YzMtwtj75+r7KRDh8aNhIC59iXnmxNmzWq2ecfrTu6447JW9abFxQeFs00rzCSY+BY=
X-Received: by 2002:a17:907:74a:b0:9be:4bfd:6a6c with SMTP id
 xc10-20020a170907074a00b009be4bfd6a6cmr1766721ejb.41.1697820536140; Fri, 20
 Oct 2023 09:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <ZTEt7NqfDHPOkm8j@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
 <CAM+2Eu+ndzS9NLvsZaX_=YTHb_+t4cE5GjQevJ1Lgc2EBO20rA@mail.gmail.com> <c623b6ff-6d6c-4351-b828-4ed4663f9de9@gmail.com>
In-Reply-To: <c623b6ff-6d6c-4351-b828-4ed4663f9de9@gmail.com>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Fri, 20 Oct 2023 22:18:44 +0530
Message-ID: <CAM+2EuJ8J+sJNBqbPuFLXVK-Y9V=q+Lt=js9giWdSZ6H=aJ2Jg@mail.gmail.com>
Subject: Re: [PATCH] iio: kx022a: Fix acceleration value scaling
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Oct 20, 2023 at 5:39=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> On 10/19/23 21:21, Jagath Jog J wrote:
> > Hi Matti,
> >
> > On Thu, Oct 19, 2023 at 6:54=E2=80=AFPM Matti Vaittinen
> > <mazziesaccount@gmail.com> wrote:
> >>

> >> I did only very quick testing on KX022A and iio_generic_buffer. After
> >> the patch the values seemed to be correct order of magnitude. Further
> >> testing is appreciated :)
> >
> > Values are correct with this change, Thank you for fixing.
> > Tested-by: Jagath Jog J <jagathjog1996@gmail.com>
>
> Thanks a ton for testing! May I ask which component did you use (or did
> you just use some 'simulated' regster values?)

Hi Matti,

I just simulated with the register values, Should the 'tested-by' tag only =
be
provided after hardware testing? I referred to this driver because it's
the most recent accelerometer driver that was merged.

Regards
Jagath
