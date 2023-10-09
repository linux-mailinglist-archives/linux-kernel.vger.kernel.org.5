Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83DB7BE749
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377376AbjJIRCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377145AbjJIRCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:02:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4C89E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:02:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50308217223so5913713e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696870961; x=1697475761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRuutAZs8fFclbHqtZl6SoFD2RTZgdCG/+ruCdezTQs=;
        b=l6TKlzdjmZvQd0RM9XdyAWioQGS3SkJ8BvWxGmkPv2Pc+pxxPK9cFbav8MYbC3D9Vx
         /csAkdx0yVX7/tP90wQYRLJKE1ayroMh4euL/sMC7OezW4AAUMQIrJQmAwvRbMSJUaZa
         DG2rhZ/A89DBWK2WiIutWQ1Rae/wKimC9sWWdFchnOZJoPaBPUJ/GLV3Tg3Ly6SB82PB
         iBqn4uSAhdk1hit7JwXwl9686f8idEicjazK1zKZX3vq8X1p5ZJq2tcaWPxb3YFdDyVG
         Hd7NiKbRl04WX9KV2Kpi/vWp507JpWDJBIkkGBacQWdCzHdHvV3skliQkorqHb2nYYlq
         7Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870961; x=1697475761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRuutAZs8fFclbHqtZl6SoFD2RTZgdCG/+ruCdezTQs=;
        b=hhl0VVhgBJaXOvESm5ZrcaQcqjV/ljjEwlZtHKKBwKQLEeLRgksBR+UyZArxrkW2IH
         7GYiEk7a+1XxGu3XYV7KT+661ADB3ZLd+TIH326lzTRe3V62Gai/oOg7lz9P+jYwQQH9
         h/pEaZa7g/qmlqY9K+rbjFh9zopJZifTtAz9RtnBZdtkctnADhr+QJWA1opjZiuarH4Q
         KEt/RtvAzQn75yNmtr2iXFYN+cOLsxPI7DRzJSXNnd0bDSu1f36ylRFgr/sO5QS2/jZo
         bAuY8Gjfmpvr5rY9rZAWz6TKSeC0ECiN8X+BLqwE+0XCHW4kyusWntxC4JePiHbY2bnj
         AZjA==
X-Gm-Message-State: AOJu0Yx2Zi2LuAa7dqwupM5Xc17opPIjIaUf4QX194FIHlt806ABg9af
        Al7+O3R37OO5j4mZ5efU6OAhzQ==
X-Google-Smtp-Source: AGHT+IG3N9oYTVVpWHCHcenUkG2u+mwOdltu7goVxMyVQmfsCsfNgPExviIbIkYFLeq5xxpYKPwL3Q==
X-Received: by 2002:ac2:5b1b:0:b0:503:60e:91f5 with SMTP id v27-20020ac25b1b000000b00503060e91f5mr14425167lfn.36.1696870961038;
        Mon, 09 Oct 2023 10:02:41 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id r2-20020ac252a2000000b004f1400630d3sm1492618lfm.35.2023.10.09.10.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 10:02:40 -0700 (PDT)
Message-ID: <b0776261-323b-4f3f-a1d7-9a6b59f39276@linaro.org>
Date:   Mon, 9 Oct 2023 20:02:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/5] drm/msm: dpu1: vbif: add
 dpu_vbif_setup_clk_force_ctrl() helper
Content-Language: en-GB
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-0-806c0dee4e43@linaro.org>
 <20231009-topic-sm8550-graphics-sspp-split-clk-v1-3-806c0dee4e43@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-3-806c0dee4e43@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2023 19:36, Neil Armstrong wrote:
> Move the actual call to the MDP setup_clk_force_ctrl() op to
> an helper which will call the correct op depending on the caps.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

