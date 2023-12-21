Return-Path: <linux-kernel+bounces-7965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E065A81AFD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8854C1F26072
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE58156D6;
	Thu, 21 Dec 2023 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A258R30z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F254154AC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e3845abdaso659288e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703145290; x=1703750090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8JlMGjDbWI3o2X+Vm2WsAsXNAIE0NMID+aG9ZAdKHE=;
        b=A258R30zg4SW/10IOujCIMI6xco00hx18JAkRJa7H0fLgxnxy4DY6wWi1JJlVFtAM0
         mvURlppIYd4cjmZef9r85o/tzmBa+l6/aeNrHyGMGPek4uckqhIoRMHTnbkGm7MSjLOU
         jioDGcKKteNDT702Guw3JejeHvIWCh03Kqk4ZlEF6UDSNK3sx50L6Pq5dIjkQ3oJaN96
         UbuOOP2pjH70TLnij1bXwO52UAxoUVz/V9J6D5HbuSINB1AAjQLdf60us/brUzMSsDXB
         63rqaPk7JdQNk/9oHjgWfZUkscuk20WLmH8VxUtUIMt4XH7oNGhztDM6x5PJ1cjEaA25
         oO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703145290; x=1703750090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8JlMGjDbWI3o2X+Vm2WsAsXNAIE0NMID+aG9ZAdKHE=;
        b=vMYky7EZF9jWTY6Hp0jg03YEphNI4XmYEMML59vbh9j2GIFTGdRPaDHRNq0NPxYyV+
         99B+SBxwpEYCzGoQJgzoE9rwseIA4X6kLyz5S6PW45aqqAUT/H2+TllKqS5yrehEy685
         qc1TSM4lRGjebcvTS5VT/5KDsLLiiGNrmBAwG7jqGIJ3iJNDLxiA03lhzLkkW7tnKAGu
         Qf3/koipYSO0dUxjjz1guBex86OHfLZNNuVnxunwmMVT3RsFi4VIHNGHVj0SJZW2Xj/6
         W5W6Eo0Ls7aCU6Df34QTUR7nICFVzzyQPtLUIrg/H3Wc6Vel+ibJ4dosFK3bOtd+Ywa+
         Ju/w==
X-Gm-Message-State: AOJu0YzAlBxzFURv9DRhw/dI2fjrjl9DxeoTDNdC4BSN5pVbFr8qt5XU
	5WVZOqozkBqfQPanlsAi1+wbdA+TGnDDwOeWcVIVig==
X-Google-Smtp-Source: AGHT+IHXE0SvvKh+BBlfB/Y28NFVLbZii8VCDwvUjc5vj9hOtWga8E1x1lbDDWosb6/uDp0Ep2qmMzbPoEnytsptros=
X-Received: by 2002:a05:6512:3b11:b0:50e:5072:3f94 with SMTP id
 f17-20020a0565123b1100b0050e50723f94mr1739541lfv.99.1703145290001; Wed, 20
 Dec 2023 23:54:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221070449.1809020-1-songshuaishuai@tinylab.org> <DM8PR11MB5751B02E235561D402D4C608B895A@DM8PR11MB5751.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB5751B02E235561D402D4C608B895A@DM8PR11MB5751.namprd11.prod.outlook.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 21 Dec 2023 15:54:38 +0800
Message-ID: <CABgGipVKwpyAwYL1yQrkt_fJb94eMZTU_xrvgmnrzVsud+-1XA@mail.gmail.com>
Subject: Re: [PATCH] riscv: vector: Check SR_SD before saving vstate
To: "Wang, Xiao W" <xiao.w.wang@intel.com>
Cc: Song Shuai <songshuaishuai@tinylab.org>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "greentime.hu@sifive.com" <greentime.hu@sifive.com>, 
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>, "guoren@kernel.org" <guoren@kernel.org>, 
	"bjorn@rivosinc.com" <bjorn@rivosinc.com>, "heiko@sntech.de" <heiko@sntech.de>, 
	"ruinland.tsai@sifive.com" <ruinland.tsai@sifive.com>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 3:37=E2=80=AFPM Wang, Xiao W <xiao.w.wang@intel.com=
> wrote:
>
>
>
> > -----Original Message-----
> > From: Song Shuai <songshuaishuai@tinylab.org>
> > Sent: Thursday, December 21, 2023 3:05 PM
> > To: paul.walmsley@sifive.com; palmer@dabbelt.com;
> > aou@eecs.berkeley.edu; andy.chiu@sifive.com; greentime.hu@sifive.com;
> > conor.dooley@microchip.com; guoren@kernel.org;
> > songshuaishuai@tinylab.org; bjorn@rivosinc.com; Wang, Xiao W
> > <xiao.w.wang@intel.com>; heiko@sntech.de; ruinland.tsai@sifive.com
> > Cc: linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] riscv: vector: Check SR_SD before saving vstate
> >
> > The SD bit summarizes the dirty states of FS, VS, or XS fields,
> > providing a "fast check" before saving fstate or vstate.
> >
> > Let __switch_to_vector() check SD bit as __switch_to_fpu() does.
>
> It looks a duplication of status check since the __switch_to_*() internal=
ly will check the ext specific status bit.
> Can we just remove SR_SD check for the fpu() case?

Hi, I came to the same question when adding the Vector context switch.
I think the better solution is to skip saving both fpu and vector if
the SD is clear. However, this may make code less maintainable because
fpu and vector code are scattered and we must mix code together by
doing that. Also, we will have to duplicate has_fpu and has_vector
check because of the branch dependency

e.g.

if (likely((regs->status & SR_SD))) {
    if (has_fpu())
        fstate_save()
    if (has_vector())
        vstate_save()
}

if (has_fpu()) <--- duplicated check (nop)
    fstate_restore()
if (has_vector()) <--- same
    vstate_restore()

So, it really is "Is it worth to trade extra nop with SR_SD that
potentially skip one SR_*S check"

Besides, with user space libraries start embracing Vector, I don't
expect SR_SD would be in "cleared" state very often. Though I haven't
done any real-world experiment yet.

>
> BRs,
> Xiao
>
> >
> > Fixes: 3a2df6323def ("riscv: Add task switch support for vector")
> > Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> > ---
> >  arch/riscv/include/asm/vector.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/v=
ector.h
> > index 87aaef656257..d30fa56f67c6 100644
> > --- a/arch/riscv/include/asm/vector.h
> > +++ b/arch/riscv/include/asm/vector.h
> > @@ -190,7 +190,8 @@ static inline void __switch_to_vector(struct
> > task_struct *prev,
> >       struct pt_regs *regs;
> >
> >       regs =3D task_pt_regs(prev);
> > -     riscv_v_vstate_save(prev, regs);
> > +     if (unlikely(regs->status & SR_SD))
> > +             riscv_v_vstate_save(prev, regs);
> >       riscv_v_vstate_restore(next, task_pt_regs(next));
> >  }
> >
> > --
> > 2.20.1
>

Thanks,
Andy

