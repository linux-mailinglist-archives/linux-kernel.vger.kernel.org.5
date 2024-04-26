Return-Path: <linux-kernel+bounces-160300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C20C8B3B99
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5AF1C2231A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DB81494A6;
	Fri, 26 Apr 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A28551tf"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7357D149E00
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145562; cv=none; b=GU7REhY0NnehW1uCeX7Y4E+gsKuOdhvnMKlUFANilxDN03bIGZKFa3qj+IudboRQkrgRAaORSHEcNOnBKQOVnyKQEvPuuk2D8G/fiRlAq889jmHSm5dWpNiYBek4JRt+IPa3lKkaniBdKhXrldg4JzcE2MT+VuTwFbyapYrzybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145562; c=relaxed/simple;
	bh=qklciRQxec8j59g3ZMuTPWOVbw7bNHFK9MOa3OI5oBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVunE8u82dgAs/XHuAejHYsMdK4oguMLjnD3jrJs+uZ4FaPMQKKgUqwH8Ocw/9QSAYN+9eFwPb7kI2FWCoZxzPxyewHBJ4VBH+76O+NDvjp/uSIBWyS7HI11C/HARd2Oxfl3SxvjdxurcGm3SQ8cM8t5fmOLxRRlZ/9z+Wv9mww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A28551tf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a55ab922260so312325266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714145559; x=1714750359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gd6ILVzk0t6uXM79Zttkn5VJ29kj20R5ZD7OwenGmLo=;
        b=A28551tf4kbu1BWESsy4bxyXyR2ba8bom2utsMw0Hg72G0xIITj3xZfKWgE5xY5WXU
         NFd3IJxvzScIibRBwpGr3rTMgMaUlS/2+xKlM8KNQz42p4x6hHay6+O1Pd8Eqj/2n6sx
         Kx5DdMEhJFrWJf/SE1e+TjtaNp5+rDyDLB03m2Zj9hS0PJQozPKn9BS29o+dsP5yIV1b
         bPYktCaCov0pq6s+G7N5/yIXFI0Tsqpi97Nc4fh96lE+eZTzgJZgL7ebGdCUf3GCxuzs
         dcIB3dHROUfVMYPw8Z3R737XfyXMpJLlHhuk6bhk7oYCfJKG8VbVumwhtnljdfDgXVli
         Y2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145559; x=1714750359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gd6ILVzk0t6uXM79Zttkn5VJ29kj20R5ZD7OwenGmLo=;
        b=KivFaTMzxgzIikv1QJvMu2KbMdaewhTloZ1M4Qgbh/srgo1LGJTWtihr7IJkARq6GU
         yfnQa4W4SlAplhjd16Jd55m3+bjCjijif+C/kqKHLQZsenH/m2nLd9Ddo5HJL89lTJrl
         b3yWajdJScyvxkeu3G3yF6gV+nghMFe5hIUZO3IJQgiqE603gI4nPN8LveLjgtnVtY/t
         wub+LTvcNTc7SZJQ7A7B2GvZUhPuwYyrnTKnqax1IUSYdF3rdKDJqCzv8TK03APqhlq3
         JGnEc+P2crbcPhe+b9kA247vLPQOiu6+RzVDEM4wDqTn9rTFDvIemAKEBcy9FHfYU/E5
         YgVg==
X-Forwarded-Encrypted: i=1; AJvYcCWTRwVTG+ZOVeNGERtRRkSWdEtevU5YA6aQfjcoOVCecZ506bUWes81zluIZSro5SGJ7QM3ZL1ibt2yqnw//kiwEqIGwQpQezi63F9b
X-Gm-Message-State: AOJu0YyX27O0iESLet/pcpBnv6iB9tHIWb48bwf1HNEAk+AzfZfQgCe9
	H4HsDNujyZ03s56E3WPNoTckrN0vUxhCKGlHR+/msvd2ghqyvJHwBEMGVrOsqeNTSDUZ6gi4I/5
	U
X-Google-Smtp-Source: AGHT+IHO9ZwNd+bCnrGqjMRC0t/4lWSuJQ5CiOnjwm37ZKk+bzMBetUelSmBBHMySLB81gG6EG9SRw==
X-Received: by 2002:a17:906:13c7:b0:a51:f463:cfa6 with SMTP id g7-20020a17090613c700b00a51f463cfa6mr2046211ejc.29.1714145558440;
        Fri, 26 Apr 2024 08:32:38 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id z12-20020a170906270c00b00a55895c7f50sm9192735ejc.151.2024.04.26.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:32:37 -0700 (PDT)
Date: Fri, 26 Apr 2024 18:32:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: lumingyindetect@126.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
Subject: Re: [PATCH] serial: 8250_lpss: Fix memory leak in lpss8250_probe()
Message-ID: <047e490b-0dbf-49b7-9506-996f0053e92d@moroto.mountain>
References: <20240426114716.1275085-1-lumingyindetect@126.com>
 <87d376e4-84f1-48c3-8c5d-955f706f3bfb@moroto.mountain>
 <Ziu-HUUE43xsjnia@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ziu-HUUE43xsjnia@smile.fi.intel.com>

On Fri, Apr 26, 2024 at 05:45:49PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 26, 2024 at 04:53:18PM +0300, Dan Carpenter wrote:
> 
> > > Fixes: e88c4cfcb7b888ac374916806f86c17d8ecaeb67
> > 
> > This is the wrong hash and the format is wrong.  It should be:
> > 
> > Fixes: 254cc7743e84 ("serial: 8250_lpss: Switch over to MSI interrupts")
> 
> Since you are here, just pay attention that this does NOT fix anything
> as it uses pcim_enable_device(). I hope smatch won't stumble over this
> and produce false positives.
> 

Ah...  No, this isn't a Smatch warning.  I think I tried to add it but
was told it was wrong because I have this in my unpublished code.  :P

// Are these affected by pcim_enable_device()?
//      { "pci_alloc_irq_vectors", ALLOC, 0, "$",  &int_one, &int_max },
//      { "pci_free_irq_vectors", RELEASE, 0, "$" },

So when we're using pcim_enable_device(), calling pci_free_irq_vectors()
is harmless but not necessary?

regards,
dan carpenter

