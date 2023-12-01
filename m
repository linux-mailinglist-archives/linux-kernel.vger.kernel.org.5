Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B9C800500
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377758AbjLAHsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjLAHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:48:17 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766DA128
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:48:23 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54c671acd2eso10620a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701416902; x=1702021702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BqqO/q4f6pFgF1PPCq8ZVSkps1XzTjSMsOrJ9t4F9/I=;
        b=IjI7Wo7Bm9xr0H9WMUILgjVAdSBPPWrvMnlNSD2QPHxKe43SaZuYXlGm8ppLcGO7y/
         jGsxnAFRVtA/u8wKOXAsqnPzY6RzIj0peAtGwUrOTuc00Vx6HMvi34yhebx9LTOALHMb
         lerPuCAkxB48HqsprdOAKv/pA/CHC6q5IM0poppY7Ncojm80MYRuIXL/HmjeKY7eeIWs
         f/WwiMEXXYzjQxawjQUdA5N8OWS0TlwR2J/BUgQ9cDQusMxWtXm1h2zNQ5HGSwHyer02
         Yf663V58C5raqoFdEX/ltAZ57+UMh5Ynh/blQDgPvxCpoT15+HxNg5DUDiN7vCe3Fmsm
         a0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701416902; x=1702021702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqqO/q4f6pFgF1PPCq8ZVSkps1XzTjSMsOrJ9t4F9/I=;
        b=DbxMJie2CSG87DPF5aI5NMst1rEtiFNMLRFG68t8kbf95p5CJc+AgV3QsbM11/byo9
         5eqJkpWg0EJn5h/ErSrBWYGruNGGAX1VRxDqwvCxuikd8sr0A+kDHJ8rVSgagja1nTYa
         FdYQUa5c02ufQYaqlBn/mXjdVN1l00UJdACiRg+u1oPB7hDthNYiSbK2Cp5b2NBhXn63
         NqVIWRAzcP5mRqvt4/fHL6BCpQCIz7M0NBlMFqooBMZD7jFqzx3drwd49c2anYfyxDz4
         9b2Lc245dDRzxs1VM9e2Ry/xVaeJK8rlUcAUrLUsSPzWj/P8ivSqiGRicc0oLrTuBQpr
         uOWg==
X-Gm-Message-State: AOJu0YzwNQI/qoL92q/wxdbN64HxmVX6F0Du5DxsvEC+0fVvmR3D2gU8
        eFaynmdvI9VH7ufNR5K0GIUtF3dU+LUjuWWhD3aGe5ehK8U=
X-Google-Smtp-Source: AGHT+IHXt7iWmWAHVO6dLBENFB4BU1iOkeDYAFaPuDdzu9erF2c9fh5ZDPqFa2o+OlhWO+47MvbVCk1IY20gs45gSgI=
X-Received: by 2002:a50:a404:0:b0:548:7a6f:b51e with SMTP id
 u4-20020a50a404000000b005487a6fb51emr498989edb.14.1701416901693; Thu, 30 Nov
 2023 23:48:21 -0800 (PST)
MIME-Version: 1.0
References: <20231105213731.1878100-1-ubizjak@gmail.com> <20231105213731.1878100-3-ubizjak@gmail.com>
 <20231201035457.GA321497@dev-arch.thelio-3990X>
In-Reply-To: <20231201035457.GA321497@dev-arch.thelio-3990X>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 1 Dec 2023 08:48:10 +0100
Message-ID: <CAFULd4YWa+Xfue-JEebR9JgjxKtQy7byr68Q+tTOdR+Jf1DBEg@mail.gmail.com>
Subject: Re: [PATCH -tip v2 2/3] x86/callthunks: Handle %rip-relative
 relocations in call thunk template
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, llvm@lists.linux.dev
Content-Type: multipart/mixed; boundary="0000000000000a641c060b6dfec8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000a641c060b6dfec8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 4:55=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> Hi Uros,
>
> On Sun, Nov 05, 2023 at 10:34:36PM +0100, Uros Bizjak wrote:
> > Contrary to alternatives, relocations are currently not supported in
> > call thunk templates.  Re-use the existing infrastructure from
> > alternative.c to allow %rip-relative relocations when copying call
> > thunk template from its storage location.
> >
> > The patch allows unification of ASM_INCREMENT_CALL_DEPTH, which already
> > uses PER_CPU_VAR macro, with INCREMENT_CALL_DEPTH, used in call thunk
> > template, which is currently limited to use absolute address.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ...
> > diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.=
c
> > index e9ad518a5003..ef9c04707b3c 100644
> > --- a/arch/x86/kernel/callthunks.c
> > +++ b/arch/x86/kernel/callthunks.c
> ...
> > @@ -291,20 +298,27 @@ void *callthunks_translate_call_dest(void *dest)
> >  static bool is_callthunk(void *addr)
> >  {
> >       unsigned int tmpl_size =3D SKL_TMPL_SIZE;
> > -     void *tmpl =3D skl_call_thunk_template;
> > +     u8 insn_buff[MAX_PATCH_LEN];
> >       unsigned long dest;
> > +     u8 *pad;
> >
> >       dest =3D roundup((unsigned long)addr, CONFIG_FUNCTION_ALIGNMENT);
> >       if (!thunks_initialized || skip_addr((void *)dest))
> >               return false;
> >
> > -     return !bcmp((void *)(dest - tmpl_size), tmpl, tmpl_size);
> > +     *pad =3D dest - tmpl_size;
>
> Clang warns (or errors with CONFIG_WERROR=3Dy):

Uh, GCC didn't warn at all (and there is some mixup with types here,
so a thinko slipped through.

The attached patch fixes the oversight. I'll post a formal patch later
today after some more testing.

Thanks,
Uros.

--0000000000000a641c060b6dfec8
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lpmbofu90>
X-Attachment-Id: f_lpmbofu90

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jYWxsdGh1bmtzLmMgYi9hcmNoL3g4Ni9rZXJu
ZWwvY2FsbHRodW5rcy5jCmluZGV4IGY1NTA3Yzk1ZTdiZS4uNzFiNzRhMDdjOGVlIDEwMDY0NAot
LS0gYS9hcmNoL3g4Ni9rZXJuZWwvY2FsbHRodW5rcy5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9j
YWxsdGh1bmtzLmMKQEAgLTMwNiw3ICszMDYsNyBAQCBzdGF0aWMgYm9vbCBpc19jYWxsdGh1bmso
dm9pZCAqYWRkcikKIAlpZiAoIXRodW5rc19pbml0aWFsaXplZCB8fCBza2lwX2FkZHIoKHZvaWQg
KilkZXN0KSkKIAkJcmV0dXJuIGZhbHNlOwogCi0JKnBhZCA9IGRlc3QgLSB0bXBsX3NpemU7CisJ
cGFkID0gKHZvaWQgKilkZXN0IC0gdG1wbF9zaXplOwogCiAJbWVtY3B5KGluc25fYnVmZiwgc2ts
X2NhbGxfdGh1bmtfdGVtcGxhdGUsIHRtcGxfc2l6ZSk7CiAJYXBwbHlfcmVsb2NhdGlvbihpbnNu
X2J1ZmYsIHRtcGxfc2l6ZSwgcGFkLAo=
--0000000000000a641c060b6dfec8--
