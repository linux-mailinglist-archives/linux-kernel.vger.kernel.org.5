Return-Path: <linux-kernel+bounces-16150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2AC8239B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A021F26049
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C007259B;
	Thu,  4 Jan 2024 00:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ra4f+5iF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51F21FC1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e72e3d435so8533956e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 16:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704328712; x=1704933512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeSEM9FnhCQHetUK/2V8lmbOcksPqkXqmCZ/w8B3yNs=;
        b=Ra4f+5iFh9DeiuZD7AJrQcT9Pa89TqkQ3vjDHB4quHaC2uFszhVyJv640tFP+pwnVt
         Cf2tbnDli0iwXQTtZo7BDFOKbH5+jFFn8Odn4nVEYioGxZGEYsTzjGgEp6AURIXVBClG
         9cGGIt29TF1mHrCb9/CP5f/csEoDVRVE9QaGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704328712; x=1704933512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WeSEM9FnhCQHetUK/2V8lmbOcksPqkXqmCZ/w8B3yNs=;
        b=N/VjV8hhJAaH9Ro8qgMfjQVo297JNGRvr6HrbqmQSEacqtw3F6r09x4TkdmqdakvCo
         P7IRFuJDB9mJ0UsNqX6ERqjGqGLOcEov58OSzyuBiTqYgxCErTRWQ90Jzsl/9gaSZKye
         IdySWHjUxdMikA67OTmLtRkUdxaV/2FNBdhaLJLEOd/dyCW//YG2ZKhT8rstxiTdn4x1
         2okMcl71O4BwFJLT6k7SvpO4QdtESylwD0b0SVpXqQWrkk6W/+EPLFzfsH+5J+BPWTrY
         1yDfXBkGRpVF/OxtuFuq5abLYXvXUf/cYfPK95WcjvH+o2R9v9Z59TSyMBO/iu6XeQag
         3iRQ==
X-Gm-Message-State: AOJu0YwNNKYELNc6cyE5QRuczUaVkMFdofyz68TZKVR0JbI51eytlugi
	Kotb7si792dfsOjsM5IgIOiK8InJPLjmTS9BKPYbBbVfKxi+
X-Google-Smtp-Source: AGHT+IH5TiJLJAwWw1IiZgdfve2aCAaTuhmjUVYOptdj5QYk7WMPA8Q7ozG9oW8WM4Og9/cgsdtPKuNPyJe5UgTN9LY=
X-Received: by 2002:a05:6512:3b9a:b0:50e:710b:a7bf with SMTP id
 g26-20020a0565123b9a00b0050e710ba7bfmr5628850lfv.81.1704328711790; Wed, 03
 Jan 2024 16:38:31 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jan 2024 16:38:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANg-bXCU0Y+GOf9w2j5suoq+F=AnE-NPuhOYjGtpoG3W4WT6-Q@mail.gmail.com>
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
 <CAE-0n50zkwZ8nguUJcL1gjbuavhSU_rLxfGhanxB4YA7N34hLQ@mail.gmail.com>
 <CANg-bXByhaSngW2AAG9h6DYHpiTUvh8+yw3LPU6ZQSCb62M-wg@mail.gmail.com>
 <CAE-0n52u68wMHJGe8=jz4Y1y2=voycFEY15keebz9tPDDBgiqA@mail.gmail.com>
 <CANg-bXDzLJgWLuH8Xj4GLYG=AVfcbmi_EfrA7DaHj4F6i350DA@mail.gmail.com> <CANg-bXCU0Y+GOf9w2j5suoq+F=AnE-NPuhOYjGtpoG3W4WT6-Q@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 3 Jan 2024 16:38:31 -0800
Message-ID: <CAE-0n52ri8S6wnSkOkT7frNi+HMVXFrmuwuvBz=hgJCfpYHmOg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

Quoting Mark Hasemeyer (2024-01-03 14:45:06)
> On Wed, Jan 3, 2024 at 3:25=E2=80=AFPM Mark Hasemeyer <markhas@chromium.o=
rg> wrote:
> >
> > > The DTS patch would go through the platform maintainer tree and be
> > > pulled into the soc tree and sent up to mainline from there. The
> > > platform/chrome patch would go through chrome platform tree and then =
to
> > > mainline. The bisection hole will be real.
> >
> > I thought it would all get merged in the next merge window. How are
> > bifurcations like this normally dealt with? Does one wait for the
> > first series of patches to land in mainline before submitting
> > dependent patches? That could take two merge windows.
>
> The DTS dependency problem must be an exception? How are other
> dependency problems resolved? For example, this patch relies on
> changes to 'platform_get_irq()' which is in drivers/base/platform.c,
> which I imagine is in a different subsystem and gets merged into a
> different maintainer's tree.

Cross tree code dependencies like that are usually resolved by having a
maintainer ack the patch and another maintainer take the code parts.

DT bindings are not supposed to be changed in a way that would break
compatibility with existing code, hence the compatible property. It's a
backwards incompatible change to add the wakeup-source property to the
EC binding and make the driver rely on that property to maintain the
previous code behavior. That's why I keep saying that if you want to add
a wakeup-source property and make the driver act the same as before it
must be done with a new compatible string. Because the driver has always
set the device to wakeup, the compatible has implicitly conveyed that
the wakeup-source property is present.

