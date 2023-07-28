Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA4766224
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjG1C5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjG1C46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:56:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A12B2135
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 19:56:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bbdc05a93bso9867975ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 19:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690513014; x=1691117814;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ewkP+fmHss4rf5fbUWv/EEGxmt6BbWfLF1hqZGGiplc=;
        b=QFRViFLG4n+6xeUQihXNdibwOjsEggW7wMy5EmI1udqq+jgL8F5EU5b2llFM3FvYSJ
         WrnQjwXdVjwwVcWBuKigXquZFFcakgIE4xcsR4qKGFLciUgYWUxKoMBO01WXMW9SQv9W
         lxpQrEsUpN0M3U71Ynl+ejCb1yFgruqQEKMZo1AiYyWW/NZ4v88wlyoLukM9ijQwGOJM
         uy6TFPz53nUcc8Hg8DkQ4qmer3WegVso9gc7PG31ce0fFG6d/FrJltjVfqUNNjWu2XBM
         lHbSx96ujkMSRfv7tV6WqSEDnaKiy4ZIRNfLeLT4H+ozIeXIoDGIbpze9s5xJqy6fyqo
         S7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690513014; x=1691117814;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewkP+fmHss4rf5fbUWv/EEGxmt6BbWfLF1hqZGGiplc=;
        b=GibqweOmrkWl14X8jNlxXSf9TyWTGpqbCn2XJI0DUx3aGTq/tg+B9RDKfp59rSaPjl
         /HH/3b9+1qpGTMKz7JHQctQqK7H/ZT5YKwCM2yFkMjoirUwfJdq6i2XHUL9Nd69tk3fT
         Vc4d1pRw4AhXkviZpmHyWY5rB/FenpDPLy1x+EHLT/W+7vipHMe6A8IsE5l25uIHupj5
         EnNZU2kDQ4l6tophDwkViLkchDA+0wLMYVyjoa4T6Sdy067xA/NH2fQvXce0K1HbVSvi
         vnD5BM62SdKw6jguJJDL5QlEEefflsiTc4mD0VGOSJ+iDW/0AP7F5taZHwkPcuLAvLjd
         XjmQ==
X-Gm-Message-State: ABy/qLY5Uheq5P4TlETam1Bzx4DuZZzv4KhQPxdRxGe/vpoltf3Dg0tY
        gdE5lh4ZlCvI4exMpDv24NyLZOWNt+2Jlmgy3w==
X-Google-Smtp-Source: APBJJlFxQ90Alx8AU5MexunkvV8ksiaGkHdDV8tqLd3yiYFBexMo7dJ4W53DRJTcP72UwBrWUmm97Q==
X-Received: by 2002:a17:902:db06:b0:1b8:8670:541 with SMTP id m6-20020a170902db0600b001b886700541mr335799plx.25.1690513013775;
        Thu, 27 Jul 2023 19:56:53 -0700 (PDT)
Received: from thinkpad ([2405:201:e002:907b:3cd6:46d1:3de:9a66])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001b9dab0397bsm2349682plq.29.2023.07.27.19.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 19:56:53 -0700 (PDT)
Date:   Fri, 28 Jul 2023 08:26:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v10 0/4] PCI: qcom: ep: Add basic interconnect support
Message-ID: <20230728025648.GC4433@thinkpad>
References: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 12:50:14PM +0530, Krishna chaitanya chundru wrote:
> Add basic support for managing "pcie-mem" interconnect path by setting
> a low constraint before enabling clocks and updating it after the link
> is up based on link speed and width the device got enumerated.
> 

Krzysztof, can this series be merged for 6.6? Bjorn A will pick the dts patches.

- Mani

> changes from v9:
> 	- addressed the comments by mani.
> changes from v8:
>         - Added cpu to pcie path in dtsi and in dtsi binding.
> changes from v7:
>         - setting icc bw to '0' in disable resources as suggested by mani.
> changes from v6:
>         - addressed the comments as suggested by mani.
> changes from v5:
>         - addressed the comments by mani.
> changes from v4:
>         - rebased with linux-next.
>         - Added comments as suggested by mani.
>         - removed the arm: dts: qcom: sdx55: Add interconnect path
>           as that patch is already applied.
> changes from v3:
>         - ran make DT_CHECKER_FLAGS=-m dt_binding_check and fixed
>          errors.
>         - Added macros in the qcom ep driver patch as suggested by Dmitry
> changes from v2:
>         - changed the logic for getting speed and width as suggested
>          by bjorn.
>         - fixed compilation errors.
> 
> 
> Krishna chaitanya chundru (4):
>   PCI: qcom-ep: Add ICC bandwidth voting support
>   arm: dts: qcom: sdx65: Add PCIe EP interconnect path
>   arm: dts: qcom: sdx55: Add CPU PCIe EP interconnect path
>   dt-bindings: PCI: qcom: ep: Add interconnects path
> 
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 15 +++++
>  arch/arm/boot/dts/qcom/qcom-sdx55.dtsi             |  5 +-
>  arch/arm/boot/dts/qcom/qcom-sdx65.dtsi             |  4 ++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c          | 71 ++++++++++++++++++++++
>  4 files changed, 93 insertions(+), 2 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
