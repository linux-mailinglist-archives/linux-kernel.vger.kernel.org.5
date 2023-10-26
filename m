Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7AB7D8A39
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344732AbjJZVZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZVZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:25:51 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CF710E;
        Thu, 26 Oct 2023 14:25:49 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-581fb6f53fcso819460eaf.2;
        Thu, 26 Oct 2023 14:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698355549; x=1698960349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUGBh/P34kDvbMPaTOm6+jeZny2Y+EPf+Q7R754U1ys=;
        b=ShiXnHecBmAyFKBzu1cKPCm6MxCRFzDcp6C8mIlrH6Jpn8BHxj9oJ4KW6FiRAoPyxh
         m5T24wh3/JU6oP5miVAy3bvUpK1kSmdPqh0/WlswoPjCdpVbisagZAC2zYjbWja1haMk
         i3CUH5D5bh1zqyIORB5wVI9Betk/oqrnI1/+4kKMsQZQ0mK+VPgFpLdSZgbWxaPDF3Em
         faFQtJZ4ZFqTXlkZUZTgSo/0zeHucg6UOz9mtXtEVqK+bCv1+RKhaKFtWuSAPBVJybkX
         El7e6JDfwzurvNBodMWyhQBdh+LZ5XJYNK7HR5W9SzEzQ8rBrF+zmkK0225T+/UIE8FE
         UDaQ==
X-Gm-Message-State: AOJu0YxpEjHyeWgqZ9vKSm/aKvy2CFfGNIq/PixQjR78QP6AgHhKkpjo
        on5gLOMEFToaqcZmPnSYww==
X-Google-Smtp-Source: AGHT+IHI1iTcIMvhAjZtXr+zeyPnQQsygc6IP8SozeSeE2ot7xjwoS8aHA4+TLWUl4d6uk2xLReD9Q==
X-Received: by 2002:a4a:e1d4:0:b0:581:e819:cac5 with SMTP id n20-20020a4ae1d4000000b00581e819cac5mr675502oot.9.1698355548774;
        Thu, 26 Oct 2023 14:25:48 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v18-20020a05683018d200b006b9cc67386fsm18867ote.66.2023.10.26.14.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 14:25:48 -0700 (PDT)
Received: (nullmailer pid 424302 invoked by uid 1000);
        Thu, 26 Oct 2023 21:25:46 -0000
Date:   Thu, 26 Oct 2023 16:25:46 -0500
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
Subject: Re: [PATCH v2 1/8] dt-bindings: arm: Add support for CMB element size
Message-ID: <20231026212546.GA420866-robh@kernel.org>
References: <1698202408-14608-1-git-send-email-quic_taozha@quicinc.com>
 <1698202408-14608-2-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698202408-14608-2-git-send-email-quic_taozha@quicinc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 10:53:21AM +0800, Tao Zhang wrote:
> Add property "qcom,cmb-elem-size" to support CMB(Continuous
> Multi-Bit) element for TPDM. The associated aggregator will read
> this size before it is enabled. CMB element size currently only
> supports 32-bit and 64-bit.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/qcom,coresight-tpdm.yaml          | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> index 61ddc3b..f9a2025 100644
> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> @@ -52,6 +52,14 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint8
>      enum: [32, 64]
>  
> +  qcom,cmb-element-size:

What are the units? Use '-bits' suffix.

> +    description:
> +      Specifies the CMB(Continuous Multi-Bit) element size supported by
> +      the monitor. The associated aggregator will read this size before it
> +      is enabled. CMB element size currently only supports 32-bit and 64-bit.

The enum says 8-bit is supported.

> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    enum: [8, 32, 64]
> +
>    qcom,dsb-msrs-num:
>      description:
>        Specifies the number of DSB(Discrete Single Bit) MSR(mux select register)
> @@ -110,4 +118,23 @@ examples:
>        };
>      };
>  
> +    tpdm@6c29000 {
> +      compatible = "qcom,coresight-tpdm", "arm,primecell";
> +      reg = <0x06c29000 0x1000>;
> +      reg-names = "tpdm-base";
> +
> +      qcom,cmb-element-size = /bits/ 8 <64>;
> +
> +      clocks = <&aoss_qmp>;
> +      clock-names = "apb_pclk";
> +
> +      out-ports {
> +        port {
> +          tpdm_ipcc_out_funnel_center: endpoint {
> +            remote-endpoint =
> +              <&funnel_center_in_tpdm_ipcc>;
> +          };
> +        };
> +      };
> +    };
>  ...
> -- 
> 2.7.4
> 
