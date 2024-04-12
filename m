Return-Path: <linux-kernel+bounces-141982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DAE8A25BF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D77AB22760
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AF21BC23;
	Fri, 12 Apr 2024 05:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzjNtb/9"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B2D2F4A;
	Fri, 12 Apr 2024 05:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899974; cv=none; b=MMrFrf3oLzH++NAi5CNi+1i4EL2xeq2Z8rZebwshjuPUi3dSOyr1OVNVwIHwjJo/+AK4sYTlofDrN82ZNivf8FLgamHio4pZqBfG3W9ZPaB1jrPViMT4NxfkUwh2omymc9aa0NiGkc+txisoCAHOC71gXNJznBnZGUkWDPvpIJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899974; c=relaxed/simple;
	bh=LeNIrOB+CpAK7CxcmRCtZ/nGX+ykzuZDuTvsE5OrGig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAahegin/6LROLWBbEwbmt6ztltnrf3tIqhjQhMv87Vg3TCM2Pbg4O9wzaAJN0R4SiCGrjujH+iJixPn6hrvkLaiTWI8qMRKmKL+lg8XuV0Zi3Bf+uMUjU/sUyJE8Fq2xBTtVsL+lfR7S2FbyUyJnauN7tAEZmgwaqlpar6ROb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzjNtb/9; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-22f078f1aecso337090fac.3;
        Thu, 11 Apr 2024 22:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712899972; x=1713504772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fkZu08swlbXArXRtRYpF1By2zsiAltvNt7vYo8OheZo=;
        b=DzjNtb/9r8uBmn0XtLUUsSrtAlZpmgyBJMR3rFOp5wN0Hj4ujnG4chWNls8KkmnaQj
         yjoThp0+I+uJAIaXszJXxnQgm1Xs6DczuTqaFxLuZt4VTG6lHki8fvdHeTkZRcxXsDpV
         E/ERa9Qmzoqg8Z8QHRt1cXibtUFKMOyw5Ky+d7ewFFH1+Q1sBSenYc1lPgI58gaHXggQ
         eF2pJtQQaUDEmVUwIpt3jYX3NNCxCGqFbPWD8lnxmX+3c9BJw+vxuKDDm+ypSi/Fkl8w
         BFtgcTArdDmKGHJsSWf0LSndmF9Yad0NswOIBuTNGMGHrLfLvx/i/ea6nE3s47MdFb7k
         kQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712899972; x=1713504772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkZu08swlbXArXRtRYpF1By2zsiAltvNt7vYo8OheZo=;
        b=Wei5x8V+q2PzAvv0jBNHq66UcV/W3Ftwj6qKkcfpQZTWPGC+YnHokgqPp4v2Fq6aWA
         eNadqRoFrEc0KFplr/SCd9mm+RelvC7PjZDt42XezD0D3VDdCSJwxk1F4c+pw28vlSaP
         0Gm4OQwZRYhzKtzz5gYPa/ZseLdLAuAZIWGgBV5Esru4igBlOY5z8vXE7cbnILLAPnxL
         FGgBVorbew7hy27I8Rw0HCVOWM4P3SXPg4JoX2InvbtyEMErT15hm8PmftpL3It6oqoo
         v27EGenL4UMP0lAslAcvmd7DYh4a+FLs+tfwd5yWzSUSpLG37uhosBEyNsUdXqb89t83
         20Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUj4+ttmP1nZDb3uLgFWaDDUfLbP0jRjSpU76e4/F4KD7tA9zJvFMYO7Fyg1XV7DsDyb0fINsd5+P8LUOuBfB0zAQ7k1o0ggbBrd9ZdvQhB8cIvdl+blOgtcYqztagZkWjdBg65cz7qoNCxBxmnuAGJzVO/cMWM5neH9D1mvzNyoa8AIXToBWZQsoE=
X-Gm-Message-State: AOJu0YycGaaCK988cki+xlGGyEdNix++RimhcZjC+9I9Rj6sWTzKLA9P
	ddTzNevV5fmCd0OoaxOV1CuRiKphoGkD1xs82zbSTkHvPENZLsh29T3CBHMzwhLLS3a8+MjE/0m
	4i6bIODdbBN2W42F7A5py4NNE1Lo=
