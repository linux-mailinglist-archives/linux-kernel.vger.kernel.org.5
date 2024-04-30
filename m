Return-Path: <linux-kernel+bounces-164752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 576378B820B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FAF1F2428E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A691BED88;
	Tue, 30 Apr 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSetsOCw"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338ED1BED6D;
	Tue, 30 Apr 2024 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513297; cv=none; b=LJwALdKtGccjYqZIVyj8xpL5C8sXZgJICElOEIjhAOiT37ao+l32weaAx0D9MDpCeyuIUvGMZVewZ4VTo+bCWCuYnLeuj6irY8l8qe2JrIbdhZQfGvAC00CnT2zhaf37sZ18P6KoFu3L2b9MQ3P+B8WN52I/MybtPM7cl0XeKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513297; c=relaxed/simple;
	bh=BiF9GnuhVzLkqQztta/yMxvlsv4vBJvKKN7re09JxeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd79G21IRSxdJvA9VjPIwDHYGngvz2L3h9crjPgspoD54q8Xj/Hv3IlFwBq16dEb5+VE9ZM0q3sgNUhyRilONlAaDIm5pZX64FBeyAO/80OTO6YxpR9v8msQjs55LgTMu0sEoIWWp527CMNfBJ1iBktjBMgp615ff/1Gs545e5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSetsOCw; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36c546b7d04so8773715ab.0;
        Tue, 30 Apr 2024 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714513295; x=1715118095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ACMbtfXqDXl8mT86PD7W0UZrsuRE0FuMtjMTpD2oMs=;
        b=BSetsOCw7+00c0xhg0Al9psckpm4s43CW+CQLbgMmd38vHFTBotGAFkwvWiX2rA1JP
         kutJLxjFCnsPtknV8STq3+bafGyVx1QLk1zalgMFeLwGCwAeI/d6IX72j7Fd2elN73qK
         qt1SoRYUpXifHxdIaLoAXFx09bKo2UHtKdz0PpvguNgetY5IM8KvOlE+IjrO2loEtsvu
         vKWin9/ANts4IT0iphlhQMBFqT5FMyC6jrl2H3ki+atL8cCyji7JFk6OZQ0eSoJv/58E
         P/er85IuR/bpL2P7UVBLPJIMDzDyWy6Yv+YF9B56ktp/DjZUwKjGgHKZndnBwzgMC7Wx
         z/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714513295; x=1715118095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ACMbtfXqDXl8mT86PD7W0UZrsuRE0FuMtjMTpD2oMs=;
        b=BYlP1TRk7vtM2JFnaaQzgBVYsmaAieo6ZRjrYAXCgwwzuSQnorEs0zlOXVfdKnkwT0
         zuR3KGJ9O8/7HIA7Tnqi1QZhzsXVpvwr9Nz2xuGxs/dDxP4LFpbOtZyU03QyEC5f0Q2p
         40j+xXL2weQ+nQwcCBh62tzM4x69nEVbmpMMAifHAE0JFPQ19871Xj8m8tauozcwftJP
         DgtWZ71fa9z9Na1V9JgyQmQwJJg2Zj7HxOH6s2wPN5CiRI2EQwPINiXPnB9zve6tMQuB
         f0+OxdQVboRdMGLDYsuw371Tb2ExEip0cv3JtHULIsm5Ue2oV10ZHwfFfyhzBf1E8Lbr
         o1Aw==
X-Forwarded-Encrypted: i=1; AJvYcCV9otNZ1tPPai2KITk6EITPtntGXibT3HSGgvz/QSvTYF+jGdZTm0husM0khV3ya1ijdITuZ2eg5QFpLDs+MeaIkxMNj7Fx6QxPSTdTAFn2JJZ5zCiJa1IvDTZ4gijlCTy/Y6WgDB3HCPc=
X-Gm-Message-State: AOJu0YybpZ/SrfC7skBRz4MsvfWsFVW4n8zDm+m83sfGPopIJTrDdPHO
	htD21TeulfrJhGrtHF+ksZY9kcm0Uma6AhBdDXRN2sZ/ATze1q4P
