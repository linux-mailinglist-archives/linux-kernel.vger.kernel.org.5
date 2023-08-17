Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92A1780177
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355966AbjHQXDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355979AbjHQXDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:03:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF7335A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:03:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ff9121fd29so377874e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692313390; x=1692918190;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KohSaVbVTZzw51hU080rc6/yBBZBjNRiH2rTqSdtLwA=;
        b=Fof3Acoia7VG4nhAUoI/nfrGuonJnuAOuLTuxr4ifWkBep3jTwsZKCvWMSh4AvndpG
         trV6p3y5uWJ0aEKg9s8EiJORJ/EP4s69g424Jk97fDuHlZqb2n45XmAfy9vurcT0weSh
         G5lrDhwTny3/mdaReAoSN8pWdxsEFbm9/lWAx6F8CmYOatCY8DzUODWaCHADNiNRblNJ
         RxPAVA8I8QwkTdzrQvhhHOWp9RSjkC9SUVJCFaDo5rfzgiSzWYdoulQkQPfhUwKqwGeX
         fe5jNLQUkCBMNIMlJ1IFYlS8vlIZf+zofWZMXZHsR/9e1KPOPcJwbiuu3wJicckDIN8U
         889Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692313390; x=1692918190;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KohSaVbVTZzw51hU080rc6/yBBZBjNRiH2rTqSdtLwA=;
        b=Jlx8EZp9vTyk0lWKvhw3QBvmR8YWIbpq3QPuL5GQyQ5tTvD0jZqjCr8oTvRD3wg9z9
         OG8p3cPyXxXKnAJYlsxWXqjJ+41VtMv+l69QqdglvvE8TT6IG7po/mPB8WP+kCw7EMyS
         13XMmTyRAIF+r5f/kF/cZXcWeITxW8S8AmSBxBZKWDb500w4PbrzO+hDwVXe53adwIKG
         yMb+5FuFdvKwYKpuWZWMt1p+cxe/jehgy5BmO+AR/IydwNnPyGv2fVr1mN/qrsz08yhg
         XCVWP2H15NLXTj8t/WZ+F9p+Fj1x8mc/oMz5p0QT9rMVnp0sVycc/1kdIx5etIWNWzkg
         gBhw==
X-Gm-Message-State: AOJu0Yx0YEYBPM3RlSV0Vz1RQU/zvgS/bVwy4v557HX+p5a6hA2HychY
        jMPaatL6IFfUh2jIBerqkbBZ8Q==
X-Google-Smtp-Source: AGHT+IEsPKiYiAI9yScvyF/DuR+/ExSEEAU+QEx8uhb/3wDAjFfUrvIb5f02SKlt45rVQZXgly+RRg==
X-Received: by 2002:a05:6512:324d:b0:4ff:9aaa:6e3e with SMTP id c13-20020a056512324d00b004ff9aaa6e3emr441535lfr.41.1692313390043;
        Thu, 17 Aug 2023 16:03:10 -0700 (PDT)
Received: from [192.168.1.101] (abxh52.neoplus.adsl.tpnet.pl. [83.9.1.52])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004fa52552c7csm84540lfi.151.2023.08.17.16.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 16:03:09 -0700 (PDT)
Message-ID: <662c9de8-6298-4eb0-ae84-d0cb4ea34a17@linaro.org>
Date:   Fri, 18 Aug 2023 01:03:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sa8775p-ride: Describe sgmii_phy1
 irq
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>, andersson@kernel.org
Cc:     agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@bgdev.pl
References: <20230817213815.638189-1-ahalaney@redhat.com>
 <20230817213815.638189-3-ahalaney@redhat.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230817213815.638189-3-ahalaney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.2023 23:37, Andrew Halaney wrote:
> There's an irq hooked up, so let's describe it.
> 
> Prior to commit 9757300d2750
> ("pinctrl: qcom: Add intr_target_width field to support increased number of interrupt targets")
> one would not see the IRQ fire, despite some (invasive) debugging
> showing that the GPIO was in fact asserted, resulting in the interface
> staying down.
> 
> Now that the IRQ is properly routed we can describe it.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
