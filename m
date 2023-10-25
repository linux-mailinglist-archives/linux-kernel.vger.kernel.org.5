Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48E07D6C49
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344023AbjJYMtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjJYMs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:48:59 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4971913D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:48:56 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so86713441fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698238134; x=1698842934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mhfK3Xbp7dGorRag1GQdAYkUAEC0Al9vXL9om2bY/oI=;
        b=MZV3uxJLrPBAE6Y5odc5Wz6n33WPTtx8ciBWL4crzscX4d+1/GEAc/q/yIYbyUND1W
         Xo2vwvH6KWhChQfOuC13kB8DaktvkBQr4jmnx/CPEkw0vcodH3lApyOOR5QZQxpkSm/V
         Y0WZnMiZnP0JkTwOxMMZnUmagKUZhy+B3nf0ML5gao8RkTvONhdGva2J8C9Wd1qtBOBG
         loOAxcsLUKoThKwn/AvhFC2U8TfUizLa713O4mW7i7JfPzaqfh5WW2tztW3bVRpZ6i64
         aMGaDgTMv/EnynWYUBq6mcarSKVJrRmmggQOqfmA6NHeKBj6xCtE8e10x2EabiicgUWM
         t1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238134; x=1698842934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhfK3Xbp7dGorRag1GQdAYkUAEC0Al9vXL9om2bY/oI=;
        b=v2cY8tnAgxvuwyLcBPjy7MzS9D5e17XeEt8nnEZ4XrqVb1qEaWgRqBhbZPYedADxwp
         +uGBSNRTj6da6KuHEKKFMs2B3LKrqDF84ae8TQ/byIIj0OP2es6BXRCpB8Dp1xgxiB6Z
         Gy9gUXXO0MXUhToVizvNoTjnu1xpb/qaf7ULiMuHsSvYr6fQq6rNEYXF9X8R/jAVHufq
         YrftU2ng95OzGcR6TXWQkSNMqtu5PYxSfuOvF6Mwk7QAwr6HyFimjyRrJqsxtuqPQiqH
         UwwCbREZ6ejpX0JRcSSYkodD5cAhbBzIR3s74lGcK5ar5hZDyvmvYFY+Rv7kn7klJ+43
         it4g==
X-Gm-Message-State: AOJu0Yxg8L5Oza2Un1ni/L08/2/PSzE6qaE+x1gNz+9eWIdycmgUMazF
        Eq16Px2nAzZQV7osNnSl6sdTyw==
X-Google-Smtp-Source: AGHT+IGtGtGHKJuO0bAirx2hne0N0Y/3+/cSERvZVDPv9gjGAUiKzMFk7r5OAYKMrzB4SUepkCEJgA==
X-Received: by 2002:a2e:86c7:0:b0:2c5:1602:53f6 with SMTP id n7-20020a2e86c7000000b002c5160253f6mr10457117ljj.34.1698238134501;
        Wed, 25 Oct 2023 05:48:54 -0700 (PDT)
Received: from [192.168.53.189] ([188.162.65.61])
        by smtp.gmail.com with ESMTPSA id f7-20020a2e9187000000b002c0167edd86sm2443551ljg.122.2023.10.25.05.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 05:48:53 -0700 (PDT)
Message-ID: <c5c233e9-a3e7-4a65-b1d5-cf11e68d0f8e@linaro.org>
Date:   Wed, 25 Oct 2023 15:48:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: pmic_glink: fix connector type to be
 DisplayPort
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Simon Ser <contact@emersion.fr>, linux-kernel@vger.kernel.org
References: <20231010225229.77027-1-dmitry.baryshkov@linaro.org>
 <ZTkIpMWpxKzSE7gQ@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <ZTkIpMWpxKzSE7gQ@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 15:23, Johan Hovold wrote:
> On Wed, Oct 11, 2023 at 01:52:29AM +0300, Dmitry Baryshkov wrote:
>> As it was pointed out by Simon Ser, the DRM_MODE_CONNECTOR_USB connector
>> is reserved for the GUD devices. Other drivers (i915, amdgpu) use
>> DRM_MODE_CONNECTOR_DisplayPort even if the DP stream is handled by the
>> USB-C altmode. While we are still working on implementing the proper way
>> to let userspace know that the DP is wrapped into USB-C, change
>> connector type to be DRM_MODE_CONNECTOR_DisplayPort.
>>
>> Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
>> Cc: Simon Ser <contact@emersion.fr>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/soc/qcom/pmic_glink_altmode.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
>> index 9569d999391d..6f8b2f7ae3cc 100644
>> --- a/drivers/soc/qcom/pmic_glink_altmode.c
>> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
>> @@ -467,7 +467,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>>   		alt_port->bridge.funcs = &pmic_glink_altmode_bridge_funcs;
>>   		alt_port->bridge.of_node = to_of_node(fwnode);
>>   		alt_port->bridge.ops = DRM_BRIDGE_OP_HPD;
>> -		alt_port->bridge.type = DRM_MODE_CONNECTOR_USB;
>> +		alt_port->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
>>   
>>   		ret = devm_drm_bridge_add(dev, &alt_port->bridge);
>>   		if (ret) {
> 
> I was just going to post a patch fixing this after finally investigating
> why the DisplayPort outputs on the X13s were annoyingly identified as
> "Unknown20-1" and "Unknown20-2" instead of the expected "DP-1" and
> "DP-2".

Well, that depends on the userspace being updated to know about USB 
connectors or not. But you are right, we should probably mention that in 
the commit message.

> 
> A lore search just before posting led me to this fix from two weeks ago.
> 
> I think the commit message should have mentioned something about the how
> this change affects user space. My patch also had a CC stable, but I
> guess we can ping the stable team once it hits mainline:
> 
> commit e5f55bf5ad4effdd59d4d06c839a0ac553a73c7d (HEAD -> work)
> Author: Johan Hovold <johan+linaro@kernel.org>
> Date:   Wed Oct 25 11:54:09 2023 +0200
> 
>      soc: qcom: pmic_glink_altmode: fix DP alt mode connector type
>      
>      The PMIC glink altmode bridge connector type should be "DisplayPort"
>      rather than "USB", which is intended for custom USB display protocols
>      (e.g. see 40e1a70b4aed ("drm: Add GUD USB Display driver")).
>      
>      This specifically makes the DisplayPort outputs on the Lenovo ThinkPad
>      X13s show up as "DP-1" and "DP-2" rather than "Unknown20-1" and
>      "Unknown20-2" with xrandr as expected (by users and tools):
>      
>        Screen 0: minimum 320 x 200, current 1920 x 1200, maximum 5120 x 4096
>        eDP-1 connected primary 1920x1200+0+0 (normal left inverted right x axis y axis) 286mm x 178mm
>           1920x1200     60.03*+
>           1600x1200     60.00
>        DP-1 disconnected (normal left inverted right x axis y axis)
>        DP-2 connected (normal left inverted right x axis y axis)
>           1920x1200     59.95 +
>        ...
>      
>      Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
>      Cc: stable@vger.kernel.org      # 6.3
>      Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Johan

-- 
With best wishes
Dmitry

