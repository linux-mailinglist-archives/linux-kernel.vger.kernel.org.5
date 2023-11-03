Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005ED7E040A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377666AbjKCNyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377661AbjKCNyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:54:38 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE19D1A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:54:27 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7b3d33663so24958577b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699019667; x=1699624467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ATfkuRplpjvcZPadAGRPy0zHxih4OimRMmk8d3DvTRo=;
        b=HsgaQPM/urZOrCeA/GhuChYiEl3fGn7LcsZffq0MGisDzk8PG3AeaJjS9zM7IxUs/x
         7Bk1upc7zlwPhoUnQYWYHV72BnzzmwzvLpJvfZoY1NaddYzLA88HNfmiymWClF0DyuOE
         oCYXAeldo175WBO4or5jtjz1H3O69tXfJ35BdiutHWI2mXtaUXIdIdW//yiIPLi32BlN
         Ja+x+daN71ocXKNNdCFz8Fvgq3nif4vrQg0GYq35lQ2WYmFboK7jlMdgHEIysfZMmgPB
         nqzkK28fJok+bak+EfkRIZBDdBQPnCbW5FXesAnPb6OEJAXI5HgjMpULsdfCdPHTYyH8
         0BEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699019667; x=1699624467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATfkuRplpjvcZPadAGRPy0zHxih4OimRMmk8d3DvTRo=;
        b=LQ/NGSV+6Y1sHaYsEbo5uzHm68SJDzb1C00PBBbW/w081TBgPCcSyfoW9DV6idC7Ot
         jbHGIkRNSaQs5LhMgEqcBUthyKLUafLPNo0M8P0c0d7RKShgl7jnWpZLI6pCxMgNF/nx
         XpTeGzP+MHdaiyyn3yThWZWFVCrrUr1RCuhbDAaWFdcvYnqg7fcihCkqxktAvjycPULf
         3mw1B8LqjtpaU+iIY6/fgFcmMGLliVnXcCuSx+aVkKhgTcg57Z6K29g0ABP1V0j/WwFF
         r5AE+DFXiS74xdpLB93PdGvBEUHwdFT3cuOywRK6vWIV+nyg5VPrCo32+izn7K4E8/BC
         K2Ug==
X-Gm-Message-State: AOJu0YxFOJxycyTDtR/ME+/bc0oMr2DhqyRu+l8ciFNR7gxlASWSB3qW
        /ahKjolVwg5e8fIxHCFYVaMRe/YDolxTqi8t+kMC2g==
X-Google-Smtp-Source: AGHT+IGJhi2HD1dMqgiPCYjBW7UEdwmlVZwkFEeH+M3ISG/Orbn/Hk+wHiAAb3Dh0JFHj3sIr8CsxN9AfX+vzx7+LpA=
X-Received: by 2002:a05:690c:a:b0:59e:9a44:9db9 with SMTP id
 bc10-20020a05690c000a00b0059e9a449db9mr2829093ywb.26.1699019667155; Fri, 03
 Nov 2023 06:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
 <20231031120307.1600689-2-quic_mdalam@quicinc.com> <b9af01d2-1a86-4b41-9bd6-3bf7a0dde1c0@linaro.org>
 <553c1373-c9a0-b2af-2286-058824e31bad@quicinc.com> <CAA8EJpp-xsP1x==a5DH8pKpy7XH75UF-L8ewKWmeL8ePtxUq-A@mail.gmail.com>
 <4b911907-44b9-c164-9648-3d399e557672@quicinc.com>
In-Reply-To: <4b911907-44b9-c164-9648-3d399e557672@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 3 Nov 2023 15:54:15 +0200
Message-ID: <CAA8EJpqtKJYK92Zd0EEZFA0duDzWBp-JObh4Dv9uR_ezhgnWuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] mtd: nand: ecc-qcom: Add support for ECC Engine Driver
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, quic_srichara@quicinc.com,
        qpic_varada@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2023 at 15:24, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
