Return-Path: <linux-kernel+bounces-20107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE485827955
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2262284518
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C16555E54;
	Mon,  8 Jan 2024 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HQ1Hwazy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25FE55E46
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so2719471e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 12:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704746871; x=1705351671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4j2m9ttyYBnQGcELMK0PzOZL5BgPNtka95T8FKd/tY0=;
        b=HQ1HwazymMZ+ThalIPCz24sdwuZkhn0OeBUe1WSuMq+S4ahNO3VV9hc6CIkmshgmIk
         mhrwgZ9LrG/mMmfcmLcQgs/i/u7rTwVAUvxP8SndqJ+qreTd4QBCEiyP1VVk28avBSMW
         ghse6x7eXCqoJrIPls/jj/2KEwYOGkOxLEmZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704746871; x=1705351671;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4j2m9ttyYBnQGcELMK0PzOZL5BgPNtka95T8FKd/tY0=;
        b=APIwP//BziiM66x+QN9NLCpIfemPCFo3CrVOtMYfne5yMWF8vzrOk6i/4LQm28N64r
         Aa1PIqudfpj7ckyM/pwiAnoPLluag+hj9+1a3pHzck2OYL6Uz+0XXe05MHNVwj9Q+thY
         xN5XVJ4DXWXdf5N7qhyIwxUS9xfMTAydTkHnfKOPJ+TqNNEoN9THM7UaNGdP7U5lSAGg
         nhUrbva0/YBYswZiKyvJ+7QRaRV5Az4BgogJkR3vwTmfgDijAj/VvXgqGsGw9Y70xvGL
         053q1YzwBP7bG69EKfqVtsq/P8Npm60sNd7G2UiZsuljnOFurWirLF/Ch6vV0X8peKVx
         FxVw==
X-Gm-Message-State: AOJu0YwZ3bkWjYfQfudcTZL1v2r0K7fu+6mcxKscowaKyKmwGWrn5xJF
	YzVlEweplzz3nc5l/BIXWQ4uZEidvrT7zP8OUkZ6GRFIxb7A
X-Google-Smtp-Source: AGHT+IFrXNY5JCZjDG0wh8MJ115D2h3ZIcWAwz50L9LhrxlnOz44eC+kuILatHzHo0WqAX2exa7M31EX3ZCTpEK9S3I=
X-Received: by 2002:ac2:5de1:0:b0:50e:6032:984b with SMTP id
 z1-20020ac25de1000000b0050e6032984bmr1754251lfq.110.1704746870844; Mon, 08
 Jan 2024 12:47:50 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jan 2024 12:47:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANg-bXAO0Pk8Lea-Ci+k56ucBDA+w-2+3L_uP6y2=-JihujXDg@mail.gmail.com>
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
 <CAE-0n50zkwZ8nguUJcL1gjbuavhSU_rLxfGhanxB4YA7N34hLQ@mail.gmail.com>
 <CANg-bXByhaSngW2AAG9h6DYHpiTUvh8+yw3LPU6ZQSCb62M-wg@mail.gmail.com>
 <CAE-0n52u68wMHJGe8=jz4Y1y2=voycFEY15keebz9tPDDBgiqA@mail.gmail.com>
 <CANg-bXDzLJgWLuH8Xj4GLYG=AVfcbmi_EfrA7DaHj4F6i350DA@mail.gmail.com>
 <CAE-0n52365_AYgjaXyV7+oB8WgaJVp5oCUzdsq7NquZsR08XXw@mail.gmail.com>
 <CANg-bXAVm01qoGUL2hUN9=3eK5o6c6BKtTUL82WiLL8cxFeaLA@mail.gmail.com>
 <CAE-0n50nNXSybfAnOgAk4g8hOma7=yLG8+y9PpHaXXSUE-zfsw@mail.gmail.com> <CANg-bXAO0Pk8Lea-Ci+k56ucBDA+w-2+3L_uP6y2=-JihujXDg@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 8 Jan 2024 12:47:50 -0800
