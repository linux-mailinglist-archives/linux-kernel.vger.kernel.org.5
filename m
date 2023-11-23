Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487EB7F5F19
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345316AbjKWMgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345318AbjKWMgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:36:41 -0500
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EE31A4;
        Thu, 23 Nov 2023 04:36:48 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-35937f2fadeso2488135ab.2;
        Thu, 23 Nov 2023 04:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700743007; x=1701347807;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JVG1KNeHJ3/qRli7u6E6D3tolaMDNcU5rbGWAgFoWgU=;
        b=FPNi5YOTD4xWldy1LWYytHnyPu3eB/Fn+WWKhT2qnlW+0GaEXg2XsZYx2v+6nnesWh
         VsagWSLdZb4hjYyZpdO60tR29gk4NFiVzQ4IGQxLHvVeKsfe6UoT1bSbHwAnVj2XV0Sn
         AEBAcSJoxqEYuWy5FPyZ+mLNXhbiMKZbZHhoz1Er0OkAPcMDP4jDk+cJR05QoWgfBoqI
         pilHqMokZqCyHq53Py5r2hkdy6uPIpbnrMVoVCI3G8lFBiYswAj8dt3MkaPorUn6Hsxs
         nOKgb73+x2BlTh1pFIAkoIWZPdhmsQVew2Q3cJi472Mih+e1DCRqGq2inf3Dw3cpSgdJ
         T+8Q==
X-Gm-Message-State: AOJu0YxN9mSE8HZKIEMjIok7rGZ3qMbnl8kEtJpgY1W85GDuZy0BhBLu
        5IaaNB0pr/BHh29cesQ3YdyCMISd2Q==
X-Google-Smtp-Source: AGHT+IEafPH9MCVT+IeUUQWmAa4cHPiJx8xmvLFQH0AMy6TyixDtRRrpfnRNcq4x10e9HLwEtQ3bAQ==
X-Received: by 2002:a05:6e02:216d:b0:35a:fa7f:36b with SMTP id s13-20020a056e02216d00b0035afa7f036bmr5583940ilv.9.1700743007574;
        Thu, 23 Nov 2023 04:36:47 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id cn10-20020a056e02388a00b0035b01686da6sm323031ilb.58.2023.11.23.04.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 04:36:46 -0800 (PST)
Received: (nullmailer pid 853092 invoked by uid 1000);
        Thu, 23 Nov 2023 12:36:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        kernel@quicinc.com, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <ff458955a24c0cb4ba41158b8b53fbef00c8237d.1700737841.git.quic_jsuraj@quicinc.com>
References: <cover.1700737841.git.quic_jsuraj@quicinc.com>
 <ff458955a24c0cb4ba41158b8b53fbef00c8237d.1700737841.git.quic_jsuraj@quicinc.com>
Message-Id: <170074300457.853076.1315477036902827786.robh@kernel.org>
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: net: qcom,ethqos: add
 binding doc for fault IRQ for sa8775p
Date:   Thu, 23 Nov 2023 05:36:44 -0700
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Nov 2023 17:23:20 +0530, Suraj Jaiswal wrote:
> Add binding doc for fault IRQ. The fault IRQ will be
> triggered for ECC, DPP, FSM error.
> 
> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
> ---
>  Documentation/devicetree/bindings/net/qcom,ethqos.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/qcom,ethqos.example.dtb: ethernet@7a80000: interrupt-names:2: 'eth_lpi' was expected
	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/qcom,ethqos.example.dtb: ethernet@7a80000: Unevaluated properties are not allowed ('mdio', 'phy-handle', 'phy-mode', 'rx-fifo-depth', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,tso', 'tx-fifo-depth' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ff458955a24c0cb4ba41158b8b53fbef00c8237d.1700737841.git.quic_jsuraj@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

