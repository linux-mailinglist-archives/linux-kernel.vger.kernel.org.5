Return-Path: <linux-kernel+bounces-32762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39F9835FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8AF01C259C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF5A3A1CB;
	Mon, 22 Jan 2024 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKtOjMbB"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120B8374F1;
	Mon, 22 Jan 2024 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919707; cv=none; b=Wt5whbQ3cqVrkcBA1N6Ep25N2z0Ue685evK1/AG2Gj2W04J7cMW73dusyRtQYhj+EF4yZ/W9SGk46kHzGEQ1/6u6D7+cPuJgtXfFQ++yd6kJwZEwLQtsjNaesORNaCFqF2mCwP1IP1x55440rfbqY/+h1H0xHAMLbYAyCxKDWs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919707; c=relaxed/simple;
	bh=pPWGPf9n2O0H4oOsB6zd/ZUH2JpfRiHcPMPlucfBH/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfyBMVyAx89nhS4O/h6q5Gl42kwpa7YRmWV+wouR8uG0ndjQ/KqVTPKgtxkGu2SVeEOpqTS5bdKLQiPOxxAwg/OFnVzh9OuKp652hsrsowMNHGa67nwrrAIEtdBPJJlsI8pnwk+/eaomWPHDkfGo4dM9pFtk4OTbR5dmDqh58TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKtOjMbB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40eac352733so10127555e9.0;
        Mon, 22 Jan 2024 02:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705919704; x=1706524504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUaBjTF8ze7TJQKlKI0DO8wsNhCqTacpbxQmnNsDib0=;
        b=eKtOjMbBMub3fdlJeAOu3dBol94W8SU2eRjVTXYitsy+Gnv0ngwy5BbChBDTLp3PPr
         JksMoPCC1BapKJ5b9AAA6jH3LlycR70FQSEUCAkJQnCCQl2PdJ/zLTfkPs8Dq9jyrODy
         kekkJ6JKRAwULkYtIwl5Sjbm22rl9WR9lBlXfnzwBtdkioVCFZHxHFlU/idNeGacqD6I
         p1lcT7YNQ5+0y2BsMrmIzi2g67j2Gr8/yVmevNfAHRhSb7yJ9HWGbMY+LtQ/PH8ebUJ4
         EMPqthEHub8TPdxJcK2vxayLygmUhFj55BDBdKRR4ncSOecgsQ8b/RzBqpAVpjTnAeNh
         WNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705919704; x=1706524504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUaBjTF8ze7TJQKlKI0DO8wsNhCqTacpbxQmnNsDib0=;
        b=es2PT0+Vmwn6U1QgQjOfT1m9aCJsyH/dyu/lIA4kPBNU5uvaX8caIApBHjfkMAu0R9
         VFrTUCS/KFZag0G5bsWHay2XND8eV02QNATI6kJEyqjrRjl7Wifd69xfgeN6fcD0WAi1
         h3Mfm6kAFktBQ30vHGqSzqAwdnH+iiptAARN55K49SmYs5tzV87XrW0xpvuEPnL9oksj
         o6jg3ezqr2MQCkEmPgea5VMz8pL7ZcLnnXY7yzMaykt3FAq3eDmBndChvYls1qupOHWp
         MwoZSytCkSYRX5nXWDbECxhcnX2SShnMx1lCnJjxvQonMzOCg2DjQAPLtp18GHhZtJte
         /OzQ==
X-Gm-Message-State: AOJu0YwxpUu0z9EZJABV4HECu2I4xf6zaniX+vWqVZjbtZmtRhD0yoVY
	eNr7rDzyJnb3DS6wG1cF8ZrihYallMr4C2Fm8ejkqLQR1NA3+bIS
X-Google-Smtp-Source: AGHT+IEBg93W5Ic2cq8LVxb2U2hPd7pLRG/nN6Z0J3Udrdl4B95BIKuujofcMkdi+IpBnJPrzbr9Pg==
X-Received: by 2002:a05:600c:548e:b0:40e:615f:32cc with SMTP id iv14-20020a05600c548e00b0040e615f32ccmr2257718wmb.185.1705919703859;
        Mon, 22 Jan 2024 02:35:03 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id ay2-20020a05600c1e0200b0040ead97f70dsm3088330wmb.24.2024.01.22.02.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 02:35:03 -0800 (PST)
Message-ID: <8035f515-591f-4c87-bf0a-23d5705d9b1c@gmail.com>
Date: Mon, 22 Jan 2024 11:35:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linaro-mm-sig] [PATCH v5 1/6] dma-buf: Add
 dma_buf_{begin,end}_access()
Content-Language: en-US
To: Paul Cercueil <paul@crapouillou.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20240119141402.44262-1-paul@crapouillou.net>
 <20240119141402.44262-2-paul@crapouillou.net>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240119141402.44262-2-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 19.01.24 um 15:13 schrieb Paul Cercueil:
> These functions should be used by device drivers when they start and
> stop accessing the data of DMABUF. It allows DMABUF importers to cache
> the dma_buf_attachment while ensuring that the data they want to access
> is available for their device when the DMA transfers take place.

As Daniel already noted as well this is a complete no-go from the 
DMA-buf design point of view.

Regards,
Christian.

