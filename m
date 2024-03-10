Return-Path: <linux-kernel+bounces-98100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 925F1877526
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 03:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B67D1F216FF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7E81115;
	Sun, 10 Mar 2024 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI3GFeSy"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41CEC5
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710037653; cv=none; b=HVgDyEbKEgtwjUXQCP9AWIErLQnFCSscnMIWsPmw5qdErOQMsZwFu5ewUcMUWZOnbASMGDRDtf9Mi6aRb1pcmozabmV1+V0twvsUuSfdZfTp830+22fvOuU6RG+LzTMG9tQlcfay10IdR3PxIPWApGU6P1ac/wOZxWkok0Gt4Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710037653; c=relaxed/simple;
	bh=z/Ae57RHxWxRm7fOcWED5pQ9hfFioiYvDwVI6LW6oOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVIX4PpzLQlaL2EcqxhK/ZclukN1VkG5lti48Cwg74tVyqkwx80jGkZXHSba66zR7n5Faij/LXNamyoizSmtod2rt3WAakAqsAoMEWMGSDlr9cw6AJkeZwpnBCx6gWnuLwwR8Q3jLC08eI8Zs33FRIvSHzhR6FbjY2ankgPK+HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FI3GFeSy; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso3954673a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 18:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710037650; x=1710642450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UyIMcx7YI42naqlnpwMXGZAB29gG6v/fxoHkDHcKrMI=;
        b=FI3GFeSycA6I+N+Of9pwNxYjc9HQRvkkkODWL5qvujW9rMVnn0gxHZ+Dn3/9QDWmFw
         O4dcpcfE+m9/SScIOqnVmXVOvU+8RJ3wojPeQ4Yyx4lPlfepICTIEdVwF9/dT/ZxrtAU
         etQwoyuUGcfRKpVE5z3d2l4tYzmC3Qzu4hFdRtXfAAuTJ1/ILFH9qalWtoS2KJuDg7Vy
         GAM5IZnOz+SkUXUA6IHDY7Q/c5JbxitS3ZlJ2rK0De/EHRjOqVbv6XwykOLI+WWCQbax
         MxuZPHBo4I9bD3qTJc90cEGBhv5jcm1HZUmuNd5rAD0vUj00E88G36rY45FxJj/C+vzX
         YaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710037650; x=1710642450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyIMcx7YI42naqlnpwMXGZAB29gG6v/fxoHkDHcKrMI=;
        b=mbMXE1B5vQ4FW0eSqPzN4DtdDxIGBYiAWQhIVwEisFZqMkYm6U3rthUgmF5THHC4ss
         D7c+pmuEMS/zmdD1MpE7kFvzX6f0oXV0XsiBZriK04JFDqoiFeHzEpfbbGdIa0cOBObh
         ogewD9qOH8ioIYFYqRMYBlRWMGuCyJJFk/Y7GxqRs7uCtiMxsV2VExZa65I5cbwBIdxQ
         1BWDLzonWeasatZntzl2wP4P0QbLumcZqQ+c69efBs1p8K5/WuJqtZNjh232kUF8I2Kx
         alaAIIFMbkfq7OoHSysVdIL2fEhjCo0sZ5Szb8X84s8qHVh/na7zT3ok0/EL3KXimn+k
         NM1g==
X-Forwarded-Encrypted: i=1; AJvYcCVPhUflZl/jYZz2o+9NTh1ISaB1LyHMVryskS0BGkHQTlt1P9GbJ2wfkvqJBeA1E9t/zSFFPcH6alwOuBX+gSY5xED1ZsEqNqzMEZNb
X-Gm-Message-State: AOJu0YwPchopMN9u9F9KzyIJZa2iriC2Jb0hW3UWXNsBKDkGl1Y6Tvt1
	eAYjx4GByOo7rLZSwh64Ra+FjzAinGLiHSF7MjwRDLAReZH1uv9WTZfFh6NB
