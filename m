Return-Path: <linux-kernel+bounces-61245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09125850FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C02E1C21A67
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E612134B9;
	Mon, 12 Feb 2024 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwcceRaS"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F6512B7D;
	Mon, 12 Feb 2024 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730174; cv=none; b=Gcn3JmvYaj1bpS4QtPGdUXmXIMI0gmnDcLQctpK5Opbqpia04ojkc1BQN6zsnn5gGS/xN6sWeJnWu7SVzEio9XNr/rwIWvfHTKLYCFDBKObsgWUPmn22EHtRQ9Ck5Ubj9+lERmr2172vFRCTyjIuaIr4cOCD0SaRfFqATuPLjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730174; c=relaxed/simple;
	bh=EJ5BTPRVj13kfwymPH+wIPG9mOFx9DxZcpXeSgKSC7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqKlOLJ0DYu9VsIAtcW8IE+APOGLjSlDKqRwLjXsT2cRtL/BScJIOzTHdn3XCRljydKRkuETBcp1m/eulFucg1NlxbkLT7047Lk3cG/SBL+lmwZIfREJCC12enOMHJ0jAP+HWb/L0wH5zlHm9m7C6t1aa56EAoAS+GGwdG9NAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwcceRaS; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5610cc8cc1aso2998749a12.1;
        Mon, 12 Feb 2024 01:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707730171; x=1708334971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJ5BTPRVj13kfwymPH+wIPG9mOFx9DxZcpXeSgKSC7w=;
        b=mwcceRaSMK2KRT1cMp7c7nJRk6QikkzrXQBWDaOGi9Y98SMeYUzGVqzvl3U+/+DsB/
         /9IJyAqXpiAAdfPgYEvUtPoRFDEv+1YjFPKKrHCbHWALsOz1WPNclL429YAIvxyCugbO
         OIFPK1NZu9disaZzhqoWmJf5apQtmGG9gts3E2XD7oAUMsVZQf3EfCDeMu31t317rLWD
         oG5jOyWxLxoy4wr2QOTu36KiiWES1DxQ08lM2pCL9HfQ4atBA/thl+82OEbThRPy6RRn
         cNePS0X1CYPw6Jq20LnX6XsLHuP2Z3KOiux1C0KQseAimU+mkFk6qFX8kgcIoauoCuR7
         tA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707730171; x=1708334971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJ5BTPRVj13kfwymPH+wIPG9mOFx9DxZcpXeSgKSC7w=;
        b=jGFhu3q/0If3y6lKtDRPGbSUFOTphF5UlPfauW9mlEpYX2FjeuaTVEXGGxcf8trEdx
         ytO/YdK5ddgQ3IcSC9PVav1jbg/2c6zl1XdD6svFlUisXKEp47Rkdjr9gnc4Mld50Cs4
         MT2khIVRUi3lTT4dpdfs3A9QbIUqCj9sYUxpmZa32OgjWxvkQIph6gvcPBBzQmuyPXhu
         63G/PLX0uxSGjvxil+sz8vcwARVMDNf5yVEjx0khpErviAgbrYvDb9KADU7wIPNeoTi/
         nYqjO39DChXmvRcxl8KFttDDxr4FHRnPX5Ccjot2hafaXfhxFnC5RuKvDmB6gEaIc6T4
         rqrA==
X-Gm-Message-State: AOJu0YxiBbAS3cxPhbvBHpTNL5MfE+4gudNIKBIYOzwL55sd8vx6e6El
	9uOfI7xHOYh8hE0dxrbDQCH+Tm1s3BPV697QQUS1n/gKyzVvWBoMMitwZOsYSpwrX1EAcQamWWe
	UCkhOFrW0nNqWkIwGLOik3sCqxHs=
X-Google-Smtp-Source: AGHT+IGhoK3hwkx7RRINlSWGp87qr2pxc9KZEXT4C+i4t0vWMfhkS6eIwosQ/d4wMgNYAogOQ7ZaucnMVGTvw7ZnqwE=
X-Received: by 2002:a17:906:dd0:b0:a3c:2c1:5fea with SMTP id
 p16-20020a1709060dd000b00a3c02c15feamr4088132eji.75.1707730171202; Mon, 12
 Feb 2024 01:29:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240211101421.166779-1-warthog618@gmail.com> <CAHp75VeSLvrxMOARDBHBJ5VGVR-Jv-7saxjJiN-NOPMyTwit3Q@mail.gmail.com>
 <20240211231321.GA4748@rigel>
In-Reply-To: <20240211231321.GA4748@rigel>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Feb 2024 11:28:54 +0200
Message-ID: <CAHp75VddjcLaRqugKuk+eejYx_0AHVL4SjYcdh7zUKDj8SpcQw@mail.gmail.com>
Subject: Re: [PATCH] gpio: uapi: clarify default_values being logical
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl, 
	linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 1:13=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
> On Sun, Feb 11, 2024 at 06:58:14PM +0200, Andy Shevchenko wrote:
> > On Sun, Feb 11, 2024 at 12:14=E2=80=AFPM Kent Gibson <warthog618@gmail.=
com> wrote:
> > >
> > > The documentation for default_values mentions high/low which can be
> > > confusing, particularly when the ACTIVE_LOW flag is set.
> > >
> > > Replace high/low with active/inactive to clarify that the values are
> > > logical not physical.
> > >
> > > Similarly, clarify the interpretation of values in struct gpiohandle_=
data.
> >
> > I'm not against this particular change, but I want the entire GPIO
> > documentation to be aligned in the terminology aspect. Is this the
> > case after this patch? I.o.w. have we replaced all leftovers?
>
> Agreed. Those are the last remnants of the low/high terminolgy that I am
> aware of, certainly the last in gpio.h.
>
> Having a closer look to double check...
>
> Ah - it is still used in Documentation/userspace-api/gpio/sysfs.rst -
> not somewhere I go very often.
> Would you like that updated in a separate patch?

Yes, please. For this one
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko

