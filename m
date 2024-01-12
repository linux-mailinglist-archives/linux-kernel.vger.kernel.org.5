Return-Path: <linux-kernel+bounces-24778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5D682C255
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371D21F21522
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FAE6E2AD;
	Fri, 12 Jan 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FRqqA6bl"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47D26E2B4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3373a30af67so5652602f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1705071579; x=1705676379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/BtQRkPRo0PDkqr7h2go7WXT8nDwFvbbHMJTq+1IaQ=;
        b=FRqqA6bl56wSbCuNV+dihl+jf78ouFMTNYdWFoz0CGOAf836RIbyBRHPvnmFptU60c
         Zs6zaIB1n/hRnK1vCUg2t+LwlJlRkCxOxeW2uzoimORx6FZqxz5C4rWxzL2oPI5iiZWR
         4vu4uPLlr1xdTG3v4Av70K/l5orvCx6ECGVD6UpVIp2R/sw7wD6/c2XzEyosDVXlEdIQ
         oFmoQicyxeNNtub1IVW9kp3TlfJGORnM1T/MA6DTGJVlICrU+EspckNTrfxmz+gnUkss
         aKmWzH9SYn2zgXlxOf0ifW4lNP6k/pQItk0FQuGtK6vs6XeBfJDG8dz5YiYVOnEULPBh
         9tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705071579; x=1705676379;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/BtQRkPRo0PDkqr7h2go7WXT8nDwFvbbHMJTq+1IaQ=;
        b=xFyvzrIQ/OTkvpS4LkXMTxzKQdu/wGZj/+m86aqpzRR4qBoTaOXZPRqRhMtXO5xy8W
         2Ve96BZlQ3XQG/udS1QgwXyzz5Fl/Qf5AM9yIbfbGBBcwsmp01Aa22hYZg8rDwC58/CN
         f62GFvzPqOO/GF4rmkP/YWfsAhlhXlHwMFMLXo85420XbDy671FwhNW+cScOsPOjiXTs
         M3Dq9Kiz74GGO544YliT1ZPR7shZTrHfuIsjgshUg9tfSfh2mAbtbh/wDI8w60iHVqTt
         OAEylKkctD4sUh0+TAailZr2fEIT3/nuGLXwoXZW9TNYOt4lzsQ8wITk54qRLdNxpJ/D
         rulg==
X-Gm-Message-State: AOJu0Yw3+v8hDw1SJ1ZQFDH1zjIuP8DFiMSehrkpTUYx9zOjMVwVo/Uz
	9Fij2P+WaHk3bWZQ205WfS5aIoRTfA/dsw==
X-Google-Smtp-Source: AGHT+IHlzOnEPzQA5ipb6HisnDyIT67m1rDMx0qCjw3pajHcuG78NaTaRWbEy1sMIitmndhhKsBi6g==
X-Received: by 2002:a5d:598c:0:b0:336:5c93:aef6 with SMTP id n12-20020a5d598c000000b003365c93aef6mr700610wri.34.1705071578640;
        Fri, 12 Jan 2024 06:59:38 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id co8-20020a0560000a0800b00336755f15b0sm4136419wrb.68.2024.01.12.06.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 06:59:38 -0800 (PST)
Message-ID: <a6a4136a-c3b6-4224-bf73-2948fb849095@tuxon.dev>
Date: Fri, 12 Jan 2024 16:59:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: renesas_sdhi: Fix change point of data handling
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org,
 yoshihiro.shimoda.uh@renesas.com, takeshi.saito.xv@renesas.com,
 masaharu.hayakawa.ry@renesas.com, linux-mmc@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240112114147.1977955-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUoDhZSmD5rxhZ7t_DydsZ13UX3eHD3i-OaxDs9P6awAg@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdUoDhZSmD5rxhZ7t_DydsZ13UX3eHD3i-OaxDs9P6awAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 12.01.2024 14:29, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, Jan 12, 2024 at 12:42 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> On latest kernel revisions it has been noticed (on a RZ/G3S system) that
