Return-Path: <linux-kernel+bounces-24116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F84882B74D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC81B286E26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9366056B88;
	Thu, 11 Jan 2024 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UJ9CSk+Z"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812B21351
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 22:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28b1095064so647584666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705013656; x=1705618456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bl2EO7yezYiVPGfmE+e0KG7KvJAbfV77M002tDc+A1A=;
        b=UJ9CSk+ZxcFgubqeEJdMZTZUDkmIpNsjC8jZxoqDFOhpetxzaOXoCbLC63VmGg5+yp
         XottLrR4OShrSbG8WbK/068db0LiSF4R2BSNio+Cew2Jfp18NYjUxutKN7d5s1ihWJsf
         QVXv6uE0Xey6hhQSe/E8l2VJFroDqwPiPScS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705013656; x=1705618456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bl2EO7yezYiVPGfmE+e0KG7KvJAbfV77M002tDc+A1A=;
        b=RBQ+Fw6zUuSQiXCLSOQm9kuMeVkQata1Ltcn2omBoSTggB25xljAkpt1lL0+KjhkVf
         1ptUrymOdzAK9bWdvxIaOr4vw7Fqn4jqhl/jS1v5nAqM+Hrgsi8MEwoWuzPRP8INo6G8
         6srOpXB60qyDVszKxJifO0GlkkZMnEPCPwY/4TRA2V3OH1Ggq+YGQ1zn5aANUUyYYFuB
         RtJhvJ0oMVr5+dSPcOnu1wvgo3wSNW0EfRQvOXZEmEPQEKI6ZWJ+Hcyypccgzxr2oVtZ
         bcKC4lLkqs/um/8ZiV0IMT7MFEGrfHVnjT0xqRWlFOA/FyzsDm8CqLq+W3BN7g08PE9L
         hwAQ==
X-Gm-Message-State: AOJu0Yx8uLtHRLKzpl+7Ravdqo2RUFYi8rEOmNducMCMFOrQeKWP/X9s
	NzKJUYmupooMVD5e8ZDRt9vQwZw37vT1wP+u0Z5XLn6vRehZ9sZ2
X-Google-Smtp-Source: AGHT+IEhFOl6j/qNPzBU4nRmKYLSqppUfZOaFFSVYE/urwVGvWKw7CTBTPVGZhxsX0w/PqTKIz1RhQ==
X-Received: by 2002:a17:906:6056:b0:a27:a00a:bd8a with SMTP id p22-20020a170906605600b00a27a00abd8amr96886ejj.151.1705013656228;
        Thu, 11 Jan 2024 14:54:16 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id qc21-20020a170906d8b500b00a26ac5e3683sm1072015ejb.100.2024.01.11.14.54.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 14:54:15 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso6759565a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:54:15 -0800 (PST)
X-Received: by 2002:a17:907:36ce:b0:a28:d31a:f8a with SMTP id
 bj14-20020a17090736ce00b00a28d31a0f8amr113422ejc.246.1705013655197; Thu, 11
 Jan 2024 14:54:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5ac3166f35bac3a618b126dabadaddc11c8512d.camel@HansenPartnership.com>
 <CAHk-=whKVgb27o3+jhSRzuZdpjWJiAvxeO8faMjHpb-asONE1g@mail.gmail.com> <3b5b650fa3c6ed6dc7f296eb7258c722a699147d.camel@HansenPartnership.com>
In-Reply-To: <3b5b650fa3c6ed6dc7f296eb7258c722a699147d.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 14:53:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wik=6Rhvm5Kmgzc6VUJdp=17kQcxXFAGwxkFveU=dAvtQ@mail.gmail.com>
Message-ID: <CAHk-=wik=6Rhvm5Kmgzc6VUJdp=17kQcxXFAGwxkFveU=dAvtQ@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.7+ merge window
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 14:47, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Well, I did already tell you that I bypass the pgp keyservers because I
> use a DNSSEC based DANE entry instead:
>
> https://lore.kernel.org/all/1564171685.9950.14.camel@HansenPartnership.com/

I think I dimly remember seeing that email.

But honestly, that just reinforces my point: this is yet ANOTHER
magical thing you have to know about gpg, and that nobody buy you use.

So if you insist on using these things that are obscure, you need to
keep reminding people. Every time your keys are close to expiry, send
out an email saying "To update my key, use this magical command line".

If gpg did that auto-locate automatically, and it all JustWorked(tm),
it would be one thing. But that is clearly against the design
principles of pgp and gpg.

              Linus

