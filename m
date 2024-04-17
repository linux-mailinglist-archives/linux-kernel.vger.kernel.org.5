Return-Path: <linux-kernel+bounces-148007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6298A7C88
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E49C9B21A50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D283A65BA8;
	Wed, 17 Apr 2024 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b="GFG2I0q7"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC8D394
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 06:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336532; cv=none; b=JKJ9AsIWK3vltMQaVgQUcCF68JyiMy5JoBHgvk9Qyng5IFEmXYH690HDhKfXYbXfXr0Tr79+7GeIpY5vJspvyKkPqOTRaVVc45bhAzTXetEZABYsnAe0Rxc+AqZG4A+KS/MLf1XmHmGDLdbQ6qhOMM+K8YNdJBEtqKZPQEAI5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336532; c=relaxed/simple;
	bh=8GdD1N+kL+Txs2fR62xmamHs4atP+AS/1YrbyOjH9XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1c3qZxGu4rCtzLDJa9Fp4B7qM11pLmAoZO7T5hKZpcpXS/M6X8OCMYRT8oKi8M8Y28cld2a6FdddIsLkmbDIZdNvM09U8q2PWg9V7cDyddAtM2TKpZPix0fEF51Ypy9InbcI5Z1VIj5RZlPgEVREZxbeU3qgKlWSoDi2W5tH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro; spf=pass smtp.mailfrom=shruggie.ro; dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b=GFG2I0q7; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shruggie.ro
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5194cebd6caso227940e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20230601.gappssmtp.com; s=20230601; t=1713336527; x=1713941327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GdD1N+kL+Txs2fR62xmamHs4atP+AS/1YrbyOjH9XU=;
        b=GFG2I0q76lEDzP8gzQO5K3lFcYJpKA4n7HsUPL7fA+NKaax4/BiQLG9lxgNGU8VQj1
         vGdzrB+PaF1vc356ZyfVsxeiAl3Eah83W2BcHDIRfyLgqkoPLe2dw6jle9ZXwvkTgVIh
         d3cyTZLAA53xxCaWRLAHhYGuxT8IJuReEaHcJyxLhVapOap5PRZCn6ySixf/02KcIUnn
         DXdCcMRHPv/eLUTfnN1Ktalpb7+/gLA068Nkqyjc4tNHqFnONsSNC4Oybc6CCstQh6//
         uZtHnFPPvWu9DHafjHw8vwWpb/FfkdGeN5SBHXYvlQT3FJ+aT1Oya8rNzNUvKmb0TKWc
         wgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713336527; x=1713941327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GdD1N+kL+Txs2fR62xmamHs4atP+AS/1YrbyOjH9XU=;
        b=RNT3ZfEx6p2N4RwIAQcWkhlJks+nmZUatsZZUz48PVLXHAVGolYUhNOBSrV2yVBsrX
         9ox+UmoA2ZJtqu4x+bpHxIOAUtIdUr6chJPtN7teG4NaAcx8spR2y0BEKI8mWh1OATrP
         BrmVyC6mbixEPRauJVuEhAS+i3et1x3oIOFMZSXLKSAfbnBUj2auUWqw5G4L3JtNnMhc
         A2/Til5vKBGvX3HXiYXHRjBBh7dc3d79HRLcaIUcfmtvfJ3udgUtCV8Vw8qhEjqAXSxm
         3ev90130SVsONyx4oR+Gq81v+AjVRmj7cGNQltu7iqgsmIUyFak4KocTEkKFORJlSmwc
         7T5Q==
X-Gm-Message-State: AOJu0YypzMjCtTXP8+tdQI1PmpUtdxhJhrQrDCQOut5Q7ODdpkKaP+tm
	h3lUO/cuYwNHt6mFqDPbTJtcsl0nWNyTObnEqiSLGiwF00bm9buSjlxOQSz6lbdrcm2AAz9LTga
	WG5kL8X+BdhpG28BnfOpemcmKOMFigqgF3rS/6g==
X-Google-Smtp-Source: AGHT+IELKwZURXxT6BzF+klrUUBwR99xlItfoxcCvrRVeeNi5J6r7J+VMpXsyCHSfWJEcHe5m5fOsWmif33f2yBisH0=
X-Received: by 2002:ac2:464a:0:b0:518:9950:9079 with SMTP id
 s10-20020ac2464a000000b0051899509079mr8518848lfo.2.1713336527056; Tue, 16 Apr
 2024 23:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230516122202.954313-1-alex@shruggie.ro> <CAH3L5QoBqSOBHhoxSrYw6U34gqTPEhi_RB_Cve-YmBzYj3LXAQ@mail.gmail.com>
 <CAH3L5QqZ61H9Fk24R4K3vNdpmvBjnxHaxH7CRTT5Fa3tbot_hg@mail.gmail.com> <xhsmho7ajanb5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmho7ajanb5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Wed, 17 Apr 2024 09:48:36 +0300
Message-ID: <CAH3L5Qr9Lmju1nXk-+O8d9Hj0r0WyLP-grrbaY6HfQx_Ga_KMw@mail.gmail.com>
Subject: Re: [PATCH][V2] sched/rt: Print curr when RT throttling activated
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	tian.xianting@h3c.com, steffen.aschbacher@stihl.de, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 6:25=E2=80=AFPM Valentin Schneider <vschneid@redhat.=
com> wrote:
>
> On 01/04/24 18:47, Alexandru Ardelean wrote:
> > On Thu, Jul 13, 2023 at 11:07=E2=80=AFPM Alexandru Ardelean <alex@shrug=
gie.ro> wrote:
> >>
> >> On Tue, May 16, 2023 at 3:22=E2=80=AFPM Alexandru Ardelean <alex@shrug=
gie.ro> wrote:
> >> >
> >> > From: Xianting Tian <tian.xianting@h3c.com>
> >> >
> >> > We may meet the issue, that one RT thread occupied the cpu by 950ms/=
1s,
> >> > The RT thread maybe is a business thread or other unknown thread.
> >> >
> >> > Currently, it only outputs the print "sched: RT throttling activated=
"
> >> > when RT throttling happen. It is hard to know what is the RT thread,
> >> > For further analysis, we need add more prints.
> >> >
> >> > This patch is to print current RT task when RT throttling activated,
> >> > It help us to know what is the RT thread in the first time.
> >> >
> >>
> >> Adding Greg on this patch, since it 's been a while.
> >> And also: ping :)
> >
> > Ping on this :)
> >
>
> AFAIA this has been proposed a few times in the past, the problem is that
> printing the current task isn't the right thing to do as it may not be th=
e
> one that contributed most of the runtime that lead to throttling.
>
> See https://lore.kernel.org/lkml/20221209163606.53a2370e@gandalf.local.ho=
me/

Ah.
Thanks for the input :)
I'll shut up on this.

Thanks
Alex

>

