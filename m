Return-Path: <linux-kernel+bounces-41258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CE583EE18
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CC2284022
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ABC2941F;
	Sat, 27 Jan 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKFpN6ao"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15470200D4;
	Sat, 27 Jan 2024 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706370782; cv=none; b=EkQ88Xro8aeWJS47ck4zKNcN6QG8oTCUPGSNLG3PmMOD+lCesGzx6ZqHxCrSsfqQSykcXu+6CUq0417FasW5HQgzHcvLv63U5d+u1UevkmjfF/ITQ2f8eF4/XiF2oJ6irsQAL4X8rpBZeTAfQH59t4pl6m4MgnKlNUJDbbKjb4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706370782; c=relaxed/simple;
	bh=0YrSO1h696+GEJ50oswGfbDXeCj0z5bC7JdxE464cVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZhlsl1v0kzdu9y0bptz3InGXUtKm0FUczWK7YETpWJVCYeqpdfFHiUr2UGIvUCvzJQShuwAJ4rDxClVQv9H1KPUh1YmKXOxNzuqkktTM6DWuXSBP08uoslyzX1PyI5RpESTAUvTC85kzk96hn680iucuzaJYJeeqvKkIhY9LiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKFpN6ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD7CC433F1;
	Sat, 27 Jan 2024 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706370781;
	bh=0YrSO1h696+GEJ50oswGfbDXeCj0z5bC7JdxE464cVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IKFpN6aoFvHavI6MI29AP/Z3aGLqQypKa6O0orqOeV3LLDYV3FmwYuHxIhhB2Cnel
	 B+TOGeVB9BFMGLHBfLNA9O0qMXoT7VkElO+ReBuQx/RC1n0Q/ppWRVFzYujsGtZEMr
	 5/73PTeUV9BjJsMBU+3O7BbYo5XOJ7dBdYOtWhl5W042spPL9+dEK1r+WYFqrVUtq2
	 qDEnCeIfSKE0SNkD3ieKy1i7OqdeJLeu8EC8NuDEkCwF6xLsj5Q29ToHMsek57MSxg
	 rnZHOUq4Kgu34Tx7y38CwrAVDaM7oX6Z2sSwa12lX4/ZlPVBv2M9UDZhLBJc1IlS8k
	 Z/h1fleyUL8zQ==
Date: Sat, 27 Jan 2024 15:52:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Paul Cercueil <paul@crapouillou.net>, Lars-Peter Clausen
 <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "iio: add modifiers for A and B ultraviolet
 light"
Message-ID: <20240127155247.00f6aa3b@jic23-huawei>
In-Reply-To: <efdfb611-5ba4-4cd6-a7f0-bd96259cf1a6@gmail.com>
References: <20240123104305.10881-1-paul@crapouillou.net>
	<0bd3319f-7d63-485b-9b44-d6858c045b37@gmail.com>
	<a6f79ec0025e1862ba170c6a535447dd09e7dfad.camel@crapouillou.net>
	<efdfb611-5ba4-4cd6-a7f0-bd96259cf1a6@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

..
> > Can you just move these entries to the end of the enum in your new
> > patch?
> >   
> >>
> >> Thanks and best regards,
> >> Javier Carrasco  
> > 
> > Cheers,
> > -Paul  
> Sure, I will do it right now.
> 
> Thank you again and best regards,
> Javier Carrasco

Hi Javier,

If you sent a v2, it didn't reach me or the list.

Jonathan



