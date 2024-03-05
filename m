Return-Path: <linux-kernel+bounces-92660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DC98723D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EEAA288B0B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAB812880D;
	Tue,  5 Mar 2024 16:10:26 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39F1272CB;
	Tue,  5 Mar 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655026; cv=none; b=J1rKOUBulNy5Ehsaf7VfagmUwIIHBPeYaCNF7FfAf1eAbEQdNxxDrzr23BK/jXv4zGhr6cwh0flPkcBVfz8Wce3HRox54N9sHTQnPd/kYHn5zzkHlYwiTPqysUr0/waiUMy79mqsC4o1aV3O/nFkb18yBqf1CkdB4ISYl0ewQic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655026; c=relaxed/simple;
	bh=Vvap9D+gaundMmhRMvj0DrekYh3yXKPuSlpOEn/TD/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITFdu4S3dya+ONu4+oJgbAkCUn1NhtVVXNhd6lirhNsOl1WkkWSbgyluzDP6a42pjWNh4GNltzv5iXfVP1G/y9x6T0cbrCBSpI+Dd0gjg/PBJTbC9Z1DQultsdIJY5McaonV0DFCQC9qaXvs2ZHDN/e+U0dwle8Q73ZHEtkERQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e4eaa4b394so397197a34.1;
        Tue, 05 Mar 2024 08:10:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709655022; x=1710259822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=713VBddz39OpjY6HlnbJzt3Tjm1gHuO4WD57Deft6JI=;
        b=QhXDqyZtjfjca+ugpireRm2j7h5oLAy7QWtgWlLJLHZBIyOYEWCvRU8klwWMwfdm7t
         r4XUMw1uEu0WA+zS6n2DQd5R4QjDqgUz/qKLBwvex3AJ1dZga6Ni2BfFhS2RcS6qqF0E
         qAnVmvB/DZdp7uDzSRLzImPFbUzToGn/QWvavk1iVSKBFEmKx5p+ZgDJhbbIlbp30lPn
         BBQQeh+iu7FPGODfwGxb0jq1nKhJ5WxYeXo5hIwcdtcGOA4uaOaRW3/0yzk3C952e6pP
         esrxkptek0uN/tAuoyYtzrYZtZvXuytuLQtMTA3wqbOAvvuXK+sARZbyG3gX8jAPkF2X
         21WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyoeWVDtnCSWr5xAACSqsbflJsmwGI8wRcTZUpnblth96VXgBDiL2P2fJyU3hRuVvI3elKCgc2VNI3FnQhd5ed9yY5yfpTGGUAYerwD/ZRNSQ94c33SahbaJCGZQroi5QwwMc4UxNDSA==
X-Gm-Message-State: AOJu0Yw7tq4zrloEINX+NTS12UTgxCUedhn08FbPCQpRK768JMukbv9L
	ZxHTMwJr1PooGzx2PqazqNoUJGJGkvNiArwmR4KIwyHWOXFlwuMa+38i4sFi6Qg=
X-Google-Smtp-Source: AGHT+IFFf0stai/v9sJDn4pNJU2Ls7iEfHLvnriZZO+9t8UxNe2MtMgJPVaSt1najitQIKurOruwQA==
X-Received: by 2002:a05:6830:1cf:b0:6e2:f4a8:799 with SMTP id r15-20020a05683001cf00b006e2f4a80799mr2376123ota.16.1709655021992;
        Tue, 05 Mar 2024 08:10:21 -0800 (PST)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id d17-20020a9d4f11000000b006e48edecda0sm775635otl.41.2024.03.05.08.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 08:10:21 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a143047a4aso354043eaf.0;
        Tue, 05 Mar 2024 08:10:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsK50marNyif0O0u8UyoBYGkap5B3ApIzkoJwGULBOb4+Vgf+hTd11TsjslS+ibu5e3aEVbulUI/r/wFEFyGzSl99mdVBcBRuWhOM80945RgJ//l06o1NqZoc1k7ULVKPnQ4XlPEwrqA==
X-Received: by 2002:a05:6358:7243:b0:17b:b573:a437 with SMTP id
 i3-20020a056358724300b0017bb573a437mr2777334rwa.8.1709655020927; Tue, 05 Mar
 2024 08:10:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305160046.46337-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240305160046.46337-1-krzysztof.kozlowski@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Mar 2024 17:10:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWRDA9te7PjnP3ibKDKsOakxco1m8-NtUsybi=6kVd0Qw@mail.gmail.com>
Message-ID: <CAMuHMdWRDA9te7PjnP3ibKDKsOakxco1m8-NtUsybi=6kVd0Qw@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: starfive: jh7100: fix root clock names
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 5:00=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> JH7100 clock controller driver depends on certain root clock names.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/all/CAMuHMdWw0dteXO2jw4cwGvzKcL6vmnb96C=
=3DqgPgUqNDMtF6X0Q@mail.gmail.com/
> Fixes: f03606470886 ("riscv: dts: starfive: replace underscores in node n=
ames")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Not tested on hardware

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