X-Google-Smtp-Source: AGHT+IGTIFnik48YV7WtOVXqf4VkLiTiGC5at2Tx1p6PyWpgpa1LgotTyXKdvv4nWirg0ZXJHJECsQ==
X-Received: by 2002:a05:6e02:13ae:b0:36a:1e55:535b with SMTP id h14-20020a056e0213ae00b0036a1e55535bmr1102908ilo.16.1714513295063;
        Tue, 30 Apr 2024 14:41:35 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:68d:41e7:d081:607d])
        by smtp.gmail.com with ESMTPSA id bn14-20020a056a02030e00b006089cf2cde5sm9023079pgb.26.2024.04.30.14.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:41:34 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:41:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kenny Levinsen <kl@kl.wtf>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>,
	Lukasz Majczak <lma@chromium.org>
Subject: Re: [PATCH v3 1/3] HID: i2c-hid: Rely on HID descriptor fetch to
 probe
Message-ID: <ZjFli4zOalXkDWx_@google.com>
References: <20240426225739.2166-1-kl@kl.wtf>
 <20240426225739.2166-2-kl@kl.wtf>
 <ZixvUNooESC02cJK@google.com>
 <5aa9f745-7f6a-4873-90ba-79c55335905c@kl.wtf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5aa9f745-7f6a-4873-90ba-79c55335905c@kl.wtf>

On Sat, Apr 27, 2024 at 03:20:07PM +0200, Kenny Levinsen wrote:
> On 4/27/24 5:21 AM, Dmitry Torokhov wrote:
> > I really think we should differentiate the cases "we do not know if
> > there is a device" vs "we do known that there is a device and we have
> > strong expectation of what that device is, and we do not expect
> > communication to fail".
> 
> My reasoning was that there is no difference between looking for address
> acknowledge on a probe read vs. a real command. Unfortunately, I ran into
> some issues with error code consistency that Doug highlighted...

I actually believe there is. On Chromebooks we may source components
from several vendors and use them in our devices. The components
are electrically compatible with each other, have exactly the same
connector, and therefore interchangeable. Because of that at probe time
we do not quite know if the device is there at given address, or not
(i.e. the touchpad could be from a different vendor and listening on
another address) and we need to make a quick determination whether we
should continue with probe or not.

Once we decided that the probe should continue we commit to it and all
subsequent errors from the device should be treated as unexpected errors
worthy of logging. On resume we do not expect hardware configuration to
change, so again when resuming we also treat errors as errors and log
them and fail resume.

> 
> Considering that the smbus probe bails on *any* error, it's really only
> ACK'd address + NACK'd register that remains, and I thought it maybe
> wouldn't be too harmful to just always have a debug log as suggested.
> However, I would still like *more* good errors by being specific about the
> error condition, and I plan to send some patches to get the number of
> drivers sending ENXIO up so we can comfortably rely on it in a future
> i2c-hid patch.
> 
> If you don't think it's acceptable to leave this as a pure debug print for
> now, I'll send a patch with just a minor clean-up and Łukasz' delays - then
> I'll try this again later when the driver situation has improved. I've been
> rapid-firing revisions, so I'll await an ACK this time... :)
> 
> ---
> 
> For some context, I started looking at the i2c-hid driver after a recent
> regression around assumed Windows behavior, and found that the actual
> behavior differed a lot from our assumptions. Windows gets the job done
> notably quicker, with fewer messages and with shorter albeit differently
> placed delays.

I am not sure we can fully unify what Windows does and what Linux does,
mainly because our firmwares are different (I think Windows devices do a
lot more device discovery in firmware, Chrome OS historically tried to
limit amount of code in its firmware). We also need to make sure it
works on non-ACPI systems/ARM.

Thanks.

-- 
Dmitry

