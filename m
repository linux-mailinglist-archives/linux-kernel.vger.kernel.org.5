Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AB4793DC5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbjIFNei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjIFNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:34:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E50410D7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:34:33 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so210051366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 06:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694007272; x=1694612072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUvSvKUaI9jM7APVyUfAw53E9ZhyDpJtbSHLwdTGqM8=;
        b=l/cCpz4oFGpGYiRgSD2cKZwFltpj/Ame8thJsY5UzmP2fiLRPQu9uLdFL+yV32b6NB
         J98i4xxn4eBXD/wHgagujTBqGGaT7M6qtNiKLEcxyFYZdPbPZCk+VFkK1UXP2Bns2w6F
         HGU22RsQ2sMpbBNIDO+pEyI/usVMvfpXYU/x5nWbqYiTVvtf+KlM5SQD1QY9WCAEkMg0
         0SnRpvEsAm3i9xk9kjMbUuR5inM6KsVTU2hBDbQH2bO3Z1SpkRshaLi4sv2U5OXJoSS1
         hy/BcPjjrM37Qt1BeFSwn1M3WgN6OaylYADxNviYIJgKBHa8tC8dmhgcTQRLf+zh2Jnm
         523Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007272; x=1694612072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUvSvKUaI9jM7APVyUfAw53E9ZhyDpJtbSHLwdTGqM8=;
        b=QHrXM5pLfrweciiEjVQy2bkPIIQ5KDXOqFpyBbKjYX1johnjah7c6Wlfz8qHPGP5Ok
         pdUsVapG0TCuqlTDxgARTB0pfaJGi22TqA8aZNJ7Mt2domvGAdetB5GURPZMxCtFwQlQ
         JEJXNas5jKJMhf5Bdyq41Y5a60RQPbSeaLsBOG/d+qvuqqdP9D1P4D5lhUy/DET9uh8H
         JTCDRjZo+f9+EG9wS3zjAJIq+G/tVX28DarrfnXpHJP191ThwCtSEhQceV/goxka7VtL
         68q5CLWMBF9fJsn2gLPBNqZpRRSM9TMWuHIdLoC8mYFvDZAAXVrpPIqRGnUTlbG/Xn2d
         0rhg==
X-Gm-Message-State: AOJu0YzXSSq1toIxoBeQjxsLYRKEcXUKfI1L0AjJvSR7mo1acqP/d0BU
        c21nwau3xlEO1nqRrBnqZtZtxA==
X-Google-Smtp-Source: AGHT+IH0ewRIkYKg0go+8hBWldfPMNlrRyX/G/TxBFdICsMBmJS+8NZ3XjbC8n+zTti1vGaHWz2XGg==
X-Received: by 2002:a17:906:3003:b0:9a1:eb4f:56f with SMTP id 3-20020a170906300300b009a1eb4f056fmr3273088ejz.13.1694007271951;
        Wed, 06 Sep 2023 06:34:31 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id p26-20020a1709060e9a00b0099cfd0b2437sm9070145ejf.99.2023.09.06.06.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 06:34:31 -0700 (PDT)
Message-ID: <04bf71a9-cfa6-60c1-ecbb-c8e2865d8d15@linaro.org>
Date:   Wed, 6 Sep 2023 15:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/4] dt-bindings: remoteproc: qcom: sc7180-pas: Add
 ADSP compatible
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230905-sc7180-adsp-rproc-v2-0-8ab7f299600a@trvn.ru>
 <20230905-sc7180-adsp-rproc-v2-1-8ab7f299600a@trvn.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230905-sc7180-adsp-rproc-v2-1-8ab7f299600a@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 12:41, Nikita Travkin wrote:
> SC7180 has an ADSP remoteproc. Add it's compatible to the bindings and
> refactor the schema conditionals to fit the ADSP.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
> v2: Refactor similar to qcom,sm8150-pas.yaml
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

