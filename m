Return-Path: <linux-kernel+bounces-25453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7037982D076
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 13:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D56B216DD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 12:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A942107;
	Sun, 14 Jan 2024 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cujmPQdB"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF42581;
	Sun, 14 Jan 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28da6285c1so1416043966b.0;
        Sun, 14 Jan 2024 04:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705233726; x=1705838526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWRjRFXEceL8YNoAA8HuRe3I9HTaS3BgE69HQr1Lej0=;
        b=cujmPQdBni2WgUop8fyyZmElk5DpZTyqryW2gvr2Ma7mpCsIhJRTA4AYTcce9hvID6
         nCXHDpdGHSk41CloZH1taUea/vymyacT020OVfnR7aq+MVeHLGNYxSNNiku0EmhqjvkI
         RYltP2AJe3JV7wBfNuk+h381vQ6wIjW844cQlt67a39K4BWHELDfcr/R2vFuFAbGfSiY
         2CI/Yyn/DcKDkcspChONgNV1+wjCdWPS3Vytw94kSQyjxriKr4rT6Zy/AjmJDi3J3WC2
         sS+CJ83pkRU8tX9bwCEqA1sjFMdDOtOlTVCHd1wOSDZDEEenYZxG73pZxa6RsXugMSn5
         pseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705233726; x=1705838526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWRjRFXEceL8YNoAA8HuRe3I9HTaS3BgE69HQr1Lej0=;
        b=SkmU5qSCzP7yoBe6rzEBPPPuJOcQMaN4xkHPT1jVlJWjD0qiYVpN6TtoSJxsNoyirH
         Wx3t1cCY2Q/RfjI2c+BFMiilIsxYT8kPo832zAa7BtT11HDGwAYYbPxPBqnZjkPklNov
         k6rLFwz0qCqHxUcT78cpyOvcpYbSnDKQmO8sLbXEOYze7HZ3jYZCyrFDAtkzVw+O8EOl
         nepUDp4U/o6cahYVsaL3HTyJ/5uqFols/BLzxVU22cV41iYWUIMjdA2l22ezftWRqViO
         7JR5gecw0AmLJE+Y25uHtvcZfmU8ixtKpK+EePSnVMvvh2Vu85FWf6ISyGgUh7OfbgHJ
         KQ+A==
X-Gm-Message-State: AOJu0YxAaODKJ927iC5rVnOWqQWLC3rP2t9idfoC5IySQMPne7GAC0BD
	PiDMlDY+M9i93QkvDE6+FR9xPqWtwd/CgNTkeso=
X-Google-Smtp-Source: AGHT+IGVmKRZ4RucIzKBoI4x7wBpZ8rOXpZN4Q1Q9u/TykudWe9+FZLJZ7V2yIJAGQmM/qTgMC3pPS/J5ZJ6teqT6eM=
X-Received: by 2002:a17:907:1992:b0:a29:fb9a:a3a0 with SMTP id
 li18-20020a170907199200b00a29fb9aa3a0mr5147704ejc.1.1705233725850; Sun, 14
 Jan 2024 04:02:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109135952.77458-1-warthog618@gmail.com> <20240114024724.GA20870@rigel>
In-Reply-To: <20240114024724.GA20870@rigel>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Jan 2024 14:01:29 +0200
Message-ID: <CAHp75VeN25Q+7nTM0f3MWnU99Y0MZJjxBLfMxJJhAyWcBq8W7w@mail.gmail.com>
Subject: Re: [PATCH 0/7] Documentation: gpio: add character device userspace
 API documentation
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	andy@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 4:47=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
> On Tue, Jan 09, 2024 at 09:59:45PM +0800, Kent Gibson wrote:
> > My new year's resolution was to improve the documentation of the
> > character device API and gpio in general, so here we are.

..

> While preparing the v2 version of this series, I'm now wondering
> if this should be changed to "obsolete" rather than "deprecated", to
> better fit with the interface lifecycle, to indicate there is an
> alternative, and to emphasise that it is scheduled for removal.
> i.e. from a userspace perspective "obsolete" is the clearer term.
>
> Is that a change worth making?

From my p.o.v. yes, as it makes it consistent with what we already
have in the sysfs/obsolete.

--=20
With Best Regards,
Andy Shevchenko