>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>
> ---
> v5: New patch
> ---
>   drivers/dma-buf/dma-buf.c | 66 +++++++++++++++++++++++++++++++++++++++
>   include/linux/dma-buf.h   | 37 ++++++++++++++++++++++
>   2 files changed, 103 insertions(+)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 8fe5aa67b167..a8bab6c18fcd 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -830,6 +830,8 @@ static struct sg_table * __map_dma_buf(struct dma_buf_attachment *attach,
>    *     - dma_buf_mmap()
>    *     - dma_buf_begin_cpu_access()
>    *     - dma_buf_end_cpu_access()
> + *     - dma_buf_begin_access()
> + *     - dma_buf_end_access()
>    *     - dma_buf_map_attachment_unlocked()
>    *     - dma_buf_unmap_attachment_unlocked()
>    *     - dma_buf_vmap_unlocked()
> @@ -1602,6 +1604,70 @@ void dma_buf_vunmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map)
>   }
>   EXPORT_SYMBOL_NS_GPL(dma_buf_vunmap_unlocked, DMA_BUF);
>   
> +/**
> + * @dma_buf_begin_access - Call before any hardware access from/to the DMABUF
> + * @attach:	[in]	attachment used for hardware access
> + * @sg_table:	[in]	scatterlist used for the DMA transfer
> + * @direction:  [in]    direction of DMA transfer
> + */
> +int dma_buf_begin_access(struct dma_buf_attachment *attach,
> +			 struct sg_table *sgt, enum dma_data_direction dir)
> +{
> +	struct dma_buf *dmabuf;
> +	bool cookie;
> +	int ret;
> +
> +	if (WARN_ON(!attach))
> +		return -EINVAL;
> +
> +	dmabuf = attach->dmabuf;
> +
> +	if (!dmabuf->ops->begin_access)
> +		return 0;
> +
> +	cookie = dma_fence_begin_signalling();
> +	ret = dmabuf->ops->begin_access(attach, sgt, dir);
> +	dma_fence_end_signalling(cookie);
> +
> +	if (WARN_ON_ONCE(ret))
> +		return ret;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(dma_buf_begin_access, DMA_BUF);
> +
> +/**
> + * @dma_buf_end_access - Call after any hardware access from/to the DMABUF
> + * @attach:	[in]	attachment used for hardware access
> + * @sg_table:	[in]	scatterlist used for the DMA transfer
> + * @direction:  [in]    direction of DMA transfer
> + */
> +int dma_buf_end_access(struct dma_buf_attachment *attach,
> +		       struct sg_table *sgt, enum dma_data_direction dir)
> +{
> +	struct dma_buf *dmabuf;
> +	bool cookie;
> +	int ret;
> +
> +	if (WARN_ON(!attach))
> +		return -EINVAL;
> +
> +	dmabuf = attach->dmabuf;
> +
> +	if (!dmabuf->ops->end_access)
> +		return 0;
> +
> +	cookie = dma_fence_begin_signalling();
> +	ret = dmabuf->ops->end_access(attach, sgt, dir);
> +	dma_fence_end_signalling(cookie);
> +
> +	if (WARN_ON_ONCE(ret))
> +		return ret;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(dma_buf_end_access, DMA_BUF);
> +
>   #ifdef CONFIG_DEBUG_FS
>   static int dma_buf_debug_show(struct seq_file *s, void *unused)
>   {
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 8ff4add71f88..8ba612c7cc16 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -246,6 +246,38 @@ struct dma_buf_ops {
>   	 */
>   	int (*end_cpu_access)(struct dma_buf *, enum dma_data_direction);
>   
> +	/**
> +	 * @begin_access:
> +	 *
> +	 * This is called from dma_buf_begin_access() when a device driver
> +	 * wants to access the data of the DMABUF. The exporter can use this
> +	 * to flush/sync the caches if needed.
> +	 *
> +	 * This callback is optional.
> +	 *
> +	 * Returns:
> +	 *
> +	 * 0 on success or a negative error code on failure.
> +	 */
> +	int (*begin_access)(struct dma_buf_attachment *, struct sg_table *,
> +			    enum dma_data_direction);
> +
> +	/**
> +	 * @end_access:
> +	 *
> +	 * This is called from dma_buf_end_access() when a device driver is
> +	 * done accessing the data of the DMABUF. The exporter can use this
> +	 * to flush/sync the caches if needed.
> +	 *
> +	 * This callback is optional.
> +	 *
> +	 * Returns:
> +	 *
> +	 * 0 on success or a negative error code on failure.
> +	 */
> +	int (*end_access)(struct dma_buf_attachment *, struct sg_table *,
> +			  enum dma_data_direction);
> +
>   	/**
>   	 * @mmap:
>   	 *
> @@ -606,6 +638,11 @@ void dma_buf_detach(struct dma_buf *dmabuf,
>   int dma_buf_pin(struct dma_buf_attachment *attach);
>   void dma_buf_unpin(struct dma_buf_attachment *attach);
>   
> +int dma_buf_begin_access(struct dma_buf_attachment *attach,
> +			 struct sg_table *sgt, enum dma_data_direction dir);
> +int dma_buf_end_access(struct dma_buf_attachment *attach,
> +		       struct sg_table *sgt, enum dma_data_direction dir);
> +
>   struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info);
>   
>   int dma_buf_fd(struct dma_buf *dmabuf, int flags);


