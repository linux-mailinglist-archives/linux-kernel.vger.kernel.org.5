Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE06F78DF05
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242474AbjH3TUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242450AbjH3IeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:34:03 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECCC1AE;
        Wed, 30 Aug 2023 01:34:00 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bc9811558cso3873822a34.0;
        Wed, 30 Aug 2023 01:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693384439; x=1693989239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SNhm82/yD2XJatnGAr0vBKs9bR4mP6ICOeiAlhv3D3w=;
        b=S9IfiC3bVXp8/08C30G84BodEDx2SGcUYTdidPUytMQpeyXgy/En4TD04Qh4Dhafk+
         xdquH/ylJUGZKqLvjN6pFMaIyjVAuwh7a73LzIbKOJS8pr2oacDzLYSD7hAE2lgFpHxE
         5P/Ibf/lBe4vW6Dfsw9it/cAFxzEmr629HxnUdgcMOrXV+BjGBKHMa0xPb2DblePq5z8
         nd1oWA6XtNKI70k7CYreQ/RDCOW4TcKJC0FUKPhuoZU1u3+83de3A+RqMhUemjbsTQ5M
         Uw07Bp5W9TIQyLIMq/GMVd/QKw1u0jEXM6rXQKqZkvp+wTZvI4u0EGTyirlUGe6UnXAk
         yTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693384439; x=1693989239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNhm82/yD2XJatnGAr0vBKs9bR4mP6ICOeiAlhv3D3w=;
        b=ahhrJBhAEDN4f+44O7+NiaTWtV2m/j7MBnvc5KA+NSfbbdzS6I5IKlqkaWS60jws2X
         J0iz2BdYY1mg3PfYR/qnlLPiYicPV4xKwRyLECAQXJoGCHKSH/fZQ6bMDVCWzLm4lWww
         6wG9fj7tUVxtS09E/0Dvxiiv9uXFCDgFF13ouPLJ0IaDm8OOx3hfzPSxcwJvXq7awzRo
         6ANQDRqpNCy34TZE++ZzzheXc4y1rEBcXONQD7pWlp1Dh1s7Mf+KO2gFHDcKVvi6o0T1
         Yxf02I2u53Jwy8natkvtavVWByAB77a+kqKQd6gSHG4RTpsvgbNVeFkGwiNHK9PRxnV3
         ap+w==
X-Gm-Message-State: AOJu0YyUiZmJ103KxQlLlKJ4Sgn5Sx2fZZQYboSn+2Si4GGWNjYZnPE1
        08Rc0tCcjtVbGnt12JxnCow=
X-Google-Smtp-Source: AGHT+IH4ZhfEnaAkZGMykkJRKfiN3d5ACC8sCq9Mk9PI6f9+a6622SjCGiGGGMWyZcawvPU1mIWHcA==
X-Received: by 2002:a05:6870:8a21:b0:1c0:131b:2bb8 with SMTP id p33-20020a0568708a2100b001c0131b2bb8mr1784884oaq.58.1693384439500;
        Wed, 30 Aug 2023 01:33:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t2-20020a17090a024200b002717a368efasm875416pje.12.2023.08.30.01.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 01:33:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c477c29c-74db-9d48-0b45-b22b70dc93c0@roeck-us.net>
Date:   Wed, 30 Aug 2023 01:33:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] usb: typec: qcom: Update the logic of regulator enable
 and disable
Content-Language: en-US
To:     hui liu <quic_huliu@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_fenglinw@quicinc.com,
        subbaram@quicinc.com
References: <20230830-qcom-tcpc-v4-1-c19b0984879b@quicinc.com>
 <a2353ce6-bd39-f5ca-ad81-63b061147400@roeck-us.net>
 <fea72c0f-f23d-493c-beae-6bc830b9c2a2@quicinc.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <fea72c0f-f23d-493c-beae-6bc830b9c2a2@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 23:37, hui liu wrote:
> 
> 
> On 8/30/2023 2:25 PM, Guenter Roeck wrote:
>> On 8/29/23 20:00, Hui Liu via B4 Relay wrote:
>>> From: Hui Liu <quic_huliu@quicinc.com>
>>>
>>> Removed the call logic of disable and enable regulator
>>> in reset function. Enable the regulator in qcom_pmic_typec_start
>>> function and disable it in qcom_pmic_typec_stop function to
>>> avoid unbalanced regulator disable warnings.
>>>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
>> Please drop.
> I didn't get your mean. would you please explain it?

You kept my Reviewed-by: tag even though the current version
of the patch is completely different to the patch I reviewed.
This is inappropriate. Please drop my Reviewed-by: tag.

Guenter

