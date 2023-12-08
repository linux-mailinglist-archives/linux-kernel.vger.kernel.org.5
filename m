Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6878280AE08
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574725AbjLHUhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjLHUg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:36:58 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804A91700;
        Fri,  8 Dec 2023 12:37:05 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-590a2a963baso231674eaf.2;
        Fri, 08 Dec 2023 12:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702067825; x=1702672625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtLCjRr60799H2MKwM/QzmmaJzcd7IJTQn1+Afg4EXM=;
        b=UC7Ngmp/efhZqTJKByfX8S9EBwQf9lMln2azKAWNMz08GWTl/cA+IhoFsNjIU9uxU2
         fqJPVU5f0Au0VLgIzgmYMGq/mA6F4LF485cLyVYQp0i2uTprY6L/gjyGAO/yVQqdillD
         3Ob/S0APmBKTSZAcNfHGwsoGuTxlfodrH81pyyntMTgKLYxAaW1pT6WmzHxAlWIyi3qH
         JgiafG8b1Qctt+GFPty3fHCoPn4Vkoh2Biea05pIldySD3a6HUUbXU0WFQPGX3Xs4ps2
         bEgQ8qWy/4MQFicwkDtOCzqQson8wpFcpPGsH/2qG0f47wq/uK/7nIRvnDZtkxcsDT0z
         /9GA==
X-Gm-Message-State: AOJu0Yy0V28QNLgklgTbse/zWbnat4oAHgGneKWF3s1P/kqh65ihenqf
        /Rr2wL3XmCeqRSdrnW+UyQ==
X-Google-Smtp-Source: AGHT+IF6nHBrpdI9PdRJ4tPrY8/hF9C+fJyV7AZgkGumgP+nDJ+h9st1ng57n985M8whf2xhzvAPCg==
X-Received: by 2002:a05:6820:556:b0:58d:d525:6b68 with SMTP id n22-20020a056820055600b0058dd5256b68mr1039807ooj.7.1702067824630;
        Fri, 08 Dec 2023 12:37:04 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n27-20020a4a345b000000b0057e88d4f8aesm440586oof.27.2023.12.08.12.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:37:03 -0800 (PST)
Received: (nullmailer pid 2661606 invoked by uid 1000);
        Fri, 08 Dec 2023 20:37:02 -0000
Date:   Fri, 8 Dec 2023 14:37:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, kernel@quicinc.com,
        linux-stm32@st-md-mailman.stormreply.com,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jose Abreu <joabreu@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: qcom,ethqos: add
 binding doc for safety IRQ for sa8775p
Message-ID: <170206782161.2661547.16311911491075108498.robh@kernel.org>
References: <cover.1701939695.git.quic_jsuraj@quicinc.com>
 <87bdedf3c752d339bf7f45a631aa8d5bf5d07763.1701939695.git.quic_jsuraj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bdedf3c752d339bf7f45a631aa8d5bf5d07763.1701939695.git.quic_jsuraj@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 07 Dec 2023 14:51:25 +0530, Suraj Jaiswal wrote:
> Add binding doc for safety IRQ. The safety IRQ will be
> triggered for ECC, DPP, FSM error.
> 
> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
> ---
>  Documentation/devicetree/bindings/net/qcom,ethqos.yaml | 9 ++++++---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml  | 6 ++++--
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

