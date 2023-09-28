Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D7E7B1529
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjI1HkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjI1HkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:40:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA24EB3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:40:19 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so23676465e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695886818; x=1696491618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NS4C/mM/zBNdFiLrFor74up9kjjsQXCZO6F1jw5ZLDA=;
        b=CE9a5C5h2CbfituwOHByIg9wOcNtvJAmI54gaPQ0jElB11kurI/R/zRzKf/6jyBEMv
         04RZBV98LmxRoM4AL/UPzlytMGV01oqo4SwcinjQgsQwKsc0J6gTm7mCRcrLiphkblQG
         mlHTkUad93O2D9z4h/Rb84Unr9i+oUfb3Cb9BaoFFLC86rSz0jzoHX+prqYqQQL1siWO
         JiGYgmLUV8Zx1Cmv/8RyB1tGNfNBheimvaXoRySzkENBM9DTShreIJQS2V7VY7nBNwM6
         PHyHnBYYzQ27bz7JOg0We4l+UBRJ+zAl2ExojYECcDmRPPxQTGHVXkYn0B3KaBBbmW5I
         HkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695886818; x=1696491618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NS4C/mM/zBNdFiLrFor74up9kjjsQXCZO6F1jw5ZLDA=;
        b=v8sIAJvpceH5Q9Ghdfv5/QGFxqQZc+sUDHu2lSC1ci7pNxHVZnaic5JKDuhhoQvQv5
         3zYETSuf75hETBPxtljw3F57r1WMJccNYR7aUmy+DeY1OEsLZVYYk69yVUWnnrsDTYo8
         jtMPdfWAdg1p+VTT9n/cJA4SuNPQqQZPrs5FpMZoKNZsnowQacWi24cOEfdWglkqS8Tq
         GB7S970aASg+7TDXnRJU4t268gGL76dmUNa+Vlq3ElKVylcAHn3+kmhzySsrSjRIIS/d
         02L3JLQFp3tUaz2aV2XkQ2vXTPliqB58hPAOKy6tmjXIvCpmn6S9zKGeX77hjTvvLM7w
         jlSw==
X-Gm-Message-State: AOJu0Yzao3qlr9shEoq6rJemtNvvIUJQ7yQdhs5SEMuBIXyF1TPNsicU
        i9pl7UykL/Bgp4wi49EftdmXaw==
X-Google-Smtp-Source: AGHT+IFIIg/HkrSyr4dW/IdOOjc0GrxIwQDaDFz5Dl/EzewLiPMWA0QQ4iNuQOCvvX+eVWZzRAAM3g==
X-Received: by 2002:a7b:c4d1:0:b0:405:514d:eb13 with SMTP id g17-20020a7bc4d1000000b00405514deb13mr515848wmk.24.1695886817909;
        Thu, 28 Sep 2023 00:40:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id y8-20020a7bcd88000000b003fee567235bsm9924970wmj.1.2023.09.28.00.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 00:40:17 -0700 (PDT)
Message-ID: <7ca5819f-bfec-bd25-c2f8-8a303802df07@linaro.org>
Date:   Thu, 28 Sep 2023 09:40:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] thermal: imx8mm_thermal: Fix function pointer declaration
 by adding identifier name
Content-Language: en-US
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        rafael@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230917083443.3220-1-bragathemanick0908@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230917083443.3220-1-bragathemanick0908@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2023 10:34, Bragatheswaran Manickavel wrote:
> Added identifier names to respective definitions for fix
> warnings reported by checkpatch.pl
> 
> WARNING: function definition argument 'void *' should also have an identifier name
> WARNING: function definition argument 'int *' should also have an identifier name
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

