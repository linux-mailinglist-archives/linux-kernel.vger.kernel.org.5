Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152F07F4663
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbjKVMik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343747AbjKVMii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:38:38 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AF2E7;
        Wed, 22 Nov 2023 04:38:35 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5409bc907edso9434742a12.0;
        Wed, 22 Nov 2023 04:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656713; x=1701261513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKXgT3EZzq5PttAsnZQG8TZjwKzXmLY9K8JLPmoHaas=;
        b=XPQpNq5qgFdGFcSc1/Mj4ou4J8ngPyVA3ZdZSaUHEkN90lUIVj0+WCe5nEIlP1kpte
         PPIzWUQp4tz4gLWYHHrlIdVgBz+5lcZejSf2vSPRUThz7ApXfyAVAsrKZ206ntfUh5Wp
         4l55C0L9IRjYf8VZq51mu8bsmR3QvTMUWzRq8x81VtfnMosagBkLAjh5uu0KgBovzgRZ
         HGqYpwgRfHsxp/1qdcz0iNhX+nLirOdDxwdZyjwMlWfrgiKQqBjEvEeSrEF1U3cEicq9
         0KgRvLrghRasWi5jOwKvNGhWhv5SIXiMXpkinXa2ZPd2Ve5Oj+wTdiQWpYvOF5q/vtZq
         nvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656713; x=1701261513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKXgT3EZzq5PttAsnZQG8TZjwKzXmLY9K8JLPmoHaas=;
        b=gwbqc8SHAo/sz+W2cwzA4f4TwvewlSxLKJ5e0hwZUzENX7rYYeH9qeEOYpj2oiGpbv
         aaS9GbKK3rIE1qV4eeFPlKmlgwXmV2+SggM0VrcY65QPUQNEHieZi/skbGMR9636RUvT
         vhDFgrAqZm0ykFlLue5VPZ7pLczoi5un3eCKiW0KfmKGszWyyaG7goesa/P82XMay8uk
         kiVu0LHjZdpI5vmM3hWdSl6EwVr7XqgKWEqOVrxYBSGyH1If6WeF39M3GghxVARV6wOC
         twxnWThf/gyTgFvDA36kRGyUr7raflS/xnAknp1k0hU6pV2pdxMdCZtaoL0znKuFIuX5
         R2mw==
X-Gm-Message-State: AOJu0YzU8A4QWHa/gzJLcHYUeVS0z8DfE0BGemtvm6z7fOSo/cLp2RiU
        g3FN6GOzaCMMO0YNTP0ob41rwYZkYEoWnurnVF8=
X-Google-Smtp-Source: AGHT+IGXNF2nYx70uqrarAweHtVzQ3qpxZuTuLxOL8xyCf+8G9+wpVf36dsJkkGtDMQH4m282VmPVuqBKc6sXQkh0eI=
X-Received: by 2002:a05:6402:14c4:b0:53e:7881:6bdf with SMTP id
 f4-20020a05640214c400b0053e78816bdfmr199825edx.14.1700656713251; Wed, 22 Nov
 2023 04:38:33 -0800 (PST)
MIME-Version: 1.0
References: <20231114170038.381634-1-ubizjak@gmail.com> <SN6PR02MB41570168279C428D385ADCB0D4B1A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAFULd4Z3DZh0SoEyNHfz3=DM2CkDGtNP_f1gVx64NJkzmWp-Pw@mail.gmail.com>
 <ZV163ePuUQyyeKUj@liuwe-devbox-debian-v2> <CAFULd4ZqhQTpUNw7xMvfAk7jUR0EweHVVbNY2+9oA0ZiGOrhXg@mail.gmail.com>
