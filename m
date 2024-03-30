Return-Path: <linux-kernel+bounces-125622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AB88929C1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C65C28337C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 08:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C251B66B;
	Sat, 30 Mar 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXjGklLv"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A701C0DE5;
	Sat, 30 Mar 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788328; cv=none; b=hy2EJtultiHA2uprxClpuyL5vkrt41hd3n58CjdMQLibHZXsvMRchd8JII5YE7RX5qMM7I5Cr0riNKCHP2sLnYzIt/9Z9J+ngG5d7HYy7VBYIeGGVN7C3oRam+OqMLbrAPLS+Prx/zKn8nQknTXKwgZydGVJBVlMJNd2jojHsdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788328; c=relaxed/simple;
	bh=TSaZGxrHrCgTXiI9MawX9SQ+wZmZXIIq6Npzi1mEsok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTFIdGHjwd3USwM7c1M7mT4vPdw4l9NOKiRNEYLE0JXotMqljeMBWiDJmAdA6FLAnK8SscYadE3xks8mv3lwSpVRJDAjW5Qz++oDw8bB/iiSlidhkvtQyw1DKQCpfqm6szIYfCjGnIXCiSirpbotfnuo4dFJygsk0aYFcAbrAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXjGklLv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a469dffbdfeso99241066b.0;
        Sat, 30 Mar 2024 01:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711788325; x=1712393125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3TYUZ32mQOVXpT3ypAywszB693VhtWtaKsJE+/46ZY=;
        b=eXjGklLv+M9nfBcN/oivUx3CpC6f+nBZGMVLSnBD6gX0hbWDoKS5Sji/Zer3mAEeP5
         a6Su5nDYf2nCiqzyQdfWY+Lg5beNxhKUEHPBqKVgLUMjNOq1L5kg4NnSl9iKDGQ1NMzT
         qGx5PDLEWDfbOwelyybIUxRNVG7uHzc+CGe0Uw2ghKpSwDUdpzo3Be6usBxNMdcmJQ21
         OjYxMGC1zjyBOCwEGpOwLC9i+AoR8yZTtnR2LqwLFqE648SDwuqsQwZwrrJK0dg4y9XL
         FiYr3Dh/5XUqCjMXrsmh9s2H8qJjKqrM/33w/TLAhFrLvneyngWPGEm+8TEaMnGhRcN7
         Mlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711788325; x=1712393125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3TYUZ32mQOVXpT3ypAywszB693VhtWtaKsJE+/46ZY=;
        b=uZLMC5svLg3mNI1NrgB4DATXctJPIhbhFHIThsZzAT9/wxOz73kK66g0aeN+s6P7R1
         DngMfRpqo9Ah42sxHtCKHScdmaRLEVJ3IPRZpvLwMeScYC87VrNgi2jUrMJnew4qzdoJ
         LngHtxXzsN8xXXIIU25kaAatvj3ueNlikJ/ft+MFzCU5Qub9F2u85lGhL6FHJQiJRlrD
         cwen5bND8vCetAqyTtwft3Upcu8HY0RrnKhRLhBQ8qaemFXZnaYUZWUQ8vcBZOWTaPXF
         xGw/KtbJcZ5VAu4TDNKNKja1vUtL3d7wbIjLtxveNiDWUd/RgpKxOS2uUo05AArSxclr
         +7/A==
X-Forwarded-Encrypted: i=1; AJvYcCUNn0eDXOZPAEFNoWQR13kFHZWnql5YsGmXPC5NzX81yUsAV0OqksOYxye+me7xKz8X56oe5hGuUasaNBZ8xqtz9VvYfL5P9tjHa9DQ2uaClVYtSO4ea7fai9c/67xi3NGJqJk3s56Bh08=
X-Gm-Message-State: AOJu0Yw9Dv6VIrhpTqBMfgd8cUbNOfAtXPybizMLLziB6TNNSU2FSGre
	+L6c2RUDgf3XsCO9zUyWqQyyH3lzDoRRhZUgy9j+zgoWpnHy41b764ZSJvl9a66KyaRuXUcOQYV
	ABLMjyKyp7iaXvtbZg5qFxKiXAn65cDI1dWV3H6my
X-Google-Smtp-Source: AGHT+IGS2iyq4eBMdSFiU0V1nXZG2AqD4DW6knNPt4IyLyi80S0q7E5TKlK3w1CaBJFL8Qhe9bORA+K6edTkN3/gmEY=
X-Received: by 2002:a17:907:1b12:b0:a47:52fe:ef5 with SMTP id
 mp18-20020a1709071b1200b00a4752fe0ef5mr3222720ejc.0.1711788325231; Sat, 30
 Mar 2024 01:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329091245.135216-1-richard120310@gmail.com>
 <848d1259-ff6e-4732-b840-a02a5e5fe2cb@acm.org> <be8e14ec-3d46-4d67-88b0-f3dbf7ff22b2@kernel.dk>
 <CAH5jb=btggiO7Op+k2pTS8LyjcZ0tYpvtWJRmQ8sApD-fHyHXg@mail.gmail.com>
