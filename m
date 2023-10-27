Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD707D9E38
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjJ0Qzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjJ0Qzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:55:45 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856801A7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:55:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5082a874098so1148366e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698425740; x=1699030540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoGb0Btn2vDy2yUK1mA4u/V4vYI6IKCD7EuPJ/906ww=;
        b=O25+jRqZbOOlzHvcc3KriQ2KAtoCY4wV32eV0EKBQxzN+81VIr8Z4cYtvQwUkbEWC6
         t95VwoTCF58kk/hG9D42mgpXGKACm+71gzTv4zaNRJp+A7fTKOur85xgYkPx3OTHKwcG
         +RcMwIKfRkVICq6+gtulEs9QnEuWlejd12vzwExwNU9rmCVHdtWSEQwE0Nz4QfdAo/S2
         Zy6rw8G5YJkWAucTbfxYX5V3jM3Ox4LGyLKmt6ExSsEbJ3GcWPTLqvd8jWqEPKG9GX0l
         TesXPypD07jJlI6czWCqZqCw8DZf/cvJRK9aIPGimIyvkGsxnpk4BxhyZDIgwA/ihuEY
         Lrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698425740; x=1699030540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoGb0Btn2vDy2yUK1mA4u/V4vYI6IKCD7EuPJ/906ww=;
        b=AJss4sR/bfcPCoMwjYA+nzLcz9yWpMpbDv5a0jpzsxYTmvH0S4ZSAuf5Lkg0hgyWrs
         dn0eCMGTrk0gFeDjMeEA6kmU/DLW832fFxQz3QKqgqrNG49oLb5pCE5aWoERN7qr59U5
         buHu49X8CPghIjO0XBiV40K0UYaRYbCMy+ouBFjXOZeN+FTAcOnfbAGisOKCjdmtVTlh
         uhNG5MvziNPDxAMoKfxeS66gXRZz04m7UVC8oDWUJ/TEmnLrURLzzDAfI822POIByptn
         6z/YfuWwwUXfZVApQ7xz8JhgaHs5OwdU1R+kci0Y6xaM/OcgcxPGNH/X6yF/xlwdm9BW
         mfbg==
X-Gm-Message-State: AOJu0YzCtdC0g/SONledqmV4dEiFpmRRhNDI9xmBMKnsesRoXdp2cZYW
        oR4Tz5kfVuWwfY/AXprlUXKJYc5yJuOBcvTtsQ==
X-Google-Smtp-Source: AGHT+IHxSSs+Y76MiIlo5B8buVWKbaJV774g0/kXhFL6FJdQPAPfeaoWWtOQd3hUdXYenJQ4wswdQFecTvs8wxcqDXM=
X-Received: by 2002:a19:6416:0:b0:507:9fc1:ca7e with SMTP id
 y22-20020a196416000000b005079fc1ca7emr1984875lfb.51.1698425740210; Fri, 27
 Oct 2023 09:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-1-brgerst@gmail.com> <20231026160100.195099-8-brgerst@gmail.com>
 <CAFULd4ZSzJGzckYLGuh-uVXqpk4E7bxnen0_y5HqFiPkr_36PA@mail.gmail.com>
 <CAMzpN2h+5FvMhDMWBf8H80mMAMYTOBMBFM4nSr92QRJLA0gqJw@mail.gmail.com> <CAFULd4aMo5c-34rHaoNPpF08o28TG_OgAxw+_rxwZmHti9WD=w@mail.gmail.com>
In-Reply-To: <CAFULd4aMo5c-34rHaoNPpF08o28TG_OgAxw+_rxwZmHti9WD=w@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 27 Oct 2023 12:55:28 -0400
Message-ID: <CAMzpN2ix+b++kuWBMcpD1HfsGKGWxJBeRuvzvV+gvCUJOhFP_A@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] x86/percpu/64: Use relative percpu offsets
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
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

On Fri, Oct 27, 2023 at 2:09=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Fri, Oct 27, 2023 at 4:09=E2=80=AFAM Brian Gerst <brgerst@gmail.com> w=
rote:
> >
> > On Thu, Oct 26, 2023 at 2:47=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com>=
 wrote:
> > >
> > > On Thu, Oct 26, 2023 at 6:01=E2=80=AFPM Brian Gerst <brgerst@gmail.co=
m> wrote:
> > > >
> > > > The percpu section is currently linked at virtual address 0, becaus=
e
> > > > older compilers hardcoded the stack protector canary value at a fix=
ed
> > > > offset from the start of the GS segment.  Now that the canary is a
> > > > normal percpu variable, the percpu section can be linked normally.
> > > > This means that x86-64 will calculate percpu offsets like most othe=
r
> > > > architectures, as the delta between the initial percpu address and =
the
> > > > dynamically allocated memory.
> > >
> > > The comments above MSR_GS_BASE setup should be reviewed or removed. I
> > > don't think they need to be set up to access stack canary, they are
> > > just clearing MSR now.
> >
> > GSBASE is deliberately set to zero offset on SMP for boot because we
> > want any percpu accesses (including stack protector) to use the4
> > initial percpu area until the full percpu memory is allocated.  It's
> > possible that more stack protector checks could sneak back into the
> > early boot code, and after the conversion to relative percpu offsets
> > they would work properly again.  I just didn't reenable them because
> > they are unnecessary that early.
>
> Thanks for the explanation, perhaps this non-obvious fact should be
> mentioned in the comment .

I will update the comments if I need to send a v3 for some other
reason, otherwise I'll do a followup patch.

Brian Gerst
