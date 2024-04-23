Return-Path: <linux-kernel+bounces-155808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD9C8AF769
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AAA1F2499A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3574C1419A1;
	Tue, 23 Apr 2024 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QSFWSgOT"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D81411DF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900765; cv=none; b=Yss4reS89jVN/gcn/m53WgLVvkQNUXrumh+vQ7/eQpKhxLbMEpRdRnxr87EgKT94QOM/d0HWSVLzU+18YD7tUxRN6P/1ZHndmILL0NI+eS8tqgj4NfkWpiMChGD9pKMcGfFFs8VJ6XH7yXHRFNtYYQ4plgauFSLkhqQ3yL+YFS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900765; c=relaxed/simple;
	bh=Yg9JT0GPJ5FCanV1IVJLCalS6j631626ieKfDNZIsrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hk6oe7pk5zwk1DAUDRHlef7lRG6cl4zzrgTXDDYVzP0bg/Am2LySquux6yk+FuqjNAWZyT6le2RD+0g8kNeR24Ytj6KwZC8EQxg0408B7yTHemQ7nDgTlPtSLqISkQDJ/e7plqjjkawwZf3Z6ZnL2o/5VduUhrm4+qSDe4OcNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QSFWSgOT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3f17c6491so48811895ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713900763; x=1714505563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eGaS/zfSaOemq/5va4z7SgRNYZdnHSSpsk3opQQf4+o=;
        b=QSFWSgOTGdoDN6D4+fkm8QQmoqGM567uVjKxahKv8GcfdHg4qbtiNIJ/yNAzkf/lPf
         ATkMA2JtHEJbBeegOKAkWz1RssVdzMvHYeQ+TOugGd2N5AQodzrpJRblCNARB72e8k4Q
         fEbQO09BRJzxTXeIq4XKptITqn0l9wEKc6CHjQjEprLRf6mgN1DPEQPkM/LOom4ES/6A
         9K1psgyIoGJip1jjnZqZ4sdNyx3Wzmuu5kYyZiqfYr9A9Ln7urdj1jn8xHsy3AFBvTui
         i568gwc11HvadS35bFiWpetuizEdpmAWst5FxXwq9MZsPXzP1+D91ZXFpN3EwU8VwqBX
         YbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713900763; x=1714505563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGaS/zfSaOemq/5va4z7SgRNYZdnHSSpsk3opQQf4+o=;
        b=gdhMV8J26iyzSg7rLwfxTTp1kDrHThofjCXRAW+Rw2V/eq/RSlDCeTflLrYAvQGsKh
         KCQ2jxNBbztOi1BWEFXvHypDDqhaPzttMwTZZFDA/ZRnrEYSEcihfuiH1S5LgXfdOn0X
         PUPKlew2CBVxGqEPvGA7/XraNHL7Ipm2/EsNzBnSZOg/JyLjxmuPIH4yNIACGELmVFiE
         4sQwOB63S23Cj6A8bPI+ZVbwhTZdJ4YYZs7WCK+YAhDZcwm+BYshrAqnKYSG+ZcQbxzC
         d9JGttvh3PozFw3RfQw84gWwBIzjAWb/54wPiTDI4+c2hE6v8mPrBN3xgN8rg5G/o4+8
         f1/w==
X-Forwarded-Encrypted: i=1; AJvYcCWM1s/S//OsgjoPX9yrtuJqjv78mkO7aqrSfYRZk69ZAEg99o+Jpd6XzD8g/quRgd/f0jX2JNKaGAnkJSUXDPLn/HWx6a9FLidgfR2y
X-Gm-Message-State: AOJu0Yx/Y8RNqWBurNAcGDd1dyB2XOiV+/4cnN1S808kZ0Qgqhy+RcT2
	29TEscEbC49CEcFsmN+9wZLwLt5wqRZxTltVLa40kpsxxnHI4/72MG9Z6INhSmk=
X-Google-Smtp-Source: AGHT+IE7HckQKrB7EekRQpTfXp8JNrKSb1ZYBxmPz3IOLyDMxafIxaoffEuDaKvno/obq55gOhpMuQ==
X-Received: by 2002:a17:902:cf11:b0:1e9:55f:f3be with SMTP id i17-20020a170902cf1100b001e9055ff3bemr533792plg.43.1713900763238;
        Tue, 23 Apr 2024 12:32:43 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:951d:44de:e424:2887])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709027b9300b001e435fa2521sm10401699pll.249.2024.04.23.12.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 12:32:42 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:32:40 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drivers: remoteproc: xlnx: fix uninitialize variable use
Message-ID: <ZigM2KORFbsJgHEW@p14s>
References: <20240423170210.1035957-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423170210.1035957-1-tanmay.shah@amd.com>

On Tue, Apr 23, 2024 at 10:02:11AM -0700, Tanmay Shah wrote:
> Fix following warning for clang compiler with W=1 option:
> initialize the variable 'ret' to silence this warning
>      907 |         int ret, i;
>          |                ^
>          |                 = 0
> 
> Fixes: a6b974b40f94 ("drivers: remoteproc: xlnx: Add Versal and Versal-NET support")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404231839.oHiY9Lw8-lkp@intel.com/
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index a6d8ac7394e7..d98940d7ef8f 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -904,7 +904,7 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>  {
>  	struct device *dev = cluster->dev;
>  	struct zynqmp_r5_core *r5_core;
> -	int ret, i;
> +	int ret = -EINVAL, i;
>

Applied - thanks,
Mathieu

>  	r5_core = cluster->r5_cores[0];
>  
> 
> base-commit: e99fcac055b3325283d6c5c61a117651fb147686
> -- 
> 2.25.1
> 

