Return-Path: <linux-kernel+bounces-16546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6C2823FF9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E5E1F22201
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6631E2136A;
	Thu,  4 Jan 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mblrYhoc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB032135D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cceb5f0918so3911281fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 02:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704365759; x=1704970559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oH+x8dc7CjlHtZS1AokXJkpjh5RJpjx4kF8N/HDLA1Q=;
        b=mblrYhocD2Z36/r8saKxis4pkM6hO8L3ZiHSvymct1iFX2gtzGsPUC9NFJX+CzZLPt
         TP4Xn5w5XPMbLMGUOevm1fXIKRnaTdRwQIdnAM1vFehGlkm7BopjtK2yrWeoO44DiTP9
         ZmjcYEIa0XZQY6Bt+vX3HJYaq+OLZjtpC3agvw2JFx3Olo5mYagr/qkrYa6S1zFziaE3
         9fUmQRhlXES629OwrZyMte0bgAUPiPsoYMjDqP2FReJhd3RZWO9RLaBAq+xdph6D7lL8
         ksCzWDaXPyvyPd7LTTrz0DcdTkcjUSA35fKv5APef3PdpamnXic3zzBxIlE9VmzAdvcg
         QTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704365759; x=1704970559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oH+x8dc7CjlHtZS1AokXJkpjh5RJpjx4kF8N/HDLA1Q=;
        b=c5bXTeSYQoBq/ve6/HF3SeloULX9oJ+4irdunGNKC7xe4cTbyyEF1QARGm1K2tUads
         L0qHlRmKB21W/cm90pj3WxzYCAfu9jJ6PjsUCRWBotJ7jY8KSXzz3+DDWndiBVW+i1W0
         /hW5aB4/akrj2pkK9GKPBNmG3XKlRCVP9Bknhk3QTOjGqNXNcRhuqTT3qwbh1dn0Bzv/
         r51IZVq02LYvPYUqKYAw/oC6kIgwWTbmm0MNyLZwSJzn++Db+ymD8kDgpEg6dpaEMEXQ
         5bhB6MwINbhQudGJ1iwF3F7W43q/q3FXivEbWXBysgwT67fkv7NTmp6DOdOvykSpkxYF
         rvGg==
X-Gm-Message-State: AOJu0Yy2E5kMN4nmyYi45mNwbC/9vaiH1PoZI5vpvF6WIF0YndH43hd+
	DOzgagFr1sPrEFcwyxFeU0ow8sgT+4Ehow==
X-Google-Smtp-Source: AGHT+IE+bd6zfsDFZa/JD+wOfw2r/N/uYy3J1/E1wlssWzkrMvmRn7wZNxNuvOm8npWS3+v8t0E8gg==
X-Received: by 2002:a05:6512:304b:b0:50e:ab4d:abc5 with SMTP id b11-20020a056512304b00b0050eab4dabc5mr204592lfb.116.1704365758834;
        Thu, 04 Jan 2024 02:55:58 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id q4-20020ac25284000000b0050e9e1c989esm883890lfm.257.2024.01.04.02.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 02:55:58 -0800 (PST)
Message-ID: <3256aff4-8929-442c-8e11-667c9a3656ec@gmail.com>
Date: Thu, 4 Jan 2024 12:55:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uapi: regulator: Fix typo
To: Naresh Solanki <naresh.solanki@9elements.com>, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240104101315.521301-1-naresh.solanki@9elements.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240104101315.521301-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/24 12:13, Naresh Solanki wrote:
> Fix minor typo.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>   include/uapi/regulator/regulator.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/regulator/regulator.h b/include/uapi/regulator/regulator.h
> index d2b5612198b6..71bf71a22e7f 100644
> --- a/include/uapi/regulator/regulator.h
> +++ b/include/uapi/regulator/regulator.h
> @@ -52,7 +52,7 @@
>   /*
>    * Following notifications should be emitted only if detected condition
>    * is such that the HW is likely to still be working but consumers should
> - * take a recovery action to prevent problems esacalating into errors.
> + * take a recovery action to prevent problems escalating into errors.

Thanks!

>    */
>   #define REGULATOR_EVENT_UNDER_VOLTAGE_WARN	0x2000
>   #define REGULATOR_EVENT_OVER_CURRENT_WARN	0x4000
> 
> base-commit: 67ba055dd7758c34f6e64c9d35132362c1e1f0b5

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


