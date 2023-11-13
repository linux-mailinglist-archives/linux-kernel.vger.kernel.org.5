Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF377E9DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjKMN6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjKMN6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:58:43 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03C5D5C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:58:40 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a8ee23f043so51123127b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699883920; x=1700488720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZgE4RyaZYwPpDpDmOy4ALqEOGv9gIKIVZc2rBCan1U=;
        b=ilmlLb13j+wiuAfTgXWQj8IzVwYmrCiZa5VYqZcOOVeGmbRkzLpx9PmeUHU28seZ7+
         kBvAdsG8On5pAqEmZb/8QB/K3g23xJemuQ2GwO2f8ExJllJcMrJFPJHZtR9ILQTP0Zwo
         v367n21Im6a5N472QdhmrYEpPRCXD6U5OB1EUiVVl18YCE76FRaYw18Z2vLfPY8lmaRu
         fxol6/RnIfx2I7gm/S4EW5bV9zElaOMkD24w5x6cv2ykBXpzz14Q43u2LXOVktZhIJM5
         pZoKFf5ogtwRnNBsVP0u4OPXSXehLFg2p8ijG6JxixUgI3jJyoXWxU4rX+8Yy2EF/Yis
         YFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699883920; x=1700488720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZgE4RyaZYwPpDpDmOy4ALqEOGv9gIKIVZc2rBCan1U=;
        b=uS0B7/sP9z8J/UzdaBNNOZuabrpPsSSytW34c5VxKQENGw7zYT2OY13kh4pdNrcMkn
         ttD/WAXOEiyBH9Co1ZkSMrRd5//qzbGrxJSJpaXvIUOdJShv0MKYgo4jpQe0/h7/WvMW
         s5bnMx6pvujtttS3IuWqKaEoSGrCkBMOeG31UCRZMHUArdlyHW7Ap8ITHkvTFWY8ukaH
         Ra8IOnxyKVWSjoo/rlkCq0oq8yMRGSQEG2yYvijcaqqo7COQ3qMZ+XgJb4VbnXhC3kAv
         Z+Jxp4CuHCt2yzIkhm7PBgP92MFV7LHld+OxP4J9KM2ECKhKm3ox4FCSWiNDJTQI0eQ/
         cMrw==
X-Gm-Message-State: AOJu0Yw8Iqut9xnaND4iq6F8x2xJiQK4mxTkqH2luqEHEG1PInosF2vO
        khSokn0cl6dAQeNFQuqw/wkUcSDABdcgB0gmeuwRcw==
X-Google-Smtp-Source: AGHT+IG5c3s+o9BrWyZQxJS5cVO8U/DkjOW+r6e+D50agoGCB9Gj+0P+5CyAq0JBqKdwRUbTr85e+HJ5+N/ikQE8cJM=
X-Received: by 2002:a81:7c45:0:b0:5ae:fd4b:f06a with SMTP id
 x66-20020a817c45000000b005aefd4bf06amr7443270ywc.30.1699883920153; Mon, 13
 Nov 2023 05:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20231027093615.140656-1-krzysztof.kozlowski@linaro.org> <20231027093615.140656-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231027093615.140656-2-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Nov 2023 14:58:29 +0100
Message-ID: <CACRpkdYtzAi-jPsPExvgXvj8i0m9QACzvd20cOLy7nrfAq=Dyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom,sm8650-lpass-lpi-pinctrl:
 add SM8650 LPASS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Oct 27, 2023 at 11:37=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Add bindings for the pin controller in Low Power Audio SubSystem (LPASS)
> of Qualcomm SM8650 SoC.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied.

Yours,
Linus Walleij
