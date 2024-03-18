Return-Path: <linux-kernel+bounces-106402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185487EE01
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1701F219D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896EB54BDA;
	Mon, 18 Mar 2024 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ES9KYqeH"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B9154BC4;
	Mon, 18 Mar 2024 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780726; cv=none; b=ejbO1no+jS9Rc6wu8wbRqwmuY2kcUXVJu/h/C/XZO55mQbY+i6cswU3ByzildBXVrgCRoRtGv2UeITN/1mcI+/yt4tkEqjdlnrQIungM4ni5IwhoFTUpcUDTaBxwpLwwlhmE8Pm4cug38rnfFkZrArImkQrI3aCEALvijoMAoFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780726; c=relaxed/simple;
	bh=06faSDOvMMSEygDMFyVQDxscKO2QCoGKfE4e/W6tpeA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+7YMvlhvsWv2f4/pCgpcJoW4M6sW/4pSeE3frHRBlFVO2qxAllACX0nttzkT5B6AHLTuJb5IJNpvmRSO39zT1l5YRU7QouUQYKKSZ0sVT58TvZKOw2o8E2CJFkUXQ4RDGUokqaEUNeNPzd9M65rf5ov3wIsVmlCV3z/y0nJCF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ES9KYqeH; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60cc4124a39so47620607b3.3;
        Mon, 18 Mar 2024 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710780724; x=1711385524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vz0r7CrxXAbXAWl8jQv4wux9fTOJzzdZaP8w4NIvRC8=;
        b=ES9KYqeH/pm//HQncwrdVNr4KDVPottUI/pMw+SC7cAinAN64Vek6Hj9ouJHz1rjce
         UaVO6ii6s3sRLjND+nTum/KsLikvFiDPlFVHVEBN2j/a4HSEvzKrJU07QO+WyhV2KlAD
         VIElR+yR+zV28wgeXmk9N9Ujxqd0qF0fPCH9VTOlCuD5nYO2cDgplMq3EvmZ+TMRVGpN
         owzk6fPWUtnOrzjKnN4V8Y5u7Gf2Kh3PdoP9CV+xL4Ls4iubdatTG967/NHm4pJJp/GL
         o6pjDIncroDSmbpnU4VSrXzIHICZLKPZLl7tgkX81gGXJ1F9eNayIjH8vGtjKvF53nwL
         VeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710780724; x=1711385524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vz0r7CrxXAbXAWl8jQv4wux9fTOJzzdZaP8w4NIvRC8=;
        b=MOHF23FzMqqdVBgneZT3reUpMQ7c59uNOTj4bgJ7FKfH6nVFDYHdUQwqOncokbd9YU
         TSMigGo9IAFga4L+qQ67hISti+hlRjLpYxcSormDtqyp/N9z4Udwx3MsiJjksOQGEt7l
         WrEFDYWrDL3HkDVanV5POJVAZieRPC3cKTsSk3CiL4u/lqz95K5x6kdkCqUUJ3MyTyoK
         d5QV4I8M8bzgujXe7iVWKLvttZjM9+a7ZlullCZekqwxaY2SoFQ7pLlxQVe+vMlMMymS
         1x+oTkWfosFa1zomGYXvMlqaLea4IMQTESsvudW3MFaVyuxhBWCfG/3Wqxe2FhEEkb9F
         X/8g==
X-Forwarded-Encrypted: i=1; AJvYcCX3KALHIcTPG/11wW6xJ3okXRZcO2bbswsZHlyApzsRZzOeWfHipZmffTVDySfTRyLNXVSVD0vPRZvXtlxF7+5IZV780yepPA2oWAdGddmk/b9TjN6SNUt9ff4FYw/bLl0o53j5vi3Z
X-Gm-Message-State: AOJu0YykfLIu4X+FT2mRKRv5M96rCkot1DdrZfpXKD5MX2e2TpnNIB1c
	zuxjGV66YgWIx5TDu9hQOAiW8H9IWIycK2oZyq7NVpe4bsqk5Epc
X-Google-Smtp-Source: AGHT+IE74Blc9zBVN0WzDHrovLKlrrSAraGNg67XAavl/JFPJfRSr+e3Xmo8Mk52fM6O7BPN4plgLw==
X-Received: by 2002:a81:6e8a:0:b0:607:f09a:d298 with SMTP id j132-20020a816e8a000000b00607f09ad298mr12423396ywc.42.1710780724301;
        Mon, 18 Mar 2024 09:52:04 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id r123-20020a0de881000000b00609f4a354d2sm2032136ywe.71.2024.03.18.09.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 09:52:03 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 18 Mar 2024 09:51:36 -0700
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: ira.weiny@intel.com, jonathan.cameron@huawei.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
	chenbaozi@phytium.com.cn
Subject: Re: [PATCH v2 1/1] cxl/mem: Fix for the index of Clear Event Record
 Handle
Message-ID: <ZfhxGHXCCgWSLqcX@debian>
References: <20240318022928.509130-1-wangyuquan1236@phytium.com.cn>
 <20240318022928.509130-2-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318022928.509130-2-wangyuquan1236@phytium.com.cn>

On Mon, Mar 18, 2024 at 10:29:28AM +0800, Yuquan Wang wrote:
> The dev_dbg info for Clear Event Records mailbox command would report
> the handle of the next record to clear not the current one.
> 
> This was because the index 'i' had incremented before printing the
> current handle value.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  drivers/cxl/core/mbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9adda4795eb7..b810a6aa3010 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -915,7 +915,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  
>  		payload->handles[i++] = gen->hdr.handle;
>  		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
> -			le16_to_cpu(payload->handles[i]));
> +			le16_to_cpu(payload->handles[i-1]));

LGTM except for the space issue mentioned by Jonathan.

After the fix,
Reviewed-by: Fan Ni <fan.ni@samsung.com>

Fan
>  
>  		if (i == max_handles) {
>  			payload->nr_recs = i;
> -- 
> 2.34.1
> 

