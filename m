Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355887C8B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjJMQYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjJMQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:24:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8ACA9;
        Fri, 13 Oct 2023 09:24:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-536b39daec1so3852649a12.2;
        Fri, 13 Oct 2023 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697214250; x=1697819050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zizxzHDdvMghQ8MHo3aHnYXx7ejJUjFj9o4g619WJCQ=;
        b=JsHvwilsPDTjxAZ+XtOVJ8WyqONQWgXiYqseX3FoBljQhel1fQ2CUSGD62+i691mE4
         1GhLq5TW0r5tSuTwv3dKMfBhtjc916S0tYgebs1w1Z6o2pkcUwFCLPUqE/wWUy6RYHTt
         CQwsiDlM5SeCgUF0egkiL/3FBnPfIfkfkrFE2vx7rivt88OExzH6CfX7WIamsH+no4w9
         wEk2ljv9CLz0a6V2nYvwTycnOIOG4ep4ctPSTnMdD9sLWD0Fvr/r+bw8TZYJb0Uog4PW
         Tu5EVWnx+q3eOEyPLpiIRqzrBbReOUuaee6X4kdGnKLSNK5axJIz2mehgf08e9vgcWyh
         IiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697214250; x=1697819050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zizxzHDdvMghQ8MHo3aHnYXx7ejJUjFj9o4g619WJCQ=;
        b=tE+zRGVPkbDsrodSzFl+O97TsK64L/WfSJPkWpaLc4NA+P7rtEehWUVb2JJKCw2wYZ
         F2xpS4PwxZsCuSsTXWf87fnuI+eAiBQmCNI4NIOC0170Y+lp1IRNT9EYQnTahHbUyBxd
         DdhgfvG5hznHlRit8vTSFZbMK3wtjiVecLCKI5W8uRGLGrosnov58vo9wQ87JYhDmjko
         T5rnc/LmaZuvBUiZajpzJmPW7kRCEMBwwTuasHfiWie4fDwVMENEiagfgemD0xS6MrnE
         lq34FYRPyPfcnyj9cFeU8lOKiGK0Fr/sJIhxBXWXfdmejulHNG8qb9wpkBKeuxr1eOwa
         mIVg==
X-Gm-Message-State: AOJu0YxuHXQaetf2uIWoV84I8VgHbA3D6yQNCk5kCfoixj8ZjXAldlfX
        kyExlTKnazHcO+/emgfDuIRGYe9h+7B75tvtrGQq3q41ydE=
X-Google-Smtp-Source: AGHT+IEszXjFKSidX2y7Q+53gnLCwRD+Y69DadWTR+KKbDxL1IitJsgUwsdzTKiu3hi42npHihA53UsX/ig2NR0Z+Q8=
X-Received: by 2002:a50:d68f:0:b0:53e:4c39:5608 with SMTP id
 r15-20020a50d68f000000b0053e4c395608mr1455028edi.17.1697214249625; Fri, 13
 Oct 2023 09:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-2-jagathjog1996@gmail.com> <20230924143710.7c6edc4a@jic23-huawei>
 <CAM+2EuJ8o5X2ucph8gic2=03bbLQmUCX=j3SFLrqD4Y6rwXs9A@mail.gmail.com>
 <20230930170530.0b8f185c@jic23-huawei> <CAM+2EuKzBVbTF2SrpYEYfzap1wrONboFV-QuTU9Fz7sVjqJLeA@mail.gmail.com>
 <20231010100002.0163d681@jic23-huawei> <CACRpkdY+K90mN1Q1tf38FLRgEsz3q8dK9SJYSQVwGe=PL3FaUQ@mail.gmail.com>
 <20231010154216.6032a1c2@jic23-huawei> <CACRpkdY4yJKmc_Sbr=4sJ0WseCEEBOQ7wKj4fBUMG2_cx-Xxbw@mail.gmail.com>
 <20231013091615.00007399@Huawei.com>
In-Reply-To: <20231013091615.00007399@Huawei.com>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Fri, 13 Oct 2023 21:53:57 +0530
Message-ID: <CAM+2EuLFZBnrhqb1e67XAU0ssOwsfjeR+c=xn5j7Hpts80D96Q@mail.gmail.com>
Subject: Re: [RFC 1/2] dt-bindings: iio: imu: Add DT binding doc for BMI323
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 13, 2023 at 1:46=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 10 Oct 2023 21:51:17 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > On Tue, Oct 10, 2023 at 4:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote:
> >
> > > We kind of lost the question along the way.  Wasn't so much about whe=
ther
> > > there was a generic binding but more about whether it is worth provid=
ing
> > > separate controls for the two IRQ pins?  Or just assume no one is cra=
zy
> > > enough to play that level of mix and match.
> >
> > Ugh no, that's upfront design for a nonexistent use case.
> >
> > - First, to even consider open drain the designer need to be really
> >   short of IRQ lines/rails, and, despite knowing it's a bad idea, decid=
e
> >   to share this line between several peripherals, even though it will
> >   require I2C traffic to just determine which one even fired the IRQ.
> >
> > - Second, be interested in using two IRQs to distinguish between
> >   different events? When we just faced the situation that we had
> >   too few IRQ lines so we need to start sharing them with open
> >   drain...?
> >
> > It's not gonna happen.
> >
> > Stay with just drive-open-drain; and configure them all as that if
> > that property is set.
>
> Good insights, I'd not really thought about the wider reasons for using
> this :)  Not done any circuit design or embedded board bring up in a
> long while.
>
> Thanks!

Thank you for the explanation and suggestion.

Regards
Jagath.

>
> >
> > Yours,
> > Linus Walleij
> >
>
