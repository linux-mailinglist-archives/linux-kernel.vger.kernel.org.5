Return-Path: <linux-kernel+bounces-67033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F4E856516
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15EFF1C246E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229E3131751;
	Thu, 15 Feb 2024 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOJ2yhtT"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A988C12FF72;
	Thu, 15 Feb 2024 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005424; cv=none; b=HH2eNRMC6ulvLl3Fh/ybmd+27pBtggyAFr1tcU3x1dtVMw1BsnXY2lWspST3E+QSH5R5lZMtnxSJs+Zqp5I+Rvt/hGiPgmtdGIe7mkHZ/4DgJLk6PON2cz/uB+H6Gn91hhZHIvz5+Wu8ZEWvmvcuDfTtadJbYplk2m1ryiUJgdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005424; c=relaxed/simple;
	bh=fMrSiHEqH2oACTriTLR2RCLr7nCENDlRjSvlkn4SbkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaZgh7+hYZEbP5+lzzFGX9sxjyverVhPwiaX9iaI+KNfswBASvEHJKVpR3Lsw8NgJCABqeNqxibDo0a8b2z9CHE+9QVlcP/3SGY1dQN9ELaLz9iKHSZZ6/0G1H1EFFTJyhdYPEVqu8SYnA8qMUaMfZTObh2FWa9pd1SyQrhJxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOJ2yhtT; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0f7585d89so11063001fa.3;
        Thu, 15 Feb 2024 05:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708005420; x=1708610220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBttmjDDaofneeagqypVCgYFojO4GLtZsNzeW1YFvaM=;
        b=NOJ2yhtTAhbCcArVl+niLM4aAaT5iBglGvJs7aMCYD45Xe8aThNDRytMLRBb0K210v
         BbvR+DBlcN0R+0eAYbzqotQKcnf4F2yJT8wskrTU77cAyOs0AyZqzXFA4wXsjMebds7w
         U0fGudc3KtecLxB05+WF3tJ5kc6OpoIca0g2PDOWYnXwTHxaAu48OL+stCrPNWPA4RKe
         AY/XzOu2j/Xyn1iO3/jJu96Pf/eVEttTxcPpzPSp3yPWh9rZpwMMhQ1neb978yHapHy0
         4oPbTcB76w9mGUz8YwNRLyZe5tyXYVGsRyevE8uPaUx5/Sblj9eBZlNEpze0Yf+xeBW4
         XZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708005420; x=1708610220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBttmjDDaofneeagqypVCgYFojO4GLtZsNzeW1YFvaM=;
        b=PXGVSwAKZoZgackcpGJTtnbBceBfqNH+I9LlMyyhbXXqI52PYqNxN73jS7DD6oePV8
         kvJXo2S3//BrQrwu3vV7blkfC+ZT8i9ou209vP+Qvi1xpSvau2lUw2uPIqYV5yxnSf7y
         VZZEl+k1j/a3RsA206ArXPQWiv+qlW9fMS+733sBZlSzl682oBiZbekyoh21N6LMJ9Ig
         MaN5RdmXNUsmY+kE+8Xb218xODYT6Q/7GUgWVvxkz+yWPVa6TtsJXLGrG9ujsksrTi+w
         502BXeqNwhUiaa4nJ/S/OgfH9JIAVg+thoPRvVAMpFLiTO8EI9eDA+X/PDB9RFNe4gKs
         9wOw==
X-Forwarded-Encrypted: i=1; AJvYcCXU0UwlI7Nl9riYH+nkRyr04FRaHssXNPzXZEaTZpaiEjKne1EniCeJMZQLIFg/rnqCpO5RkR1f9YybjEvtMLbOWcg02iN1yHI1Cj/aHekABbJiuh6wuvSgnN/RkCyq4yHfDrplng+UZavDJqUja6RUvmZk4cv0ZvkqaEgkQiyMxKzwGvT6+k/j
X-Gm-Message-State: AOJu0YyahoD0nU2jOVrGNeSr6eoa6jQa629n2ETBnLjbMaSSiJF7dPEV
	QfUrwUQLvP62SeVItCmWujbuC8REeei98QJFFUJrLGLuy0HFrYU0sV+JyUne
X-Google-Smtp-Source: AGHT+IF5OeM1u8aUPGMYEaWcvjmMqv+dGKbe/bDUjIRJeaIM+WBEyiWaWkzWnncJOAVRcR6xJYG14A==
X-Received: by 2002:a2e:9995:0:b0:2d0:cff6:1141 with SMTP id w21-20020a2e9995000000b002d0cff61141mr1257466lji.49.1708005420387;
        Thu, 15 Feb 2024 05:57:00 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id y19-20020a2e7d13000000b002d0a8143f31sm295755ljc.50.2024.02.15.05.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:57:00 -0800 (PST)
Date: Thu, 15 Feb 2024 16:56:57 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] spi: dw: remove redundant assignment to variable
 len
Message-ID: <5gltmtohx4t2eubmlxjnflba7ydlnbj5wej67mh2kjjy3vdmsl@2ggv6iddskav>
References: <20240215131603.2062332-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215131603.2062332-1-colin.i.king@gmail.com>

On Thu, Feb 15, 2024 at 01:16:03PM +0000, Colin Ian King wrote:
> The variable id len being initialized with a value that is never read,
> it is being re-assigned later on in a for-loop. The initialization is
> redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/spi/spi-dw-dma.c:580:17: warning: Although the value stored
> to 'len' is used in the enclosing expression, the value is never
> actually read from 'len' [deadcode.DeadStores]

Don't know for sure now what was my original intention of having it
pre-initialized in the for-loop init section. Possibly what you
suggest to drop was a leftover from some another version of the
function implementation where the re-initialization was required. On
the other hand rather weak but still a justification of having that
assignment can be a maintainability so all the basic loop variables
would be safely pre-initialized before the code block is executed. But
in that case a more correct value would have been "xfer->len" instead
of zero. Anyway let's keep the code simple and drop the assignment.
Thanks for the patch.

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/spi/spi-dw-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> index 0ecbb6c36e23..f4c209e5f52b 100644
> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -577,7 +577,7 @@ static int dw_spi_dma_transfer_one(struct dw_spi *dws,
>  	sg_init_table(&tx_tmp, 1);
>  	sg_init_table(&rx_tmp, 1);
>  
> -	for (base = 0, len = 0; base < xfer->len; base += len) {
> +	for (base = 0; base < xfer->len; base += len) {
>  		/* Fetch next Tx DMA data chunk */
>  		if (!tx_len) {
>  			tx_sg = !tx_sg ? &xfer->tx_sg.sgl[0] : sg_next(tx_sg);
> -- 
> 2.39.2
> 

