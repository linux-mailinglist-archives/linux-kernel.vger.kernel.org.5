Return-Path: <linux-kernel+bounces-16859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCDC824514
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BCC2B23BE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8058624207;
	Thu,  4 Jan 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qMvLBmwe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B6219E8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id LPlKrqxpy9TFdLPlKrksRV; Thu, 04 Jan 2024 16:36:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704382563;
	bh=m/73VPI7SQbIGru8DsYnoCGvDgBHipomOllqcMV7BhM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=qMvLBmwewUDSfZ85F12hloX9gXDpLOZFtg0DcsQBqT2/1V8lvWf1yfDFI9xzDxicR
	 wYp7aRkv9z1yb8pbNOpr93IK0a/PJOG7y2dIPBb+rniyoln9OfYYBY5w9/DY74/QhB
	 j7hAWOCv6L5l2pIq4ERxK07Xo9JV2Zkc34B6MWaHx5X8IT6NRMlnp9PVuhvsWu1eJq
	 JaELC/yuWm/5+6Bggn8iIg62uBNcetCxu5Q9Yi2eSVsaVdiCa/QRGVj1SzH/ysqIAh
	 9IIt292wmhZkWKaZU8z0H9PAw9r2A5DGU4XcPyym26gDl+ezNCqye/7wdOkIMambzd
	 4rSj3KTbBAE2Q==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 04 Jan 2024 16:36:03 +0100
X-ME-IP: 92.140.202.140
Message-ID: <eacd168f-22dd-4e11-8907-0c79ee33f595@wanadoo.fr>
Date: Thu, 4 Jan 2024 16:36:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] android: removed asm-generic/errno-base.h
Content-Language: fr
To: Tanzir Hasan <tanzirh@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>
References: <20231226-binderfs-v1-1-66829e92b523@google.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231226-binderfs-v1-1-66829e92b523@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 26/12/2023 à 18:09, Tanzir Hasan a écrit :
> asm-generic/errno-base.h can be replaced by linux/errno.h and the file
> will still build correctly. It is an asm-generic file which should be
> avoided if possible.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> ---
>   drivers/android/binderfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 1224ab7aa070..d04ff6029480 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -29,7 +29,7 @@
>   #include <linux/uaccess.h>
>   #include <linux/user_namespace.h>
>   #include <linux/xarray.h>
> -#include <uapi/asm-generic/errno-base.h>
> +#include <linux/errno.h>

linux/errno.h is already included a few lines above.

CJ

>   #include <uapi/linux/android/binder.h>
>   #include <uapi/linux/android/binderfs.h>
>   
> 
> ---
> base-commit: 606d9c29e71fbf52fcfd3fcc3ad92e444c8e1d47
> change-id: 20231218-binderfs-a758e162e0ba
> 
> Best regards,


