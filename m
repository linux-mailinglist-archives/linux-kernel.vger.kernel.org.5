Return-Path: <linux-kernel+bounces-22694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FFB82A1BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD521F22FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52244EB2C;
	Wed, 10 Jan 2024 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WzLXoFkJ"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496824EB22
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd65f803b7so27991341fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704917541; x=1705522341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/fj02NgFEpXOUC8WMG2M+2uV8+7IAP+8k2/hv3e3pU=;
        b=WzLXoFkJBW+ETi0Aq2Y7xiQxLumzrbndCS2w8zJHmREbZHvtzNmC18hkPtTrENku/4
         mFqqn6WbdFnQ5MAzbe8UbYAjoyx28RYo8kvM9NJk1L7t364jxnq4MMy9PVCfMs8LiQaF
         B9hQk23MXnRnXHD/wxqL3ad0O00Oq4QmM0Xjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704917541; x=1705522341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N/fj02NgFEpXOUC8WMG2M+2uV8+7IAP+8k2/hv3e3pU=;
        b=GIn9Q6OSIRpxQmbU2krE44n1URr8DQgTYFP0E4Tu6Vb27ilnZnOH0iZb92tuwLclT7
         DuAXdI+WArY6w/iuUBI5SPazmFt3JdAZ5x8NQlBnOe/1RKAwv24lbCnKbzuIzK1zyjSg
         vi13GvBrHA5tsVbvagSmsMHDqq50In4djd4U7yJZKbI4QiLHClGQGAktzyesL6ysjJVP
         JJF9i2dvbJANXPno04FyoWFwYQVnJ6W9otDnOeMrm2bM/JqR1Ys4Ym5F0i8IY0PCetef
         zAVBrWWyVCs/dUr34ddbKsBRKeR+vReFK7y8nq/8DBKmU7enSvVGfRFEgAiSxDbSxMe3
         k5gA==
X-Gm-Message-State: AOJu0Yz9/kWnmTO/pWJ9+xmKhZL5aHMINFhXl1HMm/NcxZmNUUjA8v6l
	9GS4wJcPvwgay164eFoZPPBx9A3OziDxxcOxRSnSBuNEPTBo
X-Google-Smtp-Source: AGHT+IHxPy9iVTepICVNt4/7XptEXNB5DnOiKHVLahviiCoEeamG0k7YF4V8EyYRqN+l3tkiDrikBNVDmrGgjoZdHI0=
X-Received: by 2002:a2e:780e:0:b0:2cd:6fa:9b9a with SMTP id
 t14-20020a2e780e000000b002cd06fa9b9amr49619ljc.89.1704917541440; Wed, 10 Jan
 2024 12:12:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jan 2024 12:12:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240110074007.4020016-1-tudor.ambarus@linaro.org>
References: <20240110074007.4020016-1-tudor.ambarus@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 10 Jan 2024 12:12:21 -0800
Message-ID: <CAE-0n53eOEGNMT8qTF_mHZK9SEG40ssROHXYn5dT+HTdVTv=AA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: irq: include <linux/cpumask.h>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, catalin.marinas@arm.com, mark.rutland@arm.com, 
	will@kernel.org
Cc: dianders@chromium.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Quoting Tudor Ambarus (2024-01-09 23:40:07)
> Sorting include files in alphabetic order in
> drivers/tty/serial/samsung.c revealed the following error:
>
> In file included from drivers/tty/serial/samsung_tty.c:24:
> ./arch/arm64/include/asm/irq.h:9:43: error: unknown type name =E2=80=98cp=
umask_t=E2=80=99
>     9 | void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int ex=
clude_cpu);
>       |                                           ^~~~~~~~~
>
> Include cpumask.h to avoid unknown type errors for parents of irq.h that
> don't include cpumask.h.
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

