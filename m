Return-Path: <linux-kernel+bounces-141999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801CC8A25F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204031F22409
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925121BC4B;
	Fri, 12 Apr 2024 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwe4TmCm"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B891B974;
	Fri, 12 Apr 2024 05:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901054; cv=none; b=tOXzX73xNNEdtAMe0HOyZHmeVWBSGra8B/jAKigoHce2jSqo0ukK8iFMVi6VRrGd+ua7sx2dsCuhSWVgRfL88MuFKWlQc8cXYljQh3+Wt3qiCk9K+kL7lR/fMZdxZhjehD5NuIENavP1zM5G1xPb6KRW0RY0iaGQ/30/DDVd2wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901054; c=relaxed/simple;
	bh=qx6ompS090EU6oaymJ8vYi09zxJzRBow4hMUa484dWM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CkIKcS6kRL+ZGxSQoB+AAcKzHfd4rhIb9+OI9/dF45co6R/Gb6H8j0ysuD+ngqfIbi8oWPlvbLGnRay5g+gEpjDyAHrgksY18R0DdURWqqNVH3dqu5bMT+JL80djZLyvYKbE3JOtXRhwcYSf7KlKoZZyavTE2VEab3+Augsbwjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwe4TmCm; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d8a24f8a3cso4821951fa.1;
        Thu, 11 Apr 2024 22:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712901051; x=1713505851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OUqqIoLVyl32Am9CtoDJBz/T8IAJNp9zL27JaewSqCE=;
        b=hwe4TmCm7dM8F07tEJZAIlkhKWr2oogXFaZs9pouuwWG3v5Nx8LPzDXYcQAfMH49oD
         EUcJTgjb8QXz0FAHWn67WVI0PdPQ6zhIVEByAykHZOZIg5KddiWYwe/F+4fdZE4TXoNi
         FodY9cZ6rBM3YSLt2lOlOFGrIYuwKtRA7Hx0SUv/RBUxqMGg8VrKsXjIJIWy3sqNv4hm
         gGtnoLoyMiejyd3mE6sM5aJTwlSi8khORvkg0W0XZbalacLmQZ7Jf8fZb5GtQ05sZzhl
         dPg7OXRFP3sJz0qBgBCoLBf6orGG1KwCCF+kSnHhY0S6Dgm8dpqzgykEY7AVo9lH0wiF
         6Z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712901051; x=1713505851;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUqqIoLVyl32Am9CtoDJBz/T8IAJNp9zL27JaewSqCE=;
        b=VlIHpOWLaZkNeFotOafJziZJDzPgTxzzFLg4pBXBxy4VdmklaUpEfHbSZbMINTpHTe
         K/TxxO+5JVHDt/z81tbyRG2E4VsfKa3UvT/k7h9wstKHnZrIY+gIx0F6yRYa6weiAiHN
         4AASgwMOCW7DCRQAlXUa9t9k5MSdGsqr0WzUvkaM1r6RyFkzLy9CW5Fl5xPWsCvBlBKY
         CBkRDE8QfL95N+1o8tHX/NRr5CyCm33ve6y1Bo30baOoe7sau0DOWyYmBp1SFryUVKyk
         D6ynyB+cP7dbxNRqWx/U03d4YikyhRAa1/7QLI4k6zsTEYrphJl/hsx6nnqsnW5I6s1r
         I3Og==
X-Forwarded-Encrypted: i=1; AJvYcCU+A2Czw/TO2tBq2sOh4rxviEHObKTe1ugffP4sGiaLDiLmOYWHeZ9hbry8db+X4EmkEeSGHC+SOBixIn4dh6ToQWJaRQ+dizamPuyhQqFShHT+mzCTXTQ+uNuEnG5ASwmuyHLSZR/Zj3zG7HB/0c437JcXZXjbiZ/Jkh2lrYeb2UssE28hCBaM
X-Gm-Message-State: AOJu0YxL0RF4ljaFVE6RUkRgXV00dqjfM7YH6qq+Kn0cYs1EdvPTgynP
	Qz8UsV404DWJYQFAZZEboB96Db1DV2UhPNMFsqdswunjtm1pF6Ned//nYA==
X-Google-Smtp-Source: AGHT+IGr9w0Z8Z8YBWyPKbrrVMYvt8nmSPJBLsKAdvNhE/qAoPvafm6k/xQx04be5DbmnHEnAUL7nw==
X-Received: by 2002:a05:651c:1543:b0:2d7:b4f:e3fe with SMTP id y3-20020a05651c154300b002d70b4fe3femr1020212ljp.34.1712901051346;
        Thu, 11 Apr 2024 22:50:51 -0700 (PDT)
Received: from ?IPV6:2001:14ba:7426:df00::2? (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a2e9d8d000000b002d557895e4dsm416005ljj.131.2024.04.11.22.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 22:50:51 -0700 (PDT)
Message-ID: <853e5854-c2b4-475f-9449-29ce0e35b23c@gmail.com>
Date: Fri, 12 Apr 2024 08:50:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] mfd: support ROHM BD96801 PMIC core
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <b86b7a73968810339b6cea7701bc3b6f626b4086.1712058690.git.mazziesaccount@gmail.com>
 <20240411143856.GD2399047@google.com>
 <25c959bc-fb02-42d9-b973-4a74cebd7208@gmail.com>
In-Reply-To: <25c959bc-fb02-42d9-b973-4a74cebd7208@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/24 08:40, Matti Vaittinen wrote:
> Hi deee Ho Lee!
> 
> Thanks a ton for taking a look at this :) I already sent the V2 
> yesterday, briefly before receiving your comments.

It's not completely unusual I don't know what I am doing. BUT, it's not 
that common I don't know what I did... Seems like the V2 is still in my 
outbox, so I will add the fixes to your comments prior sending it! :)

Sorry for the added confusion!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


