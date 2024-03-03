Return-Path: <linux-kernel+bounces-89928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B88586F765
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A8D2811E0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2FF7A733;
	Sun,  3 Mar 2024 22:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEDxnU/L"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B443AB5;
	Sun,  3 Mar 2024 22:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709504549; cv=none; b=qeSyVbAfjbfmJRrdE2PG66XwRl+PLxRfXY07bBGj3LDnlfLWAYr0K0sim6CWu9cJN1nHPnc4kqC2CHovhZSsuq7+qVI3Oi7OjRWvUi/PX2F6m4xSupRLWDN1FLAh78L8AursZrIWcd197zf/avQ/dvGOrw8+wMFVQ7kxRo4jyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709504549; c=relaxed/simple;
	bh=l4c7mgc2KlsqWlFa+HlguYlMpiem2JJrvCbQrfK5PdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXTOSMePsWnuBo8jmTkCoCgyJhIppG6HeD9PcU5WLQrkkOOtPhoYmVUtVkP52+XX0t4uTsQ+NeRgSoP7CVLaD49sX8x3KzekGBBGdb9iPH/1YtZr1XVldaBolCwTDQ1MZ1FuVdIedaFiklrMp4NkTxRFF6adnNanasavDWFi4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEDxnU/L; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d094bc2244so55580291fa.1;
        Sun, 03 Mar 2024 14:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709504546; x=1710109346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jIHXZVVXuB45GC2GRd9h6jwuBiJ6oIOuCBu3L9F02rY=;
        b=XEDxnU/LTuVVZpK+0YcTCzz8AnqEB0fsj+jSXAr3prdqQ2CVvAqw5sJUWk8JGkOsdj
         y+u0PfFclFifCSPJXTGyR9NqoLQvBSRt22U2irn3GW2ho8wwJHxXONnrzbkzg3+UzRHY
         zg6RnBnxvfNUTSIuUHpRN/1SidyRun7Be6uhcLg5OfksNdgSmQVrmvmvcxHLIY/iv3q/
         jRNr/BfqktjrD3fUfaYpda8/YNYZVj8AhFUDWnijeyEtORAdzhL19Gy92dal6zS3r/4w
         iC0bRCqyQHGbJo9d1XZwcDqMKvo2mKDJU+g7gTKc2FgAZXgSi4DRc4Xx+iOUmxKcXkAH
         eINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709504546; x=1710109346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIHXZVVXuB45GC2GRd9h6jwuBiJ6oIOuCBu3L9F02rY=;
        b=tDkZgaiwdzq0n6uF3/RkBite6F92gReAGr3o20pWB7APZcZMKn8cpzIqfM15GvLt9z
         CqxnOeAeSO2jmIVC5MKQ1gVC5/QzeLsUgkm1Qshf15e2yAR+8+sG7rzWebnKVhyBqO2N
         1YwcODBPDDg5YGvcMGSLFvBlQbtuzIw03PbGXxYb0MWrtJE3xo5bGMHVCBqDKgW32hdR
         mAABs71plw/DM3nroycpGjRX/Q2vBax37dSyNXt57ujyjjGDNBdEfXQSQ+whDGNA9fRQ
         gFEh8IfQjj5aYnq+tbcs/CG8n1c3TvXjbP7nnaczAaIPrJfyfDnX9TJ3euHPDhV9UP8e
         IPEA==
X-Forwarded-Encrypted: i=1; AJvYcCXlpTu/mjYlzcjcHajI3NGIb9R+xRrv5FFctBsDrhRdyu9yrQjQZIuRuSApiHm3avKdl8Uvt2LH+yAfS1h23PNaxJILiKaThHcwaurWxYAK7hDtCLCSgBI2ogKll5t81a3w4lOZ
X-Gm-Message-State: AOJu0YwTBRa5WVG+gpVFXj4rA5OrBhk6y5hUVzKQ4nesM1uXtoW/Q/i+
	y0418jRfiMxWPmplCwQIZCj9Se2YwTCdybfwbTSztfb3T6OwNptX
X-Google-Smtp-Source: AGHT+IHu8I1Zwv26dmjKIfDiaxNPSlGOYlKPf3LY+iJMU4xUgK7l6x91TUDaOVHUIWmGoInXK6kFFg==
X-Received: by 2002:a05:651c:b0e:b0:2d3:af63:56d0 with SMTP id b14-20020a05651c0b0e00b002d3af6356d0mr1447804ljr.42.1709504545831;
        Sun, 03 Mar 2024 14:22:25 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id d13-20020a2e96cd000000b002d2682050d4sm1511084ljj.88.2024.03.03.14.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 14:22:25 -0800 (PST)
Message-ID: <965c055a-1ff7-4b7e-9fea-3fbca5b08be8@gmail.com>
Date: Mon, 4 Mar 2024 00:22:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] net: wwan: hwsim: make wwan_hwsim_class
 constant
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Loic Poulain <loic.poulain@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Paolo Abeni <pabeni@redhat.com>, Salil Mehta <salil.mehta@huawei.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240302-class_cleanup-net-next-v1-0-8fa378595b93@marliere.net>
 <20240302-class_cleanup-net-next-v1-4-8fa378595b93@marliere.net>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20240302-class_cleanup-net-next-v1-4-8fa378595b93@marliere.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.03.2024 19:06, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the wwan_hwsim_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Thanks!

Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

