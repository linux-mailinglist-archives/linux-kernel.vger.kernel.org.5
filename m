Return-Path: <linux-kernel+bounces-154089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE098AD742
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612681F219FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BFB1F932;
	Mon, 22 Apr 2024 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6KIrESC"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2871CF8B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824888; cv=none; b=biPcmrBfR8+/Y7VC0nmrfN0X/FxBQVLH/kyN4Uf5KmCmsK+t3cK5Ei8hBUG1r6cJp6Ak4hid8+iF78XCeSPaQcBF8Q+TqVjgOOJQ+kAdemhOgSr6fQD6Z/Vp7piN+bdDkKmQAl6kmU5MVU7zEQG6/EEApw+taDaAtZ5DnYl5bT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824888; c=relaxed/simple;
	bh=MLFkybndloaTyhzy2NSZlChDIyrEPGzYpaVyXPRXuPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAfYQTnK7CmCKEDyIss6Huw9hMVi8jLrCyXohST0QXCvk+ct30FSo+2iThkaQBfz25AFWzhCtWKhZheDd6gDC3HU8cq+W50vPTceguFDO/ZYO4oIFE+uyAI5Uy82fzdZdAqkjkx59Niuu4I9A24C5a29wIF5yIBKe6EbnftiKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6KIrESC; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ac8c73cf88so3228629eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713824885; x=1714429685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=leSnoNO9vQrVE5sfz5zVqfPLAcq7aLQPMSXK8GtpNmg=;
        b=N6KIrESCM3tkYm1ICQEHhzqGPTNy9HtXTfBX8KWhH99ICtwSVWB5GwyQzgKPijOyl+
         8notiZqfalyKnfvG6l9maizlCDn9JUDklj+ubQaJo0L9sEHs1Ulcz2tA/pIQRewHN2Tv
         6zZktUPEBVbFukST9xjIPN8iZBhkfOaCGgmaat6goIq/KqjDK3dBPHPj0DqzRW0PmJzM
         MWmq/wZAewEJfxL8BALMb9M4dejbxJzRSwm2Y4jV44xymNseckJGwRBb7uOlq1QyIr1a
         lgzbNWpJI7RK34sZowETfTsLpPJpwYYuMl9VAOJkQvnY44Ha6VoOTZD9uUVieKGXw5LF
         23JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713824885; x=1714429685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leSnoNO9vQrVE5sfz5zVqfPLAcq7aLQPMSXK8GtpNmg=;
        b=HLQp0ApWt1SFK076gr78xQ11OXNMubnyQcMQNw1AiDU6bCFQZ7NgtopIsowXLikn22
         2i2pbyEDxVf0kbIHU8P16Gko5hkkoru25/yDFj1Ye4IVdunSLPJNlRtkKrTHfI0fyb9L
         /AFR3YW1gf6ydVLEdaKCCdHp0oky58hcLE5gFDL7Pt08AfkHQ7md/eAyfmuBKmWZrDZW
         TZTqNmjG3IJUTrLmMxz58IyuuujwD91vSaD/QiHhLCnfWGvGV/MO5m5RAKqmzUv3x7F0
         EwRSgn5RrwQIa2FdAioVyXFPh23SyrzlArE7mlsGlR0v/2zzipgST/yZLUo7WkE9arbo
         yHKw==
X-Forwarded-Encrypted: i=1; AJvYcCVw5C4hf46vMlQK1XUB3Vdj2TVG1k9gjulGmh9MUASEOoUuzMByhAMlQ6uvI4iwg6l7JVXpeH+6YpG89qAM0c/7eJ4NfNEg7IamyHYK
X-Gm-Message-State: AOJu0YxWz58xtJjN5AgJADeex7yIJOInis9ax+CxPaFQM3+iJSzOZl+w
	6D7vegRPse1sAtmU1sNeyqwiws+UNzscv90KX9RIQ1xhjWUPPgOa
X-Google-Smtp-Source: AGHT+IHiOHr8xZRKoetz1ZzJBPH+u6GDsOzHrYk5JQ+BDVFcxTuSV7o1i1zwGeTrrvdEyq47MPFIKg==
X-Received: by 2002:a05:6358:2c83:b0:183:f0e8:b632 with SMTP id l3-20020a0563582c8300b00183f0e8b632mr15132548rwm.11.1713824885499;
        Mon, 22 Apr 2024 15:28:05 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id du30-20020a05620a47de00b0078d65fbde2bsm4698001qkb.86.2024.04.22.15.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:28:05 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 9BB201200043;
	Mon, 22 Apr 2024 18:28:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 22 Apr 2024 18:28:04 -0400
X-ME-Sender: <xms:dOQmZkRlpJLzYftwkomOnWRndCZ9vjlczdCOUpFp8dC0xHUktf4FTw>
    <xme:dOQmZhxSoL1xv5De6takD1MxXcY4ePQuyCdv2Lato3HMuUq9rNCYm5UjfV7IRgnMY
    0BOx-QeiwT-iBOmyg>
X-ME-Received: <xmr:dOQmZh12OLjtkGgqdq7blBSuCW55GVJzLomfujsFyBktjMnymZVH1N_6JLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:dOQmZoDEx3eSldEQayVz95tdMwg2XCywDLmEpAwQ-vQQI0QkszNuUg>
    <xmx:dOQmZthu3dxzE1VSIvLsLceM4nJUPw5yxMOQq9oB98S62RtLPdtXkg>
    <xmx:dOQmZkre5PsacGAvlN_3IDBEgFxmq5a-NnaMS__biGyYZVXUa59p_A>
    <xmx:dOQmZgiz_mrR7FjOlBip7fTbEc8sq9VBamyJGjyd1JQp0nToQZmKhg>
    <xmx:dOQmZkQ3XGfvfYXQtN1MvkN-sh-tlojo-JvFe_7tyGsxKdvWE40r4N5Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 18:28:04 -0400 (EDT)
Date: Mon, 22 Apr 2024 15:28:02 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/pvqspinlock/x86: Use _Q_LOCKED_VAL in
 PV_UNLOCK_ASM macro
Message-ID: <ZibkclTJf4oeS6IB@boqun-archlinux>
References: <20240422151752.53997-1-ubizjak@gmail.com>
 <Zia-VeObR-m6Bf39@boqun-archlinux>
 <CAFULd4ZhTAY9irw8V=MLZpjQK+q0AM_Aw8g2E=ivHjv7+5m9Zg@mail.gmail.com>
 <ZibB5zp5DcCmC9gP@boqun-archlinux>
 <CAFULd4bxtH_Eo3j6kXDBOs_a4u4qsneOfm9t0c-fxGHo5L_FuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4bxtH_Eo3j6kXDBOs_a4u4qsneOfm9t0c-fxGHo5L_FuQ@mail.gmail.com>

On Mon, Apr 22, 2024 at 10:12:11PM +0200, Uros Bizjak wrote:
> On Mon, Apr 22, 2024 at 10:00 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Apr 22, 2024 at 09:57:04PM +0200, Uros Bizjak wrote:
> > > On Mon, Apr 22, 2024 at 9:45 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > >
> > > > > diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
> > > > > index 466af57b8ed6..0a985784be9b 100644
> > > > > --- a/arch/x86/include/asm/qspinlock_paravirt.h
> > > > > +++ b/arch/x86/include/asm/qspinlock_paravirt.h
> > > > > @@ -40,7 +40,7 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
> > > > >  #define PV_UNLOCK_ASM                                                        \
> > > > >       FRAME_BEGIN                                                     \
> > > > >       "push  %rdx\n\t"                                                \
> > > > > -     "mov   $0x1,%eax\n\t"                                           \
> > > > > +     "mov   $" __stringify(_Q_LOCKED_VAL) ",%eax\n\t"                \
> > > > >       "xor   %edx,%edx\n\t"                                           \
> > > > >       LOCK_PREFIX "cmpxchg %dl,(%rdi)\n\t"                            \
> > > > >       "jne   .slowpath\n\t"                                           \
> > > >
> > > > There is also a "cmp $0x1,%al" afterwards.
> > >
> > > Not anymore. Please note that the patch is against -tip, where we have:
> > >
> >
> > Oh, thanks for the information. Maybe it makes sense to mention the
> > patches dependency in the commit log?
> 
> Hm, yes ... I should mention this as "[PATCH -tip]" in the subject
> line to avoid confusion with this particular patch.
> 

Anyway, the code looks good to me.

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> Thanks,
> Uros.

