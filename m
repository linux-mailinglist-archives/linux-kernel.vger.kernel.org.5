Return-Path: <linux-kernel+bounces-135596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F75689C829
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AC61C23FDC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4573E1411C7;
	Mon,  8 Apr 2024 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4kInhAj"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DED140E5C;
	Mon,  8 Apr 2024 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589811; cv=none; b=GBR7NaaH0Pb3OIQ6ftLBpPRWBXWL9uEFYOujtK4dLTM2djxfMLFJyIaPpdMz8/AjEC6HHWCPC76YmEPjguKksUCb+uraFCr72gf+rhRAhADOLhyF5xgZqQvNOgXwOTknB+b2up8719eCTIcTwU1tu8CP53qgA6C4cwvgv98vujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589811; c=relaxed/simple;
	bh=YE2/eJwGtOKC270Pf6AD/gnWZLqa2aC+ZVpjLPeWt6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPT3LbWRHIRHlh+DvpXQZoOewF/7VoImhHmaq7Ch70YHrheV0YF0TcN58YVBZBoumGWtNf6YVItl+PI1ZJFXvUfwy4Fsc08kIHO0nyBvtNjVlL7QzPEMI5gkE4qzictJB6BMt0HsYqIWSR1XjNAVvFcux1y6L1acj0y3Pa+QcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4kInhAj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso1817968a12.2;
        Mon, 08 Apr 2024 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712589808; x=1713194608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE2/eJwGtOKC270Pf6AD/gnWZLqa2aC+ZVpjLPeWt6o=;
        b=Q4kInhAjPNSLPl8GBvfT2+gjLlxLpEp9SIAZm6hd7VxxY2dg/YlLc0JNngbtGh3UqN
         YEA88vUE9drO1dWiis5cxwTSRzPIBECdp1HxnMQh1mLXUnZlaCYDZi+/9Qgafm/8Cgck
         U1XnuCWLFf4qRkitCWJxc3CjFyuFhn8moHJT/LdHwVnGahfugAED2rGieueo1jWnKH3t
         HssxXWKoGcxLWV1UCczuC1+P3zrL9fa83+YgV7aEaGICLUxyoqSDqTVcRrCjqBYwXyOc
         zMfT6ZtvNzVatTDDx58r55F7KwiHgBSWiUUaeO2sdBZ4GYRJMJDvoIDaebPtQRy2BgQg
         6Ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712589808; x=1713194608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YE2/eJwGtOKC270Pf6AD/gnWZLqa2aC+ZVpjLPeWt6o=;
        b=bGABpB+VTiJvF+yGWAVCVEAJ1vwv91GlLvpTiUkf3eGuK6PBft/LXO8B9XXwJTZh2H
         MVdPLfp7goRv3Y5959AMg99BTA2aAOC2bYZt56Hc76h/753gHqr9QGUa+pOR5rDI5/xD
         YtIS53r6lA9lrjRojQvrWxKsEO3ArqZ2920WXcT6TOpwBimWa3Jdk08QK1LPDp/jbbJL
         06iYO82Iy3ELsKfL4Kw1fFvxCAwdRmO2B6xli2LiuBRMAG6Z8HYmva1XXgCj/Nds46gI
         FQW1xGox65wKWutFMHmzszzYT0yXkfOBawPGtLzwTgDRMGGiQn9pfljIj/YjHqfaEsdT
         MgPw==
X-Forwarded-Encrypted: i=1; AJvYcCXleMFBCP4/VWQicLEDhmzOdU3rrewP8zu2RQxw3Aq5g3gGesuOKAW+sNxmZ3+ECgb4X3gGV72dtfXad5fo9pJqmwE+xjKzxQymbCOeYTXpOXPHrrYoilaCpZOcuwSBZecc2no0Gd5GdgFxUD0=
X-Gm-Message-State: AOJu0YzpOFzaO/YaMwoFLRqx940MwJuJbCeaX/sWnc7AicxKlj8bIzVf
	Ma1S82mhQAh2oRVRKqoHQy1f9ASmJTUIoKhu71jXC1MrL5O4CLCDLejLYHFf0n9dle8NQPE2wPW
	OB61PNE1jyl0G1sG686R1Rjbwo9h7n7SqjF0=