In-Reply-To: <CAH5jb=btggiO7Op+k2pTS8LyjcZ0tYpvtWJRmQ8sApD-fHyHXg@mail.gmail.com>
From: I Hsin Cheng <richard120310@gmail.com>
Date: Sat, 30 Mar 2024 16:45:13 +0800
Message-ID: <CAH5jb=bptDp43mLJ7A3nZuBnDB=V_wjLa3XqCSfsG8sC0OoFyg@mail.gmail.com>
Subject: Re: [PATCH] blk-wbt: Speed up integer square root in rwb_arm_timer
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, akpm@linux-foundation.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Ching-Chun (Jim) Huang" <jserv@ccns.ncku.edu.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The last email didn't follow the plain-text format, I'm sorry for that,
 that's why I resend it. Sorry for the bother.

>> Additionally, why to add a second
>> implementation of int_sqrt() instead of replacing the int_sqrt()
>> implementation in lib/math/int_sqrt.c?

I was thinking about adding an alternative option first rather than
replace the whole int_sqrt() function which is used in many other
parts in the Linux kernel.

>> Since int_sqrt() does not use divisions and since int_fastsqrt() uses
>> divisions, can all CPUs supported by the Linux kernel divide numbers as
>> quickly as the CPU mentioned above?

You're right about that. Thanks for pointing out the problem, I'll try to
replace the divisions maybe with another kind of approximation method.

> The claim that it is floor(sqrt(val)) is not true.
> Trivial example:
>
> 1005117225
>         sqrt()          31703.58
>         int_sqrt()      30703
>         int_fastsqrt()  30821

Thanks for pointing out the problem, I only compare my method with int_sqrt=
()
and plot the result using gnuplot, the result shown that they gave
very very close
answers, but I didn't count the error based on the integer part of
sqrt(), which is
indeed necessary. Sorry for this part. I'll check on the precision of my me=
thod
again.

Thanks for your patience and time on reviewing my patch.


Best Regards,

I Hsin Cheng.


On Sat, Mar 30, 2024 at 4:29=E2=80=AFPM =E9=84=AD=E4=BB=A5=E6=96=B0 <richar=
d120310@gmail.com> wrote:
>
> >> Additionally, why to add a second
> >> implementation of int_sqrt() instead of replacing the int_sqrt()
> >> implementation in lib/math/int_sqrt.c?
>
> I was thinking about adding an alternative option first rather than
> replace the whole int_sqrt() function which is used in many other
> parts in the Linux kernel.
>
> >> Since int_sqrt() does not use divisions and since int_fastsqrt() uses
> >> divisions, can all CPUs supported by the Linux kernel divide numbers a=
s
> >> quickly as the CPU mentioned above?
>
> You're right about that. Thanks for pointing out the problem, I'll try to
> replace the divisions maybe with another kind of approximation method.
>
> > The claim that it is floor(sqrt(val)) is not true.
> > Trivial example:
> >
> > 1005117225
> >         sqrt()          31703.58
> >         int_sqrt()      30703
> >         int_fastsqrt()  30821
>
> Thanks for pointing out the problem, I only compare my method with int_sq=
rt()
>  and plot the result using gnuplot, the result shown that they gave very =
very close
> answers, but I didn't count the error based on the integer part of sqrt()=
, which is
> indeed necessary. Sorry for this part. I'll check on the precision of my =
method
> again.
>
> Thanks for your patience and time on reviewing my patch.
>
> Best Regards,
>
> I Hsin Cheng.
>
> Jens Axboe <axboe@kernel.dk> =E6=96=BC 2024=E5=B9=B43=E6=9C=8830=E6=97=A5=
 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=883:12=E5=AF=AB=E9=81=93=EF=BC=9A
>>
>> On 3/29/24 12:15 PM, Bart Van Assche wrote:
>> > On 3/29/24 2:12 AM, I Hsin Cheng wrote:
>> >> As the result shown, the origin version of integer square root, which=
 is
>> >> "int_sqrt" takes 35.37 msec task-clock, 1,2181,3348 cycles, 1,6095,36=
65
>> >> instructions, 2551,2990 branches and causes 1,0616 branch-misses.
>> >>
>> >> At the same time, the variant version of integer square root, which i=
s
>> >> "int_fastsqrt" takes 33.96 msec task-clock, 1,1645,7487 cyclces,
>> >> 5621,0086 instructions, 321,0409 branches and causes 2407 branch-miss=
es.
>> >> We can clearly see that "int_fastsqrt" performs faster and better res=
ult
>> >> so it's indeed a faster invariant of integer square root.
>> >
>> > I'm not sure that a 4% performance improvement is sufficient to
>> > replace the int_sqrt() implementation. Additionally, why to add a
>> > second implementation of int_sqrt() instead of replacing the
>> > int_sqrt() implementation in lib/math/int_sqrt.c?
>>
>> That's the real question imho - if provides the same numbers and is
>> faster, why have two?
>>
>> I ran a quick test because I was curious, and the precision is
>> definitely worse. The claim that it is floor(sqrt(val)) is not true.
>> Trivial example:
>>
>> 1005117225
>>         sqrt()          31703.58
>>         int_sqrt()      30703
>>         int_fastsqrt()  30821
>>
>> whether this matters, probably not, but then again it's hard to care
>> about a slow path sqrt calculation. I'd certainly err on the side of
>> precision for that.
>>
>> --
>> Jens Axboe
>>

