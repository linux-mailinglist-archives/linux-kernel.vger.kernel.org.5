Return-Path: <linux-kernel+bounces-103127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3915187BB5D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6971D1C215BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468975DF26;
	Thu, 14 Mar 2024 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avKzZCgq"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED3347C1;
	Thu, 14 Mar 2024 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412533; cv=none; b=h3MGvGtwmbmK2KADknLb/V64TN7YiGtXb7BLmCzobRcKc8KFjCiyOz0XHtXvRQ8ZIVJ0SFREbNKv+5m+ORwAWN8jiKQWo6FV53oZhu64CyTdAEtlMVdhxVrN5DHXIn2RQCpLwgSGr3Z6BbU+e7OcU4qBmUuVaKuYRXx1i6sAKZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412533; c=relaxed/simple;
	bh=xUT+z5aPzLoK1XBR0CtD7lRZ7iP+OijvRC1vgfB2c3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WN+oVyaf/9BlNoNLIlx7zAU6+6t9KbPaRJg5lq4rvRpwQllwlvkXAp3SbM7B0wKvqlwT0EkB+IM4qx1GJg08lGCFPp42E5Y3LHC9oKM3ojXW/c818UDDwo3KTItszSgh+MgZlXNx2FBg2FQA8OfyteWbUWoG3oUSD0dtT9GtC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avKzZCgq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a466a256726so146374566b.1;
        Thu, 14 Mar 2024 03:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710412530; x=1711017330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUT+z5aPzLoK1XBR0CtD7lRZ7iP+OijvRC1vgfB2c3M=;
        b=avKzZCgq3uWI40OvufjlPKyjvxzt70i0JvtttZ19X3jxcMZ/au8oouj/f52xUN1ru9
         wfAJkvbfR6wHIPBFhWXNrRGnAwvv+pDl/xkvNZGQFgtymep56H+tt0Jr/gT26u86KIYY
         Ar+eFZfHLek3Im7nQqzGU9sh8tcgJgnMeUfmIE8rT3cyRR+mKGa/7mt63sSUkvszDC1c
         lOw98ZH8ZLjva/mofUwNzAAM7vEEIYa5LltbU6H2Hv7ZC6BJSIK9hO8gU7uWmrnnaRyX
         gZVBD1sa0oy+GRyg9dwxHk+bZM4BQPKB0uoAORN/x4ufCKZjVWGGODbMkbT7MljoNNPa
         4+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710412530; x=1711017330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUT+z5aPzLoK1XBR0CtD7lRZ7iP+OijvRC1vgfB2c3M=;
        b=AQsk7jMJ0R2glxPngvp8aUr/scK26XT9LPiWsPPEWSu+Et7KvQmymXoKTq+YY4Pa4O
         Q1SektZhfbIf87nVAr/3hN3YxLcHKu2yYWbdZcSPBB7nmeq8J1J7pruKF2Yhi0kt5Wvm
         byWgN3bYFq1voObmF3xvn5NIpjvcsBGqkq60WwPg33la+x472U/xZP8zu9eime3xIP5G
         Fg+e9A2Ir2BPtt5/H2RhYQOs3LkExL6zE+DBE7M3PE30mMqfSpKNdO9VebCSB3a+H1F6
         7LPgWSK2LqvxltzO4/UV89qnmWo+jIHIfWWmeD0op7e8wUz20eRvnBAU50cYC18OIf/k
         tU3g==
X-Forwarded-Encrypted: i=1; AJvYcCUQQMZYnPBtJ2F/gHT1m/BIFo1kOVjNO+3Rbt/uEA0+PZ4R04mRCvHpOx6Es2Gu9LsQsqVo2/OOzSe/Y+9qN31KX7KTEQF5FNfCzXoLh8w9xgOsn++6pddhXjftX+XejtEqVLABLpQyag==
X-Gm-Message-State: AOJu0Yx9rm9T0GFCiLbxWVItkLU2x+1Fs86SSlKMfVGeKIEXQvUsbATs
	00pvG5aZ/vN+kHrXu0pialFFoAWax3An2UUk+CpYzOyeVw20PhCxd4xCHNOeAzvw9AC/AvHXJly
	mOEB5hhCl4Ghk68jRHophkmAfZsg=
X-Google-Smtp-Source: AGHT+IFnq0Pgx23scikKTP17lOnZUwgeSw196b+FB/RuP2T0OiI6iGiC9TdnME85WIwCtzKA0WA7uZJMZKfaiv1Soro=
X-Received: by 2002:a17:906:5acf:b0:a46:1cbd:c2c4 with SMTP id
 x15-20020a1709065acf00b00a461cbdc2c4mr1170808ejs.26.1710412530221; Thu, 14
 Mar 2024 03:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314084531.1935545-1-gnstark@salutedevices.com> <20240314084531.1935545-10-gnstark@salutedevices.com>
In-Reply-To: <20240314084531.1935545-10-gnstark@salutedevices.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 14 Mar 2024 12:34:54 +0200
Message-ID: <CAHp75VfGRNo4hvKV7caQE6i2rHVncOjxDv3-b9oGrpK-uDEBRw@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] leds: powernv: use LED_RETAIN_AT_SHUTDOWN flag for leds
To: George Stark <gnstark@salutedevices.com>
Cc: pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, hdegoede@redhat.com, 
	mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com, 
	nikitos.tr@gmail.com, marek.behun@nic.cz, kabel@kernel.org, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:46=E2=80=AFAM George Stark <gnstark@salutedevice=
s.com> wrote:
>
> This driver wants to keep its LEDs state after module is removed
> and implemented it in its own way. LED subsystem supports dedicated
> flag LED_RETAIN_AT_SHUTDOWN for the same purpose so use the flag
> instead of custom implementation.

So, this change is not related to the main purpose of the series...

--=20
With Best Regards,
Andy Shevchenko

