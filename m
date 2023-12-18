Return-Path: <linux-kernel+bounces-3256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A05218169FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFF21F23203
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A235125C8;
	Mon, 18 Dec 2023 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+mDdHN2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507A0125AD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2343c31c4bso120674066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702892342; x=1703497142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRPdYcUK3bn4d/UXXQLaapxgT6fJS3k55mWLhcaaxas=;
        b=o+mDdHN2EtmgjBO6ntxWOFVioz+gL6okdo/e/cJRvzvhMNOEkL4IoyrFdatU7rI9R4
         dS7cfNKaHy9Xj6m0V+EH8l2OmXhaztNbmB3swKazTqBg0Mwd1L7ujI+XwF8D+lZGqDEn
         ozqgB412mHq7/UZVyU/ctIAO397zLqixkbtCxL/lmLriVYtowHiW6nbWglG6xo/HabC7
         h78i46ueaP6bY3tNFy3FEDCeTM/TiMi5AtrDHq3UmdC8zSJ5A118arQP8nkajAz4RqJ5
         trVAqmBadYRzqzCE6IfBs/M94I+xgoncNVvehSXpST5CGZoAdw4z0jnn9e6h5sG72p3N
         l6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702892342; x=1703497142;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRPdYcUK3bn4d/UXXQLaapxgT6fJS3k55mWLhcaaxas=;
        b=ehrEALyzbYasWe57yl6VfPqWoMcRnh1J5u9IaWRqetn1KSxYxWn9TD/Bzu8Dmy0PlA
         g/7uS0ZvSysUZdlpXcn8OynpwlNTzhyjcO9rWy0rbgecIfyN3lPl8wSE1R7F8+HfMxSN
         UY7gmhRAElqz91XfDcniYlJ4MpCb7c3o79woZhynmzlUHd4djm6m0vvN69UVUeHDGgHC
         lv28/pNgu/N0LLQn6pE2W2nMp9eVC2EoMuGQ1nxgeB0Gk7EZbVgmQOpIUYmCb80AIIKN
         AanA8go1dK9kHKRlMa+kV1ADXmgu9FDZni8AFtZGO5OHu/YOo6CUNS+JbcRTU3pX2RYD
         hG1Q==
X-Gm-Message-State: AOJu0Yy93SFVEiUeXd1q2usNjRho/Ze0EiTGteClQyxGNqWpQsvN2b0Z
	OJmKrhGe03+h372lnpj8RONSvQ==
X-Google-Smtp-Source: AGHT+IHCY04o2ElyEIUFv45JzgsxUGUOaLPS9XFvi3QivAc9F3XZ2RcNWxsqNxNkiq3+S+5soAdwaA==
X-Received: by 2002:a17:907:9349:b0:a23:4c0c:7cb3 with SMTP id bv9-20020a170907934900b00a234c0c7cb3mr677668ejc.120.1702892342527;
        Mon, 18 Dec 2023 01:39:02 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id cw10-20020a170907160a00b009bf7a4d591csm14136712ejd.11.2023.12.18.01.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 01:39:01 -0800 (PST)
Message-ID: <6160aa1e-5f77-4d7d-aafd-e1ac7606bf06@linaro.org>
Date: Mon, 18 Dec 2023 10:39:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/2] nfc: llcp_core: Hold a ref to
 llcp_local->dev when holding a ref to llcp_local
Content-Language: en-US
To: Siddh Raman Pant <code@siddh.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Suman Ghosh <sumang@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
References: <cover.1702816635.git.code@siddh.me>
 <0d812b9aae2f16691d373460b06c5f3e098ed2a6.1702816635.git.code@siddh.me>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0d812b9aae2f16691d373460b06c5f3e098ed2a6.1702816635.git.code@siddh.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2023 14:11, Siddh Raman Pant wrote:
>  static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
> @@ -959,8 +974,18 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
>  	}
>  
>  	new_sock = nfc_llcp_sock(new_sk);
> -	new_sock->dev = local->dev;
> +
>  	new_sock->local = nfc_llcp_local_get(local);
> +	if (!new_sock->local) {
> +		reason = LLCP_DM_REJ;
> +		release_sock(&sock->sk);
> +		sock_put(&sock->sk);
> +		sock_put(&new_sock->sk);

Why is this needed? Which part earlier gets the reference?

> +		nfc_llcp_sock_free(new_sock);

This order is still wrong. Unwinding is almost always done in reversed
order, for good reasons. Why do you unwind in other order?

> +		goto fail;
> +	}
> +
> +	new_sock->dev = local->dev;
>  	new_sock->rw = sock->rw;
>  	new_sock->miux = sock->miux;
Best regards,
Krzysztof


