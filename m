Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FDF77782C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjHJMWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjHJMW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:22:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FD9211D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:22:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe45481edfso8022955e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691670147; x=1692274947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=raKaSO0bx4jOE7OKU2N2ftJwkwr22E8Sk6vAid3oKS8=;
        b=DfjnEX+WZaoFvTHqKRObZtQygjLG+y4QuMm/E9zgbDyxJxLIopF+U2X7XbB1FS1W6y
         QbquJD7RZmZvPmKTp+lB11KtZe/7aukNoFpYz/GABzRstnhdY2uWNpmyVAfacdc3QgMf
         vaeJs/TdH7e1zdi93oy+6+yjkQFlCUW/ynM6pIyk+Hun8Q/cwt3fSTL9wPnnemrpTkvx
         9e2oway38SFd0P9yJByzmEsFJVlD+lGRhMXv1I5cZ4i07s3P8kd8e4lnNq8qmmMZz0AL
         kPnp1wTau1zeKrkQfq1gVQ/TbcJbdyGslr2YtW6lDp/NR9UcGiqM2xp+qFpwEcuH9aIw
         LNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691670147; x=1692274947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=raKaSO0bx4jOE7OKU2N2ftJwkwr22E8Sk6vAid3oKS8=;
        b=bbB3rx1TFBY+AOD8BR4+euE5YsxIgZ3mJu9iiJzn7U2/zrZtZAA7q6sGW43UMVGQ7+
         IPOIOnlYTj9YP2+bTuZZMFMikwLvNYSEOlnIwnN9zxfqvT4b0izbNACGgayVI88g1dOe
         768nWHj2avtlRYCtGpLdhLAkxtuTodFbIwSGjrfgtoMuY41hzy7S6lmItSk4U3mGsCNE
         UwmyunJ1qQhAUsGI7I0gzbASAH96SZnTpI0eXkjssqUATJ339/3+3m/Dg/Hjmke2OtOT
         OaYQZKLNQAHBEEtQ5VZ2Z0fFAhjtByotYnEjJlkSSRbiZx3TzoEG95+x7j8Tu0IBlo4w
         cChg==
X-Gm-Message-State: AOJu0Ywa4ozDPMeqjsBMbuu0Q5jHT5A/rsM7Cs9EBEL1xOwVCjI5jtcB
        JfyhnVL2+G7tZ0MxFQmtpO0vwO5Ogt58M5q/KeQ=
X-Google-Smtp-Source: AGHT+IGeBZm0j3Xwz3t2IKFe94d8bJrD6jWllxR/LeWyk/hbl/+gK4r/9F7D+lzaVUUBvPegke57tw==
X-Received: by 2002:adf:f3cd:0:b0:314:2f5b:2ce with SMTP id g13-20020adff3cd000000b003142f5b02cemr1955642wrp.12.1691670147004;
        Thu, 10 Aug 2023 05:22:27 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s7-20020adfecc7000000b0031912c0ffebsm1279740wro.23.2023.08.10.05.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 05:22:26 -0700 (PDT)
Message-ID: <79ccb7c0-dc4b-87a7-3721-488f3ef3b192@linaro.org>
Date:   Thu, 10 Aug 2023 13:22:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/6] soc: qcom: llcc: Refactor llcc driver to support
 multiple configuration
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230810061140.15608-1-quic_kbajaj@quicinc.com>
 <20230810061140.15608-3-quic_kbajaj@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230810061140.15608-3-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 07:11, Komal Bajaj wrote:
> +	if (!cfgs || cfgs->num_config != DEF_NUM_CFG) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	cfg = &cfgs->llcc_config[DEF_NUM_CFG - 1];

This is a bit of a redundant check.

You add in the check for num_config != 1, then deref llc_config[0] but 
in patch #4 you get an index and check that index against num_config

I'm not seeing how at this point in your series, how num_config could be 
anything other than 1.

I'd do away with the DEF_NUM_CFG define in this code/series completely.

num_config should encode all the necessary detail we need, DEF_NUM_CFG 
just adds noise.

---
bod
