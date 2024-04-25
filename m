Return-Path: <linux-kernel+bounces-158887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F028B264B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1EE285320
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870D814D444;
	Thu, 25 Apr 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUqpvLz9"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9B114D42C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062145; cv=none; b=beVwQGR6eoq05oEgjksBPs0lZg4tOmqrlMj6NoRaw/v9gFfZDlQk3ldkOlaWRS5aKXENW8ImCjn3ZExhgRhxqcm89voL2kaYMRWFhyNRcOM6RHyjURVLLfI7SOYtZmelbfO0yR8KYIZt6oblKQxgbg2iFv2V9kkWLZxzXSnK+Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062145; c=relaxed/simple;
	bh=+naKcIk5EvH6BPYm2Cjrzgy9Fbzr4w1ZLSAaG7qX8IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ol6BXpjvY8P7Sj8cD5Z6QnMzSEqkQ9P+NLmzXa3WBSzHZ5yHUooqt7xrGbus2IS2qPQUNQu1LbQ5pT+ys5ZcbhzhYQMqVF1U5CoYmHBWmw+RnyANiXpmJDEUkr3w6feIjqg+gCayD8M1OB7OpUWAdX2TmYkodSH+QuVAmNH+pbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bUqpvLz9; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1284196276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714062142; x=1714666942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uLxrhcQ9oc44OMZc8b5Iq8eE4NFzuTcQxbVwCcXluvg=;
        b=bUqpvLz9bsxLTCDE07ke0cqh1yMoBKVFRmjI6B69KtshzMntZOfkCc8XGXKwoiwSYn
         KaS5VpDEcM+a9Nx3oBNiooP1EiDj6czchZnSLikZ1N8vmtLBGy9a4cv9H7f1JDeSt/dQ
         KdnrIbvtVfN67jSr4U/LfZHV/QJa6hCAzOAuWu7k4IQiFvEZvmtCs+dlJ8n2RG8G2uBn
         CQzBwUHniIk2ZThuM7MsVUJcRo961kU5acB133pZ3c6jaTsoBPkI+r4ZSZb/GxK8w+15
         wczQ3MnmasOx1mrwhtyz3KC+LS93hgK36dYdi+U8S03T50wzHb1X8clG0x8RIyjexmL7
         dc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062142; x=1714666942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLxrhcQ9oc44OMZc8b5Iq8eE4NFzuTcQxbVwCcXluvg=;
        b=NpbUeswftVQFw76K/vIUBdyimrXMn74EC7fkmzkbhPL5fhurUyxVezgOrEqt+0yc51
         co5iJLj/xwRqfCc9Q6+2oqJcb15CKmWu6N34woBn732hLbjZklMIwkfW+yMLXwKtijo2
         ZBw/cpTHMoDRrtQ4KTGmKJgIKeMhx+zEow9DQ/keGYG5VtR+/YdWPN7355Hs9+b76flZ
         0Kyb/M0tV0HpFbQGQRX+zSMBPqWvOYsQoi42ihV3RnzGFBIv9jnmyZ7jisK4pMWVP1m+
         136IExA2WPzmsIyOW7QWnZ+P0wDQoJUD4NDeT7UkpT2l94uPLsH1uhyv63R7MCVkM8ml
         y86Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyLxF5EQ4zmjegr8AIPMjzSOu7aW0zaBunoY2q7L9WaM7jjWER/nC34yFbtu3FYVJ5z2vZqKE9I88bBmT7hmCVqFTMJe+Z0lKmriIa
X-Gm-Message-State: AOJu0Ywkpfckpg89c7a1cDpsbZSPzd2jvtRQ/SHqWGMyF2ARGJbK47EB
	eUE+ixNVnmPO6kl4G08/83JU6nLnXrWo/7Sflyng5Vzj7fqRD89gcRvxTNKP6yGQRAA6SjQEey5
	eF4k7wsRMQaGqYdB0LJgo7zyAEcezrKhq72quhQ==
X-Google-Smtp-Source: AGHT+IFtKn6b6GJpNn67zl9+P4j1OLHkcP6FUpJ4JOoi5sUsm1euCeUryXi8PiHOutOriprJEFlsIAFazJXA+fzp6kc=
X-Received: by 2002:a25:bfc8:0:b0:db9:9134:bb28 with SMTP id
 q8-20020a25bfc8000000b00db99134bb28mr137095ybm.4.1714062141958; Thu, 25 Apr
 2024 09:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414-mmc-const-sdhci-ops-v2-0-262f81faadac@kernel.org>
In-Reply-To: <20240414-mmc-const-sdhci-ops-v2-0-262f81faadac@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 18:21:46 +0200
Message-ID: <CAPDyKFoC1fSvWifKtFV9D=hNkGuOL7eVnDdw2ZGVedsYrombdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mmc: Constify struct sdhci_ops
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Angelo Dureghello <adureghello@baylibre.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Apr 2024 at 16:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Hi,
>
> Changes in v2:
> - Patch 5 - sdhci-s3c: add __maybe_unused, reported by kernel test
>   robot.
> - Link to v1: https://lore.kernel.org/r/20240414-mmc-const-sdhci-ops-v1-0-178539d68093@kernel.org
>
> The local struct sdhci_ops can be made const for code safety.
> No dependencies.
>
> Best regards,
> Krzysztof
>
> ---
> Krzysztof Kozlowski (5):
>       mmc: sdhci-esdhc-mcf: Constify struct sdhci_ops
>       mmc: sdhci-omap: Constify struct sdhci_ops
>       mmc: sdhci-sprd: Constify struct sdhci_ops
>       mmc: sdhci_am654: Constify struct sdhci_ops
>       mmc: sdhci-s3c: Choose sdhci_ops based on variant
>
>  drivers/mmc/host/sdhci-esdhc-mcf.c |  2 +-
>  drivers/mmc/host/sdhci-omap.c      |  2 +-
>  drivers/mmc/host/sdhci-s3c.c       | 31 +++++++++++++++++--------------
>  drivers/mmc/host/sdhci-sprd.c      |  2 +-
>  drivers/mmc/host/sdhci_am654.c     |  6 +++---
>  5 files changed, 23 insertions(+), 20 deletions(-)
> ---

Applied for next, thanks!

Kind regards
Uffe

