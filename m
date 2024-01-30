Return-Path: <linux-kernel+bounces-44732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374D58426A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E868A28E5E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C6A6DD1E;
	Tue, 30 Jan 2024 14:09:43 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4CA6DCF9;
	Tue, 30 Jan 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623783; cv=none; b=mRsvMSX3NLZbNPHxRaDEpI46dGxnWl+T9giFJ7TaseK7XE+C5j41rC9oAIuE6CziUQXXcWt/KUAjMsFT7hQ03WmuiIpHHGvyEpr+xiYZ/jwyqKP7fyIyLabkFjqJ6s4wPUnlxcVZ/ktsoBjkTjLEfbQYmy5Wmo3MgCN+5M86Uuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623783; c=relaxed/simple;
	bh=o1k4iFE/HUulRjJ43XJNeY0by3JrFyxm/ZfiQvz9w/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWdZqvnyd4cjZ8vp8pm8LBkd+Hr4bVGSeDKRW46nJAtOkCUtFA8rMEIycDTXFXotCql5ldT0mMjFr9jzLXanzFoLILKrsBt4iT0STSIqL/wuMzOtKv71uoWJ/FtYaBFPTMZMOQEg9aV3frmTyzVQUtw+YSSzJAFTtaOhxwdcgEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6001449a2beso28076397b3.3;
        Tue, 30 Jan 2024 06:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706623780; x=1707228580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0SvDjYvteTt+Kd+QVKtRMo2BPw5U9VqDXXfG0IcHts=;
        b=l+uNFm+T2g7nu/SBXBsd3Ny6qaObD+Z2eQMKeSNmeHl/vqm3vGKUPOl0BNNU92qUIA
         RR7U0MrNrtvbPGtOF06fvryG0DBdDdUKW3p6tQQKuKSR1GNWsoQS4B21o7OfIxo7Phyh
         aZIN+xMnSkfzTExXu0jFEYDfIn3Vsxa/LvPW6PF18k/oQG6hVpQa+fLMGEpqQiLjPe3I
         rR4ZbA5QlYtNkjtFOHCLCctTXi9f/8HFvmrzNR+STge+NhVpzHVe9mBiSCZA4zmGab95
         Ykog6MrSZLBmIr3GicZd1+Jgy9eiOfS41hSIUqzRTyuXJyxXDiJ9GGgz7rImfGAS1740
         fOhg==
X-Gm-Message-State: AOJu0Yw0FzX/S70fqvFa8ALSRDAaeiFEY6bBsJfvFVoKsWMLbSlXBOQT
	enkz0PIuJjGYNkjX/aADwwsJiJN/+XFnmRjj1wi5vC1v4QHtHl/OU+BQUdibWsU=
X-Google-Smtp-Source: AGHT+IGe4Y4gB4yrb0mFcfsxDMyoZTE2//fqiYR5m8yWVGu1ly4w686E1dEslYJWI7EoqOWgn4VTAA==
X-Received: by 2002:a05:690c:3603:b0:5ff:b104:cc74 with SMTP id ft3-20020a05690c360300b005ffb104cc74mr7177866ywb.2.1706623780378;
        Tue, 30 Jan 2024 06:09:40 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id cb2-20020a05690c090200b005ff9d3ca38fsm3161039ywb.1.2024.01.30.06.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 06:09:40 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6001449a2beso28076277b3.3;
        Tue, 30 Jan 2024 06:09:40 -0800 (PST)
X-Received: by 2002:a81:af4f:0:b0:602:a5ef:eff9 with SMTP id
 x15-20020a81af4f000000b00602a5efeff9mr5573440ywj.16.1706623780021; Tue, 30
 Jan 2024 06:09:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130094053.10672-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdUMeHCCiAkNyJMHTGUSTqewt=AWPUy+beA_kR26vcS8_Q@mail.gmail.com>
 <Zbjc_p_Pin7TAHw4@ninjato> <CAMuHMdVBXXpv9QfttBETQAeeRQjWRvfVJnrpPNiQj-N1SB9GQw@mail.gmail.com>
 <Zbj8Qyqu8KQ4Rshp@ninjato>
In-Reply-To: <Zbj8Qyqu8KQ4Rshp@ninjato>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 15:09:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWYZ99dm4DmKD25qu2uGXaoxYbqsq0A_K2sz=OB=nXgxg@mail.gmail.com>
Message-ID: <CAMuHMdWYZ99dm4DmKD25qu2uGXaoxYbqsq0A_K2sz=OB=nXgxg@mail.gmail.com>
Subject: Re: [PATCH] spi: sh-msiof: avoid integer overflow in constants
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Tue, Jan 30, 2024 at 2:40=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > But they don't match, so we can't unify them?
> >
> > I stand corrected...
>
> So, the patch is good as-is?

Yeah...
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Still, it might make sense to apply the same change to the
SIFCTR_RFWM_* definitions.  However, that would still leave us with
inconsistencies with other bitfield definitions in the file...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

