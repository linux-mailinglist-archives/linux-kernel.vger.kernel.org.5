Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB18F7D8C47
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjJZXlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJZXla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:41:30 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2134187
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:41:27 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-457cb7f53afso698649137.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698363687; x=1698968487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LjBrI9YmsLIbi6PERsecmQp7XtKn0fCbk7lkuucm0CI=;
        b=oTZfJSBfwasj9VVW70IVETJUSniFX9kg230kHsmi5Hiq8HfBT5f1gKmfFE/Fbq86yP
         xR/NSBvold4npZXOwH9EZ7Y7xeRMm2TogotfuPV9W+aE1gqVyd/pjsPWB6z+lYWQOglN
         3EBFERCJXOfK/Y7GqBFupJp+dJXmA0Oip953KjvdqB0sukKSxxAukh3x/fV+31Aln6mg
         d0Oz6YAe6fpWi7vdRsnPx16xORJgXdXpHAYCWDL2ez2dU8Mml16BA4oNk/fxo0kBKLiw
         ZuAG1Dptj/7CbLnSWgYzv3kYypFtyfzTXRKliqX5YrAAUlDHEA5KUjOXxOq4W1FatCOL
         5+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698363687; x=1698968487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjBrI9YmsLIbi6PERsecmQp7XtKn0fCbk7lkuucm0CI=;
        b=HzwfCJ8E73F6kteDnO6Ti3sV6dI4icT8xNc0VIcxXffLoJr3FAFuQNtQGrE00KHDGg
         Z7dD1ndK1iM+p24oAQMn99QUBKvj2FGJBpZGBB+TdGkHMENSAVsl0Bv/J2I4cCeJJ6zW
         GqH4+ru0nN/uqMJIQpxgW5VtNQrMEl6E8CursVfd0xKU7hU7eiJBiLva/KrsOiOLhKp1
         CxcxPUcqPdcFb2EfX0Clr6u3AQK2gWfQEwLcuOOJnKNBHz3yTdZ+ITC7qqTOYuKNO0uk
         YovHKGkWuPDTn84hfIP4OhzT/eaMhx311NxWpuWMlKLRgyuIqIsGV4D2vn2DAbMAe0wd
         NXDg==
X-Gm-Message-State: AOJu0YwkbpY+SyCuxw9aLxYuo5Or4kOfsWEzYZblVshHGL5wfCR8xDl0
        sCtxOBMKo2/P1z4njMtCouZ56WMQuCQYhAdvWoJz4GhcOWDS23V8r/A=
X-Google-Smtp-Source: AGHT+IGXh1dtqLyeV+dAZwx6xwPRfo8Ss9CVmJmQjkA6Te17SBEjqowXaFoKDQg2vw//qtBqDH6nO2/AkjaqjNtQe/0=
X-Received: by 2002:a05:6102:22c8:b0:452:6465:4a35 with SMTP id
 a8-20020a05610222c800b0045264654a35mr1154073vsh.11.1698363686704; Thu, 26 Oct
 2023 16:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <d65bddf3-c58a-1420-bff9-8333c10edb56@microchip.com>
 <20221115221051.1871569-1-debug@rivosinc.com> <98eb5bc7-dee4-b36e-a219-17b1e08d85f6@siemens.com>
 <ZR5JvCSDZwTQAucC@u-NUC7i5BNH>
In-Reply-To: <ZR5JvCSDZwTQAucC@u-NUC7i5BNH>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Thu, 26 Oct 2023 16:41:13 -0700
Message-ID: <CAKC1njRRnerL3vF36DX9cAdyO4pyqGE8g35q8U1-D71gKW2jKA@mail.gmail.com>
Subject: Re: [PATCH v5] scripts/gdb: add lx_current support for riscv
To:     20221115221051.1871569-1-debug@rivosinc.com
Cc:     ajones@ventanamicro.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, jan.kiszka@siemens.com,
        kbingham@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 10:29 PM Hsieh-Tseng Shen
