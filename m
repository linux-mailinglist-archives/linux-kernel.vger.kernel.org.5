Return-Path: <linux-kernel+bounces-131315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04930898618
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D3C288CBA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E4E839F7;
	Thu,  4 Apr 2024 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFuaz8fr"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5272433AE;
	Thu,  4 Apr 2024 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230392; cv=none; b=TZcU8nsKXKvXxDASdnil2is+nmBaUNseq2oS9JoLO7nc7wgfd89oeRWRIynJOka1NXcmW1b+XKcIiwXN+KxSF/CMSQUiTLwDT62ec1VwKKyMbIxcGAA29lUtCawAVJJ1XZ2oPDQK/hoOlNEuAzrcYAgpMb1MHoXDA9sHjAG/6KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230392; c=relaxed/simple;
	bh=rsjRboU5+FZFYDOFymphsNOVY6c+pmI6IwHNJDV3zbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JannhWf9tZADMLbl3Yk/lvNNx/KYqhioBi629wlUfpswk/Api+Ka8k+5NmGCispcvkMDwE2zPTRYQQPKUTvDaHDq69VSIb6IsumAjha638lLhuRAMjHPwM9TegYJ2r9K+/YBPTdGYWMhFpfFHe77Czxbaq+glFjYfdKJzcUEtxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFuaz8fr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4e60a64abcso337254966b.1;
        Thu, 04 Apr 2024 04:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712230389; x=1712835189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsjRboU5+FZFYDOFymphsNOVY6c+pmI6IwHNJDV3zbo=;
        b=OFuaz8frcemt188fmumDn3WwbqGKFHdLNSfJiB7zrC9HIvQJEzC1ljpy/zihQ6bKvE
         BeN1ijxGTRjq6JldOAYuHdxkS7MY9yJ8ye56cfjTnhv97efa1hbmXMNdZvO6t/kUrYMA
         /fit0iL7WzjI13Xm5IvNdaK2bTH2Eu526r7i3dDuRNJ9RxGB21a6D8HOXtlpXQTiFszB
         5Lq0udLmvS+2araf3aB4kE22+rN8wmpKxQ9IL+WImqXvD6+ket+ToHR8Te6Wi4qUIH3n
         P5TzGgnynn2zO/Q8SLLoV77JfRGVC3eg2Nwlv5cqexwFPssdB2uMT6KOtxs5Pln/gIqV
         zJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230389; x=1712835189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsjRboU5+FZFYDOFymphsNOVY6c+pmI6IwHNJDV3zbo=;
        b=hu07SF7SHQZF21HMp9emWieaf0CRSwxAAduhMM23QlBYdnrIwEHwG71MBfQpYIYozs
         CtPCnXWRnABpTZKJakSWpQhr3Jmh8S4KqpQM4fVxeL+7ZDx0v5k75YdbLbL5tR/U4on1
         aNHTruIPrKf4BixUxEZkBCD9sGPbEvUCRvca7UGflEzMYdjhb9mjoYO/K/hiJf1PVQqm
         s3mOoNjYTB7SwJTW0ll73dORycxSCaOkvfgHJjHm0A4BXHe+9dC/nt6M/QdG9JxoFhRj
         ACymhWxhpCHgMy6oeRKzN+SN4tYG7syuWMoxfQU7aPnrfHei1OpkO7u1NCU2avPe/g7z
         BcVw==
X-Forwarded-Encrypted: i=1; AJvYcCVbNKem6DKYcnOZStgh9fEOEoqmUfzdWU5zl82vpD3AXuLep0YASVWLc21yBIvUBWl2BDUiuKSGfy5m6tZrhOuYkR/hvAGcn7tw/JFwRXh2IqG84MMsEkwydYomk08a9WR7I9EjyqycmA==
X-Gm-Message-State: AOJu0YzbqkdfA9IKTp1c7DoQyqAMpUC3SqP5taMEfvovr2dnWHtNs+jf
	/aS3NkY4tjmoSCpdSLWqvegHzAYZvHpaYmPDUknwaywPiBF1cqTG/iRGtDzP1CQhdk2NCyNnfIG
	+B6TnXW4BrEK+5B0BB9UhE3Qzprw=
X-Google-Smtp-Source: AGHT+IFq/w4RPf0xD1EUGE8hlMgNpyPYlxs4ucGQclr5xWdZ7KsXNkBdwp+3ZXd4y+p60Vspiv+MgRzsx4bXjmaYleE=
X-Received: by 2002:a17:906:b0d8:b0:a47:3766:cfec with SMTP id
 bk24-20020a170906b0d800b00a473766cfecmr5117745ejb.9.1712230389148; Thu, 04
 Apr 2024 04:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329105634.712457-1-andy.shevchenko@gmail.com>
 <20240329105634.712457-12-andy.shevchenko@gmail.com> <CACRpkdagjPLMUjYa0z1sFGVJJ4+0Tp9Kvf6umU2JWHeOB+fbPw@mail.gmail.com>
In-Reply-To: <CACRpkdagjPLMUjYa0z1sFGVJJ4+0Tp9Kvf6umU2JWHeOB+fbPw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Apr 2024 14:32:32 +0300
Message-ID: <CAHp75VfroTNRuyH-q=MyZO4nxMnZ65D+TqokHPuhk+nsQxwtuQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] pinctrl: aw9523: Remove redundant dependency to OF
To: Linus Walleij <linus.walleij@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 2:20=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
> On Fri, Mar 29, 2024 at 11:56=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>
> > Driver does not dependent on OF, remove it.
> > While here, add missing mod_devicetable.h.
> >
> > Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Oh the kbuild complains about this one because the driver uses some
> DT-only helpers. How typical. I kept patches 1-10 and dropped this
> one.

Thanks, you beat me to it, I was wanting to ask you to do exactly this.

--=20
With Best Regards,
Andy Shevchenko

