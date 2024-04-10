Return-Path: <linux-kernel+bounces-137901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7842A89E936
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4942845D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26BF10979;
	Wed, 10 Apr 2024 04:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="jOk3fCct"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7B8F44
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712724790; cv=none; b=RJy14Bv4snc/tcfQoMfzG6tSKP5jw8gtSE2KNSUL4hvmhB0Q2NXmUcxEX9JgPPLhD4nWHdfiGS7TttiMsYAElYXWC6nXo19G/jO6gVm6DSuxra3MybPO1YljkOXH01uqWjMa9mR3pc+lxAJXdvGcddpXMUcgm5XfBLFDiF9G0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712724790; c=relaxed/simple;
	bh=3a6xBxfBTuhDr2mbQLGPWuHFkhHEu34jB6fMbSSBIMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2WNzHiQyJk4jNuIUvz8hSsuobI9kU+pRhr2/4DJtYbm+oq89wDDQV084BIptQc9i05w4uyY9FqTKrDnSJBxtDoLhXH9nFGrttZJNVDdpBqXyvZSQagp+c3hTDmNKEA1hZvQ/FpmJGqKOoa2lM/leYaRLkvAmUROo1zkX72Ms7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=jOk3fCct; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6164d7a02d2so69226677b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 21:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712724787; x=1713329587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAE654Au+Cu+yFu/o4oiBY/gYWIOkPFch6LZEH21s18=;
        b=jOk3fCctb4fHEoPQEO5uJl8V/0I2FBpxAe3Hfk97dF/I1ixePj9Q+2I3RvNoh1EM7/
         9BH9iVuisz9A1BEay62wnyF1mPAHm5u5j7HYpXyjNjzSViFiR1k56HF6dTPLStMEk03R
         B84pSV9h7dtS7+Hz/btQ2FxSuFMnmj4+toBldZKE8DD4l1w874IkZCTfyywesLjfLzSd
         000M3VwP4ixfEagLu3MkyGfk/9Qr3QE7KaWZ6Q92t+JaXsQkGLwfZZePgUFP+Dz/NJT8
         Lc2pnZmdfCjHc+CWvdXWAqeUalhyJyPqdkH23CWESEoCUTShdl/3Pd3kEBPnXyeiagg8
         KiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712724787; x=1713329587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAE654Au+Cu+yFu/o4oiBY/gYWIOkPFch6LZEH21s18=;
        b=IZaArQH88ef24ISU9cki4ZVcJzPblXKgN1X5lHSFO3EqOr7vSLHXY4NTxkDdZ2PJwB
         REIL3v8PpOhGMSYPcZj0wcowdFmLJ9taiixFXO8oe6IfW5Nnd6260XDIV5HLHL5/gzzH
         qSmTGFh4iG1/wCOaMAdH+vfBiefdZkiGRbcr3+nYBxVjn7lgoejjzRSe/z3jDqz/8xhc
         29S0lvpJOv+K0YC8ZuqkPMjT39AKOO2214+gQ927BEjs3VcBA/ymj1BMyYGQ8kgmEPIz
         FH5K0izTOzWzPUcah60meTaP3QLQ03ldzUqDwh5txsOEtc/Gh7MJUsirRysvzYYZDQ9t
         2Xag==
X-Forwarded-Encrypted: i=1; AJvYcCXtlvfZ4Jkie/7CKi7flirl2PSylxDkluD2A+8MqD0dwL/NK575zdUAw8pD+sDg5/3317giSbtXfNQQj5b4ZyGAhSoosunZzVYINLR5
X-Gm-Message-State: AOJu0YyF+TbMS0R6FUMMgP1u+L65jkOxTzwRgEbRrJWC4swWolTPgOSx
	1UjSJdV5aCR3QgnL7V6f8jX70c9mL939OGQ0BWcNCl40Lo2Lmz71cOICPeA/fhPvdmd5Dq3SZM/
	OLU1zF16v3e9nLaifNmVzi+SoE96SFb1a7X8GHg==
X-Google-Smtp-Source: AGHT+IEDQQpBK6XZSXPAqfxDh052kSypvbxtnqC3reJifSRqNmfuSjm5X9w5rcmwQrEa+f9DgnRsbZq8Dcp6o9bI66s=
X-Received: by 2002:a81:8346:0:b0:614:42b1:edd8 with SMTP id
 t67-20020a818346000000b0061442b1edd8mr1883003ywf.2.1712724786123; Tue, 09 Apr
 2024 21:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408100607.1732600-1-lei.chen@smartx.com> <ZhT22tl/Iho5M+1x@gmail.com>
In-Reply-To: <ZhT22tl/Iho5M+1x@gmail.com>
From: Lei Chen <lei.chen@smartx.com>
Date: Wed, 10 Apr 2024 12:52:55 +0800
Message-ID: <CAKcXpBz0wsabXFLK3uSgXn2sti11VcZeZz1c6G=7P6RoiExqjw@mail.gmail.com>
Subject: Re: [PATCH RESEND] x86/tsc: print some log if calibrated tsc freq
 deviates from original too much
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 4:05=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Lei Chen <lei.chen@smartx.com> wrote:
>
> > In most cases, tsc_khz is refined by hpet on boot. But in a few
> > production-level nodes, the refinement fails because calibrated
> > freq diviates from origin tsc freq more than 1%. Printing some
> > logs will help get this info.
> >
> > Signed-off-by: Lei Chen <lei.chen@smartx.com>
> > ---
> >  arch/x86/kernel/tsc.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 15f97c0abc9d..a68b16e72df1 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1435,8 +1435,15 @@ static void tsc_refine_calibration_work(struct w=
ork_struct *work)
> >       }
> >
> >       /* Make sure we're within 1% */
> > -     if (abs(tsc_khz - freq) > tsc_khz/100)
> > +     if (abs(tsc_khz - freq) > tsc_khz/100) {
> > +             pr_warn("Warning: TSC freq calibrated by [%s]: %lu.%03lu =
MHz deviates too much from original freq: %lu.%03lu MHz\n",
>
> Yeah, so it wouldn't cost us anything to more precisely define 'too much'=
:
>
>  s/deviates too much from
>   /deviates by more than 1% from
>
> Right?

Thanks for your suggestion, I'll change it.


>
> > +                     hpet ? "HPET" : "PM_TIMER",
> > +                     (unsigned long)freq / 1000,
> > +                     (unsigned long)freq % 1000,
> > +                     (unsigned long)tsc_khz / 1000,
> > +                     (unsigned long)tsc_khz % 1000);
> >               goto out;
> > +     }
>
> The warning makes sense I suppose, if it's one per system and once per
> bootup [right?], but I think pr_info() would be plenty enough priority fo=
r
> this condition - especially as we didn't have the warning before and don'=
t
> know how frequent it is?
>
I'm afraid tsc frequency deviates from HPET more than 1% is a system risk.
It means either HPET or tsc might be not stable. Users should be cautious o=
f
the risk and turn to ntp for help. In our production nodes, it indeed
causes more
time skew.  So maybe warning is a better way to expose the risk ?

