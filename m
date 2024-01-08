Return-Path: <linux-kernel+bounces-20055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E9D8278CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BFB1F23B2D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E365576E;
	Mon,  8 Jan 2024 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gKjSJXBC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE754F8D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e7409797a1so19349377b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704743816; x=1705348616; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=okK8yG6yCTI1mgGltbh1CTPhrkiOhqEoi7Rr/ighIsc=;
        b=gKjSJXBC+mT+TonCu/dPaISjtBz6xrK2HKPYzzNm2ayiMdGJhzyKzqN+g9VXUBQXiI
         JchcXGfq5pi1eu+guE09XBFZ7gnaOiXSBpzX3GoXRwPb+blE36UUsSlncTchCjm7/p7e
         UFt5YaoRIP0HV4IC/QwKMam/AhvXqm1fDhS5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704743816; x=1705348616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okK8yG6yCTI1mgGltbh1CTPhrkiOhqEoi7Rr/ighIsc=;
        b=m0KFP/mHwgXzab0rUZy4KNhiGpmHuv4zDbGIrNw5d4VlksYvH+j5fYrQw/Gc1LcX5c
         OigkZTIkJt8KgzInRKDGt3rMANeaXYfcWaags2XvVsXo9eWQnVPiG/tuEUJqLYBqazt/
         U83OvF6vaN4xJfyrMAcOeSfxa3NpBXQGQQLG9ZlJvqZUwHrwGVLcymVfRc3o5/QrcXC0
         mN09TqJEMBz9OYKPuHPXKDEM991sRBm9azHud3lOGNtImrGGDhSyqTld8sFMXfOHY6eZ
         r0gCnRHJn9WLJ9DIKWY75rywhE9epjmEGhXixP85KbspprKI/eJlx4/sydRENPgFmq8i
         i3VA==
X-Gm-Message-State: AOJu0YzjB9gQBs4RGglzKVeDqttrqAmfwmdWbav+dQZu+u6178xMb15w
	5LOd68Gq5YJQvC/TRZyYOO8THDz5on1B+OokltxkWcdHVFMq
X-Google-Smtp-Source: AGHT+IEiHU7X1aYIiaCwwovUzb8yJE+Zc0Vt4H+vGZhGKTbA71xktr7bIAC3NtNFIGAuIWxPYTVw/cg/eUGLLzk2Sds=
X-Received: by 2002:a81:57d6:0:b0:5f6:e869:2a7 with SMTP id
 l205-20020a8157d6000000b005f6e86902a7mr2066138ywb.99.1704743815874; Mon, 08
 Jan 2024 11:56:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
 <CAE-0n50zkwZ8nguUJcL1gjbuavhSU_rLxfGhanxB4YA7N34hLQ@mail.gmail.com>
 <CANg-bXByhaSngW2AAG9h6DYHpiTUvh8+yw3LPU6ZQSCb62M-wg@mail.gmail.com>
 <CAE-0n52u68wMHJGe8=jz4Y1y2=voycFEY15keebz9tPDDBgiqA@mail.gmail.com>
 <CANg-bXDzLJgWLuH8Xj4GLYG=AVfcbmi_EfrA7DaHj4F6i350DA@mail.gmail.com>
 <CAE-0n52365_AYgjaXyV7+oB8WgaJVp5oCUzdsq7NquZsR08XXw@mail.gmail.com>
 <CANg-bXAVm01qoGUL2hUN9=3eK5o6c6BKtTUL82WiLL8cxFeaLA@mail.gmail.com> <CAE-0n50nNXSybfAnOgAk4g8hOma7=yLG8+y9PpHaXXSUE-zfsw@mail.gmail.com>
In-Reply-To: <CAE-0n50nNXSybfAnOgAk4g8hOma7=yLG8+y9PpHaXXSUE-zfsw@mail.gmail.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Mon, 8 Jan 2024 12:56:44 -0700
Message-ID: <CANg-bXAO0Pk8Lea-Ci+k56ucBDA+w-2+3L_uP6y2=-JihujXDg@mail.gmail.com>
Subject: Re: [PATCH v4 24/24] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
To: Stephen Boyd <swboyd@chromium.org>
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

> Isn't this patch series making the wakeup-source DT property required
> for all existing DT nodes? I'm saying that the property is implicit
> based on the compatible string "google,cros-ec-{spi,rpmsg,uart}", so
> we shouldn't add the property explicitly. Just rely on the compatible
> string to convey the property's existence.

The current wording in 'wakeup-source.txt' states: "Nodes that
describe devices which has wakeup capability must contain a
"wakeup-source" boolean property." According to that wording, the
existing DTS does not match the expectation. This is what led me to
add the property. However, feedback from KML mentioned the wording may
be a little strong and it should be updated. Hence patch 04 in this
series.

I can revert the SPI driver to assume wake capability, which will no
longer make the wakeup-source property required. At that point,
leaving the property in the DTS simply provides an indication. Considering it
won't be required, I can drop the DTS patches that add the property.

> I'm no expert in ACPI so sorry if I'm misunderstanding. The driver
> unconditionally enables wake on the irq.

Yes.

> Most other chromebooks have
> added some other interrupt (GPE?) for wakeup purposes, which is
> different from the irq used for IO?

The GPE is used for wake and IO (It processes ACPI notify alerts).
AFAIK, the separate IRQ was introduced for latency reasons as the GPE
path was too slow.

> And this patch series tries to
> figure out if enable_irq_wake() is going to fail on those devices so it
> can only enable irq wake if the irq supports it? When does calling
> enable_irq_wake() not return an error to properly indicate that the irq
> can't wake? On skyrim devices, where presumably it needed to be marked
> in ACPI differently? Or does that platform really support wake on the
> irq, but we also have a GPE so enabling wake on the irq is not failing?

The patch series does two things:
1. Determines whether the irq should be enabled for wake, as opposed
to assuming (at least for LPC/ACPI).
2. Moves enable_irq_wake() logic to the PM subsystem.

Skyrim does _not_ support wake on irq. It uses a GPE. So the patch
series drops the assumption that irqwake should be enabled. Instead,
it polls the ACPI tables to determine whether or not the IRQ should be
enabled for wake.

> Having to backport 24 patches to fix a bug is not good.

Some of the patches were DTS related as a result of my interpretation
of 'wakeup-source.txt' (see above comment). Other patches are
tangential based on KML feedback to fix things that are orthogonal to
the bug itself.

> Can the driver
> look for both an IO interrupt and a GPE and then assume the GPE is for
> wakeup and the interrupt is for IO?

No, some boards need the IO based irq to wake, and may use both.

> > 3. Leave the existing solution
>
> How is 3 an option? I thought this patch series was fixing a bug.

I meant the solution in the existing patch train.

