Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D1A7D8A56
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344880AbjJZVaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjJZVaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:30:07 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54824C1;
        Thu, 26 Oct 2023 14:30:03 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b2b1af09c5so863505b6e.0;
        Thu, 26 Oct 2023 14:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698355802; x=1698960602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYfiY1nKxAZsWF0F5VbhPVavKMf0vI1AMRg29BMV6/o=;
        b=vYp6oCa7kJwp47uVA96KastJBHeEJXmDfjuZQ6+EleB96K2jtqbuj4OCPNpwqTUWyu
         ZLl27KrikYzmK4J34hhrCv9Y/Qt8jCXIK3DsISfDVr3A+V35PBOJyuIqXqM+IWYRGJDd
         laSBzURzsKMNGf+xQskMfX3hueiETjjOj0tlLaLKvLoDfBwZnEV+QsgrSDb9yV+AD5Ry
         ICIABOnHyfJHHSzTxtsPfiuz19SB0fiOJzz11MzMDJ9i7bKSFfjbexCtrYfoEwV2qEFN
         gfURQRWH2y4VZhWY3AlDwo0eBUb3m0bn4cjY8NGnkdBv28FWxd+zXU0Y5UTvJBIRFs8C
         PA+w==
X-Gm-Message-State: AOJu0YzV5xMV+NUZvH3bSsbfqg3PrBX3cF8gu6PNXdAPEXJ+7W5X08J0
        7tzRDgi9ihL7pG67/9TcSl/GtKA95g==
X-Google-Smtp-Source: AGHT+IG4Sy6ttAIaRVwypnCE68UBTkUQVlvszJ3K8Ac4GKgmT5UBMIHItk50OcdmeUVBv1HdnCHdmw==
X-Received: by 2002:aca:1b0d:0:b0:3a7:52b9:cbfe with SMTP id b13-20020aca1b0d000000b003a752b9cbfemr666503oib.32.1698355802562;
        Thu, 26 Oct 2023 14:30:02 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z1-20020a056808064100b003ae31900048sm36618oih.44.2023.10.26.14.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 14:30:01 -0700 (PDT)
Received: (nullmailer pid 430850 invoked by uid 1000);
        Thu, 26 Oct 2023 21:30:00 -0000
Date:   Thu, 26 Oct 2023 16:30:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: crypto: qcom-qce: document the SM8650
 crypto engine
Message-ID: <169835580052.430788.9870147580422013118.robh@kernel.org>
References: <20231025-topic-sm8650-upstream-bindings-qce-v1-1-7e30dba20dbf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-qce-v1-1-7e30dba20dbf@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Oct 2023 09:28:22 +0200, Neil Armstrong wrote:
> Document the crypto engine on the SM8650 Platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
> ---
>  Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

