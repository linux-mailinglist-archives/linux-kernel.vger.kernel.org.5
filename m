Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20377EAB06
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjKNHqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKNHqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:46:12 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E4A1A3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:46:09 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso5289725276.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699947968; x=1700552768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Mf/xSVIgKoT0Vi/mPJIhzX8ynp76JIll23s2BTYNB0=;
        b=SIad7yUpflxqxpf83VQxSTGPk6Hu6MHX7tRlzqDY8r5wi5TCkmHGEbcnyJzQe7gC7b
         nXWhTJqakofxpcmoIrb6Ufv3YXiR8ArW0XLlYqM8dNCLhQSe4cPA+vYzStxIKufwa69g
         WxGrhUfrxC3L+QG5wT/PIz98EzjcQPITctyvLjLoT7Sa6unQSYn0qhzD9yApsXcQpaVK
         v53JfciT7NANZI25ca/zgsKEzixER5WxKHlz7pRSfLqF/KDFOkbS4/CbK1pqhmkH5gjm
         90aPP1thv40jp0UbighGZBN7bVbNmlvcAjn+aR2tLi53uFTv2rU5Ew27FvbI8YmFASdY
         5GzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699947968; x=1700552768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Mf/xSVIgKoT0Vi/mPJIhzX8ynp76JIll23s2BTYNB0=;
        b=w6rV5mdGiMJRlp2PwL1c3/zHbqP8vkZcYMUMNZ8p2UzA31PiA2yLxFlV0MUkcxZOqx
         uDQpyVuP1RNVd0PD80BxFUC7UMwPTeVO+9jh/2VXP/EgCN5m0eB9LD3FKgLmxt8HKwM1
         H7AJL+OkU25FazSiGUEhUlQGIVv+s9/N/4XVkW91GHLRmDx3ECFn7pA7E5Swv0iXoZAJ
         wbcSvOqbWgo322pW1nwPSDI6Nu+SHtIwwitYYZsQ6lu7BlTNpmvyCONwFw3TZK5cMchM
         2oKreD7QYXUcPLsW+gIdGG7rWE1R+Kjtw3eiIniWkXHN1kFwv3hBYkp98UYy1sgFWBtu
         frog==
X-Gm-Message-State: AOJu0YxOSnDlmcFgVgXsByeTIlar+zf60vAF29hLrli3E8RwXDaAGX++
        bOlfh/+D0PPDhwt5RAyA31pEOjYDkSjbu++WgSetUg==
X-Google-Smtp-Source: AGHT+IEEljFNVD7ewl/FBBs2hBHC84IGp7EQ3DuxYiXEeUuO4jUVXspB8EmOY9HvHArQbejHw+3p2Th6A9pBuhwJJl4=
X-Received: by 2002:a25:32cf:0:b0:da3:76d3:e4fb with SMTP id
 y198-20020a2532cf000000b00da376d3e4fbmr6843475yby.26.1699947968695; Mon, 13
 Nov 2023 23:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20231013145935.220945-1-krzysztof.kozlowski@linaro.org> <20231013145935.220945-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231013145935.220945-3-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 08:45:56 +0100
Message-ID: <CACRpkdb14A5z2nhe18VupwPdDvuOXxM68nTrU-drO9nRNhWmzA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: lpass-lpi: allow slew rate bit in
 main pin config register
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 4:59=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Existing Qualcomm SoCs have the LPASS pin controller slew rate control
> in separate register, however this will change with upcoming Qualcomm
> SoCs.  The slew rate will be part of the main register for pin
> configuration, thus second device IO address space is not needed.
>
> Prepare for supporting new SoCs by adding flag customizing the driver
> behavior for slew rate.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patches applied.

Yours,
Linus Walleij
