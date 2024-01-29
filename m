Return-Path: <linux-kernel+bounces-42258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A6383FE9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155841C2310B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866D04CDE0;
	Mon, 29 Jan 2024 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H6wArnhR"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514DE4C605
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706510355; cv=none; b=n0WQyUZuyIq5qf7Xm2BXE4xcTzY64dMyvCs7ummWjHPe4ZTYtY8pwDO8QdkOeUeRdeoSjMbbRsnpsNrykYSxSBWE+vYS3N2GgNRzuU1G9BejVf37rCtga9OW7PvNNCMLEbqFA1BR83vj9ahYo/BEcPtDyPkwJmCXvWo5VuqoLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706510355; c=relaxed/simple;
	bh=nGc5Rk808XajOHhC3TW8MKeLI1B58l2h/CoEu6PYIB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yt9pJHtcqMDXdxtprMx926/7Z+e+nD2PhBTrHLcN57QU624mVucW3UwvCZyonePwDvuwSsdVaHkHCgsMOwEPi0IjzyHHwgbboCqO/el8xaggoBDrUF69FRImbs6LPP3NrMUA1W0qQWfGJUguWpQQhtL4OIcVn/pJN06lPbq2p7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H6wArnhR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ddb807e23bso923471b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706510353; x=1707115153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYeb+OH2qe6fMf4XQ/Nljtlt3l4/tSy9S/76bBZB700=;
        b=H6wArnhRlJgr39O1+ua/n3ifYlf7ioXr/kkBk8Wm4K6OGFSvQRpIw5SBj4XqhxfeLu
         mPcx0KMmJYDSUCD5ylRaurGuVmhT5LOVlaAxGHXvc1ZVXHndWznQAJnb1Ol+u85kzp08
         IBWa6tVvz/EouGZlxEM2NbgsPxH+P5OJl1PQBE9+9CdhHuyJoJz+YDiJAvp/3Mt9gKje
         XCguLzBwiv9BDPkSTi3Kr17P8+lGLjfwzSZqKjYJTnIkDpBwPYEK8N7rhonKjQF8DyE/
         9Yjp9G6piARafDs1NRXW4EJcEZt+jcOgpMdesirZAt29IVFxjt1cx5hNE49QTmihnaQK
         iETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706510354; x=1707115154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYeb+OH2qe6fMf4XQ/Nljtlt3l4/tSy9S/76bBZB700=;
        b=ED5QfxROHSgkH4IztjfSb+wNrXb8/kmf6qpom0naYnHA3suBjHhP/K1zk2Plj/0c3Y
         5Ngv7pr31zqU4DZ7u1skK5LuDILtFCmSYtNpl2d+8ZXKEKWLYVCnm+6QDjss095q9U0s
         nzB3vm7CZHnuTNj7ktXRaDS0WNVmyVFRknaCi/93O3Wa6HtGDCTY73HUNbbCnBvD0mo9
         Vcn8dHqXZL8BI/4qq8gv/6wWQeMMqFBxSM01VOootjvbLG1I00ZsygkrjVwyXofwsWrZ
         TqWlpPnn1Wsef9iL5caHcizqXs/Q2P4wnzMpAujNXGGU9IPGyPtWipexHOFb1RMqG5P3
         FZIA==
X-Gm-Message-State: AOJu0YzmB9Uqh4qOj9AeuxE45HUVSZCGi1RNSPwsoTneVt82vvrsGoaw
	7D/sflYkrrXFARIgH1akHF2SaclAxF7B+aOyaI4WAx6pweXkPDvQ0mGhIxoYSng=
X-Google-Smtp-Source: AGHT+IG1RlzICcSgDxtlmC2LbhU4LwqCj/TOnOCSgXomv+Ila8IpJ9Qu9TfGh+pEUU91PnCpRFzO1Q==
X-Received: by 2002:a62:f207:0:b0:6db:e6b9:4d21 with SMTP id m7-20020a62f207000000b006dbe6b94d21mr1509406pfh.4.1706510353710;
        Sun, 28 Jan 2024 22:39:13 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id b185-20020a6334c2000000b0059d6f5196fasm5191293pga.78.2024.01.28.22.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 22:39:13 -0800 (PST)
Date: Mon, 29 Jan 2024 12:09:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [RFC PATCH v2 2/3] virtio-spi: Add virtio-spi.h (V10 draft
 specification).
Message-ID: <20240129063911.kqqi4hfxhxoyt2i6@vireshk-i7>
References: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
 <20240104130129.17823-3-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104130129.17823-3-Harald.Mommer@opensynergy.com>

On 04-01-24, 14:01, Harald Mommer wrote:
> From: Harald Mommer <harald.mommer@opensynergy.com>
> 
> Add virtio-spi.h header for virtio SPI. The header file is compliant to
> the virtio SPI draft specification V10.
> 
> Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
> ---
>  include/uapi/linux/virtio_spi.h | 185 ++++++++++++++++++++++++++++++++
>  1 file changed, 185 insertions(+)
>  create mode 100644 include/uapi/linux/virtio_spi.h
> 
> diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
> new file mode 100644
> index 000000000000..d56843fcb2ec
> --- /dev/null
> +++ b/include/uapi/linux/virtio_spi.h
> @@ -0,0 +1,185 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +/*
> + * Copyright (C) 2023 OpenSynergy GmbH
> + */
> +#ifndef _LINUX_VIRTIO_VIRTIO_SPI_H
> +#define _LINUX_VIRTIO_VIRTIO_SPI_H
> +
> +#include <linux/types.h>
> +#include <linux/virtio_types.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_config.h>

Maybe keep them in alphabetical order. Looks good otherwise.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

