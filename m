Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D05380AE6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjLHU50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjLHU5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:57:23 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31DA19A3;
        Fri,  8 Dec 2023 12:57:29 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59067f03282so1211074eaf.0;
        Fri, 08 Dec 2023 12:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069049; x=1702673849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TSDtl0Azz5luMxLKhKarHWK73BgADkXXtwNxYA4KqY=;
        b=XmokS0XHcfclfPkzEX/m1js6yw5XkhMqT2Rym6xaqQs7NOYes6s/JiytU9tQdS2pS3
         nlgF8ScUbhqrIcffKgGDHZkdQ9Wf1ZhJIDgparo17jEjpqbx+DILZamm9K9/UQcoInPq
         HOiv7RqFgnqxm83tUeBHn8ChNH3AU77V3+CZ2FMrfDadgoREuoGprfoA+2BAXQbfjenf
         3wSyrAvthBDSzrMGS+udImvC1oAUtSCFVNlHypD1ObFQGV++AA6GqmGJ4yCj9/Mvw404
         cBN08Cwrhoo0jBnPH3LydUyIEUYr82fHIr+ombU6G4Rp0X0Ci7/fcphz8WgQnG+C1d/r
         GcGw==
X-Gm-Message-State: AOJu0YxKjH6nIwXcH6QM7p5yQKSnfJDNK75NDpaGpttxBD816qygvqxE
        MOQa0s6AsJFFHvXrP6f4rxuPhZgYDQ==
X-Google-Smtp-Source: AGHT+IFmv/dETYAqauSH9FMzc+KMrJOlH+2gYt6To1vKoCoyRIKhyBjKXuGe47gKz4+6EbH+iLHaqA==
X-Received: by 2002:a05:6820:1ca5:b0:590:78ca:496c with SMTP id ct37-20020a0568201ca500b0059078ca496cmr828259oob.7.1702069048972;
        Fri, 08 Dec 2023 12:57:28 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z18-20020a4a3052000000b0058ab906ae38sm453010ooz.2.2023.12.08.12.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:57:28 -0800 (PST)
Received: (nullmailer pid 2689518 invoked by uid 1000);
        Fri, 08 Dec 2023 20:57:27 -0000
Date:   Fri, 8 Dec 2023 14:57:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: PCI: qcom: correct clocks for SM8150
Message-ID: <170206904677.2689479.1976529270820866350.robh@kernel.org>
References: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>
 <20231208105155.36097-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208105155.36097-3-krzysztof.kozlowski@linaro.org>
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


On Fri, 08 Dec 2023 11:51:54 +0100, Krzysztof Kozlowski wrote:
> PCI node in Qualcomm SM8150 should have exactly 8 clocks, including the
> ref clock.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Please take the patch via PCI tree.
> 
> Changes in v3:
> 1. New patch: Split from sc8180x change.
> 2. Add refclk as explained here:
>    https://lore.kernel.org/all/20231121065440.GB3315@thinkpad/
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