<woodrow.shen@sifive.com> wrote:
>
> On Mon, Jan 02, 2023 at 10:09:01AM +0100, Jan Kiszka wrote:
> > On 15.11.22 23:10, Deepak Gupta wrote:
> > > csr_sscratch CSR holds current task_struct address when hart is in
> > > user space. Trap handler on entry spills csr_sscratch into "tp" (x2)
> > > register and zeroes out csr_sscratch CSR. Trap handler on exit reloads
> > > "tp" with expected user mode value and place current task_struct address
> > > again in csr_sscratch CSR.
> > >
> > > This patch assumes "tp" is pointing to task_struct. If value in
> > > csr_sscratch is numerically greater than "tp" then it assumes csr_sscratch
> > > is correct address of current task_struct. This logic holds when
> > >    - hart is in user space, "tp" will be less than csr_sscratch.
> > >    - hart is in kernel space but not in trap handler, "tp" will be more
> > >      than csr_sscratch (csr_sscratch being equal to 0).
> > >    - hart is executing trap handler
> > >        - "tp" is still pointing to user mode but csr_sscratch contains
> > >           ptr to task_struct. Thus numerically higher.
> > >        - "tp" is  pointing to task_struct but csr_sscratch now contains
> > >           either 0 or numerically smaller value (transiently holds
> > >           user mode tp)
> > >
> > > Patch also adds new cached type "ulong" in scripts/gdb/linux/utils.py
> > >
> > > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > >
> > > ---
> > > Since patch has changed a little bit from v1 and I didn't include
> > > changelog earlier, here it is.
> > >
> > > v1 --> v2:
> > >  - added logic to locate task_struct irrespective of priv
> > >  - made locating task_struct agnostic to bitness(32 vs 64).
> > >  - added caching of ulong type in scripts/gdb/linux/utils.py
> > >  - added more descriptive commit message
> > >
> > > v2 --> v3:
> > >  - amended commit message and source line to fit column width
> > >
> > > v3 --> v4:
> > >  - amended commit message and remove whitespace in source
> > >  - added Reviewed-by for reviewers
> > >
> > > v4 --> v5:
> > >  - changing the order of changelog and sign off/review tags in commit
> > > ---
> > > ---
> > >  scripts/gdb/linux/cpus.py  | 15 +++++++++++++++
> > >  scripts/gdb/linux/utils.py |  5 +++++
> > >  2 files changed, 20 insertions(+)
> > >
> > > diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> > > index 15fc4626d236..14c22f82449b 100644
> > > --- a/scripts/gdb/linux/cpus.py
> > > +++ b/scripts/gdb/linux/cpus.py
> > > @@ -173,6 +173,21 @@ def get_current_task(cpu):
> > >           else:
> > >               raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
> > >                                  "while running in userspace(EL0)")
> > > +    elif utils.is_target_arch("riscv"):
> > > +         current_tp = gdb.parse_and_eval("$tp")
> > > +         scratch_reg = gdb.parse_and_eval("$sscratch")
> > > +
> > > +         # by default tp points to current task
> > > +         current_task = current_tp.cast(task_ptr_type)
> > > +
> > > +         # scratch register is set 0 in trap handler after entering kernel.
> > > +         # When hart is in user mode, scratch register is pointing to task_struct.
> > > +         # and tp is used by user mode. So when scratch register holds larger value
> > > +         # (negative address as ulong is larger value) than tp, then use scratch register.
> > > +         if (scratch_reg.cast(utils.get_ulong_type()) > current_tp.cast(utils.get_ulong_type())):
> > > +             current_task = scratch_reg.cast(task_ptr_type)
> >
> > Why not if-else for the assignment here?
> >
> > > +
> > > +         return current_task.dereference()
> > >      else:
> > >          raise gdb.GdbError("Sorry, obtaining the current task is not yet "
> > >                             "supported with this arch")
> > > diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
> > > index 1553f68716cc..ddaf3089170d 100644
> > > --- a/scripts/gdb/linux/utils.py
> > > +++ b/scripts/gdb/linux/utils.py
> > > @@ -35,12 +35,17 @@ class CachedType:
> > >
> > >
> > >  long_type = CachedType("long")
> > > +ulong_type = CachedType("ulong")
> > >  atomic_long_type = CachedType("atomic_long_t")
> > >
> > >  def get_long_type():
> > >      global long_type
> > >      return long_type.get_type()
> > >
> > > +def get_ulong_type():
> > > +    global ulong_type
> > > +    return ulong_type.get_type()
> > > +
> > >  def offset_of(typeobj, field):
> > >      element = gdb.Value(0).cast(typeobj)
> > >      return int(str(element[field].address).split()[0], 16)
> >
> > Looks good to me otherwise.
> >
> > Jan
> >
> > --
> > Siemens AG, Technology
> > Competence Center Embedded Linux
>
> This patch had been pending for quite a while, and not sure if it's
> still acceptable to be merged, but from my testing it's working fine
> for me. Nevertheless, the v5 patch now has conflict with the current
> master, so I've slightly modified for reference. It would be helpful
> if Deepak can send v6 later on.

Thanks for testing it out.
I just sent out a v6 based on v6.6-rc5.

-Deepak

>
> Tested-by: Hsieh-Tseng Shen <woodrow.shen@sifive.com>
>
> v5 --> v6:
>  - dropped cache type "ulong" in scripts/gdb/linux/utils.py as it
>  already exists in the current upstream
> ---
>  scripts/gdb/linux/cpus.py | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> index 255dc18cb9da..f8325cab5f1b 100644
> --- a/scripts/gdb/linux/cpus.py
> +++ b/scripts/gdb/linux/cpus.py
> @@ -179,6 +179,21 @@ def get_current_task(cpu):
>          else:
>              raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
>                                 "while running in userspace(EL0)")
> +    elif utils.is_target_arch("riscv"):
> +        current_tp = gdb.parse_and_eval("$tp")
> +        scratch_reg = gdb.parse_and_eval("$sscratch")
> +
> +        # by default tp points to current task
> +        current_task = current_tp.cast(task_ptr_type)
> +
> +        # scratch register is set 0 in trap handler after entering kernel.
> +        # When hart is in user mode, scratch register is pointing to task_struct.
> +        # and tp is used by user mode. So when scratch register holds larger value
> +        # (negative address as ulong is larger value) than tp, then use scratch register.
> +        if (scratch_reg.cast(utils.get_ulong_type()) > current_tp.cast(utils.get_ulong_type())):
> +            current_task = scratch_reg.cast(task_ptr_type)
> +
> +            return current_task.dereference()
>      else:
>          raise gdb.GdbError("Sorry, obtaining the current task is not yet "
>                             "supported with this arch")
> --
> 2.31.1
>
> Thank you
