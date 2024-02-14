Return-Path: <linux-kernel+bounces-65272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (unknown [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC8C854A69
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF0C1F249B0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DA355C04;
	Wed, 14 Feb 2024 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m6Jo1iSq"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5054BFB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916980; cv=none; b=ZJf/XZ5eYyitkqqPWKGjdKI457HDVYbAB7c1aGAdFxOVP48q/itrRoEYYIb+BjmuTBbgaBjibam7fyRxkcpfPfmjp9w/YRfCM1kZdmsN8BJTrpG5CwXRXC2lvpPEOwtVxYP7cqXUp0QPUJVVg9bdIS7Y6VUcbQkxIJWgsoBBpOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916980; c=relaxed/simple;
	bh=AmJiIFHLW1bUfTVm+jyhUo31jIVhADlU73008mYT8aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OetfshoMFe2r2kelXVzfzWwgmMcpZLGz0JzkARiJ+BIX+WYGtrPNqYyJx7xU1bNQ96AkfH7TNXrzwLUrPdtnUgHOf2UESvCaw+b9hBQe4izi4pYKgxFWmCLvY24Y2doGK0o/Das9g5eTsXWAEjCCj42EIw0Av4tE9g5yb/S2H/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m6Jo1iSq; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5101cd91017so2846120e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 05:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707916976; x=1708521776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fRYO1F/cM8QgUE08NBZ01Gj9fzdGQ5jlSnC6Mq/YgDA=;
        b=m6Jo1iSqsCrxNI8HNEVhao1GvXmfOHS86GfPSlL+6Chtuku5svTRe/3JZ4iT5d82NZ
         fBX8P/HWYKvStw2f8iAUlbvjngPo4UH+8fKnem1oYmGHW6ZOHMm6GXq8PS+VEQgDKKeO
         OLxyd/gLQMAyxOIPS/9tOVW+tq4MbODHtKYE/RqVur2/oXJtVkOemEy3BXkJye0VVCar
         drrWVL5/2tcXt9f9hLrqM1hFsadBU+fE+sNK4CyseNQmd8FuxUuRP1Ugn1wYle8Ak79v
         GRmmb9cGl0ydnxm+K0WQc6CQJe7qri2qrTjOyROWqS0KrXvZHaQFSIVGssFIfkwaNdvD
         kEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707916976; x=1708521776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRYO1F/cM8QgUE08NBZ01Gj9fzdGQ5jlSnC6Mq/YgDA=;
        b=VhE8f2c2niQF6RsfNARCJwWvNbUk8Yg3FtxvUSndQ5s8PxAlDaU1dwIjDNjaCkSmXj
         mHgM+GDd5PNbc7331UJos+20h5p8gX0ijVw+jppdGklIwakL9wyvmuhXUqBJ7XowBcXp
         7HQKVbaAI33geBxDvZYk5ebWBfBkHhV1zIRPO+X/sJxsNjbW2gaxmX38FfAxgigjLeYb
         HsdxKs8xAlfXLyEDkNlBZX2R+R2Db2K/ZrkD820y3JvLYE5iEbs9tqenEsMjVMUmmcvD
         yfdy31QXudXqkgNyTJh8ldW+XzGBc4sBhzXdKmasqlHXLGmyk05d61H4MfFsJdF7/FEK
         vZuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIzNNHps9zw05zPfDjeWoCYwPTkd5H9KsM5lbZe4dGOr4aBCE8ba5d6xAjGRRHV3RGcwckh7V5i0r2AVkuyZmvwFWlXFqLvf0/iVaF
X-Gm-Message-State: AOJu0YxU7rjnTJRUO+1vuMHC6QBAAnYhZ71zDJiGXYSb9BEzxhSILzxD
	/iZHb5GOi/AptIGzfVqus+pJU6E3dMZdHuTcFmGUhW8TkXItf5J3aCU+eX4+jGI=
X-Google-Smtp-Source: AGHT+IFZhTyfVIIqvEvVst9FifshDLETVLsVmUnD/0a2cPbtb576eCL7mXrv8iFKTuNfB/zc8td7TA==
X-Received: by 2002:ac2:46fc:0:b0:511:970b:2cdc with SMTP id q28-20020ac246fc000000b00511970b2cdcmr1794977lfo.35.1707916976270;
        Wed, 14 Feb 2024 05:22:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAr5xqgEYAqprZPCQZAcA7Y3pVj4CTo/6gF2qv5VY2oYOsyE1J1gF2owASHgUGR7qcOFWaNHFtwz8UQiFq66ZTMPpK9YYFz7DwexdfleN6AKccIU9823N2ZfCRjtpDhG+2CHNLYhuJeB4OXCesa4nTaFsvbP18e9zRYPd0/N58/Cliz9WiQKJ/hUpKhF+XFveqVvPG3kgLrUKZZy64rwy7nHPG9iicNtvawlMw2BOjSslu/YRJl2ovHLZMZa0FX5crhCzYgPT9pb0TDR4XDG9G80WEuOWM78qhJrlJ6sJ59FlMawd344kuYQUYqYu40pyc+JAqdtISjmIV
Received: from linaro.org ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id fj17-20020a1709069c9100b00a3cfcd8772asm1692159ejc.155.2024.02.14.05.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 05:22:55 -0800 (PST)
Date: Wed, 14 Feb 2024 15:22:54 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: bryan.odonoghue@nexus-software.ie, andersson@kernel.org,
	konrad.dybcio@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
	quic_fenglinw@quicinc.com, quic_collinsd@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom-rpmh: Fix pm8010 pmic5_pldo502ln minimum
 voltage
Message-ID: <Zcy+roPWLIVfjWs8@linaro.org>
References: <20240214121614.2723085-1-bryan.odonoghue@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214121614.2723085-1-bryan.odonoghue@linaro.org>

On 24-02-14 12:16:14, Bryan O'Donoghue wrote:
> The relevant documents and the dtsi specify the minimum value at 1.808v not
> 1.8v.
> 
> Prior to this fix we get the following error on boot:
> [    1.353540] vrej_l3m_1p8: failed to get the current voltage: -ENOTRECOVERABLE
> [    1.353544] qcom-rpmh-regulator 17500000.rsc:regulators-9: ldo3: devm_regulator_register() failed, ret=-131
> [    1.353546] qcom-rpmh-regulator: probe of 17500000.rsc:regulators-9 failed with error -131
> 
> Fixes: 2544631faa7f ("regulator: qcom-rpmh: add support for pm8010 regulators")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index 80e304711345b..767a17fe0d51b 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -757,7 +757,7 @@ static const struct rpmh_vreg_hw_data pmic5_pldo502ln = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_ops,
>  	.voltage_ranges = (struct linear_range[]) {
> -		REGULATOR_LINEAR_RANGE(1800000, 0,  2,  200000),
> +		REGULATOR_LINEAR_RANGE(1808000, 0,  2,  200000),
>  		REGULATOR_LINEAR_RANGE(2608000, 3,  28, 16000),
>  		REGULATOR_LINEAR_RANGE(3104000, 29, 30, 96000),
>  		REGULATOR_LINEAR_RANGE(3312000, 31, 31, 0),
> -- 
> 2.43.0
> 
> 

