Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A077F075B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjKSQMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjKSQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:12:10 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ADA126;
        Sun, 19 Nov 2023 08:12:06 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d3260385b5so1840376a34.0;
        Sun, 19 Nov 2023 08:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700410326; x=1701015126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEu0nuOXzWy7wH5tn0mHCily9PWBQhKrF+Z00A3ebI8=;
        b=Rjw3yeOJH3eN8J+vBbSzkSHvaVbOQInmZ8jeR764JCByCVe9jRR6q/5eU3lQ9l9qqE
         2JWoc+JmpI9wRL0WplPd03gOMSjIdDvGAvkkCqJsbMiXoLQnNgLwxWq1LsyXG5s2l2Wa
         EAXWOE55KQAwxkbDpN2ymg1wBhjrj96nFZHo8ETGmzcxkXjupaPa1wd5EHYGIWn9+lvk
         9J7MaPO5srhrVo6eMP9o3TVvzXPQ+MfotYAQF5EGTZfieQf/j0GR+XpDMRc0zworwY7D
         V30EJznw5pBYelSdIfsQrsR+rIbuPDBA+lZSgDULbUPzoIfky9ZbNYcnYhrbshn+4cS+
         l6dg==
X-Gm-Message-State: AOJu0YyRb6GdAVu7gSZVN6poCQybysf3cOiANDkJBv4zwXt2XBeENugz
        DM+3laVrI72d4fRJtBbi8Q==
X-Google-Smtp-Source: AGHT+IHGGM8ZAa1lSr23KAzSyTH5dGZQdtx5KG4w1Okx17TDG9eIKkTbs2icl7eKgrEN3ubKijy84A==
X-Received: by 2002:a9d:628b:0:b0:6cd:9f4:e088 with SMTP id x11-20020a9d628b000000b006cd09f4e088mr5199714otk.5.1700410326260;
        Sun, 19 Nov 2023 08:12:06 -0800 (PST)
Received: from herring.priv ([2607:fb90:45e3:889f:15b4:1348:6d64:224b])
        by smtp.gmail.com with ESMTPSA id c3-20020a9d67c3000000b006ce28044207sm893035otn.58.2023.11.19.08.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 08:12:01 -0800 (PST)
Received: (nullmailer pid 276187 invoked by uid 1000);
        Sun, 19 Nov 2023 16:11:56 -0000
Date:   Sun, 19 Nov 2023 10:11:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Wronek <davidwronek@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-phy@lists.infradead.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-scsi@vger.kernel.org,
        hexdump0815@googlemail.com, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Joe Mason <buddyjojo06@outlook.com>,
        cros-qcom-dts-watchers@chromium.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: crypto: ice: Document SC7180 inline
 crypto engine
Message-ID: <170041031632.276154.11804659126094035319.robh@kernel.org>
References: <20231117201720.298422-1-davidwronek@gmail.com>
 <20231117201720.298422-2-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117201720.298422-2-davidwronek@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Nov 2023 21:08:33 +0100, David Wronek wrote:
> Document the compatible used for the inline crypto engine found on
> SC7180.
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
>  .../devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml    | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

