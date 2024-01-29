Return-Path: <linux-kernel+bounces-42239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B1983FE68
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9338B2220C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D46751C35;
	Mon, 29 Jan 2024 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iM9GuFvR"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D44E1C5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509852; cv=none; b=eVX1U4qfEMefY3T/bs9HFLnvG1EOm0DkDUOZ4tvmednDte1TVdLJzUkmqYAa8ocQ2AEp9PUyBjXMWc9FlPy8jZJoKRGS1vQaxvLgMUMpUUMLiYz3ZcpumMAA/36KQkNNHfV/OqUURoNUK5tO42w19E3w9AW0sFe7pImRodG8dTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509852; c=relaxed/simple;
	bh=Nh5fNbqnzNpSKk7yH37ydnGyv3ul2OhY4GvbMvtsgNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7F1uJ6vr8fnwlcawHWVQFuQfXurpYwgCmkadbPDVmUM3URqqEgl+pHylpCoA7JvP3fmyAHfkG3gjP6iPSIfVFiAvuGUPngg6h2LEpKALM5TXy3CdTaRxzCA+7eW+JuOFf8whFBxP2zBrS7W/v/wt4TYPrlXO/XgAZ4wivjMKXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iM9GuFvR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2186704a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706509850; x=1707114650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qcNcTEhoIWYD8Jyza8FT+m6h2KJ7pAuMT+sHRSLuWk8=;
        b=iM9GuFvRGWM71YvcjnJw73gMBeFJ02MIWov/qaO/lfKNjVs5sAcyysdah//jOwBJXT
         YIvGHDfqWqk9Ekj3dLK35tlkc0RZMakLM6zUIY4JlgT5IOYHZz9wdiCrWYm+5V2sk+sw
         iYNtEwH+J5m+DmYwssrWYb+IMDxM5P2tRxFz+Mn8mRfyHzVuAHdSKTresAhdMsp0Kf2N
         D1OZJFgTe5FR4v0hwj8Wb9JUSrpyL11XnEzrlUfsvZT+9fEtHiSqiC/J8bafQA/rLs0x
         AXUZ/L6xalpzxTF/Gu2aQWdApnN+kIZfx8vlIuyUcmSbM1Rdml6Fuhsiwymr53iEsDWZ
         BucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706509850; x=1707114650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcNcTEhoIWYD8Jyza8FT+m6h2KJ7pAuMT+sHRSLuWk8=;
        b=Wx1tlUFn81SeQ3CzIRY0yT9NmJ0HHO+GkN4M0Tl4LHSEKmL+TtyzViy9iorPJro41P
         jDxq/qWy5xaRk10whqv0l7xnYlmdE2ZQLPzxD4rxMuvm+ROGs4tgUFKPtO1/axxrQngF
         1Zib/+1MiQ4TIfntOhfYQqCNn1v6dfhZV87uM6fosf0voCSv33OBDRfVkhixp0E5sbLo
         MDHaplV+B6x0q8BR+DbLj7o7KF9AmZrJZT0wNKVH76TZUEu50XxPInSyXojMk6icbv1r
         JLX9iJ3MUgCQhhRQPmRgNMKVpl32KjzhyZdt230IgOt/kbCQevCKMLEknFOAVt2l+UfA
         2W6g==
X-Gm-Message-State: AOJu0YzKzMYA3N20wGy4jF8iOPa9UylDeISMTjl32oS531LjDQ8m4uSd
	uCpwTlsfcYD8NZeSZaRGInR4DhJAIH9o/ylVy3iHIiYostOEFBrG1oywoD5oCgpOvq5nEiHnGMG
	k
X-Google-Smtp-Source: AGHT+IGh1h+05vCnmj809KQhjvUSTg1qxRaQJCyMKHLDmh1e7V1HvPMklyZdkqrrztZ7SNswfm/rew==
X-Received: by 2002:a05:6a20:7f8a:b0:19c:71bc:ec82 with SMTP id d10-20020a056a207f8a00b0019c71bcec82mr4830387pzj.48.1706509849818;
        Sun, 28 Jan 2024 22:30:49 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090a088f00b002902076c395sm7215305pjc.34.2024.01.28.22.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 22:30:49 -0800 (PST)
Date: Mon, 29 Jan 2024 12:00:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [RFC PATCH v2 1/3] virtio: Add ID for virtio SPI.
Message-ID: <20240129063047.hgnljeqq2xswoteh@vireshk-i7>
References: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
 <20240104130129.17823-2-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104130129.17823-2-Harald.Mommer@opensynergy.com>

On 04-01-24, 14:01, Harald Mommer wrote:
> From: Harald Mommer <harald.mommer@opensynergy.com>
> 
> Add #define ID VIRTIO_ID_SPI 45 for virtio SPI.
> 
> Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
> ---
>  include/uapi/linux/virtio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index 7aa2eb766205..6c12db16faa3 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -68,6 +68,7 @@
>  #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
>  #define VIRTIO_ID_BT			40 /* virtio bluetooth */
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
> +#define VIRTIO_ID_SPI			45 /* virtio spi */

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

