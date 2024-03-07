Return-Path: <linux-kernel+bounces-94799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94858874560
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A326283568
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96FE4A28;
	Thu,  7 Mar 2024 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atOiC4YC"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F82F1879;
	Thu,  7 Mar 2024 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773107; cv=none; b=llKALxWZEuXFmtXzhuVcN5n3p/DzhFRCHsF521CqslgarS6lSQmZAZvCNzG6Jm/1z7Nj80EgkaZhNcn9L1cremBfWjcG+nyCihtGCsH6957Wmg5+tmsz8s1wf2enUOD5Ix635SHhmPV/A13N5VU9kRlfMpg36poG0YZ+cf+uwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773107; c=relaxed/simple;
	bh=kcrybf8ZhbcxqaAvPY50XSlMpT/BCUl5Chgg2NgPmw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mi2a8iAih8caHXeZEh81uZ0pM3vhA8BlWB7eYci2Xb2NtMP7nstNAkG8sU9IDmdIJPUmtFagOVaIK2VahWxd5haPnuWg+R2QQRc/Ebc7cSKRVzHMXTR3LY+R+VDwZNM6qm4urAVULbCmho2tqnxKr/qg+aT+hs/N84Q9o0qy4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atOiC4YC; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-364f794f237so1219695ab.1;
        Wed, 06 Mar 2024 16:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709773105; x=1710377905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOXetrYB7FG7uPFK9qD35tNyUTXHX53MKHAyDztq5IU=;
        b=atOiC4YCp5iQIf8ccWpi+RvhF9CuGIax0Jk5Bvj8IToXC/9e4lDgHHr0w2p9urtWfp
         UbDsKWcsJObyG1uCY2SdM3GDw4WjBuNBETyo1QdwBynYRyKhBLevuFQucPx2fzfPC7Wr
         utCJqClt1U/yQgaLK4jjiij4UKqLUAc0dDE5lvb2RgDJqDH89TT2CzEM/z8sye2QdAK3
         izF4Cod0kiFaXiaxQkX2gmTdRbpw2tOIQkuq/EDPyF8eSMynayiAdX/rTw81gYX1RqU6
         +4rDKW/XYHe/f8u9bowqT7Eujbt5C91/31eSPBa/WiE84gI8k3VYwzWfbVwrl2RZdUFU
         NEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709773105; x=1710377905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOXetrYB7FG7uPFK9qD35tNyUTXHX53MKHAyDztq5IU=;
        b=gAemivJzAYIn5tY5lb03AW5bKDzHPKHnNWQ/ycij3c3jxOzsrXwNkk5YIZ7lRWkr5p
         uWomOeSRMlodpl4Ud7GecozlfwElUir8mbAPtd7LqC9Gg+cLRk96OKCCAXtGNZmBZzOd
         xRvuqOXwxeh8ZeN33VyEE82mXxNrURCxlTuhv3wAi/ceqVjJBNXXjvZ2ETo159/i3ROi
         sfCH6d1A2jZwSFPVaxI77VAfHnnBIe9YfzeJ8TURYp4qlxBB+jq/55mvItpaIxVbXgUn
         es0ILTRZV6MxO+vw4gXbxsyfUu/HQd2CBC2iGrrmbbsvxnX2Jzwi3B3gR2vcPK8ISckr
         HwEw==
X-Forwarded-Encrypted: i=1; AJvYcCWhU6dS0jCyzeE2MIDeGSQPkcbEtNVKJXu8KzIGxM3/fe5JXqalajEbSAuwXtIRi2UaIv3M0CndtiXknKVnmebkP37H5TSpVZJacABYPUivTM0wd/+nid1rP0LcBXrqRGjbE1KRUWD8s539SiI0NgVp0ChJI/At37WFlovL6GgARVjPKEuZQwsFmxoWMTmG/oX05tgVJAvkUGHtTU4nHFBg
X-Gm-Message-State: AOJu0Yx5pXx66EM75nJjPyPU0cWoNpmX/9GXP7QZsRsE0EBtw5HCv81L
	gD8377kubMY4DXz2B9FcxWqJ7uk7Mo/E/HhTRjw0Mb6i7ya2NqFmCqnjmeZ+FtjnjXOEPhaGIan
	sYYVAAhqOBxaDkGHE1RC0XVSwoF8=
X-Google-Smtp-Source: AGHT+IG8PjRaZLt/Q5CiEttvyPNHeWicHW61mnLg89xliS1+pm55W9W/fIsDsAuZF8ItOHUpgqY7hQ7MZ2R9HfODMxs=
X-Received: by 2002:a05:6e02:19c8:b0:365:cac8:87a9 with SMTP id
 r8-20020a056e0219c800b00365cac887a9mr20930302ill.6.1709773105301; Wed, 06 Mar
 2024 16:58:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com> <20240227005606.1107203-4-kcfeng0@nuvoton.com>
 <62f38808-7d5f-4466-a65e-b6a64b2e7c01@molgen.mpg.de> <4b06d535-6739-47b5-ad1e-0ff94322620e@roeck-us.net>
 <e2b0b8e3-9b39-4621-9e43-d7de02286a27@molgen.mpg.de> <24ee4bf3-aa91-483d-a9be-5c47e5c37ed7@roeck-us.net>
 <35dcecdd-ee19-40d6-80ab-5eed9718e639@molgen.mpg.de>
