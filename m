Return-Path: <linux-kernel+bounces-70943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 645FD859E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5A22822D8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DA62137A;
	Mon, 19 Feb 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ge6DQLie"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D3200D6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331839; cv=none; b=bT0/kvZp3OlLb1z+oyKgh2u75nDpIiXngj8mz8Ys6f7/AFllxOoMxlh/P79oYBNQjKQhiC4S9VTMZ/o9QrETX0v/0k+Dsl0Wh0i4ATjrv+VC486NTvQ63pkD7B0t42ApqlOID8KuN9k+OgsfgA8+CL4idYfpha7W2Q/QZDc5tMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331839; c=relaxed/simple;
	bh=tA/HjR4gNsKYDqxOmkzpm1jPCMw5rPMZeBApJ0Rh/cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Djo/1mkPxP3wwQu5qfkEcnWwVZb+kJkwNLjY1HhOIxd2ikXmXbRWB0gY6eACWPsJG20WLzr1fXrjr3f2za05H0arZARFHvBBn1Pnp21jwbuDkLl4YWevOfBJx4Cnia7jqZJpkLM0Ni2fb6NWk1uzas3M04xCjBTh/Zxq9hLQTQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ge6DQLie; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso3233869a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708331837; x=1708936637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ojbVELbGUO0Fdw1LO3aSx5BEslcvMdmSrG39OaZaxOY=;
        b=Ge6DQLieZ2ifGEL3Y2+H/rbtAMtU0Zl5t9cedF+AlgRk4g8V9/pw4CBzTO0ehV1IVx
         95WO1Q72LHvcU4rU118BDgM7NqVnZFYxsg/o44DUMitwmM7WPeUEy0E8/XfTXuMd3ODG
         ZXQuaphfcGJepmMcgUhakUe9YoCZqmUoxpwRvfp/oLSh8t+Wli4VHG2uWryR8FM5SmPW
         ngOZsaH3EmFfZpz4AJbfV/qYb3o1cvZWHzWdPWMonjpxRaiRdooGZ9x3hL4kC9302Fdv
         ibD1pFVBPwXy9L0iWFL4lzvXIsjYn700t9oetL453v/FaZ1ge7FFC4cW1xNtwzgV08xv
         bhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708331837; x=1708936637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojbVELbGUO0Fdw1LO3aSx5BEslcvMdmSrG39OaZaxOY=;
        b=w1MhjJ+Vy/jQ+oKsntKbIsdCugFTpMj7E0nOK4WxK29DqjlkJsReNL+n1erRzC1hG4
         ep6Grvq73zOV6K6alqI+GPAEZ1CIIkcV1jS75Aoqdc7PLuF3ZXtHOSgM4UDSaSKkv6PW
         16PBp75/lyM8BQFJfYbXWEUa8C0mWfYCVBPMvfO4v5gGq1oUuwS5NGFruGxcp+l30YKb
         OIG9r6VtPpTqJHlYcVvmwFrGKeIugrJBhjKI8ToC3bVaPb7AZQwVmLFEJaVLI9OQElWr
         Mq7c+TwwjevUiY2jHCN97sgVwhS3bMSxQT3D5LXgDcPst1zPyEon1iWXMku7uaA8S/5r
         zd5g==
X-Forwarded-Encrypted: i=1; AJvYcCV5ahq3fvp+KvN0IbGD9b5nZavU/aK0qd+Ehp+D3O5X22tWXnnGQOgMTSqx4NnkzHLCgyQodJFmIMNjyKNjYC56zvSLEe6Nd9KLb8W6
X-Gm-Message-State: AOJu0Yxf8CEZG52eKhxLIrd1rkovPoEr6p1CZ9XdxNX6C1si7DhXpCev
	T/ou2ck/K9iVH2gnehu22dyeVqaDb0orMeHUXqj5rojQgo7cSF3MFwtNt949mPs=
X-Google-Smtp-Source: AGHT+IHPRRVfa7/lTL/FAHCnZ0EhKSDENbaTpEre/56m0a9j/pZ89HxBxVne3vEkeUmJJ840QF6VYg==
X-Received: by 2002:a17:906:fcca:b0:a3e:473e:26a0 with SMTP id qx10-20020a170906fcca00b00a3e473e26a0mr2936656ejb.51.1708331836826;
        Mon, 19 Feb 2024 00:37:16 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id th7-20020a1709078e0700b00a3e059c5c5fsm2695590ejc.188.2024.02.19.00.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 00:37:16 -0800 (PST)
Date: Mon, 19 Feb 2024 11:37:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: gustavo@embeddedor.com, keescook@chromium.org,
	Gerd Hoffmann <kraxel@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2] udmabuf: Fix a potential (and unlikely) access to
 unallocated memory
Message-ID: <91d964c2-3d5a-4e96-a4db-e755455c5b5c@moroto.mountain>
References: <f75d0426a17b57dbddacd7da345c1c62a3dbb7ce.1708278363.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f75d0426a17b57dbddacd7da345c1c62a3dbb7ce.1708278363.git.christophe.jaillet@wanadoo.fr>

On Sun, Feb 18, 2024 at 06:46:44PM +0100, Christophe JAILLET wrote:
> If 'list_limit' is set to a very high value, 'lsize' computation could
> overflow if 'head.count' is big enough.
> 

The "list_limit" is set via module parameter so if you set that high
enough to lead to an integer overflow then you kind of deserve what
you get.

This patch is nice for kernel hardening and making the code easier to
read/audit but the real world security impact is negligible.

regards,
dan carpenter


