Return-Path: <linux-kernel+bounces-167869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA8B8BB08D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D60BB211AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7525015533F;
	Fri,  3 May 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq3ZI0xm"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DED1CD35;
	Fri,  3 May 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752413; cv=none; b=IhDy2g1Y/wz1xOivRFqQz+MhBoIcOv6/riY4A7A7YAQ9+obt9PmAoNEPECyz7wulRi9J0txOKO9nZ3i7cVl6+ZBoHrzIqcl6yFF3JM0OY3DtgkU1/L6I399zE9zA0rRG/YUr6Ca4ACBpVj2uDFi7eepA6C+IqTUBuPvI+hxwRzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752413; c=relaxed/simple;
	bh=qxBCTMEj+TrC4OaMYlCE+ezrkZkmRTfkazny2w8eteo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MX7KuW5vQ0sLB7k2pxWg3YYw4RsffTx7tc5SZPqNODA11McdjrvHjUOzoe573IWKic1qJaKdNOY4o7t3XZOYv4MdPtEW07WV3bgJuqciLqPvoaammgrC5Amegqh+d3NRFxuIMTe3WEuwHTqCeuHv0+gt6fbAbK35FBADhAHgnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq3ZI0xm; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e27277d2c1so7880341fa.2;
        Fri, 03 May 2024 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714752410; x=1715357210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxBCTMEj+TrC4OaMYlCE+ezrkZkmRTfkazny2w8eteo=;
        b=Hq3ZI0xmXm1oKhcGgA688l481oje+sTPytgqb8mKWWBf/7qAMhJ/butatNuOf2sweH
         HfpblSmqagsBX2FV6bqeXGnzDMIX7jkgkt1qIemjuRjc93sxLTwde/dLjhxtOWklkdhc
         9kdSvmQKIIJo8wXjv9kB8i+O5AWuk9v5E7pzu1FwsUn4LuvmNWD+rTJJeF8M8DxazoVq
         FQDEN+aZ6RWoSqrzDqfMGtZ9dC050c7gtxYNqAA6ltNONURQAbYq/8cGmo/v4bl87GKI
         1OA6+hhXk0gYbQWA2z4+Gql7r3PrAkHKdnwRCOmYheGz4bOFBxBgYZKzykxqPeX2manp
         y0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714752410; x=1715357210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxBCTMEj+TrC4OaMYlCE+ezrkZkmRTfkazny2w8eteo=;
        b=uni4D1keQlfUMkFdRNPxryMKM99sQPgOMn5QAdV6BZ80gc7ImYQSkcxZPkVNGRHUMb
         YtmWyGBICZsJ0hykJr1k3JA4lG3SRgsLRaOtNGUJdjjzzQ5ic3sJUzE/2qtIH1/bmbWw
         mopPfKSho7AaSxwi339jGUvG+KM+N9QJEt4hW5k4VS5jjIY8x7DhsRGLonv6HI4CNsuI
         9xZTqy+WA/TKY5veG8ky6els6PTkXdk4ZZFKPFvb/BZALkyKhm9BvQSgwYaB/jyCA4ah
         leIYlGGuV4NYPaZlE90xfwyPBPN1ttWdN3g1qBtIa5m38oToKxJanbDVABbPrVp1Xg3M
         LHYg==
X-Forwarded-Encrypted: i=1; AJvYcCXZKCVukGiYL5AMy634wGvCX0YDyrZXqIN+hP6ofVfOyFKzUzOQL+lHHQxJSX2YAcBpjXg7QNhy7XBCuCR1uLBfaQuge77AEPzBpaAY
X-Gm-Message-State: AOJu0YyKL/4OoJr5YrEDhZjjiVN98nxmONWud/kVvhnh8iNvZ1ZYdvAF
	yVWsdmkbC5IDwyI5C3+OyfxPtzPvi4KV7cp7I39yp+mos4Y0/JBu3TaPUtRtvKLrLTLXDxqxtvD
	X2fDNHej7vD615+s13cHWLCZ1vOuQsA==
X-Google-Smtp-Source: AGHT+IFK4sAnD+PcN9wxvNTQr+V8aQYvj+lN3HAjOcEf7e5Cjno9CXWiGsb1WRBuz457rEjlEFOt+zRk0P/xS0Yr638=
X-Received: by 2002:a2e:9c87:0:b0:2e0:aaaa:e551 with SMTP id
 x7-20020a2e9c87000000b002e0aaaae551mr2104652lji.37.1714752410273; Fri, 03 May
 2024 09:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503081125.67990-1-arnd@kernel.org>
In-Reply-To: <20240503081125.67990-1-arnd@kernel.org>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 3 May 2024 12:06:38 -0400
Message-ID: <CAEdQ38GNU_vCFgi-uuFCW_QVBObTdD8VwoyQ71Cm5dNfZ4+=JQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Marc Zyngier <maz@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 4:12=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> I had investigated dropping support for alpha EV5 and earlier a while
> ago after noticing that this is the only supported CPU family
> in the kernel without native byte access and that Debian has already
> dropped support for this generation last year [1] after it turned
> out to be broken.
>
> This topic came up again when Paul E. McKenney noticed that
> parts of the RCU code already rely on byte access and do not
> work on alpha EV5 reliably, so I refreshed my series now for
> inclusion into the next merge window.
>
> Al Viro did another series for alpha to address all the known build
> issues. I rebased his patches without any further changes and included
> it as a baseline for my work here to avoid conflicts.

Thanks for all this. Removing support for non-BWX alphas makes a lot
of sense to me.

The whole series is

Acked-by: Matt Turner <mattst88@gmail.com>

