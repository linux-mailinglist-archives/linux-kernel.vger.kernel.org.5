Return-Path: <linux-kernel+bounces-144970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5F88A4D55
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE71EB22DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B665D725;
	Mon, 15 Apr 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SP6yQvH9"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE65D465
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179328; cv=none; b=XNdiB8ENs/0Kv+Pz4DwLCKhPVNFKVgTA84GrABU6Mdtov2hiIfalVhWVAZDaZv18SSKheBNrV1pcCHXliUc9kIOH3hP/q54XSkkfmyAkxMYBw9NBLMWCKCXVfxTON0aigkLvfSSZt96ZBd7VUJd/0YQPQ3+G3Ebm/ZY5OMC1evc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179328; c=relaxed/simple;
	bh=eWZ4SE0VfIGB196vF8TDN8VWBaOVe9vVQJNsTIzQG34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRB8DExxcb4bMBHFFi6TuotrBN5nWlkPnrEtsA7t2l9yI4NkmRg1eW5vE4p0CuVSVCovkwMTH9hBJjhr+QzWJKIgzJqkFqJiqD7Qc3XSaWndAHOZv9pWuLYs1jBno+9xqg5+cnpIcNNSJ2XAfumnh4TWNWbXUOVZlr8WobeKX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SP6yQvH9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso2800370e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713179322; x=1713784122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3380gI0Nj7jMG48jHd6uITkRP1ddHwOHc3O4ogiMMkI=;
        b=SP6yQvH9aa8V4WbY53KMKGVPaDCAxYJW6Qma3st47KqbhuyMZ1FF7NYPjt6XqtLIvl
         MlFnAI0GnkBTqKmQerU79cOznNhBE/qAtTLKJdOOzfxIVD4JNSR3ofVnfmA8zPBaHo+s
         03wtyfOYQxEy2hlCJCFDXbgEib1efNw5uWN7qnHXDvnFDssDMJQOnInApGgW48HsdkVy
         J/Fb8r2oDFMEeFRV1t5GnEBY4HQM6ovKqMOBM9KFZ8jfMgFi9BtrPmPP/IKknEI42AsH
         L67+AvMWT2EfZE7i8I0gbosGHOnah5unRqMkEtI7FQnHpkdXo/0zVUApGtuNHyyd2qah
         zOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713179322; x=1713784122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3380gI0Nj7jMG48jHd6uITkRP1ddHwOHc3O4ogiMMkI=;
        b=ZiMWbU9Xi2LG56jP0D6C5PpRIjPv+apxkMnQMsmZ8p/rxVjjSngbomag2vmqdytEP5
         zLmjJdln5WxIzf4uzQfrNQPsiQRgAAowPe0UrS3kEU90MNlAL+1/ShOzsWzMOi1L+YmZ
         E9hfWrWSItCYxG5Ksooj0hi2N9ueRCIglT0cEkd9UZkbVn8MYbXF+hnh+7Rk7zppGHEB
         2c2Nuj0gxDmrjBsaWfyAsA92JeO3BE2IEjRzDxbXh8NjkYCwyZhTUpZRnm5lWqbKAxXX
         WOUfQL99sM2O1KpqR0kiLiN/eCmjouHAZQdZyOO1a1TW7kY234g7LI9rbTBNNm4R+m9f
         JoPg==
X-Forwarded-Encrypted: i=1; AJvYcCWrAa7kbIeJ/TGklyI0nx8wb3ZyOThNVnrOB8OJU1KQaO0lG4fTKu2Duh9MzLKGT4ro3EAUq3f063SBC5lerPRXqJxGFNhvSZxr2kbF
X-Gm-Message-State: AOJu0YwfBRlGfeA8pP3N2TxPEqv/EnprLE6m8CLCgCLuibjFKy9DNjH1
	GnKoGZF0kANaF5FWnJbgwWwcoDoqNIumQS5ZlFXDv/056hpwA9k+lhWmxYOgjlY=
X-Google-Smtp-Source: AGHT+IHzRY+Km+K+uNC5WrZH12Nr3LIaMRqEWHjF2lnS92jC7N2zOBTxs89YvPsBydrkjwa7agmHig==
X-Received: by 2002:a19:640c:0:b0:515:af1f:5bad with SMTP id y12-20020a19640c000000b00515af1f5badmr7146407lfb.28.1713179322078;
        Mon, 15 Apr 2024 04:08:42 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bf14-20020a170907098e00b00a52225b44e4sm5203616ejc.115.2024.04.15.04.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 04:08:41 -0700 (PDT)
Date: Mon, 15 Apr 2024 14:08:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zeng Heng <zengheng4@huawei.com>
Cc: linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
	xiexiuqi@huawei.com, linux-gpio@vger.kernel.org,
	weiyongjun1@huawei.com, liwei391@huawei.com
Subject: Re: [PATCH] pinctrl: devicetree: fix refcount leak in
 pinctrl_dt_to_map()
Message-ID: <637f9185-3fde-48c4-9a47-30987c8dd5a2@moroto.mountain>
References: <20240415105328.3651441-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415105328.3651441-1-zengheng4@huawei.com>

On Mon, Apr 15, 2024 at 06:53:28PM +0800, Zeng Heng wrote:
> If we fail to allocate propname buffer, we need to drop the reference
> count we just took. Because the pinctrl_dt_free_maps() includes the
> droping operation, here we call it directly.
> 
> Fixes: 91d5c5060ee2 ("pinctrl: devicetree: fix null pointer dereferencing in pinctrl_dt_to_map")
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


