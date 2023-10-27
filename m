Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7157D9598
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345516AbjJ0KvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjJ0KvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:51:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F491A5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:51:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40838915cecso15387125e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698403867; x=1699008667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5GMaDMg99nAklQh1qDlCO1TyWf93Sxk8f/KTLZFXGDM=;
        b=hsyeb2EJ47q8NPOFwBeTUzRxTZtvefrGnSZTsQtW+CZ9sQkAj5nxuJWwHjcDJYBES1
         0RAigfE8ks7Nleg3vlNx5iDNRnhuSF4hVWXKp4HxmUGiWvzgiGfcrMw5RhfzI5Ja8rns
         R3qR/ihnxgbHc9N20c3yllNw+bOHZw6ajbPMdknGIHn5b6xLi5OE85XIexE90ESk3EEc
         ZMD1twrZcOZ+ZvtlsVsbE+E7FShm3gJG40gTRPu9YSeaGl6ZAzIRFP8RQspFJXbTBfdy
         xExzc1TP5E+9oNCJqw21p8GXt5LniPneceo44/t1kWhCqCpxWSo58FeEguAynyrkhfbY
         IUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698403867; x=1699008667;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GMaDMg99nAklQh1qDlCO1TyWf93Sxk8f/KTLZFXGDM=;
        b=dX5yoSJaJu1vEAZg/N0sMpdLw/VIvEns6P46swrpbAuscucTIzW9mocVA2SvfkIjHZ
         29DkM7LYBTU8ThsrNsa8fg/qoukkpL+NFbYf7bmo3k2/ZQXy/VYSB4HtgdGq3M+Aw3/H
         YpzJqc9NhrUdWtJrVYi7/pxtdGnpRgpqL7IBQNtBPy+Vl90lHATiR9lURofzw71uySTR
         CpSroatk1C+MQdxpwfQOIokwOX73w+6FoEF78gMhQI2drZsIk99AA/b1Y+wxcCv4KgmC
         C2Xhk1eGJdSbQv6kyQh7bBU7pKGioyyCSIc6/bALwVOPO8yCstgQAFhX2yhulg9JKomg
         4X+w==
X-Gm-Message-State: AOJu0YzdyCKdIE38uQDmuIOqas3WcjcqV4zPFRoFIIfItztJq6D9fyBn
        2flLK6M+dfpXD7zf35/ZHKyIqg==
X-Google-Smtp-Source: AGHT+IHdmua5zVi+ZxIFHrXsTwBL0mnHN3EnRlt4+jCLxKzUHqOycqakChHQbS4LdHAroIwqyan+aw==
X-Received: by 2002:a05:600c:4fcb:b0:401:b204:3b97 with SMTP id o11-20020a05600c4fcb00b00401b2043b97mr2127444wmq.4.1698403866687;
        Fri, 27 Oct 2023 03:51:06 -0700 (PDT)
Received: from [192.168.86.24] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id m28-20020a05600c3b1c00b003feae747ff2sm4881007wms.35.2023.10.27.03.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 03:51:06 -0700 (PDT)
Message-ID: <4da5dbea-fc3c-4b72-90b6-246f8e6fe9e7@linaro.org>
Date:   Fri, 27 Oct 2023 11:51:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/4] ASoC: codecs: wsa883x: mute/unmute PA in correct
 sequence
To:     Mark Brown <broonie@kernel.org>, Johan Hovold <johan@kernel.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        johan+linaro@kernel.org, steev@kali.org,
        dmitry.baryshkov@linaro.org
References: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
 <20230323164403.6654-4-srinivas.kandagatla@linaro.org>
 <ff3eb88a-6941-4303-a4ba-17cad3842b88@sirena.org.uk>
 <2a0aabf5-41a3-cc07-3203-9b0bca6b71aa@linaro.org>
 <ZTjKWHAAfSYfc5px@hovoldconsulting.com>
 <6df45f92-5fe6-4b44-af04-c528d540ac06@sirena.org.uk>
 <ZTkNcHAzgnL5xpAO@hovoldconsulting.com>
 <9c622323-6b94-4622-840f-5f126942ae96@sirena.org.uk>
Content-Language: en-US
In-Reply-To: <9c622323-6b94-4622-840f-5f126942ae96@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/10/2023 14:05, Mark Brown wrote:
> On Wed, Oct 25, 2023 at 02:43:28PM +0200, Johan Hovold wrote:
>> On Wed, Oct 25, 2023 at 01:36:14PM +0100, Mark Brown wrote:
>>> On Wed, Oct 25, 2023 at 09:57:12AM +0200, Johan Hovold wrote:
> 
>>>> I understand Srini has looked at this but has not yet been able to come
>>>> up with a generic implementation. Would it be possible to merge the two
>>>> codec fixes as an interim workaround for 6.7?
> 
>>> You're talking about two fixes here but this is a 4 patch series...
> 
>> Yes, sorry, I should have been more clear. I was talking about the codec
>> fixes so that's patch 3 and 4.
> 
>> I believe the first two have already been applied.
> 
> So, having gone and fished the series out of lore to look at what the
> patches are I'm pretty surprised here, it's been about six months since
> the original discussion and I'd not have expected this to be such a
> difficult thing to do, or at least that any issues would have been
> flagged up by now.  What are the issues that have been encountered here?

The approach I tried was to reuse the existing 
snd_soc_dai_digital_mute() from generic snd_soc_pcm_dai_trigger()

The issue is that prepare also unmutes the stream which is why moving 
this to generic code is not helping in this setup.

To overcome this I have added a flag in snd_soc_dai_ops which seems to 
have helped

Let me send that patch as RFC for more discussion.

thanks,
Srini


