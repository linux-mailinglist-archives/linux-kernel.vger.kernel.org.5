Return-Path: <linux-kernel+bounces-3680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75962816F84
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA071F268AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFA63789A;
	Mon, 18 Dec 2023 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKhGPq3B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669033789E;
	Mon, 18 Dec 2023 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d190044c5so8785965e9.2;
        Mon, 18 Dec 2023 04:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702904007; x=1703508807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zk7VwvCkv/REjWb5Mkx7cR0feqBstB82gntTyFAKcZQ=;
        b=AKhGPq3BcnqHhaAxKRl6Kw+9z/KCj4nm/Y6c3BqWh193sm8InAetKLi61HgKqHqGEc
         1+VA8pnopJCVhKkf4MWSUYQEwPo98YtVXHYX805j2WpLEqWYfTJTT6/IYu/++GWap572
         chfF0PsB7DI/GaiU46FD42aDxTwZKHQDE6WNkXYYdd/Gzr2VnLGoJFoTXK3pgww146um
         POi56FmXwfP9fAC5Xd35LWOLwcszle9f1/zne5liiKXLucHGiKtifcY6G9pQx5OE5WrJ
         t4Afanc8OZ6Ctw6vDBGVwrIDakJUy9w72+FkmbjWlLynFHsSSi9ykXYIuIPtqNWxflcu
         XNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702904007; x=1703508807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zk7VwvCkv/REjWb5Mkx7cR0feqBstB82gntTyFAKcZQ=;
        b=ikR0TTLrCjZQBEO5fPHoQNrc7/mi5o76B8xNf5gu4BidOnMGs1a2W/uM04dfdTBBXR
         4dVr8jRR2+2Y9oowvtzRy/Oj7m3Ys0bK1QfviweuR7I0LdacULKyo886j2sGeljnOhzm
         vF7D0z5QotiUu891WBBeQwkHVh+nI4pBWFUTTbX5oZ819z4Rwd0yDugXybjIhF9cuMbm
         9W85y6dJPw9jfqnqmvE2lwxcvq1RkPGGM1odplYkiuol0Plxnu6ESrP7eczJjvOfjOvX
         b/NDsF3iPdXPke9WHXV/SkGJXYI28rhAkbNJYWhz1DwRVRDAUpNJbUNC+JLpeTr4tH8f
         peYw==
X-Gm-Message-State: AOJu0YzOBcpASbapYfsfsBoMg9STt/Wg1U/DSjsEy6SDu3jMA77V5Du5
	6ELR/fu4fY6dD5hxCpRWhZtDN2HLApZRtWHy3LPXe5IE8A==
X-Google-Smtp-Source: AGHT+IH4P/pa/XE7Dbmoi0Vq1JMUyCieCQChtYE/NkSc01lbxr3nwZDSMxNt0rxJT1KPgJiHbuKlRPEFALGgf3loX7w=
X-Received: by 2002:a05:600c:3b8a:b0:40b:35aa:bfdd with SMTP id
 n10-20020a05600c3b8a00b0040b35aabfddmr7444701wms.27.1702904007367; Mon, 18
 Dec 2023 04:53:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218114222.283705-1-tomas.mudrunka@gmail.com>
 <c22997c9-6d99-4e1f-9015-b7f80be2a720@kernel.org> <CAH2-hcJe40e7LhrmQb5XjGpRfrUEp3RukqWUqn1p8UQSNkpisg@mail.gmail.com>
 <2023121858-aground-consent-cfe3@gregkh> <CAH2-hc+BO=oxt2faSqy4AJS6qPdjC+cAc+ONZrvYnCPJT1H61Q@mail.gmail.com>
 <2023121858-detonator-deepness-0135@gregkh>
In-Reply-To: <2023121858-detonator-deepness-0135@gregkh>
From: =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Date: Mon, 18 Dec 2023 13:53:16 +0100
Message-ID: <CAH2-hc+OeJw6mZbekqCLF33GPY5wCHRMhS7auGMmR=dFazwG+w@mail.gmail.com>
Subject: Re: [PATCH] /proc/sysrq-trigger can now pause processing for one second
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Add pauses and soon you will want loops and then it's turing complete :)
>
> Why not have a bpf script that does this instead?  :)

Funny you mention this. For a moment i've actually thought someone
would come with this idea sooner or later. :-)
But i think we will all agree that there are several reasons why this
would be quite terrible idea...

Anyway for me the sysrq-trigger is about giving kernel linear
instructions on how to shutdown/reboot ASAP with minimal chance for
data corruption and least amount of userspace involvement possible. I
just want to kill everything more or less cleanly and safely reboot
without having to give control back to userspace script, because there
might be something wrong with userspace at the time.

Tom

