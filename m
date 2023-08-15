Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4677B77C6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 07:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbjHOFPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 01:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjHOFNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:13:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A79173B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:13:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bccc9ec02so709915666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692076382; x=1692681182;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DNI6rtrYF1Ybq811JJ87vOIIKiYVPsQ25Sx4UjotkVw=;
        b=gbW4SSBK1ojxMblUsK5g499ERe7twiF6LRWgbQHzU/vA1ghtMMCyVjUo2EaWwIoba0
         7zn5k05dEWr1IlsT3WxNxWIYIl4bSPmgbAL81eXgxBLtwA5MfEWRXl9tlBxymFWfSKjY
         WzIep0GDpzuIwGsA9UvKuh/ir+8z3BQycdJmOHjkc2G2GWBm1XeQ46tENcVRQqY4tTX9
         EBSz+f/dRQUKJD/yAtmDFYFZ9XjJEbnft0lhBy8WKkF94Ug5M/bpFvn1aHxUKpn2+ImF
         rkfkoxFJT2NyLQ5ukz3ZzpXvjcjVO1r6GFAPXp042EFaTZIQwEwNHCuE68N1TKHED64P
         2dDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692076382; x=1692681182;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNI6rtrYF1Ybq811JJ87vOIIKiYVPsQ25Sx4UjotkVw=;
        b=WnGMR/+Dovx0q0/BEM9uCS0TOtnkhykSSoSs+Ta/+VnUSwZZT3NqoKTrgbuR7Ph06T
         mYBj4yG31TR46xZCim8IFeQt4gL2zQTI86v+LVEVa8MUM5KLeXXYsmcTuuSo51imv/B6
         Ss+yNo97GoV7JGYEHwO9bbCTjGm8XB2A23uWqUk5LySKOaf1wzPnkRu/2wMz7V1LiRrT
         daQmlOFlDE++DOswxD9C9SANW3wln/qSH8K2ygl2FuS+Gj/8NBbp+OaaE3/dNQKWWWpG
         fv+tTfPx/V2mOGstRZPaQroBzSMBa4+k72OFHiUmp6t16dR8opYXWpSgoqNA6xj92aXL
         H7Dg==
X-Gm-Message-State: AOJu0YyQoS3x3e7Ou/48tqN4ykOlSsqA35BmeuBuqxJINiXYrXh2VgJC
        XJwXk1XwvGYBh4+3YciHLh2TQg==
X-Google-Smtp-Source: AGHT+IHxSgB//CCtVHdyYiVOgZlxJ2NXYIq1D1nSb6b31RyTYQO+cWLsea219E/beqdlubPkigPEGg==
X-Received: by 2002:a17:906:8a6c:b0:99c:a93a:432f with SMTP id hy12-20020a1709068a6c00b0099ca93a432fmr9281673ejc.1.1692076381769;
        Mon, 14 Aug 2023 22:13:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709062dc800b0099b7276235esm6553566eji.93.2023.08.14.22.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 22:13:01 -0700 (PDT)
Message-ID: <808735b6-d7ee-5223-ef6b-8ec5118e95ac@linaro.org>
Date:   Tue, 15 Aug 2023 07:12:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: clock: qcom: ipq4019: add missing
 networking resets
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230814104119.96858-1-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230814104119.96858-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 12:40, Robert Marko wrote:
> Add bindings for the missing networking resets found in IPQ4019 GCC.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  include/dt-bindings/clock/qcom,gcc-ipq4019.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

