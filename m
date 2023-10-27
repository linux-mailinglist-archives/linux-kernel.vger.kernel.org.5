Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67BE7D8E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345200AbjJ0GJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJ0GJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:09:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E090D1AD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:09:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so2823321a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698386959; x=1698991759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uT19wDjBNDXIT18whelaViyd9NALExyuPmq5fccLKI=;
        b=ZxhzF903rEtCcQdhGGVjmU+LjEIcaX/s2naYHreZLPs5RQyx2DD/plxO45m6ddzRLD
         UFlVwNqz31QKmyHkEc2AoKmgk7xVZx+W8C+BkJ8OkvgTPYNMiLAGKCYIBK+XU/jSqP66
         I/QB+9c86B7M778TOJkdgTAtetUGxdBAK40Bv3SyLbX22AMShaJwJ7gkAb9pmSgIbWQo
         3ZQOy/4GmSy4cbBE5qCNcbBD4GcCiIpkmzgBm1KocUrZo/67H64d+0MHXLCj0XMhXxQ5
         n3xQ8+ZH7AfsEhF+iSDqQMbYtJhAoQtd4TYCFw+/lFQGtFv5pZO+bRS5TwCMoZvdWLrn
         Z/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698386959; x=1698991759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uT19wDjBNDXIT18whelaViyd9NALExyuPmq5fccLKI=;
        b=trzcqRw+pK+fNjO2oznvA58m5PmpdISykZylxFl6F40SctWm1AuwweoBshbliM4KdQ
         0Gxy13PXTO/tPxCVa61hSACYQcztd26Q5SIexaaRVDGp40PTViHFtHVcKyvsd8JvdXit
         6bvZ1tDUhlxZ2h41/OkyDUBR5BV9xapsZmdG26Dewhm5Yw6LHpiYuMPQI48hIsT7QKFE
         F6PFFOmi441NQjU7pId01xOVr7koe6DekBZpF3p1520lLEzhsvbUf5AygyKrP4JNcXIS
         Yk+gnFtv+KTmSNDh124PsNwZc1PcuPhUVo458g2FuV6ACZT4N1f2B0I9lG6AIUiQb09k
         ePEw==
X-Gm-Message-State: AOJu0Yw1iX1xyYZ0dTdowk83xN9nH2RPd0c18KQpb7UIT7vkhHEisU5G
        UGybJ00EYav54pv6ZWTZ0O/sWzcj0rInGVapwPY=
X-Google-Smtp-Source: AGHT+IH7H9IBZcNg8hAIdE4Fd6UlaSN/PQyWiY63vd21Cpx1nHV/uIHQvLNej+0+Z+LWmiVxhV4LC1bprfX3jzBpwIs=
X-Received: by 2002:a05:6402:124e:b0:53e:1375:33ce with SMTP id
 l14-20020a056402124e00b0053e137533cemr1508179edw.30.1698386959120; Thu, 26
 Oct 2023 23:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-1-brgerst@gmail.com> <20231026160100.195099-8-brgerst@gmail.com>
 <CAFULd4ZSzJGzckYLGuh-uVXqpk4E7bxnen0_y5HqFiPkr_36PA@mail.gmail.com> <CAMzpN2h+5FvMhDMWBf8H80mMAMYTOBMBFM4nSr92QRJLA0gqJw@mail.gmail.com>
In-Reply-To: <CAMzpN2h+5FvMhDMWBf8H80mMAMYTOBMBFM4nSr92QRJLA0gqJw@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 27 Oct 2023 08:09:07 +0200
Message-ID: <CAFULd4aMo5c-34rHaoNPpF08o28TG_OgAxw+_rxwZmHti9WD=w@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] x86/percpu/64: Use relative percpu offsets
To:     Brian Gerst <brgerst@gmail.com>
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

On Fri, Oct 27, 2023 at 4:09=E2=80=AFAM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> On Thu, Oct 26, 2023 at 2:47=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > On Thu, Oct 26, 2023 at 6:01=E2=80=AFPM Brian Gerst <brgerst@gmail.com>=
 wrote:
> > >
> > > The percpu section is currently linked at virtual address 0, because
> > > older compilers hardcoded the stack protector canary value at a fixed
> > > offset from the start of the GS segment.  Now that the canary is a
> > > normal percpu variable, the percpu section can be linked normally.
> > > This means that x86-64 will calculate percpu offsets like most other
> > > architectures, as the delta between the initial percpu address and th=
e
> > > dynamically allocated memory.
> >
> > The comments above MSR_GS_BASE setup should be reviewed or removed. I
> > don't think they need to be set up to access stack canary, they are
> > just clearing MSR now.
>
> GSBASE is deliberately set to zero offset on SMP for boot because we
> want any percpu accesses (including stack protector) to use the
> initial percpu area until the full percpu memory is allocated.  It's
> possible that more stack protector checks could sneak back into the
> early boot code, and after the conversion to relative percpu offsets
> they would work properly again.  I just didn't reenable them because
> they are unnecessary that early.

Thanks for the explanation, perhaps this non-obvious fact should be
mentioned in the comment .

Thanks,
Uros.

> Brian Gerst