X-Google-Smtp-Source: AGHT+IE3ieeEcK8ealprtxmznMKb1f67Bx1kVR7dXHKRFQjHyEmXV3jr67k9sfuxgKuFmqcrZ+e8lA==
X-Received: by 2002:a50:c90d:0:b0:565:edd9:1acb with SMTP id o13-20020a50c90d000000b00565edd91acbmr2188878edh.23.1710037649712;
        Sat, 09 Mar 2024 18:27:29 -0800 (PST)
Received: from andrea ([31.189.122.3])
        by smtp.gmail.com with ESMTPSA id i40-20020a0564020f2800b005684b7c7cbcsm643588eda.78.2024.03.09.18.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 18:27:29 -0800 (PST)
Date: Sun, 10 Mar 2024 03:27:10 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Kenneth-Lee-2012@foxmail.com
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
Message-ID: <Ze0afrfXMe4oJ4ez@andrea>
References: <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>
 <ZejC+lutRuwXQrMz@andrea>
 <Zenip+8BDM3p+MUh@andrea>
 <eb8f2a21-d388-424d-8504-ccd7bdb53a93@rowland.harvard.edu>
 <ZeoFBkB1BeTdEQsn@andrea>
 <bde188b0-1c5b-4b3b-94de-395a52fc37ce@rowland.harvard.edu>
 <ZeoQvj3l6moF9KdQ@andrea>
 <tencent_3FCF3AA5E98BC9395F98803764A6B2F7CC07@qq.com>
 <ZeuFQdk/zcjkILbC@andrea>
 <tencent_454C12FBD6076C20C3955565E6D6354E4F0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_454C12FBD6076C20C3955565E6D6354E4F0A@qq.com>

> > Remark that, in the CAT language, the identity relation ({(e, e) : each event e})
> > is a subset of R* (the _reflexive_-transitive closure of R) for any relation R.
> > 
> > The link at stake, (P0:Wx1, P0:Rx), is the result of the following composition:
> > 
> >   [Marked]         ; (overwrite & ext)? ; cumul-fence*     ; [Marked]          ; rfe?            ; [Marked]
> >   (P0:Wx1, P0:Wx1)   (P0:Wx1, P1:Wx8)     (P1:Wx8, P1:Wx8)   (P1:Wx8, P1:Wx8))   (P1:Wx8, P0:Rx)   (P0:Rx, P0:Rx)
> > 
> 
> So the cumul-fence relation includes the same Store? This is hard to
> understand, because it is defined as:
> 
>   let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
> 	po-unlock-lock-po) ; [Marked] ; rmw-sequence
> 
> There is at lease a rmw-sequence in the relation link.
> 
> I doubt we have different understanding on the effect of
> reflexive operator. Let's discuss this with an example. Say we have two
> relation r1 and r2. r1 have (e1, e2) while r2 have (e2, e3). Then we got
> (e1, e3) for (r1;r2). The (;) operator joins r1's range to r2's domain.
> 
> If we upgrade (r1;r2) to  (r1?;r2), (r1?) become {(m1, m1), (m1, m2), (m2,
> m2)}, it is r1 plus all identity of all elements used in r1's relations.
> 
> So (r1?;r2) is {(m1, m3), (m2, m3)}. If we consider this link:
> 
>   e1 ->r1 ->e2 ->r2 e3
> 
> A question mark on r1 means both (e1, e3) and (e2, e3) are included in
> the final definition. The r1 is ignore-able in the definition. The event
> before or behind the ignore-able relation both belong to the definition.
> 
> But this doesn't means r1 is optional. If r1 is empty, (r1?;r2) will
> become empty, because there is no event element in r1's relations.
> 
> So I think the reflexive-transitive operation on cumul-fence cannot make
> this relation optional. You should first have such link in the code.

In Cat, r1? is better described by (following your own wording) "r1 plus
all identity of all elements (i.e. not necessarily in r1)".

As an example, in the scenario at stake, cumul-fence is empty while both
cumul-fence? and cumul-fence* match the identity relation on all events.

Here is a (relatively old, but still accurate AFAICR) article describing
these and other notions as used in Herd:  (cf. table at the bottom)

  https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/herd.html

Said this, I do think the best way to familiarize with these notions and
check one's understanding is to spend time using the herd tool itself.

  Andrea

