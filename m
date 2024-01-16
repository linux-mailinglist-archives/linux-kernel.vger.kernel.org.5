Return-Path: <linux-kernel+bounces-27510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF79582F15D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46A61F246E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B9B1C281;
	Tue, 16 Jan 2024 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGiU5sr0"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D411B941;
	Tue, 16 Jan 2024 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5fc2e997804so34354777b3.3;
        Tue, 16 Jan 2024 07:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705418517; x=1706023317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=13JrJeAldiqSPGnO/8nR55kEZJiWwYEFrmzzkOgGtcQ=;
        b=MGiU5sr0jaB0LuTRdMYYPfeLvvukL9kd+LHNrL7h3gLFGPIUbUkcSFJKc55BUNRPAR
         3B3hzC5UY+Z0hjOXHcc3zOaSEwXQ5Ie6u1blh4dGg5UCDb+P6DYPcCKK0LI18hVOqyPC
         TbtFaCKKlmQKgBaaEdMmcMJUDkf8baFgGsE+q0unb2n+N28uYrAKmOgWHXoXvfEyKru4
         t3aLngBvolJuJAbsVYcI3SYyHx2lQUULBGYwccOug6eBsHHyFOJFnkLfZRhSBoZo7gVF
         hrlZSi6mfHd0QSMHjBrwZ+pJjlEigfVbwtDGt8TcAJZID8NouOuBhhOZVd/WD8IRUTLH
         pLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705418517; x=1706023317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13JrJeAldiqSPGnO/8nR55kEZJiWwYEFrmzzkOgGtcQ=;
        b=L0UY4xxWhbrZabhwvIgYrUpf9zUXx+LZj8GH9MK1UlaegCJoNJLBTttdFYKU7NnXCL
         ZcHdUulMHNLfkxCMzFNGI94yeNztZrEvmCftzL1YEBveDeU8OAaLSNH7AHwjRMNBRSw9
         0DpNHLyRbFCM2VcCfFPWLEQbg+QTknp/io1ZlG4a+ApCg3joPxyxBYNBft7IGIMDkhXa
         bM2eQKIv6moFGJlUvx4Q42l0lReZdULx2oUDctv2Pr6ui8zFkAhiwXr4goQB9mQxbYgP
         vhj3qb2hDrTzEOkXrXDYhFBEebDR8ccSrpvNmT9IiRBHUhPhHyQODRloPlyzvFafl0wm
         s0aw==
X-Gm-Message-State: AOJu0Ywa8ZIv/8nSAezRZ+OLoGu6EGZ+idlWoBjwNMAImNSG1UsSTe9Z
	fU5xIS1sq2FQ6rRnFHIYHKiUUlb8Kf6HvssOEII=
X-Google-Smtp-Source: AGHT+IFlQeu3q+ElU+rld3EnjOvz9eE/88otShb9zYT15iLTCLTu+OZ9uWUpKmfFbrAENM1p3a2FZ3JgKivbohmlLEI=
X-Received: by 2002:a81:8584:0:b0:5fb:9705:5853 with SMTP id
 v126-20020a818584000000b005fb97055853mr5307731ywf.73.1705418517573; Tue, 16
 Jan 2024 07:21:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108135421.684263-1-tmaimon77@gmail.com> <20240108135421.684263-2-tmaimon77@gmail.com>
 <20240109170830.GA2772086-robh@kernel.org> <CAP6Zq1jCHVrFfRa6c3DZ4t2aaJTkWukeEkia0AqhzppC0mjbfg@mail.gmail.com>
 <dc739435-d955-44f7-b5ee-9de4d5336725@linaro.org> <78875535469138a0fd0659d7e621a4f2.sboyd@kernel.org>
In-Reply-To: <78875535469138a0fd0659d7e621a4f2.sboyd@kernel.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Tue, 16 Jan 2024 17:21:46 +0200
Message-ID: <CAP6Zq1gcjayNA0j2fR-RW_mSJN41RS4PR2Q9AjLKFoGOvo-ecQ@mail.gmail.com>
Subject: Re: [PATCH v22 1/8] dt-bindings: clock: npcm845: Add reference 25m
 clock property
To: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>, 
	mturquette@baylibre.com, krzysztof.kozlowski+dt@linaro.org, 
	tali.perry1@gmail.com, joel@jms.id.au, venture@google.com, yuenn@google.com, 
	benjaminfair@google.com, openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

On Wed, 10 Jan 2024 at 23:46, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Krzysztof Kozlowski (2024-01-10 12:54:14)
> > On 10/01/2024 14:47, Tomer Maimon wrote:
> > >>> +
> > >>> +  clock-names:
> > >>> +    items:
> > >>> +      - const: refclk
> > >>> +
> > >>>    '#clock-cells':
> > >>>      const: 1
> > >>>      description:
> > >>> @@ -30,12 +38,20 @@ properties:
> > >>>  required:
> > >>>    - compatible
> > >>>    - reg
> > >>> +  - clocks
> > >>> +  - clock-names
> > >>
> > >> New required properties are an ABI break. That's fine if you explain why
> > >> that's okay in the commit msg.
> > > What do you mean?
> >
> > I think it was clear. Which part is not clear?
> >
> > > Could I add the new required properties to the required list?
> >
> > You just did, didn't you? And received feedback that you are breaking
> > the ABI.
> >
>
> It's fine to break the ABI as long as the commit message explains that
> the driver isn't merged yet.

Thanks for your clarification.

Best regards,

Tomer

