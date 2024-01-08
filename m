Return-Path: <linux-kernel+bounces-19853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654EF82755C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183812823D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9749A53E25;
	Mon,  8 Jan 2024 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nT6tKgOu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DE553E2B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cce6c719caso21527641fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 08:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704731805; x=1705336605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnSQxvC9fJmnqbuFgQC12kF4flGjmQLQ6fFuqyK51SM=;
        b=nT6tKgOuil3Ni03AII8y6gVu0HKiQCe3oJi9vmgWvANEuHqOARwq56FQ4vUuAUAxEE
         pETXT3RbuJZ63HtdcQ6d62KFXdbqomv84xFzWRWSu1HRnB6HInTqpOR3cmkN1AObIBgL
         VYwbRrIh4y4RNhIInCdTz+UPbivdKEk2rycVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704731805; x=1705336605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnSQxvC9fJmnqbuFgQC12kF4flGjmQLQ6fFuqyK51SM=;
        b=FnsFCz2psfQj4qpgy8o3Em7BZKyFGN9W1O3XWhSv+p66Qcon+63ci+5LRDP7BSFaPr
         mCy0dJMjTpmuJC3rMWrJuvFCLp132S5C6lq2fH4Y/+Fe083f09Kg41nDZRhnAFzdf/Zo
         buy5dOn9qJvU0TO+Kp5vF0Pm/lUuX9SZX1v00dgQzVrrttFTkIeRv/epfG4NeMraHyoS
         Snu+iSwRtR81SGruP/8BnZ72ndemKKhQwj9hhd8E6c7RHpYkoZs3fpB1aeD8g8iuUYO2
         snt7kV7ht9TvTdUhsO/6FUPojUayP3izM4RNU4ARTdFddy+uTyYjmXENT3jH/0VelFkk
         wQBQ==
X-Gm-Message-State: AOJu0Yzsd4ol8+y2YCvwcRc/Xhpk//QnpvVE+mpxmnG3bbL6qgljslPh
	0IozfVXsRBKJOTUOWaFs7r8GfrQHLWZF5bhe9j/MViRD+CmC
X-Google-Smtp-Source: AGHT+IFNcz/f8d6/i9Di7K3T/2O29v6Q0dCbIStjQmwmAjSXnmKrhgOzGahPzLwlBtdzdMcSuHludjyE1e+YvrHK4ek=
X-Received: by 2002:a2e:94cb:0:b0:2cc:7ba8:d756 with SMTP id
 r11-20020a2e94cb000000b002cc7ba8d756mr1498622ljh.89.1704731805482; Mon, 08
 Jan 2024 08:36:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925163313.1.I55bfb5880d6755094a995d3ae44c13810ae98be4@changeid>
 <ZWF76ALANQwP_9b1@google.com> <CALNJtpUHHaq6g0wSuyaNBxtOE9kt6vDzdAGGu6j=JJdJmerDWQ@mail.gmail.com>
In-Reply-To: <CALNJtpUHHaq6g0wSuyaNBxtOE9kt6vDzdAGGu6j=JJdJmerDWQ@mail.gmail.com>
From: Jonathan Denose <jdenose@chromium.org>
Date: Mon, 8 Jan 2024 10:36:34 -0600
Message-ID: <CALNJtpX3Yb=tzGYMwr6He27hc-MYjfwWtm4_LuhLThOfat_jiA@mail.gmail.com>
Subject: Re: [PATCH] Input: i8042 - add quirk for Lenovo ThinkPad T14 Gen 1
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jonathan Denose <jdenose@google.com>, 
	Hans de Goede <hdegoede@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Mattijs Korpershoek <mkorpershoek@baylibre.com>, Takashi Iwai <tiwai@suse.de>, 
	Werner Sembach <wse@tuxedocomputers.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, Nov 27, 2023 at 10:38=E2=80=AFAM Jonathan Denose <jdenose@chromium.=
org> wrote:
>
> Hi Dmitry
>
> On Fri, Nov 24, 2023 at 10:45=E2=80=AFPM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Jonathan,
> >
> > On Mon, Sep 25, 2023 at 04:33:20PM -0500, Jonathan Denose wrote:
> > > The ThinkPad T14 Gen 1 touchpad works fine except that clicking
> > > and dragging by tapping the touchpad or depressing the touchpad
> > > do not work. Disabling PNP for controller setting discovery enables
> > > click and drag without negatively impacting other touchpad features.
> >
> > I would like to understand more on how enabling PnP discovery for i8042
> > affects the touchpad. Do you see it using different interrupt or IO
> > ports? What protocol does the touchpad use with/without PnP? If the
> > protocol is the same, do you see difference in the ranges (pressure,
> > etc) reported by the device?
> >
> > Thanks.
> >
> > --
> > Dmitry
>
> Without PnP discovery the touchpad is using the SynPS/2 protocol, with
> PnP discovery, the touchpad is using the rmi4 protocol. Since the
> protocols are different, so are the ranges but let me know if you
> still want to see them.
>
> Can you tell me how to check the interrupt/IO ports? I'm not sure how
> to do that.
>
> Thanks,
> Jonathan

Do you require any more information from me?

Thanks,
Jonathan

