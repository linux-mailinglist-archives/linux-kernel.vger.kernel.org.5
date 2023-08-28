Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF278A940
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjH1Jsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjH1Js0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:48:26 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A130103
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:48:20 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so44052521fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693216098; x=1693820898;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKlHsSeuVGTpkMdRS5+LwSEAr5nAZTkLGPaU8OU91kw=;
        b=vrxU9MRTJVI2wEm1w5KY5/AjXquGR/9cwq19GOMM2vAL4TN+chHOVLgl65J+ihKaYd
         cw6fg/G5yyta6HEYoqqiz0a3BsTxT15fKa/D9DeaV3Jnmqoc4ImNvWZR+NjcPXD79WT+
         RZcjAmPIh7Tx2CjVtRc/vX59lJ26PwF/CvNIaUHyM4UFq3jPuCfVtShZvR/rJV/EmYLv
         In7l+lsK32Lbn5T2RauQTaJj2vSxZsXi8nRYCXDv3XCsB6S5zRdosn0J/H1ELmtnCnq0
         Q54ziDSkHKfpKe0/yA46BAllP8kib/Rl/BVagnMVewiCH9opTSibxIVgvmTpFmsQc7V/
         FwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693216098; x=1693820898;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKlHsSeuVGTpkMdRS5+LwSEAr5nAZTkLGPaU8OU91kw=;
        b=PF9qycAKgb/L90KHx+sGPSQIej4Fqy5lzZcbtpWD5nx0nL9TNwV4IgUJFvVj0J0RkM
         LW5xWZ6ZjMygraCMD3+zfO4l7rsCcrGLRQ+pVV9xH5UDw6bMpZTPv23j+VzzTwqg9v0Z
         5eTGk5RvsAvyGJ1MPe/K7PkPiG+VBBPpY9i5MCMGvbF485jqpneQEVXXJ4/VeyU15R/i
         RQGYQ9yg1mt9q2Y2Qm3ZyUGfv1HLe2uWVh1JqGPK+KCJJh6J5FQSDLsUm1evx7eBF4oj
         f7siq80Vq5TNeEKlGG7U2+t12SGYu92IK8RG0I5bxFo3SGzdjARuC7wXpM33mREZyz2/
         X2xw==
X-Gm-Message-State: AOJu0YxQBeJCv2s2ja/z91K7jKgR/KG8orlOPayMzuSt5ahLI7n5tlae
        pWqJeZ1PUXTUTNMDmIU41PdD4w==
X-Google-Smtp-Source: AGHT+IFaYsQ3+vhNlH2eIC8IHFmDnZdOcTcoqkP4FAv7PIMBSDyzbC9UH4Sgw+Mag133BPvkVzGMWA==
X-Received: by 2002:a2e:9b18:0:b0:2bc:db99:1306 with SMTP id u24-20020a2e9b18000000b002bcdb991306mr11760946lji.38.1693216098466;
        Mon, 28 Aug 2023 02:48:18 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id h10-20020a2e900a000000b002ba130e9a29sm1682693ljg.76.2023.08.28.02.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 02:48:18 -0700 (PDT)
Message-ID: <31b528cf-53e3-41f8-921c-691614296da4@linaro.org>
Date:   Mon, 28 Aug 2023 11:48:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7225-fp4: Revert "arm64: dts:
 qcom: sm7225-fairphone-fp4: Add AW8695 haptics"
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Luca Weiss <luca.weiss@fairphone.com>
References: <20230827122842.63741-1-krzysztof.kozlowski@linaro.org>
 <20230827122842.63741-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230827122842.63741-3-krzysztof.kozlowski@linaro.org>
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

On 27.08.2023 14:28, Krzysztof Kozlowski wrote:
> This reverts commit 413821b7777d062b57f8dc66ab088ed390cbc3ec because it
> was never reviewed, was buggy (report from kernel test robot:
> https://lore.kernel.org/all/202204090333.QZXMI2tu-lkp@intel.com/) and
> used undocumented, broken bindings.  Half of the properties in this
> device are questioned, thus adding DTS node causes only errors and does
> not make the device usable without the bindings and driver part:
> 
>   sm7225-fairphone-fp4.dtb: haptics@5a: failed to match any schema with compatible: ['awinic,aw8695']
>   sm7225-fairphone-fp4.dtb: haptics@5a: awinic,tset: b'\x12' is not of type 'object', 'array', 'boolean', 'null'
>   sm7225-fairphone-fp4.dtb: haptics@5a: awinic,r-spare: b'h' is not of type 'object', 'array', 'boolean', 'null'
> 
> Since bindings were abandoned (4 months since review), revert the commit
> to avoid false sense of supporting something which is not supported.
> 
> Cc: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
