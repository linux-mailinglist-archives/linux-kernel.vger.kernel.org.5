Return-Path: <linux-kernel+bounces-154842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4C78AE1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580F4281E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D437860DFB;
	Tue, 23 Apr 2024 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSxihSSu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F0122F11;
	Tue, 23 Apr 2024 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866984; cv=none; b=ozR64S9/NY/VE7kDnM5xeC15E3eAT2Z0OvA5sXKlMlQ7tXvWK3DG8udokJQxw7umoo/sGNyL6ZQ54fWA2OPMM7U3WWg9yTbRj7m16FJO/27ELim2okKJhc8x9iSHN38QNF/9JncimFrSRtWlTn3neSfDQ+K6uTkU94Iow9NY6C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866984; c=relaxed/simple;
	bh=SDrP4kaBL1QTqOrq543JUsX6/r4rmoGEDKqDVQE2Tgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDp50JHhXjRA3dETYxPmjjvSn26tZV0zZ26ZJKT+AGoo+mSd3JJMrq1EgGrvWz983vF0vyWaIQKSsvPM83DveifRWPgNqAXSaYRZx579wFksVQGm1FDYaAhWlwSuUSkxK4yWCAmvzxQ7bLDeHvOvc1QiQTDGNbfZSuqwSlvfo34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSxihSSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E739FC116B1;
	Tue, 23 Apr 2024 10:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713866983;
	bh=SDrP4kaBL1QTqOrq543JUsX6/r4rmoGEDKqDVQE2Tgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSxihSSuCrj6KKttZSw/JNkDPUFhhLj2FBO1e4hQu5taz0qhfXUBNtIvw8cSJqmWC
	 D0HXkavl5zSdIVVvtYMhD70mrfufXVG/ZSGYh4YWTeYdISd7LNmSH3sjmUJEpACd8m
	 ZWQEjln7HvMXu5H/VG8iqdZH+Hn8aq9fRbuj120c2/gMdNR04B94iNQtc86jehBegJ
	 OZYphnfv/LdxSX6mOJ6qUrH7C3sFGLvisOcLzhYnRDSlntWGaKO2DBTlQzyYcNC92w
	 YV/dAfXwSpxyjvskBXGbOODhbMBNnK1ZPhjiWMyJswEsio3yl2EA/ICnJpVOisyS/y
	 IHL0AwpmhrdnQ==
Date: Tue, 23 Apr 2024 11:09:39 +0100
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crash: Fix spelling mistake: "crahskernel" ->
 "crashkernel"
Message-ID: <20240423100939.GH42092@kernel.org>
References: <20240419085206.888416-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419085206.888416-1-colin.i.king@gmail.com>

On Fri, Apr 19, 2024 at 09:52:06AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a pr_warn message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