X-Google-Smtp-Source: AGHT+IF9dzD7iLtCdJgQlA0hmX0ZC0Y2NZnlWJhk8sfa1PdAr4szU8KjtOK7wGmL9qXZMMl5km6aDaJISu2aQjiKKz0=
X-Received: by 2002:a05:6870:611f:b0:22e:c4d1:4844 with SMTP id
 s31-20020a056870611f00b0022ec4d14844mr1666786oae.18.1712899972566; Thu, 11
 Apr 2024 22:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404071350.4242-1-linux.amoon@gmail.com> <20240404071350.4242-7-linux.amoon@gmail.com>
 <20240409015352.ocpjbgxrx636jmk4@synopsys.com> <CANAwSgQtfOG9FSygNMsNfgdmxsr-HyvyqaYr=UXE2UC_mxKJQA@mail.gmail.com>
 <20240410232623.6gaupt6t725hhype@synopsys.com> <CANAwSgS-oD86obNUHcjAwfD+3v6VyWidTezwtihJBOC8VWHPjg@mail.gmail.com>
 <20240411222145.rkjz3cfzudjfnkdt@synopsys.com>
In-Reply-To: <20240411222145.rkjz3cfzudjfnkdt@synopsys.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 12 Apr 2024 11:02:36 +0530
Message-ID: <CANAwSgQDGUzYO8+wAFonCo4zZZ5s94uDiHi+jLGK4EtULZaDXw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] usb: dwc3: exynos: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr()
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Johan Hovold <johan@kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Thinh,

On Fri, 12 Apr 2024 at 03:52, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
>
> On Thu, Apr 11, 2024, Anand Moon wrote:
> > Hi Thinh,
> >
> > On Thu, 11 Apr 2024 at 04:56, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
> > >
> > > On Wed, Apr 10, 2024, Anand Moon wrote:
> > > > Hi Thinh,
> > > >
> > > > On Tue, 9 Apr 2024 at 07:24, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
> > > > >
> > > > > On Thu, Apr 04, 2024, Anand Moon wrote:
> > > > > > Use the new PM macros for the suspend and resume functions to be
> > > > > > automatically dropped by the compiler when CONFIG_PM_SLEEP are disabled,
> > > > > > without having to use #ifdef guards. If CONFIG_PM_SLEEP unused,
> > > > > > they will simply be discarded by the compiler.
> > > > > >
> > > > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > > > ---
> > > > > > v2: add __maybe_unused to suspend/resume functions in case CONFIG_PM is
> > > > > >    disabled.
> > > > >
> > > > > The compiler discards the code, yet we still need __maybe_unused?
> > > > >
> > > > Earlier version had not added this since but I removed the
> > > > guard.CONFIG_PM_SLEEP.
> > > > added __maybe_unused just to safeguard the function.
> > > >
> > > > I have tried to build with config by disabling CONFIG_PM and CONFIG_PM_SLEEP
> > > > but could get the warning compilation by adding flag W=1
> > > > -Werror=unused-function.
> > > >
> > >
> > > <snip>
> > >
> > > >
> > > > But since these CONFIG_PM and CONFIG_PM_SLEEP cannot be disabled,
> > > > I am not getting any warning related to these functions.
> > > >
> > > > Do you want me to remove __maybe_unused ?
> > > >
> > >
> > > The warning was there as expected. You should to use it along with
> > > DEFINE_SIMPLE_DEV_PM_OPS(). Let me know if you still see the same
> > > warning.
> > >
> >
> > But the warnings are related to the following macros
> >
> > #define PTR_IF(cond, ptr) ((cond) ? (ptr) : NULL)
> >
> > #define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))
> > #define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
> >
> > So if we can disable CONFIG_PM and CONFIG_PM_SLEEP options
> > the relevant function with the above macro will be set to NULL.
> > in this case, the compiler will discard the function in SET_SYSTEM_SLEEP_PM_OPS
> >
>
> There are differences if you use SET_SYSTEM_SLEEP_PM_OPS vs the new
> macro. It's noted in this commit:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1a3c7bb088266fa2db017be299f91f1c1894c857
>
> Please try it out.

Thank you very much for this input

I will drop the __maybe_unused from my patch series.
and switch to use DEFINE_SIMPLE_DEV_PM_OPS macro
for suspend resume functions

>
> Thanks,
> Thinh

Thanks
-Anand

