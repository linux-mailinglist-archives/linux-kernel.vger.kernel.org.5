Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEA376900F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjGaIYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGaIYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:24:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D470BFA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:23:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe07f0636bso6734439e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690791838; x=1691396638;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blXee+dDBQ47fnSeiUMVWE7fTOyc9C8HdxZlOvJbcv0=;
        b=Ex3Bn7EExzLV4MN9C/nljzAJjFQ0zSVGSQ9Md9FbJrIf6utaec9gFlJwhCuHmHlWPA
         z/wYprbtI9UOQfnUINErG0ap3FASEceipLsOyG4wfIf3urG/BHMSLh231sfK2CPk35Gu
         B4j1Z23v6SDCEbv7BTR/eISuTukq1WA8VLx67QixBkz/9fsF2pEjQi96EtDxdmF7Flpd
         EtjhGoHWdY+JNwr+mUIqRxGdp0qqaW0Cr/ITLKy/LxRZyGIDGCg7jISLCbMcgjijrDit
         GzZvr5WIjtxBS7cFBceYXjZkArcXCIfs4NlQezsRzPlqeWlcABxi8BmPyc98BY1y96gH
         bGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690791838; x=1691396638;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blXee+dDBQ47fnSeiUMVWE7fTOyc9C8HdxZlOvJbcv0=;
        b=RPVNi3b7gt9cLNpJG4F716FVrT5KbBmsayrNzQ/S+1XfamYMCPEuJDwhxp3W1qnReJ
         NIB6Cq6YD+Xo3cO3igAvIY/7W/ooN4CmMrxbiAoXY58nVCja+YwTg/j3ueUKdr55TbAq
         sV3/1Wc0uxPcW4xN+OQZgkWez9BhjY6jkaF/VkbxjP+OlTBJ7iUOh/0az0fRMYK/x9ew
         HZDRR+vy51fwopjgxttQLPT3boIaNQhZ+AMw8wCfYkkbIjNhm/1Q2dWxl61Mfd+/6hDA
         RgO16bT9I0Q7SpzYiVRjpglNYdZGpAW1JQTgBIs44Qa/ejWnY7xL2Rq1M5XbbDUNs5jV
         CRfQ==
X-Gm-Message-State: ABy/qLbPWZCc4TeeeouON+GGCw7QyEs78smlt+4laGgxoAupDSMkbm8K
        IxLeDv0fhG7EYrtw4AjMmjMc7tWMa+4W6e8E6RtU3Q==
X-Google-Smtp-Source: APBJJlGKE2DVLe149kchpBqjbs1hE92ofyR6T5tdMJPbmCVveeORAYPo6+BcOsrUK12AR94Q9JRlZg==
X-Received: by 2002:a19:9146:0:b0:4fb:7b4c:d38c with SMTP id y6-20020a199146000000b004fb7b4cd38cmr4754003lfj.60.1690791838163;
        Mon, 31 Jul 2023 01:23:58 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id u23-20020ac24c37000000b004fcdea129basm1977429lfq.94.2023.07.31.01.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:23:57 -0700 (PDT)
Message-ID: <2c43966d-33da-107a-ff47-370e3e27a99a@linaro.org>
Date:   Mon, 31 Jul 2023 10:23:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] soc: qcom: aoss: Tidy up qmp_send() callers
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Lew <quic_clew@quicinc.com>
Cc:     Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
 <20230731041013.2950307-5-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230731041013.2950307-5-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.07.2023 06:10, Bjorn Andersson wrote:
> With qmp_send() handling variable length messages and string formatting
> he callers of qmp_send() can be cleaned up to not care about these
> things.
> 
> Drop the QMP_MSG_LEN sized buffers and use the message formatting, as
> appropriate.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
If Alex is okay with that going through qcom:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

One nit below.

[...]

> -	snprintf(buf, sizeof(buf),
> -		 "{class: volt_flr, event:zero_temp, res:%s, value:%s}",
> -			qmp_cdev->name,
> -			cdev_state ? "on" : "off");
> -
> -	ret = qmp_send(qmp_cdev->qmp, buf);
> -
> +	ret = qmp_send(qmp_cdev->qmp, "{class: volt_flr, event:zero_temp, res:%s, value:%s}",
There's a space after the first colon but not after the subsequent
ones.

Konrad
