Return-Path: <linux-kernel+bounces-103400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A4387BEEC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 343BEB21E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A963426AF3;
	Thu, 14 Mar 2024 14:31:32 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4DA4A12;
	Thu, 14 Mar 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426692; cv=none; b=CJtTrXdbwgyBib82IxA6Ie1eDLQ5kH9NuhLcEJSSEB3L8dZyfHp4/IvBKRSfbxzC4RFmzn5nlvlhOKxwUu9V5S+teQWqrl5Vh/mDOjNug8MljO1qpHI75dtXrS0acVgh/ISmPG+/hx5Lr4htdgpjrJpBVfpp4YkKeH/t5+Nn5ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426692; c=relaxed/simple;
	bh=xFi2AxXaD1yOJvBeQtP4ZD5kDFtlgnvcd89oSlKF4Ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkLZ8aPbwJBQfnUaVe0+ZhNpDXrCYXvCaV2epwtEkFMgSl9OTXcsI3HCHpobVoZZSSUq76I9Mr/mOahBImtK5Qq2bRFob0/DnwVTHgrzoPbUoz1M/zxQeF1S7kWh7KMQ6QjLQo9jlRexDNxdGMMn8HAe0aLQLKZ1U1G8BIupoIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-609ed7ca444so11031127b3.1;
        Thu, 14 Mar 2024 07:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710426689; x=1711031489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpTGs8md/LpP1yl0wQV3+VwaTfKxWgHEQ+Q8ylWPYkI=;
        b=hHY2TlaTC4PqfXnF4h41RHeMNBs7qKTds66ePwLGI74Su9ZDBJIxvPDVgJY+BIvj/C
         mES6Dob6Da+1lAhqwoKPhlS9UgKmNylF36oFDevUXzV5um1sBLyALFDsd4Nn5Yc44YhN
         NF0D9/dzZBuGE81d2+srA2vJk73EMJZePN4LmdFBul+i8gaghG2Tb8bfHMPGOjqZdvof
         X05IKVvHROLqPzGAoaaI7YB3FTRHSQq9Om9+zSRNj/ue67RDeumB21bMHsy9f73E/gTH
         Fr5iOUMTUKmzYt0vE1nMME3Vdml7Y0XaLz/8QM+yN2d6aIZBd9GUO9azdzuJGEX9i9C5
         gaHA==
X-Forwarded-Encrypted: i=1; AJvYcCXjl5NIzlB8IFeY0OjMfIxc49/SyOEPNALyEiBDOS1v8XAXbc+MCHRz3MS0tA92XcHdVRjhsE44XKDztgKMHFjeWJyNmfzBSZSxNfhi8SvBeos8HcxwRyoWZ2+Jr8N+8FYdwINHYPl+qnWaTZPPh0HcMB2uV9rXiguF0eoubaNXQYcNLNJE6iytUzxx
X-Gm-Message-State: AOJu0YxHtslM+EX5x4B9+dxrF12alz8gMJmDhmeUkVn8OsWjNyIGrC1c
	X2CoRxa6XMI0Nqm+HNicVsswIrluyyoPfJ7kM7iqx5ICsSmFKSjL64uMS0h2UiY=
X-Google-Smtp-Source: AGHT+IE8ZbNb5xPNE9O4L4/HL2zteap+0DIOLu3b1Wm1qdBksLX3ahtb1zB1wFR4wLFKFn8jbQd6Kg==
X-Received: by 2002:a0d:fac5:0:b0:60a:107c:cfef with SMTP id k188-20020a0dfac5000000b0060a107ccfefmr2032496ywf.41.1710426688925;
        Thu, 14 Mar 2024 07:31:28 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id i72-20020a0ddf4b000000b00604a0aedd92sm290572ywe.108.2024.03.14.07.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 07:31:28 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc742543119so908414276.0;
        Thu, 14 Mar 2024 07:31:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfrZWvbiKVStYjfUePmWCeJhuNXCnb+ONe5fhjBoECOEpqOlAPf3JwqdH3picPBsScHA9rKtCEtqnzfq8VC4ld37SU2wuYn5VYto5qzxZw5jvB41ttz2VgYgZQe7Qhb63JzTHC2jlYgL/2kVyLiKTd40cUgmTckDrzrVf+TtpKPc+doXOTWdxN2GTa
X-Received: by 2002:a25:ad46:0:b0:dcd:aa73:e349 with SMTP id
 l6-20020a25ad46000000b00dcdaa73e349mr1723862ybe.12.1710426688516; Thu, 14 Mar
 2024 07:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307112452.74220-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWwbfem71Q9FE40jqHM2pXWJW9u+w-+NKy3OffFkzu5SQ@mail.gmail.com> <da48838c-5043-4fff-99aa-2f75f0755609@tuxon.dev>
In-Reply-To: <da48838c-5043-4fff-99aa-2f75f0755609@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 15:31:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU6fo0S0FOpvii8gksa=X=2o4BTCQOp2KS5SnErHeXLKg@mail.gmail.com>
Message-ID: <CAMuHMdU6fo0S0FOpvii8gksa=X=2o4BTCQOp2KS5SnErHeXLKg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Execute atomically the interrupt configuration
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: linus.walleij@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Mar 14, 2024 at 3:11=E2=80=AFPM claudiu beznea <claudiu.beznea@tuxo=
n.dev> wrote:
> On 14.03.2024 15:21, Geert Uytterhoeven wrote:
> > On Thu, Mar 7, 2024 at 12:25=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.d=
ev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> Lockdep detects a possible deadlock as listed below. This is because i=
t
> >> detects the IA55 interrupt controller .irq_eoi() API is called from
> >> interrupt context while configuration-specific API (e.g., .irq_enable(=
))
> >> could be called from process context on resume path (by calling
> >> rzg2l_gpio_irq_restore()). To avoid this, protect the call of
> >> rzg2l_gpio_irq_enable() with spin_lock_irqsave()/spin_unlock_irqrestor=
e().
> >> With this the same approach that is available in __setup_irq() is mimi=
cked
> >> to pinctrl IRQ resume function.
> >
> > You mean __setup_irq() in kernel/irq/manage.c?
>
> Yes!
>
> > That one uses the raw spinlock methods?
>
> Yes! Would you prefer to have raw spinlock here, too?

Most pin control driver needing protection in an irq_enable
method use raw spinlock, so I think it makes sense to follow that.

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

