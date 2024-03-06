Return-Path: <linux-kernel+bounces-94507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CD68740C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D831F217BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B62A140E29;
	Wed,  6 Mar 2024 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4bYcwU8"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D3013F437
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754636; cv=none; b=VOVoNMTEogSpKKhYs/4yRgiY5uUexpVhob7N+/VjBF6XTdx7Nvy//qHeCu4KS7G3uv+jIifKTTyc57DP1WtXSvS0J5M8aPJC22rhjZWbvCUAouLhydsMd2NOWo5djesCyhLc2VFbENWE0gdd3Ha9L8b4liNgeyevstsp3PgjjbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754636; c=relaxed/simple;
	bh=J/J/WYR0a/jfL/L8CmcqoJd0/LkmdHVXKLnGZM35uAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRJ88g3J0UFw1wDEnMN/OiCr6Y3q0M3zuPK0BRVe7Ixzfj/EFIvUR7FTzVPiwYy5jY7/7bH824YzcORp0YFnmgi02pCyk+zuRMc2ny0H3jJm4juiXSnr9Fk+xGLFvIBJJaaUlL1ybS4YknZ5wgLdexgkae+zfgnYXHfIODHHdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z4bYcwU8; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so39153276.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709754634; x=1710359434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XYqVqYpwYt6rNIG76DtvSNsSsOOOlu66e5YGMr8JNM4=;
        b=Z4bYcwU86sOwtH6K6/+Sbkt+PgwbvwKMzcHZsWI7M6tYKURQr3oQ22WCNfWdb9j5B3
         4D+nwNP87Xs9lOHg1NXBCMf3sSj7PEXQxp31pPjS1IA5gHBSepO7qsYfJMSUUIxcNYQe
         TSltAQp6FD0E5zGO7MadSNwCCbqeDmuWUtLml8VN6agw89Oy7Lyi6sEfvwZ2NMF6BiZ6
         q9wh1YLySyhb1vYiUFXGmuyxFE98GxmOlAHXXHXoP/FVGKLedUsne+UHRP0qk0GQJy1y
         xxrXDCnpmK2wTWng74G9AidBXpwqpKti4O29edVXxDh4WdTveghboA4ugaMz21Tk6U+B
         dwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754634; x=1710359434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYqVqYpwYt6rNIG76DtvSNsSsOOOlu66e5YGMr8JNM4=;
        b=ZR48yOxDyxxnKOnWWno34JLk/ZD6i9FrGDXbwAYO545nVM6tvK/HbX5rMva5nx6R3/
         Guv646/6Do/DJwQ52uaSmjGtQLB94o6H4Sb6gisBFvZlWgYaXBfrtrKUkFRIY7rVFTAz
         OxE2kjUXgpO0Y6RRbN5rAGOcfUNW14fdMnuDKZ4iW4f7q//p88yqytb2HUjaL3muzHM0
         digzOYpoUG1jpn4GjQMCM/hjeg+dhFTkerQBk7kc3HRu9DhgYeyZ/m1fzdTDqW1VMA53
         bIFmE9CjkTzJJhrbvo/Yth3CZVkDoIVuIh7cx1Ub5IVeb+SG80FlwaxhIe5e9PP8jmst
         cGwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCkxCxwTp6cw/inFYg+u8Gxd70wExCkz1zipObieNn8gTS7LTEfkeRBm+/WVrA2RXYFwypDjSaTOrUE8r15GDwgUIC4PCKijR5uSSN
X-Gm-Message-State: AOJu0YzwZXctXg6zVVB87/+actY3TwdAbPvZsv3eVtep2Y4V3IQZ2fNW
	eqLwXxp5UVjGA2ff201AFUWeTrSYPYOzZzBxIahHhWlfllLhbp45AzD68nDOlnVdYOle0qV5wpi
	L6nspDX3Q4cFX3qfIhsTAWtdaSCjc/8wBUbdkng==
X-Google-Smtp-Source: AGHT+IFCY6UXVEeXo4Ge0RRKwR7IuVdrQnxEw4oe3yP+Y7OxURs32fyQY0uegRM9q9PXK/Gxa7fam/d+oeVVOvQQAJs=
X-Received: by 2002:a25:aea7:0:b0:dcf:477e:c82e with SMTP id
 b39-20020a25aea7000000b00dcf477ec82emr14974521ybj.50.1709754634018; Wed, 06
 Mar 2024 11:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306172710.59780-1-danila@jiaxyga.com> <20240306172710.59780-3-danila@jiaxyga.com>
In-Reply-To: <20240306172710.59780-3-danila@jiaxyga.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 6 Mar 2024 21:50:23 +0200
Message-ID: <CAA8EJpo22Pk-6zPWEhVjD+HbYWbmsYNm-ZuurOQ2KVw4=0dC3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: pm6150l: add Light Pulse Generator
 device node
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: pavel@ucw.cz, lee@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 19:49, Danila Tikhonov <danila@jiaxyga.com> wrote:
>
> Add device node defining LPG/PWM block on PM6150L PMIC chip.
>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  arch/arm64/boot/dts/qcom/pm6150l.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

