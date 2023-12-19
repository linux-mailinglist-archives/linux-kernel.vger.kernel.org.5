Return-Path: <linux-kernel+bounces-5990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B74881928F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D859E1C247BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD873B781;
	Tue, 19 Dec 2023 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv8d9YE4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1063D0B0;
	Tue, 19 Dec 2023 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3ba4850f65dso2809271b6e.2;
        Tue, 19 Dec 2023 13:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703022740; x=1703627540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/HELoxRBihubnQTIbfT46yyuCF92jjoc5j2WnCAxMg=;
        b=fv8d9YE4jjzwa9pobauF+LktaPrWbOyWqFtWHYxi0I4noweJfbMFeiC3i7Wo/eEWkZ
         najZ+n42kfZxF2QviCmiH0G4kgeniEIGpEkHU98vAwoa4CZx60LLd01tjN4AFcpO3Qyn
         T+KpSc6RwBFZJmRoboLhVgOHBpDUZhCXEf/sOIZON28KvYq7GGnirpjR53mY54frmEDD
         C+SlycOrdDGxJoHZHDTu+7VQ0rNA+8+W46apOE+pktdAjL6sn3Pc1ssKyTc/ijD1ihBj
         9BAWdgdh69KBhfyAEAqKkBcHhDatH0Q5tBl2HBopryvV7O8+5L/ssueVi5ZAfJbj1xKY
         l7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703022740; x=1703627540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/HELoxRBihubnQTIbfT46yyuCF92jjoc5j2WnCAxMg=;
        b=UwPHggbZw3heVYuoJnxGd6oenTdF3UEd47AypBFARlApYKgq4opBovxqc/lbFO+RQq
         T0KykHMwkqTqklOyGCG7mp4DasLBSlYjrRM5MTVo3PCyxvixshLiuPC32GMy32L0o1o/
         2SqgW3TzZ9us0G6l57B/nbwsKlgNkHlyAL1k4jJH/yhYbpP89W0+WOqLdRfWdP67HNoZ
         QaLEMisNT9GAcKjcdzqvi81gH25Jp27meLqnqzi+ooJAO4spTOwjtlQLOyN5D8Thfn3C
         ZSpP42z5dG0fX5IMgGf6iF8E3cZ6BNlLGGrlI+Qe8G/zQP1DCqY/VnUsVfxfeJelRHkO
         HWQg==
X-Gm-Message-State: AOJu0YwVeTyxs785u5dY+5AKVVdvdJdDgvHgON/fZ8GUeGh5I2oYgQki
	CAvQSRu3DK1K493x/qYRJu9i3M0QaXA5oiKMiiU=
X-Google-Smtp-Source: AGHT+IEYMovugHC3Wx2wWk978fWVMiH69UO6ZUgo0IecWqN29PEQku+lqbLZS9m5zTdKhg7b9KpHO8lfRDjZN6HORQs=
X-Received: by 2002:a05:6808:10d4:b0:3bb:67fb:a451 with SMTP id
 s20-20020a05680810d400b003bb67fba451mr1114878ois.114.1703022739808; Tue, 19
 Dec 2023 13:52:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219-libstringheader-v5-0-206d4afd309a@google.com> <20231219-libstringheader-v5-1-206d4afd309a@google.com>
In-Reply-To: <20231219-libstringheader-v5-1-206d4afd309a@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Dec 2023 23:51:43 +0200
Message-ID: <CAHp75VfS7rYZwRP50cm5vYq_EO9ozA=_qrEm4u7jB1WMwOVc0A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kernel.h: removed REPEAT_BYTE from kernel.h
To: Tanzir Hasan <tanzirh@google.com>
Cc: Kees Cook <keescook@chromium.org>, Nick Desaulniers <nnn@google.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Greg KH <gregkh@linuxfoundation.org>, llvm@lists.linux.dev, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 8:48=E2=80=AFPM Tanzir Hasan <tanzirh@google.com> w=
rote:
>
> This patch creates wordpart.h and includes it in asm/word-at-a-time.h
> for the all architectures. WORD_AT_A_TIME_CONSTANTS depends on kernel.h
> because of REPEAT_BYTE. Moving this to another header and including it
> where necessary allows us to not include the bloated kernel.h. Making
> this implicit dependency on REPEAT_BYTE explicit allows for later
> improvements in the lib/string.c inclusion list.

Same comments as per v4 apply here.
According to the Submitting Patches the best time between versions is
~1w. I understand your desire to close this quicker, but the result is
actually the opposite. Take your time and check carefully what others
commented and recommended. With this series it's fine to send a couple
of times per (working) week. It sounds to me balanced between the
complexity of the change and the people's willingness (having time?)
to review.

Otherwise it's a good start!

--=20
With Best Regards,
Andy Shevchenko

