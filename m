Return-Path: <linux-kernel+bounces-89929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2158286F768
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8277C2815AB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86C57A736;
	Sun,  3 Mar 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP1iFgJH"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFFE43AB5;
	Sun,  3 Mar 2024 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709504644; cv=none; b=rrZwDkZu6TvEdjCLmiak7wf69l7LtTvFUZvEykydHAgfT48xCAYWUVy85Qk6+wnnWGC5X6SBl5ni+coNwOiOwfPqKdYN6Lho4sHwe5+sFgnlkkWWOM37DM5+rQl+h+3gCO0vMzUa0CojWo+LgyhWFLI+3BJ/bcE+8BI+o/wNlOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709504644; c=relaxed/simple;
	bh=fWKZpoOVsmI9SMFRFzneQ+qINrfQUikH9vUDXnHAPDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOcH84R/wPLn9UKSliJUM04TQFVcGSoVaW73YdgNZQlYZxRRldnGWG3YmjPYOgyNprGyaTwaL0F9GgzY7GMn78bFwGRecReJCpCW6+RgN6PwXsNevA4ZiONc3svw9nwFBrf5B2NBiVJLmT3gzzyks5vfkkh3o6j3AtuV7+SnklM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP1iFgJH; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d27fef509eso53434571fa.3;
        Sun, 03 Mar 2024 14:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709504641; x=1710109441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EL46pY+v2d0L2oaWW+o5qVHF8A3+bX5FwEvxf5XZex4=;
        b=IP1iFgJHin0x4kOchsa0JNHyCEc3EJcJZ9NzbYmfGvaovREJqcF8oL/vmMB7S3O43Y
         ksO3GrsfHCvhUu9WORveRoUmEXBQc8G9u4DAeTgtthxYQ3WnAWCCsud5mJzx7dZV47Tm
         4wH8UdEAJqRza7ocjS4ot/ng9HIHXhPB6E+ZGgmUTQBISCkyZtMOE1Fdm11lFlJ/8J3X
         Ghcb921ufwohYXxQRt86JoSZ0MzbU60sMqS92mH8S/Q/GjTkZLBS3vtBHe/ZNsDKAiD4
         LxMMWrtaKL99tFxsCbZRBx8MYzz6n273VGN6hpGVwztMgGRC8hQpGY4a3xqER5oSAMN4
         CHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709504641; x=1710109441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EL46pY+v2d0L2oaWW+o5qVHF8A3+bX5FwEvxf5XZex4=;
        b=ap0jWsKPBZMGij3kTj5o2UPnNBJEFjacZS++qgwwUCmw5KyfRTcxQJ7D4EWh+GMeWC
         bKdTjizSlACVpMw9oQmHfNhFORqvZVmLsEAEAhp9S0sRZ0w0kQLBHLn4hqo2rp/DA1ct
         +vgzhm2q0DkUSYa4mP+O3rK0QxdxiqiAbDgKcGwYoE7hC43PXSQ88jMDbmTo2hVh+shF
         en6NCeUDeoBsI3g8ElUh+8b/r99ciamLWYaW3wZSInBR/diGSEgdHojvq00WRLRZVpLt
         DwGZS7prdW6X82ZhUA03suxWP+FDr9da5TumVayaUTLmQz4E1G05T5GhMFHlmbhhbyN+
         J3yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBHvFbm3KinhOF6+5FvXmVVC1+i90icHXWV0c/u8y1d0dnz348SnDSTNI1NU2fVe7CmdvjvLEXN/+Cas+J3vi2Kv8PkmpRAIZRafg8STrMpPyWTbH6LPrZw+m7FTh7v4zYYhSn
X-Gm-Message-State: AOJu0Yx62YsmSBrCgsxj73Ru4iNDLRtLPjSSYLavYKBvyDpS/aMvDqfB
	8JlZx3I0hqO5TWjOxUKicZicoPnHEf+ZZHAf45iXUdMI697bqXV8
X-Google-Smtp-Source: AGHT+IHCISfGPU2ASnga0MPJQDU2Wph/zBmNJ+4bntTT0LP9wwbZRHoM0CLPtUE4u39I8gC700OgAA==
X-Received: by 2002:a2e:9f0e:0:b0:2d2:954e:aceb with SMTP id u14-20020a2e9f0e000000b002d2954eacebmr5116563ljk.53.1709504640799;
        Sun, 03 Mar 2024 14:24:00 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id d13-20020a2e96cd000000b002d2682050d4sm1511084ljj.88.2024.03.03.14.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 14:24:00 -0800 (PST)
Message-ID: <2866e576-52e0-463a-be8f-f133aaf1e066@gmail.com>
Date: Mon, 4 Mar 2024 00:24:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] net: wwan: core: make wwan_class constant
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
 <20240302-class_cleanup-net-next-v1-5-8fa378595b93@marliere.net>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20240302-class_cleanup-net-next-v1-5-8fa378595b93@marliere.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.03.2024 19:06, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the wwan_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Thanks!

Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

