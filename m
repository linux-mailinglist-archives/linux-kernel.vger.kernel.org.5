Return-Path: <linux-kernel+bounces-42190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8E783FDB1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9F91F244DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A55433C4;
	Mon, 29 Jan 2024 05:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCjJnoCN"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD54205B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706505634; cv=none; b=YAMz2C5An5fXvD13g7eu3ks3/kndjnxpQPMwgRBzBSmFU3dQkJ5nkGTtr8QSuKMGrfIVF2BGkuHMvBiPPugHDg5d7jheGsDhmw7nAqAc4jJM4dvpw7RPXYwKwkWER0NASkBYjZq9fJSruqqmVnUH3srMAd/HrkwHf1iGxVF2oo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706505634; c=relaxed/simple;
	bh=VNfQNXcwaj9L7sBzly9Yd2YYDACh1h3l8Zw6n6MrGnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLRunkEnoreFBRvJ0H7XUs55ix0ultihdGOduLaXE0BSpvMamucJlC4B0HWxmicB46XAEJv0WDQ99jioD7GvxT/kyRBV8eLZ21dk4o9xkc6YNc7rJ5huPD5cwfua3tf/qlCs7BCmVETGQymZiidc4734kwORtAMHNJ6J1TrqC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DCjJnoCN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e80046264so35404535e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 21:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706505630; x=1707110430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TG0As8Zf+jaNpWP1oUZ8aP25VHp9LmLOVgXQ/rkSlDI=;
        b=DCjJnoCNZXrn8YeV6BulpW5DIwpuHFJLzrqSbvk0inZN2vwDC1n32YzAv1+URqzTsY
         whbQSu1NtxPHe+UlPPTRpbHyAUu6XhROJyCdKlGqAi7aaiD+ag3xL3iX2q4OeB92jR3Q
         NB+8mnm1it0tPUhK+ET9BRBDx16ZdLIDkkzNCCSK2pnHSMLXa11Pl4+HP427096wxNqc
         dMYDpAxFia/pNShOuJgNURQ0lZ7TgZ1aMsf3jc27be6TWw9mB+jlJ2I7BtL/9IyGQPEC
         LvtUWCl1NnWDpJGNJdp0sLqPenANJF5KQ3D3vqC2CEubxdRPEPOsi+Z6RVDa9mi9s6Tg
         UqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706505630; x=1707110430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG0As8Zf+jaNpWP1oUZ8aP25VHp9LmLOVgXQ/rkSlDI=;
        b=Ma9MRAcs+L8wb7Hy+QZt+zUkOHxNZegDivIjfhkZjiDZBg6OCE/WSy4lu28CaOIPU8
         mS+OhQti9/pUqfAyxhIYx5XwtJmga6xbsv19HwSzqiUDBxl9qcQIxvCe3LmQIcNi00jK
         I3iSX/f6Vj3BpeM2iCSHr8c18Ll/xQXI21kcHHax8v33pWKMKDHAGcAdc4oSxmqQKxEt
         bMk8i+BRYIX1Q/gnMbh+pY/2M1/nYRa0rJ/aMonmMsvvOkYkQndD1JfmvI7HoOVvWaYl
         /PUpn110j0VYnXPicePdq6aluEPL70HXyEb3e4/k7IA7zHuj2Nt31v01evGZ9KiMp3Y6
         +Ptg==
X-Gm-Message-State: AOJu0Yw5++/a0JWmdPBIBuJS4f3qBgkAjMaBZ5NJCpNhS+ApLQEB9M11
	FX9QkJTQ7Q2DR819Iyo5ItMrjkAaGA5k//4nDnKcmfkwEa1rMRKRjyO9wK0NK0o=
X-Google-Smtp-Source: AGHT+IEfoXxJ+z+aVz9Hl5jSUOADUMdycEW6ZCPWSS5N4L7GhwgTKNyeWxDzwUUJNPQ0Lx23qnWpKw==
X-Received: by 2002:a05:600c:ad0:b0:40e:779f:416 with SMTP id c16-20020a05600c0ad000b0040e779f0416mr4554158wmr.2.1706505630593;
        Sun, 28 Jan 2024 21:20:30 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0040ec8330c8asm12823044wmq.39.2024.01.28.21.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 21:20:30 -0800 (PST)
Date: Mon, 29 Jan 2024 08:20:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: ep: Use kcalloc() instead of kzalloc()
Message-ID: <3b175cb6-fcbe-4521-b6ac-442c8a11c297@moroto.mountain>
References: <20240120152518.13006-1-erick.archer@gmx.com>
 <43614a09-d520-4111-873a-b352bd93ea07@moroto.mountain>
 <20240128102933.GA2800@titan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128102933.GA2800@titan>

On Sun, Jan 28, 2024 at 11:29:33AM +0100, Erick Archer wrote:
> > It's a bit concerning that ->event_rings is set multiple times, but only
> > allocated one time.  It's either unnecessary or there is a potential
> > memory corruption bug.  If it's really necessary then there should be a
> > check that the new size is <= the size of the original buffer that we
> > allocated.
> 
> The ->event_rings is set twice. In the mhi_ep_mmio_init function and in
> the mhi_ep_mmio_update_ner function.
> 

It's not about the type.

The event_rings struct member is the number of elements in the
mhi_cntrl->mhi_event array.  However, we ->event_rings without
re-allocating mhi_cntrl->mhi_event so those are not in sync any more.
So since we don't know the number of elements in the mhi_cntrl->mhi_event
array leading to memory corruption.

> void mhi_ep_mmio_init(struct mhi_ep_cntrl *mhi_cntrl)
> {
> 	[...]
> 	mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, regval);
> 	[...]
> }
> 
> void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl)
> {
> 	[...]
> 	mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, regval);
> 	[...]
> }

These ->event_rings assignments look exactly the same.  It depends on
regval.  So possibly one could be deleted.

regards,
dan carpenter


