Return-Path: <linux-kernel+bounces-96413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 916CE875BC4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41180283448
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB94021373;
	Fri,  8 Mar 2024 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOv3JZAD"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600F24C9D;
	Fri,  8 Mar 2024 01:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709859922; cv=none; b=caYm1MdhvfZmKz11osFi3zO6BFK4hoX/bgZ5SNAQjkoRFMh2PZn+USrZ9OJs0eUs9cAugwslEEgWoMVMjgk0BEA0fWIAbMychcHhGh1jfUT7kyo227AgQ3bR5V1EhuQ/3/X2JSemWH9voAjqvcxserNC2DxxUS568vJysvdo7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709859922; c=relaxed/simple;
	bh=R0bSqRYD6CzViChjj8q9dPrtFPv2SnH5d4dyapK11OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvVANlfPp4q2w1oDJ5Uvkt9Yic9Y+tvRJA0BD1zGCTLX/AQ6RcEm+HqA3Qvyu/xA4eQzbaerLfQshP9iod/0f9TOSRU473vjzR1CVDP5jbMG31FdDcktUODp70sp2tICt6ZiwAtD/Gvu/7mKsurqJjI6yhK6JNqTR71l8A57qTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOv3JZAD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28a6cef709so49035566b.1;
        Thu, 07 Mar 2024 17:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709859918; x=1710464718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aU3czmwuDCtSc1/Mjq6RqOTSd9iBxR4nbUu5GcbsrY=;
        b=MOv3JZADAJeCbmprVEaxtWFJFxRk+iVI5YrU94nuhcfXXIamfF8kt0ff2ScdFbKwDs
         z7xkJdQpy3iXxQe73+82FP37n+LDa11R0C3wClxKOzoxUZPhFyHOcGcpEuozbDk5cG11
         1+LcVOduuhnQAf313Cx5PUQ0sCpcOUCiwwxTB3hiwsHn4hD6WweoAx/s5Ewk2qukLTYA
         r/0fdvdDg4c4ZUJ/LxuNiqzf+imrGkZMmK2hod/i1H7U8dOU5cLp/UatZqugGIHOP451
         OpaBegjN2H1E0KxTKRHhmlyK7cQcT/wj4HGbI5B5ewqBVjWHMoBA1u6+oLyXN3i26uIc
         CmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709859918; x=1710464718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aU3czmwuDCtSc1/Mjq6RqOTSd9iBxR4nbUu5GcbsrY=;
        b=Jw9APqJ83LD9zv2rLV47OE6CYgV62zHLV6hx4IvAwrRd6rA88CpeSNtwIbTJjC84rT
         +lwas+1UNULGvSu/4swUj3uPpN/kWbuMWrD3e+Zkosxk1Nu+Db/XxEfMejsEld98nu23
         X8X0c0Ys3lkh20l+gVFoRsV4hn0t9B87Zrf31Ewf5QaMWgmNYe1JFO7lakBGd6h/ywJ1
         /xsFQfIa4JaTQZAwDVe9oPqBuhavXb/CxVB+LnFdbwGPnYPiUVZJdkglgpZoHJrhFn7c
         ZH9grimWFyoINGW65JqiKw8ueEZ+oDDsruSEVI1IDBU/auTWb31SNc5VRQq8yfkknvK/
         kHiw==
X-Forwarded-Encrypted: i=1; AJvYcCXUJZml+h+rEuiUkncMVdHTKMrd1YoeI23doJSjjA/M/eYpBiuUfeDHzMkqVCrCWtq8BybtNh+HaALfCldDA1s2AazX6X0RpMFT/OM0MKH0xFSXvticgGod8o3OFTn+hLtH4S5XXg69ZeZlWIw=
X-Gm-Message-State: AOJu0YyaY0H4yInNgkpbH2C3gSZs8WsurATn2z5P26HtAkm4AAIcnJcN
	alER2UL3p5uxeIEo3VoNWf//YXBrk3eZnATWbJjc5Ib4+QgdZv0l+0sXzHBtLDS1JO3NBF9j+Wp
	ldl17E/r5q6HQgeKc6W5NNVXRcMx6sxzez0g=
