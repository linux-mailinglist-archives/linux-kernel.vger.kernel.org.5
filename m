Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A99801EF2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 23:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjLBWIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 17:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLBWIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 17:08:45 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F498118
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 14:08:51 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9b9191722so44463211fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 14:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701554929; x=1702159729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBnQbPIaKZ1FnI4i+KfUpDsqKQ/SRB/Q4CkBHEZWQ+s=;
        b=uPfywUtFhR8c5xi6/Qgy3ymOSXmuLeeo1+KUvlM8WrITbezBgmVJjSsSL1Kl27rmVD
         RsNIa7VJ0c5YnZ5Cb0era8/aWqAp1kAVuqMcqwizMcnphe39h3JaNNWgLfnOc2aOfif7
         6pjAx7rvbxf9znkLatLkmbKlhepZsCy9IwKUJXPhpykOvKUQBXttzugqApaQbKEnJl9k
         ULAn1wsNS4vzEoLUsMyRrc8l61lQGozs8zly++NBs9bqWR2qkV8a7O08BdHsaNG+CJyg
         6OeAST238gS2573L7tMj+FviEtVvETsqobLj3ax/WiOQ/RtY1sphjaccaYTdvKhyB5R8
         VWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701554929; x=1702159729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBnQbPIaKZ1FnI4i+KfUpDsqKQ/SRB/Q4CkBHEZWQ+s=;
        b=UNVKA64NnSI5sXZB3Sdc+HZsh0/QbPSjdjRXjY7fMYLL2FtIjrMVPHBmzx1cmmpQTb
         nUy1ik7hVx9Gztg/bW64Lp+WFOASKfoz6/dfNCoIiQ1iKW80Sb9RxbNmNs4otTR3PBQu
         fEYiBlcPw5rxK2fwEQgjF/C9+4sOeAG+8QGByCOv77catb0LL/ff8QXZNCICWbHP329T
         B2/iig8xlclyZFtiu9JqPjmY2pDPJWH2TEwW5JblnrmlPS30xkO4XjjIHA0C8dyaDAVj
         yI2d7NXkMwlA/h1NJva4ZxSJHP/8ywbxBFgTHGK6auRZgSVUC3vdCwfOmf3EKxwGUveA
         L91Q==
X-Gm-Message-State: AOJu0YxSqt7h7MBKO7n3uucIoHece8q3MnGQjTBe1QTp/CAfYomkzvKC
        5UqNuHiY6KvvwtR4t8JtR/nhNQ==
X-Google-Smtp-Source: AGHT+IHtNMy5Yq1qJwCjIbPETZ9dRA+AvYabXqW3vd5GCgYQ+Z9Fd/TLncg8J3C2Wr4ROOmIVxmsBA==
X-Received: by 2002:a2e:b0ca:0:b0:2c9:f57f:fcf6 with SMTP id g10-20020a2eb0ca000000b002c9f57ffcf6mr410723ljl.37.1701554929583;
        Sat, 02 Dec 2023 14:08:49 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id p21-20020a2eba15000000b002c9eca858a0sm344305lja.137.2023.12.02.14.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 14:08:49 -0800 (PST)
Message-ID: <124cf6d1-16b8-45e1-997c-24f176f59e20@linaro.org>
Date:   Sun, 3 Dec 2023 00:08:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/gpu: Fix null-pointer dereference in
 zap_shader_load_mdt
Content-Language: en-GB
To:     Kunwu Chan <chentao@kylinos.cn>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        jordan@cosmicpenguin.net, konrad.dybcio@linaro.org
Cc:     kunwu.chan@hotmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20231123033329.27477-1-chentao@kylinos.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231123033329.27477-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 23/11/2023 05:33, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> Fixes: a9e2559c931d ("drm/msm/gpu: Move zap shader loading to adreno")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>   drivers/gpu/drm/msm/adreno/adreno_gpu.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