In-Reply-To: <CAFULd4ZqhQTpUNw7xMvfAk7jUR0EweHVVbNY2+9oA0ZiGOrhXg@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 22 Nov 2023 13:38:22 +0100
Message-ID: <CAFULd4ZXKhj9eXFikr-aaxju5k7tAD9aiVfQ-0OXoNgwP2ZHWA@mail.gmail.com>
Subject: Re: [PATCH] x86/hyperv: Use atomic_try_cmpxchg() to micro-optimize hv_nmi_unknown()
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Michael Kelley <mhklinux@outlook.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 1:31=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Wed, Nov 22, 2023 at 4:52=E2=80=AFAM Wei Liu <wei.liu@kernel.org> wrot=
e:
> >
> > On Wed, Nov 15, 2023 at 09:58:29PM +0100, Uros Bizjak wrote:
> > > On Wed, Nov 15, 2023 at 6:19=E2=80=AFPM Michael Kelley <mhklinux@outl=
ook.com> wrote:
> > > >
> > > > From: Uros Bizjak <ubizjak@gmail.com> Sent: Tuesday, November 14, 2=
023 8:59 AM
> > > > >
> > > > > Use atomic_try_cmpxchg() instead of atomic_cmpxchg(*ptr, old, new=
) =3D=3D old
> > > > > in hv_nmi_unknown(). On x86 the CMPXCHG instruction returns succe=
ss in
> > > > > the ZF flag, so this change saves a compare after CMPXCHG. The ge=
nerated
> > > > > asm code improves from:
> > > > >
> > > > >   3e: 65 8b 15 00 00 00 00    mov    %gs:0x0(%rip),%edx
> > > > >   45: b8 ff ff ff ff          mov    $0xffffffff,%eax
> > > > >   4a: f0 0f b1 15 00 00 00    lock cmpxchg %edx,0x0(%rip)
> > > > >   51: 00
> > > > >   52: 83 f8 ff                cmp    $0xffffffff,%eax
> > > > >   55: 0f 95 c0                setne  %al
> > > > >
> > > > > to:
> > > > >
> > > > >   3e: 65 8b 15 00 00 00 00    mov    %gs:0x0(%rip),%edx
> > > > >   45: b8 ff ff ff ff          mov    $0xffffffff,%eax
> > > > >   4a: f0 0f b1 15 00 00 00    lock cmpxchg %edx,0x0(%rip)
> > > > >   51: 00
> > > > >   52: 0f 95 c0                setne  %al
> > > > >
> > > > > No functional change intended.
> > > > >
> > > > > Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> > > > > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > > > > Cc: Wei Liu <wei.liu@kernel.org>
> > > > > Cc: Dexuan Cui <decui@microsoft.com>
> > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > > > ---
> > > > >  arch/x86/kernel/cpu/mshyperv.c | 5 ++++-
> > > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/x86/kernel/cpu/mshyperv.c
> > > > > b/arch/x86/kernel/cpu/mshyperv.c index e6bba12c759c..01fa06dd06b6
> > > > > 100644
> > > > > --- a/arch/x86/kernel/cpu/mshyperv.c
> > > > > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > > > > @@ -262,11 +262,14 @@ static uint32_t  __init ms_hyperv_platform(=
void)
> > > > > static int hv_nmi_unknown(unsigned int val, struct pt_regs *regs)=
  {
> > > > >       static atomic_t nmi_cpu =3D ATOMIC_INIT(-1);
> > > > > +     unsigned int old_cpu, this_cpu;
> > > > >
> > > > >       if (!unknown_nmi_panic)
> > > > >               return NMI_DONE;
> > > > >
> > > > > -     if (atomic_cmpxchg(&nmi_cpu, -1, raw_smp_processor_id()) !=
=3D -1)
> > > > > +     old_cpu =3D -1;
> > > > > +     this_cpu =3D raw_smp_processor_id();
> > > > > +     if (!atomic_try_cmpxchg(&nmi_cpu, &old_cpu, this_cpu))
> > > > >               return NMI_HANDLED;
> > > > >
> > > > >       return NMI_DONE;
> > > > > --
> > > > > 2.41.0
> > > >
> > > > The change looks correct to me.  But is there any motivation other
> > > > than saving 3 bytes of generated code?  This is not a performance
> > > > sensitive path.  And the change adds 3 lines of source code.  So
> > > > I wonder if the change is worth the churn.
> > >
> > > Yes, I was trying to make the function more easy to understand and
> > > similar to nmi_panic() from kernel/panic.c. I had also the idea of
> > > using CPU_INVALID #define instead of -1, but IMO, the above works as
> > > well.
> > >
> > > > In any case,
> > > >
> > > > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> >
> > Applied to hyperv-fixes.
> >
> > Uros, just so you know, DKIM verification failed when I used b4 to appl=
y
> > this patch. You may want to check your email setup.
>
> Strange, because I didn't touch the mailer and git config for
> months... and recently I have sent many patches this way without
> problems.

This one [1] checks OK, so it looks like some transient issue with gmail.

[1] https://lore.kernel.org/lkml/20231120153419.3045-1-ubizjak@gmail.com/

Thanks,
Uros.
