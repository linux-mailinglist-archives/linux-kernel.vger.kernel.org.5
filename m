Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53723779C18
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 02:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbjHLAmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 20:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237318AbjHLAm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:42:27 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8794635A2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:42:16 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76c8dd2ce79so203861485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691800935; x=1692405735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1t7xanvo5C/A+LTtahMsYpWaAQUNKZ7fnvImz4e3jE=;
        b=A9RgZe84t+bCvYRaIa/xIyjsOR8DW3YJ49Tz2s0yMHYmmDhj0IyxdgSLW5JZnOB3os
         6+bXGDa/JBsct3emFUS2eipJlTwa9rSaWg9V4KOdsTJ7WEGuS3aajpjPB5iQnmeMMG4i
         jH/YbYH/uzPsM+CKZ0ZZ3Uoz56/8hRNYRwerpx6Zmz0B+2Ms0B7Dkc+uw9n2OLYNh/XK
         Dy5wqim9YetL4bW3Y6loh+y3Svt92g+eIAMMyGwj83CF5uM66uCxABM0SMZYcVgpWedb
         dW1deHlEghAoHzd4ve3oncLf9w2R+w76N3IhW2jRcmsNsMU+nt+sJYcZI1mMRkDhnQh8
         pvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691800935; x=1692405735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1t7xanvo5C/A+LTtahMsYpWaAQUNKZ7fnvImz4e3jE=;
        b=GDBnDJdnIS1gs0yrC1V3gtOxd/+rcEANSVtQZOzMwH5gBMZ2I9ZGmzSCVv2Cac7Vxp
         vz3lFoSOeTYnYwVsCyssaMUKq15FHrzXAOV/7uBBel9lp5UBkEC/Ov0U4kmzJs05NR5b
         qkW4HzTS3tby7TkJ7AkkVav9xrzLDKmanz2E27FX2VOU8cs6DoRqD57MYxrE0sr6aaQW
         bFfNcCVbQ9cBgTtlQbJkBYv/6T5AKvvNV3aky6jvpf5j4ifmnOb/zQAqKyUsDB0dOEil
         Lko5OPNRCOtKdPBCQjC03QkivMmqA1DgI08ZqQhz6sgrlW6jz6AHwbavaSBWxFTzlYfd
         1sYw==
X-Gm-Message-State: AOJu0YzSy4fPjfhIdKH2izOX2BYmAJukaidZmc8XhMbzOhpljcUHoqrz
        5N3yOhmlNYSq7lSIps9sKDf+nJgrXsnGLEZ+8QgeTgfUZbbV8EP1me8GFg==
X-Google-Smtp-Source: AGHT+IE+uPoQF/TL/04OKYbo7KkQjB52aTBBt0ByekSFPMdDQCM8FGYCKx5Ibdt2hWHI7d6/uJKji9U6SQOSrwG90VU=
X-Received: by 2002:a05:620a:450d:b0:76d:2f15:56a9 with SMTP id
 t13-20020a05620a450d00b0076d2f1556a9mr4925857qkp.31.1691800935516; Fri, 11
 Aug 2023 17:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230810133216.GKZNTm4KpohRR4gVsT@fat_crate.local>
 <20230810134056.GA130730@dev-arch.thelio-3990X> <20230810144344.GLZNT3oM6MLVdzGlyd@fat_crate.local>
 <20230810150706.GA42856@dev-arch.thelio-3990X> <20230810151410.GNZNT+wn/cLBWiU6dO@fat_crate.local>
 <20230810154831.GA38495@dev-arch.thelio-3990X> <20230810161414.GA4000@dev-arch.thelio-3990X>
 <20230811101456.GDZNYKIHs1k7ri8hrI@fat_crate.local> <20230811140941.GB193223@dev-arch.thelio-3990X>
 <ZNZbxhL5ZJD1Sd9P@google.com> <20230811161225.GIZNZd6QfLUoZv9TLO@fat_crate.local>
In-Reply-To: <20230811161225.GIZNZd6QfLUoZv9TLO@fat_crate.local>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 11 Aug 2023 17:42:04 -0700
Message-ID: <CAKwvOdmejxO=_KBuw1WZGgh=MXNNbfWH03TpEFO47vkKWq04Cg@mail.gmail.com>
Subject: Re: Hang when booting guest kernels compiled with clang after SRSO mitigations
To:     Sean Christopherson <seanjc@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 9:12=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Fri, Aug 11, 2023 at 09:03:18AM -0700, Sean Christopherson wrote:
> > Might be the flags bug that borks KVM's fastop() emulation.  If that fi=
xes things,
> > my guess is that bringing APs out of WFS somehow triggers emulation.
>
> I was just about to connect you two guys, thanks Sean!
>
> > https://lore.kernel.org/all/20230811155255.250835-1-seanjc@google.com
>
> Nathan, if you could test, that would be cool.

Nathan confirmed on IRC (since Sean isn't there; Sean what are you
doing, you know we have corp IRCCloud accounts, yeah?):


<nathanchance>
bpetkov: Seems like Sean bailed you out :P his patch appears to fix
the issue on the Ryzen 3 box, about to test the Threadripper
bpetkov: Will have results shortly assuming the machine boots :^) is
it possible that clang is generating a code sequence that triggers
this issue that gcc does not?

<bpetkov>
yeah, something about rFLAGS gets clobbered in the clang variant while
gcc doesn't
dunno if this is a more serious code generation issue

I'm not familiar enough with the relevant code to make a call there,
but perhaps Sean has more context and can help us deduce if that's the
case?

>
> Also, Nick has another patch for -mno-shared, it probably isn't fixing
> yours but it would be good to test it too, just in case:
>
> https://github.com/ClangBuiltLinux/linux/issues/1911#issuecomment-1674993=
796

So far it looks like it's working for folks. Fixing that issue is the
lowest priority issue of the three we found; I'll send it formally
next week.

I literally just had my hard drive fail on my main dev box (that's two
machines fail in one week; laptop wont power on anymore; down to one
machine left).  Going to see if fsck can help at all; worst case I may
need Nathan to formally send it for me next week.  Let's see if I can
recover this machine first...what a way to end the week. SMH

>
> Thx!
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



--=20
Thanks,
~Nick Desaulniers
