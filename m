Return-Path: <linux-kernel+bounces-112704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32046887D2A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6C8B20FBB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A385E182A7;
	Sun, 24 Mar 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CznqUHPl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB05C18032
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711289083; cv=none; b=GCcGf20sySnV462Jp4R0C5AYA/87MbN5AspYz+mL4P4GkIlA6FQn4GFuROfbXBf/D5EJuP38uNCXM9DPhc2GY2fqsIxoMS+GEU+01DPPpStAQujSZHZuxPs+0WJVe1RPsyz4tH9OLVzaYUWhM+dDsEnFSc+tYCeq7uSzMbBSVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711289083; c=relaxed/simple;
	bh=Kspn8gzhUPZ9YM9spyq9jZwQzCKtXO9aU6dyN3b33zs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFzmU4aI9vda8H0BtPeb416efpksL3eCROkqkt3wuQNhkJB9zTo+EgFQG/ym/5VdhjMLUE2Dt7lv3Wn7pL9lC7OTHFpG9nnWMJVCeql2i6nA0z+nOWLlJugXeh9qQvuRByxRkcxyGhYFZ02PdOeuh355S9MtQolmRS2NtiIREsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CznqUHPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29768C433F1;
	Sun, 24 Mar 2024 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711289082;
	bh=Kspn8gzhUPZ9YM9spyq9jZwQzCKtXO9aU6dyN3b33zs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CznqUHPlE7oJ3pKMWNj1e6aI+DmjnG6tA2+NLcZk0Ifw8NJtLxU1Y+fM0CEA7Jowl
	 8M9ZAdg0wvsyAbh9dWN4GBPlcbV1iBJdfE6mosH16C5GYT4y4ggJCnvcIKpmkRWDjz
	 rsHvA3gLVDwzBCCfOF6Dfb1Q9Tkj4i6APWUvrkF5PiKHn7Vilk6ZljPUCv0ZUp73rF
	 iS6SEcmmzPdRXrYRUC8svH7Cw9yTcE7vLMrdZLOHsiNZijid3nFRDblMI/SwkmaeeK
	 4kswhZhdtRjRSBcCPmsYGT7PMMxIDoI1d52R4Z6ECjf7xNyGNcQHWLJ8V5b/74CwGc
	 u0Zj9aotlwvBw==
Date: Sun, 24 Mar 2024 14:04:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, gnstark@salutedevices.com,
 neil.armstrong@linaro.org, lars@metafoo.de
Subject: Re: [PATCH v1 0/3] iio: adc: meson: a few improvements
Message-ID: <20240324140429.5484eb54@jic23-huawei>
In-Reply-To: <20240323231309.415425-1-martin.blumenstingl@googlemail.com>
References: <20240323231309.415425-1-martin.blumenstingl@googlemail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Mar 2024 00:13:06 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> This series contains three improvements to the meson SAR ADC driver.
> None of them are meant to change the existing behavior. The goal is
> to make the driver code easier to read and understand.
> 
> 
> Martin Blumenstingl (3):
>   iio: adc: meson: fix voltage reference selection field name typo
>   iio: adc: meson: consistently use bool/enum in struct
>     meson_sar_adc_param
>   iio: adc: meson: simplify MESON_SAR_ADC_REG11 register access
> 
>  drivers/iio/adc/meson_saradc.c | 78 ++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 42 deletions(-)
> 

Hi Martin,

Please resend +CC linux-iio@vger.kernel.org

I'll take a quick look but I won't pick up anything that hasn't been on that
list (as I use patchwork to track status etc).

Jonathan

