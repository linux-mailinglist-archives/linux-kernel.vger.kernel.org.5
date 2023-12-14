Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A908130D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573320AbjLNNCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573256AbjLNNBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:01:34 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD63210D2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:01:35 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bf82f4409so590999e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702558894; x=1703163694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEBNj87fP9250zui4T/Hvg1xpkDfzNZnKnVDxt1bMUY=;
        b=c/cZNQ2Z0vfSqTkKgxr6lG0OXRJajUMTqpoy7zJ3VvQkPKHDIDqROQqUXD/DNNhz3w
         soLa1tsM9s7HUvfzVaXAKPrbejdY68Kkvu5UCN4q6raPbwHXHAoNswcy6qnI+gHixg2k
         egNpuOllT5hdaPCMfhC1KHhi+cISA249t8amqu8M7/IIr+725/WJIfq6GkQXM7YLU0aR
         sgtp2msCe9hTpuKtrJIZCSbb0mHtqPcqIu5Vb3WxOM7hZzPKJCAFe50eYvXDkuXRx+u5
         Ma8Kk6H811winPIQ2eRrn3d7ZBV3J8eR/x9JzfJyTCHP3hv0W37GJ2uDQMu6pehIGeX+
         B8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702558894; x=1703163694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEBNj87fP9250zui4T/Hvg1xpkDfzNZnKnVDxt1bMUY=;
        b=eSwGY0mj/IZtEgCOGGM/ee6qjrbhQ9UY4fiaFIuBDJ8INjrZdpryI4WzIg1RmyYbPY
         B8qmVVa0qyZJW3Bc3+f+cmrWdTKRZaTD8Ze02bOKyj26RoP+AJNY3/9tDobXPHXXv8jC
         GQDIO459cSajelkhrUd4UtddCtmYp24BWoyAwJbZrCUoIduoEGP3ReSorZUYqPLvzwgO
         Ip/GZWu1d9tWH4vhe1dMEBKw4IO5MIa9e0HT6zt5dbyWA2qEKCkdKob1+Jw+pgi/E1FD
         gi/vShH06wMmo+rnlulf6Q2wABhNKxGkvLk26mvdvzIxklTr5I+z+oNbbd1x/nGlariu
         uFXA==
X-Gm-Message-State: AOJu0YxZL/bcNy6pMBDyatUHxDbgRqsa62ebCzQdoV/RYS4lrkke7N19
        q744dKAd6cX1sJNlum/eeT4bTw==
X-Google-Smtp-Source: AGHT+IHDwfUDUX4A8h+6BpYMmsxXIr+8mmt9c12FvptD9zihDInwN3uM8coAVGJ5D7hEzSztlmtQhw==
X-Received: by 2002:a05:6512:3ba6:b0:50b:e472:d825 with SMTP id g38-20020a0565123ba600b0050be472d825mr7069181lfv.20.1702558893836;
        Thu, 14 Dec 2023 05:01:33 -0800 (PST)
Received: from [172.30.204.158] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id m16-20020a056512115000b0050e1b9c6ff5sm34796lfg.265.2023.12.14.05.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 05:01:33 -0800 (PST)
Message-ID: <32a47aa9-4b4a-493d-879a-0cf3f7fe9c00@linaro.org>
Date:   Thu, 14 Dec 2023 14:01:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: qcom: Fix ESI vector mask
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
References: <20231214125532.55109-1-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231214125532.55109-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/23 13:55, Manivannan Sadhasivam wrote:
> While cleaning up the code to use ufshcd_rmwl() helper, the ESI vector mask
> was changed incorrectly. Fix it and also define a proper macro for the
> value together with FIELD_PREP().
> 
> Reported-by: Andrew Halaney <ahalaney@redhat.com>
> Fixes: 0e9f4375db1c ("scsi: ufs: qcom: Use ufshcd_rmwl() where applicable")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Looks sound

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
