Return-Path: <linux-kernel+bounces-103981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6E587C765
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED911F22327
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329346FDC;
	Fri, 15 Mar 2024 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLvCbVFF"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A0612E;
	Fri, 15 Mar 2024 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710468808; cv=none; b=N9S/psIVH3xmhZvDR5shSK4qy6pZJTxUU2+NG7K0lEfCxB/4bPhM793WUEl/P+sVX1s04NiRVWC3uGojwxNacPvBzPoBUK5OlwhHQbjFX8+9zY13DxliM4z2zf1r0qJ5ScfrRNF+cthunNeZv6+vdPrzpP4jobi0eWeP9KrzyXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710468808; c=relaxed/simple;
	bh=O+6LRgrygCLtpBhSXzeqgj58h+eqfO4WTTCABl9R9Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTa/m5KbfEsFUz7Pht0OyXbDsSgg558cSNpRW8t0ikiz1sXFxTQzPS+27jeQWACFmrL1+Y1Mp9CZ4u1WE5jhBgLpKGRlB/8zpFPKUV38YJBS7Z+yEreCLrDnHz0gwxya5/ENv2rrGc7P4wN5gQi/C+o4Ucjf1REYLBr/YxVD7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLvCbVFF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6cadfffdbso1344854b3a.3;
        Thu, 14 Mar 2024 19:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710468806; x=1711073606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0CUgvuk9nZtOPbyPCqCebRGxrj95mz6Zh4Ge/V1jUso=;
        b=nLvCbVFFnHytCNqHZwP2Co5q9hrn+T2PUQyc8uWSXRsQF9wnRHG4lWIbae9sYTPm6T
         aN4CEXlmyUB6m43pxuoMgmoN/m8Btv0NHoRQqyktxahBSm3Jb+0uifOUWJMHlPH3oW+T
         LomCfZMU9Rm7VSdVddJOzeJMa/OSd2BielzG34awJGHffi4/kjIfFiXNpOWfahBqLD24
         dmAA0VogsW/Q2eLGRCc1s9xqy4J+2mN9q8ZmOHlL67uVvHajIUJaWIlCfx6pDpS6JaU7
         qRRBKgWTc0Wzsnz/i9ZBY6ocjtLPuMSag5QFbexD6thZAx3+fCRo54+OAKUIW08HFkKW
         O8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710468806; x=1711073606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CUgvuk9nZtOPbyPCqCebRGxrj95mz6Zh4Ge/V1jUso=;
        b=Zwh+7Nmm6kR9EfFeMXST2pHcvGcgN20TLQzX75Q1U5qj+or67akv7vDc7YZQGr9AgU
         kIIQaxIHhz/FoCJ3FgiLRBJcNPJbePu1O6Xro4/HWaiiV1vSj2zDlNH/q1JjQyI1LDgX
         8UaWHCcOe+i4bPUhsnCVHGlVCxW+45WyZGroAW+Iw4ZIyHAe/wmr/7Jj9rYA7uaPjVnQ
         sQOMFlvGbnLlUjybvlAvozH6+oF16JioIARGJP4EGuJG6inhYGazK8cQ8n0kdSydmABT
         LlE9yUzgi+sS4FWHlZRVK+44taLe9XoiPUrta2lHKXngXM0/IaXIuV4gmdAn+e889FQ9
         DYPw==
X-Forwarded-Encrypted: i=1; AJvYcCWAnIDsy5MR468RQFR182gtho9Bd6gufpNu4eMFqTYq5BdgxRD83Hmq7XymlM26NLTEtUGkZsO5hSOZyHwisPbTUCAx9XSHeLamjT/cyXittU4hjF1FBH3jmmxq4sFCEnHFUizH
X-Gm-Message-State: AOJu0Yz5xAw2XYMvmA0ck+LXz0RtZ3er1tKpYLQvI9oBy8uP+iIqNyIu
	v1fEnn0+DUF67oDMQ2/MyFi92Cc5N/MsnHf2cRfuiTEXLc2PigLtJ0XS6lW83ooAf87Y1kHqC+Y
	rDekACX6jnkE0Ye2CYuy3eZMQImc=
X-Google-Smtp-Source: AGHT+IGmbW/BLJZ8f4JUoptDSCtQhmRn5DRAzlFWW1ZjYGY7eQpPKSC5mh1xcAS2cU30j6JimmpdvVd+jArLNXBedNs=
X-Received: by 2002:a05:6a20:43a9:b0:1a3:4721:e02a with SMTP id
 i41-20020a056a2043a900b001a34721e02amr2252087pzl.34.1710468806534; Thu, 14
 Mar 2024 19:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ef6a91ac20d8441bad9956c15caaafef@qianxin.com> <CALm+0cW8HutqzcrfxysLWoOVyzh70RT3G0gaALRbnS=8Lw2f=g@mail.gmail.com>
 <87frwtm7ws.ffs@tglx>
In-Reply-To: <87frwtm7ws.ffs@tglx>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Fri, 15 Mar 2024 10:13:15 +0800
Message-ID: <CALm+0cVFRp=jZduv2DVhirvLQQrd+MLts0NsC8GJzkSnAsYrog@mail.gmail.com>
Subject: Re: memory leak in posix_clock_open
To: Thomas Gleixner <tglx@linutronix.de>
Cc: =?UTF-8?B?5p+z6I+B5bOw?= <liujingfeng@qianxin.com>, 
	"richardcochran@gmail.com" <richardcochran@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>, "secalert@redhat.com" <secalert@redhat.com>
Content-Type: text/plain; charset="UTF-8"

>
> On Mon, Mar 11 2024 at 17:46, Z qiang wrote:
> >
> > diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
> > index 9de66bbbb3d1..71d9d8c394fa 100644
> > --- a/kernel/time/posix-clock.c
> > +++ b/kernel/time/posix-clock.c
> > @@ -137,6 +137,8 @@ static int posix_clock_open(struct inode *inode,
> > struct file *fp)
> >
> >         if (!err) {
> >                 get_device(clk->dev);
> > +       } else {
> > +               kfree(pccontext);
> >         }
> >  out:
> >         up_read(&clk->rwsem);
>
> Looks about right. Can you please send a proper patch?

I will send a patch.

Thanks,
Zqiang

