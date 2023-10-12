Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414A17C707B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjJLOkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjJLOku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:40:50 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1813EA9;
        Thu, 12 Oct 2023 07:40:47 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c5028e5b88so1136301fa.3;
        Thu, 12 Oct 2023 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697121645; x=1697726445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3kw/R5D+s3aJanIgvu3nf4Gs9+0fYmqPraYbms7U3dY=;
        b=DwVeY7kHZd8snQaNN6Y5NhbpQ0/BYx67rw6lzY4o5kNSGMJaFgSQ5V/IN/814EB6MV
         VxzKLRWKbDYsAmnnc1WHj6Iesx8bYekuYLSGiUoBs+9EBVT6WaUj0DWkXWRhe1woeAcb
         T+skGg+gArzc8hC4CSnWiCNtr0K1kF9VEvm681bZepPZHhlNHYRKh0e0naKxfldNaWAp
         18UfTPvhAxExzwKoCPl2l0QmLm1FT6fx7ZSMN8La4YgQ/7toh+x3b9ZZdzFsVln5AzU+
         9NeRjenVNaq3nHxPHI1m4L3Ly2uhqKA2svrFxly1FoWn0lZOcebl2CEq0zTnjKR+fZtj
         RT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697121645; x=1697726445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kw/R5D+s3aJanIgvu3nf4Gs9+0fYmqPraYbms7U3dY=;
        b=PZYRjA/6Wr+98tZXo9m9C2MqFgzfmEVlHHmHVI0EdPSLZiAgeqCwiBEi2y8v/bPS8P
         49sh7QjkHlWxQEr84PwM7h4954vR8Eb2iRuHZ06PfGdOVL9KxOiHA77bKUmxSe5TQtYQ
         gJn71r+n2gVIzSNSYygc7dMyHBZFy1W/ZkF5bj8ZcfUupvkkDVHebfo2Qij0GqMBQi+4
         Pk42cfibH0ckMOVP8j2TecaYsmpvXls4HR51qi9d6rR5PTjP3b6KBbAIbLoB1qKnj3lu
         cIhRFz9pTOzTlfuKqN/ceuTtdBKe20vp95bgeRGiOGi1ZTTe0apQh0ebbp77hJCkvVdu
         u2cg==
X-Gm-Message-State: AOJu0YwFTJfaElhW7LGrNUfV+3X+2/nsbveZbO6zCK2mm5nDagFJsMFI
        bf3iAcYtoOLNaeqqPXo3hwVmMSDlnJyemrvY
X-Google-Smtp-Source: AGHT+IGH41yXs+O99grdygoszPTYW1zPKpN4EmD/LKIiUtotZlFPT/goo7+MpuARd/B4135q9i6NQg==
X-Received: by 2002:a05:6512:4002:b0:504:369d:f11c with SMTP id br2-20020a056512400200b00504369df11cmr24729653lfb.34.1697121644971;
        Thu, 12 Oct 2023 07:40:44 -0700 (PDT)
Received: from ?IPV6:2001:999:704:2143:20b5:8471:77bf:6204? ([2001:999:704:2143:20b5:8471:77bf:6204])
        by smtp.gmail.com with ESMTPSA id b17-20020a056512025100b005042ae13de4sm2854806lfo.302.2023.10.12.07.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 07:40:44 -0700 (PDT)
Message-ID: <db511d14-f2fe-4b4e-bd13-223e7a33f933@gmail.com>
Date:   Thu, 12 Oct 2023 17:41:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ASoC: ti: omap-mcbsp: Ignore errors for getting
 fck_src
To:     Andreas Kemnade <andreas@kemnade.info>,
        Tony Lindgren <tony@atomide.com>
Cc:     bcousson@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, jarkko.nikula@bitmer.com,
        dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20230705190324.355282-1-andreas@kemnade.info>
 <20230705190324.355282-2-andreas@kemnade.info>
 <7d58d52d-2087-45af-b29e-2515b63ead13@gmail.com>
 <20230920063353.GQ5285@atomide.com>
 <dac768d2-2c66-4d6b-b3d3-d1ef69103c76@gmail.com>
 <20230921121626.GT5285@atomide.com> <20231006102348.GK34982@atomide.com>
 <20231006213003.0fbac87a@aktux> <20231007062518.GM34982@atomide.com>
 <20231007091156.588d7ba1@aktux>
Content-Language: en-US
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20231007091156.588d7ba1@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2023 10:11, Andreas Kemnade wrote:
>> OK good to hear it works, I'll send out fixes for omap4 and 5, seems
>> the runtime PM warning is something different.
>>
>>> omap-mcbsp 40124000.mcbsp: Runtime PM usage count underflow!
>>> # cat /sys/bus/platform/devices/40124000.mcbsp/power/runtime_status 
>>> active
>>>
>>> even with no sound.  
>>
> Well, it is a regression caused by your fix. Without it (and not reverting
> the already applied ignore patch), runtime is properly suspended. Don't know
> why yet.

I guess it is because of the pm_runtime_put_sync() in the
omap2_mcbsp_set_clks_src() around the fclk re-parenting.
That is a bit dubious thing for sure. We need to disable the device to
be able to re-parent the fclk but if we disable the device it is going
to be powered down, right? I think we have appropriate context handling,
so it might work, but it is certainly not a rock solid code... If you
have a stream running already, you don't really want to kill the McBSP.

The problem is that this mux is outside of the McBSP IP, so we need a
system level (iow, clk API) way to change it runtime.

What is the machine driver where this happens? If you set the sysclk in
hw_params of the machine driver, it will be OK, but if you do that in
probe time then it is likely going to fail as you experienced

-- 
Péter
