Return-Path: <linux-kernel+bounces-22930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A12E82A59A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66764B25C59
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DBAA44;
	Thu, 11 Jan 2024 01:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9O+ne4H"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64418642;
	Thu, 11 Jan 2024 01:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3aa0321b5so41441495ad.2;
        Wed, 10 Jan 2024 17:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704937109; x=1705541909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE1lTwtemaJJKuDvq3IDwsBehzLTwHAByDMQDxpo694=;
        b=R9O+ne4Huj6ZO9z96eUnsQTWPcdy8tZwrGy7hZAI9wByEeOSjnIIfJFgXIYjcDQ0Pr
         NUCTh4dwm9HNXT/medGOH+QOgjC0qge0OKy3eJlVQA3lQS2+Mtgbu1Uscd6EU6uy5KHh
         1pvZ5SNqUM811zwiRGMaN3roTEHdcEVzJzyNWAWSL4+NuiGM8ox0vLhcTpVcYKpsUjj1
         uSfFNkWnidKeYqpF6lSrO3aMBJB8zU/BV8z2SWPhoRvzv5GHQV0yY0gklfiTfTxN70mq
         jTgIiIfV5aEugCoBRanavuzCQ8HXOK0yP3LWQ2rxUSxggiHpyrYJLrwltfIjXclyMWOw
         7wnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704937109; x=1705541909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FE1lTwtemaJJKuDvq3IDwsBehzLTwHAByDMQDxpo694=;
        b=juv0TxNGG98+8JI9xmDklVL5gS+5zwAGkDzD36AfEicdTLrFqc2IFoOnWldJxiKgR6
         6ba+V3eSs0hGg2xUrniuCJl0wpmb/ZIgpApCF34zJVajp0/hh7o8fkAPifzsHBqZ8b18
         56U7mXds7Zn9C1tKonsaxTzjyrj3j1nbNrO25vEvQvYT5x5QTbqzmnyBmK7Mm9p5zkHD
         00aIGYdhb53OwuDSXWUVNUqjEqYyrNdkZ/B8l+E6D0LLAth8VAuKxQv70RHfY4bKhs5+
         ukgrmBwuKm44cLVYdjZrzzTri0SKGKCx/83V1JnKc7Itj1VgXMHEB8j1fA/JZhnKHN47
         n+BA==
X-Gm-Message-State: AOJu0YwlmdrxwYwm/TYwzKaXYkbvJ60f2rp+I8baWqgyWl0rQJJ0tVfr
	7GNKm0T01jGRbqF4+XE0wIU=
X-Google-Smtp-Source: AGHT+IHKARNqCqYCTu0+mYQrX4M5yrGtv01ApdtOSYrg296QI8bAcWKPraS9YraPTO7HTbbek7MGtQ==
X-Received: by 2002:a17:902:a709:b0:1d4:e011:789e with SMTP id w9-20020a170902a70900b001d4e011789emr475676plq.78.1704937108515;
        Wed, 10 Jan 2024 17:38:28 -0800 (PST)
Received: from [10.193.226.49] ([106.39.42.235])
        by smtp.gmail.com with ESMTPSA id ji13-20020a170903324d00b001d3d8c04331sm4290389plb.64.2024.01.10.17.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 17:38:27 -0800 (PST)
Message-ID: <5ac868ca-239a-4758-9cd2-14a1ad210f26@gmail.com>
Date: Thu, 11 Jan 2024 09:38:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] [media] xc4000: Fix atomicity violation in
 xc4000_get_frequency
To: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, mcgrof@kernel.org,
 gregkh@linuxfoundation.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@outlook.com, stable@vger.kernel.org,
 BassCheck <bass@buaa.edu.cn>
References: <20231222055030.5237-1-2045gemini@gmail.com>
From: Gui-Dong Han <2045gemini@gmail.com>
In-Reply-To: <20231222055030.5237-1-2045gemini@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear All:

I hope this email finds you well. I hope you haven't missed my previous 
email, as I understand that everyone has a busy schedule. I just wanted 
to follow up on my previous message sent.
I understand that you may be occupied with other tasks or priorities. 
However, I would greatly appreciate it if you could spare a few moments 
to check the patch in my previous email. Your prompt response would be 
highly valuable to me.
Thank you for your attention to this matter, and I look forward to 
hearing from you soon.

Thanks,
Han

On 22/12/2023 下午1:50, Gui-Dong Han wrote:
> In xc4000_get_frequency():
> 	*freq = priv->freq_hz + priv->freq_offset;
> The code accesses priv->freq_hz and priv->freq_offset without holding any
> lock.
>
> In xc4000_set_params():
> 	// Code that updates priv->freq_hz and priv->freq_offset
> 	...
>
> xc4000_get_frequency() and xc4000_set_params() may execute concurrently,
> risking inconsistent reads of priv->freq_hz and priv->freq_offset. Since
> these related data may update during reading, it can result in incorrect
> frequency calculation, leading to atomicity violations.
>
> This possible bug is found by an experimental static analysis tool
> developed by our team, BassCheck[1]. This tool analyzes the locking APIs
> to extract function pairs that can be concurrently executed, and then
> analyzes the instructions in the paired functions to identify possible
> concurrency bugs including data races and atomicity violations. The above
> possible bug is reported when our tool analyzes the source code of
> Linux 6.2.
>
> To address this issue, it is proposed to add a mutex lock pair in
> xc4000_get_frequency() to ensure atomicity. With this patch applied, our
> tool no longer reports the possible bug, with the kernel configuration
> allyesconfig for x86_64. Due to the lack of associated hardware, we cannot
> test the patch in runtime testing, and just verify it according to the
> code logic.
>
> [1] https://sites.google.com/view/basscheck/
>
> Fixes: 4c07e32884ab6 ("[media] xc4000: Fix get_frequency()")
> Cc: stable@vger.kernel.org
> Reported-by: BassCheck <bass@buaa.edu.cn>
> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
> ---
> v2:
> * In this patch v2, we've added some information of the static analysis
> tool used, as per the researcher guidelines. Also, we've added a cc in the
> signed-off-by area, according to the stable-kernel-rules.
>    Thank Greg KH for helpful advice.
> ---
>   drivers/media/tuners/xc4000.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/tuners/xc4000.c b/drivers/media/tuners/xc4000.c
> index 57ded9ff3f04..29bc63021c5a 100644
> --- a/drivers/media/tuners/xc4000.c
> +++ b/drivers/media/tuners/xc4000.c
> @@ -1515,10 +1515,10 @@ static int xc4000_get_frequency(struct dvb_frontend *fe, u32 *freq)
>   {
>   	struct xc4000_priv *priv = fe->tuner_priv;
>   
> +	mutex_lock(&priv->lock);
>   	*freq = priv->freq_hz + priv->freq_offset;
>   
>   	if (debug) {
> -		mutex_lock(&priv->lock);
>   		if ((priv->cur_fw.type
>   		     & (BASE | FM | DTV6 | DTV7 | DTV78 | DTV8)) == BASE) {
>   			u16	snr = 0;
> @@ -1529,8 +1529,8 @@ static int xc4000_get_frequency(struct dvb_frontend *fe, u32 *freq)
>   				return 0;
>   			}
>   		}
> -		mutex_unlock(&priv->lock);
>   	}
> +	mutex_unlock(&priv->lock);
>   
>   	dprintk(1, "%s()\n", __func__);
>   

