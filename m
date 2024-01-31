Return-Path: <linux-kernel+bounces-45970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272E6843881
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6A22B24C24
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084985677B;
	Wed, 31 Jan 2024 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FaW8yFzq"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD775A0E3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688486; cv=none; b=Z40vb+YrBUFuEUT324Pwypgnc1bCRUdlfZrG11ZBqjEMfo1Aa6nIIRJBqeU/WD2aqSj8J92j4S/hR83MmWIhN4zMb1oGbcFZL5JSGWpi+ajZlKoU+gef18v5QyZbGnooYUJMDGf8PNjULDC1m9UwrUCwyINPDlYfVIbCuRIo6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688486; c=relaxed/simple;
	bh=cxJarr+Nb1HMC+SQxpSSHWDecf1r7VOqrOt12aIi6V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdRRVfK53dagpkeYOqO6QGYYZQX5FF03Hdg/+UkyEN9iHw6JQi1q/KdhqVQ0cq1OkyaGBOgD8jhcdxwYEymMN5bHV3CTklTON3VkN92WeviKhLXLA9NKJg+VNR/dDQyw8wyrRAEYMtJOAGwO/v/26Vbr2AcKTNCmqmz5ibW4Ung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FaW8yFzq; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ff7a8b5e61so45527227b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706688482; x=1707293282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxJarr+Nb1HMC+SQxpSSHWDecf1r7VOqrOt12aIi6V4=;
        b=FaW8yFzqLAHk6J3Val1sX3RxHMgQ6e5Rv/pQ/m/q2nRMXfoNo3Ird3oytN/cYra9/U
         j74MiOPOmtG6U3e+93vR5ldHF67bf+gvyyKymfhlO7iR56iu/AcNrImFt6GkbP2ppA6A
         aqCKjsn5qm5/ezZdLxGm62KZbSDvjI4WvnfbMrqc+Jp+9OSJT03qY1sPz3TzinkYC0q+
         HgT4Nre2uiPhQbuaof66vP8YTPR9gh/BCAzTVKuLgjhklOaKsYc0jp5M4xPPoW5lD5q2
         HNoiFyOIvYMhZsW40XgSH2Tc/AF9Mxs8SQMZup/uBX4hluw7Ud874x5HYojzHNjixoX2
         eL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706688482; x=1707293282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxJarr+Nb1HMC+SQxpSSHWDecf1r7VOqrOt12aIi6V4=;
        b=sOcOvV8jy+OVk2iQvD9iITQ8kRMS/z28h7UJffY3dmDgpcqEMJ6O6sDb9n9qoAnej1
         rlVk2XJ6qlChiQZF0GE41w+Bg/ZkCrfF1T2Hi72YVPIqhPtb2LKRo2KyPTVJmyOW/YhC
         kRijPWwM6P0dwTm93iRWAsw7GQyDy0Hv+ukKPqwLaH9oAr+DwUIsQ7XxSHXzTdPY5N6e
         zua98+5uWijbRlFi9ULlzSijag231psbPtc63WjEFAx8XkMZPV9meivXGnsA60j2PvNL
         exbAzb68nnNkryPbHZUwlDf3njfer99wS9bbvCSHsIJFZ9bZofNwZBiHIRJQ1OhpJjPg
         62YA==
X-Gm-Message-State: AOJu0Yx6szP8Z7PbNf5Iif0R/GTPrhY75/Pl2akxp9M1yyWOPue3slC5
	bn8KK3JlGdOtVjiTLX6OAZrVbpZ0xIbsyzSOgcHi8v9XzQz7sk56hQ3fWZjk1Og+uYQG5gMbKoJ
	RZvEAtAjH5gMjnTrKZGQymAgxjO09hYz0zHLg4g==
X-Google-Smtp-Source: AGHT+IGJX0Ll/pN9RrEqTeMJ5I+KtCVrji0pP40CSJDw2wi3bOHlKyBHFIXAxoI0f6YPcwBuNm+aKN7VcP/T8lhxZc0=
X-Received: by 2002:a25:fc26:0:b0:dc6:c3e0:82d1 with SMTP id
 v38-20020a25fc26000000b00dc6c3e082d1mr436656ybd.60.1706688482257; Wed, 31 Jan
 2024 00:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124100606.22700-1-brgl@bgdev.pl>
In-Reply-To: <20240124100606.22700-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 09:07:51 +0100
Message-ID: <CACRpkdbHnD4wWtrQ1tZr08xB69fDySgjHCxEdHsLX-t_7Bm7Cw@mail.gmail.com>
Subject: Re: [PATCH] gpio: unexport GPIO irq domain functions only used internally
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 11:06=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> There are no external users for the irq domain helpers so unexport them
> and remove the prototypes from the driver header.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Makes sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

