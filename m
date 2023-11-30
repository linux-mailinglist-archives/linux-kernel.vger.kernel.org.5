Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD057FEEF7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbjK3MY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345209AbjK3MY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:24:27 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5D4D46
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:24:33 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54ba86ae133so871782a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701347071; x=1701951871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DohD+zPdgRQov8rgbOlj4kgq1RsGhFx7NPzpyVYUFqs=;
        b=tjtAgp0ZOzlOPtcv2qER2WWdXUzKTlMo288ZJRxG+L12yNAM9X/Afe8w2c/Y8I9tTA
         /SygA4KVGfGX48XV7tN0qaeLbbQuyfkERfsiuDIiZKE5syPBQATMuu2+2Zz6bgsDJ9LG
         F8Rk7obShzGllW4vBwxmLWIyJayjbMhqGwG7S7FyDoDQluQZOxBAZbQLu0tIyxigf1OT
         Iua1ADBB+A9tHDqn4hNXtVewvhQ8G0QNbq49+1Zfui76u9AmJbvCRRpzwuz/XtzECwTI
         A2fJJzb6S4W8P8eFW8HRrTzNCo0C599SMHJDGFvQLUFrPpqX7JSeymsADnaETTSPhtnt
         666A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701347071; x=1701951871;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DohD+zPdgRQov8rgbOlj4kgq1RsGhFx7NPzpyVYUFqs=;
        b=j55DYL3/YA2dO3O4V0goT+mmBwN+XkaBJ0iT5PUib0/3NcSRm+29JTwTZ+/s3RPBu2
         Ha2WZ7ck2gGfOmDHEVyiNN+Rcf7CkTmhlWXFuZ3z5Qc8ve7jtipZSoeHF31wuGdOeWFM
         GH+E2MPxwfeyjfhPUJI4YUDrDrXM5Zs1lZ3qCovAtvXCkbK0Cg0G3ozX/StOBaWni8o7
         svuue0WMnjHhBIAnepx8VlCwv0+KFcmz+VUU6Eocj1O+TO+M/rqkT7vXTnFdqqyOB+k5
         xmUYSQpjLBDBAgsNJgMgL6pLfn/QeHkP4O4lNVVJjQ/LRYopP5NNQ0/TgK9jLharF/s/
         FfoA==
X-Gm-Message-State: AOJu0YyD72M6SIRkE41UKGE1DZuLn9slplwj/NmCm+Lm984FAY+zmCo8
        gJjPNFTd+Jr1BUlJ+jQc598NHQ==
X-Google-Smtp-Source: AGHT+IFioR13YQ+qfneJ+7APmy6pnKR276TO+VIZUZm+mbkgfJynRObFBd7p0BnwIiZlFKKqRuzaEA==
X-Received: by 2002:a17:906:b20a:b0:9e6:4410:2993 with SMTP id p10-20020a170906b20a00b009e644102993mr11763050ejz.18.1701347071507;
        Thu, 30 Nov 2023 04:24:31 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id e20-20020a1709067e1400b00a17ca6996a2sm620669ejr.178.2023.11.30.04.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 04:24:31 -0800 (PST)
Message-ID: <0cf0b5f0-165d-401a-a2ec-2fada4fdcebf@linaro.org>
Date:   Thu, 30 Nov 2023 12:24:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: qcom: audioreach: Add 4 channel support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20231020084919.18628-1-krzysztof.kozlowski@linaro.org>
 <f882b666-8a68-4341-a143-cb226ab7d22b@linaro.org>
 <81b23ae7-bb01-4c23-80df-df171fbc2d08@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <81b23ae7-bb01-4c23-80df-df171fbc2d08@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/2023 12:17, Krzysztof Kozlowski wrote:
> On 23/10/2023 10:42, Srinivas Kandagatla wrote:
>> Thanks for the patch,
>>
>> On 20/10/2023 09:49, Krzysztof Kozlowski wrote:
>>> Add support four channel streams.  Map channel 3 and 4 to left/right
>>> surround ("quad(side)" from ffmpeg standard channel list) to match what
>>> is in qdsp6/q6dsp-common.c driver.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>
>>> ---
>>>
>>> quad(side):
>>> https://trac.ffmpeg.org/wiki/AudioChannelManipulation#Listchannelnamesandstandardchannellayouts
>>> ---
>>>    sound/soc/qcom/qdsp6/audioreach.c | 25 ++++++++++++++++++++++---
>>>    1 file changed, 22 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
>>> index 5974c7929dd3..4dd2a2e261c9 100644
>>> --- a/sound/soc/qcom/qdsp6/audioreach.c
>>> +++ b/sound/soc/qcom/qdsp6/audioreach.c
>>> @@ -833,6 +833,11 @@ static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
>>>    	} else if (num_channels == 2) {
>>>    		media_format->channel_mapping[0] = PCM_CHANNEL_L;
>>>    		media_format->channel_mapping[1] = PCM_CHANNEL_R;
>>> +	} else if (num_channels == 4) {
>>> +		media_format->channel_mapping[0] = PCM_CHANNEL_FL;
>>> +		media_format->channel_mapping[1] = PCM_CHANNEL_FR;
>>> +		media_format->channel_mapping[2] = PCM_CHANNEL_LS;
>>> +		media_format->channel_mapping[3] = PCM_CHANNEL_RS;
>>
>>
>> These are fine, but duplicated from q6dsp_map_channels(), Please
>> consider using q6dsp_map_channels().
>>
>> Also when you do that pl get rid of PCM_CHANNEL_L and PCM_CHANNEL_R
>> defines in audioreach.h
> 
> The code is not exactly equivalent, e.g. for one channel L (=1) -> FC
> (=3). I assume that's okay for you.
> 
Yep, that is okay for me.

--srini
> Best regards,
> Krzysztof
> 
