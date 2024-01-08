Return-Path: <linux-kernel+bounces-20121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8029A827A03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0F62810D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C0755E70;
	Mon,  8 Jan 2024 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UQVm02xd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3923A5380E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a271a28aeb4so227391366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 13:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704748291; x=1705353091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RTN2vPhLY7RAk40kndh1PrOmouWR62J2f4LyCXtmXbs=;
        b=UQVm02xdZH6q2Tn9pirvRAaD9rC+lRVSfhBlv/zLbdtOPCwOAtqVRMXhiwtfluohNI
         vMCPkoo5gPHaEW0pS2hUJDpCqePLo3fMevWYsZE2X2O1iEoLc6snBhMsQqlzzGr7LKec
         9AMawepY46mOIvMCdCT/oHwzLQTYlH2dMLOUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704748291; x=1705353091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTN2vPhLY7RAk40kndh1PrOmouWR62J2f4LyCXtmXbs=;
        b=LcujygGhzlBurkJBquI3rGaA9Xd1iv4qjX1CdD9aInQyJF7qgjB5UOpQCMeinY2NpN
         1T7TD3erEVDLp0/wHpl7ZwQEwfwTZekeceVyKb/wMQVjjwdiLz+rTMNYSIa4ppzOIFKx
         dhQydqE3Z5M19oo7+7v5d+OIz1SA+hJ9G0V4PCXZOFl5SCPKj02Neif7NCrJqc46IErb
         57sP39d8ciHEI0HPPvNEQMKypIPZPdFtHYszMX4S+WlHLZ06Lj19AkrACIV+6lJWpgOV
         OSXt6uQQuWedR3CrzDfJvFr9iJ54UzH1k8aaXUO39RS8RYrIDjHQ6s53qbP4QMfZzLAw
         ZlDw==
X-Gm-Message-State: AOJu0Yw1glfbuIxWlV8rTQ5ixXRoBlzXEu7SNDv/3PQ4KpC1RN9E+csN
	WZNkGuUfgIS9PyABAex7pIqJHqRHh1qSkB60CTG0S/WlJ1Re171X
X-Google-Smtp-Source: AGHT+IGmCdykgOZQxT0dMbdWk3/JE7adi1+RpwW42SsJSjSJkdCbB03mqkxv/6chiC/79m3VJdC5QQ==
X-Received: by 2002:a17:907:9056:b0:a28:d83e:d0ac with SMTP id az22-20020a170907905600b00a28d83ed0acmr13893ejc.142.1704748291383;
        Mon, 08 Jan 2024 13:11:31 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id l15-20020a1709065a8f00b00a26b361ec0esm253013ejq.118.2024.01.08.13.11.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 13:11:30 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a28a6cef709so228120866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 13:11:30 -0800 (PST)
X-Received: by 2002:a17:906:5806:b0:a28:ccb4:6ba7 with SMTP id
 m6-20020a170906580600b00a28ccb46ba7mr28069ejq.11.1704748289910; Mon, 08 Jan
 2024 13:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com> <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
 <CAHk-=wjE1eLMtkKqTt0XqNSnKAeDagV=WQU+vxHL_wsLuO8Gag@mail.gmail.com>
In-Reply-To: <CAHk-=wjE1eLMtkKqTt0XqNSnKAeDagV=WQU+vxHL_wsLuO8Gag@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Jan 2024 13:11:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=whkGHOmpM_1kNgzX1UDAs10+UuALcpeEWN29EE0m-my=w@mail.gmail.com>
Message-ID: <CAHk-=whkGHOmpM_1kNgzX1UDAs10+UuALcpeEWN29EE0m-my=w@mail.gmail.com>
Subject: Re: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
To: Jiri Slaby <jirislaby@gmail.com>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 12:04, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So we *could* plan on that, remove the checks from min/max, and use
> something like the attached patch.

Whee.

On my machine, that patch makes an "allmodconfig" build go from

    10:41 elapsed

to

     8:46 elapsed

so that min/max type checking is almost 20% of the build time.

Yeah, I think we need to get rid of it.

Can somebody else confirm similar time differences? Or is it just me?

                 Linus

