Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3E378C20E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjH2KKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjH2KJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:09:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F8EB4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:09:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a2185bd83cso548452466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693303794; x=1693908594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIPmU7FAJ8IOYvnYbTQNoLyMT4f9tBlJd7cHQ5zQPbM=;
        b=IEQkjv5pDWvOJODSQFAK9mCfHEz07C78LlPcrvcpqfG6eG87xyftm55IZxV+u0PmCT
         /ZXeRhYuVOp5WmsfC0t+nV/U3qWN6WOXm+UO3lwIRTvY7GM0b/G0KTXnPehKoKCABD50
         iP51Gu1vYl/MspxwrxTh6+V/d1hFmpP5THU1UJbmugnKmmHhU36qe2NwCzZAUpEdhw3b
         vs9R1LAobeQo/wesdONjcq+Sojqk+2l+jz1z/X65bEQT1vuXkB/uuPPMX11eOscows/u
         Gq34ZhuJxODyZHRRbvT3bV2ocpcr/Q4Kfgz/+6feskVid0vI9jecmulRf4DpA35gChWV
         R4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693303794; x=1693908594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIPmU7FAJ8IOYvnYbTQNoLyMT4f9tBlJd7cHQ5zQPbM=;
        b=czhYgBOHW4opAgNBXwKurRzKkrCYDzs075WzwC8GtP/v7PiJsQfBSG1zpTvD06oRpV
         6itIk271l2NHcwGmVbaV+IBHNcPLkGgwRmyv5mXZbJ2m22MQFQGZ/LAvdpQmoPI3nkTj
         M9EQhdX0/mYkz38Dk01ldTnb457l4T6jQGMnIxtrAixt4hSK2VPtBFxyvmgD0wCzJABR
         b4gQM809AI86mCnH5hwgs/XRq6Soo+jvxkhM/fL5QEcKtF3IdRnk5kBNxPw3w7PPeIoI
         WSa5WNwIYzb13L3OARB9EhAwGOMVgntxWhBnTkxCvuWUHAvbNBPDKszjYVxFdkibGXgI
         oZwA==
X-Gm-Message-State: AOJu0Ywl4SXIe1BQ2FvBh4ruMo9cnhANXuG9R6Ay3ZeEgy8h8Tu6Uab6
        4fcjjTeDP3LIQMLxF2llHA2MEQ==
X-Google-Smtp-Source: AGHT+IHsS8rnwwkQciQs8TVFBlZ1ixruc6azZm0xibcbq6NZF/8gVU+AVy4GO39xjkSiyVkUKeiW/A==
X-Received: by 2002:a17:906:76cc:b0:9a1:f668:dae9 with SMTP id q12-20020a17090676cc00b009a1f668dae9mr11091534ejn.33.1693303794318;
        Tue, 29 Aug 2023 03:09:54 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709064b1000b00992e94bcfabsm5723819eju.167.2023.08.29.03.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 03:09:53 -0700 (PDT)
Message-ID: <3722a8f6-8f63-fe7c-6983-ac96caa18c87@linaro.org>
Date:   Tue, 29 Aug 2023 12:09:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom,a53pll: add IPQ5018
 compatible
Content-Language: en-US
To:     Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com, quic_srichara@quicinc.com
References: <20230829095423.760641-1-quic_gokulsri@quicinc.com>
 <20230829095423.760641-2-quic_gokulsri@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829095423.760641-2-quic_gokulsri@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 11:54, Gokul Sriram Palanisamy wrote:
> Add IPQ5018 compatible to A53 PLL bindings.
> 
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Knowing that this patch could not come from downstream (it's some old
kernel without this file), I really wonder why two people were involved
in developing trivial one line change.

> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

