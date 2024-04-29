Return-Path: <linux-kernel+bounces-163167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BC88B669C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1691F2132B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75791194C9D;
	Mon, 29 Apr 2024 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ayMTo6Tm"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519F4194C72
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434061; cv=none; b=gPmBVBHahuCVEhLxZ0HKbRdyNhCG3K4o/EaZ2hbOgDPCYVCMPwBlGk+xalEj1X6iSMW4tOx1bsR9Ago1+9PD6NRUgcQWmfZPlOEHwodg1PTxUhreqloeJ5ZtzrnbUBPoqOObCknuBSaPXs+tIH34hcQt78erextztMXoXZ5aqag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434061; c=relaxed/simple;
	bh=9MO1ID6/Dni98gXftjcdPKVRf1xgWDaDWvJs3kq8WcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEXBdkHmdh5lnQN7+WT2kBsnyIx5US3sLocVAOX2ncdFaUU7rBpgFZDUVwCf8kHhrJ84ndQviQdmMauCSjWlEuD4vTYE9YXVZqOoxuNd+6rZ7ZAAUuyHYNMmIElcXJmRkUFN9y0A9ocIhrDZoxKtE8UDQPsctKXxetjgbZ1Vi4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ayMTo6Tm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b2119da94so41190565e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714434059; x=1715038859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLAA8r7OMJ9LI4fbMG9YMmoxVfYzPxAZqvpO6GyTP90=;
        b=ayMTo6TmDbAQvPIU5ZVbCDyaWMSgjDmiLYIw+lHqdFudSQkzRaoSlsWxmLKD5Z8Tp3
         SuIOCsNVLYoHPHtrkeIzm1/OFXPz5wiOsUUJunfio8KrdrIa5e8RpcXlPr+OBShieOBr
         VU4Rw0wbUyqMSyORfvO7TziFuxmislvqIr2nIEj590lUTsj5NRK1VRh1mcSTkt10VmkK
         yNyu2RUiydSDfleWykKZuZNE7+wYGNopDQlwDnXmUxbK6+hNQOXXfp2yjlY6YIGVgR/K
         JV9srGtmJ1+AyatM+ieiEbnjYv55nwXN4ccDSNpNBKFTCZp4xa+YTGRjG+TWqBAu/lfT
         MShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714434059; x=1715038859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLAA8r7OMJ9LI4fbMG9YMmoxVfYzPxAZqvpO6GyTP90=;
        b=ouEgZ0MSSZUJWZ3NwvxdL544krMXW11QFgUqYlnujkKsxNzTeWyjfWoIOaUVWvjyH9
         pLltUtQY6GGPe3kEuk/CT1EFYfZMhFsaH1GykZn8G77UGzQh0/P0B+EkHNAOkVnRixBG
         i5OKaR75PcGepCX6qIRX50YFaUW8Tm/Y19ZPrG7e5Wu3nK8MKHY0lCMYvJuVwKZl6x29
         HDMfiOGJmgyoPy/7LwkFJtro3AsusJ+0LWQK+y9LViyhzbDD3fnGRURSd7B8yCHXxEdk
         caZhC43JpeMDtH/fTGT/hz4kcfmqgdM75O3tXi+ez856/UJdXIavFl5sAANYb4p0RcE0
         7hkw==
X-Gm-Message-State: AOJu0Yxv453b+rMZwd23OmKlBdxrFDDlXMRlbUAAQ7/zlkfcUdSAUliu
	rOwsGcdZelcgm9fVeaOEpddIOycoo3NbYedKZzV/d5pe3I1NuvZl5u4YBfslOmM=
X-Google-Smtp-Source: AGHT+IHw76QNirOES/5P2hd6Dx6Wf7Xfab/S+qu6ZJw5C+dTUqXBmmJDCE8Q4AXh+LWLhhp930kfsQ==
X-Received: by 2002:a05:600c:458e:b0:418:dbad:c57d with SMTP id r14-20020a05600c458e00b00418dbadc57dmr687758wmo.28.1714434058600;
        Mon, 29 Apr 2024 16:40:58 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z10-20020a05600c220a00b0041bef325c4esm5309725wml.1.2024.04.29.16.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 16:40:58 -0700 (PDT)
Message-ID: <ce8b3277-a371-41f5-ab61-181a05f38058@linaro.org>
Date: Tue, 30 Apr 2024 01:40:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add OSTM support for Renesas RZ/V2H(P) SoC
Content-Language: en-US
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chris Brandt <chris.brandt@renesas.com>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240322151219.885832-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240322151219.885832-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/03/2024 16:12, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi,
> 
> This patch series aims to add OSTM support for Renesas RZ/V2H(P) SoC.
> RZ/V2H(P) SoC has 8 GTM channels.
> 
> v1->v2
> - Inlcuded Ack/RB tag
> - Updated commit description for patch 2/2
> 
> v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20240318160731.33960-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


