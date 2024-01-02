Return-Path: <linux-kernel+bounces-14394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2DA821C74
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFE92816B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF78F9FC;
	Tue,  2 Jan 2024 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="w/zioODx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52EDF9EF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4b3288df490so1137049e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 05:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704201422; x=1704806222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KptT4kcLxqTUxKQoDuDLhTdKZCzvVtebQ5eypGHMHPE=;
        b=w/zioODx+TFNd4J11IoNH2+B74JRzkxpplZ+Yithb4GBKiJGyqAh9sr4JV+XnlKx4O
         0bpghXze4nvupYdrcw9TP2VbxFa4SI0abKXh2pLOgFSFsmfEgHp2QUpIfoAbupcgfZxU
         /zMaY9NlBI36IPKKi8G7Q7g9pEqRtbZ5IgVn2hRy7Hk85Sp72gKJnGUMFNnxYpcQA0tr
         a6BBKOv+yGlhsiT6c09RylxYKFkKuvGMFL1H19Wyeae5Pvev+cgtAbncVnk7mgtNYSNe
         PLgro3vMqmhZVisFoWMBksLTV8eE+kwtbyTRfgCigoU40jZ/Ch8ghnomV0vOtaDeZ0Wo
         XiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704201422; x=1704806222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KptT4kcLxqTUxKQoDuDLhTdKZCzvVtebQ5eypGHMHPE=;
        b=CbImzE+wpEDpc0t8sDb9qQ6H7IgjXq0DpcTN/4nhc52tCrwF3mteUM1kcQPY4NioVt
         oZcHSv5y5CFKvs8Bg/lPr2VLf3DL2GVvWaLJMWcH2HL99DOYwGLG0OI+GsODGkUELR1+
         x25AIzRisMfbFxY2Cf4SLoxvyhiQP5h+iKVzfe9pf7PxlYNqbRfKPn5ulx5WWusJ0Z28
         k7uAIWEoc9m6swvnn+J7bkUILjG4zhEbmmAzKlr8e6hwl3sF0F0GMUzSNsQd+t2/RTr9
         Z/DeQPTC1FUIyWduUL4EAQ+677ZLfEJBL6WrULQHQh1QSmj7OnoVhPx6ijob2b05nLCf
         3ceQ==
X-Gm-Message-State: AOJu0YxioMoJhMMpIW/OCPcfhgXUHv/9u4PLr4WL/aFDE3rm43CHm7Uy
	mdf2Sgz0r2HnfIuTupykLpLS3GuYL7Ql5pRmoMSNR59Wf1ShQQ==
X-Google-Smtp-Source: AGHT+IGAtC+6ICEBlvwZh78ZTUBEh3sVxOyQsJP6iMx0W8ZsVrOpEX9NxYclkYz1oOes1H8wpHAb9PTbhBCsbKAt0g8=
X-Received: by 2002:a1f:1483:0:b0:4b7:8e59:4df3 with SMTP id
 125-20020a1f1483000000b004b78e594df3mr456085vku.21.1704201421030; Tue, 02 Jan
 2024 05:17:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229130758.84214-1-emil.renner.berthing@canonical.com>
In-Reply-To: <20231229130758.84214-1-emil.renner.berthing@canonical.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 2 Jan 2024 14:16:50 +0100
Message-ID: <CAMRc=Me5fs0+L0_K5EhfKe9rQ-ZOvmBqy2=Dktvd6L5bDqksQA@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: dwapb: Use generic request, free and set_config
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hoan Tran <hoan@os.amperecomputing.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Drew Fustini <dfustini@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 2:08=E2=80=AFPM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> This way GPIO will be denied on pins already claimed by other devices
> and basic pin configuration (pull-up, pull-down etc.) can be done
> through the userspace GPIO API.
>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---

Applied, thanks!

Bart

