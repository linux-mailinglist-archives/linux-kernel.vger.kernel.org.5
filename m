Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFC9784595
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbjHVPbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbjHVPbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:31:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061ADCDA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:31:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-313e742a787so2846707f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692718271; x=1693323071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uosOUAxceoT7rDQGwT3620q675u/dmggpL1Oc/TVgg=;
        b=GUZ7giCgdKP6AhmwT/JVkY64DYRgMauV+6U+N6onI7l1spNddyBseF8A0c0nnd7d5r
         rmNkccfFrHpN938CryWtERXeAhsTEJa/YbLEvboiLbwhjl402/cO8drGYLBYPEfdmnXD
         v/EwcGCf8pz4SD49sG6NCkRzJF1KuQqPisOZBha+wdaKY93+Sug/1wZH8D017QQbWLs1
         my2JbQrOzgZOBQO+6PYtqCokDCayyeNIAFXNWf6zAcOaB25lEYXy04q4fhr0WSBZb63J
         yH2xNF/ojnGSTs+rMvo9Ewk/edcExBuyDS0N3nTPQewBOXIthL4DTjODwODRzxnHv38Z
         tcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718271; x=1693323071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uosOUAxceoT7rDQGwT3620q675u/dmggpL1Oc/TVgg=;
        b=MzpfC5R7noZ+yfW7uvBj0o2SLsOcjVD3NDWDlm10qPngiSgSpHAwkeBryp1ZrTDgr+
         J7Jcbjpe8eHMT8Q4xVa2zHmAn8hwu7IZsno43xBkgMVejgooGwW9ufKji+AbsfcOUwR/
         NTVp1crgmWm6m3LwROP8uYNwPHjzOGaiHxeaIiTZPfnsFTr16BYZ/KUsjDXdJUinOWbe
         Q+c9XFhq1riZc+4uIriZOG+I4Rg11Mav95SUHXaQ6mAjLX/eAOGkftQfAyDMzih7/MfH
         Fki8aizBFxNmjlzWx8VboQtyO7AfWPg2fxMQc4GCIyWBqS+h6gauNnFQtzbm2nVsbMuh
         8qmg==
X-Gm-Message-State: AOJu0Yx4qXfJ3tswGTnlrlAaHBrZMtZxMAK4rwbp8WDCNrIWVvExYVom
        ME2PSamup6ILYZCnaKaXQdh3uA==
X-Google-Smtp-Source: AGHT+IEUU1gRdjdHzr8Sc3oXci7an4zcTuXwebjVN+K5jGfZ4/8TEKLXoA5qZBkoZfGRTGFx/BLqkg==
X-Received: by 2002:a5d:44c8:0:b0:317:e9d7:9387 with SMTP id z8-20020a5d44c8000000b00317e9d79387mr9599604wrr.25.1692718271428;
        Tue, 22 Aug 2023 08:31:11 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d674f000000b00317909f9985sm16043357wrw.113.2023.08.22.08.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 08:31:10 -0700 (PDT)
Message-ID: <2d989b98-8ab2-5204-d59a-ae7a8bd43906@linaro.org>
Date:   Tue, 22 Aug 2023 16:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 2/2] usb: typec: qcom-pmic-typec: register drm_bridge
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230817150824.14371-1-dmitry.baryshkov@linaro.org>
 <20230817150824.14371-3-dmitry.baryshkov@linaro.org>
 <ZOS+GnLeV6JJgpp8@kuha.fi.intel.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ZOS+GnLeV6JJgpp8@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 14:54, Heikki Krogerus wrote:
> On Thu, Aug 17, 2023 at 06:08:24PM +0300, Dmitry Baryshkov wrote:
>> The current approach to handling DP on bridge-enabled platforms requires
>> a chain of DP bridges up to the USB-C connector. Register a last DRM
>> bridge for such chain.
>>
>> Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/usb/typec/tcpm/Kconfig                |  1 +
>>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 37 +++++++++++++++++++
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
>> index 5d393f520fc2..0b2993fef564 100644
>> --- a/drivers/usb/typec/tcpm/Kconfig
>> +++ b/drivers/usb/typec/tcpm/Kconfig
>> @@ -79,6 +79,7 @@ config TYPEC_WCOVE
>>   config TYPEC_QCOM_PMIC
>>   	tristate "Qualcomm PMIC USB Type-C Port Controller Manager driver"
>>   	depends on ARCH_QCOM || COMPILE_TEST
>> +	depends on DRM || DRM=n
>>   	help
>>   	  A Type-C port and Power Delivery driver which aggregates two
>>   	  discrete pieces of silicon in the PM8150b PMIC block: the
> 
> Would it be an option to put the below in separate c file that you
> just compile based on CONFIG_DRM?
> 
>          obj-$(CONFIG_TYPEC_QCOM_PMIC)           += qcom_pmic_tcpm.o
>          qcom_pmic_tcpm-y                        += qcom_pmic_typec.o \
>                                                     qcom_pmic_typec_port.o \
>                                                     qcom_pmic_typec_pdphy.o
>          ifneq ($(CONFIG_DRM),)
>                 qcom_pmic_tcpm-y                 += qcom_pmic_bridge_func.o
>          endif
> 
> Thouse ifdefs in c file just look a bit rough to me.

+1 if that's possible.

Sounds nice.

---
bod

