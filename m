Return-Path: <linux-kernel+bounces-23703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 300C882B074
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560E81C23873
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C2B3D0BE;
	Thu, 11 Jan 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vkfbozRu"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE53B185
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e6296636fso1915405e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704982617; x=1705587417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7HNZaDiw/8JtL+WOdbC/TQ6GQKXbKUvja93oq/W0PE=;
        b=vkfbozRugNDFIpcNpfzHeIZCjYgnTFaMzo6J/h5C+anLIsuqkYLV6lWJPxLtybrlA6
         xrZ3ofRaT181Khw9JAwfnj1hC8oU5YNJVHW7sqTfe7LTHSOojrfRb3ZImLiRLr5nQtNM
         uulJKizhcZScFhkUfOGqLHjpMhl3TLLOG0NBqiULUOw2HuGCfF6d7rmccRpb+T1DK5z1
         2bT84SglewgV95Kmhq4YpEVQ3PhAQq/Z9+7vFWE+C/vXBxYvfe4BvQv3ivkqAiVF3p/o
         pv52e2wznEGu6JaxUTlKuUIowSyzdGPOKXTWoAo3QWetSZKqQ88AyiXczuhrkGKrR+6w
         zt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704982617; x=1705587417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7HNZaDiw/8JtL+WOdbC/TQ6GQKXbKUvja93oq/W0PE=;
        b=QkEnB8yLRIAPlQlx0uUEswmYIWiq3hWBM99zAKx6RNwfj/fR+ovf+RV0hNebFlJjZG
         JwcP5OND3GDCssa4QCw1x74weOZ2BD5YGCowyfsA5mKAtMuQ89cGGz4N2fKvnVaMjMOl
         bZOZlHayspzhOKBxqTeAHucK48U5e4AthFtzTNwDD+iuVMc4YtWNmYnZR7Cw3jVZfrPb
         PkFLZeAZCGg5rtgGTY7/B0+8Rlg22UpSAHJBVsTx6CaqVkj5Qf2KnVFnndWA7TtgY/Re
         wy6AjgzFKiMl7Fhxpn+R9YJkxpIMXZuZyBFbgapbytD06LVOr2Oqc7bDjof7NL8jrwnx
         d9Nw==
X-Gm-Message-State: AOJu0YzAyMuIdSlcyfz7ktb9k7feWnewkHNF60Q3s1u4ahYjmdMS7oLc
	VH49t6GTa4s9LhWS1SVKF+pNQdukuoj0Ow==
X-Google-Smtp-Source: AGHT+IHE7xVs3T4jps/jsae2Tnaipvhm1oyu66/to3BEj+6cPFdVQsBVa3/hqFcjkXCI6xeVBHSvsA==
X-Received: by 2002:a05:600c:a47:b0:40e:5421:e2dc with SMTP id c7-20020a05600c0a4700b0040e5421e2dcmr444019wmq.198.1704982617490;
        Thu, 11 Jan 2024 06:16:57 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b0040e549c77a1sm6035367wmq.32.2024.01.11.06.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 06:16:57 -0800 (PST)
Date: Thu, 11 Jan 2024 17:16:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Heusel <christian@heusel.eu>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/ipoib: print symbolic error name instead of error
 code
Message-ID: <102549f3-2169-40b7-b413-b86bc7965c4c@moroto.mountain>
References: <20240111141311.987098-1-christian@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111141311.987098-1-christian@heusel.eu>

On Thu, Jan 11, 2024 at 03:13:07PM +0100, Christian Heusel wrote:
> Utilize the %pe print specifier to get the symbolic error name as a
> string (i.e "-ENOMEM") in the log message instead of the error code to
> increase its readablility.
> 
> This change was suggested in
> https://lore.kernel.org/all/92972476-0b1f-4d0a-9951-af3fc8bc6e65@suswa.mountain/
> 
> Signed-off-by: Christian Heusel <christian@heusel.eu>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


