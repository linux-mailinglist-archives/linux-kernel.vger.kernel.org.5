Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C290D76C7C8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjHBIBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjHBIBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:01:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F4A103
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:01:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-317b31203c7so883568f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690963291; x=1691568091;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lra3q/h8SM1TJz6A0xEiw6O+E+QZRKqoZawzR3yHXXU=;
        b=WG73QsGDeqbfFjtwLTViQKxw6vZp2+DccJge8CopyqgNhzxZm+NQPurbPNE/zbpvMb
         bEgOEWX0oPDIaBXZIVkSUELuXPvZj6JYHj5uJrgQ2jE9KduNryz1mDgdOixfYtF4h98o
         qfKCJiugBJqKJVVmo1lAc4nyjob3fEmOS3ht6W7HnrqGou0fnckbspaaFoQoxqsWasnj
         MaoTR/Dc2Lt4Bco2VSIl4V4Z3tTFkfVb/IyxeFiTZgCQRAGry2qAwp0dDSG299dmrK1A
         UKRE0hvOGpw44zgPPdF+CqB9s4CZ9dVWFD/cM48hcfQxiGdKHgiUT8exP1Aroz+G1uLV
         KTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690963291; x=1691568091;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lra3q/h8SM1TJz6A0xEiw6O+E+QZRKqoZawzR3yHXXU=;
        b=XxL6CsRAoq0H4Um/deEYEgLp+MGJpNylZWRcAfyEFzvy5hE0rrY3You+L9IPXRdLJb
         /JBis2nH/ymN/LGYK+yDu4bl6zGvFfcRcmw8z+vuwBsMogko4gExuAX2krfQW6tPXMRU
         QiS3+yOEnkPqvM9o3Hvu9kuzrRY49TsQWbzTJP25Did7RSrPbIpI862WIIOyEeDNsm+J
         BqxPv5AXYz1Qxzus4M8vlllBhaEdqTBNAcxxrUuvdIPNnXtDcqWkKa8OpEm0U0hP10fS
         /iAKgYDiQn4MvuesDCwM8+eszALllt8bpGOtVijB1wtyX28zq0PhCUq7k1nTDe1srqve
         2fJQ==
X-Gm-Message-State: ABy/qLYgjqOAHTS8MQYjfQkMPTe+q9PDf93z/9k6dmcu8KqnMTRDz004
        JSbGv9/j2OaOPBS8sozjFLxzGg==
X-Google-Smtp-Source: APBJJlGdsZhFMf93cQbrmr7O2hMk9KbKDVaIKgraQYohQlJ5ll+m53ZGUG4Ri6G3YFdBEvdtu0kh7Q==
X-Received: by 2002:adf:e291:0:b0:317:67bf:3376 with SMTP id v17-20020adfe291000000b0031767bf3376mr4297267wri.57.1690963291548;
        Wed, 02 Aug 2023 01:01:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c5bb:5b4:61e3:d196? ([2a01:e0a:982:cbb0:c5bb:5b4:61e3:d196])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d654d000000b00314398e4dd4sm18128546wrv.54.2023.08.02.01.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 01:01:30 -0700 (PDT)
Message-ID: <32876ecc-4f20-2b59-937d-7923a4d20594@linaro.org>
Date:   Wed, 2 Aug 2023 10:01:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: samsung-s6d7aa0: Add MODULE_DEVICE_TABLE
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>,
        Artur Weber <aweber.kernel@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230802-gt5-panel-dtable-v1-1-c0a765c175e2@trvn.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230802-gt5-panel-dtable-v1-1-c0a765c175e2@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 08:41, Nikita Travkin wrote:
> The driver can be built as a module, however the lack of the
> MODULE_DEVICE_TABLE macro prevents it from being automatically probed
> from the DT in such case.
> 
> Add the missed macro to make sure the module can load automatically.
> 
> Fixes: 6810bb390282 ("drm/panel: Add Samsung S6D7AA0 panel controller driver")
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> index 0583360b1280..ea5a85779382 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> @@ -567,6 +567,7 @@ static const struct of_device_id s6d7aa0_of_match[] = {
>   	},
>   	{ /* sentinel */ }
>   };
> +MODULE_DEVICE_TABLE(of, s6d7aa0_of_match);
>   
>   static struct mipi_dsi_driver s6d7aa0_driver = {
>   	.probe = s6d7aa0_probe,
> 
> ---
> base-commit: 626c67169f9972fffcdf3bc3864de421f162ebf5
> change-id: 20230802-gt5-panel-dtable-d9d6ca407f26
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
