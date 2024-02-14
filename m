Return-Path: <linux-kernel+bounces-65284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8570854A96
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2B01C26502
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FDE54789;
	Wed, 14 Feb 2024 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpI9oj3p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F361DFEA;
	Wed, 14 Feb 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707917819; cv=none; b=HW0R+YOn4fADzr9dYcB0cmpc3hBQwtM7q5HjU7zkEy/iiSdbQRYIt/H1sLmjqkl+Q6aozPufbMKqiTBDPujsRfPjrJTA6f02VNhjwW+hqyDmUCZr08wywMyltaYynhjWPRGGGGNl5qE2lyjtYpzi8x5/p+YGW9Edvf7VQHODoMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707917819; c=relaxed/simple;
	bh=U1jCTNVJm15uvKPqEIOl7zNnBDnvU9eJTInfZRnMjpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsdQsfUJJwWpPWNg/+vWQ7EsF4pK+uDU4hQTTekSWg9yCRp7D6lTQ/ARYq9CFH94L9+P7T7i1VIsnP0/s6tLZ1MFixk4zJeeERx2W2pyIuRW7/BuTcz28pDoPIcTwcSkkIwcJvRVoXsiw+kYwacHul02CICcjjb5J61QDWmlYl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpI9oj3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCCCC433C7;
	Wed, 14 Feb 2024 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707917817;
	bh=U1jCTNVJm15uvKPqEIOl7zNnBDnvU9eJTInfZRnMjpY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RpI9oj3pH60wKeJS9L1c/z/GRTOGh21Eo2XP7OkdTLPKd4DqMaUc9zXSHZjihCxws
	 do6KcZ3q5Q357CFcZke6B8iUdql2diJjM8eqI/Kceph3eOBV0tLvU9U3iaHhtB/mtz
	 cWISbARZeFxkvND5kwRI3bfBzA4os0nLNbmGnIJSa2Ba3dD9HGMiwKLPfndMaaQ3vy
	 WxwmSfGRUQ2gLdzEjbKNU2fRHILWK7hkT+8PGRYANV4RXUYl3oCAHXFQCYiFCu4KxD
	 oLEtmxCE+Up1gsidTkqcs/YexZkM7WTN3sGNCqM1Vj+64nr6ZPkwhQHfkmShtZvy4h
	 Ln9+3XYsa8/KA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511a4a1c497so846166e87.3;
        Wed, 14 Feb 2024 05:36:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfxzOGZgVJXjy8b31t0HKd1Vh/LM8VpbEXyggKeOp8kQgOPts4MzeeQojKQS+oBEl5QEn02+6fT2uJuF5UHdvI2QjnwA3Xyrlr3PwE
X-Gm-Message-State: AOJu0YzmRLZAPbUu66+CTZ0FrykXxlPKS+iViqJyyffjPahLMo7wHw2d
	ViPc2Z/tZEAW0nlM1xMovfBcNtGwF6E4M7iZhIqlwr7FyuTSO4dErMHll+gXwfFFIpbUtNlb0od
	MrMenIvyMvUoWL7v12CGERRoyGhU=
X-Google-Smtp-Source: AGHT+IEs7kLG4Up8jbrMGO9ULSn5VrRH09Ci/qay7A4pM/iUfUE8JmFShU2XEQ5jocXRJt2i6BUUDuZgu5QnGPzcbaE=
X-Received: by 2002:ac2:5631:0:b0:511:52b4:2fed with SMTP id
 b17-20020ac25631000000b0051152b42fedmr1838176lff.66.1707917816318; Wed, 14
 Feb 2024 05:36:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08693d17-f2a1-4b5e-a136-81138ca3a58d@oracle.com>
In-Reply-To: <08693d17-f2a1-4b5e-a136-81138ca3a58d@oracle.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 14 Feb 2024 22:36:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQjVjiUdXq3Wcuh14rW7q420J76Y8=AXNW8OHhYocCZ4w@mail.gmail.com>
Message-ID: <CAK7LNAQjVjiUdXq3Wcuh14rW7q420J76Y8=AXNW8OHhYocCZ4w@mail.gmail.com>
Subject: Re: srcversion hash does not cover all the module's source/dependency files
To: Radek Krejci <radek.krejci@oracle.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 6:43=E2=80=AFPM Radek Krejci <radek.krejci@oracle.c=
om> wrote:
>
> Hi,
> I've found a bug in modpost - when it gets the list of source files to
> generate srcversion hash, it skips all the source/dependency files
> except for the first one.
>
> There is patch [1] in v5.8rc1 replacing get_next_line() by get_line() in
> parse_source_file() function. Besides other things, the difference
> between those 2 functions is that get_next_line() trims the leading
> spaces of the line being returned. The issue is, that the source (deps_
> located at the same directory) file names in the list, being processed
> in parse_source_file(), are indented. So, when the code gets to
> "Terminate line at first space, to get rid of final ' \'", it
> effectively hides the source file name from further processing, since
> the first space is at the beginning of the line.
>
> I checked this behavior with modpost from v5.4 and v5.14 (and confirmed
> with the current master in git). In my case, my kernel module had just 2
> source files - mymodule.c and mymodule.h (both located at the same
> directory). With modpost from v5.4, the code change in any of the files
> was reflected in srcversion hash. But with modpost from v5.14 (and
> master) there is no hash change when the code change appears in the
> header file, which is listed at the end of the deps_ list. I believe
> this is quite simple to reproduce with any module, but if needed, I can
> prepare some example code to reproduce the issue.


Thanks. You are right.


> I noticed this [2] email thread in the list. It mentions a similar
> issue. However, since it happened a half year before the change [1] was
> introduced and because I was unable to find any further details,
> including the promised patch, I believe that these 2 things are unrelated=
.


Correct. They are different things.

Parsing the headers located in the same directory seems
to be a design.



> The enclosed patch worked for me, but there might be some other
> consequences that I've missed, so feel free to modify it on your own or
> let me know.
>
> Is there anything else I can do to help fixing this issue?


I think the attached patch is correct.
I will pick it up later.



One question is, is this feature still used?

I assume the answer is yes because you noticed this bug.
(but you are the first/only person who noticed it
in the past 3 years)






Thanks.




> Regards,
> Radek Krejci
>
>
> [1] -
> https://lore.kernel.org/linux-kbuild/20200601055731.3006266-26-masahiroy@=
kernel.org/
> [2] -
> https://lore.kernel.org/linux-kbuild/CAN19L9G-mFN-MTmw0FS3ZX4d1MjeoL2U+s-=
Fk7Qw9UYWn5Q1YA@mail.gmail.com/



--
Best Regards
Masahiro Yamada

