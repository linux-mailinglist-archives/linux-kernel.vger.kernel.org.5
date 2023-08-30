Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB6478DF83
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244659AbjH3TPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245167AbjH3OkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:40:09 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F026193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:40:06 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-58dfe2d5b9aso13026437b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693406405; x=1694011205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KrTsyj8vTuwb1R7EgFvIpFRrHVbkdblSWQv8HtJNkjw=;
        b=kxd4SwHtjpceRRiUJnigRk/qFMUqBDY8/1+FaKIHQA7VxZo7pmcbx59v9NkyvB/kKR
         xnHVrEtCFgszPs1aJJ57dmHzoOuf+ttR7t11K3I2o+7IAk/VvtpxfLDWYpRBHxh2IhUs
         /u85mNIcODSxzUDekOOGR+jdOqSdBfQ324mHTriGNrhfMYfr95ndV15e8hn/nIijmrst
         ZfmBfNAop0NwMKlNd3b1OkbkV3uoRLAf59QSXColZ13xa0yJXyCn8AJakKSlEzCNW/3E
         eVgjYEbb7d/irfX0ISYM2pWFUG34ZIAeY3gaEgNXFHHo1Tm7sYn9/M9umVPmSDR0uMYC
         7WMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693406405; x=1694011205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrTsyj8vTuwb1R7EgFvIpFRrHVbkdblSWQv8HtJNkjw=;
        b=dXjlPg68QfDFxKSw4VMWmWgNAQf6QN9sfLsFIL5YXHN5pf/jv9mzpYTOAA6JRovATS
         GX7qshoLkLZTNDFRyOLkfSldbmgmL7H6lFQGCC/+BUc+KjyU7i7qIOLo+Z9jTibgZIrp
         +jVePQrSLPc5llj4kCs6auAHmGXgUcrEsz7CqCw/Ku2JZchzJ9eIyFORj5rymVhOdwAv
         rTwN5An5tQ2/cs7cVypshgRLsg/ON8F7X8xZIO3Htiq7kWgbam0Ql+Mnz/Rjp7ksDXX9
         mkmufPZPINkz04yvlEYn09jyQoKrAr1/UKPOxiom4bip0Qb+RE7U3TmRs5/0R2tSq72N
         Ob+Q==
X-Gm-Message-State: AOJu0YwyEzgGj6m6kqZl2pnPoGelYOmqyxRtM/dzSrv7CwbrTn57tyXB
        9lXE2SgJcKKaZ++w+zCViGZrXKps5YGiHMhHmYuWcw==
X-Google-Smtp-Source: AGHT+IFU8XaOOrILy040/gbwnZ35P9lcr9UZxyBlmBkz/3/bJpZKMcm+nSO+vibvAwQkm40AxOjhpoXEpSE3YkPw7OI=
X-Received: by 2002:a0d:cacf:0:b0:583:7545:2f2e with SMTP id
 m198-20020a0dcacf000000b0058375452f2emr6350637ywd.7.1693406405122; Wed, 30
 Aug 2023 07:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <20230828192507.117334-6-bartosz.golaszewski@linaro.org> <9b69a4a6-b011-f0e8-217f-5f91d9a00382@linaro.org>
 <48feda07-525d-4319-ba09-14928ab1fd29@linaro.org> <CACMJSeuOigO38_jgjNLz6AiWK1BoLN+shDQHrubS5s-dkDFG7A@mail.gmail.com>
 <3f7f6427-51eb-a251-f8dd-f7922b9fcfd7@linaro.org>
In-Reply-To: <3f7f6427-51eb-a251-f8dd-f7922b9fcfd7@linaro.org>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Wed, 30 Aug 2023 16:39:54 +0200
Message-ID: <CACMJSevO7sGZ5Yj_wBrs6kV+eo7iW_aLwBj68zjbU3dS7tJ-sA@mail.gmail.com>
Subject: Re: [PATCH 05/11] dt-bindings: document the Qualcomm TEE Shared
 Memory Bridge
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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

On Wed, 30 Aug 2023 at 16:31, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/08/2023 15:48, Bartosz Golaszewski wrote:
> > On Tue, 29 Aug 2023 at 11:30, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >> On 29.08.2023 10:02, Krzysztof Kozlowski wrote:
> >>> On 28/08/2023 21:25, Bartosz Golaszewski wrote:
> >>>> Add Device Tree bindings for Qualcomm TEE Shared Memory Brige - a
> >>>> mechanism that allows sharing memory buffers between trustzone and the
> >>>> kernel.
> >>>
> >>> Subject prefix:
> >>> dt-bindings: firmware:
> >>>
> >>>
> >>>
> >>>>
> >>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>> ---
> >>>>  .../bindings/firmware/qcom,shm-bridge.yaml    | 36 +++++++++++++++++++
> >>>>  1 file changed, 36 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml b/Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..f660962b7b86
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
> >>>> @@ -0,0 +1,36 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/firmware/qcom,shm-bridge.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: QCOM Shared Memory Bridge
> >>>> +
> >>>> +description: |
> >>>
> >>> Do not need '|' unless you need to preserve formatting.
> >>>
> >>>> +  Qualcomm TEE Shared Memory Bridge allows sharing limited areas of kernel's
> >>>> +  virtual memory with the trustzone in order to avoid mapping the entire RAM.
> >>>> +
> >>>> +maintainers:
> >>>> +  - Bjorn Andersson <andersson@kernel.org>
> >>>> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>> +  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>> +
> >>>> +properties:
> >>>> +  compatible:
> >>>> +    items:
> >>>> +      - enum:
> >>>> +          - qcom,shm-bridge-sa8775p
> >>>> +          - qcom,shm-bridge-sm8150
> >>>> +          - qcom,shm-bridge-sm8450
> >>>> +      - const: qcom,shm-bridge
> >>>> +
> >>>
> >>> Looks quite empty... Why this cannot be part of qcom,scm? IOW, why do
> >>> you need new binding if you do not have any resources here and the block
> >>> is essentially feature of qcom,scm firmware?
> >> Since it's "discoverable" (via retval of an scm call), I'd second the
> >> idea of probing this from within the SCM driver.
> >>
> >> Konrad
> >
> > Downstream has a bunch of DT switches that we don't support for now
> > upstream. I disagree about shoehorning this into the SCM driver. It
> > really is a layer on top of SCM but also SCM is a user of this
> > interface.
>
> Sure, for the driver makes sense, but it does not really explain why DT
> node is needed. It is not separate hardware. I doubt it is even separate
> firmware, but part of SCM.
>
> Best regards,
> Krzysztof
>

Because not all platforms support it and it's the simplest way of
marking the ones that do. Both SHM and SCM nodes sit on the firmware
node anyway. What do you recommend? A property of the SCM node? Like
'qcom,shm-bridge` or something?

Bart
