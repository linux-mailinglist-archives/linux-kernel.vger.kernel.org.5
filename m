Return-Path: <linux-kernel+bounces-74184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBF885D0DC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E781C227A5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED733A29E;
	Wed, 21 Feb 2024 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clOwIJtb"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E56C38F9A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499272; cv=none; b=q1KSYNyprohJKsf+j0Gk6G6gFb11loHzY9QoSNRJIULqoftPGilis+n0ZhQIElDYZprQud6KjCOL/lUWQtedMH/L63TQKb+k88ac1Nkue/bBuIu7/PGJk5CMOihojLUAYtIyB0/ZKyD0xmYoHhflkwpjAi2oTHWnuFYludODAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499272; c=relaxed/simple;
	bh=iBt7GgaipAQNgxegnjfd9wvWH/HcjSlObaEGobdnf/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uheN/knanF8QAxJ0sjOe+YdpaMZswIzogRQcRahln0uKTkV3IdHZEflV1gBEsKP3qfMWuU0gyiFifcTJXrpVM5PN0zjjmbeoi1ra9eZPXHjQV8AwtC7AjfgjdNtdk8gWvYMEsVFBlIGsU48fjApTxzNaYLuRlOz68q6hPS3Fgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=clOwIJtb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d51ba18e1bso3012955ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708499269; x=1709104069; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HN6S5OkRpzjfW/oUatP0Qz5x0+v3A5sIvi8QPWu6N9A=;
        b=clOwIJtbzZdNNmTB3DcNP1rxBXqiJx19IH8sOj2z+HHyUKt76QaosgVvbBJ8sjClvZ
         OgWde3aU7zpLEY/shOrHDRDoEykCcWkIDHJtBWLMgNmtCwuwCOZnxSqwrXocY80HdxvC
         /KHBkvGF9LRZqSfenBJpQDDRlArPkiYAKb3dg3kRA/4/HbHqo8M5xk/aAuGT+TLioT5a
         gVFWbLnrlTaZVmCJE36uFIIMUMsK98+RlQtXxzbSk2yWJ4cpnqo7lOyuyd8jJcfOhAYo
         5eZgp6Mq+HeRDZqyzceFr7bbhpE0bWn7Jy/Vz2ymbq3oQnmXVw8ipJ9mlaa5/yOXV5Jf
         ro+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499269; x=1709104069;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HN6S5OkRpzjfW/oUatP0Qz5x0+v3A5sIvi8QPWu6N9A=;
        b=MRvxEo7PWCitKbCfHZx4fBOqnwH24bcCNicdB8hhYy8VX1xnau+9tqUD4VHVsJhe08
         fCA87WXyiWXiVYpQxILShNPmuRWhu9RsJZRn3rFj8F0KGe60MrgzAvfLFgU7LRSxq7c0
         krovXf+AsOlTne0B91lKMvwJPMMxu69LgR8gI69YUDjDsJUYoXdzo5JAnpEjznOjpOc/
         90SoVTBb6MudR6d8eyJOBeo8pacL3KYfmj7WRvvIV+3J6PONCVbd6puF8HqtJqTOOXec
         qAMLThR8JvYG31dHWGRbihFnC+9mz31lQFg1SPYBAp3QFC8ziykDfrMn4nocw0XqPsfH
         M1Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWkLlSbJLMYISfdEX7+snOaacewvT7ksGesU3eSYSZTLm2cIdusI+g2tuYw6yISKed7VHWrGAodqZ/R+Ies+4qAr5XOW6N2OhlmOp5W
X-Gm-Message-State: AOJu0YyaJjO7w3RT3Zr45MwEG/tiEQd3qFAFfbExy6NNUs2MZZQrTud+
	WLBv3kABRvYF7iwvbLEWKdeYYZyggIwnBHLHn5goPYAJ3xeceQlv4tWV3PyO4g==
X-Google-Smtp-Source: AGHT+IGw2tun5cH6q5fUCAvKCYRBsgdMhG+kJkVxK0Ihl/pZe6XSEZfaTek3RQXFn856xz5XBxgK8A==
X-Received: by 2002:a17:903:1106:b0:1d9:e18b:d916 with SMTP id n6-20020a170903110600b001d9e18bd916mr24917776plh.28.1708499268670;
        Tue, 20 Feb 2024 23:07:48 -0800 (PST)
Received: from thinkpad ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id jd20-20020a170903261400b001d94a3f3987sm7335617plb.184.2024.02.20.23.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:07:48 -0800 (PST)
Date: Wed, 21 Feb 2024 12:37:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alex Elder <elder@linaro.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Erick Archer <erick.archer@gmx.com>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: ep: check the correct variable in
 mhi_ep_register_controller()
Message-ID: <20240221070742.GG11693@thinkpad>
References: <bebcd822-d465-45da-adae-5435ec93e6d4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bebcd822-d465-45da-adae-5435ec93e6d4@moroto.mountain>

On Wed, Feb 21, 2024 at 09:20:19AM +0300, Dan Carpenter wrote:
> There is a copy and paste bug here so it checks "ev_ring_el_cache" instead
> of "ring_item_cache".
> 
> Fixes: 62210a26cd4f ("bus: mhi: ep: Use slab allocator where applicable")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/bus/mhi/ep/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 8d7a4102bdb7..f8f674adf1d4 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1497,7 +1497,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>  	mhi_cntrl->ring_item_cache = kmem_cache_create("mhi_ep_ring_item",
>  							sizeof(struct mhi_ep_ring_item), 0,
>  							0, NULL);
> -	if (!mhi_cntrl->ev_ring_el_cache) {
> +	if (!mhi_cntrl->ring_item_cache) {
>  		ret = -ENOMEM;
>  		goto err_destroy_tre_buf_cache;
>  	}
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

