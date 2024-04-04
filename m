Return-Path: <linux-kernel+bounces-131326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA68898651
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0FC1F2B883
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C775C84D12;
	Thu,  4 Apr 2024 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/mH3OX3"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162E811E2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231169; cv=none; b=RXhYKvyY8Q8tHHfqcTC9JnxoI0GBjCVRnWzBzUP+XkXWbEGfdaD7EpAWnXnnilKEQeDXh5En4RDeGM2OaBGuaGDlMq6prJeqMNS8OakDEE8w53sOujZwYEpXKMs6qwqpanghPfIDHb0CIUCde+x5qqihOdW+bFpzHc+bwTneCOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231169; c=relaxed/simple;
	bh=0bAFYCn0S1dJ2yrIEz0ZS7aIjMo0R6DrZJPHkE7bWBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sadV3HxRmYBgpljbiGm7Rih1S5/7XHZ1B5roq56LQkq46JC9cuzd2PmqvBiOK3NlgGaXOK/PBc6WOQ5A9PYdMj1mHWHsKd1m89yF5k+7Yv56oK5k9rKVX0HTnrnrCiT8lb9CR12itWgJOhHNzo3Ki0tIF6sF5ZXaO76ZfDFAKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E/mH3OX3; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6151d79db7bso10385187b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 04:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712231166; x=1712835966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bAFYCn0S1dJ2yrIEz0ZS7aIjMo0R6DrZJPHkE7bWBA=;
        b=E/mH3OX3I0ioJybT4i+Im8tS8fxJYAPYZ/RvaYq6PDJCEDh7ujMkpAd1QaNn/crAaO
         aRDi467gxpjz5m2okD9Gzh9oucXwxEQWlRJA5Z0dr8gjF8nUJOVhnVZkDGKXbx95cxgi
         s1047OsdmhN1JShDAmRFH9WZ/OQ8fI4Y8TUjzYXEUpjtEtC/zRFs6kGvyX4d0J96I/cB
         Ayrji5gvJHdvNBD/niHLLjs4dcSqxzyjs/ARKc30JUSfl+PuGCPbq69F0Gn5dwBiZLpF
         WKTuZM4PJFOQUvgTJ6vRcAkr0S9Pemnjpgx/EP8Nlhw69/XdVEwPncS8tgPj7oLaZB3F
         PpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231166; x=1712835966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bAFYCn0S1dJ2yrIEz0ZS7aIjMo0R6DrZJPHkE7bWBA=;
        b=UU1YAZMI40mXT39DBzCPMM9DBGW83iqK+PwX1cSOlnahIIGIdFpoIE1sNfy2/43dfb
         usuoQGON6yQkb/whr691ov4fcEXtnsmYNGvrfnClex72x8Br+c0I6gVMdlz1jO31F2Rn
         zrmxDpXEQU57zJ/u9HrtqP3MQ4zeBZ0qZT/RKKy0bqEKXpicNvPboBQPQCDRs8CpLwYI
         Ml2irNRM1iLdqS+eM8UY3P6uR7OySIY9jwbkD+68LBaE8Tp0GeTzq/EkNfE129YDsQ8L
         uj+5G12UFFOFEdEslIzP1GUy81rAvzxcEHUt/77yjm0rpaVS4KBAhuHH0ESuE7Fbdp72
         OJ8w==
X-Gm-Message-State: AOJu0YyfE2vJShGvg31Pr2ZAgKx1NsH0UcEkL3NVnWYogxETwwLFmDN9
	8IAvWownhq5lvwntpq2P3WUzG6M2JtNbb9chXIn/rfZ37VabF8eJABxQ/JK7LMNBstJSbf1sVtQ
	hr3Ohz6fYOmgQaaiv915oKHQQrXdBxoJo3GENtg==
X-Google-Smtp-Source: AGHT+IGu74Af53iaIgk2XgFUj5ga3mO2b15/RLozSRxzXstnfq8AhJlMB9p+lzkEfYDrX2Fvnpr0i0qNbGQS0bdtK/k=
X-Received: by 2002:a81:ab4c:0:b0:611:481:9117 with SMTP id
 d12-20020a81ab4c000000b0061104819117mr1965101ywk.1.1712231166433; Thu, 04 Apr
 2024 04:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <60af8968864ae4a83a76e589b39a2b1e1f65c9db.1711992588.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <60af8968864ae4a83a76e589b39a2b1e1f65c9db.1711992588.git.christophe.jaillet@wanadoo.fr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 13:45:55 +0200
Message-ID: <CACRpkdaeMr=gKH2FSL4kkSyOirD__Pc3YYGoPga2GUvX3kjYBw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: max77620: Remove an unused fields in struct
 max77620_pin_info and max77620_pctrl_info
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 7:30=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> In "struct max77620_pin_info", the 'pull_config' field is unused.
> In "struct max77620_pctrl_info", the 'pins_current_opt' field is unused.
>
> Remove them.
>
> On my x86_64 config, with allmodconfig, this shrinks the struct
> max77620_pctrl_info from 360 bytes to 296.
>
> Found with cppcheck, unusedStructMember.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Patch applied.

Yours,
Linus Walleij

