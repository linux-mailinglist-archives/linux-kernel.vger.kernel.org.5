Return-Path: <linux-kernel+bounces-16072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B078823833
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055392828A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19612224D0;
	Wed,  3 Jan 2024 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PZPu/kxi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9FC224C4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5f00bef973aso41562237b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 14:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704320737; x=1704925537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZY6X4GxAISq2Dpjj0MYEasfTJvF/UOrjwVpalnx7z/Q=;
        b=PZPu/kxise+R+6qS1VJRy+zEnsN8/B4U/BDJVpT9vz3UU4q+36QjarOM+g2M9Pp8Kv
         M7uSdM/Vl2ts3WmlLT63oHnmEtaxDM1Etkl6SMQkFJa0SI8/D1EOdpvZ63YG4NQAevP6
         5CWtgT+pdYkZvbfASd+EVUDJGGA/yniya7aaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704320737; x=1704925537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZY6X4GxAISq2Dpjj0MYEasfTJvF/UOrjwVpalnx7z/Q=;
        b=KQjJoamKfb+TyKE0piM+4oBx2eWGUHRkYQQg7iz0OISfCq+Z2cO4qpEkJVZyzJXarg
         5h68H7y65A5ZSsKJMW1qkXXlMmoi3vr3SMFBXfCJIEMvasADdWZbJuRnsBZOX9FpSZQP
         7dC+340/DIB20Jsi7WsxBy7Z3+qbOZONvgtK8hcX2DJ/UUV0bs1hOzlLY6ZLS4zFCu6G
         +yIjSQuP968gTEicT5zecl1nl9ssXIB5zq6AztuFLgHTcoBT54dGmDGRS6MrcgosrLcu
         o55P0b4RFu81CTBpNaG2c8AH1qszfMB9/FMWpE0P4BFuuS+9b/XA80Noh8MKGCa9pyx3
         Ijog==
X-Gm-Message-State: AOJu0YzVdJoCba/f2tmZCovutXjP3gIvHvSlECsUp4rj+VYUDolM41Nu
	2tAJrWHSl0ihGp6+qxjOPvewrH/TIDATeXAAr/hGlx+5jLxB
X-Google-Smtp-Source: AGHT+IEtx4f6aSVvCn+9mEm9jp2DIH/ofoWczzXhNzKvk1Ij9PoZDvM0JNFRIsRe9u0nur4ZKW3BVmUPd1TqyVo5Pqk=
X-Received: by 2002:a0d:d346:0:b0:5e8:80d5:db79 with SMTP id
 v67-20020a0dd346000000b005e880d5db79mr16383125ywd.85.1704320736785; Wed, 03
 Jan 2024 14:25:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
 <CAE-0n50zkwZ8nguUJcL1gjbuavhSU_rLxfGhanxB4YA7N34hLQ@mail.gmail.com>
 <CANg-bXByhaSngW2AAG9h6DYHpiTUvh8+yw3LPU6ZQSCb62M-wg@mail.gmail.com> <CAE-0n52u68wMHJGe8=jz4Y1y2=voycFEY15keebz9tPDDBgiqA@mail.gmail.com>
In-Reply-To: <CAE-0n52u68wMHJGe8=jz4Y1y2=voycFEY15keebz9tPDDBgiqA@mail.gmail.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Wed, 3 Jan 2024 15:25:25 -0700
Message-ID: <CANg-bXDzLJgWLuH8Xj4GLYG=AVfcbmi_EfrA7DaHj4F6i350DA@mail.gmail.com>
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

> The DTS patch would go through the platform maintainer tree and be
> pulled into the soc tree and sent up to mainline from there. The
> platform/chrome patch would go through chrome platform tree and then to
> mainline. The bisection hole will be real.

I thought it would all get merged in the next merge window. How are
bifurcations like this normally dealt with? Does one wait for the
first series of patches to land in mainline before submitting
dependent patches? That could take two merge windows.

> >
> > > Does using the pm wakeirq logic require the use of 'wakeup-source'
> > > property in DT? A quick glance makes me believe it isn't needed, so
> > > please split that part out of this patch as well.
> >
> > No, 'wakeup-source' is not required, it provides an indication to the
> > driver that the IRQ should be used for wake, which then enables the pm
> > subsystem accordingly. If 'wakup-source' is not used, we're back to
> > square one of making assumptions. Specifically in this case, it would
> > be assumed that all SPI based EC's are wake capable.
>
> Is that the wrong assumption to make? My understanding of the DT
> property is that it is used to signal that this device should be treated
> as a wakeup source, when otherwise it isn't treated as one. In this
> case, the device has always been treated as a wakeup source so adding
> the property is redundant.

For SPI, it's not the wrong assumption. I was trying to drop the
assumption though to match ACPI/LPC behavior.

> Making the patch series dependent on the
> property being present makes the driver break without the DT change. We
> try to make drivers work with older DT files, sometimes by adding
> backwards compatibility code, so the presence of the wakeup-source
> property should not be required to make this work.

Do we have use cases where Chromebooks are running older DTBs? I get
the idea in theory, but don't grasp why it's needed here. Regardless,
I can update the SPI code to assume a wake capable IRQ. But I'd like
to keep the prerequisite device tree patches unless there's a good
reason to drop them. Specifying 'wake-source' certainly doesn't hurt
anything, and there are other improvements to the OF
subsystem/documentation.

> What is the goal of this patch series? Is it to allow disabling the
> wakeup capability of the EC wake irq from userspace? I can see a
> possible problem where we want to disable wakeup for the EC dynamically
> because either it has no child devices that are wakeup sources (e.g. no
> power button, no keyboard on ARM) or userspace has disabled all the
> wakeup sources for those child devices at runtime. In that case, we
> would want to keep the EC irq from waking up the system from suspend. Is
> that what you're doing here?

The root of this patch series stems from a bug where spurious wakes
are seen on Skyrim. Copying some wording from the DTS patches:
"Some Chromebooks use a separate wake pin, while others overload the
interrupt for wake and IO. With the current assumption, spurious wakes
can occur on systems that use a separate wake pin. It is planned to
update the driver to no longer assume that the EC interrupt pin should
be enabled for wake."

This patch series will allow us to disable the ec_sync pin as a wake
source on Skyrim as it already uses a dedicated wake gpio.

