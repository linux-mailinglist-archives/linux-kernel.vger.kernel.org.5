Return-Path: <linux-kernel+bounces-13192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBFE8200F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794BE2825A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A5612B87;
	Fri, 29 Dec 2023 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alSTZBB+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B999B12B84
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbd721384c0so6013032276.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 09:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703872237; x=1704477037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P81u+eG0GfTd2LNxdHAAM/aJvrdRoSS+QBsfBsOk/dw=;
        b=alSTZBB+c02LGazZPDdRLy0fYbZu+q9ofZu1r+wriG3t+R7zDneZFE+dbGREhHFpDf
         BSLtJmoKxUvPi5yjqLhcuTS2bzeqvu2FE335eD/GFwd5TEzrv/RqiaHreE6d9517MfGA
         Bnm73eg0+V9alG4QaobBh6FU/gYTQpoIgICQVGmNOBOI5OoPzxjQeCTmHC8B0T8SIy7+
         hbRfEkLS4xAObgUbBIcdRBUVosDXMe0sh4aNzadqqsJV2YmzC1pmcNXDy4CCvB5mg5ei
         muf5dLO6ooJbOSkGX4uPPteNpbGF5apj3DblgsqdAaMJa+19LjX8G71YlJgJlZBFGaYs
         e3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703872237; x=1704477037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P81u+eG0GfTd2LNxdHAAM/aJvrdRoSS+QBsfBsOk/dw=;
        b=G2KDZM5EIoCURl4cbpmIFaKYu86Rd0E53g3RWD6zjJS6XK8dPEqbYrwL07aZdjbh+s
         O3RfaEki9xm9DmwdSaOEDfFGncxhLmlbkH+IlNLSvsqgr8OJuVfOWR9BVWFwvzUMwkof
         gAI83BHQMZkFd/XfgkS0JGJU55479N2OHW3SDnuf81doICHv8LHWhPDWCJQS4tM5Xazx
         6NuaMlVfPlQkBjqehOqbWnLFIwISjc4BO+yUULtAACy23UYctiiCt2hX/MjBAv9zfjLC
         TG0/mczoTPlJLsv8LJvK9So+1KBYftXHqSha37nmZBGT+Ua9Ee8kg6Jo+/5lrAlglL2G
         YQyg==
X-Gm-Message-State: AOJu0Yy825Z6EWFNj70i50WQmAXlfq94YIjLNqDpXxdrmwJMBQYbsNN3
	2a45eRpDK/9AUo0WE+wxP3TbzNbteH9DaApjVtQr2C0uwSNMQA==
X-Google-Smtp-Source: AGHT+IHXYwNf72w1aST2XgJonUOt9cIq7p2XUzBAEueBGhV+/R8nnBgYMdGoOCpbhv0z9u+aocB9DHdxJShIoJlQiM8=
X-Received: by 2002:a5b:bc7:0:b0:dbc:b19c:8e64 with SMTP id
 c7-20020a5b0bc7000000b00dbcb19c8e64mr6790367ybr.94.1703872237690; Fri, 29 Dec
 2023 09:50:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229130758.84214-1-emil.renner.berthing@canonical.com>
In-Reply-To: <20231229130758.84214-1-emil.renner.berthing@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 29 Dec 2023 18:50:26 +0100
Message-ID: <CACRpkdaCPtY=gjAxuQAQUxczBVniWPFBq8ZSM+DfE8v0nxafvQ@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: dwapb: Use generic request, free and set_config
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hoan Tran <hoan@os.amperecomputing.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
	Drew Fustini <dfustini@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 2:08=E2=80=AFPM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:

> This way GPIO will be denied on pins already claimed by other devices
> and basic pin configuration (pull-up, pull-down etc.) can be done
> through the userspace GPIO API.
>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

This looks like a nice case of a pure pin control back-end for the
generic DW front-end GPIO.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