X-Google-Smtp-Source: AGHT+IGNtxRg7ePxc4wfucfqFxf1H0corq4iPDOgs14LkueKkdWRt27Kwju2LN+bFwCya/G3fJiqd1SgE4hWv908Mh0=
X-Received: by 2002:a17:906:b014:b0:a44:c6b4:ee4b with SMTP id
 v20-20020a170906b01400b00a44c6b4ee4bmr12221668ejy.25.1709859918403; Thu, 07
 Mar 2024 17:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307223849.13d5b58b@barney> <20240307232927.171197-1-rand.sec96@gmail.com>
In-Reply-To: <20240307232927.171197-1-rand.sec96@gmail.com>
From: James Dutton <james.dutton@gmail.com>
Date: Fri, 8 Mar 2024 01:04:41 +0000
Message-ID: <CAAMvbhE53upfqfB=afJK9YAZUWFTBN8ripae0W+PUUXdwj4-kw@mail.gmail.com>
Subject: Re: [PATCH v3] ssb: Fix potential NULL pointer dereference in ssb_device_uevent
To: Rand Deeb <rand.sec96@gmail.com>
Cc: m@bues.ch, deeb.rand@confident.ru, jonas.gorski@gmail.com, 
	khoroshilov@ispras.ru, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org, 
	voskresenski.stanislav@confident.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Mar 2024 at 23:29, Rand Deeb <rand.sec96@gmail.com> wrote:
>
>
> On Fri, Mar 8, 2024 at 12:39=E2=80=AFAM Michael B=C3=BCsch <m@bues.ch> wr=
ote:
>
> > The point is that leaving them in is defensive programming against futu=
re changes
> > or against possible misunderstandings of the situation.
>
> Dear Michael, I understand your point. It's essential to consider defensi=
ve
> programming principles to anticipate and mitigate potential issues in the
> future. However, it's also crucial to strike a balance and not overburden
> every function with excessive checks. It's about adopting a mindset of
> anticipating potential problems while also maintaining code clarity and
> efficiency.
>
> > > I understand and respect your point of view as software engineer but =
it's a
> > > matter of design problems which is not our case here.
> >
> > No, it very well is.
>
> I'm talking about your phrase "Not having these checks is a big part of w=
hy
> security sucks in today's software."
> I think it's a matter of design problem, when you don't have a good desig=
n
> of course you'll need to add so many checks everywhere.
> Let me explain my point of view by example,
>
> // Good design

Note: I am not so sure that this is Good design.

> CHECK(x){
>         if x !=3D null && x is a number
>                 return true;
>         else return false;
> }
> MULTIPLY(a, b){
>         return a*b;
> }
> SUM(a, b){
>         return a+b;
> }
> ....
> MAIN(){
>         // input a, b
>         CHECK(a);
>         CHECK(b);
>         // now do the operations
>         SUM(a, b)
>         MULTIPLY(a, b)
> }
>
> // Bad design
> SUM(x, y){
>         if x !=3D null && x is a number
>                 return x+y;
> }
> MULTIPLY(x, y){
>         if x !=3D null && x is a number
>                 return x*y;
> }
> ...
>

The reason it is probably not a good design is what comes later.
Another developer comes along and says I see a nice SUM(a, b);
function that I would like to re-use in my new function I am adding.
But that new developer introduces a bug whereby they have implemented
their CHECK(a) wrongly which results in SUM(a, b) now being a security
exploit point because of some very subtle bug in CHECK(a) that no one
noticed initially.
After a while, we might have ten functions that all re-use SUM(a, b)
at which point it becomes too time consuming for someone to check all
ten functions don't have bugs in their CHECK(a) steps.
It is always easier for the safety checks to be done as close as
possible to the potential exploit point (e.g. NULL pointer
dereference) so that it catches all future cases of re-use of the
function.
For example, there exist today zero day exploits in the Linux wireless
code that is due to the absence of these checks being done at the
exploit point.
The biggest problem with all this, is if I sutily (without wishing to
give away that it is to fix a zero day exploit) submitted a patch to
do an extra check in SUM(a, b) that I know prevents a zero day
exploit, my patch would be rejected.

