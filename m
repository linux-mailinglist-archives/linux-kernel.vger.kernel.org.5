Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1225766710
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjG1I0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjG1IZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:25:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3571A448E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:24:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-992acf67388so248801566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690532675; x=1691137475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6xZMW8v9WDlw5tXvogvREezExsu09Z2EBvflkVtH5j0=;
        b=lvuGezwBo7w6YoCoMR2ywp7hjte4FF8EiqJz0bhyi6O9yeMvQ4Gt0UTRflgv/oq67+
         hiuHmjO8G4Lkzu9WL58EdPdzdRFZnbJcxXDrgo58liQRD3BDtBsdCOG3OVkRQq5Pn0Nb
         iu3y3Yy9XW4pOYzypJ0Jbd96Df63y0WIoUNGEB3onWAp8cX3RvJ3eyJwXCudnqgh23sV
         W+MtsCMgaWDIXP0kw/+5zmrY2EkyEXCg9vZw28AFuQfTyR+k9OkX1DrVHNY0pNueGG2z
         sZHHFaIp2y5UhNP7OtZSZgu8tGCmyifcLUdZICPGhVD7BxfEij6j6Efdinci4cCqIC+1
         uleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690532675; x=1691137475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xZMW8v9WDlw5tXvogvREezExsu09Z2EBvflkVtH5j0=;
        b=MHLu34iS3RHu4ioHw3P/kCa19s72ON2ABhMcpgC/PYNNrv0vmMa6LV7MzGEz977J+i
         aoIszz4lFwkFTV4gcMSBHtQiulAvayjVX/SVlnqH2gDxPjo5c+CPpbarH8b4yM1zPtb7
         VfIwquP8GCeZ9iB0G93Gvw4QcOqUlt9Uzr5l8F15z9/CzQuG7kmf4VTGxNBwrJebPzqy
         GnSgEVjG8gb5BlTW+4kiYd0JBxoFXlB+OnFJutsuZzZhE45huqADzQSuBBAnxv4BJH5u
         TKZsNBpOAobPCrwx4AtNxKgS1OcqxKS6zuJvZT3tQrXYAA+FoOsSlFOgqN127ghCkTLr
         5R8g==
X-Gm-Message-State: ABy/qLbeLT3yjw75h+kFMIuJ8QAs1yu5Q3kum5cR1n7cvXhBzbG5j5N+
        Q1/i8qXlTXvc6VrNtdhxyRrJvg==
X-Google-Smtp-Source: APBJJlEdbpuC1Nw6chKfD8DpvTXtK/jYFNYuoDSG1/AORvF94aI8p6IXkC/PwQhjZ0y2M9Wm+58Y4A==
X-Received: by 2002:a17:907:7611:b0:99b:ddac:d9d9 with SMTP id jx17-20020a170907761100b0099bddacd9d9mr1333134ejc.53.1690532675673;
        Fri, 28 Jul 2023 01:24:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id by24-20020a170906a2d800b00993b381f808sm1760451ejb.38.2023.07.28.01.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 01:24:35 -0700 (PDT)
Message-ID: <65098077-8876-6acb-c3e8-2f582745fe82@linaro.org>
Date:   Fri, 28 Jul 2023 10:24:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 04/11] dt-bindings: clock: qcom: gcc-ipq5332: remove q6
 bring up clock macros
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_eberman@quicinc.com, kvalo@kernel.org,
        loic.poulain@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_varada@quicinc.com
References: <20230728063412.1641856-1-quic_mmanikan@quicinc.com>
 <20230728063412.1641856-5-quic_mmanikan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728063412.1641856-5-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 08:34, Manikanta Mylavarapu wrote:
> In multipd model Q6 firmware takes care of bringup clocks,
> so remove them.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

