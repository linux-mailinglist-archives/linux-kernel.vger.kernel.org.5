Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EFF762D83
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjGZH3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjGZH2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:28:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129492684
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:27:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so4293137a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690356467; x=1690961267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BWEre0pLcOLYcd4FD5EnL9dsQ10qbvUWSP37/zR61D0=;
        b=y1y4UoR49VvO/j/vrmNwbquCfSyLDlgw3j9InOuwgigjZpxTDRdXipG5bYoZyd3opy
         xpSLGavxsiWFni8Z2JjG0cXg27Y58zhTRMD2R5HfHDZGXCvrsyAMRu/TrI+uaB4SQJK1
         A1a/wiZcZYJsXfKdG9kaGpGpfTyKOQlnANSr4QOpNHaZvJG7CuMpiStJi/5JKxf3F3K7
         2Yx5T8Mkz9UNra3VOzryRtiIM0jyEfrlHS+Ya9aHYX/9loaWUFt1+ARCRiWyn6NbVr/x
         Hnp97I11lJZMkQgwn/AhEszY1COsbYlN7H/OBzYLPCtvrhCIB8f/yaSAyztTrCWuUKoq
         uFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690356467; x=1690961267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWEre0pLcOLYcd4FD5EnL9dsQ10qbvUWSP37/zR61D0=;
        b=jsm2HgCyeBLJuVh3pfT0vfvsM85Tvv6KWtTUzhH4xacpOjpQLorb9VLrn2fnfiMeG7
         PLQeq4J66FzrvHkCDWquSxggfPgbY3JNukvGi7xFGHtZ4nCxo5HFrZMlOsgAotzQiTsI
         Me1EvVIlOSybO2Clknj0EGr2vfy90XwEt1/560urBro+ONZGQtM17opPkDIGUbBhqSdy
         zlOqcWIcJ6C2qpPcvndfAk+iKJexWKjGNjKF2FoEgLu3S2aGJRzXl//g/ON1OljyHaO2
         8DBnxuHwEIntKDmYG/wzsoG9EcZMKk8Jg0/Jfip/aO2ucNVtRmWKksDv+u61/RzT1RyD
         nFKw==
X-Gm-Message-State: ABy/qLYZdZ4ileNlN0eCDclZChIQH7vfI2RyryyLiaiV8Qai4azyZxlQ
        T3+NLo8fYgxNgjk3woY6BYqtBQ==
X-Google-Smtp-Source: APBJJlHaQ6NqQh4t7ZcAf3OfzxoJXhkRZpG1HFLke+5OkK90xm5aTlP0C8KtPZf532soYkXSt4uFIw==
X-Received: by 2002:aa7:d7d0:0:b0:51d:e1cf:dc8a with SMTP id e16-20020aa7d7d0000000b0051de1cfdc8amr918375eds.22.1690356467436;
        Wed, 26 Jul 2023 00:27:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id v12-20020a056402184c00b005224d960e66sm1711008edy.96.2023.07.26.00.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 00:27:46 -0700 (PDT)
Message-ID: <11eca956-9e91-f645-9cc7-4c9f534d9821@linaro.org>
Date:   Wed, 26 Jul 2023 09:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: display: msm: sm6125-mdss: drop unneeded
 status from examples
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230725101610.75122-1-krzysztof.kozlowski@linaro.org>
 <5w2hvzmwzqm4ffopzewveaviebq2ig7awimeo6ipcehx5a43ae@mlwffkf2ctn5>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5w2hvzmwzqm4ffopzewveaviebq2ig7awimeo6ipcehx5a43ae@mlwffkf2ctn5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 13:46, Marijn Suijten wrote:
> On 2023-07-25 12:16:10, Krzysztof Kozlowski wrote:
>> Example DTS should not have 'status' property.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml   | 6 ------
> 
> This is not needed: it has already been corrected in v3 and v4 of the
> respective series (among other changes) and the patches were only picked
> to a preliminary (draft) pull to get an overview of the outstanding work
> for this subsystem.  That branch happens to be included in regular -next
> releases though.
> 
> 6.6 drm/msm display pull: https://gitlab.freedesktop.org/drm/msm/-/merge_requests/69
> v3: https://lore.kernel.org/linux-arm-msm/20230718-sm6125-dpu-v3-0-6c5a56e99820@somainline.org/
> v4: https://lore.kernel.org/linux-arm-msm/20230723-sm6125-dpu-v4-0-a3f287dd6c07@somainline.org/

What do you mean? The old code (one I am fixing) is in current next...

If this was fixed, why next gets some outdated branches of drm next?
Each maintainers next tree is supposed to be fed into the next, without
delays.

Best regards,
Krzysztof

