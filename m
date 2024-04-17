Return-Path: <linux-kernel+bounces-149209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DBD8A8D35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE3A1F2260D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C15D4645B;
	Wed, 17 Apr 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GEwge8Yz"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F38237714
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386785; cv=none; b=MhV+4+SWpcVIDeMeZb8F21Q2c9VvBo+vRHLO2LQ3PU5XIwdVlEQan8K/9kwKdNJjHAXeIG9iET8PmorvBN5x5KYb/X/ehmyHlCvAFfyLe6EN+NBeiG1NZ2dKDO0gxNoJrjbJmjFgUciHWbBRMfInK5QZLpCXTf9aYBW8crtpS6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386785; c=relaxed/simple;
	bh=EfHIRXfyzIc+zsNsIy83ZLgWQXoedpsFV93faiZ+gtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdzix8FY+VFQXizd4ou/x4aHx1gRp0QUPl9UF+CQdo7ZBNg/tUbeghvyX58kUrsnp2CrCPad3k39AnEywxfc0ptyZsSWZFISSxWI05TA4wyUVnR9Fwsppn+iDMhZ7Q75KFd2+cUHCrDMK2tulTajMUl6ktb3z4H8CTzKqXt3+OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GEwge8Yz; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-518bad5f598so99468e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713386782; x=1713991582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfHIRXfyzIc+zsNsIy83ZLgWQXoedpsFV93faiZ+gtw=;
        b=GEwge8Yz2b3GdgHZO0lKoX5Hyj+XP76C+jNeH/mny1/WfTbS+iuPLp4uNXCXNihbXw
         YLhpEtArqR+HBm4x8QdBbbtJtIxzT+TmfMcmLyViELH/VEKO+vvnlqNSoZVQW5FU9KIv
         VDoug47yBqNdoVrdBkwfJhA2aM3do+zGSoWr9xBeXt3abXI1zuF+N3RHW9YEET7WHQxu
         XrY3nrt4kUzuUPmZFU0GK3mGdWk0NXqpO6i/SzCGTolV52/kakHfPWfgMPTyn+MqQzwA
         OZbfi6DsWZzZYeigpdrJ2TuqUI/XuoNz9BmVIQRK1K3qwntFiVYo7x+qO77gVQXbFRZJ
         YWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713386782; x=1713991582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfHIRXfyzIc+zsNsIy83ZLgWQXoedpsFV93faiZ+gtw=;
        b=Kes8K7yomvaP4hRW+8PXHy57u6L0idWX10hZeQFlCLq48aeqPnbKb5cAY9b81eongi
         LgHskNZn5uXiWTtPvMGfTAFnsrcMMf5KvztmlJb7onB4XZZOIW52nKsupn8GcILZ4jhM
         7I5iqFY5WrbOgy8XtRqbqiwhcA0sqTWjIrGhK1OE16Ia0RDRmdDUbpg4SrHbM/IM9RO1
         NxlKatjGUdBd6XU6ZxZWhZErMuecqGBANQGJzxVgkqPlDANm//20jXIKlfC3hQdgSUdZ
         0ABCZdITdx6KQAuD5agdmTeNfG3ZEBpaRmPPnj6EGEPOteYSRL/DnHdO78XdkVURz9XA
         +OlA==
X-Forwarded-Encrypted: i=1; AJvYcCVMp5y8IJxYksfMA4POLhcpbziUEqlWUuDgjthpRaY42UYT2H6DrZqcm7kM+tCK7fkxxpFuGYKtyz1RrYIIfpWJXpjB4b7GVdwhI/Sv
X-Gm-Message-State: AOJu0Yx5CVhyQhH+lDJl9mHQjh0P2VOMeOB7YXIZQVO0Hf5SCl1Hk6O5
	GwXOIdTrCiS5/pkdwVwOCA/ey70VvWlH00/HBj0EWhHbKq7CJdiRcEqKUOHZgF5o7/kTI3ME9sX
	PNs+zBif2jPeqcHHyh4GI7OQ6B2IOHpBss0PFOQ==
X-Google-Smtp-Source: AGHT+IFCIy31VeQrucnBimnHF77Apjx89o4M0uTx633iUVN0szNYp+oTVukhklbGPwE42PIek7r32qYimxmIK8XwJXk=
X-Received: by 2002:ac2:46e2:0:b0:519:2c84:2405 with SMTP id
 q2-20020ac246e2000000b005192c842405mr227184lfo.44.1713386782450; Wed, 17 Apr
 2024 13:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410072102.1200869-1-andy.shevchenko@gmail.com>
 <ZhpC3lLD-BHqJEZz@ishi> <CAMRc=MerqbYue_uubSkr0ta3wr+yQxfFMfk+vAUZa+C2oR+udQ@mail.gmail.com>
 <CAHp75VcofgAQLFVLdsA-A1AkjVzQBJWtam=w00+z9-rueZyv8A@mail.gmail.com>
 <CAMRc=MejJTnawn1=_x9Va-QJRctjoc3TJanVqQ0uZbpmDzpyjw@mail.gmail.com> <CAHp75VcXoEhxA+qO=MMoUanZeCP5hPXd9q7n-8AuRrotEfbYFw@mail.gmail.com>
In-Reply-To: <CAHp75VcXoEhxA+qO=MMoUanZeCP5hPXd9q7n-8AuRrotEfbYFw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 17 Apr 2024 22:46:11 +0200
Message-ID: <CAMRc=McrxEeS-BdgSEswJ+x_qDYJ7Gn_fKP8n-ctCzk2BuP29A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: sch: Switch to memory mapped IO accessors
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 10:41=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Apr 17, 2024 at 9:19=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> > On Wed, Apr 17, 2024 at 10:05=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Wed, Apr 17, 2024 at 12:17=E2=80=AFAM Bartosz Golaszewski <brgl@bg=
dev.pl> wrote:
> > > > On Sat, Apr 13, 2024 at 10:31=E2=80=AFAM William Breathitt Gray <wb=
g@kernel.org> wrote:
>
> ...
>
> > > > I applied it as is, if anyone wants it, this can be sent on top of =
it.
> > >
> > > Thanks, but I assumed this should go via my tree and as PR to you. At
> > > least I have it already in my for-next.
> >
> > You didn't respond in any way about picking it up.
>
> Hmm... I'm the author of it and I'm a maintainer for that driver. I'm
> not sure if it's mandatory to respond for that purpose. Usually I
> asked the opposite, i.e. when I'm not going to pick the thing up.
>
> > Can you just drop
> > it from your branch?
>
> It's possible, but I will need to rebase, which is not a good thing to
> perform. What about just leaving it as is and letting git to (nicely)
> solve this?
>
> --
> With Best Regards,
> Andy Shevchenko

It won't be solved nicely, we'll get a warning about the same commit
appearing twice with different hashes.

Whatever, I dropped it from my tree, it was the HEAD anyway.

Bart

