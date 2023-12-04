Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF3C802F8F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343714AbjLDKHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjLDKHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:07:32 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8735CFF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:07:38 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5d3758fdd2eso38156927b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 02:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684458; x=1702289258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOjFu2drG+hMnp/Q97syICFEIr+VaeLOs/zLd33yc5o=;
        b=rFJxYK4S7F7dZ3XC7itCQIM3bvSy14WUCyRzBq9RNkO+WjnhPqv8Jal72I/c/BbBRW
         yrtNAjsw0/Y94GQHtTNq/QzFE0XESHXl8rJp9mYta5Mp3nCPHuH1cs7vkf39vFEKeM9F
         msKv4P4OqhkkjTIyUG6zL73k/iiZydzn4iOYgTy2186Ro6cFQXjGqUrGFPPJwFASwAeZ
         r1wUJb1lWCYxmmYqcUVgbd8HagsKXNCgY16QL300ZnfaDzPWFhFQ0wOhrJj7r/IW5J1o
         52rFLzU99NVjYaLbht/8TOn4K935hTEzAGpDW27AU6Jf3z4jt4KQpMyn4zL5/5cEmGGj
         HOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684458; x=1702289258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOjFu2drG+hMnp/Q97syICFEIr+VaeLOs/zLd33yc5o=;
        b=Cz3iZFg2u8KdE3WFckXdnsnib1ZCG2cSWbftI0nfiH381LPf+zGMqMXWk0QnFi+SdI
         WBpn7TdfegUOJLxkZddraUtSl5bF3ewX9lrSuzL7b4Aenw3PLZEM7uZbH87miwRXyY4o
         +D8iSTEJg2EISj4JLUggfALYRoHw5p/3e5wLoWyuGxuNasEQ7jA03a3XY7nmuQ41H4xh
         EL3zAA0ASpZqih0LeGmBji+ZmS3tpL1qxv4mQe5gLCk/nkmyqxzVDQ/dR/GeWLDJ/eny
         rkZdphGw7C6XcP5l2U+Qw+ygIPIw4wF1SoSkQmBrfi87Y/Gh3or26LvbOQlqUAhfOMwy
         tD5Q==
X-Gm-Message-State: AOJu0YzZYmT6l0fQwlRg+nOuRo4vsvpZsMHAMO827AB0iGsUbGSAJKXM
        zqGsdLW/bsgos9f3K/WS6ihdEAT8TEPkDLK1mUBzRQ==
X-Google-Smtp-Source: AGHT+IEoge3/myhs2BcCDEJp4E9gpYLs+VQjOagFp3dj4nwSFFRmEaUr9A1PcGSVVDhiBSqVcGb1yW5jwtTHpbrMvxw=
X-Received: by 2002:a0d:e881:0:b0:5d9:1524:e315 with SMTP id
 r123-20020a0de881000000b005d91524e315mr320677ywe.17.1701684457823; Mon, 04
 Dec 2023 02:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20231129155738.167030-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231129155738.167030-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Dec 2023 11:07:26 +0100
Message-ID: <CACRpkdbXLpdthrSvAFn_5EUBN4==_mbQd_QpKtQr0O=wxV+gYQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sm8550-lpass-lpi: add X1E80100
 LPASS LPI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
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

On Wed, Nov 29, 2023 at 4:57=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Document the Qualcomm X1E80100 SoC Low Power Audio SubSystem Low Power
> Island (LPASS LPI) pin controller, compatible with earlier SM8550 model.
>
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied!

Yours,
Linus Walleij