>
>
>
> On 11/3/2023 6:03 PM, Dmitry Baryshkov wrote:
> > On Fri, 3 Nov 2023 at 14:25, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 10/31/2023 10:41 PM, Krzysztof Kozlowski wrote:
> >>> On 31/10/2023 13:03, Md Sadre Alam wrote:
> >>>
> >>> Eh? Empty?
> >>
> >> QPIC controller has the ecc pipelined so will keep the ecc support
> >> inlined in both raw nand and serial nand driver.
> >>
> >> Droping this driver since device node was NAK-ed
> >> https://www.spinics.net/lists/linux-arm-msm/msg177596.html
> >
> > It seems, we have to repeat the same thing again and again:
> >
> > It was not the device node that was NAKed. It was the patch that was
> > NAKed. Please read the emails carefully.
> >
> > And next time please perform dtbs_check, dt_binding_check and
> > checkpatch before sending the patch.
> >
> > It is perfectly fine to ask questions 'like we are getting we are
> > getting this and that issues with the bindings, please advise'. It is
> > not fine to skip that step completely.
>
> Sorry in V1 will run all basic checks.
>
> Based on below feedback [1] and NAK on the device node patch
> got idea of having separate device node for ECC is not acceptable.
> Could you please help to clarify that.
>
> Since ECC block is inlined with QPIC controller so is the below
> device node acceptable ?

No, the node below is not acceptable. And you have already got two
reasons for that. Let me repeat them for you:

- it is "okay" not "ok"
- no underscores in node names.

If you want to have a more meaningful discussion, please provide full
ECC + NAND + SPI DT bindings, only then we can discuss them.

>     bch: qpic_ecc {
>                            compatible = "qcom,ipq9574-ecc";
>                            status = "ok";
>                    };
>
>   [1] https://www.spinics.net/lists/linux-arm-msm/msg177525.html
>
> >
> >>>
> >>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> >>>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> >>>> ---
> >>>>    drivers/mtd/nand/Kconfig    |   7 ++
> >>>>    drivers/mtd/nand/Makefile   |   1 +
> >>>>    drivers/mtd/nand/ecc-qcom.c | 198 ++++++++++++++++++++++++++++++++++++
> >>>>    3 files changed, 206 insertions(+)
> >>>>    create mode 100644 drivers/mtd/nand/ecc-qcom.c
> >>>>
> >>>
> >>> ...
> >>>
> >>>> +
> >>>> +    return 0;
> >>>> +}
> >>>> +EXPORT_SYMBOL(qcom_ecc_config);
> >>>> +
> >>>> +void qcom_ecc_enable(struct qcom_ecc *ecc)
> >>>> +{
> >>>> +    ecc->use_ecc = true;
> >>>> +}
> >>>> +EXPORT_SYMBOL(qcom_ecc_enable);
> >>>
> >>> Drop this and all other exports. Nothing here explains the need for them.
> >>>
> >>>> +
> >>>> +void qcom_ecc_disable(struct qcom_ecc *ecc)
> >>>> +{
> >>>> +    ecc->use_ecc = false;
> >>>> +}
> >>>> +EXPORT_SYMBOL(qcom_ecc_disable);
> >>>> +
> >>>> +static const struct of_device_id qpic_ecc_dt_match[] = {
> >>>> +    {
> >>>> +            .compatible = "qcom,ipq9574-ecc",
> >>>
> >>> Please run scripts/checkpatch.pl and fix reported warnings. Some
> >>> warnings can be ignored, but the code here looks like it needs a fix.
> >>> Feel free to get in touch if the warning is not clear.
> >>>
> >>> Checkpatch is preerquisite. Don't send patches which have obvious issues
> >>> pointed out by checkpatch. It's a waste of reviewers time.
> >>>
> >>>> +    },
> >>>> +    {},
> >>>> +};
> >>>> +
> >>>> +static int qpic_ecc_probe(struct platform_device *pdev)
> >>>> +{
> >>>> +    struct device *dev = &pdev->dev;
> >>>> +    struct qpic_ecc *ecc;
> >>>> +    u32 max_eccdata_size;
> >>>> +
> >>>> +    ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
> >>>> +    if (!ecc)
> >>>> +            return -ENOMEM;
> >>>> +
> >>>> +    ecc->caps = of_device_get_match_data(dev);
> >>>> +
> >>>> +    ecc->dev = dev;
> >>>> +    platform_set_drvdata(pdev, ecc);
> >>>> +    dev_info(dev, "probed\n");
> >>>
> >>> No, no such messages.
> >>>
> >>>
> >>>
> >>> Best regards,
> >>> Krzysztof
> >>>
> >
> >
> >



-- 
With best wishes
Dmitry
