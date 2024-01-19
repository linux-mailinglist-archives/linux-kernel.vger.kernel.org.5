Return-Path: <linux-kernel+bounces-30901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B99E8325B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8F11C22D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C6E224F6;
	Fri, 19 Jan 2024 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hInY594r"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6991DDF6C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652757; cv=none; b=MJfkiVphM+iPnQRTpZnImu/X9Jq436QWPfpvmrLOz5XZBpD31DhpI6dH2vKdMd7Yfcig8KjT7nhqYoCSpD+3wJIfSKgpymdpc9c6outZ9ABAJL3VewcRMDKXDvOajJnkNc0uzydWOux9yrSeP4Jd3X3ljP1Gn0KmbVz62XLdhck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652757; c=relaxed/simple;
	bh=CUucUSh0q5PVDhwQRi6YBW3ImttHp3BqkC0YGaXZl2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpQmcXOobawtF/Ylu0PPMVVi+LbPgaeTOf1gme/SNNqa8wyYjy4cikD0222p6C/KatBA+kPbon2cGD7+SzEwOOl7s+CWAJ4E9H04NShrPJWEugCI/4OfnHVhyMM+C1gS3PZZ6P+bx+AN2u7gr+1rW3ZTtErj2DtPukwlhURI7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hInY594r; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-337bcaef29eso370378f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705652755; x=1706257555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7dcjTRyl1/vUofqEvBgKl6cVF0fqOtVtv29zRSnRI4=;
        b=hInY594rTwpMOrimclUL2REqjZPnq75WS2MSrCd3Ad7i+de0Ltxul4bjv66f6NFjku
         vkD5S4Xm6SiZhnOW8P040SpkqpmKhqRwKnJR17e8ur+HYTIDDiPQyd5MvtxVRyvFF4VY
         fwC6/xt4CwBZMWAHW2Snbz5wtIzMpuwx6VYj3kIJBftJi1NaNIWDvBrbkLbU8J+JqZZb
         ZtjtbcDd5ipIgaYZajPCfRlZJgFMXgfoKtazk5lTJBaAqz23FEmNnIX44Hs+jAJ4tDwg
         6hh+QQ89fP28ZWLa3X3qcQkLqyvjU0+YTP6nTNCyYrf3g6QSSZEdJsHHkK8FdrRZKnrW
         dktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705652755; x=1706257555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7dcjTRyl1/vUofqEvBgKl6cVF0fqOtVtv29zRSnRI4=;
        b=SmwTEFOi4u+1YrNthn4yVbWlqISxClgkHwWrH5RbaCxoXF6UEKHrr3qk1TxuX1LvbK
         Y/1z3m3gjLyXQmwMFlrM+YZZ3pn3uh+N3Vs3JIzEN344ZxSRtjQW/cXoPuA3yMJxvVGv
         iR0B+HDDnx5fi7nkxTnjJP3IeLFcqP0VpJXxmAjxen2kX6dGgxLkZ1oLZFMjNPANh/wN
         0Hf2KcncCwLbl/gCQ/lCWp8+AmRL/xoaDsaax2XpJ4nDg2vr3PUufDxD3oz4tOkzR9Wg
         s/eMh0jujdIABrdDpiCIYttrJUXLNgS34qAo2A3aGVHJe+Z4sGndhRF4vjp5kzU5/HGL
         xACA==
X-Gm-Message-State: AOJu0YzY2w6DimnUBK6gtElQDoG98KsLoq7gN7s213FWSKjMlx9Serht
	iLqWTAWruv6xqwEVUU5CbdjIvP1IQx66vHVpC0yLOnFisT/EVsk7iVVT1b/7i+4=
X-Google-Smtp-Source: AGHT+IHvdcKDkDD1e39ucnqrSKAPEsqRPS6GaaFM+CE5xvpcISEieX1qz3akhcLF/mGVkOAuNmiFuA==
X-Received: by 2002:a5d:5512:0:b0:336:b8d:6531 with SMTP id b18-20020a5d5512000000b003360b8d6531mr1317167wrv.100.1705652754752;
        Fri, 19 Jan 2024 00:25:54 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id t26-20020adfa2da000000b00337c0cacf54sm5942518wra.101.2024.01.19.00.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:25:54 -0800 (PST)
Date: Fri, 19 Jan 2024 11:25:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()
Message-ID: <501533ad-7671-46aa-a034-91e0a6322e6c@moroto.mountain>
References: <3f9f779c-a32f-4925-9ff9-a706861d3357@moroto.mountain>
 <ZahE455neE3wPnHA@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZahE455neE3wPnHA@x1-carbon>

On Wed, Jan 17, 2024 at 09:21:41PM +0000, Niklas Cassel wrote:
> Hello Dan,
> 
> On Wed, Jan 17, 2024 at 09:32:08PM +0300, Dan Carpenter wrote:
> > The "msg_addr" variable is u64.  However, the "tbl_offset" is an unsigned
> 
> Here you write tbl_offset.
> 
> > int.  This means that when the code does
> > 
> > 	msg_addr &= ~aligned_offset;
> > 
> > it will unintentionally zero out the high 32 bits.  Declare "tbl_offset"
> 
> Here you also write tbl_offset.
> 

That's so weird...  I can't imagine how that happened.  Do you think it
could be a Welsh mice situation where forest creatures are changing my
work when I'm away from my desk?  https://www.youtube.com/shorts/h8gkIbtaaek

Fixed in v2.  Thanks!

regards,
dan carpenter


