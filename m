Return-Path: <linux-kernel+bounces-71922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D01785AC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A340282592
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B6551037;
	Mon, 19 Feb 2024 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zlKLk5Bx"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE474F1F5
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372553; cv=none; b=FjHTIgmDynkWhLcUL5fdHU9JuwKxtrGKKajtpvFG7kBsyiN+6emABp8e922IQYwnwa+L7FYM3RtjpnA8nqXeERBH0efI2RIvXxinU1bofKfFfzTVt4cSg7JQvAU8F/JGuv8LH/Q7GDydbZnBUh5rP9ob0G+eqfI9x4ks4FYg8rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372553; c=relaxed/simple;
	bh=8OKl41Wc+X80Yr8sNThOn8WRf/IkQK8EP6oDeYEVzfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rF+LetVer/llok2HvVmqz6/JsPa8cALnLRwGBycVISC2nYsR8Z/KOLfyifeamEO9VZV9fYPrxNm0ORYSMW1FelKqISQGX104mwBGNPNm/wS4oHOmMGPHssTW2h+0Yd/ZNs/S4e0LqO85tO/6Wvo726IWAzJJ9q/JxPYj7cWLrgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zlKLk5Bx; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6818f3cf00aso28001026d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708372551; x=1708977351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8OKl41Wc+X80Yr8sNThOn8WRf/IkQK8EP6oDeYEVzfw=;
        b=zlKLk5Bx5qV8ZRs9WwK799E2imjQoywr4LoZhjnL3NOaBAv2H4dnsTkaSw4yFGQ0VC
         gfyxL7jclaKOC6JGmIJRp3am5tfxYWciy4G/LjBT6d6ZjdOphH5O2+DuXtI93pjvM5Ki
         3bWejXzmNUJrQ3STIAN+CqoNW8lKbkCtznm9HzvP4ZR/XWSHveTVYsnoF1Ww6DYseAx2
         IWxMxvGblRuzyGdTqeL2GJUMV68b+kpzXQ5j89Asne3UVerkWi3fli8z8BL34P405ZzZ
         kuq0EfshsxtSQ0M2Dwz1POm/I2WyoaNqrUlS1nYyhgY0HVhfLJvvXKEiQnj9ys5DFg3q
         WQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372551; x=1708977351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OKl41Wc+X80Yr8sNThOn8WRf/IkQK8EP6oDeYEVzfw=;
        b=X5MRtTYaAMyLB4QNhqAVaERPH15iM29+mOun9CgCUJ9I2YSTRA5iKLUXBrXrBjaoSi
         8fOEwlg7+B9j9AXL9j4n3dpPr0Z5JmQ56ZIW/FoRgfidigRnqtd569YWu0n713YoaiFL
         tdGBUGAWlD7GiJqgtByaI39aSTFKbrbrAE5NMU+3muqGJqjP4LAm+m7W9lIYLBTJRbXp
         Z+FeuoBU9VDPhR7MzT5qrZTjE4YMr04HqBpaX3qaSSvyUD3Qbu7v9MzARpzAlJ9BaKFE
         nFeCAKaNeONInBtabxmcbiOa9K5WFT0IWKwBpeQvSzveaLRDSe33UlJq3OpII09BvpIz
         Kl/w==
X-Forwarded-Encrypted: i=1; AJvYcCV96WBkkk8b5Sa/jnT5pWaVifrBO/gEAvuCa1X82X3N1NaE7QCiwg4/tF4ze3uAu/YTuRwEj9XgjJsfiFyDYxTLlFNHxYnAglm/K68w
X-Gm-Message-State: AOJu0YzpG3rCH1h2ML82om0xvHy1p9KnpcNsq9qRNdoBtjfYzLl4P/fB
	bRgx2p4RCOQ/T/hhpvQL3njYljORwQSWz/EhdOJ7XNWBrNvUl7p4WkDZ1jeaXqn3AxHoAZjKGjk
	b7E1IY22hP0rQ8glOaiTzmwDe9/rgoeQ+eFTzNrGxpcgxi0Ncx9g=
X-Google-Smtp-Source: AGHT+IG102p+3tJPXw/wv5GEecEGDJ4yNBwcwvEeNuhkzfGBOzbwgyL9AORHgu7VBoaPB3l8XOP6sTuKS6wMjWiNBq8=
X-Received: by 2002:a05:6214:2687:b0:68f:3c39:c63e with SMTP id
 gm7-20020a056214268700b0068f3c39c63emr10578054qvb.6.1708372550871; Mon, 19
 Feb 2024 11:55:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219125453.103692-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240219125453.103692-1-krzysztof.kozlowski@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 19 Feb 2024 19:55:39 +0000
Message-ID: <CADrjBPq1X2P7hTqSiTnZ03c_QguTQ4kbFen9MeWh5TaYn9fh-A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: samsung: gs101: match patches touching
 Google Tensor SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Mon, 19 Feb 2024 at 12:54, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Maintainers of Google Tensor SoC should be aware of all driver patches
> having that name.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> This allows to spot easier such weird drivers (weird because they claim they are
> for hardware, but they omit entirely hardware part) like:
> https://lore.kernel.org/all/20240219061008.1761102-3-pumahsu@google.com/
> ---

Thanks for this, I hadn't seen the series you referenced above.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