In-Reply-To: <35dcecdd-ee19-40d6-80ab-5eed9718e639@molgen.mpg.de>
From: Ban Feng <baneric926@gmail.com>
Date: Thu, 7 Mar 2024 08:58:14 +0800
Message-ID: <CALz278a4zoje8ZL5REY==fGmowO5EJnRT8rGXaDnSvDK+aROdg@mail.gmail.com>
Subject: Re: Commit messages (was: [PATCH v4 3/3] hwmon: Driver for Nuvoton NCT7363Y)
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, kcfeng0@nuvoton.com, 
	kwliu@nuvoton.com, openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com, 
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul and Guenter,

Appreciate your valuable comments, and I'll add some commit messages
to describe this chip for pwm and fan.

Thanks,
Ban

On Thu, Feb 29, 2024 at 12:25=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Guenter,
>
>
> Thank you for your reply.
>
> Am 28.02.24 um 17:03 schrieb Guenter Roeck:
> > On 2/28/24 03:03, Paul Menzel wrote:
>
> >> Am 28.02.24 um 10:03 schrieb Guenter Roeck:
> >>> On 2/27/24 23:57, Paul Menzel wrote:
> >>
> >>>> Am 27.02.24 um 01:56 schrieb baneric926@gmail.com:
> >>>>> From: Ban Feng <kcfeng0@nuvoton.com>
> >>>>>
> >>>>> NCT7363Y is an I2C based hardware monitoring chip from Nuvoton.
> >>>>
> >>>> Please reference the datasheet.
> >>>
> >>> Note that something like
> >>>
> >>> Datasheet: Available from Nuvoton upon request
> >>>
> >>> is quite common for hardware monitoring chips and acceptable.
> >>
> >> Yes, it would be nice to document it though. (And finally for vendors
> >> to just make them available for download.)
> >
> > Nuvoton is nice enough and commonly makes datasheets available on reque=
st.
> > The only exception I have seen so far is where they were forced into an=
 NDA
> > by a large chip and board vendor, which prevented them from publishing =
a
> > specific datasheet.
>
> Nice, that they are better in this regard than others.
>
> > Others are much worse. Many PMIC vendors don't publish their datasheets=
 at
> > all, and sometimes chips don't even officially exist (notorious for chi=
ps
> > intended for the automotive market). Just look at the whole discussion
> > around MAX31335.
> >
> > Anyway, there are lots of examples in Documentation/hwmon/. I don't see
> > the need to add further documentation, and I specifically don't want to
> > make it official that "Datasheet not public" is acceptable as well.
> > We really don't have a choice unless we want to exclude a whole class
> > of chips from the kernel, but that doesn't make it better.
>
> I know folks figure it out eventually, but I found it helpful to have
> the datesheet name in the commit message to know what to search for, ask
> for, or in case of difference between datasheet revision what to compare
> against.
>
> >>>> Could you please give a high level description of the driver design?
> >>>
> >>> Can you be more specific ? I didn't have time yet to look into detail=
s,
> >>> but at first glance this looks like a standard hardware monitoring
> >>> driver.
> >>> One could argue that the high level design of such drivers is describ=
ed
> >>> in Documentation/hwmon/hwmon-kernel-api.rst.
> >>>
> >>> I don't usually ask for a additional design information for hwmon dri=
vers
> >>> unless some chip interaction is unusual and needs to be explained,
> >>> and then I prefer to have it explained in the code. Given that, I am
> >>> quite curious and would like to understand what you are looking for.
> >> For a 10+ lines commit, in my opinion the commit message should say
> >> something about the implementation. Even it is just, as you wrote, a
> >> note, that it follows the standard design.
> >
> > Again, I have not looked into the submission, but usually we ask for th=
at
> > to be documented in Documentation/hwmon/. I find that much better than
> > a soon-to-be-forgotten commit message. I don't mind something like
> > "The NCT7363Y is a fan controller with up to 16 independent fan input
> >   monitors and up to 16 independent PWM outputs. It also supports up
> >   to 16 GPIO pins"
> > or in other words a description of the chip, not the implementation.
> > That a driver hwmon driver uses the hardware monitoring API seems to be
> > obvious to me, so I don't see the value of adding it to the commit
> > description. I would not mind having something there, but I don't
> > see it as mandatory.
> >
> > On the  other side, granted, that is just _my_ personal opinion.
> > Do we have a common guideline for what exactly should be in commit
> > descriptions for driver submissions ? I guess I should look that up.
>
> `Documentation/hwmon/submitting-patches.rst` refers to
> `Documentation/process/submitting-patches.rst`, and there *Describe your
> changes* seems to have been written for documenting bug fixes or
> enhancements and not new additions. It for example contains:
>
> > Once the problem is established, describe what you are actually doing
> > about it in technical detail.  It's important to describe the change
> > in plain English for the reviewer to verify that the code is behaving
> > as you intend it to.
>
> I agree with your description, but I am also convinced if you write 500
> lines of code, that you can write ten lines of commit messages giving a
> broad overview. In this case, saying that it follows the standard driver
> model would be good enough for me.
>
> Also, at least for me, often having to bisect stuff and using `git
> blame` to look at old commits, commit messages are very valuable to me,
> and not =E2=80=9Cforgotten=E2=80=9D. ;-)
>
>
> Kind regards,
>
> Paul

