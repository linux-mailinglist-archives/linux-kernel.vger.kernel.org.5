Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6067978CCA2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbjH2TEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239091AbjH2TD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:03:58 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD05CE4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:03:54 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d743a5fe05aso4475102276.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693335833; x=1693940633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pUpheKq+1JSQMZjnZF4kInD8StAyFEmUTtjvjFiSFy4=;
        b=rper8cZkIV5pYarlVzm9r6QWzY3T2UdfruxO8NQxVfN+/Ay9dB65coOnS5aYxavazX
         8LYAN3YQr66dT2A4sCk0FpiHDZ/Uaqge12lkLQOe4jYOM574Lay3kFOJ9DEu6tzC0GbM
         CSfAuZRNQkOuskGSafmL2BHAIl8RtH8SbkLFfAS1e6ug/Pds1eocGtFowImTiSGsfilM
         f2C74eVqNusyBkiuHvew7/zLuyBlZFYTiiUiYJzqAMtCECobbHtLmOqHYGg8zKtaddEl
         3BsJDteKyWkAZoA2VrK00h0HsfklcQk+6XDuiIir0b7//WMlfzBeQyQYBAMnjFwV2Fn7
         bZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693335833; x=1693940633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUpheKq+1JSQMZjnZF4kInD8StAyFEmUTtjvjFiSFy4=;
        b=jmKLqdo/5HnFrdaJGOTdmH4oHZFI7ak4l4kpYWm/bwQzQOpUUqpOXILf3Q6o0s3Zv9
         lh+dJG5xUwLidKJl0aVmNc5pHic0ah2fwGm57iEG1ny1fG43cq/7yzA2ACDaNFMXMU0f
         hf9jP4xKwcAoCWNg/jN7nhIUywCJa411Tgll+seEvrdgNgJkKHOBqIBSMhnaweollfOf
         L+UFiVjrOvBrPDa6K70Np4StM8V975dVIlf99ocYNzONnw3sSztxCj4fakPJZ3ehqlZl
         BJimEe+L6UurZDe3xRmXHCEbpoxGNnhXKUG4fTWbLM3BuA4ZP/tuMbm/U6M2nLFAd+6i
         9DCA==
X-Gm-Message-State: AOJu0YwB/CYhKHtUBd3enws77jwmhErlb5spQ9j7HPBwPFytpZdoaSvi
        PgLX/nKMVJgNI/kkjAdz73K4u8qF6cwSfGyqb/Yw1g==
X-Google-Smtp-Source: AGHT+IFNtj7fwawiWbux5Dq90/Rn4syHRy4EBua4A31ueNEAReWJhLBQL+bHOuTOrPBbl1KEogyErWrZdfGLWV9R2U4=
X-Received: by 2002:a25:a247:0:b0:d12:25d:fd60 with SMTP id
 b65-20020a25a247000000b00d12025dfd60mr29062ybi.9.1693335833197; Tue, 29 Aug
 2023 12:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org> <CAA8EJpp_Uu62TDknZ-X0DQYinnwxxoriPpetfppCySxg_25YQg@mail.gmail.com>
In-Reply-To: <CAA8EJpp_Uu62TDknZ-X0DQYinnwxxoriPpetfppCySxg_25YQg@mail.gmail.com>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue, 29 Aug 2023 21:03:42 +0200
Message-ID: <CACMJSet-1tbTnMOab2GvMEc-b6Y3Xq5AZEE4mrfiUOZ=65z3MQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] arm64: qcom: add and enable SHM Bridge support
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 23:24, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, 28 Aug 2023 at 22:29, Bartosz Golaszewski
> <bartosz.golaszewski@linaro.org> wrote:
> >
> > SHM Bridge is a mechanism allowing to map limited areas of kernel's
> > virtual memory to physical addresses and share those with the
> > trustzone in order to not expose the entire RAM for SMC calls.
> >
> > This series adds support for Qualcomm SHM Bridge in form of a platform
> > driver and library functions available to users. It enables SHM Bridge
> > support for three platforms and contains a bunch of cleanups for
> > qcom-scm.
>
> Which users do you expect for this API?
>

This series adds a single user: the SCM driver. We have another user
almost ready for upstream in the form of the scminvoke driver and I
learned today, I can already convert another user upstream right now
that I will try to get ready for v2.

> Also, could you please describe your design a bit more? Why have you
> implemented the shm-bridge as a separate driver rather than a part of
> the SCM driver?
>

It's self-contained enough to be put into a separate module and not
all platforms support it so in order to avoid unnecessary ifdeffery in
the scm driver, I made it separate.

Bart

> >
> > Bartosz Golaszewski (11):
> >   firmware: qcom-scm: drop unneeded 'extern' specifiers
> >   firmware: qcom-scm: order includes alphabetically
> >   firmware: qcom-scm: atomically assign and read the global __scm
> >     pointer
> >   firmware: qcom-scm: add support for SHM bridge operations
> >   dt-bindings: document the Qualcomm TEE Shared Memory Bridge
> >   firmware: qcom-shm-bridge: new driver
> >   firmware: qcom-scm: use SHM bridge if available
> >   arm64: defconfig: enable Qualcomm SHM bridge module
> >   arm64: dts: qcom: sm8450: enable SHM bridge
> >   arm64: dts: qcom: sa8775p: enable SHM bridge
> >   arm64: dts: qcom: sm8150: enable SHM bridge
> >
> >  .../bindings/firmware/qcom,shm-bridge.yaml    |  36 ++
> >  arch/arm64/boot/dts/qcom/sa8775p.dtsi         |   4 +
> >  arch/arm64/boot/dts/qcom/sm8150.dtsi          |   4 +
> >  arch/arm64/boot/dts/qcom/sm8450.dtsi          |   4 +
> >  arch/arm64/configs/defconfig                  |   1 +
> >  drivers/firmware/Kconfig                      |   8 +
> >  drivers/firmware/Makefile                     |   1 +
> >  drivers/firmware/qcom-shm-bridge.c            | 452 ++++++++++++++++++
> >  drivers/firmware/qcom_scm-smc.c               |  20 +-
> >  drivers/firmware/qcom_scm.c                   | 106 +++-
> >  drivers/firmware/qcom_scm.h                   |   3 +
> >  include/linux/firmware/qcom/qcom_scm.h        | 109 +++--
> >  include/linux/firmware/qcom/shm-bridge.h      |  32 ++
> >  13 files changed, 712 insertions(+), 68 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
> >  create mode 100644 drivers/firmware/qcom-shm-bridge.c
> >  create mode 100644 include/linux/firmware/qcom/shm-bridge.h
> >
> > --
> > 2.39.2
> >
>
>
> --
> With best wishes
> Dmitry
