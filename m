Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A12F7EE703
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345464AbjKPSqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKPSqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:46:49 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD874D4B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:46:45 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4219f89ee21so6355011cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1700160405; x=1700765205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=If/44f1KPyVE2d2iqlt11gTcl1EXO2kaaJZBfwh5YxI=;
        b=YKnoJTwWuoErDwGyNtj03dwhKkhdBux3KS6L8wRcNoDxWyMYs7u/4uOC2SkaFliGVB
         9azwrgMmXVc6DnUfOVYn1nUuM2HiB5B0f7ioZloLqc5f9hLPrhZ8EbULvoou5bE9UCvQ
         c3M3d5gBZL72swIsGsEUxfsyQhmIKQY6yJKjCdkN8a/Ziss2Nkfe3Hg7e+zuUGjwMZEM
         yZhRGFE1Cxex8vvYi0+l23UcyC4R/NtObdKkKtjH3NmC9Loj7ILIQj7OjagCvkqSZcRc
         OHdS10Of/jcECJGmzQpazM4bHDPERKgCfsYj5+hEHoziVgJcscSel598xwSWF+qkqXVa
         7Bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700160405; x=1700765205;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=If/44f1KPyVE2d2iqlt11gTcl1EXO2kaaJZBfwh5YxI=;
        b=IZzZ5abchMfm0r/MbZFf8ZLnWGEwLi5ji597H1DsW+MTA1kWv0856atoVKyHKpP+Qx
         Yg+yQeoELkdCIIeB2JbuAIC5ptyT5dPSQrczJiumwZ9lsKD6syzoyPbQcL2k9q4D9Bnj
         IpHUj0+5j+wfsxmqf3ZrNW+J6W5wxZ6GrDPxD9B2d43W1qePLRiKaOs/+uJ1X0S0ylFR
         t3EpQZ1R2af8WXRhqGs1ieJBCV0suGqU550rS2IS1hPrsexGmyLr7nj4xjDPBauu380V
         ZRI8AEPT/YPyh9JhfBBfbf9NY6OcD5kq4aS940Swd9VP9GIl+QEcGSqRuP9fnUJxmFRQ
         mEXQ==
X-Gm-Message-State: AOJu0YwduhE87WwoyTo3t38Jz+dt93Q6WRFHTSmzEelREp+fyOxVUy+W
        lZWYjjBM0uR0GW9M0L8I8+R64yE0wiQZeOfGVm8=
X-Google-Smtp-Source: AGHT+IFQlwjNqtRd3lxS5p0T5Vg8UQ+JyMTZejmIFz8gVnKZabprGWmddPa0pf0JYS0omO1Kk+ALrQ==
X-Received: by 2002:ac8:7f14:0:b0:419:6954:3ba2 with SMTP id f20-20020ac87f14000000b0041969543ba2mr11124161qtk.43.1700160404914;
        Thu, 16 Nov 2023 10:46:44 -0800 (PST)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id w19-20020ac843d3000000b0041991642c62sm4493571qtn.73.2023.11.16.10.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 10:46:44 -0800 (PST)
Subject: Re: [PATCH v2 4/6] drm/msm/dsi: add a comment to explain pkt_per_line
 encoding
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231114225857.19702-1-jonathan@marek.ca>
 <20231114225857.19702-5-jonathan@marek.ca>
 <CAA8EJppg=pYh73ncHBCO6Ddv9gG7+WNnpwLYGEv6xEu_3MRNWw@mail.gmail.com>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <ebec534a-4c72-7d33-4c18-4e0b43338568@marek.ca>
Date:   Thu, 16 Nov 2023 13:45:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAA8EJppg=pYh73ncHBCO6Ddv9gG7+WNnpwLYGEv6xEu_3MRNWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/23 2:38 AM, Dmitry Baryshkov wrote:
> On Wed, 15 Nov 2023 at 01:00, Jonathan Marek <jonathan@marek.ca> wrote:
>>
>> Make it clear why the pkt_per_line value is being "divided by 2".
>>
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>   drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
>> index 66f198e21a7e..842765063b1b 100644
>> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
>> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
>> @@ -877,6 +877,8 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
>>          /* DSI_VIDEO_COMPRESSION_MODE & DSI_COMMAND_COMPRESSION_MODE
>>           * registers have similar offsets, so for below common code use
>>           * DSI_VIDEO_COMPRESSION_MODE_XXXX for setting bits
>> +        *
>> +        * pkt_per_line is log2 encoded, >>1 works for supported values (1,2,4)
>>           */
>>          reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE(pkt_per_line >> 1);
> 
> Should we switch to ffs() or fls() instead?
> 

Just a ffs() on its own can be confusing as well (without the 
information that only powers of two are possible), I think like this is 
better.

>>          reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM(eol_byte_num);
>> --
>> 2.26.1
>>
> 
> 
