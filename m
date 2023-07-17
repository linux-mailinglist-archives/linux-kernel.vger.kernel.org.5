Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC72F756E25
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjGQUYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQUYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:24:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0560D188
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:24:05 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so7787826e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689625443; x=1692217443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPmxEAn98qat39xVVQIKzAUFqZtNFTpShvS5B+Il20g=;
        b=Q8fqmZj/nwim2uqP9c4Pq+vL0vXAHQcvTm9SN8fMiI2W7vtxtSmYu5UyI1msnJ/ybM
         eAGpk94XUc2OZv6QdcBatakQRuq6Pfg+j7YdglFlux67eJeBgGGLX6zxgzBxnQ9mtULz
         g7egOxbpkMRADaYHVqLg5mbGgGSZG27jnrhwdwRuCE3gTL5Rc+2vxOb/zn8FQxY9ySSK
         cwHaQd3v+m5N/siROLzDjA5fwLj8w4yZCx6gj4ZWv63SlfLa5bTNSqfgVGjjgIHcM9ea
         VMJmC4K7i2cnKRyF7FLWu3e+TmiC7ozwYIsiIlzY/rf+ecDJs4rLj1cz4UixFw/0j5zr
         yhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689625443; x=1692217443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPmxEAn98qat39xVVQIKzAUFqZtNFTpShvS5B+Il20g=;
        b=gKSKyQWxE4PzgCCMwvumi+OEWQZU4W2VhSGASu7P+BXuh0jELZ/ch41gsyYH1SM8z6
         YFDougK7Vn6nd1p/zxNG4xtIqMHrkan89OVsrq/ZG1Gksns3c6Y87WwVxlaGObO1jW0F
         G5rkHx+beXV82N9CmrFMJmU0MUyA3hrFSUEwuWpT+q0TnPcJ5Vy7kZ46ECXJTfRUMrcm
         AKDMnwB78LCs6wsqg/rAqEEAFxDcWsNAavPDAUIHeDPeZCiz9msdjJcFO/HzzLAuvj9f
         QnEdQDPs1uu4fw9Gv2EJlQ8TqZcr6BDoboFAlvSci0HO3xUMvbIcsJNgXcpdKzsxWpZX
         X9Qw==
X-Gm-Message-State: ABy/qLas02O1z/SD8n39TvTIuDhJfb1W0zFHJpTThSEtSaw7TGt6hTI4
        vjX6jSTX/bvMsYmbIf68Mr6QaA==
X-Google-Smtp-Source: APBJJlEtcmakKntg4CRzzMflCj8rCNgTL3VCRsDKprRKPbcDg7cEv/oMh5h8oGw8JyePosIHuY7FSQ==
X-Received: by 2002:ac2:4f12:0:b0:4fd:c78d:5419 with SMTP id k18-20020ac24f12000000b004fdc78d5419mr1637394lfr.8.1689625443174;
        Mon, 17 Jul 2023 13:24:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id v16-20020a056402185000b0051bfc85afaasm87535edy.86.2023.07.17.13.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 13:24:02 -0700 (PDT)
Message-ID: <192fa604-5fe6-c5c2-7fca-10f3a271b640@linaro.org>
Date:   Mon, 17 Jul 2023 22:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1 5/5] ASoC: dt-bindings: Add schema for "awinic,aw88261"
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.co, shumingf@realtek.com,
        herve.codina@bootlin.com, flatmax@flatmax.com,
        ckeepax@opensource.cirrus.com, doug@schmorgal.com,
        fido_max@inbox.ru, pierre-louis.bossart@linux.intel.com,
        kiseok.jo@irondevice.com, liweilei@awinic.com,
        colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yijiangtao@awinic.com, zhangjianming@awinic.com
References: <20230717115845.297991-1-wangweidong.a@awinic.com>
 <20230717115845.297991-6-wangweidong.a@awinic.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717115845.297991-6-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 13:58, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Add a DT schema for describing Awinic aw88261 audio amplifiers. They are
> controlled using I2C.
> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>

...

> +  compatible:
> +    const: awinic,aw88261
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#sound-dai-cells'
> +  - reset-gpios

I don't see any differences against AW88395. Add the compatible to that
schema.

Best regards,
Krzysztof

