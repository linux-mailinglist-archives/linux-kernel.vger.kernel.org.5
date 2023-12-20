Return-Path: <linux-kernel+bounces-6262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D364881967A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A6BAB256B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E23E6FCE;
	Wed, 20 Dec 2023 01:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iE8SqDwm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B25168A4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 01:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so6494021a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703036677; x=1703641477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AKiRzNtGGIY1uHjH837oLbfNwwCc/Uk8HlilWVS2/0M=;
        b=iE8SqDwmmop5WmzQ9R6Vw3cjsgZspUBYSU92C4VU9Qkn1hhCymgp9QVolj6RQO2on5
         dK481GpYfXve7NkmKvVXotqTnzw2Xp5UtRVLyONgpDPWHlxcm4eqoGJWt5jIJkTYMa36
         tkfyUAhVEhLpwHzAUAhUgWeHaqB57YhRij4rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703036677; x=1703641477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKiRzNtGGIY1uHjH837oLbfNwwCc/Uk8HlilWVS2/0M=;
        b=Yg1/Mvs4eV6u6gWxJ8rq5+Jah9U3jHC2N6fG9J8eA6sbeUV0uLahrhk0DPb01XMZQd
         Zg8YrRSZ9/67GMxHZe6VeVkSvLxh24oSUvazH7zcKnL97PGTgAe6bB5W0tpM/Rg38Jhw
         IxBYVAv7sETgEcOGvzYperSjVPoOyblHWFxEHCJEWe0zsce9bDG1uavV7IYYeL6/9Hw2
         QZlOknuzbdltcAGF21fIeF0V1CxQ0obtxj++TlX3jbcWqBDS9cO+hPiqWVmJd1UEATu1
         QBA0hnuvmaf1J8W9rXaqmJCkPXfE1afoziLv7heBw/uFM6ZRrDj9wZYzTy9PzIYMmCAU
         fL6A==
X-Gm-Message-State: AOJu0YzMjEUwTVpzRk0cWX5WWWZDLJ1K/J06x2G0IYgzEGuLnGXhcFDh
	m3OH2CdaATbpJ+mkrgSaxeUm1xm/jyWkTNN4mGiAhM0q
X-Google-Smtp-Source: AGHT+IEw6poHwN8e5/hiEfH8nLklZtp5K9QuyUian1NgEzrxhHo+ScLTkNyaLWPdGph83LvT7fuhHA==
X-Received: by 2002:a17:906:bc52:b0:a23:57b3:46f1 with SMTP id s18-20020a170906bc5200b00a2357b346f1mr1578205ejv.82.1703036677078;
        Tue, 19 Dec 2023 17:44:37 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id kt13-20020a170906aacd00b00a23456a405bsm3903717ejb.205.2023.12.19.17.44.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 17:44:35 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c3fe6c08fso59463945e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:44:35 -0800 (PST)
X-Received: by 2002:a05:600c:524b:b0:40c:4857:e012 with SMTP id
 fc11-20020a05600c524b00b0040c4857e012mr5485525wmb.85.1703036675282; Tue, 19
 Dec 2023 17:44:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
 <170281231651.2255653.7498073085103487666.kvalo@kernel.org>
 <18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <1b51997f-2994-46e8-ac58-90106d1c486d@marcan.st> <c392f901-789a-42e2-8cf7-5e246365a1ca@broadcom.com>
 <CAF4BwTXNtu30DAgBXo4auDaDK0iWc9Ch8f=EH+facQ-_F-oMUQ@mail.gmail.com>
 <87r0jiqmnx.fsf@kernel.org> <01bd8c68-1b9c-49b2-8ace-1c7d1b5192ad@marcan.st>
In-Reply-To: <01bd8c68-1b9c-49b2-8ace-1c7d1b5192ad@marcan.st>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Dec 2023 17:44:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
Message-ID: <CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
To: Hector Martin <marcan@marcan.st>
Cc: Kalle Valo <kvalo@kernel.org>, Daniel Berlin <dberlin@dberlin.org>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Arend van Spriel <aspriel@gmail.com>, 
	Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, 
	SHA-cyfmac-dev-list@infineon.com, asahi@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, David Airlie <airlied@redhat.com>, 
	Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 16:06, Hector Martin <marcan@marcan.st> wrote:
>
> On 2023/12/19 23:42, Kalle Valo wrote:
> >
> > Why is it that every patch Hector submits seems to end up with flame
> > wars?

Well, I do think some of it is Hector's personality and forceful
approaches, but I do think part of it is also the area in question.

Because I do agree with Hector that..

> Just recently a patch was posted to remove the Infineon list from
> MAINTAINERS because that company cares so little they have literally
> stopped accepting emails from us. Meanwhile they are telling their
> customers that they do not recommend upstream brcmfmac and they should
> use their downstream driver [1].

Unquestionably broadcom is not helping maintain things, and I think it
should matter.

As Hector says, they point to their random driver dumps on their site
that you can't even download unless you are a "Broadcom community
member" or whatever, and hey - any company that works that way should
be seen as pretty much hostile to any actual maintenance and proper
development.

If Daniel and Hector are responsive to actual problem reports for the
changes they cause, I do think that should count a lot.

I don't think Cypress support should necessarily be removed (or marked
broken), but if the sae_password code already doesn't work, _that_
part certainly shouldn't hold things up?

Put another way: if we effectively don't have a driver maintainer that
can test things, and somebody is willing to step up, shouldn't we take
that person up on it?

                  Linus