Message-ID: <CAE-0n53N302rys6iFk0e=G2XXyew3rA_eHHgohbKyJc04e3EZg@mail.gmail.com>
Subject: Re: [PATCH v4 24/24] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Raul Rangel <rrangel@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Bhanu Prakash Maiya <bhanumaiya@chromium.org>, 
	Chen-Yu Tsai <wenst@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Prashant Malani <pmalani@chromium.org>, Rob Barnes <robbarnes@google.com>, 
	chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Quoting Mark Hasemeyer (2024-01-08 11:56:44)
> > Isn't this patch series making the wakeup-source DT property required
> > for all existing DT nodes? I'm saying that the property is implicit
> > based on the compatible string "google,cros-ec-{spi,rpmsg,uart}", so
> > we shouldn't add the property explicitly. Just rely on the compatible
> > string to convey the property's existence.
>
> The current wording in 'wakeup-source.txt' states: "Nodes that
> describe devices which has wakeup capability must contain a
> "wakeup-source" boolean property." According to that wording, the
> existing DTS does not match the expectation. This is what led me to
> add the property. However, feedback from KML mentioned the wording may
> be a little strong and it should be updated. Hence patch 04 in this
> series.
>
> I can revert the SPI driver to assume wake capability, which will no
> longer make the wakeup-source property required. At that point,
> leaving the property in the DTS simply provides an indication. Considering it
> won't be required, I can drop the DTS patches that add the property.
>
> > I'm no expert in ACPI so sorry if I'm misunderstanding. The driver
> > unconditionally enables wake on the irq.
>
> Yes.
>
> > Most other chromebooks have
> > added some other interrupt (GPE?) for wakeup purposes, which is
> > different from the irq used for IO?
>
> The GPE is used for wake and IO (It processes ACPI notify alerts).
> AFAIK, the separate IRQ was introduced for latency reasons as the GPE
> path was too slow.

Alright, I don't know what ACPI notify alerts are so most likely that is
causing me confusion.

>
> > And this patch series tries to
> > figure out if enable_irq_wake() is going to fail on those devices so it
> > can only enable irq wake if the irq supports it? When does calling
> > enable_irq_wake() not return an error to properly indicate that the irq
> > can't wake? On skyrim devices, where presumably it needed to be marked
> > in ACPI differently? Or does that platform really support wake on the
> > irq, but we also have a GPE so enabling wake on the irq is not failing?
>
> The patch series does two things:
> 1. Determines whether the irq should be enabled for wake, as opposed
> to assuming (at least for LPC/ACPI).
> 2. Moves enable_irq_wake() logic to the PM subsystem.
>
> Skyrim does _not_ support wake on irq. It uses a GPE. So the patch
> series drops the assumption that irqwake should be enabled.

Does the call to enable_irq_wake() on skyrim succeed? It seems like the
driver considers failure to enable wake on the irq as the way to figure
out if the irq supports wakeup or not. I'm trying to understand why
anything needs to be changed.

> Instead,
> it polls the ACPI tables to determine whether or not the IRQ should be
> enabled for wake.
>
> > Having to backport 24 patches to fix a bug is not good.
>
> Some of the patches were DTS related as a result of my interpretation
> of 'wakeup-source.txt' (see above comment). Other patches are
> tangential based on KML feedback to fix things that are orthogonal to
> the bug itself.

Fair enough. The fix should be isolated and be early in the series so
that we don't need to backport the whole stack to fix a bug.

>
> > Can the driver
> > look for both an IO interrupt and a GPE and then assume the GPE is for
> > wakeup and the interrupt is for IO?
>
> No, some boards need the IO based irq to wake, and may use both.

Ok.

>
> > > 3. Leave the existing solution
> >
> > How is 3 an option? I thought this patch series was fixing a bug.
>
> I meant the solution in the existing patch train.

Got it.

