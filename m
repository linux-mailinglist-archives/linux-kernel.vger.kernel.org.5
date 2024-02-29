Return-Path: <linux-kernel+bounces-86430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C7286C540
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE887287E34
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91D65D749;
	Thu, 29 Feb 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="miaiGnrt"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B8B5B690
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199088; cv=none; b=DzSNX2quDPVIvhp0fC2HDPIi24jc/5tvql1e3qU8RJBWMN6Qf39KE24kyIJIHH1Q2DgXgHuoxvCuaQVP6WaUirksM/DnjcROvVWjBo6QPaZWFMZYx0TimyqP3Eu+nG1gvLfhDP+XButXW518wA8N3RzJMbXs3r25TfGGaLoUfH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199088; c=relaxed/simple;
	bh=yLDH/SmZ8OkNo4IKopG13DYJTMTGxHzaAKTzK5mwr88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpyRnhrOuYxhRqaY3YlckY68pg9xFcbWJmY6mwzxoloiMd+mA41pUyOgTUQDm2q3sK/ATgimsZqY/S8o9ftnT4xleYN6My444mu9gvOnp85DOdiVNE/rvA0nXFmWI+ikIXQvTDACleJdndZSllWZ7v6yMfaO9fJ10j/MvnOlcvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=miaiGnrt; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso767283276.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709199085; x=1709803885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLDH/SmZ8OkNo4IKopG13DYJTMTGxHzaAKTzK5mwr88=;
        b=miaiGnrt0Ofo/Y9TQswPkiaTMl+dgvBYegpF6lL+Tla111mA5PVr0JxUPAjhFaXN8t
         YPgwarVt4S8w8FCN8D+M950Teob1tIypeRLnkMqPeU4jRKp8b7TWdBBPT36bwfbkwXD/
         POufNVxJ6LAzDlLr0WsuTatvvFG14Xojy+jC8GYqH4zfcdtn9wyFyr+uDya5ufUSjLEm
         O0olpqp7JT7iqOlii1adZmBrxq5i5+U/JP0jK5Zqfs5vz0G4f5KXA0ieOK3KVyPXedBn
         e40aVi/wAdwxsUEzL+3NTKhqtftZxv2VWjvzGDq3K+7YNRAo0Ir4QXofOrThA4Glammg
         Zs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199085; x=1709803885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLDH/SmZ8OkNo4IKopG13DYJTMTGxHzaAKTzK5mwr88=;
        b=PJEZwDsBvPJdUxbZSPtZDFdJ9+kEXQ78EM+BAr3Xjlf1HHBGUZO9ppJ0VQmmlMeuUR
         VNbYvzQDQIB5NLxu2w3UWWo/BMN3Ipbqo6V/qbbTp8TSzL3BlUfMfvakmAhx+oyBr0C+
         OLt25uIhzJlhucer9ie5u5U0UzoYvpIU85lL6AKB7nSFkXJmc0AxAIO+ep6KgH3FmwQa
         p/NKF96QZmpZ+VOHQ3eytCFst4gCed5UM8bzRUi+352uaSTNOEKNpqoNvaJzkDcb2qYp
         eYdwfkkXl95alQk2w2Pg1V+RLIeBa9YNzXyKIXSVRnf1j/qA28BUNavPB08HI1J1gw24
         y9xw==
X-Forwarded-Encrypted: i=1; AJvYcCUTbTH4aCsFmu4/qMPOQTOxuRATdX8K+wr2stxC4TIz20N3WH77QVI9vE0kLp5L8qxTdE0HMTn0I4p+gnalGP7O5VfpN0zcAEE539iZ
X-Gm-Message-State: AOJu0YwU+w4EztsJb5wKaNEVmpB6wBpG3epR9ef0VqrGp8ROV3xdUWEN
	2U8DgrrLhbADq7XOjK29ffQMJ6pUln4o00WiUktdczFGGKGKBrvw5QXef6Ih6Xi5hIfgiNmXMBW
	rwJMLVz5rL/LgdDrFmHp+HcVplY1puOslGTjR7Q==
X-Google-Smtp-Source: AGHT+IGSggpuk2KLmltD3piA3qT24S+sa7pJ2na4Fu/l5Ohz9uHZf9k8yLApEggfc1Jf09gIebRKKbZvOzn1ChOVodk=
X-Received: by 2002:a25:a28f:0:b0:dca:e4fd:b6d5 with SMTP id
 c15-20020a25a28f000000b00dcae4fdb6d5mr1603586ybi.27.1709199085627; Thu, 29
 Feb 2024 01:31:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com> <20240228-mbly-gpio-v2-17-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-17-3ba757474006@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:31:14 +0100
Message-ID: <CACRpkdbUNiK7wmtR0xastCgtsp+QpfEGgXTBf32S+R5xQtxD0Q@mail.gmail.com>
Subject: Re: [PATCH v2 17/30] gpio: nomadik: use devm_platform_ioremap_resource()
 helper
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:28=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:

> Replace calls to platform_get_resource() then devm_ioremap_resource() by
> a single call to devm_platform_ioremap_resource().
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Patch applied!

Yours,
Linus Walleij

