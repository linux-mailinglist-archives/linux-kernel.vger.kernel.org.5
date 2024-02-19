Return-Path: <linux-kernel+bounces-72131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA4585AFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3DF1F23066
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD156774;
	Mon, 19 Feb 2024 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg4plTjU"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A054747;
	Mon, 19 Feb 2024 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708385422; cv=none; b=K79I0Jdzfm7hBftXnwIQOBLlvtzpSDGfZL92G+IkJWtxyVc1INgwu/CoitT7EobmE9yNsbwTrjShHrV8Rg2XeTtUQryNQSV0jJgRE8vLgDhbBx8WvmMJgEeTetUUwHsl5ncLAQSmkgZGq08F/0YobmDiM33Tb5TqnxjDzXIkNG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708385422; c=relaxed/simple;
	bh=CeHPFPzweoMTBxqm2mAquo6FAJ+dj7TgxzmBf+DGHIg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rRM+Ce0sQC2g2dc/pzwS7Bb3AoEmtwZhISmO4PReeeT+XlAZ+wpF2zPo64Qs7H0jmCNfIEGilTvgcXntqmf4d8RPaqK39LaCtsmf0r5V76iXKu/e56xPShQbKgC+OGrxrMPcYNEmzMCV9jNYaH1759+XrfL5aXhEyl0W86QVx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg4plTjU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4126cff4721so2734655e9.2;
        Mon, 19 Feb 2024 15:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708385419; x=1708990219; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CeHPFPzweoMTBxqm2mAquo6FAJ+dj7TgxzmBf+DGHIg=;
        b=Tg4plTjUo2iiyvzbNvFebhpJ8loBqBIMcE26Xyqhv76Th7tcuY9aUiG7oNcRIexwRW
         qEYYBookhEZaGdLSEJxcA+qGLImNifmbat4Yv05ACQCYNvQHpXvtGh4kAHsiLgiO+DrK
         QPnjmIRZ8sTiwFs6iG+QEIInqrNiVUVYeq97ALrlixCkkHKbsGD6SOsuifVNuVTPYysc
         s3SeLZiCtSD7E1FJTtJS+4pWs5hGEdyQWqh+PJpbcPXq33sfnh6M7GLpPv7NXjFc5M/z
         zf0xgXAl6pGATHi1LZadwu9TpdelL3WG0qvj1i97neMDqa4bch1oCRtHkp5csidI3EM6
         xetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708385419; x=1708990219;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CeHPFPzweoMTBxqm2mAquo6FAJ+dj7TgxzmBf+DGHIg=;
        b=cRxrefkUSRulR5p1xjSrFYj/mTusFbB3Yq5Nec+doH0DuSRVXIWV+pGgZpGD3Sxw6m
         GnmQePhTLDFN3r9YwpZhOsVuF/OBfXrV0rTpwG7XxEk70iO7ZF9MJYItAyiz3K1DroP0
         kiFc4NtLfkXqk9bmDxCNuqRDlT28tcndCi4GtMQLzjfkH6Z2YLWGs3APpzFaQEsN7aNO
         sbA6UGJNE8a4Q/QUc3Hk7Zn2BHkqx8zBXNnhQOM2QrPayyNVXpMYOJhA5YxQAVpsecUg
         z2W5HCSMf0trsY2/24xdkmk2LHSeN2ShKHkwEr3MuIv1lEPeGyviikgo/ZCQhoOvLuQ4
         fQfA==
X-Forwarded-Encrypted: i=1; AJvYcCVzCFpnpNKoFiQNt0P6iCUYANhpqhUUnGQrvROrRuKFLkI1rq92L1b4TjIGiBNAowpY59TewYvSuZCAel2itpjX5b0u+t6a4V2YEavTE3rmZFezemS9mLOg2sRC3gRo92y8CMzb7hbl
X-Gm-Message-State: AOJu0Yw5VI7YTAKAdV6xRUMrupNytIzrgRjwsQ8l3oB3kQ3Qu1J54RqV
	tWtfYGILaFFT0SerXRq+5KReS4fOULO+WkefxNFFNoB5qbTiQ6td
X-Google-Smtp-Source: AGHT+IGM7wxI2/8LJWYwud7jh0Ruuy40sHYF6QWziXjdcA+0zuC+91YFsNm2Wl/RjE3ArErGUrxr9A==
X-Received: by 2002:a05:600c:a05:b0:411:f418:375f with SMTP id z5-20020a05600c0a0500b00411f418375fmr9215005wmp.19.1708385419223;
        Mon, 19 Feb 2024 15:30:19 -0800 (PST)
Received: from DreamMachine2.lan (146.red-83-35-56.dynamicip.rima-tde.net. [83.35.56.146])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c020d00b00410dd253008sm12552402wmi.42.2024.02.19.15.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 15:30:18 -0800 (PST)
Message-ID: <6621b55b4a966783259c75dd10ecec929e6e3a11.camel@gmail.com>
Subject: Re: [PATCH] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
From: Angel Iglesias <ang.iglesiasg@gmail.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com, 
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 20 Feb 2024 00:30:17 +0100
In-Reply-To: <20240219191359.18367-1-vassilisamir@gmail.com>
References: <20240219191359.18367-1-vassilisamir@gmail.com>
Autocrypt: addr=ang.iglesiasg@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-19 at 20:13 +0100, Vasileios Amoiridis wrote:
> According to the datasheet of BMP38x and BMP390 devices, for an SPI
> read operation the first byte that is returned needs to be dropped,
> and the rest of the bytes are the actual data returned from the
> sensor.
>=20
Looks good to me :)

Acked-by: Angel Iglesias <ang.iglesiasg@gmail.com>

Kind regards,
Angel

