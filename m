Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3F77D8A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjJZV1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjJZV1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:27:18 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88379C0;
        Thu, 26 Oct 2023 14:27:13 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ce37d0f13fso869049a34.2;
        Thu, 26 Oct 2023 14:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698355633; x=1698960433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJctg3LQ2Eqx4PP4m5UAVdEfjTJu7QkiGWMGElnVHXA=;
        b=u0ALcd5zVWZ3FuabKpMNh6mYw4uby40C9FRbGsR9AbVqueY/ZdpjCvVEoJV1kjsBx9
         3LEbF+1d1uZQJKHE9k/IOS/+eJooSmTL3wKVL0fTllFOkRhYEMzgSU3cPCcE5Vpr8Vdi
         JLmprlXl29JpCwGWn+DsaV4/ygfql48xp6Bvbr5h248nbOfIITiTZV3QV3HavrO9he3f
         REcVlRqoy9iSESKJwpVTMALYl4YX/SqGDH3/CcU0ZlgS8s4LVsRb5p5sSLVslPwCEbPA
         f3fRkqPr2YoaIlTax9K1YCwHz3Z5JSNMSt4MHLXtoymExEVIrXl8Hur4PhUQg3OKDpxl
         pgVg==
X-Gm-Message-State: AOJu0Yxh8QITsvGqpmAW0BRCrb50v0ejQPHLfHza2KodCX/plUCQbKjG
        5J8XrtO+9ZrePoDyJ54tKQ==
X-Google-Smtp-Source: AGHT+IEav6DIFhEOc38NhC5CPrbd6AgbnqMagRfq9SSxqrYaBAWgSErUdp0crmeHFX+XrbyjufjmxQ==
X-Received: by 2002:a05:6830:348c:b0:6b5:ee8f:73af with SMTP id c12-20020a056830348c00b006b5ee8f73afmr889517otu.5.1698355632833;
        Thu, 26 Oct 2023 14:27:12 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j5-20020a056830270500b006ce46212341sm20236otu.54.2023.10.26.14.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 14:27:12 -0700 (PDT)
Received: (nullmailer pid 426191 invoked by uid 1000);
        Thu, 26 Oct 2023 21:27:10 -0000
Date:   Thu, 26 Oct 2023 16:27:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
Subject: Re: [PATCH v2 7/8] dt-bindings: arm: Add support for TPDM CMB MSR
 register
Message-ID: <20231026212710.GA424453-robh@kernel.org>
References: <1698202408-14608-1-git-send-email-quic_taozha@quicinc.com>
 <1698202408-14608-8-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698202408-14608-8-git-send-email-quic_taozha@quicinc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 10:53:27AM +0800, Tao Zhang wrote:
> Add property "qcom,cmb_msr_num" to support CMB MSR(mux select register)
> for TPDM. It specifies the number of CMB MSR registers supported by
> the TDPM.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> index f9a2025..a586b80a 100644
> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> @@ -69,6 +69,15 @@ properties:
>      minimum: 0
>      maximum: 32
>  
> +  qcom,cmb-msrs-num:
> +    description:
> +      Specifies the number of CMB MSR(mux select register) registers supported
> +      by the monitor. If this property is not configured or set to 0, it means
> +      this TPDM doesn't support CMB MSR.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 32

default: 0

> +
>    clocks:
>      maxItems: 1
>  
> @@ -124,6 +133,7 @@ examples:
>        reg-names = "tpdm-base";
>  
>        qcom,cmb-element-size = /bits/ 8 <64>;
> +      qcom,cmb-msrs-num = <32>;
>  
>        clocks = <&aoss_qmp>;
>        clock-names = "apb_pclk";
> -- 
> 2.7.4
> 
