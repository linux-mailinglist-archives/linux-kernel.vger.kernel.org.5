Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAF27C760C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441975AbjJLSkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379677AbjJLSkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:40:07 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397C9BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:40:05 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso2436330a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697136003; x=1697740803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1aZVXohRge+v3Vv/6fsNhXCZ7AScOuTNQZ+ekrGnkw=;
        b=J6C9DRsYTiZlBsvb3/9mJVVnALTuEg9Gi4yBmo8R1Av16vSkmj6x0P3KVGxc1QbGv5
         y6Oy5BHa5arD3b2wSdCsM5LeIlzruFbq0pxd6WNCdAHg82XHDLVeT2Jfw3dwct2TSK1e
         Fxv/Pp1ycueB8LKnQkPUc8lhT9wwdF8LSySxOeI4hiCm6IhCzfJquUGxXO2SkKY0jHSv
         NZkM49s0golYvrbwBCDhIRDYxiq22TS1XMWMD/kX77KYIUkylDEk3za1vp+TO+9nrZaK
         hko+AfTrZW+mZLZ9Pj178S4W2IGmfRRNwzyqlV/E0wzh70NxHDCda6k1Km/1PZCGQe8C
         TiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697136003; x=1697740803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1aZVXohRge+v3Vv/6fsNhXCZ7AScOuTNQZ+ekrGnkw=;
        b=bGvIAhFMz8bDkMFm4O3InnhnGx9PfmkA+ghmdsESvwSglpOVqZAGlog3WLEtoS9LBp
         KZtBWvUUa7gQZOitUaHIbRc8uBESwF2QRE9fC4/yuuikgkoog84+izN6mbO2n5KeOHGf
         K9Ny7j8VIdbvJHhQ4kgjMrl4jntrnM2jjlMlv+Zghzu+7+fUF2SQOtpkxsnS7tZT1Hko
         BVPvlfXRpPpLgvPdZ20c8kZvFrgOvB9CTuhW1xgD7O2Lq4zwyJd5f07MdaIAlj5Q+CJg
         6qEOGpE0StAzzfFR8wkUPicBi6QWqrrbR79MEoRmGvJVFeScZVMFo0qG6BdaJKSEg45S
         KFBg==
X-Gm-Message-State: AOJu0YxXPvYOtrAKXJaBD+kFQUMyuSUFRSXqukcaPO7A5SIBkAmOheaL
        k4bgBkIGT/H6YzlT7zs3ZahNy8nhewa8YNwV6uQ=
X-Google-Smtp-Source: AGHT+IEHHumjNQpn73kXZqpk0T02To9UzO7onfeg6sqCjti4bWA6fBS/ptoScbdqZYxE54CRPouSH8kbA0BFawhRjIw=
X-Received: by 2002:a05:6402:510a:b0:53e:3584:d394 with SMTP id
 m10-20020a056402510a00b0053e3584d394mr169774edd.33.1697136003595; Thu, 12 Oct
 2023 11:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231012161237.114733-1-ubizjak@gmail.com> <20231012161237.114733-2-ubizjak@gmail.com>
 <CAMzpN2ii5qMr36PSw8RzNuVB-9KhoQgyfet=FpPtT5F3hOmLmQ@mail.gmail.com> <CAFULd4ZVvRvssyj--un6vrLU5M816ysEkc4xpXnGSN=hyhTTFQ@mail.gmail.com>
In-Reply-To: <CAFULd4ZVvRvssyj--un6vrLU5M816ysEkc4xpXnGSN=hyhTTFQ@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 12 Oct 2023 20:39:52 +0200
Message-ID: <CAFULd4b=S09YvHoJ3UkY=DbJRS+xqhFwrP50YEYomntxy6JtnQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/percpu: Use explicit segment registers in lib/cmpxchg{8,16}b_emu.S
To:     Brian Gerst <brgerst@gmail.com>
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 7:54=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
> > This will break on !SMP builds, where per-cpu variables are just
> > regular data and not accessed with a segment prefix.
>
> Ugh, indeed. Let me rethink this a bit.

Something like this:

#ifdef CONFIG_SMP
#define PER_CPU_ARG(arg)    %__percpu_seg:arg
#define PER_CPU_VAR(var)    %__percpu_seg:(var)##__percpu_rel
#else /* ! SMP */
#define PER_CPU_ARG(arg)    arg
#define PER_CPU_VAR(var)    (var)##__percpu_rel
#endif    /* SMP */

and using the above PER_CPU_ARG in /lib/cmpxchg{8,16}b_emu.S will
solve the issue.

I will prepare a v2.

Thanks,
Uros.
