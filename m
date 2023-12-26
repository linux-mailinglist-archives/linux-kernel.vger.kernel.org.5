Return-Path: <linux-kernel+bounces-11621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48081E912
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC22B1F21B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D8C15A8;
	Tue, 26 Dec 2023 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFE04khS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2A81104
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-427b515c2bbso788631cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 10:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703616440; x=1704221240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiJwBW/7K1qBcXH+9J8bQ7mf/uov1uwXgkCpJ4/LnIE=;
        b=bFE04khSXwR1SSMM0Qk0csE4053YaCFK5VCruP2J5XN5XMjk4ZKZTMUt91v13q3wE+
         PuJeNCBQR3BCQtR9h8kNtwsPA8zyu89/96B9Fcb99A5la+8uH6wDQH/p+wKY2W+s9kL8
         BsGCVNn06aMr6GAWXGDp3QVfu1bOg/ec3oRH0TVJpYSvvnFX9234qbMcRleSx6JfAma+
         9IJEkfwdkPCCVc9ubQkiGLmgcqtzGet1qmcm8O2gzf5BGztb+9gIJDc6OXQgUNjfpfr3
         eE1X8ZkUiEAbVWeJwQwFSAWpV4taIfLPhGhlfnK99iiGS2cegpAZ3plDqWmj9ZK2qGWk
         /7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703616440; x=1704221240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiJwBW/7K1qBcXH+9J8bQ7mf/uov1uwXgkCpJ4/LnIE=;
        b=kfBCzqTWWtPkmLcYHYlBZGN3+uJzudmM+EoTdkycf3FuI9pQ7qA8Q+naUHxj8A5Nr4
         j/3MVBBi5Jh8FkqBIL5RXwmVRqln1kzQXwL4da7zyzetZi3wiLVqTJSJlTOCYqdOScYc
         G7E+WLtuBTusoeNN3cq8gcTRxWfjdLcVmG6aWjZiBsgIYRme8p6AZTgiVpNS+JFH9Qur
         8/PB0UkjShJnIKCzLppgBYw47s0kmYqu0R30EZoInAbw9UHXfghrhln6IFLEuMmQvLhy
         KaUvIySbj+OjWFk0BSD9YV2kAMNUcYNrgv1/67VKOfGGuAXaEqmjeEzkB98UT6nmLHS2
         8M2Q==
X-Gm-Message-State: AOJu0YzYRjA+LuxuJT2jrxZwZYArbTjvXUTovtvXbTqGt76qwl5qtylh
	2EwCIORf+gJTCANtk+PbYJZrgPavz+11vq8Vtr2xssHvoD1N
X-Google-Smtp-Source: AGHT+IEYBwyPvzBQv8GdFUrmTLbOocq9WgF0k2bz6g2BBEu2Eob8+NO71K+QvEgSeux3dfF6mm5LchW+yBQf+nVfP6c=
X-Received: by 2002:a05:622a:1b8d:b0:425:758d:7279 with SMTP id
 bp13-20020a05622a1b8d00b00425758d7279mr624418qtb.0.1703616440295; Tue, 26 Dec
 2023 10:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226-libstringheader-v6-0-80aa08c7652c@google.com>
 <20231226-libstringheader-v6-2-80aa08c7652c@google.com> <CAHp75VfXWev7Z-tHRPAuWzaLj7ogiECW2arFc4CdcxUE87Ld0A@mail.gmail.com>
In-Reply-To: <CAHp75VfXWev7Z-tHRPAuWzaLj7ogiECW2arFc4CdcxUE87Ld0A@mail.gmail.com>
From: Tanzir Hasan <tanzirh@google.com>
Date: Tue, 26 Dec 2023 10:47:08 -0800
Message-ID: <CAE-cH4rche0dbKWXHQ89YUZzs6Q6XwRPrfdy5+uox9YnQ-5VXA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] lib/string: shrink lib/string.i via IWYU
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Nick Desaulniers <nnn@google.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Greg KH <gregkh@linuxfoundation.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 10:35=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Dec 26, 2023 at 8:00=E2=80=AFPM Tanzir Hasan <tanzirh@google.com>=
 wrote:
> >
> > This diff uses an open source tool include-what-you-use (IWYU) to modif=
y
> > the include list, changing indirect includes to direct includes. IWYU i=
s
> > implemented using the IWYUScripts github repository which is a tool tha=
t
> > is currently undergoing development. These changes seek to improve buil=
d
> > times.
> >
> > This change to lib/string.c resulted in a preprocessed size of
> > lib/string.i from 26371 lines to 5321 lines (-80%) for the x86
> > defconfig.
>
> Why did you ignore my tag?

I'm sorry. I forgot you had already reviewed this one. In a future
revision I will include this:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Best,
Tanzir

