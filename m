Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B06B779B50
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjHKXZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjHKXZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:25:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E597E71
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:25:42 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe0c566788so3921806e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691796341; x=1692401141;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVN6+rNkyqx4xTJizaY12BHwBRW/Yqq72y+b5htJZMo=;
        b=iVBAmmxArWrYmPXM9lzi+P9bnoViHnKLHpHOG7W9AOIFX28cvk/XDjekRUUn8DwFY/
         VWouH942lYH2gJFyPL5qxkRM8Ajkx9D15B9BIhXKBLoOXoAle1p/5FHXKCBfp7W0FzdP
         SUHBbzvsf1pniQKtHXZEbTY22RiAsSEo1AGgTq7JcPNuEQUS3BArsV16sSx+qcQOp8Cw
         KC6lmvUfA217tiapWQs51okYds2wPDAa+nctqGghxWBTbyxAJroXT5JY+WA6qMFovDG6
         fi0qk94klRs/t01SDE0ZQKGuCnFeAHDvdjYIkDow8Zd3IUbyM7b8I9c4jVerXNRCbBp5
         bkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796341; x=1692401141;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVN6+rNkyqx4xTJizaY12BHwBRW/Yqq72y+b5htJZMo=;
        b=Ebpk2GJEV2KWQxJgr4q+0zPqSK6zFkNsjC6cpIRl52kmKpUcoBFOkXQimv8geX8Y0N
         dgRtL2mtAbbFseD4g3Tv1MyvP8zi15ki3SQtEhqUD2g8RY+TiANmYqINUnvCMgJlud12
         yUgXwiBtc5h+yfzcw93RMbA7OS+ehaEeZ6wCKE9Y/AziFonon6lDDOmP+b+/lhWF7PUT
         +hP2X5GsRzg9XmPTCPzSmYVEpeu0tPJvX/OjWnxUGbkohXodLy17eXBX+8yWLzVAwagj
         GDwc5XnH+eLd/VE2ApktSkYlbs2Op8mN6WwIctpIOVA/Td0IG9dApykUihyQHbRmhy6a
         hwag==
X-Gm-Message-State: AOJu0YyHOHy8b6D1vEBjDcZi3PNkNe/9ay6R+XprHehe/43xVSaa2M3f
        kh7PCoClsN0f0ZEyFJkUDh6aGA==
X-Google-Smtp-Source: AGHT+IECVHoFPHSz8JsNIQS3/CY1pOGH/6zGBAPRpK8QHTOoxepP9AMIR+l4mT8gPYrCiP207c2/GA==
X-Received: by 2002:a05:6512:3c8a:b0:4fe:1d71:6076 with SMTP id h10-20020a0565123c8a00b004fe1d716076mr2988393lfv.46.1691796340641;
        Fri, 11 Aug 2023 16:25:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id eq6-20020a056512488600b004fe5688b5dcsm870934lfb.150.2023.08.11.16.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 16:25:40 -0700 (PDT)
Message-ID: <b815129f-ee26-4956-88a4-cbe65b8f5f23@linaro.org>
Date:   Sat, 12 Aug 2023 01:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] Hook up ACV enable_mask for everybody
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Richard Acayan <mailingradian@gmail.com>,
        David Dai <daidavid1@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230811-topic-acv-v2-0-765ad70e539a@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230811-topic-acv-v2-0-765ad70e539a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.08.2023 01:20, Konrad Dybcio wrote:
> In the downstream kernel, ACV enable_mask has not been mentioned
> explicitly, rather being handled by a sneaky if-condition [1], [2].
> 
> Add it to all RPMh platforms to actually enable that BCM.
> 
> Based atop [3].
> 
> [1] https://git.codelinaro.org/clo/la/kernel/msm-4.19/-/blob/LA.UM.10.2.1.c25/drivers/soc/qcom/msm_bus/msm_bus_arb_rpmh.c#L556-567
> [2] https://git.codelinaro.org/clo/la/kernel/msm-4.19/-/blob/LA.UM.10.2.1.c25/drivers/soc/qcom/msm_bus/msm_bus_arb_rpmh.c#L475-495
> [3] https://lore.kernel.org/linux-arm-msm/20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org/T/#t
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v2:
> - Remove the define and use raw BIT(3) as the APPS mask may change (Mike)
> - Pick up tags (Bjorn)
Whoops sorry, there were no tags (and none were picked up)!

Konrad
