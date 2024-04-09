Return-Path: <linux-kernel+bounces-137478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF789E2B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D764A282FE2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82984156F3D;
	Tue,  9 Apr 2024 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+7syKAS"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF30156F25
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687967; cv=none; b=XEi78jz+KBAvBaRcdQ6jckeDcUjvmvaZvIi3KTWAN39XZ07GnQR6+nu8ug3Um/hbdXIVwX14/p/8qzPUsuWi4Sp5wVfIbawTjiYUhCIU4eBJ6ZJzKcdDt3ZQXtjGFwmaK6lHFy2YqItH99sIMg8gSbnHR5zgh4IORKG6jOgqMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687967; c=relaxed/simple;
	bh=BwPr7SrsQf4b7g+pojJ443HjHLELotWIZE/wilGloq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsAqkH/8iwF6HHTC8K32wj/xMOU1Y19QLHiAbqRgQU5L+lE5OetK6rCYcQRlv1fC7p2qfa2dEPIfdIYXLdIpP0n8cF6G5Y8iU85xvyv9x846K4e/PgMV2AD0Ebpu9PG/h/tjGybp3nd6iYR/Ml0bls/1IX3ai4u0G2Q7UhjL2AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O+7syKAS; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-ddda842c399so6132969276.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712687965; x=1713292765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hAdR0lfI/Ap3S0wzwjpUHjQuKqdM6aVtl85wb7tRnRA=;
        b=O+7syKASBx2JiFlsf6BUFWTgvb8hzJc1kYl/sTbv+8cPiBaRynz8Gbcm8FlAELTX+m
         /l0SKde+GrmSENTVJydNz3kLE420nx0i+Ang2TYm9BI0i4Yvbyj/6XrOEBaabpfK7TLp
         nR1+C0huxdZbrnNUdWg8Zdsq+I9VsFm/B8NYahsJpdIQ1cGqzlWHw/dUtwt5LaKoIVJM
         FZF7LiqqdVlwwV4gqB56ml1T7x8Utc60xBYQcFlNn7wj+z2UdvDO6UmdkqWHMeyGmBf9
         5unKzwqIU0O5N5Azvb8EvL7u151ziPbwU1i4UJJvP8NhcMY1OL78frGZyAGXGT38yvOe
         moGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712687965; x=1713292765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAdR0lfI/Ap3S0wzwjpUHjQuKqdM6aVtl85wb7tRnRA=;
        b=OLFU+kOLGxoAraAqmW52IeJXj7DCepzk7SRxQ5gtynyXfQrj7biITYDo5PysxarOOm
         ceiTM5T+wTURxqcXzdF3aQO7UT2IM3ywuNarEhtB8EKhxoIbXK+mUIfI0yghA6cl6Wvk
         UjDXSXWTNXH3nBznnYqzZHETRhEpm3Di5gPsi+3hBbqIav1qLoV9QX5K06RHqXzNx+g+
         58gmSjmvB09IaYLeoFwZy7YKKLqY2wDfbJVcFZExzHx6FBVoRxgXHMDVjtmuERs/y8a+
         kN68tP1HGxQAMsU9PWX1iVL4ts8srKRVmK2Xnu3l08SQONVNIYaVm9nymDMErW8yUTRG
         7yCA==
X-Forwarded-Encrypted: i=1; AJvYcCWFKVXWMYN1OnL8+7EW8AnQrKAbQU95bbCIE5uGfPRLWpss6zqOrypW/BKq8yNGdE6kKknDRE1866Qh2EtpnjJE0woz0M96aC3qrT+l
X-Gm-Message-State: AOJu0YwcdIFFzSvKE1GWqJNy/I2AHipZYIN3tpqPeliE7G5nQAwXQfX1
	0fq2TbGK2iyb8YkxdzJw3L3beD0+32CW4OSDCUfNC6KU+Xs882nYWHiGTp4Fk5A3jma3wAv5hhC
	1mx71zXj8BZvMYjX4eVo9pxb0IqI78HbE/l2Cgg==
X-Google-Smtp-Source: AGHT+IHq5NVO+WfWmq3XyvBYt0xQLngoIVqzHjLiDg5l97bez8m7/Sp8OhTA5vGPOslEtZDyb+Woew1HHexx4xjD/3U=
X-Received: by 2002:a05:6902:c0b:b0:dc2:1f53:3a4f with SMTP id
 fs11-20020a0569020c0b00b00dc21f533a4fmr750553ybb.5.1712687965237; Tue, 09 Apr
 2024 11:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409-qcom-pmic-gpio-hog-v2-0-5ff812d2baed@z3ntu.xyz> <20240409-qcom-pmic-gpio-hog-v2-2-5ff812d2baed@z3ntu.xyz>
In-Reply-To: <20240409-qcom-pmic-gpio-hog-v2-2-5ff812d2baed@z3ntu.xyz>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 9 Apr 2024 21:39:14 +0300
Message-ID: <CAA8EJppzfBbTi7htJDmMowtXXTi3ASfzQpEpkCjPngBFH=TE-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: qcom: msm8974-hammerhead: Update gpio
 hog node name
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Apr 2024 at 21:37, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Follow the gpio-hog bindings and use otg-hog as node name.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