X-Google-Smtp-Source: AGHT+IEJvbxzuNcQXgeFuh8Ke1Vj6bw5Qs2GP3BPuhWpp9IRpSdKAmcs1TpqyhEdrxoRqqjjfJIzAib9+6pfN5hwvYs=
X-Received: by 2002:a50:d59b:0:b0:56b:cfef:b2de with SMTP id
 v27-20020a50d59b000000b0056bcfefb2demr7217258edi.26.1712589807970; Mon, 08
 Apr 2024 08:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72meap5C9bkj5rNDE=0U5gb5OKwDrrTSrVRwJbkAPWgUsg@mail.gmail.com>
 <d912f0e0-19d5-4cde-a548-10db94da15a9@yahoo.de>
In-Reply-To: <d912f0e0-19d5-4cde-a548-10db94da15a9@yahoo.de>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Mon, 8 Apr 2024 17:22:49 +0200
Message-ID: <CAA76j92Sd-YN=UYET7jyMyBuzyhET+rwqF-Rxo-0S_60+TUX1Q@mail.gmail.com>
Subject: Re: [PATCH] x86/insn_decoder_test: allow longer symbol-names
To: Danilo Krummrich <danilokrummrich@yahoo.de>
Cc: miguel.ojeda.sandonis@gmail.com, tglx@linutronix.de, x86@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	david@readahead.eu, davidgow@google.com, hpa@zytor.com, 
	john.m.baublitz@gmail.com, linux-kernel@vger.kernel.org, mhiramat@kernel.org, 
	mingo@kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I was just waiting in case there was feedback from David Rheinsberg.

Cheers!

On Mon, 8 Apr 2024 at 14:52, Danilo Krummrich <danilokrummrich@yahoo.de> wr=
ote:
>
> On 2/20/24 18:07, Miguel Ojeda wrote:
> >
> > On Fri, Jan 27, 2023 at 11:39=E2=80=AFAM David Rheinsberg <david@readah=
ead.eu> wrote:
> >>
> >> The current workaround is to just disable CONFIG_X86_DECODER_SELFTEST,=
 which I thought is a sad state. I can gladly use `256 + KSYM_NAME_LEN` and=
 add a comment ala "room for insn-encoding and a symbol name". Would that b=
e acceptable? The alternative would be to try to dyn-alloc a buffer and inc=
rease it to the actual line-length?
> >
> > John independently hit this issue again. Could we fix this? Going for
> > the `256 + KSYM_NAME_LEN` sounds good enough for the moment since it
> > would be a clear improvement, though I agree this could be cleaned up
> > further.
>
> I hit this independently as well. Miguel pointed me on this mail thread
> when I sent another fix for this in [1].
>
> >
> > Sergio took the approach David suggested in a related patch [1], but
> > perhaps it is best to submit the fix on its own so that it is easier
> > to put it in. David, would you be so kind as to submit a v2 with that?
> > Hopefully x86 can pick it up, otherwise with an Acked-by I am happy to
> > take it too; and then Sergio can submit his patch on top again.
>
> Sergio, David: Do you intend to follow up on this? Otherwise, I can also
> pick this up and re-submit.
>
> - Danilo
>
> >
> > Thanks!
> >
> > (Cc'ing also Masami who wrote this originally)
> >
> > [1] https://lore.kernel.org/rust-for-linux/20231119180145.157455-1-serg=
io.collado@gmail.com/
> >
> > Cheers,
> > Miguel
>
> [1] https://lore.kernel.org/rust-for-linux/20240325174924.95899-2-dakr@re=
dhat.com/

