Return-Path: <linux-kernel+bounces-125445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81649892605
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C241C2130A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B5613BC16;
	Fri, 29 Mar 2024 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h02OONrK"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910E138FAD;
	Fri, 29 Mar 2024 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711747613; cv=none; b=o3hT6rBlhYRPp3nILeYSgLH5jgw3/ahNcI+sDsQW7a6Oq02j3c5prNzS0n5vJx9TVbZQcqIgvdV9HTstLuoPtW/jT0vcYIvofBPyJUl7qtv3N1ZcCALaUGLdrgZBAPv1JUH+kyrmT9ybQHjLzeMASpgNwI0hFSXpPucdmpDSanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711747613; c=relaxed/simple;
	bh=GY2kYFst4z/jzDluAZKuRs3VnNLG/lJw8nm0VcFYikM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvWQ2A0CseIsL9FgYjN6zPufVIpQqiRzxpxfWWir2S2bRrkalHeIYKni2SW9MnB9+iKThkvwKO+Zn5Zssl7qqHveQk51ff9EJpUn5NhPHVmY4QJ0TF4i9BP87FJsd1aA9g47SAdGsUrEEJEsLIDX4ANMZG8S1Gjnd1qw8tZdsRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h02OONrK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341c9926f98so1441462f8f.1;
        Fri, 29 Mar 2024 14:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711747610; x=1712352410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kvv9NiziDyCYu9Ssy1MqwcYz3Obg+5qR7kJAYV5rLhc=;
        b=h02OONrKn+4k88m3UEDllV8o8JUuB2NguuTGHZzCXHNiOAa9yBQIiaGmfQsGVV86q3
         vwTm5pN9qCEJWhO3/1dihonK9iCD1MV6zVd13EikzldfB4dxhYg+3Wg6vO0czEsr1HAc
         Xnut8+4zSVKD/nOdEua3WuEO6t2FYuiIILMfvrA145eDAhyL+bLHHiztPM0IEukc3eMT
         QwkIybVK8O22yg5D4IKFhCt9QnTfLrqtSCdTICpGqqxHghVj4Ift5u/IfjSrR2EkEVNe
         CwHVBQEan1clULUfxVR4imy+rZpP4IILFDkrBGL8rfHg7ZbgGF/FY9ZH05/vNFFyN9i4
         L+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711747610; x=1712352410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kvv9NiziDyCYu9Ssy1MqwcYz3Obg+5qR7kJAYV5rLhc=;
        b=AZml1tLtFlyP9+6qzsr/Y/Kp5igFrK2oUC/WIz//Zmu/5fSRzhVpw37aRWeKK6hdX/
         FxsJBUEiOwP7rnH9cVh0eWtHbz2qaashwfXDE6sVeXzEDIGZGpGu23nNdVQXdmSsPoym
         +exTdbi8fY0pCW6bB8Bl9QHeCnAfsqlPKJyaAjnrOHw5Qw9qdI1S9gC2eq0WbnVy6iHQ
         7tLKPnU50UXa4ii7btWPm2rqB3S45MtzAeOOLaaKgubovEhMNhC+usRZ5ijfKdVYpIhu
         bTcuciA022kGsoViz3poqnsJ0p8W9ojwHusnFV0FwDvrqrw9MTAV+LH+DM//g3kcbyjr
         T4ig==
X-Forwarded-Encrypted: i=1; AJvYcCUms6Y8mQXobn6Doc4LggzSXZfoQDIm/IKPAkO+/bgLih/BXEZjjKJJx2V38SsUeCaJy1R/1BisLsDktGAF092Q8+cQmdOHd3i65roTYjtnFDPo2/M4ZlO8bb6wJr5fOR5UJWeLxlciGCxFLtE/mIj3WRxJMuCKajUX
X-Gm-Message-State: AOJu0YwDLEfVDuSKNNImIfCehbMu01XecTBUg/BxEe3Dr2BLV02Sld8L
	HnQdjTLXkZXA3IHu11Z7n/x+G0xL6V5UIl2p3WAyQ6nodkCzPQbShE13cVc4xK07Mw0KAcUpPfT
	hd4UbQzqEaNrmK52fddVQ5NxZI1I=
X-Google-Smtp-Source: AGHT+IEhPG1B/8mDvGNpkDj4PWCUpLjQ708pGc8G6bha6o2gM1Lwf8UNLZI5EJ57kTgt1wZPIajCKtTg1SeDSsMj41A=
X-Received: by 2002:a05:6000:24a:b0:33e:4238:8615 with SMTP id
 m10-20020a056000024a00b0033e42388615mr1774070wrz.40.1711747609718; Fri, 29
 Mar 2024 14:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329094906.18147-1-ubizjak@gmail.com> <20240329094906.18147-2-ubizjak@gmail.com>
In-Reply-To: <20240329094906.18147-2-ubizjak@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 14:26:38 -0700
Message-ID: <CAADnVQLZnkm8psPvmUOS1FDacXdJPxQ79rQJ33F00dkS9czw1Q@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf 1/2] x86/bpf: Fix IP after emitting call depth accounting
To: Uros Bizjak <ubizjak@gmail.com>
Cc: X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?Joan_Bruguera_Mic=C3=B3?= <joanbrugueram@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 2:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> From: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
>
> Adjust the IP passed to `emit_patch` so it calculates the correct offset
> for the CALL instruction if `x86_call_depth_emit_accounting` emits code.
> Otherwise we will skip some instructions and most likely crash.
>
> Fixes: b2e9dfe54be4 ("x86/bpf: Emit call depth accounting if required")
> Link: https://lore.kernel.org/lkml/20230105214922.250473-1-joanbrugueram@=
gmail.com/
> Signed-off-by: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  arch/x86/net/bpf_jit_comp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a7ba8e178645..09f7dc9d4d65 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -479,9 +479,10 @@ static int emit_call(u8 **pprog, void *func, void *i=
p)
>
>  static int emit_rsb_call(u8 **pprog, void *func, void *ip)
>  {
> +       void *adjusted_ip;
>         OPTIMIZER_HIDE_VAR(func);
> -       x86_call_depth_emit_accounting(pprog, func);
> -       return emit_patch(pprog, func, ip, 0xE8);
> +       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func);

Why not just
ip +=3D x86_call_depth_emit_accounting(pprog, func);

?

> +       return emit_patch(pprog, func, adjusted_ip, 0xE8);
>  }
>
>  static int emit_jump(u8 **pprog, void *func, void *ip)
> --
> 2.44.0
>

