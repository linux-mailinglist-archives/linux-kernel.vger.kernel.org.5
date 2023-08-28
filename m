Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DDA78B644
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjH1RTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjH1RTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:19:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6107BC5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:19:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-500b0f06136so3256680e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693243140; x=1693847940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdKbGkiMEHDZxtvYcB55AX2r1kA+uiZkHP+paoU6rrc=;
        b=tcLEXaH7U2rrkp8U48odL6CZ9G0Yj99XWgWuWbIi+UqEQJYr6rL/iyJYDlRli70j+I
         82klvz+6xlCINNfhaFVHlwKtsUlC66SqJF62dBJ4FxDkL+qRg4k6KQJ/vRXGx3za+sR9
         moDWg7GOcvn/MxBC0lJo5zvcj/6vwcdoiKrovRfh11G9Tzc3v/xrzHzimUAztd4zQIwE
         rSEerbOTo3ZeWbU6t/FikfSDKLKcauIQS9NG8UvhiZoq7kSsfVfX2Erhs5TKasYRVnye
         FwHjL+9IoegnxeNtkp5B1b8lo8ZAhhE6OdiY7gIctUHUOpsF+NLg5JI/saWY3GsNw2B+
         fHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693243140; x=1693847940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdKbGkiMEHDZxtvYcB55AX2r1kA+uiZkHP+paoU6rrc=;
        b=fBVgtfqOejeRrOS++F7+lgR9yi8wIx2nsaAsR+skDSYiGxEeXZ5fiDcqnElGopQ+Id
         0IhPAiiCDfJdE7lu+aFSGgqtbjAFTtUNCdSU05uB9BrDh4+alH/rMURzi9h1SkQzlBha
         m38mS6T7dqhhb9qdk4H5XglKoTUwWAbJKexi3s5Eo6dOo5nwmJ2OyaaeyJBMU8hnn+1J
         7ZSRu2lgpesJBmbEKMucTD2m66fdSyjJLXIIJ/CsfCHfyUJ5+yEpRfxcFhwCP5HLHLE/
         JiVk8Bt2t7BstTZEvaWLRno0b1W82/R6Jn8gN8Ui1eu/i09NS1aEuttJxPqv/SA/eO1v
         skJQ==
X-Gm-Message-State: AOJu0YxQ8zg4Xans6V4aotbkhSANK29PIiq5heBTZSbbXTeT86wLj6Nu
        BDK2gRw61H0MNNrn9WojFUAc3d2AeKMueQdOCyJYYw==
X-Google-Smtp-Source: AGHT+IEYUWRZ0JpXXlpm+5EXrS0OW+lBPytKeqgJpS6Qt+weN8A4HwoSwMDa4hK4cbEiOzGW8mMIFOuVsIRkvH9Z9nw=
X-Received: by 2002:a05:6512:108d:b0:4ff:9095:a817 with SMTP id
 j13-20020a056512108d00b004ff9095a817mr23538756lfg.57.1693243140412; Mon, 28
 Aug 2023 10:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230825231139.1145522-1-evan@rivosinc.com> <20230826-anguished-tutu-81d63b3081a7@spud>
 <20230826-copper-suffocate-5f4f0e67f9a7@spud> <CALs-HsvwLpcUMPeKEs3ZW3tOwLGeGRQSe=grxE5L14Tj8b+XHw@mail.gmail.com>
 <20230828-dangling-decency-ededaa58d014@spud>
