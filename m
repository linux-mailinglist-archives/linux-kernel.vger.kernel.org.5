Return-Path: <linux-kernel+bounces-24589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1328182BE8F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05D71F24877
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09885EE8C;
	Fri, 12 Jan 2024 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rXXBYWI0"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9195EE8A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5f70c085d64so55434697b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705055157; x=1705659957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrpYiiUZvW6/AnFbosBlfeKS3Uh1NSZM2E5hPQsUkps=;
        b=rXXBYWI0vGvvTKV6ygv88oM6VN6fXHHyZjLlGKMs/s3CbH5ci8S/ZMTvCYqPcVxfOb
         b/+PWxhNxncyKnZ2ZkHpqQOqBTe4gKaDV25oFWex16yfaOE64JSa4tp+TLnaaZsHp+gL
         oFC2MfirbpqhGs6e4AsAZfDwo1A3MsFZA/KR/pfITivpSG7AG/wdl6SxqjWLVznZgfJV
         ni4KSOTYAA0g7P63wJnFem26JwLAtTtDjDNoJ0WASue6Y4AJOdltlY1FMXp86bmziBQi
         gEWZ07W7emdb6aNONrB8+e+cxwvhZfV33DKXp1PQVpdNsnb6H1EV+T85vLkz/uCKh+T9
         A/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705055157; x=1705659957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrpYiiUZvW6/AnFbosBlfeKS3Uh1NSZM2E5hPQsUkps=;
        b=KgwjleB0Afzp7y1zbkbF5ykeJ884VaKwe5wnVDWVdYD8QIj1Ejn35IDodQsg+QRVAB
         j7iGh0goQvZCSL8sABBPFd3vChdSWOqViQh1nq25Q2QxTrUf9QNjm54IpRYGtydx12y1
         MrYhWVFfGqgJTH+Io23DqIrLpnMgY+EaXgdfsuC7F9QjUcaCIM0hoMAyExo//p7UaF9w
         ZeAH24lSM7d6PV6gEa0OEP/pmQ+rg8m6jxe/Xe0iphXfalWVLIJ9aZ9VgRUDNVgNCpvC
         WjdzJ9K3gp29TKnMwsPFTidNYGGHRneIlg9Usr9FFMKr6EKOAsuLaryIN7zAGUmA2xut
         vBuA==
X-Gm-Message-State: AOJu0YwymFPAgPtTsl2VnHStph42xfY5e7479ECARXpmDqp6xUyOOBPK
	nHYlo9+E8SUlefgUn2SrEfmuehJSJRv37OJhESoItC1b+1LnKQ==
X-Google-Smtp-Source: AGHT+IFlOE1GVKUUNrtrFdTNGJR3/eHT7lHMq9rhtkAS83Jo4rY6adUw6B7dW71bpZFr994d28Nl/vfiD5zAKqQ4GOw=
X-Received: by 2002:a25:ea44:0:b0:dbd:e651:a32f with SMTP id
 o4-20020a25ea44000000b00dbde651a32fmr439006ybe.114.1705055157730; Fri, 12 Jan
 2024 02:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <46566e85-4afa-4c55-93b2-0d0b71d76b12@moroto.mountain>
In-Reply-To: <46566e85-4afa-4c55-93b2-0d0b71d76b12@moroto.mountain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Jan 2024 11:25:46 +0100
Message-ID: <CACRpkdafwsQugKzGFsAPsMNGGObSJEzJRah9qGTitah12Zf3Bg@mail.gmail.com>
Subject: Re: [PATCH] gpio: rtd: Fix signedness bug in probe
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tzuyi Chang <tychang@realtek.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 7:55=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
org> wrote:

> The "data->irqs[]" array holds unsigned int so this error handling will
> not work correctly.
>
> Fixes: eee636bff0dc ("gpio: rtd: Add support for Realtek DHC(Digital Home=
 Center) RTD SoCs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Looks right to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

