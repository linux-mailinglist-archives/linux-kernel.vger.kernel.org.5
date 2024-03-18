Return-Path: <linux-kernel+bounces-106426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC47087EE7F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622451F24F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC3554FB6;
	Mon, 18 Mar 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJoCnLEK"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8C54BF7;
	Mon, 18 Mar 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781854; cv=none; b=q6QemTdCWBV2Dsm4j6nr0UnTOaClePjcPmIJqOkXI+zOgLhf3Vp9lk7z5P4jTXYW4T8A57ZLO4DMN/mMKn/mDLaPu+yiqiJxzWxWCaQ9drCIM4lPpOZjlWjBuwcfhl+5r0jO8uWC+TmtmKl/MeOsvVN7yLGVo4/ZtuJkFy5Nr+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781854; c=relaxed/simple;
	bh=TJf6LnwgsKl71TNbw+Pvtwa4Bl/y2PNwY3PC96VPFr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AF5P8s1+oru3hq451/NUQBRFvJQBZrNR5doSBiW4c2TTEV3lI8kDOfEwhcY0AGcf0KwhOFdDAiyMDO7X1YKqLaL20HD26KAMoYB5cXNqYUFnN7ubUAeqsosnL5UUdfHGWzdmzx2ib2FjYuV2gHudY5s3uHtIT7RMAjOHzofB1TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJoCnLEK; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a49261093cso1412415eaf.3;
        Mon, 18 Mar 2024 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710781852; x=1711386652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Fp/07gqSj3HNqiWAJVFuUHu0yxBPdZOSVPdfE9Qmrc=;
        b=mJoCnLEKXuWTHIFWhXsLIz5OGTX3ct3za7RkrZujLO39fVjpevSmV2X4GTEKWBuQYy
         71FLuXfRfqCj/S3TasXEvvVp5BKGdRNOHUmQ218VQ6zhclXqrt+MAQOqNg73l+N7MRgp
         v34HAilGLF4k+vxhhGTmx9IYjhoB2UWLBacjQbs+bkTJR5bA1tZ1kvzdLAM7W9HzpKn5
         HW0+7fta9A+oYSbxh2cQRhYYia5+TvLAx/Knr2HB36xjMsj2SiPwfPMJ/wAtyFai5Y1q
         in9QqaqbXL+lDvjbQxp8SXEAPhAiAIbcQ67izqPAJKMqZhzJ0NJ+dyIQjPmfS6QTWjAJ
         CR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781852; x=1711386652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Fp/07gqSj3HNqiWAJVFuUHu0yxBPdZOSVPdfE9Qmrc=;
        b=lCQEgph+0pz5IoZSAwjMXUNkM/6NYDE4rNsuB/+QWkicQCV801tY/8s00n+i5e3tnw
         wauHEv4BeYvWUgAYM0wRjU0XIPwlD12d0hVLFG5hTnHzsBLj2px/pVRJnwwraWBolwQU
         rP8v/IpXirbTzyF0q/ayK23ThYCBcxddVYFHKNdfvnczUXmVxJ4p21bxgOG5g2Z6BMr8
         JQpatbgYqdwsYpraMjO4PgW0AirRIlP25KD2VP+FH21Z6JzyWqIJhCnNigF9AJLg5zGH
         +qWexf/OIQt8LhNJMgyqenFZuogthERBRrCizqU+XIvXF5GDIlEz54b4pJWHlLc4TffZ
         WwEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3i3Opt3OqkZp8oRBIRDONYQFFxsu4MNbqbvjpNLqTvH6IlXcr7TqS6/7qjueUKn+Rd77mhvkOu6o7HubMzI9xd79DHf24yYcIkLRsQ9HSgW5gi+ri+nJtHykPmmQ6cZVyt5/zGl49
X-Gm-Message-State: AOJu0YyumF4othZPTq9kJoQZg+2ME52s53wgorPKwHUhgWzBpBNq5gjk
	4KcNf/WGPhokjNpvnih0hhoO18cUjTXxPzMFWuL1aFD5ZeAy7ZmQ9DxX2LpYdT2PR02YSEEzr7/
	GIF6meUUJ9bbnhDylFUKXM0SYn6c=
X-Google-Smtp-Source: AGHT+IHgCd3BExVo1DFNj17nFMKQ1w7GzsQ67J8jV3E/WZw61T0NX8LaQJaZcp1/mvXNBoc0UEc7RNlZagX1PWpGwm0=
X-Received: by 2002:a05:6870:9688:b0:21e:7cee:9815 with SMTP id
 o8-20020a056870968800b0021e7cee9815mr13809024oaq.53.1710781851752; Mon, 18
 Mar 2024 10:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301141800.30218-1-lukas.bulwahn@gmail.com>
 <m21q8732wo.fsf@gmail.com> <41f28393-0211-4448-8add-ad3c55d02210@oracle.com>
In-Reply-To: <41f28393-0211-4448-8add-ad3c55d02210@oracle.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Mon, 18 Mar 2024 17:10:40 +0000
Message-ID: <CAD4GDZzjc6=-Gzw23tRgCDE7=AxsenXqpD+qnh6gj1+MYYU2fA@mail.gmail.com>
Subject: Re: [PATCH v2] docs: drop the version constraints for sphinx and dependencies
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 16:54, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> > % time make htmldocs
> > ...
> > real  9m0.533s
> > user  15m38.397s
> > sys   1m0.907s
>
> Was this running 'make cleandocs' (or otherwise removing the output
> directory) in between? Sphinx is known to be slower if you already have

Yes, times were after 'make cleandocs'.

> an output directory with existing-but-obsolete data, I believe this is
> the case even when switching from one Sphinx version to another. Akira
> also wrote about the 7.x performance:
>
> https://lore.kernel.org/linux-doc/6e4b66fe-dbb3-4149-ac7e-8ae333d6fc9d@gmail.com/

Having looked at the Sphinx code, it doesn't surprise me that
incremental builds can have worse performance. There's probably going
to be some speedups to be found when we go looking for them.

> > I have an experimental fix that uses a dict for lookups. With the fix, I
> > consistently get times in the sub 5 minute range:
>
> Fantastic!
>
> There is a github issue for the C++ domain but I believe it's the same
> issue for both C and C++ domains:
>
> https://github.com/sphinx-doc/sphinx/issues/10966

Ahh, I looked for an issue for the C domain but did not see one. I
didn't think to check for issues with the C++ domain, even though the
code for the C domain has been copied from there.

