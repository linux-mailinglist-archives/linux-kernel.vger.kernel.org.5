Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD680AE6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbjLHU4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjLHU4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:56:52 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0FD198A;
        Fri,  8 Dec 2023 12:56:58 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5906e03a7a4so1172595eaf.1;
        Fri, 08 Dec 2023 12:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069018; x=1702673818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TI/RqiqFvfwN3vDT0QkLa8LwHknIXwgijnfQShjrLJw=;
        b=E/AueIah6En4PnfS4BFY9xAh84KmKXrPrRYcs5J77Gp1C6rhoXlp5dRPlHHmBVstE5
         cz5xEP9PD2rdHIkLl1siZZF6kP0RwKsxPknvxtS/DiRGhmhEriYToyC6WbNpIv3JWT6h
         8xdZbHScbpPY0TKDKdIYNI3i+fFCNLPDrczcevmhXzezQVt48IsYeTXpBnFoUJ1fJukT
         6Bp32hGcMHJJZgZlwdClP5eLtg/GBDr7EobHV4ZYDfTtDIV29rok+NV26DxQwAZDqAev
         yQvPe/4kIYq0LHsaiFrIKzlOf6J6NX2cW2CFwCa3+3w+ESNwEPo6CgDlzqIzVF2zeQDr
         BIjA==
X-Gm-Message-State: AOJu0Yw0JkbL09w+tfPMDDWu24k89VWg+71YXQI4I5eggR75IGfiO5Le
        mBAKrZSar6NNLnLwXQlYFg==
X-Google-Smtp-Source: AGHT+IE+6K/3z/2u70S9BVpba++VIOXFUksuND4b533lXO0ykh5exfWRZHFXoGNaaWjNPyZNwFb41A==
X-Received: by 2002:a05:6820:16a2:b0:590:7b3d:dbcf with SMTP id bc34-20020a05682016a200b005907b3ddbcfmr813210oob.5.1702069017743;
        Fri, 08 Dec 2023 12:56:57 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t9-20020a4a7609000000b0058d76e8ce0dsm444188ooc.36.2023.12.08.12.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:56:57 -0800 (PST)
Received: (nullmailer pid 2688740 invoked by uid 1000);
        Fri, 08 Dec 2023 20:56:56 -0000
Date:   Fri, 8 Dec 2023 14:56:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: qcom: correct clocks for SC8180x
Message-ID: <170206901570.2688701.11999628972316181537.robh@kernel.org>
References: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>
 <20231208105155.36097-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208105155.36097-2-krzysztof.kozlowski@linaro.org>
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


On Fri, 08 Dec 2023 11:51:53 +0100, Krzysztof Kozlowski wrote:
> PCI node in Qualcomm SC8180x DTS has 8 clocks:
> 
>   sc8180x-primus.dtb: pci@1c00000: 'oneOf' conditional failed, one must be fixed:
>     ['pipe', 'aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'ref', 'tbu'] is too short
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Please take the patch via PCI tree.
> 
> Changes in v3:
> 1. Split from sm8150 change. Due to split/changes around sm8150, drop
>    Mani's Rb tag.
> 2. Drop unneeded oneOf for clocks.
> 
> Changes in v2:
> 1. Add Acs/Rb.
> 2. Correct error message for sm8150.
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 28 ++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

