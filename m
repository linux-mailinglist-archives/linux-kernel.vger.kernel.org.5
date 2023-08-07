Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3C1771CA4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjHGIyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjHGIyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:54:02 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B1A10FD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:54:01 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d0b597e7ac1so4881212276.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 01:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691398440; x=1692003240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeF5Rq6ezVVBpQULtHVMCwxuhR7zC8qg0BvYuicBYII=;
        b=u14yqO7GtyZkl2aLiTuZX9kAyeFzKq703yLHusK3SvNEn3XmYb7NDt+7TgtMsEdjsz
         IslQv34ZnzVbNNqFhoAbWTW87nVX1LsB5gJE4nRvg32ulBZ6+mdBrMz1AjW2v326pFA+
         WrhZilbLj6tt7vAwX2VVjbBzeYBF+O66g65fKqgizd1DmEZLm5dt03aORtXMOxZ1wEvY
         iHYeezAmf6tPeU5qDDj3BLksp7oWqiBgfOKMxDEn1ctEqDfNBerIYC2TqMUUjGh3Gm1Y
         cL9JcLIZJ7D5Ozje6VjmnK9gSUTM1SHJv/fnmepolCDOJK9ufF+EqDxX6ZuetPxHrEE9
         Pzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691398440; x=1692003240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeF5Rq6ezVVBpQULtHVMCwxuhR7zC8qg0BvYuicBYII=;
        b=J3G14YVdlIfkMPtSq6cvQDVjoEoTaaGt3CAzZ3uxs8AlLRVzvENtbNmQpNpPqlgMxc
         NVqGM++4afGrZwMJUpMfdyxY+A3W/GyWQ/f+as355Xreh+Fyp/3IwACQ6Tpc8kBbiwnM
         P6M1iafCwEKlL64FwtkC72aCjtTY3mskfPMjZp8gMY6HGOtYRKdtqGNstd5CUj1r5EYK
         HBtQdo+YP47msddK03Y39ECDDjeliTTte2X80eNVet8+38dzK/e/iB3ZZRULrBj60/a1
         4ifXhYoylEmy/V20Z17LkbErpCjUt7DG3IRJ/yI5/rBpRQ47cVf9TebnzjGYjNA+9/Oc
         IrIA==
X-Gm-Message-State: AOJu0YzSwkw3sKB+df08Lw03LPkboIjOmAcN5pZ5zLlBxZCLU4MHjWsS
        Badr1IPS3othHnBfmHtwVIMua/arb5P034tl5wAoyg==
X-Google-Smtp-Source: AGHT+IFHv86Jsl6/7WkZ07IOOIjjHtRvTVAuY5BH8iBoYJcYDq/HAi6+yMz2REL09FmYDxt3gPGBTsuRHCXbiFfpSBw=
X-Received: by 2002:a25:bf8c:0:b0:d35:c50c:8ed7 with SMTP id
 l12-20020a25bf8c000000b00d35c50c8ed7mr8145421ybk.24.1691398440283; Mon, 07
 Aug 2023 01:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230722-topic-6115_lpasstlmm-v2-0-d4883831a858@linaro.org> <20230722-topic-6115_lpasstlmm-v2-3-d4883831a858@linaro.org>
In-Reply-To: <20230722-topic-6115_lpasstlmm-v2-3-d4883831a858@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Aug 2023 10:53:49 +0200
Message-ID: <CACRpkdY6K9_PcQa-w4EiVfJVPq8aivuHQPMwrRbH=PmpT0Ordg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: defconfig: enable Qualcomm SM6115 LPASS pinctrl
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 1:40=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:

> Enable the Qualcomm SM6115 LPASS TLMM pin controller driver for
> providing GPIOs/pins for audio block on SM6115 based boards (e.g.
> QTI RB2).
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
