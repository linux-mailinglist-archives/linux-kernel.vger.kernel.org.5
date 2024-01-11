Return-Path: <linux-kernel+bounces-23872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D716C82B304
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A346B246E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44205026B;
	Thu, 11 Jan 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EWbtMVFK"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AF050248;
	Thu, 11 Jan 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E9521357;
	Thu, 11 Jan 2024 16:34:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E9521357
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704990843; bh=8C8ez5oKZ6aDXYV7FW+bq0jKaWn7WFD2LYB/fho2mZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EWbtMVFKYL2VL7NBvB9IBWGY9NuzDr1teQ8Kg3XTGAf6/p9YV7zy3P3Ac9Phk2SQ4
	 961OYlQ9eDIGZYiZdaxA8nEUrdJ4pk3bXlKea6omGpZRwgARpXBIk9mm4COqKh4bu2
	 eDu3wkZKPw15B6WEKV7q9KIQb55kywZst1PjWoH35VLpLaOQAtOVAiHjTxAzaXmlVS
	 Vd92QbaqXYfNwm9yveI7xuXQLJ2jLBGL59eyspKRmGetdpixRfkJssUwbBFA11cJPa
	 at2AzYhtnVS/w+tBvRQm4JLdcDk/qBnCKB+WTkPWL1+uodvvZaKoWDr1e+cjIjaKZ2
	 k1fM+jsO3ey9w==
From: Jonathan Corbet <corbet@lwn.net>
To: attreyee-muk <tintinm2017@gmail.com>, tj@kernel.org, jiangshanlai@gmail.com
Cc: attreyee-muk <tintinm2017@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/core-api: fix spelling mistake in workqueue
In-Reply-To: <20240110185746.24974-1-tintinm2017@gmail.com>
References: <20240110185746.24974-1-tintinm2017@gmail.com>
Date: Thu, 11 Jan 2024 09:34:02 -0700
Message-ID: <877ckfn81x.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

attreyee-muk <tintinm2017@gmail.com> writes:

> Correct to "following" from "followings" in the sentence "The followings
> are the read bandwidths and CPU utilizations depending on different affinity
> scope settings on ``kcryptd`` measured over five runs."
>
> Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>
> ---
>  Documentation/core-api/workqueue.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
> index 0046af06531a..8c325a640862 100644
> --- a/Documentation/core-api/workqueue.rst
> +++ b/Documentation/core-api/workqueue.rst
> @@ -446,7 +446,7 @@ The command used: ::
>  
>  There are 24 issuers, each issuing 64 IOs concurrently. ``--verify=sha512``
>  makes ``fio`` generate and read back the content each time which makes
> -execution locality matter between the issuer and ``kcryptd``. The followings
> +execution locality matter between the issuer and ``kcryptd``. The following
>  are the read bandwidths and CPU utilizations depending on different affinity
>  scope settings on ``kcryptd`` measured over five runs. Bandwidths are in

Applied, thanks.

jon

