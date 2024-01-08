Return-Path: <linux-kernel+bounces-19661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0BD827082
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9E01F232C5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039D446538;
	Mon,  8 Jan 2024 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="UGCs0p40"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2794645B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28bf1410e37so1639807a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1704722441; x=1705327241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsHjtSAD7CR/Uw67tDyZXUJsMA+vgb2Il2+MXiGde7A=;
        b=UGCs0p4068lLQwCRR2iIsFuGu6SUsFfca6kMXlPd6ApIdSM8AhGzLcU8lgFyNvAAS6
         4nAUYGO+PTgdHjXiUOpVaiOlIHiDXj7R18i8zKQvOtLaHc+EpLQh0Wi+KhDMemF1lL7s
         kzZAyUtU4aF+ILfPc/Vqqeoex1q9t+36wNb8reIv/lZZQ91gR1CfbkEW/vgxEC9rcMZw
         isBLOep7iGC1IcHLFH2GOl60q6F9nvykybzTTIaXxWUcb/y/4TZP5/hK8VGICSIaa9ZM
         6tza4TlHF05BG8D97U7+FMW2WsvnzkoRnCQVoyJ2jjAv7HzB22i4aU9WLkdc5/cuEVtW
         3WGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704722441; x=1705327241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsHjtSAD7CR/Uw67tDyZXUJsMA+vgb2Il2+MXiGde7A=;
        b=ARGIIfOQx+h+3sr8tCnkfRdoa/lbj+LQ9gJA8HsgJ9x1IYpOn/ipAuSAiV1Wq/VIGQ
         FwER32aFvF3ItKYQuq+Vt9Lvo6V/GevAfIA511/CYKjargya/8NurFbCX3cTqsYbfMoT
         R4KGkatvENORz/pg5QBp8CZ8mApibmJrcH4DoBDZBs1kmwKgZf011LJlJB0KNV+KpZA3
         gkYNL+aYeob4m9rNiTNxxdI39EDGfUTaXTtS1M3XYdLrlq/VReAn7WfJCPwKOu29kFVr
         oz8BWgTkUz4SZI8UMej9iy17UdeSVJyy+IHge3C1cJS4fVhDu7JHF/gvHyd+gTmAynxZ
         erDA==
X-Gm-Message-State: AOJu0YzE6CJx0u55KjQ+5Yj5Vw5K6EoTdD95tJbTfXvOZmdP8HClNc/9
	n367CpQbEYoMatpA8dVncQj2RsvXVoCDswU13ZVgcJwYUYDVGQ==
X-Google-Smtp-Source: AGHT+IG6M5/HPL5z2iu+bv+cDT8okM9t+0Kb9SYQo0HU3bi50MXU6tg3bagSrM1h0jjNwpnrNJpAS5jTVZd+AmduFM4=
X-Received: by 2002:a17:90a:474e:b0:28c:25d9:cc08 with SMTP id
 y14-20020a17090a474e00b0028c25d9cc08mr1737979pjg.82.1704722441110; Mon, 08
 Jan 2024 06:00:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230521114715.955823-1-heiko.stuebner@vrull.eu>
 <ZTE7eUyrb8+J+ORB@andrea> <CAEg0e7jkTOn1pjO=+GaiCZJ9_Yd2NcB1GMG=Q6m3-r0+Q0OjGQ@mail.gmail.com>
 <ZTJUOji+B+dDbMKh@andrea> <20240108-a56ba0dfd1779e4ab6893d16@orel>
In-Reply-To: <20240108-a56ba0dfd1779e4ab6893d16@orel>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Mon, 8 Jan 2024 15:00:29 +0100
Message-ID: <CAEg0e7g34qXbtaGbQftqucRxopFKHvErm=DWx8N65kueDo2n4w@mail.gmail.com>
Subject: Re: Re: [PATCH v3 0/2] Add Zawrs support and use it for spinlocks
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	linux-kernel@vger.kernel.org, David.Laight@aculab.com, 
	Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 12:35=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Fri, Oct 20, 2023 at 12:19:38PM +0200, Andrea Parri wrote:
> > (Removing Heiko's @vrull address from Cc:, since it seemed to bounce, k=
eeping
> >  his @sntech address.)
> >
> > > I had a quick look at your changes, and they look good to me.
> >
> > Great.  Thank you for looking them over.
> >
> > > Did you agree with Palmer about testing requirements?
> > > I.e., do we need to run this on hardware that implements Zawrs in a
> > > non-trivial way?
> >
> > I didn't quite discuss such specific requirements or hardware implement=
ations,
> > but I agree that's a valid concern.  Not that I currently have access t=
o such
> > hardware; any further inputs/data will be appreciated.
> >
> > > I can try to raise the priority on this here, but can't promise anyth=
ing.
> > > For me it is also ok if you take over this patchset.
> >
> > Thanks.  Either way works for me.  No urgency from my side.  I'd say - =
let us
> > leave this up to the community/other reviewers.  (IIUC, Palmer was reco=
vering
> > from a certain flu and might need more time than usual to get back here=
.)
> >
>
> Hi everyone,
>
> I'm also interested in seeing this series resurrected and making progress
> again. I'd be happy to help out in any way. It's not clear to me if it ha=
s
> a current owner. If not, then I could start shepherding the patches with
> their authorships intact.

Sounds good to me!
Thanks for working on this!

>
> I may be able to do some testing on an FPGA too.
>
> Thanks,
> drew

