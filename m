Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DDC7D1E31
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 18:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjJUQRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 12:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjJUQRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 12:17:39 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58808D65
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 09:17:33 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c16757987fso27152491fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 09:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697905051; x=1698509851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2QCO7vKJdpewvnrGf7uSRM6TlZdVHtky0YfzwG9dgVY=;
        b=pjU9v8Sh/YyZ8em/EcIQCkdxq2+38oY0OIMcZ/DbABHxJpz/lkPlMKWQMfaCjsBurT
         dIiaPd+Ih/j+utE8T6fKkbdWZr80i7w1QsMjuwnuSrvWKQKSx8rnC/ClQE/54oSfA77/
         c1LGbIJ7i1Lanwd8zGVa+vRwQQaVWqyeCFO70Z9bckUWP8+vEIVPKTm6bA4Uu14R1RWN
         oy/qfamM5eCPtMlJ4yGP7hnVXpmXNpvNnloBSAYm7ixbYdlCe+vbnkm2w4J5CuoUaPTs
         XxRZtVEvjYTpE4c4bUEM1qqxyMJihW0Iq1gOfOiQr1VqrrPsFpeCMNjXAcgB/gp7dxLs
         3d6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697905051; x=1698509851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2QCO7vKJdpewvnrGf7uSRM6TlZdVHtky0YfzwG9dgVY=;
        b=qyEMro1dBVgLAtia+crxTNTTv3dmSeJPv9+YwylhAWy0uo5t7viIVP6xStZTMicaqG
         CBXCAYCxXsjm0hTIQxIOAgNmlHF/1iFBrevS85IoP+b8bvFu5Bj7XmS7id5PME2WoidF
         l2hs0U42pddvmHhhl4C2eEAZkQO7l/GYcDaLr/XTKRggAQirsfO9qB91eSqC6hYNYW/e
         8XXUOd8Atf0wForuQoW6Z5fKVuW+fepbsC3rbmBJdjfY1iyfyPamSVcvjIXyUXFWhU7a
         tw25r+V6/sE2yKaL39fSMrl0A5iCrMBqpo6Or3skUJYhxwElIcUT/1/aEl+2pTejb3TS
         78kA==
X-Gm-Message-State: AOJu0YyI83KeAiQdOsQIvWcBNOzqfDCY3pC+mvqH9/lH+FdoIN9hQg+P
        F0E41pc4bPoFXQFJ2buAc006Ew==
X-Google-Smtp-Source: AGHT+IGUX29kGn+O+8jtH1EHnalh5tcVZoDjnw2thl7vfAv7LtObZoQC9rYzurf+iaRF8Wb17E7sig==
X-Received: by 2002:a2e:9210:0:b0:2bf:f7ea:884a with SMTP id k16-20020a2e9210000000b002bff7ea884amr3462294ljg.30.1697905051347;
        Sat, 21 Oct 2023 09:17:31 -0700 (PDT)
Received: from [192.168.1.116] (abyl4.neoplus.adsl.tpnet.pl. [83.9.31.4])
        by smtp.gmail.com with ESMTPSA id h5-20020a05651c124500b002b95eb96ab7sm876376ljh.18.2023.10.21.09.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 09:17:30 -0700 (PDT)
Message-ID: <ae070706-2f0a-4932-b917-b8cc9a59b46e@linaro.org>
Date:   Sat, 21 Oct 2023 18:17:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] sc7180: Add qdsp baked soundcard
To:     Nikita Travkin <nikita@trvn.ru>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     jenneron@postmarketos.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231020-sc7180-qdsp-sndcard-v1-0-157706b7d06f@trvn.ru>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231020-sc7180-qdsp-sndcard-v1-0-157706b7d06f@trvn.ru>
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



On 10/20/23 17:33, Nikita Travkin wrote:
> Some devices, such as Acer Aspire 1, can't use lpass dirrectly, but
> instead must use adsp core to play sound. Since otherwise the hardware
> is, usually, very similar across the devices on the same platform, it
> makes sense to reuse the same boardfile.
> 
> This series refactors the sc7180.c slightly and adds the functions to
> control clocks via adsp instead of controlling the hardware directly.
> 
> Existing google devices should experience no change.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
s/baked/backed, unless it's a nice bread :)

Konrad
