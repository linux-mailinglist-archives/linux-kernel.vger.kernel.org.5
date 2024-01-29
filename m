Return-Path: <linux-kernel+bounces-43643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880EC841725
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FEB1F23C55
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BBB5380F;
	Mon, 29 Jan 2024 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kJb/H+Dy"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD6524C8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572211; cv=none; b=f3qZxrtiWi2z/ZkLNml1cTBhDp2UMv7GRRD9Dp4f9iVL9o3V/S5uab1hL4/gqVbiKr2Xfkv7/w3rp1wmlMcW5gT6tU7lEC7kt/Mx7V8eBONQnXhRzqmdg0aTCQCR95/EzPQ7+aZ9rGxDUA1ciZtNKXBwMCiaPfTiG6E3f/h7TlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572211; c=relaxed/simple;
	bh=UBzKAjw1cx6u8YMuRXY/IgE9Q07ZVbkxH/j/6WQSCcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWe6kq2OrzUP4NY/dtGpNlWo/kkVPk8yf9WudhupPs2q9V3RJdq68DJsK0cP74/2Fnhumj8eOp9ZalF9Hpgf7HbQnWQecN68brdnLBLvtB4HEiurvnEib+Z1oxm9RYtTvbT6kg1G6LgjC9LNR2QsuUOtT3KOzgEKKMIWyI0e3JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kJb/H+Dy; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5ff847429d4so39792267b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706572208; x=1707177008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T3Y1YC77PE7gg6RUxiLjcwt8G9i7hJpA6mB4vW7ufYU=;
        b=kJb/H+Dy0eUw0mTUGlUwL8KHDRR6bJi1XWcZY364O108a4UDr2MenBFk5UtRXDDAXP
         28bYhoy95CxustMZK78vZi6htBtXvfTvQziDrSeFSzakcO8GIFmNhxqOKuWjg75ohVFi
         YUku3nbG0oclTgQIPdyuYeAJokcVsztujTo24VM8QpTvkZ3RChv54l6MwP7P8KBQRKJx
         GlE6zDKuFGWWBrRf4vfhaNMINEQQadCqPI7PzZRcME50RhcsY8PRaIJIAHGZJctAdto6
         LoybIBNnC/r/AaM9sJwNCrKzIF/MRqVnvtAVvICK3bh7oXEEgYGY7hII8BbeZPQn/PKM
         /x6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706572208; x=1707177008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3Y1YC77PE7gg6RUxiLjcwt8G9i7hJpA6mB4vW7ufYU=;
        b=TpFEGlzlhfgQcNjeJmy0iXxo3FEQnz2jLkVObs/s17RBV1stg5MjKedDw/Vc30YMua
         iZL23Ktqy8Z2OOOThHj9y9f3fioKZEpJOkrHJjMzBAdkL2s/hfs+N81gK0mcbw8+xnxa
         mlfm40+4qfxX7jRFJaPa+UGgjnAF5uGSqyC/GW0ta57laZr1SfL0NptnBmdI1GWlWed/
         UR5odaFJF1srGv/AkPeTzlYxwkJCHIyN7INGAa/45jNxSZqw37/AZkBNq3wrLDLUHPfg
         T9i8/VAQ10Ld8qDxRj7DRcoM98e1LbgcHzULtD9kVxc9gwaQSB50UXViQsxWKBPYCZGo
         QiTQ==
X-Gm-Message-State: AOJu0YxsFC/Pi64zQeF5zC3ccMXgjMCE5q8O3mnxoyDfUT/1pg1oGizy
	P/xFuPossZ7L4IE7aCe4qcCilvAEKjv18ot1vLH5m6i88vdaEW+J1/xEh7wLjoS8xwK7jeKSKQZ
	tTzLxok994FEoHH3gCoars18u+NQWh4xLsve+Ng==
X-Google-Smtp-Source: AGHT+IHY4mRLGmiqbzZ+aQNi3H8Nb73QQbbBMg6ZnaSyjyc4iEXN4mPvFUhRRKJriADaKhFaHy7DTlLQf5hCWRAtd5U=
X-Received: by 2002:a81:c14a:0:b0:5ff:6ca0:4b19 with SMTP id
 e10-20020a81c14a000000b005ff6ca04b19mr6109145ywl.31.1706572208292; Mon, 29
 Jan 2024 15:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129061003.4085-1-quic_vdadhani@quicinc.com>
In-Reply-To: <20240129061003.4085-1-quic_vdadhani@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Jan 2024 01:49:57 +0200
Message-ID: <CAA8EJpr_KXsjTUYha7OVg4HLLJLqMRvJun9DnMkBFvq3R2nk=Q@mail.gmail.com>
Subject: Re: [V2] i2c: i2c-qcom-geni: Correct I2C TRE sequence
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, andi.shyti@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vkoul@kernel.org, quic_bjorande@quicinc.com, 
	manivannan.sadhasivam@linaro.org, quic_msavaliy@quicinc.com, 
	quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 08:10, Viken Dadhaniya <quic_vdadhani@quicinc.com> wrote:
>
> For i2c read operation, we are getting gsi mode timeout due
> to malformed TRE(Transfer Ring Element). Currently we are
> configuring incorrect TRE sequence in gpi driver
> (drivers/dma/qcom/gpi.c) as below
>
> - Sets up CONFIG
> - Sets up DMA tre
> - Sets up GO tre
>
> As per HPG(Hardware programming guide), We should configure TREs in below
> sequence for any i2c transfer
>
> - Sets up CONFIG tre
> - Sets up GO tre
> - Sets up DMA tre

It is not clear how this is relevant and/or affected by swapping
I2C_WRITE and I2C_READ gpi calls.

>
> For only write operation or write followed by read operation,
> existing software sequence is correct.
>
> for only read operation, TRE sequence need to be corrected.
> Hence, we have changed the sequence to submit GO tre before DMA tre.
>
> Tested covering i2c read/write transfer on QCM6490 RB3 board.

Please read Documentation/process/submitting-patches.rst, understand
it and write a proper commit message.

>
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> Fixes: commit d8703554f4de ("i2c: qcom-geni: Add support for GPI DMA")

As it was pointed out, this line shows ignorance of the mentioned file
and of the existing community practices.

> ---
> v1 -> v2:
> - Remove redundant check.
> - update commit log.
> - add fix tag.
> ---
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 0d2e7171e3a6..da94df466e83 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -613,20 +613,20 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
>
>                 peripheral.addr = msgs[i].addr;
>
> +               ret =  geni_i2c_gpi(gi2c, &msgs[i], &config,
> +                                   &tx_addr, &tx_buf, I2C_WRITE, gi2c->tx_c);
> +               if (ret)
> +                       goto err;
> +
>                 if (msgs[i].flags & I2C_M_RD) {
>                         ret =  geni_i2c_gpi(gi2c, &msgs[i], &config,
>                                             &rx_addr, &rx_buf, I2C_READ, gi2c->rx_c);
>                         if (ret)
>                                 goto err;
> -               }
> -
> -               ret =  geni_i2c_gpi(gi2c, &msgs[i], &config,
> -                                   &tx_addr, &tx_buf, I2C_WRITE, gi2c->tx_c);
> -               if (ret)
> -                       goto err;
>
> -               if (msgs[i].flags & I2C_M_RD)
>                         dma_async_issue_pending(gi2c->rx_c);
> +               }
> +
>                 dma_async_issue_pending(gi2c->tx_c);
>
>                 timeout = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
>


-- 
With best wishes
Dmitry

