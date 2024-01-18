Return-Path: <linux-kernel+bounces-29719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89954831270
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435ED286A97
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988038F6F;
	Thu, 18 Jan 2024 05:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bies4SxQ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7FE63B5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 05:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705555767; cv=none; b=D9csiXa0DdEgUfP5UmJQWQze0YpEeid/pMvYPe6IT5EI6B0FrYBQrQCngPTWayu26pjknMXdPcp21Yh16UCqymH+TFyoBXJj5SURW7De6oFzYLL0X0vYqpyv/+UZyBQ4sNy6NZgRwI55oG+lxFctUqQXb9benn4ExophHuCGqe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705555767; c=relaxed/simple;
	bh=SBVMA/CPQNcVCfcURUzuwVBCE1qUg3c5WG0zdMGFPQg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=G9afj1eCuwoH9xY5OZtyFTewHWtl6276rb82i2GZOtmX0HpVpPzcDeeu1kaTbmiu/D1quffw0rjss86VMJPi3rnx8llJrXll/ChoZfA0LZN/h2UwgV3injt/6zyi8LJAzDFI/IY+U6jztOQbFK//1+1Yv3dfcDqiO0pLNyhfaS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bies4SxQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e800461baso31788065e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 21:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705555764; x=1706160564; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wWVOjE9eG7LQZ1p5rDtepmpo2WIDbMJDdYV1+1m1FBU=;
        b=Bies4SxQOMm2y9Btq51UiXzVZwhtvjN5NVmtvQJ0eMUe5gfREJdCIWlM2FxjYkiBL3
         viV/JtBvnRgvSaTfwEus92WDyzUb3MfLjJ5O9zlh/ZVwvyVQBv9ZeiJiF1E7DFlkoLLO
         63j7Xl9jQkNSOsfYa7Ts9+OTe+0uab+XRsZ5WD7dEzWzmQQ+NdTwQcWCyP+4CkAEiz+r
         ORCWpnC38A/1yZmryV8RrfSfvJ57rWs9JR8xGuX/rZYA8bP39uLvGBOE2VJtukBhe+Tc
         C7nh4w/yN1i/HRgsTCxOEl+pkZ6R/0O2RS9YvtIv8EHNK1rY8hSfBv0GqE2qbHOeuljq
         YHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705555764; x=1706160564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWVOjE9eG7LQZ1p5rDtepmpo2WIDbMJDdYV1+1m1FBU=;
        b=AmHS4oDe4VRYhaR9Prm//GufKo+f0CoqNQcSjkjQqZ2rhA2mKPA1PNYXlePu9sk23/
         kIACPf2D1VtDPbJQdRICtiYDhIod4+qesjlHMJ7aQi7qVRrm92a/ucYT76ZDJM1C0cPA
         3YxheZqTUd9jlhmkDnzS0WEPJP3zJC2JElv0oQGUvJ0oud175eabG0zw3bL0YhPf6zCM
         T5u9GyIZfVNijr+Qu/YlZmNZaCDaf36TfHEKWMQvmOOybc5aJnJX/rbnRYy6yq32Ao3P
         EYVfMCTxjK7uRXqu9gJ4PmEpzEiyBkMLHn6Ck8I7eab9qXRR7HO2Ij4iyVP0kwV41KN2
         KJdA==
X-Gm-Message-State: AOJu0Yw5+wFKQnWy+a6dZOnUmaP+jtwA0jnvRZAaQNkE3xJe/jJBRPKx
	9XgNqG8W7bodyskPLLEjhtA9JY1WV2wGzBfaJnq4lD06Y+BgnaDNvwSMLeS89mg=
X-Google-Smtp-Source: AGHT+IHaCjW/5P67xwqKO0g8DnWLu4YQwaK2HHCRSW+8Wlvh81P/g9nOxJOSa7NQjI8+GNuKu6R48Q==
X-Received: by 2002:a05:600c:880e:b0:40e:4799:8a81 with SMTP id gy14-20020a05600c880e00b0040e47998a81mr66295wmb.281.1705555764049;
        Wed, 17 Jan 2024 21:29:24 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id o21-20020a05600c4fd500b0040e34ca648bsm24586127wmq.0.2024.01.17.21.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 21:29:23 -0800 (PST)
Date: Thu, 18 Jan 2024 08:29:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?Q?G=FCnter_R=F6ck?= <groeck@chromium.org>,
	Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] pstore/ram: Return directly after a failed kasprintf()
 call in ramoops_init_prz()
Message-ID: <26759e3b-ff74-4b04-b06f-4d68fbc5f606@moroto.mountain>
References: <644f44ad-7e2b-4a1a-bbd7-ccc79d479242@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <644f44ad-7e2b-4a1a-bbd7-ccc79d479242@web.de>

On Wed, Jan 17, 2024 at 09:24:12PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 17 Jan 2024 21:09:22 +0100
> 
> The result from a call of the function “kasprintf” was passed to
> a subsequent function call without checking for a null pointer before
> (according to a memory allocation failure).
> This issue was detected by using the Coccinelle software.
> 
> Thus return directly after a failed kasprintf() call.
> 
> Fixes: 1227daa43bce1 ("pstore/ram: Clarify resource reservation labels")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/pstore/ram.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 88b34fdbf759..1a673a4af17c 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -595,6 +595,9 @@ static int ramoops_init_prz(const char *name,
>  	}
> 
>  	label = kasprintf(GFP_KERNEL, "ramoops:%s", name);
> +	if (!label)
> +		return -ENOMEM;
> +
>  	*prz = persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
>  				  cxt->memtype, PRZ_FLAG_ZAP_OLD, label);
>  	kfree(label);

This patch is fine as a clean up, but I think it's useful to say that
if you pass a NULL label to persistent_ram_new() then it will return
an error.  It won't crash.  So this patch is a nice cleanup but it's not
a bug fix.

regards,
dan carpenter


