Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE157A33AC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 05:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjIQD3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 23:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjIQD2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 23:28:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E912CCD;
        Sat, 16 Sep 2023 20:28:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401da71b85eso37587485e9.1;
        Sat, 16 Sep 2023 20:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694921317; x=1695526117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q5M0WMQ46n2FGOpYv7Jc4XqOFTIJE/KY78/IF5A+gUI=;
        b=FwljwuIdZUy88bKZNljjXrPe3Tt7Za+LiXHc3yZc/PByd55zeHujm1v85fWooUae69
         zgVGtthpjKroeSGN2Pvs7rLmnqxYb3K4vrQP1FpJftNQLBoc0OYqUbyaJYxl6LugID5h
         HaLEHyti0FLbaYdmyY9wCe/2mB4wNVpqGJoaRNA7Q5bfCGARHkGpclOEfe34P289uVtj
         mQROY5rWLk2VhX/+FsArtxC9i3B5sZEnh0UCkk4gBu+ftdxhhgC+Rx27j4Ii8SItk0EZ
         g5RZ+zYkKTi90vbyMxAaotPoAqthFcwSV6u6TLXyeT1ajjmWkn/3lp0aml9NU2ZS/33r
         AAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694921317; x=1695526117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5M0WMQ46n2FGOpYv7Jc4XqOFTIJE/KY78/IF5A+gUI=;
        b=IS6eVTwfjBu4xmC+/ySpUSKlb9BBCgfAYMAkLizmOW7I0r5IL2uTmnNjzL9xS+At+x
         ew9/FRb95Q5OE34WIefUdAPJy7WOLyHaG+2fY/bOVoG/BNV/ju/aPXlsom2M401WzPTw
         VFdEfevO63vZZkJMVKobiwrMZQmISY7EkaSlWz2SQyc9RiEBS7vWtH+P7Nj180/EUODo
         W2okXXIMqCGT+LWK/5EDEGyksBSkfX7LeykYrTLM++i1I4vGeCSEQJCbE0Wn/NGHz0m/
         pQZkl3NdvorCjSdTfMnwjnPbAnTzYN9yYZe2Ts1ecP/FqrVL79Pkr6IxDiDN+RJ8pprX
         1gRQ==
X-Gm-Message-State: AOJu0Yy783jpN2SKPMSX4siGpqIAsK3xSFxAchfQqldji8iPRXOlXIQr
        nHNLiI4KpHk6sOSdTBpym2XClOVdsbg=
X-Google-Smtp-Source: AGHT+IGgAD0WnANIU0VI4N4cm5B8MSzcXVPwCmCeLyj6PuW/mfzMWkZfnrt3qtEOYHAjWvVEkHHmQw==
X-Received: by 2002:a1c:f30a:0:b0:402:ea96:c09a with SMTP id q10-20020a1cf30a000000b00402ea96c09amr5090927wmq.16.1694921317365;
        Sat, 16 Sep 2023 20:28:37 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d4a90000000b0031ffb51f6f9sm4039685wrq.30.2023.09.16.20.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 20:28:36 -0700 (PDT)
Message-ID: <f3982556-dddc-4936-a628-a1fc8f05a750@gmail.com>
Date:   Sun, 17 Sep 2023 05:28:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom: qseecom: Add missing AUXILIARY_BUS
 dependency
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20230915-qseecom-auxiliary-fix-v1-1-38a46cfbfdb0@quicinc.com>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20230915-qseecom-auxiliary-fix-v1-1-38a46cfbfdb0@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/23 00:50, Bjorn Andersson wrote:
> The newly introduced QSEECOM driver fail to link if the system is built
> without CONFIG_AUXILIARY_BUS, make sure it is selected.
> 
> Fixes: 00b1248606ba ("firmware: qcom_scm: Add support for Qualcomm Secure Execution Environment SCM interface")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/r/9f156fa6-e5aa-4cb2-ab2b-b67fd8fc4840%40infradead.org
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Thanks for the quick fix!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/firmware/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index a94202229a71..8c608be30060 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -229,6 +229,7 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>   config QCOM_QSEECOM
>   	bool "Qualcomm QSEECOM interface driver"
>   	depends on QCOM_SCM=y
> +	select AUXILIARY_BUS
>   	help
>   	  Various Qualcomm SoCs have a Secure Execution Environment (SEE) running
>   	  in the Trust Zone. This module provides an interface to that via the
> 
> ---
> base-commit: dfa449a58323de195773cf928d99db4130702bf7
> change-id: 20230915-qseecom-auxiliary-fix-1574abe3bc98
> 
> Best regards,
