Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8417756E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjGQUuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjGQUux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:50:53 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D1410C4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:50:51 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-57764a6bf8cso50535677b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689627051; x=1692219051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQvuhpFLaz/ow6oQFOL4+/IASlr49hflcZSKip75GTc=;
        b=AMfaXTW+HTIn1ZrWiPZeRTi097D+iklO2df09dAWMOehCYICFneLFjilYSBQC9HcH7
         Tq8XZr/o/mWt8pPCZUaaCILll6PiabcEeE66Jy/q1bBs8WcoJALmyfQDyrS40aTeQQ4Y
         7IhExT33jFw04mw2yJ45h/T+rF1B+kCxBHuMaT4u8w9NfnykL96H1AoV1IoMEaipHuqW
         mTNj8Z97fuWsSDG6stxPV9pOaKRMJRGt8nz72w8ocvE4BdBiA18p4tKhq8UO0NOUJOrZ
         H8m439iRZPPbJFR/YMTfMm5IkhUmUb4VlIyo4Znx1VZhrwVVf7lNrfAwrYqWboWfv5yy
         a2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689627051; x=1692219051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQvuhpFLaz/ow6oQFOL4+/IASlr49hflcZSKip75GTc=;
        b=Jyu5RsKqB6u3/XAILNLmd83+6OShloxcuDFzLJP+2dfcLpMZ51cwVQLanqJowELtuq
         JOT1VvC/mPvv1L9pTWNjvFKqn5WkNQ0MJkh+2knS9I998tBcyufp2879HQKmGzSP48F+
         FX3t6d5XsYRN08BHZetAY7jsGZ6vpD5EXCKi/vWWEpEzJL56KbsGr8nnVe1UjIkzyS7y
         +wKQ3ttk6JW0A/yfV5DzyyxNO+PJM+qmaZWBVMab/sx6/nji8iGNCInF1HzQ3u5vZ4ys
         E92xhyE3NStNfw//iTc0kp3AnGiGFX4B+J9MrAbdV5YqO5dATMWxJBbJ3nnc07/D3X9N
         b2DQ==
X-Gm-Message-State: ABy/qLYTAcheXab0JHoyJTc7iW7D6LuqFvyUINsHV9nlzsyR3epdNdOC
        nsw6ND7iKQ2F8Jx81BUr64L+XInJfn4tY/q50l+QLA5srQbddj4=
X-Google-Smtp-Source: APBJJlF15giuoFoTzjJPSaYpOwaMB2a2fzsGAUMwN1+mEM4AYSfLWpgVkcTSMeJVl47iVn8MZ2JRn04zH8f8YWYyAu4=
X-Received: by 2002:a0d:df52:0:b0:573:b42b:4e27 with SMTP id
 i79-20020a0ddf52000000b00573b42b4e27mr13570860ywe.16.1689627050777; Mon, 17
 Jul 2023 13:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230710082500.1838896-1-lsahn@wewakecorp.com>
 <CAHC9VhQY0Uq_xQ_AwAuZ8gJbS52nQvRONHvCxiR-dGDg3BviRw@mail.gmail.com> <0fcac6a8-4ab8-91bc-34e0-cbbb81da3973@schaufler-ca.com>
In-Reply-To: <0fcac6a8-4ab8-91bc-34e0-cbbb81da3973@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Jul 2023 16:50:40 -0400
Message-ID: <CAHC9VhQ3nmpRQPT6m2jBKtpML0sR9htARWr2cTPt78s=4nRkcg@mail.gmail.com>
Subject: Re: [PATCH] selinux: optimize major part with a kernel config in selinux_mmap_addr()
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Leesoo Ahn <lsahn@ooseel.net>, lsahn@wewakecorp.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 4:31=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 7/17/2023 1:13 PM, Paul Moore wrote:
> > On Mon, Jul 10, 2023 at 4:25=E2=80=AFAM Leesoo Ahn <lsahn@ooseel.net> w=
rote:
> >> The major part, the conditional branch in selinux_mmap_addr() is alway=
s to be
> >> false so long as CONFIG_LSM_MMAP_MIN_ADDR is set to zero at compile ti=
me.
> >>
> >> This usually happens in some linux distros, for instance Ubuntu, which
> >> the config is set to zero in release version. Therefore it could be a =
bit
> >> optimized with '#if <expr>' at compile time.
> >>
> >> Signed-off-by: Leesoo Ahn <lsahn@wewakecorp.com>
> >> ---
> >>  security/selinux/hooks.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> > First, I agree with Stephen's comments that you should ask your distro
> > (you mentioned Debian) to move MIN_ADDR higher.  Beyond that, I have
> > one request, see below ...
> >
> >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >> index d06e350fedee..a049aab6524b 100644
> >> --- a/security/selinux/hooks.c
> >> +++ b/security/selinux/hooks.c
> >> @@ -3723,11 +3723,13 @@ static int selinux_mmap_addr(unsigned long add=
r)
> >>  {
> >>         int rc =3D 0;
> >>
> >> +#if CONFIG_LSM_MMAP_MIN_ADDR > 0
> >>         if (addr < CONFIG_LSM_MMAP_MIN_ADDR) {
> >>                 u32 sid =3D current_sid();
> >>                 rc =3D avc_has_perm(sid, sid, SECCLASS_MEMPROTECT,
> >>                                   MEMPROTECT__MMAP_ZERO, NULL);
> >>         }
> >> +#endif
> >>
> >>         return rc;
> >>  }
> > Pre-processor conditionals inside a function are generally something
> > we don't recommend.  In this case I would suggest doing something like
> > this:
> >
> > #if (MMAP_MIN_ADDR > 0)
> > static int selinux_mmap_addr(...)
> > {
> >   /* current func definition */
> > }
> > #else /* MMAP_MIN_ADDR > 0 */
> > static int selinux_mmap_addr(...)
> > {
> >   return 0;
> > }
> > #endif /* MMAP_MIN_ADDR > 0 */
>
> Better yet, skip the #else here and #if out the LSM_HOOK_INIT(mmap_addr, =
...).
> No hook at all is faster than a hook that does nothing.

My only concern with that approach is the disconnected nature: one
ifdef around the func definition, one around the LSM_HOOK_INIT() call.
If we thought a zero MMAP_MIN_ADDR value was a good idea, or even
common, I would be more inclined to pay the bad-code-practices-tax
here, but seeing as we don't want to encourage a zero MMAP_MIN_ADDR
value I'd rather lean towards the more maintainable code.

--=20
paul-moore.com
