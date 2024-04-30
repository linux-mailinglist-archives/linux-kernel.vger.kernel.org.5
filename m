Return-Path: <linux-kernel+bounces-163326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 558178B6980
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D40C282C66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2202411702;
	Tue, 30 Apr 2024 04:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM8YR7l9"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BE0539A;
	Tue, 30 Apr 2024 04:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452076; cv=none; b=FD/75CEglom6FxgnPzkpsGmZ/reJZeSxdMDIr5aJiBm5FI1PYPEc3gqYh9Hc1xHabqyJiVGW1gkQkew0ES5pmIfHv4CILr010gdvFq5wIo8kfi7J8GBN3+YABBd8pvQMQXWdR166jsh/n35X+t0szl4m4z4A6G7Olv9EpK253ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452076; c=relaxed/simple;
	bh=ftf3Djm+oaNpq8SfgpJ0GWcWU0OyZ47B0DzMOR7/cT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHRmyynJY+Pqg3NmsWpefiDyVrhL5vOMG/tC/rix9bn8absiy98pzWQtjY4UgkkZe0sGDisOjAQ5JFzHmVaTnVWStqqNDJfpjrywbvEIKRSj7qUKsBrSO4Fqv2bpUCpawnv6cUAwHmGZhtMRb0XkAcGe65+1XjYZi4dUSZsG1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM8YR7l9; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ee266e2999so1129285a34.2;
        Mon, 29 Apr 2024 21:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714452073; x=1715056873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K0ndqdXJ161tOfS7+EFPFxxLScketizvn6VGOP4/lzE=;
        b=eM8YR7l9qvRM5of5WIyib+bDvjJWtWX9//wR27kd06WUgUf3NpDTrkDaKsykt8Ns4D
         dOJjwrOJBTRNAbIgQRvIG8PCJi/KcN2EtxxHLALhvoiuRgEML+8PPLajGdHmVI52keDB
         JMt8ZjijBPIS+00cnTsFqiaNnMfBRh7i8JN1fVwKIvYCvCnEmxGc23g7PLvNgYeue0nz
         0RxLa56sI+MXLVHYAYFCkrZvto8vqD4H/VeGytXerEXINqWnRkmYDiyjBWLpsrkaay/W
         NZAn9m1yktL86AdcLk+p19u4qUQCEkXrPct+URNzsAJsyykodcgEdyBjHYjwcYgkApUX
         fmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714452073; x=1715056873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0ndqdXJ161tOfS7+EFPFxxLScketizvn6VGOP4/lzE=;
        b=kXp+QigqppXVO9EHb95KPHTF5eNHNJK8IXFLxNcP1oIW/Y5z2IIBqK2RukisMr/wZR
         04u2I+v9y3y3FokpikjnmDFI1tsIKMdabtYSoU0sZVGLQ9tCzkfDehk30orzGupP0h34
         aMI1OpTWSc3i81aunuPxQKnfx2e7uB2fszA9yBXDDwkq0zU1ULYeSyXwPx8Byf9jmB1U
         vyx30W2GR19tA2kgigmv8wQZY0T4wanWZcgRaXU8404k8V9K7ZB6vtVTyxzgef/0Au1e
         Jfm/0rRRL8ZUhuDIc00kBahA2LtEL4sWqh3pQnzOUVu2T5AsoswTloc5e++8OLVAsvVt
         AEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtwI1f8GBljK4u9WZdGCK3+3pi7VMhJSTd7pBm5T/p2o6xfZTWY5nHM7h4g9Z6E1HraBlmzD9/pwFV9ABNIHNddP0c4wqhf7gaa9nW00ZBl3EYwZ4gdJRipe3XBoNoYJvTifM06QdYAX5M
X-Gm-Message-State: AOJu0Yxqac2kqXoZfgpLDp4b43RQn9vo5gabDIGFvrJVTNYp+v7VH/1n
	LDGbAxdpTtPKF4FgRTDWpEDWpm6WE+Ir4ip5PKjncZVnR5UJU4wY
