Return-Path: <linux-kernel+bounces-159565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758618B305C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C181F2398B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D87913A879;
	Fri, 26 Apr 2024 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw8j+EMt"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0E282FD;
	Fri, 26 Apr 2024 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714112782; cv=none; b=Y0B206reJ9XhT+OMz/xE85RttAlmWbyvIuvqJf3wSykYOmcfDKJm9fbIIBUOHNLVTPprzRSnqBw8dP6b4SimMxHMWWqbhAw3y1D8CA8aUL7ohD2GsZgaKJfHvVr3SlcpjGAXuS5/VHAF0hpaY7Ofr63RW6ko9z00dlDVAAR1l1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714112782; c=relaxed/simple;
	bh=K/lLSTmB1r5VdQlAr4SIuQlIKbznnzoX4+gIxqWEcdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GtmmdO6qOab2RqE2nmV6+u/CyJDD62IyHYKiaDAistfqKctoXBjt91C2CnSD36Rz8yB9ly2VEuREndbDC7u5ilc2TVnbr+khMXrC2iBukr6oPKbVVVawdnDBbwt4qR+MOMU++4QbH2m1BgtAAP70w2tSR3LnQpjblAPgVZTJLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw8j+EMt; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso1340197a12.2;
        Thu, 25 Apr 2024 23:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714112780; x=1714717580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akq0FDQRGKYwMJs1Hv8SvLZ2QQx9betP7BmyGgdXjV4=;
        b=mw8j+EMtvSkYd8vFt/k5aFleWg6NVDh9FhimBhl4udQkGErWsmcSIncYPON4R0Pf2f
         MTEaPFY83a7HmoLQs79n1uUMJZM+KPQUIroiiVcWvFCDXiizwCRHRXd1oiYWgvKjIK5B
         cteUw+SaEmji1QVEW8KSqDQf5tzwDxMmXxeN1nSrpucvH2PxIw3JBse3ZjEpjdY9cscp
         FpTip+4kyGSxjoYfYfrZc6ordQCl0x3MY6KGGim3XP3Ve2alFa9SeTI8F8NYl0aeVrhK
         g+d/vnnNkrTfI1YvC5xFpHc8bENkpJLnMGrx1aOUT/hFNned5IM3pZhpQ4Uhm2DwHukJ
         3Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714112780; x=1714717580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akq0FDQRGKYwMJs1Hv8SvLZ2QQx9betP7BmyGgdXjV4=;
        b=GHxzEaxfDjaxiwNHCgV233I/G9pvNvkjsR3AG+UEKdZut/G3P5rW1dyk1rHtEmN9Be
         J5e8a5egesCurr/t4JJs9JbBKUhGxg43kPyQsNe7NHRZhELUkg2FmWEehTabJJeDtxGA
         HBWTaqDEtcION4HUZ41qK3s9etfyrPYFGfPZgdce3ps5XG5VctuyLG0lN8ve/GNcD1Hr
         2VdwJb8LpY5qiomdIujIT/3gUC0NaXdRS7KzGRThL4NfeYlJYt5+PGtIqM5Si9uQY254
         NiVScaTSnWLGDTCjee9Rhc40F+jhXEmB7vKPG8fyY5DQw4VzupBdPoai+hApUSSMbGrc
         IzPA==
X-Forwarded-Encrypted: i=1; AJvYcCXw/zD/dcS0D50AknmBwBqabEWZA3+cFp00Brbhgjg7ueEAGiht+xke0tUlRBf7215CpmtJxJrExxyZMGcqp/wEXgEW4HBOlARedreq
X-Gm-Message-State: AOJu0YygUThGSwTtgDWQ/jYMaiOppdcCDMqmrTeE/OwFrmx+Na72CJ1i
	yqS7ByF8iT1Sw9I3CHCtqfq9lWyV10v8x3tXa6F7iSZba66Mmyfn
X-Google-Smtp-Source: AGHT+IEtZOi6hhkuI7OrQ4kBPhgfN1vv2fTVRaLhJdr4hhFHGpJmOgnhcutwsZrkdGezK4r1v3/F7A==
X-Received: by 2002:a05:6a20:8406:b0:1aa:5b05:7925 with SMTP id c6-20020a056a20840600b001aa5b057925mr2228373pzd.4.1714112780100;
        Thu, 25 Apr 2024 23:26:20 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001e2a479954dsm14791818plh.181.2024.04.25.23.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 23:26:19 -0700 (PDT)
Message-ID: <63596d91-0a34-4311-9067-e2a125514e1a@gmail.com>
Date: Fri, 26 Apr 2024 14:26:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] docs/zh_CN: add process/cve Chinese translation
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240422041115.2439166-1-dzm91@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240422041115.2439166-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Alex Shi <alexs@kernel.org>


On 4/22/24 12:11 PM, Dongliang Mu wrote:
> Translate process/cve.rst into Chinese and add it to
> Documentation/translations/zh_CN directory.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v3->v4: revise sentences suggested by Alex Shi
> v2->v3: remove a trailing space
> v1->v2: add a newline at then end of cve.rst.
>  .../translations/zh_CN/process/cve.rst        | 89 +++++++++++++++++++
>  .../translations/zh_CN/process/index.rst      |  1 +
>  2 files changed, 90 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/process/cve.rst
>
> diff --git a/Documentation/translations/zh_CN/process/cve.rst b/Documentation/translations/zh_CN/process/cve.rst
> new file mode 100644
> index 000000000000..e39b796efcec
> --- /dev/null