>> when booting Linux and root file system is on eMMC, at some point in
>> the booting process, when the systemd applications are started, the
>> "mmc0: tuning execution failed: -5" message is displayed on console.
>> On kernel v6.7-rc5 this is reproducible in 90% of the boots. This was
>> missing on the same system with kernel v6.5.0-rc1. It was also noticed on
>> kernel revisions v6.6-rcX on a RZ/G2UL based system but not on the kernel
>> this fix is based on (v6.7-rc5).
>>
>> Investigating it on RZ/G3S lead to the conclusion that every time the issue
>> is reproduced all the probed TAPs are OK. According to datasheet, when this
>> happens the change point of data need to be considered for tuning.
>>
>> Previous code considered the change point of data happens when the content
>> of the SMPCMP register is zero. According to RZ/V2M hardware manual,
>> chapter "Change Point of the Input Data" (as this is the most clear
>> description that I've found about change point of the input data and all
>> RZ hardware manual are similar on this chapter), at the time of tuning,
>> data is captured by the previous and next TAPs and the result is stored in
>> the SMPCMP register (previous TAP in bits 22..16, next TAP in bits 7..0).
>> If there is a mismatch b/w the previous and the next TAPs, it indicates
>> that there is a change point of the input data.
>>
>> To comply with this, the code checks if this mismatch is present and
>> updates the priv->smpcmp mask.
>>
>> This change has been checked on the devices with the following DTSes by
>> doing 50 consecutive reboots and checking for the tuning failure message:
>> - r9a08g045s33-smarc.dts
>> - r8a7742-iwg21d-q7.dts
>> - r8a7743-iwg20d-q7.dts
>> - r8a7744-iwg20d-q7.dts
>> - r8a7745-iwg22d-sodimm.dts
>> - r8a77470-iwg23s-sbc.dts
>> - r8a774a1-hihope-rzg2m-ex.dts
>> - r8a774b1-hihope-rzg2n-ex.dts
>> - r8a774c0-ek874.dts
>> - r8a774e1-hihope-rzg2h-ex.dts
>> - r9a07g043u11-smarc-rzg2ul.dts
>> - r9a07g044c2-smarc-rzg2lc.dts
>> - r9a07g044l2-smarc-rzg2l.dts
>> - r9a07g054l2-smarc-rzv2l.dts
>>
>> On r8a774a1-hihope-rzg2m-ex, even though the hardware manual doesn't say
>> anything special about it in the "Change Point of the Input Data" chapter
>> or SMPCMP register description, it has been noticed that although all TAPs
>> probed in the tuning process are OK the SMPCMP is zero. For this updated
>> the renesas_sdhi_select_tuning() function to use priv->taps in case all
>> TAPs are OK.
>>
>> Fixes: 5fb6bf51f6d1 ("mmc: renesas_sdhi: improve TAP selection if all TAPs are good")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/mmc/host/renesas_sdhi_core.c
>> +++ b/drivers/mmc/host/renesas_sdhi_core.c
>> @@ -641,7 +645,14 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
>>          * identifying the change point of data.
>>          */
>>         if (bitmap_full(priv->taps, taps_size)) {
>> -               bitmap = priv->smpcmp;
>> +               /*
>> +                * On some setups it happens that all TAPS are OK but
>> +                * no change point of data. Any tap should be OK for this.
>> +                */
>> +               if (bitmap_empty(priv->smpcmp, taps_size))
>> +                       bitmap = priv->taps;
>> +               else
>> +                       bitmap = priv->smpcmp;
>>                 min_tap_row = 1;
> 
> I know nothing about tuning, but should min_tap_row still be 1?

As of my understanding of this code, yes, it should be harmless in keeping
it 1 as the above:
	if (tap_cnt >= min_tap_row)

will be true due to the fact that priv->taps is full.

> Or can you fall back to the else case if priv->smpcmp is empty?
> I.e. can this be simplified to:
> 
>     if (!bitmap_empty(priv->smpcmp, taps_size) &&
>         bitmap_full(priv->taps, taps_size)) {

This will not cover all the cases, if I understand your request.

The idea was to keep the code as it previously was and, as I mentioned in
the comment, it happens that priv->taps to be full but smpcmp to be empty
(and code tries to address this scenario, too).

As of my understanding of the tuning, if all the taps are OK ( ==
priv->taps is full) then a change point of the input data should be
reported though priv->smpcmp but that doesn't happens on
r8a774a1-hihope-rzg2m-ex as of my experiments, thus I tried to address this
case, too.

>             ...
>     } else {
>             ...
>     }
> 
>>         } else {
>>                 bitmap = priv->taps;
>> @@ -706,7 +718,10 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>                 if (mmc_send_tuning(mmc, opcode, &cmd_error) == 0)
>>                         set_bit(i, priv->taps);
>>
>> -               if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPCMP) == 0)
>> +               val = sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPCMP);
> 
> The SH_MOBILE_SDHI_SCC_SMPCMP register is read even if its value is
> not used below.
> 
>> +               cmpngu_data = FIELD_GET(SH_MOBILE_SDHI_SCC_SMPCMP_CMPNGU_DATA, val);
>> +               cmpngd_data = FIELD_GET(SH_MOBILE_SDHI_SCC_SMPCMP_CMPNGD_DATA, val);
>> +               if (!cmd_error && cmpngu_data != cmpngd_data)
>>                         set_bit(i, priv->smpcmp);
> 
> So better move the SH_MOBILE_SDHI_SCC_SMPCMP register access
> inside the if (), and change the below to else.

Ok, agree.

> 
>>
>>                 if (cmd_error)
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

