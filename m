Return-Path: <linux-kernel+bounces-60679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F91850858
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDBD1F227A3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD4C5917B;
	Sun, 11 Feb 2024 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSJr//90"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D992E3E1;
	Sun, 11 Feb 2024 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707644408; cv=none; b=UTTMoc7n4N7ro4lhJH53iyhtgGFnu71recwO7AwP26xRXd372ciAbIQ50vTEIBdpvBTatFBiwIBZCzBO1GV1LWpVCzRmkhe59hTHlJIe7wNNYaLBclgqD5xgAPjpYuywgvKsD1jg+q4K62BbFks3wgmUQrGsEHHb1ZCKFKTkYR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707644408; c=relaxed/simple;
	bh=m+MynlBCqiTW/nW56xpevjEGzyTh2lJGO9XlKJBXUj8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VO0hAeIrTgyQD6mCeXvhBMQx7r8N/3PRMablfi2JytRQxqp5YrYHdDdp4apOpwruJ/9EmtpuvnUIGme0IvUbH8Uac9Y9LyIgfgRNs0lxvXFUTE49XHAsZnzv4UUo1P66wSZhQG03yYRR4SSyPmTxHqt67VSUrBNxN7ECBNu0qu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSJr//90; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0dc3fdd1bso21666131fa.0;
        Sun, 11 Feb 2024 01:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707644404; x=1708249204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxAeYgheoBLj+Edm6NVrMBtYDbJT2BZs/m5VJ4rUUQw=;
        b=CSJr//90IQqI+pyyOsk+4UvVYgEnN3sWKPNEIIVsGvxZqRF7tCA9i6RDYw0muwg28F
         b+GVm7259D2Qlu4UnX7PUxiZ17BEQBQ8kkF6GdtVgGytkgjTi8XolXNkCTznL8pOqahJ
         vh41i0zP5Bd/pqmc0pLSFKt5p51LcIb1UhBAC9IGd+9z0sGb7sr9/7Fs8EehaSvyHwQJ
         sWeJ9RggKcHIb4kd9DdbGrzKr1WBqJ7yEhJxAoMxj4rFDg1e0xHvXBeHCp6py4BfV0gX
         FGa8XtGRLGYn6/Km2o2cTIPx7DZXLCyl6TGZHcvb4FwHbqAH38/R45/GL4535lxR4utz
         lMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707644404; x=1708249204;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxAeYgheoBLj+Edm6NVrMBtYDbJT2BZs/m5VJ4rUUQw=;
        b=RDAVhX40NLjxD/iNJZvnvaSCAPUkYZ+EeieoW8YH1NyhVsf7ikISI3INTzHgGfDqXn
         QQxKWBcKHORVq5R+VQqfvXzXqJb4xo/MrDpaITC0y1hYce28E3lYo2AYOROb/tW5vSJb
         VVsMZJppQiklfsLvb5INp9ht3bTFvpUY8Oojs+pO86uLjvBqlHatluozj4uK/3M9fUaG
         TcGM5rixnbhfraj4tOuCF9e/E9jiwcLocBVtrRX3UWSX3xtmclIV+bC8mHGc/dJti4Bt
         SM+FFOFqF/MQYXh9KYZHZnc1aIugCm6uf7GNTIUfmD9yA3wMHxIyN+mRXkZNP2CEHXh7
         6isA==
X-Forwarded-Encrypted: i=1; AJvYcCUmylMKYlwDuywS1hHIv/DgkLRRCTwTF+4rjjoRC00d8TAE+yEoYdM/Jo2okQPGBUMH/29JF/5Vh9e4VsSOzTpUQy4ZgVZ3FxMV0QBQAJsFriOKxWcznjPb12kQEpe1rA34lEkvcvDaFS/fJ6Iht9RgBBLx+TrAEYwVEsvgjMLA/TbdlVfmJ4w=
X-Gm-Message-State: AOJu0YyqtxTTTH4L2KYmZgFdLsSt4zV9XiCqqyx+dnEtWEjQXFDMRpBS
	rJuTSU17IP3AuUeYvygyKFn7Jvp0VyFVu2rZRqZmDtH76S/luwdl