X-Google-Smtp-Source: AGHT+IHhr7KzaySF0ERMZqtScLssIixw60M7eNmIh8SbjYFZf1IZUpEmjEYbzozS9WqOELJ/tWXpjA==
X-Received: by 2002:a54:480e:0:b0:3c8:694e:4fd with SMTP id j14-20020a54480e000000b003c8694e04fdmr5046150oij.28.1714452073483;
        Mon, 29 Apr 2024 21:41:13 -0700 (PDT)
Received: from hercules ([68.69.165.4])
        by smtp.gmail.com with ESMTPSA id e14-20020aa7824e000000b006edceb4ea9dsm20171132pfn.166.2024.04.29.21.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 21:41:12 -0700 (PDT)
Date: Mon, 29 Apr 2024 22:41:10 -0600
From: Aaron Toponce <aaron.toponce@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random: add chacha8_block and swtich the rng to it
Message-ID: <ZjB2ZjkebZyC7FZp@hercules>
References: <20240429134942.2873253-1-aaron.toponce@gmail.com>
 <20240430031105.GA10165@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430031105.GA10165@sol.localdomain>

On Mon, Apr 29, 2024 at 08:11:05PM -0700, Eric Biggers wrote:
> I don't think there is consensus on ChaCha8 being recommended.  Adiantum uses
> ChaCha12, but even that received some pushback.
> 
> The Linux RNG is also usually used only for small amounts of data, and its
> security (and the perception of its security) is extremely important.
> 
> So just staying with ChaCha20 seems appropriate.

The 7-round attack does indeed fall short of the required 256-bits of security
per the stated goals of the ChaCha stream cipher, coming in at ~237 bits.
However, this attack is not catastrophic and of theoretical interest only. It's
well outside of practical reach. The 8-round version however reaches our
required security goal and is currently unbroken.

An interesting note in that paper is how we got ChaCha20 to begin with. ChaCha
is an evolution of Salsa20 which was included in the final eSTREAM portfolio [1]
The final eSTREAM portfolio recommends Salsa20/12, which is the 12 round
Salsa20. but with better diffusion [2]. In the "Too Much Crypto" paper, it
states [3]:

> "Regarding ChaCha, the eSTREAM actually recommended Salsa20/12, or ChaCha's
> predecessor with 12 rounds instead of 20, but ChaCha was de facto standardized
> with 20 rounds."

ChaCha20 is 13 additional rounds for extra security margin, more than have been
demonstrated for ChaCha to be secure.

[1]: https://www.ecrypt.eu.org/stream/
[2]: https://cr.yp.to/chacha/chacha-20080128.pdf
[3]: https://eprint.iacr.org/2019/1492

The reduced-round analysis of ChaCha is actually *better* than Salsa20.
Salsa20/8 has a known attack complexity with ~249 bits and Salsa20/7 has a known
attack complexity of ~153 bits. No known attacks exist against ChaCha8, and the
complexity against ChaCha7 is ~237 bits. This demonstrates to me that ChaCha's
security is very robust, and ChaCha8 is solid choice for a CSPRNG.

> Note also that currently the Linux RNG is using a portable C implementation of
> ChaCha20.  If there is actually a desire to accelerate large reads (which
> again, aren't the main use case of the Linux RNG), it would be possible to use
> a SIMD implementation of ChaCha20, which already exists in the kernel.  That
> would speed up ChaCha20 by roughly 2-5x depending on the CPU.

If ChaCha8 makes us uncomfortable, even though defensible, ChaCha12 is a good
compromise. As you mentioned, Google implemented ChaCha12 in Adiantum. It offers
a 1.67x speedup over ChaCha20 while still providing 5 additional rounds of
security over the best known attack.

-- 
 o .   o . o   . . o   o . .   . o .
 . o   . o o   o . o   . o o   . . o
o o o   . o .   . o o   o o .   o o o

