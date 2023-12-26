Return-Path: <linux-kernel+bounces-11499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE9881E74A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B59F2810F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04904E607;
	Tue, 26 Dec 2023 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="ZrdwpR8p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017C4E603
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a26db4e9676so249631766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 04:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703592865; x=1704197665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgFlNYVpTW4/LSUdsscecibsDCHhy6INDSaJkTsHmeY=;
        b=ZrdwpR8pCEzJiWHU8sTBieDw1/Waa5zyVylr6tla2Bg7waa/jfJPm8rkMEAho/C9ge
         9s1AXglsnV9076g69kdoDpn/Sf8aJiovCvSGhUxZBklbkFKK8bL5/wdgPAdYKDupdNay
         x/tR4OJpQFuCYhmS/ywqgeBgO/+MluSD6XsQYgFD1sT30dPUMn4o0O08hKUnQJNiOcFO
         Lb+cvRvJXFmrvmIX57zOV+mKqWcCsXRrAoCH4sCuK82xMDasQ14na/XKx4pUMg9eG71e
         h5A3bfcKOABv/emGpgqBR1eIrNVjHNGosGDIGfP06Fz1O8YfPWlD1I0qgDA/RcX10Ip9
         EAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703592865; x=1704197665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgFlNYVpTW4/LSUdsscecibsDCHhy6INDSaJkTsHmeY=;
        b=FwhUNRqX92EblPezwy8ruhwb+UPObWzcq4oe1uATZnRd8s2WbJQFNQiY+5+46vGsgM
         xA7Ucg0AP4cr3KUfnECHsn7EVvf07NmLcGjQneTvGnfiTnfV/dbYeQucjbhcN/vlpDli
         oGuGMjZEmkMFX44LMeUuZcHB6xoEoR+dbzWspT9oiMQruMu4Ag4YmyPeE1zH+LJmbS7+
         rio6wu+4XkzZX6alCEONQ2b4mqZH2JPL1WFs6l37FL2MTeYztbFHyvP8wqhFNtKjyZVb
         3Yv+T1XNr2vdnj1SGmxPYz/9dufB1lDOX22MbtJ8QlExb1kOumJOtFtgY8CS25jzqhhf
         h2Lg==
X-Gm-Message-State: AOJu0Yzf3IP29CkTMsT6wK9DT9PjA0yO1uoB/JMcp0jSkbX0+uIcEdPn
	RbvT5W/dD0LXT7kr7rZN23yIiKZvhjpdpJz9u/OuXmbzpa4tKAmCPcr2Wu6dQFxdCm5V
X-Google-Smtp-Source: AGHT+IHxzCgO2oCLfPXnR4/Me1mMAqfQos7RB3BFSZ2u3yzZCPtF4kJmY71gWFuDLOAwlb8zPxryR79r59mCSy96caI=
X-Received: by 2002:a17:907:1b12:b0:a26:ebc6:eb7e with SMTP id
 mp18-20020a1709071b1200b00a26ebc6eb7emr965572ejc.194.1703592864489; Tue, 26
 Dec 2023 04:14:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207043118.118158-1-fengli@smartx.com> <20231225092010-mutt-send-email-mst@kernel.org>
 <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com> <20231226040342-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231226040342-mutt-send-email-mst@kernel.org>
From: Li Feng <fengli@smartx.com>
Date: Tue, 26 Dec 2023 20:14:13 +0800
Message-ID: <CAHckoCyBxHd6Lc8UPh_3urSHz_eDj6jrm+c80+wKBmypzjvz+A@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 5:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Dec 26, 2023 at 05:01:40PM +0800, Li Feng wrote:
> > Hi MST and paolo,
> >
> > mq-deadline is good for slow media, and none is good for high-speed med=
ia.
> > It depends on how the community views this issue. When virtio-blk adopt=
s
> > multi-queue,it automatically changes from deadline to none, which is no=
t
> > uniform here.
>
> It's not virtio-blk changing though, it's linux doing that, right?
> Is virtio-blk special somehow?
>
Yes, it=E2=80=99s the common code path.

Each block driver has a chance to set the default none scheduler, like loop=
,
it has set the none as the default scheduler.

https://lkml.kernel.org/stable/20230809103647.895397540@linuxfoundation.org=
/

> > I don't have ideas right now to answer Christoph/Paolo's question.
> >
> > Thanks,
> > Li
>
> --
> MST
>

