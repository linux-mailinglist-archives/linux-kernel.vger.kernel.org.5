Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9084B77CBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbjHOLp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbjHOLpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:45:15 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA1173C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:45:14 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d650a22abd7so4883824276.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692099913; x=1692704713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Uss1xJ7T68zJOpOSvzMeDJcEGS6v01LgFXbHfvNCt4=;
        b=aDQ16dIx0q5/7i3e7tpyb0N0zy8GDO3EpKuFeU/wDyf7QsB3dGAQPev7p+hH429+kN
         htuMTHuhS7lYZ69eem0ZpAFp0Dwpk4SbfVSmC4L4AOVBZM8AFwnW9BiDdevI9bSRKtS7
         abUEyO5bRRHZWa8Z2gdGUXiw5ERi7QXIgqVUmew1LsDt+4fqsKIvBBPcKdEOqZCkDDvh
         XNkoZXnr1vvnjEmhTslPdsphwNlyUCnPlWb2WcJ1KuMWozvWJvqwZlinKzaKPoUlOCUo
         51YLkOkOzZlh0zEoFSnfo3C7GfSXrNWNsaA3dW7XUYe65vPzwrvyWqiPzb3fwlgsDYOq
         8FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692099913; x=1692704713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Uss1xJ7T68zJOpOSvzMeDJcEGS6v01LgFXbHfvNCt4=;
        b=J63UdAGVjo4Vw1NHPNtHjrv9o9NDHDmryT7q9wOrNzKf2BWVm+WBfBqCq00jwd8oWB
         38wu2M/awUitw+TlytgtLHqAFJMA2lRH1t0w8OEHXLsJ7J0z8l1A4DSj/ApGV78/R2HU
         vDEOEMgaeFcyKbP7dUmD0gSMfjJLEgeKZEp0rm55N0HZgdMCVRR4f/A0Dl2YbxVujSfZ
         /SzxikurCHl9u9l/sqfM71Nnzy7OoEV/mDuZmP0YWbNuCVQGjUyTutbgJJpZ+zG2fP3A
         8EZNJLFhR2HwXZ1CT/vCdb7mhdg0slz6Sw5HADmIY9ESqE1CHgUkJKTWXQCa4L5qCh/g
         d09A==
X-Gm-Message-State: AOJu0Yxfohst6pclBde86JK/upFU5Kgb+hdyOeylt53DmTUBICiV1t9q
        1+u9I5UPLBZkTWam0zjiGHlbuH7RqvS8IGkj0Zcdyrn6m+OYvGohfBE=
X-Google-Smtp-Source: AGHT+IE7hVv+xxjJPAe+fTihw9d0B4IaDQAkSwLsCePXvP5rKchR4KKQEE/ROaNrkhm0HsbxrwNmE8/cO2OeGJvMUC0=
X-Received: by 2002:a25:abab:0:b0:d3f:a6cd:f2d2 with SMTP id
 v40-20020a25abab000000b00d3fa6cdf2d2mr15268160ybi.50.1692099913433; Tue, 15
 Aug 2023 04:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230815110625.317971-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230815110625.317971-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Aug 2023 13:45:02 +0200
Message-ID: <CACRpkdaBee108wbXcAcz5j7Ws1pbDw5TJ7id7dupJi64YHU0mQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: lpass-lpi: fix concurrent register updates
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 1:06=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The Qualcomm LPASS LPI pin controller driver uses one lock for guarding
> Read-Modify-Write code for slew rate registers.  However the pin
> configuration and muxing registers have exactly the same RMW code but
> are not protected.
>
> Pin controller framework does not provide locking here, thus it is
> possible to trigger simultaneous change of pin configuration registers
> resulting in non-atomic changes.
>
> Protect from concurrent access by re-using the same lock used to cover
> the slew rate register.  Using the same lock instead of adding second
> one will make more sense, once we add support for newer Qualcomm SoC,
> where slew rate is configured in the same register as pin
> configuration/muxing.
>
> Fixes: 6e261d1090d6 ("pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver"=
)
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Here it would be nice if we took a sweep once this fix is in and switch
over to scoped guards, like Bartosz does:
https://lore.kernel.org/linux-gpio/20230812183635.5478-1-brgl@bgdev.pl/

Yours,
Linus Walleij