In-Reply-To: <20230828-dangling-decency-ededaa58d014@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Mon, 28 Aug 2023 10:18:24 -0700
Message-ID: <CALs-Hss8KNV9zkEHujVmzb7Rf8Zp9OGkDF9Fj8BCjQuFDYaHHA@mail.gmail.com>
Subject: Re: [PATCH v5] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 9:53=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Aug 28, 2023 at 09:24:03AM -0700, Evan Green wrote:
> > On Sat, Aug 26, 2023 at 2:56=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Sat, Aug 26, 2023 at 12:26:25AM +0100, Conor Dooley wrote:
> > > > On Fri, Aug 25, 2023 at 04:11:38PM -0700, Evan Green wrote:
> > > > > In /proc/cpuinfo, most of the information we show for each proces=
sor is
> > > > > specific to that hart: marchid, mvendorid, mimpid, processor, har=
t,
> > > > > compatible, and the mmu size. But the ISA string gets filtered th=
rough a
> > > > > lowest common denominator mask, so that if one CPU is missing an =
ISA
> > > > > extension, no CPUs will show it.
> > > > >
> > > > > Now that we track the ISA extensions for each hart, let's report =
ISA
> > > > > extension info accurately per-hart in /proc/cpuinfo. We cannot ch=
ange
> > > > > the "isa:" line, as usermode may be relying on that line to show =
only
> > > > > the common set of extensions supported across all harts. Add a ne=
w "hart
> > > > > isa" line instead, which reports the true set of extensions for t=
hat
> > > > > hart.
> > > > >
> > > > > Signed-off-by: Evan Green <evan@rivosinc.com>
> > > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > >
> > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > >
> > > > Can you drop this if you repost?
> >
> > Will do.
> >
> > > >
> > > > > +"isa" vs "hart isa" lines in /proc/cpuinfo
> > > > > +------------------------------------------
> > > > > +
> > > > > +The "isa" line in /proc/cpuinfo describes the lowest common deno=
minator of
> > > > > +RISC-V ISA extensions recognized by the kernel and implemented o=
n all harts. The
> > > > > +"hart isa" line, in contrast, describes the set of extensions re=
cognized by the
> > > > > +kernel on the particular hart being described, even if those ext=
ensions may not
> > > > > +be present on all harts in the system.
> > > >
> > > > > In both cases, the presence of a feature
> > > > > +in these lines guarantees only that the hardware has the describ=
ed capability.
> > > > > +Additional kernel support or policy control changes may be requi=
red before a
> > > > > +feature is fully usable by userspace programs.
> > > >
> > > > I do not think that "in both cases" matches the expectations of
> > > > userspace for the existing line. It's too late at night for me to t=
hink
> > > > properly, but I think our existing implementation does work like yo=
u
> > > > have documented for FD/V. I think I previously mentioned that it co=
uld
> > > > misreport things for vector during the review of the vector series =
but
> > > > forgot about it until now.
> > >
> > > I went and checked, and yes it does currently do that for vector. I
> > > don't think that that is what userspace would expect, that Google
> > > cpu_features project for example would draw incorrect conclusions.
> >
> > I'm lost, could you explain a little more?
>
> There (may be/)are userspace programs that will interpret the appearance
> of extensions in cpuinfo as meaning they can be used without performing
> any further checks.
>
> > My goal was to say that
> > there's no blanket guarantee that the feature is 100% ready to go for
> > userspace just because it's seen here.
>
> Right. I was agreeing that this is true, but it is also not how some
> userspace programs have interpreted things. Consider a platform & kernel
> that support the V extension but vector has not been enabled by default
> or by early userspace. If someone cats cpuinfo, they'll see v there, but
> it won't be usable. That Google cpu_features project (or a punter) may
> then assume they can use it, as that's been the case so far in general*.
>
> The caveat producing the * being that the same problem actually exists
> for F/D too AFAICT, but it's likely that nobody really encountered it
> as they didn't build non-FP userspaces & then try to use FP in some
> userspace applications.
>
> > For some extensions, it may in
> > fact end up meaning just that (hence the "additional ... may be
> > required" rather than "is required").
>
> > This is true for FD (maybe,
> > depending on history?),
>
> AFAICT, it's not true for FD. The FPU config option not being set, or
> either of F and D being missing will lead to unusable extensions
> appearing.

Ah ok.

>
> > or extensions whose minimal/zero kernel
> > support was unconditionally added at the same time as its parsing for
> > it. But it's not true solely by virtue of being in /proc/cpuinfo. In
> > other words, I'm trying to establish the floor of what /proc/cpuinfo
> > guarantees, without fully specifying the ceiling.
>
> > Are you saying that
> > we need to spell out the guarantees for each extension?
>
> No, I don't want that!
>
> > Or are you
> > saying the floor I've defined in general is incorrect or insufficient?
>
> I think the floor that you have defined is probably misleading to users.
> It's also the floor that has existed for quite a while, so this might be
> a case of the userspace devs messing up due to an absence of any
> explanation of what to do here.
> Things will get abhorrently messy if we try to do what these userspace
> programs expect, and I don't think we should go there. We just need to
> bear in mind that the behaviour we have & the behaviour that you are
> documenting flys in the face of what some userspace expects.

Thanks, I think I understand now. You're saying the floor I'm defining
might surprise some users, who were expecting the floor to be "fully
enabled and ready to party". Given there was no documentation about it
before, and this documentation is consistent with what we actually do
(and there seems to be consensus this is a maintainable position to
hold), can we just tell those users they're holding it wrong?

>
> > I'm also open to direct suggestions of wording if you've got something
> > in mind :)
>
> Someone mentioned it recently, but it really is starting to feel more
> and more like lscpu should grow support for hwprobe and funnel people
> into using that instead of /proc/cpuinfo when all they want is to see
> what their hardware can do.

Maybe for the fiddly microarchitectural bits, yeah. But I'd think our
newly proposed documentation for /proc/cpuinfo of keeping it closer to
what the hardware can do would suit the lscpu folks' mission well. (In
ChromeOS at least, we didn't have lscpu, but snarfed /proc/cpuinfo
directly into feedback reports that consented to sending along system
info). Really I'd think it's the application/library writers who want
to know "am I ready to go right now" are who we should be pushing to
use hwprobe, since we can define those bits to be as specific as we
want (eg V is on AND it's a full moon, so go for it).

Depending on your thoughts on this, if there are changes requested on
this patch, let me know what they are.
-Evan
