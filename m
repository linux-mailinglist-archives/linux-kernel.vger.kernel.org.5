Return-Path: <linux-kernel+bounces-85457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D636C86B646
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A986FB23E31
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB5515E5B8;
	Wed, 28 Feb 2024 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HB3WysVT"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928115DBC3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142181; cv=none; b=E85GtRIYCthmH+8fg3hgbkyBlXAy/ylp6aSl5gZLWnYbj25g8TDfTkaDywr7FsiuEN1JVt1WZY5323WbbJihW+sYFOSrQFdwHn3OrPQi6ugcXgg6IpoF5VzBXoCqLIyM0+fi2qs6jMrP8/UlmcwBHRef5aPDK+SEdzxRfOQB4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142181; c=relaxed/simple;
	bh=OnTfdMWKLwh8ThOMjY8rRqP+fXnwlTEZOKp8/UdqfZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pybd/bTzDQikUa2dRU2a8GxrAO8s2D/gE+XL0w9njNSiCQGcLVBAnVspARViaTMqwxQhHktOYobsNK/5uKMMIWg670945vEvnHsLqM4CFkGuVlDUaPDzcnrIyyrTID80v0hOA2G4ofGoCrHNzPhKCr/Od3ceT3VHwt5lwXs2rjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HB3WysVT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412b243926aso9397095e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709142177; x=1709746977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5XTL7Wi5fSoGtPT9aaYhGYa7xeX5imrSZZwRbhwuwVM=;
        b=HB3WysVTsoXuAk6qBgsO1dAToEe0AoD0mUK32iptO8rvhe33gL0+nKv/2tryZrxNkX
         ot/LrAEsqqF+PFt6Rt+BbNkRR+IE0AM6S98LXm2rWu4e/uG8hMReatmoDebdsFDhpl7K
         knR1FD0tgH3HyGGWzFTO8eTNUaYEdtRV3npePly4vlxNhVjP9FuhzoHljDuJtMwrpCRk
         wLdSkeU23YwOCVcALZiu0Lltz4wkI2aSx1i/63U/Zukdm3jmKtrpAe+fgqFftAbJXgnz
         a4RAOs+T8tgvXMJnUrYuwVZfT+Xb58k+Mn3sVksiXbRLjk58GIlpxyuc60yuRL32dWHC
         F2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142177; x=1709746977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XTL7Wi5fSoGtPT9aaYhGYa7xeX5imrSZZwRbhwuwVM=;
        b=h98lM0FXv1g+ze2U4VezKjTtb54PumCg63SZFYEMy88s+sEj8Ix1n/va3GMhWE0bfq
         /e9vEeTA95MtC48cd5YNum0jKkXM0RoO7dAcUyQr6Rm0MTuWUcsCKvMqMmLz+4NbqgR/
         TVHnHkYOrEg2dTKx3UHRwtX6nLcu1nFDBqCA5QiGQJSuskLa9DsBuUYW4XoLy5pkpdV5
         KJwQw3q9h1b50nW0Ukj/vN/oGQy1wILH2TrwneWgJp6whQgCvUP3oJ542PJq2eNDlbJK
         s+YV3UasubDW+qDPiR1uHGPJ0By8MVXxRi0z6YWZiIGAE/kZGq7nTXsdGl5O/DHHpke5
         zjJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD7kU6Wol/QbSrAexaqJbK+vstxeFShfL9PViVHR6tr0+fbTj2UywwQpVHZTpbjNMPEsCIhZqkanA2kbTeaJ4WNOBHI0xELVh1FSpr
X-Gm-Message-State: AOJu0Yz783wqg6QzQxfcrhMBbr0Pma/nF5y2OdestwNbiBi8QyFRyKcA
	rCPey8CRRNoQkm8wrZEIMieHYykCvclinfMC0vrQBYamYJJoxcFaTxNuuvcSdgY=
X-Google-Smtp-Source: AGHT+IEPgnl6zrKV1TWi+lu4XTy2PTm0dyVStykU3E0t1mjb2hp9hd9ASfakK+UaUYWfPrmiDRXcrw==
X-Received: by 2002:adf:f049:0:b0:33d:3099:e67b with SMTP id t9-20020adff049000000b0033d3099e67bmr157217wro.63.1709142176705;
        Wed, 28 Feb 2024 09:42:56 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bw11-20020a0560001f8b00b0033da4b06632sm15535993wrb.6.2024.02.28.09.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:42:55 -0800 (PST)
Date: Wed, 28 Feb 2024 20:42:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vduse: Fix off by one in vduse_dev_mmap()
Message-ID: <81e2238e-3ed8-44dc-82fe-256155c271ba@moroto.mountain>
References: <e26476e0-68ae-412d-a5d9-4996bc30d038@moroto.mountain>
 <20240227104743-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227104743-mutt-send-email-mst@kernel.org>

On Tue, Feb 27, 2024 at 10:48:49AM -0500, Michael S. Tsirkin wrote:
> On Tue, Feb 27, 2024 at 06:21:46PM +0300, Dan Carpenter wrote:
> > The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
> > vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
> > reading one element beyond the end of the array.
> > 
> > Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> 
> Oh wow and does this not come from userspace? If yes we
> need the speculation magic macro when using the index, do we not?
> 

Yes, it does come from userspace.

To be honest, I'm not sure about speculation.  The similar places in
this file protect against speculation so, probably?  I'll resend the
patch.

regards,
dan carpenter


