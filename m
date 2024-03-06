Return-Path: <linux-kernel+bounces-94035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480988738E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79FB284369
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980C61332A1;
	Wed,  6 Mar 2024 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfwizPda"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F58A132C3D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734992; cv=none; b=rSoUcBujbUESDpO/DEkSw4FxYy9jfsdeVJmcK3v7+aa2jdtOHh9H9oBeihuVPHmUFoFyc1vfoqEQd+L9Lj19pWQ4bp8/icJxNs3o/y5TZsmUVreEtonPTVkw4gmhNX6QoHjmENI5gNUfoFal4XtapIFwVPOx3hHXkATu13iqy3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734992; c=relaxed/simple;
	bh=AsmhaGXykgBlpIYOs3YSnmBAyE1Ypg8y1KFAQNP2p/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8X8Gb2yIcT6EcrGDb0cUsNwov+Z5lDYSfreJ10sdyEUYS5oQo8DWyTBfWsESOKN3+3U20iteiQbWFaXZKRy24fhovogSM9vF7GhDCLBYqHtDWL4vR+KdTXIiYWAtErCIbTsznFQNapMmXmnBgvykfKbOnsnPnBpyuDkDsMYZKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gfwizPda; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412f8d2b0fcso3490555e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 06:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709734989; x=1710339789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R30SW6r7kkcz9rR70c7AXNIgyI+HRbFxKSmQCilxNYc=;
        b=gfwizPdaqRzCf8EqiXJaUDvK74Ew2XplU95lFERI8iXDCoOseTlvojnaF0fqL8w+LN
         wlN/JrJxlWJs+nlI1g33Pdv4VMLMDSeL0/6idhxVwccKjhru/tFn56zCj2WeqfOpS8ct
         +6ZdQ/NbZJLwzzyHW6UIQ8bR7n4bnHG/QLEmwayyfLpBVa2qTCMwyNr+WFTZRmn/ceIY
         6mywL2icQbSy7EVSepMQmQJFDt46XWmKkfnWK30ZFZHryqxgfWQZvAppe7VY3OCn4ZM2
         zUYpicFMqlvZ1AzcqY8BAv989UO42Who92KTEOgbYAGdYR0v2I3nVP5daw4Jqasrnpid
         9i1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709734989; x=1710339789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R30SW6r7kkcz9rR70c7AXNIgyI+HRbFxKSmQCilxNYc=;
        b=GrZc8XcmeH+EiIMANb9aNBPAzjpmj5wtJjksBKR6QX6qVgKjl1eND4SJERHZytmW+N
         e1SjDVk9dwXpUU2EgZQJ4VR62uC5jFRlBCavVMKviA6E4HzmCTIhONl/OWL1+wO+Yxti
         8hD6h91BFMwKnF64koPaj8RZ+8iExVT6Qw4GartqGElJ5Ivy+LLiUYG6XZIGmluxUKK6
         zkrT9wvI9ql+nWtLGfpGAQOCRDuiV8uUoqRXc56jJnxWl0nMFCIm/bREVGqWu1z9+lxS
         pep++0nxiFLGoohi0vnKUV6g0IEjfKqpJ/E2UCVEoEodyhvbGAboSUU4e0OaqWifeCY8
         JTXg==
X-Forwarded-Encrypted: i=1; AJvYcCXcATtm2ku3jaqOkrmEUlcNGmCw0Y0FBXq/PM2kL3fnA4rT/9jxqC0CmSvAjtj1OG4zp1qVBZtgcu4KG1LWC1Yq0vHLF3IE0w4eg71c
X-Gm-Message-State: AOJu0Yz8TlNEHZyVQNpW48UZBPE4hqTSEW02sb2dYIjs4d28aUcgb5ng
	pwc61oBrKOIZd2JRsEMi3J332ImIzv+3J+tuRIaayTDFa/nLv4HwAYSW9n+Bm8s=
X-Google-Smtp-Source: AGHT+IFik5zZonyK9lfW3FFZ5//dn9vpf/Oex5P9EnsbT+ZYCfD2/JkWWjnOMVAt0EeR7S59HT1j5w==
X-Received: by 2002:a05:600c:3106:b0:412:ad75:aad1 with SMTP id g6-20020a05600c310600b00412ad75aad1mr11626007wmo.38.1709734989251;
        Wed, 06 Mar 2024 06:23:09 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c19c600b00412dc5cfc2dsm12309760wmq.33.2024.03.06.06.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:23:08 -0800 (PST)
Date: Wed, 6 Mar 2024 17:23:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 1/7] staging: media: starfive: Replaced current_fmt
 with get from sd_state
Message-ID: <8a0cf244-1cb7-48a5-a900-1f82877d1e2f@moroto.mountain>
References: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
 <20240306093334.9321-2-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306093334.9321-2-changhuang.liang@starfivetech.com>

On Wed, Mar 06, 2024 at 01:33:28AM -0800, Changhuang Liang wrote:
> current_fmt only can store one pad format, when setting other pad it
> will be overwrote. Replaced it with get from sd_state directly.
>

These commit descriptions are kind of hard to understand so I have
proposed new commit messages.

Subject: staging: media: starfive: Get rid of current_fmt

We want to support mutiple formats so saving one "current_fmt" doesn't
work.  This was only used to set the ISP_REG_STRIDE so use the sd_state
directly for that and delete the ->current_fmt pointer.  No functional
change.

regards,
dan carpenter


