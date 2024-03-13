Return-Path: <linux-kernel+bounces-101451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD1587A74D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE5A1F23EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AD03FB17;
	Wed, 13 Mar 2024 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJ1WbaKW"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E79E3F9E8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710330917; cv=none; b=C/EJZtuFjId5ZR9GL+97fJGtBLRwbCF4YdDT34JHH9PtUenhqgdcLz7PFYB3RSMUjiyQYYaqdTRRmba3Nx804wPdfGMEiYmdQGAiw4/JXJ2IilK+fVQJIgWjFPhaehjgNKQBsJcTA5g0Bf1BRD9r3zIO0PUMAWdMj4KD/P6GeOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710330917; c=relaxed/simple;
	bh=xYQb+BQulrZxxo772iQeUy5dIlvaSIgJg4G59zCwYxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6QipWB36I4nt0Qw2FtXDFr4ABFUTamQvmMhOktzptVL4spmHfzBjhQxE8K3CE1fFAA19nEP5Xn7+bTbEiJoMAJgC+iCCGbe4QPqPNbm0mgric6qVELZfaUoxiiqE1eemfiTodIRKakbkYG06Gm4KjON0wfnaWSA6X0Q9XLsA/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJ1WbaKW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3122b70439so835608966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710330914; x=1710935714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XY8Gauun/KCCuJd3rvfN1BqCAqZcqM1FwxPVTr0A7jA=;
        b=IJ1WbaKW2X7pA6IF3fW+Kyv72ov9fZ4UYS5Gn/T9t/wo+YAhLm8rHXONyWZRruKO8l
         nRXAW+AaqtDID991AQFhS4aTwKWzyWPokTIU1LNT95lj8hz8qrlJHZssTBtP1PMkEnnK
         4+H2jL6U9kYxkbB3L760Wj36e6WAjOTcPnoE/cd9fDb5eJzx/2m2veqApaxISUMF+3QN
         svU94NCaHpZzzMBT8uc/xuLRkq6Ip3VroNPlKBhZoDhi8gsVFo+lKY1sKn6lxy1Oa5s4
         2SpdshtfMEQVbGP5u8c3P9kq8TOe4kBCSyItxC0hPNZT0iFN1t7Bxw3Kr9JP7NueVKcR
         rz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710330914; x=1710935714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XY8Gauun/KCCuJd3rvfN1BqCAqZcqM1FwxPVTr0A7jA=;
        b=c1KPYPZX/YHsmmuCG8lCUpd1CemkDoi5F5Xj8XZb+RIO5M15VHOkeDz8oWyNaawjaV
         GYU8XWBGVB0l59DlhsFG5sPFqeA/pWSYlca0cK/mXwIzTL5IN/joWmHFAH0zkT2Me+by
         ohog5W4DETAoMX3BvzPb5KgTwofq74j8gnR4JZbc2E1Z05AShX674HMQLgD0MmDm3edw
         PYDKaUfcPMCjcgabNoqsg9eIKtLvPNBdcSUQl5iEhDZe/8ZAlZGV/c5WUa0oTybwJ1Xf
         jCNIrmpmQltwQUyRbt6uiEKRyBnYSkV63gGX3rSt/YztvvnOE9Bjx17wIhaBnXBttJ1K
         hd8A==
X-Forwarded-Encrypted: i=1; AJvYcCXOKbNAQhpvgHkKb0liu/jI7KKoQDxupTKvtN3UrjCH1Mmg5YsRM595XVHD8nuwmlkYeriWbU1A8BIev+eUuuYTThtfUN24MP3vULMZ
X-Gm-Message-State: AOJu0YxfdyvTeqmagS2MeXtn9gQUcGV7CFD8T3nX6y5a+VTf79jWHxJu
	cDN1DXCHDa+2A3SoL+Z/CdiJl0GGQjHrWHHA6zNruMMv1iD3UgDmHBo6yQgXLSw=
X-Google-Smtp-Source: AGHT+IHzBdFBrOL1CjRXO7Wb5LRYPoTHhkJHvpPJm4Lz3kGYGnrSb0QF0pr6U7kKl6sQkdlibLujiw==
X-Received: by 2002:a17:906:c784:b0:a46:61ef:2846 with SMTP id cw4-20020a170906c78400b00a4661ef2846mr622937ejb.66.1710330914218;
        Wed, 13 Mar 2024 04:55:14 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id be10-20020a1709070a4a00b00a461d2a3374sm3442380ejc.47.2024.03.13.04.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:55:13 -0700 (PDT)
Date: Wed, 13 Mar 2024 14:55:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Prasad Pandit <ppandit@redhat.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
	rjui@broadcom.com, sbranden@broadcom.com,
	linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v3] staging: bcm2835-audio: add terminating new line to
 Kconfig
Message-ID: <15b3644f-f83e-4c7a-8b58-9d4b87f5af1e@moroto.mountain>
References: <20240313114126.1418453-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313114126.1418453-1-ppandit@redhat.com>

On Wed, Mar 13, 2024 at 05:11:26PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Add terminating new line to the Kconfig file. It helps
> Kconfig parsers to read file without error.
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  drivers/staging/vc04_services/bcm2835-audio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> v3: fix typo and note about parsing errors.
>   -> https://lore.kernel.org/lkml/CAE8KmOzcD+__7xdC7tegbHO9HEP48s7=reA4j-tvqVDwzHr+8Q@mail.gmail.com/T/#t

Normally this would go about the diffstat but no stress...

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


