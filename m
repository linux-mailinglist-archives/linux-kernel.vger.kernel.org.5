Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1336E80ADC8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574703AbjLHUZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHUZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:25:36 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A3A10D;
        Fri,  8 Dec 2023 12:25:42 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b844357f7cso1820024b6e.1;
        Fri, 08 Dec 2023 12:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702067142; x=1702671942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0IasXQvJWdqGOSJT9mbD+TBCwZWsYzoBaQM5NAJ5Vk=;
        b=maZEwoXKaplx4RioXH3M/bFF8vuBD1Hex4eonFmbDPKTatoxu4sErLv6TtUT8lvQts
         8SvhIp81Mr6rAtOI9vNl3PPsPVQJV5LFPLwWP4nR4PBkM1ukbJKConA7Bjo1PK3fC1bf
         oeFl4YMP7nefsoZGVMLf2wgIFcJnLM9CdFoJroXD3hqvwZ9n19mfz1wGJUwiUhcYQcUV
         ukvwg0Na/695HBuOCUjnDXx2GWFgAIbpfFTwbFr2hJa1K8Y+zY5GyhcTetnefMXo5kS8
         2D+wLMGDpWYeh8Ev0zo52RDKPs5XplbncpDb/G6ECrUmGK5NnmE5h6dE04UrDQ/E9PzG
         jhPw==
X-Gm-Message-State: AOJu0YxPIuUy4Jh+YHsZSuZgdNTMoh451q/IDfZIHLU76Jcb+NsItrW0
        Y+jVIj5IRZhtWZfATHzbog==
X-Google-Smtp-Source: AGHT+IFjHxqoIzR0RbuwiW28r+05JTaViqeBRKZvgBhK0CJ8WntAGX4XOSvgUidV37wumW/9bax6Bg==
X-Received: by 2002:a05:6808:16a4:b0:3b8:b063:6bae with SMTP id bb36-20020a05680816a400b003b8b0636baemr651068oib.93.1702067142007;
        Fri, 08 Dec 2023 12:25:42 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i26-20020a54409a000000b003b2e2d134a5sm467888oii.35.2023.12.08.12.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:25:41 -0800 (PST)
Received: (nullmailer pid 2646256 invoked by uid 1000);
        Fri, 08 Dec 2023 20:25:40 -0000
Date:   Fri, 8 Dec 2023 14:25:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tao Zhang <quic_taozha@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, Hao Zhang <quic_hazha@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        James Clark <james.clark@arm.com>,
        linux-arm-msm@vger.kernel.org, Mike Leach <mike.leach@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, coresight@lists.linaro.org,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: arm: qcom,coresight-tpda: fix
 indentation in the example
Message-ID: <170206713968.2646196.10411372196062019776.robh@kernel.org>
References: <20231206115332.22712-1-krzysztof.kozlowski@linaro.org>
 <20231206115332.22712-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206115332.22712-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 06 Dec 2023 12:53:32 +0100, Krzysztof Kozlowski wrote:
> Fix triple-space indentation to double-space in the example DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/arm/qcom,coresight-tpda.yaml     | 32 +++++++++----------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

