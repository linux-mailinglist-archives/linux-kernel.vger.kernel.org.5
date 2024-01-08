Return-Path: <linux-kernel+bounces-19128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AAF826867
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485C11F210E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9F08BFC;
	Mon,  8 Jan 2024 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="phI3eXm5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF4B660
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso1346551e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 23:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704697559; x=1705302359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+W5MR0GZTvvVT7Ez94bP6YWkWN8S36H3wYikt4HSl4Q=;
        b=phI3eXm59qPP0jQ8DwkFvWbXhXYGoID3/wYE1adMQ60hFPVf6xzqQ+lSTk9whbAidC
         Kjmx36XSDGf+EE+n2rEIXlOMb/CAOidVvXyLYhhA4w1jMg8853SSEOSk+P+mtgVmk5lw
         kKldn4woAzVrFPtjQD85wE/VDnrQhV8slyl/ttwnrkqDwh+zzQW+Yti9pUcVsowqnIVr
         Dmdu0tpwtA+XMQL9syRoUcK7f2tjTB0tfzQmFTIi2Ice1U00oX4IGZURPOZQJ4qYiajn
         puZzodbWzUYfukddEviLWRv7JXXoP/d52KCLGZsZu7PtF8Mea7GZkRruSrYegAUD2FPd
         lrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704697559; x=1705302359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+W5MR0GZTvvVT7Ez94bP6YWkWN8S36H3wYikt4HSl4Q=;
        b=FbagQ+VmwJokaEhnjfVjJq00YHiFI8kL5n6kxa2RO6Q5pAYVoU9PJrfB2Ni4xvgFcv
         UU4z2x0YNiRyFbeNPEJZYjGO44YjMSDHazHpQawuM4O6jk8JmlMVX4wDtlq0Q+Virfr+
         KIreyLqC6QRO8fSsScJPKS/n/4Oc2DR0wgqMzrYGGVA7APPNiDJe9zNLc8p+DBBMmWID
         VBiW0lR7DzeEMDumlQ/AbDhtm7jfjHrmdEMhvXwSTrV+mhYLIiQb2SsbD1ndPpgH7rHU
         mRDCsbwOKSS6kgoqSPZxyvYZoTgSzD9RgwIYkf0nv4vnFtrUC6aDL1V+lyNfqI+pM4pK
         aSiQ==
X-Gm-Message-State: AOJu0YwZcNwLebzPjPDVcfjbYGKeBKt4JpiBuDJbx4pT92XeKMpbb3cz
	x2Uysez3M8/SoaV9tOMxmjwlwQ5hZ5NslA==
X-Google-Smtp-Source: AGHT+IF2PtwQKrEqWSIs9T+bjTD2KsvisYFdWZg8Aq53R2YUIdp6yibADBbGYZSvkWNnhjOzoyIUyg==
X-Received: by 2002:a05:6512:b23:b0:50e:a942:e6f3 with SMTP id w35-20020a0565120b2300b0050ea942e6f3mr1367517lfu.10.1704697559144;
        Sun, 07 Jan 2024 23:05:59 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id ez10-20020a1709070bca00b00a28a7f56dc4sm1063479ejc.188.2024.01.07.23.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 23:05:58 -0800 (PST)
Message-ID: <bd76083f-c1de-4581-820c-50d9084b3942@tuxon.dev>
Date: Mon, 8 Jan 2024 09:05:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/19] net: ravb: Make reset controller
 support mandatory
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
 wsa+renesas@sang-engineering.com, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 geert+renesas@glider.be, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
 <20240105082339.1468817-4-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWTE=AUEd5iqd4Qm04sgFcGtHkbYEQJH9A=qPWph=S4+g@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdWTE=AUEd5iqd4Qm04sgFcGtHkbYEQJH9A=qPWph=S4+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 05.01.2024 11:38, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, Jan 5, 2024 at 9:24 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> On the RZ/G3S SoC the reset controller is mandatory for the IP to work.
>> The device tree binding documentation for the ravb driver specifies that
>> the resets are mandatory. Based on this, make the resets mandatory also in
>> driver for all ravb devices.
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -2645,7 +2645,7 @@ static int ravb_probe(struct platform_device *pdev)
>>                 return -EINVAL;
>>         }
>>
>> -       rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
>> +       rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
>>         if (IS_ERR(rstc))
>>                 return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
>>                                      "failed to get cpg reset\n");
> 
> Upon second look, you also have to make config RAVB select
> RESET_CONTROLLER.
> Currently, you can build an R-Car Gen[234] kernel with RESET_CONTROLLER
> disabled, causing devm_reset_control_get_exclusive() to fail
> unconditionally.

ok, I'll update it. Thanks!

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

