Return-Path: <linux-kernel+bounces-109895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4E9885777
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2DE283960
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4672956763;
	Thu, 21 Mar 2024 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYFXpi9V"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05856751
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711016964; cv=none; b=oQB6eXzk0fdMEaADEUjqeqnTEueESCYlr6Rkd+OF1MC8ZaAcxf/maWbFm4FB6Ic414oYrVdQVUxwB7pP7FLgaEn+15qJHh6/szbQybdjcRMb0w7KeZsORGnh/N6y0e3PQ9I3vGo529qT31e103zJcxyK+ZEe77F4bWbvmCKXB7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711016964; c=relaxed/simple;
	bh=lr/ld6LZKki83QfUyI11Gr3pibctAzUl0+BQ0vKyXpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjH3jk0165+l7jRdWeGnBWyt4fI4sGxpBYwp7gKBJ3zGHd+tDD1B9r3TxdGOkUzfYpI1bXfH+ofwwN3BAc37pgWXqRuZnAdPpjydeB+rBCBvbFm/znqUWnzJb6rmnjgVxCMEUTr5QaZCXAdqiagUS3zQqiZMrYO0+6Yw1SBrWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JYFXpi9V; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so660308276.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711016962; x=1711621762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/sfGiMQOWE4qVjOwgz/wWhsIkX2dxibhY6pkQCwewf0=;
        b=JYFXpi9VN51y6ahg89/j8fUJONXl7O5g1SmSnlCMeUTWqg0M9G9WzflKjitpxEawpk
         85DphiFxO4qw2W5J4icoTfIbZYlAnvDLphOew7muUpaRrvi/NtP9gCkp6L1l2ACTtXst
         K14PMpkoZTozxxm8GIp1HLY12hIteHHh9MH/cvT+I9Hu6Nv92aiTJpwn+WVUhjDSJn/z
         skdz7xBa4J8HavstvE5XqxIv16fMrEpJKEuSc/iu71ozmuyEDggIP/svJYiHul38ptMx
         P1P7XiYf2LaoFjSjq9F8bxVtk5xit9jgJj59e7pVFB3HO7uLbpKQ9vTAs+7puKpFAi8v
         3mJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711016962; x=1711621762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sfGiMQOWE4qVjOwgz/wWhsIkX2dxibhY6pkQCwewf0=;
        b=Bo6qYpIDyrbYYCZusxAcZXnxv6eKpQT6bAvcRBdzo1Y3jqFjXG8L59S95q93dahK/c
         QtypmYwspyi1we/MqbCtF9IzNspf98DJedW4EVzozOxtVWhDXkEYLU9NA6KXp1nnB4LA
         2OVF/H0nGgqYabc8YtZ6YMaYC2aSF/dhwfsW5UaUyNW2UB5agj2+CIfjk45v/Z2lQlee
         4yjBf3lUF6+UB8cm2bhYtvvgzkEiEq3sIDRsoqxXQgkneoLjaXVif23zYp1CdU1WkbYk
         wLhBF5bMrh2dPLa6iQz7Sd8MpDL/g/8wHG0rBpnmYOWzXAvkgcekj4bC7HuayvRAu5MA
         YojQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFzP6MwDvDYU9yAk17hBcrSpOWmoybioX1saYpExe0NvwyPwWX1ToQHVQoeylYVnpGB7GfPxFy5TH6m+XspI+N3f6wGQk+HDF2QotW
X-Gm-Message-State: AOJu0Yz3Ad3j8IOrstq0k48pQYOXXJNHKHI/5g/AXmkvXYCMM5cfvkxm
	wYbun8WLeVN817DY6COJESO/qBvf4GHCR09uOq8mCSMQIhMNNynthsyjATrI9cEX4ooQmUjyUAn
	/Ax2jJjTTTf7BiwvdKmI346d1/kbdWLApb6nMxA==
X-Google-Smtp-Source: AGHT+IExbdetzQ9xDBaxa779Os0rcJeKqehsNC5UOgPnByKQYAfthML80JKoXGc0ZMbS3XGvTEwkkqHMcTzwiPZ6/J8=
X-Received: by 2002:a25:b502:0:b0:dc7:4564:fe6b with SMTP id
 p2-20020a25b502000000b00dc74564fe6bmr4133015ybj.60.1711016962076; Thu, 21 Mar
 2024 03:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com> <20240321-apss-ipq-pll-cleanup-v2-5-201f3cf79fd4@gmail.com>
In-Reply-To: <20240321-apss-ipq-pll-cleanup-v2-5-201f3cf79fd4@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Mar 2024 12:29:11 +0200
Message-ID: <CAA8EJpqRs81-8wdufLcNFWKpAkF2=d+6TrOApJNOV2XMcYAT1g@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] clk: qcom: apss-ipq-pll: constify clk_init_data structures
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 09:50, Gabor Juhos <j4g8y7@gmail.com> wrote:
>
> The clk_init_data structures are never modified, so add const
> qualifier to the ones where it is missing.
>
> No functional changes.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Changes in v2:
>  - no changes
>  - Link to v1: https://lore.kernel.org/r/20240318-apss-ipq-pll-cleanup-v1-5-52f795429d5d@gmail.com
> ---
>  drivers/clk/qcom/apss-ipq-pll.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