X-Google-Smtp-Source: AGHT+IHgHMXcm6Lu4lcuYGzuQWfKtCRvTjkEiAIsX+ofRSGKGLh+iM4VFDBnvXF5ZTHsCWCz56qhiQ==
X-Received: by 2002:a05:651c:507:b0:2d0:d336:d144 with SMTP id o7-20020a05651c050700b002d0d336d144mr2983808ljp.14.1707644403904;
        Sun, 11 Feb 2024 01:40:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNbVc6nIIj7NjqkDPBg5terxOSgaQfNkajtoQQrtFWhNxIYj+vrBES6GSJSHLukRUcMFtLGqC32+pNKwLB890KrA3SeSzHT2rAkj81S9b/JD9DvoRP3rE9T6xzmjwo0C+U1rD725MIp/16mXXpN80RCcCPWxCkUb0WpPYUd7CqRt3rBXl5PagSo2dis+uD3Y6NqBUV+vIsHhvsdU3qCRavSa4bGS4LStIGj94HY48GzKj/7h2iU5x3WNCaAPGqKjJ4rJHP/dmLWlApNa83+bgX5JU/3KWHitUaWrD0ndFbUUdEHK8OFuMONYH58+mRvoKiuz+4cQYtK6nOt3SID4122Y9C53QjhRkKg7F8sEc934z8knvVOkjNu+y2Shtq3EqIDxIx
Received: from [192.168.1.105] ([31.173.83.113])
        by smtp.gmail.com with ESMTPSA id n15-20020a05651c000f00b002d06c31cf6esm887333lja.124.2024.02.11.01.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 01:40:03 -0800 (PST)
Subject: Re: [PATCH net-next v2 4/5] net: ravb: Do not apply RX checksum
 settings to hardware if the interface is down
To: Biju Das <biju.das.au@gmail.com>, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, claudiu.beznea@tuxon.dev,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <CADT+UeAfCTd8c+dHn3mgT=g6Boip=oRPdkODMN_j2KaROcT0AQ@mail.gmail.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <5600b643-0d07-5583-4858-a521676476a5@gmail.com>
Date: Sun, 11 Feb 2024 12:40:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADT+UeAfCTd8c+dHn3mgT=g6Boip=oRPdkODMN_j2KaROcT0AQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2/11/24 11:56 AM, Biju Das wrote:

>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> Do not apply the RX checksum settings to hardware if the interface is
>>>> down.
>>>> In case runtime PM is enabled, and while the interface is down, the IP
>>>> will be in reset mode (as for some platforms disabling the clocks will
>>>> switch the IP to reset mode, which will lead to losing register
>>>> contents) and applying settings in reset mode is not an option.
>>>> Instead, cache the RX checksum settings and apply them in ravb_open()
>>>> through ravb_emac_init().
>>>> This has been solved by introducing pm_runtime_active() check. The
>>>> device runtime PM usage counter has been incremented to avoid
>>>> disabling the device clocks while the check is in progress (if any).
>>>>
>>>> Commit prepares for the addition of runtime PM.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> This will do the same job, without code duplication right?
>>
>>> static int ravb_set_features(struct net_device *ndev,
>>>     netdev_features_t features)
>>> {
>>> struct ravb_private *priv = netdev_priv(ndev);
>>> struct device *dev = &priv->pdev->dev;
>>> const struct ravb_hw_info *info = priv->info;
>>>
>>> pm_runtime_get_noresume(dev);
>>> if (!pm_runtime_active(dev)) {
>>> pm_runtime_put_noidle(dev);
>>> ndev->features = features;
>>> return 0;
>>> }
>>>
>>> return info->set_feature(ndev, features);
> 
>> We now leak the device reference by not calling pm_runtime_put_noidle()
>> after this statement...
> 
> Oops. So this leak  can be fixed like [1]
> 
>>  The approach seems sane though -- Claudiu, please consider following it.
> 
> [1]
> static int ravb_set_features(struct net_device *ndev,
>     netdev_features_t features)
> {
> struct ravb_private *priv = netdev_priv(ndev);
> const struct ravb_hw_info *info = priv->info;
> struct device *dev = &priv->pdev->dev;
> bool pm_active;
> 
> pm_runtime_get_noresume(dev);
> pm_active = pm_runtime_active(dev);
> pm_runtime_put_noidle(dev);

   There is no point dropping the RPM reference before we access
the regs...

> if (pm_active )
>      return info->set_feature(ndev, features);

   As I said, we should call pm_runtime_put_noidle() here...
 
> ndev->features = features;
> return 0;
> }

MBR, Sergey

