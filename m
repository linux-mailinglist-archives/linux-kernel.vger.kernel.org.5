Return-Path: <linux-kernel+bounces-24588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D11882BE8C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098991F2A78A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F355EE80;
	Fri, 12 Jan 2024 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="spC2baQ/"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C4B5D910
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso66047047b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705054991; x=1705659791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoixCIvUaJI+Ikw8bVxT8gSbu0EfclZZOnaz2syKKYw=;
        b=spC2baQ/D8jPu7CEJOU1UPOIN16iZNlCsr3QXetR7rqP/O6ARnnDL1eTkw/s90ZqKc
         etq4/kbAXij7fdiNlkjfxpMp/ePmC7Jo3Ukdt+rp/aVLZiXQRJezlSxGNczMGfjq3pzf
         C/9qyekg1pRk7UDFY2CVvMyNCYxhA8Kxgw2w/vGKF+vSebD3LYsUyApejvOfKXWjYf+i
         8yXXBoHbnWy2L4c7PnlGeOU0pWmnVC8sQvYQV4pKV8YPs9Ze3EDOVX16ueew3M9rBbEK
         0aj2F9dx5PYbmTmHxT8qMKJZXejVHszUCn+MFlZQVZ7vmnKGeEBOVRTRJJHKzVbTY1lw
         VB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705054991; x=1705659791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoixCIvUaJI+Ikw8bVxT8gSbu0EfclZZOnaz2syKKYw=;
        b=FKhXedSTNzOSX1DnT2bDhidjwWQEMBy02GOobb3CAcJHTsWmJfKvuDMiLYFItQ2tN5
         JipDxg8Z7xORG3QXNbABNZGQ5j0Y59/rigAewT4c9PxfhvnuyuJ6ujPTXYbBnyj9eOzH
         LC7sQNwBdTNIcJ1JhX2KZ5fVdfDN5PvqpahfJfxnhhC4PjuKFVZpxTbxwJy5VQaKCe45
         QEZqshy9+N/afdZnKduvTY25q2XPKL7pBYITQdPrCfnNLmPfj2etSOCeBR7LzjgPLRWl
         mZIPaWOWHCftXUuC7a3amJATYKa0lZwvjqMCs1Hnfbh776XRPrGUS0/Gkgw4uCXG6c80
         ZZrw==
X-Gm-Message-State: AOJu0YyRFG0ZDE5WrCXKdVkx4l4Kob17PFjONU6RMccKZtWJzunB1bT1
	NBjSNRyboropNj6DzN/NeVj2ouI7JNbwsJ5Jpf2bEafeF8PHtw==
X-Google-Smtp-Source: AGHT+IHmVOQtBdyVCbejqekjIZT/Rhkl+4ZWZHIRmIXNgIVih5i3KRfprEy8VQeiPbDlnOubwhyA1NG9t/mgb8i6gp4=
X-Received: by 2002:a81:ed0b:0:b0:5ee:6491:c2e5 with SMTP id
 k11-20020a81ed0b000000b005ee6491c2e5mr1005535ywm.10.1705054991639; Fri, 12
 Jan 2024 02:23:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110-fp4-panel-v2-0-8ad11174f65b@fairphone.com>
 <20240110-fp4-panel-v2-2-8ad11174f65b@fairphone.com> <CACRpkdaWTfPDCin_L6pefHsokjNyO8Mo6hWPdzPLLi1EUkKUuA@mail.gmail.com>
 <CYBZEZ4IM6IL.VR04W7933VI@fairphone.com> <CACRpkdZQbVXfBa70nhDOqfWPbsh-6DgX-uvZOxr19pzMmF2giQ@mail.gmail.com>
 <CYCLSCKPPBOC.1B1MP3VOOC0Q8@fairphone.com> <cdc18e2a-b7eb-4b54-a513-481148fb3b0d@linaro.org>
 <CYCMVXHYVDCI.HVH1TR8MWEUK@fairphone.com>
In-Reply-To: <CYCMVXHYVDCI.HVH1TR8MWEUK@fairphone.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Jan 2024 11:23:00 +0100
Message-ID: <CACRpkdacS9ojXUuogygkz6xxCf3mMq6GG_75sze8ukUu=rxVyw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] drm/panel: Add driver for DJN HX83112A LCD panel
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: neil.armstrong@linaro.org, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 10:52=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.c=
om> wrote:

> Since there's zero indication Truly is involved in this panel in my
> documentation - much less the number 5P65 - I'm not going to add that.

OK then, I fold, thanks for looking into it.
Keep the Himax hx83112a file name and symbols.

> So in short this panel is the model 9A-3R063-1102B from DJN, which uses
> a Himax HX83112A driver IC.

So compatible =3D "djn,9a-3r063-1102b" since the setup sequences for
hx83112a are clearly for this one display?

Yours,
Linus Walleij

