Return-Path: <linux-kernel+bounces-21544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4788290F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529F31F26A1F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7C43EA75;
	Tue,  9 Jan 2024 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2X/fCjnp"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1CC3F8C4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3606de7f4bdso17033055ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704843764; x=1705448564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIcPXVK1fYFTemMdjpiQGc+AOvdzW3M34c5/yKhDtd4=;
        b=2X/fCjnpWleyUM89aPH0FD6rDIWGbLtUc2Mv15EvJVL5FPT0TO2L7pFdzX4GOsfqP4
         rS18DElgEhNV9dk7NrG1b9UIO6YNdjbBNVjYcjCkpFHGhTqTnjfDzIUMBSq1AVUHRP0f
         yOb4rReEGaiwkslthXZHh9oquvcRXfjeTNELlvIK+JsvTLj0Nmh9AbLPY30wyHZjGfXH
         RbuDC/2hgS6QASD09oWCvr+nTnUu6tof+TYCbfEndNUAR79cj7rPD0zkS+g3if8uX55X
         +95LXNWegkGPPnzW6K9c+/dhd0EmumJtnhedDaR42BlVkOS7Vpj8vlRzq7u+TiyiV6xe
         +QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704843764; x=1705448564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIcPXVK1fYFTemMdjpiQGc+AOvdzW3M34c5/yKhDtd4=;
        b=AZjFn5uq9iJxFFGqCrkMmXIx/1QkTTnidoPJPp4nXxNkyRTEFKvdZaH5ZfiKP6Ujt1
         Ufgv7vjriYqVzFSwTJjRY5ozZmWRb1zgug45OV+L8NKYg/WTzoTp2bLi7wa1pGEjehX7
         psRETFV+7mTn2lvi/7k9sJW7eek7nV2DW0lf2XxqU56ecJ0UG0UXb2ApuarmTzCgEAV5
         oiG7+SwvEMowEff9Gjbsk3KVml1LE2w85KAOu+047UfxDc2sZGToMtVGGIXsCnBXGJPh
         IoRZWnDLJvLeYumBpO5NgzI5XlzDs3ToGurNHjEO5HgmeVZwXU1OmGVuHom5E1bjdO/n
         VP+Q==
X-Gm-Message-State: AOJu0YySQfdRGSk43PJIjRDt3ffq4Leerl83qH251ro8JNyTaJohzhdI
	dJPP41MLfwXJDHOuDQxRJpl8KMFMBhxZ
X-Google-Smtp-Source: AGHT+IFcCSzwyXxCeIeRPodhTFSjdMhuIXovQrmFwVT7Gt7z1oM7wbSewwsMzzo7BrlWgSVFYS5jcw==
X-Received: by 2002:a05:6e02:3208:b0:360:5cd9:a73e with SMTP id cd8-20020a056e02320800b003605cd9a73emr300419ilb.6.1704843764645;
        Tue, 09 Jan 2024 15:42:44 -0800 (PST)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id em17-20020a0566384db100b0046ceccc798asm954664jab.6.2024.01.09.15.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 15:42:44 -0800 (PST)
Date: Tue, 9 Jan 2024 23:42:41 +0000
From: Justin Stitt <justinstitt@google.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel test robot <lkp@intel.com>, virtualization@lists.linux.dev,
	linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Gonglei <arei.gonglei@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH v2] crypto: virtio - Less function calls in
 __virtio_crypto_akcipher_do_req() after error detection
Message-ID: <20240109234241.4q3ueqdjz5o54oan@google.com>
References: <2413f22f-f0c3-45e0-9f6b-a551bdf0f54c@web.de>
 <202312260852.0ge5O8IL-lkp@intel.com>
 <7bf9a4fa-1675-45a6-88dd-82549ae2c6e0@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf9a4fa-1675-45a6-88dd-82549ae2c6e0@web.de>

Hi,

On Tue, Dec 26, 2023 at 11:12:23AM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 26 Dec 2023 11:00:20 +0100
>
> The kfree() function was called in up to two cases by the
> __virtio_crypto_akcipher_do_req() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.

If the script is short and simple would you mind, in the future,
including it below the fold -- this may help others do similar work down
the line -- Or you could also link to a git-managed version like what
Kees has been doing with his __counted_by patches [1].

>
> * Adjust jump targets.
>
> * Delete two initialisations which became unnecessary
>   with this refactoring.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Nonetheless,

Reviewed-by: Justin Stitt <justinstitt@google.com>
>
> v2:
> A typo was fixed for the delimiter of a label.
>
>  drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index 2621ff8a9376..057da5bd8d30 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -224,11 +224,11 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
>  	struct virtio_crypto *vcrypto = ctx->vcrypto;
>  	struct virtio_crypto_op_data_req *req_data = vc_req->req_data;
>  	struct scatterlist *sgs[4], outhdr_sg, inhdr_sg, srcdata_sg, dstdata_sg;
> -	void *src_buf = NULL, *dst_buf = NULL;
> +	void *src_buf, *dst_buf = NULL;
>  	unsigned int num_out = 0, num_in = 0;
>  	int node = dev_to_node(&vcrypto->vdev->dev);
>  	unsigned long flags;
> -	int ret = -ENOMEM;
> +	int ret;
>  	bool verify = vc_akcipher_req->opcode == VIRTIO_CRYPTO_AKCIPHER_VERIFY;
>  	unsigned int src_len = verify ? req->src_len + req->dst_len : req->src_len;
>
> @@ -239,7 +239,7 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
>  	/* src data */
>  	src_buf = kcalloc_node(src_len, 1, GFP_KERNEL, node);
>  	if (!src_buf)
> -		goto err;
> +		return -ENOMEM;
>
>  	if (verify) {
>  		/* for verify operation, both src and dst data work as OUT direction */
> @@ -254,7 +254,7 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
>  		/* dst data */
>  		dst_buf = kcalloc_node(req->dst_len, 1, GFP_KERNEL, node);
>  		if (!dst_buf)
> -			goto err;
> +			goto free_src;
>
>  		sg_init_one(&dstdata_sg, dst_buf, req->dst_len);
>  		sgs[num_out + num_in++] = &dstdata_sg;
> @@ -277,9 +277,9 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
>  	return 0;
>
>  err:
> -	kfree(src_buf);
>  	kfree(dst_buf);
> -
> +free_src:
> +	kfree(src_buf);
>  	return -ENOMEM;
>  }
>
> --
> 2.43.0
>

[1]: https://lore.kernel.org/all/20230922175023.work.239-kees@kernel.org/

Thanks
Justin

